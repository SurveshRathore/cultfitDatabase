create table LabTestTable
(
	LabTestId int primary key identity(1,1),
	LabTestName varchar(255),
	LabTestDescription varchar(255),
	LabTestOriginalPrice int,
	LabTestOfferPrice int
)

create proc spAddLabTest
(
	@LabTestName varchar(255),
	@LabTestOriginalPrice int,
	@LabTestOfferPrice int
)
AS
SET XACT_ABORT on;
BEGIN
	Begin Try
		Begin Transaction
			Declare @Result varchar(255) = '';
				if exists (select * from LabTestTable where LabTestName = @LabTestName)
				begin
					Set @Result = 'Lab Test Name already Exists';
					THROW 52000, 'Lab Test Name already Exists', -1;
				end
 
				else
					Begin
							insert into LabTestTable (LabTestName, LabTestOriginalPrice , LabTestOfferPrice) 
							values (@LabTestName, @LabTestOriginalPrice , @LabTestOfferPrice)

							select * from LabTestTable

							Set @Result = 'Test Added successfully';
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
	
	
