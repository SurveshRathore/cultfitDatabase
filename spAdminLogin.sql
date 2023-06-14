use cultFitDB
create proc spAdminLogin
(
	@adminEmail varchar(255),
	@adminPassword varchar(255)
)
AS
SET XACT_ABORT on;
BEGIN
	Begin Try
		Begin Transaction
			Declare @Result varchar(255) = '';
				if not exists (select * from AdminTable where adminEmail = @adminEmail)
				begin
					Set @Result = 'Invalid Email';
					THROW 52000, 'Invalid Email';
				end
 
				else
					Begin
						

							select * from AdminTable where adminEmail = @adminEmail and adminPassword = @adminPassword

							Set @Result = 'Admin successfully Login';
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