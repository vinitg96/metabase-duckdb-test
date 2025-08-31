CREATE SCHEMA IF NOT EXISTS silver;

DROP TABLE IF EXISTS silver.crm_prd_info;
CREATE TABLE IF NOT EXISTS silver.crm_prd_info AS 

SELECT
    CAST(prd_id AS INT) AS prd_id,
    REPLACE(SUBSTRING(TRIM(prd_key),1,5), '-', '_') AS cat_id,
    TRIM(prd_nm) AS prd_name,
    SUBSTRING(prd_key, 7, LEN(prd_key)) AS prd_key,
    COALESCE(CAST(prd_cost AS float), 0) AS prd_cost,
    CASE 
        WHEN UPPER(TRIM(prd_line)) = 'M' THEN 'Mountain'
        WHEN UPPER(TRIM(prd_line)) = 'R' THEN 'Road'
        WHEN UPPER(TRIM(prd_line)) = 'S' THEN 'Other Sales'
        WHEN UPPER(TRIM(prd_line)) = 'T' THEN 'Touring'
        ELSE 'n/a'
    END AS prd_line,
    CAST(prd_start_dt AS DATE) AS prd_start_dt,
    LEAD(CAST(prd_start_dt AS DATE)) OVER (PARTITION BY prd_key ORDER BY CAST(prd_end_dt AS DATE) ASC) -1 AS prd_end_dt

FROM 
    bronze.crm_prd_info
ORDER BY prd_id;