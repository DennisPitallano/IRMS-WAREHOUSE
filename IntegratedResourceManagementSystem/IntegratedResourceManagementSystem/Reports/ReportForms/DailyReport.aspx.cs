using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using CrystalDecisions.Shared;
using CrystalDecisions.CrystalReports.Engine;
using System.Data;
using System.Data.SqlClient;
using IntegratedResourceManagementSystem.Reports.ReportDocuments;
using System.Configuration;
using IRMS.Components;

namespace IntegratedResourceManagementSystem.Reports.ReportForms
{
    public partial class DailyReport : System.Web.UI.Page
    {
        protected void Page_Init(object sender, EventArgs e)
        {
            if (Request.QueryString["dept"] == "Warehouse")
            {
                if (Request.QueryString["rptname"] == "Merge")
                {
                    MERGE_PLDR();
                }
                else if (Request.QueryString["rptname"] == "StockCard")
                {
                    STYLE_STOCKCARD();
                }
                else if (Request.QueryString["rptname"] == "OverAllComParativeYearly" || Request.QueryString["rptname"] == "OverAllComParativeYearlyperBrand")
                {
                    OVERALL_COMPARATIVE();
                }
                else
                {
                    WH_DailyCustomer();
                }
            }
            else
            {
                Redirector.Redirect("~/WareHouse/DailyReportPanel.aspx");
            } 
        }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        #region WareHouse Reports

        private void MERGE_PLDR()
        {
            ReportDocument rpt = new rptMergePLandDR();
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["IRMSConnectionString"].ConnectionString);
            //rptMergePLandDR PLDR = new rptMergePLandDR();
            conn.Open();

            DataTable resultSet = new DataTable("result");
            SqlCommand cmd = new SqlCommand();

            cmd.Connection = conn;
            cmd.CommandText = "select * from rptmerge_planddr";
            using (SqlDataAdapter adp = new SqlDataAdapter())
            {
                adp.SelectCommand = cmd;
                adp.Fill(resultSet);
            }
            DataBaseLogIn(rpt);
            crvDailyReport.ReportSource = rpt;
        }

        private void WH_DailyCustomer()
        {
            ReportDocument rpt;
            //string rptDocCachedKey = null;
            if (Request.QueryString["rptname"] == "DailySI")
            {
                //rptDocCachedKey = "DailySI";
                //if (rptDocCachedKey != null)
                //{
                //    rpt = (DailySI)Cache[rptDocCachedKey];
                //}
                //else
                //{
                    rpt = new DailySI();
                //    Cache.Insert(rptDocCachedKey, rpt);
                //}
            }
            else if (Request.QueryString["rptname"] == "DailySIItin")
            {
                //rptDocCachedKey = "DailySIItin";
                //if (rptDocCachedKey != null)
                //{
                //    rpt = (DailySIItin)Cache[rptDocCachedKey];
                //}
                //else
                //{
                    rpt = new DailySIItin();
                //    Cache.Insert(rptDocCachedKey, rpt);
                //}
            }
            else if (Request.QueryString["rptname"] == "DailySISumm")
            {
                //rptDocCachedKey = "DailySISumm";
                //if (rptDocCachedKey != null)
                //{
                //    rpt = (DailySISumm)Cache[rptDocCachedKey];
                //}
                //else
                //{
                    rpt = new DailySISumm();
                //    Cache.Insert(rptDocCachedKey, rpt);
                //}
            }
            else if (Request.QueryString["rptname"] == "DailyDR")
            {
                //rptDocCachedKey = "DailyDR";
                //if (rptDocCachedKey != null)
                //{
                //    rpt = (DailyDR)Cache[rptDocCachedKey];
                //}
                //else
                //{
                    rpt = new DailyDR();
                //    Cache.Insert(rptDocCachedKey, rpt);
                //}
            }
            else if (Request.QueryString["rptname"] == "DailyDRItin")
            {
                //rptDocCachedKey = "DailyDRItin";
                //if (rptDocCachedKey != null)
                //{
                //    rpt = (DailyDRItin)Cache[rptDocCachedKey];
                //}
                //else
                //{
                    rpt = new DailyDRItin();
                //    Cache.Insert(rptDocCachedKey, rpt);
                //}
            }
            else if (Request.QueryString["rptname"] == "DailyDRSumm")
            {
                //rptDocCachedKey = "DailyDRSumm";
                //if (rptDocCachedKey != null)
                //{
                //    rpt = (DailyDRSumm)Cache[rptDocCachedKey];
                //}
                //else 
                //{
                    rpt = new DailyDRSumm();
                //   Cache.Insert(rptDocCachedKey, rpt);
                //} 
            }
            else if (Request.QueryString["rptname"] == "DailyCRS")
            {
                //rptDocCachedKey = "DailyCRS";
                //if (rptDocCachedKey != null)
                //{
                //    rpt = (DailyCRS)Cache[rptDocCachedKey];
                //}
                //else 
                //{
                    rpt = new DailyCRS();
                //    Cache.Insert(rptDocCachedKey, rpt);
                //}
            }
            else if (Request.QueryString["rptname"] == "DailyCRSItin")
            {
                //rptDocCachedKey = "DailyCRSItin";
                //if (rptDocCachedKey != null)
                //{
                //    rpt = (DailyCRSItin)Cache[rptDocCachedKey];
                //}
                //else
                //{
                    rpt = new DailyCRSItin();
                //    Cache.Insert(rptDocCachedKey, rpt);
                //}
            }
            else
            {
                //rptDocCachedKey = "DailyCRSSumm";
                //if (rptDocCachedKey != null)
                //{
                //    rpt = (DailyCRSSumm)Cache[rptDocCachedKey];
                //}
                //else
                //{
                    rpt = new DailyCRSSumm();
                //    Cache.Insert(rptDocCachedKey, rpt);
                //}
            }

            DataBaseLogIn(rpt);
            ParameterField prmDateFrom = new ParameterField();
            ParameterFields prmList = new ParameterFields();

            prmDateFrom.ParameterFieldName = "datefrom";


            ParameterDiscreteValue prmDateFromValue = new ParameterDiscreteValue();

            prmDateFromValue.Value = Request.QueryString["datefrom"];

            prmDateFrom.CurrentValues.Add(prmDateFromValue);

            prmList.Add(prmDateFrom);

            crvDailyReport.ParameterFieldInfo = prmList;
            crvDailyReport.ReportSource = rpt;

        }

