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

data=()

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
   exit
}

# Build curl upload file
function build_upload_file() {
    path_upload_str="curl -F 'file=@$1' https://temp.sh/upload"
    path_upload=$(eval "$path_upload_str")
    #data+=( "$1@@$path_upload" )
    if [[ $1 =~ $init_dir(.*) ]]; then
        path_build="${BASH_REMATCH[1]}"
    fi
    data+=( "$path_build@@$path_upload" )
}

# Read all files in a directory
function read_dir_content_recursive() {
    local current_dir="$1"

    for elem in "$current_dir"/*; do
        # If is a file
        if [[ "$elem" == *"."* ]]; then
            #echo -e "\n${blueColour}$elem${endColour}"
            #echo -e "\n$elem"
            build_upload_file $elem
            test=$(basename $init_dir)
        fi

        # If is a directory
        if [ -d "$elem" ]; then
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
        fi;
        read_dir_content_recursive "$init_dir";
        for str in ${data[@]}; do
            echo $str
        done;;
     \?) help;;
   esac
done