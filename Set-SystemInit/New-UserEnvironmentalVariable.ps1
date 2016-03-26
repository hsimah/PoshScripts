param(
    [Parameter(Mandatory=$true, Position=1)]
    [string]$Key,
    [Parameter(Mandatory=$true, Position=2)]
    [string]$Value
)

if ((Get-ChildItem env: | Where-Object { $_.Name -eq $Key }).Length -eq 0) {
    Set-ItemProperty -Path HKCU:\Environment -Name $Key -Value $Value -Type ExpandString
}