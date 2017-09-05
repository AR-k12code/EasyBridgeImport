#2015-08-10 hjarrett created script
#2015-08-13 hjarrett Updated MPs
#2017-07-25 hjarrett updated MPs

#MP1
$datestartMP1 = "2017-08-14"
$dateendMP1   = "2017-10-13"
#MP2
$datestartMP2 = "2017-10-16"
$dateendMP2   = "2017-12-15"
#MP3
$datestartMP3 = "2018-01-02"
$dateendMP3   = "2018-03-09"
#MP4
$datestartMP4 = "2018-03-12"
$dateendMP4   = "2018-05-25"



#Correct Date format on DOB field inside select
#, @{label = 'DOB';expression={get-date $_.DOB -f 'yyyy-MM-dd'}} -ExcludeProperty DOB `
Import-Csv C:\scripts\importfiles\pearson_PIF_sections_staff.csv `
  | select @{n="section_teacher_code";e={$_.section_teacher_code +"_"+ $_.date_start +"_" + $_.section +"_"+ $_.staff_code +"_"+ $_.period}}, staff_code, @{n="native_section_code";e={$_.native_section_code +"_"+ $_.date_start +"_" + $_.section +"_"+$_.period}}, school_year, date_start, date_end, teacher_of_record -ExcludeProperty section,period `
  | % {


#datestart ifs
    if (($_.date_start) -eq "1" ) 
        { 
            ($_.date_start) = $datestartMP1
            ($_.date_end) = $dateendMP1
        }
    if (($_.date_start) -eq "2" ) 
        { 
            ($_.date_start) = $datestartMP2
            ($_.date_end) = $dateendMP2
        }
    if (($_.date_start) -eq "3" ) 
        { 
            ($_.date_start) = $datestartMP3
            ($_.date_end) = $dateendMP3
        }
    if (($_.date_start) -eq "4" ) 
        { 
            ($_.date_start) = $datestartMP4
            ($_.date_end) = $dateendMP4
        }
   
    $_.teacher_of_record = $_.teacher_of_record.replace("Y","true")  
    $_
  }  |export-csv -NoTypeInformation C:\scripts\importfiles\PIF_SECTION_STAFF.txt