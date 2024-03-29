/****** Object:  StoredProcedure [dbo].[proc_Team_Update]    Script Date: 09/03/2020 17:13:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE[dbo].[proc_Team_Update] 
    @Id bigint,
    @Name nvarchar(200)
AS 
	SET NOCOUNT OFF 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[Team]
	SET    [Id] = @Id, [Name] = @Name
	WHERE  [Id] = @Id
	
	/*/*/*-- Begin Return Select <- do not remove
	SELECT [Id], [Name]
	FROM   [dbo].[Team]
	WHERE  [Id] = @Id	
	-- End Return Select <- do not remove*/*/*/

	COMMIT
GO
