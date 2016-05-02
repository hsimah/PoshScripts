function Invoke-LogTail([string]$Path, [string]$Title) {
    if (!$(Test-Path -Path $Path)) {
        New-Item -ItemType file -Path $Path
    }

    # check if log already being tailed
    $Process = Get-Process -Name powershell | Where-Object { $_.MainWindowTitle -eq $Title }

    if (!$Process) {
        # start new window and tail log
        $Process = Start-Process powershell -ArgumentList "`$host.ui.RawUI.WindowTitle = '$Title'; Get-Content -Path $Path -Wait" -PassThru
    }

    # return process to caller
    return $Process
}