/****** Object:  StoredProcedure [dbo].[proc_UnderOver_Insert]    Script Date: 09/03/2020 17:13:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE[dbo].[proc_UnderOver_Insert] 
    @OddsId bigint,
    @MatchId bigint,
    @OddOver decimal(18, 4),
    @OU decimal(18, 4),
    @OddUnder decimal(18, 4),
    @TimeUpdated datetime
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN
	
	INSERT INTO [dbo].[UnderOver] ([MatchId], [OddsId], [OddOver], [OU], [OddUnder], [TimeUpdated])
	SELECT @MatchId, @OddsId, @OddOver, @OU, @OddUnder, @TimeUpdated
	
	-- Begin Return Select <- do not remove
	SELECT @@Identity
	-- End Return Select <- do not remove
               
	COMMIT
GO
