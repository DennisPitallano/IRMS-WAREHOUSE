<%@ Page Title="" Language="C#" MasterPageFile="~/WareHouse/WareHouse.Master" AutoEventWireup="true"
    CodeBehind="DeliveryDetails.aspx.cs" Inherits="IntegratedResourceManagementSystem.WareHouse.DeliveryDetails" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <link href="../Styles/deliveries.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="modalDrag">
    <div class="close_btn" style="cursor:pointer;">
       <img src="../Resources/cancel_normal.png" alt="CLOSE" title="CLOSE WINDOW" onclick="window.close()" />
   </div>
        <div class="sizeLogo">
            Delivery Details View
        </div>
    </div>
    <div>
        <table>
            <tr>
                <td class="modalLabel">
                    DR #:
                </td>
                <td>
                    <asp:TextBox ID="txtDRNumberDetails" runat="server" CssClass="modalText"  Height="22px" EnableViewState="False" ReadOnly="True"></asp:TextBox>
                </td>
                <td class="modalLabel">
                    PL NUMBER:
                </td>
                <td>
                    <asp:TextBox ID="txtPLNumber" runat="server" CssClass="modalText" Height="22px" Width="75px"
                        EnableViewState="False" ReadOnly="True">
                    </asp:TextBox>
                </td>
                <td class="style2" rowspan="4">
                </td>
            </tr>
            <tr>
                <td class="modalLabel">
                    DELIVERY DATE:
                </td>
                <td>
                    <asp:TextBox ID="txtDeliveryReceiptDate" runat="server" CssClass="modalText" Height="22px"
                        Width="170px" EnableViewState="False" ReadOnly="True"></asp:TextBox>
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td class="modalLabel">
                    CUSTOMER/OUTLET:
                </td>
                <td colspan="3">
                    <asp:TextBox ID="txtDeliverTo" runat="server" CssClass="modalText" Height="22px" Width="300px"
                        EnableViewState="False" ReadOnly="True">
                    </asp:TextBox>
                </td>
            </tr>
        </table>
    </div>
    <div style="margin: 5px;">
        <asp:RadioButtonList ID="rdioView" CssClass="modalText" runat="server" AutoPostBack="True"
            RepeatDirection="Horizontal" OnSelectedIndexChanged="rdioView_SelectedIndexChanged">
            <asp:ListItem Selected="True">Summary</asp:ListItem>
            <asp:ListItem>Details</asp:ListItem>
        </asp:RadioButtonList>
    </div>
    <asp:MultiView ID="mViewSalesInvoice" runat="server" ActiveViewIndex="0">
        <asp:View ID="vSummary" runat="server">
            <div>
                <asp:GridView ID="gvDeliverySummary" CssClass="table_grid" runat="server" AutoGenerateColumns="False"
                    CellPadding="4" DataSourceID="SqlDataSourceSummary" ForeColor="#333333" GridLines="None">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:TemplateField>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Image ID="Image1" runat="server" Height="16px" ImageUrl="~/Resources/product_brand_summary.png" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="StyleNo" HeaderText="STYLE #" SortExpression="StyleNo" />
                        <asp:BoundField DataField="BrandName" HeaderText="BRAND" SortExpression="BrandName" />
                        <asp:BoundField DataField="Articles" HeaderText="ARTICLES" SortExpression="Articles" />
                        <asp:BoundField DataField="Quantity" HeaderText="QUANTITY" SortExpression="Quantity">
                            <ItemStyle Font-Bold="True" HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Unit" HeaderText="UNIT" SortExpression="Unit" />
                        <asp:BoundField DataField="UnitPrice" HeaderText="UNIT PRICE" SortExpression="UnitPrice"
                            DataFormatString="{0:###,###.00}">
                            <ItemStyle Font-Bold="True" ForeColor="#CC0000" HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Amount" HeaderText="AMOUNT" SortExpression="Amount" DataFormatString="{0:###,###.00}">
                            <ItemStyle Font-Bold="True" ForeColor="#CC0000" />
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
                <asp:SqlDataSource ID="SqlDataSourceSummary" runat="server" ConnectionString="<%$ ConnectionStrings:IRMSConnectionString %>"
                    SelectCommand="SELECT [StyleNo], [BrandName], [Articles], [Quantity], [Unit], [UnitPrice], [Amount] FROM [DRSumm] WHERE ([DRID] = @DRID)">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="DRID" QueryStringField="DRID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>
        </asp:View>
        <asp:View ID="vDetails" runat="server">
            <div>
                <asp:GridView ID="gvDRDetails" runat="server" CellPadding="4" ForeColor="#333333"
                    GridLines="None" Font-Names="Verdana" Font-Size="10px" AutoGenerateColumns="False"
                    EnableViewState="False">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <Columns>
                        <asp:TemplateField>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Image ID="Image1" runat="server" Height="16px" ImageUrl="~/Resources/Barcode.png" />
                            </ItemTemplate>
                        </asp:TemplateField>
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
                        <asp:BoundField DataField="Unit" HeaderText="UNIT" />
                        <asp:BoundField DataField="UnitPrice" DataFormatString="{0:Php###,###.00}" HeaderText="UNIT PRICE">
                            <HeaderStyle Wrap="False" />
                            <ItemStyle Wrap="False" ForeColor="#CC3300" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Amount" DataFormatString="{0:Php###,###.00}" HeaderText="AMOUNT">
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
            </div>
        </asp:View>
    </asp:MultiView>
     <div style="margin: 5px;">
        <table style="">
            <tr>
                <td class="modalLabel">
                    TOTAL QUANTITY:
                </td>
                <td>
                    <asp:TextBox CssClass="modalText" ReadOnly="true" Height="22px" ID="txtTotalQTY"
                        runat="server" Font-Bold="True" ForeColor="#CC0000"></asp:TextBox>
                </td>
                <td class="modalLabel">
                    TOTAL AMOUNT:
                </td>
                <td>
                    <asp:TextBox CssClass="modalText" ReadOnly="true" Height="22px" ID="txtTotalAmount"
                        runat="server" Font-Bold="True" ForeColor="#CC0000"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
                <td>
                    &nbsp;
                </td>
            </tr>
        </table>
    </div>
</asp:Content>
