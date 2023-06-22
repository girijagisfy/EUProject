using CF.Models;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Web.Http;
using System.Web.Http.Cors;

namespace CF.Controllers
{
    [EnableCors(origins: "*", headers: "*", methods: "*", exposedHeaders: "X-Custom-Header")]
    public class FilterController : ApiController
    {
        clsJson objjson = new clsJson();
        [Route("api/Filter/yearWiseData")]
        [HttpPost]
        public string yearWiseData(clsFilter objfilter)
        {
            string returnMsg = string.Empty;
            try
            {
                string VillageCondetion = string.Empty;
                string stateCondition = string.Empty;
                string districtCondion = string.Empty;
                string blockCondition = string.Empty;
                string CSOCondetion = string.Empty;
                string WFGCondetion = string.Empty;

                string year = "";
                if (objfilter.year != null && objfilter.year != "" && objfilter.year != "All")
                {
                    year = " and a.Year =" + objfilter.year;
                }
                if (objfilter.stateId != "All")
                {
                    stateCondition = " and c.StateId = " + objfilter.stateId;
                }
                if (objfilter.districtId != "All")
                {
                    districtCondion = " and c.DistrictID = " + objfilter.districtId;
                }
                if (objfilter.blockId != "All")
                {
                    blockCondition = " and c.BlockID = " + objfilter.blockId;
                }

                if (objfilter.CSOId != "All")
                {
                    CSOCondetion = " and c.CSOID = " + objfilter.CSOId;
                }
                if (objfilter.VillageId != "All")
                {
                    VillageCondetion = " and Vid = " + objfilter.VillageId;
                }
                if (objfilter.WFGID != "All")
                {
                    WFGCondetion = " and WfgNo = " + objfilter.WFGID;
                }

                string allContion = stateCondition + districtCondion + blockCondition + VillageCondetion + CSOCondetion + WFGCondetion + year;
                string MajorSourceofincomeofthefamily = "";

                string chartName = objfilter.ChartName;

                DataTable dt = objfilter.bindchartYearWise(chartName, allContion);
                if (dt != null)
                {
                    returnMsg = objjson.DataTableToJSONWithJavaScriptSerializer(dt);
                }
                else
                {
                    returnMsg = "Errer";
                }
            }
            catch (Exception ex)
            {
                returnMsg = "Errer";
            }
            return returnMsg;
        }
        [Route("api/Filter/TotalIrrigatedLand")]
        [HttpPost]
        public string TotalIrrigatedLand(clsFilter objfilter)
        {
            List<object> TotalLandinHectors = new List<object>();
            string returnMsg = string.Empty;
            try
            {
                string VillageCondetion = string.Empty;
                string stateCondition = string.Empty;
                string districtCondion = string.Empty;
                string blockCondition = string.Empty;
                string CSOCondetion = string.Empty;
                string WFGCondetion = string.Empty;

                string year = "";
                if (objfilter.year != "All")
                {
                    year = " and a.Year =" + objfilter.year;
                }

                if (objfilter.stateId != "All")
                {
                    stateCondition = " and c.StateId = " + objfilter.stateId;
                }
                if (objfilter.districtId != "All")
                {
                    districtCondion = " and c.DistrictID = " + objfilter.districtId;
                }
                if (objfilter.blockId != "All")
                {
                    blockCondition = " and c.BlockID = " + objfilter.blockId;
                }
                if (objfilter.CSOId != "All")
                {
                    CSOCondetion = " and c.CSOID = " + objfilter.CSOId;
                }
                if (objfilter.VillageId != "All")
                {
                    VillageCondetion = " and Vid = " + objfilter.VillageId;
                }
                if (objfilter.WFGID != "All")
                {
                    WFGCondetion = " and WfgNo = " + objfilter.WFGID;
                }

                string allContion = stateCondition + districtCondion + blockCondition + VillageCondetion + CSOCondetion + WFGCondetion + year;
                string MajorSourceofincomeofthefamily = "";

                string chartName = objfilter.ChartName;
                DataTable dtEQ = new DataTable();
                Random r = new Random();
                DataTable land = new DataTable();
                land.Rows.Clear();
                land.Columns.Clear();
                land.Columns.Add("heading");
                land.Columns.Add("val");
                land.Columns.Add("formate");
                DataTable dt = objfilter.bindchartYearWise(chartName, allContion);
                if (dt != null)
                {
                    if (dt.Rows.Count > 0)
                    {
                        dtEQ = dt;
                        if (dtEQ.Rows.Count > 0)
                        {

                            //land.Rows.Add("upto 1 Hec", Convert.ToInt32(dtEQ.Rows[0]["LandUpto1Hec"].ToString()), String.Format("#{0:X6}", r.Next(0x1000000)));
                            //land.Rows.Add("1 to 2 Hec", Convert.ToInt32(dtEQ.Rows[0]["Land1to2Hec"].ToString()), String.Format("#{0:X6}", r.Next(0x1000000)));
                            //land.Rows.Add("2 to 4 Hec", Convert.ToInt32(dtEQ.Rows[0]["Land2to4Hec"].ToString()), String.Format("#{0:X6}", r.Next(0x1000000)));
                            //land.Rows.Add("More then 4 Hec", Convert.ToInt32(dtEQ.Rows[0]["LandMorethan4Hec"].ToString()), String.Format("#{0:X6}", r.Next(0x1000000)));
                            //land.Rows.Add("land less", Convert.ToInt32(dtEQ.Rows[0]["Landless"].ToString()), String.Format("#{0:X6}", r.Next(0x1000000)));
                            //returnMsg = objjson.DataTableToJSONWithJavaScriptSerializer(land);
                            TotalLandinHectors.Add(new object[]
                            {
                            "upto 1 Hec",  Convert.ToInt32(dtEQ.Rows[0]["LandUpto1Hec"].ToString()), String.Format("#{0:X6}", r.Next(0x1000000)),
                            });
                            TotalLandinHectors.Add(new object[]
                            {
                            "1 to 2 Hec",Convert.ToInt32(dtEQ.Rows[0]["Land1to2Hec"].ToString()), String.Format("#{0:X6}", r.Next(0x1000000)),

                            });
                            TotalLandinHectors.Add(new object[]
                            {
                            "2 to 4 Hec",Convert.ToInt32(dtEQ.Rows[0]["Land2to4Hec"].ToString()),  String.Format("#{0:X6}", r.Next(0x1000000)),
                            });
                            TotalLandinHectors.Add(new object[]
                            {
                                 "More then 4 Hec",  Convert.ToInt32(dtEQ.Rows[0]["LandMorethan4Hec"].ToString()), String.Format("#{0:X6}", r.Next(0x1000000)),
                            });
                            TotalLandinHectors.Add(new object[]
                            {
                              "land less", Convert.ToInt32(dtEQ.Rows[0]["Landless"].ToString()), String.Format("#{0:X6}", r.Next(0x1000000)),
                            });

                            returnMsg = JsonConvert.SerializeObject(TotalLandinHectors);
                        }
                    }
                    else
                    {
                        TotalLandinHectors.Add(new object[]
                            {
                            "upto 1 Hec",  0, String.Format("#{0:X6}", r.Next(0x1000000)),
                            });
                        TotalLandinHectors.Add(new object[]
                        {
                            "1 to 2 Hec",0, String.Format("#{0:X6}", r.Next(0x1000000)),

                        });
                        TotalLandinHectors.Add(new object[]
                        {
                            "2 to 4 Hec",0,  String.Format("#{0:X6}", r.Next(0x1000000)),
                        });
                        TotalLandinHectors.Add(new object[]
                        {
                                 "More then 4 Hec",  0, String.Format("#{0:X6}", r.Next(0x1000000)),
                        });
                        TotalLandinHectors.Add(new object[]
                        {
                              "land less", 0, String.Format("#{0:X6}", r.Next(0x1000000)),
                        });
                        //land.Rows.Add("upto 1 Hec", 0, String.Format("#{0:X6}", r.Next(0x1000000)));
                        //land.Rows.Add("1 to 2 Hec", 0, String.Format("#{0:X6}", r.Next(0x1000000)));
                        //land.Rows.Add("2 to 4 Hec", 0, String.Format("#{0:X6}", r.Next(0x1000000)));
                        //land.Rows.Add("More then 4 Hec", 0, String.Format("#{0:X6}", r.Next(0x1000000)));
                        //land.Rows.Add("land less", 0, String.Format("#{0:X6}", r.Next(0x1000000)));

                        returnMsg = JsonConvert.SerializeObject(TotalLandinHectors);
                    }
                }
                else
                {
                    returnMsg = "Errer";

                }
            }
            catch (Exception ex)
            {
                returnMsg = "Errer";
            }
            return returnMsg;
        }

    }
}
