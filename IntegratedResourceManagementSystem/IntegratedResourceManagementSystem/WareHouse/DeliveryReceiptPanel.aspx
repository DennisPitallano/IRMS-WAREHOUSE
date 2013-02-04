<%@ Page Title="" Language="C#" MasterPageFile="~/WareHouse/WareHouse.Master" AutoEventWireup="true"
    CodeBehind="DeliveryReceiptPanel.aspx.cs" Inherits="IntegratedResourceManagementSystem.WareHouse.DeliveryReceiptPanel" %>

<%@ OutputCache CacheProfile="cached_profile" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="~/WareHouse/controls/UCLoader.ascx" TagName="LOADER" TagPrefix="UC" %>
<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <link href="../Styles/deliveries.css" rel="stylesheet" type="text/css" />
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
        <img src="../Resources/panels.png" alt="" align="top"  />
        Manage Deliveries Panel
    </div>
    <asp:UpdatePanel ID="upnlDeliveryReceipts" runat="server">
        <ContentTemplate>
            <div style="margin-bottom: 1px; height: 30px;" class="modalDrag">
                <div style="float: left;">
                 <asp:UpdateProgress ID="upDeliveryReceiptsSlip" runat="server" AssociatedUpdatePanelID="upnlDeliveryReceipts"
                                    DisplayAfter="500">
                                    <ProgressTemplate>
                                        <asp:PlaceHolder ID="plcHldrLoader" runat="server">
                                            <UC:LOADER ID="loader" runat="server" />
                                        </asp:PlaceHolder>
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                    <asp:Button ID="btnPreviewSelectedDRForcancel" Height="28px" runat="server" OnClick="btnCancelSelectedDR_Click"
                        Text="" CssClass="btnDelete" />
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
                </div>
                <div style="float: left;">
                    <asp:HyperLink ID="hpLinkDeliveryDetails" Height="28px" CssClass="btnPrint" Target="_blank"
                        runat="server">DELIVERY DETAILS</asp:HyperLink>
                </div>
                <div style="float: left; height: 24px; padding-right: 5px;" class="SearchTextContainer">
                    FILTER:<asp:RadioButtonList ID="rdioFilterView" CssClass="filterContainer" runat="server"
                        Font-Names="Verdana" Font-Size="10px" ForeColor="#993300" RepeatDirection="Horizontal"
                        RepeatLayout="Flow" AutoPostBack="True" OnSelectedIndexChanged="rdioFilterView_SelectedIndexChanged">
                        <asp:ListItem Selected="True" Value="UNPOSTED">UNPOSTED</asp:ListItem>
                        <asp:ListItem>POSTED</asp:ListItem>
                        <asp:ListItem Value="CANCELLED">CANCELLED</asp:ListItem>
                    </asp:RadioButtonList>
                    &nbsp; &nbsp;
                </div>
                <div class="SearchTextContainer">
                    <asp:Label ID="lblSearchBy" runat="server" Text="SEARCH BY:" CssClass="search_option"
                        EnableViewState="False"></asp:Label>
                    <asp:HoverMenuExtender ID="lblSearchBy_HoverMenuExtender" runat="server" DynamicServicePath=""
                        Enabled="True" TargetControlID="lblSearchBy" PopupControlID="pnlSearchOption"
                        PopupPosition="Bottom" OffsetY="5" OffsetX="-10">
                    </asp:HoverMenuExtender>
                    <asp:Panel ID="pnlSearchOption" runat="server" class="SearchTextContainer"
                        Height="25px">
                        <asp:RadioButtonList ID="rdioSearchOption" CssClass="filterContainer" 
                            runat="server" Font-Names="Verdana" 
                           RepeatDirection="Horizontal" Font-Size="10px" ForeColor="#993300" 
                            RepeatLayout="Flow">
                            <asp:ListItem Selected="True">All</asp:ListItem>
                            <asp:ListItem Value="PLNumber">PL #</asp:ListItem>
                            <asp:ListItem Value="DRNumber">DR #</asp:ListItem>
                        </asp:RadioButtonList>
                    </asp:Panel>
                    <asp:TextBox ID="txtSearchDR" Font-Size="10px" Height="16px" Width="130px" CssClass="modalText" 
                    placeholder="Search Deliveries" runat="server"></asp:TextBox>
                    <asp:ImageButton ID="imgBtnSearchDR" runat="server" ImageAlign="Top" ImageUrl="~/Resources/search.png"
                        ToolTip="Search Delivery Receipt" OnClick="imgBtnSearchDR_Click" />
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
                                <img src="../Resources/panels.png" alt="" align="middle" />
                                ADVANCE SEARCH OPTION!
                            </div>
                        </asp:Panel>
                        <div style="margin: 5px 3px 5px 5px;">
                            <div style="margin-left: 55px; margin-bottom: 3px;">
                                <label for="MainContent_txtSearchCompany" class="modalLabel" >COMPANY:</label>
                                <asp:TextBox ID="txtSearchCompany" runat="server" Width="200px" Height="20px" Enabled="False"></asp:TextBox>
                                <asp:CheckBox ID="chkEnableCompanySearch" Font-Size="10px" Height="20px" CssClass="modalText" runat="server" AutoPostBack="True" 
                                OnCheckedChanged="chkEnableCompanySearch_CheckedChanged" Text="ENABLE" ToolTip="Include Company Name for Searching" />
                            </div>
                            <asp:Label ID="Label2" runat="server" CssClass="modalLabel" Text="DATE RANGE:"></asp:Label>
                            <asp:Label ID="Label3" runat="server" Text="FROM" CssClass="modalLabel"></asp:Label>
                            <asp:TextBox ID="txtDateSeachFrom" runat="server" Font-Names="Verdana" Font-Size="11px"
                                Height="20px"></asp:TextBox>
                            <asp:CalendarExtender ID="txtDateSeachFrom_CalendarExtender" runat="server" Enabled="True"
                                TargetControlID="txtDateSeachFrom" Format="MMMM dd, yyyy">
                            </asp:CalendarExtender>
                            <asp:Label ID="Label4" runat="server" Text="TO" CssClass="modalLabel"></asp:Label>
                            <asp:TextBox ID="txtDateSeachTo" runat="server" Font-Names="Verdana" Font-Size="11px"
                                Height="20px"></asp:TextBox>
                            <asp:CalendarExtender ID="txtDateSeachTo_CalendarExtender" runat="server" Enabled="True"
                                TargetControlID="txtDateSeachTo" Format="MMMM dd, yyyy">
                            </asp:CalendarExtender>
                            <div style="text-align: center; margin-top: 5px;">
                                <asp:Button ID="btnAdvanceSearch" CssClass="modalWarningButtonYes" runat="server" Text="GO" OnClick="btnAdvanceSearch_Click" />
                            </div>
                        </div>
                    </asp:Panel>
                </div>
            </div>
            <div style="float: left; min-width: 500px; 
                margin-right: 2px;">
                <div class="titleList">
                     <img src="../Resources/panels.png" alt="" align="top"  />
                    LIST OF DELIVERIES
                </div>
                <div style="margin-bottom:10px;">
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
                                    <asp:Image ID="imgDelivery" runat="server" ToolTip='<%# Eval("ID") %>' ImageUrl="~/Resources/panels.png" Height="17" />
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
                                    <asp:CheckBox ID="chkID" runat="server"  />
                                </ItemTemplate>
                                <HeaderStyle Wrap="False" />
                                <ItemStyle Font-Bold="True" ForeColor="#CC6600" HorizontalAlign="Center" Wrap="False" />
                            </asp:TemplateField>
                            <asp:CommandField ShowSelectButton="True" />
                            <asp:BoundField DataField="ID" HeaderText="RECORD#" InsertVisible="False" ReadOnly="True"
                                SortExpression="ID" Visible="False">
                                <HeaderStyle Wrap="False" />
                                <ItemStyle Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="DRNo" HeaderText="DR #" SortExpression="DRNo">
                                <HeaderStyle Wrap="False" />
                                <ItemStyle Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="DRDate" DataFormatString="{0:MMMM dd, yyyy}" HeaderText="DR DATE"
                                SortExpression="DRDate">
                                <HeaderStyle Wrap="False" />
                                <ItemStyle Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="PLNo" HeaderText="PL#" SortExpression="PLNo" HtmlEncode="False">
                                <HeaderStyle Wrap="False" />
                                <ItemStyle Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="CustNo" HeaderText="CUST #" SortExpression="CustNo">
                                <HeaderStyle Wrap="False" />
                                <ItemStyle Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="DeliveredTo" HeaderText="DELIVERED TO" SortExpression="DeliveredTo"
                                HtmlEncode="False">
                                <HeaderStyle Wrap="False" />
                                <ItemStyle Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="CustAddr" HeaderText="CUSTOMER ADDRESS" SortExpression="CustAddr">
                                <HeaderStyle Wrap="False" />
                                <ItemStyle Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="TotalQty" HeaderText="TOTAL QTY" SortExpression="TotalQty">
                                <HeaderStyle Wrap="False" />
                                <ItemStyle Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="TotalAmt" DataFormatString="{0:Php###,###.00}" HeaderText="TOTAL AMOUNT"
                                SortExpression="TotalAmt">
                                <HeaderStyle Wrap="False" />
                                <ItemStyle Wrap="False" />
                            </asp:BoundField>
                            <asp:BoundField DataField="ItemStatus" HeaderText="STATUS" SortExpression="ItemStatus" />
                        </Columns>
                        <EditRowStyle BackColor="#7C6F57" />
                        <EmptyDataTemplate>
                            <br />
                            <asp:Image ID="Image4" runat="server" ImageAlign="AbsMiddle" ImageUrl="~/Resources/unhappy.png" />
                            RECORDS NOT FOUND!!!
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
                        SelectCommand="SELECT [ID], [DRNo], [DRDate], [PLNo], [CustNo], [DeliveredTo], [CustAddr], [TotalQty], [TotalAmt], [ItemStatus] FROM [DR]   where (ynPosted =0 and ynCancelled =0) ORDER BY DRDate DESC">
                    </asp:SqlDataSource>
                </div>
            </div>
            <asp:Panel ID="pnlSelectedDRPreview" runat="server" CssClass="modal">
                <asp:Panel ID="pnlSelectedDRPreviewDrag" runat="server" CssClass="modalDrag">
                    <div class="close_btn">
                        <asp:ImageButton ID="imgBtnClosepnlSelectedDRPreview" runat="server" CssClass="btnClose"
                            ImageUrl="~/Resources/cancel_gray.png" ToolTip="CLOSE" />
                    </div>
                    <div class="sizeLogo">
                        <img src="../Resources/panels.png" alt="" height="16px" align="top" />
                        Preview Selected Deliveries
                    </div>
                </asp:Panel>
                <div style="text-align: center;">
                    <asp:Label ID="Label6" runat="server" CssClass="modalText" Text="UNCHECK TO EXCLUDE" Font-Bold="true" 
                        Font-Italic="True" Font-Size="10px"></asp:Label>
                </div>
                <div style="margin-left: 5px; margin-right: 5px;">
                    <asp:GridView ID="gvPreviewSelectedDR" CssClass="table_grid" runat="server" AutoGenerateColumns="False"
                        Font-Names="Verdana" Font-Size="10px" ForeColor="#333333" CellPadding="4" 
                        GridLines="None">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:BoundField DataField="DeliveryReceiptNumber" HeaderText="DR NUMBER" />
                            <asp:BoundField DataField="DeliveredTo" HeaderText="CUSTOMER" />
                            <asp:BoundField DataField="DRDate" HeaderText="DR DATE" DataFormatString="{0:MMMM dd, yyyy}" />
                            <asp:BoundField DataField="PLNumber" HeaderText="PL NUMBER" HtmlEncode="False" />
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
                <div style="text-align: center; margin-top: 5px; margin-bottom: 5px;">
                    <asp:Button ID="btnYesCancelSelectedDR" runat="server" Width="100px" Text="CONTINUE" CssClass="modalWarningButtonYes"
                        OnClick="btnYesCancelSelectedDR_Click" />
                    
                </div>
            </asp:Panel>
            <asp:HiddenField ID="hfIsAdvanceSearch" runat="server" />
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
