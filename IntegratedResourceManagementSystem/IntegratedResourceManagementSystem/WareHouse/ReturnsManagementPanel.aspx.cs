using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using IRMS.BusinessLogic.Manager;
using IRMS.Components;
using IRMS.ObjectModel;

namespace IntegratedResourceManagementSystem.WareHouse
{
    public partial class CRSConfirmationPanel : System.Web.UI.Page
    {
        private BrandManager BManager = new BrandManager();
        private CustomerReturnSlipManager CRSManager = new CustomerReturnSlipManager();
        private DeliveryReceiptDetailManager DRDetailManager = new DeliveryReceiptDetailManager();
        private DeliveryReceiptManager DRManager = new DeliveryReceiptManager();
        private ForwarderManager ForwarderManager = new ForwarderManager();

        public string BRAND_NAME { get; set; }

        public DateTime DR_DATE_FROM { get; set; }

        public DateTime DR_DATE_TO { get; set; }

        public string INCLUDE_DATE_RANGE { get; set; }

        public string TRANSIT_STATUS { get; set; }

        protected void btnCancelSelectedDR_Click(object sender, EventArgs e)
        {
          
            this.btnPreviewSelectedDRForcancel_ModalPopupExtender.Show();
        }

      

        protected void btnContinueDRConfirmation_Click(object sender, EventArgs e)
        {
            try
            {
                List<CustomerReturnSlipConfirmation> list = GetSelectedDeliveryReceiptsToBeCancelled();
                CRSManager.ConfirmCustomerReturnSlip(list);
                rdioFilterView_SelectedIndexChanged(sender, e);
            }
            catch (Exception)
            {
                // throw;
            }
        }

        protected void btnGenerateDetailedReportPerCustomer_Click(object sender, EventArgs e)
        {
            string ResponseURL = string.Empty;
            ResponseURL = "~/Reports/ReportForms/DetailedReportPerOutlet.aspx?";
            ResponseURL += "CustomerNumber=" + dlOutletDetailed.SelectedValue;
            ResponseURL += "&DateFrom=" + txtPullOutDetailedPerOutletDateFrom.Text;
            ResponseURL += "&DateTo=" + txtPullOutDetailedPerOutletDateTo.Text;
            Redirector.Redirect(ResponseURL);
        }

        protected void btnGenerateMonthlyPullOutSummaryPerCustomer_Click(object sender, EventArgs e)
        {
            string ResponseURL = string.Empty;
            ResponseURL = "~/Reports/ReportForms/MonthlyPullOutSummaryPerCustomer.aspx?";
            ResponseURL += "CustomerNumber=" + dlCustomerSummary.SelectedValue;
            ResponseURL += "&DateFrom=" + txtDateRangeFromSummaryPerCustomer.Text;
            ResponseURL += "&DateTo=" + txtDateRangeToSummaryPerCustomer.Text;
            Redirector.Redirect(ResponseURL);
        }

        protected void btnGo_Click(object sender, EventArgs e)
        {
        }

        protected void btnPrintByBrand_Click(object sender, EventArgs e)
        {
            string ResponseURL = string.Empty;
            ResponseURL = "~/Reports/ReportForms/MonthlyPullOutSummaryPerBrandReport.aspx?";
            ResponseURL += "Brand=" + dlConfirmedBrands.SelectedValue;
            ResponseURL += "&DateFrom=" + txtConfirmedDateRangeFrom.Text;
            ResponseURL += "&DateTo=" + txtConfirmedDateRangeTo.Text;
            ResponseURL += "&CustomerType=" + rdioListCustomerType.SelectedValue;
            Redirector.Redirect(ResponseURL);
        }

        protected void btnPrintConsolidated_Click(object sender, EventArgs e)
        {
            string ResponseURL = string.Empty;
            ResponseURL = "~/Reports/ReportForms/MonthlyConsolidatedReport.aspx?";
            ResponseURL += "&DateFrom=" + txtConsolidatedDateFrom.Text;
            ResponseURL += "&DateTo=" + txtConsolidatedDateTo.Text;
            Redirector.Redirect(ResponseURL);
        }

        protected void btnYesCancelSelectedDR_Click(object sender, EventArgs e)
        {
            try
            {
                List<CustomerReturnSlip> list = GetSelectedCustomerReturnSlipToBeCancelled();
                this.CRSManager .UpdateCustomerReturnSlipCancelledStatus(list);
                gvDeliveryReceipts.DataBind();
            }
            catch (Exception)
            {
                // throw;
            }
        }

