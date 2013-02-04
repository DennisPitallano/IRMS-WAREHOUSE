using System;
using System.Collections.Generic;
using System.Web.UI;
using System.Web.UI.WebControls;
using IRMS.BusinessLogic.Manager;
using IRMS.Components;
using IRMS.ObjectModel;

namespace IntegratedResourceManagementSystem.WareHouse
{
    public partial class SalesInvoicePanel : System.Web.UI.Page
    {
        private SalesInvoiceManager SIManager = new SalesInvoiceManager();
        private SalesInvoiceDetailManager SIDtlManager = new SalesInvoiceDetailManager();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                btnPreviewSelectedSIForcancel.Text = "CANCEL SELECTED \nSALES INVOICE/s";
                txtSearchDR.Focus();
            }
            txtSearchDR.Focus();
        }

        private void LoadAllSalesInvoices()
        {
            this.gvSalesInvoice.DataSource = SIManager.SalesInvoices();
            this.gvSalesInvoice.DataBind();
        }

        protected void gvSalesInvoice_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                hpLinkSalesInvoiceDetails.NavigateUrl = "~/WareHouse/SalesInvoiceDetails.aspx?SIID=" + gvSalesInvoice.SelectedValue.ToString()
                    + "&SalesInvoiceDate=" + gvSalesInvoice.SelectedRow.Cells[6].Text + "&PLNumber=" + gvSalesInvoice.SelectedRow.Cells[12].Text
                    + "&Customer=" + gvSalesInvoice.SelectedRow.Cells[8].Text + "&SINumber=" + gvSalesInvoice.SelectedRow.Cells[5].Text;
            }
            catch (Exception)
            {
                // throw;
            }
        }

       

        protected void btnPreviewSelectedSIForcancel_Click(object sender, EventArgs e)
        {
            if (GetSelectedSalesInvoice().Count > 0)
            {
                LoadSelectedSalesInvoices(sender, e);
                this.btnPreviewSelectedDRForcancel_ModalPopupExtender.Show();
            }
            else
            {
                Redirector.Redirect("~/WareHouse/SalesInvoicePanel.aspx");
            }
        }

        protected void LoadSelectedSalesInvoices(object sender, EventArgs e)
        {
            List<SalesInvoice> list = GetSelectedSalesInvoice();
            this.gvPreviewSelectedDR.DataSource = list;
            this.gvPreviewSelectedDR.DataBind();
        }

        private List<SalesInvoice> GetSalesInvoiceToBeCancelled()
        {
            List<SalesInvoice> list = new List<SalesInvoice>();
            foreach (GridViewRow row in this.gvPreviewSelectedDR.Rows)
            {
                CheckBox ck = ((CheckBox)row.FindControl("chkSelectedSalesInvoice"));

                if (ck.Checked)
                {
                    SalesInvoice si = new SalesInvoice();
                    si.RecordNo = int.Parse(ck.ToolTip);// = this.SIManager.GetSalesInvoiceByKey(long.Parse(ck.ToolTip));
                    list.Add(si);
                }

                else
                {
                    //Code if it is not checked ......may not be required
                }
            }
            return list;
        }

        private List<SalesInvoice> GetSelectedSalesInvoice()
        {
            List<SalesInvoice> list = new List<SalesInvoice>();
            foreach (GridViewRow row in this.gvSalesInvoice.Rows)
            {
                CheckBox ck = ((CheckBox)row.FindControl("chkID"));
                Image imgSalesInvoice = (Image)row.FindControl("imgInvoice");
                if (ck.Checked)
                {
                    SalesInvoice si = new SalesInvoice();
                    si.SalesInvoiceNumber = row.Cells[5].Text;
                    si.SoldTo = row.Cells[8].Text;
                    si.SalesInvoiceDate = DateTime.Parse(row.Cells[6].Text);
                    si.PLNumber = row.Cells[12].Text;
                    si.RecordNo = int.Parse(imgSalesInvoice.AlternateText);
                    list.Add(si);
                }
            }
            return list;
        }

        protected void gvSalesInvoice_PageIndexChanged(object sender, EventArgs e)
        {
            // LoadAllSalesInvoices();
        }

        protected void rdioFilterView_SelectedIndexChanged(object sender, EventArgs e)
        {
            ClearSerchOption();

            if (rdioFilterView.SelectedValue == "CANCELLED")
            {
                btnPreviewSelectedSIForcancel.Enabled = false;
            }
            else
            {
                btnPreviewSelectedSIForcancel.Enabled = true;
            }

            //  chkSeleckAll.Checked = false;
            if (txtSearchDR.Text != String.Empty)
            {
                SIManager.SearchSalesInvoiceList(SqlDataSourceSalesInvoice, (txtSearchDR.Text),
                    rdioFilterView.SelectedItem.Text, rdioSearchOption.SelectedValue);
                gvSalesInvoice.DataBind();
            }
            else
            {
                SIManager.FilterSalesInvoiceList(SqlDataSourceSalesInvoice, (rdioFilterView.SelectedValue));
                gvSalesInvoice.DataBind();
            }
        }

        protected void btnYesCancelSelectedDR_Click(object sender, EventArgs e)
        {
            try
            {
                List<SalesInvoice> list = GetSalesInvoiceToBeCancelled();
                SIManager.UpdateSalesInvoiceCancelledStatus(list);
                gvSalesInvoice.DataBind();
            }
            catch (Exception)
            {
                // throw;
            }
        }

        protected void imgBtnSearchDR_Click(object sender, ImageClickEventArgs e)
        {
            ClearSerchOption();

            //  chkSeleckAll.Checked = false;
            hfIsAdvanceSearch.Value = "NO";
            if (rdioFilterView.SelectedValue != string.Empty)
            {
                if (txtSearchDR.Text != String.Empty)
                {
                    SIManager.SearchSalesInvoiceList(SqlDataSourceSalesInvoice, (txtSearchDR.Text), rdioFilterView.SelectedValue,
                        rdioSearchOption.SelectedValue);
                    gvSalesInvoice.DataBind();
                }
                else
                {
                    SIManager.FilterSalesInvoiceList(SqlDataSourceSalesInvoice, (rdioFilterView.SelectedValue));
                    gvSalesInvoice.DataBind();
                }
            }
            else
            {
                if (txtSearchDR.Text != String.Empty)
                {
                    SIManager.SearchSalesInvoiceList(SqlDataSourceSalesInvoice, (txtSearchDR.Text), (rdioFilterView.SelectedValue),
                        rdioSearchOption.SelectedValue);
                    gvSalesInvoice.DataBind();
                }
                else
                {
                    SIManager.FilterSalesInvoiceList(SqlDataSourceSalesInvoice, (rdioFilterView.SelectedValue));
                    gvSalesInvoice.DataBind();
                }
            }
        }

        protected void gvSalesInvoice_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            //  chkSeleckAll.Checked = false;
            if (this.txtDateSeachFrom.Text != string.Empty)
            {
                btnAdvanceSearch_Click(sender, e);
            }
            else
            {
                if (rdioFilterView.SelectedValue != string.Empty)
                {
                    if (txtSearchDR.Text != String.Empty)
                    {
                        SIManager.SearchSalesInvoiceList(SqlDataSourceSalesInvoice, (txtSearchDR.Text), rdioFilterView.SelectedValue,
                            rdioSearchOption.SelectedValue);
                        gvSalesInvoice.DataBind();
                    }
                    else
                    {
                        SIManager.FilterSalesInvoiceList(SqlDataSourceSalesInvoice, (rdioFilterView.SelectedValue));
                        gvSalesInvoice.DataBind();
                    }
                }
                else
                {
                    if (txtSearchDR.Text != String.Empty)
                    {
                        SIManager.SearchSalesInvoiceList(SqlDataSourceSalesInvoice, (txtSearchDR.Text), (rdioFilterView.SelectedValue),
                            rdioSearchOption.SelectedValue);
                        gvSalesInvoice.DataBind();
                    }
                    else
                    {
                        SIManager.FilterSalesInvoiceList(SqlDataSourceSalesInvoice, (rdioFilterView.SelectedValue));
                        gvSalesInvoice.DataBind();
                    }
                }
            }
        }

        protected void btnAdvanceSearch_Click(object sender, EventArgs e)
        {
            try
            {
                hfIsAdvanceSearch.Value = "YES";
                SIManager.AdvanceSearch(SqlDataSourceSalesInvoice, txtSearchDR.Text, rdioFilterView.SelectedValue,
                    DateTime.Parse(txtDateSeachFrom.Text), DateTime.Parse(txtDateSeachTo.Text), txtSearchCompany.Text);
                gvSalesInvoice.DataBind();
            }
            catch (Exception)
            {
                // throw;
            }
        }

        protected void chkEnableCompanySearch_CheckedChanged(object sender, EventArgs e)
        {
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

        protected void chkSeleckAll_CheckedChanged(object sender, EventArgs e)
        {
            //if (chkSeleckAll.Checked == true)
            //{
            //    foreach (GridViewRow row in this.gvSalesInvoice.Rows)
            //    {
            //        CheckBox ck = ((CheckBox)row.FindControl("chkID"));
            //        ck.Checked = true;
            //    }
            //}
            //else
            //{
            //    foreach (GridViewRow row in this.gvSalesInvoice.Rows)
            //    {
            //        CheckBox ck = ((CheckBox)row.FindControl("chkID"));
            //        ck.Checked = false;
            //    }
            //}
        }

        protected void gvSalesInvoice_Sorting(object sender, GridViewSortEventArgs e)
        {
            // chkSeleckAll.Checked = false;
            if (this.txtDateSeachFrom.Text != string.Empty)
            {
                btnAdvanceSearch_Click(sender, e);
            }
            else
            {
                if (rdioFilterView.SelectedValue != string.Empty)
                {
                    if (txtSearchDR.Text != String.Empty)
                    {
                        SIManager.SearchSalesInvoiceList(SqlDataSourceSalesInvoice, (txtSearchDR.Text), rdioFilterView.SelectedValue,
                            rdioSearchOption.SelectedValue);
                        gvSalesInvoice.DataBind();
                    }
                    else
                    {
                        SIManager.FilterSalesInvoiceList(SqlDataSourceSalesInvoice, (rdioFilterView.SelectedValue));
                        gvSalesInvoice.DataBind();
                    }
                }
                else
                {
                    if (txtSearchDR.Text != String.Empty)
                    {
                        SIManager.SearchSalesInvoiceList(SqlDataSourceSalesInvoice, (txtSearchDR.Text), (rdioFilterView.SelectedValue),
                            rdioSearchOption.SelectedValue);
                        gvSalesInvoice.DataBind();
                    }
                    else
                    {
                        SIManager.FilterSalesInvoiceList(SqlDataSourceSalesInvoice, (rdioFilterView.SelectedValue));
                        gvSalesInvoice.DataBind();
                    }
                }
            }
        }

        private void ClearSerchOption()
        {
            txtDateSeachFrom.Text = string.Empty;
            txtDateSeachTo.Text = string.Empty;
            txtSearchCompany.Text = string.Empty;
        }
    }
}