using System;
using System.Collections.Generic;
using System.Collections.Specialized;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;

namespace CF.Models
{
    public class clsConnection
    {

        public SqlConnection objCon;
        public SqlCommand objCom;
        public SqlDataReader objDr;
        public SqlDataAdapter objAdr;
        public DataSet objDs;
        public DataTable objDt;
        //function for estsblishing connection from code to database
        public clsConnection()
        {
            string connectionstring = ConfigurationManager.ConnectionStrings["ConnStringStr"].ConnectionString;
            objCon = new SqlConnection(connectionstring);

        }
        //function for open connection
        public void fnOpenConnection()
        {

            if (objCon.State == ConnectionState.Closed)
            {
                objCon.Open();
            }

        }
        //function for close connection
        public void fnCloseConnection()
        {
            if (objCon.State == ConnectionState.Open)
            {
                objCon.Close();
            }
        }

        public SqlDataReader fnExecuteSelectStmtDr(string sqlstmt)
        {
            try
            {
                fnOpenConnection();
                objCom = new SqlCommand(sqlstmt, objCon);
                objDr = objCom.ExecuteReader();

                return objDr;
            }
            catch (Exception e) { return null; }
            finally { fnCloseConnection(); }
        }
        public DataTable fnExecuteSelectStmtDt(string sqlstmt)
        {
            try
            {
                fnOpenConnection();
                objAdr = new SqlDataAdapter(sqlstmt, objCon);
                objDt = new DataTable();
                objAdr.Fill(objDt);

                return objDt;
            }
            catch (Exception e) { return null; }
            finally { fnCloseConnection(); }
        }
        public DataSet fnExecuteSelectStmtDs(string sqlstmt)
        {
            try
            {
                fnOpenConnection();
                objAdr = new SqlDataAdapter(sqlstmt, objCon);
                objDs = new DataSet();
                objAdr.Fill(objDs);

                return objDs;
            }
            catch (Exception e) { return null; }
            finally { fnCloseConnection(); }

        }
        public DataTable fnExecuteProcedureSelect(string procedurename)
        {
            try
            {
                fnOpenConnection();
                objCom = new SqlCommand(procedurename, objCon);
                objCom.CommandType = CommandType.StoredProcedure;
                objAdr = new SqlDataAdapter(objCom);
                objDt = new DataTable();
                objAdr.Fill(objDt);

                return objDt;
            }
            catch (Exception e) { return null; }
            finally { fnCloseConnection(); }

        }
        public DataTable fnExecuteProcedureSelectWithCondtion(string procedurename, NameValueCollection ParamNamevalue)
        {
            try
            {
                fnOpenConnection();
                objCom = new SqlCommand(procedurename, objCon);

                objCom.CommandTimeout = 0;
                objCom.CommandType = CommandType.StoredProcedure;
                foreach (string key in ParamNamevalue.AllKeys)
                {
                    string val = ParamNamevalue.Get(key);
                    SqlParameter param = new SqlParameter(key, val);
                    objCom.Parameters.Add(param);
                }
                objAdr = new SqlDataAdapter(objCom);
                objDt = new DataTable();
                objAdr.Fill(objDt);

                return objDt;
            }
            catch (Exception e) { return null; }
            finally { fnCloseConnection(); }

        }
        public DataTable fnExecuteProcedureSelectWithCondtionwithoutopencloseconnection(string procedurename, NameValueCollection ParamNamevalue)
        {
            try
            {

                objCom = new SqlCommand(procedurename, objCon);

                objCom.CommandTimeout = 0;
                objCom.CommandType = CommandType.StoredProcedure;
                foreach (string key in ParamNamevalue.AllKeys)
                {
                    string val = ParamNamevalue.Get(key);
                    SqlParameter param = new SqlParameter(key, val);
                    objCom.Parameters.Add(param);
                }
                objAdr = new SqlDataAdapter(objCom);
                objDt = new DataTable();
                objAdr.Fill(objDt);

                return objDt;
            }
            catch (Exception e) { return null; }
            finally { }

        }

        public DataTable fnExecuteProcedureSelectSpecificDt(string procedurename, NameValueCollection ParamNamevalue)
        {
            try
            {
                fnOpenConnection();
                objCom = new SqlCommand(procedurename, objCon);
                objCom.CommandType = CommandType.StoredProcedure;
                foreach (string key in ParamNamevalue.AllKeys)
                {
                    string val = ParamNamevalue.Get(key);
                    SqlParameter param = new SqlParameter(key, val);
                    objCom.Parameters.Add(param);
                }
                objAdr = new SqlDataAdapter(objCom);


                objDt = new DataTable();
                objAdr.Fill(objDt);

                return objDt;
            }
            catch (Exception e) { return null; }
            finally { fnCloseConnection(); }

        }

        public string fnExecuteProcedureReturnSingle(string procedurename, NameValueCollection ParamNamevalue)
        {
            try
            {
                fnOpenConnection();
                objCom = new SqlCommand(procedurename, objCon);
                objCom.CommandType = CommandType.StoredProcedure;
                foreach (string key in ParamNamevalue.AllKeys)
                {
                    string val = ParamNamevalue.Get(key);
                    SqlParameter param = new SqlParameter(key, val);
                    objCom.Parameters.Add(param);
                }
                string rec = objCom.ExecuteScalar().ToString();

                return rec;
            }
            catch (Exception e) { return null; }
            finally { fnCloseConnection(); }

        }
    }
}