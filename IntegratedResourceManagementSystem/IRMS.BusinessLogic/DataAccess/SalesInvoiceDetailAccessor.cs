using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using BLToolkit.Data;
using BLToolkit.DataAccess;
using IRMS.ObjectModel;

namespace IRMS.BusinessLogic.DataAccess
{
    public abstract class SalesInvoiceDetailAccessor : AccessorBase<SalesInvoiceDetailAccessor.DB, SalesInvoiceDetailAccessor>
    {
        public class DB : DbManager { public DB() : base("IRMSConnectionString") { } }
        [SqlQuery("SELECT * FROM SIDtl WHERE SIID=@SIID")]
        public abstract List<SalesInvoiceDetail> GetSalesInvoicesBySINumber(int SIID);
    }
}
