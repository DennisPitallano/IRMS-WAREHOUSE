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
    public class SalesInvoiceManager
    {
        #region Accessor
        SalesInvoiceAccessor Accessor
        {
            [System.Diagnostics.DebuggerStepThrough]
            get
            {
                return SalesInvoiceAccessor.CreateInstance();
            }
        }

        #endregion

        public SalesInvoice GetSalesInvoiceByKey(long id)
        {
            return Accessor.Query.SelectByKey<SalesInvoice>(id) ?? new SalesInvoice();
        }

        public void FilterSalesInvoiceList(SqlDataSource datasource, string filter_field_type)
        {
            switch (filter_field_type)
            {
                case "POSTED":
                    datasource.SelectCommand = SearchCommand(filter_field_type);
                    datasource.DataBind();
                    break;
                case "UNPOSTED":
                    datasource.SelectCommand = SearchCommand(filter_field_type);
                    datasource.DataBind();
                    break;
                case "CANCELLED":
                    datasource.SelectCommand = SearchCommand(filter_field_type);
                    datasource.DataBind();
                    break;
            }
        }

        private static string SearchCommand(string filter_type)
        {
            string CommandText = string.Empty;
            switch (filter_type)
            {
                case "POSTED":
                    CommandText = "SELECT [ID], [SIID], [SINo], [SIDate], [CustNo], [SoldTo], [CustAddr], [TotalAmt], [TotalQty], [PLNo] FROM SI WHERE (ynPosted=1 and ynCancelled=0 and ynLiquidation=0) ORDER BY SIDate DESC";
                    break;
                case "UNPOSTED":
                    CommandText = "SELECT [ID], [SIID], [SINo], [SIDate], [CustNo], [SoldTo], [CustAddr], [TotalAmt], [TotalQty], [PLNo] FROM SI WHERE (ynPosted=0 and ynCancelled =0 and ynLiquidation=0) ORDER BY SIDate DESC";
                    break;
                case "CANCELLED":
                    CommandText = "SELECT [ID], [SIID], [SINo], [SIDate], [CustNo], [SoldTo], [CustAddr], [TotalAmt], [TotalQty], [PLNo] FROM SI WHERE (ynCancelled=1 and ynLiquidation=0)ORDER BY SIDate DESC";
                    break;
            }
            return CommandText;
        }

        //public void SearchSalesInvoiceList(SqlDataSource datasource, string search_parameter, string Status)
        //{
        //    string CommandText = string.Empty;
        //    CommandText = "SELECT [ID], [SIID], [SINo], [SIDate], [CustNo], [SoldTo], [CustAddr], [TotalAmt], [TotalQty], [PLNo] FROM SI"; 
        //    CommandText += " WHERE SINo LIKE '%" + search_parameter + "%' ";
        //    CommandText +=" OR PLNo LIKE '%" + search_parameter + "%' ";
        //    if(Status !="CANCELLED")
        //    {
        //      CommandText + =" and ";
        //    }else 
        //    {
            
        //    }
          
        //    datasource.SelectCommand = CommandText;
        //    datasource.DataBind();
        //}

        public void SearchSalesInvoiceList(SqlDataSource datasource, string search_parameter, string Status,string SearchOption)
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
                //    SearchSalesInvoiceList(datasource, search_parameter);
                //    break;
            }
        }

        public List<SalesInvoice> SalesInvoices()
        {
            return Accessor.SalesInvoiceList();
        }

        public List<SalesInvoice> SalesInvoiceSummary()
        {
            return Accessor.SalesInvoiceSummary();
        }

        public void Save(SalesInvoice SalesInvoice)
        {
            using (DbManager db = new DbManager())
            {
                if (SalesInvoice.RecordNo != 0)
                {
                    Accessor.Query.Update(db, SalesInvoice);
                }
                else
                {
                    Accessor.Query.Insert(db, SalesInvoice);
                }
            }
        }

        public void Delete(SalesInvoice SalesInvoice)
        {
            using (DbManager db = new DbManager())
            {
                Accessor.Query.Delete(db, SalesInvoice);
            }
        }

        public void UpdateSalesInvoiceCancelledStatus(List<SalesInvoice> sales_invoice)
        {
            foreach (SalesInvoice si in sales_invoice)
            {
                this.Accessor.UpdateSalesInvoiceCancellStatus(si.RecordNo);
            }
        }

        public List<SalesInvoice> SearchSalesInvoices(string[] search_parameter)
        {
            string[] columns = new string[2];
            columns[0] = "DRNo";
            columns[1] = "FABRIC_DESCRIPTION";
            return Accessor.Query.SelectByKeyWords<SalesInvoice>(search_parameter, columns);
        }

        #region "Command Text"
        private static string SearchCommand(string search_parameter, string Status, string StatusType,string SearchOption)
        {
            string CommandText = string.Empty;
            CommandText = "SELECT [ID], [SIID], [SINo], [SIDate], [CustNo], [SoldTo], [CustAddr], [TotalAmt], [TotalQty], [PLNo] FROM SI ";
            CommandText += " WHERE ";

            if (StatusType != "CANCELLED")
            {
                switch(SearchOption)
                {
                    case "All":
                        CommandText += " PLNo LIKE '%" + search_parameter + "%' ";
                        CommandText += "OR SINo LIKE '%" + search_parameter + "%' ";
                        break;
                    case "PLNumber":
                        CommandText += " PLNo LIKE '%" + search_parameter + "%' ";
                        break;
                    case "SINumber":
                        CommandText += " SINo LIKE '%" + search_parameter + "%' ";
                        break;
                }             
                CommandText += " AND ynPosted=" + Status + " AND ynCancelled=0 AND ynLiquidation=0 ORDER BY SIDate DESC ";
            }
            else
            {
                switch (SearchOption)
                {
                    case "All":
                        CommandText += " PLNo LIKE '%" + search_parameter + "%' ";
                        CommandText += "OR SINo LIKE '%" + search_parameter + "%' ";
                        break;
                    case "PLNumber":
                        CommandText += " PLNo LIKE '%" + search_parameter + "%' ";
                        break;
                    case "SINumber":
                        CommandText += " SINo LIKE '%" + search_parameter + "%' ";
                        break;
                }   
                CommandText += " AND ynCancelled=1 AND ynLiquidation=0 ORDER BY SIDate DESC ";
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
                CommandText = "SELECT [ID], [SIID], [SINo], [SIDate], [CustNo], [SoldTo], [CustAddr], [TotalAmt], [TotalQty], [PLNo] FROM SI"; 
                CommandText += " WHERE ";
                CommandText += " SIDate BETWEEN '" + date_from + "' AND '" + date_to + "'";
                if (search_parameter != string.Empty)
                {
                    CommandText += " AND SINo LIKE '%" + search_parameter + "%' ";
                    CommandText += " OR PLNo LIKE '%" + search_parameter + "%' ";
                }
                if (!CompanyName.Equals(string.Empty))
                {
                    CommandText += " AND SoldTo LIKE '%" + CompanyName + "%'";
                }
                CommandText += " AND ynPosted=" + Status + " AND ynCancelled=0 AND ynLiquidation =0 ORDER BY SIDate DESC ";
            }
            else
            {
                CommandText = "SELECT [ID], [SIID], [SINo], [SIDate], [CustNo], [SoldTo], [CustAddr], [TotalAmt], [TotalQty], [PLNo] FROM SI ";
                CommandText +=" WHERE ";
                CommandText += "  SIDate BETWEEN '" + date_from + "' AND '" + date_to + "'";
                if (search_parameter != string.Empty)
                {
                    CommandText += " AND SINo LIKE '%" + search_parameter + "%' ";
                    CommandText += " OR ID LIKE '%" + search_parameter + "%' ";
                }
                if (!CompanyName.Equals(string.Empty))
                {
                    CommandText += " AND SoldTo LIKE '%" + CompanyName + "%'";
                }
                CommandText += " AND ynCancelled=1 AND ynLiquidation=0 ORDER BY SIDate DESC ";
            }
            return CommandText;
        }
        #endregion
    }
}
