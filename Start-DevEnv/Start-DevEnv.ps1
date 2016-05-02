function Show-ConsoleMenu([Hashtable]$Options, [string]$Title, [string]$Message) {
    $Choices = @()
    foreach ($Option in $Options.GetEnumerator()) {

        $Choices += New-Object System.Management.Automation.Host.ChoiceDescription $("&{0}" -f $Option.Name), $Option.Value
    }
    
    $Result = $host.ui.PromptForChoice($Title, $Message, $Choices, 0)

    return $Result
}

function Invoke-VisualStudio() {
    Write-Output "Starting Visual Studio 2015 Community..."

    $Process = Start-Process -FilePath "C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\devenv.exe" -PassThru

    Write-Output "Visual Studio 2015 Community running."

    Wait-Process -InputObject $Process

    Write-Output "Visual Studio 2015 Community closed."
}

function Start-DependentService([string]$Name) {
    $Service = Get-Service -Name $Name

    if ($Service.Status -ne 'Running') {
        Write-Output "Starting $Name..."
        Start-Service -InputObject $Service -ErrorAction Stop
    }

    Write-Output "$Name is $($Service.Status)."
}

function Stop-DependentService([string]$Name) {
    $Service = Get-Service -Name $Name

    if ($Service.Status -eq 'Running') {
        Write-Output "Stopping $Name..."
        Stop-Service -InputObject $Service -Confirm
    }

    Write-Output "$Name is $($Service.Status)."
}

$Services = @('MSSQL$SQLEXPRESS')

# Start dependent services
foreach ($Service in $Services) {
    Start-DependentService -Name $Service
}

while ($true) {
    # Start Visual Studio
    Invoke-VisualStudio

    # Visual Studio closed - prompt user for next action
    $Result = Show-ConsoleMenu -Title "Visual Studio closed" -Message "Action to take?" -Options @{ 
        Restart="Restart Visual Studio 2015."; End="End development session (shut down SQL Server)."; }

    switch ($Result) {
        0 {
            # stop dependent services
            foreach ($Service in $Services) {
                Stop-DependentService -Name $Service
            }

            exit
        }
        1 {
            # restart Visual studio
            continue
        }
    }
}