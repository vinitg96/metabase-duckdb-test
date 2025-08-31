
CREATE SCHEMA IF NOT EXISTS silver;

DROP TABLE IF EXISTS silver.crm_sales_details;
CREATE TABLE IF NOT EXISTS silver.crm_sales_details AS 

SELECT
    sls_ord_num,
    sls_prd_key,
    CAST(sls_cust_id AS INT) AS sls_cust_id,
    CASE
        WHEN sls_order_dt = '0' OR len(sls_order_dt) !=8 THEN NULL
        ELSE CAST(STRPTIME(sls_order_dt, '%Y%m%d') AS DATE)
    END AS sls_order_dt,
    CASE 
        WHEN sls_ship_dt = '0' OR len(sls_ship_dt) !=8 THEN NULL
        ELSE CAST(STRPTIME(sls_ship_dt, '%Y%m%d') AS DATE) 
    END AS sls_ship_dt,
    CASE 
        WHEN sls_due_dt = '0' OR len(sls_due_dt) !=8 THEN NULL
        ELSE CAST(STRPTIME(sls_due_dt, '%Y%m%d') AS DATE) 
    END AS sls_due_dt,
    CASE
        WHEN CAST(sls_sales AS FLOAT) <= 0 OR CAST(sls_sales AS FLOAT) IS NULL OR
        CAST(sls_sales AS FLOAT) != CAST(sls_quantity AS FLOAT) * CAST(sls_price AS FLOAT) THEN CAST(sls_quantity AS FLOAT) * CAST(sls_price AS FLOAT)
        ELSE CAST(sls_sales AS FLOAT)
    END AS sls_sales,
    sls_quantity,
    CASE
        WHEN CAST(sls_price AS FLOAT) IS NULL OR CAST(sls_price AS FLOAT) <= 0 THEN CAST(sls_sales AS FLOAT) / COALESCE(CAST(sls_quantity AS FLOAT), 0)
        ELSE CAST(sls_price AS FLOAT)
    END AS sls_price

FROM
    bronze.crm_sales_details;


