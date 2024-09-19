SELECT TOP (1000) [BusinessEntityID]
      ,[DepartmentID]
      ,[ShiftID]
      ,[StartDate]
      ,[EndDate]
      ,[ModifiedDate]
      ,[Timestamp]
  FROM [AdventureWorks2019].[HumanResources].[EmployeeDepartmentHistory]

select convert(int,max([Timestamp])) from  [AdventureWorks2019].[HumanResources].[EmployeeDepartmentHistory]-- 188935

select * from  [AdventureWorks2019].[HumanResources].[EmployeeDepartmentHistory]
where [BusinessEntityID] = 200

UPDATE [AdventureWorks2019].[HumanResources].[EmployeeDepartmentHistory] -- 188630
SET [DepartmentID] =1, 
    [ShiftID] = 3, 
    [EndDate] = null, 
    [ModifiedDate] = GETDATE()
WHERE [BusinessEntityID] = 200;

 select * from HR.[dimension].[EmployeeDepartmentHistory] where BusinessEntityID=200;