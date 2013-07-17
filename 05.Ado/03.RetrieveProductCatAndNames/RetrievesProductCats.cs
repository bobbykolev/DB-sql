using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace RetrieveProductCatAndNames
{
    //03.Write a program that retrieves from the Northwind database all product categories and the 
    //names of the products in each category. Can you do this with a single SQL query (with table join)?

    class RetrievesProductCats
    {
        static void Main()
        {
            SqlConnection dbCon = new SqlConnection("Server=.\\;Database=Northwind; Integrated Security=true");
            dbCon.Open();
            using (dbCon)
            {
                SqlCommand selectCatAndProd = new SqlCommand(
              "SELECT c.CategoryName AS [Category Name],  p.ProductName AS [Product Name] " +
                "FROM Categories c "+
                "JOIN Products p "+
                "ON c.CategoryID=p.CategoryID "+
                "ORDER BY [Category Name]", dbCon);
                SqlDataReader reader = selectCatAndProd.ExecuteReader();
                using (reader)
                {
                    Console.WriteLine("     Category Name | Product Name");
                    Console.WriteLine("     ----------------------------");
                    short counter = 0;
                    while (reader.Read())
                    {
                        counter++;
                        string catName = (string)reader["Category Name"];
                        string prodName = (string)reader["Product Name"];
                        Console.WriteLine("{0:00}|{1,15} | {2}", counter, catName, prodName);
                    }
                    Console.WriteLine();
                }
            }
        }
    }
}
