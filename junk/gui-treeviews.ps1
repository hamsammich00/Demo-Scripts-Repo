Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = "TreeView"
$form.StartPosition = "CenterScreen"
$form.Size = New-Object System.Drawing.Size(360, 260)
$form.FormBorderStyle = "FixedDialog"
$form.MaximizeBox = $false

$tree = New-Object System.Windows.Forms.TreeView
$tree.Location = New-Object System.Drawing.Point(10, 10)
$tree.Size = New-Object System.Drawing.Size(320, 200)

$root = New-Object System.Windows.Forms.TreeNode("Root")
$child1 = New-Object System.Windows.Forms.TreeNode("Child 1")
$child2 = New-Object System.Windows.Forms.TreeNode("Child 2")
$child1.Nodes.Add("Grandchild A") | Out-Null
$child1.Nodes.Add("Grandchild B") | Out-Null
$root.Nodes.AddRange(@($child1, $child2))
$tree.Nodes.Add($root) | Out-Null
$tree.ExpandAll()

$form.Controls.Add($tree)
$form.Add_Shown({ $form.Activate() })

[void]$form.ShowDialog()
