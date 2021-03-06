﻿<%@ Page Language="C#" MasterPageFile="~/MasterPage.master" AutoEventWireup="true"
    CodeFile="ReportExcelHirePurchase.aspx.cs" Inherits="ReportExcelHirePurchase" Title="Hire Purchase Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .style1
        {
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <center>
    <br />
        <div >
            <table width="400px" style="background-color:White; border:1px solid blue;">
                <tr class="headerPopUp">
                    <td colspan="4">
                        <table>
                            <tr>
                                <td>
                                    Hire Purchase Report
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr style="height:15px">

                </tr>
                <tr>
                    <td style="width:25%">
                    
                    </td>
                    <td style="width:1%">
                        <asp:Button ID="btnData" runat="server" OnClick="btnData_Click" CssClass="generatebutton" EnableTheming="false"   Visible="False" />
                    </td>
                    <td  style="width:20%">
                        <asp:Button ID="btnxls" runat="server" OnClick="btnxls_Click"  CssClass="exportexl6" EnableTheming="false" />
                    </td>
                    <td style="width:30%">
                    
                    </td>
                </tr>
             </table>
            </div>

            <table style="width:100%">
            <tr style="height:6px">

                </tr>
            <tr>
                <td style="width:100%">
                    <asp:GridView ID="GridCust" runat="server" BackColor="White" BorderColor="blue" Width="100%"  OnRowCreated="GridCust_RowCreated" OnPageIndexChanging="GridCust_PageIndexChanging"
                        BorderStyle="Solid" BorderWidth="1px" CellPadding="3" CellSpacing="1" Font-Size="Small" Font-Names="Trebuchet MS" CssClass="someClass"
                        AutoGenerateColumns="False" OnRowDataBound="GridCust_RowDataBound" AllowPaging="True" HeaderStyle-ForeColor="Black">
                        <Columns>
                            <asp:TemplateField HeaderText="Product Name"  HeaderStyle-BorderColor="Blue" >
                                <ItemTemplate>
                                    <asp:Label ID="lblLedger" runat="server" Text='<%# Eval("ProductName") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Item Code"  HeaderStyle-BorderColor="Blue" >
                                <ItemTemplate>
                                    <asp:Label ID="lblLed" runat="server" Text='<%# Eval("ItemCode") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Model"  HeaderStyle-BorderColor="Blue" >
                                <ItemTemplate>
                                    <asp:Label ID="lblLedg" runat="server" Text='<%# Eval("Model") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Brand"  HeaderStyle-BorderColor="Blue" >
                                <ItemTemplate>
                                    <asp:Label ID="lblLedge" runat="server" Text='<%# Eval("Productdesc") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Opening Stock"  HeaderStyle-BorderColor="Blue">
                                <ItemTemplate>
                                    <asp:Label ID="lblAlisname" runat="server" Text='<%# Eval("OpeningStock") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <PagerTemplate>
                                    <table style=" border-color:white">
                                        <tr style=" border-color:white">
                                            <td style=" border-color:white">
                                                Goto Page
                                            </td>
                                            <td style=" border-color:white">
                                                <asp:DropDownList ID="ddlPageSelector" OnSelectedIndexChanged="ddlPageSelector_SelectedIndexChanged" runat="server" AutoPostBack="true" style="border:1px solid blue"  Width="65px">
                                                </asp:DropDownList>
                                            </td>
                                            <td style=" border-color:white;Width:5px">
                                            
                                            </td>
                                            <td style=" border-color:white">
                                                <asp:Button Text="" CommandName="Page" CommandArgument="First" runat="server" CssClass="NewFirst" EnableTheming="false" Width="22px" Height="18px"
                                                    ID="btnFirst" />
                                            </td>
                                            <td style=" border-color:white">
                                                <asp:Button Text="" CommandName="Page" CommandArgument="Prev" runat="server" CssClass="NewPrev" EnableTheming="false" Width="22px" Height="18px"
                                                    ID="btnPrevious" />
                                            </td>
                                            <td style=" border-color:white">
                                                <asp:Button Text="" CommandName="Page" CommandArgument="Next" runat="server" CssClass="NewNext" EnableTheming="false" Width="22px" Height="18px"
                                                    ID="btnNext" />
                                            </td>
                                            <td style=" border-color:white">
                                                <asp:Button Text="" CommandName="Page" CommandArgument="Last" runat="server" CssClass="NewLast" EnableTheming="false" Width="22px" Height="18px"
                                                    ID="btnLast" />
                                            </td>
                                        </tr>
                                    </table>
                                </PagerTemplate>
                        <RowStyle BackColor="#DEDFDE" ForeColor="Black" />
                        <FooterStyle BackColor="#C6C3C6" ForeColor="Black" />
                        <PagerStyle BackColor="#C6C3C6" ForeColor="Black" HorizontalAlign="Right" />
                        <SelectedRowStyle BackColor="#9471DE" Font-Bold="True" ForeColor="White" />
                        <HeaderStyle BackColor="#4A3C8C" Font-Bold="True" ForeColor="black" />
                    </asp:GridView>
                </td>
               
            </tr>
        </table>

    </center>
</asp:Content>
