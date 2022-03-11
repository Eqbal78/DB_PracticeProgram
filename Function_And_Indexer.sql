use DB_Practice

---------------------------  User-Defined function ------------------------------

create function Fun_EmployeeInformation()      
returns table       
as      
return(select * from Employee_Details  ) 

select * from Fun_EmployeeInformation()


create function Fun_Employee_Information_With_SomeCondition
(
@Emp_ID int
)      
returns table       
as      
return(select * from Employee_Details where Employee_Details.Emp_ID > @Emp_ID ) 

select * from Fun_Employee_Information_With_SomeCondition(3)
select * from Employee_Details


----------------------------- Two-Column join function -------------------------

alter function fun_JoinEmpColumnInfo  
(  
   @EmpName varchar(15),    
   @EmpCity varchar(30)
)  
returns varchar(100)  
as  
begin return(select @EmpName+ ' ' +@EmpCity)  
end  

print dbo.fun_JoinEmpColumnInfo('Ram','Mumbai')

-------------------------------- Store Data using a Function and Display that Stored data using Print Command -----------

create function fun_PrintNumber()  
returns decimal(7,2)  
as  
begin  
    return 1000.13  
end  

print dbo.fun_PrintNumber()

--------------------------------- Adding Two Number using Function ----------------------------------

create function Fun_Addition(@Num1 Decimal(7,2),@Num2 Decimal(7,2))  
RETURNS Decimal(7,2)  
Begin  
    DECLARE @Result Decimal(7,2)  
    SET @Result = @Num1 + @Num2  
    RETURN @Result  
end   

print dbo.Fun_Addition(14.5,15.5)


create function Fun_NetSale(
    @quantity INT,
    @list_price DEC(10,2),
    @discount DEC(4,2)
)
RETURNS DEC(10,2)
AS 
BEGIN
    RETURN @quantity * @list_price * (1 - @discount);
END

print dbo.Fun_NetSale(10,100,0.02)

---------------------------------- Clustered And Non-Clustered Indexes --------------------------------

use DemoDB


create table student
(
    id INT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    gender VARCHAR(50) NOT NULL,
    DOB datetime NOT NULL,
    total_score INT NOT NULL,
    city VARCHAR(50) NOT NULL
 )

 EXECUTE sp_helpindex student

insert into student 
values  
(6, 'Kate', 'Female', '03-JAN-1985', 500, 'Liverpool'), 
(2, 'Jon', 'Male', '02-FEB-1974', 545, 'Manchester'),
(9, 'Wise', 'Male', '11-NOV-1987', 499, 'Manchester'), 
(3, 'Sara', 'Female', '07-MAR-1988', 600, 'Leeds'), 
(1, 'Jolly', 'Female', '12-JUN-1989', 500, 'London'),
(4, 'Laura', 'Female', '22-DEC-1981', 400, 'Liverpool'),
(7, 'Joseph', 'Male', '09-APR-1982', 643, 'London'),  
(5, 'Alan', 'Male', '29-JUL-1993', 500, 'London'), 
(8, 'Mice', 'Male', '16-AUG-1974', 543, 'Liverpool'),
(10, 'Elis', 'Female', '28-OCT-1990', 400, 'Leeds')

SELECT * FROM student where id = 5

Create Clustered Index IX_tblStudent_Gender_Score
ON student(gender ASC, total_score DESC)

Create Nonclustered Index IX_tblStudent_Name
ON student(name ASC)

Create Nonclustered Index IX_tblStudent_Id
ON student(id ASC)

SELECT * FROM student

CREATE Nonclustered Index IX_tblStudent_score_name
ON student(total_score ASC , name ASC)

SELECT * FROM student