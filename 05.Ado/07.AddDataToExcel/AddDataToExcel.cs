using System;
using System.Collections.Generic;
using System.Data.OleDb;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AddDataToExcel
{
    //07.Implement appending new rows to the Excel file.
    class AddDataToExcel
    {
        private static void InsertData(string name, double score, OleDbConnection excelCon)
        {
            OleDbCommand InsertRow = new OleDbCommand(@"INSERT INTO [Sheet1$](Name, Score) VALUES(@name, @score)", excelCon);
            InsertRow.Parameters.AddWithValue("@name", name);
            InsertRow.Parameters.AddWithValue("@score", score);

            InsertRow.ExecuteNonQuery();
        }
        
        static void Main()
        {
            string path = @"../../scores.xlsx";
            string connStr = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + path + ";Extended Properties=Excel 12.0;";

            OleDbConnection excelCon = new OleDbConnection(connStr);

            excelCon.Open();

            using (excelCon)
            {
                InsertData("Gosho2", 6, excelCon);
                Console.WriteLine("Success!");
                Console.WriteLine();
            }
        }
    }
}
