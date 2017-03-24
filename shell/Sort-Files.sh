#!/bin/bash
#
# The following is a way of creating a list of files through the Bash shell,
# based on a path location ($1) and search term ($2).
#
# Example:
#   ./Sort-Files.sh PRODUCTS fox
#
# Output is saved in listing3.txt.

# Get the search terms
path=$1
term=$2

# flush out the text files 
>listing_$term.txt
>listing2_$term.txt
>search_$term.txt

# Get the list of all files and subdirectories in date order.
find $1 -type f -exec ls -lt {} + | awk '{ print $6, $7, $8, $9 }' >> listing_$term.txt

# Strip the file paths out of the previous result set.
cat listing_$term.txt | sed 's/^[A-Za-z0-9 \:]*//' >> listing2_$term.txt

# Go through the paths of the previous result set and get the matching text, 
#  date and path information.

while read p; do
	if grep $term $1/$p; then
		echo "<item>" >> search_$term.txt
			grep $term $1/$p >> search_$term.txt
			ls -ltr "$1/$p" | awk '{ print $6, $7, $8, $9 }' >> search_$term.txt
		echo "</item>" >> search_$term.txt
	fi
done < listing2_$term.txt

# cleanup
rm listing_$term.txt listing2_$term.txt

# print out the results.
echo "--------------------";
cat search_$term.txt

# This code was tested on VirtualBox instance of Solaris 10.
# SunOS solaris 5.10 Generic_147148-26 i86pc i386 i86pc