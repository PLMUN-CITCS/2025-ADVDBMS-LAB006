-- Step 1: Create the Courses table
CREATE TABLE `Courses` (
    `CourseID` INT PRIMARY KEY AUTO_INCREMENT, -- Or SERIAL/IDENTITY as needed for your DBMS
    `CourseName` VARCHAR(100) NOT NULL
);
