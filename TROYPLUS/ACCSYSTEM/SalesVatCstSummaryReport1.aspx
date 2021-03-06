﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SalesVatCstSummaryReport1.aspx.cs"
    Inherits="SalesVatCstSummaryReport1" %>

<%@ Register Assembly="Shared.WebControls" Namespace="Shared.WebControls" TagPrefix="wc" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Sales VAT/CST Summary Report</title>
    <link href="App_Themes/DefaultTheme/calendar.css" rel="stylesheet" type="text/css" />
    <script language="javascript" type="text/javascript" src="Scripts/calendar_eu.js"></script>
    <script language="javascript" type="text/javascript">
        function CallPrint(strid) {
            var prtContent = document.getElementById(strid);
            var WinPrint = window.open('', '', 'letf=0,top=0,width=600,height=400,toolbar=0,scrollbars=1,status=0');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();

        }
        function PrintItem(ID, Customername) {
            //alert(Customername);
            window.showModalDialog('BillCustomerView.aspx?ID=' + ID + '&cname=' + escape(Customername), self, 'dialogWidth:700px;dialogHeight:430px;status:no;dialogHide:yes;unadorned:yes;');
            //window.open('BillCustomerView.aspx?ID=' + ID + '&cname=' + Customername ,'','letf=0,top=0,width=600,height=400,toolbar=0,scrollbars=1,status=0');
            //alert('BillCustomerView.aspx?ID=' + ID + '&cname=' + Customername );
        }
        function switchViews(obj, imG) {
            var div = document.getElementById(obj);
            var img = document.getElementById(imG);

            if (div.style.display == "none") {
                div.style.display = "inline";


                img.src = "App_Themes/DefaultTheme/Images/minus.gif";

            }
            else {
                div.style.display = "none";
                img.src = "App_Themes/DefaultTheme/Images/plus.gif";

            }
        }

    </script>
    <link rel="Stylesheet" href="App_Themes/DefaultTheme/DefaultTheme.css" />
    <style type="text/css">
        .style1
        {
            height: 21px;
        }
    </style>
