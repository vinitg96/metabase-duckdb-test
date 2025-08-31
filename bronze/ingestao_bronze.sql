
CREATE SCHEMA IF NOT EXISTS bronze;

DROP TABLE IF EXISTS bronze.crm_cust_info;
DROP TABLE IF EXISTS bronze.crm_prd_info;
DROP TABLE IF EXISTS bronze.crm_sales_details;
DROP TABLE IF EXISTS bronze.erp_loc_a101;
DROP TABLE IF EXISTS bronze.erp_cust_az12;
DROP TABLE IF EXISTS bronze.erp_px_cat_g1v2;


CREATE TABLE bronze.crm_cust_info AS
    SELECT * FROM read_csv('raw/source_crm/cust_info.csv', delim = ',', all_varchar = true);

CREATE TABLE bronze.crm_prd_info AS
    SELECT * FROM read_csv('raw/source_crm/prd_info.csv', delim = ',', all_varchar = true);

CREATE TABLE bronze.crm_sales_details AS
    SELECT * FROM read_csv('raw/source_crm/sales_details.csv', delim = ',', all_varchar = true);

CREATE TABLE bronze.erp_loc_a101 AS
    SELECT * FROM read_csv('raw/source_erp/LOC_A101.csv', delim = ',', all_varchar = true);

CREATE TABLE bronze.erp_cust_az12 AS
    SELECT * FROM read_csv('raw/source_erp/CUST_AZ12.csv', delim = ',', all_varchar = true);

CREATE TABLE bronze.erp_px_cat_g1v2 AS
    SELECT * FROM read_csv('raw/source_erp/PX_CAT_G1V2.csv', delim = ',', all_varchar = true);

