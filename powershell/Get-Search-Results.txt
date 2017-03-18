Function Get-Search-Results {
<#
	.SYNOPSIS
	
		Generates a list of files that match a given string in their contents.

	.DESCRIPTION
	
		Later versions of powershell (after version 2) have Select-String, but we're specifically 
		targetting this powershell version. Use "$PSVersionTable.PSVersion" to see your available version.
		To force an earlier version of powershell, use the line "powershell -version 2".

		This uses regex components as available with lines like:
		'abc123def456' -match '[a-z]+(\d+)' | Out-Null; $Matches[0,1]		
		
	.EXAMPLE

	Get-Search-Results -path .\PRODUCTS -regex fox
	Get-Search-Results -path .\PRODUCTS -regex rob

	Get-Search-Results -path .\PRODUCTS -regex tom -details
	Get-Search-Results -path .\PRODUCTS -regex rob -details

	Get-Search-Results -path .\PRODUCTS -regex tom | Format-list -Property * -Force
	
#>
	Param (
	        [Parameter(mandatory=$true)]$path, 
	        [Parameter(mandatory=$true)]$regex,
			[switch]$details=$False
	    )

	$myArrayResults = @()
	
	if ($details) {
		Write-Host "Working off directory",$path
	}
	
	Get-ChildItem $path -Recurse  | Where-Object { !$_.PSIsContainer } | ForEach-Object {
		# The Where-Object PSIsContainer filters to files only (no directories)
		# http://stackoverflow.com/questions/37481335/return-only-files-with-get-childitem-in-powershell-2

		$file = $_
		$fileName = $file.FullName
		if ($details) {
			echo "Examining $fileName"
		}
		if ((Get-Content $fileName) -match $regex) {
			$myArrayResults += $file
		}
	}
	return $myArrayResults
}
