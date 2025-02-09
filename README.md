# **2025-ADVDBMS-LAB006**
Week 02 - Review on Database Concepts

Laboratory # 06 - Guided Coding Exercise: Creating Tables with Primary and Foreign Keys

## **Instructions**

### **Step 1.1: Accept the Assignment**

   1. Click on the assignment link provided by your instructor.
   2. GitHub Classroom will create a **private repository** under your GitHub account.
   3. After the repository is created, click **"Go to Repository"** to view your assignment.

---

### **Step 1.2: Setup your Git Environment**
Only perform this if this is the first time you will setup your Git Environment

   1. Create a GitHub Account:
   ```bash
   https://github.com/signup?source=login
   ```
      
   2. Download and Install Git on your Laptop/Desktop:
   ```bash
   https://git-scm.com/downloads
   ```
   
   3. Create a Folder in your Laptop/Desktop
   4. Right-click anywhere in the created folder and select "Open Git Bash Here".
   5. In the Git Bash Terminal, set your git name, perform command:
   ```bash
   git config --global user.name "Your Name"
   ```
   
   6. In the Git Bash Terminal, set your git email, perform command:
   ```bash
   git config --global user.email "your.email@example.com"
   ```
   
   7. Create your SSH Key, just follow the instructions, no need to provide filename and passphrase. In the Git Bash Terminal, perform command:
   ```bash
   ssh-keygen -t rsa -b 4096 -C "your_email@example.com"
   ```
   
   8. Copy your SSH Keys into clipboard. In the Git Bash Terminal, perform command:
   ```bash
   clip < ~/.ssh/id_rsa.pub
   ```
   
   9. Log in to your GitHub account.
   10. In the upper-right corner of GitHub, click your profile picture and select Settings.
   11. In the left sidebar, click on SSH and GPG keys.
   12. Click the New SSH key button.
   13. In the Title field, give the key a recognizable name (e.g., "My Windows Laptop").
   14. In the Key field, CTRL + V or paste the keys copied into your clipboard. Save the key.
   15. Go Back to terminal, use command:
   ```bash
   ssh -T git@github.com
   ```

### **Step 2: Clone the Repository to Your Local Machine**

   1. On your repository page, click the green **"Code"** button.
   2. Copy the repository URL (choose HTTPS for simplicity).
   3. Open your terminal (or Git Bash, Command Prompt, or PowerShell) and run:
   
   ```bash
   git clone <git_repo_url>
   ```
   
   4. Navigate into the cloned folder:
   
   ```bash
   cd <git_cloned_folder>
   ```

### **Step 3: Complete the Assignment**

**Laboratory # 06 - Guided Coding Exercise: Creating Tables with Primary and Foreign Keys**

   **Objective:**
   Learn how to create tables with primary and foreign key relationships in SQL. This exercise demonstrates how to link two tables together, ensuring referential integrity.

   **Folder Structure:**
   ```
   university_db/
   ├── create_courses_table.sql
   └── create_enrollments_table.sql
   ```

   **File Naming Convention:**
   - `create_courses_table.sql`: Contains the SQL statement for creating the Courses table.
   - `create_enrollments_table.sql`: Contains the SQL statement for creating the Enrollments table with foreign key constraints.

   **Notable Observations (to be discussed after completing the exercise):**
   - Referential Integrity: The Golden Rule: Foreign keys are all about relationships. They ensure that your data is consistent. You can't enroll a student in a course that doesn't exist. This is called referential integrity, and it's fundamental to relational databases.
   - Order Matters: Think of it like building a house. You need the foundation (parent tables) before you can build the walls (child tables). The order in which you create tables with foreign keys is crucial.
   - Data Type Harmony: Foreign keys and their corresponding primary keys must have matching data types. It's like trying to fit a square peg in a round hole if they don't match.
   - Composite Keys: Two (or More) are Better Than One: Sometimes, a combination of columns makes a good key. A composite key can prevent duplicate enrollments in the same course, for instance.
   - Constraint Options: The Fine Print: ON DELETE CASCADE or ON DELETE SET NULL give you control over what happens when you delete a record in a parent table. Do you want to delete related records in the child table automatically? Or set the foreign keys to NULL? These are important design decisions.

