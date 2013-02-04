using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using IRMS.ObjectModel;
using IRMS.Components;
using IRMS.BusinessLogic.Manager;
namespace IntegratedResourceManagementSystem.WareHouse.controls
{
    public partial class UserAccount : System.Web.UI.UserControl
    {
        //#region variables
        //MessageManager MSGManager = new MessageManager();
        //UserManager UserManager = new UserManager();
        //#endregion
        //protected void Page_Init(object sender, EventArgs e)
        //{
        //    if (Session["USER_ACCOUNT"] != null)
        //    {
        //        UsersClass userAccount = (UsersClass)Session["USER_ACCOUNT"];

        //        if(string.IsNullOrEmpty(userAccount.FullName)){
        //            lblName.Text = userAccount.Username;
        //        }else{
        //            lblName.Text = userAccount.FullName;
        //        }
        //        if (string.IsNullOrEmpty(userAccount.Avatar))
        //        {
        //           if(userAccount.Gender !="Male"){
        //               imgAvatar.ImageUrl = "~/Marketing/Marketing-Admin/user-images/femaleicon.png";
        //           }
        //           else
        //           {
        //               imgAvatar.ImageUrl = "~/Marketing/Marketing-Admin/user-images/maleicon.png";
        //           }
        //        }
        //        else
        //        {
        //            imgAvatar.ImageUrl = "~/Marketing/Marketing-Admin/user-images/"+userAccount.Avatar;
        //        }
        //         List <Message> Messages = MSGManager.GetMessagesToday(DateTime.Today,userAccount.ID);
        //        if (Messages.Count >0)
        //        {
        //            msgNotification.Visible = true;
        //            int msg_count = Messages.Count;
        //            if (msg_count > 1)
        //            {
        //                hpLinkNewMessage.Visible = true;
        //                hpLinkNewMessage.Text = Messages.Count + "New Messages";
        //                btnNewMessage.Visible = false;
        //            }
        //            else
        //            {
                      
        //                btnNewMessage.Visible = true;
        //                Message message = new Message();
        //                message = Messages.FirstOrDefault();
        //                UsersClass fromUser = UserManager.GetUserAccountByKey(message.FromUserId);
        //                LiteralControl objPanelText = pnlMsgContent.Controls[0] as LiteralControl;
        //                if (!string.IsNullOrEmpty(fromUser.FullName))
        //                {
        //                    objPanelText.Text = "FROM:" + fromUser.FullName + "<br />" + message.MessageContent;
        //                }
        //                else
        //                {
        //                    objPanelText.Text = "FROM:" + fromUser.Username + "<br />" + message.MessageContent ;
        //                }
        //                hpLinkNewMessage.Visible = false;
        //            }
        //            Session["MESSAGES"] = Messages;
        //            hpLinkNewMessage.NavigateUrl = "~/Marketing/ViewMessage.aspx";
        //        }
        //        else
        //        {
        //            msgNotification.Visible = false;
        //        }
        //    }
        //    else
        //    {
        //        Redirector.Redirect("~/Marketing/SessionExpired.aspx");
        //    }
        //}

        //protected void Page_Load(object sender, EventArgs e)
        //{

        //}

        protected void btnNewMessage_Click(object sender, EventArgs e)
        {
            //HiddenField1_ModalPopupExtender.Show();
        }

        protected void btnOMessageOK_Click(object sender, EventArgs e)
        {
            //try
            //{
            //    UsersClass userAccount = (UsersClass)Session["USER_ACCOUNT"];
            //    Message message = new Message();
            //    List<Message> Messages = MSGManager.GetMessagesToday(DateTime.Today, userAccount.ID);
            //    message = Messages.FirstOrDefault();
            //    message.Status = "READ";
            //    MSGManager.Save(message);
            //    btnNewMessage.Visible = false;
            //}
            //catch (Exception)
            //{
            //    Redirector.Redirect("~/Marketing/DashBoardPanel.aspx");
            //}
        }
    }
}