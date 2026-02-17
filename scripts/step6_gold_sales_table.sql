create or alter procedure create_view_sales_table 
as
begin 

if object_id('gold.sales_table','V') is not null
	drop view gold.sales_table;

exec('create or alter view gold.sales_table as 
select  
si.sls_odr_no as Order_number,
cio.customer_id as customer_id,
pio.product_catogory_id as Product_catogory,
si.sls_order_date as Order_date,
si.sls_ship_date as Shipping_date,
si.sls_due_date as Due_date,
si.sls_sales as Sales_amount,
si.sls_quantity as Quantity,
si.sls_price as price
from silver.sales_info si
left join gold.product_information pio 
on si.sls_prt_key = pio.product_catogory_id 
left join gold.customer_information cio 
on si.sls_cust_id = cio.customer_id ;
')
end;