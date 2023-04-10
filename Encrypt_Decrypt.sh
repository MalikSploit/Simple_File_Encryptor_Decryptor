#!/bin/bash

function Encryption()
{
	if gpg -c $FILENAME1; 
	then
		rm -r $FILENAME1
		echo "The file has been encrypted and saves as $FILENAME1.gpg"
	else
		echo "Encryption failed"
	fi
}

function Decryption()
{
	if gpg -d $FILENAME2 > "${FILENAME2%.*}"; 
	then
		rm "$FILENAME2"
		echo "The file has been decrypted and saves as ${FILENAME2%.*}"
	else
		echo "The decryption failed"
	fi
}

echo "This is a simple file encrypter/decrypter"
echo "Please choose what you want to do"

choice="Encrypt Decrypt Exit List_Files"

select option in $choice; do
	if [ $REPLY = 1 ];
	then
		echo "You have selected Encryption"
		echo "Please enter the file name"
		read FILENAME1
		if [ -e "$FILENAME1" ]; 
		then
			Encryption
		else
			echo "File not found"
			echo "Searching for file..."
			if FILEPATH1=$(locate "$FILENAME1"); then
				echo "File found at: $FILEPATH1"
				FILENAME1=$FILEPATH1
				Encryption
			else
				echo "File not found"
			fi
		fi
	elif [ "$REPLY" = 2 ];
	then
		echo "You have selected Decryption"
		echo "Please enter the file name"
		read FILENAME2
		if [ -e $FILENAME2 ]; 
		then
			Decryption
		else
			echo "File not found"
			echo "Searching for file..."
			if FILEPATH2=$(locate "$FILENAME2"); 
			then
				echo "File found at: $FILEPATH2"
				FILENAME2=$FILEPATH2
				Decryption
			else
				echo "File not found"
			fi
		fi
	elif [ "$REPLY" = 3 ]; 
	then
		echo "Exiting the program"
		exit 0
	elif [ "$REPLY" = 4 ]; 
	then
		echo "Listing all files in the current directory"
		ls
	else 
		echo "Invalid option, please choose again"
	fi
done
