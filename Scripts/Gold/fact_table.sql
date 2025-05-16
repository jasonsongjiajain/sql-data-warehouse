CREATE VIEW gold.facts_table AS
SELECT 
sd.sls_ord_num AS order_number, 
pr.product_key, 
cu.customer_key, 
sd.sls_order_dt AS order_date, 
sd.sls_ship_dt AS shipping_date, 
sd.sls_due_dt AS due_date, 
sd.sls_sales AS sales_amount, 
sd.sls_quantity AS quanity, 
sd.sls_price price 
FROM silver.crm_sales_details sd 
LEFT JOIN gold.dim_product pr 
ON sd.sls_prd_key = pr.product_number 
LEFT JOIN gold.dim_customers cu 
ON sd.sls_cust_id = cu.customer_id
