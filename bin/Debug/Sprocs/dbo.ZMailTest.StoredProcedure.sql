/****** Object:  StoredProcedure [dbo].[ZMailTest]    Script Date: 09/03/2020 17:13:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[ZMailTest]

@DAY NVARCHAR (10),
@TIME_FROM NVARCHAR(10),
@TIME_TO NVARCHAR(10),
@HANDICAP_FROM DECIMAL,
@HANDICAP_TO DECIMAL

AS

BEGIN

SELECT 
	CONVERT(NVARCHAR(10), m.StartDate, 23) AS [Date],
	CONVERT(NVARCHAR(10), m.StartDate, 24) AS [Time],
	m.ContestCode,
	m.OddsId,
	(SELECT Name FROM Team tA WHERE tA.Id=m.TeamAId) AS 'Home',
	(SELECT Name FROM Team tB WHERE tB.Id=m.TeamBId) AS 'Away',
	m.MatchStatusId,
	m.MatchStatus,
	h.OddA, h.Handicap,  h.OddB, 
	CONVERT(NVARCHAR(10), h.TimeUpdated, 23) AS [Odd Date],
	CONVERT(NVARCHAR(10), h.TimeUpdated, 24) AS [Odd Time], 
	h.OddA+h.OddB AS SumHandicap,
	m.ScoreA As HomeScore,
	m.ScoreB As AwayScore,
	CASE 
		WHEN m.ScoreA = m.ScoreB THEN 'Draw'
		WHEN m.ScoreA > m.ScoreB THEN 'Home Wins'
		ELSE 'Away Wins'
	END as Result,
	('http://s2.lucksport.com/chart.htm?ecd=2&id=' + CONVERT(nvarchar(12),m.OddsId)) AS 'Link'
FROM [Match] m
JOIN
	AsianHandicap AS h
	ON h.OddsId = m.OddsId
WHERE
	CONVERT(NVARCHAR(10), StartDate, 23) = @DAY  AND (
	CONVERT(NVARCHAR(10), StartDate, 24) BETWEEN @TIME_FROM AND @TIME_TO ) AND
	m.StartDate > h.TimeUpdated AND
	(MatchStatusId = 4 OR MatchStatusId = 13)
ORDER BY [Time] ASC, m.OddsId, h.TimeUpdated DESC
END
GO
