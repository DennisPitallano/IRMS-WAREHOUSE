using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using IRMS.ObjectModel;
using System.Configuration;
using IRMS.BusinessLogic.Manager;
using IRMS.Components;

namespace IntegratedResourceManagementSystem.Accounting
{
    public partial class Login : System.Web.UI.Page
    {
        private UserManager UM = new UserManager();
        protected void Page_Load(object sender, EventArgs e)
        {
            
        }

        protected void btnLogIn_Click(object sender, EventArgs e)
        {
            UsersClass user = new UsersClass();
            lblErrorMessage.Text = string.Empty;
            user = UM.FindUser(txtUsername.Text);
            if (user == null)
            {
                pnlError.Visible = true;
                lblErrorMessage.Text = "ERROR : USER NAME DOESN'T EXIST!";
                return;
            }

            if (UM.ConfirmPassword(txtPassword.Text) == false)
            {
                pnlError.Visible = true;
                lblErrorMessage.Text = "ERROR :WRONG PASSWORD!";
                return;
            }

            Session["USER_ID"] = txtUsername.Text;
            Session["CURRENT_DATE"] = DateTime.Now;
            Session["NET_SESSION_ID"] = Session.SessionID;
            Session["CLASSIC_SESSION_ID"] = "";
            Session["SHOW_CLASSIC_WINDOW"] = "FALSE";
            Session.Timeout = 30;

            SendToBridge(ref user);
           // Redirector.Redirect("~/Accounting/DashBoardPanel.aspx");
        }
        private void SendToBridge(ref UsersClass user)
        {
            string sBridgeLocation = ConfigurationManager.AppSettings["BridgeLocation"];
            string sDefaultPage = ConfigurationManager.AppSettings["DefaultPage"];

            //string sLocation = ConfigurationManager.AppSettings["BridgeLocation"];
            //Response.Write("<form name='bridge' action='http://irms-svr:82/irmsbridge.asp' method='POST' Target='_blank'>");
            Response.Write("<form name='bridge' action='" + sBridgeLocation + "' method='POST'>");
            Response.Write("<input type=hidden name='sessionid' value='" + Session.SessionID + "' >");
            Response.Write("<input type=hidden name='unameid' value='" +  this.txtUsername.Text + "' >");
            Response.Write("<input type=hidden name='ulevelid' value='" + user.UserLevelID + "' >");
            Response.Write("<input type=hidden name='udeptid' value='" + user.DeptID + "' >");
            Response.Write("<input type=hidden name='defaultpage' value='" + sDefaultPage + "' >");
            Response.Write("</form>");
            Response.Write("<script>window.document.bridge.submit();</script>");
            Response.End();
        }

        private void ResponseMessage(string sMess)
        {
            //this.Response.Write("<script language=\"javascript\">alert('" + sMess + "');</script>");         
            ClientScript.RegisterStartupScript(this.GetType(), "myalert", "alert('" + sMess + "');", true);
        }
    }
}