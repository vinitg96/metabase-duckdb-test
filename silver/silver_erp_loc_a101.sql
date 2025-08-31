CREATE SCHEMA IF NOT EXISTS silver;

DROP TABLE IF EXISTS silver.erp_loc_a101;
CREATE TABLE IF NOT EXISTS silver.erp_loc_a101 AS 

SELECT 
    TRIM(REPLACE(CID, '-','')) AS cid,
    CASE
        WHEN UPPER(TRIM(CNTRY)) = 'DE' THEN 'Germany'
        WHEN UPPER(TRIM(CNTRY)) IN ('USA', 'US') THEN 'United States'
        WHEN TRIM(CNTRY)= '' OR CNTRY IS NULL THEN 'n/a'
        ELSE TRIM(CNTRY)
END AS cntry
FROM bronze.erp_loc_a101;