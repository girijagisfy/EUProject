using DocumentFormat.OpenXml;
using DocumentFormat.OpenXml.Packaging;
using DocumentFormat.OpenXml.Spreadsheet;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;


namespace CF.Models
{
    public class ExcelUtlity
    {
        DbErrorLog db = new DbErrorLog();
        public StreamWriter logfile;//logfile creates the log entry in the text file
        /// <summary>
        /// FUNCTION FOR EXPORT TO EXCEL
        /// </summary>
        /// <param name="dataSet"></param>
        /// <param name="worksheetName"></param>
        /// <param name="saveAsLocation"></param>
        /// <returns></returns>
        public ExcelUtlity()
        {
            Random rn = new Random();
            int Order = rn.Next(10000000, 99999999);
            logfile = new StreamWriter("C:\\inetpub\\wwwroot\\SQL\\log\\logfile " + DateTime.Now.Year + "" + DateTime.Now.Month + "" + DateTime.Now.Day + DateTime.Now.Hour + "_" + DateTime.Now.Minute + "_" + DateTime.Now.Second + "_" + DateTime.Now.Millisecond + "_" + Order + ".txt", true);// creating a textfile for logfile data entry
        }
        public bool WriteDataSetToExcel(System.Data.DataSet dataset, string worksheetName, string saveAsLocation, string ReporType)
        {
            logfile.WriteLine("Start writing here now");
            logfile.Flush();
            Microsoft.Office.Interop.Excel.Application excel;
            Microsoft.Office.Interop.Excel.Workbook excelworkBook;
            Microsoft.Office.Interop.Excel.Worksheet excelSheet;
            Microsoft.Office.Interop.Excel.Range excelCellrange;

            try
            {
                logfile.WriteLine("in try");
                logfile.Flush();
                // Start Excel and get Application object.
                excel = new Microsoft.Office.Interop.Excel.Application();
                logfile.WriteLine("after excel application obj");
                logfile.Flush();
                excel.Interactive = false;
                // for making Excel visible
                excel.Visible = false;
                excel.DisplayAlerts = false;

                // Creation a new Workbook
                int f = 0;
                logfile.WriteLine("before excel workbook obj");
                logfile.Flush();
                excelworkBook = excel.Workbooks.Add(Type.Missing);
                logfile.WriteLine("after excel workbook obj");
                logfile.Flush();
                for (int xy = 0; xy < dataset.Tables.Count; xy++)
                {
                    if (dataset.Tables[xy].Columns.Count > 1)
                    {
                        if (dataset.Tables[xy].Rows.Count >= 1)
                        {
                            if (f == 0)
                            {
                                f += 1;
                            }
                            else
                            {
                                excelworkBook.Worksheets.Add();
                                f += 1;
                            }
                        }
                    }
                }
                //excelworkBook.Worksheets.Add();
                //excelworkBook.Worksheets.Add();
                //excelworkBook.Worksheets.Add();
                int sheetno = 1;
                foreach (DataTable dataTable in dataset.Tables)
                {
                    worksheetName = dataTable.TableName;
                    if (dataTable.Columns.Count > 1)
                    {
                        if (dataTable.Rows.Count >= 1)
                        {

                            // Workk sheet
                            excelSheet = (Microsoft.Office.Interop.Excel.Worksheet)excelworkBook.Worksheets[sheetno];
                            excelSheet.Name = worksheetName;


                            //excelSheet.Cells[1, 1] = ReporType;
                            //excelSheet.Cells[1, 2] = "Date : " + DateTime.Now.ToShortDateString();

                            // loop through each row and add values to our sheet
                            int rowcount = 1;
                            foreach (DataRow datarow in dataTable.Rows)
                            {
                                rowcount += 1;
                                for (int i = 1; i <= dataTable.Columns.Count; i++)
                                {
                                    // on the first iteration we add the column headers
                                    if (rowcount == 2)
                                    {
                                        excelSheet.Cells[1, i] = dataTable.Columns[i - 1].ColumnName;
                                        excelSheet.Cells.Font.Color = System.Drawing.Color.Black;
                                    }

                                    excelSheet.Cells[rowcount, i] = datarow[i - 1].ToString();

                                    //for alternate rows
                                    //if (rowcount > 2)
                                    //{
                                    //    if (i == dataTable.Columns.Count)
                                    //    {
                                    //        if (rowcount % 2 == 0)
                                    //        {
                                    //            excelCellrange = excelSheet.Range[excelSheet.Cells[rowcount, 1], excelSheet.Cells[rowcount, dataTable.Columns.Count]];
                                    //           // FormattingExcelCells(excelCellrange, "#CCCCFF", System.Drawing.Color.Black,false);
                                    //        }

                                    //    }
                                    //}

                                }

                            }

                            // now we resize the columns
                            excelCellrange = excelSheet.Range[excelSheet.Cells[1, 1], excelSheet.Cells[rowcount, dataTable.Columns.Count]];
                            excelCellrange.EntireColumn.AutoFit();
                            Microsoft.Office.Interop.Excel.Borders border = excelCellrange.Borders;
                            border.LineStyle = Microsoft.Office.Interop.Excel.XlLineStyle.xlContinuous;
                            border.Weight = 2d;
                            excelCellrange = excelSheet.Range[excelSheet.Cells[1, 1], excelSheet.Cells[1, dataTable.Columns.Count]];
                            FormattingExcelCells(excelCellrange, "#000099", System.Drawing.Color.White, true);
                            excelCellrange = excelSheet.Range[excelSheet.Cells[1, 1], excelSheet.Cells[dataTable.Rows.Count + 1, 1]];
                            FormattingExcelCells(excelCellrange, "#000099", System.Drawing.Color.White, true);
                            sheetno += 1;
                        }
                    }
                }
                //now save the workbook and exit Excel
                excelworkBook.SaveAs(saveAsLocation); ;
                excelworkBook.Close();
                excel.Quit();
                return true;
            }
            catch (Exception ex)
            {

                logfile.WriteLine("Enter in catch block");
                logfile.Flush();
                logfile.WriteLine(ex.StackTrace.ToString());
                logfile.Flush();
                logfile.WriteLine(ex.Message);
                logfile.Flush();
                return false;
            }
            finally
            {
                logfile.WriteLine("in final");
                logfile.Flush();
                logfile.Close();
                excelSheet = null;
                excelCellrange = null;
                excelworkBook = null;
            }

        }

