using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using IRMS.BusinessLogic.Manager;
using IRMS.ObjectModel;
using System.Data;
using IRMS.Components;

namespace IntegratedResourceManagementSystem.WareHouse
{
    public partial class DeliveryReceiptPanel : System.Web.UI.Page
    {
        DeliveryReceiptManager DRManager = new DeliveryReceiptManager();
        DeliveryReceiptDetailManager DRDetailManager = new DeliveryReceiptDetailManager();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                btnPreviewSelectedDRForcancel.Text = "CANCEL SELECTED \n DELIVERY RECEIPT/s";
                txtSearchDR.Focus();
            }
            txtSearchDR.Focus();
        }
        
       
        protected void btnCancelSelectedDR_Click(object sender, EventArgs e)
        {
            try
            {
                if (GetSelectedDeliveryReceipts().Count > 0)
                {
                    btnCancelSelectedDR_ModalPopupExtender_Load(sender, e);
                    this.btnPreviewSelectedDRForcancel_ModalPopupExtender.Show();
                }
                else
                {
                    Redirector.Redirect("~/WareHouse/DeliveryReceiptPanel.aspx");
                }
            }
            catch (Exception)
            {
               // throw;
            }
        }

        protected void gvDeliveryReceipts_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                string DRNUmber=gvDeliveryReceipts.SelectedRow.Cells[4].Text;
               string DRDate = gvDeliveryReceipts.SelectedRow.Cells[5].Text;
                string PLNumber= HttpUtility.HtmlDecode(gvDeliveryReceipts.SelectedRow.Cells[6].Text);
               string Customer= gvDeliveryReceipts.SelectedRow.Cells[8].Text;
                hpLinkDeliveryDetails.NavigateUrl = "~/WareHouse/DeliveryDetails.aspx?DRID=" + gvDeliveryReceipts.SelectedValue.ToString()
                    +"&DRNumber="+DRNUmber+"&DRDate="+DRDate+"&PLNumber="+PLNumber+"&Customer="+Customer;
            }
            catch (Exception)
            {
                //throw;
            }
        }
        
      

        protected void btnCancelSelectedDR_ModalPopupExtender_Load(object sender, EventArgs e)
        {
            List<DeliveryReceipt> list = GetSelectedDeliveryReceipts();
            this.gvPreviewSelectedDR.DataSource = list;
            this.gvPreviewSelectedDR.DataBind();
        }

        private List<DeliveryReceipt> GetSelectedDeliveryReceiptsToBeCancelled()
        {
            List<DeliveryReceipt> list = new List<DeliveryReceipt>();
            foreach (GridViewRow row in this.gvPreviewSelectedDR.Rows)
            {
                CheckBox ck = ((CheckBox)row.FindControl("chkSelectedDRTCancelled"));

                if (ck.Checked)
                {
                    DeliveryReceipt dr = new DeliveryReceipt();
                    dr.RecordNo = long.Parse(ck.ToolTip);
                    list.Add(dr);
                }
            }
            return list;
        }

        private List<DeliveryReceipt> GetSelectedDeliveryReceipts()
        {
            List<DeliveryReceipt> list = new List<DeliveryReceipt>();
            foreach (GridViewRow row in this.gvDeliveryReceipts.Rows)
            {
                CheckBox ck = ((CheckBox)row.FindControl("chkID"));
                Image imgDelivery = (Image)row.FindControl("imgDelivery");
                if (ck.Checked)
                {
                    DeliveryReceipt dr = new DeliveryReceipt();
                    dr.DeliveryReceiptNumber = row.Cells[4].Text;
                    dr.DeliveredTo = row.Cells[8].Text;
                    dr.DRDate = DateTime.Parse(row.Cells[5].Text);
                    dr.PLNumber = row.Cells[6].Text;
                    dr.RecordNo = long.Parse(imgDelivery.ToolTip);
                    list.Add(dr);
                }
            }
            return list;
        }

        protected void btnYesCancelSelectedDR_Click(object sender, EventArgs e)
        {
            try
            {
                List<DeliveryReceipt> list = GetSelectedDeliveryReceiptsToBeCancelled();
                DRManager.UpdateDeliveryRecieptCancelledStatus(list);
                gvDeliveryReceipts.DataBind();
            }
            catch (Exception)
            {
                // throw;
            }
        }

        protected void imgBtnSearchDR_Click(object sender, ImageClickEventArgs e)
        {
            ClearSearchOption();
            hfIsAdvanceSearch.Value = "NO";
            if (rdioFilterView.SelectedValue != string.Empty)
            {
                if (txtSearchDR.Text != string.Empty)
                {
                    DRManager.SearchDeliveryReceiptList(SqlDataSourceDeliveryReceipt, txtSearchDR.Text,rdioFilterView.SelectedValue,rdioSearchOption.SelectedValue);
                    gvDeliveryReceipts.DataBind();
                }
                else
                {
                    DRManager.FilterDeliveryReceiptList(SqlDataSourceDeliveryReceipt, (rdioFilterView.SelectedValue));
                    gvDeliveryReceipts.DataBind();
                }
            }
            else
            {
                if (txtSearchDR.Text != String.Empty)
                {
                    DRManager.SearchDeliveryReceiptList(SqlDataSourceDeliveryReceipt, (txtSearchDR.Text));
                    gvDeliveryReceipts.DataBind();
                }
                else
                {
                    DRManager.FilterDeliveryReceiptList(SqlDataSourceDeliveryReceipt, (rdioFilterView.SelectedValue));
                    gvDeliveryReceipts.DataBind();
                }
            }
        }

        protected void gvDeliveryReceipts_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            if (this.txtDateSeachFrom.Text != string.Empty)
            {
                btnAdvanceSearch_Click(sender, e);
            }
            else
            {
                if (rdioFilterView.SelectedValue != string.Empty)
                {
                    if (txtSearchDR.Text != string.Empty)
                    {
                        DRManager.SearchDeliveryReceiptList(SqlDataSourceDeliveryReceipt, txtSearchDR.Text, rdioFilterView.SelectedValue, rdioSearchOption.SelectedValue);
                        gvDeliveryReceipts.DataBind();
                    }
                    else
                    {
                        DRManager.FilterDeliveryReceiptList(SqlDataSourceDeliveryReceipt, (rdioFilterView.SelectedValue));
                        gvDeliveryReceipts.DataBind();
                    }
                }
                else
                {
                    if (txtSearchDR.Text != String.Empty)
                    {
                        DRManager.SearchDeliveryReceiptList(SqlDataSourceDeliveryReceipt, (txtSearchDR.Text));
                        gvDeliveryReceipts.DataBind();
                    }
                    else
                    {
                        DRManager.FilterDeliveryReceiptList(SqlDataSourceDeliveryReceipt, (rdioFilterView.SelectedValue));
                        gvDeliveryReceipts.DataBind();
                    }
                }
            }
        }

      private void ClearSearchOption()
        {
            txtDateSeachFrom.Text = string.Empty;
            txtDateSeachTo.Text = string.Empty;
            txtSearchCompany.Text = string.Empty;
        }
        protected void rdioFilterView_SelectedIndexChanged(object sender, EventArgs e)
        {
            ClearSearchOption();
            if (rdioFilterView.SelectedValue == "CANCELLED")
            {
                btnPreviewSelectedDRForcancel.Enabled = false;
            }
            else
            {
                btnPreviewSelectedDRForcancel.Enabled = true ;
            }
            if (txtSearchDR.Text != String.Empty)
            {
                System.Threading.Thread.Sleep(100);
                DRManager.SearchDeliveryReceiptList(SqlDataSourceDeliveryReceipt, txtSearchDR.Text, rdioFilterView.SelectedValue, rdioSearchOption.SelectedValue);
                gvDeliveryReceipts.DataBind();
            }
            else
            {
                System.Threading.Thread.Sleep(100);
                DRManager.FilterDeliveryReceiptList(SqlDataSourceDeliveryReceipt, (rdioFilterView.SelectedValue));
                gvDeliveryReceipts.DataBind();
            }
        }

        protected void btnAdvanceSearch_Click(object sender, EventArgs e)
        {
            try
            {
                System.Threading.Thread.Sleep(100);
                hfIsAdvanceSearch.Value = "YES";
                DRManager.AdvanceSearch(SqlDataSourceDeliveryReceipt, txtSearchDR.Text, rdioFilterView.SelectedValue,
                                        DateTime.Parse(txtDateSeachFrom.Text), DateTime.Parse(txtDateSeachTo.Text), txtSearchCompany.Text);
                gvDeliveryReceipts.DataBind();
            }
            catch (Exception)
            {
                // throw;
            }
        }

        protected void chkEnableCompanySearch_CheckedChanged(object sender, EventArgs e)
        {
           // System.Threading.Thread.Sleep(100);
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


        protected void gvDeliveryReceipts_Sorting(object sender, GridViewSortEventArgs e)
        {
            if (this.txtDateSeachFrom.Text !=string.Empty)
            {
                btnAdvanceSearch_Click(sender, e);
            }
            else
            {
                if (rdioFilterView.SelectedValue != string.Empty)
                {
                    if (txtSearchDR.Text != string.Empty)
                    {
                        System.Threading.Thread.Sleep(100);
                        DRManager.SearchDeliveryReceiptList(SqlDataSourceDeliveryReceipt, txtSearchDR.Text, rdioFilterView.SelectedValue, rdioSearchOption.SelectedValue);
                        gvDeliveryReceipts.DataBind();
                    }
                    else
                    {
                        System.Threading.Thread.Sleep(100);
                        DRManager.FilterDeliveryReceiptList(SqlDataSourceDeliveryReceipt, (rdioFilterView.SelectedValue));
                        gvDeliveryReceipts.DataBind();
                    }
                }
                else
                {
                    if (txtSearchDR.Text != String.Empty)
                    {
                        System.Threading.Thread.Sleep(100);
                        DRManager.SearchDeliveryReceiptList(SqlDataSourceDeliveryReceipt, (txtSearchDR.Text));
                        gvDeliveryReceipts.DataBind();
                    }
                    else
                    {
                        System.Threading.Thread.Sleep(100);
                        DRManager.FilterDeliveryReceiptList(SqlDataSourceDeliveryReceipt, (rdioFilterView.SelectedValue));
                        gvDeliveryReceipts.DataBind();
                    }
                }
            }
        }
    }
}