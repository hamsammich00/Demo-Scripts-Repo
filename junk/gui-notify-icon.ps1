Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = "Notify Icon"
$form.StartPosition = "CenterScreen"
$form.Size = New-Object System.Drawing.Size(360, 220)
$form.FormBorderStyle = "FixedDialog"
$form.MaximizeBox = $false

$label = New-Object System.Windows.Forms.Label
$label.Text = "A dummy tray icon will appear."
$label.AutoSize = $true
$label.Location = New-Object System.Drawing.Point(20, 20)

$status = New-Object System.Windows.Forms.Label
$status.Text = "Status: Visible"
$status.AutoSize = $true
$status.Location = New-Object System.Drawing.Point(20, 55)

$notify = New-Object System.Windows.Forms.NotifyIcon
$notify.Icon = [System.Drawing.SystemIcons]::Information
$notify.Text = "Dummy Notify Icon"
$notify.Visible = $true

$menu = New-Object System.Windows.Forms.ContextMenuStrip
$showItem = New-Object System.Windows.Forms.ToolStripMenuItem("Show")
$exitItem = New-Object System.Windows.Forms.ToolStripMenuItem("Exit")
$menu.Items.AddRange(@($showItem, $exitItem))
$notify.ContextMenuStrip = $menu

$showItem.Add_Click({
    $form.WindowState = "Normal"
    $form.ShowInTaskbar = $true
    $form.Show()
})

$exitItem.Add_Click({
    $notify.Visible = $false
    $form.Close()
})

$form.Add_FormClosing({
    $notify.Visible = $false
})

$form.Controls.AddRange(@($label, $status))
$form.Add_Shown({ $form.Activate() })

[void]$form.ShowDialog()
