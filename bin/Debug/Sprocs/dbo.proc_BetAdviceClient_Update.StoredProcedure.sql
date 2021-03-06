/****** Object:  StoredProcedure [dbo].[proc_BetAdviceClient_Update]    Script Date: 09/03/2020 17:13:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE[dbo].[proc_BetAdviceClient_Update] 
    @Id bigint,
    @MatchId bigint,
    @MatchStart datetime,
    @Contest nvarchar(100),
    @TeamA nvarchar(100),
    @TeamB nvarchar(100),
    @Score nvarchar(100),
    @MatchStatus nvarchar(100),
    @BetSystemName nvarchar(100),
    @BetType nvarchar(100),
    @Selection nvarchar(100),
    @RulesOk int,
    @RulesTotal int,
    @WonPercent decimal(18, 4)
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[BetAdviceClient]
	SET    [MatchId] = @MatchId, [MatchStart] = @MatchStart, [Contest] = @Contest, [TeamA] = @TeamA, [TeamB] = @TeamB, [Score] = @Score, [MatchStatus] = @MatchStatus, [BetSystemName] = @BetSystemName, [BetType] = @BetType, [Selection] = @Selection, [RulesOk] = @RulesOk, [RulesTotal] = @RulesTotal, [WonPercent] = @WonPercent
	WHERE  [Id] = @Id
	
	/*/*/*-- Begin Return Select <- do not remove
	SELECT [Id], [MatchId], [MatchStart], [Contest], [TeamA], [TeamB], [Score], [MatchStatus], [BetSystemName], [BetType], [Selection], [RulesOk], [RulesTotal], [WonPercent]
	FROM   [dbo].[BetAdviceClient]
	WHERE  [Id] = @Id	
	-- End Return Select <- do not remove*/*/*/

	COMMIT
GO
