/****** Object:  StoredProcedure [dbo].[proc_UnderOver_SelectByOddsId]    Script Date: 09/03/2020 17:13:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE[dbo].[proc_UnderOver_SelectByOddsId] 
    @OddsId BIGINT
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	SELECT *
	FROM   [dbo].[UnderOver] 
	WHERE  [OddsId] = @OddsId

	COMMIT
GO
