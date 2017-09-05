#2014-07-27 hjarrett created script
#2015-08-07 hjarrett changed file name
try
{
    # Load WinSCP .NET assembly
    Add-Type -Path "c:\scripts\WinSCP\WinSCPnet.dll"
 
    # Setup session options
    $sessionOptions = New-Object WinSCP.SessionOptions
    $sessionOptions.Protocol = [WinSCP.Protocol]::Sftp
    $sessionOptions.HostName = "SFTP.pifdata.net"
    $sessionOptions.UserName = "AUsername"
    $sessionOptions.Password = "APassword"
    $sessionOptions.SshHostKeyFingerprint = "ssh-rsa 2048 4c:fd:9f:b0:7d:be:43:a9:18:da:6a:5c:d5:94:4f:37"
	
 
    $session = New-Object WinSCP.Session
 
    try
    {
        # Connect
        $session.Open($sessionOptions)
 
        
        # Upload files
        $transferOptions = New-Object WinSCP.TransferOptions
        $transferOptions.TransferMode = [WinSCP.TransferMode]::Binary

        $transferResult = @()
 
        $transferResult += $session.PutFiles("C:\scripts\ImportFiles\tasd.zip", "SIS/tasd.zip", $False, $transferOptions)


 
        # Throw on any error
        $transferResult.Check()
 
        # Print results
        foreach ($transfer in $transferResult.Transfers)
        {
            Write-Host ("Upload of {0} succeeded" -f $transfer.FileName)
        }
    }
    finally
    {
        # Disconnect, clean up
        $session.Dispose()
    }
 
    exit 0
}
catch [Exception]
{
    Write-Host $_.Exception.Message
    exit 1
}
