using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using BLToolkit.Data;
using BLToolkit.DataAccess;
using IRMS.ObjectModel;

namespace IRMS.BusinessLogic.DataAccess
{
    public abstract class CustomerReturnSlipDetailAccessor : AccessorBase<CustomerReturnSlipDetailAccessor.DB, CustomerReturnSlipDetailAccessor>
    {
        public class DB : DbManager { public DB() : base("IRMSConnectionString") { } }
        [SqlQuery("SELECT * FROM CRSDtl WHERE CRSID=@CRSID")]
        public abstract List<CustomerReturnSlipDetail> GetCustomerReturnSlipByCRSID(int CRSID);
    }
}
