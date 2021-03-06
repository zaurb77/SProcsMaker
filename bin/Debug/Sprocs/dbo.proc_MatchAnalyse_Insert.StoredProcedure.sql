/****** Object:  StoredProcedure [dbo].[proc_MatchAnalyse_Insert]    Script Date: 09/03/2020 17:13:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE[dbo].[proc_MatchAnalyse_Insert] 
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
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN
	
	INSERT INTO [dbo].[MatchAnalyse] ([MatchId], [WinA], [Draw], [WinB], [WinAHome], [DrawAHome], [LoseAHome], [TeamAGoals], [TeamBGoals], [TeamAWin], [TeamADraw], [TeamALose], [TeamAWinHome], [TeamADrawHome], [TeamALoseHome], [TeamBWin], [TeamBDraw], [TeamBLose], [TeamBWinHome], [TeamBDrawHome], [TeamBLoseHome], [LastUpdated])
	SELECT @MatchId, @WinA, @Draw, @WinB, @WinAHome, @DrawAHome, @LoseAHome, @TeamAGoals, @TeamBGoals, @TeamAWin, @TeamADraw, @TeamALose, @TeamAWinHome, @TeamADrawHome, @TeamALoseHome, @TeamBWin, @TeamBDraw, @TeamBLose, @TeamBWinHome, @TeamBDrawHome, @TeamBLoseHome, @LastUpdated
	
	-- Begin Return Select <- do not remove
	SELECT @MatchId
	-- End Return Select <- do not remove
               
	COMMIT
GO
