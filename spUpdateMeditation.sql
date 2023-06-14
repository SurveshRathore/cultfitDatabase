create table MeditationTable
(
	MeditationId int primary key identity(1,1),
	MeditationName varchar(255),
	MeditationDescription varchar(255),
	NumberOfPacks int,	
	MeditationImage varchar(255)
)

Create proc [dbo].[spUpdateMeditation]
(
	@MeditationId int,
	@MeditationName varchar(255),
	@MeditationDescription varchar(255),
	@NumberOfPacks int	
)
AS
SET XACT_ABORT on;
BEGIN
	Begin Try
		Begin Transaction
			Declare @Result varchar(255) = '';
				if not exists (select * from MeditationTable where MeditationId = @MeditationId)
				begin
					Set @Result = 'Meditation Id not Exists';
					THROW 52000, 'Meditation Id not Exists', -1;
				end
 
				else
					Begin

						update MeditationTable set 
							MeditationName = @MeditationName, 
							MeditationDescription = @MeditationDescription, 
							NumberOfPacks = @NumberOfPacks
							where MeditationId = @MeditationId
							

							select * from MeditationTable

							Set @Result = 'Meditation Session updated successfully';
							
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
