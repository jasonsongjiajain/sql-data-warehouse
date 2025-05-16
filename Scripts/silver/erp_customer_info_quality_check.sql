-- Check see the integration id 
SELECT cid from bronze.erp_cust_az12
SELECT cst_id, cst_key from bronze.crm_cust_info

-- Check see the integration id 
SELECT bdate FROM bronze.erp_cust_az12
WHERE bdate < '1924-01-01' OR bdate > GETDATE()

-- Check Distinct values for Gender
SELECT DISTINCT gen from bronze.erp_cust_az12

-- Check the silver layer
SELECT * FROM silver.erp_cust_az12