<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ReturnAndTransferMenu.ascx.cs" Inherits="IntegratedResourceManagementSystem.WareHouse.controls.ReturnAndTransferMenu" %>
  <%@ OutputCache Duration="86400" VaryByParam="*" Shared="true"  %>
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
<img src="../Resources/accounting.png" alt="PITA" height="22px"  align="top" />
<label > Returns and Transfer Menu</label>
</div>
<div class="menu-wrapper">
	<div class="mnuIcon" title="Manage Outright Markdown Memo">
		<a class="lblMenu" href="../Marketing/PullOutLettersManagementPanel.aspx">
			<img src="../Resources/adjustment.png" height="32px" title="Manage Pull-Out Letters" />
		</a>
		<br />
		<a title="Manage Pull-Out Letters" class="lblMenu" style="font-family: Verdana;
			font-size: 10px; font-weight: bold;"
			 href="../Marketing/PullOutLettersManagementPanel.aspx">
			PULL-OUT LETTERS</a>
	</div>
	<div class="mnuIcon" title="Manage Outright MarkDown Memo">
		<div>
			<a class="lblMenu" href="../Marketing/RequestPanel.aspx">
				<img src="../Resources/adjustment.png" height="36px" title="Manage Pull Out Requests" />
			</a>
		</div>
		<a title="Manage Pull Out Requests" class="lblMenu" style="font-size:10px; 
			font-weight: bold;" href="../Marketing/RequestPanel.aspx">PULL-OUT REQUEST</a>
	</div>
	<div class="mnuIcon" title="MarkDown Reports">
		<div>
			<a class="lblMenu" href="../Marketing/ReturnsAndTransferReportPanel.aspx">
				<img src="../Resources/adjustment.png"  title="Manage Outright MarkDown Memo" />
			</a>
		</div>
		<a title="Manage Outright MarkDown Memo" class="lblMenu" style="font-size:10px; 
			font-weight: bold;" href="../Marketing/ReturnsAndTransferReportPanel.aspx">REPORTS</a>
	</div>
</div>
<div class="menu-wrapper">
	<div class="mnuIcon">
	 <div>
		<a class="lblMenu" href="../WareHouse/ReturnsManagementPanel.aspx">
			<img src="../Resources/adjustment.png"  title="Manage Item/s Returns" />
		</a>
		</div>
		<a title="Manage Item/s Returns" class="lblMenu" style="font-family: Verdana;
			font-size:11px; font-weight: bold;" href="../WareHouse/ReturnsManagementPanel.aspx">
			RETURNS</a>
		
	</div>
	<div class="mnuIcon">
		<div>
			<a class="lblMenu" href="../Marketing/TransferManagementPanel.aspx">
				<img src="../Resources/adjustment.png"  title="Manage Transfer Item/s" />
			</a>
		</div>
		<a title="Manage Transfer Item/s" class="lblMenu" style="font-family: Verdana;
			font-size: 11px; font-weight: bold;" href="../Marketing/TransferManagementPanel.aspx">
			TRANSFER</a>
	</div>
</div>
