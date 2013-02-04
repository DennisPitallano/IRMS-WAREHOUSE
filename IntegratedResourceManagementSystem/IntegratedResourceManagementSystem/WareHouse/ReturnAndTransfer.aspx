<%@ Page Title="" Language="C#" MasterPageFile="~/WareHouse/WareHouse.Master" AutoEventWireup="true" CodeBehind="ReturnAndTransfer.aspx.cs" Inherits="IntegratedResourceManagementSystem.WareHouse.ReturnAndTransfer" %>

<%@ Register Src ="~/WareHouse/controls/ReturnAndTransferMenu.ascx" TagName="return_and_transfer_menu" TagPrefix ="dc" %>
<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <link href="controls/styles/memo-menu.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div style ="min-height:500px;">
    <asp:PlaceHolder ID ="phlderMarkReturnAndTransferMenu" runat ="server">
        <dc:return_and_transfer_menu ID ="returnAndTransferMenu" runat="server" />
    </asp:PlaceHolder>
</div>
</asp:Content>
