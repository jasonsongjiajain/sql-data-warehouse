-- Quality Check

SELECT * from bronze.erp_px_cat_g1v2
SELECT * from silver.crm_prd_info

SELECT 
id, 
cat, 
subcat,
maintenance
FROM 
bronze.erp_px_cat_g1v2

-- Check for unwanted spaces
SELECT * from bronze.erp_px_cat_g1v2
WHERE cat != TRIM(cat) OR subcat != TRIM(subcat) OR maintenance != TRIM(maintenance) 

-- Data Standardization & Consistency
SELECT 
DISTINCT maintenance
from bronze.erp_px_cat_g1v2