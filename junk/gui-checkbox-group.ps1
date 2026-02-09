Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = "Checkbox Group"
$form.StartPosition = "CenterScreen"
$form.Size = New-Object System.Drawing.Size(360, 240)
$form.FormBorderStyle = "FixedDialog"
$form.MaximizeBox = $false

$group = New-Object System.Windows.Forms.GroupBox
$group.Text = "Dummy Options"
$group.Location = New-Object System.Drawing.Point(20, 20)
$group.Size = New-Object System.Drawing.Size(300, 120)

$cb1 = New-Object System.Windows.Forms.CheckBox
$cb1.Text = "Option 1"
$cb1.Location = New-Object System.Drawing.Point(15, 25)

$cb2 = New-Object System.Windows.Forms.CheckBox
$cb2.Text = "Option 2"
$cb2.Location = New-Object System.Drawing.Point(15, 50)

$cb3 = New-Object System.Windows.Forms.CheckBox
$cb3.Text = "Option 3"
$cb3.Location = New-Object System.Drawing.Point(15, 75)

$status = New-Object System.Windows.Forms.Label
$status.Text = "Selected: (none)"
$status.AutoSize = $true
$status.Location = New-Object System.Drawing.Point(20, 155)

$update = {
    $selected = @()
    if ($cb1.Checked) { $selected += $cb1.Text }
    if ($cb2.Checked) { $selected += $cb2.Text }
    if ($cb3.Checked) { $selected += $cb3.Text }
    if ($selected.Count -eq 0) {
        $status.Text = "Selected: (none)"
    } else {
        $status.Text = "Selected: " + ($selected -join ", ")
    }
}

$cb1.Add_CheckedChanged($update)
$cb2.Add_CheckedChanged($update)
$cb3.Add_CheckedChanged($update)

$group.Controls.AddRange(@($cb1, $cb2, $cb3))
$form.Controls.AddRange(@($group, $status))
$form.Add_Shown({ $form.Activate() })

[void]$form.ShowDialog()
