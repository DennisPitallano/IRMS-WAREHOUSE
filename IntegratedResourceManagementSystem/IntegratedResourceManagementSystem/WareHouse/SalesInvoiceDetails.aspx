<%@ Page Title="" Language="C#" MasterPageFile="~/WareHouse/WareHouse.Master" AutoEventWireup="true"
    CodeBehind="SalesInvoiceDetails.aspx.cs" Inherits="IntegratedResourceManagementSystem.WareHouse.SalesInvoiceDetails" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <link href="../Styles/sales-invoice.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="modalDrag">
        <div class="close_btn" style="cursor: pointer;">
            <img src="../Resources/cancel_normal.png" alt="CLOSE" title="CLOSE WINDOW" onclick="window.close()" />
        </div>
        <div class="sizeLogo">
            Sales Invoice Details View
        </div>
    </div>
    <div>
        <table style="">
            <tr>
                <td class="modalLabel">
                    SI NUMBER:
                </td>
                <td>
                    <asp:TextBox CssClass="modalText" ReadOnly="true" Height="22px" ID="txtSINumber"
                        runat="server"></asp:TextBox>
                </td>
                <td class="modalLabel">
                    PL NUMBER:
                </td>
                <td>
                    <asp:TextBox ID="txtPLNumber" ReadOnly="true" CssClass="modalText" Height="22px"
                        runat="server"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="modalLabel">
                    CUSTOMER:
                </td>
                <td colspan="3">
                    <asp:TextBox ID="txtCustomer" ReadOnly="true" CssClass="modalText" Height="22px"
                        Width="300px" runat="server"></asp:TextBox>
                    &nbsp; &nbsp;
                </td>
            </tr>
            <tr>
                <td class="modalLabel">
                    SI DATE:
                </td>
                <td>
                    <asp:TextBox CssClass="modalText" ReadOnly="true" Height="22px" ID="txtSIDate" runat="server"></asp:TextBox>
                </td>
                <td>
                    &nbsp;
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
                <asp:GridView ID="gvSalesInvoiceSummary" runat="server" CssClass="table_grid" AutoGenerateColumns="False"
                    DataSourceID="SqlDataSourceSummary" CellPadding="4" ForeColor="#333333" GridLines="None">
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:TemplateField>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Image ID="Image1" runat="server" ImageUrl="~/Resources/product_brand_summary.png"
                                    Height="16px" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="StyleNo" HeaderText="STYE #" SortExpression="StyleNo" />
                        <asp:BoundField DataField="BrandName" HeaderText="BRAND" SortExpression="BrandName" />
                        <asp:BoundField DataField="Quantity" HeaderText="QUANTITY" SortExpression="Quantity">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Unit" HeaderText="UNIT" SortExpression="Unit" />
                        <asp:BoundField DataField="Articles" HeaderText="ARTICLES" SortExpression="Articles" />
                        <asp:BoundField DataField="UnitPrice" HeaderText="UNIT PRICE" SortExpression="UnitPrice"
                            DataFormatString="{0:###,###.00}">
                            <ItemStyle Font-Bold="True" ForeColor="#CC0000" />
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
                    SelectCommand="SELECT [StyleNo], [BrandName], [Quantity], [Unit], [Articles], [UnitPrice], [Amount] FROM [SISumm] WHERE ([SIID] = @SIID)">
                    <SelectParameters>
                        <asp:QueryStringParameter Name="SIID" QueryStringField="SIID" Type="Int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </div>
        </asp:View>
        <asp:View ID="vDetails" runat="server">
            <div>
                <asp:GridView ID="gvDRDetails" CssClass="table_grid" runat="server" CellPadding="4"
                    ForeColor="#333333" GridLines="None" Font-Names="Verdana" Font-Size="10px" AutoGenerateColumns="False"
                    EnableViewState="False">
                    <AlternatingRowStyle BackColor="White" ForeColor="#284775" />
                    <Columns>
                        <asp:TemplateField>
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Image ID="Image1" runat="server" ImageUrl="~/Resources/Barcode.png" Height="16px" />
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
                        <asp:BoundField DataField="Quantity" HeaderText="QUANTITY">
                            <ItemStyle Font-Bold="True" HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Unit" HeaderText="UNIT" />
                        <asp:BoundField DataField="UnitPrice" DataFormatString="{0:Php###,###.00}" HeaderText="UNIT PRICE">
                            <HeaderStyle Wrap="False" />
                            <ItemStyle Wrap="False" ForeColor="#CC3300" Font-Bold="True" />
                        </asp:BoundField>
                        <asp:BoundField DataField="Amount" DataFormatString="{0:Php###,###.00}" HeaderText="AMOUNT">
                            <HeaderStyle Wrap="False" />
                            <ItemStyle Wrap="False" ForeColor="#CC3300" Font-Bold="True" />
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
