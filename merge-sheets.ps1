#Merge all excel files into one

$file1 = "$PSScriptRoot\Resouce\Example File.xslx" #src path
$file2 = "$PSScriptRoot\Resource\Example File2.xlsx" #dest path

$xl = new-object -c excel.application
$xl.displayAlerts = $false

$wb1 = $x1.workbooks.open($file1, $null, $true)
$wb2 = $x1.workbooks.open($file2)

$sh1_wb2 = $wb2.sheets.item(1)
$sheetToCopy = $wb1.sheets.item('Sheet 1')
$sheetToCopy.copy($sh1_wb2)

$wb1.close($false)
$wb2.close($true)

$xl.quit()

spps -n excel

