/****** Object:  StoredProcedure [dbo].[proc_vLiveMatches_Select]    Script Date: 09/03/2020 17:13:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE[dbo].[proc_vLiveMatches_Select] 
   
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN

	SELECT *,
	dbo.func_GetlastHDCP(OddsID) as HDCP,
	dbo.func_GetlastOddA(OddsID) AS Odds1,
	dbo.func_GetlastOddB(OddsID) AS Odds2,
	'' AS LM1,
	
	dbo.func_GetlastFTOU(OddsID) AS FTOU,
	dbo.func_Getlastover(OddsID) AS "Over",
		dbo.func_GetlastUnder(OddsID) AS Under,
		' ' AS LM2	,
		' ' AS CH
	FROM   VLivematch
	WHERE StartDate between dateadd(hh, -3, Getdate()) AND DATEADD(d, DATEDIFF(d, 0, Getdate()) + 1, 0) 
	--MatchStatus!='FT'
	ORDER BY displayOrder asc
	


	COMMIT
--SELECT * FROM dbo.AsianHandicap
GO
