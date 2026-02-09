Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = "Context Menu"
$form.StartPosition = "CenterScreen"
$form.Size = New-Object System.Drawing.Size(360, 220)
$form.FormBorderStyle = "FixedDialog"
$form.MaximizeBox = $false

$label = New-Object System.Windows.Forms.Label
$label.Text = "Right-click anywhere in the window."
$label.AutoSize = $true
$label.Location = New-Object System.Drawing.Point(20, 20)

$status = New-Object System.Windows.Forms.Label
$status.Text = "Selection: (none)"
$status.AutoSize = $true
$status.Location = New-Object System.Drawing.Point(20, 55)

$menu = New-Object System.Windows.Forms.ContextMenuStrip
$itemA = New-Object System.Windows.Forms.ToolStripMenuItem("Dummy A")
$itemB = New-Object System.Windows.Forms.ToolStripMenuItem("Dummy B")
$itemC = New-Object System.Windows.Forms.ToolStripMenuItem("Dummy C")

$itemA.Add_Click({ $status.Text = "Selection: Dummy A" })
$itemB.Add_Click({ $status.Text = "Selection: Dummy B" })
$itemC.Add_Click({ $status.Text = "Selection: Dummy C" })

$menu.Items.AddRange(@($itemA, $itemB, $itemC))
$form.ContextMenuStrip = $menu

$form.Controls.AddRange(@($label, $status))
$form.Add_Shown({ $form.Activate() })

[void]$form.ShowDialog()
