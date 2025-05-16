CREATE VIEW gold.dim_product AS
SELECT 
	ROW_NUMBER() OVER (ORDER BY pd.prd_start_dt, pd.prd_key) AS product_key,
	pd.prd_id AS product_id,
	pd.cat_id AS category_id,
	pd.prd_key AS product_number,
	pd.prd_nm AS product_name,
	pc.cat AS category, 
	pc.subcat AS subcategory,
	pc.maintenance,
	pd.prd_cost AS cost,
	pd.prd_line AS product_line, 
	pd.prd_start_dt AS start_date
FROM silver.crm_prd_info pd
LEFT JOIN silver.erp_px_cat_g1v2 pc
ON pd.cat_id = pc.id
WHERE prd_end_dt IS NULL