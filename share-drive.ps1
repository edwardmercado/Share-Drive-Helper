Add-Type -AssemblyName System.Windows.Forms

#GUI

$form = New-Object System.Windows.Forms.Form
$form.Text = 'Share Drive Helper'
$form.Size = New-Object System.Drawing.Size(500,630)
$form.StartPosition = 'CenterScreen'
$form.TopMost = $true
$form.FormBorderStyle = 'FixedDialog'

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,20)
$label.Size = New-Object System.Drawing.Size(280,20)
$label.Text = "Please enter the share drive path below: "

$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(10,40)
$textBox.Size = New-Object System.Drawing.Size(460,20)

$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point(10,70)
$okButton.Size = New-Object System.Drawing.Size(75,23)
$okButton.Text = 'OK'
$form.AcceptButton = $okButton

$resetButton = New-Object System.Windows.Forms.Button
$resetButton.Location = New-Object System.Drawing.Point(90,70)
$resetButton.Size = New-Object System.Drawing.Size(75,23)
$resetButton.Text = 'Reset'

$updateButton = New-Object System.Windows.Forms.Button
$updateButton.Location = New-Object System.Drawing.Point(395,70)
$updateButton.Size = New-Object System.Drawing.Size(72,23)
$updateButton.Text = 'Update'

#ReadWrite
$labelReadWrite = New-Object System.Windows.Forms.Label
$labelReadWrite.Location = New-Object System.Drawing.Point(10,130)
$labelReadWrite.Size = New-Object System.Drawing.Size(280,20)
$labelReadWrite.Text = 'Read\Write Access Group: '

$textReadWrite = New-Object System.Windows.Forms.TextBox
$textReadWrite.Location = New-Object System.Drawing.Point(10,150)
$textReadWrite.Size = New-Object System.Drawing.Size(380,250)

$buttonCopyRW = New-Object System.Windows.Forms.Button
$buttonCopyRW.Location = New-Object System.Drawing.Point(393,149)
$buttonCopyRW.Size = New-Object System.Drawing.Size(75,23)
$buttonCopyRW.Text = 'Copy'

#Read Only
$labelReadOnly = New-Object System.Windows.Forms.Label
$labelReadOnly.Location = New-Object System.Drawing.Point(10,180)
$labelReadOnly.Size = New-Object System.Drawing.Size(280,20)
$labelReadOnly.Text = 'Read Only Access Group: '

$textReadOnly = New-Object System.Windows.Forms.TextBox
$textReadOnly.Location = New-Object System.Drawing.Point(10,200)
$textReadOnly.Size = New-Object System.Drawing.Size(380,250)

$buttonCopyRO = New-Object System.Windows.Forms.Button
$buttonCopyRO.Location = New-Object System.Drawing.Point(393,199)
$buttonCopyRO.Size = New-Object System.Drawing.Size(75,23)
$buttonCopyRO.Text = 'Copy'

#Approval
$labelApproval = New-Object System.Windows.Forms.Label
$labelApproval.Location = New-Object System.Drawing.Point(10,230)
$labelApproval.Size = New-Object System.Drawing.Size(280,20)
$labelApproval.Text = 'Approval Required from: '

$textApproval = New-Object System.Windows.Forms.TextBox
$textApproval.Location = New-Object System.Drawing.Point(10,250)
$textApproval.Size = New-Object System.Drawing.Size(380,250)

$buttonCopyApproval = New-Object System.Windows.Forms.Button
$buttonCopyApproval.Location = New-Object System.Drawing.Point(393,249)
$buttonCopyApproval.Size = New-Object System.Drawing.Size(75,23)
$buttonCopyApproval.Text = 'Copy'

$labelResults = New-Object System.Windows.Forms.Label
$labelResults.Location = New-Object System.Drawing.Point(10,310)
$labelResults.Size = New-Object System.Drawing.Size(280,20)
$labelResults.Text = 'Logs'

$textResults = New-Object System.Windows.Forms.TextBox
$textResults.Location = New-Object System.Drawing.Point(10,330)
$textResults.Size = New-Object System.Drawing.Size(460,250)
$textResults.Multiline = $true

$form.controls.AddRange(@($label, $textbox, $textResults, $okButton, $resetButton, $textReadWrite, $labelReadWrite, $buttonCopyRW, $labelReadOnly, $textReadOnly, $buttonCopyRO, $labelApproval, $textApproval, $buttonCopyApproval, $labelResults, $updateButton))

#---------------------------------------------------------

#import csv file
$ShareDrive = Import-Csv -Path "$PSScriptRoot\Resource\Example File.csv"

function comparePaths ($PathInputted){
    $folderPaths = $_.'Folder Path'

    if ($folderPaths -like "$($PathInputted)"){
        $textResults.AppendText("Same Paths: " + $folderPaths + "`r`n")
        Write Host "Same Paths: " $folderPaths
    }
}

function initialSearch($PathInputted){
    
    $ShareDrive | ForEach {

        if ($PathInputted -eq $_.'Folder Path') {

            $textResults.AppendText("Server Name: " + $_.'Server' + "`r`n")
            $textResults.AppendText("Read/Write Access Group: " + $_.'Read\Write Access Group' + "`r`n")
            $textResults.AppendText("Read Only Access Group: " + $_.'Read Only Access Group' + "`r`n")
            $textResults.AppendText("Approval: " + $_.'Approval Required From' + "`r`n")
            $textResults.AppendText("Resolving Group: " + $_.'Resolving Group' + "`r`n")

        } else {

            comparePaths $PathInputted

        }

    }
 
} 

$okButton.add_Click({

    if ($textBox.Text -eq ""){

        $label.ForeColor = "Red"
        $label.Text = "Please enter the drive path"

    } else {

        initialSearch $textBox.Text

    }

})

$updateButton.add_Click({

    & "$PSScriptRoot\fileDownload.ps1"

})

$resetButton.add_Click({

    $textBox.Text = ""
    $textResults.Text = ""
    $textReadWrite.Text = ""
    $textReadOnly.Text = ""
    $textApproval.Text = ""

})

$buttonCopyRW.add_Click({

    Set-Clipboard -Value $textReadWrite.Text

})

$buttonCopyRO.add_Click({

    Set-Clipboard -Value $textReadOnly.Text

})

$buttonCopyApproval.add_Click({

    Set-Clipboard -Value $textApproval.Text

})


$form.Add_Shown({$textBox.Select()})

[void] $form.ShowDialog()