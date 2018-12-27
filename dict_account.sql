--drop table default.dict_account;
create table default.dict_account
(intAccountID Int64
,varCompanyName String
,varAddress String
)
engine = MergeTree order by intAccountID;

--Копируем данные
scp -i C:\Users\dmitriy.golovachev\Documents\id_golovachev_ed D:\projects\prod_docs_to_clickhouse_doctype_2-3-4-61-62-63\accounts_0.csv golovachev@192.168.17.94:/home/golovachev/projects/prod_docs_to_clickhouse_doctype_2-3-4-61-62-63/

--Импортируем данные
cat /media/sf_projects/prod_docs_to_clickhouse_doctype_2-4-61-62-63/accounts_0.csv | clickhouse-client --format_csv_delimiter=";" --input_format_allow_errors_num=1000000000 --input_format_allow_errors_ratio=1 --query="INSERT INTO default.dict_account FORMAT CSV";
cat /home/golovachev/projects/prod_docs_to_clickhouse_doctype_2-3-4-61-62-63/accounts_0.csv | clickhouse-client --format_csv_delimiter=";" --input_format_allow_errors_num=1000000000 --input_format_allow_errors_ratio=1 --query="INSERT INTO default.dict_account FORMAT CSV";

select *
	from default.dict_account;