--drop table default.dict_inn_gln_okved;
create table default.dict_inn_gln_okved
(inn Int64,
gln Int64,
okvedCode String,
okvedName String
)
engine = MergeTree order by gln;

--Импортируем данные
cat /media/sf_projects/GLN_ОКВЭД/dict_inn_gln_okved.csv | clickhouse-client --format_csv_delimiter=";" --input_format_allow_errors_num=1000000000 --input_format_allow_errors_ratio=1 --query="INSERT INTO default.dict_inn_gln_okved FORMAT CSV";

--Check load
--110 609 ok
select count(*)
	from default.dict_inn_gln_okved;
	
select *
	from default.dict_inn_gln_okved;