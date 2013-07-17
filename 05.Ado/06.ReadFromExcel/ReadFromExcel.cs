using System;
using System.Collections.Generic;
using System.Data.OleDb;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ReadFromExcel
{
    //06.Create an Excel file with 2 columns: name and score:
    //Write a program that reads your MS Excel file through the OLE DB data provider and displays the name and score row by row.

    class ReadFromExcel
    {
        static void Main()
        {
            string path = @"../../scores.xlsx";
            string connStr = "Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + path + ";Extended Properties=Excel 12.0;";

            OleDbConnection excelCon = new OleDbConnection(connStr);
            excelCon.Open();

            using (excelCon)
            {
                OleDbCommand command = new OleDbCommand(@"SELECT * FROM [Sheet1$]", excelCon);
                OleDbDataReader reader = command.ExecuteReader();

                using (reader)
                {
                    Console.WriteLine("Participants:");
                    Console.WriteLine("-------------");
                    while (reader.Read())
                    {
                        string name = (string)reader["Name"];
                        double score = (double)reader["Score"];

                        Console.WriteLine("Player name: {0,-10} | Player score: {1:F2}", name, score);
                    }
                }
            }
        }
    }
}
