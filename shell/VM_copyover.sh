#!/bin/bash
# Notes about VirtualBox setup:
#
# Guest Additions are needed to allow mounting other drives.
#   Under the VM > Settings > Shared Folders...
#   Added a Transient Folder (I named it "shell") with path ${PROJ_HOME}\shell. (Read Only, Automount)
#
# on the console:
#   mkdir /mnt/shell
#   mount -F vboxfs shell /mnt/shell

function allow_running {
	file=$1
	cp "/mnt/shell/$file"
	dos2unix "$file" "$file"
	chown root:root "$file"
	chmod 777 "$file"
	echo "allowing $file"
}

allow_running Get-Search-Results.sh
allow_running Sort-Files.sh

# ./Get-Search-Results.sh PRODUCTS fox
./Sort-Files.sh PRODUCTS fox
