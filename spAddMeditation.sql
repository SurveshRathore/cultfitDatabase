create table MeditationTable
(
	MeditationId int primary key identity(1,1),
	MeditationName varchar(255),
	MeditationDescription varchar(255),
	NumberOfPacks int,	
	MeditationImage varchar(255)
)

Create proc [dbo].[spAddMeditation]
(
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
				if exists (select * from MeditationTable where MeditationName = @MeditationName)
				begin
					Set @Result = 'Meditation Session name already Exists';
					THROW 52000, 'Meditation Session name already Exists', -1;
				end
 
				else
					Begin
							insert into MeditationTable (MeditationName, MeditationDescription , NumberOfPacks) 
							values (@MeditationName, @MeditationDescription, @NumberOfPacks)

							select * from MeditationTable

							Set @Result = 'Meditation Session added successfully';
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
