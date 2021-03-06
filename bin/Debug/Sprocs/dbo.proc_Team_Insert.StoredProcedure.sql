/****** Object:  StoredProcedure [dbo].[proc_Team_Insert]    Script Date: 09/03/2020 17:13:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE[dbo].[proc_Team_Insert] 
    @Id bigint,
    @Name nvarchar(200)
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN
	
	INSERT INTO [dbo].[Team] ([Id], [Name])
	SELECT @Id, @Name
	
	-- Begin Return Select <- do not remove
	SELECT @Id
	-- End Return Select <- do not remove
               
	COMMIT
GO
