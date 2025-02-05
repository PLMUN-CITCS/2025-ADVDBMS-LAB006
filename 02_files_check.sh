#!/bin/bash

declare -a files
directory="university_db"
SQL_FILES=("setup.sql" "insert_students.sql" "update_student_email.sql" "delete_student.sql") # Array of filenames

for file in "${files[@]}"; do  # Important: Quote "${files[@]}"
filepath="$directory/$file" # Construct the full path
if [ -f "$filepath" ]; then
    echo "$filepath exists"
else
    echo "$filepath does not exist"
fi
done