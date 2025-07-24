#!/bin/bash

# A script to interactively review and strip EXIF data from files.

# Check if exiftool is installed.
if ! command -v exiftool &> /dev/null
then
    echo "Error: exiftool is not installed."
    echo "Please install it from https://exiftool.org/ or via Homebrew (brew install exiftool)."
    exit 1
fi

# If no files are provided, show instructions and exit.
if [ "$#" -eq 0 ]; then
    echo "Usage: Drag and drop one or more files onto this script."
    read -p "Press Enter to exit."
    exit 0
fi

# Loop through each file provided as an argument.
for file in "$@"
do
    # Clear the terminal for a clean view for each file.
    clear
    
    echo "--------------------------------------------------"
    echo "🔎 Processing File: $file"
    echo "--------------------------------------------------"
    echo ""
    
    # Display the EXIF data.
    exiftool "$file"
    
    echo ""
    echo "--------------------------------------------------"
    # Ask the user for confirmation.
    read -p "Do you want to strip all metadata from this file? (y/n): " choice
    
    # Check the user's response.
    case "$choice" in
      y|Y )
        echo "⏳ Stripping metadata..."
        # The -overwrite_original flag prevents exiftool from creating a backup file.
        exiftool -all= -overwrite_original "$file"
        echo "✅ Done."
        ;;
      * )
        echo "⏭️ Skipping file."
        ;;
    esac
    
    echo ""
    read -p "Press Enter to continue to the next file (or exit if done)..."
done

clear
echo "✨ All files processed."