**SQL Script Best Practices**
   - Descriptive Constraint Names: Give your foreign key constraints meaningful names (like fk_student or fk_course). This makes your code easier to understand and maintain.
   - ER Diagrams: Visualize the Connections: Before you start writing SQL, sketch out an ER diagram. It helps you visualize the relationships between your tables and ensures you're designing your database correctly.
     
   **Step-by-Step Instructions:**

   1. Setting up the Environment
      - Ensure you have a SQL database management system installed and that you've connected to the `UniversityDB` database (created in Problem 1) and created the `Students` table (created in Problem 2). The `Students` table will be referenced by a foreign key in this exercise.
      - Create the two SQL files as shown in the folder structure above within the `university_db` directory.
      
   2. `create_courses_table.sql` (Create Courses Table):
      - Open `create_courses_table`.sql in a text editor.
      - Create the Courses table:
      ```SQL
      USE `UniversityDB`;

      -- Step 1: Create the Courses table
      CREATE TABLE `Courses` (
      `CourseID` INT PRIMARY KEY AUTO_INCREMENT, -- Or SERIAL/IDENTITY as needed for your DBMS
      `CourseName` VARCHAR(100) NOT NULL
      );

      ```
      
      - Important Note: Use `AUTO_INCREMENT` (MySQL), `SERIAL` (PostgreSQL), or `IDENTITY` (SQL Server) for the `CourseID` as appropriate for your database system.

      - Save the `create_courses_table.sql` file.
      
   3. `create_enrollments_table.sql` (Create Enrollments Table):
      - Open `create_enrollments_table.sql` in a text editor.
      - Create the `Enrollments` table with foreign key constraints:
      ```SQL
      USE `UniversityDB`;

      -- Step 2: Create the Enrollments table with foreign key constraints
      CREATE TABLE `Enrollments` (
      `EnrollmentID` INT PRIMARY KEY AUTO_INCREMENT, -- Or SERIAL/IDENTITY
      `StudentID` INT,
      `CourseID` INT,
      `EnrollmentDate` DATE,
      CONSTRAINT `fk_student` FOREIGN KEY (`StudentID`) REFERENCES `Students`(`StudentID`),
      CONSTRAINT `fk_course` FOREIGN KEY (`CourseID`) REFERENCES `Courses`(`CourseID`)
      );

      ```
         - Important Note: The order in which you create the tables is important. You must create the `Courses` and `Students` tables before you create the `Enrollments` table because the `Enrollments` table references them via foreign keys.
         - The `fk_student` and `fk_course` are names given to the foreign key constraints. You can choose descriptive names.
         - The `REFERENCES Students(StudentID)` and `REFERENCES Courses(CourseID)` clauses specify the tables and columns that the foreign keys reference.
      
      - Save the `create_enrollments_table.sql` file.

   4. Executing the SQL Scripts:
   - Open your SQL client and connect to the `UniversityDB` database.
   - Create Courses Table: Execute the `create_courses_table.sql` script.
   - Create Enrollments Table: Execute the `create_enrollments_table.sql` script.

### **Step 4: Push Changes to GitHub**
Once you've completed your changes, follow these steps to upload your work to your GitHub repository.

1. Check the status of your changes:
   Open the terminal and run:
   
   ```bash
   git status
   ```
   This command shows any modified or new files.
   
2. Stage the changes:
   Add all modified files to staging:
   
   ```bash
   git add .
   ```
   
3. Commit your changes:
   Write a meaningful commit message:
   
   ```bash
   git commit -m "Submitting ADVDBMS Week 02 - Session 01 - Exercise 04"
   ```
   
4. Push your changes to GitHub:
   Upload your changes to your remote repository:
   
   ```bash
   git push origin main
   ```
