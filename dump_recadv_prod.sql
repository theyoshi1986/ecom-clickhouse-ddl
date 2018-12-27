--Создаем таблицу
--drop table default.dump_recadv_prod;

create table default.dump_recadv_prod
(recadv_date Date,
recadv_deliv_note_date Date,
recadv_ord_date Date,
recadv_reception_date Date,
intDocID Int64,
recadv_buyer_gln Int64,
recadv_deliv_place Int64,
recadv_packages_amount Int64,
recadv_pos_acceptedquantity Int64,
recadv_pos_amount_no_vat_x01k Int64,
recadv_pos_amount_with_vat_x01k Int64,
recadv_pos_deliveredquantity_x1k Int64,
recadv_pos_deltaquantity_x1k Int64,
recadv_pos_number Int64,
recadv_pos_orderedquantity_x1k Int64,
recadv_pos_price_no_vat_x01k Int64,
recadv_pos_price_with_vat_x01k Int64,
recadv_pos_product_num Int64,
recadv_supplier_gln Int64,
recadv_pos_vat Int64,
recadv_deliv_note_num String,
recadv_doctype String,
recadv_info String,
recadv_number String,
recadv_ord_number String,
recadv_pos_condition_status String,
recadv_pos_description String,
recadv_version String
)
engine = MergeTree partition by recadv_date order by intDocID;

--truncate table default.dump_recadv_prod;
select * from default.dump_recadv_prod;

--Всего 67 073 925 строк на 24.09.2018
--Импортируем данные 0
cat /media/sf_projects/prod_docs_to_clickhouse_doctype_2-3-4-61-62-63/recadv_0.csv | clickhouse-client --format_csv_delimiter=";" --input_format_allow_errors_num=1000000000 --input_format_allow_errors_ratio=1 --query="INSERT INTO default.dump_recadv_prod FORMAT CSV";

--29 999 592
select count() from default.dump_recadv_prod;

cat /media/sf_projects/prod_docs_to_clickhouse_doctype_2-3-4-61-62-63/recadv_1.csv | clickhouse-client --format_csv_delimiter=";" --input_format_allow_errors_num=1000000000 --input_format_allow_errors_ratio=1 --query="INSERT INTO default.dump_recadv_prod FORMAT CSV";

--59 998 910
select count() from default.dump_recadv_prod;

cat /media/sf_projects/prod_docs_to_clickhouse_doctype_2-3-4-61-62-63/recadv_2.csv | clickhouse-client --format_csv_delimiter=";" --input_format_allow_errors_num=1000000000 --input_format_allow_errors_ratio=1 --query="INSERT INTO default.dump_recadv_prod FORMAT CSV";

--67 072 619
select count() from default.dump_recadv_prod;