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

# 3. Check Foreign Key Constraints (correct and efficient using information_schema)

# Check if fk_student exists
fk_student_exists=$(execute_sql "SELECT COUNT(*) FROM information_schema.REFERENTIAL_CONSTRAINTS WHERE CONSTRAINT_NAME = 'fk_student' AND TABLE_NAME = 'Enrollments' AND REFERENCED_TABLE_NAME = 'Students';" | tail -n 1)

# Check if fk_course exists
fk_course_exists=$(execute_sql "SELECT COUNT(*) FROM information_schema.REFERENTIAL_CONSTRAINTS WHERE CONSTRAINT_NAME = 'fk_course' AND TABLE_NAME = 'Enrollments' AND REFERENCED_TABLE_NAME = 'Courses';" | tail -n 1)


if [[ "$fk_student_exists" -eq 1 && "$fk_course_exists" -eq 1 ]]; then
    echo "Foreign Key constraints check: PASSED"
else
    echo "Foreign Key constraints check: FAILED (fk_student: $fk_student_exists, fk_course: $fk_course_exists)"
    exit 1
fi

echo "All database schema validations passed!"

exit 0