#2015-08-10 hjarrett - created script
#2016-04-08 hjarrett - chanaged name of file to all CAPS

$hash = @{}
Get-ADUser -SearchBase "OU=Students,DC=domain,dc=local" -Filter {mail -like '*' } -Properties mail | select SamAccountName, mail | % {$hash[$_.SamAccountName] = $_.mail}

Import-Csv C:\scripts\importfiles\pearson_student.csv `
| select student_code, last_name,first_name, middle_name, gender_code, dob, @{n='email';e={}}, federated_id , @{label = 'dob';expression={get-date $_.dob -f 'yyyy-MM-dd'}} -ExcludeProperty dob  `
| % {
    if ( $hash.ContainsKey($_.Student_code) ) {
      $_.email = $hash[$_.Student_code]
    }
    $_
  }  | export-csv -NoTypeInformation C:\scripts\importfiles\STUDENT.txt