/****** Object:  StoredProcedure [dbo].[proc_DeleteAllMatchData]    Script Date: 09/03/2020 17:13:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER PROCEDURE[dbo].[proc_DeleteAllMatchData] 
    @Id BIGINT = null
AS 
	SET NOCOUNT ON 
	SET XACT_ABORT ON  

	BEGIN TRAN


DELETE FROM [ZGrabber_master].[dbo].[_1x2]
DELETE FROM [ZGrabber_master].[dbo].[AsianHandicap]
DELETE FROM [ZGrabber_master].[dbo].[Match]
DELETE FROM [ZGrabber_master].[dbo].[UnderOver]
DELETE FROM [ZGrabber_master].[dbo].[Team]
DELETE FROM [ZGrabber_master].[dbo].[Contest]
DELETE FROM [ZGrabber_master].[dbo].[MatchAnalyse]

	COMMIT
GO
