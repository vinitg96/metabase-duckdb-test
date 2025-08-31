----------- silver.crm_cust_info

CREATE SCHEMA IF NOT EXISTS silver;

DROP TABLE IF EXISTS silver.crm_cust_info;
CREATE TABLE silver.crm_cust_info AS 


WITH cte_row_number AS (
    SELECT 
        *,
        ROW_NUMBER() OVER (PARTITION BY cst_id ORDER BY cst_create_date DESC) AS flag_last
    FROM bronze.crm_cust_info
    ORDER BY cst_id, CAST(cst_create_date AS DATE) DESC
)

SELECT
    CAST(TRIM(cst_id) AS INT) AS cst_id,
    TRIM(cst_key) as cst_key,
    TRIM(cst_firstname) AS cst_firstname,
    TRIM(cst_lastname) AS cst_lastname,
    CASE
        WHEN UPPER(cst_marital_status) = 'M' THEN 'Married'
        WHEN UPPER(cst_marital_status) = 'S' THEN 'Single'
        ELSE 'n/a'
    END AS cst_marital_status,
    CASE
        WHEN UPPER(cst_gndr) = 'M' THEN 'Male'
        WHEN UPPER(cst_gndr) = 'F' THEN 'Female'
        ELSE 'n/a'
    END AS cst_gndr,
    CAST(cst_create_date AS DATE) AS cst_create_date
FROM cte_row_number
WHERE flag_last = 1 AND cst_id IS NOT NULL;






