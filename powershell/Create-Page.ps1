Function Create-Page {
<#
	.SYNOPSIS
	
	Given a list of files, generate an HTML page of these files.

	.DESCRIPTION

	.EXAMPLE

	Create-Page -outputFile .\index.html -fileList .\PRODUCTS\ -override

	Create-Page -outputFile .\index.html -fileList .\PRODUCTS\ -override -details

	$results = (Get-Search-Results -path .\PRODUCTS -regex fox)
	Create-Page -outputFile .\index.html -fileList $results -override

	Generate a HTML list of files that match some criteria.
#>
	Param (
			[Parameter(mandatory=$true)]$outputFile, 
			[Parameter(mandatory=$true)]$fileList,
			[string]$rootPath,
			[switch]$override = $False,
			[switch]$details = $False
		)
	
	$fileExists = (Test-Path $outputFile)
	if ($details) {
		echo "Output File: $outputFile"
		echo "File Exists: $fileExists"
		echo "File List: $fileList"
		
		Write-Host "File List Type:",$fileList.GetType().Name
		# 	Create-Page -outputFile .\index.html -fileList .\PRODUCTS\ -override -details
		
		echo "Override: $override"
	}
	if ($fileExists -and !$override) {
		echo "File exists and will not be replaced."
	} elseif (!$fileExists -or $override) {
		if ($fileExists) {
			Clear-Content $outputFile
		}
		Add-Content $outputFile "<body>"
		if ($fileList.GetType().Name -eq "String") {
			$fileLocation = (Get-Item $fileList)
			Write-Host "Reading files from the location $fileLocation"
			$fileList = (Get-ChildItem $fileLocation -Recurse) | Where-Object { !$_.PSIsContainer }
		}
		$fileList | sort -property LastWriteTime -Descending | ForEach-Object {
			$file = $_.FullName
			$name = $_.Name
			$LastWriteTime = $_.LastWriteTime
			Write-Host "Writing $file as $name"
			Add-Content $outputFile "<a href=$file>$name</a> (last updated $LastWriteTime)<br />"
		}
		Add-Content $outputFile "</body>"
	}
	return $outputFile
}
