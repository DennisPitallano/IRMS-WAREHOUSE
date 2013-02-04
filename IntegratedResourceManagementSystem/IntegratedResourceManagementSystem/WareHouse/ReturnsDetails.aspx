<%@ Page Title="" Language="C#" MasterPageFile="~/WareHouse/WareHouse.Master" AutoEventWireup="true"
    CodeBehind="ReturnsDetails.aspx.cs" Inherits="IntegratedResourceManagementSystem.WareHouse.ReturnsDetails" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <link href="../Styles/crs.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
<div class="modalDrag">
   <div class="close_btn" style="cursor:pointer;">
       <img src="../Resources/cancel_normal.png" alt="CLOSE" title="CLOSE WINDOW" onclick="window.close()" />
   </div>
</div>
    <div>
        <table>
            <tr>
                <td class="modalLabel">
                    DR #:
                </td>
                <td>
                    <asp:TextBox ID="txtDRNumberDetails" CssClass="modalText" runat="server" Height="22px"
                        Font-Names="Verdana" ForeColor="#003366" ReadOnly="true"></asp:TextBox>
                </td>
                <td class="modalLabel">
                    PL #:
                </td>
                <td class="style2">
                    <asp:TextBox ID="txtPLNumber" CssClass="modalText" runat="server" Height="22px" Font-Names="Verdana"
                        ForeColor="#003366" Width="75px" ReadOnly="true"></asp:TextBox>
                </td>
                <td rowspan="3">
                </td>
            </tr>
            <tr>
                <td class="modalLabel">
                    RETURN DATE:
                </td>
                <td>
                    <asp:TextBox CssClass="modalText" ID="txtDeliveryReceiptDate" runat="server" Height="22px"
                        Font-Names="Verdana" ForeColor="#003366" Width="170px" ReadOnly="true"></asp:TextBox>
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                    <asp:HiddenField ID="hfRcordNumber" runat="server" />
                </td>
            </tr>
            <tr>
                <td class="modalLabel">
                    CUSTOMER/OUTLET:
                </td>
                <td colspan="3">
                    <asp:TextBox ID="txtDeliverTo" CssClass="modalText" runat="server" Height="22px"
                        Width="350px" Font-Names="Verdana" ForeColor="#003366" ReadOnly="true"></asp:TextBox>
                </td>
            </tr>
        </table>
    </div>
    <div style="margin: 5px;">
        <asp:RadioButtonList ID="rdioViewFilter" CssClass="modalText" runat="server" RepeatDirection="Horizontal"
            AutoPostBack="True" 
            onselectedindexchanged="rdioViewFilter_SelectedIndexChanged">
            <asp:ListItem Selected="True">SUMMARY</asp:ListItem>
            <asp:ListItem>DETAILS</asp:ListItem>
        </asp:RadioButtonList>
    </div>
    <div style="margin: 5px 10px;">
        <asp:MultiView ID="mViewFilter" runat="server" ActiveViewIndex="0">
            <asp:View ID="vSummary" runat="server">
                <asp:GridView ID="gvSummary" CssClass="table_grid" runat="server" AutoGenerateColumns="False" 
                    CellPadding="4" DataSourceID="SqlDataSourceSummary" ForeColor="#333333" 
                    GridLines="None">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:TemplateField>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Image ID="Image1" runat="server"  Height="16px" ImageUrl="~/Resources/panels.png" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="StyleNo" HeaderText="STYLE #" 
                            SortExpression="StyleNo" >
                        <ItemStyle Font-Bold="True" />
                        </asp:BoundField>
                        <asp:BoundField DataField="BrandName" HeaderText="BRAND" 
                            SortExpression="BrandName" />
                        <asp:BoundField DataField="Quantity" HeaderText="QUANTITY" 
                            SortExpression="Quantity" >
                        <ItemStyle Font-Bold="True" HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Articles" HeaderText="ARTICLES" 
                            SortExpression="Articles" />
                        <asp:BoundField DataField="UnitPrice" HeaderText="UNIT PRICE" 
                            SortExpression="UnitPrice" DataFormatString="{0:###,###.00}" >
                        <ItemStyle Font-Bold="True" ForeColor="#CC0000" HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Amount" HeaderText="AMOUNT" 
                            SortExpression="Amount" DataFormatString="{0:###,###.00}" >
                        <ItemStyle Font-Bold="True" ForeColor="#CC0000" HorizontalAlign="Center" />
                        </asp:BoundField>
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
                <asp:SqlDataSource ID="SqlDataSourceSummary" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:IRMSConnectionString %>" 
                    SelectCommand="SELECT [StyleNo], [BrandName], [Quantity], [Articles], [UnitPrice], [Amount] FROM [CRSSumm] WHERE ([CRSID] = @CRSID)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="hfRcordNumber" Name="CRSID" 
                            PropertyName="Value" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </asp:View>
            <asp:View ID="vDetails" runat="server">
                <asp:GridView ID="gvDRDetails" runat="server" CellPadding="4" ForeColor="#333333"
                    GridLines="None" Font-Names="Verdana" CssClass="table_grid" AutoGenerateColumns="False"
                    AllowSorting="True" DataSourceID="SqlDataSourceCRSDetails">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <Columns>
                        <asp:TemplateField>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Image ID="Image1" Height="16px" runat="server" ImageUrl="~/Resources/Barcode.png" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="SKU" HeaderText="SKU" SortExpression="SKU">
                        <ItemStyle Font-Bold="True" />
                        </asp:BoundField>
                        <asp:BoundField DataField="StyleNo" HeaderText="STYLE #" 
                            SortExpression="StyleNo">
                        </asp:BoundField>
                        <asp:BoundField DataField="BrandName" HeaderText="BRAND" 
                            SortExpression="BrandName">
                        </asp:BoundField>
                        <asp:BoundField DataField="Quantity" HeaderText="QUANTITY" 
                            SortExpression="Quantity">
                        <ItemStyle Font-Bold="True" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Articles" HeaderText="ARTICLES" 
                            SortExpression="Articles" />
                        <asp:BoundField DataField="UnitPrice" HeaderText="UNIT PRICE" SortExpression="UnitPrice"
                            DataFormatString="{0:###,###.00}" >
                        <ItemStyle Font-Bold="True" ForeColor="#CC0000" HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Amount" HeaderText="AMOUNT" SortExpression="Amount" 
                            DataFormatString="{0:###,###.00}">
                        <ItemStyle Font-Bold="True" ForeColor="#CC0000" HorizontalAlign="Center" />
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
                <asp:SqlDataSource ID="SqlDataSourceCRSDetails" runat="server" ConnectionString="<%$ ConnectionStrings:IRMSConnectionString %>"
                    SelectCommand="SELECT [SKU], [StyleNo], [BrandName], [Quantity], [Articles], [UnitPrice], [Amount] FROM [CRSDtl] WHERE ([CRSID] = @CRSID)"
                    EnableCaching="True">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="hfRcordNumber" Name="CRSID" PropertyName="Value"
                            Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </asp:View>
        </asp:MultiView>
        <div style="line-height:20px; margin:10px;">
            <table style="">
                <tr>
                    <td class="modalLabel">
                        TOTAL QUANTITY:
                    </td>
                    <td>

                        <asp:Label ID="lblTotalQuantity" CssClass="modalText" Height="20px" 
                            Width="200px" runat="server" Font-Bold="True" ForeColor="#CC0000"></asp:Label>
                    </td>
                    <td class="modalLabel">
                        TOTAL AMOUNT:
                    </td>
                    <td>
                        <asp:Label ID="lblTotalAmount" CssClass="modalText" Height="20px" 
                            Width="200px"  runat="server" Font-Bold="True" ForeColor="#CC0000"></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>
