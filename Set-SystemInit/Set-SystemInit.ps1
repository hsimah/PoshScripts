$Path = Split-Path $MyInvocation.MyCommand.Path -Parent

# PowerShell cmdlet repository location
. $Path\New-UserEnvironmentalVariable.ps1 -Key "PSLocalModulePath" -Value "%USERPROFILE%\OneDrive\Development\Scripts\PowerShell"