        private List<CustomerReturnSlip> GetSelectedCustomerReturnSlipToBeCancelled()
        {
            List<CustomerReturnSlip> list = new List<CustomerReturnSlip>();
            foreach (GridViewRow row in this.gvSelectedItemsToCancel.Rows)
            {
                CheckBox ck = ((CheckBox)row.FindControl("chkSelectedCRSToBeCancelled"));
                if (ck.Checked)
                {
                    CustomerReturnSlip crs = new CustomerReturnSlip();
                    crs.RecordNo = int.Parse(ck.ToolTip); // = this.CRSManager.GetCustomerReturnSlipByKey(long.Parse(ck.ToolTip));
                    list.Add(crs);
                }
                else
                {
                    //Code if it is not checked ......may not be required
                }
            }
            return list;
        }

        protected void gvDeliveryReceipts_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            if (txtDateSeachFrom.Text != string.Empty)
            {
                txtDateSeachFrom_TextChanged(sender, e);
            }
            else
            {
                if (txtSearchDR.Text != string.Empty)
                {
                    CRSManager.SearchCustomerReturnSlip(SqlDataSourceDeliveryReceipt, (rdioFilterView.SelectedValue), txtSearchDR.Text, rdioSearchFilter.SelectedValue);
                    gvDeliveryReceipts.DataBind();
                }
                else
                {
                    CRSManager.FilterCustomerReturnSlip(SqlDataSourceDeliveryReceipt, (rdioFilterView.SelectedValue));
                    gvDeliveryReceipts.DataBind();
                }
            }
        }

        protected void gvDeliveryReceipts_SelectedIndexChanged(object sender, EventArgs e)
        {
            hpLinkReturnDetails.NavigateUrl = "~/WareHouse/ReturnsDetails.aspx?ReturnId=" + gvDeliveryReceipts.SelectedValue.ToString()
                + "&ReturnNumber=" + gvDeliveryReceipts.SelectedRow.Cells[5].Text
                + "&ReturnDate=" + gvDeliveryReceipts.SelectedRow.Cells[6].Text
                + "&PLNumber=" + HttpUtility.HtmlDecode(gvDeliveryReceipts.SelectedRow.Cells[10].Text)
                + "&Customer=" + gvDeliveryReceipts.SelectedRow.Cells[7].Text;
        }

        protected void gvDeliveryReceipts_Sorting(object sender, GridViewSortEventArgs e)
        {
            if (txtDateSeachFrom.Text != string.Empty)
            {
                txtDateSeachFrom_TextChanged(sender, e);
            }
            else
            {
                if (txtSearchDR.Text != string.Empty)
                {
                    CRSManager.SearchCustomerReturnSlip(SqlDataSourceDeliveryReceipt, (rdioFilterView.SelectedValue), txtSearchDR.Text, rdioSearchFilter.SelectedValue);
                    gvDeliveryReceipts.DataBind();
                }
                else
                {
                    CRSManager.FilterCustomerReturnSlip(SqlDataSourceDeliveryReceipt, (rdioFilterView.SelectedValue));
                    gvDeliveryReceipts.DataBind();
                }
            }
        }