        /// <summary>
        /// FUNCTION FOR EXPORT TO EXCEL
        /// </summary>
        /// <param name="dataTable"></param>
        /// <param name="worksheetName"></param>
        /// <param name="saveAsLocation"></param>
        /// <returns></returns>
        public bool WriteDataTableToExcel(System.Data.DataTable dataTable, string worksheetName, string saveAsLocation, string ReporType)
        {
            Microsoft.Office.Interop.Excel.Application excel;
            Microsoft.Office.Interop.Excel.Workbook excelworkBook;
            Microsoft.Office.Interop.Excel.Worksheet excelSheet;
            Microsoft.Office.Interop.Excel.Range excelCellrange;

            try
            {
                // Start Excel and get Application object.
                excel = new Microsoft.Office.Interop.Excel.Application();

                // for making Excel visible
                excel.Visible = false;
                excel.DisplayAlerts = false;

                // Creation a new Workbook
                excelworkBook = excel.Workbooks.Add(Type.Missing);

                // Workk sheet
                excelSheet = (Microsoft.Office.Interop.Excel.Worksheet)excelworkBook.ActiveSheet;
                excelSheet.Name = worksheetName;


                excelSheet.Cells[1, 1] = ReporType;
                excelSheet.Cells[1, 2] = "Date : " + DateTime.Now.ToShortDateString();

                // loop through each row and add values to our sheet
                int rowcount = 2;

                foreach (DataRow datarow in dataTable.Rows)
                {
                    rowcount += 1;
                    for (int i = 1; i <= dataTable.Columns.Count; i++)
                    {
                        // on the first iteration we add the column headers
                        if (rowcount == 3)
                        {
                            excelSheet.Cells[2, i] = dataTable.Columns[i - 1].ColumnName;
                            excelSheet.Cells.Font.Color = System.Drawing.Color.Black;

                        }

                        excelSheet.Cells[rowcount, i] = datarow[i - 1].ToString();

                        //for alternate rows
                        if (rowcount > 3)
                        {
                            if (i == dataTable.Columns.Count)
                            {
                                if (rowcount % 2 == 0)
                                {
                                    excelCellrange = excelSheet.Range[excelSheet.Cells[rowcount, 1], excelSheet.Cells[rowcount, dataTable.Columns.Count]];
                                    FormattingExcelCells(excelCellrange, "#CCCCFF", System.Drawing.Color.Black, false);
                                }

                            }
                        }

                    }

                }

                // now we resize the columns
                excelCellrange = excelSheet.Range[excelSheet.Cells[1, 1], excelSheet.Cells[rowcount, dataTable.Columns.Count]];
                excelCellrange.EntireColumn.AutoFit();
                Microsoft.Office.Interop.Excel.Borders border = excelCellrange.Borders;
                border.LineStyle = Microsoft.Office.Interop.Excel.XlLineStyle.xlContinuous;
                border.Weight = 2d;


                excelCellrange = excelSheet.Range[excelSheet.Cells[1, 1], excelSheet.Cells[2, dataTable.Columns.Count]];
                FormattingExcelCells(excelCellrange, "#000099", System.Drawing.Color.White, true);


                //now save the workbook and exit Excel


                excelworkBook.SaveAs(saveAsLocation); ;
                excelworkBook.Close();
                excel.Quit();
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
            finally
            {
                excelSheet = null;
                excelCellrange = null;
                excelworkBook = null;
            }

        }

        /// <summary>
        /// FUNCTION FOR FORMATTING EXCEL CELLS
        /// </summary>
        /// <param name="range"></param>
        /// <param name="HTMLcolorCode"></param>
        /// <param name="fontColor"></param>
        /// <param name="IsFontbool"></param>
        public void FormattingExcelCells(Microsoft.Office.Interop.Excel.Range range, string HTMLcolorCode, System.Drawing.Color fontColor, bool IsFontbool)
        {
            range.Interior.Color = System.Drawing.ColorTranslator.FromHtml(HTMLcolorCode);
            range.Font.Color = System.Drawing.ColorTranslator.ToOle(fontColor);
            if (IsFontbool == true)
            {
                range.Font.Bold = IsFontbool;
            }
        }

        //public System.Data.DataSet ExceltoDataTable(string path)
        //{
        //    //Instance reference for Excel Application
        //    Microsoft.Office.Interop.Excel.Application objXL = null;
        //    //Workbook refrence
        //    Microsoft.Office.Interop.Excel.Workbook objWB = null;
        //    System.Data.DataSet ds = new System.Data.DataSet();
        //    try
        //    {
        //        //Instancing Excel using COM services
        //        objXL = new Microsoft.Office.Interop.Excel.Application();
        //        //Adding WorkBook
        //        objWB = objXL.Workbooks.Open(path);
        //        foreach (Microsoft.Office.Interop.Excel.Worksheet objSHT in objWB.Worksheets)
        //        {
        //            int rows = objSHT.UsedRange.Rows.Count;
        //            int cols = objSHT.UsedRange.Columns.Count;
        //            System.Data.DataTable dt = new System.Data.DataTable(objSHT.Name);
        //            int noofrow = 1;
        //            //If 1st Row Contains unique Headers for datatable include this part else remove it
        //            //Start
        //            for (int c = 1; c <= cols; c++)
        //            {
        //                string colname = objSHT.Cells[1, c].Text;
        //                dt.Columns.Add(colname);
        //                noofrow = 2;
        //            }
        //            //END
        //            for (int r = noofrow; r <= rows; r++)
        //            {
        //                DataRow dr = dt.NewRow();
        //                for (int c = 1; c <= cols; c++)
        //                {
        //                    dr[c - 1] = objSHT.Cells[r, c].Text;
        //                }
        //                dt.Rows.Add(dr);
        //            }
        //            ds.Tables.Add(dt);
        //        }
        //        //Closing workbook
        //        objWB.Close();
        //        //Closing excel application
        //        objXL.Quit();
        //        return ds;
        //    }
        //    catch (Exception ex)
        //    {
        //        objWB.Saved = true;
        //        //Closing work book
        //        objWB.Close();
        //        //Closing excel application
        //        objXL.Quit();
        //        //Response.Write("Illegal permission");
        //        return ds;
        //    }
        //}
        public DataSet ExceltoDataTable(string fileName)
        {
            DataSet ds = new DataSet();
            try
            {


                using (SpreadsheetDocument spreadSheetDocument = SpreadsheetDocument.Open(fileName, false))
                {
                    WorkbookPart workbookPart = spreadSheetDocument.WorkbookPart;
                    IEnumerable<Sheet> sheets = spreadSheetDocument.WorkbookPart.Workbook.GetFirstChild<Sheets>().Elements<Sheet>();
                    Sheets thesheetcollection = workbookPart.Workbook.GetFirstChild<Sheets>();
                    foreach (Sheet thesheet in thesheetcollection)
                    {
                        DataTable dataTable = new DataTable(thesheet.Name);
                        Worksheet workSheet = ((WorksheetPart)workbookPart.GetPartById(thesheet.Id)).Worksheet;
                        SheetData sheetData = (SheetData)workSheet.GetFirstChild<SheetData>();

                        //string relationshipId = sheets.First().Id.Value;
                        //WorksheetPart worksheetPart = (WorksheetPart)spreadSheetDocument.WorkbookPart.GetPartById(relationshipId);
                        //Worksheet workSheet = worksheetPart.Worksheet;
                        //SheetData sheetData = workSheet.GetFirstChild<SheetData>();
                        IEnumerable<Row> rows = sheetData.Descendants<Row>();

                        foreach (Cell cell in rows.ElementAt(0))
                        {
                            dataTable.Columns.Add(GetCellValue(spreadSheetDocument, cell));
                        }

                        foreach (Row row in rows)
                        {
                            DataRow dataRow = dataTable.NewRow();
                            for (int i = 0; i < row.Descendants<Cell>().Count(); i++)
                            {
                                dataRow[i] = GetCellValue(spreadSheetDocument, row.Descendants<Cell>().ElementAt(i));
                            }

                            dataTable.Rows.Add(dataRow);
                        }
                        dataTable.Rows.RemoveAt(0);
                        ds.Tables.Add(dataTable);
                    }

                }
            }
            catch (Exception ex)
            {
                string msg = ex.Message;
            }
            return ds;
        }

        private static string GetCellValue(SpreadsheetDocument document, Cell cell)
        {
            SharedStringTablePart stringTablePart = document.WorkbookPart.SharedStringTablePart;
            string value = string.Empty;

            try
            {



                value = cell.CellValue.InnerXml;

                if (cell.DataType != null && cell.DataType.Value == CellValues.SharedString)
                {
                    return stringTablePart.SharedStringTable.ChildElements[Int32.Parse(value)].InnerText;
                }
                else
                {

                }
            }
            catch (Exception ex)
            {

            }
            return value;
        }
        public void ExportDataSet(DataSet ds, string destination)
        {
            using (var workbook = SpreadsheetDocument.Create(destination, DocumentFormat.OpenXml.SpreadsheetDocumentType.Workbook))
            {
                var workbookPart = workbook.AddWorkbookPart();

                workbook.WorkbookPart.Workbook = new DocumentFormat.OpenXml.Spreadsheet.Workbook();

                workbook.WorkbookPart.Workbook.Sheets = new DocumentFormat.OpenXml.Spreadsheet.Sheets();

                foreach (System.Data.DataTable table in ds.Tables)
                {
                    if (table.Columns.Count > 1)
                    {
                        if (table.Rows.Count >= 1)
                        {
                            var sheetPart = workbook.WorkbookPart.AddNewPart<WorksheetPart>();
                            var sheetData = new DocumentFormat.OpenXml.Spreadsheet.SheetData();
                            sheetPart.Worksheet = new DocumentFormat.OpenXml.Spreadsheet.Worksheet(sheetData);

                            DocumentFormat.OpenXml.Spreadsheet.Sheets sheets = workbook.WorkbookPart.Workbook.GetFirstChild<DocumentFormat.OpenXml.Spreadsheet.Sheets>();
                            string relationshipId = workbook.WorkbookPart.GetIdOfPart(sheetPart);

                            uint sheetId = 1;
                            if (sheets.Elements<DocumentFormat.OpenXml.Spreadsheet.Sheet>().Count() > 0)
                            {
                                sheetId =
                                sheets.Elements<DocumentFormat.OpenXml.Spreadsheet.Sheet>().Select(s => s.SheetId.Value).Max() + 1;
                            }

                            DocumentFormat.OpenXml.Spreadsheet.Sheet sheet = new DocumentFormat.OpenXml.Spreadsheet.Sheet() { Id = relationshipId, SheetId = sheetId, Name = table.TableName };
                            sheets.Append(sheet);

                            DocumentFormat.OpenXml.Spreadsheet.Row headerRow = new DocumentFormat.OpenXml.Spreadsheet.Row();

                            List<String> columns = new List<string>();
                            foreach (System.Data.DataColumn column in table.Columns)
                            {
                                columns.Add(column.ColumnName);

                                DocumentFormat.OpenXml.Spreadsheet.Cell cell = new DocumentFormat.OpenXml.Spreadsheet.Cell();
                                cell.DataType = DocumentFormat.OpenXml.Spreadsheet.CellValues.String;
                                cell.CellValue = new DocumentFormat.OpenXml.Spreadsheet.CellValue(column.ColumnName);

                                headerRow.AppendChild(cell);

                            }


                            sheetData.AppendChild(headerRow);

                            foreach (System.Data.DataRow dsrow in table.Rows)
                            {
                                DocumentFormat.OpenXml.Spreadsheet.Row newRow = new DocumentFormat.OpenXml.Spreadsheet.Row();
                                foreach (String col in columns)
                                {
                                    DocumentFormat.OpenXml.Spreadsheet.Cell cell = new DocumentFormat.OpenXml.Spreadsheet.Cell();
                                    cell.DataType = DocumentFormat.OpenXml.Spreadsheet.CellValues.String;
                                    cell.CellValue = new DocumentFormat.OpenXml.Spreadsheet.CellValue(dsrow[col].ToString()); //
                                    newRow.AppendChild(cell);
                                }

                                sheetData.AppendChild(newRow);
                            }
                        }
                    }

                }

            }
        }
        public void ExportDataSetmatrix(DataSet ds, string destination)
        {
            using (var workbook = SpreadsheetDocument.Open(destination, true))
            {
                //var workbookPart = workbook.AddWorkbookPart();

                // workbook.WorkbookPart.Workbook = new DocumentFormat.OpenXml.Spreadsheet.Workbook();

                // workbook.WorkbookPart.Workbook.Sheets = new DocumentFormat.OpenXml.Spreadsheet.Sheets();

                foreach (System.Data.DataTable table in ds.Tables)
                {
                    if (table.Columns.Count > 1)
                    {
                        if (table.Rows.Count >= 1)
                        {
                            var sheetPart = workbook.WorkbookPart.AddNewPart<WorksheetPart>();
                            var sheetData = new DocumentFormat.OpenXml.Spreadsheet.SheetData();
                            sheetPart.Worksheet = new DocumentFormat.OpenXml.Spreadsheet.Worksheet(sheetData);

                            DocumentFormat.OpenXml.Spreadsheet.Sheets sheets = workbook.WorkbookPart.Workbook.GetFirstChild<DocumentFormat.OpenXml.Spreadsheet.Sheets>();
                            string relationshipId = workbook.WorkbookPart.GetIdOfPart(sheetPart);

                            uint sheetId = 1;
                            if (sheets.Elements<DocumentFormat.OpenXml.Spreadsheet.Sheet>().Count() > 0)
                            {
                                sheetId =
                                sheets.Elements<DocumentFormat.OpenXml.Spreadsheet.Sheet>().Select(s => s.SheetId.Value).Max() + 1;
                            }

                            DocumentFormat.OpenXml.Spreadsheet.Sheet sheet = new DocumentFormat.OpenXml.Spreadsheet.Sheet() { Id = relationshipId, SheetId = sheetId, Name = table.TableName };
                            sheets.Append(sheet);

                            DocumentFormat.OpenXml.Spreadsheet.Row headerRow = new DocumentFormat.OpenXml.Spreadsheet.Row();

                            List<String> columns = new List<string>();
                            foreach (System.Data.DataColumn column in table.Columns)
                            {
                                columns.Add(column.ColumnName);

                                DocumentFormat.OpenXml.Spreadsheet.Cell cell = new DocumentFormat.OpenXml.Spreadsheet.Cell();
                                cell.DataType = DocumentFormat.OpenXml.Spreadsheet.CellValues.String;
                                cell.CellValue = new DocumentFormat.OpenXml.Spreadsheet.CellValue(column.ColumnName);

                                headerRow.AppendChild(cell);

                            }


                            sheetData.AppendChild(headerRow);

                            foreach (System.Data.DataRow dsrow in table.Rows)
                            {
                                DocumentFormat.OpenXml.Spreadsheet.Row newRow = new DocumentFormat.OpenXml.Spreadsheet.Row();
                                foreach (String col in columns)
                                {
                                    DocumentFormat.OpenXml.Spreadsheet.Cell cell = new DocumentFormat.OpenXml.Spreadsheet.Cell();
                                    cell.DataType = DocumentFormat.OpenXml.Spreadsheet.CellValues.String;
                                    cell.CellValue = new DocumentFormat.OpenXml.Spreadsheet.CellValue(dsrow[col].ToString()); //
                                    newRow.AppendChild(cell);
                                }

                                sheetData.AppendChild(newRow);
                            }
                        }
                    }

                }

            }
        }
        public void ExportDataSetToExcelold(DataSet ds, string destination)
        {
            var app = new Microsoft.Office.Interop.Excel.Application();
            var wb = app.Workbooks.Add();
            wb.SaveAs(destination);
            wb.Close();
            //Creae an Excel application instance
            Microsoft.Office.Interop.Excel.Application excelApp = new Microsoft.Office.Interop.Excel.Application();

            //Create an Excel workbook instance and open it from the predefined location
            Microsoft.Office.Interop.Excel.Workbook excelWorkBook = excelApp.Workbooks.Open(destination);

            foreach (DataTable table in ds.Tables)
            {
                //Add a new worksheet to workbook with the Datatable name
                Microsoft.Office.Interop.Excel.Worksheet excelWorkSheet = excelWorkBook.Sheets.Add();
                excelWorkSheet.Name = table.TableName;

                for (int i = 1; i < table.Columns.Count + 1; i++)
                {
                    excelWorkSheet.Cells[1, i] = table.Columns[i - 1].ColumnName;
                }

                for (int j = 0; j < table.Rows.Count; j++)
                {
                    for (int k = 0; k < table.Columns.Count; k++)
                    {
                        excelWorkSheet.Cells[j + 2, k + 1] = table.Rows[j].ItemArray[k].ToString();
                    }
                }
            }

            excelWorkBook.Save();
            excelWorkBook.Close();
            excelApp.Quit();

        }

        public void ExportDataSetToExcel(DataSet ds, string filename)
        {
            // Response.Write("<script>alert('excel fired')</script>");
            Random rn = new Random();
            int Order = rn.Next(10000000, 99999999);
            string filepath = ConfigurationManager.ConnectionStrings["DownloadReport"].ConnectionString;
            try
            {
                string excelpath = filepath + filename;
                System.IO.File.Copy(filepath + "WFGReport.xlsx", excelpath, true);
                //Creae an Excel application instance
                Microsoft.Office.Interop.Excel.Application excelApp = new Microsoft.Office.Interop.Excel.Application();
                // Response.Write("<script>alert('excelapp created')</script>");

                //Create an Excel workbook instance and open it from the predefined location
                Microsoft.Office.Interop.Excel.Workbook excelWorkBook = excelApp.Workbooks.Open(excelpath);
                int lastRow = ds.Tables[0].Rows.Count;
                //Response.Redirect("<script>alert('excelWorkBook')</script>");

                foreach (DataTable table in ds.Tables)
                {
                    //Add a new worksheet to workbook with the Datatable name
                    //Excel.Worksheet excelWorkSheet = excelWorkBook.Sheets.Add();
                    //excelWorkSheet.Name = table.TableName;

                    Microsoft.Office.Interop.Excel.Worksheet excelWorkSheet = (Microsoft.Office.Interop.Excel.Worksheet)excelWorkBook.Worksheets.get_Item("Sheet1");

                    for (int i = 2; i < table.Columns.Count + 1; i++)
                    {
                        excelWorkSheet.Cells[1, i - 1] = table.Columns[i - 1].ColumnName;
                    }

                    for (int j = 1; j < table.Rows.Count + 1; j++)
                    {
                        for (int k = 1; k < table.Columns.Count; k++)
                        {
                            excelWorkSheet.Cells[j + 1, k] = table.Rows[j - 1].ItemArray[k].ToString();
                        }
                    }
                    // excelWorkSheet.Rows[lastRow].Style.Color = Color.LightBlue;
                }

                excelWorkBook.Save();
                excelWorkBook.Close();
                excelApp.Quit();
                //Response.Write(excelpath);

                // Response.Write("<script>alert('excel completed')</script>");
                //DownloadXlsx(excelpath, filename);
                //DownloadPDF(excelpath);
            }
            catch (Exception ex)
            {
                ex.Message.ToString();
                db.AppendToErrorLog(ex.Message.ToString(), ex.StackTrace.ToString(), "", "");
            }
        }

        #region Reading Excel sheet into dataset******
        public DataTable ExtractExcelSheetValuesToDataTable(string Path)
        {
            DataTable dt = new DataTable();

            using (SpreadsheetDocument spreadSheetDocument = SpreadsheetDocument.Open(Path, false))
            {

                WorkbookPart workbookPart = spreadSheetDocument.WorkbookPart;
                IEnumerable<Sheet> sheets = spreadSheetDocument.WorkbookPart.Workbook.GetFirstChild<Sheets>().Elements<Sheet>();
                string relationshipId = sheets.First().Id.Value;
                WorksheetPart worksheetPart = (WorksheetPart)spreadSheetDocument.WorkbookPart.GetPartById(relationshipId);
                Worksheet workSheet = worksheetPart.Worksheet;
                SheetData sheetData = workSheet.GetFirstChild<SheetData>();
                IEnumerable<Row> rows = sheetData.Descendants<Row>();

                foreach (Cell cell in rows.ElementAt(0))
                {
                    dt.Columns.Add(GetCellValue1(spreadSheetDocument, cell));
                }
                foreach (Row row in rows) //this will also include your header row...
                {
                    DataRow tempRow = dt.NewRow();
                    int columnIndex = 0;
                    int count = 0;
                    foreach (Cell cell in row.Descendants<Cell>())
                    {
                        // Gets the column index of the cell with data
                        int cellColumnIndex = (int)GetColumnIndexFromName(GetColumnName(cell.CellReference));
                        cellColumnIndex--; //zero based index
                        if (columnIndex < cellColumnIndex)
                        {
                            do
                            {
                                tempRow[columnIndex] = ""; //Insert blank data here;
                                columnIndex++;
                            }
                            while (columnIndex < cellColumnIndex);
                        }
                        tempRow[columnIndex] = GetCellValue1(spreadSheetDocument, cell);

                        columnIndex++;
                    }

                    dt.Rows.Add(tempRow);
                }

            }
            dt.Rows.RemoveAt(0); //...so i'm taking it out here.
            DataSet Ds = new DataSet();
            Ds.Tables.Add(dt);
            return dt;
        }

        public string GetCellValue1(SpreadsheetDocument document, Cell cell)
        {

            SharedStringTablePart stringTablePart = document.WorkbookPart.SharedStringTablePart;
            var workbookPart = document.WorkbookPart;
            string name = GetColumnName(cell.CellReference);

            string returnval = string.Empty;
            if (cell.CellValue == null)
            {
                returnval = "";
            }

            //double p = double.TryParse(cell.CellValue.InnerXml);
            //string t = DateTime.FromOADate(value);


            if (cell.DataType != null && cell.DataType == CellValues.SharedString)
            {
                string value = cell.CellValue.InnerXml;
                returnval = stringTablePart.SharedStringTable.ChildElements[Int32.Parse(value)].InnerText.ToString();
            }
            //else if (cell.DataType != null && cell.DataType == CellValues.Date)
            //{

            //    return Convert.ToString(Convert.ToDateTime(stringTablePart.SharedStringTable.ChildElements[Int32.Parse(value)].InnerText));
            //}
            else
            {

                returnval = ReadExcelCell(cell, workbookPart);
            }
            return returnval;

        }

        /// <summary>
        /// Given just the column name (no row index), it will return the zero based column index.
        /// Note: This method will only handle columns with a length of up to two (ie. A to Z and AA to ZZ). 
        /// A length of three can be implemented when needed.
        /// </summary>
        /// <param name="columnName">Column Name (ie. A or AB)</param>
        /// <returns>Zero based index if the conversion was successful; otherwise null</returns>
        public static int? GetColumnIndexFromName(string columnName)
        {
            //return columnIndex;
            string name = columnName;
            int number = 0;
            int pow = 1;
            for (int i = name.Length - 1; i >= 0; i--)
            {
                number += (name[i] - 'A' + 1) * pow;
                pow *= 26;
            }
            return number;

        }

        /// <summary>
        /// Given a cell name, parses the specified cell to get the column name.
        /// </summary>
        /// <param name="cellReference">Address of the cell (ie. B2)</param>
        /// <returns>Column Name (ie. B)</returns>
        public static string GetColumnName(string cellReference)
        {
            // Create a regular expression to match the column name portion of the cell name.
            Regex regex = new Regex("[A-Za-z]+");
            Match match = regex.Match(cellReference);

            return match.Value;
        }



        #endregion




        public string ReadExcelCell(Cell cell, WorkbookPart workbookPart)
        {
            string date = "";
            var cellValue = cell.CellValue;
            if (cell.InnerText == null || cell.InnerText == "")
            {
                return "";
            }
            var text = (cellValue == null) ? cell.InnerText : cellValue.Text;
            if (cell.DataType?.Value == CellValues.SharedString)
            {
                text = workbookPart.SharedStringTablePart.SharedStringTable
                    .Elements<SharedStringItem>().ElementAt(
                        Convert.ToInt32(cell.CellValue.Text)).InnerText;
            }

            var cellText = (text ?? string.Empty).Trim();
            date = cellText;

            //     var cellWithType = new ExcelCellWithType();

            if (cell.StyleIndex != null)
            {
                var cellFormat = workbookPart.WorkbookStylesPart.Stylesheet.CellFormats.ChildElements[
                    int.Parse(cell.StyleIndex.InnerText)] as CellFormat;

                if (cellFormat != null)
                {
                    //  cellWithType.ExcelCellFormat = cellFormat.NumberFormatId;

                    var dateFormat = GetDateTimeFormat(cellFormat.NumberFormatId);
                    if (!string.IsNullOrEmpty(dateFormat))
                    {
                        //  cellWithType.IsDateTimeType = true;

                        if (!string.IsNullOrEmpty(cellText))
                        {
                            double cellDouble;
                            if (double.TryParse(cellText, out cellDouble))
                            {
                                var theDate = DateTime.FromOADate(cellDouble);
                                cellText = theDate.ToString(dateFormat);
                                date = cellText;
                            }
                        }
                    }
                }
            }
            else
            {
                date = cellText;
            }



            return date;
        }

        public Boolean fncompareDatatableColumnNames(DataSet dscmp1, DataSet dscmp2)
        {
            Boolean IsTrue = true;
            try
            {

                for (int i = 0; i < dscmp1.Tables.Count; i++)
                {
                    DataTable dt1 = new DataTable();
                    DataTable dt2 = new DataTable();
                    dt1 = dscmp1.Tables[i];
                    dt2 = dscmp2.Tables[dscmp1.Tables[i].TableName];
                    for (int j = 0; j < dt1.Columns.Count; j++)
                    {
                        if (dt1.Columns[j].ColumnName.Contains("&lt;") || dt2.Columns[j].ColumnName.Contains("&lt;") || dt1.Columns[j].ColumnName.Contains("&gt;") || dt2.Columns[j].ColumnName.Contains("&gt;"))
                        {

                        }
                        else
                        {
                            if (dt1.Columns[j].ColumnName != dt2.Columns[j].ColumnName)
                            {
                                IsTrue = false;
                                return IsTrue;
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                ex.Message.ToString();
                IsTrue = false;
            }


            return IsTrue;
        }
        public Boolean fncompareDatatablefirstcolumn(DataSet dscmp1, DataSet dscmp2)
        {
            Boolean IsTrue = true;
            try
            {
                for (int i = 0; i < dscmp1.Tables.Count; i++)
                {
                    DataTable dt1 = new DataTable();
                    DataTable dt2 = new DataTable();
                    dt1 = dscmp1.Tables[i];
                    dt2 = dscmp2.Tables[dscmp1.Tables[i].TableName];
                    for (int j = 0; j < dt1.Rows.Count; j++)
                    {
                        if (dt1.Rows[j][0].ToString().Contains("&lt;") || dt2.Rows[j][0].ToString().Contains("&lt;") || dt1.Rows[j][0].ToString().Contains("&gt;") || dt2.Rows[j][0].ToString().Contains("&gt;"))
                        {

                        }
                        else
                        {
                            if (dt1.Rows[j][0].ToString() != dt2.Rows[j][0].ToString())
                            {
                                IsTrue = false;
                                return IsTrue;
                            }
                        }
                    }

                }
            }
            catch (Exception ex)
            {
                ex.Message.ToString();
                IsTrue = false;
            }

            return IsTrue;
        }
        private readonly Dictionary<uint, string> DateFormatDictionary = new Dictionary<uint, string>()
        {
            [14] = "dd/MM/yyyy",
            [15] = "d-MMM-yy",
            [16] = "d-MMM",
            [17] = "MMM-yy",
            [18] = "h:mm AM/PM",
            [19] = "h:mm:ss AM/PM",
            [20] = "h:mm",
            [21] = "h:mm:ss",
            [22] = "M/d/yy h:mm",
            [30] = "M/d/yy",
            [34] = "yyyy-MM-dd",
            [45] = "mm:ss",
            [46] = "[h]:mm:ss",
            [47] = "mmss.0",
            [51] = "MM-dd",
            [52] = "yyyy-MM-dd",
            [53] = "yyyy-MM-dd",
            [55] = "yyyy-MM-dd",
            [56] = "yyyy-MM-dd",
            [58] = "MM-dd",
            [165] = "M/d/yy",
            [166] = "dd MMMM yyyy",
            [167] = "dd/MM/yyyy",
            [168] = "dd/MM/yy",
            [169] = "d.M.yy",
            [170] = "yyyy-MM-dd",
            [171] = "dd MMMM yyyy",
            [172] = "d MMMM yyyy",
            [173] = "M/d",
            [174] = "M/d/yy",
            [175] = "MM/dd/yy",
            [176] = "d-MMM",
            [177] = "d-MMM-yy",
            [178] = "dd-MMM-yy",
            [179] = "MMM-yy",
            [180] = "MMMM-yy",
            [181] = "MMMM d, yyyy",
            [182] = "M/d/yy hh:mm t",
            [183] = "M/d/y HH:mm",
            [184] = "MMM",
            [185] = "MMM-dd",
            [186] = "M/d/yyyy",
            [187] = "d-MMM-yyyy"
        };

        private string GetDateTimeFormat(UInt32Value numberFormatId)
        {
            return DateFormatDictionary.ContainsKey(numberFormatId) ? DateFormatDictionary[numberFormatId] : string.Empty;
        }
    }
}
