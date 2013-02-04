<%@ Page Title="" Language="C#" MasterPageFile="~/WareHouse/WareHouse.Master" AutoEventWireup="true"
    CodeBehind="ForwarderManagementPanel.aspx.cs" Inherits="IntegratedResourceManagementSystem.WareHouse.ForwarderManagementPanel" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register TagPrefix="forms" TagName="Brand" Src="~/WareHouse/forms/ForwarderForm.ascx" %>
<%@ Register Src="~/WareHouse/controls/UCLoader.ascx" TagName="LOADER" TagPrefix="UC" %>
<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <link href="../Styles/forwarder-management.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div style="min-height: 550px;">
        <div class="titlePanel">
            <img src="../Resources/HWcar-5-icon (3).png" alt="" height="30px" align="top" />
            Forwarder Management Panel
        </div>
        <hr />
        <asp:UpdatePanel ID="upnlBrands" runat="server">
            <ContentTemplate>
                <div style="height: 26px; margin-bottom: 1px;" class="modalDrag">
                    <div class="SearchTextContainer">
                        SEARCH:
                        <asp:TextBox ID="txtSearch" runat="server" autofocus placeholder="Search Forwarder"
                            CssClass="modalText" AutoPostBack="True" Height="16px" Font-Size="10px" Width="150px"
                            OnTextChanged="txtSearch_TextChanged"></asp:TextBox>
                        <asp:ImageButton ID="imgBtnSearch" runat="server" ImageAlign="AbsBottom" ImageUrl="~/Resources/search.png"
                            ToolTip="SEARCH" OnClick="imgBtnSearch_Click" />
                    </div>
                    <div style="float: left;">
                        <div style="float: left; margin-right: 5px;">
                            <asp:Button ID="btnNewBrand" runat="server" Text="NEW" CssClass="btnNew" Font-Names="Verdana"
                                OnClick="btnNewBrand_Click" />
                        </div>
                        <div style="float: left; margin-right: 5px;">
                            <asp:Button ID="btnUpdateBrand" runat="server" Text="UPDATE" CssClass="btnUpdate"
                                Font-Names="Verdana" />
                            <asp:ModalPopupExtender ID="btnUpdateBrand_ModalPopupExtender" runat="server" CancelControlID="imgBtnCloseUpdateSizeModal"
                                DynamicServicePath="" Enabled="True" PopupControlID="pnlUpdateSizeModal" PopupDragHandleControlID="pnlUpdateSizeModalDrag"
                                TargetControlID="btnUpdateBrand" BackgroundCssClass="bgModal">
                                <Animations>
                                        <OnShown>
                                            <FadeIn Duration=".2" />
                                        </OnShown>
                                </Animations>
                            </asp:ModalPopupExtender>
                        </div>
                        <div style="float: left; margin-right: 5px;">
                            <asp:Button ID="btnDelete" runat="server" Text="DELETE" CssClass="btnDelete" Font-Names="Verdana" />
                            <asp:ModalPopupExtender ID="btnDelete_ModalPopupExtender" runat="server" CancelControlID="btnNo"
                                DynamicServicePath="" Enabled="True" PopupControlID="pnlDeleteModal" PopupDragHandleControlID="pnlDeleteModalDrag"
                                TargetControlID="btnDelete" BackgroundCssClass="bgModal">
                                <Animations>
                                        <OnShown>
                                            <FadeIn Duration=".2" />
                                        </OnShown>
                                </Animations>
                            </asp:ModalPopupExtender>
                        </div>
                        <div style="float: left; margin-right: 5px;">
                            <asp:Button ID="btnViewCustomers" runat="server" Text="VIEW CUSTOMERS" CssClass="btnPrint"
                                Font-Names="Verdana" Font-Size="10px" />
                            <asp:ModalPopupExtender ID="btnViewCustomers_ModalPopupExtender" runat="server" DynamicServicePath=""
                                Enabled="True" TargetControlID="btnViewCustomers" BackgroundCssClass="bgModal"
                                PopupControlID="pnlPreviewCustomersModal" PopupDragHandleControlID="pnlPreviewCustomersModalDrag"
                                CancelControlID="imgBtnClosepnlPreviewCustomersModal">
                                <Animations>
                    <OnShown>
                        <FadeIn Duration=".2" />
                    </OnShown>
                                </Animations>
                            </asp:ModalPopupExtender>
                        </div>
                        <div style="float: left; margin-right: 5px;">
                            <asp:Button ID="btnPrint" runat="server" Text="PRINT" CssClass="btnPrint" Font-Names="Verdana" />
                        </div>
                        <div style="float: left; margin-left: 5px;">
                            <asp:UpdateProgress ID="uprogLoader" runat="server" AssociatedUpdatePanelID="upnlBrands">
                                <ProgressTemplate>
                                    <asp:PlaceHolder ID="plcHldrLoader" runat="server">
                                        <UC:LOADER ID="loader" runat="server" />
                                    </asp:PlaceHolder>
                                </ProgressTemplate>
                            </asp:UpdateProgress>
                        </div>
                    </div>
                </div>
                <div class="listContent" style="float:left;">
                    <div class="titleList">
                        <img src="../Resources/forwarder.png" alt="" height ="16px" width="20px" align="top" />
                        LIST OF BRANDS
                    </div>
                    <div style="margin-bottom: 10px;">
                        <asp:GridView ID="gvForwarders" runat="server" CellPadding="4" GridLines="None" AutoGenerateColumns="False"
                            CssClass="table_grid" AllowPaging="True" AllowSorting="True" DataSourceID="SqlDataSourceForwarder"
                            OnSelectedIndexChanged="gvForwarders_SelectedIndexChanged" PageSize="15" DataKeyNames="RECORD_NUMBER"
                            EnablePersistedSelection="True" Font-Size="11px">
                            <AlternatingRowStyle BackColor="White" />
                            <Columns>
                                <asp:TemplateField>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Image ID="imgRecordNumber" runat="server" Height="16px" ImageUrl="~/Resources/forwarder.png"
                                            AlternateText='<%# Eval("RECORD_NUMBER") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:CommandField ShowSelectButton="True" />
                                <asp:BoundField DataField="FORWARDER_NAME" HeaderText="FORWARDER NAME" SortExpression="FORWARDER_NAME">
                                    <HeaderStyle Wrap="False" />
                                    <ItemStyle Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="FORWARDER_ADDRESS" HeaderText="FORWARDER ADDRESS" SortExpression="FORWARDER_ADDRESS">
                                    <HeaderStyle Wrap="False" />
                                    <ItemStyle Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="FORWARDER_CONTACT" HeaderText="FORWARDER CONTACT" SortExpression="FORWARDER_CONTACT">
                                    <HeaderStyle Wrap="False" />
                                    <ItemStyle Wrap="False" />
                                </asp:BoundField>
                                <asp:BoundField DataField="DATE_RECORDED" HeaderText="DATE RECORDED" SortExpression="DATE_RECORDED">
                                    <HeaderStyle Wrap="False" />
                                    <ItemStyle Wrap="False" />
                                </asp:BoundField>
                            </Columns>
                            <EditRowStyle BackColor="#7C6F57" />
                            <EmptyDataTemplate>
                                <asp:Image ID="Image2" runat="server" ImageUrl="~/Resources/unhappy.png" ImageAlign="AbsMiddle" />
                                RECORDS NOT FOUND!!!
                            </EmptyDataTemplate>
                            <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                            <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="#eaf7ff" />
                            <PagerStyle CssClass="pager" />
                            <RowStyle BackColor="#E3EAEB" />
                            <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="False" ForeColor="#333333" Font-Names="Verdana"
                                Font-Size="11px" Font-Italic="True" />
                            <SortedAscendingCellStyle CssClass="asc_cell_style" />
                            <SortedAscendingHeaderStyle CssClass="asc_cell_style_h" />
                            <SortedDescendingCellStyle CssClass="desc_cell_style" />
                            <SortedDescendingHeaderStyle CssClass="desc_cell_style_h" />
                        </asp:GridView>
                        <asp:SqlDataSource ID="SqlDataSourceForwarder" runat="server" ConnectionString="<%$ ConnectionStrings:IRMSConnectionString %>"
                            SelectCommand="SELECT [RECORD_NUMBER], [FORWARDER_NAME], [FORWARDER_ADDRESS], [FORWARDER_CONTACT], [DATE_RECORDED] FROM [FORWARDERS]">
                        </asp:SqlDataSource>
                    </div>
                </div>
                <asp:Panel ID="pnlPreviewCustomersModal" runat="server" CssClass="modal">
                    <asp:Panel ID="pnlPreviewCustomersModalDrag" runat="server" CssClass="modalDrag">
                        <div class="close_btn">
                            <asp:ImageButton ID="imgBtnClosepnlPreviewCustomersModal" runat="server" CssClass="btnClose"
                                ImageUrl="~/Resources/cancel_gray.png" ToolTip="CLOSE" />
                        </div>
                        <div class="sizeLogo">
                            <img src="../Resources/forwarder.png" alt="" height="16px" align="top"  />
                            LIST OF CUSTOMER/S &nbsp;
                            <asp:Label ID="lblForwarder" runat="server" Text="Label"></asp:Label>
                        </div>
                    </asp:Panel>
                    <div style="margin: 5px 5px 7px 5px;">
                    <div style="height:35px;">
                        <div style="float:left;">
                            <div class="SearchTextContainer">
                            FILTER:
                                <asp:DropDownList ID="DDLBrands" CssClass="modalText" Height="22px" 
                                    runat="server" AutoPostBack="True" 
                                    onselectedindexchanged="DDLBrands_SelectedIndexChanged">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="SearchTextContainer">
                         SEARCH: 
                            <asp:TextBox ID="txtSearchCustomer" CssClass="modalText" Width="120px" 
                                Height="16px" runat="server" ontextchanged="txtSearchCustomer_TextChanged"></asp:TextBox>
                              <asp:ImageButton ID="ibtnSearchCustomerForwarder" runat="server" 
                                ImageAlign="AbsBottom" ImageUrl="~/Resources/search.png"
                            ToolTip="SEARCH" onclick="ibtnSearchCustomerForwarder_Click" />
                        </div>
                    </div>
                        <asp:Panel ID="pnlForwrderCustomers" runat="server" ScrollBars="Auto">
                            <asp:HiddenField ID="hfRecordNo" runat="server" />
                            <asp:GridView ID="gvCustomers" runat="server" BackColor="LightGoldenrodYellow" BorderColor="Tan"
                                BorderWidth="1px" CellPadding="2" Font-Names="Verdana" Font-Size="10px" ForeColor="Black"
                                GridLines="None" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False"
                                DataSourceID="SqlDataSourceForwarderCustomers" OnSelectedIndexChanged="gvCustomers_SelectedIndexChanged"
                                OnSorting="gvCustomers_Sorting" 
                                OnPageIndexChanging="gvCustomers_PageIndexChanging" DataKeyNames="CustNo">
                                <AlternatingRowStyle BackColor="PaleGoldenrod" />
                                <Columns>
                                    <asp:TemplateField>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Image ID="imgCustomer" runat="server" Height="16px" ImageUrl="~/Resources/panels.png"
                                                AlternateText='<%# Eval("RECORD_NO") %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:CommandField ShowSelectButton="True" />
                                    <asp:BoundField DataField="CompName" HeaderText="NAME" SortExpression="CompName" />
                                    <asp:BoundField DataField="brand" HeaderText="BRAND" SortExpression="brand" />
                                </Columns>
                                <FooterStyle BackColor="Tan" />
                                <HeaderStyle BackColor="Tan" Font-Bold="True" />
                                <PagerSettings Mode="NumericFirstLast" />
                                <PagerStyle BackColor="PaleGoldenrod" ForeColor="DarkSlateBlue" HorizontalAlign="Center" />
                                <SelectedRowStyle BackColor="DarkSlateBlue" ForeColor="GhostWhite" />
                                <SortedAscendingCellStyle BackColor="#FAFAE7" />
                                <SortedAscendingHeaderStyle BackColor="#DAC09E" />
                                <SortedDescendingCellStyle BackColor="#E1DB9C" />
                                <SortedDescendingHeaderStyle BackColor="#C2A47B" />
                            </asp:GridView>
                            <asp:SqlDataSource ID="SqlDataSourceForwarderCustomers" runat="server" ConnectionString="<%$ ConnectionStrings:IRMSConnectionString %>"
                                SelectCommand="SELECT FORWARDER_CUSTOMERS.RECORD_NO, CustInfo.CompName, CustInfo.brand,CustNo FROM CustInfo INNER JOIN FORWARDER_CUSTOMERS ON CustInfo.CustNo = FORWARDER_CUSTOMERS.CUSTOMER_NO WHERE ( FORWARDER_CUSTOMERS.FORWARDER_NO = @forwarder_no)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="hfRecordNo" Name="forwarder_no" PropertyName="Value" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </asp:Panel>
                    </div>
                    <div style="margin-top: 5px; margin-bottom: 5px; height: 30px; float: left;
                        margin-left: 10px; text-align: center;">
                        <asp:Button ID="btnRemoveCustomer" runat="server" Font-Size="9px" CssClass="btnDelete" Text="REMOVE"
                            ToolTip="Remove Selected Customer/s" Font-Names="Verdana" OnClick="btnRemoveCustomer_Click" />
                        <asp:ModalPopupExtender ID="btnRemoveCustomer_ModalPopupExtender" runat="server"
                            CancelControlID="btnConfirmRemoveCustomerNo" DynamicServicePath="" Enabled="True"
                            PopupControlID="pnlRemoveCustomer" PopupDragHandleControlID="pnlRemoveCustomerDrag"
                            TargetControlID="btnRemoveCustomer">
                        </asp:ModalPopupExtender>
                    </div>
                    <div style="text-align: center; margin-top: 5px; margin-bottom: 5px; height: 30px;
                        float: left;">
                        <asp:Button ID="btnChangeForwarder" runat="server" Font-Size="9px" CssClass="btnUpdate" Text="CHANGE FORWARDER"
                            ToolTip="Change forwarder"  />
                        <asp:ModalPopupExtender ID="btnChangeForwarder_ModalPopupExtender" runat="server"
                            CancelControlID="imgBtnClosepnlChangeForwarderModal" DynamicServicePath="" Enabled="True"
                            PopupControlID="pnlChangeForwarderModal" PopupDragHandleControlID="pnlChangeForwarderModalDrag"
                            TargetControlID="btnChangeForwarder">
                        </asp:ModalPopupExtender>
                    </div>
                    <div style="text-align: center; margin-top: 5px; margin-bottom: 5px; height: 30px;
                        float: left; ">
                       <asp:Button ID="btnAddCustomer" runat="server" Font-Size="9px" CssClass="btnNew" Text="ADD CUSTOMER"
                            ToolTip="Add Customer" OnClick="btnAddCustomer_Click" PostBackUrl="~/WareHouse/AddForwarderCustomers.aspx" />
                    </div>
                    <div style="text-align: center; margin-top: 5px; margin-right:5px; margin-bottom: 5px; height: 30px;
                        float: left; ">
                         <asp:Button ID="btnOtherForwarder" runat="server" Font-Size="9px"  CssClass="btnUpdate" Text="OTHER FORWARDERS"
                            ToolTip="View Other Related Forwarders"  />
                         <asp:ModalPopupExtender ID="btnOtherForwarder_ModalPopupExtender" 
                             runat="server" DynamicServicePath="" Enabled="True" 
                             TargetControlID="btnOtherForwarder" 
                             CancelControlID="imbBtnPnlOtherForwarderModal" 
                             PopupControlID="pnlOtherForwarderModal" 
                             PopupDragHandleControlID="pnlOtherForwarderModalDrag">
                         </asp:ModalPopupExtender>
                        
                    </div>
                </asp:Panel>
                <asp:Panel ID="pnlUpdateSizeModal" runat="server" CssClass="modal">
                    <asp:Panel ID="pnlUpdateSizeModalDrag" runat="server" CssClass="modalDrag">
                        <div class="close_btn">
                            <asp:ImageButton ID="imgBtnCloseUpdateSizeModal" runat="server" CssClass="btnClose"
                                ImageUrl="~/Resources/cancel_gray.png" ToolTip="CLOSE" />
                        </div>
                        <div class="sizeLogo">
                            <img src="../Resources/forwarder.png" alt="" height="16px" align="top" />
                            UPDATE BRAND
                        </div>
                    </asp:Panel>
                        <forms:Brand ID="fforwarder_update" runat="server"></forms:Brand>
                    <asp:Panel ID="pnlUpdateMessage" runat="server">
                        <div style="border: 1px solid #FFCC66; text-align: center; background-color: #FFFFCC;
                            color: #FF9933;">
                            <img alt="" src="../Resources/warning.png" align="middle" />
                            <label>
                                No data to update!</label>
                        </div>
                    </asp:Panel>
                    <div style="text-align: center; margin: 5px;">
                        <asp:Button ID="btnSaveUpdate" runat="server" CssClass="btnSave" OnClick="btnSaveUpdate_Click"
                            Text="SAVE" ToolTip="Update Color" />
                    </div>
                </asp:Panel>
                <asp:Panel ID="pnlChangeForwarderModal" runat="server" CssClass="modal">
                    <asp:Panel ID="pnlChangeForwarderModalDrag" runat="server" CssClass="modalDrag">
                        <div class="close_btn">
                            <asp:ImageButton ID="imgBtnClosepnlChangeForwarderModal" runat="server" CssClass="btnClose"
                                ImageUrl="~/Resources/cancel_gray.png" ToolTip="CLOSE" />
                        </div>
                        <div class="sizeLogo">
                            <img src="../Resources/forwarder.png" alt="" height="16px" align="top"  />
                            Change Forwarder
                        </div>
                    </asp:Panel>
                    <div style="margin: 5px 5px 5px 5px;">
                        <asp:Label ID="Label5" CssClass="modalLabel" runat="server" Text="CUSTOMER: "></asp:Label>
                        <asp:Label ID="lblCustomerName" runat="server" Text="Label" Font-Names="Verdana"
                            Font-Size="11px" ForeColor="#FFFFCC"></asp:Label>
                        <br />
                        <asp:Label ID="Label2" CssClass="modalLabel" runat="server" Text="OLD FORWARDER: " ></asp:Label>
                        <asp:Label ID="lblFromForwarder" runat="server" Text="Label" Font-Names="Verdana"
                            Font-Size="11px" ForeColor="#FFFFCC"></asp:Label>
                    </div>
                    <div style="margin-top: 20px; margin-left: 10px;">
                        <asp:Label ID="Label3" CssClass="modalLabel" runat="server" Text="NEW FORWARDER: " ></asp:Label>
                        <asp:DropDownList ID="dlForwarders" CssClass="modalText" runat="server" DataSourceID="SqlDataSourceForwardersForUpdate"
                            DataTextField="FORWARDER_NAME" DataValueField="RECORD_NUMBER" Font-Size="11px"  Height="20px">
                        </asp:DropDownList>
                        <asp:ListSearchExtender ID="dlForwarders_ListSearchExtender" runat="server" Enabled="True"
                            TargetControlID="dlForwarders">
                        </asp:ListSearchExtender>
                        <asp:SqlDataSource ID="SqlDataSourceForwardersForUpdate" runat="server" ConnectionString="<%$ ConnectionStrings:IRMSConnectionString %>"
                            SelectCommand="SELECT [RECORD_NUMBER], [FORWARDER_NAME] FROM [FORWARDERS]"></asp:SqlDataSource>
                    </div>
                    <div style="text-align: center; margin-top: 5px; margin-bottom: 5px;">
                        <asp:Button ID="btnChangeSave" runat="server" CssClass="btnSave" Width="120px" Text="SAVE CHANGES"
                            title="Change Forwarder"  OnClick="btnChangeSave_Click" />
                    </div>
                </asp:Panel>
                <%--Delete Modal--%>
                <asp:Panel ID="pnlDeleteModal" runat="server" CssClass="modal">
                    <asp:Panel ID="pnlDeleteModalDrag" runat="server" CssClass="modalDrag">
                        <div class="sizeLogo">
                            <img src="../Resources/forwarder.png" alt="" height="16px" align="top" />
                            CONFIRMATION!!!
                        </div>
                    </asp:Panel>
                    <div style="text-align: center; padding:5px;" class="modalLabel">
                        <asp:Label ID="lblForwarderToDelete" runat="server" Text="No data to delete!"></asp:Label>
                    </div>
                    <div style="border: 1px solid #FFCC66; text-align: center; background-color: #FFFFCC;
                        color: #FF9933; margin: 5px 3px;">
                        <img alt="" src="../Resources/warning.png" align="middle" />
                        <label>
                            Warning: you cannot undo this action!</label>
                    </div>
                    <div style="text-align: center; margin: 12px 5px;">
                        <asp:Button ID="btnYes" runat="server" Text="YES" CssClass="modalWarningButtonYes"
                            ToolTip="Delete" OnClick="btnYes_Click" />
                        <asp:Button ID="btnNo" runat="server" Text="NO" CssClass="modalWarningButtonNo" ToolTip="Cancel" />
                    </div>
                </asp:Panel>
                <%--Remove Customer Modal--%>
                <asp:Panel ID="pnlRemoveCustomer" runat="server" CssClass="modal">
                    <asp:Panel ID="pnlRemoveCustomerDrag" runat="server" CssClass="modalDrag">
                       <div class="sizeLogo">
                            <img src="../Resources/forwarder.png" alt="" height="16px" align="top" />
                            CONFIRMATION!!!
                        </div>
                    </asp:Panel>
                    <div style="text-align: center; padding:5px;" class="modalLabel">
                        <asp:Label ID="lblOutletTobeDeleted" runat="server" Text="No Selected data!"></asp:Label>
                    </div>
                    <div style="border: 1px solid #FFCC66; text-align: center; background-color: #FFFFCC;
                        color: #FF9933; margin: 5px 3px;">
                        <img alt="" src="../Resources/warning.png" align="middle" />
                        <label>
                            Warning: you cannot undo this action!</label>
                    </div>
                    <div style="text-align: center; margin-top: 12px;">
                        <asp:Button ID="btnConfirmRemoveCustomerYes" runat="server" Text="YES" CssClass="modalWarningButtonYes"
                            ToolTip="Delete" OnClick="btnConfirmRemoveCustomerYes_Click" />
                        <asp:Button ID="btnConfirmRemoveCustomerNo" runat="server" Text="NO" CssClass="modalWarningButtonNo"
                            ToolTip="Cancel" />
                    </div>
                </asp:Panel>
                <asp:Panel ID="pnlOtherForwarderModal" runat="server" CssClass="modal">
                    <asp:Panel ID="pnlOtherForwarderModalDrag" CssClass="modalDrag" runat="server">  
                     <div class="close_btn">
                            <asp:ImageButton ID="imbBtnPnlOtherForwarderModal" runat="server" CssClass="btnClose"
                                ImageUrl="~/Resources/cancel_gray.png" ToolTip="CLOSE" />
                        </div>
                        <div class="sizeLogo">
                            <img src="../Resources/forwarder.png" alt="" height="16px" align="top"  />
                            Other Customer Forwarder
                        </div>
                    </asp:Panel>  
                    <div style="text-align:center; height:26px; margin-top:3px;">
                        <asp:Button ID="btnSetAsDefaultForwarder"  Font-Size="9px" Visible="false" CssClass="btnUpdate" 
                            runat="server" Text="SET AS DEFAULT FORWARDER" 
                            onclick="btnSetAsDefaultForwarder_Click" />
                    </div>
                    <div style="margin:0 5px 5px 5px;">
                    <asp:GridView ID="gvOtherForwarder" runat="server" CssClass="table_grid" AutoGenerateColumns="False" 
                        DataSourceID="SqlDataSourceCustomerForwarders" CellPadding="4" 
                        ForeColor="#333333" GridLines="None" 
                            onselectedindexchanged="gvOtherForwarder_SelectedIndexChanged" 
                            DataKeyNames="RECORD_NO,IS_DEFAULT,CUSTOMER_NO,FORWARDER_NO">
                        <AlternatingRowStyle BackColor="White" />
                        <Columns>
                            <asp:TemplateField>
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:Image ID="Image1" runat="server" ImageUrl="~/Resources/forwarder.png" Height="16px" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:CommandField ShowSelectButton="True" />
                            <asp:BoundField DataField="FORWARDER_NAME" HeaderText="FORWARDER" 
                                SortExpression="FORWARDER_NAME" />
                            <asp:BoundField DataField="CUSTOMER_NO" HeaderText="CUSTOMER_NO" 
                                SortExpression="CUSTOMER_NO" Visible="False" />
                            <asp:CheckBoxField DataField="IS_DEFAULT" HeaderText="DEFAULT FF" 
                                SortExpression="IS_DEFAULT" >
                            <ItemStyle HorizontalAlign="Center" />
                            </asp:CheckBoxField>
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
                    <asp:SqlDataSource ID="SqlDataSourceCustomerForwarders" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:IRMSConnectionString %>" SelectCommand="SELECT FORWARDER_CUSTOMERS.RECORD_NO, FORWARDERS.FORWARDER_NAME, FORWARDER_CUSTOMERS.CUSTOMER_NO,IS_DEFAULT,FORWARDER_NO FROM FORWARDERS INNER JOIN FORWARDER_CUSTOMERS ON FORWARDERS.RECORD_NUMBER = FORWARDER_CUSTOMERS.FORWARDER_NO
where FORWARDER_CUSTOMERS.CUSTOMER_NO = @CUSTOMER_NUMBER">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="gvCustomers" Name="CUSTOMER_NUMBER" 
                                PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    </div>
                    
                </asp:Panel>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
