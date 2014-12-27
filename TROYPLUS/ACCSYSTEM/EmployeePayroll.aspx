﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EmployeePayroll.aspx.cs" Inherits="EmployeePayroll" MasterPageFile="~/PageMaster.master" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cplhTab" runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="cplhControlPanel" runat="Server">
    <asp:UpdatePanel ID="UpdatePanelMain" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <table style="width: 100%">
                <tr style="width: 100%">
                    <td style="width: 100%">
                        <div class="mainConBody">
                            <table style="width: 100%; margin: -1px 0px 0px 1px;" cellpadding="3" cellspacing="2" class="searchbg">
                                <tr style="height: 25px; vertical-align: middle">
                                    <td style="width: 5%"></td>
                                    <td style="width: 20%; font-size: 22px; color: #000000;">Initiate Payroll
                                    </td>
                                    <td style="width: 60%;"></td>
                                    <td style="width: 15%;"></td>
                                </tr>
                                <tr style="height: 25px; vertical-align: middle">
                                    <td style="width: 5%"></td>
                                    <td style="width: 20%;  color:black;">Choose payroll year:</td>
                                    <td style="width: 60%;">
                                        <div style="width: 160px; font-family: 'Trebuchet MS';">
                                            <asp:DropDownList ID="ddlYear" runat="server" Width="154px" BackColor="#BBCAFB" Height="23px"
                                                Style="text-align: center; border: 1px solid #BBCAFB" Visible="true" DataTextField="MonthName" DataValueField="MonthId"
                                                AutoPostBack="true">
                                                <asp:ListItem Text="2014" Value="2014" Selected="True"></asp:ListItem>
                                                <asp:ListItem Text="2015" Value="2015"></asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </td>
                                    <td style="width: 15%;"></td>
                                </tr>

                                <tr style="height: 25px; vertical-align: middle">
                                    <td style="width: 5%"></td>
                                    <td style="width: 20%; color:black;">Choose payroll month:</td>
                                    <td style="width: 60%;">
                                        <div style="width: 160px; font-family: 'Trebuchet MS';">
                                            <asp:DropDownList ID="ddlMonth" runat="server" Width="154px" BackColor="#BBCAFB" Height="23px"
                                                Style="text-align: center; border: 1px solid #BBCAFB" Visible="true" DataTextField="MonthName" DataValueField="MonthId"
                                                AutoPostBack="true">
                                            </asp:DropDownList>
                                        </div>
                                    </td>
                                    <td style="width: 15%;"></td>
                                </tr>
                                <tr style="height: 25px; vertical-align: middle">
                                    <td style="width: 5%"></td>
                                    <td style="width: 20%">                                        

                                    </td>
                                    <td style="width: 60%;">
                                        <div style="text-align: left;">
                                            <asp:Label ID="lblPayrollStatus" runat="server" Text="Status" ForeColor="Black"></asp:Label>
                                            <asp:HiddenField ID="hdfPayrollId" runat="server" Value="" />
                                        </div>
                                    </td>
                                    <td style="width: 15%;"></td>
                                </tr>

                                <tr style="height: 25px; vertical-align: middle">
                                    <td style="width: 5%"></td>
                                    <td style="width: 20%">
                                        <asp:Button ID="btnSearchpayroll" runat="server" Text="Search Payroll" EnableTheming="false" OnClick="btnSearchpayroll_Click" />
                                        <asp:Button ID="btnQueuePayroll" runat="server" Text="Queue Payroll" Enabled="false" EnableTheming="false" OnClick="btnQueuePayroll_Click" />
                                        </td>
                                        <td style="width: 60%;" align="left">
                                            <asp:Button ID="btnViewPayslips" runat="server" Text="View Payslip" Enabled="false" EnableTheming="false" OnClick="btnViewPayslips_Click" />
                                        </td>
                                        <td style="width: 15%;"></td>
                                </tr>
                            </table>
                        </div>
                    </td>
                </tr>
                <tr style="width: 100%; height: 100%">
                    <td style="width: 100%">
                        <table width="100%" style="margin: -3px 0px 0px 0px;">
                            <tr style="width: 100%">
                                <td>
                                    <div class="mainGridHold" id="searchGrid">
                                        <asp:GridView ID="grdViewPaySlipInfo" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                            Width="99.9%" AllowPaging="True" DataKeyNames="PayslipId"
                                            EmptyDataText="No payslip associated with this payroll." Font-Names="Trebuchet MS" CssClass="someClass">
                                            <Columns>
                                                <asp:BoundField DataField="PayslipId" HeaderText="PayslipId" Visible="false" HeaderStyle-BorderColor="Gray" />
                                                <asp:BoundField DataField="EmployeeName" HeaderText="Employee Name" Visible="false" />
                                                <asp:BoundField DataField="PayrollDate" HeaderText="PayrollDate" Visible="false" />
                                                <asp:BoundField DataField="Deductions" HeaderText="Deductions" HeaderStyle-BorderColor="Gray" />
                                                <asp:BoundField DataField="Payments" HeaderText="Payements" HeaderStyle-BorderColor="Gray" />
                                                <asp:BoundField DataField="TotalPayable" HeaderText="Total Payable" HeaderStyle-BorderColor="Gray" NullDisplayText="NA" />
                                            </Columns>
                                            <PagerTemplate>
                                                <table style="border-color: white">
                                                    <tr style="border-color: white">
                                                        <td style="border-color: white">Goto Page
                                                        </td>
                                                        <td style="border-color: white">
                                                            <asp:DropDownList ID="ddlPageSelector" runat="server" AutoPostBack="true" Style="border: 1px solid blue" BackColor="#BBCAFB" Width="75px" Height="25px">
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td style="border-color: white; width: 5px"></td>
                                                        <td style="border-color: white">
                                                            <asp:Button Text="" CommandName="Page" CommandArgument="First" runat="server" CssClass="NewFirst" EnableTheming="false" Width="22px" Height="18px"
                                                                ID="btnFirst" />
                                                        </td>
                                                        <td style="border-color: white">
                                                            <asp:Button Text="" CommandName="Page" CommandArgument="Prev" runat="server" CssClass="NewPrev" EnableTheming="false" Width="22px" Height="18px"
                                                                ID="btnPrevious" />
                                                        </td>
                                                        <td style="border-color: white">
                                                            <asp:Button Text="" CommandName="Page" CommandArgument="Next" runat="server" CssClass="NewNext" EnableTheming="false" Width="22px" Height="18px"
                                                                ID="btnNext" />
                                                        </td>
                                                        <td style="border-color: white">
                                                            <asp:Button Text="" CommandName="Page" CommandArgument="Last" runat="server" CssClass="NewLast" EnableTheming="false" Width="22px" Height="18px"
                                                                ID="btnLast" />
                                                        </td>

                                                    </tr>
                                                </table>
                                            </PagerTemplate>
                                        </asp:GridView>
                                    </div>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
