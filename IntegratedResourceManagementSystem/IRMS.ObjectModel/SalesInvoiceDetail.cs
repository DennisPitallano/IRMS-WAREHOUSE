using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using BLToolkit.DataAccess;
using BLToolkit.Mapping;

namespace IRMS.ObjectModel
{
    [TableName("SIDtl")]
    public class SalesInvoiceDetail
    {
        [MapField("ID"), PrimaryKey, NonUpdatable]
        public long RecordNo { get; set; }
        [MapField("SIID")]
        public int SalesInvoiceID { get; set; }
        [MapField("SINo")]
        public string SalesInvoiceNumber { get; set; }
        [MapField("SKU")]
        public string SKUCode { get; set; }
        [MapField("StyleNo")]
        public string StyleNumber { get; set; }
        [MapField("BrandName")]
        public string BrandName { get; set; }
        [MapField("Quantity")]
        public int Quantity { get; set; }
        [MapField("Unit")]
        public string Unit { get; set; }
        [MapField("Bundle")]
        public string Bundle { get; set; }
        [MapField("Articles")]
        public string Articles { get; set; }
        [MapField("UnitPrice")]
        public double UnitPrice { get; set; }
        [MapField("Amount")]
        public double Amount { get; set; }
    }
}
