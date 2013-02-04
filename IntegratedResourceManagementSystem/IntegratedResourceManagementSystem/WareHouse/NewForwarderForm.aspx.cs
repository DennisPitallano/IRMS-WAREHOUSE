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
    public partial class NewForwarderForm : System.Web.UI.Page
    {
        public List<Customer> SelectedCustomers = new List<Customer>();
        private ForwarderManager FM = new ForwarderManager();
        protected void Page_Load(object sender, EventArgs e)
        {
            txtSearch.Focus();
        }

        protected void btnAddCustomers_Click(object sender, EventArgs e)
        {
            fForwarder1.ForwarderName = fforwarder.ForwarderName;
            fForwarder1.ForwarderContact = fforwarder.ForwarderContact;
            fForwarder1.ForwarderAddress = fforwarder.ForwarderAddress;
            mViewForwarder.ActiveViewIndex = 1;

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

        protected void btnBack_Click(object sender, EventArgs e)
        {
            mViewForwarder.ActiveViewIndex = 0;
        }

        protected void btnResetSelection_Click(object sender, EventArgs e)
        {
            gvSelectedCustomers.DataSource = SelectedCustomers;
            gvSelectedCustomers.DataBind();
        }

        protected void btnSaveForwarder_Click(object sender, EventArgs e)
        {
            SaveForwarder();
            Redirector.Redirect("~/WareHouse/ForwarderManagementPanel.aspx");
        }

        private void SaveForwarder()
        {
            Forwarder FORWARDER = fforwarder.Forwarder;
            FM.Save(FORWARDER);
        }

        protected void btnYes_Click(object sender, EventArgs e)
        {
            btnContinueSave_Click(sender, e);
        }

        protected void btnContinueSave_Click(object sender, EventArgs e)
        {
            List<ForwarderCustomer> ForwarderCustomers = new List<ForwarderCustomer>();
            SaveForwarder();
            long last_forwarder = FM.LastForwarder();

            foreach (GridViewRow row in gvSelectedCustomers.Rows)
            {
                CheckBox chk = (CheckBox)row.FindControl("chkSelectedCustomer");
                if (chk.Checked == true)
                {
                    ForwarderCustomer fc = new ForwarderCustomer();
                    fc.ForwarderNumber = last_forwarder;
                    fc.CustomerNumber = long.Parse(chk.ToolTip);
                    ForwarderCustomers.Add(fc);
                }
            }
            FM.SaveForwarderCustomers(ForwarderCustomers);
            Redirector.Redirect("~/WareHouse/ForwarderManagementPanel.aspx");
        }

        protected void btnConfirmYes_Click(object sender, EventArgs e)
        {
            btnSaveForwarder_Click(sender, e);
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