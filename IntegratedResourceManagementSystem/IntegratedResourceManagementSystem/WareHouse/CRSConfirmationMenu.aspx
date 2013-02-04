<%@ Page Title="" Language="C#" MasterPageFile="~/WareHouse/WareHouse.Master" AutoEventWireup="true" CodeBehind="CRSConfirmationMenu.aspx.cs" Inherits="IntegratedResourceManagementSystem.WareHouse.CRSConfirmationMenu" %>
<%@ Register Src ="~/WareHouse/controls/CRSMenu.ascx" TagName ="crsmenu" TagPrefix ="uc" %>
<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
<div style ="height:470px;"> 
    <asp:PlaceHolder ID="plHolderMenu" runat="server">
        <uc:crsmenu ID="crs_menu" runat="server" />
    </asp:PlaceHolder>
    </div>
</asp:Content>
