CREATE DATABASE `UniversityDB`;

USE `UniversityDB`;

CREATE TABLE `Students` (
   `StudentID` INT PRIMARY KEY AUTO_INCREMENT,  -- MySQL Example: AUTO_INCREMENT
   -- For other databases (e.g., PostgreSQL, SQL Server) you might use SERIAL or IDENTITY
   `FirstName` VARCHAR(50) NOT NULL,
   `LastName` VARCHAR(50) NOT NULL,
   `EnrollmentDate` DATE
);

ALTER TABLE `Students`
ADD `Email` VARCHAR(100);

INSERT INTO `Students` (`FirstName`, `LastName`, `EnrollmentDate`, `Email`)  -- StudentID is auto-incremented
VALUES
('Alice', 'Smith', '2023-09-01', 'alice.smith@example.com'),
('Bob', 'Johnson', '2023-09-01', 'bob.johnson@example.com'),
('Charlie', 'Lee', '2023-09-01', 'charlie.lee@example.com');

UPDATE `Students`
SET `Email` = 'bob.j@example.com'
WHERE `FirstName` = 'Bob' AND `LastName` = 'Johnson';

DELETE FROM `Students`
WHERE `FirstName` = 'Charlie' AND `LastName` = 'Lee';
