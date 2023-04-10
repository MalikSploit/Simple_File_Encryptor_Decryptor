#!/bin/bash

# Function to handle encryption
function Encryption()
{
    if gpg -c "$FILENAME1"; then
        rm -r "$FILENAME1"
        zenity --info --text="The file has been encrypted and saved as $FILENAME1.gpg"
    else
        zenity --error --text="Encryption failed"
    fi
}

# Function to handle decryption
function Decryption()
{
    if gpg -d "$FILENAME2" > "${FILENAME2%.*}"; then
        rm "$FILENAME2"
        zenity --info --text="The file has been decrypted and saved as ${FILENAME2%.*}"
    else
        zenity --error --text="The decryption failed"
    fi
}

while true; 
do
    # Create a GUI for the program
    CHOICE=$(zenity --list --title="File Encryption/Decryption" --text="Choose an option:" --radiolist \
            --column "Select" --column "Option" \
            --width=350 --height=250 \
            TRUE "Encrypt" \
            FALSE "Decrypt" \
            FALSE "List Files" \
            FALSE "Exit" \
            --timeout=60) #Timeout of 60 seconds in case the user dosn't respond

    # Check if the user closed the dialog box
    if [ $? -eq 1 ]; 
    then 
        echo "Program closes by user"
        exit 0
    fi

    # process the user's choice
    case "$CHOICE" in
        "Encrypt")
            # Get the name of the file to encrypt
            FILENAME1=$(zenity --file-selection --title="Select a file to encrypt")
            if [ -n "$FILENAME1" ]; then
                Encryption
            else
                zenity --error --text="No file selected"
            fi
            ;;
        "Decrypt")
            # Get the name of the file to decrypt
            FILENAME2=$(zenity --file-selection --title="Select a file to decrypt")
            if [ -n "$FILENAME2" ]; then
                Decryption
            else
                zenity --error --text="No file selected"
            fi
            ;;
        "List Files")
            # List all files in the current directory
            zenity --text-info --filename="/dev/stdin" --width=800 --height=600 <<< "$(ls -al)"
            ;;
        "Exit")
            exit 0
            ;;
        *)
            zenity --error --text="Invalid option"
            ;;
    esac
done
