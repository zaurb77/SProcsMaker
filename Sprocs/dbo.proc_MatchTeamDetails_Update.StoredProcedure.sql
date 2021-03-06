/****** Object:  StoredProcedure [dbo].[proc_MatchTeamDetails_Update]    Script Date: 09/03/2020 17:13:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE[dbo].[proc_MatchTeamDetails_Update] 
    @TeamId bigint,
    @GameId bigint,
    @GameDate datetime,
    @OponentId bigint,
    @Score bigint,
    @OponentScore bigint,
    @HomeAway bit
AS 
	SET NOCOUNT OFF
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[MatchTeamDetails]
	SET    [TeamId] = @TeamId, [GameId] = @GameId, [GameDate] = @GameDate, [OponentId] = @OponentId, [Score] = @Score, [OponentScore] = @OponentScore, [HomeAway] = @HomeAway
	WHERE  [TeamId] = @TeamId
	
	/*/*/*-- Begin Return Select <- do not remove
	SELECT [TeamId], [GameId], [GameDate], [OponentId], [Score], [OponentScore], [HomeAway]
	FROM   [dbo].[MatchTeamDetails]
	WHERE  [TeamId] = @TeamId	
	-- End Return Select <- do not remove*/*/*/

	COMMIT
GO
