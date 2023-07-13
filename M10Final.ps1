#region Load GUI
Add-Type -AssemblyName presentationframework, presentationcore
$XAML= [XML](Get-Content -Path "C:\Users\sikotha\OneDrive - Microsoft\WorkShop\WorkshopPLUS-Windows_PowerShell_Tool_Building_Examples\M10Xaml.Xaml" -Raw)
$XAML.Window.RemoveAttribute('x:Class')
$XAML.Window.RemoveAttribute('xmlns:local')
$XAML.Window.RemoveAttribute('xmlns:d')
$XAML.Window.RemoveAttribute('xmlns:mc')
$XAML.Window.RemoveAttribute('mc:Ignorable')

#read XML as XAML
$XAMLreader = New-Object System.Xml.XmlNodeReader $XAML
$Rawform = [Windows.Markup.XamlReader]::Load($XAMLreader)

#add XML namespace manager
$XmlNamespaceManager = [System.Xml.XmlNamespaceManager]::New($XAML.NameTable)
$XmlNamespaceManager.AddNamespace('x','http://schemas.microsoft.com/winfx/2006/xaml')

#Create hash table containing a representation of all controls
$GUI = @{}
$namedNodes = $XAML.SelectNodes("//*[@x:Name]",$XmlNamespaceManager)
$namedNodes | ForEach-Object -Process {$GUI.Add($_.Name, $Rawform.FindName($_.Name))}

#endregion Load GUI

$RootPath = $null #to be populated when the search button is clicked

$ButtonSB = {
   $GUI["DisplayListBox"].Items.Clear()

   $Script:RootPath = $GUI["PathTextBox"].text
   if(!(Test-Path $RootPath))
   {
       $GUI["DisplayListBox"].Items.Add("INVALID PATH")
       return
   }

   if($GUI["FileRadioButton"].isChecked){$data = Get-ChildItem -Path $RootPath -file}
   else{$data = Get-ChildItem -Path $RootPath -Directory}

   foreach ($item in $data)
   {
       $GUI["DisplayListBox"].Items.add($item.Name)
   }
}
$GUI["SearchButton"].Add_Click($ButtonSB)

$DoubleClickSB = {
   $Gui["DisplayListView"].Items.clear()
   $ItemPath = "$rootPath/$($Gui["DisplayListBox"].selecteditem)"
   $SelectedItem = Get-Itemproperty -Path $ItemPath -ErrorAction SilentlyContinue
   $SelectedItem.psobject.properties | foreach {$Gui["DisplayListView"].Items.add("$($_.name): $($_.value)")}
}
$Gui["DisplayListBox"].Add_MouseDoubleClick($DoubleClickSB)

$Rawform.ShowDialog() | Out-Null