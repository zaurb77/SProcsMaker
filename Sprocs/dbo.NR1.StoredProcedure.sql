/****** Object:  StoredProcedure [dbo].[NR1]    Script Date: 09/03/2020 17:13:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE [dbo].[NR1](@STARTDATE date,@ENDDATE date, @WEEKDAY tinyint,@GAMEPART bit,@CONTESTCODE nvarchar(20),@ALLOWMOVINGODDS bit,@AHMIN decimal(18,4),@AHMAX decimal(18,4),@SIGN int,@TEAM int ,@POINTSMIN decimal(18,4),@POINTSMAX decimal(18,4),@REPEATINGADJACENT bit,@OPENINGVSCLOSINGA int,@OPENINGVSCLOSINGB int,@MATCHSTATUSID int, @EXCLUDESMALLRAWS bit)
AS
DECLARE @enddt date 
set @enddt = dateadd(day, 1, cast(@ENDDATE AS date))
;WITH result as(
SELECT MatchId,StartDate, UpdateDate, EndDate, ContestCode, ContestName, HomeTeam, AwayTeam, OddsId, Home, [Sign], max(e.HomeAdjacent) OVER(PARTITION BY e.MatchId) Homeadjacent, max(e.AwayAdjacent) OVER(PARTITION BY e.MatchId) AwayAdjacent ,
Handicap, Away, MatchStatus, MatchStatusId, ScoreHome, ScoreAway, TotalGoals,HomeFirst, HomeLast, AwayFirst, AwayLast
FROM [ZGrabber_master].[dbo].[ExtentedMatch] e
WHERE
e.StartDate >= @STARTDATE AND
e.EndDate <= @enddt AND
(@CONTESTCODE = '' OR ContestCode = @CONTESTCODE) AND
(@GAMEPART = 0 OR e.GamePart = @GamePart) AND
(@WEEKDAY = 0 OR @WEEKDAY = DATEPART(dw, StartDate)) AND
MatchStatusId = @MATCHSTATUSID AND
HandicapMin >= @AHMIN AND 
HandicapMax <= @AHMAX AND 
(@SIGN = 2 OR [Sign] = @SIGN) AND
(@EXCLUDESMALLRAWS = 0 OR HandicapCount > 1) AND
(@ALLOWMOVINGODDS = 1 OR HandicapMin = HandicapMax)  AND
(@POINTSMAX = 0 OR ((@TEAM = 0 OR @TEAM = 1) AND AwayPointsMin >= @POINTSMIN AND AwayPointsMax <= @POINTSMAX) OR ((@TEAM = 0 OR @TEAM = 2) AND HomePointsMin >= @POINTSMIN AND HomePointsMax <= @POINTSMAX)) AND
(@OPENINGVSCLOSINGA = 0 or(@OPENINGVSCLOSINGA = 1 AND AwayFirst > AwayLast) or(@OPENINGVSCLOSINGA = 2 AND AwayFirst  < AwayLast) or(@OPENINGVSCLOSINGA = 3 AND AwayFirst  = AwayLast)) AND
(@OPENINGVSCLOSINGB = 0 or(@OPENINGVSCLOSINGB = 1 AND HomeFirst > HomeLast) or(@OPENINGVSCLOSINGB = 2 AND HomeFirst  < HomeLast) or(@OPENINGVSCLOSINGB = 3 AND HomeFirst  = HomeLast))
)
SELECT 
MatchId,StartDate, UpdateDate, EndDate, ContestCode, ContestName, HomeTeam, AwayTeam, OddsId, Home, [Sign]
Handicap, Away, MatchStatus, MatchStatusId, ScoreHome, ScoreAway, TotalGoals,HomeFirst, HomeLast, AwayFirst, AwayLast
FROM result WHERE
@REPEATINGADJACENT = 0 OR (@REPEATINGADJACENT = 1 AND (@TEAM = 0 OR @TEAM = 1) AND AwayAdjacent = 1) OR (@REPEATINGADJACENT = 2 AND (@TEAM = 0 OR @TEAM = 2) AND HomeAdjacent = 1)
ORDER BY StartDate, MatchId, UpdateDate
GO
