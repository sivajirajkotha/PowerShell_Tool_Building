Add-Type -AssemblyName System.ServiceProcess
Add-Type -AssemblyName System.Windows.Forms

# Create the main form
$form = New-Object Windows.Forms.Form
$form.Text = "Service Status Viewer"
$form.Size = New-Object Drawing.Size(400, 200)

# Create a drop-down list to select services
$servicesDropdown = New-Object Windows.Forms.ComboBox
$servicesDropdown.Location = New-Object Drawing.Point(10, 10)
$servicesDropdown.Width = 300

# Get the list of services and populate the drop-down
$services = Get-Service | ForEach-Object { $_.DisplayName }
$servicesDropdown.Items.AddRange($services)

# Create a label to display the selected service status
$statusLabel = New-Object Windows.Forms.Label
$statusLabel.Location = New-Object Drawing.Point(10, 50)
$statusLabel.AutoSize = $true

# Event handler for drop-down selection change
$servicesDropdown.add_SelectedIndexChanged({
    $selectedService = $servicesDropdown.SelectedItem.ToString()
    $serviceStatus = (Get-Service $selectedService).Status
    $statusLabel.Text = "Status of $selectedService : $serviceStatus"
})

# Add controls to the form
$form.Controls.Add($servicesDropdown)
$form.Controls.Add($statusLabel)

# Show the form
$form.ShowDialog()
