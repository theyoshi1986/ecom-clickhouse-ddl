--drop table default.dict_gln;
create table default.dict_gln
(gln Int64
,varname String
,varstreet String
,varcityregexp String
,intaccountid Int64
,geodata_id Int64
,name_rus String
,name_utf8 String
,latitude String
,longitude String
,admin1_code String
)
engine = MergeTree order by gln;

--»мпортируем данные
cat "/media/sf_projects/GLN_ќ ¬ЁƒФ/GLN дл€ clickhouse.csv" | clickhouse-client --format_csv_delimiter=";" --input_format_allow_errors_num=1000000000 --input_format_allow_errors_ratio=1 --query="INSERT INTO default.dict_gln FORMAT CSV";

select *
	from default.dict_gln;