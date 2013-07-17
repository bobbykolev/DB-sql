using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace NumOfRows
{
    //01.Write a program that retrieves from the Northwind sample database in 
    //MS SQL Server the number of  rows in the Categories table.
    public class RowsInCat
    {
        static void Main()
        {
            SqlConnection dbCon = new SqlConnection("Server=.\\;Database=Northwind; Integrated Security=true");
            dbCon.Open();
            using (dbCon)
            {
                SqlCommand countRows = new SqlCommand(
                    "SELECT COUNT(CategoryID) FROM Categories", dbCon);
                int rowsInCategoriesCount = (int)countRows.ExecuteScalar();
                Console.WriteLine("The number of rows in \"Categories\": {0} ", rowsInCategoriesCount);
                Console.WriteLine();
            }
        }
    }
}
