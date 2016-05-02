# get functions to be autoloaded
$AutoLoadFuncs = Get-Content -Path $env:PSLocalModulePath\autoload.ini

# load functions
foreach ($Func in $AutoLoadFuncs) {
    if ($Func.StartsWith('#')) { 
        continue 
    }

    Get-ChildItem -Path $env:PSLocalModulePath\$Func -Filter *.ps1 | ForEach-Object { 
        . $_.FullName
    }
}

Write-Output "Custom PowerShell Environment loaded"

# Aliases
function mklink { cmd /c mklink $args }