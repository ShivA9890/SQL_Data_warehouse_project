create or alter procedure create_view_product_table as
begin

if object_id('gold.product_information','V') is not null
	drop view gold.product_information;

exec('create or alter view gold.product_information as
SELECT 
ROW_NUMBER() over (order by pr.prd_key , pr.prd_id) as product_id,
pr.prd_id as product_id_info,
pr.prd_key as product_key,
pr.id as product_key_id,
pr.cid as product_catogory_id,
pr.prd_name as product_name,
pr.prd_cost as product_cost,
px.cat as product_catogory,
px.subcat as product_subcatogory,
pr.prd_line as product_line,
px.maintenance as maintance,
pr.prd_start_date as product_start_date
FROM silver.prd_info pr 
LEFT JOIN silver.px_cat_g1v2 px ON pr.id = px.id;
')

end;
