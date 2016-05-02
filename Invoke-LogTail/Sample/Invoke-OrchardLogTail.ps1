param([string]$Solution)

# alter this to point to where Invoke-LogTail.ps1 is stored
. $env:PSLocalModulePath\Invoke-LogTail\Invoke-LogTail.ps1

$LogFileFormat = 'orchard-{0}-{1}.log'
$LogFileLocation = "$Solution\Orchard.Web\App_Data\Logs"
$Date = Get-Date -Format yyyy.MM.dd

$LogFileName = $($LogFileFormat -f 'error',$Date)
$ErrorLogProcess = Invoke-LogTail -Path "$LogFileLocation\$LogFileName" -Title $LogFileName

$LogFileName = $($LogFileFormat -f 'debug',$Date)
$DebugLogProcess = Invoke-LogTail -Path "$LogFileLocation\$LogFileName" -Title $LogFileName

# Add the following to csproj
#
#  <PropertyGroup>
#    <PostBuildEvent>"C:\Windows\system32\WindowsPowerShell\v1.0\powershell.exe" -file $(SolutionDir)Tools\Scripts\Invoke-OrchardLogTail.ps1 $(SolutionDir)</PostBuildEvent>
#  </PropertyGroup>
#

# Install this file into src\Tools\Scripts