        private void STYLE_STOCKCARD()
        {
            ReportDocument rpt; 
            SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["IRMSConnectionString"].ConnectionString);
            
            
            //string rptDocCachedKey = "StockCard";
            //if (rptDocCachedKey != null)
            //{
            //    rpt = (RptStyle_StockCard)Cache[rptDocCachedKey];
            //}
            //else
            //{
                rpt = new RptStyle_StockCard();
            //    Cache.Insert(rptDocCachedKey, rpt);
            //}

            long Balqty = 0;
            long Balqty1 = 0;
            long INqty = 0;
            long OUTqty = 0;
            bool Firstrec = true;

            conn.Open();

            SqlCommand cmd = new SqlCommand();

            cmd.Connection = conn;
            cmd.CommandText = "genrptstyle_stockcard '" + System.DateTime.Now.Date + "','" + Request.QueryString["StyleNo"] + "','" + Session["USER_ID"] + "'";
            cmd.ExecuteNonQuery();

            DataTable ResultSet = new DataTable();

            cmd.CommandText = "select * from rptstyle_stockcard where username = '" + Session["USER_ID"] + "'";
            using (SqlDataAdapter adapter = new SqlDataAdapter())
            {
                adapter.SelectCommand = cmd;
                adapter.Fill(ResultSet);
            }

            foreach (DataRow row in ResultSet.Rows)
            {
                if (Firstrec == true)
                {
                    Balqty = (long)row[6] + (long)row[7] + (long)row[8];

                    cmd.CommandText = "update rptstyle_stockcard set balance = '" + Balqty + "' where id = '" + (int)row[0] + "' and username = '" + Session["USER_ID"] + "'";
                    cmd.ExecuteNonQuery();

                    Firstrec = false;
                }
                else
                {
                    INqty = (long)row[6];
                    OUTqty = (long)row[7];

                    Balqty1 = Balqty + INqty - OUTqty;

                    Balqty = Balqty1;

                    cmd.CommandText = "update rptstyle_stockcard set balance = '" + Balqty + "' where id = '" + (int)row[0] + "' and username = '" + Session["USER_ID"] + "'";
                    cmd.ExecuteNonQuery();

                }
            }

            DataBaseLogIn(rpt);

            ParameterField prmAsOfDate = new ParameterField();
            ParameterField prmUserName = new ParameterField();
            ParameterFields prmList = new ParameterFields();

            prmAsOfDate.ParameterFieldName = "asofdate";
            prmUserName.ParameterFieldName = "username";

            ParameterDiscreteValue prmAsOfDateValue = new ParameterDiscreteValue();
            ParameterDiscreteValue prmUserNameValue = new ParameterDiscreteValue();

            prmAsOfDateValue.Value = System.DateTime.Now.Date;
            prmUserNameValue.Value = Session["USER_ID"];

            prmAsOfDate.CurrentValues.Add(prmAsOfDateValue);
            prmUserName.CurrentValues.Add(prmUserNameValue);

            prmList.Add(prmAsOfDate);
            prmList.Add(prmUserName);

