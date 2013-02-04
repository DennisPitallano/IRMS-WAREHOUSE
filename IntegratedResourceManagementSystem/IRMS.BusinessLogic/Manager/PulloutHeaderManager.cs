using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web.UI.WebControls;
using IRMS.BusinessLogic.DataAccess;
using IRMS.ObjectModel;
using BLToolkit.Data;

namespace IRMS.BusinessLogic.Manager
{
    public class PulloutHeaderManager   
    {
        #region Accessor
        /// <summary>
        /// Initialize Pull-Out Header Accessor
        /// </summary>
        PulloutHeaderAccessor Accessor
        {
            [System.Diagnostics.DebuggerStepThrough]
            get
            {
                return PulloutHeaderAccessor.CreateInstance();
            }
        }
        #endregion

        public PulloutHeader GetPOHeadByID(long RecordNo)
        {
            return Accessor.Query.SelectByKey<PulloutHeader>(RecordNo) ?? new PulloutHeader();
        }

        public List<PulloutHeader> GetRequestALL()
        {
            return Accessor.GetAllPOHead();
        }

        //public PulloutHeader UpdateRequest(long Custno, string CompName, DateTime PO_Date, string Brand, DateTime TransDate, string DeptCode, long RecordNo)
        //{
        //    return Accessor.UpdateTransaction(Custno, CompName, PO_Date, Brand, TransDate, DeptCode, RecordNo);
        //}

        public List<PulloutHeader> GetLastSeriesperBrand(string BrandName)
        {
            return Accessor.GetLastSeriesPerBrand(BrandName);
        }

        public List<PulloutHeader> GetPOHeadByCustNo(long CustNo)
        {
            return Accessor.GetPOHeadByCustomer(CustNo);
        }

        public List<PulloutHeader> GetPOHeadByPODate(DateTime PullOutDate)
        {
            return Accessor.GetPOHeadByPDate(PullOutDate);
        }

        public List<PulloutHeader> GetPOHeadByPODateAndCustno(DateTime PullOutDate, Int32 CustNo)
        {
            return Accessor.GetPOHeadByPDateAndCustno(PullOutDate,CustNo);
        }

        public PulloutHeader GetPOHeadsByPODateAndCustno(DateTime PullOutDate, Int32 CustNo)
        {
            return Accessor.GetPOHeadsByPDateAndCustno(PullOutDate, CustNo);
        }

        public List<PulloutHeader> SearchOutlet(string[] search_parameter)
        {
            string[] columns = new string[1];
            columns[0] = "COMPANY_NAME";
            return Accessor.Query.SelectByKeyWords<PulloutHeader>(search_parameter, columns);
        }

        public void SaveRequest(PulloutHeader PH)
        {
            using (DbManager db = new DbManager())
            {
                if (PH.RecordNo != 0)
                {
                    Accessor.Query.Update(db, PH);
                }
                else
                {
                    Accessor.Query.Insert(db, PH);
                }
            }
        }

        public void DeleteRequest(PulloutHeader PH)
        {
            using (DbManager db = new DbManager())
            {
                Accessor.Query.Delete(db, PH);
            }
        }

        //public void UpdateTransaction(List<PulloutHeader> PO_List)
        //{
        //    foreach (PulloutHeader POHead in PO_List)
        //    {
        //        Accessor.UpdateTransaction(POHead.Custno, POHead.CompName, POHead.Pullout_Date, POHead.BrandName, POHead.TransDate, POHead.DeptCode, POHead.RecordNo);
        //    }
        //}

        #region "search_outlets"
            public SqlDataSource SearchOutletDataSource(SqlDataSource sql_data_source, string search_parameter)
            {
                if (search_parameter != string.Empty)
                {
                    sql_data_source.SelectCommand = "SELECT [CustNo], [CompName], [CustCode], [CustType], [brand], [BrandNameNo], [ArrangeType], [Addr1], [BRAND_CODE] FROM [CustInfo] a inner join [BRANDS] b on a.[brand]=b.[BRAND_DESCRIPTION] where CompName Like '%" + search_parameter + "%'";
                }
                else
                {
                    sql_data_source.SelectCommand = "SELECT [CustNo], [CompName], [CustCode], [CustType], [brand], [BrandNameNo], [ArrangeType], [Addr1] FROM [CustInfo]";
                }
                sql_data_source.DataBind();
                return sql_data_source;
            }
        #endregion

        #region "search_Styles"
            public SqlDataSource SearchStyleDataSource(SqlDataSource sql_data_source, string search_parameter)
            {
                if (search_parameter != string.Empty)
                {
                    sql_data_source.SelectCommand = "SELECT [StyleNo], [BrandName], [StyleDesc], [AP_Type], [BRAND_CODE] FROM [Style] a inner join [BRANDS] b on a.BrandName=b.BRAND_DESCRIPTION where StyleNo Like '%" + search_parameter + "%'";
                }
                else
                {
                    sql_data_source.SelectCommand = "SELECT [StyleNo], [BrandName], [StyleDesc], [AP_Type], [BRAND_CODE] FROM [Style] a inner join [BRANDS] b on a.BrandName=b.BRAND_DESCRIPTION";
                }
                sql_data_source.DataBind();
                return sql_data_source;
            }
        #endregion
    }
}
