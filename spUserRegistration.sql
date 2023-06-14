use cultFitDB
create proc spUserRegistration
(
	@UserFirstName varchar(255),
	@UserLastName varchar(255),
	@UserEmail varchar(255),
	@UserContactNumber varchar(255),
	@UserPasswrod varchar(255)
)
AS
SET XACT_ABORT on;
BEGIN
	Begin Try
		Begin Transaction
			Declare @Result varchar(255) = '';
				if exists (select * from UserTable where UserEmail = @UserEmail)
				begin
					Set @Result = 'Email Id already Exists';
					THROW 52000, 'Email Id already Exists', -1;
				end
 
				else
					Begin
							insert into UserTable (UserFirstName, UserLastName, UserEmail, UserContactNumber, UserPasswrod) 
							values (@UserFirstName, @UserLastName, @UserEmail, @UserContactNumber, @UserPasswrod)

							select * from DoctorTable

							Set @Result = 'User successfully Registered';
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

exec spUserRegistration
	@UserFirstName = 'User1',
	@UserLastName = 'Last',
	@UserEmail = 'user1@gmail.com',
	@UserContactNumber = 98765,
	@UserPasswrod = ''
	
