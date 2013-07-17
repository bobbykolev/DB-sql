--01.Write a SQL query to find the names and salaries of the employees that take 
--the minimal salary in the company. Use a nested SELECT statement.
SELECT e.FirstName + ' ' + e.LastName AS [Employee Name], e.Salary
	FROM Employees e
	WHERE Salary = (
		SELECT MIN(e.Salary) 
		FROM Employees e)
	ORDER BY e.FirstName

--02.Write a SQL query to find the names and salaries of the employees that have a salary 
--that is up to 10% higher than the minimal salary for the company.
SELECT e.FirstName + ' ' + e.LastName AS [Employee Name], e.Salary
	FROM Employees e
	WHERE Salary <= 1.1*(
		SELECT MIN(e.Salary) 
		FROM Employees e)
	ORDER BY e.FirstName

--03.Write a SQL query to find the full name, salary and department of the employees 
--that take the minimal salary in their department. Use a nested SELECT statement.
SELECT e.FirstName + ' ' + e.LastName AS [Employee Name], e.Salary, d.Name
	FROM Employees e, Departments d
	WHERE Salary = (
		SELECT MIN(e.Salary) 
		FROM Employees e
		WHERE e.DepartmentID = d.DepartmentID)
	ORDER BY e.Salary

--04.Write a SQL query to find the average salary in the department #1.
SELECT AVG(Salary) AS [AVG Selary Of Engineers]
	FROM Employees e ,Departments d
	WHERE e.DepartmentID = d.DepartmentID 
			AND e.DepartmentID = 1

--05.Write a SQL query to find the average salary  in the "Sales" department.
SELECT AVG(e.Salary) AS [AVG Selary Of "Sales"]
	FROM Employees e, Departments d
	WHERE e.DepartmentID = d.DepartmentID 
			AND d.Name = 'Sales'

--06.Write a SQL query to find the number of employees in the 
--"Sales" department.
SELECT COUNT(*) AS [Employees In The Sales Department]
	FROM Employees e , Departments d 
	WHERE e.DepartmentID = d.DepartmentID 
			AND d.Name = 'Sales'

--07.Write a SQL query to find the number of all employees that have manager.
SELECT COUNT(*) AS [Employees That Have Manager]
	FROM Employees 
	WHERE ManagerID IS NOT NULL

--08.Write a SQL query to find the number of all employees that have no manager.
SELECT COUNT(*) AS [Employees That Have Manager]
	FROM Employees 
	WHERE ManagerID IS NULL

--09.Write a SQL query to find all departments and the average salary 
--for each of them.
SELECT DepartmentID AS [Department Name], AVG(Salary) AS [AVG Salary]
	FROM Employees 
	GROUP BY DepartmentID

--10.Write a SQL query to find the count of all employees in each department 
--and for each town.
SELECT  COUNT(*) AS [Employees Count], DepartmentID, t.Name AS [Town]
FROM Employees e
        JOIN Addresses a
        ON a.AddressID = e.AddressID
        JOIN Towns t
        ON a.TownID = t.TownID
GROUP BY e.DepartmentID, t.Name
ORDER BY e.DepartmentID 

--11.Write a SQL query to find all managers that have exactly 5 employees. 
--Display their first name and last name.
SELECT e.FirstName+' '+e.LastName AS [Manager Name], e.EmployeeID
	FROM Employees e, Employees m
	WHERE e.EmployeeID = m.ManagerID
	GROUP BY e.ManagerID, e.FirstName, e.LastName, e.EmployeeID
	HAVING COUNT(*)=5

--12.Write a SQL query to find all employees along with their managers. 
--For employees that do not have manager display the value "(no manager)".
SELECT e.FirstName+' '+e.LastName AS [Employee Name], COALESCE(m.FirstName+' '+m.LastName, '(no manager)') AS [Manager Name]
	FROM Employees e
	LEFT JOIN Employees m
	ON e.ManagerId = m.EmployeeId;

--13.Write a SQL query to find the names of all employees whose last name 
--is exactly 5 characters long. Use the built-in LEN(str) function.
SELECT LastName
	FROM Employees
	WHERE LEN(LastName)=5

