#################################################################################################################
#Description
#building a VM in proxmox by calling Teraform via powershell
#github.com/hamsammich00/Demo-Scripts-Repo
#11/14/25
#################################################################################################################

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Create the form
$form = New-Object System.Windows.Forms.Form
$form.Text = "VM Builder v0.1"
$form.Size = New-Object System.Drawing.Size(500,500)
$form.StartPosition = "CenterScreen"

# Vm Name
$VMNameLabel = New-Object System.Windows.Forms.Label
$VMNameLabel.Text = "New VM name:"
$VMNameLabel.Location = New-Object System.Drawing.Point(10,24)
$VMNameLabel.AutoSize = $true
$form.Controls.Add($VMNameLabel)
$VMNameTextbox = New-Object System.Windows.Forms.TextBox
$VMNameTextbox.Location = New-Object System.Drawing.Point(180, 20)
$VMNameTextbox.Size = New-Object System.Drawing.Size(180,20)
$VMNameTextbox.Text = "Name"
$form.Controls.Add($VMNameTextbox)

# CPU
$CPUlabel = New-Object System.Windows.Forms.Label
$CPUlabel.Text = "Number of CPU :"
$CPUlabel.Location = New-Object System.Drawing.Point(10,54)
$CPUlabel.AutoSize -= $true
$form.Controls.Add($CPUlabel)
$CPUTextbox = New-Object System.Windows.Forms.TextBox
$CPUTextbox.Location = New-Object System.Drawing.Point(180, 50)
$CPUTextbox.Size = New-Object System.Drawing.Size(180,20)
$CPUTextbox.Text = "CPU"
$form.Controls.Add($CPUTextbox)

# RAM multiple choice dropdown
$RAMCombo = New-Object System.Windows.Forms.ComboBox
$RAMCombo.Location = New-Object System.Drawing.Point(180,80)
$RAMCombo.Size = New-Object System.Drawing.Size(180,50)
$RAMCombo.Text = "Amount of RAM"						  
$RAMCombo.Items.AddRange(@("2048", "4096"))
$form.Controls.Add($RAMCombo)


# Button
$button = New-Object System.Windows.Forms.Button
$button.Text = "Build me a VM!"
$button.Location = New-Object System.Drawing.Point(170, 400)
$button.Size = New-Object System.Drawing.Size(150,30)
$form.Controls.Add($BuildButton)

$button.Add_Click({
    if ($textbox.Text -eq "Target Computer Name" -or [string]::IsNullOrWhiteSpace($VMName.Text)) {
        [System.Windows.Forms.MessageBox]::Show("Please enter a valid computer name.")
        return
    }
    if ($LocalFolder.Text -eq "Local File Path" -or [string]::IsNullOrWhiteSpace($CPU.Text)) {
        [System.Windows.Forms.MessageBox]::Show("Please .")
        return
    }
    if ($DestinationFolder.Text -eq "Target File Path" -or [string]::IsNullOrWhiteSpace($DestinationFolder.Text)) {
        [System.Windows.Forms.MessageBox]::Show("Please enter a valid destination file path.")
        return
    }
    
    $session = New-PSSession -ComputerName $textbox.Text -Credential (Get-Credential)
    Copy-Item $LocalFolder.Text -Destination $DestinationFolder.Text -ToSession $session -Recurse
    Remove-PSSession $session
    
        [System.Windows.Forms.MessageBox]::Show("File transfer initiated to $($textbox.Text).")
    })

[void]$form.ShowDialog()