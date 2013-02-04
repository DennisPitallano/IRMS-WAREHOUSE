using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using IRMS.BusinessLogic.Manager;

namespace IntegratedResourceManagementSystem.WareHouse
{
    public partial class SalesInvoiceDetails : System.Web.UI.Page
    {
        private SalesInvoiceDetailManager SIDtlManager = new SalesInvoiceDetailManager();

        protected void Page_Init(object sender, EventArgs e)
        {
            int SIID = int.Parse(Request.QueryString["SIID"]);
            gvDRDetails.DataSource = this.SIDtlManager.GetSalesInvoiceDetailBySINumber(SIID);
            gvDRDetails.DataBind();
            txtCustomer.Text = Request.QueryString["Customer"];
            txtPLNumber.Text = Request.QueryString["PLNumber"];
            txtSIDate.Text = Request.QueryString["SalesInvoiceDate"];
            txtSINumber.Text = Request.QueryString["SINumber"];
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
          
            txtTotalQTY.Text = CountTotalDeliveryReceiptDetailsQuantity().ToString();
            txtTotalAmount.Text = CountTotalDeliveryReceiptDetailsAmount().ToString("###,###.00");

            }
        }
        private int CountTotalDeliveryReceiptDetailsQuantity()
        {
            int count = 0;
            foreach (GridViewRow row in this.gvSalesInvoiceSummary.Rows)
            {
                count = count + int.Parse(row.Cells[3].Text);
            }
            return count;
        }

        private double CountTotalDeliveryReceiptDetailsAmount()
        {
            double amount = 0.0;
            foreach (GridViewRow row in this.gvSalesInvoiceSummary.Rows)
            {
                amount = amount + double.Parse(row.Cells[7].Text);
            }
            return amount;
        }

        protected void rdioView_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (rdioView.SelectedIndex ==0)
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