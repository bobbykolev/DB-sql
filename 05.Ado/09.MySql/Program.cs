using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace MySql
{
    class MySql
    {
        static void Main()
        {
            //choose database!!!
            string connectionString = "Server=localhost; Database = uni; Uid = root; Pwd =; pooling = true;";
            MySqlConnection dbConnection = new MySqlConnection(connectionString);
            dbConnection.Open();

            using (dbConnection)
            {
                MySqlCommand checkExistingTable = new MySqlCommand(@"SELECT 1
                                                                    FROM INFORMATION_SCHEMA.TABLES
                                                                    WHERE TABLE_TYPE='BASE TABLE' 
                                                                    AND TABLE_NAME='Books'", dbConnection);

                int existing = Convert.ToInt32(checkExistingTable.ExecuteScalar());
                if (existing != 1)
                {
                    MySqlCommand createTable = new MySqlCommand(@"CREATE TABLE Books
                                                                (
                                                                        BookID int PRIMARY KEY AUTO_INCREMENT,
                                                                        Title nvarchar(100) NOT NULL,
                                                                        Author nvarchar(50) NOT NULL,
                                                                        PublishDate date NOT NULL,
                                                                        ISBN nvarchar(50) NOT NULL
 
                                                                )", dbConnection);

                    Console.WriteLine("Created table 'Book' ", createTable.ExecuteNonQuery());
                }

                AddProduct(dbConnection, "Sql For Dummies", "Unknown", new DateTime(2011, 1, 21), "KE2345");
                AddProduct(dbConnection, "MySql For Dummies", "Unknown", new DateTime(2010, 2, 15), "AD6432");
                ListAllBooks(dbConnection);
                FindBookByName(dbConnection, "dum");
            }
        }

        private static void FindBookByName(MySqlConnection dbConnection, string input)
        {
            MySqlCommand selectProducts = new MySqlCommand("SELECT * FROM Books WHERE Title LIKE @searchString", dbConnection);
            input = input.Replace("%", "[%]").Replace("'", "[']").Replace("\\", "[\\]").Replace("_", "[_]").Replace("\"", "[\"]");
            selectProducts.Parameters.AddWithValue("@searchString", "%" + input + "%");

            MySqlDataReader result = selectProducts.ExecuteReader();

            using (result)
            {
                Console.WriteLine();
                Console.WriteLine("Found Books");
                Console.WriteLine("-----------");
                while (result.Read())
                {
                    Console.WriteLine("{0} {1} {2} {3} {4}", result["BookId"], result["Title"], result["Author"], result["PublishDate"], result["ISBN"]);
                }

            }
        }

        private static void ListAllBooks(MySqlConnection dbConnection)
        {
            Console.WriteLine("List All Books");
            Console.WriteLine();
            MySqlCommand getAllBooks = new MySqlCommand("SELECT * FROM Books", dbConnection);

            MySqlDataReader result = getAllBooks.ExecuteReader();

            using (result)
            {
                while (result.Read())
                {
                    Console.WriteLine("{0} {1} {2} {3} {4}", result["BookId"], result["Title"], result["Author"], result["PublishDate"], result["ISBN"]);
                }
            }
        }

        private static void AddProduct(MySqlConnection dbConnection, string title, string author, DateTime publishDate, string ISBN)
        {
            MySqlCommand insertIntoProducts = new MySqlCommand(@"INSERT INTO Books(Title, Author, PublishDate, ISBN)
                                                                VALUES
                                                                   (
                                                                       @Title,
                                                                       @Author,
                                                                       @PublishDate,
                                                                       @ISBN
                                                                   )", dbConnection);
            insertIntoProducts.Parameters.AddWithValue("@Title", title);
            insertIntoProducts.Parameters.AddWithValue("@Author", author);
            insertIntoProducts.Parameters.AddWithValue("@PublishDate", publishDate.ToString("yyyy-MM-dd"));
            insertIntoProducts.Parameters.AddWithValue("@ISBN", ISBN);
        }
    }
}
