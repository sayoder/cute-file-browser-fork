<?php

$dir = "Obituaries";

// Run the recursive function 

$response = scan($dir);


// This function scans the files folder recursively, and builds a large array

function scan($dir){

	$files = array();

	// Is there actually such a folder/file?

	if(file_exists($dir)){
	
		foreach(scandir($dir) as $f) {
		
			if(!$f || $f[0] == '.') {
				continue; // Ignore hidden files
			}

            $fullpath = $dir . '/' . $f;

			if(is_dir($dir . '/' . $f)) {

				// The path is a folder

				$files[] = array(
					"name" => $f,
					"type" => "folder",
					"path" => $fullpath,
                    "description" => get_description($fullpath),
					"items" => scan($dir . '/' . $f) // Recursively get the contents of the folder
				);
			}
			
			else {

				// It is a file

				$files[] = array(
					"name" => $f,
					"type" => "file",
					"path" => $fullpath,
                    "description" => "",
					"size" => filesize($dir . '/' . $f) // Gets the size of this file
				);
			}
		}
	
	}

	return $files;
}


function get_description($path){
   $file = $path . "/.description.html";

   if (file_exists($file)) {
       return file_get_contents($file);
   } else {
       return "";
   }
}

// Output the directory listing as JSON

header('Content-type: application/json');

echo json_encode(array(
	"name" => "Obituaries",
	"type" => "folder",
	"path" => $dir,
    "description" => get_description("Obituaries"),
	"items" => $response
));
