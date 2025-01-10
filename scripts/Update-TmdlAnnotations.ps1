<#
.SYNOPSIS
    Updates PBI_ProTooling annotation in all model.tmdl files
.DESCRIPTION
    Finds all model.tmdl files and updates the PBI_ProTooling annotation
    from ["DevMode"] to ["DevMode","TMDL-Extension"]
.NOTES
    Version: 1.0
#>

# Get parent directory path
$parentPath = Split-Path -Parent $PSScriptRoot

# Get all model.tmdl files recursively from parent directory
$files = Get-ChildItem -Path $parentPath -Filter "model.tmdl" -Recurse
$updateCount = 0

Write-Host "Starting TMDL annotation update process..."

foreach ($file in $files) {
    try {
        # Read file content
        $content = Get-Content $file.FullName -Raw

        # Replace the annotation
        $newContent = $content -replace 'annotation PBI_ProTooling = \["DevMode"\]', 'annotation PBI_ProTooling = ["DevMode","TMDL-Extension"]'

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
