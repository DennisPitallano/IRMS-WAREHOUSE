<%@ Page Title="" Language="C#" MasterPageFile="~/WareHouse/WareHouse.Master" AutoEventWireup="true"
    CodeBehind="SalesInvoicePanel.aspx.cs" Inherits="IntegratedResourceManagementSystem.WareHouse.SalesInvoicePanel" %>

<%@ OutputCache Duration="30" VaryByParam="*" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="~/WareHouse/controls/UCLoader.ascx" TagName="LOADER" TagPrefix="UC" %>
<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <link href="../Styles/sales-invoice.css" rel="stylesheet" type="text/css" />
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
        <asp:Image ID="imgDRTitle" runat="server" ImageUrl="~/Resources/panels.png" ImageAlign="AbsMiddle" />
        &nbsp;Manage Sales Invoice
    </div>
    <hr />
    <asp:UpdatePanel ID="upnlSalesInvoice" runat="server">
        <ContentTemplate>
            <div style="margin-bottom: 1px; height: 30px;" class="modalDrag">
                <div style="float: left;">
                    <asp:Button ID="btnPreviewSelectedSIForcancel" runat="server" Height="30px" CssClass="btnDelete"
                        OnClick="btnPreviewSelectedSIForcancel_Click" TabIndex="3" />
                    <asp:UpdateProgress ID="upCustomerReturnSlip" runat="server" AssociatedUpdatePanelID="upnlSalesInvoice"
                        DisplayAfter="500">
                        <ProgressTemplate>
                            <asp:PlaceHolder ID="plcHldrLoader" runat="server">
                                <UC:LOADER ID="loader" runat="server" />
                            </asp:PlaceHolder>
                        </ProgressTemplate>
                    </asp:UpdateProgress>
                </div>
                <div style="float: left;">
                    <asp:HyperLink ID="hpLinkSalesInvoiceDetails" Height="28px" CssClass="btnPrint" Target="_blank" runat="server">INVOICE DETAILS</asp:HyperLink>
                </div>
                <div style="float: left; height: 24px; padding-right: 5px;" class="SearchTextContainer">
                    FILTER:<asp:RadioButtonList CssClass="filterContainer" ID="rdioFilterView" runat="server"
                        Font-Names="Verdana" Font-Size="10px" ForeColor="#993300" RepeatDirection="Horizontal"
                        RepeatLayout="Flow" AutoPostBack="True" OnSelectedIndexChanged="rdioFilterView_SelectedIndexChanged">
                        <asp:ListItem Selected="True" Value="UNPOSTED">UNPOSTED</asp:ListItem>
                        <asp:ListItem Value="POSTED">POSTED</asp:ListItem>
                        <asp:ListItem Value="CANCELLED">CANCELLED</asp:ListItem>
                    </asp:RadioButtonList>
                </div>
                <div class="SearchTextContainer">
                    <asp:Label ID="lblSearchBy" runat="server" Text="SEARCH BY:" CssClass="search_option"></asp:Label>
                    <asp:HoverMenuExtender ID="lblSearchBy_HoverMenuExtender" runat="server" DynamicServicePath=""
                        Enabled="True" TargetControlID="lblSearchBy" PopupControlID="pnlSearchOption"
                        PopupPosition="Bottom">
                    </asp:HoverMenuExtender>
                    <asp:Panel ID="pnlSearchOption" runat="server" CssClass="modalDrag"
                        Height="25px">
                        <asp:RadioButtonList ID="rdioSearchOption" runat="server" Font-Names="Verdana" Font-Size="10px" 
                        ForeColor="#993300" RepeatDirection="Horizontal" RepeatLayout="Flow">
                            <asp:ListItem Selected="True">All</asp:ListItem>
                            <asp:ListItem Value="PLNumber">PL #</asp:ListItem>
                            <asp:ListItem Value="SINumber">SI #</asp:ListItem>
                        </asp:RadioButtonList>
                    </asp:Panel>
                   
                    <asp:TextBox ID="txtSearchDR" Font-Size="10px" Height="16px" Width="130px" CssClass="modalText" 
                    placeholder="Search Sales Invoice" runat="server" ></asp:TextBox>
                    <asp:ImageButton ID="imgBtnSearchDR" runat="server" ImageAlign="Top" ImageUrl="~/Resources/search.png" OnClick="imgBtnSearchDR_Click" />
                    <asp:ImageButton ID="imgAdvanceSearch" runat="server" ImageUrl="~/Resources/advance_search.png"
                        ToolTip="ADVANCE SEARCH" />
                    <asp:ModalPopupExtender ID="imgAdvanceSearch_ModalPopupExtender" runat="server" DynamicServicePath=""
                        Enabled="True" TargetControlID="imgAdvanceSearch" PopupControlID="pnlAdvanceSearch"
                        PopupDragHandleControlID="pnlAdvanceSearchDrag" CancelControlID="ibtnCloseAdvanceSearch">
                    </asp:ModalPopupExtender>
                    <asp:Panel ID="pnlAdvanceSearch" runat="server" CssClass="modal">
                        <asp:Panel ID="pnlAdvanceSearchDrag" runat="server" CssClass="modalDrag">
                            <div class="close_btn">
                                <asp:ImageButton ID="ibtnCloseAdvanceSearch" runat="server" CssClass="btnClose" ImageUrl="~/Resources/cancel_gray.png"
                                    ToolTip="CLOSE" />
                            </div>
                            <div class="sizeLogo">
                                <img src="../Resources/panels.png" alt="" align="top" />
                                ADVANCE SEARCH OPTION!
                            </div>
                        </asp:Panel>
                        <div style="margin: 5px 3px 5px 5px;">
                            <div style="margin-left: 55px; margin-bottom: 3px;">
                            <label for="MainContent_txtSearchCompany" class="modalLabel">COMPANY:</label>
                                <asp:TextBox ID="txtSearchCompany" runat="server" Width="200px" Height="20px" Enabled="False"></asp:TextBox>
                                <asp:CheckBox ID="chkEnableCompanySearch" runat="server" AutoPostBack="True" Font-Size="10px" Height="20px" CssClass="modalText" 
                                OnCheckedChanged="chkEnableCompanySearch_CheckedChanged" Text="ENABLE" ToolTip="Include Company Name for Searching" />
                            </div>
                            <label for="MainContent_txtDateSeachFrom" class="modalLabel">DATE RANGE:</label>
                            <asp:Label ID="Label3" runat="server" Text="FROM" Font-Names="Verdana" CssClass="modalLabel"
                                Font-Size="11px"></asp:Label>
                            <asp:TextBox ID="txtDateSeachFrom" runat="server" Font-Names="Verdana" Font-Size="11px"
                                Height="20px"></asp:TextBox>
                            <asp:CalendarExtender ID="txtDateSeachFrom_CalendarExtender" runat="server" Enabled="True"
                                TargetControlID="txtDateSeachFrom" Format="MMMM dd, yyyy">
                            </asp:CalendarExtender>
                            <asp:Label ID="Label4" runat="server" Text="TO" Font-Names="Verdana" CssClass="modalLabel"
                                Font-Size="11px"></asp:Label>
                            <asp:TextBox ID="txtDateSeachTo" runat="server" Font-Names="Verdana" Font-Size="11px"
                                Height="20px"></asp:TextBox>
                            <asp:CalendarExtender ID="txtDateSeachTo_CalendarExtender" runat="server" Enabled="True"
                                TargetControlID="txtDateSeachTo" Format="MMMM dd, yyyy">
                            </asp:CalendarExtender>
                            <div style="text-align: center; margin-top: 5px;">
                                <asp:Button ID="btnAdvanceSearch" CssClass="modalWarningButtonYes" runat="server" Text="GO" Font-Bold="True" 
                                OnClick="btnAdvanceSearch_Click" />
                            </div>
                        </div>
                    </asp:Panel>
                 
                </div>
                <asp:Label ID="Label1" runat="server" TabIndex="4"></asp:Label>
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
            </div>
            <div style="float: left;min-height: 435px;">
                <div class="titleList">
                    <asp:Image ID="imgList" runat="server" ImageUrl="~/Resources/panels.png"
                        ImageAlign="AbsMiddle" />
                    LIST OF SALES INVOICE
                </div>
                <div style="min-width: 500px;">
                    <asp:GridView ID="gvSalesInvoice" runat="server" AllowPaging="True" AllowSorting="True"
                        AutoGenerateColumns="False" DataKeyNames="ID" DataSourceID="SqlDataSourceSalesInvoice"
                        CellPadding="4" CssClass="table_grid" GridLines="Horizontal" EnablePersistedSelection="True"
                        OnSelectedIndexChanged="gvSalesInvoice_SelectedIndexChanged" PageSize="12" ToolTip="LIST OF SALES INVOICE"
                        OnPageIndexChanging="gvSalesInvoice_PageIndexChanging" OnSorting="gvSalesInvoice_Sorting"
                        EmptyDataText="EMPTY!!">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:TemplateField>
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Image ID="imgInvoice" AlternateText='<%# Eval("ID") %>' runat="server" Height="16px"
                                        ImageUrl="~/Resources/panels.png" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <EditItemTemplate>
                                    <asp:CheckBox ID="CheckBox1" runat="server" />
                                </EditItemTemplate>
                                <HeaderTemplate>
                                    <asp:CheckBox ID="chkAllSelected" runat="server" ClientIDMode="Static" onclick="SelectAll('MainContent_gvSalesInvoice','chkAllSelected')" />
                                </HeaderTemplate>
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkID" runat="server" />
                                </ItemTemplate>
                                <HeaderStyle Wrap="False" />
                                <ItemStyle Wrap="False" Font-Bold="True" ForeColor="#CC6600" />
                            </asp:TemplateField>
                            <asp:CommandField ShowSelectButton="True" />
                            <asp:BoundField DataField="ID" HeaderText="RECORD #" InsertVisible="False" ReadOnly="True"
                                SortExpression="ID" FooterText="Record#" Visible="False">
                                <HeaderStyle Wrap="False" />
                                <ItemStyle Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="SIID" HeaderText="SI ID" SortExpression="SIID">
                                <HeaderStyle Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="SINo" HeaderText="SALES INVOICE#" SortExpression="SINo">
                                <HeaderStyle Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="SIDate" HeaderText="SALES INVOICE DATE" SortExpression="SIDate"
                                DataFormatString="{0:MMMM dd, yyyy}">
                                <HeaderStyle Wrap="False" />
                                <ItemStyle Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="CustNo" HeaderText="CUSTOMER #" SortExpression="CustNo">
                                <HeaderStyle Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="SoldTo" HeaderText="SOLD TO" SortExpression="SoldTo">
                                <HeaderStyle Wrap="False" />
                                <ItemStyle Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="CustAddr" HeaderText="CUSTOMER ADDRESS" 
                                SortExpression="CustAddr" Visible="False">
                                <HeaderStyle Wrap="False" />
                                <ItemStyle Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="TotalAmt" HeaderText="TOTAL AMOUNT" 
                                SortExpression="TotalAmt" DataFormatString="{0:###,###.00}">
                                <HeaderStyle Wrap="False" />
                                <ItemStyle Wrap="False" Font-Bold="True" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="TotalQty" HeaderText="TOTAL QTY" SortExpression="TotalQty">
                                <HeaderStyle Wrap="False" />
                                <ItemStyle Wrap="False" Font-Bold="True" HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="PLNo" HeaderText="PL #" SortExpression="PLNo">
                                <HeaderStyle Wrap="False" />
                                <ItemStyle Wrap="False" />
                            </asp:BoundField>
                        </Columns>
                        <EditRowStyle BackColor="#7C6F57" />
                        <EmptyDataTemplate>
                            <br />
                            <asp:Image ID="Image4" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/Resources/unhappy.png" />
                            RECORDS NOT FOUND!!!
                        </EmptyDataTemplate>
                        <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                        <PagerSettings FirstPageImageUrl="~/Resources/first.png" LastPageImageUrl="~/Resources/last.png"
                            Mode="NumericFirstLast" PageButtonCount="20" />
                        <PagerStyle CssClass="pager" />
                        <RowStyle BackColor="#E3EAEB" />
                        <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                        <SortedAscendingCellStyle CssClass="asc_cell_style" />
                        <SortedAscendingHeaderStyle CssClass="asc_cell_style_h" />
                        <SortedDescendingCellStyle CssClass="desc_cell_style" />
                        <SortedDescendingHeaderStyle CssClass="desc_cell_style_h" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="SqlDataSourceSalesInvoice" runat="server" ConnectionString="<%$ ConnectionStrings:IRMSConnectionString %>"
                        SelectCommand="SELECT [ID], [SIID], [SINo], [SIDate], [CustNo], [SoldTo], [CustAddr], [TotalAmt], [TotalQty], [PLNo] FROM [SI]   where (ynPosted = 0 and ynCancelled=0 and ynLiquidation=0)  ORDER BY SIDate DESC">
                    </asp:SqlDataSource>
                </div>
            </div>
        
            <asp:Panel ID="pnlSelectedDRPreview" runat="server" CssClass="modal">
                <asp:Panel ID="pnlSelectedDRPreviewDrag" runat="server" CssClass="modalDrag">
                    <div class="close_btn">
                        <asp:ImageButton ID="imgBtnClosepnlSelectedDRPreview" runat="server" CssClass="btnClose"
                            ImageUrl="~/Resources/cancel_gray.png" ToolTip="CLOSE" EnableViewState="False" />
                    </div>
                    <div class="sizeLogo">
                        <img src="../Resources/panels.png" alt="" height="16px" align="top" />
                        Preview Sales Invoice to cancel.
                    </div>
                </asp:Panel>
                <div style="text-align: center;">
                    <asp:Label ID="Label6" CssClass="modalText" runat="server" Text="UNCHECK TO EXCLUDE" Font-Italic="True" Font-Size="10px" ></asp:Label>
                </div>
                <div style="margin-left: 5px; margin-right: 5px;">
                    <asp:GridView ID="gvPreviewSelectedDR" CssClass="table_grid" runat="server" AutoGenerateColumns="False"
                        Font-Names="Verdana" Font-Size="10px" ForeColor="#333333" CellPadding="4" 
                        GridLines="None">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:BoundField DataField="SalesInvoiceNumber" HeaderText="SI NUMBER" />
                            <asp:BoundField DataField="SoldTo" HeaderText="CUSTOMER" />
                            <asp:BoundField DataField="SalesInvoiceDate" HeaderText="SI DATE" DataFormatString="{0:MMMM dd, yyyy}" />
                            <asp:BoundField DataField="PLNumber" HeaderText="PL NUMBER" HtmlEncode="False" />
                            <asp:TemplateField>
                                <EditItemTemplate>
                                    <asp:CheckBox ID="CheckBox1" runat="server" />
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkSelectedSalesInvoice" runat="server" Checked="true" ToolTip='<%# Eval("RecordNo") %>' />
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
                <div style="text-align: center; margin-top: 5px; margin-bottom: 5px;">
                    <asp:Button ID="btnYesCancelSelectedDR" runat="server" Width="100px" Text="CONTINUE" CssClass="modalWarningButtonYes"
                        OnClick="btnYesCancelSelectedDR_Click" />
                </div>
            </asp:Panel>
            <asp:HiddenField ID="hfIsAdvanceSearch" runat="server" />
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
