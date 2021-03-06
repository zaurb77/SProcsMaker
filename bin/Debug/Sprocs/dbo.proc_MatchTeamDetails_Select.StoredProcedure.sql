/****** Object:  StoredProcedure [dbo].[proc_MatchTeamDetails_Select]    Script Date: 09/03/2020 17:13:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE[dbo].[proc_MatchTeamDetails_Select] 
    @TeamId BIGINT = null
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	SELECT *
	FROM   [dbo].[MatchTeamDetails] 
	WHERE  ([TeamId] = @TeamId OR @TeamId IS NULL) 

	COMMIT
GO
