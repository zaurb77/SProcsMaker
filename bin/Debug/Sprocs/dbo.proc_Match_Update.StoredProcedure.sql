/****** Object:  StoredProcedure [dbo].[proc_Match_Update]    Script Date: 09/03/2020 17:13:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER OFF
GO
CREATE OR ALTER PROCEDURE[dbo].[proc_Match_Update] 
    @Id bigint,
    @ContestId bigint,
    @ContestCode nvarchar(20),
    @TeamAId bigint,
    @TeamBId bigint,
    @OddsId bigint,
    @MatchStatusId bigint,
    @MatchStatus nvarchar(30),
    @StartDate datetime,
    @SecondHalfStartDate datetime,
    @EndDate datetime,
    @ScoreA bigint,
    @ScoreB bigint,
    @ScoreAHT bigint,
    @ScoreBHT bigint,
    @TeamAPosition nvarchar(10),
    @TeamBPosition nvarchar(10),
    @DisplayOrder bigint
AS 
	SET NOCOUNT OFF
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[Match]
	SET    [Id] = @Id, [ContestId] = @ContestId, [ContestCode] = @ContestCode, [TeamAId] = @TeamAId, [TeamBId] = @TeamBId, [OddsId] = @OddsId, [MatchStatusId] = @MatchStatusId, [MatchStatus] = @MatchStatus, [StartDate] = @StartDate, [SecondHalfStartDate] = @SecondHalfStartDate, [EndDate] = @EndDate, [ScoreA] = @ScoreA, [ScoreB] = @ScoreB, [ScoreAHT] = @ScoreAHT, [ScoreBHT] = @ScoreBHT, [TeamAPosition] = @TeamAPosition, [TeamBPosition] = @TeamBPosition, [DisplayOrder] = @DisplayOrder
	WHERE  [Id] = @Id
	
	/*/*/*-- Begin Return Select <- do not remove
	SELECT [Id], [ContestId], [ContestCode], [TeamAId], [TeamBId], [OddsId], [MatchStatusId], [MatchStatus], [StartDate], [SecondHalfStartDate], [EndDate], [ScoreA], [ScoreB], [ResultHT], [TeamAPosition], [TeamBPosition], [DisplayOrder]
	FROM   [dbo].[Match]
	WHERE  [Id] = @Id	
	-- End Return Select <- do not remove*/*/*/

	COMMIT
GO
