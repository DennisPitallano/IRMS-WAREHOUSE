<%@ Page Title="" Language="C#" MasterPageFile="~/WareHouse/WareHouse.Master" AutoEventWireup="true" CodeBehind="DeliveriesMenu.aspx.cs" Inherits="IntegratedResourceManagementSystem.WareHouse.DeliveriesMenu" %>
<%@ Register Src="~/WareHouse/controls/DeliveriesMenu.ascx" TagName="deleivery_menu" TagPrefix="dc" %>
<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
  <div style=" height :430px;">
    <asp:PlaceHolder ID="pholderMenu" runat="server">
      <dc:deleivery_menu  ID="deliveryMenu" runat="server" />
    </asp:PlaceHolder>
    </div>
    <div style ="margin-top:10px; margin-bottom: 20px;">
    </div>
</asp:Content>
