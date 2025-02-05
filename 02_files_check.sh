#!/bin/bash

declare -a files
directory="university_db"
SQL_FILES=("setup.sql" "create_courses_table.sql" "create_enrollments_table.sql") # Array of filenames

for file in "${files[@]}"; do  # Important: Quote "${files[@]}"
filepath="$directory/$file" # Construct the full path
if [ -f "$filepath" ]; then
    echo "$filepath exists"
else
    echo "$filepath does not exist"
fi
done