$VerbosePreference ='continue'
$DebugPreference= 'continue'

function get-systeminfo
{
    [cmdletbinding()]
    param(
        [string[]]$computername
    )
    Process{
        foreach($computer in $computername)
        {
            Write-Verbose "Pulling wmi info from given $computer"
            $os= Get-WmiObject -Class win32_operatingsystem -ComputerName $computer
            $comp= Get-WmiObject -Class win32_computersystem -ComputerName $computer
            $proc= Get-WmiObject -Class win32_processor -ComputerName $computer
            $bios = Get-WmiObject -Class win32_bios -ComputerName $computer
            Write-Debug "Done with data extraction"
        }
        if ($os.OSArchitecture -ne $proc.addresswidth)
        {$var = $true}
        else
        {$var= $false}
        $props =@{
            computername= $computer
            OSversion= $os.Version
            Model= $comp.model
            OSArch =$os.OSArchitecture
            ProcArch = $proc.AddressWidth
            BiosSerial =$bios.SerialNumber
            OptimalArchitechture = $var
             
        }
        $obj= New-Object -TypeName psobject -Property $props
        Write-Output $obj
}
}
get-systeminfo -computername localhost