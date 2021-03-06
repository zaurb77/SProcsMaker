/****** Object:  StoredProcedure [dbo].[proc_UnderOver_Update]    Script Date: 09/03/2020 17:13:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE[dbo].[proc_UnderOver_Update] 
    @Id bigint,
    @MatchId bigint,
    @OddsId bigint,
    @OddOver decimal(18, 4),
    @OU decimal(18, 4),
    @OddUnder decimal(18, 4),
    @TimeUpdated datetime
AS 
	SET NOCOUNT OFF	
	SET XACT_ABORT ON  
	
	BEGIN TRAN

	UPDATE [dbo].[UnderOver]
	SET    [MatchId] = @MatchId, [OddsId] = @OddsId, [OddOver] = @OddOver, [OU] = @OU, [OddUnder] = @OddUnder, [TimeUpdated] = @TimeUpdated
	WHERE  [Id] = @Id
	
	/*/*/*-- Begin Return Select <- do not remove
	SELECT [Id], [OddsId], [OddOver], [OU], [OddUnder], [TimeUpdated]
	FROM   [dbo].[UnderOver]
	WHERE  [Id] = @Id	
	-- End Return Select <- do not remove*/*/*/

	COMMIT
GO
