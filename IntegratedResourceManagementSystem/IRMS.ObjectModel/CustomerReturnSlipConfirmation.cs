using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using BLToolkit.DataAccess;
using BLToolkit.Mapping;

namespace IRMS.ObjectModel
{
    [TableName("CRS_CONFIRMATIONS")]
    public class CustomerReturnSlipConfirmation
    {
        [MapField("RECORD_NUMBER"),PrimaryKey, NonUpdatable]
        public virtual long RecordNumber { get; set; }
        [MapField("CRS_NUMBER")]
        public virtual string CRSNumber { get; set; }
        [MapField("WAY_BILL_NUMBER")]
        public virtual string WayBillNumber { get; set; }
        [MapField("FORWARDER")]
        public virtual string Forwarder { get; set; }
        [MapField("DESTINATION")]
        public virtual string Destination { get; set; }
        [MapField("DATE_TRANSFER")]
        public virtual DateTime DateTransfer { get; set; }
    }
}
