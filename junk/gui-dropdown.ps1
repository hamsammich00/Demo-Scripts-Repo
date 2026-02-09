Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = "Dummy Dropdown"
$form.StartPosition = "CenterScreen"
$form.Size = New-Object System.Drawing.Size(360, 220)
$form.FormBorderStyle = "FixedDialog"
$form.MaximizeBox = $false

$label = New-Object System.Windows.Forms.Label
$label.Text = "Choose a dummy option (no real effect):"
$label.AutoSize = $true
$label.Location = New-Object System.Drawing.Point(20, 20)

$combo = New-Object System.Windows.Forms.ComboBox
$combo.DropDownStyle = "DropDownList"
$combo.Location = New-Object System.Drawing.Point(20, 50)
$combo.Size = New-Object System.Drawing.Size(200, 24)
$combo.Items.AddRange(@("Option A", "Option B", "Option C"))
$combo.SelectedIndex = 0

$status = New-Object System.Windows.Forms.Label
$status.Text = "Selected: Option A"
$status.AutoSize = $true
$status.Location = New-Object System.Drawing.Point(20, 85)

$combo.Add_SelectedIndexChanged({
    $status.Text = "Selected: " + $combo.SelectedItem
})

$closeButton = New-Object System.Windows.Forms.Button
$closeButton.Text = "Close"
$closeButton.Size = New-Object System.Drawing.Size(80, 28)
$closeButton.Location = New-Object System.Drawing.Point(20, 130)
$closeButton.Add_Click({ $form.Close() })

$form.Controls.AddRange(@($label, $combo, $status, $closeButton))
$form.Add_Shown({ $form.Activate() })

[void]$form.ShowDialog()
