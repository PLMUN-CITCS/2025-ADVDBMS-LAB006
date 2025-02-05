CREATE DATABASE `UniversityDB`;

-- Step 2: Create the Enrollments table with foreign key constraints
CREATE TABLE `Enrollments` (
    `EnrollmentID` INT PRIMARY KEY AUTO_INCREMENT, -- Or SERIAL/IDENTITY
    `StudentID` INT,
    `CourseID` INT,
    `EnrollmentDate` DATE,
    CONSTRAINT `fk_student` FOREIGN KEY (`StudentID`) REFERENCES `Students`(`StudentID`),
    CONSTRAINT `fk_course` FOREIGN KEY (`CourseID`) REFERENCES `Courses`(`CourseID`)
);