--14.Write a SQL query to display the current date and time in the following 
--format "day.month.year hour:minutes:seconds:milliseconds". 
--Search in  Google to find how to format dates in SQL Server.
SELECT FORMAT(GETDATE(), 'dd.MM.yyyy HH:mm:ss:fff') [Date Time Now]

--15.Write a SQL statement to create a table Users. Users should have username, 
--password, full name and last login time. Choose appropriate data types for the 
--table fields. Define a primary key column with a primary key constraint. 
--Define the primary key column as identity to facilitate inserting records. 
--Define unique constraint to avoid repeating usernames. 
--Define a check constraint to ensure the password is at least 5 characters long.
CREATE TABLE Users
        (
                UserID INT PRIMARY KEY IDENTITY(1,1) NOT NULL,
                Username nvarchar(20) UNIQUE NOT NULL,
                [Password] nvarchar(20) CHECK(LEN([Password]) > 5) NOT NULL,
                Fullname nvarchar(50) NOT NULL,
                LastLogin datetime
        )

--16.Write a SQL statement to create a view that displays the users from theUsers 
--table that have been in the system today. Test if the view works correctly.
CREATE VIEW RecentUsers
AS
	SELECT Username, DAY(GETDATE() - LastLogin) AS DayDifference
	FROM Users
	WHERE DAY(GETDATE() - LastLogin) = 1

--17.Write a SQL statement to create a table Groups. Groups should have unique
--name (use unique constraint). Define primary key and identity column.
CREATE TABLE Groups
		(
			GroupID int PRIMARY KEY IDENTITY(1,1) NOT NULL,
			Name nvarchar(30) UNIQUE NOT NULL,
		)	
		
--18.Write a SQL statement to add a column GroupID to the table Users. 
--Fill some data in this new column and as well in the Groups table. 
--Write a SQL statement to add a foreign key constraint between tables 
--Users and Groups tables.
ALTER TABLE Users
ADD GroupID INT FOREIGN KEY REFERENCES Groups(GroupID);

--19.Write SQL statements to insert several records in the Users and Groups tables.
INSERT INTO Groups
VALUES('first group')
 
INSERT INTO Groups
VALUES('second group')
 
INSERT INTO Groups
VALUES('Administrators')
 
INSERT INTO Users
VALUES
        ('user', 'password', 'First User', GETDATE(), 2),
        ('user2', 'password2', 'Second User', GETDATE(), 1),

-- 20.Write SQL statements to update some of the records in the Users and Groups tables.
UPDATE Users
SET Username = 'user1', Password = 'password1'
FROM Users
WHERE Username = 'user'

UPDATE Groups
SET Name = 'the group'
FROM Groups
WHERE GroupID = 1

-- 21. Write SQL statements to delete some of the records from the Users and Groups tables.
BEGIN TRAN
DELETE FROM Users
WHERE Username = 'user2'
ROLLBACK TRAN

-- 22.Write SQL statements to insert in the Users table the names of all
-- employees from the Employees table. Combine the first and last names as a
-- full name. For username use the first letter of the first name + the
-- last name (in lowercase). Use the same for the password, and NULL for
-- last login time.

INSERT INTO Users(Username, [Password], Fullname, GroupID)
SELECT  LOWER(LEFT(FirstName,1)+LastName),
                LOWER(LEFT(FirstName,1)+LastName),
                FirstName+' ' + LastName,
                1
FROM Employees

-- 23.Write a SQL statement that changes the password to NULL for
-- all users that have not been in the system since 10.03.2010.
 UPDATE Users
SET [Password] = NULL
FROM Users
WHERE   LastLogin < CONVERT(datetime, '10-03-2010')
               
-- 24.Write a SQL statement that deletes all users without
-- passwords (NULL password).
 
BEGIN TRAN
DELETE FROM Users
WHERE [Password] IS NULL
 
ROLLBACK TRAN

-- 25.Write a SQL query to display the average employee salary by
-- department and job title.
SELECT DepartmentID, AVG(e.salary) AS [AVG Salary], e.JobTitle 
	FROM Employees e
	GROUP BY DepartmentID, JobTitle, Salary
	ORDER BY Salary DESC

-- 26.Write a SQL query to display the minimal employee salary by
-- department and job title along with the name of some of the
-- employees that take it.
SELECT e.FirstName+' '+e.LastName AS [Employee Name], DepartmentID, AVG(e.salary) AS [AVG Salary], e.JobTitle 
	FROM Employees e
	GROUP BY DepartmentID, e.FirstName, e.LastName,  JobTitle, Salary
	ORDER BY Salary DESC

