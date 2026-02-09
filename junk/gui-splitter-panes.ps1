Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = "Splitter Panes"
$form.StartPosition = "CenterScreen"
$form.Size = New-Object System.Drawing.Size(520, 300)
$form.FormBorderStyle = "FixedDialog"
$form.MaximizeBox = $false

$split = New-Object System.Windows.Forms.SplitContainer
$split.Dock = "Fill"
$split.Orientation = "Vertical"
$split.SplitterDistance = 240

$leftLabel = New-Object System.Windows.Forms.Label
$leftLabel.Text = "Left Pane"
$leftLabel.AutoSize = $true
$leftLabel.Location = New-Object System.Drawing.Point(10, 10)

$rightLabel = New-Object System.Windows.Forms.Label
$rightLabel.Text = "Right Pane"
$rightLabel.AutoSize = $true
$rightLabel.Location = New-Object System.Drawing.Point(10, 10)

$split.Panel1.Controls.Add($leftLabel)
$split.Panel2.Controls.Add($rightLabel)

$form.Controls.Add($split)
$form.Add_Shown({ $form.Activate() })

[void]$form.ShowDialog()
