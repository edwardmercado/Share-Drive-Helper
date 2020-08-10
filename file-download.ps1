Add-Type -AssemblyName System.Windows.Forms

#GUI

$form = New-Object System.Windows.Forms.Form
$form.Text = 'Update File'
$form.Size = New-Object System.Drawing.Size(250,210)
$form.StartPosition = 'CenterScreen'
$form.FormBorderStyle = 'FixedDialog'
$form.TopMost = $true

$labelUsername = New-Object System.Windows.Forms.Label
$labelUsername.Location = New-Object System.Drawing.Point(10,20)
$labelUsername.Size = New-Object System.Drawing.Size(280, 20)
$labelUsername.Text = 'Username: '

$textUsername = New-Object System.Windows.Forms.TextBox
$textUsername.Location = New-Object System.Drawing.Point(10,40)
$textUsername.Size = New-Object System.Drawing.Size(210, 20)

$labelPassword = New-Object System.Windows.Forms.Label
$labelPassword.Location = New-Object System.Drawing.Point(10,80)
$labelPassword.Size = New-Object System.Drawing.Size(280, 20)
$labelPassword.Text = 'Password: '

$textPassword = New-Object System.Windows.Forms.MaskedTextBox
$textPassword.PasswordChar = "*"
$textPassword.Location = New-Object System.Drawing.Point(10,100)
$textPassword.Size = New-Object System.Drawing.Size(210, 20)

$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point(10,130)
$okButton.Size = New-Object System.Drawing.Size(75,23)
$okButton.Text = "Update"

$form.controls.AddRange(@($labelUsername, $labelPassword, $textPassword, $textUsername, $okButton))


#---------------------------------------------------------------



[void]$form.ShowDialog()

