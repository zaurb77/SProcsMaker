/****** Object:  View [dbo].[ExtentedMatch]    Script Date: 09/03/2020 17:13:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER VIEW [dbo].[ExtentedMatch]
AS
SELECT
m.Id MatchId,
CASE WHEN ah1.OddA = ah2.OddA THEN 1 ELSE 0 END HomeAdjacent ,
CASE WHEN ah1.OddB = ah2.OddB THEN 1 ELSE 0 END AwayAdjacent ,
max(ah1.Handicap) OVER(PARTITION BY ah1.MatchId) HandicapMax,
min(ah1.Handicap) OVER(PARTITION BY ah1.MatchId) HandicapMin,
Min(abs(ah1.OddA - ah2.OddA))OVER(PARTITION BY ah1.MatchId) HomePointsMin,
Max(abs(ah1.OddA - ah2.OddA))OVER(PARTITION BY ah1.MatchId) HomePointsMax,
Min(abs(ah1.OddB - ah2.OddB))OVER(PARTITION BY ah1.MatchId) AwayPointsMin,
Max(abs(ah1.OddB - ah2.OddB))OVER(PARTITION BY ah1.MatchId) AwayPointsMax,
count(ah1.Handicap) OVER(PARTITION BY ah1.MatchId) HandicapCount,
max(ah1.awayfirst) OVER(PARTITION BY ah1.MatchId) AwayFirst,
max(ah1.AwayLast)OVER(PARTITION BY ah1.MatchId) AwayLast,
max(ah1.HomeFirst) OVER(PARTITION BY ah1.MatchId) HomeFirst,
max(ah1.HomeLast)OVER(PARTITION BY ah1.MatchId) HomeLast,
ah1.[desc] [desc],
CASE WHEN ah1.TimeUpdated < m.StartDate THEN 1 ELSE 2 END GamePart,
m.StartDate ,
ah1.TimeUpdated UpdateDate,
m.EndDate,
m.[ContestCode] [ContestCode],
c.[Name] [ContestName],
t1.[Name] [HomeTeam],
t2.[Name] [AwayTeam],
ah1.OddsId [OddsId],
ah1.OddA [Home],
ah1.[Sign],
ah1.Handicap [Handicap],
ah1.OddB [Away],
m.[MatchStatus] [MatchStatus],
m.MatchStatusId MatchStatusId,
m.[ScoreA] [ScoreHome],
m.[ScoreB] [ScoreAway],
m.[ScoreA]+m.[ScoreB] [TotalGoals],
ah2.OddA [Home2],
ah2.OddB [Away2]
FROM dbo.RankedAsianHandicap ah1
JOIN
AsianHandicap ah2 ON ah2.Id = ah1.Id+1
JOIN Match m
ON m.Id = ah1.MatchId
JOIN Contest c
ON m.ContestId = c.Id
INNER JOIN dbo.Team t1 ON t1.Id = m.TeamAId
INNER JOIN dbo.Team t2 ON t2.Id = m.TeamBId
GO
