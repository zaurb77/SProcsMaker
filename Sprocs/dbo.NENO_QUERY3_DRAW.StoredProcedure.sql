/****** Object:  StoredProcedure [dbo].[NENO_QUERY3_DRAW]    Script Date: 09/03/2020 17:13:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[NENO_QUERY3_DRAW]


 

 
@STARTDATE nvarchar(10),
@WEEKDAY nvarchar(50),
@ENDDATE nvarchar(10),
@GAMEPART INT,
@CONTESTCODE nvarchar(50),
@EXCLUDECONTESTCODE nvarchar(50),
@ALLOWMOVINGODDS INT,
@OPENINGVSCLOSINGA INT,
@OPENINGVSCLOSINGB INT,
@AHMIN float,
@AHMAX float,
@SIGN INT,
@TEAM INT,
@MATCHSTATUSID INT,
@TIMEBEFORESTART INT,
@MOVEMENTTYPEVALS INT,
@MOVEMENTTYPEVALSAH INT,
@MINNUMBEROFROWS INT,
@LINESLIP INT,
@SKIPINITIAL INT,
@ODDSID INT


AS

BEGIN
	
	

SELECT [Start Date],[Start Time],[Update Date],[Update Time],[Contest Code],[Odds Id], [Home Team],[Away Team],Home,sign,Handicap,Away,[Match Status],[Score Home],[Score Away],[Total Goals],
[Home]+[Away] SumOdds 
--, Handicap
--,Gamepart, home AHOddH, away AHOddA
--, Gamepart
--, OpenHomeOdd,ClosingHomeOdd,OpenAwayOdd, ClosingAwayOdd 
--,AH1ID
--,ahopenid
--,a.ahdif
--,FirstOddAfterTimebeforestartA
--,ClosingHomeOdd
--,NumOfRowsBeforeMatch
--,Movementypevals
--,OpenHomeOdd
--,OpenAwayOdd
--,MovementypevalsAH
--, Case  When @TEAM=1 THEN 'A' WHEN @team=2 then 'H' END + CAST(@MOVEMENTTYPEVALS as nvarchar)1
FROM 
(
SELECT 
		m.id,
		m.startdate,
		DATENAME(weekday,m.StartDate) weekday,
		m.enddate,
		CONVERT(VARCHAR(20), m.[StartDate], 23) AS [Start Date],
		CONVERT(VARCHAR(20), m.[StartDate], 24) AS [Start Time],
		CONVERT(VARCHAR(20), ah1.[TimeUpdated], 23) AS [Update Date],
		CONVERT(VARCHAR(20), ah1.[TimeUpdated], 24) AS [Update Time],
		m.[ContestCode] AS [Contest Code],
		c.[Name] AS [Contest name],
		--ah1.MatchId,
		(SELECT t.Name FROM Team t WHERE m.TeamAId=t.Id) AS [Home Team],
        (SELECT t.Name FROM Team t WHERE m.TeamBId=t.Id) AS [Away Team],
		ah1.OddsId AS [Odds Id],
		ah1.Id AS AH1ID,
		ah2.Id AS AH2ID,
		ah1.OddA AS [Home], 
		ah1.OddB [Away],
		ah1.[Sign],
		ah1.Handicap AS [Handicap],
		m.[MatchStatus] AS [Match Status],
		m.[ScoreA] AS [Score Home],
		m.[ScoreB] AS [Score Away],
		m.[ScoreA]+m.[ScoreB] AS [Total Goals],
		ah1.TimeUpdated,
		CASE WHEN m.StartDate>ah1.TimeUpdated then 1 WHEN m.StartDate<=ah1.TimeUpdated THEN 2 END as Gamepart,
		AHOPEN.Handicap OpenHandicap,
		CASE WHEN  (select count(*) from (select count(Handicap) val from AsianHandicap where MatchId = m.Id AND TimeUpdated<m.StartDate Group by Handicap) a ) =1 then 0 else 1 end MovingGoods,
		AHOPEN.OddA OpenHomeOdd,
		AHOPEN.oddb OpenAwayOdd,
		
		(select top 1 Id  from AsianHandicap where MatchId = m.Id and handicap <> AHOPEN.Handicap  order by TimeUpdated ASC) ahdif,
		AHOPEN.id ahopenid,

		----last odd before timesheet 
		AHAfterTIMEBEFORESTART.OddA FirstOddAfterTimebeforestartA,
		AHBeforeMatch.OddB ClosingAwayOdd,
		AHAfterTIMEBEFORESTART.OddB FirstOddAfterTimebeforestartB,
		AHBeforeMatch.OddA ClosingHomeOdd,
		CASE  WHEN @team=1 AND AHBeforeMatch.OddB >ahopen.oddb AND AHBeforeMatch.OddB >AHAfterTIMEBEFORESTART.OddB THEN 'A1'
		WHEN @team=1 AND       AHBeforeMatch.OddB <ahopen.oddb AND AHBeforeMatch.OddB <AHAfterTIMEBEFORESTART.OddB THEN 'A2'
		WHEN @team = 2 AND     AHBeforeMatch.OddA >ahopen.odda AND AHBeforeMatch.OddA >AHAfterTIMEBEFORESTART.OddA   THEN 'H1'
		WHEN @team = 2 AND     AHBeforeMatch.OddA <ahopen.odda AND AHBeforeMatch.OddA <AHAfterTIMEBEFORESTART.OddA  THEN 'H2' END Movementypevals,
		CASE WHEN    AHBeforeMatch.handicap >ahopen.handicap AND AHBeforeMatch.handicap >AHAfterTIMEBEFORESTART.handicap THEN 'AH1'  
		WHEN  AHBeforeMatch.handicap <ahopen.handicap AND AHBeforeMatch.handicap <AHAfterTIMEBEFORESTART.handicap  THEN 'AH2' END MovementypevalsAH,
		(select count(*) from AsianHandicap WHERE matchid = m.id and TimeUpdated<m.StartDate ) NumOfRowsBeforeMatch,
		AHAfterTIMEBEFORESTART.odda,
		AHAfterTIMEBEFORESTART.oddb,
		(SELECT 'Query 3') AS [Query]
FROM AsianHandicap ah1
INNER JOIN
AsianHandicap AS ah2 ON ah2.Id = ah1.Id+1
JOIN Match AS m
ON m.Id = ah1.MatchId
CROSS APPLY ---- Opening odds
(select top 1 * from AsianHandicap  where matchid = m.id and ((id<> (select top 1 id from AsianHandicap  where matchid = m.id  order by TimeUpdated ASC) and @SKIPINITIAL=1) or @SKIPINITIAL=0 )  order by TimeUpdated ASC) AHOPEN
CROSS APPLY ---- Opening after timebeforestart
(select top 1 * from AsianHandicap  where matchid = m.id AND (TimeUpdated >  DATEADD(MINUTE,0- @TIMEBEFORESTART , StartDate)  OR @TIMEBEFORESTART=0) order by TimeUpdated ASC) AHAfterTIMEBEFORESTART
CROSS APPLY ---- Closing row for match
(select top 1 * from AsianHandicap  where matchid = m.id AND TimeUpdated<m.StartDate order by TimeUpdated DESC) AHBeforeMatch
JOIN Contest c
ON m.ContestId = c.Id
WHERE 
(CAST(convert(date,m.StartDate) as nvarchar) BETWEEN @STARTDATE AND @ENDDATE OR @STARTDATE='0' or @ENDDATE='0') 
AND 
(m.ContestCode= @CONTESTCODE OR @CONTESTCODE='0')
AND 
m.ContestCode<> @EXCLUDECONTESTCODE
AND
(MatchStatusId = @MATCHSTATUSID OR 0 = @MATCHSTATUSID)
AND
(ah1.OddsId = @ODDSID or @ODDSID = 0)
----AND 
----m.id=908844
AND
(DATENAME(weekday,m.StartDate)=@WEEKDAY OR '0'=@WEEKDAY)  --@WEEKDAY
AND
(ah1.TimeUpdated >  DATEADD(MINUTE,0- @TIMEBEFORESTART, StartDate) OR @TIMEBEFORESTART=0)
)
a
LEFT OUTER JOIN 
(select matchid  from AsianHandicap
inner join match on match.id = AsianHandicap.MatchId 
where ((Handicap NOT BETWEEN  @AHMIN AND  @AHMAX)
OR NOT((SIGN =  @sign) OR (2=@sign))) AND 
(CASE WHEN StartDate>TimeUpdated then 1 WHEN StartDate<=TimeUpdated THEN 2 END =@GAMEPART or 0=@GAMEPART)
 group by matchid
) AHMINMAX
ON a.id = AHMINMAX.matchid
WHERE 
AHMINMAX.matchid is null
--AND
--((2=@team AND ClosingHomeOdd-ahopenodda BETWEEN @POINTSMIN AND @POINTSMAX  AND ClosingHomeOdd-FirstOddAfterTimebeforestartA BETWEEN @POINTSMIN AND @POINTSMAX) 
--OR (1=@team AND ClosingAwayOdd-ahopenoddB  BETWEEN @POINTSMIN AND @POINTSMAX AND ClosingAwayOdd-FirstOddAfterTimebeforestartB BETWEEN @POINTSMIN AND @POINTSMAX) 
--OR (0=@team AND (ClosingHomeOdd-ahopenoddA BETWEEN @POINTSMIN AND @POINTSMAX  AND ClosingHomeOdd-FirstOddAfterTimebeforestartA BETWEEN @POINTSMIN AND @POINTSMAX) OR (ClosingAwayOdd-ahopenoddB  BETWEEN @POINTSMIN AND @POINTSMAX AND ClosingAwayOdd-FirstOddAfterTimebeforestartB BETWEEN @POINTSMIN AND @POINTSMAX) ) 
--OR @POINTSMIN=0 )
AND
(@ALLOWMOVINGODDS = MovingGoods OR @ALLOWMOVINGODDS = 1 ) 
AND 
(GAMEPART=@GAMEPART or 0 = @GAMEPART)
AND 
((CASE WHEN OpenAwayOdd<ClosingAwayOdd THEN 1 WHEN OpenAwayOdd>ClosingAwayOdd THEN 2 WHEN OpenAwayOdd=ClosingAwayOdd THEN 3 END) = @OPENINGVSCLOSINGB OR 0= @OPENINGVSCLOSINGB)
AND											 
((CASE WHEN OpenHomeOdd<ClosingHomeOdd THEN 1 WHEN OpenHomeOdd>ClosingHomeOdd THEN 2 WHEN OpenHomeOdd=ClosingHomeOdd THEN 3 END) = @OPENINGVSCLOSINGA OR 0= @OPENINGVSCLOSINGA)
AND
( a.ahdif-ahopenid <=@LINESLIP OR @LINESLIP = 0 )
AND 
(Movementypevals = Case  When @TEAM=1 THEN 'A' WHEN @team=2 then 'H' END + CAST(@MOVEMENTTYPEVALS as nvarchar)   OR @MOVEMENTTYPEVALS=0 OR @team=0)
AND 
(MovementypevalsAH = 'AH' + CAST(@MOVEMENTTYPEVALSAH as nvarchar)   OR @MOVEMENTTYPEVALSAH=0)
AND
(NumOfRowsBeforeMatch>=@MINNUMBEROFROWS OR @MINNUMBEROFROWS=0)
AND
OpenHomeOdd+OpenAwayOdd = ClosingHomeOdd+ ClosingAwayOdd
ORDER BY a.id, a.TimeUpdated DESC





END

GO
