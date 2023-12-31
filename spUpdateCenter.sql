create proc [dbo].[spUpdateCenter]
(
	@CenterId int,
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
				
				if not exists (select * from CenterTable where CenterId = @CenterId)
				begin
					Set @Result = 'Center not Exists';
					THROW 52000, 'Center not Exists', -1;
				end
 
				else
					Begin

							update CenterTable set 
							CenterName = @CenterName, 
							CenterAddress = @CenterAddress, 
							CenterContactNumber = @CenterContactNumber
							
							where CenterId = 1
							

							select * from CenterTable

							Set @Result = 'Center updated successfully';
							
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
	
	

	select * from CenterTable where CenterId = 1

	insert into 

	insert into CenterTable (CenterName, CenterAddress , CenterContactNumber) 
							values ('center1', 'delhi', 9876)