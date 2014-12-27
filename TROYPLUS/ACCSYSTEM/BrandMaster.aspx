﻿<%@ Page Language="C#" MasterPageFile="~/PageMaster.master" AutoEventWireup="true"
    CodeFile="BrandMaster.aspx.cs" Inherits="BrandMaster" Title="Inventory > Brand Master" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cplhTab" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cplhControlPanel" runat="Server">
    <script language="javascript" type="text/javascript">

//        function Mobile_Validator() {
//            var ctrMobile = document.getElementById('ctl00_cplhControlPanel_frmViewAdd_txtMobile');

//            if (ctrMobile == null)
//                ctrMobile = document.getElementById('ctl00_cplhControlPanel_frmViewAdd_txtMobileAdd');

//            var txtMobile = ctrMobile.value;

//            if (txtMobile.length > 0) {
//                if (txtMobile.length != 10) {
//                    alert("Customer Mobile Number should be minimum of 10 digits.");
//                    Page_IsValid = false;
//                    return window.event.returnValue = false;
//                }

//                if (txtMobile.charAt(0) == "0") {
//                    alert("Customer Mobile should not start with Zero. Please remove Zero and try again.");
//                    Page_IsValid = false;
//                    return window.event.returnValue = false;
//                }
//            }
//            else {
//                Page_IsValid = true;
//            }
//        }

    </script>
    <asp:UpdatePanel ID="UpdatePanel16" runat="server" UpdateMode="Always">
        <ContentTemplate>
            <table style="width: 100%">
                <tr style="width: 100%">
                    <td style="width: 100%">
                        
                            <%--<div class="mainConHd">
                                <table cellspacing="0" cellpadding="0" border="0">
                                    <tr valign="middle">
                                        <td>
                                            <span>Brand Master</span>
                                        </td>
                                    </tr>
                                </table>
                            </div>--%>
                            <%--<table class="mainConHd" style="width: 994px;">
                                <tr valign="middle">
                                    <td style="font-size: 20px;">
                                        Brand Master
                                    </td>
                                </tr>
                            </table>--%>
                            <div class="mainConBody">
                                <table style="width: 100.3%; margin: -3px 0px 0px 2px;" cellpadding="3" cellspacing="2" class="searchbg">
                                    <tr style="height: 25px; vertical-align: middle">
                                        <td style="width: 2%;" >
                                               
                                        </td>
                                        <td style="width: 18%; font-size: 22px; color: #000000;" >
                                                Brand Master
                                        </td>
                                        <td style="width: 13%">
                                            <div style="text-align: right;">
                                                <asp:Panel ID="pnlSearch" runat="server" Width="100px">
                                                    <asp:Button ID="lnkBtnAdd" runat="server" OnClick="lnkBtnAdd_Click" CssClass="ButtonAdd66"
                                                        EnableTheming="false" Width="80px" Text=""></asp:Button>
                                                </asp:Panel>
                                            </div>
                                        </td>
                                        <td style="width: 13%; color: #000000;" align="right">
                                                Search
                                            </td>
                                        <td style="width: 20%" class="Box1">
                                            <asp:TextBox ID="txtSearch" runat="server" SkinID="skinTxtBoxSearch"></asp:TextBox>
                                        </td>
                                        <td style="width: 20%" class="Box1">
                                            <div style="width: 160px; font-family: 'Trebuchet MS';">
                                                <asp:DropDownList ID="ddCriteria" runat="server" Width="153px" BackColor="#BBCAFB" Height="23px" style="text-align:center;border:1px solid #BBCAFB ">
                                                    <asp:ListItem Value="0">All</asp:ListItem>
                                                    <asp:ListItem Value="BrandName">Brand Name</asp:ListItem>
                                                    
                                                </asp:DropDownList>
                                            </div>
                                        </td>
                                        <td style="width: 18%" class="tblLeftNoPad">
                                            <asp:Button ID="btnSearch" runat="server" Text="" CssClass="ButtonSearch6" EnableTheming="false" />
                                        </td>
                                        
                                       <td style="width: 20%" class="tblLeftNoPad">
                                            <asp:Button ID="BtnClearFilter" runat="server"  OnClick="BtnClearFilter_Click"  EnableTheming="false" Text="" CssClass="ClearFilter6" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        
                        <input id="dummy" type="button" style="display: none" runat="server" />
                        <input id="Button1" type="button" style="display: none" runat="server" />
                        <cc1:ModalPopupExtender ID="ModalPopupExtender1" runat="server" BackgroundCssClass="modalBackground"
                            CancelControlID="Button1" DynamicServicePath="" Enabled="True" PopupControlID="popUp"
                            TargetControlID="dummy">
                        </cc1:ModalPopupExtender>
                        
                              <asp:Panel runat="server" ID="popUp" Style="width: 40%">
                                 <div id="contentPopUp">
                                    <table style="width: 100%;" align="center">
                                        <tr style="width: 100%">
                                            <td style="width: 100%">
                                            <asp:FormView ID="frmViewAdd" runat="server" Width="100%" DataSourceID="frmSource"
                                                DataKeyNames="BrandId" OnItemCommand="frmViewAdd_ItemCommand" DefaultMode="Edit"
                                                OnItemCreated="frmViewAdd_ItemCreated" Visible="False" OnItemInserting="frmViewAdd_ItemInserting"
                                                OnItemUpdating="frmViewAdd_ItemUpdating" EmptyDataText="No Records" OnItemInserted="frmViewAdd_ItemInserted"
                                                OnItemUpdated="frmViewAdd_ItemUpdated">
                                                <RowStyle HorizontalAlign="left" CssClass="GrdContent allPad" VerticalAlign="Middle"
                                                    BorderColor="#cccccc" Height="20px" />
                                                <EditRowStyle HorizontalAlign="left" CssClass="GrdAlternateColor allPad" BorderColor="#cccccc"
                                                    VerticalAlign="middle" Height="20px" />
                                                <HeaderStyle HorizontalAlign="left" CssClass="GrdHeaderbgClr GrdHdrContent allPad"
                                                    Height="25px" BorderColor="#cccccc" VerticalAlign="Middle" />
                                                <EditItemTemplate>
                                                    <div class="divArea">
                                                        <table cellpadding="1" cellspacing="1" style="border: 1px solid #86b2d1; width: 100%;">
                                                            <tr>
                                                                <td colspan="4" class="headerPopUp">
                                                                    Brand Master
                                                                </td>
                                                            </tr>
                                                            <tr style="height:5px">
                                                            </tr> 
                                                            <tr>
                                                                <td class="ControlLabel" style="width:40%">
                                                                    Brand Name *
                                                                    <asp:RequiredFieldValidator ID="rvLdgrName" runat="server" ControlToValidate="txtBrandName"
                                                                        Display="Dynamic" EnableClientScript="True" ErrorMessage="Brand Name is mandatory">*</asp:RequiredFieldValidator>
                                                                </td>
                                                                <td class="ControlTextBox3" style="width:30%">
                                                                    <asp:TextBox ID="txtBrandName" runat="server" Text='<%# Bind("BrandName") %>' SkinID="skinTxtBoxGrid"
                                                                        TabIndex="1"></asp:TextBox>
                                                                </td>
                                                                
                                                                <td style="width:30%">
                                                                </td>
                                                                <td>
                                                                </td>
                                                            </tr>
                                                            <tr style="height:3px">
                                                                                    </tr>
                                                            <tr>
                                                                <td class="ControlLabel" style="width:40%">
                                                                    Brand % *
                                                                    <asp:RequiredFieldValidator ID="rvAliasName" runat="server" ControlToValidate="txtBrandLevel"
                                                                        Display="Dynamic" EnableClientScript="True" ErrorMessage="Brand Level is mandatory">*</asp:RequiredFieldValidator>
                                                                    <cc1:FilteredTextBoxExtender ID="OBvalid" runat="server" FilterType="Numbers" TargetControlID="txtBrandLevel" />
                                                                </td>
                                                                <td class="ControlTextBox3" style="width:30%">
                                                                    <asp:TextBox ID="txtBrandLevel" runat="server" Text='<%# Bind("Brandlevel") %>' SkinID="skinTxtBoxGrid"
                                                                        TabIndex="4"></asp:TextBox>
                                                                </td>
                                                                <td style="width:30%">
                                                                </td>
                                                                <td>
                                                                </td>
                                                                
                                                            </tr>
                                                            <tr style="height:3px">
                                                                                    </tr>
                                                            <tr>
                                                                <td class="ControlLabel" style="width:40%">
                                                                    Allowed Price % *
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtDeviation"
                                                                        Display="Dynamic" EnableClientScript="True" ErrorMessage="Allowed Price is mandatory">*</asp:RequiredFieldValidator>
                                                                    
                                                                </td>
                                                                <td class="ControlTextBox3" style="width:30%">
                                                                    <asp:TextBox ID="txtDeviation" runat="server" Text='<%# Bind("Deviation") %>' SkinID="skinTxtBoxGrid"
                                                                        TabIndex="5"></asp:TextBox>
                                                                </td>
                                                                <td style="width:30%">
                                                                </td>
                                                                <td>
                                                                </td>
                                                                
                                                            </tr>
                                                            <tr style="height:10px">
                                                            </tr> 
                                                            <tr>
                                                                <td colspan="4">
                                                                    <table style="width:100%">
                                                                        <tr>
                                                                            <td style="width:20%">
                                                                            
                                                                            </td>
                                                                            <td style="width:30%" align="center">
                                                                            <asp:Button ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                                                                                    CssClass="cancelbutton6" EnableTheming="false" SkinID="skinBtnCancel" OnClick="UpdateCancelButton_Click">
                                                                                </asp:Button>
                                                                            </td>
                                                                            <td style="width:30%" align="center">
                                                                                <asp:Button ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
                                                                                    CssClass="Updatebutton1231" EnableTheming="false" SkinID="skinBtnSave"
                                                                                    OnClick="UpdateButton_Click"></asp:Button>
                                                                            </td>
                                                                            <td style="width:20%">
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                    <table cellspacing="0">
                                                        <tr>
                                                            <td>
                                                                <asp:ObjectDataSource ID="srcGroupInfo" runat="server" SelectMethod="ListGroupInfo"
                                                                    TypeName="BusinessLogic" OldValuesParameterFormatString="original_{0}">
                                                                    <SelectParameters>
                                                                        <asp:CookieParameter Name="connection" CookieName="Company" Type="String" />
                                                                    </SelectParameters>
                                                                </asp:ObjectDataSource>
                                                                <td>
                                                                    <asp:ValidationSummary ID="valSum" DisplayMode="BulletList" ShowMessageBox="true"
                                                                        ShowSummary="false" HeaderText="Validation Messages" Font-Names="'Trebuchet MS'"
                                                                        Font-Size="12" runat="server" />
                                                                </td>
                                                                <td>
                                                                </td>
                                                                <td>
                                                                </td>
                                                        </tr>
                                                    </table>
                                                </EditItemTemplate>
                                                <FooterTemplate>
                                                </FooterTemplate>
                                                <InsertItemTemplate>
                                                    <div class="divArea">
                                                        <table cellpadding="1" cellspacing="1" style="border: 1px solid #86b2d1; width: 100%;">
                                                            <tr>
                                                                <td colspan="4" class="headerPopUp">
                                                                    Brand Master
                                                                </td>
                                                            </tr>
                                                            <tr style="height:5px"> 
                                                            </tr>
                                                            <tr>
                                                                <td class="ControlLabel" style="width:40%">
                                                                    Brand Name *
                                                                    <asp:RequiredFieldValidator ID="rvLdgrNameAdd" runat="server" ControlToValidate="txtBrandNameAdd"
                                                                        Text="*" Display="Dynamic" EnableClientScript="True" ErrorMessage="Brand Name is mandatory"></asp:RequiredFieldValidator>
                                                                </td>
                                                                <td class="ControlTextBox3" style="width:30%">
                                                                    <asp:TextBox ID="txtBrandNameAdd" runat="server" Text='<%# Bind("BrandName") %>'
                                                                        SkinID="skinTxtBoxGrid" TabIndex="1"></asp:TextBox>
                                                                </td>
                                                                
                                                                <td style="width:30%">
                                                                    
                                                                </td>
                                                                <td>
                                                                </td>
                                                            </tr>
                                                            <tr style="height:3px">
                                                                                    </tr>
                                                            <tr>
                                                                <td class="ControlLabel" style="width:40%">
                                                                    Brand % *
                                                                    <asp:RequiredFieldValidator ID="rvAliasNameAdd" runat="server" ControlToValidate="txtBrandLevelAdd"
                                                                        Display="Dynamic" EnableClientScript="True" ErrorMessage="Brand Level is mandatory">*</asp:RequiredFieldValidator>
                                                                    <cc1:FilteredTextBoxExtender ID="OBvalid" runat="server" FilterType="Numbers" TargetControlID="txtBrandLevelAdd" />
                                                                </td>
                                                                <td class="ControlTextBox3" style="width:30%">
                                                                    <asp:TextBox ID="txtBrandLevelAdd" runat="server" Text="0"
                                                                        SkinID="skinTxtBoxGrid" TabIndex="4"></asp:TextBox>
                                                                </td>
                                                                
                                                                <td style="width:30%">

                                                                </td>
                                                                <td>
                                                                </td>
                                                            </tr>
                                                            <tr style="height:3px">
                                                                                    </tr>
                                                            <tr>
                                                                <td class="ControlLabel" style="width:40%">
                                                                    Allowed Price % *
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="txtDeviationAdd"
                                                                        Display="Dynamic" EnableClientScript="True" ErrorMessage="Allowed Price % is mandatory">*</asp:RequiredFieldValidator>
                                                                    
                                                                </td>
                                                                <td class="ControlTextBox3" style="width:30%">
                                                                    <asp:TextBox ID="txtDeviationAdd" runat="server" Text="0"
                                                                        SkinID="skinTxtBoxGrid" TabIndex="5"></asp:TextBox>
                                                                </td>
                                                                
                                                                <td style="width:30%">

                                                                </td>
                                                                <td>
                                                                </td>
                                                            </tr>
                                                            <tr style="height:10px"> 
                                                            </tr>
                                                            <tr>
                                                                <td colspan="4">
                                                                    <table style="width:100%">
                                                                        <tr>
                                                                            <td style="width:20%">
                                                                            
                                                                            </td>
                                                                            <td style="width:30%" align="center">
                                                                                <asp:Button ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                                                                                    CssClass="cancelbutton6" EnableTheming="false" SkinID="skinBtnCancel" OnClick="InsertCancelButton_Click">
                                                                                </asp:Button>
                                                                            </td>
                                                                            <td style="width:30%" align="center">
                                                                                <asp:Button ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert"
                                                                                    CssClass="savebutton1231" EnableTheming="false" SkinID="skinBtnSave"
                                                                                    OnClick="InsertButton_Click"></asp:Button>
                                                                        
                                                                            </td>
                                                                            <td style="width:20%">

                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                                
                                                            </tr>
                                                        </table>
                                                    </div>
                                                    <table cellspacing="0">
                                                        <tr>
                                                            <td colspan="2">
                                                                <asp:ValidationSummary ID="valSumAdd" DisplayMode="BulletList" ShowMessageBox="true"
                                                                    ShowSummary="false" HeaderText="Validation Messages" Font-Names="'Trebuchet MS'"
                                                                    Font-Size="12" runat="server" />
                                                            </td>
                                                            <td colspan="2">
                                                                <asp:ObjectDataSource ID="srcGroupInfoAdd" runat="server" SelectMethod="ListGroupInfoExp"
                                                                    TypeName="BusinessLogic" OldValuesParameterFormatString="original_{0}">
                                                                    <SelectParameters>
                                                                        <asp:CookieParameter Name="connection" CookieName="Company" Type="String" />
                                                                    </SelectParameters>
                                                                </asp:ObjectDataSource>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </InsertItemTemplate>
                                             </asp:FormView>
                                        </td>
                                    </tr>
                                </table>
                            </div> 
                        </asp:Panel>
                    </td>
                </tr>
                <tr style="width: 100%;">
                    <td style="width: 100%;">
                        <table width="100%" style="margin: -6px 0px 0px 0px;">
                                    <tr style="width: 100%">
                                        <td>
                        <div class="mainGridHold" id="searchGrid">
                            <asp:GridView ID="GrdViewLedger" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                OnRowCreated="GrdViewLedger_RowCreated" Width="100.3%" DataSourceID="GridSource" CssClass="someClass"
                                AllowPaging="True" DataKeyNames="BrandID" EmptyDataText="No Brand Found."
                                OnRowCommand="GrdViewLedger_RowCommand" OnRowDataBound="GrdViewLedger_RowDataBound" OnRowDeleting="GrdViewLedger_RowDeleting"
                                OnRowDeleted="GrdViewLedger_RowDeleted">
                                <Columns>
                                    <asp:BoundField DataField="BrandName" HeaderText="Brand Name"  HeaderStyle-BorderColor="Gray" HeaderStyle-Width="690px"/>
                                    <asp:BoundField DataField="BrandLevel" HeaderText="Brand Level"  HeaderStyle-BorderColor="Gray" HeaderStyle-Width="200px"/>
                                    <asp:BoundField DataField="Deviation" HeaderText="Deviation"  HeaderStyle-BorderColor="Gray" HeaderStyle-Width="200px"/>
                                    <asp:TemplateField ItemStyle-CssClass="command" HeaderText="Edit" ItemStyle-Width="50px" HeaderStyle-BorderColor="Gray"
                                        ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="btnEdit" runat="server" SkinID="edit" CommandName="Select" />
                                            <asp:ImageButton ID="btnEditDisabled" Enabled="false" SkinID="editDisable" runat="Server">
                                            </asp:ImageButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ItemStyle-CssClass="command" HeaderText="Delete" HeaderStyle-Width="50px" HeaderStyle-BorderColor="Gray"
                                        ItemStyle-HorizontalAlign="Center">
                                        <ItemTemplate>
                                            <cc1:ConfirmButtonExtender ID="CnrfmDel" TargetControlID="lnkB" ConfirmText="Are you sure to Delete this Brand?"
                                                runat="server">
                                            </cc1:ConfirmButtonExtender>
                                            <asp:ImageButton ID="lnkB" SkinID="delete" runat="Server" CommandName="Delete"></asp:ImageButton>
                                            <asp:ImageButton ID="lnkBDisabled" Enabled="false" SkinID="deleteDisable" runat="Server">
                                            </asp:ImageButton>
                                            <asp:HiddenField ID="ldgID" runat="server" Value='<%# Bind("BrandId") %>' />
                                            <asp:HiddenField ID="HiddenField1" runat="server" Value='<%# Bind("BrandName") %>' />
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
                                                <asp:DropDownList ID="ddlPageSelector" BackColor="#BBCAFB" runat="server" AutoPostBack="true" width="65px" style="border:1px solid blue" height="23px">
                                                </asp:DropDownList>
                                            </td>
                                            <td  style=" border-color:white;Width:5px">
                                            
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
                            </asp:GridView>
                        </div>
                        </td>
                        </tr>
                        </table>

                    </td>
                </tr>
                <tr style="width:100%;">
                    <td style="width: 918px" align="left">
                        <asp:ObjectDataSource ID="GridSource" runat="server" SelectMethod="ListBrandInfo"
                            TypeName="BusinessLogic" DeleteMethod="DeleteBrandInfo" OnDeleting="GridSource_Deleting">
                            <DeleteParameters>
                                <asp:CookieParameter Name="connection" CookieName="Company" Type="String" />
                                <asp:Parameter Name="BrandID" Type="Int32" />
                                <asp:Parameter Name="Username" Type="String" />
                            </DeleteParameters>
                        </asp:ObjectDataSource>
                        <asp:ObjectDataSource ID="empSrc" runat="server" SelectMethod="ListExecutive" TypeName="BusinessLogic">
                            <SelectParameters>
                                <asp:CookieParameter Name="connection" CookieName="Company" Type="String" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                        <asp:ObjectDataSource ID="empSrcAdd" runat="server" SelectMethod="ListExecutive"
                            TypeName="BusinessLogic">
                            <SelectParameters>
                                <asp:CookieParameter Name="connection" CookieName="Company" Type="String" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                        <asp:ObjectDataSource ID="frmSource" runat="server" SelectMethod="GetBrandInfoForId"
                            TypeName="BusinessLogic" OnUpdating="frmSource_Updating" OnInserting="frmSource_Inserting"
                            InsertMethod="InsertBrandInfo" UpdateMethod="UpdateBrandInfo">
                            <UpdateParameters>
                                <asp:CookieParameter Name="connection" CookieName="Company" Type="String" />
                                <asp:Parameter Name="BrandID" Type="Int32" />
                                <asp:Parameter Name="BrandName" Type="String" />
                                <asp:Parameter Name="Brandlevel" Type="String" />
                                <asp:Parameter Name="Deviation" Type="Int32" />
                                <asp:Parameter Name="Username" Type="String" />
                            </UpdateParameters>
                            <SelectParameters>
                                <asp:ControlParameter ControlID="GrdViewLedger" Name="BrandID" PropertyName="SelectedValue"
                                    Type="String" />
                                <asp:CookieParameter Name="connection" CookieName="Company" Type="String" />
                            </SelectParameters>
                            <InsertParameters>
                                <asp:CookieParameter Name="connection" CookieName="Company" Type="String" />
                                <asp:Parameter Name="BrandName" Type="String" />
                                <asp:Parameter Name="Brandlevel" Type="String" /> 
                                <asp:Parameter Name="Deviation" Type="Int32" />        
                                <asp:Parameter Name="Username" Type="String" />                     
                            </InsertParameters>
                        </asp:ObjectDataSource>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table align="center" style="width:100%">
                            <tr>
                                <td  style="width:35%">
                        
                                </td>
                                <td style="width:15%">
                                    <asp:Button ID="BlkAdd" runat="server"  OnClientClick="window.open('BulkAdditionBrand.aspx','billSummary', 'toolbar=no,status=no,menu=no,location=no,resizable=yes,height=250,width=500,left=425,top=220, scrollbars=yes');" CssClass="bulkaddition"
                                                EnableTheming="false" Text=""></asp:Button>
                                </td>
                                <td  style="width: 15%" >
                                    <asp:Button ID="btnExportToExcel" runat="server" CssClass="exportexl6" OnClientClick="window.open('ReportExcelbrand.aspx ','billSummary', 'toolbar=no,status=no,menu=no,location=no,resizable=yes,height=310,width=500,left=425,top=220, scrollbars=yes');"
                                                            EnableTheming="false"></asp:Button>
                                </td>
                                <td  style="width:35%">
                        
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>