create or alter procedure create_view_customer_information 
as
begin 

if object_id('gold.customer_information','V') is not null
	drop view gold.customer_information;

exec('create or alter view gold.customer_information as
select 
row_number() over( order by c.cst_id) as id,
c.cst_id as customer_id,
c.cst_key as customer_key,
c.cst_firstName as customer_firstName,
c.cst_lastName as customer_lastname,
c.cst_marital_status as customer_marital_status,
case when c.csr_gndr != "n/a" then c.csr_gndr
else a.gen 
end as gender,
l.cntry as customer_country,
a.bdate as customer_birthdate,
c.cst_create_date as creation_date
from silver.cust_info c left join silver.cust_az12 a on c.cst_key = a.cid
left join silver.loc_a101 l on c.cst_key = l.cid;
')
end
