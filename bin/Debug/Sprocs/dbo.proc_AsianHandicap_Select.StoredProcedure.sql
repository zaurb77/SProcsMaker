/****** Object:  StoredProcedure [dbo].[proc_AsianHandicap_Select]    Script Date: 09/03/2020 17:13:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE[dbo].[proc_AsianHandicap_Select] 
    @Id BIGINT = null
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	SELECT *
	FROM   [dbo].[AsianHandicap] 
	WHERE  ([Id] = @Id OR @Id IS NULL) 

	COMMIT
GO
