/****** Object:  StoredProcedure [dbo].[proc_Match_Delete]    Script Date: 09/03/2020 17:13:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE[dbo].[proc_Match_Delete] 
    @Id bigint
AS 
	SET NOCOUNT OFF 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	DELETE
	FROM   [dbo].[Match]
	WHERE  [Id] = @Id

	COMMIT
GO
