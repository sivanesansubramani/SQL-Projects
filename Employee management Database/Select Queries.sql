use EmployeeManagement;

select * from Employee_M;
select * from Destination_M;
select * from Salary_M;

--Count of male and female employees
select Gender,Count(*) as 'GenderCount' from Employee_M group by Gender;

--select each destination count
select count(*) as 'DestinationCount',Destinationname from Destination_M group by Destinationname;

--employee Destination count
select Count(*),Destinationname from Destination_M Group By Destinationname;

--highest and lowest level of employee detination count
select Top 3 Count(*) As Countof,DestinationName from Destination_M Group By DestinationName Order By Countof desc;
select Top 3 Count(*) As Countof,DestinationName from Destination_M Group By DestinationName Order By Countof;

--select highest third aged employee from employee table
SELECT TOP 1 *
FROM (
    SELECT DISTINCT TOP 3 *
    FROM Employee_M
    ORDER BY DOB DESC
) AS Subquery
ORDER BY DOB ASC;

--inner join with where , IN , NOT IN , Between
--NOT IN
select R.Name,R.Email,R.Email,P.Destinationname
from Employee_M R 
inner Join Destination_M P on R.empid = P.Empid_fk And P.Destinationname Not In ('HR');
--IN
--
select R.Name,R.Email,R.Email,P.Destinationname
from Employee_M R 
inner Join Destination_M P on R.empid = P.Empid_fk And P.Destinationname In ('HR','Manager');
--WHERE Equal to
--
select R.Name,R.Email,R.Email,P.Destinationname
from Employee_M R 
inner Join Destination_M P on R.empid = P.Empid_fk Where P.Destinationname = 'HR';
--WHERE Not Equal to
--
select R.Name,R.Email,R.Email,P.Destinationname
from Employee_M R 
inner Join Destination_M P on R.empid = P.Empid_fk Where P.Destinationname != 'HR';
--Between
--
select R.EmpID,R.Name,R.Email,R.Email,P.Destinationname
from Employee_M R 
inner Join Destination_M P on R.empid = P.Empid_fk Where R.Empid between 1 AND 2 or  R.Empid between 6 and 7;


--destination count with gender count
select count(*) as 'DestinationCount',Destinationname,'Female' as Gender from Destination_M as t1 inner join
Employee_M as t2 on t1.Empid_fk = t2.empid  where t2.gender = 'F'
group by Destinationname
union
select count(*) as 'DestinationCount',Destinationname,'Male' as Gender from Destination_M as t1 inner join
Employee_M as t2 on t1.Empid_fk = t2.empid  where t2.gender = 'M'
group by Destinationname; 

-- reduce 5 % percentage tax for each employye and show balance data
select salaryid,Empid_fk,salary,Salary * (100 - 5) / 100 AS Balance from Salary_M;

select t1.Name,t2.Destinationname,t3.salary,Salary * (100 - 5) / 100 AS Balance
from Employee_M as t1 inner join Destination_M as t2 on t1.EmpId = t2.Empid_fk inner join 
Salary_M as t3 on t2.Empid_fk = t3.Empid_fk;

--select top aged and low aged Employees
select top 1 * from Employee_M order by DOB asc;
select top 1 * from Employee_M order by DOB desc;

--each employee full data with three table join
select * from Employee_M as t1 inner join Destination_M as t2 on t1.EmpId = t2.Empid_fk inner join 
Salary_M as t3 on t2.Empid_fk = t3.Empid_fk;

--each destination total salary for one month
select t2.Destinationname,sum(t3.Salary) as 'Monthly_Salary' from Employee_M as t1 inner join Destination_M as t2 on t1.EmpId = t2.Empid_fk inner join 
Salary_M as t3 on t2.Empid_fk = t3.Empid_fk group by t2.Destinationname;

--each destination Average salary for one month
select t2.Destinationname,AVG(t3.Salary) as 'Monthly_Salary' from Employee_M as t1 inner join Destination_M as t2 on t1.EmpId = t2.Empid_fk inner join 
Salary_M as t3 on t2.Empid_fk = t3.Empid_fk group by t2.Destinationname;

