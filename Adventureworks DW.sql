-- Drop tables if they exist
DROP TABLE IF EXISTS dimension.Personal_information;
DROP TABLE IF EXISTS dimension.Employee_Payment;
DROP TABLE IF EXISTS dimension.EmployeeDepartmentHistory;
DROP TABLE IF EXISTS dimension.Shift;
DROP TABLE IF EXISTS fact.Employee;
DROP TABLE IF EXISTS dimension.Department;
DROP TABLE IF EXISTS dimension.Employeelogin;

-- Create dimension table Employeelogin
CREATE TABLE dimension.Employeelogin (
    BusinessEntityID int PRIMARY KEY,
    LoginID nvarchar(256) NOT NULL,
    rowguid uniqueidentifier NOT NULL
);

-- Create dimension table Department
CREATE TABLE dimension.Department (
    DepartmentID smallint PRIMARY KEY,
    Name nvarchar(50) NOT NULL,
    GroupName nvarchar(50) NOT NULL,
    ModifiedDate datetime NOT NULL
);

-- Create dimension table Shift
CREATE TABLE dimension.Shift (
    ShiftID tinyint PRIMARY KEY,
    Name nvarchar(50) NOT NULL,
    StartTime time(7) NOT NULL,
    EndTime time(7) NOT NULL,
    ModifiedDate datetime NOT NULL
);


CREATE TABLE fact.Employee (
    EmployeeID int IDENTITY(1,1) PRIMARY KEY,  -- Surrogate key with auto-increment
    BusinessEntityID int NOT NULL UNIQUE,  -- Natural key
    DepartmentID smallint NOT NULL,
    FOREIGN KEY (BusinessEntityID) REFERENCES dimension.Employeelogin(BusinessEntityID),
    FOREIGN KEY (DepartmentID) REFERENCES dimension.Department(DepartmentID)
);



-- Create dimension table EmployeeDepartmentHistory
CREATE TABLE dimension.EmployeeDepartmentHistory (
	EmployeeID int IDENTITY(1,1) PRIMARY KEY,
    BusinessEntityID int NOT NULL,
    ShiftID tinyint NOT NULL,
    StartDate date NOT NULL,
    EndDate date NULL,
    ModifiedDate datetime NOT NULL,
    JobTitle nvarchar(50) NOT NULL,
    IsCurrent BIT DEFAULT 1,
    Timestamp rowversion,
	 scd_startdate datetime default current_timestamp,
	 scd_enddate datetime default null,
    FOREIGN KEY (BusinessEntityID) REFERENCES fact.Employee(BusinessEntityID),
    FOREIGN KEY (ShiftID) REFERENCES dimension.Shift(ShiftID)
);

-- Create dimension table Employee_Payment
CREATE TABLE dimension.Employee_Payment (
    BusinessEntityID int NOT NULL,
    RateChangeDate datetime NOT NULL,
    Salary_hourly_rate money NOT NULL,
    Salary_received_monthly bit,
    Salary_received_weekly bit,
    ModifiedDate datetime NULL,
    Inactive bit,
    Active bit,
    Hourly bit,
    Salaried bit,
    PRIMARY KEY (BusinessEntityID, RateChangeDate),
    FOREIGN KEY (BusinessEntityID) REFERENCES fact.Employee(BusinessEntityID)
);

-- Create dimension table Personal_information
CREATE TABLE dimension.Personal_information (
    BusinessEntityID int NOT NULL,
    NationalIDNumber nvarchar(15) NOT NULL,
    BirthDate date NOT NULL,
    MaritalStatus nchar(1) NOT NULL,
    Gender nchar(1) NOT NULL,
    HireDate date NOT NULL,
    VacationHours smallint NOT NULL,
    SickLeaveHours smallint NOT NULL,
    Resume xml NULL,
    employee_location_in_corporate_hierarchy hierarchyid NULL,
    employee_depth_in_corporate_hierarchy int,
    PRIMARY KEY (BusinessEntityID),
    FOREIGN KEY (BusinessEntityID) REFERENCES fact.Employee(BusinessEntityID)
);


ALTER TABLE [dimension].[EmployeeDepartmentHistory]
ADD [Timestamp] rowversion;

ALTER TABLE [AdventureWorks2019].[HumanResources].[EmployeeDepartmentHistory]
ADD [Timestamp] rowversion;

ALTER TABLE [AdventureWorks2019].[HumanResources].[Employee]
ADD [Timestamp] rowversion;

ALTER TABLE [dimension].[Employee_Payment]
ADD [Previous_Salary_hourly_rate] DECIMAL(18, 2);


ALTER TABLE [dimension].[EmployeeDepartmentHistory]
ADD LoadTimestamp datetime default current_timestamp;