            crvDailyReport.ParameterFieldInfo = prmList;
            crvDailyReport.ReportSource = rpt;
        }

        private void OVERALL_COMPARATIVE()
        {
            try
            {
                string BrandName = Request.QueryString["brandname"];
                int Previous_Year = Convert.ToDateTime(Request.QueryString["ToDate"]).Year - 1;
                int Current_Year = Convert.ToDateTime(Request.QueryString["ToDate"]).Year;
                DateTime From = Convert.ToDateTime(Request.QueryString["FromDate"]);
                DateTime To = Convert.ToDateTime(Request.QueryString["ToDate"]);

                ReportDocument rpt;
                //string rptDocCachedKey = null;
                if (Request.QueryString["rptname"] == "OverAllComParativeYearly")
                {
                //    rptDocCachedKey = "OverAllComParativeYearly";
                //    if (rptDocCachedKey != null)
                //    {
                //        rpt = (RptOverallComparative)Cache[rptDocCachedKey];
                //    }
                //    else
                //    {
                        rpt = new RptOverallComparative();
                    //    Cache.Insert(rptDocCachedKey, rpt);
                    //}
                }
                else
                {
                    //rptDocCachedKey = "OverAllComParativeYearlyperBrand";
                    //if (rptDocCachedKey != null)
                    //{
                    //    rpt = (RptOverallComparativePerBrand)Cache[rptDocCachedKey];
                    //}
                    //else
                    //{
                        rpt = new RptOverallComparativePerBrand();
                    //    Cache.Insert(rptDocCachedKey, rpt);
                    //}
                }

                SqlConnection conn = new SqlConnection(ConfigurationManager.ConnectionStrings["IRMSConnectionString"].ConnectionString);
                conn.Open();
                SqlCommand cmd = new SqlCommand();

                if (Request.QueryString["brandname"] != "")
                {
                    cmd.Connection = conn;
                    cmd.CommandTimeout = 600;
                    cmd.CommandText = "GenRptOverAllComparativePerBrand '" + Session["USER_ID"] + "', " + Previous_Year + ", " + Current_Year + ", '" + From + "','" + To + "', '" + BrandName + "'";
                    cmd.ExecuteNonQuery();
                }
                else
                {
                    cmd.Connection = conn;
                    cmd.CommandTimeout = 3000;
                    cmd.CommandText = "GenRptOverAllComparative '" + Session["USER_ID"] + "', " + Previous_Year + ", " + Current_Year + ", '" + From + "','" + To + "'";
                    cmd.ExecuteNonQuery();
                }
                DataBaseLogIn(rpt);

                ParameterField prmUserName = new ParameterField();
                ParameterField prmDateFrom = new ParameterField();
                ParameterField prmDateTo = new ParameterField();
                ParameterFields prmList = new ParameterFields();

                prmUserName.ParameterFieldName = "username";
                prmDateFrom.ParameterFieldName = "datefrom";
                prmDateTo.ParameterFieldName = "dateto";

                ParameterDiscreteValue prmUserNameValue = new ParameterDiscreteValue();
                ParameterDiscreteValue prmDateFromValue = new ParameterDiscreteValue();
                ParameterDiscreteValue prmDateToValue = new ParameterDiscreteValue();

                prmUserNameValue.Value = Session["USER_ID"];
                prmDateFromValue.Value = From;
                prmDateToValue.Value = To;

                prmUserName.CurrentValues.Add(prmUserNameValue);
                prmDateFrom.CurrentValues.Add(prmDateFromValue);
                prmDateTo.CurrentValues.Add(prmDateToValue);

                prmList.Add(prmUserName);
                prmList.Add(prmDateFrom);
                prmList.Add(prmDateTo);

                crvDailyReport.ParameterFieldInfo = prmList;
                crvDailyReport.ReportSource = rpt;
            }
            catch (Exception except)
            {
                throw new Exception(except.Message);
            }


        }

        #endregion

        private static SqlConnectionStringBuilder Connection()
        {
            SqlConnectionStringBuilder con = new SqlConnectionStringBuilder();
            con.ConnectionString = ConfigurationManager.ConnectionStrings["IRMSConnectionString"].ConnectionString;
            return con;
        }

        private static void DataBaseLogIn(ReportDocument rpt)
        {
            ConnectionInfo con_info = new ConnectionInfo();
            TableLogOnInfos crtableLogoninfos = new TableLogOnInfos();
            TableLogOnInfo crtableLogoninfo = new TableLogOnInfo();
            Tables crTables;

            con_info.ServerName = Connection().DataSource;
            con_info.DatabaseName = Connection().InitialCatalog;
            con_info.UserID = Connection().UserID;
            con_info.Password = Connection().Password;

            crTables = rpt.Database.Tables;

            foreach (CrystalDecisions.CrystalReports.Engine.Table crTable in crTables)
            {
                crtableLogoninfo = crTable.LogOnInfo;
                crtableLogoninfo.ConnectionInfo = con_info;
                crTable.ApplyLogOnInfo(crtableLogoninfo);
            }
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Redirector.Redirect("~/WareHouse/DailyReportPanel.aspx");
        }
    }
}