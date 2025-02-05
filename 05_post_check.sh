#!/bin/bash

# Database credentials (environment variables are recommended)
DB_HOST="${DB_HOST:-127.0.0.1}"  # Default to 127.0.0.1 if not set
DB_PORT="${DB_PORT:-4000}"      # Default to 4000 if not set
DB_USER="${DB_USER:-root}"      # Default to root if not set
DB_NAME="${DB_NAME:-UniversityDB}"      # Default to root if not set

# Function to execute SQL queries and handle errors
execute_sql() {
  mysql -h "$DB_HOST" -P "$DB_PORT" -u "$DB_USER" -D "$DB_NAME" -e "$1"
  if [[ $? -ne 0 ]]; then
    echo "Error executing SQL: $1"
    exit 1
  fi
}

# --- Validation ---
# 1. Check the Courses table structure (columns)
courses_columns=$(execute_sql "DESCRIBE Courses;" | awk '{print $1}' | grep -E 'CourseID|CourseName' | tr -d '\n') # Remove newlines
expected_courses_columns="CourseIDCourseName"  # Expected without newlines

if [[ "$courses_columns" == "$expected_courses_columns" ]]; then
    echo "Courses table structure check: PASSED"
else
    echo "Courses table structure check: FAILED. Expected columns: '$expected_courses_columns', Found: '$courses_columns'"
    exit 1
fi

# 2. Check Enrollments Table Structure and Foreign Keys
enrollments_structure=$(execute_sql "DESCRIBE Enrollments;" | awk '{print $1}' | grep -E 'EnrollmentID|StudentID|CourseID|EnrollmentDate' | tr -d '\n') # Remove newlines
expected_enrollments_structure="EnrollmentIDStudentIDCourseIDEnrollmentDate" # Expected without newlines

if [[ "$enrollments_structure" == "$expected_enrollments_structure" ]]; then
    echo "Enrollments table structure check: PASSED"
else
    echo "Enrollments table structure check: FAILED. Expected structure: '$expected_enrollments_structure', Found: '$enrollments_structure'"
    exit 1
fi

# 3. Check Foreign Key Constraints (more robust and correct)
fk_check=$(execute_sql "SHOW CREATE TABLE Enrollments;" | grep -E "CONSTRAINT \`fk_student\`|CONSTRAINT \`fk_course\`" | tr -d '\n\t ')

# Improved expected string construction (only constraints)
expected_fk_check=$(echo "EnrollmentsCREATETABLE\`enrollments\`(\n\`EnrollmentID\`int(11)NOTNULLAUTO_INCREMENT,\n\`StudentID\`int(11)DEFAULTNULL,\n\`CourseID\`int(11)DEFAULTNULL,\n\`EnrollmentDate\`dateDEFAULTNULL,\nPRIMARYKEY(\`EnrollmentID\`),\nKEY\`fk_student\`(\`StudentID\`),\nKEY\`fk_course\`(\`CourseID\`),\nCONSTRAINT\`fk_course\`FOREIGNKEY(\`CourseID\`)REFERENCES\`courses\`(\`CourseID\`),\nCONSTRAINT\`fk_student\`FOREIGNKEY(\`StudentID\`)REFERENCES\`students\`(\`StudentID\`)\n)ENGINE=InnoDBDEFAULTCHARSET=utf8mb4COLLATE=utf8mb4_general_ci" | tr -d '\n\t ')

if [[ "$fk_check" == "$expected_fk_check" ]]; then
    echo "Foreign Key constraints check: PASSED"
else
    echo "Foreign Key constraints check: FAILED. Expected: '$expected_fk_check', Found: '$fk_check'"
    exit 1
fi


echo "All database schema validations passed!"

exit 0