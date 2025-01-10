import os
import glob
import argparse
from typing import List

def update_files(file_pattern: str, search_text: str, replace_text: str) -> List[str]:
    """
    Update content in files matching the specified pattern.

    Args:
        file_pattern: Pattern to match files
        search_text: Text to search for
        replace_text: Text to replace matches with

    Returns:
        List of updated file paths
    """
    # Get parent directory path
    parent_dir = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))

    # Change to parent directory
    os.chdir(parent_dir)

    # Find all matching files recursively
    files = glob.glob(f"**/{file_pattern}", recursive=True)
    updated_files = []

    for file_path in files:
        try:
            # Read file content
            with open(file_path, 'r', encoding='utf-8') as f:
                content = f.read()

            # Replace the content
            new_content = content.replace(search_text, replace_text)

            # Write back to file if changes were made
            if content != new_content:
                with open(file_path, 'w', encoding='utf-8', newline='') as f:
                    f.write(new_content)
                updated_files.append(file_path)
                print(f"Updated: {file_path}")
        except Exception as e:
            print(f"Error processing {file_path}: {str(e)}")

    return updated_files

def main():
    parser = argparse.ArgumentParser(description='Update content in files')
    parser.add_argument('--pattern', required=True, help='File pattern to match')
    parser.add_argument('--search', required=True, help='Text to search for')
    parser.add_argument('--replace', required=True, help='Text to replace with')

    args = parser.parse_args()

    print(f"Starting content update process...")
    print(f"Looking for files matching: {args.pattern}")

    updated_files = update_files(args.pattern, args.search, args.replace)
    print(f"Completed! Updated {len(updated_files)} files.")

if __name__ == "__main__":
    main()
