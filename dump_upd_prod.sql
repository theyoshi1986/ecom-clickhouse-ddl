--Создаем таблицу
--drop table default.dump_upd_prod;
create table default.dump_upd_prod
(intDocID Int64,
Int64TypeID Int64,
upd_file_name String,
upd_number String,
upd_currency_code String,
upd_type String,
upd_file_create_time String,
upd_creator String,
upd_id_sender String,
upd_id_receiver String,
upd_format_version String,
upd_software_version String,
upd_sender String,
upd_recipient String,
upd_pos_order_number String,
upd_based_on_other String,
upd_pos_description String,
upd_date Date,
upd_file_create_date Date,
upd_order_date Date,
upd_order_number Int64,
upd_pos_amount_no_vat Int64,
upd_pos_amount_with_vat Int64,
upd_pos_number Int64,
upd_pos_product_num Int64,
upd_pos_quantity Int64,
upd_pos_unit_price_no_vat Int64,
upd_pos_vat Int64,
upd_recipient_gln Int64,
upd_sender_gln Int64,
upd_knd Int64,
upd_pos_unit_code Int64
)
engine = MergeTree partition by upd_order_date order by intDocID;

--truncate table default.dump_upd_prod;
select * from default.dump_upd_prod;

--Копируем данные. cmd
scp -i C:\Users\dmitriy.golovachev\Documents\id_golovachev_ed D:\projects\prod_docs_to_clickhouse_doctype_2-3-4-61-62-63\upd_0_.csv.gz golovachev@192.168.17.94:/home/golovachev/projects/prod_docs_to_clickhouse_doctype_2-3-4-61-62-63/
scp -i C:\Users\dmitriy.golovachev\Documents\id_golovachev_ed D:\projects\prod_docs_to_clickhouse_doctype_2-3-4-61-62-63\upd_1_.csv.gz golovachev@192.168.17.94:/home/golovachev/projects/prod_docs_to_clickhouse_doctype_2-3-4-61-62-63/
scp -i C:\Users\dmitriy.golovachev\Documents\id_golovachev_ed D:\projects\prod_docs_to_clickhouse_doctype_2-3-4-61-62-63\upd_2_.csv.gz golovachev@192.168.17.94:/home/golovachev/projects/prod_docs_to_clickhouse_doctype_2-3-4-61-62-63/

--Импортируем данные 0
cat /home/golovachev/projects/prod_docs_to_clickhouse_doctype_2-3-4-61-62-63/upd_0.csv | clickhouse-client --format_csv_delimiter=";" --input_format_allow_errors_num=1000000000 --input_format_allow_errors_ratio=1 --query="INSERT INTO default.dump_upd_prod FORMAT CSV";

--29 825 474
select count() from default.dump_upd_prod;

--Импортируем данные 1
cat /home/golovachev/projects/prod_docs_to_clickhouse_doctype_2-3-4-61-62-63/upd_1.csv | clickhouse-client --format_csv_delimiter=";" --input_format_allow_errors_num=1000000000 --input_format_allow_errors_ratio=1 --query="INSERT INTO default.dump_upd_prod FORMAT CSV";

-- примерно 59 398 949
select count() from default.dump_upd_prod;

--Импортируем данные 2
cat /home/golovachev/projects/prod_docs_to_clickhouse_doctype_2-3-4-61-62-63/upd_2.csv | clickhouse-client --format_csv_delimiter=";" --input_format_allow_errors_num=1000000000 --input_format_allow_errors_ratio=1 --query="INSERT INTO default.dump_upd_prod FORMAT CSV";

--67 619 814
select count() from default.dump_upd_prod;

---------------
-- Проверяем --
---------------

select *
	from `default`.dump_upd_prod
;
