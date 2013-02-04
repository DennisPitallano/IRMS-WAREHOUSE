using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using IRMS.BusinessLogic.Manager;

namespace IntegratedResourceManagementSystem.WareHouse
{
    public partial class DeliveryDetails : System.Web.UI.Page
    {
        DeliveryReceiptDetailManager DRDetailManager = new DeliveryReceiptDetailManager();
        protected void Page_Init(object sender, EventArgs e)
        {
            int DRID = int.Parse(Request.QueryString["DRID"]);
            gvDRDetails.DataSource = DRDetailManager.DeliveryReceiptDetailsByDRNumber(DRID);
            gvDRDetails.DataBind();
            txtDeliverTo.Text = Request.QueryString["Customer"];
            txtDeliveryReceiptDate.Text = Request.QueryString["DRDate"];
            txtDRNumberDetails.Text = Request.QueryString["DRNumber"];
            txtPLNumber.Text = Request.QueryString["PlNumber"];
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                txtTotalAmount.Text = CountTotalDeliveryReceiptDetailsAmount().ToString("###,###.00");
                txtTotalQTY.Text = CountTotalDeliveryReceiptDetailsQuantity().ToString();
            }
        }
        private int CountTotalDeliveryReceiptDetailsQuantity()
        {
            int count = 0;
            foreach (GridViewRow row in this.gvDeliverySummary.Rows)
            {
                count = count + int.Parse(row.Cells[4].Text);
            }
            return count;
        }

        private double CountTotalDeliveryReceiptDetailsAmount()
        {
            double amount = 0.0;
            foreach (GridViewRow row in this.gvDeliverySummary.Rows)
            {
                amount = amount + double.Parse(row.Cells[7].Text);
            }
            return amount;
        }

        protected void rdioView_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (rdioView.SelectedIndex == 0)
            {
                mViewSalesInvoice.SetActiveView(vSummary);
            }
            else
            {
                mViewSalesInvoice.SetActiveView(vDetails);
            }
        }
    }
}