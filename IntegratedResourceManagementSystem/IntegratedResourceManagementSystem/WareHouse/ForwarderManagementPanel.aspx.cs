using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using IRMS.ObjectModel;
using IRMS.BusinessLogic.Manager;
using IRMS.Components;

namespace IntegratedResourceManagementSystem.WareHouse
{
    public partial class ForwarderManagementPanel : System.Web.UI.Page
    {
        ForwarderManager FM = new ForwarderManager();
        public Forwarder FORWARDER { get; set; }
        BrandManager BrandManager = new BrandManager();

        protected void Page_Init(object sender, EventArgs e)
        {
            InitializeBrandList();
        }

        private void InitializeBrandList()
        {
            DDLBrands.Items.Clear();
            DDLBrands.Items.Add(new ListItem("ALL", "ALL"));
            foreach (var brand in BrandManager.Brands())
            {
                DDLBrands.Items.Add(new ListItem(brand.BrandDescription, brand.BrandDescription));
            }
        }

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
                txtSearch.Focus();
                fforwarder_update.ForwarderName = "NONE";
            }
            txtSearch.Focus();
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            FM.SearchForwarder(SqlDataSourceForwarder, txtSearch.Text);
            gvForwarders.DataBind();
        }

        protected void btnSaveUpdate_Click(object sender, EventArgs e)
        {
          
            Image imgRecordNumber = (Image)gvForwarders.SelectedRow.FindControl("imgRecordNumber");
            Forwarder FORWARDER = FM.GetForwarderByKey(long.Parse(imgRecordNumber.AlternateText));
            FORWARDER.ForwarderName  = fforwarder_update.ForwarderName;
            FORWARDER.ForwarderContact = fforwarder_update.ForwarderContact;
            FORWARDER.ForwarderAddress = fforwarder_update.ForwarderAddress;
            FM.Save(FORWARDER);
            gvForwarders.DataBind();
        }

        protected void btnSaveForwarder_Click(object sender, EventArgs e)
        {

            //Forwarder FORWARDER = fforwarder.Forwarder;
            //FM.Save(FORWARDER);
            //gvForwarders.DataBind();
        }

        protected void btnYes_Click(object sender, EventArgs e)
        {
            Image imgRecordNumber = (Image)gvForwarders.SelectedRow.FindControl("imgRecordNumber");
            Forwarder FORWARDER = FM.GetForwarderByKey(long.Parse(imgRecordNumber.AlternateText));
            FM.Delete(FORWARDER);
            gvForwarders.DataBind();
        }

        protected void gvForwarders_SelectedIndexChanged(object sender, EventArgs e)
        {
            Image imgRecordNumber = (Image)gvForwarders.SelectedRow.FindControl("imgRecordNumber");
            hfRecordNo.Value = imgRecordNumber.AlternateText;
           
            Forwarder FORWARDER = FM.GetForwarderByKey(long.Parse(imgRecordNumber.AlternateText));
            fforwarder_update.ForwarderName = FORWARDER.ForwarderName;
            fforwarder_update.ForwarderAddress = FORWARDER.ForwarderAddress;
            fforwarder_update.ForwarderContact = FORWARDER.ForwarderContact;
            lblForwarder.Text = FORWARDER.ForwarderName;
            lblFromForwarder.Text = FORWARDER.ForwarderName;
            lblForwarderToDelete.Text ="Delete forwarder "+ FORWARDER.ForwarderName +"?";
            pnlUpdateMessage.Visible = false;
        }

        protected void gvCustomers_SelectedIndexChanged(object sender, EventArgs e)
        {
            lblCustomerName.Text = gvCustomers.SelectedRow.Cells[2].Text;
            lblOutletTobeDeleted.Text = "Delete " + gvCustomers.SelectedRow.Cells[2].Text + "?";
            btnViewCustomers_ModalPopupExtender.Show();
           
        }

        protected void gvCustomers_Sorting(object sender, GridViewSortEventArgs e)
        {
             FM.SearchForwarderCustomer(SqlDataSourceForwarderCustomers, txtSearchCustomer.Text, int.Parse(hfRecordNo.Value), DDLBrands.SelectedValue);
            btnViewCustomers_ModalPopupExtender.Show();
        }

        protected void btnAddCustomer_Click(object sender, EventArgs e)
        {
              Image imgRecordNumber = (Image)gvForwarders.SelectedRow.FindControl("imgRecordNumber");
              FORWARDER = FM.GetForwarderByKey(long.Parse(imgRecordNumber.AlternateText));
        }

        protected void btnRemoveCustomer_Click(object sender, EventArgs e)
        {
             Image imgRecordNumber = (Image)gvCustomers.SelectedRow.FindControl("imgCustomer");
             ForwarderCustomer fc = FM.GetForwarderCustomerByID(long.Parse(imgRecordNumber.AlternateText));
             FM.DeleteCustomerForwarder(fc);
             gvCustomers.DataBind();
             btnViewCustomers_ModalPopupExtender.Show();
        }

        protected void btnConfirmRemoveCustomerYes_Click(object sender, EventArgs e)
        {
            btnRemoveCustomer_Click(sender, e);
        }

        protected void btnChangeSave_Click(object sender, EventArgs e)
        {
             Image imgRecordNumber = (Image)gvCustomers.SelectedRow.FindControl("imgCustomer");
            ForwarderCustomer FC = new ForwarderCustomer();
            FC = FM.GetForwarderCustomerByID(long.Parse(imgRecordNumber.AlternateText));
            FC.ForwarderNumber = long.Parse(dlForwarders.SelectedValue);
            FM.SaveForwarderCustomer(FC);
            gvCustomers.DataBind();
            btnViewCustomers_ModalPopupExtender.Show();
        }

        protected void btnNewBrand_Click(object sender, EventArgs e)
        {
            Redirector.Redirect("~/WareHouse/NewForwarderForm.aspx");
        }

        protected void gvCustomers_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            FM.SearchForwarderCustomer(SqlDataSourceForwarderCustomers, txtSearchCustomer.Text, int.Parse(hfRecordNo.Value), DDLBrands.SelectedValue);
            btnViewCustomers_ModalPopupExtender.Show();
        }

        protected void imgBtnSearch_Click(object sender, ImageClickEventArgs e)
        {

        }

        protected void ibtnSearchCustomerForwarder_Click(object sender, ImageClickEventArgs e)
        {
            FM.SearchForwarderCustomer(SqlDataSourceForwarderCustomers, txtSearchCustomer.Text, int.Parse(hfRecordNo.Value), DDLBrands.SelectedValue);
            btnViewCustomers_ModalPopupExtender.Show();
        }

        protected void txtSearchCustomer_TextChanged(object sender, EventArgs e)
        {
            FM.SearchForwarderCustomer(SqlDataSourceForwarderCustomers, txtSearchCustomer.Text, int.Parse(hfRecordNo.Value), DDLBrands.SelectedValue);
            btnViewCustomers_ModalPopupExtender.Show();
        }

        protected void DDLBrands_SelectedIndexChanged(object sender, EventArgs e)
        {
            FM.SearchForwarderCustomer(SqlDataSourceForwarderCustomers, txtSearchCustomer.Text, int.Parse(hfRecordNo.Value), DDLBrands.SelectedValue);
            btnViewCustomers_ModalPopupExtender.Show();
        }

        protected void gvOtherForwarder_SelectedIndexChanged(object sender, EventArgs e)
        {
            bool defaultVForwarder = bool.Parse (gvOtherForwarder.SelectedDataKey.Values[1].ToString());
            if (defaultVForwarder)
            {
                btnSetAsDefaultForwarder.Visible = false ;
            }
            else
            {
                btnSetAsDefaultForwarder.Visible = true;
            }
            btnOtherForwarder_ModalPopupExtender.Show();
            btnViewCustomers_ModalPopupExtender.Show();
        }

        protected void btnSetAsDefaultForwarder_Click(object sender, EventArgs e)
        {
            long  recordNumber = long.Parse(gvOtherForwarder.SelectedDataKey.Values[0].ToString());
            long customerNumber = long.Parse(gvOtherForwarder.SelectedDataKey.Values[2].ToString());
            long forwarderNumber = long.Parse(hfRecordNo.Value);
            bool isDefault = bool.Parse(gvOtherForwarder.SelectedDataKey.Values[1].ToString());
            ForwarderCustomer defaultForwarder= FM.GetDefaultForwarder(customerNumber);

            if (defaultForwarder!=null)
            {
                defaultForwarder.IsDefault = false;
                FM.SaveForwarderCustomer(defaultForwarder);
                ForwarderCustomer forwarderCustomer = new ForwarderCustomer
                {
                    RecordNumber = recordNumber,
                    IsDefault = true,
                    CustomerNumber = customerNumber,
                    ForwarderNumber = long.Parse(gvOtherForwarder.SelectedDataKey.Values[3].ToString())
                };
                FM.SaveForwarderCustomer(forwarderCustomer); 
            }
            else
            {
                ForwarderCustomer forwarderCustomer = new ForwarderCustomer
                {
                    RecordNumber = recordNumber,
                    IsDefault = true,
                    CustomerNumber = customerNumber,
                    ForwarderNumber = forwarderNumber
                };
                FM.SaveForwarderCustomer(forwarderCustomer); 
            }
                       
            gvOtherForwarder.DataBind();
            btnSetAsDefaultForwarder.Visible = false;
            btnOtherForwarder_ModalPopupExtender.Show();
            btnViewCustomers_ModalPopupExtender.Show();
        }
    }
}