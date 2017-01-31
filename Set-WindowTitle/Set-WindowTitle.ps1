<#
.SYNOPSIS

Sets the current PowerShell window title.
.DESCRIPTION

Sets the current PowerShell window title.
.PARAMETER Title

The new window title.
.PARAMETER filePath

Provide a PARAMETER section for each parameter that your script or function accepts.
.EXAMPLE

PS C:\>Set-WindowTitle -Title 'Log.txt Tail'

Sets the current PowerShell window title to be 'Log.txt Tail'
#>
function Set-WindowTitle {
    Param([Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [string]
        $Title)

    $Host.UI.RawUI.WindowTitle = $Title
}