using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace ReadFromConsole
{
    class ReadFromConsole
    {
        //08.Write a program that reads a string from the console and finds all products that contain this string. 
        //Ensure you handle correctly characters like ', %, ", \ and _.
        static void Main()
        {
            SqlConnection dbCon = new SqlConnection("Server=.\\;Database=Northwind;Integrated Security=true");
            dbCon.Open();

            string searchString = Console.ReadLine().Replace("%", "[%]").Replace("_", "[_]").Replace("\\", "[\\]").Replace("\"", "[\"]");

            using (dbCon)
            {
                SqlCommand command = new SqlCommand(@"SELECT c.CategoryName, p.ProductName 
                                                        FROM Products p 
	                                                    JOIN Categories c 
                                                        ON c.CategoryID = p.CategoryID
                                                        WHERE p.ProductName LIKE @searchString
                                                        ORDER BY c.CategoryName", dbCon);
                command.Parameters.AddWithValue("@searchString", "%" + searchString + "%");

                SqlDataReader reader = command.ExecuteReader();

                using (reader)
                {
                    Console.WriteLine("  Category Name | Description");
                    Console.WriteLine("  ---------------------------");
                    short counter = 0;
                    while (reader.Read())
                    {
                        counter++;
                        string name = (string)reader["CategoryName"];
                        string description = (string)reader["ProductName"];

                        Console.WriteLine("{0:00}|{1,15} | {2}", counter, name, description);
                    }
                }
            }
        }
    }
}
