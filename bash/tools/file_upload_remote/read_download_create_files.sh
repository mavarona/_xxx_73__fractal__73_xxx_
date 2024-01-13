#! /bin/bash

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

trap ctrl_c INT

function ctrl_c(){
	echo -e "\n${yellowColour}[*]${endColour}${grayColour}Saliendo${endColour}"
	exit 0
}

# Show menu help
function help()
{
   # Display Help
   echo -e "\n${greenColour}Menu${endColour}"
   echo -e "\n${greenColour}options: ${endColour}"
   echo -e "\n${greenColour}-h     Print this Help. ${endColour}"
   echo -e "\n${greenColour}-f     file to read to create tree folder and files. ${endColour}"
   exit
}

function get_path_create_and_link_download() {

    IFS='@' #setting space as delimiter  
    read -ra items <<<"$line" #reading str as an array as tokens separated by IFS  
    create_folder_file

}

function create_folder_file() {

    IFS='/' #setting space as delimiter  
    read -ra allPath <<<"${items[0]}"
    lengthArr=${#allPath[@]}
    if [ $lengthArr -eq 2 ]; then
        echo "Is file"
    else
        for ((i = 1; i < $lengthArr; i++)); do
            echo "Element at index $i: ${lengthArr[i]}"
        done
    fi
    echo ${items[1]}
}

function read_file(){
    # Check if the file exists
    if [ -f "$file" ]; then
        # Open the file and read it line by line
        while IFS= read -r line; do
            # Process each line as needed
            echo "Processing line: $line"
            get_path_create_and_link_download $line
        done < "$file"
    fi
}

#Main function
while getopts ":hfo:" option; do
   case $option in
      h) help;;
      f) file=$2; 
        if [ ! -f "$file" ]; then
            echo "The file '$file' not exists."
            exit 1
        fi;
        echo "The file $file";
        read_file;;
     \?) help;;
   esac
done
