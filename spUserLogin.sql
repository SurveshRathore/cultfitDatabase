use cultFitDB
create proc spUserLogin
(
	@UserEmail varchar(255),
	@UserPasswrod varchar(255)
)
AS
SET XACT_ABORT on;
BEGIN
	Begin Try
		Begin Transaction
			Declare @Result varchar(255) = '';
				if not exists (select * from UserTable where UserEmail = @UserEmail)
				begin
					Set @Result = 'Invalid EmailID';
					THROW 52000, 'Invalid EmailID', -1;
				end
 
				else
					Begin
							select * from UserTable where  UserEmail = @UserEmail and UserPasswrod = @UserPasswrod 

							Set @Result = 'User successfully Login';
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
	End Catch
END