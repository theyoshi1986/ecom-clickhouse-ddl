--drop table default.dict_gtin_groups_bread;
create table default.dict_gtin_groups_bread
(gtin Int64
,group_name String
,match_word String
,group_id Int32
,pos_name String
,weight_gramm Int64)
engine = MergeTree order by gtin;

--Импортируем данные
cat "/media/sf_projects/prod_docs_to_clickhouse_doctype_2-4-61-62-63/dict_gtin_groups_bread.csv" | clickhouse-client --format_csv_delimiter=";" --input_format_allow_errors_num=1000000000 --input_format_allow_errors_ratio=1 --query="INSERT INTO default.dict_gtin_groups_bread FORMAT CSV";

select *
	from default.dict_gtin_groups_bread;