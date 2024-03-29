/****** Object:  StoredProcedure [dbo].[proc_Contest_Insert]    Script Date: 09/03/2020 17:13:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE[dbo].[proc_Contest_Insert] 
    @Id bigint,
    @Name nvarchar(200),
    @Code nvarchar(20)
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN
	
	INSERT INTO [dbo].[Contest] ([Id], [Name], [Code])
	SELECT @Id, @Name, @Code
	
	-- Begin Return Select <- do not remove
	SELECT @Id
	-- End Return Select <- do not remove
               
	COMMIT
GO