--calculate anaul salary of each employee
select t1.Name,t2.Destinationname,t3.salary,t3.salary * 12 as 'Anual Salary'
from Employee_M as t1 inner join Destination_M as t2 on t1.EmpId = t2.Empid_fk inner join 
Salary_M as t3 on t2.Empid_fk = t3.Empid_fk;

--high salary employee in each department
select MAX(salary) from Salary_M;

select t2.Destinationname,MAX(t3.salary)
from Salary_M as t3 inner join Destination_M as t2 on t3.EmpId_fk = t2.Empid_fk 
group by t2.Destinationname;

SELECT t1.Name, t2.Destinationname, t3.Salary
FROM Employee_M AS t1
INNER JOIN Destination_M AS t2 ON t1.EmpId = t2.EmpId_FK
INNER JOIN Salary_M AS t3 ON t1.EmpId = t3.EmpId_FK
WHERE t3.Salary = (
    SELECT MAX(Salary)
    FROM Salary_M AS sm
    INNER JOIN Destination_M AS dm ON sm.EmpId_FK = dm.EmpId_FK
    WHERE dm.Destinationname = t2.Destinationname
);


-- select employee celeberiting birthday today with their age
select EmpId,Name,PhoneNumber,Email,Gender,DOB,
    DATEDIFF(YEAR, DOB, GETDATE()) - 
        CASE 
            WHEN MONTH(DOB) > MONTH(GETDATE()) 
                 OR (MONTH(DOB) = MONTH(GETDATE()) AND DAY(DOB) > DAY(GETDATE())) 
            THEN 1 
            ELSE 0 
        END AS Age
from Employee_M WHERE DATEPART(DD, DOB) = DATEPART(DD, GETDATE()) AND DATEPART(MM, DOB) = DATEPART(MM, GETDATE());

--allow hr and manager to access some informations
select e1.*,d1.Destinationname,
case when d1.Destinationname = 'HR' OR d1.Destinationname = 'Manager' Then 'Allow'
else 'Not Allow'
end as 'Credientials'
from Employee_M as e1 inner join Destination_M as d1 on e1.EmpId = d1.EmpId_FK;

--how many can and can not access
SELECT 
    SUM(CASE WHEN d1.Destinationname = 'HR' OR d1.Destinationname = 'Manager' THEN 1 ELSE 0 END) AS AllowCount,
    SUM(CASE WHEN d1.Destinationname <> 'HR' AND d1.Destinationname <> 'Manager' THEN 1 ELSE 0 END) AS NotAllowCount
FROM 
    Employee_M AS e1
INNER JOIN 
    Destination_M AS d1 
ON 
    e1.EmpId = d1.EmpId_FK;

--how many days employees has been employed in this company
select e1.*,d1.Destinationname,d1.Emp_Date,
    DATEDIFF(YEAR, Emp_Date, GETDATE()) - 
        CASE 
            WHEN MONTH(Emp_Date) > MONTH(GETDATE()) 
                 OR (MONTH(Emp_Date) = MONTH(GETDATE()) AND DAY(Emp_Date) > DAY(GETDATE())) 
            THEN 1 
            ELSE 0 
        END AS Employeement_Years,
		    DATEDIFF(DAY, Emp_Date, GETDATE()) - 
        CASE 
            WHEN MONTH(Emp_Date) > MONTH(GETDATE()) 
                 OR (MONTH(Emp_Date) = MONTH(GETDATE()) AND DAY(Emp_Date) > DAY(GETDATE())) 
            THEN 1 
            ELSE 0 
        END AS Employeement_Days,
		DATEDIFF(MONTH, Emp_Date, GETDATE()) - 
        CASE 
            WHEN MONTH(Emp_Date) > MONTH(GETDATE()) 
                 OR (MONTH(Emp_Date) = MONTH(GETDATE()) AND DAY(Emp_Date) > DAY(GETDATE())) 
            THEN 1 
            ELSE 0 
        END AS Employeement_Months
from Employee_M as e1 inner join Destination_M as d1 on e1.EmpId = d1.EmpId_FK;

--Accessiability based on roled
select R.Name,R.Email,R.Email,P.Destinationname, 
Case
When P.Destinationname = 'HR' Then 'Allow'
When p.Destinationname = 'Manager' Then 'Not Allow'
Else 'You want to get Permision'
End As Eligibility
from Employee_M R 
inner Join Destination_M P on R.EmpId = P.EmpId_fk;