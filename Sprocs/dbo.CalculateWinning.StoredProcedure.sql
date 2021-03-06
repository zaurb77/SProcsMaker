/****** Object:  StoredProcedure [dbo].[CalculateWinning]    Script Date: 09/03/2020 17:13:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE OR ALTER PROCEDURE [dbo].[CalculateWinning]
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

    SELECT SUM(z.Money1)
FROM (SELECT [Id]
      ,[ContestId]
      ,[ContestCode]
      ,[TeamAId]
      ,[TeamBId]
      ,[OddsId]
      ,[MatchStatusId]
      ,[MatchStatus]
      ,[StartDate]
      ,[SecondHalfStartDate]
      ,[EndDate]
      ,[ScoreA]
      ,[ScoreB]
      ,[TeamAPosition]
      ,[TeamBPosition]
      ,[DisplayOrder]
      ,[ScoreAHT]
      ,[ScoreBHT]
      ,[FirstOdd]
      ,[FirstTime]
      ,[LastOdd]
      ,[LastTime]
      ,[DIFF]
      ,[BetType]
      ,[Selection]
      ,[Result]
      ,(CASE 
      WHEN Result like 'Win' THEN LastOdd * 100
      WHEN Result like 'Partial' THEN -50
      ELSE -100 END) as 'Money1'
      
  FROM [ZGrabber_master].[dbo].[GuerillaView]
WHERE DIFF >= 0.04 AND LastOdd between 0.7 and 1.0) z

END
GO
