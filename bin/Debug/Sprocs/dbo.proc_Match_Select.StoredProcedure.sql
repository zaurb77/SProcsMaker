/****** Object:  StoredProcedure [dbo].[proc_Match_Select]    Script Date: 09/03/2020 17:13:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE[dbo].[proc_Match_Select] 
    @Id BIGINT = null
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	SELECT *--,dbo.func_GetlastOddA(OddsID)
	FROM   [dbo].[Match] 
	WHERE  ([Id] = @Id OR @Id IS NULL) 
	AND StartDate between dateadd(hh, -3, Getdate()) AND DATEADD(d, DATEDIFF(d, 0, Getdate()) + 1, 0) 
	COMMIT
GO
