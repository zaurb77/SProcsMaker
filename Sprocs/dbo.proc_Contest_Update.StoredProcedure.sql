/****** Object:  StoredProcedure [dbo].[proc_Contest_Update]    Script Date: 09/03/2020 17:13:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE[dbo].[proc_Contest_Update] 
    @Id bigint,
    @Name nvarchar(200),
    @Code nvarchar(20)
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[Contest]
	SET    [Id] = @Id, [Name] = @Name, [Code] = @Code
	WHERE  [Id] = @Id
	
	/*/*/*-- Begin Return Select <- do not remove
	SELECT [Id], [Name], [Code]
	FROM   [dbo].[Contest]
	WHERE  [Id] = @Id	
	-- End Return Select <- do not remove*/*/*/

	COMMIT
GO
