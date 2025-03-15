#!/bin/bash

# Define variables
screenshots_dir="./Screenshots"
output_file="README.md"

# Check if Screenshots directory exists
if [ ! -d "$screenshots_dir" ]; then
    echo "❌ Error: The '$screenshots_dir' directory does not exist."
    exit 1
fi

echo "🔄 Renaming files in '$screenshots_dir'..."
# Rename all files in the directory (replace spaces with '-')
for file in "$screenshots_dir"/*; do
    if [[ -f "$file" ]]; then
        filename=$(basename -- "$file")
        new_filename=$(echo "$filename" | tr ' ' '-')
        if [[ "$filename" != "$new_filename" ]]; then
            mv "$screenshots_dir/$filename" "$screenshots_dir/$new_filename"
            echo "✅ Renamed: '$filename' → '$new_filename'"
        fi
    fi
done

echo "📄 Generating README.md..."
# Write header to README.md
echo "## Screenshots" > "$output_file"
echo "" >> "$output_file"

# Enable nullglob to avoid issues when no matching files are found
shopt -s nullglob

# Loop through image files and add them to README.md
for file in "$screenshots_dir"/*.{jpg,jpeg,png,gif}; do
    if [[ -e "$file" ]]; then
        filename=$(basename "$file")
        echo "![${filename}]($screenshots_dir/${filename})" >> "$output_file"
    fi
done

echo "🎉 README.md has been generated successfully!"
