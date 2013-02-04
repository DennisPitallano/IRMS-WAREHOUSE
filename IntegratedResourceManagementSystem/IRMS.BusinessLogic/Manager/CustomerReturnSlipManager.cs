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
	public class CustomerReturnSlipManager
	{
		#region Accessor
		CustomerReturnSlipAccessor Accessor
		{
			[System.Diagnostics.DebuggerStepThrough]
			get { return CustomerReturnSlipAccessor.CreateInstance(); }
		}
		#endregion

		public CustomerReturnSlip GetCustomerReturnSlipByKey(long id)
		{
			return Accessor.Query.SelectByKey<CustomerReturnSlip>(id) ?? new CustomerReturnSlip();
		}

		public List<CustomerReturnSlip> CustomerReturnSlips()
		{
			return Accessor.Query.SelectAll<CustomerReturnSlip>();
		}

		public void Save(CustomerReturnSlip CustomerReturnSlip)
		{
			using (DbManager db = new DbManager())
			{
				if (CustomerReturnSlip.RecordNo != 0)
				{
					Accessor.Query.Update(db, CustomerReturnSlip);
				}
				else
				{
					Accessor.Query.Insert(db, CustomerReturnSlip);
				}
			}
		}

		public void Delete(CustomerReturnSlip CustomerReturnSlip)
		{
			using (DbManager db = new DbManager())
			{
				Accessor.Query.Delete(db, CustomerReturnSlip);
			}
		}

		public void SearchCustomerReturnSlipList(SqlDataSource datasource,string search_parameter)
		{
			string CommandText = string.Empty;
			CommandText = "SELECT [ID], [CRSID], [CRSNo], [CRSDate], [Customer], [TotalAmt], [PUSNo], [PkgNo], [ItemStatus] FROM CRS WHERE CRSNo LIKE '%" + search_parameter + "%' ORDER BY CRSDate DESC ";// OR ID LIKE '%" + search_parameter + "%'";
			datasource.SelectCommand = CommandText;
			datasource.DataBind();
		}

		public void FilterCustomerReturnSlipList(SqlDataSource datasource, string filter_field_type)
		{
			string CommandText = string.Empty;
			switch (filter_field_type)
			{
				case "POSTED":
					CommandText = "SELECT [ID], [CRSID], [CRSNo], [CRSDate], [Customer], [TotalAmt], [PUSNo], [PkgNo], [ItemStatus] FROM CRS WHERE ynPosted=1 and ynCancelled=0 ORDER BY CRSDate DESC ";
					datasource.SelectCommand = CommandText;
					datasource.DataBind();
					break;
				case "UNPOSTED":
					CommandText = "SELECT [ID], [CRSID], [CRSNo], [CRSDate], [Customer], [TotalAmt], [PUSNo], [PkgNo], [ItemStatus] FROM CRS WHERE ynPosted=0 and ynCancelled=0 ORDER BY CRSDate DESC ";
					datasource.SelectCommand = CommandText;
					datasource.DataBind();
					break;
				case "CANCELLED":
					CommandText = "SELECT [ID], [CRSID], [CRSNo], [CRSDate], [Customer], [TotalAmt], [PUSNo], [PkgNo], [ItemStatus] FROM CRS WHERE ynCancelled=1 ORDER BY CRSDate DESC ";
					datasource.SelectCommand = CommandText;
					datasource.DataBind();
					break;
				//default:
				//    CommandText = "SELECT [ID], [CRSID], [CRSNo], [CRSDate], [Customer], [TotalAmt], [PUSNo], [PkgNo], [ItemStatus] FROM CRS ";
				//    datasource.SelectCommand = CommandText;
				//    datasource.DataBind();
				//    break;
			}
		}

		public void SearchCustomerReturnSlipList(SqlDataSource datasource, string search_parameter, string Status, string SearchOption)
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
			}
		}


		public void UpdateCustomerReturnSlipCancelledStatus(List<CustomerReturnSlip> customer_list)
		{
			foreach (CustomerReturnSlip srs in customer_list)
			{
				Accessor.UpdateCustomerReturnSlipCancelledStatus(srs.RecordNo);
			}
		}

		public List<CustomerReturnSlip> SearchCustomerReturnSlips(string[] search_parameter)
		{
			string[] columns = new string[2];
			columns[0] = "CRSNo";
			columns[1] = "FABRIC_DESCRIPTION";
			return Accessor.Query.SelectByKeyWords<CustomerReturnSlip>(search_parameter, columns);
		}

		public List<CustomerReturnSlip> CustomerReturnSlipSummary()
		{
			return Accessor.CustomerReturnSlipSummary();
		}

		#region "Command Text"
		private static string SearchCommand(string search_parameter, string Status, string StatusType,string SearchOption)
		{
			string CommandText = string.Empty;
				CommandText = "SELECT [ID], [CRSID], [CRSNo], [CRSDate], [Customer], [TotalAmt], [PUSNo], [PkgNo], [ItemStatus] FROM CRS ";
				CommandText += " WHERE  ";
				switch (SearchOption)
				{
					case "All":
						CommandText += " CRSNo LIKE '%" + search_parameter + "%' OR PUSNo LIKE '%" + search_parameter + "%' ";
						break;
					case "PUSNumber":
						CommandText += " PUSNo LIKE '%" + search_parameter + "%' ";
						break;
					case "CRSNumber":
						CommandText += " CRSNo LIKE '%" + search_parameter + "%' ";
						break;
				}

				if (StatusType != "CANCELLED")
				{
					CommandText += " AND ynPosted=" + Status + " ";
					CommandText += " AND ynCancelled=0 ORDER BY CRSDate DESC ";
				}
				else
				{
					CommandText += " AND ynCancelled=" + Status + " ORDER BY CRSDate DESC ";
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
					//    CommandText = "SELECT [ID], [CRSID], [CRSNo], [CRSDate], [Customer], [TotalAmt], [PUSNo], [PkgNo], [ItemStatus] FROM CRS";
					//    CommandText += "WHERE CRSDate BETWEEN '" + date_from + "' AND '" + date_to + "'";
					//    if (search_parameter != string.Empty)
					//    {
					//        CommandText += " AND CRSNo LIKE '%" + search_parameter + "%' ";
					//        //CommandText += " OR ID LIKE '%" + search_parameter + "%' ";
					//    }
					//    if (!CompanyName.Equals(string.Empty))
					//    {
					//        CommandText += " AND Customer LIKE '%" + CompanyName + "%'";
					//    }
					//    datasource.SelectCommand = CommandText;
					//    datasource.DataBind();
						//break;
				}
			}
			else
			{
			}
		}

		private static string AdvanceSearchCommand(string search_parameter, string Status, string StatusType, DateTime date_from, DateTime date_to, string CompanyName)
		{
			string CommandText = string.Empty;
				CommandText = "SELECT [ID], [CRSID], [CRSNo], [CRSDate], [Customer], [TotalAmt], [PUSNo], [PkgNo], [ItemStatus] FROM CRS";
				if (StatusType != "CANCELLED")
				{
					CommandText += " WHERE ynPosted=" + Status + " ";
				}
				else
				{
					CommandText += " WHERE ynCancelled=" + Status + "";
				}
				CommandText += " AND CRSDate BETWEEN '" + date_from + "' AND '" + date_to + "'";
				if (search_parameter != string.Empty)
				{
					CommandText += " AND CRSNo LIKE '%" + search_parameter + "%' ";
					// CommandText += " OR ID LIKE '%" + search_parameter + "%' ";
				}
				if (!CompanyName.Equals(string.Empty))
				{
					CommandText += " AND Customer LIKE '%" + CompanyName + "%'";
				}
				CommandText += " ORDER BY CRSDate DESC";
			return CommandText;
		}
		#endregion


		#region for CRS Confirmation
		public void ConfirmCustomerReturnSlip(List<CustomerReturnSlipConfirmation> list_of_crs)
		{
			foreach (CustomerReturnSlipConfirmation crs in list_of_crs)
			{
				ConfirmCustomerReturnSlip(crs);
			}
		}

		public void ConfirmCustomerReturnSlip(CustomerReturnSlipConfirmation crs)
		{
			using (DbManager dbm = new DbManager())
			{
				Accessor.Query.Insert(dbm, crs);
			}
		}

		public int CRSConfirmationCount()
		{
			using (DbManager dbm = new DbManager())
			{
				return Accessor.Query.SelectAll<CustomerReturnSlipConfirmation>().Count;
			}
		}
		public void FilterCustomerReturnSlip(SqlDataSource DataSource, string PostedStatus)
		{
			string CommandText = string.Empty;

			CommandText = "SELECT [ID], [CRSID], [CRSNo], [CRSDate], [Customer], [PUSNo], [TotalAmt], [PkgNo], [ItemStatus] FROM [CRS] ";
			if (PostedStatus != "CONFIRMED")
			{
				switch (PostedStatus)
				{
					case "POSTED":
						CommandText += " WHERE ynPosted=1 AND ynCancelled=0 and CRS.CRSNo not in(SELECT CRS_CONFIRMATIONS.CRS_NUMBER from CRS_CONFIRMATIONS) order by CRSDate DESC";
						break;
					case "UNPOSTED":
						CommandText += " WHERE ynPosted=0 AND ynCancelled=0 and CRS.CRSNo not in(SELECT CRS_CONFIRMATIONS.CRS_NUMBER from CRS_CONFIRMATIONS) order by CRSDate DESC";
						break;
					case "CANCELLED":
						CommandText += " WHERE ynCancelled=1 ORDER BY CRSDate DESC ";
						break;
					default:
						break;
				}
			}
			else
			{
				CommandText = "SELECT [ID], [CRSID], [CRSNo], [CRSDate], [Customer], [PUSNo], [TotalAmt], [PkgNo], [ItemStatus] FROM [CRS] ";
				CommandText += " INNER JOIN  CRS_CONFIRMATIONS ON CRS.CRSNo = CRS_CONFIRMATIONS.CRS_NUMBER order by CRSDate DESC";
			}
			DataSource.SelectCommand = CommandText;
			DataSource.DataBind();
		}
		public void SearchCustomerReturnSlip(SqlDataSource DataSource, string PostedStatus, string search_parameter,string searchMode)
		{
			string CommandText = string.Empty;
			CommandText = "SELECT [ID], [CRSID], [CRSNo], [CRSDate], [Customer], [PUSNo], [TotalAmt], [PkgNo], [ItemStatus] FROM [CRS] ";
			if (PostedStatus != "CONFIRMED")
			{
				CommandText += " WHERE  ";
				if (search_parameter != string.Empty)
				{
					switch (PostedStatus)
					{  
						case "POSTED":
							CommandText += " ynPosted=1 AND ynCancelled=0";
							CommandText += " and CRS.CRSNo not in(SELECT CRS_CONFIRMATIONS.CRS_NUMBER from CRS_CONFIRMATIONS) AND "
								+searchMode+" LIKE '%" + search_parameter + "%' ";
							break;
						case "UNPOSTED":
							CommandText += " ynPosted=0 AND ynCancelled=0";
							CommandText += " and CRS.CRSNo not in(SELECT CRS_CONFIRMATIONS.CRS_NUMBER from CRS_CONFIRMATIONS) AND " 
								+ searchMode + " LIKE '%" + search_parameter + "%'  ";
							break;
						case "CANCELLED":
							CommandText += " ynCancelled=0 AND "
								+ searchMode + " LIKE '%" + search_parameter + "%'  ";
							break;
						default:
							break;
					}
				}
				else
				{
					switch (PostedStatus)
					{
						case "POSTED":
							CommandText += " ynPosted=1 AND ynCancelled=0";
							break;
						case "UNPOSTED":
							CommandText += " ynPosted=0 AND ynCancelled=0";
							break;
						case "CANCELLED":
							CommandText += " ynCancelled=0";
							break;
						default:
							break;
					}
				}
			}
			else
			{
				if (search_parameter != string.Empty)
				{
					CommandText += " WHERE CRSNo LIKE '%" + search_parameter + "%' OR  Customer LIKE '%" + search_parameter + "%' ";
					CommandText += " AND ynCancelled=1";
				}
				else
				{
					CommandText += " WHERE ynCancelled=1";
				}
			}
			DataSource.SelectCommand = CommandText;
			DataSource.DataBind();
		}
		public void SearchCustomerReturnSlipWithDateRange(SqlDataSource DataSource, string PostedStatus, string search_parameter, DateTime date_from, DateTime date_to)
		{
			string CommandText = string.Empty;
			CommandText = "SELECT [ID], [CRSID], [CRSNo], [CRSDate], [Customer], [PUSNo], [TotalAmt], [PkgNo], [ItemStatus] FROM [CRS] ";
			CommandText += " WHERE CRSDate BETWEEN '" + date_from + "' AND '" + date_to + "' ";
			if (PostedStatus != "CONFIRMED")
			{
				if (search_parameter != string.Empty)
				{
					CommandText += " AND CRSNo LIKE '%" + search_parameter + "%' OR  Customer LIKE '%" + search_parameter + "%' ";
					if (PostedStatus == "POSTED")
					{
						CommandText += " AND ynPosted=1 AND ynCancelled=0";
					}
					else
					{
						CommandText += " AND ynPosted=0 AND ynCancelled=0 ";
					}
				}
				else
				{
					if (PostedStatus == "POSTED")
					{
						CommandText += " AND ynPosted=1 AND ynCancelled=0 ";
					}
					else
					{
						CommandText += " AND ynPosted=0 AND ynCancelled=0 ";
					}
				}
			}
			else
			{
				if (search_parameter != string.Empty)
				{
					CommandText += " AND CRSNo LIKE '%" + search_parameter + "%' OR  Customer LIKE '%" + search_parameter + "%' ";
					CommandText += " AND ynCancelled=1";
				}
				else
				{
					CommandText += " AND ynCancelled=1";
				}
			}
			DataSource.SelectCommand = CommandText;
			DataSource.DataBind();
		}
		#endregion
	}
}
