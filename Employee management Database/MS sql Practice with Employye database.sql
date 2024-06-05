-- create a database
Create Database EmployeeManagement;
--use created database
use EmployeeManagement;

--create Database Backup
Backup database EmployeeManagement to disk = 'F:\TestDB_Full.bak'

--Employee master table for storing employee details
 --identity(1,1) , the first 1 means the starting value of ID and the second 1 means the increment value of ID
CREATE TABLE Employee_M (
    EmpId INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(255),
    PhoneNumber VARCHAR(20),
    Email VARCHAR(255) unique,
    Gender CHAR(1),
    DOB DATE
);  

--destination master table
CREATE TABLE Destination_M (
    DestinationId int NOT NULL PRIMARY KEY IDENTITY(2,2),
    Destinationname varchar(150) NOT NULL,
	Emp_Date date not null,
    EmpId_FK int FOREIGN KEY REFERENCES Employee_M(EmpId)
);


--salary master table
create table Salary_M(
SalaryId int not null PRIMARY KEY IDENTITY(1,1),
EmpId_FK int Foreign Key REFERENCES Employee_M(EmpId),
Salary Money Not null,
);



select * from Employee_M;
select * from Destination_M;
select * from Salary_M;

insert into Salary_M values (1,15000);
insert into Salary_M values (2,25000);
insert into Salary_M values (3,18000);
insert into Salary_M values (4,30000);
insert into Salary_M values (5,50000);
insert into Salary_M values (6,15000);
insert into Salary_M values (7,25000);
insert into Salary_M values (8,32000);
insert into Salary_M values (9,25000);
insert into Salary_M values (10,15000);
insert into Salary_M values (11,40000);
insert into Salary_M values (12,30000);
insert into Salary_M values (13,20000);
insert into Salary_M values (14,15000);
insert into Salary_M values (15,13000);
insert into Salary_M values (16,17000);


insert into Destination_M values ('HR','2000-12-03',1);
insert into Destination_M values ('Manager','2001-11-03',2);
insert into Destination_M values ('Developer','2000-02-03',3);
insert into Destination_M values ('Developer','2002-05-03',4);
insert into Destination_M values ('Developer','2004-07-03',5);
insert into Destination_M values ('Manager','2001-03-03',6);
insert into Destination_M values ('HR','2000-11-03',7);
insert into Destination_M values ('Developer','2005-04-03',8);
insert into Destination_M values ('Developer','2001-03-03',9);
insert into Destination_M values ('Manager','2004-08-03',10);
insert into Destination_M values ('HR','2000-09-03',11);
insert into Destination_M values ('Developer','2003-04-03',12);
insert into Destination_M values ('Developer','2002-09-03',13);
insert into Destination_M values ('Manager','2006-10-03',14);
insert into Destination_M values ('HR','2002-01-03',15);
insert into Destination_M values ('Junior Developer','2002-01-03',16);

INSERT INTO Employee_M (Name, PhoneNumber, Email, Gender, DOB)
VALUES 
    ('John Doe', '123-456-7890', 'john.doe@example.com', 'M', '1990-01-01'),
    ('Jane Smith', '987-654-3210', 'jane.smith@example.com', 'F', '1985-05-15'),
    ('Michael Johnson', '555-555-5555', 'michael.johnson@example.com', 'M', '1982-10-25'),
    ('Emily Davis', '111-222-3333', 'emily.davis@example.com', 'F', '1995-03-12'),
    ('Christopher Brown', '333-333-3333', 'chris.brown@example.com', 'M', '1988-07-19'),
    ('Amanda Wilson', '444-444-4444', 'amanda.wilson@example.com', 'F', '1992-09-08'),
    ('James Taylor', '666-666-6666', 'james.taylor@example.com', 'M', '1978-12-03'),
    ('Olivia Martinez', '777-777-7777', 'olivia.martinez@example.com', 'F', '1980-06-28'),
    ('David Anderson', '999-999-9999', 'david.anderson@example.com', 'M', '1993-11-14'),
    ('Sophia Hernandez', '888-888-8888', 'sophia.hernandez@example.com', 'F', '1987-04-07'),
    ('Matthew Lopez', '123-987-4567', 'matthew.lopez@example.com', 'M', '1984-08-22'),
    ('Emma Gonzalez', '555-123-4567', 'emma.gonzalez@example.com', 'F', '1998-02-17'),
    ('Daniel Perez', '111-333-5555', 'daniel.perez@example.com', 'M', '1991-05-30'),
    ('Isabella Sanchez', '777-222-3333', 'isabella.sanchez@example.com', 'F', '1986-09-10'),
    ('Alexander Smith', '999-777-5555', 'alexander.smith@example.com', 'M', '1983-12-18');
INSERT INTO Employee_M (Name, PhoneNumber, Email, Gender, DOB)
VALUES 
    ('Siva S', '951-237-4258', 'siva.s@example.com', 'M', '1995-06-05');

