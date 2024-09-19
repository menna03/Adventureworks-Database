SELECT *
  FROM [dimension].[EmployeeDepartmentHistory]

select * from  [dimension].[EmployeeDepartmentHistory]
where [BusinessEntityID] = 200


select convert(int,max([Timestamp])) from [dimension].[EmployeeDepartmentHistory] --76319

DELETE FROM [dimension].[EmployeeDepartmentHistory] WHERE [EmployeeID]=302;

ALTER table [dimension].[EmployeeDepartmentHistory] add  scd_startdate datetime default current_timestamp;
ALTER table [dimension].[EmployeeDepartmentHistory] add  scd_enddate datetime default null;


select current_timestamp;

 
