#################################################################################################################
#Description
#building a VM in Proxmox by calling Teraform via powershell
#make sure you adjust to your specific Proxmox IP
#github.com/hamsammich00/Demo-Scripts-Repo
#11/14/25
#################################################################################################################

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Create the form
$form = New-Object System.Windows.Forms.Form
$form.Text = "VM Builder v0.1"
$form.Size = New-Object System.Drawing.Size(425,500)
$form.StartPosition = "CenterScreen"

# Vm Name
$VMNameLabel = New-Object System.Windows.Forms.Label
$VMNameLabel.Text = "New VM name:"
$VMNameLabel.Location = New-Object System.Drawing.Point(10,24)
$VMNameLabel.AutoSize = $true
$form.Controls.Add($VMNameLabel)
$VMNameTextbox = New-Object System.Windows.Forms.TextBox
$VMNameTextbox.Location = New-Object System.Drawing.Point(150, 20)
$VMNameTextbox.Size = New-Object System.Drawing.Size(180,20)
$VMNameTextbox.Text = "Name"
$form.Controls.Add($VMNameTextbox)

# CPU
$CPUlabel = New-Object System.Windows.Forms.Label
$CPUlabel.Text = "Number of CPU :"
$CPUlabel.Location = New-Object System.Drawing.Point(10,54)
$CPUlabel.AutoSize -= $true
$form.Controls.Add($CPUlabel)
$CPUCombo = New-Object System.Windows.Forms.ComboBox
$CPUCombo.Location = New-Object System.Drawing.Point(150,50)
$CPUCombo.Size = New-Object System.Drawing.Size(180,50)
$CPUCombo.Text = "Amount of CPU"						  
$CPUCombo.Items.AddRange(@("1", "2", "4", "6"))
$form.Controls.Add($CPUCombo)

# RAM multiple choice dropdown
$RAMlabel = New-Object System.Windows.Forms.Label
$RAMlabel.Text = "Amount of RAM :"
$RAMlabel.Location = New-Object System.Drawing.Point(10,84)
$RAMlabel.AutoSize -= $true
$form.Controls.Add($RAMlabel)
$RAMCombo = New-Object System.Windows.Forms.ComboBox
$RAMCombo.Location = New-Object System.Drawing.Point(150,80)
$RAMCombo.Size = New-Object System.Drawing.Size(180,50)
$RAMCombo.Text = "Amount of RAM"						  
$RAMCombo.Items.AddRange(@("2048", "4096", "6144", "8192"))
$form.Controls.Add($RAMCombo)

# VMID dropdown
$VMIDlabel = New-Object System.Windows.Forms.Label
$VMIDlabel.Text = "VMID :"
$VMIDlabel.Location = New-Object System.Drawing.Point(10,114)
$VMIDlabel.AutoSize -= $true
$form.Controls.Add($VMIDlabel)
$VMIDTextbox = New-Object System.Windows.Forms.TextBox
$VMIDTextbox.Location = New-Object System.Drawing.Point(150, 110)
$VMIDTextbox.Size = New-Object System.Drawing.Size(180,20)
$VMIDTextbox.Text = "Valid VMID"
$form.Controls.Add($VMIDTextbox)

# Pull current templates names and choose template
$Templatelabel = New-Object System.Windows.Forms.Label
$Templatelabel.Text = "Template :"
$Templatelabel.Location = New-Object System.Drawing.Point(10,149)
$Templatelabel.AutoSize -= $true
$form.Controls.Add($Templatelabel)
$TemplateButton = New-Object System.Windows.Forms.Button
$TemplateButton.Text = "Pull template names"
$TemplateButton.Location = New-Object System.Drawing.Point(80, 145)
$TemplateButton.Size = New-Object System.Drawing.Size(120,25)
$form.Controls.Add($TemplateButton)
$TemplateCombo = New-Object System.Windows.Forms.ComboBox
$TemplateCombo.Location = New-Object System.Drawing.Point(220,145)
$TemplateCombo.Size = New-Object System.Drawing.Size(180,50)
$TemplateCombo.Text = "Amount of RAM"						  
$TemplateCombo.Items.AddRange(@("Whatever the script i add later pulls from Proxmox"))
$form.Controls.Add($TemplateCombo)


# Output visualizer, I think I want to use this if  i can make it work
$Visualizer = New-Object System.Windows.Forms.TextBox
$Visualizer.Multiline = $true
$Visualizer.ScrollBars = 'Vertical'
$Visualizer.ReadOnly = $true
$Visualizer.Font = 'Consolas,10'
$Visualizer.Size = New-Object System.Drawing.Size(390, 200)
$Visualizer.Location = New-Object System.Drawing.Point(10, 210)
$form.Controls.Add($Visualizer)
# Visualizer logic
function Write-OutputBox {
    param($Text)
    $Visualizer.AppendText("$Text`r`n")
    $Visualizer.SelectionStart = $Visualizer.Text.Length
    $Visualizer.ScrollToCaret()
}

# Go Button
$BuildButton = New-Object System.Windows.Forms.Button
$BuildButton.Text = "Build me a VM!"
$BuildButton.Location = New-Object System.Drawing.Point(135, 420)
$BuildButton.Size = New-Object System.Drawing.Size(150,30)
$form.Controls.Add($BuildButton)

$BuildButton.Add_Click({
    if ($VMNameTextbox.Text -eq "Name" -or [string]::IsNullOrWhiteSpace($VMNameTextbox.Text)) {
        [System.Windows.Forms.MessageBox]::Show("Please enter a name for the new VM.")
        #Write-OutputBox ("Please enter a name for the new VM.")
        return
    }
    if ($VMIDTextbox.Text -eq "Valid VMID" -or [string]::IsNullOrWhiteSpace($VMIDTextbox.Text)) {
        [System.Windows.Forms.MessageBox]::Show("Please enter a valid VMID.")
        #Write-OutputBox ("Please enter a valid VMID.")
        return
    }

    
        [System.Windows.Forms.MessageBox]::Show("Your VM, $($VMNameTextbox.Text), is being cloned and configured from your templates.")
       # Write-OutputBox ("Your VM, $($VMNameTextbox.Text), is being cloned and configured from your templates.")
    })

[void]$form.ShowDialog()
