-- Quality Check for CRM Product Details ( Bronze Layer )

Select * from bronze.crm_prd_info

-- Check for NUlls & Duplicates
-- Result: No Results
select prd_id, COUNT(*) from 
bronze.crm_prd_info group by prd_id having COUNT(*) > 1 or prd_id IS NULL

-- Check for unwanted Spaces
-- Result: NO Results
SElECT prd_nm FROM bronze.crm_prd_info WHERE prd_nm != TRIM(prd_nm)

-- Check for Nulls or Negative Numbers
-- Result: NO Results
SElECT prd_cost FROM bronze.crm_prd_info WHERE prd_cost < 0 OR prd_cost IS NULL

-- Data Standardization & Consistency
SELECT DISTINCT prd_line FROM bronze.crm_prd_info

-- Check for Invalid Date Orders
SELECT * FROM bronze.crm_prd_info WHERE prd_end_dt < prd_start_dt