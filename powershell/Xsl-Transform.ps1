Function Xsl-Transform {
<#
	.SYNOPSIS
	
	Given a list of files, generate an HTML page of these files.

	.DESCRIPTION

	.EXAMPLE

	Xsl-Transform -xml C:\git\shell-scripts\powershell\XML\breakfast.xml -xsl C:\git\shell-scripts\powershell\XML\breakfast.xslt -output C:\git\shell-scripts\powershell\XML\rendered.html
#>
	param (
		[Parameter(mandatory=$true)]$xml, 
		[Parameter(mandatory=$true)]$xsl,
		[Parameter(mandatory=$true)]$output
	)

	if (-not $xml -or -not $xsl -or -not $output)
	{
		Write-Host "& Xsl-Transform [-xml] xml-input [-xsl] xsl-input [-output] transform-output"
		exit;
	}

	trap [Exception]
	{
		Write-Host $_.Exception;
	}

	$xslt = New-Object System.Xml.Xsl.XslCompiledTransform;
	$xslt.Load($xsl);
	$xslt.Transform($xml, $output);

	Write-Host "generated" $output;
}