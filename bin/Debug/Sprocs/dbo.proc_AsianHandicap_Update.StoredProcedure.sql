/****** Object:  StoredProcedure [dbo].[proc_AsianHandicap_Update]    Script Date: 09/03/2020 17:13:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE[dbo].[proc_AsianHandicap_Update] 
    @Id bigint,
    @MatchId bigint,
    @OddsId bigint,
    @StrongerTeamId bigint,
    @TimeUpdated datetime,
    @OddA decimal(18, 4),
    @OddB decimal(18, 4),
    @Handicap decimal(18, 4),
    @Sign bit
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[AsianHandicap]
	SET     [MatchId] = @MatchId, [OddsId] = @OddsId, [StrongerTeamId] = @StrongerTeamId, [TimeUpdated] = @TimeUpdated, [OddA] = @OddA, [OddB] = @OddB, [Handicap] = @Handicap, [Sign] = @Sign
	WHERE  [Id] = @Id
	
	/*/*/*-- Begin Return Select <- do not remove
	SELECT [Id], [OddsId], [StrongerTeamId], [TimeUpdated], [OddA], [OddB], [Handicap], [Sign]
	FROM   [dbo].[AsianHandicap]
	WHERE  [Id] = @Id	
	-- End Return Select <- do not remove*/*/*/

	COMMIT
GO
