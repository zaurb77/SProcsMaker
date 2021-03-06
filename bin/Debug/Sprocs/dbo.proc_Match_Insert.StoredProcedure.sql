/****** Object:  StoredProcedure [dbo].[proc_Match_Insert]    Script Date: 09/03/2020 17:13:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE[dbo].[proc_Match_Insert] 
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
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN
	
	INSERT INTO [dbo].[Match] ([Id], [ContestId], [ContestCode], [TeamAId], [TeamBId], [OddsId], [MatchStatusId], [MatchStatus], [StartDate], [SecondHalfStartDate], [EndDate], [ScoreA], [ScoreB], [ScoreAHT], [ScoreBHT], [TeamAPosition], [TeamBPosition], [DisplayOrder])
	SELECT @Id, @ContestId, @ContestCode, @TeamAId, @TeamBId, @OddsId, @MatchStatusId, @MatchStatus, @StartDate, @SecondHalfStartDate, @EndDate, @ScoreA, @ScoreB, @ScoreAHT, @ScoreBHT, @TeamAPosition, @TeamBPosition, @DisplayOrder
	
	-- Begin Return Select <- do not remove
	SELECT @Id
	-- End Return Select <- do not remove
               
	COMMIT
GO
