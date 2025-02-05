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
courses_columns=$(execute_sql "DESCRIBE Courses;" | awk '{print $1}' | grep -E 'CourseID|CourseName') # Extract column names
expected_courses_columns="CourseID\nCourseName"

if [[ "$courses_columns" == "$expected_courses_columns" ]]; then
    echo "Courses table structure check: PASSED"
else
    echo "Courses table structure check: FAILED. Expected columns: $expected_courses_columns, Found: $courses_columns"
    exit 1
fi

# 2. Check Enrollments Table Structure and Foreign Keys
enrollments_structure=$(execute_sql "DESCRIBE Enrollments;" | awk '{print $1}' | grep -E 'EnrollmentID|StudentID|CourseID|EnrollmentDate')
expected_enrollments_structure="EnrollmentID\nStudentID\nCourseID\nEnrollmentDate"

if [[ "$enrollments_structure" == "$expected_enrollments_structure" ]]; then
    echo "Enrollments table structure check: PASSED"
else
    echo "Enrollments table structure check: FAILED. Expected structure: $expected_enrollments_structure, Found: $enrollments_structure"
    exit 1
fi



# 3. Check Foreign Key Constraints (more complex, requires parsing SHOW CREATE TABLE)
fk_check=$(execute_sql "SHOW CREATE TABLE Enrollments;" | grep -E "CONSTRAINT `fk_student`|CONSTRAINT `fk_course`")

expected_fk_check="CONSTRAINT `fk_student` FOREIGN KEY (`StudentID`) REFERENCES `Students` (`StudentID`),\n\tCONSTRAINT `fk_course` FOREIGN KEY (`CourseID`) REFERENCES `Courses` (`CourseID`)"


if [[ "$fk_check" == "$expected_fk_check" ]]; then
    echo "Foreign Key constraints check: PASSED"
else
    echo "Foreign Key constraints check: FAILED. Expected: '$expected_fk_check', Found: '$fk_check'"
    exit 1
fi


echo "All database schema validations passed!"

exit 0