/****** Object:  StoredProcedure [dbo].[proc_MatchTeamDetails_Delete]    Script Date: 09/03/2020 17:13:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE[dbo].[proc_MatchTeamDetails_Delete] 
    @TeamId bigint
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	DELETE
	FROM   [dbo].[MatchTeamDetails]
	WHERE  [TeamId] = @TeamId

	COMMIT
GO
