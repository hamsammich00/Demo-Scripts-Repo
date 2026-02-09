Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = "Radio Buttons"
$form.StartPosition = "CenterScreen"
$form.Size = New-Object System.Drawing.Size(360, 240)
$form.FormBorderStyle = "FixedDialog"
$form.MaximizeBox = $false

$group = New-Object System.Windows.Forms.GroupBox
$group.Text = "Dummy Choice"
$group.Location = New-Object System.Drawing.Point(20, 20)
$group.Size = New-Object System.Drawing.Size(300, 120)

$rb1 = New-Object System.Windows.Forms.RadioButton
$rb1.Text = "Choice A"
$rb1.Location = New-Object System.Drawing.Point(15, 25)
$rb1.Checked = $true

$rb2 = New-Object System.Windows.Forms.RadioButton
$rb2.Text = "Choice B"
$rb2.Location = New-Object System.Drawing.Point(15, 50)

$rb3 = New-Object System.Windows.Forms.RadioButton
$rb3.Text = "Choice C"
$rb3.Location = New-Object System.Drawing.Point(15, 75)

$status = New-Object System.Windows.Forms.Label
$status.Text = "Selected: Choice A"
$status.AutoSize = $true
$status.Location = New-Object System.Drawing.Point(20, 155)

$update = {
    if ($rb1.Checked) { $status.Text = "Selected: " + $rb1.Text }
    elseif ($rb2.Checked) { $status.Text = "Selected: " + $rb2.Text }
    elseif ($rb3.Checked) { $status.Text = "Selected: " + $rb3.Text }
}

$rb1.Add_CheckedChanged($update)
$rb2.Add_CheckedChanged($update)
$rb3.Add_CheckedChanged($update)

$group.Controls.AddRange(@($rb1, $rb2, $rb3))
$form.Controls.AddRange(@($group, $status))
$form.Add_Shown({ $form.Activate() })

[void]$form.ShowDialog()
