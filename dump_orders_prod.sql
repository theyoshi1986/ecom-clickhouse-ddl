--Создаем таблицу
--drop table default.dump_orders_prod;
create table default.dump_orders_prod
(intDocID Int64,
ord_number String,
ord_delivery_time String,
ord_contract_number String,
ord_type String,
ord_currency String,
ord_transportation String,
ord_trans_route String,
ord_doctype String,
ord_version Int64,
ord_deliv_place Int64,
pos_unit_name String,
pos_condition_status String,
pos_description String,
ord_blanc_ord_num Int64,
ord_buyer_gln Int64,
ord_date Date,
ord_delivery_date Date,
ord_earliest_delivery_date Date,
ord_latest_delivery_date Date,
ord_shipment_date Date,
ord_supplier_gln Int64,
ord_vat Int64,
pos_number Int64,
pos_orderedquantity_x1k Int64,
pos_orderedquantity_box_x1k Int64,
pos_price_no_vat_x01k Int64,
pos_price_with_vat_x01k Int64,
pos_product_num Int64,
pos_units_in_box Int64,
pos_vat Int64
)
engine = MergeTree partition by ord_date order by intDocID;

--truncate table default.dump_orders_prod;
select * from default.dump_orders_prod;

--Импортируем данные 0
cat /project/prod_docs_to_clickhouse_doctype_2-61-62-63/orders_0.csv | clickhouse-client --format_csv_delimiter=";" --host clickhouse-server --input_format_allow_errors_num=1000000000 --input_format_allow_errors_ratio=1 --query="INSERT INTO default.dump_orders_prod FORMAT CSV";
cat /media/sf_projects/prod_docs_to_clickhouse_doctype_2-61-62-63/orders_0.csv | clickhouse-client --format_csv_delimiter=";" --input_format_allow_errors_num=1000000000 --input_format_allow_errors_ratio=1 --query="INSERT INTO default.dump_orders_prod FORMAT CSV";

--29 629 596
select count() from default.dump_orders_prod;

--Импортируем данные 1
cat /project/prod_docs_to_clickhouse_doctype_2-61-62-63/orders_1.csv | clickhouse-client --format_csv_delimiter=";" --host clickhouse-server --input_format_allow_errors_num=1000000000 --input_format_allow_errors_ratio=1 --query="INSERT INTO default.dump_orders_prod FORMAT CSV";
cat /media/sf_projects/prod_docs_to_clickhouse_doctype_2-61-62-63/orders_1.csv | clickhouse-client --format_csv_delimiter=";" --input_format_allow_errors_num=1000000000 --input_format_allow_errors_ratio=1 --query="INSERT INTO default.dump_orders_prod FORMAT CSV";

--59 284 298
select count() from default.dump_orders_prod;

--Импортируем данные 2
cat /project/prod_docs_to_clickhouse_doctype_2-61-62-63/orders_2.csv | clickhouse-client --format_csv_delimiter=";" --host clickhouse-server --input_format_allow_errors_num=1000000000 --input_format_allow_errors_ratio=1 --query="INSERT INTO default.dump_orders_prod FORMAT CSV";
cat /media/sf_projects/prod_docs_to_clickhouse_doctype_2-61-62-63/orders_2.csv | clickhouse-client --format_csv_delimiter=";" --input_format_allow_errors_num=1000000000 --input_format_allow_errors_ratio=1 --query="INSERT INTO default.dump_orders_prod FORMAT CSV";

--88 920 526
select count() from default.dump_orders_prod;

--Импортируем данные 3
cat /project/prod_docs_to_clickhouse_doctype_2-61-62-63/orders_3.csv | clickhouse-client --format_csv_delimiter=";" --host clickhouse-server --input_format_allow_errors_num=1000000000 --input_format_allow_errors_ratio=1 --query="INSERT INTO default.dump_orders_prod FORMAT CSV";
cat /media/sf_projects/prod_docs_to_clickhouse_doctype_2-61-62-63/orders_3.csv | clickhouse-client --format_csv_delimiter=";" --input_format_allow_errors_num=1000000000 --input_format_allow_errors_ratio=1 --query="INSERT INTO default.dump_orders_prod FORMAT CSV";

--111 707 697
select count() from default.dump_orders_prod;

---------------
-- Тестируем --
---------------

select toStartOfMonth(ord1.ord_date)
,count(1) cnt
,sum(ord1.pos_price_no_vat_x01k/100) prcNoVat
,sum(ord1.pos_price_with_vat_x01k/100) prcWVat
,sum(ord1.pos_price_with_vat_x01k ord1.pos_price_no_vat_x01k) prcWVat2
	from default.dump_orders_prod ord1
		any inner join default.dump_orders_prod ord2
			using intDocID
		where ord1.ord_date >= '2017-07-01'
group by toStartOfMonth(ord1.ord_date)
order by 1;

select topK(8)(pos_price_no_vat_x01k)
	from default.dump_orders_prod
		where pos_product_num = 0;
	
select toStartOfMonth(ord1.ord_date) dt
,countIf(ord1.pos_price_no_vat_x01k<0) cntIf
,sum(ord1.pos_price_no_vat_x01k/100) prcNoVat
,sum(ord2.pos_price_with_vat_x01k/100) prcWVat
,sum(ord2.pos_price_with_vat_x01k*ord1.pos_price_no_vat_x01k) prcWVat2
	from default.dump_orders_prod ord1
		any inner join default.dump_orders_prod ord2
			using intDocID
		where ord1.ord_date >= '2017-07-01'
group by toStartOfMonth(ord1.ord_date)
order by 1;
