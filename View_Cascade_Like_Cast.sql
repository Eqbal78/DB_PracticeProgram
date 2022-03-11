----------------Cast and Convert Function ----------------------

select CAST(5.37 as int) Result
SELECT CAST(5.95 AS DEC(3,0)) result

create table Worker
(
  Worker_ID int identity(1,1) PRIMARY KEY,
  Worker_Name varchar(26) not null,
  Worker_Salary money not null,
  Worker_City varchar(45)
)

insert into Worker(Worker_Name,Worker_Salary,Worker_City) values
('Ram',2834.75,'Mumbai'),
('Ramesh',5874.15,'Hyderabad'),
('Jay',3454.22,'Pune'),
('Akash',4874.36,'Kolkata'),
('Victory',6874.86,'Bangalore')

alter table Worker add Dates Date 

update Worker set Dates = '2022-02-22' where Worker_ID = 1
update Worker set Dates = '2022-02-25' where Worker_ID = 2
update Worker set Dates = '2022-03-02' where Worker_ID = 3
update Worker set Dates = '2022-03-06' where Worker_ID = 4
update Worker set Dates = '2022-02-27' where Worker_ID = 5

select * from Worker

select Cast(Worker_Salary as int) as Salary from Worker

select Cast(Dates as varchar(25)) as Salary_Date from Worker 

select Convert(int,Worker_Salary) as Salary from Worker 

select Convert(varchar(25),Dates,103) as Salary_Date from Worker

------------------------ Like Operator -------------------------

select * from Worker where Worker_Name LIKE 'R%'   ------ Name Start with R

select * from Worker where Worker_Name LIKE '%h'   ------ Name Last Character is h

select * from Worker where Worker_Name LIKE '%a%'  ------ a Character is any position in the Name

select * from Worker where Worker_Name LIKE '_a%'  ------ a Character is in Secont position in Name

select * from Worker where Worker_Name LIKE 'R__%' ------ Name Start with R and atleast 3 Character there

select * from Worker where Worker_Name LIKE 'v%y'  ------ Name Start with v and end with y character

------------------------------- View Table -----------------------------------

create view vwDemo as
(
select  Customer_Name, Customer_City, Delivery_Status, Delivery_Address
from Customers as c
INNER JOIN
Order_Details as o
on c.Customer_ID = o.Customer_ID
INNER JOIN
Delivery as d
on o.Customer_ID = d.Customer_ID
)
select * from vwDemo

create view vwDemo_1 as
(
select Customer_Name, Delivery_Status, Delivery_Address
from Customers as c
INNER JOIN
Order_Details as o
on c.Customer_ID = o.Customer_ID
INNER JOIN
Delivery as d
on o.Customer_ID = d.Customer_ID 
where c.Customer_City = 'Mumbai'
)
select * from vwDemo_1

------------------------------- Derived Table -------------------------------------

select * from
(
select  Customer_Name, Customer_City, Delivery_Status, Delivery_Address
from Customers as c
INNER JOIN
Order_Details as o
on c.Customer_ID = o.Customer_ID
INNER JOIN
Delivery as d
on o.Customer_ID = d.Customer_ID
) as DerivedTable

------------------------------- Cascade Delete -----------------------------------

create table Student (
    S_ID int Identity(1,1) PRIMARY KEY,
    S_Name VARCHAR(20),
    Age INT
)

insert into Student (S_Name,Age) 
values ('Ankit',17),
       ('Ramya',18),
       ('Ram',16)

select * from Student

create table Course (
    C_ID int identity(101,1) PRIMARY KEY,
	S_ID int,
    C_Name VARCHAR(20)
	Foreign key (S_ID) References Student(S_ID)
	ON Delete Cascade null
)

INSERT INTO Course(S_ID, C_Name) 
VALUES (1,'c'),
       (2,'c++'),
       (3,'DBMS')

select * from Course

delete from Student where S_Name = 'Ramya'

------------------------------ Cascade Update ------------------------------

create table Student_1 (
    S_ID int Identity(1,1) PRIMARY KEY,
    S_Name VARCHAR(20),
    Age INT
)

insert into Student_1 (S_Name,Age) 
values ('Ankit',17),
       ('Ramya',18),
       ('Ram',16)

create table Product (
    P_ID int identity(101,1) PRIMARY KEY,
	S_ID int,
    P_Name VARCHAR(20)
	Foreign key (S_ID) References Student_1(S_ID)
	ON Update Cascade null
)

insert into Product (S_ID,P_Name) 
values (1,'Book'),
       (2,'Pen'),
       (3,'Copy')

Select * from Student_1
select * from Product 

update Student_1 set S_Name = 'Mohan' where S_ID = 3
update Student_1 set S_ID = 4 where S_ID = 3