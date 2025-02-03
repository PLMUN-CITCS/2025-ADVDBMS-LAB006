2025-ADVDBMS-WK02S0E02
Week 02 - Review on Database Concepts

Exercise # 03 - Guided Coding Exercise: Inserting, Updating, and Deleting Records

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

**Exercise # 03 - Guided Coding Exercise: Inserting, Updating, and Deleting Records**

   **Objective:**
   Learn how to insert, update, and delete data within a table using SQL DML (Data Manipulation Language) commands. This exercise builds upon the Students table created in the previous exercise.

   **Folder Structure:**
   ```
   university_db/
   ├── insert_students.sql
   ├── update_student_email.sql
   └── delete_student.sql
   ```

   **File Naming Convention:**
   - `insert_students.sql`: Contains the SQL statements for inserting student records.
   - `update_student_email.sql`: Contains the SQL statement for updating a student's email.
   - `delete_student.sql`: Contains the SQL statement for deleting a student record.

   **Notable Observations (to be discussed after completing the exercise):**
   - Primary Keys: This exercise highlights the importance of primary keys for uniquely identifying records. Always use primary keys in `WHERE` clauses for `UPDATE` and `DELETE` statements whenever possible.
   - WHERE Clause: The `WHERE` clause is crucial for specifying which records to update or delete. Be very careful when constructing WHERE clauses to avoid unintended modifications or deletions.
   - Data Integrity: Think about how constraints (like `NOT NULL`) affect data manipulation. For example, you wouldn't be able to insert a record without values for FirstName and LastName if those columns have a NOT NULL constraint.
   - SQL Syntax: Double-check the syntax for your specific SQL database system.
   - Transactions: For more complex operations, you might want to use transactions to ensure data consistency. Transactions allow you to group multiple SQL statements together and either commit them all at once or roll them back if an error occurs.
   - Select Statements: After performing these operations, use `SELECT * FROM Students;` to view the contents of the table and verify the changes. This is a good way to check your work.
      
   **Step-by-Step Instructions:**

   1. Setting up the Environment
      - Ensure you have a SQL database management system installed and that you've connected to the `UniversityDB` database (created in Problem 1) and created the `Students` table (created in Problem 2).
      - If you haven't already, execute the `create_and_use_db.sql` script from the previous exercise to create and select the `UniversityDB` database. This ensures your new table is created in the correct database.
      - Create the two SQL files as shown in the folder structure above within the `university_db` directory.
      
   2. `insert_students.sql` (Insert Students Table):
      - Open `insert_students`.sql in a text editor.
      - Create the Database:
      ```SQL
      -- Step 1: Insert student records into the Students table
      INSERT INTO Students (FirstName, LastName, EnrollmentDate, Email)  -- StudentID is auto-incremented
      VALUES
      ('Alice', 'Smith', '2023-09-01', 'alice.smith@example.com'),
      ('Bob', 'Johnson', '2023-09-01', 'bob.johnson@example.com'),
      ('Charlie', 'Lee', '2023-09-01', 'charlie.lee@example.com');
      
      -- Alternative (if StudentID is NOT auto-incremented and you manage the IDs yourself):
      -- INSERT INTO Students (StudentID, FirstName, LastName, EnrollmentDate, Email)
      -- VALUES
      --     (1, 'Alice', 'Smith', '2023-09-01', 'alice.smith@example.com'),
      --     (2, 'Bob', 'Johnson', '2023-09-01', 'bob.johnson@example.com'),
      --     (3, 'Charlie', 'Lee', '2023-09-01', 'charlie.lee@example.com');
      ```
      
      - Important Note: Because `StudentID` is (or should be) an auto-incrementing primary key, you generally should not include it in the `INSERT` statement's column list. The database will automatically assign the next available ID. The alternative example is only provided for the rare case that you are managing the primary keys yourself.

      - Save the `insert_students.sql` file.
      
   3. `update_student_email.sql` (Update Student Email):
      - Open `update_student_email.sql` in a text editor.
      - Update Bob Johnson's email:
      ```SQL
      -- Step 2: Update the Email for Bob Johnson
      UPDATE Students
      SET Email = 'bob.j@example.com'
      WHERE FirstName = 'Bob' AND LastName = 'Johnson';  -- More robust WHERE clause
      
      -- Alternative using StudentID (preferred if you know the ID):
      -- UPDATE Students
      -- SET Email = 'bob.j@example.com'
      -- WHERE StudentID = 2;  -- Replace 2 with Bob's actual StudentID
      ```
      - Important Note: It's generally better practice to use the `StudentID` in the `WHERE` clause of an `UPDATE` statement if you know it. This is because it is the primary key and is guaranteed to be unique. Using other columns (like FirstName and LastName) might accidentally update multiple rows if there are duplicate names.
      - Save the `update_student_email.sql` file.

   4. `delete_student.sql` (Delete Student):
      - Open `delete_student.sql` in a text editor.
      - Delete Charlie Lee's record:
      ```SQL
      -- Step 3: Delete the record for Charlie Lee
      DELETE FROM Students
      WHERE FirstName = 'Charlie' AND LastName = 'Lee'; -- More robust WHERE clause
      
      -- Alternative using StudentID (preferred if you know the ID):
      -- DELETE FROM Students
      -- WHERE StudentID = 3;  -- Replace 3 with Charlie's actual StudentID
      ```
      - Important Note: Similar to the `UPDATE` statement, it's best practice to use the `StudentID` in the `WHERE` clause of a `DELETE` statement to ensure you're deleting the correct record.
      - Save the `delete_student.sql` file.
   
   5. Executing the SQL Scripts:
   - Open your SQL client and connect to the UniversityDB database.
   - Insert Records: Execute the insert_students.sql script.
   - Update Email: Execute the update_student_email.sql script.
   - Delete Record: Execute the delete_student.sql script.

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
   git commit -m "Submitting ADVDBMS Week 02 - Session 01 - Exercise 03"
   ```
   
4. Push your changes to GitHub:
   Upload your changes to your remote repository:
   
   ```bash
   git push origin main
   ```
