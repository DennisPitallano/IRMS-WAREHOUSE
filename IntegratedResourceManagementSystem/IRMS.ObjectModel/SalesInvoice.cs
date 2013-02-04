using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using BLToolkit.DataAccess;
using BLToolkit.Mapping;

namespace IRMS.ObjectModel
{
    [TableName("SI")]
    public class SalesInvoice
    {
        [MapField("ID"), PrimaryKey, NonUpdatable]
        public int RecordNo { get; set; }
        [MapField("SIID")]
        public int SalesInvoiceID { get; set; }
        [MapField("SINo")]
        public string SalesInvoiceNumber { get; set; }
        [MapField("SIDate")]
        public DateTime SalesInvoiceDate { get; set; }
        [MapField("CustNo")]
        public int CustomerNumber { get; set; }
        [MapField("SoldTo")]
        public string SoldTo { get; set; }
        [MapField("CustAddr")]
        public string CustomerAddress { get; set; }
        [MapField("TIN")]
        public string TIN { get; set; }
        [MapField("ShipToAddr")]
        public string ShipToAddress { get; set; }
        [MapField("PONo")]
        public string PONumber { get; set; }
        [MapField("Salesman")]
        public string Salesman { get; set; }
        [MapField("SONo")]
        public string SONumber { get; set; }
        [MapField("Terms")]
        public string Terms { get; set; }
        [MapField("TotalAmt")]
        public double TotalAmount { get; set; }
        [MapField("TotalQty")]
        public int TotalQuantity { get; set; }
        [MapField("InvoiceVal")]
        public double InvoiceValue { get; set; }
        [MapField("Via")]
        public string Via { get; set; }
        [MapField("BrandName")]
        public string BrandName { get; set; }
        [MapField("PLNo")]
        public string PLNumber { get; set; }
        [MapField("BoxSackNo")]
        public int BoxSackNumber { get; set; }
        [MapField("Company")]
        public string Company { get; set; }
        [MapField("PreparedBy")]
        public string PreparedBy { get; set; }
        [MapField("Remarks")]
        public string Remarks { get; set; }
        [MapField("ItemStatus")]
        public string ItemStatus { get; set; }
        [MapField("WayBillNo")]
        public string WayBillNnumber { get; set; }
        [MapField("Forwarder")]
        public string Forwarder { get; set; }
        [MapField("ConfirmedDate")]
        public DateTime ConfirmedDate { get; set; }
        [MapField("TransitStatus")]
        public string TransitStatus { get; set; }
        [MapField("DiscType")]
        public string DiscType { get; set; }
        [MapField("SubTotal")]
        public double SubTotal { get; set; }
        [MapField("DiscReg")]
        public double DiscReg { get; set; }
        [MapField("PercReg")]
        public int PercReg { get; set; }
        [MapField("DiscMD")]
        public double DiscMD { get; set; }
        [MapField("PercMD")]
        public int PercMD { get; set; }
        [MapField("InvoiceAmt")]
        public double InvoiceAmount { get; set; }
        [MapField("ynLiquidation")]
        public bool YesNoLiquidation { get; set; }
        [MapField("ynPosted")]
        public bool YesNoPosted { get; set; }
        [MapField("ynCancelled")]
        public bool YesNoCancelled { get; set; }
    }
}
