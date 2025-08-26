#################################################################################################################
#Description
#Messing with forms and file transfer in powershell
#Makes a form that allows you to use powershell to transfer files to a remote computer. Can use Shortname. 
#github.com/hamsammich00/Demo-Scripts-Repo
#7/22/25
#################################################################################################################

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Create the form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Powershell File Transfer"
$form.Size = New-Object System.Drawing.Size(400,220)
$form.StartPosition = "CenterScreen"

# Textbox (computer name)
$Namelabel = New-Object System.Windows.Forms.Label
$Namelabel.Text = "Target Computer:"
$Namelabel.Location = New-Object System.Drawing.Point(10,20)
$Namelabel.AutoSize = $true
$form.Controls.Add($Namelabel)
$textbox = New-Object System.Windows.Forms.TextBox
$textbox.Location = New-Object System.Drawing.Point(180, 20)
$textbox.Size = New-Object System.Drawing.Size(180,20)
$textbox.Text = "Target Computer Name"
$form.Controls.Add($textbox)

# Textbox $LocalFolder
# Local File Path textbox and Browse button
$LocalFolder = New-Object System.Windows.Forms.TextBox
$LocalFolder.Location = New-Object System.Drawing.Point(180, 100)
$LocalFolder.Size = New-Object System.Drawing.Size(180, 50) 
$LocalFolder.Text = "Local File Path"
$form.Controls.Add($LocalFolder)

$browseButton = New-Object System.Windows.Forms.Button
$browseButton.Text = "Browse"
$browseButton.Location = New-Object System.Drawing.Point(100, 100)
$browseButton.Size = New-Object System.Drawing.Size(60, 23)
$form.Controls.Add($browseButton)

$browseButton.Add_Click({
    $dialog = New-Object System.Windows.Forms.OpenFileDialog
    $dialog.Filter = "All files (*.*)|*.*"

    if ($dialog.ShowDialog() -eq "OK") {
        $LocalFolder.Text = $dialog.FileName
    }
})

# Textbox $DestinationFolder
$Destlabel = New-Object System.Windows.Forms.Label
$Destlabel.Text = "Destination File Path:"
$Destlabel.Location = New-Object System.Drawing.Point(10,50)
$Destlabel.AutoSize = $true
$form.Controls.Add($Destlabel)
$DestinationFolder = New-Object System.Windows.Forms.TextBox
$DestinationFolder.Location = New-Object System.Drawing.Point(180,50)
$DestinationFolder.Size = New-Object System.Drawing.Size(180,100)
$DestinationFolder.Text = "Target File Path (Folder)"
$form.Controls.Add($DestinationFolder)

# Button
$button = New-Object System.Windows.Forms.Button
$button.Text = "Start Transfer"
$button.Location = New-Object System.Drawing.Point(100, 150)
$button.Size = New-Object System.Drawing.Size(150,30)
$form.Controls.Add($button)

$button.Add_Click({
    if ($textbox.Text -eq "Target Computer Name" -or [string]::IsNullOrWhiteSpace($textbox.Text)) {
        [System.Windows.Forms.MessageBox]::Show("Please enter a valid computer name.")
        return
    }
    if ($LocalFolder.Text -eq "Local File Path" -or [string]::IsNullOrWhiteSpace($LocalFolder.Text)) {
        [System.Windows.Forms.MessageBox]::Show("Please select a valid local file path.")
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
