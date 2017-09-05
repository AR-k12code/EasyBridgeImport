#2016-04-07 hjarrett - created script
#2016-08-13 hjarrett - updated dates
#2017-07-25 hjarrett - updated dates
#

#
$currentYear = "2017"
$date_start = "2017-08-14"


#Correct Date format on DOB field inside select
#, @{label = 'DOB';expression={get-date $_.DOB -f 'yyyy-MM-dd'}} -ExcludeProperty DOB `
Import-Csv C:\scripts\importfiles\pearson_staff.csv `
  | select @{n="native_assignment_code";e={$_.staff_code +"_"+ $currentYear +"_" + $_.building }}, staff_code, @{n="school_year";e={$currentYear}}, @{n="institution_code";e={$_.building}}, @{n="date_start";e={$date_start}} -ExcludeProperty last_name,first_name,email,federated_id `
  | export-csv -NoTypeInformation C:\scripts\importfiles\ASSIGNMENT.txt