$Path = Split-Path $MyInvocation.MyCommand.Path -Parent

# Init PowerShell profile
$ProfilePath = "$env:USERPROFILE\Documents\WindowsPowerShell"

if (!(Test-Path $ProfilePath)) {
    # Create profile directory
    New-Item -Path $ProfilePath -ItemType directory -Force 
    
    # hard link profile for powershell and powershell ise
    cmd /c mklink /H "$ProfilePath\Microsoft.PowerShell_profile.ps1" "$Path\Microsoft.PowerShell_profile.ps1"
    cmd /c mklink /H "$ProfilePath\Microsoft.PowerShellISE_profile.ps1" "$Path\Microsoft.PowerShell_profile.ps1"
}

# PowerShell cmdlet repository location
. $Path\New-UserEnvironmentalVariable.ps1 -Key 'PSLocalModulePath' -Value '%USERPROFILE%\OneDrive\Development\Scripts\PowerShell'

# set up dev directory and env var
if (!(Test-Path -Path C:\dev)) {
    New-Item -Path C:\dev -ItemType directory
}
. $Path\New-UserEnvironmentalVariable.ps1 -Key 'DEV' -Value 'C:\dev'

# Create shortcut for devenv cmdlet
. $Path\New-Shortcut.ps1 -Target '%windir%\System32\cmd.exe' -Path 'C:\Users\hamis\Desktop\Start Development Environment.lnk' -Arguments '/c "title RUNNING_DevelopmentEnvironment & powershell.exe %PSLocalModulePath%\Start-DevEnv\Start-DevEnv.ps1"' -IconLocation 'C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\devenv.exe' -IconIndex 4