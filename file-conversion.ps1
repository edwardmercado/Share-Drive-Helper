#convert .xlsx to .csv

Function ExcelToCsv ($File){
    $myDir = "$PSScriptRoot\Resource"
    $excelFile = "$myDir\" + $File + ".xlsx"
    $Excel = New-Object -ComObject Excel.Application
    $Excel.Visible = $false
    $Excel.DisplayAlerts = $false

    $wb = $Excel.Workbooks.Open($excelFile)

    foreach ($ws in $wb.Worksheets) {
        $ws.SaveAs("$myDir\" + $File + ".csv", 6)
    }

    $Excel.Quit()

}

$FileName = "Global Share Drives"
ExcelToCsv -File $FileName