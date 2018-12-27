--drop table default.stg_datamart_billing;

create table default.stg_datamart_billing
(intRecID	Int64,
varSenderGLN	String,
varRecipientGLN	String,
transactionDate	Date,
transactionDateTime	DateTime,
intTypeID	Int64,
senderGlnName	String,
senderGlnAccountID	Int64,
senderGlnRetailerID	Int64,
senderGlnSapCode	String,
senderAccountType	String,
senderCurrencyID	Int64,
senderAccountIsUZD	Int8,
senderAccountCompanyName	String,
senderKppCode	String,
senderInnCode	String,
senderAccountStatus	String,
senderRetailerName	String,
senderRetailerType	String,
senderRetailerID	Int64,
recipientGlnName	String,
recipientGlnAccountID	Int64,
recipientGlnRetailerID	Int64,
recipientGlnSapCode	String,
recipientAccountType	String,
recipientCurrencyID	Int64,
recipientAccountIsUZD	Int8,
recipientAccountCompanyName	String,
recipientKppCode	String,
recipientInnCode	String,
recipientAccountStatus	String,
recipientRetailerName	String,
recipientRetailerType	String,
recipientRetailerID	Int64,
docTypeName	String
)
engine = MergeTree partition by transactionDate order by intRecID;

--truncate table default.stg_datamart_billing;
select * from default.stg_datamart_billing;

--Импортируем данные 0
cat /media/sf_projects/Billing/stage/dataMart.csv | clickhouse-client --format_csv_delimiter=";" --input_format_allow_errors_ratio=1 --query="INSERT INTO default.stg_datamart_billing FORMAT CSV";