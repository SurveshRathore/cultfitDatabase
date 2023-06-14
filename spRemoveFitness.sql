use cultFitDB

create proc spRemoveFitness
(
	@FitnessId int
)
AS
SET XACT_ABORT on;
BEGIN
	Begin Try
		Begin Transaction
			Declare @Result varchar(255) = '';
				if not exists (select * from FitnessTable where FitnessId = @FitnessId )
				begin
					Set @Result = 'FitnessCultPass not Exists';
					THROW 52000, 'Fitness CultPass not Exists', -1;
				end
 
				else
					Begin
							delete from FitnessTable
							where FitnessId = @FitnessId
							

							select * from FitnessTable

							Set @Result = 'Record deleted successfully';
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
	
	
