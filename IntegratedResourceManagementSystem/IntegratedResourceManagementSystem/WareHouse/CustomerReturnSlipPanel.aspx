<%@ Page Title="" Language="C#" MasterPageFile="~/WareHouse/WareHouse.Master" AutoEventWireup="true" CodeBehind="CustomerReturnSlipPanel.aspx.cs" Inherits="IntegratedResourceManagementSystem.WareHouse.CustomerReturnSlipPanel" %>
<%@ OutputCache CacheProfile ="cached_profile"  %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>
<%@ Register Src ="~/WareHouse/controls/UCLoader.ascx" TagName="LOADER" TagPrefix ="UC" %>
<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <link href="../Styles/warehouse.css" rel="stylesheet" type="text/css" />
    <link href="../Styles/body-style.css" rel="stylesheet" type="text/css" />
    <link href="../Styles/grid.css" rel="stylesheet" type="text/css" />
    <style type ="text/css" >
        .dtlsLabel
        {
            font-family:Verdana;
            font-size: 11px;
            text-align:right;
            }
   
    .search_option
    {
        font-family :Verdana ;
        font-size :11px;
        color:#FF3300;
         font-style:italic;
    }
    .search_option:hover
    {
        color:Gray;
        cursor:pointer;
    }
     #MainContent_gvCustomerReturnSlip tr:nth-child(n+2):hover
    {
        background-image: -webkit-gradient(linear, left top, left bottom, from(#c9c9c9), to(#848484), color-stop(0.6, #a1a1a1));
        background-image: -moz-linear-gradient(top, #c9c9c9, #848484, #a1a1a1 90%);
        color: #FFFFCC;
    }
    
    </style>
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <asp:UpdatePanel ID ="upnlSalesInvoice" runat ="server" >
    <ContentTemplate>
      <div>
        <div>
          <asp:Image ID="imgDRTitle" runat="server" ImageUrl="~/Resources/panels.png" 
                     ImageAlign="AbsMiddle" />     
            &nbsp;MANAGE CUSTOMER RETURN SLIP
          <hr />
        </div>
        <div style = "width: 750px; margin-bottom:1px; height: 30px;" class="modalDrag">
            <div style ="float:right;">
            FILTER:<asp:RadioButtonList ID="rdioFilterView" runat="server" 
                                        Font-Names="Verdana" Font-Size="10px" ForeColor="#993300" 
                                        RepeatDirection="Horizontal" RepeatLayout="Flow" 
                  AutoPostBack="True" 
                  onselectedindexchanged="rdioFilterView_SelectedIndexChanged">
              <asp:ListItem Value="UNPOSTED" Selected="True">UNPOSTED</asp:ListItem>
                    <asp:ListItem>POSTED</asp:ListItem>
              <asp:ListItem Value="CANCELLED">CANCELLED</asp:ListItem>
            </asp:RadioButtonList>

            &nbsp;  &nbsp; <asp:Label ID="lblSearchBy" runat="server" Text="SEARCH BY" 
                    CssClass ="search_option"></asp:Label>
               <asp:HoverMenuExtender ID="lblSearchBy_HoverMenuExtender" runat="server" 
                   DynamicServicePath="" Enabled="True" TargetControlID="lblSearchBy" 
                   PopupControlID="pnlSearchOption" PopupPosition="Bottom" OffsetX="-60" 
                    OffsetY="-15">
               </asp:HoverMenuExtender>
               &nbsp;  &nbsp;
               <asp:Panel ID ="pnlSearchOption" runat ="server" CssClass="modalDrag" Width ="160px" Height ="25px" >
               <asp:RadioButtonList ID="rdioSearchOption" runat="server" Font-Names="Verdana" 
                   Font-Size="10px" RepeatDirection="Horizontal" ForeColor="#FFFFCC">
                   <asp:ListItem Selected="True">All</asp:ListItem>
                   <asp:ListItem Value="PUSNumber">PUS #</asp:ListItem>
                   <asp:ListItem Value="CRSNumber">CRS #</asp:ListItem>
               </asp:RadioButtonList>
               </asp:Panel>
               <asp:DropShadowExtender ID="pnlSearchOption_DropShadowExtender" runat="server" 
                   Enabled="True" Opacity="0.75" TargetControlID="pnlSearchOption">
               </asp:DropShadowExtender>

            <asp:TextBox ID="txtSearchDR" runat="server" Font-Names="Verdana" Width="120px"></asp:TextBox>
            <asp:ImageButton ID="imgBtnSearchDR"
                             runat="server" ImageAlign="Top" ImageUrl="~/Resources/search.png" 
                             ToolTip="Search Delivery Receipt" 
                  onclick="imgBtnSearchDR_Click" />

                    <asp:ImageButton ID="imgAdvanceSearch" runat="server" 
                  ImageUrl="~/Resources/advance_search.png" ToolTip="ADVANCE SEARCH" />
              <asp:ModalPopupExtender ID="imgAdvanceSearch_ModalPopupExtender" runat="server" 
                  DynamicServicePath="" Enabled="True" TargetControlID="imgAdvanceSearch" 
                  PopupControlID="pnlAdvanceSearch" 
                  PopupDragHandleControlID="pnlAdvanceSearchDrag" 
                  CancelControlID="ibtnCloseAdvanceSearch">
              </asp:ModalPopupExtender>

              <asp:Panel ID ="pnlAdvanceSearch" runat ="server" CssClass ="modal">
                <asp:Panel ID ="pnlAdvanceSearchDrag" runat ="server" CssClass ="modalDrag" >
                    <div class ="close_btn">
                        <asp:ImageButton ID="ibtnCloseAdvanceSearch" runat="server" 
                               CssClass ="btnClose" ImageUrl="~/Resources/cancel_gray.png" ToolTip="CLOSE"/>
                    </div> 
                    <div class ="sizeLogo">
                        <asp:Image ID="Image3" runat="server" Height="16px" ImageAlign="AbsBottom" 
                         ImageUrl="~/Resources/panels.png" />
                        ADVANCE SEARCH OPTION!
                    </div>
                </asp:Panel>
                <div style ="margin:5px 3px 5px 5px;">
                   <div style ="margin-left:55px; margin-bottom:3px;">
                       <asp:Label ID="Label5" runat="server" Text="COMPANY:" Font-Names="Verdana" 
                        ForeColor="#FFCC66" Font-Size="12px" AssociatedControlID="txtSearchCompany"></asp:Label> 
                        <asp:TextBox ID="txtSearchCompany" runat="server" Width="200px" Height="20px" 
                           Enabled="False"></asp:TextBox>
                       <asp:CheckBox ID="chkEnableCompanySearch" runat="server" AutoPostBack="True" 
                           Font-Bold="True" Font-Names="Verdana" Font-Size="11px" ForeColor="#FFFFCC" 
                           oncheckedchanged="chkEnableCompanySearch_CheckedChanged" Text="ENABLE" 
                           ToolTip="Include Company Name for Searching" />
                   </div>
                    <asp:Label ID="Label2" runat="server" Text="DATE RANGE:" Font-Names="Verdana" 
                        ForeColor="#FFCC66" Font-Size="12px"></asp:Label>
                        <asp:Label ID="Label3" runat="server" Text="FROM" Font-Names="Verdana" 
                        ForeColor="#FFFFCC" Font-Size="11px"></asp:Label>
                    <asp:TextBox ID="txtDateSeachFrom" runat="server" Font-Names="Verdana" 
                        Font-Size="11px" Height="20px"></asp:TextBox>
                    <asp:CalendarExtender ID="txtDateSeachFrom_CalendarExtender" runat="server" 
                        Enabled="True" TargetControlID="txtDateSeachFrom" Format="MMMM dd, yyyy">
                    </asp:CalendarExtender>
                     <asp:Label ID="Label4" runat="server" Text="TO" Font-Names="Verdana" 
                        ForeColor="#FFFFCC" Font-Size="11px"></asp:Label>
                    <asp:TextBox ID="txtDateSeachTo" runat="server" Font-Names="Verdana" 
                        Font-Size="11px" Height="20px"></asp:TextBox>
                    <asp:CalendarExtender ID="txtDateSeachTo_CalendarExtender" runat="server" 
                        Enabled="True" TargetControlID="txtDateSeachTo" Format="MMMM dd, yyyy">
                    </asp:CalendarExtender>
                    <div style="text-align:center; margin-top:5px;">
                        <asp:Button ID="btnAdvanceSearch" runat="server" Text="GO" Font-Bold="True" 
                            Font-Names="Verdana" Font-Size="12px" ForeColor="#CC6600" Height="24px" 
                            onclick="btnAdvanceSearch_Click" />
                    </div>
                </div>
              </asp:Panel>
                <asp:DropShadowExtender ID="pnlAdvanceSearch_DropShadowExtender" runat="server" 
                    Enabled="True" Opacity="0.75" TargetControlID="pnlAdvanceSearch">
                </asp:DropShadowExtender>
          </div>
          <asp:Label ID="lblSelectedItemToCancelModalHandler" runat="server"></asp:Label>
          <asp:ModalPopupExtender ID="btnPreviewSelectedDRForcancel_ModalPopupExtender" 
                                  runat="server" DynamicServicePath="" Enabled="True" 
                                  TargetControlID="lblSelectedItemToCancelModalHandler" 
                                  PopupControlID="pnlSelectedReturnsToCancelModal" 
                                  PopupDragHandleControlID="pnlSelectedReturnsToCancelModalDrag" 
                                  BackgroundCssClass="bgModal" 
                                  CancelControlID="imgBtnClosepnlSelectedReturnsToCancelModal" >
                                  <Animations>
                                    <OnShown>
                                        <FadeIn Duration=".2" />
                                    </OnShown>
                                  </Animations>
          </asp:ModalPopupExtender>
          <asp:Button ID="btnPreviewSelectedCRSForcancel" runat="server" 
                      Text="CANCEL SELECTED CRS"  CssClass="btnCancel" onclick="btnPreviewSelectedCRSForcancel_Click" />   
                 
        </div>
        <div style = "float: left; width: 500px; height:435px; border:0.08em Solid Gray; margin-right:2px;">
         <div class ="titleList"> 
          <asp:Image ID="imgList" runat="server" Height="16px" Width ="20px"
                     ImageUrl="~/Resources/panels.png" ImageAlign="AbsBottom" /> LIST OF CRS
         </div>
          <div style ="float:left;  position:absolute; margin-left:30px;"><asp:CheckBox ID="chkSeleckAll" runat="server" 
                  AutoPostBack="True" Font-Names="Verdana" Font-Size="10px" 
                  oncheckedchanged="chkSeleckAll_CheckedChanged" 
                  ToolTip="CHECK THIS TO SELECT ALL" /></div>
          <asp:Panel ID ="pnlDeliveryReceipt" runat ="server" Height ="415px" ScrollBars ="Auto"  >
              <asp:GridView ID="gvCustomerReturnSlip" runat="server" AllowPaging="True" 
                  AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" 
                  DataKeyNames="ID" DataSourceID="SqlDataSourceCustomerReturnSlip" 
                   GridLines="Horizontal"  CssClass="table_grid"
                  onselectedindexchanged="gvCustomerReturnSlip_SelectedIndexChanged" 
                  PageSize="12" EnablePersistedSelection="True" 
                  onpageindexchanging="gvCustomerReturnSlip_PageIndexChanging" 
                  onsorting="gvCustomerReturnSlip_Sorting">
                  <AlternatingRowStyle BackColor="White" />
                  <Columns>
                      <asp:TemplateField>
                          <EditItemTemplate>
                              <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                          </EditItemTemplate>
                          <ItemTemplate>
                              <asp:Image ID="Image1" runat="server" ImageUrl="~/Resources/panels.png" Height="16px" />
                          </ItemTemplate>
                      </asp:TemplateField>
                       <asp:TemplateField>
                  <EditItemTemplate>
                    <asp:CheckBox ID="CheckBox1" runat="server" />
                  </EditItemTemplate>
                  <ItemTemplate>
                    <asp:CheckBox ID="chkID" runat="server" ToolTip='<%# Eval("ID") %>'  />
                  </ItemTemplate>
                  <HeaderStyle Wrap="False" />
                  <ItemStyle Font-Bold="True" ForeColor="#CC6600" HorizontalAlign="Center" 
                             Wrap="False" />
                </asp:TemplateField>
                      <asp:CommandField ShowSelectButton="True" />
                      <asp:BoundField DataField="ID" HeaderText="RECORD #" InsertVisible="False" 
                          ReadOnly="True" SortExpression="ID" Visible="False" >
                      <HeaderStyle Wrap="False" />
                      <ItemStyle Wrap="False" />
                      </asp:BoundField>
                      <asp:BoundField DataField="CRSNo" HeaderText="CRS NUMBER" 
                          SortExpression="CRSNo" >
                      <HeaderStyle Wrap="False" />
                      <ItemStyle Wrap="False" />
                      </asp:BoundField>
                      <asp:BoundField DataField="CRSDate" HeaderText="CRS DATE" 
                          SortExpression="CRSDate" DataFormatString="{0:MMMM dd, yyyy}" >
                      <HeaderStyle Wrap="False" />
                      <ItemStyle Wrap="False" />
                      </asp:BoundField>
                      <asp:BoundField DataField="Customer" HeaderText="CUSTOMER" 
                          SortExpression="Customer" >
                      <HeaderStyle Wrap="False" />
                      <ItemStyle Wrap="False" />
                      </asp:BoundField>
                      <asp:BoundField DataField="TotalAmt" HeaderText="TOTAL AMOUNT" 
                          SortExpression="TotalAmt" DataFormatString="{0:Php###,###.00}" >
                      <HeaderStyle Wrap="False" />
                      <ItemStyle Wrap="False" />
                      </asp:BoundField>
                      <asp:BoundField DataField="PUSNo" HeaderText="PUS #" SortExpression="PUSNo" >
                      <HeaderStyle Wrap="False" />
                      <ItemStyle Wrap="False" />
                      </asp:BoundField>
                      <asp:BoundField DataField="PkgNo" HeaderText="PACKAGE #" 
                          SortExpression="PkgNo" >
                      <HeaderStyle Wrap="False" />
                      <ItemStyle Wrap="False" />
                      </asp:BoundField>
                      <asp:BoundField DataField="ItemStatus" HeaderText="ITEM STATUS" 
                          SortExpression="ItemStatus" >
                      <HeaderStyle Wrap="False" />
                      <ItemStyle Wrap="False" />
                      </asp:BoundField>
                  </Columns>
                  <EditRowStyle BackColor="#7C6F57" />
                  <EmptyDataTemplate>
                  <br />
                      <asp:Image ID="imgNorecord" runat="server" ImageUrl="~/Resources/unhappy.png" ImageAlign ="AbsMiddle" />
                      <asp:Label ID="Label7" runat="server" Text="NO RECORDS FOUND!!!"></asp:Label>
                  </EmptyDataTemplate>
                  <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                  <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
                  <PagerSettings FirstPageImageUrl="~/Resources/first.png" 
                      LastPageImageUrl="~/Resources/last.png" Mode="NumericFirstLast" 
                      PageButtonCount="20" />
                  <PagerStyle BackColor="#666666" ForeColor="White" HorizontalAlign="Left" 
                      Font-Bold="True" Font-Names="Verdana" Font-Size="12px" />
                  <RowStyle BackColor="#E3EAEB" />
                  <SelectedRowStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
                  <SortedAscendingCellStyle CssClass="asc_cell_style" />
                  <SortedAscendingHeaderStyle BackColor="#246B61" />
                  <SortedDescendingCellStyle CssClass="desc_cell_style" />
                  <SortedDescendingHeaderStyle BackColor="#15524A" />
              </asp:GridView>
              <asp:SqlDataSource ID="SqlDataSourceCustomerReturnSlip" runat="server" 
                  ConnectionString="<%$ ConnectionStrings:IRMSConnectionString %>" 
                  
                  SelectCommand="SELECT [ID], [CRSID], [CRSNo], [CRSDate], [Customer], [TotalAmt], [PUSNo], [PkgNo], [ItemStatus] FROM [CRS] where (ynPosted =0 and ynCancelled=0) ORDER BY CRSDate DESC" >
              </asp:SqlDataSource>
          </asp:Panel>
        </div>
        
        <div style ="float: left; width:462px;">
          <div>
            <table>
              <tr>
                <td class ="dtlsLabel">
                    CRS Number:
                </td>
                <td>
                  <asp:TextBox ID="txtDRNumberDetails" runat="server" Height="22px" 
                        Font-Names="Verdana" Font-Size="10px" ForeColor="#003366" 
                        EnableViewState="False"></asp:TextBox>
                </td>
                <td class ="dtlsLabel">
                  PUS Number:
                </td>
                <td>
                  <asp:TextBox ID="txtPLNumber" runat="server" Height="22px" Font-Names="Verdana" 
                        Font-Size="10px" ForeColor="#003366" Width="75px" EnableViewState="False"></asp:TextBox>
                </td>
                  <td rowspan="4">
                     <asp:UpdateProgress ID="upCustomerReturnSlip" runat="server" 
        AssociatedUpdatePanelID="upnlSalesInvoice" DisplayAfter="500">
        <ProgressTemplate >
           <asp:PlaceHolder ID="plcHldrLoader" runat ="server" >
                        <UC:LOADER ID ="loader" runat="server" />
                      </asp:PlaceHolder>   
        </ProgressTemplate>
    </asp:UpdateProgress></td>
              </tr>
              <tr>
                <td class ="dtlsLabel">
                    CRS Date:
                </td>
                <td>
                  <asp:TextBox ID="txtDeliveryReceiptDate" runat="server" Height="22px" 
                        Font-Names="Verdana" Font-Size="10px" ForeColor="#003366" 
                        EnableViewState="False"></asp:TextBox>
                </td>
                <td>
                  &nbsp;
                </td>
                <td>
                  &nbsp;
                </td>
              </tr>
              <tr>
                <td class ="dtlsLabel">
                  Delivered To:
                </td>
                <td colspan="3">
                  <asp:TextBox ID="txtDeliverTo" runat="server" Height="22px" Width="300px" 
                        Font-Names="Verdana" Font-Size="10px" ForeColor="#003366" 
                        EnableViewState="False"></asp:TextBox>
                </td>
              </tr>
              <tr>
                <td colspan="4">
                  <asp:Image ID="Image2" runat="server" Height="18px" 
                             ImageUrl="~/Resources/panels.png" />
                    CUSTOMER RETURN SLIP DETAILS
                </td>
              </tr>
            </table>
          </div>
          <div style ="margin-left:10px;">
            <asp:Panel ID ="pnlDRDetails" runat ="server" ScrollBars ="Auto"  Height="250px" >
              <asp:GridView ID="gvCRSDetails" runat="server" CellPadding="4" ForeColor="#333333" 
                            GridLines="None" Font-Names="Verdana" Font-Size="9px" 
                            AutoGenerateColumns="False" EnableViewState="False">
                <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                <Columns>
                  <asp:BoundField DataField="SKUCode" HeaderText="SKU CODE">
                    <HeaderStyle Wrap="False" />
                    <ItemStyle Wrap="False" />
                  </asp:BoundField>
                  <asp:BoundField DataField="StyleNumber" HeaderText="STYLE NUMBER">
                    <HeaderStyle Wrap="False" />
                    <ItemStyle Wrap="False" />
                  </asp:BoundField>
                  <asp:BoundField DataField="BrandName" HeaderText="BRAND">
                    <HeaderStyle Wrap="False" />
                    <ItemStyle Wrap="False" />
                  </asp:BoundField>
                  <asp:BoundField DataField="Articles" HeaderText="ARTICLES">
                    <HeaderStyle Wrap="False" />
                  </asp:BoundField>
                  <asp:BoundField DataField="Quantity" HeaderText="QUANTITY" />
                  <asp:BoundField DataField="UnitPrice" DataFormatString="{0:Php###,###.00}" 
                                  HeaderText="UNIT PRICE">
                    <HeaderStyle Wrap="False" />
                    <ItemStyle Wrap="False" ForeColor="#CC3300" />
                  </asp:BoundField>
                  <asp:BoundField DataField="Amount" DataFormatString="{0:Php###,###.00}" 
                                  HeaderText="AMOUNT">
                    <HeaderStyle Wrap="False" />
                    <ItemStyle Wrap="False" ForeColor="#CC3300" />
                  </asp:BoundField>
                </Columns>
                <EditRowStyle BackColor="#999999" />
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
            </asp:Panel>
            <div>
              <table style="width: 100%;">
                <tr>
                  <td class ="dtlsLabel">
                    TOTAL QUANTITY:
                  </td>
                  <td>
                    <asp:Label ID="lblTotalQuantity" runat="server"  Font-Bold="True" 
                               ForeColor="#003366"></asp:Label>
                  </td>
                  <td class ="dtlsLabel">
                    TOTAL AMOUNT:
                  </td>
                  <td>
                    <asp:Label ID="lblTotalAmount" runat="server"  Font-Bold="True" 
                               ForeColor="#003366"></asp:Label>
                  </td>
                </tr>
              </table>
            </div>
          </div>
        </div>
        <asp:Panel ID="pnlSelectedReturnsToCancelModal" runat ="server" CssClass ="modal" Width ="500px" >
          <asp:Panel ID= "pnlSelectedReturnsToCancelModalDrag" runat = "server" CssClass ="modalDrag" >
            <div class ="close_btn">
              <asp:ImageButton ID="imgBtnClosepnlSelectedReturnsToCancelModal" runat="server" 
                               CssClass ="btnClose" ImageUrl="~/Resources/cancel_gray.png" ToolTip="CLOSE"/>
            </div> 
            <div class ="sizeLogo">
              <asp:Image ID="imgUpdateLogo" runat="server" Height="16px" ImageAlign="AbsBottom" 
                         ImageUrl="~/Resources/panels.png" />
              PREVIEW CRS to cancel.
            </div>
          </asp:Panel>
          <div style ="margin-left:5px; margin-right :5px; margin-top : 5px;">
                    <asp:GridView ID="gvPreviewSelectedDR" runat="server" AutoGenerateColumns="False" 
                        Font-Names="Verdana" Font-Size="10px" ForeColor="#333333" CellPadding="4" 
                        GridLines="None">
                        <AlternatingRowStyle BackColor="White" />
            <Columns>
              <asp:BoundField DataField="CustomerReturnSlipNumber" HeaderText="CRS NUMBER" />
                <asp:BoundField DataField="Customer" HeaderText="CUSTOMER" />
              <asp:BoundField DataField="CustomerReturnSlipDate" HeaderText="CRS DATE" 
                    DataFormatString="{0:MMMM dd, yyyy}" />
              <asp:BoundField DataField="PUSNo" HeaderText="PUS NUMBER" />
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
                  CssClass ="modalWarningButtonYes" onclick="btnYesCancelSelectedDR_Click" />
            <asp:RoundedCornersExtender ID="btnYesCancelSelectedDR_RoundedCornersExtender" 
                                        runat="server" Enabled="True" 
                  TargetControlID="btnYesCancelSelectedDR" BorderColor="LightGray">
            </asp:RoundedCornersExtender>
          </div>
        </asp:Panel>
         
      </div>
    </ContentTemplate>
  </asp:UpdatePanel>
    <asp:HiddenField ID="hfIsAdvanceSearch" runat="server" />
    <div style ="float:left;">
     
    </div>
   
</asp:Content>