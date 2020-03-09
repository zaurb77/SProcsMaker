/****** Object:  StoredProcedure [dbo].[proc__1x2_Select]    Script Date: 09/03/2020 17:13:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE[dbo].[proc__1x2_Select] 
    @Id BIGINT = null
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	SELECT *
	FROM   [dbo].[_1x2] 
	WHERE  ([Id] = @Id OR @Id IS NULL) 

	COMMIT
GO
