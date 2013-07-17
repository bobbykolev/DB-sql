using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace InsertProduct
{
    class AddNewProduct
    {
        static void Main()
        {
            AddProduct("testProduct", 1, false);
        }

        private static void AddProduct(string name, int category, bool discontinued)
        {
            SqlConnection dbCon = new SqlConnection("Server=.\\;Database=Northwind; Integrated Security=true");
            dbCon.Open();
            using (dbCon)
            {
                SqlCommand cmdAddProduct
                    = new SqlCommand("INSERT INTO Products(ProductName, CategoryID, Discontinued) " +
                                                          "VALUES(@name, @category, @discontinued)", dbCon);

                cmdAddProduct.Parameters.AddWithValue("@name", name);
                cmdAddProduct.Parameters.AddWithValue("@category", category);
                cmdAddProduct.Parameters.AddWithValue("@discontinued", discontinued);
                cmdAddProduct.ExecuteNonQuery();
            }
        }
    }
}
