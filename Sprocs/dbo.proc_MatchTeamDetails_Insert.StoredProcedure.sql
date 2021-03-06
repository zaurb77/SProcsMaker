/****** Object:  StoredProcedure [dbo].[proc_MatchTeamDetails_Insert]    Script Date: 09/03/2020 17:13:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE[dbo].[proc_MatchTeamDetails_Insert] 
    @TeamId bigint,
    @GameId bigint,
    @GameDate datetime,
    @OponentId bigint,
    @Score bigint,
    @OponentScore bigint,
    @HomeAway bit
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  
	
	BEGIN TRAN
	
	INSERT INTO [dbo].[MatchTeamDetails] ([TeamId], [GameId], [GameDate], [OponentId], [Score], [OponentScore], [HomeAway])
	SELECT @TeamId, @GameId, @GameDate, @OponentId, @Score, @OponentScore, @HomeAway
	
	-- Begin Return Select <- do not remove
	SELECT @TeamId
	-- End Return Select <- do not remove
               
	COMMIT
GO
