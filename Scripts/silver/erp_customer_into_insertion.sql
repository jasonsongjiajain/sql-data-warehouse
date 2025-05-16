-- Check see the integration id 
TRUNCATE TABLE silver.erp_cust_az12 
INSERT INTO silver.erp_cust_az12 (
	cid, 
	bdate, 
	gen
)
SELECT
CASE WHEN cid like 'NAS%' THEN SUBSTRING(cid, 4, len(cid))
	ELSE cid
END AS cid,
CASE WHEN bdate > GETDATE() THEN NULL
	ELSE bdate
END AS bdate,
CASE WHEN UPPER(TRIM(gen)) IN ('F', 'Female') THEN 'Female'
	WHEN UPPER(TRIM(gen)) IN ('M', 'Male') THEN 'Male'
	ELSE 'n/a'
END AS gen
from bronze.erp_cust_az12