/****** Object:  View [dbo].[GuerillaView]    Script Date: 09/03/2020 17:13:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--DROP VIEW GuerillaView;
CREATE OR ALTER VIEW [dbo].[GuerillaView] AS (Select *, 
(SELECT TOP 1 ah1.OddA--, ah1.TimeUpdated
FROM AsianHandicap ah1 
WHERE ah1.OddsId = m.OddsId 
AND (ah1.TimeUpdated BETWEEN dateadd(hh, -1, m.StartDate) AND m.StartDate)
ORDER BY ah1.TimeUpdated ASC) AS 'FirstOdd',
(SELECT TOP 1 ah1.TimeUpdated
FROM AsianHandicap ah1 
WHERE ah1.OddsId = m.OddsId 
AND (ah1.TimeUpdated BETWEEN dateadd(hh, -1, m.StartDate) AND m.StartDate)
ORDER BY ah1.TimeUpdated ASC) AS 'FirstTime',
(SELECT TOP 1 ah2.OddA--, ah2.TimeUpdated
FROM AsianHandicap ah2 
WHERE ah2.OddsId = m.OddsId 
AND (ah2.TimeUpdated BETWEEN dateadd(hh, -1, m.StartDate) AND m.StartDate)
ORDER BY ah2.TimeUpdated DESC) AS 'LastOdd',
(SELECT TOP 1 ah2.TimeUpdated
FROM AsianHandicap ah2 
WHERE ah2.OddsId = m.OddsId 
AND (ah2.TimeUpdated BETWEEN dateadd(hh, -1, m.StartDate) AND m.StartDate)
ORDER BY ah2.TimeUpdated DESC) AS 'LastTime',
((SELECT TOP 1 ah1.OddA--, ah1.TimeUpdated
FROM AsianHandicap ah1 
WHERE ah1.OddsId = m.OddsId 
AND (ah1.TimeUpdated BETWEEN dateadd(hh, -1, m.StartDate) AND m.StartDate)
ORDER BY ah1.TimeUpdated ASC) - (SELECT TOP 1 ah2.OddA--, ah2.TimeUpdated
FROM AsianHandicap ah2 
WHERE ah2.OddsId = m.OddsId 
AND (ah2.TimeUpdated BETWEEN dateadd(hh, -1, m.StartDate) AND m.StartDate)
ORDER BY ah2.TimeUpdated DESC)) AS 'DIFF',
'AsianHandicap' as 'BetType',
'Home' as 'Selection', 
(CASE WHEN m.ScoreA > m.ScoreB THEN 'Win'
WHEN m.ScoreA = m.ScoreB Then 'Partial'
ELSE 'Loose' END) AS 'Result'
FROM Match m
WHERE m.OddsId IN (SELECT ahf.OddsId FROM AsianHandicap ahf 
WHERE ahf.OddsId = m.OddsId AND (ahf.TimeUpdated BETWEEN dateadd(hh, -1, m.StartDate) AND m.StartDate)
AND ahf.Handicap = -0.25)

UNION

Select *, 
(SELECT TOP 1 ah1.OddB--, ah1.TimeUpdated
FROM AsianHandicap ah1 
WHERE ah1.OddsId = m.OddsId 
AND (ah1.TimeUpdated BETWEEN dateadd(hh, -1, m.StartDate) AND m.StartDate)
ORDER BY ah1.TimeUpdated ASC) AS 'FirstOdd',
(SELECT TOP 1 ah1.TimeUpdated
FROM AsianHandicap ah1 
WHERE ah1.OddsId = m.OddsId 
AND (ah1.TimeUpdated BETWEEN dateadd(hh, -1, m.StartDate) AND m.StartDate)
ORDER BY ah1.TimeUpdated ASC) AS 'FirstTime',
(SELECT TOP 1 ah2.OddB--, ah2.TimeUpdated
FROM AsianHandicap ah2 
WHERE ah2.OddsId = m.OddsId 
AND (ah2.TimeUpdated BETWEEN dateadd(hh, -1, m.StartDate) AND m.StartDate)
ORDER BY ah2.TimeUpdated DESC) AS 'LastOdd',
(SELECT TOP 1 ah2.TimeUpdated
FROM AsianHandicap ah2 
WHERE ah2.OddsId = m.OddsId 
AND (ah2.TimeUpdated BETWEEN dateadd(hh, -1, m.StartDate) AND m.StartDate)
ORDER BY ah2.TimeUpdated DESC) AS 'LastTime',
((SELECT TOP 1 ah1.OddB--, ah1.TimeUpdated
FROM AsianHandicap ah1 
WHERE ah1.OddsId = m.OddsId 
AND (ah1.TimeUpdated BETWEEN dateadd(hh, -1, m.StartDate) AND m.StartDate)
ORDER BY ah1.TimeUpdated ASC) - (SELECT TOP 1 ah2.OddB--, ah2.TimeUpdated
FROM AsianHandicap ah2 
WHERE ah2.OddsId = m.OddsId 
AND (ah2.TimeUpdated BETWEEN dateadd(hh, -1, m.StartDate) AND m.StartDate)
ORDER BY ah2.TimeUpdated DESC)) AS 'DIFF',
'AsianHandicap' as 'BetType',
'Away' as 'Selection', 
(CASE WHEN m.ScoreA > m.ScoreB THEN 'Loose'
WHEN m.ScoreA = m.ScoreB Then 'Partial'
ELSE 'Win' END) AS 'Result'
FROM Match m
WHERE m.OddsId IN (SELECT ahf.OddsId FROM AsianHandicap ahf 
WHERE ahf.OddsId = m.OddsId AND (ahf.TimeUpdated BETWEEN dateadd(hh, -1, m.StartDate) AND m.StartDate)
AND ahf.Handicap = 0.25))
GO
