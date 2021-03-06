/****** Object:  StoredProcedure [dbo].[proc_MatchAnalyse_Select]    Script Date: 09/03/2020 17:13:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE[dbo].[proc_MatchAnalyse_Select] 
    @MatchId BIGINT = null
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	SELECT *
	FROM   [dbo].[MatchAnalyse] 
	WHERE  ([MatchId] = @MatchId OR @MatchId IS NULL)
	AND LastUpdated between dateadd(hh, -3, Getdate()) AND DATEADD(d, DATEDIFF(d, 0, Getdate()) + 1, 0) 
	COMMIT
GO
