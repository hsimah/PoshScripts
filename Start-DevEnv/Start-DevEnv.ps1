$Name = 'MSSQL$SQLEXPRESS'
$Service = Get-Service -Name $Name

if ($Service.Status -ne 'Running') {
    Write-Output "Starting $Name..."
    Start-Service -InputObject $Service -ErrorAction Stop
}

Write-Output "$Name is $($Service.Status)."

Write-Output "Starting Visual Studio 2015 Community..."

$Process = Start-Process -FilePath "C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\devenv.exe" -PassThru

Write-Output "Visual Studio 2015 Community running."

Wait-Process -InputObject $Process

Write-Output "Visual Studio 2015 Community closed."

$Outservice = Stop-Service -InputObject $Service -Confirm -PassThru

if ($Outservice) {
    Write-Output "Stopping $Name..."
    Write-Output "$Name is $($Service.Status)."
} else {
    Write-Output "$Name is still $($Service.Status)."
}