using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using IRMS.BusinessLogic.Manager;
using IRMS.ObjectModel;
using IRMS.Components;

namespace IntegratedResourceManagementSystem.WareHouse
{
    public partial class CustomerReturnSlipPanel : System.Web.UI.Page
    {
        CustomerReturnSlipManager CRSManager = new CustomerReturnSlipManager();
        CustomerReturnSlipDetailManager CRSDtlManager = new CustomerReturnSlipDetailManager();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                txtSearchDR.Focus();
            }
            txtSearchDR.Focus();
        }

        private void LoadAllCustomerReturnSlip()
        {
            System.Threading.Thread.Sleep(500);
            this.gvCustomerReturnSlip.DataSource = CRSManager.CustomerReturnSlips();
            this.gvCustomerReturnSlip.DataBind();
        }

        protected void gvCustomerReturnSlip_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                //System.Threading.Thread.Sleep(500);
                txtDRNumberDetails.Text = gvCustomerReturnSlip.SelectedRow.Cells[4].Text;
                txtDeliveryReceiptDate.Text = gvCustomerReturnSlip.SelectedRow.Cells[5].Text;
                txtDeliverTo.Text = gvCustomerReturnSlip.SelectedRow.Cells[6].Text;
                txtPLNumber.Text = gvCustomerReturnSlip.SelectedRow.Cells[8].Text;
                CheckBox chkBox = ((CheckBox) gvCustomerReturnSlip.SelectedRow.FindControl("chkID"));

                this.gvCRSDetails.DataSource = this.CRSDtlManager.CustomerReturnSlipDetailsByCRSID(int.Parse(chkBox.ToolTip));
                gvCRSDetails.DataBind();
                lblTotalQuantity.Text = CountTotalDeliveryReceiptDetailsQuantity().ToString();
                lblTotalAmount.Text = CountTotalDeliveryReceiptDetailsAmount().ToString("Php###,###.00");
            }
            catch (Exception)
            {
               // throw;
            }
        }
        private int CountTotalDeliveryReceiptDetailsQuantity()
        {
            int count = 0;
            try
            {
                foreach (GridViewRow row in this.gvCRSDetails.Rows)
                {
                    count = count + int.Parse(row.Cells[4].Text);
                }
                return count;
            }
            catch (Exception)
            {
                return count;
            }
        }
        private double CountTotalDeliveryReceiptDetailsAmount()
        {
            double amount = 0.0;
            try
            {
                foreach (GridViewRow row in this.gvCRSDetails.Rows)
                {
                    amount = amount + double.Parse(row.Cells[6].Text.Replace("Php", ""));
                }
                return amount;
            }
            catch (Exception)
            {
                return amount;
            }
        }
        protected void LoadCustomerReturnSlip(object sender, EventArgs e)
        {
            //System.Threading.Thread.Sleep(500);
            List<CustomerReturnSlip> list = GetSelectedCustomerReturnSlip();
            this.gvPreviewSelectedDR.DataSource = list;
            this.gvPreviewSelectedDR.DataBind();
        }

        private List<CustomerReturnSlip> GetSelectedCustomerReturnSlipToBeCancelled()
        {
            List<CustomerReturnSlip> list = new List<CustomerReturnSlip>();
            foreach (GridViewRow row in this.gvPreviewSelectedDR.Rows)
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

        private List<CustomerReturnSlip> GetSelectedCustomerReturnSlip()
        {
            List<CustomerReturnSlip> list = new List<CustomerReturnSlip>();
            foreach (GridViewRow row in this.gvCustomerReturnSlip.Rows)
            {
                CheckBox ck = ((CheckBox)row.FindControl("chkID"));
                if (ck.Checked)
                {
                    CustomerReturnSlip crs = new CustomerReturnSlip();
                    crs.RecordNo = int.Parse(ck.ToolTip);// = this.CRSManager.GetCustomerReturnSlipByKey(long.Parse(ck.ToolTip));
                    crs.CustomerReturnSlipNumber = row.Cells[4].Text;
                    crs.Customer = row.Cells[6].Text;
                    crs.CustomerReturnSlipDate = DateTime.Parse( row.Cells[5].Text);
                    crs.PUSNo = row.Cells[8].Text;
                    list.Add(crs);
                }
                else
                {
                    //Code if it is not checked ......may not be required
                }
            }
            return list;
        }

        protected void btnPreviewSelectedCRSForcancel_Click(object sender, EventArgs e)
        {
            try
            {
                if (GetSelectedCustomerReturnSlip().Count > 0)
                {
                    LoadCustomerReturnSlip(sender, e);
                    this.btnPreviewSelectedDRForcancel_ModalPopupExtender.Show();
                }
                else
                {
                    Redirector.Redirect("~/WareHouse/CustomerReturnSlipPanel.aspx");
                }
            }
            catch (Exception)
            {
                
             //   throw;
            }
        }

        protected void gvCustomerReturnSlip_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            chkSeleckAll.Checked = false;
            if (this.txtDateSeachFrom.Text != string.Empty)
            {
                btnAdvanceSearch_Click(sender, e);
            }
            else
            {
               // System.Threading.Thread.Sleep(1000);
                if (rdioFilterView.SelectedValue != string.Empty)
                {
                    if (txtSearchDR.Text != String.Empty)
                    {
                        System.Threading.Thread.Sleep(500);
                        CRSManager.SearchCustomerReturnSlipList(SqlDataSourceCustomerReturnSlip, (txtSearchDR.Text), rdioFilterView.SelectedValue,rdioSearchOption.SelectedValue);
                        gvCustomerReturnSlip.DataBind();
                    }
                    else
                    {
                        System.Threading.Thread.Sleep(500);
                        CRSManager.FilterCustomerReturnSlipList(SqlDataSourceCustomerReturnSlip, (rdioFilterView.SelectedValue));
                        gvCustomerReturnSlip.DataBind();
                    }
                }
                else
                {
                    if (txtSearchDR.Text != String.Empty)
                    {
                        System.Threading.Thread.Sleep(500);
                        CRSManager.SearchCustomerReturnSlipList(SqlDataSourceCustomerReturnSlip, (txtSearchDR.Text));
                        gvCustomerReturnSlip.DataBind();
                    }
                    else
                    {
                        System.Threading.Thread.Sleep(500);
                        CRSManager.FilterCustomerReturnSlipList(SqlDataSourceCustomerReturnSlip, (rdioFilterView.SelectedValue));
                        gvCustomerReturnSlip.DataBind();
                    }
                }
            }
        }

        protected void imgBtnSearchDR_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                ClearSearchOption();
                chkSeleckAll.Checked = false;
                hfIsAdvanceSearch.Value = "NO";
                System.Threading.Thread.Sleep(500);
                if (rdioFilterView.SelectedValue != string.Empty)
                {
                    if (txtSearchDR.Text != String.Empty)
                    {
                       // System.Threading.Thread.Sleep(500);
                        CRSManager.SearchCustomerReturnSlipList(SqlDataSourceCustomerReturnSlip, (txtSearchDR.Text), rdioFilterView.SelectedValue,rdioSearchOption.SelectedValue);
                        gvCustomerReturnSlip.DataBind();
                    }
                    else
                    {
                       // System.Threading.Thread.Sleep(500);
                        CRSManager.FilterCustomerReturnSlipList(SqlDataSourceCustomerReturnSlip, (rdioFilterView.SelectedValue));
                        gvCustomerReturnSlip.DataBind();
                    }
                }
                else
                {
                    if (txtSearchDR.Text != String.Empty)
                    {
                      //  System.Threading.Thread.Sleep(500);
                        CRSManager.SearchCustomerReturnSlipList(SqlDataSourceCustomerReturnSlip, (txtSearchDR.Text));
                        gvCustomerReturnSlip.DataBind();
                    }
                    else
                    {
                       // System.Threading.Thread.Sleep(500);
                        CRSManager.FilterCustomerReturnSlipList(SqlDataSourceCustomerReturnSlip, (rdioFilterView.SelectedValue));
                        gvCustomerReturnSlip.DataBind();
                    }
                }
              
            }
            catch (Exception)
            {
                
                //throw;
            }
        }

        protected void btnYesCancelSelectedDR_Click(object sender, EventArgs e)
        {
            try
            {
                System.Threading.Thread.Sleep(500);
                List<CustomerReturnSlip> list = GetSelectedCustomerReturnSlipToBeCancelled();
                CRSManager.UpdateCustomerReturnSlipCancelledStatus(list);
                gvCustomerReturnSlip.DataBind();
            }
            catch (Exception)
            {
              //  throw;
            }
        }

        protected void rdioFilterView_SelectedIndexChanged(object sender, EventArgs e)
        {
            ClearSearchOption();
            //gvCRSDetails.DataBind();
            if (rdioFilterView.SelectedValue == "CANCELLED")
            {
                btnPreviewSelectedCRSForcancel.Enabled = false;
            }
            else
            {
                btnPreviewSelectedCRSForcancel.Enabled = true;
            }
            chkSeleckAll.Checked = false;
            if (txtSearchDR.Text != String.Empty)
            {
               // System.Threading.Thread.Sleep(500);
                CRSManager.SearchCustomerReturnSlipList(SqlDataSourceCustomerReturnSlip, (txtSearchDR.Text), rdioFilterView.SelectedValue, rdioSearchOption.SelectedValue);
                gvCustomerReturnSlip.DataBind();
            }
            else
            {
              //  System.Threading.Thread.Sleep(500);
                CRSManager.FilterCustomerReturnSlipList(SqlDataSourceCustomerReturnSlip, (rdioFilterView.SelectedValue));
                gvCustomerReturnSlip.DataBind();
            }
            
        }
        private void ClearSearchOption()
        {
            txtDateSeachFrom.Text = string.Empty;
            txtDateSeachTo.Text = string.Empty;
            txtSearchCompany.Text = string.Empty;
        }
        protected void chkEnableCompanySearch_CheckedChanged(object sender, EventArgs e)
        {
            chkSeleckAll.Checked = false;
            if (chkEnableCompanySearch.Checked == true)
            {
                txtSearchCompany.Enabled = true;
                chkEnableCompanySearch.Font.Italic = true;
            }
            else
            {
                txtSearchCompany.Enabled = false;
                chkEnableCompanySearch.Font.Italic = false;
            }
            imgAdvanceSearch_ModalPopupExtender.Show();
        }

        protected void btnAdvanceSearch_Click(object sender, EventArgs e)
        {
            try
            {
                chkSeleckAll.Checked = false;
                System.Threading.Thread.Sleep(100);
                hfIsAdvanceSearch.Value = "YES";
                CRSManager.AdvanceSearch(SqlDataSourceCustomerReturnSlip, txtSearchDR.Text, rdioFilterView.SelectedValue,
                    DateTime.Parse(txtDateSeachFrom.Text), DateTime.Parse(txtDateSeachTo.Text), txtSearchCompany.Text);
                gvCustomerReturnSlip.DataBind();
            }
            catch (Exception)
            {

                // throw;
            }
        }

        protected void chkSeleckAll_CheckedChanged(object sender, EventArgs e)
        {
            System.Threading.Thread.Sleep(100);
            if (chkSeleckAll.Checked == true)
            {
                foreach (GridViewRow row in this.gvCustomerReturnSlip.Rows)
                {
                    CheckBox ck = ((CheckBox)row.FindControl("chkID"));
                    ck.Checked = true;
                }
            }
            else
            {
                foreach (GridViewRow row in this.gvCustomerReturnSlip.Rows)
                {
                    CheckBox ck = ((CheckBox)row.FindControl("chkID"));
                    ck.Checked = false;
                }
            }
            
        }

        protected void gvCustomerReturnSlip_Sorting(object sender, GridViewSortEventArgs e)
        {
            chkSeleckAll.Checked = false;
            if (this.txtDateSeachFrom.Text!= string.Empty)
            {
                btnAdvanceSearch_Click(sender, e);
            }
            else
            {
                // System.Threading.Thread.Sleep(1000);
                if (rdioFilterView.SelectedValue != string.Empty)
                {
                    if (txtSearchDR.Text != String.Empty)
                    {
                        System.Threading.Thread.Sleep(500);
                        CRSManager.SearchCustomerReturnSlipList(SqlDataSourceCustomerReturnSlip, (txtSearchDR.Text), rdioFilterView.SelectedValue,rdioSearchOption.SelectedValue);
                        gvCustomerReturnSlip.DataBind();
                    }
                    else
                    {
                        System.Threading.Thread.Sleep(500);
                        CRSManager.FilterCustomerReturnSlipList(SqlDataSourceCustomerReturnSlip, (rdioFilterView.SelectedValue));
                        gvCustomerReturnSlip.DataBind();
                    }
                }
                else
                {
                    if (txtSearchDR.Text != String.Empty)
                    {
                        System.Threading.Thread.Sleep(500);
                        CRSManager.SearchCustomerReturnSlipList(SqlDataSourceCustomerReturnSlip, (txtSearchDR.Text));
                        gvCustomerReturnSlip.DataBind();
                    }
                    else
                    {
                        System.Threading.Thread.Sleep(500);
                        CRSManager.FilterCustomerReturnSlipList(SqlDataSourceCustomerReturnSlip, (rdioFilterView.SelectedValue));
                        gvCustomerReturnSlip.DataBind();
                    }
                }
            }
        }

      
    }
}