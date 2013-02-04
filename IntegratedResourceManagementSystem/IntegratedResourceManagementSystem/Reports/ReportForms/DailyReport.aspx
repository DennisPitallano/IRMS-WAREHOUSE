<%@ Page Title="" Language="C#" MasterPageFile="~/WareHouse/WareHouse.Master" AutoEventWireup="true" CodeBehind="DailyReport.aspx.cs" Inherits="IntegratedResourceManagementSystem.Reports.ReportForms.DailyReport" %>
<%@ Register assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" namespace="CrystalDecisions.Web" tagprefix="CR" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <style type ="text/css" >
    .backBtn
    {
        background :url('../../Resources/reply.png');
        background-repeat:no-repeat;
        font-family:Verdana;
        font-size:12px;
        height:25px;
        color:#FFFFCC;
        font-weight:bold;
        padding-left:20px;
        cursor:pointer;
    }
</style>
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div style ="margin-bottom:10px;">
    <asp:Button ID="btnBack" runat="server" Text="Back to Selection Page" 
        onclick="btnBack_Click" CssClass ="backBtn" BackColor="Silver" />
    <asp:RoundedCornersExtender ID="btnBack_RoundedCornersExtender" runat="server" 
        BorderColor="YellowGreen" Enabled="True" TargetControlID="btnBack">
    </asp:RoundedCornersExtender>
    </div>
    <CR:crystalreportviewer ID="crvDailyReport" runat="server" 
                    AutoDataBind="True" GroupTreeImagesFolderUrl="" 
                    ToolbarImagesFolderUrl="" ToolPanelView="None" 
        ToolPanelWidth="200px" HasCrystalLogo="False" HasRefreshButton="True"  PrintMode ="Pdf" />
              <%--  <CR:crystalreportsource ID="CrystalReportSource1" runat="server">
                    <Report FileName="Reports\ReportDocuments\CustSIIten.rpt">
                    </Report>
                </cr:crystalreportsource>--%>
</asp:Content>
