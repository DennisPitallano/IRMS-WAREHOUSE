<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="TransactionsStatus.ascx.cs" Inherits="IntegratedResourceManagementSystem.WareHouse.controls.TransactionsStatus" %>
<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>
<%@ OutputCache Duration="3600" VaryByParam ="*" %>
<style type ="text/css" >
    .summary_title
    {
       font-family:Verdana;
       font-size:12px;
       width:270px;
       margin:10px 0px 5px 0px;
    }
    .summary_details
    {
      font-family:Verdana;
       font-size:11px;
       margin-left:10px;
       text-align:right;
    }
</style>
<div> 
    <asp:Image ID="Image1" runat="server" Height="18px" ImageAlign="AbsMiddle" 
        ImageUrl="~/Resources/summary.png" />TRANSACTIONS SUMMARY</div>
<div class ="summary_title">
  SALES INVOICE SUMMARY: <asp:Label ID="lblTotalSalesInvoice" 
        runat="server" Text="Label" Font-Names="Verdana" Font-Size="12px" 
        ForeColor="#CC3300"></asp:Label>
  <table style="width: 100%;">
    <tr>
      <td class ="summary_details">
        TOTAL POSTED:
      </td>
      <td>
        <asp:Label ID="lblTotaPostedSalesInvoice" runat="server" Text="Label" 
              Font-Italic="True" Font-Names="Verdana" Font-Size="11px" ForeColor="#CC6600"></asp:Label>
      </td>
      <td>
        &nbsp;
      </td>
    </tr>
    <tr>
      <td class ="summary_details">
        TOTAL UNPOSTED: 
      </td>
      <td>
        <asp:Label ID="lblTotalUnpostedSalesInvoice" runat="server" Text="Label" 
              Font-Italic="True" Font-Names="Verdana" Font-Size="11px" ForeColor="#CC6600"></asp:Label>
      </td>
      <td>
        &nbsp;
      </td>
    </tr>
    <tr>
      <td class ="summary_details">
        TOTAL CANCELLED:
      </td>
      <td>
        <asp:Label ID="lblTotalCancelledSalesInvoice" runat="server" Text="Label" 
              Font-Italic="True" Font-Names="Verdana" Font-Size="11px" ForeColor="#CC6600"></asp:Label>
      </td>
      <td>
        &nbsp;
      </td>
    </tr>
  </table>
</div> 
<div class ="summary_title">
  TOTAL DELIVERIES: <asp:Label ID="lblTotalDeliveries" runat="server" 
        Text="Label" Font-Names="Verdana" ForeColor="#CC3300"></asp:Label>
   <table style="width: 100%;">
    <tr>
      <td class ="summary_details">
        TOTAL POSTED:
      </td>
      <td>
       <asp:Label ID="lblTotalDeliveriesPosted" runat="server" Text="Label" 
              Font-Italic="True" Font-Names="Verdana" Font-Size="11px" ForeColor="#CC6600"></asp:Label>
      </td>
      <td>
        &nbsp;
      </td>
    </tr>
    <tr>
      <td class ="summary_details">
        TOTAL UNPOSTED: 
      </td>
      <td>
        <asp:Label ID="lblTotalDeliveriesUnposted" runat="server" Text="Label" 
              Font-Italic="True" Font-Names="Verdana" Font-Size="11px" ForeColor="#CC6600"></asp:Label>
      </td>
      <td>
        &nbsp;
      </td>
    </tr>
    <tr>
      <td class ="summary_details">
        TOTAL CANCELLED:
      </td>
      <td>
       <asp:Label ID="lblTotalCancelledDeliveries" runat="server" Text="Label" 
              Font-Italic="True" Font-Names="Verdana" Font-Size="11px" ForeColor="#CC6600"></asp:Label>
      </td>
      <td>
        &nbsp;
      </td>
    </tr>
  </table>
</div>
<div class ="summary_title">
  TOTAL CRS: <asp:Label ID="lblTotalCRS" runat="server" Text="Label" 
        Font-Names="Verdana" ForeColor="#CC3300"></asp:Label>
   <table style="width: 100%;">
    <tr>
      <td class ="summary_details">
        TOTAL POSTED:
      </td>
      <td>
      <asp:Label ID="lblTotalPostedCRS" runat="server" Text="Label" Font-Italic="True" 
              Font-Names="Verdana" Font-Size="11px" ForeColor="#CC6600"></asp:Label>
      </td>
      <td>
        &nbsp;
      </td>
    </tr>
    <tr>
      <td class ="summary_details">
        TOTAL UNPOSTED: 
      </td>
      <td>
       <asp:Label ID="lblTotalUnpostedCRS" runat="server" Text="Label" Font-Italic="True" 
              Font-Names="Verdana" Font-Size="11px" ForeColor="#CC6600"></asp:Label>
      </td>
      <td>
        &nbsp;
      </td>
    </tr>
    <tr>
      <td class ="summary_details">
        TOTAL CANCELLED:
      </td>
      <td>
        <asp:Label ID="lblTotalCancelledCRS" runat="server" Text="Label" 
              Font-Italic="True" Font-Names="Verdana" Font-Size="11px" ForeColor="#CC6600"></asp:Label>
      </td>
      <td>
        &nbsp;
      </td>
    </tr>
  </table>
</div>
<div>
</div>