use cultFitDB

create proc spAddFitness
(
	@FitnessCultPassName varchar(255),      
    @FitnessStartTime date,
    @FitnessEndTime date,
    @FitnessOriginalPrice int,
    @FitnessOfferPrice int,
    @FitnessPerMonthCost int
)
AS
SET XACT_ABORT on;
BEGIN
	Begin Try
		Begin Transaction
			Declare @Result varchar(255) = '';
				if exists (select * from FitnessTable where FitnessCultPassName = @FitnessCultPassName)
				begin
					Set @Result = 'Fitness CultPass Name already Exists';
					THROW 52000, 'Fitness CultPass Name already Exists', -1;
				end
 
				else
					Begin
							insert into FitnessTable (FitnessCultPassName, FitnessStartTime , FitnessEndTime , FitnessOriginalPrice , FitnessOfferPrice,  FitnessPerMonthCost) 
							values (@FitnessCultPassName, @FitnessStartTime, @FitnessEndTime, @FitnessOriginalPrice, @FitnessOfferPrice, @FitnessPerMonthCost)

							select * from FitnessTable

							Set @Result = 'Type successfully Added';
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
	
	
