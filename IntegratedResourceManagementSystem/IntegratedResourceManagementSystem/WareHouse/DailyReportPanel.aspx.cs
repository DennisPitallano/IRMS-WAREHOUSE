using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using IRMS.Components;
using IRMS.BusinessLogic.Manager;
using IRMS.ObjectModel;

namespace IntegratedResourceManagementSystem.WareHouse
{
    public partial class DailyReportPanel : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (System.Configuration.ConfigurationManager.AppSettings["Integration"] == "YES")
            {
                if (Session.Count == 0)
                {
                    Response.Redirect("~/WareHouse/Login.aspx");
                    return;
                }
            }
            if (!this.IsPostBack)
            {

            }
        }

        protected void btnPrint_Click(object sender, EventArgs e)
        {
            if (rdioListReportSelector.SelectedIndex == 0)
            {

                if (rblist.SelectedItem != null)
                {

                    if (txtAsOfDate.Text == string.Empty)
                    {
                        lblError.Text = "DATE REQUIRED!!!";
                        pnlError.Visible = true;
                        return;
                    }
                    else
                    {
                        pnlError.Visible = false;
                    }
                    lblError.Text = "REPORT TYPE REQUIRED!!!";
                    pnlError.Visible = false;
                    Redirector.Redirect("~/Reports/ReportForms/DailyReport.aspx?datefrom=" + txtAsOfDate.Text + "&dept=Warehouse&rptname=" + rblist.SelectedValue);
                }
                else
                {
                    pnlError.Visible = true;
                    return;
                }

            }
            else
            {

                if (rblist1.SelectedItem != null)
                {
                    if (rblist1.SelectedValue == "OverAllComParativeYearly" || rblist1.SelectedValue == "OverAllComParativeYearlyperBrand")
                    {
                        if (txtFrom.Text == string.Empty)
                        {
                            lblError.Text = "DATE REQUIRED!!!";
                            pnlError.Visible = true;
                            return;
                        }
                        else if (txtTo.Text == string.Empty)
                        {
                            lblError.Text = "DATE REQUIRED!!!";
                            pnlError.Visible = true;
                            return;
                        }
                        else
                        {
                            pnlError.Visible = false;
                        }
                    }
                    else if (rblist1.SelectedValue == "StockCard")
                    {
                        if (txtStyle.Text == string.Empty)
                        {
                            lblError.Text = "STYLE NO. REQUIRED!!!";
                            pnlError.Visible = true;
                            return;
                        }
                        else
                        {
                            pnlError.Visible = false;
                        }
                    }
                    else
                    {
                        pnlError.Visible = false;
                    }
                    lblError.Text = "REPORT TYPE REQUIRED!!!";
                    pnlError.Visible = false;
                    Redirector.Redirect("~/Reports/ReportForms/DailyReport.aspx?datefrom=" + txtAsOfDate.Text + "&dept=Warehouse&rptname=" + rblist1.SelectedValue + "&brandname=" + dlBrandName.SelectedValue + "&FromDate=" + txtFrom.Text + "&ToDate=" + txtTo.Text + "&StyleNo=" + txtStyle.Text + "");
                }
                else
                {
                    pnlError.Visible = true;
                    return;
                }

            }
        }

        protected void rdioListReportSelector_SelectedIndexChanged(object sender, EventArgs e)
        {
            pnlError.Visible = false;
            if (rdioListReportSelector.SelectedIndex != 0)
            {
                mvReportSelector.ActiveViewIndex = 1;
            }
            else
            {
                mvReportSelector.ActiveViewIndex = 0;
            }
        }

        #region "Popup for STYLES"

        PulloutHeaderManager POHeadManager = new PulloutHeaderManager();
        protected void gvStyleList_SelectedIndexChanged(object sender, EventArgs e)
        {
            btnStyleBrowse_ModalPopupExtender.Show();
        }

        protected void gvStyleList_PageIndexChanged(object sender, EventArgs e)
        {
            btnStyleBrowse_ModalPopupExtender.Show();
        }

        protected void gvStyleList_Sorted(object sender, EventArgs e)
        {
            if (txtSearchStyle.Text != string.Empty)
            {
                POHeadManager.SearchStyleDataSource(SqlDataSourceStyle, txtSearchStyle.Text);
                gvStyleList.DataBind();
            }
            btnStyleBrowse_ModalPopupExtender.Show();
        }

        protected void gvStyleList_PageIndexChanging(object sender, EventArgs e)
        {
            if (txtSearchStyle.Text != string.Empty)
            {
                POHeadManager.SearchStyleDataSource(SqlDataSourceStyle, txtSearchStyle.Text);
                gvStyleList.DataBind();
            }
            btnStyleBrowse_ModalPopupExtender.Show();
        }

        protected void imgBtnSearchStyle_Click(object sender, ImageClickEventArgs e)
        {
            if (txtSearchStyle.Text != string.Empty)
            {
                POHeadManager.SearchStyleDataSource(SqlDataSourceStyle, txtSearchStyle.Text);
                gvStyleList.DataBind();
            }
            btnStyleBrowse_ModalPopupExtender.Show();
        }

        protected void btnSelectStyle_Click(object sender, EventArgs e)
        {
            txtStyle.Text = gvStyleList.SelectedRow.Cells[2].Text;
        }

        #endregion
    }
}