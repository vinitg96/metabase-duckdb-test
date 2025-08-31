CREATE SCHEMA IF NOT EXISTS silver;

DROP TABLE IF EXISTS silver.erp_px_cat_g1v2;
CREATE TABLE IF NOT EXISTS silver.erp_px_cat_g1v2 AS

SELECT 
    ID AS id,
    CAT AS cat,
    SUBCAT AS subcat,
    MAINTENANCE AS maintenance
FROM
    bronze.erp_px_cat_g1v2;