</head>
<body style="font-family: 'Trebuchet MS'; font-size: 11px;">
    <form id="form1" runat="server">
    <div align="center">
        <br />
        <div align="center" id="Div1" runat="server">
        <table cellpadding="2" cellspacing="2" width="450px" border="0" style="border: 1px solid blue; background-color:White;
            ">
            <%--<tr>
                <td colspan="4">
                    <table class="headerPopUp">
                        <tr>
                            <td>
                                Sales VAT/CST Summary Report
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>--%>
            <tr>
                <td colspan="4" class="subHeadFont2">
                    Sales VAT/CST Summary Report
                </td>
            </tr>
            <tr style="height:5px">
                                                            </tr>
            <tr>
                <td  style="width:25%; font-family:'ARIAL';font-size:11px;font-weight:normal; color: #000000;text-align:right;text-decoration:none;padding-right:5px;padding-left:5px;padding-top:5px;" height="27px">
                    Start Date
                </td>
                <td  style="width:25%" class="ControlTextBox3">
                    <asp:TextBox ID="txtStartDate" CssClass="cssTextBox" Width="100px" MaxLength="10"
                        runat="server" />
                    
                </td>
                <td align="left" style="width:10%">
                    <script type="text/javascript" language="JavaScript">                    new tcal({ 'formname': 'form1', 'controlname': 'txtStartDate' });</script>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtStartDate"
                        Display="None" CssClass="lblFont" ErrorMessage="Please Enter Start Date"></asp:RequiredFieldValidator>
                </td>
                <td style="width:10%">

                </td>
            </tr>
            <tr>
                <td  style="width:25%; font-family:'ARIAL';font-size:11px;font-weight:normal; color: #000000;text-align:right;text-decoration:none;padding-right:5px;padding-left:5px;padding-top:5px;" height="27px">
                    End Date
                </td>
                <td style="width:25%" class="ControlTextBox3">
                    <asp:TextBox ID="txtEndDate" CssClass="cssTextBox" Width="100px" MaxLength="10" runat="server" />
                    
                </td>
                <td align="left" style="width:10%">
                    <script type="text/javascript" language="JavaScript">                    new tcal({ 'formname': 'form1', 'controlname': 'txtEndDate' });</script>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtEndDate"
                        Display="None" ErrorMessage="Please Enter The End Date" CssClass="lblFont"></asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="txtStartDate"
                        ControlToValidate="txtEndDate" Display="None" ErrorMessage="Start Date Should Be Less Than the End Date"
                        CssClass="lblFont" Operator="GreaterThanEqual" SetFocusOnError="True" Type="Date"></asp:CompareValidator>
                </td>
                <td style="width:10%">

                </td>
            </tr>
            <tr>
                <td   style="width:25%; font-family:'ARIAL';font-size:11px;font-weight:normal; color: #000000;text-align:right;text-decoration:none;padding-right:5px;padding-left:5px;padding-top:5px;" height="27px">
                    Dealer/Customer
                </td>
                <td class="ControlDrpBorder" style="width:25%">
                    <asp:DropDownList TabIndex="1" ID="drpLedgerName" AppendDataBoundItems="true"  CssClass="drpDownListMedium" BackColor = "#90c9fc" Width="100%"
                        runat="server" AutoPostBack="true" DataValueField="LedgerID" DataTextField="LedgerName" style="border: 1px solid #90c9fc" height="26px"
                        ValidationGroup="salesval">
                        <asp:ListItem Text="ALL " Value="0"></asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td align="left" style="width:10%">
                    
                </td>
                <td style="width:10%">

                </td>
            </tr>
            <tr>
                <td   style="width:25%; font-family:'ARIAL';font-size:11px;font-weight:normal; color: #000000;text-align:right;text-decoration:none;padding-right:5px;padding-left:5px;padding-top:5px;" height="27px">
                    VAT
                </td>
                <td class="ControlDrpBorder" style="width:25%">
                    <asp:DropDownList TabIndex="1" ID="drpVat" AppendDataBoundItems="true"  CssClass="drpDownListMedium" BackColor = "#90c9fc" Width="100%"
                        runat="server" AutoPostBack="true" DataValueField="vat" DataTextField="vat" ValidationGroup="salesval" style="border: 1px solid #90c9fc" height="26px">
                        <asp:ListItem Text="ALL " Value="99"></asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td align="left"  style="width:10%">
                    
                </td>
                <td style="width:10%">

                </td>
            </tr>
            <tr>
                <td   style="width:25%; font-family:'ARIAL';font-size:11px;font-weight:normal; color: #000000;text-align:right;text-decoration:none;padding-right:5px;padding-left:5px;padding-top:5px;" height="27px">
                    CST
                </td>
                <td class="ControlDrpBorder" style="width:25%">
                    <asp:DropDownList TabIndex="1" ID="drpCst" AppendDataBoundItems="true"  CssClass="drpDownListMedium" BackColor = "#90c9fc" Width="100%"
                        runat="server" AutoPostBack="true" DataValueField="cst" DataTextField="cst" ValidationGroup="salesval" style="border: 1px solid #90c9fc" height="26px">
                        <asp:ListItem Text="ALL " Value="99"></asp:ListItem>
                    </asp:DropDownList>
                </td>
                <td style="width:10%">
                    
                </td>
                <td style="width:10%">

                </td>
            </tr>
            <tr style="height:5px">
                                                            </tr>
            <tr>
                <td colspan="4">
                    <table width="100%">
                        <tr>
                            <td  style="width:30%">
                                <asp:ValidationSummary ID="valSummary" runat="server" ShowMessageBox="true" ShowSummary="false" />
                            </td>
                            <td style="width:20%">
                               <asp:Button ID="Button2"  CssClass="NewReport6" EnableTheming="false" runat="server"
                                    OnClick="btnRep_Click" />
                            </td>
                            <td style="width:20%">
                                <asp:Button ID="btnReport"  CssClass="exportexl6" EnableTheming="false" runat="server"
                                    OnClick="btnReport_Click" />
                            </td>
                            <td style="width:30%">

                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td colspan="3" class="style1">
                    <asp:Label ID="lblErr" runat="server" CssClass="errorMsg"></asp:Label>
                </td>
            </tr>
        </table>
        </div>
        <br />
        <div id="divmain" runat="server" visible="false">
            <table width="700px">
                <tr>
                    <td style="width: 40%;">

                    </td>
                    <td style="width: 20%;">
                        <input type="button" value=""
                                        id="Button1" runat="Server" onclick="javascript:CallPrint('divPrint')" class="printbutton6"  />
                    </td>
                    <td style="width: 10%;">
                        <asp:Button ID="btndet" CssClass="GoBack" EnableTheming="false" runat="server"
                                OnClick="btndet_Click" Visible="False" />
                    </td>
                    <td style="width: 30%;">

                    </td>
                </tr>
            </table>
            <br />
        
        <div id="divPrint" style="font-family: 'Trebuchet MS'; font-size: 11px;" >
            
            <table width="450px" border="0" style="font-family: Trebuchet MS; font-size: 14px;">
                <tr>
                    <td width="140px" align="left">
                        
                        <asp:Label ID="lblTNGST" runat="server"></asp:Label>
                    </td>
                    <td align="center" width="320px" style="font-size: 20px;">
                        <asp:Label ID="lblCompany" runat="server"></asp:Label>
                    </td>
                    <td width="140px" align="left">
                       
                        <asp:Label ID="lblPhone" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td align="left">
                       
                        <asp:Label ID="lblGSTno" runat="server"></asp:Label>
                    </td>
                    <td align="center">
                        <asp:Label ID="lblAddress" runat="server"></asp:Label>
                    </td>
                    <td align="left">
                        
                        <asp:Label ID="lblBillDate" runat="server"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td align="center">
                        <asp:Label ID="lblCity" runat="server" />
                        -
                        <asp:Label ID="lblPincode" runat="server"></asp:Label>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td align="center">
                        <asp:Label ID="lblState" runat="server"> </asp:Label>
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
                <tr>
                    <td>
                        &nbsp;
                    </td>
                    <td align="center">
                        &nbsp;
                    </td>
                    <td>
                        &nbsp;
                    </td>
                </tr>
            </table>
            <div id="divReport" style="width: 80%" runat="server">
            </div>
        </div>
        </div>
    </div>
    </form>
</body>
</html>
