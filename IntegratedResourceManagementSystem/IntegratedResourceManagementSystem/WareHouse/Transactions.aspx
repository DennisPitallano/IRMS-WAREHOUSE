<%@ Page Title="" Language="C#" MasterPageFile="~/WareHouse/WareHouse.Master" AutoEventWireup="true" CodeBehind="Transactions.aspx.cs" Inherits="IntegratedResourceManagementSystem.WareHouse.Transactions" %>
<%@ Register Src="~/WareHouse/controls/CancelTransactionMenu.ascx" TagName ="menu" TagPrefix ="uc"%>
<%@ Register Src ="~/WareHouse/controls/TransactionsStatus.ascx" TagName ="transaction_status" TagPrefix ="uc" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../Styles/marketing-item-master.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div style=" height :430px;">
    <asp:PlaceHolder ID="pholderMenu" runat="server">
        <uc:menu ID ="transaction_menu" runat="server" ></uc:menu>
    </asp:PlaceHolder>
    </div>
    <div style ="margin-top:10px; margin-bottom: 20px;">
    <%--<uc:transaction_status ID ="transaction_status" runat="server">
    </uc:transaction_status>--%>
    </div>
</asp:Content>
