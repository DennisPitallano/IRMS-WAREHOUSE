using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using IRMS.Entities;
using IRMS.BusinessLogic.Manager;
using IRMS.ObjectModel;
using IRMS.Components;

namespace IntegratedResourceManagementSystem.WareHouse
{
    public partial class AddForwarderCustomers : System.Web.UI.Page
    {
        public List<Customer> SelectedCustomers = new List<Customer>();
        private ForwarderManager FM = new ForwarderManager();
        private Forwarder FORWARDER = new Forwarder();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!this.IsPostBack)
            {
                FORWARDER = PreviousPage.FORWARDER;
                hfForwarderRecordNumber.Value = FORWARDER.RecordNumber.ToString();
                fForwarder1.ForwarderAddress  = FORWARDER.ForwarderAddress;
                fForwarder1.ForwarderContact = FORWARDER.ForwarderContact;
                fForwarder1.ForwarderName = FORWARDER.ForwarderName;
                txtSearch.Focus();
            }
            txtSearch.Focus();
        }

        protected void btnAddtoList_Click(object sender, EventArgs e)
        {
            foreach (GridViewRow row in gvSelectedCustomers.Rows)
            {
                Customer cust = new Customer();
                cust = FM.GetCustomerByCustomerId(long.Parse(row.Cells[0].Text));
                SelectedCustomers.Add(cust);
            }

            foreach (GridViewRow row in gvCustomers.Rows)
            {
                CheckBox chkCustomer = (CheckBox)row.FindControl("chkCustomer");
                if (chkCustomer.Checked == true)
                {
                    Customer NEW_CUSTOMER = new Customer();
                    //  Image imgID = (Image)row.FindControl("imgID");
                    NEW_CUSTOMER = FM.GetCustomerByCustomerId(long.Parse(chkCustomer.ToolTip));
                    SelectedCustomers.Add(NEW_CUSTOMER);
                }

            }
            
            gvSelectedCustomers.DataSource = SelectedCustomers;
            gvSelectedCustomers.DataBind();
            gvCustomers.SelectRow(-1);
        }

      
        protected void btnContinueSave_Click(object sender, EventArgs e)
        {
            List<ForwarderCustomer> ForwarderCustomers = new List<ForwarderCustomer>();
            long forwarder = long.Parse(hfForwarderRecordNumber.Value);

            foreach (GridViewRow row in gvSelectedCustomers.Rows)
            {
                CheckBox chk = (CheckBox)row.FindControl("chkSelectedCustomer");
                if (chk.Checked == true)
                {
                    ForwarderCustomer fc = new ForwarderCustomer();
                    fc.ForwarderNumber = forwarder;
                    fc.CustomerNumber = long.Parse(chk.ToolTip);
                    ForwarderCustomers.Add(fc);
                }
            }
            FM.SaveForwarderCustomers(ForwarderCustomers);
            Redirector.Redirect("~/WareHouse/ForwarderManagementPanel.aspx");
        }

        protected void btnYes_Click(object sender, EventArgs e)
        {
            btnContinueSave_Click(sender, e);
        }

        protected void btnBack_Click(object sender, EventArgs e)
        {
            Redirector.Redirect("~/WareHouse/ForwarderManagementPanel.aspx");
        }

        protected void btnResetSelection_Click(object sender, EventArgs e)
        {
            gvSelectedCustomers.DataSource = SelectedCustomers;
            gvSelectedCustomers.DataBind();
        }

        protected void txtSearch_TextChanged(object sender, EventArgs e)
        {
            FM.SearchCustomer(SqlDataSourceCustomers, txtSearch.Text);
            gvCustomers.DataBind();
            chkSeleckAll.Checked = false;
        }

        protected void chkSeleckAll_CheckedChanged(object sender, EventArgs e)
        {
            if (chkSeleckAll.Checked == true)
            {
                foreach (GridViewRow row in this.gvCustomers.Rows)
                {
                    CheckBox ck = ((CheckBox)row.FindControl("chkCustomer"));
                    ck.Checked = true;
                }
            }
            else
            {
                foreach (GridViewRow row in this.gvCustomers.Rows)
                {
                    CheckBox ck = ((CheckBox)row.FindControl("chkCustomer"));
                    ck.Checked = false;
                }
            }
        }
    }
}