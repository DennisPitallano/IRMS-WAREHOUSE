<%@ Page Title="" Language="C#" MasterPageFile="~/WareHouse/WareHouse.Master" AutoEventWireup="true" CodeBehind="NewForwarderForm.aspx.cs" Inherits="IntegratedResourceManagementSystem.WareHouse.NewForwarderForm" %>
<%@ Register TagPrefix="forms" TagName="Forwarder" Src ="~/WareHouse/forms/ForwarderForm.ascx" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
<%@ Register Src ="~/WareHouse/controls/UCLoader.ascx" TagName="LOADER" TagPrefix ="UC" %>
<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <style type ="text/css" >
    .backBtn
    {
        background :url('../Resources/reply.png');
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
    <link href="../Styles/forwarder-management.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    
  <asp:UpdatePanel ID ="upnlForwarders" runat ="server" >
    <ContentTemplate >
      <div>
      <div>
          <asp:UpdateProgress ID="updateProgForwarder" runat="server" 
              AssociatedUpdatePanelID="upnlForwarders" >
            <ProgressTemplate >
                <asp:PlaceHolder ID="plcHldrLoader" runat ="server" >
                        <UC:LOADER ID ="loader" runat="server" />
                      </asp:PlaceHolder> 
            </ProgressTemplate>
          </asp:UpdateProgress>
      </div>
        <asp:MultiView ID="mViewForwarder" runat="server" ActiveViewIndex="0">
          <asp:View ID ="vForwarderForm" runat ="server" >
            <div>
              <asp:PlaceHolder ID="phForwarderForm" runat="server">
                <forms:Forwarder ID="fforwarder" runat="server" />
             
              </asp:PlaceHolder>
            </div>
            <div style =" margin-top:5px; height :30px;">
              <div style ="float:left; margin-right: 10px;" >
                <asp:Button ID="btnAddCustomers" runat="server" CssClass="btnNew" 
                            Text="ADD CUSTOMERS" ToolTip="Add Customer/s"
                            onclick="btnAddCustomers_Click" />
              </div>
              <asp:Button ID="btnSaveForwarder" runat="server" CssClass="btnSave" 
                          Text="SAVE" ToolTip="Save New Forwarder" 
                    onclick="btnSaveForwarder_Click" />
                <asp:ModalPopupExtender ID="btnSaveForwarder_ModalPopupExtender" runat="server" 
                    CancelControlID="btnConfirmNo" DynamicServicePath="" Enabled="True" 
                    PopupControlID="pnlSaveModal" PopupDragHandleControlID="pnlSaveModalDrag" 
                    TargetControlID="btnSaveForwarder">
                </asp:ModalPopupExtender>
      
            </div>
       <asp:Panel ID ="pnlSaveModal" runat ="server" CssClass ="modal" >
        <asp:Panel ID= "pnlSaveModalDrag" runat ="server" CssClass ="modalDrag">
          <div class ="sizeLogo">
            <asp:Image ID="Image2" runat="server" Height="16px" ImageAlign="AbsBottom" 
                       ImageUrl="~/Resources/forwarder.png" />
            CONFIRMATION!!!
          </div>
        </asp:Panel>
        <div class ="modalWarningText">
          Are you sure you want to Save this Data?
        </div>
        <div style =" text-align:center; margin-top: 12px;">
          <asp:Button ID="btnConfirmYes" runat="server" Text="YES" 
                      CssClass ="modalWarningButtonYes" ToolTip="Save" onclick="btnConfirmYes_Click" 
                       />
          <asp:Button ID="btnConfirmNo" runat="server" Text="NO" 
                      CssClass ="modalWarningButtonNo" ToolTip="Cancel"  />
        </div>
      </asp:Panel>
      <asp:DropShadowExtender ID="DropShadowExtender1" runat="server" 
                              Enabled="True" Opacity="0.5" Rounded="True" TargetControlID="pnlSaveModal">
      </asp:DropShadowExtender>
      <asp:RoundedCornersExtender ID="RoundedCornersExtender3" 
                                  runat="server" Enabled="True" TargetControlID="pnlSaveModal">
      </asp:RoundedCornersExtender>
          </asp:View>
          <asp:View  ID ="vForwarderOwnerForm" runat ="server" >
            <div>
              <forms:Forwarder ID="fForwarder1" runat="server" />
            </div>
            <hr />
            <div style ="margin-top:5px;">
              <asp:Label ID="Label3" runat="server" Text="LIST OF CUSTOMER" 
                         Font-Names="Verdana" Font-Size="12px" ForeColor="#CC6600"></asp:Label>
              &nbsp;
              &nbsp;
              &nbsp;
                <asp:Label ID="Label5" runat="server" Text="(Select customer/s from list.)" 
                      Font-Bold="False" Font-Names="Verdana" Font-Size="10px" 
                      ForeColor="#FF6600" Font-Italic="True"></asp:Label>
              &nbsp;
              &nbsp;
              &nbsp;
              &nbsp;
              &nbsp;
              &nbsp;
              &nbsp;
              &nbsp;
              &nbsp;
              &nbsp;
              &nbsp;
              &nbsp;
              &nbsp;
              &nbsp;
              &nbsp;
              &nbsp;
              &nbsp;
              &nbsp;
              &nbsp;
              &nbsp;
              &nbsp;
              &nbsp;
              &nbsp;
              &nbsp;
              &nbsp;
              &nbsp;
              &nbsp;
              &nbsp;
              &nbsp;
              &nbsp;
              &nbsp;
              &nbsp;
              &nbsp;
              &nbsp;
              <asp:Label ID="Label1" runat="server" Text="SEARCH:"></asp:Label>
              <asp:TextBox ID="txtSearch" runat="server" AutoPostBack="True" 
                    ontextchanged="txtSearch_TextChanged"></asp:TextBox>
              <asp:ImageButton ID="imgBtnSearch" runat="server" ImageAlign="AbsMiddle" 
                               ImageUrl="~/Resources/search.png" />
            </div>
            <div>
            <div style ="float:left;  position:absolute; margin-left:26px;"><asp:CheckBox ID="chkSeleckAll" runat="server" 
                  AutoPostBack="True" Font-Names="Verdana" Font-Size="10px" 
                  oncheckedchanged="chkSeleckAll_CheckedChanged" 
                  ToolTip="CHECK THIS TO SELECT ALL" /></div>
              <asp:GridView ID="gvCustomers" runat="server" AllowPaging="True" 
                            AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" 
                            DataKeyNames="CustNo" DataSourceID="SqlDataSourceCustomers" 
                            Font-Names="Verdana" Font-Size="10px" ForeColor="#333333" GridLines="None" 
                            EnablePersistedSelection="True">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>
                  <asp:TemplateField>
                    <EditItemTemplate>
                      <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                      <asp:Image ID="imgID" runat="server" ImageUrl="~/Resources/panels.png" AlternateText ='<%# Eval("CustNo") %>' Height ="14px" />
                    </ItemTemplate>
                  </asp:TemplateField>
                    <asp:TemplateField>
                        <EditItemTemplate>
                            <asp:CheckBox ID="chkCustomer" runat="server" />
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:CheckBox ID="chkCustomer" runat="server" ToolTip ='<%# Eval("CustNo") %>' />
                        </ItemTemplate>
                    </asp:TemplateField>
                  <asp:BoundField DataField="CustNo" HeaderText="CustNo" InsertVisible="False" 
                                  ReadOnly="True" SortExpression="CustNo" Visible="False" />
                  <asp:BoundField DataField="CompName" HeaderText="NAME" 
                                  SortExpression="CompName" />
                  <asp:BoundField DataField="brand" HeaderText="BRAND" SortExpression="brand" />
                  <asp:BoundField DataField="Addr1" HeaderText="ADDRESS" SortExpression="Addr1" />
                </Columns>
                <EditRowStyle BackColor="#999999" />
                  <EmptyDataTemplate>
                  <br />
                      <asp:Image ID="Image3" runat="server" ImageAlign="AbsMiddle" 
                          ImageUrl="~/Resources/unhappy.png" />
                          RECORDS NOT FOUND!!!
                  </EmptyDataTemplate>
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" 
                             Font-Names="Verdana" Font-Size="11px" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#E9E7E2" />
                <SortedAscendingHeaderStyle BackColor="#506C8C" />
                <SortedDescendingCellStyle BackColor="#FFFDF8" />
                <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
              </asp:GridView>
              <asp:SqlDataSource ID="SqlDataSourceCustomers" runat="server" 
                                 ConnectionString="<%$ ConnectionStrings:IRMSConnectionString %>" 
                                 SelectCommand="SELECT [CustNo], [CompName], [brand], [Addr1] FROM [CustInfo] WHERE ([ynActive] = @ynActive)">
                <SelectParameters>
                  <asp:Parameter DefaultValue="True" Name="ynActive" Type="Boolean" />
                </SelectParameters>
              </asp:SqlDataSource>
            </div>
            <div style ="height :30px; margin-top:5px;">
              <asp:Button ID="btnAddtoList" runat="server" Text="ADD SELECTED" 
                          CssClass ="btnNew" Font-Size ="11px" Width ="120px" 
                          onclick="btnAddtoList_Click" />
            </div>
            <hr />
            <div>
              <div>
                <asp:Label ID="Label2" runat="server" Text="List of Customer to be added." 
                      Font-Bold="True" Font-Names="Verdana" Font-Size="10px" ForeColor="#003366"></asp:Label>
                       &nbsp;
                        &nbsp;
                      <asp:Label ID="Label4" runat="server" Text="(Note:Uncheck to exclude from selected.)" 
                      Font-Bold="False" Font-Names="Verdana" Font-Size="10px" 
                      ForeColor="#FF6600" Font-Italic="True"></asp:Label>
                       &nbsp;
                        &nbsp;
                  <asp:Button ID="btnResetSelection" runat="server" Text="Reset Selection" 
                      Font-Names="Verdana" Font-Size="10px" ForeColor="#003366" 
                      onclick="btnResetSelection_Click" />
              </div>
              <asp:GridView ID="gvSelectedCustomers" runat="server" CellPadding="4" 
                            ForeColor="#333333" GridLines="None" AutoGenerateColumns="False" 
                            Font-Names="Verdana" Font-Size="10px">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>
                  <asp:BoundField DataField="CustomerNumber" HeaderText="RECORD#" />
                  <asp:BoundField DataField="CompanyName" HeaderText="NAME" />
                  <asp:BoundField DataField="Brand" HeaderText="BRAND" />
                  <asp:BoundField DataField="Address1" HeaderText="ADDRESS" />
                    <asp:TemplateField>
                        <EditItemTemplate>
                            <asp:CheckBox ID="CheckBox1" runat="server" />
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:CheckBox ID="chkSelectedCustomer" ToolTip ='<%# Eval("CustomerNumber") %>' Checked ="true"  runat="server" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EditRowStyle BackColor="#999999" />
                <EmptyDataTemplate>
                  EMPTY DATA!
                </EmptyDataTemplate>
                <FooterStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#5D7B9D" Font-Bold="True" ForeColor="White" />
                <PagerStyle BackColor="#284775" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#F7F6F3" ForeColor="#333333" />
                <SelectedRowStyle BackColor="#E2DED6" Font-Bold="True" ForeColor="#333333" />
                <SortedAscendingCellStyle BackColor="#E9E7E2" />
                <SortedAscendingHeaderStyle BackColor="#506C8C" />
                <SortedDescendingCellStyle BackColor="#FFFDF8" />
                <SortedDescendingHeaderStyle BackColor="#6F8DAE" />
              </asp:GridView>
            </div>
            <div style ="margin-top:10px; text-align :center;">
              <asp:Button ID="btnContinueSave" runat="server" CssClass="btnSave" 
                          Text="SAVE" ToolTip="Save New Brand" 
                    onclick="btnContinueSave_Click" />
                <asp:ModalPopupExtender ID="btnContinueSave_ModalPopupExtender" runat="server" 
                    CancelControlID="btnNo" DynamicServicePath="" Enabled="True" 
                    PopupControlID="pnlDeleteModal" PopupDragHandleControlID="pnlDeleteModalDrag" 
                    TargetControlID="btnContinueSave">
                </asp:ModalPopupExtender>
              <asp:RoundedCornersExtender ID="btnContinueSave_RoundedCornersExtender" 
                                          runat="server" Enabled="True" 
                                          TargetControlID="btnContinueSave" BorderColor="LightGray"></asp:RoundedCornersExtender>
              <asp:Button ID="btnBack" runat="server" Text="BACK" 
                          CssClass ="btnCancel" BackColor="Silver" onclick="btnBack_Click" />
              <asp:RoundedCornersExtender ID="btnBack_RoundedCornersExtender" runat="server" 
                                          BorderColor="LightGray" Enabled="True" TargetControlID="btnBack">
              </asp:RoundedCornersExtender>
            </div>
               <%--Delete Modal--%>
      <asp:Panel ID ="pnlDeleteModal" runat ="server" CssClass ="modal" >
        <asp:Panel ID= "pnlDeleteModalDrag" runat ="server" CssClass ="modalDrag">
          <div class ="sizeLogo">
            <asp:Image ID="Image1" runat="server" Height="16px" ImageAlign="AbsBottom" 
                       ImageUrl="~/Resources/forwarder.png" />
            CONFIRMATION!!!
          </div>
        </asp:Panel>
        <div class ="modalWarningText">
          Are you sure you want to Save this Data?
        </div>
        <div style =" text-align:center; margin-top: 12px;">
          <asp:Button ID="btnYes" runat="server" Text="YES" 
                      CssClass ="modalWarningButtonYes" ToolTip="Save" 
                      onclick="btnYes_Click" />
          <asp:RoundedCornersExtender ID="btnYes_RoundedCornersExtender" runat="server" 
                                      Enabled="True" TargetControlID="btnYes" 
                BorderColor="YellowGreen">
          </asp:RoundedCornersExtender>
          <asp:Button ID="btnNo" runat="server" Text="NO" 
                      CssClass ="modalWarningButtonNo" ToolTip="Cancel"  />
          <asp:RoundedCornersExtender ID="btnNo_RoundedCornersExtender" runat="server" 
                                      Enabled="True" TargetControlID="btnNo" 
                BorderColor="YellowGreen">
          </asp:RoundedCornersExtender>
        </div>
      </asp:Panel>
      <asp:DropShadowExtender ID="pnlDeleteModal_DropShadowExtender" runat="server" 
                              Enabled="True" Opacity="0.5" Rounded="True" TargetControlID="pnlDeleteModal">
      </asp:DropShadowExtender>
      <asp:RoundedCornersExtender ID="pnlDeleteModal_RoundedCornersExtender" 
                                  runat="server" Enabled="True" TargetControlID="pnlDeleteModal">
      </asp:RoundedCornersExtender>
          </asp:View>
        </asp:MultiView>
      </div>
    </ContentTemplate>
  </asp:UpdatePanel>
    
 
</asp:Content>
