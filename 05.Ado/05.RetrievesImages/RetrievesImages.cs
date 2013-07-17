using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Drawing;
using System.Drawing.Imaging;
using System.IO;

namespace RetrievesImages
{
    //05.Write a program that retrieves the images for all categories in the Northwind database and stores them as JPG files 
    //in the file system.
    class RetrievesImages
    {
        static void Main()
        {
            SqlConnection dbCon = new SqlConnection("Server=.\\;Database=Northwind;Integrated Security=true");
            dbCon.Open();
            using (dbCon)
            {
                SqlCommand command = new SqlCommand("SELECT CategoryName, Picture FROM Categories", dbCon);
                var reader = command.ExecuteReader();

                while (reader.Read())
                {
                    byte[] rawData = (byte[])reader["Picture"];
                    string fileName = reader["CategoryName"].ToString().Replace('/', '_') + ".jpg";
                    int len = rawData.Length;
                    int header = 78;
                    byte[] imgData = new byte[len - header];
                    Array.Copy(rawData, 78, imgData, 0, len - header);

                    MemoryStream memoryStream = new MemoryStream(imgData);
                    Image image = Image.FromStream(memoryStream);
                    image.Save(new FileStream(fileName, FileMode.Create), ImageFormat.Jpeg);
                }
            }
            Console.WriteLine("Success!");
            Console.WriteLine();
        }
    }
}
