﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="PrintAdjustmentReport.aspx.cs"
    Inherits="PrintAdjustmentReport" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="Shared.WebControls" Namespace="Shared.WebControls" TagPrefix="wc" %>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Print Preview - Adjustment Details Report</title>
    <script type="text/javascript">
        function CallPrint(strid) {
            var prtContent = document.getElementById(strid);
            var WinPrint = window.open('', '', 'letf=0,top=0,width=600,height=400,toolbar=0,scrollbars=1,status=0');
            WinPrint.document.write(prtContent.innerHTML);
            WinPrint.document.close();
            WinPrint.focus();
            WinPrint.print();
            WinPrint.close();

        }
    </script>
</head>
<body style="font-family: 'Trebuchet MS'; font-size: 11px;">
    <form id="form1" runat="server">
    <br />
    <asp:Button ID="btnPrint" Text="Print" runat="server" OnClientClick="javascript:CallPrint('divPrint')" />
    &nbsp;
    <asp:Button ID="btnBack" Text="Back" runat="server" OnClick="btnBack_Click" />
    <div id="divPrint" style="font-family: 'Trebuchet MS'; font-size: 11px;">
        <table width="600px" border="0" style="font-family: 'Trebuchet MS'; font-size: 11px;">
            <tr>
                <td>
                </td>
                <td align="center">
                    &nbsp;
                </td>
                <td align="right">
                    Date:
                    <asp:Label ID="lblDate" runat="server"> </asp:Label>
                </td>
            </tr>
            <tr>
                <td colspan="3">
                    <br />
                    <h5>
                        Adjustment Details Report From
                        <asp:Label ID="lblStartDate" runat="server"> </asp:Label>
                        To
                        <asp:Label ID="lblEndDate" runat="server"> </asp:Label></h5>
                </td>
            </tr>
        </table>
        <br />
        <wc:ReportGridView runat="server" BorderWidth="1" ID="gvAdjDetails" AutoGenerateColumns="false"
            PrintPageSize="23" AllowPrintPaging="true" Width="600px" OnRowDataBound="gvAdjDetails_RowDataBound"
            Style="font-family: 'Trebuchet MS'; font-size: 11px;">
            <PageHeaderTemplate>
                <br />
                <br />
            </PageHeaderTemplate>
            <Columns>
                <asp:BoundField DataField="Area" HeaderText="Area" />
                <asp:BoundField DataField="Name" HeaderText="Name" />
                <asp:BoundField DataField="Code" HeaderText="Code" />
                <asp:BoundField DataField="Doorno" HeaderText="Doorno" />
                <asp:BoundField DataField="DateEntered" HeaderText="Date Entered" />
                <asp:BoundField ItemStyle-HorizontalAlign="Right" DataField="Amount" HeaderText="Amount" />
                <asp:BoundField ItemStyle-Width="120px" DataField="Reason" HeaderText="Reason" />
            </Columns>
            <PagerTemplate>
            </PagerTemplate>
            <PageFooterTemplate>
                <br />
                <hr />
                <%-- Page <%# gvCashDetails.CurrentPrintPage.ToString() %> / <%# gvCashDetails.PrintPageCount%>--%>
            </PageFooterTemplate>
        </wc:ReportGridView>
        <br />
        <table width="600px" border="0" style="font-family: 'Trebuchet MS'; font-size: 11px;">
            <tr>
                <td width="200px">
                    &nbsp;
                </td>
                <td width="190px" align="right">
                    <b>Total Amount :</b>
                </td>
                <td width="90px" align="right">
                    <hr />
                    <asp:Label ID="lblAmount" runat="server"></asp:Label><hr />
                </td>
                <td width="120px">
                    &nbsp;
                </td>
            </tr>
        </table>
        <br />
        <br />
    </div>
    </form>
</body>
</html>
