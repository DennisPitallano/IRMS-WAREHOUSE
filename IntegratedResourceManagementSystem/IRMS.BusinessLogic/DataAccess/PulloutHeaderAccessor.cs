using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using BLToolkit.Data;
using IRMS.ObjectModel;
using BLToolkit.DataAccess;
using System.Web.UI.WebControls;

namespace IRMS.BusinessLogic.DataAccess
{
    public abstract class PulloutHeaderAccessor : AccessorBase<PulloutHeaderAccessor.DB, PulloutHeaderAccessor>
    {
        public class DB : DbManager
        {
            public DB()
                : base("IRMSConnectionString")
            {
            }
        }

        [SqlQuery("SELECT * FROM pullout_hdr ORDER BY id desc")]
        public abstract List<PulloutHeader> GetAllPOHead();

        [SqlQuery("SELECT * FROM pullout_hdr WHERE customer_no = @CustNo")]
        public abstract List<PulloutHeader> GetPOHeadByCustomer(long CustNo);

        [SqlQuery("SELECT * FROM pullout_hdr WHERE pullout_date= @PulloutDate and customer_no = @CustNo")]
        public abstract List<PulloutHeader> GetPOHeadByPDateAndCustno(DateTime PulloutDate, long CustNo);

        [SqlQuery("SELECT * FROM pullout_hdr WHERE pullout_date= @PulloutDate and customer_no = @CustNo")]
        public abstract PulloutHeader GetPOHeadsByPDateAndCustno(DateTime PulloutDate, long CustNo);

        [SqlQuery("SELECT * FROM pullout_hdr WHERE pullout_date= @PulloutDate")]
        public abstract List<PulloutHeader> GetPOHeadByPDate(DateTime PulloutDate);

        [SqlQuery("UPDATE pullout_hdr SET is_active='CONFIRMED' WHERE id=@RecordNo")]
        public abstract void RequestConfiremed(long RecordNo);

        [SqlQuery("SELECT max(SERIES_per_BRAND)as SERIES FROM PULLOUT_HDR WHERE BRANDNAME = @BrandName")]
        public abstract List<PulloutHeader> GetLastSeriesPerBrand(string BrandName);
    }
}
