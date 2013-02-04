using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using BLToolkit.Mapping;
using BLToolkit.DataAccess;

namespace IRMS.ObjectModel
{
    [TableName("PULLOUT_HDR")]
    public class PulloutHeader
    {

        [MapField("ID"), PrimaryKey, NonUpdatable]
        public long RecordNo { get; set; }

        [MapField("CUSTOMER_NO")]
        public long Custno { get; set; }

        [MapField("COMPANY_NAME")]
        public string CompName { get; set; }

        [MapField("PULLOUT_DATE")]
        public DateTime Pullout_Date { get; set; }

        [MapField("BRANDNAME")]
        public string BrandName { get; set; }

        [MapField("TRANSACTION_DATE")]
        public DateTime TransDate { get; set; }

        [MapField("DEPT_CODE")]
        public string DeptCode { get; set; }

        [MapField("BRAND_CODE")]
        public string BrandCode { get; set; }

        [MapField("SERIES_PER_BRAND")]
        public string SeriesPerBrand { get; set; }

        [MapField("IS_ACTIVE")]
        public string Status { get; set; }
    }
}
    