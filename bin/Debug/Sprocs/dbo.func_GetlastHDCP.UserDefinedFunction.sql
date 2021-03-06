/****** Object:  UserDefinedFunction [dbo].[func_GetlastHDCP]    Script Date: 09/03/2020 17:13:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER FUNCTION [dbo].[func_GetlastHDCP]
    (
      @OddsId INT 
    
    )
RETURNS NVARCHAR(20)
AS
    BEGIN
    DECLARE @HDCP nvarchar(20)
    
    SELECT @HDCP=Handicap
    FROM dbo.AsianHandicap
    WHERE TimeUpdated=(SELECT MAX(a.TimeUpdated) FROM dbo.AsianHandicap a WHERE a.OddsId=@OddsId)
    AND dbo.AsianHandicap.OddsId=@OddsId
 
        RETURN  @HDCP ;
    END
GO
