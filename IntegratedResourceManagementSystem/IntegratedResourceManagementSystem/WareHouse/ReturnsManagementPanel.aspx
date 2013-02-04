<%@ Page Title="" Language="C#" MasterPageFile="~/WareHouse/WareHouse.Master" AutoEventWireup="true"
    CodeBehind="ReturnsManagementPanel.aspx.cs" Inherits="IntegratedResourceManagementSystem.WareHouse.CRSConfirmationPanel" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="~/Warehouse/controls/UCLoader.ascx" TagName="LOADER" TagPrefix="UC" %>
<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <script src="../Scripts/jquery-1.7.2.js" type="text/javascript"></script>
    <link href="../Styles/crs.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript">
        function SelectAll(frmId, id) {
            var frm = document.getElementById(frmId);
            for (i = 1; i < frm.rows.length; i++) {
                var checkbox = frm.rows[i].cells[1].childNodes[1];
                if (checkbox != null)
                    checkbox.checked = document.getElementById(id).checked;
            }
        };
    </script>
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="titlePanel">
        <img src="../Resources/panels.png" alt="" align="top" />
        Manage Returns Panel
    </div>
    <asp:UpdatePanel ID="upnlDeliveryReceipts" runat="server">
        <ContentTemplate>
            <div style="margin-bottom: 1px; height: 30px;" class="modalDrag">
                <div style="float: left; margin-right: 5px;">
                    <asp:Label ID="lblSelectedItemToCancelModalHandler" runat="server"></asp:Label>
                    <asp:ModalPopupExtender ID="lblSelectedItemToCancelModalHandler_ModalPopupExtender" runat="server" DynamicServicePath=""
                        Enabled="True" TargetControlID="lblSelectedItemToCancelModalHandler" PopupControlID="pnlSelectedReturnsToCancelModal"
                        PopupDragHandleControlID="pnlSelectedReturnsToCancelModalDrag" BackgroundCssClass="bgModal"
                        CancelControlID="imgBtnClosepnlSelectedReturnsToCancelModal">
                        <Animations>
                                    <OnShown>
                                        <FadeIn Duration=".2" />
                                    </OnShown>
                        </Animations>
                    </asp:ModalPopupExtender>
                    <asp:Label ID="Label1" runat="server"></asp:Label>
                    <asp:ModalPopupExtender ID="btnPreviewSelectedDRForcancel_ModalPopupExtender" runat="server"
                        DynamicServicePath="" Enabled="True" TargetControlID="Label1" PopupControlID="pnlSelectedDRPreview"
                        PopupDragHandleControlID="pnlSelectedDRPreviewDrag" BackgroundCssClass="bgModal"
                        CancelControlID="imgBtnClosepnlSelectedDRPreview">
                        <Animations>
                            <OnShown>
                                <FadeIn Duration=".2" />
                            </OnShown>
                        </Animations>
                    </asp:ModalPopupExtender>
                    <asp:Button ID="btnConfirmedDR" runat="server" Height="30px" 
                        Text="CONFIRM RETURN/S" CssClass="btnDelete" 
                        onclick="btnConfirmedDR_Click" />
                </div>
                <div style="float:left;">
                      <asp:Button ID="btnPreviewSelectedCRSForcancel" runat="server" Height="30px" 
                      Text="CANCEL RETURN/S"  CssClass="btnDelete" onclick="btnPreviewSelectedCRSForcancel_Click" />   
                </div>
                <div style="float: left;">
                    <asp:Button ID="btnPrint" runat="server" Text="PRINT" CssClass="btnPrint" Height="30px" />
                    <asp:ModalPopupExtender ID="btnPrint_ModalPopupExtender" runat="server" DynamicServicePath=""
                        Enabled="True" TargetControlID="btnPrint" CancelControlID="ibtnClosepnlPrintOptionModal"
                        PopupControlID="pnlPrintOptionModal" PopupDragHandleControlID="pnlPrintOptionModalDrag">
                        <Animations>
                                <OnShown>
                                    <FadeIn Duration=".2" />
                                </OnShown>
                        </Animations>
                    </asp:ModalPopupExtender>
                </div>
                <div style="float: left; height: 32px; margin-left: 2px;">
                    <asp:HyperLink ID="hpLinkReturnDetails" Height="28px" Target="_blank" CssClass="btnPrint"
                        runat="server">RETURN DETAILS</asp:HyperLink>
                </div>
                <div style="float: left; height: 32px; margin-left: 5px;">
                    <asp:UpdateProgress ID="uProgressLoader" runat="server" AssociatedUpdatePanelID="upnlDeliveryReceipts"
                        DisplayAfter="100">
                        <ProgressTemplate>
                            <asp:PlaceHolder ID="plcHldrLoader" runat="server">
                                <UC:LOADER ID="loader" runat="server" />
                            </asp:PlaceHolder>
                        </ProgressTemplate>
                    </asp:UpdateProgress>
                </div>
                <div style="float: left; height: 24px; padding-right: 5px;" class="SearchTextContainer">
                    FILTER:<asp:RadioButtonList CssClass="filterContainer" ID="rdioFilterView" runat="server"
                        Font-Names="Verdana" Font-Size="10px" ForeColor="#993300" RepeatDirection="Horizontal"
                        RepeatLayout="Flow" AutoPostBack="True" OnSelectedIndexChanged="rdioFilterView_SelectedIndexChanged">
                        <asp:ListItem Selected="True">UNPOSTED</asp:ListItem>
                        <asp:ListItem>POSTED</asp:ListItem>
                        <asp:ListItem>CANCELLED</asp:ListItem>
                        <asp:ListItem Value="CONFIRMED">CONFIRMED</asp:ListItem>
                    </asp:RadioButtonList>
                </div>
                <div class="SearchTextContainer">
                    <asp:Label Text="SEARCH:" ID="lblSearchOption" runat="server" />
                  <asp:HoverMenuExtender ID="btnPrint_HoverMenuExtender" runat="server" 
                            DynamicServicePath="" Enabled="True" TargetControlID="lblSearchOption" 
                            PopupControlID="pnlPrintOption" PopupPosition="Bottom">
                        </asp:HoverMenuExtender>
                         <asp:Panel ID="pnlPrintOption" runat="server">
                            <div class="hover-menu-arrow" >
                            </div> 
                            <div class="hover-menu">
                                <div class="print-link">
                                    <asp:RadioButtonList ID="rdioSearchFilter" runat="server" 
                                        RepeatDirection="Horizontal" RepeatLayout="Flow">
                                        <asp:ListItem Value="CRSNo" Selected="True">CRS #</asp:ListItem>
                                        <asp:ListItem Value="PUSNo">PUS #</asp:ListItem>
                                        <asp:ListItem Value="Customer">CUSTOMER</asp:ListItem>
                                    </asp:RadioButtonList>
                                </div>
                            </div>
                        </asp:Panel>
                    <asp:TextBox ID="txtSearchDR" runat="server" Font-Size="10px" Height="18px" Width="130px"
                        CssClass="modalText" placeholder="Search Returns"></asp:TextBox>
                    <asp:ImageButton ID="imgBtnSearchDR" runat="server" ImageAlign="Top" ImageUrl="~/Resources/search.png"
                        ToolTip="Search Delivery Receipt" OnClick="imgBtnSearchDR_Click" />
                    <asp:ImageButton ID="ibtnEnableDate" runat="server" ImageAlign="Middle" ImageUrl="~/Resources/advance_search.png"
                        ToolTip="Enable Date Range" />
                    <asp:ModalPopupExtender ID="ibtnEnableDate_ModalPopupExtender" runat="server" DynamicServicePath=""
                        Enabled="True" TargetControlID="ibtnEnableDate" PopupControlID="pnlAdvanceSearch"
                        PopupDragHandleControlID="pnlAdvanceSearchDrag" CancelControlID="ibtnCloseAdvanceSearch">
                    </asp:ModalPopupExtender>
                    <asp:Panel ID="pnlAdvanceSearch" runat="server" CssClass="modal">
                        <asp:Panel ID="pnlAdvanceSearchDrag" runat="server" CssClass="modalDrag">
                            <div class="close_btn">
                                <asp:ImageButton ID="ibtnCloseAdvanceSearch" runat="server" CssClass="btnClose" ImageUrl="~/Resources/cancel_gray.png"
                                    ToolTip="CLOSE" />
                            </div>
                            <div class="sizeLogo">
                                <img src="../Resources/panels.png" alt="" height="16px" align="top" />
                                INCLUDE DATE RANGE SEARCH OPTION!
                            </div>
                        </asp:Panel>
                        <div style="margin: 5px 3px 5px 5px;">
                            <label for="MainContent_txtDateSeachFrom" class="modalLabel">
                                DATE RANGE: FROM
                            </label>
                            <asp:TextBox ID="txtDateSeachFrom" CssClass="modalText" runat="server" Font-Names="Verdana"
                                Font-Size="11px" Height="20px" AutoPostBack="True" OnTextChanged="txtDateSeachFrom_TextChanged"></asp:TextBox>
                            <asp:CalendarExtender ID="txtDateSeachFrom_CalendarExtender" runat="server" Enabled="True"
                                TargetControlID="txtDateSeachFrom" Format="MMMM dd, yyyy">
                            </asp:CalendarExtender>
                            <label for="MainContent_txtDateSeachTo" class="modalLabel">
                                TO
                            </label>
                            <asp:TextBox ID="txtDateSeachTo" CssClass="modalText" runat="server" Font-Names="Verdana"
                                Font-Size="11px" Height="20px" AutoPostBack="True" OnTextChanged="txtDateSeachTo_TextChanged"></asp:TextBox>
                            <asp:CalendarExtender ID="txtDateSeachTo_CalendarExtender" runat="server" Enabled="True"
                                TargetControlID="txtDateSeachTo" Format="MMMM dd, yyyy">
                            </asp:CalendarExtender>
                            <div style="text-align: center; margin-top: 2px;">
                                <asp:Button ID="btnGo" CssClass="modalWarningButtonYes" runat="server" Text="GO"
                                    OnClick="btnGo_Click" />
                            </div>
                        </div>
                    </asp:Panel>
                </div>
            </div>
            <div style="float: left; min-height: 415px; margin-right: 2px;">
                <div class="titleList">
                    <img src="../Resources/panels.png" alt="" align="top" />
                    <asp:Label ID="lblListTitle" runat="server" Text="LIST OF UNPOSTED RETURNS"></asp:Label>
                </div>
                <div style="margin-bottom: 10px;">
                    <asp:GridView ID="gvDeliveryReceipts" runat="server" AllowPaging="True" AllowSorting="True"
                        AutoGenerateColumns="False" CellPadding="4" DataKeyNames="ID" DataSourceID="SqlDataSourceDeliveryReceipt"
                        GridLines="Horizontal" CssClass="table_grid" EnablePersistedSelection="True"
                        OnSelectedIndexChanged="gvDeliveryReceipts_SelectedIndexChanged" PageSize="12"
                        OnPageIndexChanging="gvDeliveryReceipts_PageIndexChanging" OnSorting="gvDeliveryReceipts_Sorting">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:TemplateField>
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Image ID="imgReturn" AlternateText='<%# Eval("ID") %>' runat="server" ImageUrl="~/Resources/panels.png"
                                        Height="17" ToolTip='<%# "CRS #:" + Eval("CRSNo") +"\n" 
                    + "CUSTOMER: " + Eval("Customer") + "\n CRS DATE: " + Eval("CRSDate") + "\n TOTAL AMOUNT: Php " + Eval("TotalAmt") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <EditItemTemplate>
                                    <asp:CheckBox ID="CheckBox1" runat="server" />
                                </EditItemTemplate>
                                <HeaderTemplate>
                                    <asp:CheckBox ID="chkAllSelected" runat="server" ClientIDMode="Static" onclick="SelectAll('MainContent_gvDeliveryReceipts','chkAllSelected')" />
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkID" runat="server" />
                                </ItemTemplate>
                                <HeaderStyle Wrap="False" />
                                <ItemStyle Font-Bold="True" ForeColor="#CC6600" HorizontalAlign="Center" Wrap="False" />
                            </asp:TemplateField>
                            <asp:CommandField ShowSelectButton="True" />
                            <asp:BoundField DataField="ID" HeaderText="ID" InsertVisible="False" ReadOnly="True"
                                SortExpression="ID" Visible="False"></asp:BoundField>
                            <asp:BoundField DataField="CRSID" HeaderText="CRSID" SortExpression="CRSID" Visible="False">
                            </asp:BoundField>
                            <asp:BoundField DataField="CRSNo" HeaderText="CRS NUMBER" SortExpression="CRSNo">
                                <HeaderStyle Wrap="False" />
                                <ItemStyle Wrap="False" Font-Bold="True" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="CRSDate" HeaderText="CRS DATE" SortExpression="CRSDate"
                                DataFormatString="{0:MMM dd, yyyy}">
                                <HeaderStyle Wrap="False" />
                                <ItemStyle Wrap="False" Font-Bold="True" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Customer" HeaderText="CUSTOMER" SortExpression="Customer">
                                <HeaderStyle Wrap="False" />
                                <ItemStyle Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="PUSNo" HeaderText="PUS NUMBER" SortExpression="PUSNo">
                                <HeaderStyle Wrap="False" />
                                <ItemStyle Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="TotalAmt" HeaderText="TOTAL AMOUNT" SortExpression="TotalAmt"
                                DataFormatString="{0:###,###.00} ">
                                <HeaderStyle Wrap="False" />
                                <ItemStyle Wrap="False" ForeColor="#CC0000" />
                            </asp:BoundField>
                            <asp:BoundField DataField="PkgNo" HeaderText="PACKAGE #" SortExpression="PkgNo">
                                <HeaderStyle Wrap="False" />
                                <ItemStyle Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="ItemStatus" HeaderText="STATUS" SortExpression="ItemStatus">
                                <HeaderStyle Wrap="False" />
                                <ItemStyle Wrap="False" />
                            </asp:BoundField>
                        </Columns>
                        <EditRowStyle BackColor="#7C6F57" />
                        <EmptyDataTemplate>
                            <div style="width: 700px; margin-top: 15px; border: 1px solid #FFCC66; height: 55px;
                                line-height: 55px; background-color: #FFFFCC; color: #C46200; text-align: center;">
                                <img src="../Resources/unhappy.png" alt="WEEE" align="middle" />
                                DATA NOT FOUND!!!
                            </div>
                        </EmptyDataTemplate>
                        <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                        <PagerSettings PageButtonCount="20" FirstPageImageUrl="~/Resources/first.png" LastPageImageUrl="~/Resources/last.png"
                            Mode="NumericFirstLast" />
                        <PagerStyle CssClass="pager" />
                        <RowStyle BackColor="#E3EAEB" />
                        <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                        <SortedAscendingCellStyle CssClass="asc_cell_style" />
                        <SortedAscendingHeaderStyle CssClass="asc_cell_style_h" />
                        <SortedDescendingCellStyle CssClass="desc_cell_style" />
                        <SortedDescendingHeaderStyle CssClass="desc_cell_style_h" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSourceDeliveryReceipt" runat="server" ConnectionString="<%$ ConnectionStrings:IRMSConnectionString %>"
                        SelectCommand="SELECT [ID], [CRSID], [CRSNo], [CRSDate], [Customer], [PUSNo], [TotalAmt],
                   [PkgNo], [ItemStatus] FROM [CRS] WHERE ynPosted=0 AND ynCancelled=0 and CRS.CRSNo not in(SELECT CRS_CONFIRMATIONS.CRS_NUMBER from CRS_CONFIRMATIONS) order by CRSDate DESC"
                        CacheDuration="5" EnableCaching="True"></asp:SqlDataSource>
                </div>
            </div>
            <asp:Panel ID="pnlSelectedDRPreview" runat="server" CssClass="modal" BorderColor="Gray"
                BorderStyle="Solid" BorderWidth="1px">
                <asp:Panel ID="pnlSelectedDRPreviewDrag" runat="server" CssClass="modalDrag">
                    <div class="close_btn">
                        <asp:ImageButton ID="imgBtnClosepnlSelectedDRPreview" runat="server" CssClass="btnClose"
                            ImageUrl="~/Resources/cancel_gray.png" ToolTip="CLOSE" />
                    </div>
                    <div class="sizeLogo">
                        <asp:Image ID="imgUpdateLogo" runat="server" Height="16px" ImageAlign="AbsBottom"
                            ImageUrl="~/Resources/panels.png" />
                        Preview Customer Return Slip to Confirm.
                    </div>
                </asp:Panel>
                <div style="text-align: center; line-height: 18px; margin: 3px;">
                    <asp:Label ID="Label6" runat="server" CssClass="modalText" Text="Note: UNCHECK TO EXCLUDE OR CLOSE AND RESELECT FROM LIST "
                        Font-Bold="False" Font-Italic="True" Font-Names="Verdana" Font-Size="10px" Height="18px"></asp:Label>
                </div>
                <div style="margin-left: 10px; margin-right: 10px;">
                    <asp:GridView ID="gvPreviewSelectedDR" runat="server" AutoGenerateColumns="False"
                        Font-Names="Verdana" Font-Size="10px" ForeColor="#333333" CellPadding="4" GridLines="None">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:BoundField DataField="CustomerReturnSlipNumber" HeaderText="CRS NUMBER">
                                <ItemStyle Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="CustomerReturnSlipDate" HeaderText="CRS DATE" DataFormatString="{0:MMMM dd, yyyy}">
                                <ItemStyle Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="Customer" HeaderText="CUSTOMER">
                                <ItemStyle Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="PkgNo" HeaderText="PL NUMBER" HtmlEncode="False">
                                <ItemStyle Wrap="False" />
                            </asp:BoundField>
                            <asp:TemplateField>
                                <EditItemTemplate>
                                    <asp:CheckBox ID="CheckBox1" runat="server" />
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkSelectedDRTCancelled" runat="server" Checked="true" ToolTip='<%# Eval("RecordNo") %>' />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <EditRowStyle BackColor="#7C6F57" />
                        <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                        <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
                        <RowStyle BackColor="#E3EAEB" />
                        <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                        <SortedAscendingCellStyle BackColor="#F8FAFA" />
                        <SortedAscendingHeaderStyle BackColor="#246B61" />
                        <SortedDescendingCellStyle BackColor="#D4DFE1" />
                        <SortedDescendingHeaderStyle BackColor="#15524A" />
                    </asp:GridView>
                </div>
                <hr />
                <div style="margin-left: 5px; margin-top: 10px;">
                    <table cellpadding="0">
                        <tr>
                            <td class="modalLabel">
                                WAYBILL #:
                            </td>
                            <td>
                                <asp:TextBox ID="txtWayBillNumber" CssClass="modalText" runat="server" Font-Names="Verdana"
                                    Font-Size="12px" Height="20px" ForeColor="#003366" Width="200px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="modalLabel">
                                DESTINATION:
                            </td>
                            <td>
                                <asp:TextBox ID="txtDestination" CssClass="modalText" runat="server" Font-Names="Verdana"
                                    Font-Size="12px" Height="20px" ForeColor="#003366" Width="250px"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td class="modalLabel">
                                FORWARDER:
                            </td>
                            <td>
                                <asp:DropDownList CssClass="modalText" ID="dlForwarders" runat="server" Font-Names="Verdana"
                                    Font-Size="11px" Height="22px">
                                </asp:DropDownList>
                            </td>
                        </tr>
                        <tr>
                            <td class="modalLabel">
                                CONFIRMATION DATE:
                            </td>
                            <td>
                                <asp:TextBox CssClass="modalText" ID="txtConfirmationDate" runat="server" Font-Names="Verdana"
                                    Font-Size="12px" Height="20px" Width="150px" ForeColor="#003366"></asp:TextBox>
                                <asp:CalendarExtender ID="txtConfirmationDate_CalendarExtender" runat="server" Enabled="True"
                                    Format="MMMM dd, yyyy" TargetControlID="txtConfirmationDate">
                                </asp:CalendarExtender>
                            </td>
                        </tr>
                    </table>
                </div>
                <div style="text-align: center; margin-top: 5px; margin-bottom: 5px;">
                    <asp:Button ID="btnContinueDRConfirmation" runat="server" Text="CONTINUE CONFIRMATION"
                        CssClass="modalWarningButtonYes" Width="190px" Font-Names="Verdana" Font-Size="10px"
                        OnClick="btnContinueDRConfirmation_Click" />
                </div>
            </asp:Panel>

             <asp:Panel ID="pnlSelectedReturnsToCancelModal" runat ="server" CssClass ="modal" Width ="500px" >
          <asp:Panel ID= "pnlSelectedReturnsToCancelModalDrag" runat = "server" CssClass ="modalDrag" >
            <div class ="close_btn">
              <asp:ImageButton ID="imgBtnClosepnlSelectedReturnsToCancelModal" runat="server" 
                               CssClass ="btnClose" ImageUrl="~/Resources/cancel_gray.png" ToolTip="CLOSE"/>
            </div> 
            <div class ="sizeLogo">
                <img src="../Resources/panels.png" alt="" align="top" height="16px" />
              PREVIEW CRS to cancel.
            </div>
          </asp:Panel>
           <div style="text-align: center; line-height: 18px; margin: 3px;">
                    <asp:Label ID="Label19" runat="server" CssClass="modalText" Text="Note: UNCHECK TO EXCLUDE OR CLOSE AND RESELECT FROM LIST "
                        Font-Bold="False" Font-Italic="True" Font-Names="Verdana" Font-Size="10px" Height="18px"></asp:Label>
                </div>
          <div style ="margin-left:5px; margin-right :5px; margin-top : 5px;">
          <asp:GridView ID="gvSelectedItemsToCancel" runat="server" AutoGenerateColumns="False" 
                        Font-Names="Verdana" Font-Size="10px" ForeColor="#333333" 
                  CellPadding="4" GridLines="None">
              <AlternatingRowStyle BackColor="White" />
            <Columns>
              <asp:BoundField DataField="CustomerReturnSlipNumber" HeaderText="CRS NUMBER" >
                <ItemStyle Wrap="False" />
                </asp:BoundField>
                <asp:BoundField DataField="Customer" HeaderText="CUSTOMER" >
                <ItemStyle Wrap="False" />
                </asp:BoundField>
              <asp:BoundField DataField="CustomerReturnSlipDate" HeaderText="CRS DATE" 
                    DataFormatString="{0:MMMM dd, yyyy}" >
                <ItemStyle Wrap="False" />
                </asp:BoundField>
              <asp:BoundField DataField="PUSNo" HeaderText="PUS NUMBER" >
                <ItemStyle Wrap="False" />
                </asp:BoundField>
                <asp:TemplateField>
                    <EditItemTemplate>
                        <asp:CheckBox ID="CheckBox1" runat="server" />
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:CheckBox ID="chkSelectedCRSToBeCancelled" ToolTip ='<%# Eval("RecordNo") %>' Checked ="true" runat="server" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
              <EditRowStyle BackColor="#7C6F57" />
              <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
              <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
              <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Center" />
              <RowStyle BackColor="#E3EAEB" />
              <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
              <SortedAscendingCellStyle BackColor="#F8FAFA" />
              <SortedAscendingHeaderStyle BackColor="#246B61" />
              <SortedDescendingCellStyle BackColor="#D4DFE1" />
              <SortedDescendingHeaderStyle BackColor="#15524A" />
          </asp:GridView>
          </div>

          <div style =" text-align:center; margin-top:5px; margin-bottom:5px;">
            <asp:Button ID="btnYesCancelSelectedDR" runat="server" Text="CONTINUE CANCEL" 
                  CssClass ="modalWarningButtonYes" 
                  Width="150px" onclick="btnYesCancelSelectedDR_Click" />
            
          </div>
        </asp:Panel>

            <asp:Panel ID="pnlPrintOptionModal" runat="server" CssClass="modal" Width="480px">
                <asp:Panel ID="pnlPrintOptionModalDrag" runat="server" CssClass="modalDrag">
                    <div class="close_btn">
                        <asp:ImageButton ID="ibtnClosepnlPrintOptionModal" runat="server" CssClass="btnClose"
                            ImageUrl="~/Resources/cancel_gray.png" ToolTip="CLOSE" />
                    </div>
                    <div class="sizeLogo">
                        <asp:Image ID="Image5" runat="server" Height="16px" ImageAlign="AbsBottom" ImageUrl="~/Resources/panels.png" />
                        CRS/PULL OUT Print Option.
                    </div>
                </asp:Panel>
                <asp:TabContainer ID="TabContainer1" runat="server" ActiveTabIndex="0">
                    <asp:TabPanel ID="tabPnlDetailedReport" runat="server" HeaderText="DETAILED REPORT/CUSTOMER">
                        <ContentTemplate>
                            <asp:Label ID="Label7" runat="server" Text="Generate Detailed Report per Outlet (w/ Forwarder and Destination)"
                                Font-Italic="True" Font-Names="Verdana" Font-Size="11px"></asp:Label>
                            <br />
                            <hr />
                            <div style="margin-bottom: 5px;">
                                <asp:Panel ID="pnlIntransitDateRange" runat="server">
                                    <asp:Label ID="Label8" runat="server" Text="DATE FROM:" Font-Names="Verdana" Font-Size="11px"></asp:Label>
                                    <asp:TextBox ID="txtPullOutDetailedPerOutletDateFrom" runat="server" Font-Names="Verdana"
                                        Font-Size="11px" Width="120px"></asp:TextBox>
                                    <asp:CalendarExtender ID="CalendarExtender1" runat="server" Enabled="True" TargetControlID="txtPullOutDetailedPerOutletDateFrom"
                                        Format="MMMM dd, yyyy">
                                    </asp:CalendarExtender>
                                    <asp:Label ID="Label9" runat="server" Text="TO" Font-Names="Verdana" Font-Size="11px"></asp:Label>
                                    <asp:TextBox ID="txtPullOutDetailedPerOutletDateTo" runat="server" Font-Names="Verdana"
                                        Font-Size="11px" Width="120px"></asp:TextBox>
                                    <asp:CalendarExtender ID="CalendarExtender2" runat="server" Enabled="True" TargetControlID="txtPullOutDetailedPerOutletDateTo"
                                        Format="MMMM dd, yyyy">
                                    </asp:CalendarExtender>
                                </asp:Panel>
                            </div>
                            <div style="margin-top: 20px;">
                                <asp:Label ID="Label2" runat="server" Text="OUTLET:"></asp:Label>
                                <asp:DropDownList ID="dlOutletDetailed" runat="server" Font-Names="Verdana" Font-Size="11px"
                                    ForeColor="#003366" Height="20px" DataSourceID="SqlDataSourceOutleDetailed" DataTextField="CompName"
                                    DataValueField="CustNo">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSourceOutleDetailed" runat="server" ConnectionString="<%$ ConnectionStrings:IRMSConnectionString %>"
                                    SelectCommand="SELECT [CustNo], [CompName] FROM [CustInfo] ORDER BY CompName ASC">
                                </asp:SqlDataSource>
                                <asp:ListSearchExtender ID="dlOutletDetailed_ListSearchExtender" runat="server" Enabled="True"
                                    TargetControlID="dlOutletDetailed">
                                </asp:ListSearchExtender>
                            </div>
                            <div style="text-align: center; height: 20px; margin-bottom: 10px; margin-top: 5px;">
                                <asp:Button ID="btnGenerateDetailedReportPerCustomer" runat="server" Text="GENERATE REPORT"
                                    CssClass="btnPrint" Font-Names="Verdana" Font-Size="11px" OnClick="btnGenerateDetailedReportPerCustomer_Click" />
                                <asp:RoundedCornersExtender ID="btnGenerateDetailedReportPerCustomer_RoundedCornersExtender"
                                    runat="server" BorderColor="LightGray" Enabled="True" TargetControlID="btnGenerateDetailedReportPerCustomer">
                                </asp:RoundedCornersExtender>
                            </div>
                        </ContentTemplate>
                    </asp:TabPanel>
                    <asp:TabPanel ID="tabPnlMonthlyPullOutBrand" runat="server" HeaderText="MONTHLY SUMMARY/BRAND REPORT">
                        <ContentTemplate>
                            <asp:Label ID="Label11" runat="server" Text="Generate Monthly Pull-Out Summary per Brand"
                                Font-Italic="True" Font-Names="Verdana" Font-Size="11px"></asp:Label><br />
                            <hr />
                            <div style="margin-bottom: 5px;">
                                <asp:Panel ID="pnlConfirmedDRDateRange" runat="server">
                                    <asp:Label ID="Label4" runat="server" Text="DATE FROM:" Font-Names="Verdana" Font-Size="11px"></asp:Label><asp:TextBox
                                        ID="txtConfirmedDateRangeFrom" runat="server" Font-Names="Verdana" Font-Size="11px"
                                        Width="120px"></asp:TextBox><asp:CalendarExtender ID="txtConfirmedDateRangeFrom_CalendarExtender"
                                            runat="server" Enabled="True" TargetControlID="txtConfirmedDateRangeFrom" Format="MMMM dd, yyyy">
                                        </asp:CalendarExtender>
                                    <asp:Label ID="Label5" runat="server" Text="TO" Font-Names="Verdana" Font-Size="11px"></asp:Label><asp:TextBox
                                        ID="txtConfirmedDateRangeTo" runat="server" Font-Names="Verdana" Font-Size="11px"
                                        Width="120px"></asp:TextBox><asp:CalendarExtender ID="txtConfirmedDateRangeTo_CalendarExtender"
                                            runat="server" Enabled="True" TargetControlID="txtConfirmedDateRangeTo" Format="MMMM dd, yyyy">
                                        </asp:CalendarExtender>
                                </asp:Panel>
                            </div>
                            <div>
                                <asp:Label ID="Label15" runat="server" Text="CUSTOMER TYPE:"></asp:Label><asp:RadioButtonList
                                    ID="rdioListCustomerType" runat="server" Font-Names="Verdana" Font-Size="11px"
                                    RepeatDirection="Horizontal" RepeatLayout="Flow">
                                    <asp:ListItem Selected="True" Value="DEPARTMENT STORE">DEPT. STORE</asp:ListItem>
                                    <asp:ListItem>BOUTIQUE</asp:ListItem>
                                    <asp:ListItem>PROVINCIAL</asp:ListItem>
                                </asp:RadioButtonList>
                            </div>
                            <br />
                            <asp:Label ID="Label3" runat="server" Text="BRAND:"></asp:Label><asp:DropDownList
                                ID="dlConfirmedBrands" runat="server" Font-Names="Verdana" Font-Size="11px" ForeColor="#003366"
                                Height="20px">
                            </asp:DropDownList>
                            <asp:ListSearchExtender ID="ListSearchExtender1" runat="server" Enabled="True" TargetControlID="dlConfirmedBrands">
                            </asp:ListSearchExtender>
                            <div style="text-align: center; height: 20px; margin-bottom: 10px; margin-top: 5px;">
                                <asp:Button ID="btnPrintByBrand" runat="server" Text="GENERATE REPORT" CssClass="btnPrint"
                                    Font-Names="Verdana" Font-Size="11px" OnClick="btnPrintByBrand_Click" /><asp:RoundedCornersExtender
                                        ID="btnPrintDRConfirmedByRange_RoundedCornersExtender" runat="server" BorderColor="LightGray"
                                        Enabled="True" TargetControlID="btnPrintByBrand">
                                    </asp:RoundedCornersExtender>
                            </div>
                        </ContentTemplate>
                    </asp:TabPanel>
                    <asp:TabPanel ID="tabPnlMonthlyPullOutCustomer" runat="server" HeaderText="MONTHLY SUMMARY/CUSTOMER REPORT">
                        <ContentTemplate>
                            <asp:Label ID="Label10" runat="server" Text="Generate Monthly Pull-Out Summary per Customer"
                                Font-Italic="True" Font-Names="Verdana" Font-Size="11px"></asp:Label><br />
                            <hr />
                            <div style="margin-bottom: 5px;">
                                <asp:Panel ID="Panel1" runat="server">
                                    <asp:Label ID="Label12" runat="server" Text="DATE FROM:" Font-Names="Verdana" Font-Size="11px"></asp:Label><asp:TextBox
                                        ID="txtDateRangeFromSummaryPerCustomer" runat="server" Font-Names="Verdana" Font-Size="11px"
                                        Width="120px"></asp:TextBox><asp:CalendarExtender ID="CalendarExtender_txtDateRangeFromSummaryPerCustomer"
                                            runat="server" Enabled="True" TargetControlID="txtDateRangeFromSummaryPerCustomer"
                                            Format="MMMM dd, yyyy">
                                        </asp:CalendarExtender>
                                    <asp:Label ID="Label13" runat="server" Text="TO" Font-Names="Verdana" Font-Size="11px"></asp:Label><asp:TextBox
                                        ID="txtDateRangeToSummaryPerCustomer" runat="server" Font-Names="Verdana" Font-Size="11px"
                                        Width="120px"></asp:TextBox><asp:CalendarExtender ID="CalendarExtender_txtDateRangeToSummaryPerCustomer"
                                            runat="server" Enabled="True" TargetControlID="txtDateRangeToSummaryPerCustomer"
                                            Format="MMMM dd, yyyy">
                                        </asp:CalendarExtender>
                                </asp:Panel>
                            </div>
                            <div style="margin-top: 20px;">
                                <asp:Label ID="Label14" runat="server" Text="OUTLET:"></asp:Label><asp:DropDownList
                                    ID="dlCustomerSummary" runat="server" Font-Names="Verdana" Font-Size="11px" ForeColor="#003366"
                                    Height="20px" DataSourceID="SqlDataSourceSummaryPerCustomer" DataTextField="CompName"
                                    DataValueField="CustNo">
                                </asp:DropDownList>
                                <asp:SqlDataSource ID="SqlDataSourceSummaryPerCustomer" runat="server" ConnectionString="<%$ ConnectionStrings:IRMSConnectionString %>"
                                    SelectCommand="SELECT [CustNo], [CompName] FROM [CustInfo] ORDER BY CompName ASC">
                                </asp:SqlDataSource>
                                <asp:ListSearchExtender ID="ListSearchExtender_dlCustomerSummary" runat="server"
                                    Enabled="True" TargetControlID="dlCustomerSummary">
                                </asp:ListSearchExtender>
                            </div>
                            <div style="text-align: center; height: 20px; margin-bottom: 10px; margin-top: 5px;">
                                <asp:Button ID="btnGenerateMonthlyPullOutSummaryPerCustomer" runat="server" Text="GENERATE REPORT"
                                    CssClass="btnPrint" Font-Names="Verdana" Font-Size="11px" OnClick="btnGenerateMonthlyPullOutSummaryPerCustomer_Click" /><asp:RoundedCornersExtender
                                        ID="RoundedCornersExtender1" runat="server" BorderColor="LightGray" Enabled="True"
                                        TargetControlID="btnGenerateMonthlyPullOutSummaryPerCustomer">
                                    </asp:RoundedCornersExtender>
                            </div>
                        </ContentTemplate>
                    </asp:TabPanel>
                    <asp:TabPanel ID="tabPnlMonthlyConsolidated" runat="server" HeaderText="MONTHLY CONSOLIDATED REPORT">
                        <ContentTemplate>
                            <asp:Label ID="Label16" runat="server" Text="Generate Monthly Pull-Out Consolidated Report"
                                Font-Italic="True" Font-Names="Verdana" Font-Size="11px"></asp:Label><br />
                            <hr />
                            <div style="margin-bottom: 5px;">
                                <asp:Panel ID="Panel2" runat="server">
                                    <asp:Label ID="Label17" runat="server" Text="DATE FROM:" Font-Names="Verdana" Font-Size="11px"></asp:Label><asp:TextBox
                                        ID="txtConsolidatedDateFrom" runat="server" Font-Names="Verdana" Font-Size="11px"
                                        Width="120px"></asp:TextBox><asp:CalendarExtender ID="CalendarExtender_txtConsolidatedDateFrom"
                                            runat="server" Enabled="True" TargetControlID="txtConsolidatedDateFrom" Format="MMMM dd, yyyy">
                                        </asp:CalendarExtender>
                                    <asp:Label ID="Label18" runat="server" Text="TO" Font-Names="Verdana" Font-Size="11px"></asp:Label><asp:TextBox
                                        ID="txtConsolidatedDateTo" runat="server" Font-Names="Verdana" Font-Size="11px"
                                        Width="120px"></asp:TextBox><asp:CalendarExtender ID="CalendarExtender_txtConsolidatedDateTo"
                                            runat="server" Enabled="True" TargetControlID="txtConsolidatedDateTo" Format="MMMM dd, yyyy">
                                        </asp:CalendarExtender>
                                </asp:Panel>
                            </div>
                            <div style="text-align: center; height: 20px; margin-bottom: 10px; margin-top: 5px;">
                                <asp:Button ID="btnPrintConsolidated" runat="server" Text="GENERATE REPORT" CssClass="btnPrint"
                                    Font-Names="Verdana" Font-Size="11px" OnClick="btnPrintConsolidated_Click" />
                                <asp:RoundedCornersExtender ID="RoundedCornersExtender_btnPrintConsolidated" runat="server"
                                    BorderColor="LightGray" Enabled="True" TargetControlID="btnPrintConsolidated">
                                </asp:RoundedCornersExtender>
                            </div>
                        </ContentTemplate>
                    </asp:TabPanel>
                </asp:TabContainer>
            </asp:Panel>
            <asp:HiddenField ID="hfIsAdvanceSearch" runat="server" />
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
