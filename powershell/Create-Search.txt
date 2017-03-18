Function Create-Search {
<#
	.SYNOPSIS
	
	Given a list of files, generate an HTML page of these files.

	.DESCRIPTION

	.EXAMPLE

	Create-Search -path .\PRODUCTS\ -term "Fox"

	Create-Search -path .\PRODUCTS\ -term "Rob"
	
	Generate a HTML list of files that match some criteria.
#>
	Param (
			[Parameter(mandatory=$true)]$path,
			[Parameter(mandatory=$true)]$term,
			[switch]$details = $False
		)

	$results = (Get-Search-Results -path $path -regex $term)
	if ($details) {
		$results | Format-list -Property * -Force
	}
	Create-Page -outputFile .\search_$term.html -fileList $results -override -details
	echo "Completed."
}
