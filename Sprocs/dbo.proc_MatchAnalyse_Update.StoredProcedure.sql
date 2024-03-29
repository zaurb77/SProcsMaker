/****** Object:  StoredProcedure [dbo].[proc_MatchAnalyse_Update]    Script Date: 09/03/2020 17:13:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE[dbo].[proc_MatchAnalyse_Update] 
    @MatchId bigint,
    @WinA bigint,
    @Draw bigint,
    @WinB bigint,
    @WinAHome bigint,
    @DrawAHome bigint,
    @LoseAHome bigint,
    @TeamAGoals bigint,
    @TeamBGoals bigint,
    @TeamAWin bigint,
    @TeamADraw bigint,
    @TeamALose bigint,
    @TeamAWinHome bigint,
    @TeamADrawHome bigint,
    @TeamALoseHome bigint,
    @TeamBWin bigint,
    @TeamBDraw bigint,
    @TeamBLose bigint,
    @TeamBWinHome bigint,
    @TeamBDrawHome bigint,
    @TeamBLoseHome bigint,
    @LastUpdated datetime
AS 
	SET NOCOUNT OFF
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[MatchAnalyse]
	SET    [MatchId] = @MatchId, [WinA] = @WinA, [Draw] = @Draw, [WinB] = @WinB, [WinAHome] = @WinAHome, [DrawAHome] = @DrawAHome, [LoseAHome] = @LoseAHome, [TeamAGoals] = @TeamAGoals, [TeamBGoals] = @TeamBGoals, [TeamAWin] = @TeamAWin, [TeamADraw] = @TeamADraw, [TeamALose] = @TeamALose, [TeamAWinHome] = @TeamAWinHome, [TeamADrawHome] = @TeamADrawHome, [TeamALoseHome] = @TeamALoseHome, [TeamBWin] = @TeamBWin, [TeamBDraw] = @TeamBDraw, [TeamBLose] = @TeamBLose, [TeamBWinHome] = @TeamBWinHome, [TeamBDrawHome] = @TeamBDrawHome, [TeamBLoseHome] = @TeamBLoseHome, [LastUpdated] = @LastUpdated
	WHERE  [MatchId] = @MatchId
	
	/*/*/*-- Begin Return Select <- do not remove
	SELECT [MatchId], [WinA], [Draw], [WinB], [WinAHome], [DrawAHome], [LoseAHome], [TeamAGoals], [TeamBGoals], [TeamAWin], [TeamADraw], [TeamALose], [TeamAWinHome], [TeamADrawHome], [TeamALoseHome], [TeamBWin], [TeamBDraw], [TeamBLose], [TeamBWinHome], [TeamBDrawHome], [TeamBLoseHome], [LastUpdated]
	FROM   [dbo].[MatchAnalyse]
	WHERE  [MatchId] = @MatchId	
	-- End Return Select <- do not remove*/*/*/

	COMMIT
GO
