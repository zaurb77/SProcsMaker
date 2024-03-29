/****** Object:  StoredProcedure [dbo].[proc_BetAdvice_Insert]    Script Date: 09/03/2020 17:13:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE[dbo].[proc_BetAdvice_Insert] 
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
	
	DECLARE @ExistingId bigint = 0;
	
	SELECT TOP 1 @ExistingId = temp.Id 
	FROM [dbo].[BetAdvice] temp
	WHERE temp.MatchId = @MatchId and temp.BetSystemName LIKE @BetSystemName 
	
	if @ExistingId = 0
	BEGIN
		INSERT INTO [dbo].[BetAdvice] ([MatchId], [MatchStart], [Contest], [TeamA], [TeamB], [Score], [MatchStatus], [BetSystemName], [BetType], [Selection], [RulesOk], [RulesTotal], [WonPercent])
		SELECT @MatchId, @MatchStart, @Contest, @TeamA, @TeamB, @Score, @MatchStatus, @BetSystemName, @BetType, @Selection, @RulesOk, @RulesTotal, @WonPercent
		
		SELECT @@Identity
	END
	
	ELSE
	BEGIN
		UPDATE [dbo].[BetAdvice]
		SET    [MatchId] = @MatchId, [MatchStart] = @MatchStart, [Contest] = @Contest, [TeamA] = @TeamA, [TeamB] = @TeamB, [Score] = @Score, [MatchStatus] = @MatchStatus, [BetSystemName] = @BetSystemName, [BetType] = @BetType, [Selection] = @Selection, [RulesOk] = @RulesOk, [RulesTotal] = @RulesTotal, [WonPercent] = @WonPercent
		WHERE  [Id] = @ExistingId
		
		SELECT @ExistingId
	END
	-- Begin Return Select <- do not remove
	
	-- End Return Select <- do not remove
               
	COMMIT
GO
