<%@ Page Title="" Language="C#" MasterPageFile="~/WareHouse/WareHouse.Master" AutoEventWireup="true"
    CodeBehind="DailyReportPanel.aspx.cs" Inherits="IntegratedResourceManagementSystem.WareHouse.DailyReportPanel" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="HeadContent" ContentPlaceHolderID="head" runat="server">
    <link href="../Styles/marketing-item-master.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .btnOk
        {
             background:url('../Resources/ok.png');
            background-position:left;
            background-repeat:no-repeat;
            cursor:pointer;
            text-align:right;
        }
        .modalOutlets
        {
            background-color: #999999;
            border: 1px Solid Gray;
        }
        .modalOutletsDrag 
        {
            background-color: #C9C9C9;
            background-image: -moz-linear-gradient(top, #c9c9c9, #848484, #a1a1a1 90%);
            cursor :move;
        }
        .sizeLogo
           {
               margin-top :5px;
               float:left;
               color:White;
               font-size: 11px;
               font-weight :bold;
           }
        .report_type
        {
            font-family: Verdana;
            font-size: 12px;
            cursor: pointer;
        }
        .waterMark
        {
            font-family: Verdana;
            color: #CCCCCC;
            font-style: italic;
        }
        .error
        {
            background: url('../../Resources/warning.png');
            background-repeat: no-repeat;
            padding-left: 30px;
            border: 1px Solid #FFCC66;
            background-color: #FFFFCC;
            text-align: center;
            color: Red;
        }
        .style1
        {
            width: 100%;
        }
        .style3
        {
            width: 203px;
        }
        .style4
        {
            width: 59px;
        }
        .style5
        {
            width: 121px;
        }
        .style6
        {
            width: 159px;
        }
        .style7
        {
            width: 194px;
        }
        .style8
        {
            width: 85px;
        }
        .style9
        {
            width: 261px;
        }
    </style>
</asp:Content>
<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    &nbsp;&nbsp;&nbsp;&nbsp;
    <asp:UpdatePanel ID="upnlDailyReport" runat="server">
        <ContentTemplate>
            <asp:Image ID="Image1" runat="server" ImageUrl="~/Resources/SALES.png" ImageAlign="AbsMiddle" />
            <asp:Label ID="Label1" runat="server" Text="Warehouse Reports:" Font-Size="Medium"></asp:Label>
            <hr />
            <div>
                <asp:RadioButtonList ID="rdioListReportSelector" runat="server" AutoPostBack="True"
                    BackColor="#FFFFCC" BorderColor="#FFCC66" BorderWidth="1px" Font-Bold="True"
                    Font-Names="Verdana" ForeColor="#003366" RepeatDirection="Horizontal" Style="margin-top: 12px"
                    OnSelectedIndexChanged="rdioListReportSelector_SelectedIndexChanged">
                    <asp:ListItem Value="1" Selected="True">Detailed/Itinerary/Summary</asp:ListItem>
                    <asp:ListItem Value="2">Comparative/StockCard</asp:ListItem>
                </asp:RadioButtonList>
            </div>
            <asp:MultiView ID="mvReportSelector" runat="server" ActiveViewIndex="0">
                <asp:View ID="vDaily" runat="server" >
                    <br />
                    <asp:Label ID="Label5" runat="server" Text="Daily Report Types:"></asp:Label>
                    &nbsp;
                    <asp:Label ID="Label6" runat="server" Text="(Select One)" ForeColor="#33CC33"></asp:Label>
                    <br />
                    <asp:RadioButtonList ID="rblist" runat="server" CssClass="report_type" RepeatColumns="3"
                        RepeatDirection="Horizontal" BackColor="#FFFFCC" BorderColor="#FFCC66" BorderStyle="Solid"
                        BorderWidth="1px" ForeColor="#CC6600">
                        <asp:ListItem Value="DailySI">
      Invoice Detailed Report
                        </asp:ListItem>
                        <asp:ListItem Value="DailySIItin">
      Invoice Itinerary Report
                        </asp:ListItem>
                        <asp:ListItem Value="DailySISumm">
      Invoice Summary Report
                        </asp:ListItem>
                        <asp:ListItem Value="DailyDR">
      Delivery Detailed Report
                        </asp:ListItem>
                        <asp:ListItem Value="DailyDRItin">
      Delivery Itinerary Report
                        </asp:ListItem>
                        <asp:ListItem Value="DailyDRSumm">
      Delivery Summary Report
                        </asp:ListItem>
                        <asp:ListItem Value="DailyCRS">
      Return Detailed Report
                        </asp:ListItem>
                        <asp:ListItem Value="DailyCRSItin">
      Return Itinerary Report
                        </asp:ListItem>
                        <asp:ListItem Value="DailyCRSSumm">
      Return Summary Report
                        </asp:ListItem>
                    </asp:RadioButtonList>
                    <br />
                    <table class="style1">
                        <tr>
                            <td style="text-align: right;">
                                <asp:Label ID="lblAsOfDate" runat="server" Text="Date as Of:" AssociatedControlID="txtAsOfDate"
                                    Font-Bold="True" Font-Names="Verdana" Font-Size="12px" ForeColor="#333333"></asp:Label>
                            </td>
                            <td class="style3">
                                <asp:TextBox ID="txtAsOfDate" runat="server"></asp:TextBox>
                                <asp:TextBoxWatermarkExtender ID="txtAsOfDate_TextBoxWatermarkExtender" runat="server"
                                    Enabled="True" TargetControlID="txtAsOfDate" WatermarkCssClass="waterMark" WatermarkText="select date">
                                </asp:TextBoxWatermarkExtender>
                                <asp:CalendarExtender ID="txtAsOfDate_CalendarExtender" runat="server" Enabled="True"
                                    TargetControlID="txtAsOfDate" Format="MMMM dd, yyyy">
                                </asp:CalendarExtender>
                            </td>
                            <td class="style4">
                                &nbsp;
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="style5">
                                &nbsp;
                            </td>
                            <td class="style3">
                                <asp:Button ID="btnPrint" runat="server" OnClick="btnPrint_Click" Text="Print Preview"
                                    CssClass="btnPrint" Width="125px" />
                                <asp:RoundedCornersExtender ID="btnPrint_RoundedCornersExtender" runat="server" BorderColor="YellowGreen"
                                    Enabled="True" TargetControlID="btnPrint">
                                </asp:RoundedCornersExtender>
                            </td>
                            <td class="style4">
                                &nbsp;
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                        <tr>
                            <td class="style5">
                                &nbsp;
                            </td>
                            <td class="style3">
                                &nbsp;
                            </td>
                            <td class="style4">
                                &nbsp;
                            </td>
                            <td>
                                &nbsp;
                            </td>
                        </tr>
                    </table>
                </asp:View>
                <asp:View ID="vOverAll" runat="server">
                     <br />
                    <asp:Label ID="Label2" runat="server" Text="Daily Report Types:"></asp:Label>
                    &nbsp;
                    <asp:Label ID="Label3" runat="server" Text="(Select One)" ForeColor="#33CC33"></asp:Label>
                    <br />
                    <asp:RadioButtonList ID="rblist1" runat="server" CssClass="report_type" RepeatColumns="1"
                        RepeatDirection="Horizontal" BackColor="#FFFFCC" BorderColor="#FFCC66" BorderStyle="Solid"
                        BorderWidth="1px" ForeColor="#CC6600">
                        <asp:ListItem Value="OverAllComParativeYearly">
      Overall Comparative Yearly Report (Date Range)
                        </asp:ListItem>
                        <asp:ListItem Value="OverAllComParativeYearlyperBrand">
      Overall Comparative Yearly Report per Brand (Date Range & Brand)
                        </asp:ListItem>
                        <asp:ListItem Value="StockCard">
      Stock Card Report per Style (Style Numbers)
                        </asp:ListItem>
                    </asp:RadioButtonList>
                    <br />
                    <div>
                        <table>
                            <tr>
                                <td style="text-align: right;">
                                    <asp:Label ID="lblFrom" runat="server" Text="Date From:" AssociatedControlID="txtFrom"
                                        Font-Bold="True" Font-Names="Verdana" Font-Size="12px" ForeColor="#333333"></asp:Label>
                                </td>
                                <td class="style6">
                                    <asp:TextBox ID="txtFrom" runat="server"></asp:TextBox>
                                    <asp:TextBoxWatermarkExtender ID="txtFrom_TextBoxWatermarkExtender" runat="server"
                                        Enabled="True" TargetControlID="txtFrom" WatermarkCssClass="waterMark" WatermarkText="select date">
                                    </asp:TextBoxWatermarkExtender>
                                    <asp:CalendarExtender ID="txtFrom_CalendarExtender" runat="server" Enabled="True"
                                        TargetControlID="txtFrom" Format="MMMM dd, yyyy">
                                    </asp:CalendarExtender>
                                </td>
                                <td style="text-align:right;" class="style8">
                                    <asp:Label ID="lblTo" runat="server" Text="To:" AssociatedControlID="txtTo" Font-Bold="True"
                                        Font-Names="Verdana" Font-Size="12px" ForeColor="#333333"></asp:Label>
                                </td>
                                <td class="style9">
                                    <asp:TextBox ID="txtTo" runat="server"></asp:TextBox>
                                    <asp:TextBoxWatermarkExtender ID="txtTo_TextBoxWatermarkExtender1" runat="server"
                                        Enabled="True" TargetControlID="txtTo" WatermarkCssClass="waterMark" WatermarkText="select date">
                                    </asp:TextBoxWatermarkExtender>
                                    <asp:CalendarExtender ID="txtTo_CalendarExtender" runat="server" Enabled="True" TargetControlID="txtTo"
                                        Format="MMMM dd, yyyy">
                                    </asp:CalendarExtender>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right;">
                                    <asp:Label ID="Label8" runat="server" Text="Brand Name:" AssociatedControlID="dlBrandName"
                                        Font-Bold="True" Font-Names="Verdana" Font-Size="12px" ForeColor="#333333"></asp:Label>
                                </td>
                                <td class="style6">
                                    <asp:DropDownList ID="dlBrandName" runat="server">
                                        <asp:ListItem Value="">- SELECT -</asp:ListItem>
                                        <asp:ListItem>CRISSA</asp:ListItem>
                                        <asp:ListItem>EGO</asp:ListItem>
                                        <asp:ListItem Value="BG BOY KIDS">BB BOY KIDS</asp:ListItem>
                                        <asp:ListItem>HOTKISS</asp:ListItem>
                                        <asp:ListItem>HOTKISS FEMME</asp:ListItem>
                                        <asp:ListItem Value="BG GIRL KIDS">BB GIRL KIDS</asp:ListItem>
                                        <asp:ListItem>RED GIRL</asp:ListItem>
                                        <asp:ListItem>FUBU</asp:ListItem>
                                        <asp:ListItem>FUBU GIRLS</asp:ListItem>
                                        <asp:ListItem>EUROPRESS</asp:ListItem>
                                        <asp:ListItem>BUBBLEGUM</asp:ListItem>
                                        <asp:ListItem>CLIFFE</asp:ListItem>
                                        <asp:ListItem>NO APOLOGIES</asp:ListItem>
                                        <asp:ListItem>SURPLUS</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:ListSearchExtender ID="dlBrandName_ListSearchExtender" runat="server" Enabled="True"
                                        TargetControlID="dlBrandName" PromptPosition="Bottom">
                                    </asp:ListSearchExtender>
                                </td>
                                <td style="text-align:right;" class="style8">
                                    <asp:Label ID="lblStyle" runat="server" AssociatedControlID="txtStyle" 
                                        Font-Bold="True" Font-Names="Verdana" Font-Size="12px" ForeColor="#333333" 
                                        Text="Style No.:"></asp:Label>
                                    </td>
                                <td class="style9">
                                    <asp:TextBox ID="txtStyle" runat="server"></asp:TextBox>
                                    <asp:TextBoxWatermarkExtender ID="txtStyle_TextBoxWatermarkExtender" 
                                        runat="server" Enabled="True" TargetControlID="txtStyle" 
                                        WatermarkCssClass="waterMark" WatermarkText="insert Style No.">
                                    </asp:TextBoxWatermarkExtender>&nbsp;
                                    <asp:Button ID="btnStyleBrowse" runat="server" Text="..." />
                                    <asp:ModalPopupExtender ID="btnStyleBrowse_ModalPopupExtender" runat="server" 
                                        BackgroundCssClass="bgModal" CancelControlID="imgBtnCloseStyle" 
                                        DynamicServicePath="" Enabled="True" PopupControlID="StyleListPanel" 
                                        PopupDragHandleControlID="pnlStyleDrag" TargetControlID="btnStyleBrowse">
                                    </asp:ModalPopupExtender>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                </td>
                                <td class="style6">
                                    <asp:Button ID="btnPrintOverAll" runat="server" OnClick="btnPrint_Click" Text="Print Preview"
                                        CssClass="btnPrint" Width="125px" />
                                    <asp:RoundedCornersExtender ID="btnPrintOverAll_RoundedCornersExtender" runat="server"
                                        BorderColor="YellowGreen" Enabled="True" TargetControlID="btnPrintOverAll">
                                    </asp:RoundedCornersExtender>
                                </td>
                                <td class="style8">
                                </td>
                                <td class="style9">
                                </td>
                            </tr>
                        </table>
                    </div>

                    <asp:Panel ID ="StyleListPanel" runat ="server" CssClass ="modalOutlets" 
                        Width="482px">
                        <asp:Panel ID= "pnlStyleDrag" runat ="server" CssClass ="modalOutletsDrag" 
                            Width="482px" >
                            <div class ="close_btn">
                                    <asp:ImageButton ID="imgBtnCloseStyle" runat="server" 
                                                     CssClass ="btnClose" ImageUrl="~/Resources/cancel_gray.png" 
                                        ToolTip="CLOSE" Width="16px"/>
                            </div> 
                            <div class ="sizeLogo">
                            <asp:Image ID="Image3" runat="server" Height="16px" ImageAlign="AbsBottom" 
                                        ImageUrl="~/Resources/usermode.png" />
                                STYLE LIST
                            </div>
                        </asp:Panel>
                        <div style ="margin-left:5px; height:24px; width: 482px;">
            
                            <div style ="float:right; margin-right:3px;">
                                <asp:Label ID="Label4" runat="server" Text="FILTER:" Font-Names="Verdana" 
                                        Font-Size="11px" ForeColor="#FFFFCC"></asp:Label>
                                <asp:TextBox ID="txtSearchStyle" runat="server" Font-Names="Verdana" 
                                        Font-Size="10px"></asp:TextBox>
                                <asp:ImageButton ID="imgBtnSearchStyle" runat="server" Height="18px" 
                                        ImageUrl="~/Resources/search.png" ImageAlign="AbsMiddle" 
                                        onclick="imgBtnSearchStyle_Click" ToolTip="SEARCH" />
                            </div>
                        </div>
    
                        <asp:Panel ID ="StylePanel" runat ="server" ScrollBars="Auto" >
                            <asp:GridView ID="gvStyleList" runat="server" BackColor="White" 
                                BorderColor="#CCCCCC" BorderStyle="None" BorderWidth="1px" CellPadding="4" 
                                Font-Names="Verdana" Font-Size="11px" 
                                ForeColor="Black" GridLines="Horizontal" AllowPaging="True" 
                                AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="StyleNo" 
                                DataSourceID="SqlDataSourceStyle" 
                                onselectedindexchanged="gvStyleList_SelectedIndexChanged" 
                                EnablePersistedSelection="True" 
                                onpageindexchanged="gvStyleList_PageIndexChanged" 
                                onsorted="gvStyleList_Sorted" onpageindexchanging="gvStyleList_PageIndexChanging">
                                <Columns>
                                    <asp:TemplateField>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                                        </EditItemTemplate>
                                        <ItemTemplate>
                                            <asp:Image ID="imgStyle" runat="server" Height="16px" 
                                                ImageUrl="~/Resources/invoice.png" AlternateText='<%# Eval("StyleNo").ToString() %>' />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:CommandField ShowSelectButton="True" />
                                    <asp:BoundField DataField="StyleNo" HeaderText="STYLE NO." 
                                        SortExpression="StyleNo">
                                        <HeaderStyle Wrap="False" />
                                        <ItemStyle Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="StyleDesc" HeaderText="STYLE DESCRIPTION" >
                                        <HeaderStyle Wrap="False" />
                                        <ItemStyle Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="BrandName" HeaderText="BRAND NAME" >
                                        <HeaderStyle Wrap="False" />
                                        <ItemStyle Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="AP_Type" HeaderText="TOPS / BOTTOMS" >
                                        <HeaderStyle Wrap="False" />
                                        <ItemStyle Wrap="False" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="BRAND_CODE" HeaderText="BRAND CODE" >
                                        <HeaderStyle Wrap="False" />
                                        <ItemStyle Wrap="False" />
                                    </asp:BoundField>
                                </Columns>
                                <FooterStyle BackColor="#CCCC99" ForeColor="Black" />
                                <HeaderStyle BackColor="#333333" Font-Bold="True" ForeColor="White" />
                                <PagerSettings FirstPageImageUrl="~/Resources/first.png" 
                                    LastPageImageUrl="~/Resources/last.png" Mode="NumericFirstLast" />
                                <PagerStyle BackColor="White" ForeColor="Black" HorizontalAlign="Left" />
                                <SelectedRowStyle BackColor="#CC3333" Font-Bold="True" ForeColor="White" />
                                <SortedAscendingCellStyle BackColor="#F7F7F7" />
                                <SortedAscendingHeaderStyle BackColor="#4B4B4B" />
                                <SortedDescendingCellStyle BackColor="#E5E5E5" />
                                <SortedDescendingHeaderStyle BackColor="#242121" />
                            </asp:GridView>
                            <asp:SqlDataSource ID="SqlDataSourceStyle" runat="server" 
                                ConnectionString="<%$ ConnectionStrings:IRMSConnectionString %>" 
                                SelectCommand="SELECT [StyleNo], [BrandName], [StyleDesc], [AP_Type], [BRAND_CODE] FROM [Style] a inner join [BRANDS] b on a.BrandName=b.BRAND_DESCRIPTION">
                            </asp:SqlDataSource>
                        </asp:Panel>
                        <div style ="text-align :center; margin:3px 0px 3px 0px;">
                            <asp:Button ID="btnSelectStyle" runat="server" Text="OK" CssClass ="btnOk"
                                onclick="btnSelectStyle_Click" BackColor="#CCCCCC" Font-Names="Verdana" 
                                Font-Size="11px" ForeColor="#FFFFCC" Height="24px" Width="50px" />
                            <asp:RoundedCornersExtender ID="RoundedCornersExtender" 
                                runat="server" BorderColor="YellowGreen" Enabled="True" 
                                TargetControlID="btnSelectStyle">
                            </asp:RoundedCornersExtender>
                        </div>
                    </asp:Panel>
                </asp:View>
            </asp:MultiView>

            <asp:Panel ID ="pnlError" runat ="server" Visible ="false"  >
                <div style ="text-align:center; background-color:#FFFFCC; border:1px Solid #FFCC66; height :25px;" >
                  <asp:Image ID="Image2" runat="server" ImageUrl="~/Resources/warning.png" 
                        ImageAlign="AbsMiddle" /> <asp:Label ID="lblError" runat="server" 
                        Text="PLEASE SELECT REQUIRED PARAMETER!!" Font-Bold="True" Font-Names="Verdana" 
                        Font-Size="12px" ForeColor="#CC6600"/>
                </div>
            </asp:Panel>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
