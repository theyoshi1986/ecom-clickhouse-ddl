--drop table default.datamart_billing;

create table default.datamart_billing engine = MergeTree partition by transactionDate order by intRecID
as
select intRecID,
varSenderGLN gln,
transactionDate,
transactionDateTime,
docTypeName,
senderGlnName glnName,
senderGlnAccountID AccountID,
recipientRetailerID RetailerID,
senderGlnSapCode SapCode,
senderAccountType accountType,
senderCurrencyID currencyID,
senderAccountIsUZD isUZD,
senderAccountCompanyName accountCompanyName,
senderKppCode kppCode,
senderInnCode innCode,
senderAccountStatus accountStatus,
recipientRetailerName retailerName,
recipientRetailerType retailerType
	from default.stg_datamart_billing
union all
select intRecID,
varRecipientGLN GLN,
transactionDate,
transactionDateTime,
docTypeName,
recipientGlnName,
recipientGlnAccountID,
senderGlnRetailerID,
recipientGlnSapCode,
recipientAccountType,
recipientCurrencyID,
recipientAccountIsUZD,
recipientAccountCompanyName,
recipientKppCode,
recipientInnCode,
recipientAccountStatus,
senderRetailerName,
senderRetailerType
	from default.stg_datamart_billing;