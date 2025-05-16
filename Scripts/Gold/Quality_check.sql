SELECT DISTINCT
	ci.cst_gender ,
	ca.gen,
	CASE WHEN ci.cst_gender != 'n/a' THEN ci.cst_gender
	ELSE COALESCE(ca.gen, 'n/a')
	END AS new_gen
FROM silver.crm_cust_info ci
LEFT JOIN silver.erp_cust_az12 ca
on ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 la
on ci.cst_key = la.cid 
ORDER BY 1, 2

SELECT customer_id, COUNT(*) FROM
(
SELECT 
	ci.cst_id AS customer_id,
	ci.cst_key AS customer_key,
	ci.cst_firstname AS first_name,
	ci.cst_lastname AS last_name,
	ci.cst_material_status AS maritial_status,
	CASE WHEN ci.cst_gender != 'n/a' THEN ci.cst_gender
	ELSE COALESCE(ca.gen, 'n/a')
	END AS gender,
	ca.bdate AS birthdate,
	la.cntry AS country,
	ci.cst_create_date AS create_date
FROM silver.crm_cust_info ci
LEFT JOIN silver.erp_cust_az12 ca
on ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 la
on ci.cst_key = la.cid
)t GROUP BY customer_id
HAVING COUNT(*) > 1

SELECT prd_key, COUNT(*) FROM
(SELECT 
	pd.prd_id,
	pd.cat_id,
	pd.prd_key,
	pd.prd_nm,
	pd.prd_cost,
	pd.prd_line,
	pd.prd_start_dt,
	pc.cat,
	pc.subcat,
	pc.maintenance
FROM silver.crm_prd_info pd
LEFT JOIN silver.erp_px_cat_g1v2 pc
ON pd.cat_id = pc.id
WHERE prd_end_dt IS NULL
)t GROUP BY prd_key
HAVING COUNT(*) > 1

SELECT * FROM gold.dim_customers