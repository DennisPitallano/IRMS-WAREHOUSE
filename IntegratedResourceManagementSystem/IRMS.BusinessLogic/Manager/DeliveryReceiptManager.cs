using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IRMS.BusinessLogic.DataAccess;
using IRMS.ObjectModel;
using BLToolkit.Data;
using System.Web.UI.WebControls;

namespace IRMS.BusinessLogic.Manager
{
    public class DeliveryReceiptManager
    {

        #region Accessor
        DeliveryReceiptAccessor Accessor
        {
            [System.Diagnostics.DebuggerStepThrough]
            get { return DeliveryReceiptAccessor.CreateInstance(); }
        }
        #endregion

        public DeliveryReceipt GetDeliveryReceiptByKey(long id)
        {
            return Accessor.Query.SelectByKey<DeliveryReceipt>(id) ?? new DeliveryReceipt();
           
        }
        public SqlDataSource Sample()
        {
            SqlDataSource ds = new SqlDataSource();
            DbManager dbm = Accessor.GetDbManager();
            ds = IRMS.Components.DataSource.IRMSDataSource(dbm.Connection.ConnectionString, dbm.DataProvider.ProviderName);
            ds.SelectCommand = "SELECT * FROM DR";
            ds.DataSourceMode = SqlDataSourceMode.DataSet;
            ds.EnableCaching = true;
            ds.EnableViewState = true;
            ds.DataBind();
            return ds;
        }

        public List<DeliveryReceipt> DeliveryReceipts()
        {
            return Accessor.DeliveryReceipts();
        }

        public void SearchDeliveryReceiptList(SqlDataSource datasource, string search_parameter)
        {
            string CommandText = string.Empty;
            CommandText = "SELECT [ID], [DRNo], [DRDate], [PLNo], [CustNo], [DeliveredTo], [CustAddr], [TotalQty], [TotalAmt], [ItemStatus] FROM [DR] ";
            CommandText += " WHERE DRNo LIKE '%" + search_parameter + "%' ORDER BY DRDate DESC ";//OR ID LIKE '%"+ search_parameter+"%'";
            datasource.SelectCommand = CommandText;
            datasource.DataBind();
        }
        public void FilterDeliveryReceiptList(SqlDataSource datasource, string filter_field_type)
        {
            string CommandText = string.Empty;
            switch (filter_field_type)
            {
                case "POSTED":
                    CommandText = "SELECT [ID], [DRNo], [DRDate], [PLNo], [CustNo], [DeliveredTo], [CustAddr], [TotalQty], [TotalAmt], [ItemStatus] FROM [DR] WHERE ynPosted=1 AND ynCancelled=0 ORDER BY DRDate DESC";
                    datasource.SelectCommand = CommandText;
                    datasource.DataBind();
                    break;
                case "UNPOSTED":
                    CommandText = "SELECT [ID], [DRNo], [DRDate], [PLNo], [CustNo], [DeliveredTo], [CustAddr], [TotalQty], [TotalAmt], [ItemStatus] FROM [DR] WHERE ynPosted=0 AND ynCancelled=0 ORDER BY DRDate DESC";
                    datasource.SelectCommand = CommandText;
                    datasource.DataBind();
                    break;
                case "CANCELLED":
                    CommandText = "SELECT [ID], [DRNo], [DRDate], [PLNo], [CustNo], [DeliveredTo], [CustAddr], [TotalQty], [TotalAmt], [ItemStatus] FROM [DR] WHERE ynCancelled=1 ORDER BY DRDate DESC ";
                    datasource.SelectCommand = CommandText;
                    datasource.DataBind();
                    break;
                //default:
                //    CommandText = "SELECT [ID], [DRNo], [DRDate], [PLNo], [CustNo], [DeliveredTo], [CustAddr], [TotalQty], [TotalAmt], [ItemStatus] FROM [DR] ";
                //    datasource.SelectCommand = CommandText;
                //    datasource.DataBind();
                //    break;
            }
        }

        public void SearchDeliveryReceiptList(SqlDataSource datasource, string search_parameter, string Status,string SearchOption)
        {
            switch (Status)
            {
                case "CANCELLED":
                    datasource.SelectCommand = SearchCommand(search_parameter, "1", Status, SearchOption);
                    datasource.DataBind();
                    break;
                case "POSTED":
                    datasource.SelectCommand = SearchCommand(search_parameter, "1", Status, SearchOption);
                    datasource.DataBind();
                    break;
                case "UNPOSTED":
                    datasource.SelectCommand = SearchCommand(search_parameter, "0", Status, SearchOption);
                    datasource.DataBind();
                    break;
                //default:
                //    SearchDeliveryReceiptList(datasource, search_parameter);
                //    break;
            }
        }


        public void Save(DeliveryReceipt DeliveryReceipt)
        {
            using (DbManager db = new DbManager())
            {
                if (DeliveryReceipt.RecordNo != 0)
                {
                    Accessor.Query.Update(db, DeliveryReceipt);
                }
                else
                {
                    Accessor.Query.Insert(db, DeliveryReceipt);
                }
            }
        }

        public void Delete(DeliveryReceipt DeliveryReceipt)
        {
            using (DbManager db = new DbManager())
            {
                Accessor.Query.Delete(db, DeliveryReceipt);
            }
        }

        public void UpdateDeliveryRecieptCancelledStatus(List<DeliveryReceipt> list)
        {
            foreach (DeliveryReceipt dr in list)
            {
                Accessor.UpdateDeliveryReceiptCancelledStatus(dr.RecordNo);
            }
        }

