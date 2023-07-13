"bits","abc","winrm" | Get-Service  2>> Save-Errors.txt 
Get-Help about_Redirection -ShowWindow

 "bits","abc","winrm" | Get-Service 2>> Save-Errors.txt 1>> Save-Output.txt 

 dir 'C:\', 'fakepath' 2>&1 > .\dir.log

 &{
       Write-Warning "hello"
       Write-Error "hello"
       Write-Output "hi"
    } 3>&1 2>&1 > C:\Temp\redirection.log


 $Error[0]

$Error[0].Exception.Message 
$Error.Clear()

Test-Connection fakeserver -Count 1 -ErrorVariable myError 
Test-Connection fakeserver -Count 1 -ErrorVariable myError -ErrorAction Ignore 
Get-Help about_Preference_Variables -ShowWindow


############Throw Keyword################
#$(throw "Enter TXT file path")
function Process-servicedata
{
    param($txt=$(throw "Enter TXT file path"))
    $services= Get-Content -Path $txt
    foreach ($service in $services)
    {
        Get-Service -Name $service
    }
    Write-Host "End of the function"
}

# $Error[0].Exception.ToString() 

function Process-servicedata
{
    param($txt=$(throw "Enter TXT file path"))
    Switch ($txt)
    {
        {$_ -isNot [String]}{throw "ERROR: Please specify a string vaule for the UserFile Parameter"}        
        {!(Test-Path $_)}{throw "ERROR: File not found"}       
        {(Get-Item -Path $_).Extension -ne '.txt'} {throw "ERROR: Please specify a txt file"}        
        default {Write-Host "Validation complete"} 
    }
    $services= Get-Content -Path $txt
    foreach ($service in $services)
    {
        try {
            # Code that interacts with a service
            Get-Service -Name $service -ErrorAction Stop
            Get-Process sdkaf -ErrorAction Stop
        }
        catch [Microsoft.PowerShell.Commands.ServiceCommandException] {
            Write-Host "$($_.exception.gettype())"
            "Service not found"
        }
        catch [Microsoft.PowerShell.Commands.ProcessCommandException]
        {
            Write-Host  "process not found"
        }
    }
    Write-Host "End of the function"
}



try {
    New-Item c:\temp1 -Name text.txt -ErrorAction Stop
}
catch [System.IO.DirectoryNotFoundException]
{
    Write-Host "Could not find a part of the path 'C:\temp1\text.txt'"
    New-Item -Path c:\ -Name temp1 -ItemType Directory
    New-Item c:\temp1 -Name text.txt
    Write-Host "created directory and added file"
}
#########trap###################


Trap [System.DivideByZeroException] {    #This is specific trap
    "Can not divide by ZERO!!!-->   " + $_.exception.message
    Continue
}
Trap  {#This is a generic catch all trap
    "A serious error occurred-->   " + $_.exception.message
    Continue
}
Write-Host -ForegroundColor Yellow "`nAttempting to Divide by Zero"
1 / $null
Write-Host -ForegroundColor Yellow "`nAttempting to find a fake file"
Get-Item c:\fakefile.txt -ErrorAction Stop
Write-Host -ForegroundColor Yellow "`nAttempting an invalid command"
1..10 | ForEach-Object {Bogus-Command}

