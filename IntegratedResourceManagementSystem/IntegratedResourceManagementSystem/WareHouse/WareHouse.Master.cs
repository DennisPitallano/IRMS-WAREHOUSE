using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Configuration;

namespace IntegratedResourceManagementSystem.WareHouse
{
    public partial class WareHouse : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //this.lblVersion.Text = ConfigurationManager.AppSettings["Version"];
            //if (!this.IsPostBack)
            //{
            //    if (Session.Count == 0)
            //    {
            //        lblUser.Text = "NONE";
            //        lnkbtnLogin.Text = "Log In";

            //    }
            //    else
            //    {
            //        lblUser.Text = Session["USER_ID"].ToString().ToUpper();
            //        lnkbtnLogin.Text = "Log Out";
            //    }
            //}
        }

        protected void lnkbtnLogin_Click(object sender, EventArgs e)
        {
            //if (lnkbtnLogin.Text == "Log Out")
            //{
            //    Session.Abandon();
            //    lblUser.Text = "NONE";
            //    lnkbtnLogin.Text = "Log In";
            //    Response.Redirect("~/Warehouse/Login.aspx");
            //}
        }
    }
}