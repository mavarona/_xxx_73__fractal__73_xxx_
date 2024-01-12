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

# Sho menu help
function help()
{
   # Display Help
   echo -e "\n${greenColour}Menu${endColour}"
   echo -e "\n${greenColour}options: ${endColour}"
   echo -e "\n${greenColour}-h     Print this Help. ${endColour}"
   echo -e "\n${greenColour}-f     Folder to upload. ${endColour}"
   echo
   exit
}

# Read all files in a directory
function read_dir_content_recursive() {
    local current_dir="$1"

    for elem in "$current_dir"/*; do
        # If is a file
        echo $elem
        if [ -f "$elem" ]; then
            # echo -e "\n${purpleColour}File: $elem${endColour}"
            echo "..."
        # If is a directory
        elif [ -d "$elem" ]; then
            read_dir_content_recursive "$elem"
        fi
    done
}

# Main function
while getopts ":hf:" option; do
   case $option in
      h) help;;
      f) init_dir=$2; 
        if [ ! -d "$init_dir" ]; then
            echo "The directory '$init_dir' not exists."
            exit 1
        fi;read_dir_content_recursive "$init_dir";;
     \?) help;;
   esac
done