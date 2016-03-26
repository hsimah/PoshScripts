param(
    [string]$Target,
    [string]$Arguments,
    [string]$Path,
    [string]$IconLocation,
    [int]$IconIndex

)

$Shell = New-Object -ComObject WScript.Shell
$Shortcut = $Shell.CreateShortcut($Path)

$Shortcut.TargetPath = $Target
$Shortcut.Arguments = $Arguments
$Shortcut.Save()

# Set shortcut icon
if ($IconLocation -and $IconIndex) {
    $Folder = Split-Path -Path $Path -Parent
    $FileName = Split-Path -Path $Path -Leaf

    $Shell = New-Object -Com Shell.Application
    $Shortcut = (($Shell.NameSpace($Folder)).ParseName($FileName)).GetLink

    $Shortcut.SetIconLocation($IconLocation, $IconIndex)
    $Shortcut.Save()
}



## TODO: pin shortcut
## add pin parameter


#$f = 'C:\Users\hamis\Desktop'
#$n = 'test.lnk'

#$shell = new-object -com "Shell.Application"  
#$folder = $shell.Namespace($f)    
#$item = $folder.Parsename($n)
#$verb = $item.Verbs() | ? {$_.Name -eq 'Pin to Tas&kbar'}
#if ($verb) {$verb.DoIt()}

#$sa = new-object -c shell.application
#$pn = $sa.namespace($f).parsename($n)
#$pn.invokeverb('taskbarpin')

# this is non-working as Microsoft have removed the ability to programmatically pin items