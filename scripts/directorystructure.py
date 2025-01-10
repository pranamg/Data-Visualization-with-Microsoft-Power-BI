import os
import glob
import shutil

# Change to parent directory to scan for files
os.chdir(os.path.dirname(os.path.dirname(__file__)))

# ...existing code...


# Get all PBIX and XLSX files in the current directory
pbix_files = glob.glob("*.pbix")
xlsx_files = glob.glob("*.xlsx")

# Process PBIX files
for pbix_file in pbix_files:
    # Create folder name by removing extension
    folder_name = os.path.splitext(pbix_file)[0]

    # Create directory if it doesn't exist
    os.makedirs(folder_name, exist_ok=True)

    # Copy PBIX file to its folder
    shutil.copy2(pbix_file, os.path.join(folder_name, pbix_file))

    # Check if any Excel file starts with the same prefix
    prefix = folder_name.split()[0]  # Get the numeric prefix
    for xlsx_file in xlsx_files:
        if xlsx_file.startswith(prefix):
            shutil.copy2(xlsx_file, os.path.join(folder_name, xlsx_file))

print("Directory structure created successfully!")
