﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
//Microsoft.SqlServer.Smo.dll
using Microsoft.SqlServer.Management.Smo;
//Microsoft.SqlServer.ConnectionInfo.dll
using Microsoft.SqlServer.Management.Common;

// Should run the following to add preview version 160.1911221.0 of SMO
// Install-Package Microsoft.SqlServer.SqlManagementObjects -Version 160.1911221.0-preview

namespace SProcsMaker
{
    class Program
    {
        static string str = ConfigurationManager.ConnectionStrings["SProcsMaker.Properties.Settings.Setting"].ConnectionString;
        
        static void Main(string[] args)
        {
            SqlConnection con = new SqlConnection(str);
            try
            {
                con.Open();
                Console.WriteLine("Connected!");

                string scriptDirectory = @"Sprocs\";
                DirectoryInfo di = new DirectoryInfo(scriptDirectory);
                FileInfo[] rgFiles = di.GetFiles("*.sql");
                foreach (FileInfo fi in rgFiles)
                {
                    FileInfo fileInfo = new FileInfo(fi.FullName);
                    string script = fileInfo.OpenText().ReadToEnd();
                    //SqlConnection connection = new SqlConnection(con);
                    Server server = new Server(new ServerConnection(con));
                    server.ConnectionContext.ExecuteNonQuery(script);
                    Console.WriteLine(fileInfo.Name + " created...");
                }
            }
            catch (Exception)
            {
                throw;
            }

            Console.ReadKey();

        }
    }
}
