--drop table default.del_me_dump_desadv_glns_list;
create table default.del_me_dump_desadv_glns_list
(desadv_ord_number String,
desadv_ord_date String,
desadv_number String,
desadv_delivery_date String,
desadv_delivery_time String,
desadv_deliv_note_num String,
desadv_deliv_note_date String,
desadv_date String,
desadv_packages_amount String,
desadv_info String,
desadv_doctype String,
desadv_version String,
desadv_supplier_gln String,
desadv_supplier_name String,
desadv_buyer_gln String,
desadv_buyer_code String,
desadv_deliv_place String,
desadv_final_recipient_gln String,
desadv_sender String,
desadv_sender_name String,
desadv_sender_city String,
desadv_sender_address String,
desadv_sender_phone String,
desadv_recepient String
)
engine = MergeTree order by desadv_buyer_gln;

--Импортируем данные
cat /media/sf_projects/prod_docs_to_clickhouse_doctype_2-4-61-62-63/desadv_0.csv | clickhouse-client --format_csv_delimiter=";" --input_format_allow_errors_num=1000000000 --input_format_allow_errors_ratio=1 --query="INSERT INTO default.del_me_dump_desadv_glns_list FORMAT CSV";

select count()
	from default.del_me_dump_desadv_glns_list;