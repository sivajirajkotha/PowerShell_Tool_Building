class person
{
    $Name
    $Age
}

$sivaji = [person]::new()
$sivaji.Name= "sivaji"
$sivaji.Age=29
$sivaji

$per = New-Object -TypeName person
$per.Age =30
$per.Name="David"

$val= @{
Name="Eshwar"
Age= 25
}
New-Object -TypeName person -Property $val
#######################################################
$ramesh=[person]::new()
$ramesh.Name="Ramesh"
$ramesh.Age=30
$Suresh=[person]::new()
$Suresh.Name = "Suresh"
$Suresh.Age=31

class person1
{
    $Name
    $Age
    GetInfo() {
         write-host "Name: $($this.Name), Age: $($this.Age)"
    }
}

$sivaji = [person1]::new()
$sivaji.Name= "sivaji"
$sivaji.Age=29
$sivaji
$sivaji.GetInfo()


class person2
{
    [string]$Name
    [Int]$Age
    [String]GetInfo() {
         return "Name: $($this.Name), Age: $($this.Age)"
    }
}

$sivaji = [person2]::new()
$sivaji.Name= "sivaji"
$sivaji.Age=29

###########################default constructor###########################

class person3
{
    [string]$Name
    [Int]$Age
    person3()
    {
        $this.Name="Kapil"
    }
}


###########################default constructor with properties###########################
class person4{
    [string[]]$Name
    [Int[]]$Age
    person4([string[]]$N,[Int[]]$A)
    {
        $this.Name=$N
        $this.Age= $A
    }
}

################# Defining Parameters and Overloading Methods###################


class person5
{
    [string]$Name
    [Int]$Age
    person5([string]$N,[Int]$A)
    {
        $this.Name=$N
        $this.Age= $A
    }
    GetInfo() {
         Write-Host "Name: $($this.Name), Age: $($this.Age)" -ForegroundColor Green
    }
    use()
    {
       Write-Host "My Name is $($this.Name) and my age is $($this.age)"
    }
    use($message)
    {
        Write-Host "$message"
    }
    
}
$var= [person5]::new("sivaji",30)

###################Enums#######################
Enum role
{
    Developer
    Tester
    supportEngineer
}
class person6
{
    [string]$name
    [role]$role
    #Hidden [string]$place
    person6() {}
    person6($n,$r)
    {
        $this.name=$n
        $this.role=$r
    }
}

#########################Inheritance#####################

class Tester:person6
{
    tester(){$this.role = [role]::Tester}
    #tester($name) : base($Name,[role]::Tester){}
}

$tester1 = [tester]::new()

<#
class Tester:person6
{
    tester(){$this.role = [role]::Tester}
    tester($name) : base($Name,[role]::Tester){}
}

$tester1 = [tester]::new("sivaji")

#>