-- 27.Write a SQL query to display the town where
-- maximal number of employees work.
SELECT TOP(1) t.Name AS Town, COUNT(e.EmployeeID) AS [Employees Count]
FROM Towns t
        JOIN Addresses a
        ON t.TownID = a.TownID
        JOIN Employees e
        ON e.AddressID = a.AddressID
GROUP BY t.Name
ORDER BY [Employees Count] DESC

-- 28.Write a SQL query to display the number of managers from each town.
SELECT t.Name AS Town, COUNT(DISTINCT m.ManagerID) AS [Managers Count]
FROM Towns t
        JOIN Addresses a
        ON t.TownID = a.TownID
        JOIN Employees e
        ON e.AddressID = a.AddressID
		JOIN Employees m
        ON e.EmployeeID = m.ManagerID
GROUP BY t.Name
ORDER BY [Managers Count] DESC

-- 29.Write a SQL to create table WorkHours to store work
-- reports for each employee (employee id, date, task, hours,
-- comments). Don't forget to define  identity, primary key and
-- appropriate foreign key.
-- Issue few SQL statements to insert, update and delete of
-- some data in the table.
-- Define a table WorkHoursLogs to track all changes in the
-- WorkHours table with triggers. For each change keep the old
-- record data, the new record data and the command
-- (insert / update / delete).
 
CREATE TABLE Tasks
                (
                        TaskID INT IDENTITY(1,1) PRIMARY KEY,
                        NAME nvarchar(50) NOT NULL
                )
 
CREATE TABLE WorkHours 
                (
                        WorkHoursID INT IDENTITY(1,1) PRIMARY KEY,
                        EmployeeID INT FOREIGN KEY(EmployeeID) REFERENCES Employees(EmployeeID) NOT NULL,
                        [DATE] datetime NOT NULL,
                        TaskID INT FOREIGN KEY(TaskID) REFERENCES Tasks(TaskID) NOT NULL,
                        [Hours] INT NULL,
                        Comments nvarchar(250) NULL,
                )
 
INSERT INTO WorkHours
        VALUES(8, '2013-07-12', 1, NULL, NULL)

--30.Start a database transaction, delete all employees from the 'Sales'
--department along with all dependent records from the other tables. At the
--end rollback the transaction.

BEGIN TRAN
	ALTER TABLE EmployeesProjects
	ADD CONSTRAINT FK_CASCADE_1 FOREIGN KEY (EmployeeID)
	REFERENCES Employees (EmployeeID)
	ON DELETE CASCADE;

	ALTER TABLE Departments
	ADD CONSTRAINT FK_CASCADE_2 FOREIGN KEY (ManagerId)
	REFERENCES Employees (EmployeeID)
	ON DELETE SET NULL;

	DELETE FROM Employees 
	WHERE DepartmentId IN (SELECT DepartmentId FROM Departments WHERE Name = 'Sales')

	ROLLBACK TRAN
GO

--31.Start a database transaction and drop the table EmployeesProjects. Now
--how you could restore back the lost table data?

BEGIN TRAN
	CREATE DATABASE TelerikAcademy_snapshot1900 
	ON (NAME = TelerikAcademy_Data, FILENAME = 'TelerikAcademy_snapshot1900.ss')
	AS SNAPSHOT OF TelerikAcademy;

	DROP TABLE EmployeesProjects
	-- ROLLBACK TRAN
GO

BEGIN TRAN
	ALTER DATABASE TelerikAcademy
	SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

	USE master;
	RESTORE DATABASE TeleikAcademy FROM DATABASE_SNAPSHOT = 'TelerikAcademy_snapshot1900';
GO

-- 32 Find how to use temporary tables in SQL Server. Using temporary tables
-- backup all records from EmployeesProjects and restore them back after
-- dropping and re-creating the table.

BEGIN TRAN
	SELECT * INTO #TempEmployeesProjects 
	FROM EmployeesProjects;

	DROP TABLE EmployeesProjects;

	SELECT * INTO EmployeesProjects
	FROM #TempEmployeesProjects;

	DROP TABLE #TempEmployeesProjects
GO