        protected void imgBtnSearchDR_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                CRSManager.SearchCustomerReturnSlip(SqlDataSourceDeliveryReceipt, rdioFilterView.SelectedValue, txtSearchDR.Text, rdioSearchFilter.SelectedValue);
                gvDeliveryReceipts.DataBind();
            }
            catch (Exception)
            {
                //throw;
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                txtConfirmationDate.Text = DateTime.Now.ToString("MMMM dd, yyyy");
                LoadAllBrands();
                LoadAllForwarders();
            }
        }

        protected void rdioFilterView_SelectedIndexChanged(object sender, EventArgs e)
        {
            switch (rdioFilterView.SelectedIndex )
            {
                case 0:
                    lblListTitle.Text = "LIST OF UNPOSTED RETURNS";
                    break;
                case 1:
                    lblListTitle.Text = "LIST OF POSTED RETURNS";
                    break;
                case 2:
                    lblListTitle.Text = "LIST OF CANCELLED RETURNS";
                    break;
                case 3:
                    lblListTitle.Text = "LIST OF CONFIRMED RETURNS";
                    break;
                default:
                    break;
            }
            if (rdioFilterView.SelectedValue == "CANCELLED" || rdioFilterView.SelectedValue == "CONFIRMED")
            {
                btnConfirmedDR.Enabled = false;
                btnPreviewSelectedCRSForcancel.Enabled = false;
            }
            else
            {
                btnConfirmedDR.Enabled = true;
                btnPreviewSelectedCRSForcancel.Enabled = true;
            }
            CRSManager.FilterCustomerReturnSlip(SqlDataSourceDeliveryReceipt, (rdioFilterView.SelectedValue));
        }

        protected void txtDateSeachFrom_TextChanged(object sender, EventArgs e)
        {
            CRSManager.SearchCustomerReturnSlipWithDateRange(SqlDataSourceDeliveryReceipt, rdioFilterView.SelectedValue, txtSearchDR.Text, DateTime.Parse(this.txtDateSeachFrom.Text), DateTime.Parse(this.txtDateSeachTo.Text));
            gvDeliveryReceipts.DataBind();
            ibtnEnableDate_ModalPopupExtender.Show();
        }

        protected void txtDateSeachTo_TextChanged(object sender, EventArgs e)
        {
            CRSManager.SearchCustomerReturnSlipWithDateRange(SqlDataSourceDeliveryReceipt, rdioFilterView.SelectedValue, txtSearchDR.Text, DateTime.Parse(this.txtDateSeachFrom.Text), DateTime.Parse(this.txtDateSeachTo.Text));
            gvDeliveryReceipts.DataBind();
            ibtnEnableDate_ModalPopupExtender.Show();
        }

        private List<CustomerReturnSlip> GetSelectedCustomerReturnSlips()
        {
            List<CustomerReturnSlip> list = new List<CustomerReturnSlip>();
            foreach (GridViewRow row in this.gvDeliveryReceipts.Rows)
            {
                CheckBox ck = ((CheckBox)row.FindControl("chkID"));
                Image imgReturn = (Image)row.FindControl("imgReturn");
                if (ck.Checked)
                {
                    CustomerReturnSlip crs = new CustomerReturnSlip();
                    crs.CustomerReturnSlipNumber = row.Cells[5].Text;
                    crs.CustomerReturnSlipDate = DateTime.Parse(row.Cells[6].Text);
                    crs.Customer = row.Cells[7].Text;
                    crs.PkgNo = row.Cells[10].Text;
                    crs.RecordNo = int.Parse(imgReturn.AlternateText);
                    crs.PUSNo = row.Cells[8].Text;
                    list.Add(crs);
                }
               
            }
            return list;
        }

        protected void btnPreviewSelectedCRSForcancel_Click(object sender, EventArgs e)
        {
            try
            {
                if (GetSelectedCustomerReturnSlips().Count > 0)
                {
                    List<CustomerReturnSlip> list = GetSelectedCustomerReturnSlips();
                    this.gvSelectedItemsToCancel.DataSource = list;
                    this.gvSelectedItemsToCancel.DataBind();
                    this.lblSelectedItemToCancelModalHandler_ModalPopupExtender.Show();
                }
                else
                {
                    Redirector.Redirect("~/WareHouse/ReturnsManagementPanel.aspx");
                }
            }
            catch (Exception)
            {

                //   throw;
            }
        }
     
        private List<CustomerReturnSlipConfirmation> GetSelectedDeliveryReceiptsToBeCancelled()
        {
            List<CustomerReturnSlipConfirmation> list = new List<CustomerReturnSlipConfirmation>();
            foreach (GridViewRow row in this.gvPreviewSelectedDR.Rows)
            {
                CheckBox ck = ((CheckBox)row.FindControl("chkSelectedDRTCancelled"));

                if (ck.Checked)
                {
                    CustomerReturnSlipConfirmation crs = new CustomerReturnSlipConfirmation();
                    crs.CRSNumber = row.Cells[0].Text;
                    crs.DateTransfer = DateTime.Parse(txtConfirmationDate.Text);
                    crs.Destination = txtDestination.Text;
                    crs.Forwarder = dlForwarders.SelectedValue;
                    crs.WayBillNumber = txtWayBillNumber.Text;
                    list.Add(crs);
                }
            }
            return list;
        }

        private void LoadAllBrands()
        {
            dlConfirmedBrands.Items.Clear();
            foreach (Brand brand in BManager.Brands())
            {
                this.dlConfirmedBrands.Items.Add(new ListItem(brand.BrandDescription, brand.BrandDescription));
            }
        }

        private void LoadAllForwarders()
        {
            dlForwarders.Items.Clear();
            foreach (Forwarder forwarder in ForwarderManager.Forwarders())
            {
                dlForwarders.Items.Add(new ListItem(forwarder.ForwarderName, forwarder.ForwarderName));
            }
        }

        protected void btnConfirmedDR_Click(object sender, EventArgs e)
        {
            List<CustomerReturnSlip> list = GetSelectedCustomerReturnSlips();
            this.gvPreviewSelectedDR.DataSource = list;
            this.gvPreviewSelectedDR.DataBind();
            this.btnPreviewSelectedDRForcancel_ModalPopupExtender.Show();
        }

      
    }
}