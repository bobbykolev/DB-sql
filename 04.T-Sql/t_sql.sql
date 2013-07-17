--01.Create a database with two tables: Persons(Id(PK), FirstName, LastName, SSN) and Accounts(Id(PK), 
--PersonId(FK), Balance). Insert few records for testing. Write a stored procedure that selects the 
--full names of all persons.
CREATE DATABASE test_db_bank
GO
USE test_db_bank
GO
CREATE TABLE Persons
		(
		PersonID INT IDENTITY PRIMARY KEY NOT NULL, 
		FirstName NVARCHAR(20),
		LastName NVARCHAR(20) NOT NULL,
		SSN NVARCHAR(20) NOT NULL
		)

CREATE TABLE Accounts
		(
		AccountID INT IDENTITY PRIMARY KEY NOT NULL,
		Balance MONEY NOT NULL,
		PersonID INT FOREIGN KEY REFERENCES Persons(PersonID)
		)

INSERT INTO Persons VALUES('John', 'Doe', '123456789')
INSERT INTO Persons VALUES('Jane', 'Doe', '987654321')

INSERT INTO Accounts VALUES(3000, 1)
INSERT INTO Accounts VALUES(2500, 2)

GO

CREATE PROC dbo.usp_SelectFullNames
AS
	SELECT FirstName + ' ' + LastName AS [Full Name]
	FROM Persons
GO

EXEC dbo.usp_SelectFullNames

--02.Create a stored procedure that accepts a number as a parameter and returns all persons who 
--have more money in their accounts than the supplied number.
CREATE PROC dbo.usp_PersonsMoney
@n INT
AS
	SELECT p.FirstName + ' ' + p.LastName AS [Name] 
	FROM Accounts a,Persons p
	WHERE a.PersonID = p.PersonID
	AND a.Balance > @n
	--JOIN Persons p ON a.PersonID = p.PersonID
	--WHERE a.Balance > @n
GO

EXEC dbo.usp_PersonsMoney 2550

--03.Create a function that accepts as parameters – sum, yearly interest rate and number of months.
--It should calculate and return the new sum. Write a SELECT to test whether the function works as expected.
CREATE FUNCTION dbo.ufn_CalculateSum
(@sum INT, 
@yearlyinterestRate INT, 
@months INT)
	RETURNS INT
AS
BEGIN
	RETURN @sum + ((@yearlyinterestRate * @sum) / 100) * @months / 12
END
GO

SELECT dbo.ufn_CalculateSum(3000, 6, 12) AS [New Sum]

--04.Create a stored procedure that uses the function from the previous example to give an interest 
--to a person's account for one month. It should take the AccountId and the interest rate as parameters.
CREATE PROC dbo.usp_NewBalance
@AccountID INT, 
@interestRate INT
AS 
BEGIN
DECLARE @oldBalance MONEY
SET @oldBalance = 
	(
	SELECT Balance FROM Accounts
	WHERE AccountID = @AccountID
	)
	
DECLARE @newBalance MONEY
SET @newBalance = dbo.ufn_CalculateSum(@oldBalance, @interestRate, 1)

UPDATE Accounts
SET Balance = @newBalance
WHERE AccountID = @AccountID
END
GO

EXEC usp_NewBalance 1, 6

--05.Add two more stored procedures WithdrawMoney (AccountId, money) and DepositMoney 
--(AccountId, money) that operate in transactions.
CREATE PROC dbo.usp_WithdrawMoney
@AccountID INT,
@RequestedMoney MONEY
AS
BEGIN TRAN

DECLARE @oldBalance MONEY = 
		(
		SELECT Balance FROM Accounts
		WHERE AccountID = @AccountID 
		)

IF (@oldBalance >= @RequestedMoney)
BEGIN
	UPDATE Accounts
	SET Balance = @oldBalance - @RequestedMoney
	WHERE AccountID = @AccountID
	COMMIT
END
ELSE
BEGIN 
	 RAISERROR ('Not enough money in your account.', 16, 1)
	 ROLLBACK
END
GO

EXEC dbo.usp_WithdrawMoney 1, 500
------------------------------------------------------------
CREATE PROC dbo.usp_DepositMoney
@AccountID INT,
@DepositSum MONEY
AS
BEGIN TRANSACTION

DECLARE @oldBalance MONEY = 
		(
		SELECT Balance FROM Accounts
		WHERE AccountID = @AccountID
		)

IF (@DepositSum > 0)
	BEGIN
		UPDATE Accounts
		SET Balance = @oldBalance + @DepositSum
		WHERE AccountID = @AccountID
	COMMIT
	END
ELSE
BEGIN
	RAISERROR('Deposit sum cant be negative' , 16, 1)
	ROLLBACK
	END
GO

EXEC dbo.usp_DepositMoney 1, 1000

SELECT Balance FROM Accounts WHERE AccountID = 1

--06.Create another table – Logs(LogID, AccountID, OldSum, NewSum). Add a trigger to the Accounts 
--table that enters a new entry into the Logs table every time the sum on an account changes.
CREATE TABLE Logs 
		(
		LogID INT IDENTITY PRIMARY KEY NOT NULL,
		AccountID INT FOREIGN KEY REFERENCES Accounts(AccountID),
		OldSum MONEY NOT NULL,
		NewSum MONEY NOT NULL
		)

CREATE TRIGGER tr_BalanceUpdate ON Accounts FOR UPDATE
AS
	BEGIN
	INSERT INTO Logs
		SELECT i.AccountID,	d.Balance, i.Balance
			FROM deleted d
			JOIN inserted i
			ON i.AccountID = d.AccountID
	END
GO

EXEC dbo.usp_DepositMoney 1, 500
GO

--08,
--09.Write a T-SQL script that shows for each town a list of all employees that live in it. 
USE TelerikAcademy
SELECT t.Name AS [Town], e.FirstName+' '+e.LastName AS Employee
FROM Employees e
        JOIN Addresses a
        ON a.AddressID = e.AddressID
        JOIN Towns t
        ON a.TownID = t.TownID
GROUP BY t.Name, e.FirstName+' '+e.LastName

--10.Define a .NET aggregate function StrConcat that takes as input a sequence of strings and 
--return a single string that consists of the input strings separated by ','.
USE TelerikAcademy
CREATE FUNCTION dbo.ufn_StrConcat
(@firstInput sql_variant, 
@secondInput sql_variant)
	RETURNS nvarchar(200)
AS
BEGIN
	RETURN Convert(nvarchar(200), @firstInput) + ', ' + Convert(nvarchar(200), @secondInput)
END
GO
DECLARE @firstName sql_variant = (SELECT FirstName FROM Employees WHERE EmployeeID='1')
DECLARE @lastName sql_variant = (SELECT LastName FROM Employees WHERE EmployeeID='1')
SELECT dbo.ufn_StrConcat(@firstName, @lastName) AS StrConcat