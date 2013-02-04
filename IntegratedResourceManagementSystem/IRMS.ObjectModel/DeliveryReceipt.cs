using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using BLToolkit.Mapping;
using BLToolkit.DataAccess;

namespace IRMS.ObjectModel
{
    [TableName("DR")]
    public class DeliveryReceipt
    {
        [MapField("ID"),PrimaryKey ,NonUpdatable]
        public long RecordNo { get; set; }
        [MapField("drid")]
        public int DR_ID { get; set; }
        [MapField("DRNo")]
        public string DeliveryReceiptNumber { get; set; }
        [MapField("DRDate")]
        public DateTime DRDate { get; set; }
        [MapField("CustNo")]
        public int CustomerNumber { get; set; }
        [MapField("DeliveredTo")]
        public string DeliveredTo { get; set; }
        [MapField("CustAddr")]
        public string CustomerAddress { get; set; }
        [MapField("Salesman")]
        public string SalesMan { get; set; }
        [MapField("PONo")]
        public string PONumber { get; set; }
        [MapField("Terms")]
        public string Terms { get; set; }
        [MapField("TotalAmt")]
        public double TotalAmount { get; set; }
        [MapField("TotalQty")]
        public int TotalQuantity { get; set; }
        [MapField("Remark")]
        public string Remark { get; set; }
        [MapField("RecdBy")]
        public string RecordBy { get; set; }
        [MapField("RecdDate")]
        public string RecordDate { get; set; }
        [MapField("BrandName")]
        public string BrandName { get; set; }
        [MapField("PLNo")]
        public string PLNumber { get; set; }
        [MapField("BoxSackNo")]
        public string BoxSackNumber { get; set; }
        [MapField("Company")]
        public string Company { get; set; }
        [MapField("PreparedBy")]
        public string PreparedBy { get; set; }
        [MapField("Remarks")]
        public string Remarks { get; set; }
        [MapField("ItemStatus")]
        public string ItemStatus { get; set; }
        [MapField("WayBillNo")]
        public string WayBillNumber { get; set; }
        [MapField("Forwarder")]
        public string Forwarder { get; set; }
        [MapField("ConfirmedDate")]
        public DateTime ConfirmedDate { get; set; }
        [MapField("TransitStatus")]
        public string TransitStatus { get; set; }
        [MapField("ynLiquidation")]
        public bool YesNoLiquidation { get; set; }
        [MapField("ynPosted")]
        public bool YesNoPosted { get; set; }
        [MapField("ynCancelled")]
        public bool YesNoCancelled { get; set; }
    }
}

