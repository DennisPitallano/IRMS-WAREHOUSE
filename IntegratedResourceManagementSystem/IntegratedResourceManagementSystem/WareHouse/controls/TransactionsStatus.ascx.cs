using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using IRMS.BusinessLogic.Manager;
using IRMS.ObjectModel;

namespace IntegratedResourceManagementSystem.WareHouse.controls
{
    public partial class TransactionsStatus : System.Web.UI.UserControl
    {
        SalesInvoiceManager SIManager = new SalesInvoiceManager();
        DeliveryReceiptManager DRManager = new DeliveryReceiptManager();
        CustomerReturnSlipManager CRSManager = new CustomerReturnSlipManager();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                InitializeSummary();
            }
        }

        private void InitializeSummary()
        {
            lblTotalCancelledSalesInvoice.Text = SalesInvoiceSummary()[2].ToString("###,###");
            lblTotalUnpostedSalesInvoice.Text = SalesInvoiceSummary()[0].ToString("###,###");
            lblTotaPostedSalesInvoice.Text = SalesInvoiceSummary()[1].ToString("###,###");
            lblTotalSalesInvoice.Text = SalesInvoiceSummary()[3].ToString("###,###");

            lblTotalCancelledDeliveries.Text = DeliveriesSummary()[2].ToString("###,###");
            lblTotalDeliveriesPosted.Text = DeliveriesSummary()[0].ToString("###,###");
            lblTotalDeliveriesUnposted.Text = DeliveriesSummary()[1].ToString("###,###");
            lblTotalDeliveries.Text = DeliveriesSummary()[3].ToString("###,###");

            lblTotalCancelledCRS.Text = CustomerReturnSlipSummary()[2].ToString("###,###");
            lblTotalPostedCRS.Text = CustomerReturnSlipSummary()[0].ToString("###,###");
            lblTotalUnpostedCRS.Text = CustomerReturnSlipSummary()[1].ToString("###,###");
            lblTotalCRS.Text = CustomerReturnSlipSummary()[3].ToString("###,###");
        }
        private long[] SalesInvoiceSummary()
        {
            long[] results = new long[4];
            results[0] = SIManager.SalesInvoiceSummary().Where(c=> c.YesNoPosted ==false).Count();//unposted
            results[1] = SIManager.SalesInvoiceSummary().Where(c => c.YesNoPosted == true).Count();//posted
            results[2] = SIManager.SalesInvoiceSummary().Where(c => c.YesNoCancelled == true).Count();//cancelled
            results[3] = SIManager.SalesInvoiceSummary().Count;
            return results;
        }
        private long[] DeliveriesSummary()
        {
            long[] results = new long[4];
            results[0] = DRManager.DeliveryReceipts().Where(c => c.YesNoPosted == true).Count();
            results[1] = DRManager.DeliveryReceipts().Where(c => c.YesNoPosted == false).Count();
            results[2] = DRManager.DeliveryReceipts().Where(c => c.YesNoCancelled == true).Count();
            results[3] = DRManager.DeliveryReceipts().Count;
            return results;
        }
        private long[] CustomerReturnSlipSummary()
        {
            long[] results = new long[4];
            results[0] = CRSManager.CustomerReturnSlipSummary().Where(c => c.YesNoPosted == true).Count();
            results[1] = CRSManager.CustomerReturnSlipSummary().Where(c => c.YesNoPosted == false).Count();
            results[2] = CRSManager.CustomerReturnSlipSummary().Where(c => c.YesNoCancelled == true).Count();
            results[3] = CRSManager.CustomerReturnSlipSummary().Count;
            return results;
        }
    }
}