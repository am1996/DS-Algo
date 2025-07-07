# open xlsx file
$excel = New-Object -ComObject Excel.Application

$excel.Visible = $true
$excel.DisplayAlerts = $false
$workbook = $excel.Workbooks.Open("D:\Screenshots\DS-Algo\lobby\data.xlsx")
$worksheet = $workbook.Worksheets.Item(1)
$worksheet.Cells.Item(1, 1).Value2 = "Hello World"
$worksheet.Cells.Item(1, 2).Value2 = "Hello World 2"
$worksheet.Cells.Item(1,1).Font.Bold = $true
$worksheet.Cells.Item(1,2).Font.Italic = $true
$worksheet.Cells.Item(1,1).Interior.Color = 0xFF0000 # Red background
$worksheet.Cells.Item(1,2).Interior.Color = 0x00FF00 # Green background
#set column width
$worksheet.Columns.Item(1).ColumnWidth = 20
$worksheet.Columns.Item(2).ColumnWidth = 30
#set row height
$worksheet.Rows.Item(1).RowHeight = 25
# make border around the cells
$range = $worksheet.Range("A1:B1")
$range.Borders.LineStyle = 1 # xlContinuous
$range.Borders.Weight = 2 # xlMedium
$range.Borders.Color = 0x000000 # Black border
# Add a formula to a cell
$worksheet.Cells.Item(2, 1).Value2 = "=SUM(A1:B1)"
# Save the workbook
$workbook.Save()
# Close the workbook and Excel application
$workbook.Close()
$excel.Quit()
# Release the COM objects
[System.Runtime.Interopservices.Marshal]::ReleaseComObject($worksheet) | Out-Null
