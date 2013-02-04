<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="DeliveriesMenu.ascx.cs" Inherits="IntegratedResourceManagementSystem.WareHouse.controls.DeliveriesMenu" %>

 <style type ="text/css" >
   .mnuIcon
	{
		width:80px;
		height:75px;
		background-image:url('../Resources/submenu.png');
		background-repeat:no-repeat;
		padding-left: 13px;
		padding-top: 3px;
	}
	 .mnuIcon:hover
	{
		background-image:url('../Resources/submenuh.png');
		background-repeat:no-repeat;
		padding-left: 17px;
		color: Gray;
	}
	  .lblMenu
	{
		text-decoration:none;
		color:#666666;
		cursor:pointer;
		text-align:center;
	}
	.lblMenu:hover
	{
		color:#376F00;
		border-bottom:1px;
		border-bottom-style: dashed;
	}
</style>
<div style ="margin-bottom: 10px;
	color: #CC6600;
	font-family: Verdana;
	 font-size: 16px;
	 font-weight: bold;
	 line-height: 22px;
	 text-shadow: 1px 1px 0px white;
	 font-variant:small-caps;">
	<asp:Image ID="Image1" runat="server" ImageUrl="~/Resources/transaction.png" 
		Height="22px" ImageAlign="Top" />
	<asp:Label ID="Label1" runat="server" Font-Bold="True" Font-Names="Verdana" 
		Font-Size="16px" ForeColor="#CC6600" Text="Panel Menu"></asp:Label>
</div>
<div style ="float:left; width: 100px; margin-right:5px;">
  <div class ="mnuIcon">
	<asp:ImageButton ID="imgBtnSalesInvoice" runat="server" 
					 ImageUrl="~/Resources/SALES.png" Height="32px" 
					 ToolTip="Manage Sales Invoice" 
					 PostBackUrl="~/WareHouse/SalesInvoicePanel.aspx" />
	<br />
	<asp:LinkButton ID="lnkSalesInvoice" runat="server" CssClass ="lblMenu" 
					Font-Names="Verdana" Font-Size="9px" 
					ToolTip="Manage Sales Invoice" Font-Bold="True"
					PostBackUrl="~/WareHouse/SalesInvoicePanel.aspx" 
		  ForeColor="#666666">
	  &nbsp;SALES INVOICE
	</asp:LinkButton>
  </div>
</div>
<div style ="float:left; width: 100px; margin-right:5px;">
  <div class ="mnuIcon">
	<asp:ImageButton ID="imgBtnGarmets" runat="server" 
					 ImageUrl="~/Resources/deliveries.png" Height="42px" 
					 ToolTip="Manage Deliveries" 
					 PostBackUrl="~/WareHouse/DeliveryReceiptPanel.aspx" />
	<br />
	<asp:LinkButton ID="lnkDeliveries" runat="server" CssClass ="lblMenu" 
					Font-Names="Verdana" Font-Size="9px" 
					ToolTip="Manage Deliveries" Font-Bold="True"
					PostBackUrl="~/WareHouse/DeliveryReceiptPanel.aspx" 
		  ForeColor="#666666">
	  DELIVERIES
	</asp:LinkButton>
  </div>
</div>

