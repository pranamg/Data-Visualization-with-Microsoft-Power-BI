import os
import glob

# Get parent directory path
parent_dir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

# Change to parent directory
os.chdir(parent_dir)

# Find all model.tmdl files recursively
model_files = glob.glob("**/model.tmdl", recursive=True)

for file_path in model_files:
    # Read file content
    with open(file_path, 'r', encoding='utf-8') as f:
        content = f.read()

    # Replace the annotation
    new_content = content.replace(
        'annotation PBI_ProTooling = ["DevMode"]',
        'annotation PBI_ProTooling = ["DevMode","TMDL-Extension"]'
    )

    # Write back to file
    with open(file_path, 'w', encoding='utf-8', newline='') as f:
        f.write(new_content)
