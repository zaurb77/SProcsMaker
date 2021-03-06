/****** Object:  StoredProcedure [dbo].[proc_AsianHandicap_Insert]    Script Date: 09/03/2020 17:13:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE[dbo].[proc_AsianHandicap_Insert] 
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
	
	INSERT INTO [dbo].[AsianHandicap] ([MatchId], [OddsId], [StrongerTeamId], [TimeUpdated], [OddA], [OddB], [Handicap], [Sign])
	SELECT @MatchId, @OddsId, @StrongerTeamId, @TimeUpdated, @OddA, @OddB, @Handicap, @Sign
	
	-- Begin Return Select <- do not remove
	SELECT @@Identity
	-- End Return Select <- do not remove
               
	COMMIT
GO
