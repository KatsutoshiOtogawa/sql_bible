
CREATE FUNCTION dbo.factorial ( @n INT )
RETURNS BIGINT
AS
BEGIN
DECLARE @ret BIGINT;

    IF @n = 0
        SET @ret = 1;
    ELSE
        SET @ret = @n * dbo.factorial( @n - 1 );
RETURN @ret;
END;
GO

CREATE FUNCTION dbo.binomial(@n INTEGER, @p FLOAT, @k INTEGER)  
RETURNS FLOAT
AS   
-- Returns the stock level for the product.  
BEGIN  
DECLARE @ret FLOAT;

    SET @ret = @p
    RETURN @ret;  
END;
GO

-- IF OBJECT_ID (N'dbo.ufnGetInventoryStock', N'FN') IS NOT NULL  
--     DROP FUNCTION ufnGetInventoryStock;  
-- GO 
-- GO
-- CREATE FUNCTION dbo.binomial(@n INTEGER, @p DOUBLE, @k INTEGER)  
-- RETURNS DOUBLE   
-- AS   
-- -- Returns the stock level for the product.  
-- BEGIN  
-- DECLARE @ret DOUBLE;

--     SET @ret = @p
--     RETURN @ret;  
-- END
-- END
-- ;
-- IF OBJECT_ID (N'dbo.ufnGetInventoryStock', N'FN') IS NOT NULL  
--     DROP FUNCTION ufnGetInventoryStock;  
-- GO  
-- CREATE FUNCTION dbo.ufnGetInventoryStock(@ProductID int)  
-- RETURNS int   
-- AS   
-- -- Returns the stock level for the product.  
-- BEGIN  
--     DECLARE @ret int;  
--     SELECT @ret = SUM(p.Quantity)   
--     FROM Production.ProductInventory p   
--     WHERE p.ProductID = @ProductID   
--         AND p.LocationID = '6';  
--      IF (@ret IS NULL)   
--         SET @ret = 0;  
--     RETURN @ret;  
-- END;
