# Change to parent directory to scan for files
Set-Location (Split-Path $PSScriptRoot -Parent)

# ...existing code...
# Get all PBIX and XLSX files in the current directory
$files = Get-ChildItem -Path . -Filter "*.pbix" 
$dataFiles = Get-ChildItem -Path . -Filter "*.xlsx"

# Process PBIX files
foreach ($file in $files) {
    # Create folder name by removing extension
    $folderName = [System.IO.Path]::GetFileNameWithoutExtension($file.Name)
    
    # Create directory if it doesn't exist
    if (!(Test-Path $folderName)) {
        New-Item -ItemType Directory -Path $folderName
    }
    
    # Copy PBIX file to its folder
    Copy-Item $file.Name -Destination $folderName
    
    # Get the numeric prefix from folder name
    $prefix = $folderName.Split()[0]
    
    # Check for Excel files with matching prefix
    $relatedData = $dataFiles | Where-Object { $_.Name.StartsWith($prefix) }
    if ($relatedData) {
        Copy-Item $relatedData.Name -Destination $folderName
    }
}