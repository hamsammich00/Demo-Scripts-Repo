Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = "Dummy Switch"
$form.StartPosition = "CenterScreen"
$form.Size = New-Object System.Drawing.Size(360, 200)
$form.FormBorderStyle = "FixedDialog"
$form.MaximizeBox = $false

$label = New-Object System.Windows.Forms.Label
$label.Text = "Toggle the dummy switch (no real effect):"
$label.AutoSize = $true
$label.Location = New-Object System.Drawing.Point(20, 20)

$switch = New-Object System.Windows.Forms.CheckBox
$switch.Text = "Dummy Switch"
$switch.AutoSize = $true
$switch.Location = New-Object System.Drawing.Point(20, 55)

$status = New-Object System.Windows.Forms.Label
$status.Text = "Status: OFF"
$status.AutoSize = $true
$status.Location = New-Object System.Drawing.Point(20, 85)

$switch.Add_CheckedChanged({
    if ($switch.Checked) {
        $status.Text = "Status: ON"
    } else {
        $status.Text = "Status: OFF"
    }
})

$closeButton = New-Object System.Windows.Forms.Button
$closeButton.Text = "Close"
$closeButton.Size = New-Object System.Drawing.Size(80, 28)
$closeButton.Location = New-Object System.Drawing.Point(20, 120)
$closeButton.Add_Click({ $form.Close() })

$form.Controls.AddRange(@($label, $switch, $status, $closeButton))
$form.Add_Shown({ $form.Activate() })

[void]$form.ShowDialog()
