
#Simple  function
function test-function 
{
    Get-Date | ft
    Get-Service BITS
    Get-Process powershell
}

#Function with Parameters-Type1
function test-function1 ($ser,$proc)
{
    Get-Date | ft
    Get-Service $ser
    Get-Process $proc  
}
#Function with Parameters-Type2

function test-function2 
{
    param($ser,$proc)
    Get-Date | ft
    Get-Service $ser
    Get-Process $proc  
}

#Utility Function- Long command(s) can be turned into a function to simplify future use

Get-EventLog -LogName System -ComputerName . -Newest 5 -Source "USER32" | Select-Object Index,TimeGenerated,Message |Format-Table -AutoSize -Wrap

function Get-Myevents 
{
    Get-EventLog -LogName System -ComputerName . -Newest 5 -Source "USER32"| Select-Object Index,TimeGenerated,Message|Format-Table -AutoSize -Wrap
}

#Utility Function-with parameters
function Get-Myevents1
{
    param($logname,$computer,$nooflogs)
    Get-EventLog -LogName $logname -ComputerName $computer -Newest $nooflogs -Source "USER32"| Select-Object Index,TimeGenerated,Message|Format-Table -AutoSize -Wrap
}

#Function with $args parameter
#The [Parameter(ValueFromRemainingArguments = $true)] attribute in the function's parameter declaration is used to indicate that the parameter should accept any number of arguments that are not explicitly bound to other parameters.

function Process-Arguments {
    <#param (
        [Parameter(ValueFromRemainingArguments = $true)]
        $args
    )#>

    # Process each argument
    foreach ($arg in $args) {
        Write-Host "Argument: $arg"
    }
}


function add-numbers {
    <#param (
        [Parameter(ValueFromRemainingArguments = $true)]
        $args
    )#>
    $sum=0
    # Process each argument
    foreach ($arg in $args) {
        $sum =$sum+$arg
    }
    $sum
}


#Function with Named Parameters

function add-numbers1 
{
    param([array]$values)
    $sum=0
    foreach ($item in $values)
    {
        $sum= $sum+$item
    }
    $sum
}

#function with switch parameter

function SwitchExample {
   Param([switch]$state)
   if ($state) {"on"} else {"off"}
}

function SwitchExample {
   Param([switch]$state,$ser)
   if ($state) 
   {Get-Service -Name $ser -RequiredServices} 
   else 
   {
   Get-Service -Name $ser
   }
}


<#
The ConfirmImpact attribute accepts one of the following values:

None: This indicates that the operation has no significant impact and does not require confirmation from the user. No confirmation prompts will be shown.

Low: This indicates a low impact operation. Confirmation prompts may be displayed to confirm the operation, but they are generally less intrusive.

Medium: This indicates a moderate impact operation. Confirmation prompts will be displayed to ensure that the user is aware of the potential consequences of the operation. It is typically used for actions that can have a noticeable impact but are not considered high-risk.

High: This indicates a high impact operation. Confirmation prompts will be displayed more prominently, indicating that the operation can have significant consequences and requires explicit confirmation from the user.

By setting ConfirmImpact to a specific value, you are defining the default behavior for confirmation prompts when the -Confirm parameter is used with the cmdlet or function. The user can override this behavior by specifying the -Confirm or -WhatIf parameters explicitly.
#>



function Invoke-ExampleFunction {
    [CmdletBinding(DefaultParameterSetName='Parameter Set 1',
                  SupportsShouldProcess=$true,
                  PositionalBinding=$false,
                  HelpUri='http://www.example.com/',
                  ConfirmImpact='High')]
    param (
        [Parameter(Mandatory=$true)]
        [string]$Name
    )

    # Perform the operation
    if ($PSCmdlet.ShouldProcess($Name, "Performing example operation")) {
        # The code to execute the operation goes here
        Write-Host "Executing example operation for $Name"
    }
}



#Function with Begin , Process & End blocks

function Process-Data {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory=$true, ValueFromPipeline=$true)]
        [string]$InputData
    )

    begin {
        # Initialization code or setup tasks go here
        Write-Host "Initializing the process..."
    }

    process {
        # Code to process each input item goes here
        Write-Host "Processing: $InputData"
    }

    end {
        # Cleanup code or finalization tasks go here
        Write-Host "Finalizing the process..."
    }
}


# Pipeline input
"Item 1", "Item 2", "Item 3" | Process-Data

# Direct argument
Process-Data -InputData "Single item"


function Process-Input {
    process {
        foreach ($item in $input) {
            # Process each item received from the pipeline
            Write-Host "Processing item: $item"
        }
    }
}
1..5 | Process-Input
