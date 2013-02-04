using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IntegratedResourceManagementSystem.WareHouse
{
    public partial class ReturnsDetails : System.Web.UI.Page
    {
        protected void Page_Init(object sender, EventArgs e)
        {
            hfRcordNumber.Value = Request.QueryString["ReturnId"];
            txtDeliverTo.Text = Request.QueryString["Customer"];
            txtDeliveryReceiptDate.Text = Request.QueryString["ReturnDate"];
            txtDRNumberDetails.Text = Request.QueryString["ReturnNumber"];
            txtPLNumber.Text = Request.QueryString["PLNumber"];
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                lblTotalQuantity.Text = CountTotalDeliveryReceiptDetailsQuanntity().ToString();
                lblTotalAmount.Text = CountTotalDeliveryReceiptDetailsAmount().ToString("###,###.00");
            }
        }
        private double CountTotalDeliveryReceiptDetailsAmount()
        {
            double amount = 0.0;
            foreach (GridViewRow row in this.gvSummary.Rows)
            {
                amount = amount + double.Parse(row.Cells[6].Text);
            }
            return amount;
        }

        private int CountTotalDeliveryReceiptDetailsQuanntity()
        {
            int count = 0;
            foreach (GridViewRow row in this.gvSummary.Rows)
            {
                count = count + int.Parse(row.Cells[3].Text);
            }
            return count;
        }

        protected void rdioViewFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (rdioViewFilter.SelectedIndex ==0)
            {
                mViewFilter.ActiveViewIndex = 0;
            }
            else
            {
                mViewFilter.ActiveViewIndex = 1;
            }
        }
    }
}