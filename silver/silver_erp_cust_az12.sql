CREATE SCHEMA IF NOT EXISTS silver;

DROP TABLE IF EXISTS silver.erp_cust_az12;
CREATE TABLE IF NOT EXISTS silver.erp_cust_az12 AS 

SELECT 
    CASE 
        WHEN CID LIKE 'NAS%' THEN SUBSTRING(CID, 4, LEN(CID))
        ELSE CID
    END AS cid,
    CASE
        WHEN CAST(BDATE AS DATE) > CURRENT_DATE THEN NULL
        ELSE CAST(BDATE AS DATE)
    END AS bdate,
    CASE
        WHEN UPPER(TRIM(GEN)) IN ('F','FEMALE') THEN 'Female'
        WHEN UPPER(TRIM(GEN)) IN ('M','MALE') THEN 'Male'
        ELSE 'n/a'
    END AS gen

FROM bronze.erp_cust_az12;