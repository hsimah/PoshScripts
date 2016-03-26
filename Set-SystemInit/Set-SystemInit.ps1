﻿$Path = Split-Path $MyInvocation.MyCommand.Path -Parent

# PowerShell cmdlet repository location
. $Path\New-UserEnvironmentalVariable.ps1 -Key 'PSLocalModulePath' -Value '%USERPROFILE%\OneDrive\Development\Scripts\PowerShell'

# Create shortcut for devenv cmdlet
. $Path\New-Shortcut.ps1 -Target '%windir%\System32\cmd.exe' -Path 'C:\Users\hamis\Desktop\Start Development Environment.lnk' -Arguments '/c "title RUNNING_DevelopmentEnvironment & powershell.exe %PSLocalModulePath%\Start-DevEnv\Start-DevEnv.ps1"' -IconLocation 'C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\devenv.exe' -IconIndex 4