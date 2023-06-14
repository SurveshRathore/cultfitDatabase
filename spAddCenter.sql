create table CenterTable
(
	CenterId int primary key identity(1,1),
	CenterName varchar(255),
	CenterAddress varchar(255),
	CenterContactNumber int,	
	CenterType varchar(255),
	CenterDescription varchar(255),
	CenterCity varchar(255),
	CenterPrice int
)

use cultFitDB

create proc spAddCenter
(
	@CenterName varchar(255),
	@CenterAddress varchar(255),
	@CenterContactNumber int	
)
AS
SET XACT_ABORT on;
BEGIN
	Begin Try
		Begin Transaction
			Declare @Result varchar(255) = '';
				if exists (select * from CenterTable where CenterAddress = @CenterAddress)
				begin
					Set @Result = 'Center Address already Exists';
					THROW 52000, 'Center Address already Exists', -1;
				end
 
				else
					Begin
							insert into CenterTable (CenterName, CenterAddress , CenterContactNumber) 
							values (@CenterName, @CenterAddress, @CenterContactNumber)

							select * from CenterTable

							Set @Result = 'Center added successfully';
					End
			commit Transaction

			return @Result
	End Try
	Begin Catch
		
		if(XACT_STATE()) = -1
		begin
				print
					'Transaction is non-commitable' + ' Rolling Back Transaction'
					RollBack Transaction;
					Print @Result;
					return @result;
		end

		Else if(XACT_STATE()) = 1
		Begin
			Print
				'Transaction is Complitable' + 'Commiting Back Transaction'
				COMMIT TRANSACTION;
				Print @Result;
				return @result;
		End;
		--print 'Unable to Add doctor'
	End Catch
END

--exec spAddFitness
	
	
