/****** Object:  StoredProcedure [dbo].[proc_MatchAnalyse_Delete]    Script Date: 09/03/2020 17:13:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE[dbo].[proc_MatchAnalyse_Delete] 
    @MatchId bigint
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	DELETE
	FROM   [dbo].[MatchAnalyse]
	WHERE  [MatchId] = @MatchId

	COMMIT
GO
