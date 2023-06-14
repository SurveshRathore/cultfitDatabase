use cultFitDB

create proc spRemoveMeditation
(
	@MeditationId int
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
							delete from MeditationTable
							where MeditationId = @MeditationId
							

							select * from MeditationTable

							Set @Result = 'Meditation Session removed successfully';
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

--exec spAddFitness
	
	
