using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using IRMS.BusinessLogic.DataAccess;
using IRMS.ObjectModel;
using BLToolkit.Data;

namespace IRMS.BusinessLogic.Manager
{
    public class SalesInvoiceDetailManager
    {
        #region Accessor
        SalesInvoiceDetailAccessor Accessor
        {
            [System.Diagnostics.DebuggerStepThrough]
            get { return SalesInvoiceDetailAccessor.CreateInstance(); }
        }
        #endregion

        public SalesInvoiceDetail GetSalesInvoiceDetailByKey(long id)
        {
            return Accessor.Query.SelectByKey<SalesInvoiceDetail>(id) ?? new SalesInvoiceDetail();
        }
        public List<SalesInvoiceDetail>GetSalesInvoiceDetailBySINumber(int SIID)
        {
            return Accessor.GetSalesInvoicesBySINumber(SIID);
        }
        public List<SalesInvoiceDetail> SalesInvoiceDetails()
        {
            return Accessor.Query.SelectAll<SalesInvoiceDetail>();
        }

        public void Save(SalesInvoiceDetail SalesInvoiceDetail)
        {
            using (DbManager db = new DbManager())
            {
                if (SalesInvoiceDetail.RecordNo != 0)
                {
                    Accessor.Query.Update(db, SalesInvoiceDetail);
                }
                else
                {
                    Accessor.Query.Insert(db, SalesInvoiceDetail);
                }
            }
        }

        public void Delete(SalesInvoiceDetail SalesInvoiceDetail)
        {
            using (DbManager db = new DbManager())
            {
                Accessor.Query.Delete(db, SalesInvoiceDetail);
            }
        }

        public List<SalesInvoiceDetail> SearchSalesInvoiceDetails(string[] search_parameter)
        {
            string[] columns = new string[2];
            columns[0] = "DRNo";
            columns[1] = "FABRIC_DESCRIPTION";
            return Accessor.Query.SelectByKeyWords<SalesInvoiceDetail>(search_parameter, columns);
        }
    }
}
