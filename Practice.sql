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


--------------------------- Foreign Key And Primary Key -------------------------------

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


----------------------------- Check and Unique Constraint --------------------------

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

------------------- Table Leve Unique Constraints ---------------------

create table Persons_Detail (
    Person_ID int NOT NULL,
    Name varchar(255) NOT NULL,
    Age int CHECK (Age>=18),
	PhoneNumber int not null,
	CONSTRAINT UC_Person UNIQUE (Name,PhoneNumber)
)

insert into Persons_Detail(Person_ID,Name,Age,PhoneNumber) values
(1021,'Ram',45,987654321),
(1022,'Sham',85,985421024),
(1023,'Shayam',65,85102412),
(1024,'Ajay',42,654210245)

select * from Persons_Detail

/* Error Age is less then 18

insert into Persons(Person_ID,Name,Age,PhoneNumber) values
(101,'Petter Parker',15,987654321)

  Error Phone Number is Unique, not Same

 insert into Persons(Person_ID,Name,Age,PhoneNumber) values
(101,'Petter Parker',25,987654321) 

*/

----------------------- Having, Group By, Union and Order By Clause -----------------------

select COUNT(Comp_ID) AS Comman_ID,Comp_City
from Company
GROUP BY Comp_City
HAVING COUNT(Comp_ID) >= 1;

select COUNT(Comp_ID) AS Total_Company,Comp_City
from Company where Comp_City = 'Mumbai'
GROUP BY Comp_City

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


------------------------- Sub Query -----------------------------

select * from Company
where Comp_City = (select Comp_Name from Persons where Name = 'Tony Stark')

select * from Employee_Details 
where Emp_ID IN (select Emp_ID from Company where Comp_Name = 'Wipro' or Emp_ID > 3)
 

 ----------------------------- Joins --------------------------------

create table Customers
(
  Customer_ID int identity(1,1) PRIMARY KEY,
  Customer_Name varchar(26) not null,
  Customer_Number int not null,
  Customer_City varchar(45)
)

insert into Customers values
('Tony',787546941,'Pune'),
('Jack',874564896,'Mumbai'),
('Joy',984573045,'Delhi'),
('Roy',863271401,'Hyderabad'),
('Salman',963021457,'Mumbai'),
('Sohail',654781234,'Bangalore')

insert into Customers values
('Jhon',754694104,'Pune')

select * from Customers

create table Order_Details
(
Order_ID int identity(1021,1) PRIMARY KEY,
Customer_ID int not null,
Order_Date date
)

insert into Order_Details values
(2,'2021-03-04'),
(5,'2021-02-25'),
(10,'2021-03-09'),
(1,'2021-02-27'),
(3,'2021-03-01'),
(11,'2021-02-21')

select * from Order_Details

----------------------------- Inner Join ----------------------------

Select * from Order_Details INNER JOIN Customers ON Order_Details.Customer_ID=Customers.Customer_ID

----------------------------- Left Outer Join -----------------------

Select Order_ID, Customer_Name, Order_Date, Customer_City
from Order_Details LEFT JOIN Customers ON Order_Details.Customer_ID=Customers.Customer_ID

Select Order_ID, Customers.Customer_Name, Order_Date, Customer_City
from Order_Details  LEFT JOIN Customers  ON Order_Details.Customer_ID=Customers.Customer_ID where Order_ID > 1023
ORDER BY Customers.Customer_ID

----------------------------- Right Outer Join --------------------------

Select Order_ID, Customer_Name, Order_Date
from Order_Details RIGHT JOIN Customers ON Order_Details.Customer_ID=Customers.Customer_ID

----------------------------- Full Outer Join ----------------------------

Select Order_ID, Customer_Name, Order_Date, Customer_City
from Order_Details FULL OUTER JOIN Customers ON Order_Details.Customer_ID=Customers.Customer_ID

----------------------------- Self Join -----------------------------

select A.Customer_Name AS Customer_Name1, B.Customer_Name AS Customer_Name2, A.Customer_City
from Customers A, Customers B
where A.Customer_ID <> B.Customer_ID
AND A.Customer_City = B.Customer_City
ORDER BY A.Customer_City

select A.Order_ID AS ID, B.Order_Date AS Dates
from Order_Details A, Order_Details B
where A.Order_ID > B.Order_ID

------------------------------- Cross Join -------------------------------------

select Customer_Name, Order_ID
from Customers
CROSS JOIN Order_Details

select Customer_Name, Order_ID
from Customers
CROSS JOIN Order_Details
where Customers.Customer_ID=Order_Details.Customer_ID

----------------------------- Multiple Joins --------------------------------------

create table Delivery
(
 Delivery_ID int identity (101,1) PRIMARY KEY,
 Customer_ID int not null,
 Delivery_Address varchar(255) not null,
 Delivery_Status varchar(25) not null,
)

insert into Delivery(Customer_ID,Delivery_Address,Delivery_Status) values
(2,'Mumbai','Delivered'),
(5,'Mumbai','Delivered'),
(10,'Patna','Not Delivered'),
(1,'Pune','Delivered'),
(3,'Delhi','Not Delivered'),
(11,'Kolkata','Not Delivered'),
(4,'Hyderabad','Delivered')

select * from Delivery

select Customer_Name, Customer_City, Delivery_Status, Delivery_Address
from Customers as c
INNER JOIN
Order_Details as o
on c.Customer_ID = o.Customer_ID
INNER JOIN
Delivery as d
on o.Customer_ID = d.Customer_ID

select Customer_Name, Delivery_Status, Delivery_Address
from Customers as c
INNER JOIN
Order_Details as o
on c.Customer_ID = o.Customer_ID
INNER JOIN
Delivery as d
on o.Customer_ID = d.Customer_ID 
where c.Customer_City = 'Mumbai'

select c.Customer_ID , c.Customer_Name, Delivery_Status, Delivery_Address
from Customers as c
INNER JOIN
Order_Details as o
on c.Customer_ID = o.Customer_ID
INNER JOIN
Delivery as d
on o.Customer_ID = d.Customer_ID 
where c.Customer_ID between 2 and 5 order by c.Customer_ID

select Customer_Name, Customer_Number, Order_Date, Delivery_Status
from Customers as c
INNER JOIN
Order_Details as o
on c.Customer_ID = o.Customer_ID
RIGHT JOIN
Delivery as d
on o.Customer_ID = d.Customer_ID
