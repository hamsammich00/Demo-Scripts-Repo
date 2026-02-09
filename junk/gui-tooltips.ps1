Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = "Tooltips"
$form.StartPosition = "CenterScreen"
$form.Size = New-Object System.Drawing.Size(360, 220)
$form.FormBorderStyle = "FixedDialog"
$form.MaximizeBox = $false

$label = New-Object System.Windows.Forms.Label
$label.Text = "Hover over controls:"
$label.AutoSize = $true
$label.Location = New-Object System.Drawing.Point(20, 20)

$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(20, 50)
$textBox.Width = 200

$button = New-Object System.Windows.Forms.Button
$button.Text = "Dummy"
$button.Location = New-Object System.Drawing.Point(20, 85)
$button.Size = New-Object System.Drawing.Size(80, 28)

$toolTip = New-Object System.Windows.Forms.ToolTip
$toolTip.SetToolTip($textBox, "Dummy text input")
$toolTip.SetToolTip($button, "Dummy button")

$form.Controls.AddRange(@($label, $textBox, $button))
$form.Add_Shown({ $form.Activate() })

[void]$form.ShowDialog()
