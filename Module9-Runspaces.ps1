$Powershell = [PowerShell]::Create()
$PowerShell.AddScript({Start-Sleep -Seconds 5;'Done'})
$PowerShell.Invoke() 


$Powershell.Runspace.RunspaceStateInfo

$Powershell.Dispose()

$InitialSessionState = [System.Management.Automation.Runspaces.InitialSessionState]::CreateDefault() 
$sessionVariable = [System.Management.Automation.Runspaces.SessionStateVariableEntry]::new("name", "value", $null)
$InitialSessionState.Variables.Add($sessionVariable) 
$PowerShell = [powershell]::Create($InitialSessionState) 


New-PSSessionConfigurationFile -Path C:\Temp\test.pssc -Full -VariableDefinitions @{name="abc";value=123}
#New-PSRoleCapabilityFile -Path C:\Temp\test.psrc -VariableDefinitions @{name="abc";value=123} 
$ISS =           [System.Management.Automation.Runspaces.InitialSessionState]::CreateFromSessionConfigurationFile("C:\temp\test.pssc")
$Powershell = [powershell]::Create($ISS)




    $PowerShellInstance.Runspace.name= "test$RunspaceInstance"

################################################
$RunspacePool = [runspacefactory]::CreateRunspacePool(1,5)  
$RunspacePool.Open() 
$RunspacePool.GetAvailableRunspaces() 
[System.Collections.ArrayList]$RunspaceList = @() 
 foreach($RunspaceInstance in 1..10)
{
    #Create a runspace instance and assign it to the pool
    $PowerShellInstance = [powershell]::Create()
    $PowerShellInstance.RunspacePool = $RunspacePool
    
    #Add the script to the runspace
    [void]$PowerShellInstance.AddScript(
    {
        Get-ChildItem -Path C:\Windows -Recurse
    })
    
    #Optional: Add all the data into a results table
    $RunspaceList.Add([pscustomobject]@{
        RunspaceInstance = $RunspaceInstance
        PowerShell       = $PowerShellInstance
        AsyncResult      = $PowerShellInstance.BeginInvoke()
    })
}
#######################################

$RunspaceList.PowerShell.Stop()   