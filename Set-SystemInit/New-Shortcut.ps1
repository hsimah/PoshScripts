$Target = '%windir%\System32\cmd.exe'

function New-Shortcut([string]$Target, [string]$Arguments, [string]$Path) {
    $WshShell = New-Object -comObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut($Path)
    $Shortcut.TargetPath = $Target
    $Shortcut.Arguments = $Arguments
    $Shortcut.Save()
}

New-Shortcut -Target $Target -Path "C:\Users\hamis\Desktop\test.lnk" -Arguments '/c "title Start-DevEnv & powershell.exe %CMDLET_REPO%\Start-DevEnv\Start-DevEnv.ps1"'

$f = 'C:\Users\hamis\Desktop'
$n = 'test.lnk'

#$shell = new-object -com "Shell.Application"  
#$folder = $shell.Namespace($f)    
#$item = $folder.Parsename($n)
#$verb = $item.Verbs() | ? {$_.Name -eq 'Pin to Tas&kbar'}
#if ($verb) {$verb.DoIt()}

$sa = new-object -c shell.application
$pn = $sa.namespace($f).parsename($n)
$pn.invokeverb('taskbarpin')

# this is non-working as Microsoft have removed the ability to programmatically pin items