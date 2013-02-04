﻿<%@ Page Title="" Language="C#" MasterPageFile="~/WareHouse/WareHouse.Master" AutoEventWireup="true" CodeBehind="MonthlyConsolidatedReport.aspx.cs" Inherits="IntegratedResourceManagementSystem.Reports.ReportForms.MonthlyConsolidatedReport" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=13.0.2000.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>
<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <CR:CrystalReportViewer ID="crViewerMonthlyConsolidatedReport" runat="server" 
        AutoDataBind="true" HasCrystalLogo="False" />
</asp:Content>
