SELECT table_name 
FROM information_schema.tables 
WHERE table_schema = 'bronze';

SELECT 
    cst_id,
    COUNT(*) 
FROM bronze.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 

-- verificar vazios 
SELECT * FROM bronze.crm_cust_info
WHERE cst_id IS NULL OR cst_key IS NULL OR cst_firstname IS NULL OR cst_create_date IS NULL;


-- verificar duplicatas e vazios
SELECT *
FROM bronze.crm_cust_info
WHERE cst_id IN (

    SELECT cst_id
    FROM bronze.crm_cust_info
    GROUP BY 1
    HAVING COUNT(*) > 1
)
OR cst_id IS NULL
ORDER BY cst_id, CAST(cst_create_date AS DATE) DESC;

-- verificar espaços vazios nas sstrings

SELECT *
FROM bronze.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname);



SELECT
    *
FROM bronze.crm_prd_info
WHERE prd_key IN (
    SELECT prd_key 
    FROM bronze.crm_prd_info
    GROUP BY prd_key
    HAVING COUNT(*) > 1
)
ORDER BY prd_key;


--produtos com datas inconsitentes

SELECT *
FROM
    bronze.crm_prd_info
WHERE 
    prd_key IN (
                SELECT 
                    prd_key,
                FROM 
                    bronze.crm_prd_info
                WHERE
                    CAST(prd_start_dt AS DATE) > CAST(prd_end_dt AS DATE)       
                )
ORDER BY prd_id
;




--- visualizar ajuste data -> definir end_dt apartir de start_date
WITH cte_lead AS (

    SELECT 
        prd_key,
        CAST(prd_start_dt AS DATE) AS prd_start_dt,
        CAST(prd_end_dt AS DATE) AS prd_end_dt,
        LEAD(CAST(prd_start_dt AS DATE)) OVER (PARTITION BY prd_nm ORDER BY CAST(prd_end_dt AS DATE)) - 1 AS prd_end_dt_adjusted
    FROM
        bronze.crm_prd_info
)

SELECT * FROM cte_lead WHERE prd_end_dt_adjusted IS NOT NULL ORDER BY prd_key, prd_end_dt ;