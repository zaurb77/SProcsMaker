/****** Object:  View [dbo].[RankedAsianHandicap]    Script Date: 09/03/2020 17:13:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER VIEW [dbo].[RankedAsianHandicap]
AS
SELECT *, 
CASE [asc] WHEN 1 THEN OddA ELSE 0 END AwayFirst,
CASE [asc] WHEN 1 THEN OddB ELSE 0 END HomeFirst,
CASE [desc] WHEN 1 THEN OddA ELSE 0 END AwayLast,
CASE [desc] WHEN 1 THEN OddB ELSE 0 END HomeLast
from(
SELECT *, max(x.[asc]) OVER (PARTITION BY matchid) - x.[asc] [desc] from(
SELECT *, 
row_number() OVER (PARTITION BY ah.MatchId ORDER BY ah.TimeUpdated) [asc]
from dbo.AsianHandicap ah)x)a
GO