        public List<DeliveryReceipt> SearchDeliveryReceipts(string[] search_parameter)
        {
            string[] columns = new string[2];
            columns[0] = "DRNo";
            columns[1] = "FABRIC_DESCRIPTION";
            return Accessor.Query.SelectByKeyWords<DeliveryReceipt>(search_parameter, columns);
        }


        #region "Command Text"
        private static string SearchCommand(string search_parameter, string Status, string StatusType,string SearchOption)
        {
            string CommandText = string.Empty;
            CommandText = "SELECT [ID], [DRNo], [DRDate], [PLNo], [CustNo], [DeliveredTo], [CustAddr], [TotalQty], [TotalAmt], [ItemStatus] FROM [DR] ";
            CommandText += " WHERE ";
            if (StatusType != "CANCELLED")
            {
                switch (SearchOption)
                {
                    case "All":
                        CommandText += "  DRNo LIKE '%" + search_parameter + "%' OR  PLNo LIKE '%" + search_parameter + "%' ";
                        break;
                    case "PLNumber":
                        CommandText += " PLNo LIKE '%" + search_parameter + "%' ";
                        break;
                    case "DRNumber":
                        CommandText += " DRNo LIKE '%" + search_parameter + "%' ";
                        break;
                }       
                CommandText += " AND ynPosted=" + Status + " and ynCancelled=0 ORDER BY DRDate DESC ";
            }
            else
            {
                switch (SearchOption)
                {
                    case "All":
                        CommandText += "  DRNo LIKE '%" + search_parameter + "%' OR  PLNo LIKE '%" + search_parameter + "%' ";
                        break;
                    case "PLNumber":
                        CommandText += " PLNo LIKE '%" + search_parameter + "%' ";
                        break;
                    case "DRNumber":
                        CommandText += " DRNo LIKE '%" + search_parameter + "%' ";
                        break;
                }     
                CommandText += " AND ynCancelled=" + Status + " ORDER BY DRDate DESC ";
            }
            return CommandText;
        }

        public void AdvanceSearch(SqlDataSource datasource, string search_parameter, string filter_type, DateTime date_from, DateTime date_to, string CompanyName)
        {
            if (filter_type != string.Empty)
            {
                switch (filter_type)
                {
                    case "POSTED":
                        datasource.SelectCommand = AdvanceSearchCommand(search_parameter, "1", filter_type, date_from, date_to, CompanyName);
                        datasource.DataBind();
                        break;
                    case "UNPOSTED":
                        datasource.SelectCommand = AdvanceSearchCommand(search_parameter, "0", filter_type, date_from, date_to, CompanyName);
                        datasource.DataBind();
                        break;
                    case "CANCELLED":
                        datasource.SelectCommand = AdvanceSearchCommand(search_parameter, "1", filter_type, date_from, date_to, CompanyName);
                        datasource.DataBind();
                        break;
                    //default:
                    //    string CommandText;
                    //    CommandText = "SELECT [ID], [DRNo], [DRDate], [PLNo], [CustNo], [DeliveredTo], [CustAddr], [TotalQty], [TotalAmt], [ItemStatus] FROM [DR]";
                    //    CommandText += "WHERE DRDate BETWEEN '" + date_from + "' AND '" + date_to + "'";
                    //    if (search_parameter != string.Empty)
                    //    {
                    //        CommandText += " AND DRNo LIKE '%" + search_parameter + "%' ";
                    //        //CommandText += " OR ID LIKE '%" + search_parameter + "%' ";
                    //    }
                    //    if (!CompanyName.Equals(string.Empty))
                    //    {
                    //        CommandText += " AND DeliveredTo LIKE '%" + CompanyName + "%'";
                    //    }
                    //    datasource.SelectCommand = CommandText;
                    //    datasource.DataBind();
                    //    break;
                }
            }
            else
            {
            }
        }

        private static string AdvanceSearchCommand(string search_parameter, string Status, string StatusType, DateTime date_from, DateTime date_to, string CompanyName)
        {
            string CommandText = string.Empty;
            if (StatusType != "CANCELLED")
            {
                CommandText = "SELECT [ID], [DRNo], [DRDate], [PLNo], [CustNo], [DeliveredTo], [CustAddr], [TotalQty], [TotalAmt], [ItemStatus] FROM [DR]";
                CommandText += " WHERE ";
                CommandText += " DRDate BETWEEN '" + date_from + "' AND '" + date_to + "' ";
                if (!CompanyName.Equals(string.Empty))
                {
                    CommandText += " AND DeliveredTo LIKE '%" + CompanyName + "%'";
                }
                if (search_parameter != string.Empty)
                {
                    CommandText += " AND DRNo LIKE '%" + search_parameter + "%' ";
                    //CommandText += " OR ID LIKE '%" + search_parameter + "%' ";
                }

                CommandText += " AND ynPosted=" + Status + " AND ynCancelled=0 ORDER BY DRDate DESC ";
            }
            else
            {
                CommandText = "SELECT [ID], [DRNo], [DRDate], [PLNo], [CustNo], [DeliveredTo], [CustAddr], [TotalQty], [TotalAmt], [ItemStatus] FROM [DR] ";
                CommandText += " WHERE ";
                CommandText += " DRDate BETWEEN '" + date_from + "' AND '" + date_to + "'";
                if (!CompanyName.Equals(string.Empty))
                {
                    CommandText += " AND DeliveredTo LIKE '%" + CompanyName + "%'";
                }
                if (search_parameter != string.Empty)
                {
                    CommandText += " AND DRNo LIKE '%" + search_parameter + "%' ";
                    //CommandText += " OR ID LIKE '%" + search_parameter + "%' ";
                }
                CommandText += " AND ynCancelled=1 ORDER BY DRDate DESC ";
            }
            return CommandText;
        }
        #endregion
    }
}
