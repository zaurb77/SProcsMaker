/****** Object:  StoredProcedure [dbo].[proc_C_1x2_Insert]    Script Date: 09/03/2020 17:13:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE[dbo].[proc_C_1x2_Insert]
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
	
	INSERT INTO [dbo].[_1x2] ([MatchId], [OddsId], [Odd1], [Oddx], [Odd2], [TimeUpdated])
	SELECT @MatchId, @OddsId, @Odd1, @Oddx, @Odd2, @TimeUpdated
	
	-- Begin Return Select <- do not remove
	SELECT @@Identity
	-- End Return Select <- do not remove
               
	COMMIT

GO
