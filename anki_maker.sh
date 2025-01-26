#!/bin/bash

# Check if a prefix is provided as an argument
if [ -z "$1" ]; then
    echo "Usage: $0 <prefix>"
    exit 1
fi

prefix="$1"
notes_dir="/path/to/notes/"
anki_dir="/path/to/ankicsvs/"
final_file="${anki_dir}${prefix}_final.txt"

# Remove the final file if it exists
[ -f "$final_file" ] && rm "$final_file"

# Find all files matching the prefix, recursively in the directory
find "$notes_dir" -type f -name "${prefix}*.md" | while read -r note_file; do
    echo "Working on $note_file ..."
    # Process the note file with fabric and append directly to the final file
    fabric -sp to_anki < "$note_file" >> "$final_file"
done

echo "Processing complete. Final output is in $final_file."

