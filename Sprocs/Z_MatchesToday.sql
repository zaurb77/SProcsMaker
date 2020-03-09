/****** Object:  View [dbo].[Z_MatchesToday]    Script Date: 09/03/2020 20:33:28 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO


CREATE OR ALTER VIEW [dbo].[Z_MatchesToday]
AS
SELECT 
	CONVERT(NVARCHAR(10), m.StartDate, 23) AS [Date],
	CONVERT(NVARCHAR(10), m.StartDate, 24) AS [Time],
	m.OddsId,
	m.ContestCode AS [League Code],
	(SELECT Name FROM Contest l WHERE l.Id = m.ContestId) AS [League Description],
	(SELECT Name FROM Team tA WHERE tA.Id=m.TeamAId) AS 'Home',
	(SELECT Name FROM Team tB WHERE tB.Id=m.TeamBId) AS 'Away',
	m.MatchStatus,
	m.ScoreA As HomeScore,
	m.ScoreB As AwayScore,
	CASE 
		WHEN m.ScoreA = m.ScoreB THEN 'Draw'
		WHEN m.ScoreA > m.ScoreB THEN 'Home Wins'
		ELSE 'Away Wins'
	END as Result,
	('http://s2.lucksport.com/chart.htm?ecd=2&id=' + CONVERT(nvarchar(12),m.OddsId)) AS 'Link'
FROM [Match] m
WHERE
	CONVERT(NVARCHAR(10), StartDate, 23) = CONVERT(VARCHAR(10), getdate(), 23)
--ORDER BY [Time] ASC, m.OddsId, m.StartDate DESC
GO


