using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data;
using System.Data.SqlClient;
using System.Collections.Specialized;

namespace CF.Models
{
    public class clsFilter
    {
        public clsFilter()
        {

        }
        public string stateId { get; set; }
        public string districtId { get; set; }
        public string blockId { get; set; }
        public string year { get; set; }
        public string CSOId { get; set; }
        public string VillageId { get; set; }
        public string WFGID { get; set; }
        public string ChartName { get; set; }


        public DataTable bindState()
        {

            NameValueCollection nvc = new NameValueCollection();
            nvc.Clear();
            nvc.Add("@Operation", "state");
            DataTable dt = new clsConnection().fnExecuteProcedureSelectWithCondtion("[CF].[dbo].[spFilter]", nvc);
            nvc.Clear();
            return dt;
        }
        public DataTable bindDistrict(string stateId)
        {

            NameValueCollection nvc = new NameValueCollection();
            nvc.Clear();
            nvc.Add("@Operation", "District");
            nvc.Add("@StateId", stateId);
            DataTable dt = new clsConnection().fnExecuteProcedureSelectWithCondtion("[CF].[dbo].[spFilter]", nvc);
            nvc.Clear();
            return dt;
        }
        public DataTable bindBlock(string districtId)
        {

            NameValueCollection nvc = new NameValueCollection();
            nvc.Clear();
            nvc.Add("@Operation", "block");
            nvc.Add("@District", districtId);
            DataTable dt = new clsConnection().fnExecuteProcedureSelectWithCondtion("[CF].[dbo].[spFilter]", nvc);
            nvc.Clear();
            return dt;
        }
        public DataTable bindCSO(string blockId)
        {

            NameValueCollection nvc = new NameValueCollection();
            nvc.Clear();
            nvc.Add("@Operation", "CSO");
            nvc.Add("@BlockID", blockId);
            DataTable dt = new clsConnection().fnExecuteProcedureSelectWithCondtion("[CF].[dbo].[spFilter]", nvc);
            nvc.Clear();
            return dt;
        }

        public DataTable bindchartYearWise(string chartName, string whereCondition)
        {
            NameValueCollection nvc = new NameValueCollection();
            nvc.Clear();
            nvc.Add("@Operation", chartName);
            nvc.Add("@whereConn", whereCondition);
            DataTable dt = new clsConnection().fnExecuteProcedureSelectWithCondtion("[CF].[dbo].[spFilter]", nvc);
            nvc.Clear();
            return dt;
        }

    }
}