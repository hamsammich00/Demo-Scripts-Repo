Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = "Grid Table"
$form.StartPosition = "CenterScreen"
$form.Size = New-Object System.Drawing.Size(520, 300)
$form.FormBorderStyle = "FixedDialog"
$form.MaximizeBox = $false

$grid = New-Object System.Windows.Forms.DataGridView
$grid.Location = New-Object System.Drawing.Point(10, 10)
$grid.Size = New-Object System.Drawing.Size(480, 210)
$grid.AllowUserToAddRows = $false
$grid.ReadOnly = $true
$grid.ColumnCount = 3
$grid.Columns[0].Name = "ID"
$grid.Columns[1].Name = "Name"
$grid.Columns[2].Name = "Status"

$grid.Rows.Add(1, "Alpha", "Ready")
$grid.Rows.Add(2, "Beta", "Pending")
$grid.Rows.Add(3, "Gamma", "Offline")

$status = New-Object System.Windows.Forms.Label
$status.Text = "Rows: 3"
$status.AutoSize = $true
$status.Location = New-Object System.Drawing.Point(10, 230)

$form.Controls.AddRange(@($grid, $status))
$form.Add_Shown({ $form.Activate() })

[void]$form.ShowDialog()
