using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using BLToolkit.DataAccess;
using BLToolkit.Mapping;

namespace IRMS.ObjectModel
{
    [TableName("FORWARDER_CUSTOMERS")]
    public class ForwarderCustomer
    {
        [MapField("RECORD_NO"),PrimaryKey,NonUpdatable]
        public long RecordNumber {get;set;}
        [MapField("FORWARDER_NO")]
        public long ForwarderNumber {get;set;}
        [MapField("CUSTOMER_NO")]
        public long CustomerNumber { get; set; }
        [MapField("IS_DEFAULT")]
        public bool IsDefault { get; set; }
    }
}
