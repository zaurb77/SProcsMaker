/****** Object:  StoredProcedure [dbo].[proc__1x2_Update]    Script Date: 09/03/2020 17:13:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE[dbo].[proc__1x2_Update] 
    @Id bigint,
    @MatchId bigint,
    @OddsId bigint,
    @Odd1 decimal(18, 4),
    @Oddx decimal(18, 4),
    @Odd2 decimal(18, 4),
    @TimeUpdated datetime
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[_1x2]
	SET    [MatchId] = @MatchId, [OddsId] = @OddsId, [Odd1] = @Odd1, [Oddx] = @Oddx, [Odd2] = @Odd2, [TimeUpdated] = @TimeUpdated
	WHERE  [Id] = @Id
	
	/*/*/*-- Begin Return Select <- do not remove
	SELECT [Id], [OddsId], [Odd1], [Oddx], [Odd2], [TimeUpdated]
	FROM   [dbo].[_1x2]
	WHERE  [Id] = @Id	
	-- End Return Select <- do not remove*/*/*/

	COMMIT
GO
