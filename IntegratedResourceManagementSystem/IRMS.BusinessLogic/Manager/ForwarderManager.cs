using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IRMS.BusinessLogic.DataAccess;
using IRMS.ObjectModel;
using BLToolkit.Data;
using IRMS.Entities;
using System.Web.UI.WebControls;

namespace IRMS.BusinessLogic.Manager
{
    public class ForwarderManager
    {
        #region Accessor
        ForwarderAccessor Accessor
        {
            [System.Diagnostics.DebuggerStepThrough]
            get { return ForwarderAccessor.CreateInstance(); }
        }
        #endregion

        public List<Customer> Customers()
        {
            using (DbManager db = new DbManager())
            {
                return Accessor.Query.SelectAll<Customer>(db);
            }
        }

        public void Delete(Forwarder FORWARDER)
        {
            using (DbManager db = new DbManager())
            {
                Accessor.Query.Delete(db, FORWARDER);
            }
        }

        public List<Forwarder> Forwarders()
        {
            return Accessor.Query.SelectAll<Forwarder>();
        }

        public Customer GetCustomerByCustomerId(long ID_NUMBER)
        {
            return Accessor.Query.SelectByKey<Customer>(ID_NUMBER) ?? new Customer();
        }

        public Forwarder GetForwarderByKey(long id)
        {
            return Accessor.Query.SelectByKey<Forwarder>(id) ?? new Forwarder();
        }

        public void Save(Forwarder Forwader)
        {
            using (DbManager db = new DbManager())
            {
                if (Forwader.RecordNumber > 0)
                {
                    Accessor.Query.Update(db,Forwader);
                }
                else
                {
                    Accessor.Query.Insert(db,Forwader);
                }
            }
        }
        #region "Forwarder Customers"

        public void DeleteCustomerForwarder(ForwarderCustomer ForwarderCustomer)
        {
            using (DbManager db = new DbManager())
            {
                Accessor.Query.Delete(db, ForwarderCustomer);
            }
        }

        public ForwarderCustomer GetForwarderCustomerByID(long ID)
        {
            return Accessor.Query.SelectByKey<ForwarderCustomer>(ID) ?? new ForwarderCustomer();
        }

        public long LastForwarder()
        {
            var result = (from forwarder in Forwarders()
                          select (forwarder.RecordNumber)).Max();
            return result;
        }

        public List<ForwarderCustomer> ForwarderCustomers()
        {
            return Accessor.Query.SelectAll<ForwarderCustomer>() ?? new List<ForwarderCustomer>();
        }

        public ForwarderCustomer GetDefaultForwarder(long customerNumber)
        {
            var defaultForwarder = (from forwarder in ForwarderCustomers()
                                   where forwarder.IsDefault == true && forwarder.CustomerNumber == customerNumber
                                   select forwarder).FirstOrDefault();
            return defaultForwarder;
        }

        public void SaveForwarderCustomer(ForwarderCustomer ForwarderCustomer)
        {
            using (DbManager db = new DbManager())
            {
                if (ForwarderCustomer.RecordNumber > 0)
                {
                    Accessor.Query.Update(db, ForwarderCustomer);
                }
                else
                {
                    Accessor.Query.Insert(db, ForwarderCustomer);
                }
            }
        }

        public void SaveForwarderCustomers(List<ForwarderCustomer> ForwarderCustomers)
        {
           foreach( ForwarderCustomer forwarder in ForwarderCustomers)
           {
               SaveForwarderCustomer(forwarder);
           }
        }
        #endregion

        #region "customers query"
        public void SearchCustomer(SqlDataSource CustomerDataSource,string search_parameter)
        {
            string CommandText = string.Empty;

            CommandText = "SELECT [CustNo], [CompName], [brand], [Addr1] FROM [CustInfo] WHERE ([ynActive] =1) ";
            CommandText += " and CompName LIKE '%" + search_parameter + "%' OR brand LIKE '%"+ search_parameter +"%'";

            CustomerDataSource.SelectCommand = CommandText;
            CustomerDataSource.DataBind();
        }
        #endregion

        #region "forwarder"
        public void SearchForwarder(SqlDataSource ForwarderDataSource, string search_parameter)
        {
            string CommandText = string.Empty;
            CommandText = "SELECT [RECORD_NUMBER], [FORWARDER_NAME], [FORWARDER_ADDRESS], [FORWARDER_CONTACT], [DATE_RECORDED] FROM [FORWARDERS] ";

            CommandText += " WHERE FORWARDER_NAME LIKE '%"+ search_parameter +"%' ";
            
            ForwarderDataSource.SelectCommand = CommandText;

            ForwarderDataSource.DataBind();
        }
        #endregion

        #region forwarder customers
        public void SearchForwarderCustomer(SqlDataSource ForwarderCustomerDataSource, string searchParameter,int forwarderNumber,string brandName="")
        {
            StringBuilder strCmd = new StringBuilder();
            strCmd.Append("SELECT FORWARDER_CUSTOMERS.RECORD_NO, CustInfo.CompName, CustInfo.brand,CustNo FROM CustInfo INNER JOIN FORWARDER_CUSTOMERS ON CustInfo.CustNo = FORWARDER_CUSTOMERS.CUSTOMER_NO WHERE ( FORWARDER_CUSTOMERS.FORWARDER_NO = "+forwarderNumber+") ");

            if (!string.IsNullOrEmpty(searchParameter))
            {
                if (!string.Equals(brandName,"ALL"))
                {
                    strCmd.Append(" AND CustInfo.brand ='"+brandName+"' ");
                }
                strCmd.Append(" AND CustInfo.CompName LIKE '%"+searchParameter+"%' ");
            }
            else
            {
                if (!string.Equals(brandName, "ALL"))
                {
                    strCmd.Append(" AND CustInfo.brand ='" + brandName + "' ");
                }
            }

            ForwarderCustomerDataSource.SelectCommand = strCmd.ToString();
            ForwarderCustomerDataSource.DataBind();
        }

        #endregion
    }
}
