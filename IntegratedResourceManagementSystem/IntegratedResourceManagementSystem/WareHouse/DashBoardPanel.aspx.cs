using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace IntegratedResourceManagementSystem.WareHouse
{
    public partial class DashBoardPanel : System.Web.UI.Page
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
                else
                {
                    if (Session["SHOW_CLASSIC_WINDOW"] == "FALSE")
                    {
                        Response.Write("<script> window.open('" + System.Configuration.ConfigurationManager.AppSettings["RemotePage"] + "','_blank',fullscreen='yes'); </script>");
                        Session["SHOW_CLASSIC_WINDOW"] = "TRUE";
                    }
                }
            }
        }
    }
}