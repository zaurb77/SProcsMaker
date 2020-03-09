/****** Object:  View [dbo].[Check60]    Script Date: 09/03/2020 17:13:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[Check60]
AS

SELECT
	--CONVERT(NVARCHAR(10), m.StartDate, 23) AS [Date],
	CONVERT(NVARCHAR(10), m.StartDate, 24) AS [Time],
	m.ContestCode,
	--m.OddsId,
	(SELECT Name FROM Team tA WHERE tA.Id=m.TeamAId) AS 'Home',
	(SELECT Name FROM Team tB WHERE tB.Id=m.TeamBId) AS 'Away',
	--m.MatchStatusId,
	--m.MatchStatus,
	h.OddA AS [HomeOdds], h.Handicap,  h.OddB [AwayOdds], 
	--CONVERT(NVARCHAR(10), h.TimeUpdated, 23) AS [Odd Date],
	CONVERT(NVARCHAR(10), h.TimeUpdated, 24) AS [Odd Time] 
	--h.OddA+h.OddB AS SumHandicap
	
FROM [Match] m
JOIN
	AsianHandicap AS h
	ON h.OddsId = m.OddsId
WHERE
	CONVERT(NVARCHAR(10), StartDate, 23) = CONVERT(NVARCHAR(10), GETDATE(), 25)  AND (
	CONVERT(NVARCHAR(10), StartDate, 24) BETWEEN CONVERT(NVARCHAR(10), GETDATE(), 24) AND CONVERT(NVARCHAR(10),DateAdd(MINUTE,90,GETDATE()), 24) ) AND
	m.StartDate > h.TimeUpdated AND
	(MatchStatusId BETWEEN 17 AND 17)
	
--ORDER BY [Time] ASC, ContestCode, [Home], [Odd Time] DESC


--SELECT * FROM [dbo].[Check60] ORDER BY [Time] ASC, ContestCode, [Home], [Odd Time] DESC
GO
