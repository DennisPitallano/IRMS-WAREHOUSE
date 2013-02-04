using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using BLToolkit.Data;
using System.Web.UI.WebControls;
using IRMS.Components;
using BLToolkit.DataAccess;
using IRMS.ObjectModel;

namespace IRMS.BusinessLogic.DataAccess
{
    public abstract class DeliveryReceiptAccessor : AccessorBase<DeliveryReceiptAccessor.DB, DeliveryReceiptAccessor>
    {
        public class DB : DbManager
        {
            public DB() : base("IRMSConnectionString")
            {
            }
        }
        [SqlQuery("UPDATE DR SET ynCancelled=1 WHERE ID=@RecordNo")]
        public abstract void UpdateDeliveryReceiptCancelledStatus(long RecordNo);

        [SqlQuery(@"select ID,ynCancelled,ynPosted from DR ")]
        public abstract List<DeliveryReceipt> DeliveryReceipts();
    }
}
