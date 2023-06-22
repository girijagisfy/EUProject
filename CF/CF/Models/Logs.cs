using System;
using System.Collections.Generic;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Web;

namespace CF.Models
{
    public class Logs
    {
        string savePath = ConfigurationManager.ConnectionStrings["CFWebLog"].ConnectionString;

        public void savelogs(string key, string msg)
        {
            StreamWriter logs;
            logs = new StreamWriter(savePath + "pageLogs.txt", append: true);
            logs.WriteLine("*************************** **********************************************");
            logs.Flush();
            logs.WriteLine("Starting Time =>" + DateTime.Now.Year + "" + DateTime.Now.Month + "" + DateTime.Now.Day + DateTime.Now.Hour + "_" + DateTime.Now.Minute + "_" + DateTime.Now.Second + "_" + DateTime.Now.Millisecond);
            logs.Flush();
            logs.WriteLine(key + " - " + msg);
            logs.Flush();
            logs.Close();
        }

    }
}