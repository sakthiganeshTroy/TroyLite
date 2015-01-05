﻿<%@ Page Language="C#" MasterPageFile="~/PageMaster.master" AutoEventWireup="true"
    CodeFile="BankReceipt.aspx.cs" Inherits="BankReceipt" Title="Banking > Bank Receipt" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cplhTab" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cplhControlPanel" runat="Server">
    <script language="javascript" type="text/javascript">

        /*@cc_on@*/
        /*@if (@_win32 && @_jscript_version>=5)

        function window.confirm(str) {
            execScript('n = msgbox("' + str + '","4132")', "vbscript");
            return (n == 6);
        }

        @end@*/

        function ConfirmSMS() {
            if (Page_IsValid) {
                var confSMS = document.getElementById('ctl00_cplhControlPanel_hdSMS').value;

                var confSMSRequired = document.getElementById('ctl00_cplhControlPanel_hdSMSRequired').value;

                var txtMobile = document.getElementById('ctl00_cplhControlPanel_frmViewAdd_txtMobileAdd');

                if (txtMobile == null)
                    txtMobile = document.getElementById('ctl00_cplhControlPanel_frmViewAdd_tabEdit_tabEditMain_txtMobile');

                if (txtMobile != null) {
                    if (txtMobile.value != "") {
                        if (confSMSRequired == "YES") {
                            var rv = confirm("Do you want to send SMS to Customer?");

                            if (rv == true) {
                                document.getElementById('ctl00_cplhControlPanel_hdSMS').value = "YES";
                                return true;
                            }
                            else {
                                document.getElementById('ctl00_cplhControlPanel_hdSMS').value = "NO";
                                return true;
                            }
                        }
                    }
                }
            }
        }

        function EditMobile_Validator() {
            var txtMobile = document.getElementById('ctl00_cplhControlPanel_frmViewAdd_txtMobile').value;

            if (txtMobile.length > 0) {
                if (txtMobile.length != 10) {
                    alert("Customer Mobile Number should be minimum of 10 digits.");
                    Page_IsValid = false;
                    return window.event.returnValue = false;
                }

                if (txtMobile.charAt(0) == "0") {
                    alert("Customer Mobile should not start with Zero. Please remove Zero and try again.");
                    Page_IsValid = false;
                    return window.event.returnValue = false;
                }
            }
            else {
                Page_IsValid = true;
            }
        }

        function AddMobile_Validator() {
            var txtMobile = document.getElementById('ctl00_cplhControlPanel_frmViewAdd_txtMobileAdd').value;

            if (txtMobile.length > 0) {
                if (txtMobile.length != 10) {
                    alert("Customer Mobile Number should be minimum of 10 digits.");
                    Page_IsValid = false;
                    return window.event.returnValue = false;
                }

                if (txtMobile.charAt(0) == "0") {
                    alert("Customer Mobile should not start with Zero. Please remove Zero and try again.");
                    Page_IsValid = false;
                    return window.event.returnValue = false;
                }
            }
            else {
                Page_IsValid = true;
            }
        }


        function PrintItem(ID) {
            window.showModalDialog('./PrintReceipt.aspx?ID=' + ID, self, 'dialogWidth:700px;dialogHeight:430px;status:no;dialogHide:yes;unadorned:yes;');
        }


        function AdvancedTest(id) {

            var panel = document.getElementById('ctl00_cplhControlPanel_frmViewAdd_tblBank');
            var adv = document.getElementById('ctl00_cplhControlPanel_hidAdvancedState');

            var grd = document.getElementById("<%= frmViewAdd.ClientID %>");

            var rdoArray = grd.getElementsByTagName("input");


            for (i = 0; i <= rdoArray.length - 1; i++) {
                if (rdoArray[i].type == 'radio') {

                    if (rdoArray[i].value == 'Cash' && rdoArray[i].checked == true) {
                        panel.className = "hidden";
                        adv.value = panel.className;
                    }
                    else if (rdoArray[i].value == 'Cheque' && rdoArray[i].checked == true) {
                        panel.className = "AdvancedSearch";
                        adv.value = panel.className;
                    }

                }
            }
        }

        function AdvancedAdd(id) {

            var panel = document.getElementById('ctl00_cplhControlPanel_frmViewAdd_tblBankAdd');
            var adv = document.getElementById('ctl00_cplhControlPanel_hidAdvancedState');

            var grd = document.getElementById("<%= frmViewAdd.ClientID %>");

            var rdoArray = grd.getElementsByTagName("input");


            for (i = 0; i <= rdoArray.length - 1; i++) {
                if (rdoArray[i].type == 'radio') {

                    if (rdoArray[i].value == 'Cash' && rdoArray[i].checked == true) {
                        panel.className = "hidden";
                        adv.value = panel.className;
                    }
                    else if (rdoArray[i].value == 'Cheque' && rdoArray[i].checked == true) {
                        panel.className = "AdvancedSearch";
                        adv.value = panel.className;
                    }

                }
            }
        }
    </script>
    <asp:UpdatePanel ID="UpdatePanel16" runat="server" UpdateMode="Always">
        <ContentTemplate>
        
            <table style="width: 100%">
                <tr style="width: 100%">
                    <td style="width: 100%">
                            <%--<table class="mainConHd" style="width: 994px;">
                                <tr valign="middle">
                                    <td style="font-size: 20px;">
                                        Banks Receipts
                                    </td>
                                </tr>
                            </table>--%>
                            <%--<div class="mainConHd">
                                <table cellspacing="0" cellpadding="0" border="0">
                                    <tr valign="middle">
                                        <td>
                                            <span>Bank Receipts</span>
                                        </td>
                                    </tr>
                                </table>
                            </div>--%>
                            <div class="mainConBody">
                                <table style="width: 99.8%; margin: -2px 0px 0px 1px;" cellpadding="3" cellspacing="2" class="searchbg">
                                    <tr style="height: 25px; vertical-align: middle">
                                        <td style="width: 2%">
                                        </td>
                                        <td style="width: 23%; font-size: 22px; color: White;" >
                                              Banks Receipts
                                        </td>
                                        <td style="width: 12%">
                                            <div style="text-align: right;">
                                                <asp:Panel ID="pnlSearch" runat="server" Width="100px">
                                                    <asp:Button ID="lnkBtnAdd" runat="server" OnClick="lnkBtnAdd_Click" CssClass="ButtonAdd66"
                                                        EnableTheming="false" Width="80px" Text=""></asp:Button>
                                                </asp:Panel>
                                            </div>
                                        </td>
                                        <td style="width: 15%; color: White;" align="right">
                                            Search
                                            <asp:RequiredFieldValidator ID="rvSearch" runat="server" ControlToValidate="txtSearch"
                                                Display="Dynamic" EnableClientScript="False" Enabled="false">Search is mandatory</asp:RequiredFieldValidator>
                                        </td>
                                        <td style="width: 18%" class="NewBox">
                                            <asp:TextBox ID="txtSearch" runat="server" SkinID="skinTxtBoxSearch" ></asp:TextBox>
                                        </td>
                                        <td style="width: 18%" class="NewBox">
                                            <div style="width: 160px; font-family: 'Trebuchet MS';">
                                                <asp:DropDownList ID="ddCriteria" runat="server" Width="153px"  BackColor="White" Height="23px" style="text-align:center;border:1px solid White ">
                                                    <asp:ListItem Value="TransNo">Trans. No.</asp:ListItem>
                                                    <asp:ListItem Value="RefNo">Ref. No.</asp:ListItem>
                                                    <asp:ListItem Value="TransDate">Transaction Date</asp:ListItem>
                                                    <asp:ListItem Value="LedgerName">Received From</asp:ListItem>
                                                    <asp:ListItem Value="Narration">Narration</asp:ListItem>
                                                </asp:DropDownList>
                                            </div>
                                        </td>
                                        <td style="width: 22%" class="tblLeftNoPad">
                                            <asp:Button ID="btnSearch" runat="server" Text="" CssClass="ButtonSearch6" EnableTheming="false" ForeColor="White" />
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
                        <asp:Panel runat="server" ID="popUp" Style="width: 55%">
                            <div id="contentPopUp">
                                <table class="tblLeft" cellpadding="0" cellspacing="0" style="border: 0px solid #5078B3;
                                    background-color: #fff; color: #000;" width="100%">
                                    <tr>
                                        <td>
                                            <asp:FormView ID="frmViewAdd" runat="server" Width="100%" DataSourceID="frmSource"
                                                OnItemCommand="frmViewAdd_ItemCommand" DefaultMode="Edit" DataKeyNames="TransNo"
                                                OnItemUpdated="frmViewAdd_ItemUpdated" OnItemCreated="frmViewAdd_ItemCreated"
                                                Visible="False" OnItemInserting="frmViewAdd_ItemInserting" EmptyDataText="No Records"
                                                OnItemInserted="frmViewAdd_ItemInserted">
                                                <RowStyle HorizontalAlign="left" CssClass="GrdContent allPad" VerticalAlign="Middle"
                                                    BorderColor="#cccccc" Height="20px" />
                                                <EditRowStyle HorizontalAlign="left" CssClass="GrdAlternateColor allPad" BorderColor="#cccccc"
                                                    VerticalAlign="middle" Height="20px" />
                                                <HeaderStyle HorizontalAlign="left" CssClass="GrdHeaderbgClr GrdHdrContent allPad"
                                                    Height="25px" BorderColor="#cccccc" VerticalAlign="Middle" />
                                                <EditItemTemplate>
                                                    <div class="divArea">
                                                        <table cellpadding="3" cellspacing="1" style="border: 1px solid #86b2d1; width: 800px;">
                                                            <tr>
                                                                <td colspan="5" class="headerPopUp">
                                                                    Bank Receipt
                                                                </td>
                                                            </tr>
                                                            <tr style="height:5px">
                                                            
                                                            </tr>
                                                            <tr>
                                                                <td class="ControlLabel" style="width:25%">
                                                                    Ref. No. *
                                                                    <asp:RequiredFieldValidator ID="rvRefNo" runat="server" ErrorMessage="Ref. No. is mandatory"
                                                                        ControlToValidate="txtRefNo" Display="Dynamic" EnableClientScript="True">*</asp:RequiredFieldValidator>
                                                                </td>
                                                                <td class="ControlTextBox3" style="width:25%">
                                                                    <asp:TextBox ID="txtRefNo" runat="server" Text='<%# Bind("RefNo") %>' Width="100%"
                                                                        SkinID="skinTxtBoxGrid"></asp:TextBox>
                                                                </td>
                                                                <td class="ControlLabel" style="width:15%">
                                                                    <asp:RequiredFieldValidator ID="rvStock" runat="server" ControlToValidate="txtTransDate"
                                                                        ErrorMessage="Trasaction Date is mandatory" Display="Dynamic" EnableClientScript="True">*</asp:RequiredFieldValidator>
                                                                    <asp:CompareValidator ControlToValidate="txtTransDate" Operator="DataTypeCheck" Type="Date"
                                                                        ErrorMessage="Please enter a valid date" runat="server" ID="cmpValtxtDate">*</asp:CompareValidator>
                                                                    <asp:RangeValidator ID="myRangeValidator" runat="server" ControlToValidate="txtTransDate"
                                                                        ErrorMessage="Payment date cannot be future date." Text="*" Type="Date"></asp:RangeValidator>
                                                                    Received Date *
                                                                </td>
                                                                <td class="ControlTextBox3" style="width:25%">
                                                                    <asp:TextBox ID="txtTransDate" runat="server" Text='<%# Bind("TransDate","{0:dd/MM/yyyy}") %>'
                                                                        CssClass="cssTextBox" Width="100px"></asp:TextBox>
                                                                    <cc1:CalendarExtender ID="calExtender3" runat="server" Animated="true" Format="dd/MM/yyyy"
                                                                        PopupButtonID="btnDate3" PopupPosition="BottomLeft" TargetControlID="txtTransDate">
                                                                    </cc1:CalendarExtender>
                                                                </td>
                                                                <td align="left">
                                                                    <asp:ImageButton ID="btnDate3" ImageUrl="App_Themes/NewTheme/images/cal.gif" CausesValidation="false"
                                                                        Width="20px" runat="server" />
                                                                </td>
                                                            </tr>
                                                            <tr style="height:3px">
                                                            </tr>
                                                            <tr>
                                                                <td class="ControlLabel" style="width:25%">
                                                                    
                                                                    <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="ComboBox2"
                                                                        Display="Dynamic" EnableClientScript="True" ErrorMessage="Received From is Mandatory"
                                                                        Operator="GreaterThan" ValueToCompare="0">*</asp:CompareValidator>
                                                                    Received From *
                                                                </td>
                                                                <td class="ControlDrpBorder" style="width:25%">
                                                                    <asp:DropDownList ID="ComboBox2" runat="server" Width="100%" CssClass="drpDownListMedium" BackColor = "#e7e7e7" AutoPostBack="false"
                                                                        DataSourceID="srcCreditorDebitor" DataValueField="LedgerID" DataTextField="LedgerName" style="border: 1px solid #e7e7e7" height="26px"
                                                                        AppendDataBoundItems="true" OnDataBound="ComboBox2_DataBound">
                                                                        <asp:ListItem style="background-color: #e7e7e7" Text="Select Bank" Value="0"></asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td class="ControlLabel" style="width:15%">
                                                                    Amount *
                                                                    <asp:RequiredFieldValidator ID="rvModel" runat="server" ControlToValidate="txtAmount"
                                                                        ErrorMessage="Amount is mandatory" Display="Dynamic" EnableClientScript="True">*</asp:RequiredFieldValidator>
                                                                    <cc1:FilteredTextBoxExtender ID="fltAmt" runat="server" TargetControlID="txtAmount"
                                                                        ValidChars="." FilterType="Numbers, Custom" />
                                                                </td>
                                                                <td class="ControlNumberBox3" style="width:25%">
                                                                    <asp:TextBox ID="txtAmount" runat="server" Text='<%# Bind("Amount") %>' Width="100%"
                                                                        SkinID="skinTxtBoxGrid"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr style="height:3px">
                                                            </tr>
                                                            <tr>
                                                                <td class="ControlLabel" style="width:25%">
                                                                    Payment Made By *
                                                                    <asp:RequiredFieldValidator ID="rvBDate" runat="server" ControlToValidate="chkPayTo"
                                                                        Display="Dynamic" EnableClientScript="True" ErrorMessage="Item Name is mandatory.">*</asp:RequiredFieldValidator>
                                                                </td>
                                                                <td align="left" class="ControlTextBox3" style="width:25%">
                                                                    <asp:RadioButtonList ID="chkPayTo" runat="server" onclick="javascript:AdvancedTest(this.id);"
                                                                        AutoPostBack="False" Width="100%" OnDataBound="chkPayTo_DataBound" OnSelectedIndexChanged="chkPayTo_SelectedIndexChanged">
                                                                        <asp:ListItem Text="Cash" Selected="true"></asp:ListItem>
                                                                        <asp:ListItem Text="Cheque"></asp:ListItem>
                                                                    </asp:RadioButtonList>
                                                                </td>
                                                                <td class="ControlLabel" style="width:15%">
                                                                    Narration *
                                                                    <asp:RequiredFieldValidator ID="rvNarration" runat="server" ErrorMessage="Narration is mandatory"
                                                                        ControlToValidate="txtNarration" Display="Dynamic" EnableClientScript="True">*</asp:RequiredFieldValidator>
                                                                </td>
                                                                <td class="ControlTextBox3" style="width:25%">
                                                                    <asp:TextBox ID="txtNarration" runat="server" Height="30px" TextMode="MultiLine"
                                                                        Text='<%# Bind("Narration") %>' Width="100%" SkinID="skinTxtBoxGrid"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr style="height:2px">
                                                            </tr>
                                                            <tr>
                                                                <td colspan="4">
                                                                    <asp:Panel ID="PanelBank" runat="server">
                                                                        <table id="tblBank" runat="server" cellpadding="1" cellspacing="0" width="100%">
                                                                            
                                                                            <tr>
                                                                                <td class="ControlLabel" style="width:25%">
                                                                                    Bank Name: *
                                                                                    <asp:CompareValidator ID="cvBank" runat="server" ControlToValidate="ddBanks" Display="Dynamic"
                                                                                        EnableClientScript="false" ErrorMessage="Bank Name is Mandatory" Operator="GreaterThan"
                                                                                        ValueToCompare="0">*</asp:CompareValidator>
                                                                                </td>
                                                                                <td class="ControlDrpBorder"  style="width:25%">
                                                                                    <asp:DropDownList ID="ddBanks" Enabled="true" runat="server" OnDataBound="ddBanks_DataBound" Width="100%" CssClass="drpDownListMedium" BackColor = "#e7e7e7"
                                                                                        DataSourceID="srcBanks" DataTextField="LedgerName" DataValueField="LedgerID" style="border: 1px solid #e7e7e7" height="26px"
                                                                                        AppendDataBoundItems="True">
                                                                                        <asp:ListItem Selected="True" Value="0">-- Please Select --</asp:ListItem>
                                                                                    </asp:DropDownList>
                                                                                </td>
                                                                                <td class="ControlLabel" style="width:15%">
                                                                                    Cheque No: *
                                                                                    <asp:RequiredFieldValidator ID="rvChequeNo" runat="server" ControlToValidate="txtChequeNo"
                                                                                        ErrorMessage="Cheque No. is mandatory" Display="Dynamic" EnableClientScript="False">*</asp:RequiredFieldValidator>
                                                                                </td>
                                                                                <td class="ControlTextBox3" style="width:25%">
                                                                                    <asp:TextBox ID="txtChequeNo" runat="server" Text='<%# Bind("ChequeNo") %>' Width="100%"
                                                                                        CssClass="cssTextBox"></asp:TextBox>
                                                                                </td>
                                                                                
                                                                            </tr>
                                                                        </table>
                                                                    </asp:Panel>
                                                                </td>
                                                            </tr>
                                                            <tr style="height:5px">
                                                                
                                                            </tr>
                                                            <tr>
                                                                <td colspan="4">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td align="right" style="width: 36%;">
                                                                            </td>
                                                                            <td align="center" style="width: 17%;">                                                                                
                                                                                 <asp:Button ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
                                                                                    CssClass="Updatebutton1231" EnableTheming="false" SkinID="skinBtnSave" OnClick="UpdateButton_Click">
                                                                                </asp:Button>
                                                                            </td>
                                                                            <td align="center" style="width: 17%;">
                                                                               <asp:Button ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                                                                                    CssClass="cancelbutton6" EnableTheming="false" SkinID="skinBtnCancel" OnClick="UpdateCancelButton_Click">
                                                                                </asp:Button>
                                                                            </td>
                                                                            <td style="width: 30%;">
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
                                                                <asp:ObjectDataSource ID="srcBanks" runat="server" SelectMethod="ListBanks" TypeName="BusinessLogic">
                                                                    <SelectParameters>
                                                                        <asp:CookieParameter Name="connection" CookieName="Company" Type="String" />
                                                                    </SelectParameters>
                                                                </asp:ObjectDataSource>
                                                            </td>
                                                            <td>
                                                                <asp:ObjectDataSource ID="srcCreditorDebitor" runat="server" SelectMethod="ListBanks"
                                                                    TypeName="BusinessLogic">
                                                                    <SelectParameters>
                                                                        <asp:CookieParameter Name="connection" CookieName="Company" Type="String" />
                                                                    </SelectParameters>
                                                                </asp:ObjectDataSource>
                                                            </td>
                                                            <td>
                                                                <asp:ValidationSummary ID="valSum" DisplayMode="BulletList" ShowMessageBox="true"
                                                                    ShowSummary="false" HeaderText="Validation Messages" Font-Names="'Trebuchet MS'"
                                                                    Font-Size="12" runat="server" />
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
                                                        <table cellpadding="1" cellspacing="1" style="border: 1px solid #86b2d1; width: 800px;">
                                                            <tr>
                                                                <td colspan="5" class="headerPopUp">
                                                                    Bank Receipt
                                                                </td>
                                                            </tr>
                                                            <tr style="height:5px">
                                                            </tr> 
                                                            <tr>
                                                                <td class="ControlLabel" style="width:20%">
                                                                    Ref. No. *
                                                                    <asp:RequiredFieldValidator ID="rvRefNoAdd" runat="server" ErrorMessage="Ref. No. is mandatory"
                                                                        ControlToValidate="txtRefNoAdd" Display="Dynamic" EnableClientScript="True">*</asp:RequiredFieldValidator>
                                                                </td>
                                                                <td class="ControlTextBox3" style="width:27%">
                                                                    <asp:TextBox ID="txtRefNoAdd" runat="server" Text='<%# Bind("RefNo") %>' Width="100%"
                                                                        SkinID="skinTxtBoxGrid"></asp:TextBox>
                                                                </td>
                                                                <td class="ControlLabel" style="width:15%">
                                                                    <%--<asp:Label ID="Label1" runat="server" Width="120px" Text=""></asp:Label>--%>
                                                                    <asp:RequiredFieldValidator ID="rvStockAdd" runat="server" ControlToValidate="txtTransDateAdd"
                                                                        ErrorMessage="Trans. Date is mandatory" Display="Dynamic" EnableClientScript="True">*</asp:RequiredFieldValidator>
                                                                    <asp:CompareValidator ControlToValidate="txtTransDateAdd" Operator="DataTypeCheck"
                                                                        Type="Date" ErrorMessage="Please enter a valid date" runat="server" ID="cmpValtxtDateAdd">*</asp:CompareValidator>
                                                                    <asp:RangeValidator ID="myRangeValidatorAdd" runat="server" ControlToValidate="txtTransDateAdd"
                                                                        ErrorMessage="Receipt date cannot be future date." Text="*" Type="Date"></asp:RangeValidator>
                                                                    Received Date *
                                                                </td>
                                                                <td class="ControlTextBox3" style="width:27%">
                                                                    <asp:TextBox ID="txtTransDateAdd" runat="server" Text='<%# Bind("TransDate","{0:dd/MM/yyyy}") %>'
                                                                        CssClass="cssTextBox" Width="100px"></asp:TextBox>
                                                                    <cc1:CalendarExtender ID="calEx3" runat="server" Animated="true" Format="dd/MM/yyyy"
                                                                        PopupButtonID="btnD3" PopupPosition="BottomLeft" TargetControlID="txtTransDateAdd">
                                                                    </cc1:CalendarExtender>
                                                                </td>
                                                                <td align="left">
                                                                    <asp:ImageButton ID="btnD3" ImageUrl="App_Themes/NewTheme/images/cal.gif" CausesValidation="false"
                                                                        Width="20px" runat="server" />
                                                                </td>
                                                            </tr>
                                                            <tr style="height:3px">
                                                            </tr>
                                                            <tr>
                                                                <td class="ControlLabel" style="width:20%">
                                                                    
                                                                    <asp:CompareValidator ID="CV1Add" runat="server" ControlToValidate="ComboBox2Add"
                                                                        Display="Dynamic" EnableClientScript="True" ErrorMessage="Received From is Mandatory"
                                                                        Operator="GreaterThan" ValueToCompare="0">*</asp:CompareValidator>
                                                                    Received From *
                                                                </td>
                                                                <td style="width:27%" class="ControlDrpBorder">
                                                                    <asp:DropDownList ID="ComboBox2Add" runat="server" Width="100%" CssClass="drpDownListMedium" BackColor = "#e7e7e7"
                                                                        AutoPostBack="false" DataSourceID="srcCreditorDebitorAdd" DataValueField="LedgerID" style="border: 1px solid #e7e7e7" height="26px"
                                                                        DataTextField="LedgerName" AppendDataBoundItems="true">
                                                                        <asp:ListItem style="background-color: #e7e7e7" Text="Select Bank" Value="0"></asp:ListItem>
                                                                    </asp:DropDownList>
                                                                </td>
                                                                <td class="ControlLabel" style="width:15%">
                                                                    Amount *
                                                                    <asp:RequiredFieldValidator ID="rvModelAdd" runat="server" ControlToValidate="txtAmountAdd"
                                                                        ErrorMessage="Amount is mandatory" Display="Dynamic" EnableClientScript="True">*</asp:RequiredFieldValidator>
                                                                    <cc1:FilteredTextBoxExtender ID="fltAmtAdd" runat="server" TargetControlID="txtAmountAdd"
                                                                        ValidChars="." FilterType="Numbers, Custom" />
                                                                </td>
                                                                <td class="ControlNumberBox3" style="width:27%">
                                                                    <asp:TextBox ID="txtAmountAdd" runat="server" Text='<%# Bind("Amount") %>' Width="100%"
                                                                        SkinID="skinTxtBoxGrid"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr style="height:3px">
                                                            </tr>
                                                            <tr>
                                                                <td class="ControlLabel" style="width:20%">
                                                                    Payment Made By *
                                                                    <asp:RequiredFieldValidator ID="rvBDateAdd" runat="server" ControlToValidate="chkPayToAdd"
                                                                        Text="*" Display="Dynamic" EnableClientScript="True" ErrorMessage="Item Name is mandatory."></asp:RequiredFieldValidator>
                                                                </td>
                                                                <td align="left" style="width:27%" class="ControlTextBox3">
                                                                    <asp:RadioButtonList ID="chkPayToAdd" runat="server" OnDataBound="chkPayToAdd_DataBound"
                                                                        onclick="javascript:AdvancedAdd(this.id);" AutoPostBack="false"
                                                                        OnSelectedIndexChanged="chkPayToAdd_SelectedIndexChanged">
                                                                        <asp:ListItem Text="Cash" Selected="true"></asp:ListItem>
                                                                        <asp:ListItem Text="Cheque"></asp:ListItem>
                                                                    </asp:RadioButtonList>
                                                                </td>
                                                                <td class="ControlLabel" style="width:15%">
                                                                    Narration *
                                                                    <asp:RequiredFieldValidator ID="rvNarrationAdd" runat="server" ErrorMessage="Narration is mandatory"
                                                                        ControlToValidate="txtNarrationAdd" Display="Dynamic" EnableClientScript="True">*</asp:RequiredFieldValidator>
                                                                </td>
                                                                <td class="ControlTextBox3" style="width:27%">
                                                                    <asp:TextBox ID="txtNarrationAdd" runat="server" Height="30px" TextMode="MultiLine"
                                                                        Text='<%# Bind("Narration") %>' SkinID="skinTxtBoxGrid"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr style="height:2px">
                                                            </tr>
                                                            <tr>
                                                                <td colspan="4">
                                                                    <asp:Panel ID="PanelBankAdd" runat="server">
                                                                        <table id="tblBankAdd" runat="server" cellpadding="3" cellspacing="1" width="100%">
                                                                            
                                                                            <tr>
                                                                                <td class="ControlLabel" style="width:20%">
                                                                                    Bank Name: *
                                                                                    <asp:CompareValidator ID="cvBankAdd" runat="server" ControlToValidate="ddBanksAdd"
                                                                                        Display="Dynamic" EnableClientScript="False" ErrorMessage="Bank Name is Mandatory"
                                                                                        Text="*" Operator="GreaterThan" ValueToCompare="0">*</asp:CompareValidator>
                                                                                </td>
                                                                                <td class="ControlDrpBorder" style="width:27%">
                                                                                    <asp:DropDownList ID="ddBanksAdd" runat="server"  Width="100%" CssClass="drpDownListMedium" BackColor = "#e7e7e7" style="border: 1px solid #e7e7e7" height="26px"  SelectedValue='<%# Bind("CreditorID") %>'
                                                                                        DataSourceID="srcBanksAdd" DataTextField="LedgerName" DataValueField="LedgerID"
                                                                                        AppendDataBoundItems="True">
                                                                                        <asp:ListItem style="background-color: #e7e7e7" Selected="True" Value="0">Select Bank</asp:ListItem>
                                                                                    </asp:DropDownList>
                                                                                </td>
                                                                                <td class="ControlLabel" style="width:15%">
                                                                                    Cheque No: *
                                                                                    <asp:RequiredFieldValidator ID="rvChequeNoAdd" runat="server" ControlToValidate="txtChequeNoAdd"
                                                                                        ErrorMessage="Cheque No. is mandatory" Display="Dynamic" EnableClientScript="false">*</asp:RequiredFieldValidator>
                                                                                </td>
                                                                                <td class="ControlTextBox3" style="width:27%">
                                                                                    <asp:TextBox ID="txtChequeNoAdd" runat="server" Text='<%# Bind("ChequeNo") %>' SkinID="skinTxtBoxGrid"></asp:TextBox>
                                                                                </td>
                                                                                <%--<td style="width:10%">
                                                                                </td>--%>
                                                                            </tr>
                                                                        </table>
                                                                    </asp:Panel>
                                                                </td>
                                                            </tr>
                                                            <tr style="height:5px">
                                                                
                                                            </tr>
                                                            <tr>
                                                                <td colspan="4">
                                                                    <table width="100%">
                                                                        <tr>
                                                                            <td align="right" style="width: 36%;">
                                                                            </td>
                                                                            <td align="center" style="width: 17%;">                                                                               
                                                                                  <asp:Button ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert"
                                                                                    CssClass="savebutton1231" EnableTheming="false" SkinID="skinBtnSave" OnClick="InsertButton_Click">
                                                                                </asp:Button>
                                                                            </td>
                                                                            <td align="center" style="width: 17%;">
                                                                               <asp:Button ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                                                                                    CssClass="cancelbutton6" EnableTheming="false" SkinID="skinBtnCancel" OnClick="InsertCancelButton_Click">
                                                                                </asp:Button>
                                                                            </td>
                                                                            <td style="width: 30%;">
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
                                                                <asp:ObjectDataSource ID="srcBanksAdd" runat="server" SelectMethod="ListBanks" TypeName="BusinessLogic">
                                                                    <SelectParameters>
                                                                        <asp:CookieParameter Name="connection" CookieName="Company" Type="String" />
                                                                    </SelectParameters>
                                                                </asp:ObjectDataSource>
                                                            </td>
                                                            <td>
                                                                <asp:ObjectDataSource ID="srcCreditorDebitorAdd" runat="server" SelectMethod="ListBanks"
                                                                    TypeName="BusinessLogic">
                                                                    <SelectParameters>
                                                                        <asp:CookieParameter Name="connection" CookieName="Company" Type="String" />
                                                                    </SelectParameters>
                                                                </asp:ObjectDataSource>
                                                            </td>
                                                            <td>
                                                                <asp:ValidationSummary ID="valSumAdd" DisplayMode="BulletList" ShowMessageBox="true"
                                                                    ShowSummary="false" HeaderText="Validation Messages" Font-Names="'Trebuchet MS'"
                                                                    Font-Size="12" runat="server" />
                                                            </td>
                                                            <td>
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
                <tr style="width: 100%">
                    <td style="width: 100%">
                    <table width="100%" style="margin: -4px 0px 0px 0px;">
                                <tr style="width: 100%">
                                    <td>
                        <div class="mainGridHold" id="searchGrid">
                            <asp:GridView ID="GrdViewReceipt" runat="server" AllowSorting="false" AutoGenerateColumns="False"
                                OnRowCreated="GrdViewReceipt_RowCreated" Width="100.4%" DataSourceID="GridSource" CssClass="someClass"
                                AllowPaging="True" DataKeyNames="TransNo" EmptyDataText="No Bank Receipts found."
                                OnRowCommand="GrdViewReceipt_RowCommand" OnRowDataBound="GrdViewReceipt_RowDataBound"
                                OnSelectedIndexChanged="GrdViewReceipt_SelectedIndexChanged" OnRowDeleting="GrdViewReceipt_RowDeleting"
                                OnRowDeleted="GrdViewReceipt_RowDeleted">
                                <EmptyDataRowStyle CssClass="GrdContent" />
                                <Columns>
                                    <asp:BoundField DataField="TransNo" HeaderText="Trans. No." HeaderStyle-Wrap="false"  HeaderStyle-BorderColor="Gray"/>
                                    <asp:BoundField DataField="RefNo" HeaderText="Ref. No." HeaderStyle-Wrap="false"  HeaderStyle-BorderColor="Gray"/>
                                    <asp:BoundField DataField="TransDate" HeaderText="Transaction Date" HeaderStyle-Wrap="false" HeaderStyle-BorderColor="Gray"
                                        DataFormatString="{0:dd/MM/yyyy}" />
                                    <asp:BoundField DataField="LedgerName" HeaderText="Received From" HeaderStyle-Wrap="false"  HeaderStyle-BorderColor="Gray"/>
                                    <asp:BoundField DataField="Debi" HeaderText="Bank Name / Cash" HeaderStyle-Wrap="false"  HeaderStyle-BorderColor="Gray"/>
                                    <asp:BoundField DataField="Amount" HeaderText="Amount" HeaderStyle-Wrap="false" HeaderStyle-BorderColor="Gray" />
                                    <asp:BoundField DataField="Narration" HeaderText="Narration" HeaderStyle-Wrap="false"  HeaderStyle-BorderColor="Gray"/>
                                    <asp:TemplateField ItemStyle-CssClass="command" HeaderStyle-Width="50px" HeaderText="Edit" HeaderStyle-BorderColor="Gray">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="btnEdit" runat="server" SkinID="edit" CommandName="Select" />
                                            <asp:ImageButton ID="btnEditDisabled" Enabled="false" SkinID="editDisable" runat="Server"></asp:ImageButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ItemStyle-CssClass="command" HeaderStyle-Width="50px" HeaderText="Delete" HeaderStyle-BorderColor="Gray">
                                        <ItemTemplate>
                                            <cc1:ConfirmButtonExtender ID="CnrfmDel" TargetControlID="lnkB" ConfirmText="Are you sure to Delete this Receipt?"
                                                runat="server">
                                            </cc1:ConfirmButtonExtender>
                                            <asp:ImageButton ID="lnkB" SkinID="delete" runat="Server" CommandName="Delete"></asp:ImageButton>
                                            <asp:ImageButton ID="lnkBDisabled" Enabled="false" SkinID="deleteDisable" runat="Server"></asp:ImageButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ItemStyle-CssClass="command" HeaderStyle-Width="50px" HeaderText="Print" HeaderStyle-BorderColor="Gray">
                                        <ItemTemplate>
                                            <a href='<%# DataBinder.Eval(Container, "DataItem.TransNo", "javascript:PrintItem({0});") %>'>
                                                <asp:Image runat="server" id="lnkprint" alt="Print" border="0" src="App_Themes/DefaultTheme/Images/Print1.png"/>
                                            </a>
                                            <asp:ImageButton ID="btnViewDisabled" Enabled="false" SkinID="search" runat="Server"></asp:ImageButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField Visible="false">
                                        <ItemTemplate>
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
                                                <asp:DropDownList ID="ddlPageSelector" runat="server" AutoPostBack="true" Width="65px" Height="23px" style="border:1px solid blue" BackColor="#e7e7e7">
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
                <tr style="width:100%">
                    <td style="width: 918px" align="left">
                        <asp:ObjectDataSource ID="GridSource" runat="server" SelectMethod="ListReceiptsBank"
                            TypeName="BusinessLogic" DeleteMethod="DeleteReceipt" OnDeleting="GridSource_Deleting">
                            <DeleteParameters>
                                <asp:CookieParameter Name="connection" CookieName="Company" Type="String" />
                                <asp:Parameter Name="TransNo" Type="Int32" />
                                <asp:Parameter Name="requireValidation" Type="Boolean" DefaultValue="true" />
                                <asp:Parameter Name="Username" Type="String" />
                            </DeleteParameters>
                        </asp:ObjectDataSource>
                        <asp:ObjectDataSource ID="frmSource" runat="server" SelectMethod="GetReceiptForId"
                            TypeName="BusinessLogic" InsertMethod="InsertBankReceipt" OnUpdating="frmSource_Updating"
                            OnInserting="frmSource_Inserting" UpdateMethod="UpdateBankReceipt" OnInserted="frmSource_Inserted"
                            OnUpdated="frmSource_Updated">
                            <UpdateParameters>
                                <asp:CookieParameter Name="connection" CookieName="Company" Type="String" />
                                <asp:Parameter Name="TransNo" Type="Int32" />
                                <asp:Parameter Name="RefNo" Type="String" />
                                <asp:Parameter Name="TransDate" Type="DateTime" />
                                <asp:Parameter Name="DebitorID" Type="Int32" />
                                <asp:Parameter Name="CreditorID" Type="Int32" />
                                <asp:Parameter Name="Amount" Type="Double" />
                                <asp:Parameter Name="Narration" Type="String" />
                                <asp:Parameter Name="VoucherType" Type="String" />
                                <asp:Parameter Name="ChequeNo" Type="String" />
                                <asp:Parameter Name="Paymode" Type="String" />
                                <asp:Parameter Name="NewTransNo" Type="Int32" Direction="Output" />
                                <asp:Parameter Name="Username" Type="String" />
                            </UpdateParameters>
                            <SelectParameters>
                                <asp:ControlParameter ControlID="GrdViewReceipt" Name="TransNo" PropertyName="SelectedValue"
                                    Type="Int32" />
                                <asp:CookieParameter Name="connection" CookieName="Company" Type="String" />
                            </SelectParameters>
                            <InsertParameters>
                                <asp:CookieParameter Name="connection" CookieName="Company" Type="String" />
                                <asp:Parameter Name="RefNo" Type="String" />
                                <asp:Parameter Name="TransDate" Type="DateTime" />
                                <asp:Parameter Name="DebitorID" Type="Int32" />
                                <asp:Parameter Name="CreditorID" Type="Int32" />
                                <asp:Parameter Name="Amount" Type="Double" />
                                <asp:Parameter Name="Narration" Type="String" />
                                <asp:Parameter Name="VoucherType" Type="String" />
                                <asp:Parameter Name="ChequeNo" Type="String" />
                                <asp:Parameter Name="Paymode" Type="String" />
                                <asp:Parameter Name="NewTransNo" Type="Int32" Direction="Output" />
                                <asp:Parameter Name="Username" Type="String" />
                            </InsertParameters>
                        </asp:ObjectDataSource>
                    </td>
                </tr>
                <tr>
                    <td style="width: 100%">
                    </td>
                </tr>
            </table>
            <input type="hidden" id="hidAdvancedState" runat="server" />
            <asp:HiddenField ID="hdSMS" runat="server" Value="NO" />
            <asp:HiddenField ID="hdText" runat="server" />
            <asp:HiddenField ID="hdMobile" runat="server" />
            <asp:HiddenField ID="hdSMSRequired" runat="server" Value="NO" />
        </ContentTemplate>
    </asp:UpdatePanel>
    <table align="center">
        <tr>
            <td >
                <asp:Button ID="btnrec" runat="server"
                CssClass="exportexl6" EnableTheming="false" CausesValidation="false" 
                OnClientClick="window.open('ReportExcelReceipts.aspx?ID=BankRec','Summary', 'toolbar=no,status=no,menu=no,location=no,height=280,width=650,left=405,top=220 ,resizable=yes, scrollbars=yes');"></asp:Button>
           </td>
         </tr>
     </table>
</asp:Content>
