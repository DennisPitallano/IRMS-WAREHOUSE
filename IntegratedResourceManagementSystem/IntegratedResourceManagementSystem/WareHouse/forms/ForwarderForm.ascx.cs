using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using IRMS.ObjectModel;

namespace IntegratedResourceManagementSystem.WareHouse.forms
{
    public partial class ForwarderForm : System.Web.UI.UserControl
    {
        public string ForwarderName
        {
            get
            {
                return txtForwarderName.Text;
            }
            set
            {
                txtForwarderName.Text = value;
            }
        }

        public string ForwarderAddress
        {
            get
            {
                return txtForwarderAddress.Text;
            }
            set
            {
                txtForwarderAddress.Text = value;
            }
        }

        public string ForwarderContact
        {
            get
            {
                return txtContactNumber.Text;
            }
            set
            {
                txtContactNumber.Text = value;
            }
        }

        public Forwarder Forwarder
        {
            get
            {
                return new Forwarder{
                    ForwarderName = ForwarderName,
                    ForwarderAddress = ForwarderAddress ,
                    ForwarderContact = ForwarderContact,
                    DateRecorded = DateTime.Now
                };
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
        }
    }
}