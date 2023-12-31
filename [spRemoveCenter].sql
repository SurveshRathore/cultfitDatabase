USE [cultFitDB]
GO
/****** Object:  StoredProcedure [dbo].[spRemoveFitness]    Script Date: 06-06-2023 10:37:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create proc [dbo].[spRemoveCenter]
(
	@CenterId int
)
AS
SET XACT_ABORT on;
BEGIN
	Begin Try
		Begin Transaction
			Declare @Result varchar(255) = '';
				if not exists (select * from CenterTable where CenterId = @CenterId )
				begin
					Set @Result = 'Center not Exists';
					THROW 52000, 'center not Exists', -1;
				end
 
				else
					Begin
							delete from CenterTable
							where CenterId = @CenterId
							

							select * from CenterTable

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
