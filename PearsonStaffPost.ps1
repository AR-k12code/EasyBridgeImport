#2015-08-10 hjarrett created script
#2015-10-02 hjarrett added ToLower on Federated_id field
#

Import-Csv C:\scripts\importfiles\pearson_staff.csv `
|select staff_code, last_name, first_name, email, @{n="federated_id";e={$_.federated_id.ToLower()}} -ExcludeProperty federated_id `
|export-csv -NoTypeInformation C:\scripts\importfiles\STAFF.txt