/****** Object:  UserDefinedFunction [dbo].[func_GetlastOVER]    Script Date: 09/03/2020 17:13:49 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE OR ALTER FUNCTION [dbo].[func_GetlastOVER]
(
      @OddsId INT 
    
    )
RETURNS NVARCHAR(20)
AS
    BEGIN
    DECLARE @OddB nvarchar(20)
    
    SELECT @OddB=OddOver
    FROM dbo.UnderOver
    WHERE TimeUpdated=(SELECT MAX(a.TimeUpdated) FROM dbo.UnderOver a WHERE a.OddsId=@OddsId)
    AND dbo.UnderOver.OddsId=@OddsId
 
        RETURN  @OddB ;
    END
GO
