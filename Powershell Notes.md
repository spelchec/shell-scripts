# Code Signing

If you copy over these code snippets, you cannot directly run these files like you would a batch script. Powershell scripts require additional security. You can run these scripts in a few ways:

1. Allowing all scripts through setting the Execution Policy to "Unrestricted". I won't be going through this way of running scripts, because it weakens your computer's security significantly.

1. Copy the script contents into a PowerShell window. As these commands are all functions, they will be available to call for the lifespan of the PowerShell window.

1. Allowing scripts to run by setting the Execution Policy to "AllSigned". This will allow for running scripts that have a code-signed block appended at the bottom of the PowerShell file.

# Microsoft Management Console (MMC)

````powershell
# Make a local certificate authority (run as admin):
makecert -n "CN=PowerShell Local Certificate Root" -a sha1 -eku 1.3.6.1.5.5.7.3.3 -r -sv root.pvk root.cer -ss Root -sr localMachine

# Make the code signing user:
makecert -pe -n "CN=PowerShell User" -ss MY -a sha1 -eku 1.3.6.1.5.5.7.3.3 -iv root.pvk -ic root.cer

# verify the code signing:
Get-ChildItem cert:\CurrentUser\My -codesign
````

# Sign the script

The following lines sign the script `C:\foo.ps1`:
````powershell
    Get-ExecutionPolicy
    Set-ExecutionPolicy AllSigned
    Set-AuthenticodeSignature c:\foo.ps1 @(Get-ChildItem cert:\CurrentUser\My -codesign)[0]
````
# Transportation

You can export the certificates through the MMC.

### References:

* A majority of this information was derived from [Signing PowerShell Scripts](https://www.hanselman.com/blog/SigningPowerShellScripts.aspx). Read it for details, as it's a great resource.
