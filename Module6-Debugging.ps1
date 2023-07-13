#Set-PSDebug -Off
Function Bits {
    [Cmdletbinding()]Param()
    $Service = Get-Service -Name Bits
    $Service
    Write-Debug "Debug enabled: status is $($Service.Status)"
}



function Test-DebugFunction {
   begin {
      Write-Host "Begin" 
      "ksjdhf"
      "lsfjsdl"
   }
   process {
      Write-Host "Process"
   }
   end {
      Write-Host "End"
   }
} 


################strictmode##############
Set-StrictMode -Version Latest

# With strict mode enabled, you need to declare variables before using them
$variable = "Hello, World!"
Write-Host $variable

# Trying to use an undeclared variable will result in an error
Write-Host $undeclaredVariable


#####################################################

# Strict mode is off by default.
    $a = @(1)
    $null -eq $a[2]
    $null -eq $a['abc']
    
 
    Set-StrictMode -Version 3
    $a = @(1)
    $null -eq $a[2]
    $null -eq $a['abc']
########################PSCallStack##########################

function my-alias {
    $p = $args[0]
    Get-Alias | where {$_.definition -like "*$p"} | format-table definition, name -auto
    Get-PSCallStack
    }


function OuterFunction {
    MiddleFunction
}

function MiddleFunction {
    InnerFunction
}

function InnerFunction {
    Get-PSCallStack | ForEach-Object {
        Write-Host "Function: $($_.Command)"
        Write-Host "Script: $($_.ScriptName)"
        Write-Host "Line: $($_.LineNumber)"
        Write-Host "----------------"
    }
}

OuterFunction
