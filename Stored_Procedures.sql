
-------------------------------------- Store Procedure --------------------------------
use Brp_Practice

------------------------------- Display All Record usin Store Procedure ------------------

create procedure Sp_DisplayData
as
begin
	begin try
		select * from Employee
	end try

	begin catch
	select
		ERROR_NUMBER() AS ErrorNumber,  
		ERROR_SEVERITY() AS ErrorSeverity,  
		ERROR_STATE() AS ErrorState,  
		ERROR_PROCEDURE() AS ErrorProcedure,  
		ERROR_LINE() AS ErrorLine,  
		ERROR_MESSAGE() AS ErrorMessage
	end catch	
end

exec Sp_DisplayData

--------------------------------------- Display Record With Some Condition using Store Procedure ------------------

create procedure Sp_DisplayDataSomeCondition
(
	@Emp_Gender varchar(25)
)
as
begin
	begin try
		select Employee_Name,Employee_Age,Employee_Salary from Employee where Employee_Gender = @Emp_Gender
	end try

	begin catch
	select
		ERROR_NUMBER() AS ErrorNumber,  
		ERROR_SEVERITY() AS ErrorSeverity,  
		ERROR_STATE() AS ErrorState,  
		ERROR_PROCEDURE() AS ErrorProcedure,  
		ERROR_LINE() AS ErrorLine,  
		ERROR_MESSAGE() AS ErrorMessage
	end catch	
end

exec Sp_DisplayDataSomeCondition 'Female'

-----------------------------------------------

create procedure Sp_DisplayDataSomeConditionWithAge

as
begin
	begin try
		select Employee_Name,Employee_Age,Employee_Salary from Employee where Employee_Age>=30 and Employee_Age<=35
	end try

	begin catch
	select
		ERROR_NUMBER() AS ErrorNumber,  
		ERROR_SEVERITY() AS ErrorSeverity,  
		ERROR_STATE() AS ErrorState,  
		ERROR_PROCEDURE() AS ErrorProcedure,  
		ERROR_LINE() AS ErrorLine,  
		ERROR_MESSAGE() AS ErrorMessage
	end catch	
end

exec Sp_DisplayDataSomeConditionWithAge

----------------------------------------------------

create procedure Sp_DisplayDataSomeConditionGroupBy

as
begin
	begin try
		select Sum(Employee_Salary) as Total_Salary from Employee where Employee_Gender = 'Male' Group By Employee_Gender
	end try

	begin catch
	select
		ERROR_NUMBER() AS ErrorNumber,  
		ERROR_SEVERITY() AS ErrorSeverity,  
		ERROR_STATE() AS ErrorState,  
		ERROR_PROCEDURE() AS ErrorProcedure,  
		ERROR_LINE() AS ErrorLine,  
		ERROR_MESSAGE() AS ErrorMessage
	end catch	
end

exec Sp_DisplayDataSomeConditionGroupBy 

--------------------------------------- Insert Record Using Store Procedure -------------------------------

create procedure Sp_InsertData
(
@Emp_Name varchar(255),
@Emp_Age int,
@Emp_Address varchar(225),
@Emp_Salary int,
@Emp_Gender varchar(10)
)
as
begin
	begin try
		insert into Employee values(@Emp_Name,@Emp_Age,@Emp_Address,@Emp_Salary,@Emp_Gender)
	end try

	begin catch
	select
		ERROR_NUMBER() AS ErrorNumber,  
		ERROR_SEVERITY() AS ErrorSeverity,  
		ERROR_STATE() AS ErrorState,  
		ERROR_PROCEDURE() AS ErrorProcedure,  
		ERROR_LINE() AS ErrorLine,  
		ERROR_MESSAGE() AS ErrorMessage
	end catch	
end

exec Sp_InsertData 'Iqbal Ahmad',25,'Hingna Road CRPF Camp Nagpur',960000000,'Male'

-------------------------------------- Update the table using Store Procedure -----------------------

create procedure Sp_UpdateData
(
@Emp_Name varchar(25),
@Emp_Salary int
)
as
begin
	begin try
		update Employee set Employee_Salary = @Emp_Salary where Employee_Name = @Emp_Name
	end try

	begin catch
	select
		ERROR_NUMBER() AS ErrorNumber,  
		ERROR_SEVERITY() AS ErrorSeverity,  
		ERROR_STATE() AS ErrorState,  
		ERROR_PROCEDURE() AS ErrorProcedure,  
		ERROR_LINE() AS ErrorLine,  
		ERROR_MESSAGE() AS ErrorMessage
	end catch	
end

exec Sp_UpdateData 'Iqbal Ahmad', 880000