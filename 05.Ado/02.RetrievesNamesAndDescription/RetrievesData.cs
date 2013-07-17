using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RetrievesNamesAndDescription
{
    //02.Write a program that retrieves the name and description of all categories in the Northwind DB.
    class RetrievesData
    {
        static void Main()
        {
            SqlConnection dbCon = new SqlConnection("Server=.\\;Database=Northwind; Integrated Security=true");
            dbCon.Open();
            using (dbCon)
            {
                SqlCommand selectNamesAndDescript = new SqlCommand(
              "SELECT CategoryName AS Name, Description FROM Categories ORDER BY Name", dbCon);
                SqlDataReader reader = selectNamesAndDescript.ExecuteReader();
                using (reader)
                {
                    Console.WriteLine("              Name | Description");
                    Console.WriteLine("              ------------------");
                    short counter = 0;
                    while (reader.Read())
                    {
                        counter++;
                        string name = (string)reader["Name"];
                        string description = (string)reader["Description"];
                        Console.WriteLine("{0:00}|{1,15} | {2}", counter, name, description);
                    }
                    Console.WriteLine();
                }
            }
        }
    }
}
