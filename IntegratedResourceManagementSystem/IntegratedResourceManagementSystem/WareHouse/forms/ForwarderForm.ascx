<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="ForwarderForm.ascx.cs" Inherits="IntegratedResourceManagementSystem.WareHouse.forms.ForwarderForm" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit" tagprefix="asp" %>

    <table>
      <tr>
        <td class ="modalLabel" >
          FORWARDER NAME:
        </td>
        <td>
          <asp:TextBox ID="txtForwarderName" CssClass="modalText" runat="server" Height="22px" Font-Names="Verdana" 
                        Width ="250px" >
               </asp:TextBox><asp:RequiredFieldValidator ID="reqvalidatorForwarderName"
                           runat="server" ErrorMessage="Forwarder Name is required!" 
                ControlToValidate="txtForwarderName" Display="None" SetFocusOnError="True"></asp:RequiredFieldValidator>
            <asp:ValidatorCalloutExtender ID="reqvalidatorForwarderName_ValidatorCalloutExtender" 
                runat="server" Enabled="True" TargetControlID="reqvalidatorForwarderName">
            </asp:ValidatorCalloutExtender>
        </td>
        <td>
          &nbsp;
        </td>
      </tr>
      <tr>
        <td class ="modalLabel" >
            FORWARDER ADDRESS:
        </td>
        <td>
          <asp:TextBox ID="txtForwarderAddress" CssClass="modalText" runat="server" Height="40px" 
                       TextMode="MultiLine" Font-Names="Verdana" ForeColor="#CC6600" 
                Width ="250px" Font-Size="11px"></asp:TextBox>
        </td>
        <td>
          &nbsp;
        </td>
      </tr>
      <tr>
        <td class ="modalLabel">
            CONTACT NUMBER:</td>
        <td>
            <asp:TextBox CssClass="modalText" ID="txtContactNumber" runat="server" Font-Names="Verdana" 
                ForeColor="#CC6600" Height="22px" Width ="200px"></asp:TextBox>
          </td>
        <td>
            &nbsp;</td>
      </tr>
        </table>
