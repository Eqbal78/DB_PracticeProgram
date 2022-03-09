-- Create a database
create database DB_Practice

-- View database name
use DB_Practice

-- Create table in the database
create table Employee
(
Emp_ID int identity(1,1) primary key,
Emp_Name varchar(25) not null,
Emp_Address varchar(60) not null,
Emp_PhoneNumber int,
Emp_Salary money
)

-- View AddressBook table
select * from Employee

-- Drop table
drop table Employee

-- Create table in the database
create table Employee_Details
(
Emp_ID int identity(1,1) primary key,
FirstName varchar(25) not null,
LastName varchar(25) not null,
Address varchar(60) not null,
PhoneNumber varchar(12) not null,
Salary money
)

-- Inserting data in table
insert into Employee_Details values
('Tony','Stark','Stark Tower 59th Street Broadway, NewYork','8987224534',900000),
('Steve','Rogers','Times Square, Texas','9876778434',660000),
('Bruce','Banner','Vandalia ,Greater Dayton','5478964265',880000),
('Peter','Parker','20 Ingram Street, Forest Hills, Queens, NewYork City','4013224355',760000),
('Stephen','Strange','177A Bleecker Street, Greenwich Village, Manhattan, NewYork','6300964579',840000),
('Thor','Odinson','RoyalPalace, Asgard, Florida','7849876734',950000)

-- View table
select * from Employee_Details

-- Edit existing contact using persons's name
update Employee_Details
set PhoneNumber = '7654567885',Salary='820000' where FirstName = 'Bruce'

-- Delete data
delete Employee_Details
where Emp_ID = 4;

-- Add Extra columns
alter table Employee_Details add Email varchar(25)

update Employee_Details set Email = 'ironman@gmail.com' where Emp_ID = 1
update Employee_Details set Email = 'captainAmerica@yahoo.com' where Emp_ID = 2
update Employee_Details set Email = 'incredibleHulk@gmail.com' where Emp_ID = 3
update Employee_Details set Email = 'drStrange@yahoo.com' where Emp_ID = 5
update Employee_Details set Email = 'thor@rediffmail.com' where Emp_ID = 6

insert into Employee_Details values
('Natasha','Romanoff','Broadway street, NewYork Cit','45667365277','940000','blackwidow@gmail.com')

update Employee_Details set Email = 'blackwidow@yahoo.com' where Emp_ID = 7

delete from Employee_Details where Emp_ID = 7

-- Rename the Column name
alter table Employee_Details rename column 'Email' to 'Email_ID'

-- Remove the record into the table
truncate table Employee_Details


----Foreign Key And Primary Key------

create table Company
(
	Comp_ID int identity(1,1) PRIMARY KEY,
    Comp_Name varchar(45) not null,
	Comp_City varchar(25) not null,
    Emp_ID int not null,
    FOREIGN KEY (Emp_ID) REFERENCES Employee_Details(Emp_ID)
)

insert into Company(Comp_Name,Comp_City,Emp_ID) values
	('HCL','Mumbai',2),
	('Wipro','Bangalore',3),
	('Infosys','Pune',5),
	('Wipro','Pune',5),
	('TCS','Bangalore',6),
	('Mindtree','Hyderabad',3),
	('TCS','Mumbai',6)

select * from Company

select * from Employee_Details 
where Emp_ID IN (select Emp_ID from Company where Comp_Name = 'Wipro' OR Comp_City = 'Mumbai')


---------Check and Unique Constraint---------------

create table Persons (
    Person_ID int NOT NULL,
    Name varchar(255) NOT NULL,
    Age int CHECK (Age>=18),
	PhoneNumber int UNIQUE
)

insert into Persons(Person_ID,Name,Age,PhoneNumber) values
(101,'Tony Stark',45,987654321)

insert into Persons(Person_ID,Name,Age,PhoneNumber) values
(102,'Thor',85,985421024),
(103,'Steve Roger',65,85102412),
(104,'Bruce Banner',42,6542102454)

select * from Persons

/* Error Age is less then 18

insert into Persons(Person_ID,Name,Age,PhoneNumber) values
(101,'Petter Parker',15,987654321)

  Error Phone Number is Unique, not Same

 insert into Persons(Person_ID,Name,Age,PhoneNumber) values
(101,'Petter Parker',25,987654321) 

*/

------ Having, Group By, Union and Order By Clause-------------

select COUNT(Comp_ID) AS Comman_ID,Comp_City
from Company
GROUP BY Comp_City
HAVING COUNT(Comp_ID) >= 1;

Select * from Company ORDER BY (Comp_ID) DESC

alter table Persons add Comp_Name varchar(25)

update Persons set Comp_Name = 'Mumbai' where Person_ID = 101
update Persons set Comp_Name = 'Pune' where Person_ID = 102
update Persons set Comp_Name = 'Bangalore' where Person_ID = 103
update Persons set Comp_Name = 'Hyderabad' where Person_ID = 104

select Comp_Name from Company
UNION ALL
Select Comp_Name from Persons
ORDER BY Comp_Name