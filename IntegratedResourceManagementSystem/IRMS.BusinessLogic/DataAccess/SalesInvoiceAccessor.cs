using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using BLToolkit.Data;
using IRMS.ObjectModel;
using BLToolkit.DataAccess;

namespace IRMS.BusinessLogic.DataAccess
{
    public abstract class SalesInvoiceAccessor : AccessorBase<SalesInvoiceAccessor.DB, SalesInvoiceAccessor>
    {
        public class DB : DbManager
        {
            public DB() : base("IRMSConnectionString")
            {
            }
        }

        [SqlQuery(@"SELECT * FROM SI ")]
        public abstract List<SalesInvoice> SalesInvoiceList();

        [SqlQuery((@"Update SI set ynCancelled=1 where ID=@RecordNo"))]
        public abstract void UpdateSalesInvoiceCancellStatus(long RecordNo);

        [SqlQuery("select ID,ynCancelled,ynPosted from si")]
        public abstract List<SalesInvoice> SalesInvoiceSummary();

    }
}
