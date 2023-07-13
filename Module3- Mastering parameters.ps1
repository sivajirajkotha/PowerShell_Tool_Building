#function with Parameter attribute syntax
function Invoke-ExampleFunction {
    [CmdletBinding()]
    Param (
        #[parameter(Argument1='value1', Argument2='value2')]
        $ParameterName
    )

    # Access and use the provided parameter values
    Write-Host "Argument1: $($ParameterName.Argument1)"
    Write-Host "Argument2: $($ParameterName.Argument2)"
}



#Invoke-ExampleFunction -ParameterName @{ 'Argument1' = 'Hello'; 'Argument2' = 'World' } 
#############################################################################################

#function with parameter sets
function Invoke-ExampleFunction {
    [CmdletBinding(DefaultParameterSetName='Parameter Set 1',
                  SupportsShouldProcess=$true,
                  PositionalBinding=$false,
                  HelpUri='http://www.example.com/',
                  ConfirmImpact='High')]
    param (
        [Parameter(Mandatory=$true, ParameterSetName='Parameter Set 1',HelpMessage= "Test")]
        [string]$Name,

        [Parameter(ParameterSetName='Parameter Set 2')]
        [switch]$Force
    )

    # Perform the operation
    if ($PSCmdlet.ShouldProcess($Name, "Performing example operation")) {
        # The code to execute the operation goes here
        Write-Host "Executing example operation for $Name"
    }
}


function Invoke-ExampleFunction {
    [CmdletBinding(DefaultParameterSetName='Parameter Set 1',
                  SupportsShouldProcess=$true,
                  PositionalBinding=$false,
                  HelpUri='http://www.example.com/',
                  ConfirmImpact='High')]
    param (
        [Parameter(Mandatory=$true, ParameterSetName='Parameter Set 1')]
        [string]$Name,

        [Parameter(Mandatory=$true, ParameterSetName='Parameter Set 2')]
        [switch]$Force
    )

    # Check if parameters from different sets are passed together
    if ($PSCmdlet.ParameterSetName -eq 'Parameter Set 1' -and !$Force.IsPresent) {
        "parameterset1"
        #Write-Error "You must provide the -Force parameter when using Parameter Set 1."
        return
    }

    if ($PSCmdlet.ParameterSetName -eq 'Parameter Set 2' -and (-not $Name)) {
        ##Write-Error "You must provide the -Name parameter when using Parameter Set 2."
        "parameterset2"
        return
    }

    # Perform the operation
    if ($PSCmdlet.ShouldProcess($Name, "Performing example operation")) {
        # The code to execute the operation goes here
        Write-Host "Executing example operation for $Name"
    }
}

###############################################################################################

######Mandatory and positional parameters
function get-uptime {
    $var = Get-CimInstance -ClassName Win32_OperatingSystem
    $var1=(Get-Date)-($var.LastBootUpTime)
    Write-Host "Uptime: $($var1.days)Days $($var1.hours)hours $($Var1.Minutes)Minutes"
}

function Get-Uptime 
{
    param($computername)
    $OS = Get-WmiObject win32_operatingsystem -ComputerName $computername -ErrorAction Continue
    $BootTime = $OS.ConvertToDateTime($OS.LastBootUpTime)
    $Uptime = $OS.ConvertToDateTime($OS.LocalDateTime) - $boottime
    $Display = "$computername Uptime: " + $Uptime.Days + " days, " + $Uptime.Hours + " hours, " + $Uptime.Minutes + " minutes"
    Write-Host $Display
 }

####Function for NoValueFromRemainingArguments
 function NoValueFromRemainingArguments {
  Param($Surname,$GivenName,$MiddleOrOther)  

  "`$Surname $Surname"
  "`$GivenName $GivenName"
  "`$MiddleOrOther $MiddleOrOther“

}

NoValueFromRemainingArguments Jane Doe Sally Smith

####function for ValueFromRemainingArguments
function ValueFromRemainingArguments {
    Param(
        [Parameter(Mandatory=$true)]
        $Surname,
        
        [Parameter(Mandatory=$true)]
        $GivenName,
        
        [Parameter(Mandatory=$false, ValueFromRemainingArguments=$true)]
        $MiddleOrOther
    )

    Write-Host "`$Surname $Surname"
    Write-Host "`$GivenName $GivenName"
    Write-Host "`$MiddleOrOther $MiddleOrOther"
}

ValueFromRemainingArguments -surname "Smith" -givenname "John" "Doe" "Additional" "Arguments"


####Parameter Validation Attributes
####[Alias()] Attribute
function Get-Uptime 
{
    Param ([parameter()][alias("CN","MachineName""Laptop",“Device")]
    [String[]]$ComputerName)

    $OS = Get-WmiObject win32_operatingsystem -ComputerName $computername -ErrorAction Continue
    $BootTime = $OS.ConvertToDateTime($OS.LastBootUpTime)
    $Uptime = $OS.ConvertToDateTime($OS.LocalDateTime) - $boottime
    $Display = "$computername Uptime: " + $Uptime.Days + " days, " + $Uptime.Hours + " hours, " + $Uptime.Minutes + " minutes"
    Write-Host $Display
 }

 ######[ValidateSet()] Attribute
function Get-Uptime 
{
    Param ([parameter()][alias("CN","MachineName""Laptop",“Device")]
    [ValidateSet("localhost",".")]
    [String[]]$ComputerName)

    $var = Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName $ComputerName
    $var1=(Get-Date)-($var.LastBootUpTime)
    Write-Host "Uptime: $($var1.days)Days $($var1.hours)hours $($Var1.Minutes)Minutes"
 }


 #########[ValidateNotNull()]

 function Get-Uptime 
{
    Param ([parameter()][alias("CN","MachineName""Laptop",“Device")]
    [ValidateSet("localhost",".")]
    #[ValidateNotNull()]
    #[ValidateNotNullOrEmpty()]
    [ValidateCount(1,5)][String[]]
    [ValidateLength(1,5)]
    [String[]]$ComputerName)

    $OS = Get-WmiObject win32_operatingsystem -ComputerName $computername -ErrorAction Continue
    $BootTime = $OS.ConvertToDateTime($OS.LastBootUpTime)
    $Uptime = $OS.ConvertToDateTime($OS.LocalDateTime) - $boottime
    $Display = "$computername Uptime: " + $Uptime.Days + " days, " + $Uptime.Hours + " hours, " + $Uptime.Minutes + " minutes"
    Write-Host $Display
 }


  ############ValidateRange
 function Invoke-ExampleFunction {
    Param (
        [ValidateRange(0, 10)]
        [int]$Attempts
    )

    Write-Host "Attempts: $Attempts"
}

 #########ValidateScript
 function test {
 Param (
    [ValidateScript({$_ -ge (Get-Date)})]
    [DateTime]$EventDate
)

Write-Host "Event Date: $EventDate"

 
 }



 function Get-ExampleInfo {
    Param (
        [ValidatePattern("^comp.*")]
        [string[]]$ComputerName
    )

    foreach ($Computer in $ComputerName) {
        Write-Host "Getting info for computer: $Computer"
        # Perform actions for each computer here
    }
}


Function Kill-Process
{
    [CmdletBinding(SupportsShouldProcess=$true,ConfirmImpact='medium')]
    Param([String]$Name)

    $TargetProcess = Get-Process -Name $Name
    If ($pscmdlet.ShouldProcess($name, "Terminating Process"))
    {
        $TargetProcess.Kill()
    }
} 
