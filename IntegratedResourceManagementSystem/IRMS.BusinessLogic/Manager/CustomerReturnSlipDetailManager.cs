using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IRMS.ObjectModel;
using IRMS.BusinessLogic.DataAccess;
using BLToolkit.Data;

namespace IRMS.BusinessLogic.Manager
{
    public class CustomerReturnSlipDetailManager
    {
        #region Accessor
        CustomerReturnSlipDetailAccessor Accessor
        {
            [System.Diagnostics.DebuggerStepThrough]
            get { return CustomerReturnSlipDetailAccessor.CreateInstance(); }
        }
        #endregion

        public CustomerReturnSlipDetail GetCustomerReturnSlipDetailByKey(long id)
        {
            return Accessor.Query.SelectByKey<CustomerReturnSlipDetail>(id) ?? new CustomerReturnSlipDetail();
        }

        public List<CustomerReturnSlipDetail> CustomerReturnSlipDetails()
        {
            return Accessor.Query.SelectAll<CustomerReturnSlipDetail>();
        }
        public List<CustomerReturnSlipDetail> CustomerReturnSlipDetailsByCRSID(int CRSID)
        {
            List<CustomerReturnSlipDetail> list = new List<CustomerReturnSlipDetail>();
            try
            {
                list= Accessor.GetCustomerReturnSlipByCRSID(CRSID);
            }
            catch (Exception)
            {
                list = null;
              //  throw;
            }
            return list;
        }
        public void Save(CustomerReturnSlipDetail CustomerReturnSlipDetail)
        {
            using (DbManager db = new DbManager())
            {
                if (CustomerReturnSlipDetail.RecordNo != 0)
                {
                    Accessor.Query.Update(db, CustomerReturnSlipDetail);
                }
                else
                {
                    Accessor.Query.Insert(db, CustomerReturnSlipDetail);
                }
            }
        }

        public void Delete(CustomerReturnSlipDetail CustomerReturnSlipDetail)
        {
            using (DbManager db = new DbManager())
            {
                Accessor.Query.Delete(db, CustomerReturnSlipDetail);
            }
        }

        public List<CustomerReturnSlipDetail> SearchCustomerReturnSlipDetail(string[] search_parameter)
        {
            string[] columns = new string[2];
            columns[0] = "DRNo";
            columns[1] = "FABRIC_DESCRIPTION";
            return Accessor.Query.SelectByKeyWords<CustomerReturnSlipDetail>(search_parameter, columns);
        }
    }
}
