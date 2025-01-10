<#
.SYNOPSIS
    Updates content in files matching specified pattern
.DESCRIPTION
    Finds all files matching the specified pattern and performs search/replace operation
.PARAMETER FilePattern
    Pattern to match files (e.g., "model.tmdl")
.PARAMETER SearchPattern
    Text pattern to search for
.PARAMETER ReplacePattern
    Text to replace matches with
.EXAMPLE
    .\Update-TmdlAnnotations.ps1 -FilePattern "model.tmdl" -SearchPattern 'annotation PBI_ProTooling = ["DevMode"]' -ReplacePattern 'annotation PBI_ProTooling = ["DevMode","TMDL-Extension"]'
#>
param(
    [Parameter(Mandatory=$true)]
    [string]$FilePattern,

    [Parameter(Mandatory=$true)]
    [string]$SearchPattern,

    [Parameter(Mandatory=$true)]
    [string]$ReplacePattern
)

# Get parent directory path
$parentPath = Split-Path -Parent $PSScriptRoot

# Get all matching files recursively from parent directory
$files = Get-ChildItem -Path $parentPath -Filter $FilePattern -Recurse
$updateCount = 0

Write-Host "Starting content update process..."
Write-Host "Looking for files matching: $FilePattern"

foreach ($file in $files) {
    try {
        # Read file content
        $content = Get-Content $file.FullName -Raw

        # Replace the content
        $newContent = $content -replace $SearchPattern, $ReplacePattern

        # Write back to file if changes were made
        if ($content -ne $newContent) {
            $newContent | Set-Content $file.FullName -NoNewline
            $updateCount++
            Write-Host "Updated: $($file.FullName)"
        }
    }
    catch {
        Write-Error "Error processing $($file.FullName): $_"
    }
}

Write-Host "Completed! Updated $updateCount files."
