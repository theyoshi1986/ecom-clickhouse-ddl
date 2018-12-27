drop table default.docs_denormalized_data;

create table default.docs_denormalized_data
(
intDocID Int64,
intFromDocID Int64,
intTypeID Int64,
intStatusID Int64,
intOldDocID Int64,
varGln Int64,
intChainID Int64,
varIndex DateTime,
varCity String,
varCompanyName String,
varInnCode String,
varKpp String,
varGlnName String
)
engine = MergeTree partition by varIndex order by intDocID;

--Загружаем данные
cat /media/sf_projects/Finance/docs_denormalized_data.csv | clickhouse-client --format_csv_delimiter=";" --input_format_allow_errors_num=1000000000 --input_format_allow_errors_ratio=1 --query="INSERT INTO default.docs_denormalized_data FORMAT CSV";

--Проверяем
select count()
	from default.docs_denormalized_data;