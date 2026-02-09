Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = "Tabs"
$form.StartPosition = "CenterScreen"
$form.Size = New-Object System.Drawing.Size(400, 260)
$form.FormBorderStyle = "FixedDialog"
$form.MaximizeBox = $false

$tabs = New-Object System.Windows.Forms.TabControl
$tabs.Location = New-Object System.Drawing.Point(10, 10)
$tabs.Size = New-Object System.Drawing.Size(360, 200)

$tab1 = New-Object System.Windows.Forms.TabPage
$tab1.Text = "Tab 1"
$tab1Label = New-Object System.Windows.Forms.Label
$tab1Label.Text = "Content for Tab 1"
$tab1Label.AutoSize = $true
$tab1Label.Location = New-Object System.Drawing.Point(15, 15)
$tab1.Controls.Add($tab1Label)

$tab2 = New-Object System.Windows.Forms.TabPage
$tab2.Text = "Tab 2"
$tab2Label = New-Object System.Windows.Forms.Label
$tab2Label.Text = "Content for Tab 2"
$tab2Label.AutoSize = $true
$tab2Label.Location = New-Object System.Drawing.Point(15, 15)
$tab2.Controls.Add($tab2Label)

$tab3 = New-Object System.Windows.Forms.TabPage
$tab3.Text = "Tab 3"
$tab3Label = New-Object System.Windows.Forms.Label
$tab3Label.Text = "Content for Tab 3"
$tab3Label.AutoSize = $true
$tab3Label.Location = New-Object System.Drawing.Point(15, 15)
$tab3.Controls.Add($tab3Label)

$tabs.Controls.AddRange(@($tab1, $tab2, $tab3))

$form.Controls.Add($tabs)
$form.Add_Shown({ $form.Activate() })

[void]$form.ShowDialog()
