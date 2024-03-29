/****** Object:  View [dbo].[MatchWithHandicap]    Script Date: 09/03/2020 17:13:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER VIEW [dbo].[MatchWithHandicap]
AS
SELECT
m.Id MatchId,
CAST(m.StartDate AS date) StartDate,
CAST(m.StartDate AS time) StartTime,
CAST(ah1.TimeUpdated AS date) UpdateDate,
CAST(ah1.TimeUpdated AS time) UpdateTime,
CAST(m.EndDate AS date) EndDate,
CAST(m.EndDate AS time) EndTime,
m.[ContestCode] [ContestCode],
c.[Name] [ContestName],
--ah1.MatchId,
t1.[Name] [HomeTeam],
t2.[Name] [AwayTeam],
ah1.OddsId [OddsId],
--ah1.Id AS
ah1.OddB [Home],
ah1.[Sign],
ah1.Handicap [Handicap],
ah1.OddA [Away],
m.[MatchStatus] [MatchStatus],
m.MatchStatusId MatchStatusId,
m.[ScoreA] [ScoreHome],
m.[ScoreB] [ScoreAway],
m.[ScoreA]+m.[ScoreB] [TotalGoals]
FROM AsianHandicap ah1
INNER JOIN
AsianHandicap ah2 ON ah2.Id = ah1.Id+1
JOIN Match m
ON m.Id = ah1.MatchId
JOIN Contest c
ON m.ContestId = c.Id
INNER JOIN dbo.Team t1 ON t1.Id = m.TeamAId
INNER JOIN dbo.Team t2 ON t2.Id = m.TeamBId
GO
