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

-- Commit, Rollback and Savepoint the data

--commit data
begin transaction
insert into Employee_Details values
('Natasha','Romanoff','Broadway street, NewYork Cit','45667365277','940000','blackwidow@gmail.com')
commit
select * from Employee_Details

--rollback data
begin transaction
update Employee_Details set FirstName = 'Caption', LastName = 'Marvel' where Emp_ID = 9
rollback;

--save point 1
begin transaction
delete Employee_Details where Emp_ID = 9
save transaction sav1

--save point 2
begin transaction
insert into Employee_Details values
('Edwin','Jarvis','Avengers Mansion, NewYork City','66754621754','120000','jarvis@gmail.com')
insert into Employee_Details values
('Howard','Stark','Richford, Manhattan, NewYork','9876543256','1000000','stark@yahoo.com');
save transaction sav2

--rollback save point 1
select * from Employee_Details
rollback transaction sav1
