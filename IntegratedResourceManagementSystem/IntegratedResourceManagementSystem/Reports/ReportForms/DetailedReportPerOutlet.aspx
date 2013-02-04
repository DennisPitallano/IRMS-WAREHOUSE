<%@ Page Title="" Language="C#" MasterPageFile="~/WareHouse/WareHouse.Master" AutoEventWireup="true" CodeBehind="DetailedReportPerOutlet.aspx.cs" Inherits="IntegratedResourceManagementSystem.Reports.ReportForms.DetailedReportPerOutlet" %>
<%@ Register assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304" namespace="CrystalDecisions.Web" tagprefix="CR" %>
<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <script src="http://localhost:11006/Scripts/jquery-1.7.2.js" type="text/javascript"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#btnBack").click(function () {
                window.location.href = "../../WareHouse/CRSConfirmationPanel.aspx";
                return false;
            });
        });
    </script>
    <style  type="text/css">
        #btnBack
        {
            
        }
    </style>
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div style ="text-align:center;">
        <input id="btnBack" type="button" value="BACK" />
    </div>
    <CR:CrystalReportViewer ID="crViewerDetailedReportPerOutlet" runat="server" 
        AutoDataBind="True" GroupTreeImagesFolderUrl="" Height="50px" 
        ToolbarImagesFolderUrl="" ToolPanelWidth="200px" Width="350px" HasCrystalLogo="False" />
   
</asp:Content>
