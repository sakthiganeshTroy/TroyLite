﻿<%@ Page Title="Expense > Expense Payment" Language="C#" MasterPageFile="~/PageMaster.master"
    AutoEventWireup="true" CodeFile="ExpPayment.aspx.cs" Inherits="ExpPayment" %>

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



        function pageLoad() {
            //  get the behavior associated with the tab control
            var tabContainer = $find('ctl00_cplhControlPanel_tabMain');

//            if (tabContainer == null)
//                tabContainer = $find('ctl00_cplhControlPanel_frmViewAdd_tabEdit');

            if (tabContainer != null) {
                //  get all of the tabs from the container
                var tabs = tabContainer.get_tabs();

                //  loop through each of the tabs and attach a handler to
                //  the tab header's mouseover event
                for (var i = 0; i < tabs.length; i++) {
                    var tab = tabs[i];

                    $addHandler(
                tab.get_headerTab(),
                'mouseover',
                Function.createDelegate(tab, function () {
                    tabContainer.set_activeTab(this);
                }
            ));
                }
            }
    }


        function OnKeyPress(args) {
            if (args.keyCode == Sys.UI.Key.esc) {
                $find("ctl00_cplhControlPanel_ModalPopupExtender2").hide();
            }
        }

        $("#ctl00_cplhControlPanel_UpdateCancelButton").live("click", function () {
            $find("ctl00_cplhControlPanel_ModalPopupExtender2").hide();
        });

        function CheckDate() {
            if (document.getElementById('ctl00_cplhControlPanel_hddate').value != '0') {
                if (document.getElementById('ctl00_cplhControlPanel_tabMain_tabEditMain_hddatecheck').value != '0') {
                    var rv = confirm("Date in Future, Do you still want to continue?");

                    if (rv == true) {
                        return true;
                    }
                    else {
                        return window.event.returnValue = false;
                    }
                }
            }
            else {
                if (document.getElementById('ctl00_cplhControlPanel_tabMain_tabEditMain_hddatecheck').value != '0') {
                    alert('Cash Payment Cannot be Future');
                    return window.event.returnValue = false;
                }
            }

        }

        function CheckPendingBill() {
            if (document.getElementById('ctl00_cplhControlPanel_hdPendingCount').value != '0') {
                var rv = confirm("Unadjusted Invoice found, Do you still want to continue?");

                if (rv == true) {
                    return true;
                }
                else {
                    return window.event.returnValue = false;
                }
            }
        }

        function ConfirmSMS() {
            if (Page_IsValid) {
                var confSMS = document.getElementById('ctl00_cplhControlPanel_hdSMS').value;

                var confSMSRequired = document.getElementById('ctl00_cplhControlPanel_hdSMSRequired').value;

                var txtMobile = document.getElementById('ctl00_cplhControlPanel_txtMobile');

                if (txtMobile == null)
                    txtMobile = document.getElementById('ctl00_cplhControlPanel_txtMobile');

                if (txtMobile != null) {
                    if (txtMobile.value != "") {

                        if (confSMSRequired == "YES") {
                            var rv = confirm("Do you want to send SMS to Supplier?");

                            if (rv == true) {
                                document.getElementById('ctl00_cplhControlPanel_hdSMS').value = "YES";
                                return false;
                            }
                            else {
                                document.getElementById('ctl00_cplhControlPanel_hdSMS').value = "NO";
                                return false;
                            }
                        }
                    }
                }
            }
        }

        function Validate() {
            var txtAmount = document.getElementById('ctl00_cplhControlPanel_txtAmount').value;

            if (txtAmount == "") {
                alert('Please enter the Payment Amount before Adding BillNo');
                return true;
            }

            var e = document.getElementById("ctl00_cplhControlPanel_ddReceivedFrom");

            var strUser = e.options[e.selectedIndex].value;

            if (strUser == "0") {
                alert('Please Select the Supplier before Adding Bills');
                return true;
            }

        }

        function EditMobile_Validator() {
            var txtMobile = document.getElementById('ctl00_cplhControlPanel_txtMobile').value;

            if (txtMobile.length > 0) {
                if (txtMobile.length != 10) {
                    alert("Supplier Mobile Number should be minimum of 10 digits.");
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
            var txtMobile = document.getElementById('ctl00_cplhControlPanel_txtMobile').value;

            if (txtMobile.length > 0) {
                if (txtMobile.length != 10) {
                    alert("Supplier Mobile Number should be minimum of 10 digits.");
                    Page_IsValid = false;
                    return window.event.returnValue = false;
                }

                if (txtMobile.charAt(0) == "0") {
                    alert("Supplier Mobile should not start with Zero. Please remove Zero and try again.");
                    Page_IsValid = false;
                    return window.event.returnValue = false;
                }
            }
            else {
                Page_IsValid = true;
            }
        }


        function PrintItem(ID) {
            window.showModalDialog('./PrintPayment.aspx?ID=' + ID, self, 'dialogWidth:700px;dialogHeight:430px;status:no;dialogHide:yes;unadorned:yes;');
        }

//        function ShowCreditSales() {
//            //return window.open('./ShowSalesBills.aspx', self, 'dialogWidth:800px;dialogHeight:350px;scroll:on;status:no;dialogHide:yes;unadorned:no;');
//            window.open("ShowSalesBills.aspx", "TROY", "toolbar=no,menubar=no,resizable=yes,status=yes,height=450px,width=700px,scrollbars=yes");
//        }

        function AdvancedTest(id) {

            var panel = document.getElementById('ctl00_cplhControlPanel_tabMain_tabEditMain_tblBank');
            var adv = document.getElementById('ctl00_cplhControlPanel_hidAdvancedState');

            var rdoArray = document.getElementsByTagName("input");


            for (i = 0; i <= rdoArray.length - 1; i++) {
                //alert(rdoArray[i].type);
                if (rdoArray[i].type == 'radio') {

                    if (rdoArray[i].value == 'Cash' && rdoArray[i].checked == true) {
                        document.getElementById('ctl00_cplhControlPanel_hddate').value = "0";
                        panel.className = "hidden";
                        adv.value = panel.className;
                    }
                    else if (rdoArray[i].value == 'Cheque' && rdoArray[i].checked == true) {
                        document.getElementById('ctl00_cplhControlPanel_hddate').value = "1";
                        panel.className = "AdvancedSearch";
                        adv.value = panel.className;
                    }

                }
            }
        }

//        function AdvancedAdd(id) {

//            var panel = document.getElementById('ctl00_cplhControlPanel_tabMain_tabEditMain_tblBank');
//            var adv = document.getElementById('ctl00_cplhControlPanel_hidAdvancedState');

//            var rdoArray = document.getElementsByTagName("input");


//            for (i = 0; i <= rdoArray.length - 1; i++) {
//                //alert(rdoArray[i].type);
//                if (rdoArray[i].type == 'radio') {

//                    if (rdoArray[i].value == 'Cash' && rdoArray[i].checked == true) {
//                        document.getElementById('ctl00_cplhControlPanel_hddate').value = "0";
//                        panel.className = "hidden";
//                        adv.value = panel.className;
//                    }
//                    else if (rdoArray[i].value == 'Cheque' && rdoArray[i].checked == true) {
//                        document.getElementById('ctl00_cplhControlPanel_hddate').value = "1";
//                        panel.className = "AdvancedSearch";
//                        adv.value = panel.className;
//                    }

//                }
//            }
//        }
//    </script>

<style id="Style1" runat="server">
        
        
        .fancy-green .ajax__tab_header
        {
	        background: url(App_Themes/NewTheme/Images/green_bg_Tab.gif) repeat-x;
	        cursor:pointer;
        }
        .fancy-green .ajax__tab_hover .ajax__tab_outer, .fancy-green .ajax__tab_active .ajax__tab_outer
        {
	        background: url(App_Themes/NewTheme/Images/green_left_Tab.gif) no-repeat left top;
        }
        .fancy-green .ajax__tab_hover .ajax__tab_inner, .fancy-green .ajax__tab_active .ajax__tab_inner
        {
	        background: url(App_Themes/NewTheme/Images/green_right_Tab.gif) no-repeat right top;
        }
        .fancy .ajax__tab_header
        {
	        font-size: 13px;
	        font-weight: bold;
	        color: #000;
	        font-family: sans-serif;
        }
        .fancy .ajax__tab_active .ajax__tab_outer, .fancy .ajax__tab_header .ajax__tab_outer, .fancy .ajax__tab_hover .ajax__tab_outer
        {
	        height: 46px;
        }
        .fancy .ajax__tab_active .ajax__tab_inner, .fancy .ajax__tab_header .ajax__tab_inner, .fancy .ajax__tab_hover .ajax__tab_inner
        {
	        height: 46px;
	        margin-left: 16px; /* offset the width of the left image */
        }
        .fancy .ajax__tab_active .ajax__tab_tab, .fancy .ajax__tab_hover .ajax__tab_tab, .fancy .ajax__tab_header .ajax__tab_tab
        {
	        margin: 16px 16px 0px 0px;
        }
        .fancy .ajax__tab_hover .ajax__tab_tab, .fancy .ajax__tab_active .ajax__tab_tab
        {
	        color: #fff;
        }
        .fancy .ajax__tab_body
        {
	        font-family: Arial;
	        font-size: 10pt;
	        border-top: 0;
	        border:1px solid #999999;
	        padding: 8px;
	        background-color: #ffffff;
        }
        
    </style>

    <asp:UpdatePanel ID="UpdatePanelPage" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
        
            <table style="width: 100%;" align="center">
                <tr style="width: 100%">
                    <td style="width: 100%" valign="middle">
                        
                            <%--<div class="mainConHd">
                                <table cellspacing="0" cellpadding="0" border="0">
                                    <tr valign="middle">
                                        <td>
                                            <span>Supplier Payments</span>
                                        </td>
                                    </tr>
                                </table>
                            </div>--%>
                            <%--<table class="mainConHd" style="width: 994px;">
                                <tr valign="middle">
                                    <td style="font-size: 20px;">
                                        Expense Payments
                                    </td>
                                </tr>
                            </table>--%>
                            <div class="mainConBody">
                                
                                    <table cellspacing="2px" cellpadding="3px" border="0" width="100.3%"
                                        class="searchbg" style="margin: -3px 0px 0px 2px;">
                                        <tr style="height: 25px">
                                            <td style="width: 2%;"></td>
                                            <td style="width: 23%; font-size: 22px; color: #000000;" >
                                                Expense Payments
                                            </td>
                                            <td style="width: 12%">
                                                <div style="text-align: right;">
                                                    <asp:Panel ID="pnlSearch" runat="server" Width="100px">
                                                        <asp:Button ID="lnkBtnAdd" runat="server" OnClick="lnkBtnAdd_Click" CssClass="ButtonAdd66"
                                                            EnableTheming="false" Width="80px" Text=""></asp:Button>
                                                    </asp:Panel>
                                                </div>
                                            </td>
                                            <td style="width: 15%; color: #000000;" align="right">
                                                Search
                                            </td>
                                            <td style="width: 18%" class="Box1">
                                                <asp:TextBox ID="txtSearch" runat="server" CssClass="cssTextBox" Width="92%"></asp:TextBox>
                                            </td>
                                            <td style="width: 18%" class="Box1">
                                                <div style="width: 150px; font-family: 'Trebuchet MS';">
                                                    <asp:DropDownList ID="ddCriteria" runat="server" Width="157px" Height="23px" BackColor="#BBCAFB" style="text-align:center;border:1px solid #BBCAFB ">
                                                        <%--<asp:ListItem Value="0" style="background-color: #bce1fe">All</asp:ListItem>--%>
                                                        <asp:ListItem Value="TransNo">Trans. No.</asp:ListItem>
                                                        <asp:ListItem Value="RefNo">Ref. No.</asp:ListItem>
                                                        <asp:ListItem Value="TransDate">Transaction Date</asp:ListItem>
                                                        <asp:ListItem Value="LedgerName">Paid To</asp:ListItem>
                                                        <asp:ListItem Value="Narration">Narration</asp:ListItem>
                                                    </asp:DropDownList>
                                            </td>
                                            <td style="width: 22%; text-align: left">
                                                <asp:Button ID="btnSearch" runat="server" Text="" OnClick="btnSearch_Click"
                                                     CssClass="ButtonSearch6" EnableTheming="false" />
                                            </td>
                                        </tr>
                                    </table>
                                
                            </div>
                        
                        <input id="dummy" type="button" style="display: none" runat="server" />
                        <input id="Button1" type="button" style="display: none" runat="server" />
                        <cc1:ModalPopupExtender ID="ModalPopupExtender2" runat="server" BackgroundCssClass="modalBackground"
                            CancelControlID="Button1" DynamicServicePath="" Enabled="True" PopupControlID="popUp"
                            TargetControlID="dummy">
                        </cc1:ModalPopupExtender>
                        <asp:Panel runat="server" ID="popUp" Style="width: 60%; display: none">
                            <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <div id="contentPopUp">
                                        <asp:Panel ID="pnlEdit" runat="server">
                                            <table class="tblLeft" cellpadding="0" cellspacing="0" style="border: 0px solid #5078B3;
                                                background-color: #fff; color: #000;" width="100%">
                                                <tr>
                                                    <td>
                                                        <div class="divArea">
                                                            <table class="tblLeft" cellpadding="3" cellspacing="0" style="padding-left: 5px;"
                                                                width="100%">
                                                                <tr>
                                                                    <td colspan="4">
                                                                        <table class="headerPopUp">
                                                                            <tr>
                                                                                <td>
                                                                                    Expense Payment
                                                                                </td>
                                                                            </tr>
                                                                        </table>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <div style="text-align: left">
                                                                            <table style="width: 100%;border: 0px solid #86b2d1" align="center" cellpadding="3" cellspacing="2">
                                                                                <tr>
                                                                                    <td colspan="4" align="left">
                                                                                        <cc1:TabContainer ID="tabMain" runat="server" Width="100%" ActiveTabIndex="0"  CssClass="fancy fancy-green">
                                                                                            <cc1:TabPanel ID="tabEditMain" runat="server" HeaderText="Payment Details">
                                                                                                <ContentTemplate>
                                                                                                    <table style="width: 800px; border: 0px solid #86b2d1; vertical-align: text-top" align="center" cellpadding="3"
                                                                                                        cellspacing="2">
                                                                                                            <tr style="height:5%">
                                                                                                            </tr>
                                                                                                            <tr>
                                                                                                                <td class="ControlLabel" style="width: 24%">
                                                                                                                    Ref. No. *
                                                                                                                    <asp:RequiredFieldValidator ID="rvRefNo" runat="server" ErrorMessage="Ref. No. is mandatory"
                                                                                                                        ControlToValidate="txtRefNo" Display="Dynamic">*</asp:RequiredFieldValidator>
                                                                                                                    <cc1:FilteredTextBoxExtender ID="OBvalidAdd" runat="server" FilterType="Numbers"
                                                                                                                        TargetControlID="txtRefNo" />
                                                                                                                </td>
                                                                                                                <td class="ControlTextBox3" style="width: 25%">
                                                                                                                    <asp:TextBox ID="txtRefNo" runat="server" Text='<%# Bind("RefNo") %>' Width="100px"
                                                                                                                        CssClass="cssTextBox" ></asp:TextBox>
                                                                                                                </td>
                                                                                                                <td class="ControlLabel" style="width: 16%">
                                                                                                                    <asp:Label ID="Label1" runat="server"
                                                                                                                                    Width="120px" Text="Date *" ></asp:Label>
                                                                                                                    <asp:RequiredFieldValidator ID="rvStock" runat="server" ControlToValidate="txtTransDate"
                                                                                                                        ErrorMessage="Trasaction Date is mandatory" Display="Dynamic">*</asp:RequiredFieldValidator>
                                                                                                                    <asp:CompareValidator ControlToValidate="txtTransDate" Operator="DataTypeCheck" Type="Date"
                                                                                                                        ErrorMessage="Please enter a valid date" runat="server" ID="cmpValtxtDate">*</asp:CompareValidator>
                                                                                                                    <%--<asp:RangeValidator ID="myRangeValidator" runat="server" ControlToValidate="txtTransDate"
                                                                                                                        ErrorMessage="Payment date cannot be future date." Text="*" Type="Date"></asp:RangeValidator>--%>
                                                                                                                </td>
                                                                                                                <td class="ControlTextBox3" style="width: 25%">
                                                                                                                    <asp:TextBox ID="txtTransDate" runat="server" OnTextChanged="txtTransDate_TextChanged" AutoPostBack="true" Text='<%# Bind("TransDate","{0:dd/MM/yyyy}") %>'
                                                                                                                        CssClass="cssTextBox" Width="100px"></asp:TextBox>
                                                                                                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                                                                                                    <cc1:CalendarExtender ID="calExtender3" runat="server" Animated="true" Format="dd/MM/yyyy"
                                                                                                                        PopupButtonID="btnDate3" PopupPosition="BottomLeft" TargetControlID="txtTransDate">
                                                                                                                    </cc1:CalendarExtender>
                                                                                                                </td>
                                                                                                                <td>
                                                                                                                    <asp:ImageButton ID="btnDate3" ImageUrl="App_Themes/NewTheme/images/cal.gif" CausesValidation="false"
                                                                                                                        Width="20px" runat="server" />
                                                                                                                </td>
                                                                                                            </tr>
                                                                                                            <tr >
                                                                                                                <td class="ControlLabel" style="width: 24%">
                                                                                                                    Heading
                                                                                                                </td>
                                                                                                                <td class="ControlDrpBorder" style="width: 25%">
                                                                                                                    <asp:DropDownList ID="drpHeading" runat="server" AutoPostBack="True" Width="100%" CssClass="drpDownListMedium" BackColor = "#90c9fc"
                                                                                                                        DataValueField="HeadingID" OnSelectedIndexChanged="drpHeading_SelectedIndexChanged" style="border: 1px solid #90c9fc" height="26px" 
                                                                                                                        DataTextField="Heading" AppendDataBoundItems="True">
                                                                                                                        <asp:ListItem Text="Select Heading" Value="0"></asp:ListItem>
                                                                                                                    </asp:DropDownList>
                                                                                                                </td>
                                                                                                                <td class="ControlLabel" style="width: 16%">
                                                                                                                    Group
                                                                                                                </td>
                                                                                                                <td class="ControlDrpBorder" style="width: 25%">
                                                                                                                    <asp:DropDownList ID="drpGroup" runat="server" AutoPostBack="True" Width="100%" CssClass="drpDownListMedium" BackColor = "#90c9fc"
                                                                                                                        DataValueField="GroupID" OnSelectedIndexChanged="drpGroupName_SelectedIndexChanged" style="border: 1px solid #90c9fc" height="26px" 
                                                                                                                        DataTextField="GroupName" AppendDataBoundItems="True">
                                                                                                                        <asp:ListItem Text="Select Group" Value="0"></asp:ListItem>
                                                                                                                    </asp:DropDownList>
                                                                                                                </td>
                                                                                                            </tr>

                                                                                                            <tr >
                                                                                                                <td class="ControlLabel" style="width: 24%">
                                                                                                                    Paid To *
                                                                                                                    <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="ddReceivedFrom"
                                                                                                                        Display="Dynamic" ErrorMessage="Received From is Mandatory" Operator="GreaterThan"
                                                                                                                        ValueToCompare="0">*</asp:CompareValidator>
                                                                                                                </td>
                                                                                                                <td class="ControlDrpBorder" style="width: 25%">
                                                                                                                    <asp:DropDownList ID="ddReceivedFrom" runat="server" AutoPostBack="True" Width="100%" CssClass="drpDownListMedium" BackColor = "#90c9fc"
                                                                                                                        DataValueField="LedgerID" OnSelectedIndexChanged="ComboBox2_SelectedIndexChanged" style="border: 1px solid #90c9fc" height="26px" 
                                                                                                                        DataTextField="LedgerName" AppendDataBoundItems="True">
                                                                                                                        <asp:ListItem Text="Select Ledger" Value="0"></asp:ListItem>
                                                                                                                    </asp:DropDownList>
                                                                                                                </td>
                                                                                                                <td class="ControlLabel" style="width: 16%">
                                                                                                                    Amount *
                                                                                                                    <asp:RequiredFieldValidator ID="rvModel" runat="server" ControlToValidate="txtAmount"
                                                                                                                        ErrorMessage="Amount is mandatory" Display="Dynamic">*</asp:RequiredFieldValidator>
                                                                                                                    <cc1:FilteredTextBoxExtender ID="fltAmt" runat="server" TargetControlID="txtAmount"
                                                                                                                        ValidChars="." FilterType="Custom, Numbers" Enabled="True" />
                                                                                                                </td>
                                                                                                                <td class="ControlTextBox3" style="width: 25%">
                                                                                                                    <asp:TextBox ID="txtAmount" runat="server" Text='<%# Bind("Amount") %>' SkinID="skinTxtBoxGrid"></asp:TextBox>
                                                                                                                </td>
                                                                                                            </tr>
                                                                                                            <tr>
                                                                                                                <td class="ControlLabel" style="width: 24%">
                                                                                                                    Payment Made By *
                                                                                                                    <asp:RequiredFieldValidator ID="rvBDate" runat="server" ControlToValidate="chkPayTo"
                                                                                                                        Display="Dynamic" ErrorMessage="Item Name is mandatory.">*</asp:RequiredFieldValidator>
                                                                                                                </td>
                                                                                                                <td class="ControlTextBox3" style="width: 25%">
                                                                                                                    <asp:RadioButtonList ID="chkPayTo" runat="server" onclick="javascript:AdvancedTest(this.id);"
                                                                                                                        Width="100%" OnSelectedIndexChanged="chkPayTo_SelectedIndexChanged">
                                                                                                                        <asp:ListItem Text="Cash" Selected="True"></asp:ListItem>
                                                                                                                        <asp:ListItem Text="Cheque"></asp:ListItem>
                                                                                                                    </asp:RadioButtonList>
                                                                                                                </td>
                                                                                                                <td class="ControlLabel" style="width: 16%">
                                                                                                                    Narration *
                                                                                                                    <asp:RequiredFieldValidator ID="rvNarration" runat="server" ErrorMessage="Narration is mandatory"
                                                                                                                        ControlToValidate="txtNarration" Display="Dynamic">*</asp:RequiredFieldValidator>
                                                                                                                </td>
                                                                                                                <td class="ControlTextBox3" style="width: 25%">
                                                                                                                    <asp:TextBox ID="txtNarration" runat="server" Height="25px" TextMode="MultiLine"
                                                                                                                        Text='<%# Bind("Narration") %>' Width="95%" CssClass="cssTextBox"></asp:TextBox>
                                                                                                                </td>
                                                                                                            </tr>
                                                                                                            <%--<tr style="height:0px">
                                                                                                            </tr>--%>
                                                                                                            <%--<tr>
                                                                                                                <td class="ControlLabel" style="width: 24%">
                                                                                                                    Mobile *
                                                                                                                    <cc1:FilteredTextBoxExtender ID="FilteredTextBoxEx" runat="server" FilterType="Numbers"
                                                                                                                        TargetControlID="txtMobile" Enabled="True" />
                                                                                                                </td>
                                                                                                                <td class="ControlTextBox3" style="width: 25%">
                                                                                                                    <asp:TextBox ID="txtMobile" runat="server" Text='<%# Bind("Mobile") %>' MaxLength="10" Height="26px"
                                                                                                                        CssClass="cssTextBox" Width="98%"></asp:TextBox>
                                                                                                                </td>
                                                                                                                <td class="ControlLabel" style="width: 16%">
                                                                                                                    Phone No *
                                                                                                                    <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender1" runat="server" FilterType="Numbers"
                                                                                                                        TargetControlID="txtPhone" Enabled="True" />
                                                                                                                </td>
                                                                                                                <td class="ControlTextBox3" style="width: 25%">
                                                                                                                    <asp:TextBox ID="txtPhone" runat="server" Text='<%# Bind("Phone") %>' MaxLength="10" Height="26px"
                                                                                                                        CssClass="cssTextBox" Width="98%"></asp:TextBox>
                                                                                                                </td>
                                                                                                            </tr>--%>
                                                                                
                                                                                                            <tr id="tblBank" runat="server">
                                                                                                                <td id="Td1" class="ControlLabel" runat="server" style="width: 24%">
                                                                                                                    <asp:CompareValidator ID="cvBank" runat="server" ControlToValidate="ddBanks" Display="Dynamic"
                                                                                                                        EnableClientScript="False" ErrorMessage="Bank Name is Mandatory" Operator="GreaterThan"
                                                                                                                        ValueToCompare="0">*</asp:CompareValidator>
                                                                                                                        Bank Name *
                                                                                                                </td>
                                                                                                                <td id="Td2" runat="server" style="width: 25%" class="ControlDrpBorder">
                                                                                                                    <asp:UpdatePanel ID="UpdatePanel31" runat="server" UpdateMode="Conditional">
                                                                                                                        <Triggers>
                                                                                                                            <asp:AsyncPostBackTrigger ControlID="ddBanks" EventName="SelectedIndexChanged" />
                                                                                                                        </Triggers>
                                                                                                                        <ContentTemplate>
                                                                                                                            <asp:DropDownList ID="ddBanks" runat="server" style="border: 1px solid #90c9fc" height="26px"  CssClass="drpDownListMedium" BackColor = "#90c9fc" width="100%"
                                                                                                                                DataTextField="LedgerName" DataValueField="LedgerID" AppendDataBoundItems="True">
                                                                                                                                <asp:ListItem Selected="True" style="background-color: #90c9fc" Value="0">Select Bank</asp:ListItem>
                                                                                                                            </asp:DropDownList>
                                                                                                                        </ContentTemplate>
                                                                                                                    </asp:UpdatePanel>
                                                                                                                </td>
                                                                                                                <td id="Td3" class="ControlLabel" runat="server" style="width: 16%">
                                                                                                                    <asp:RequiredFieldValidator ID="rvChequeNo" runat="server" ControlToValidate="txtChequeNo"
                                                                                                                        ErrorMessage="Cheque No. is mandatory" Display="Dynamic" EnableClientScript="False">*</asp:RequiredFieldValidator>
                                                                                                                    Cheque No. *
                                                                                                                </td>
                                                                                                                <td id="Td4" runat="server" class="ControlDrpBorder" style="width: 25%">
                                                                                                                        <%--<asp:UpdatePanel ID="UpdatePanel312" runat="server" UpdateMode="Conditional">
                                                                                                                        <Triggers>
                                                                                                                            <asp:AsyncPostBackTrigger ControlID="ddBanks" EventName="SelectedIndexChanged" />
                                                                                                                        </Triggers>
                                                                                                                        <ContentTemplate>
                                                                                                                    <asp:DropDownList ID="txtChequeNo" runat="server"  style="border: 1px solid #90c9fc" height="26px"  CssClass="drpDownListMedium" BackColor = "#90c9fc" AutoPostBack="false"
                                                                                                                        DataValueField="ChequeId" DataTextField="ChequeNo" Width="100%"
                                                                                                                        AppendDataBoundItems="true">
                                                                                                                        <%--<asp:ListItem style="background-color: #90c9fc" Text="Select Cheque No" Value="0"></asp:ListItem>--%>
                                                                                                                    <%--</asp:DropDownList>
                                                                                                                    </ContentTemplate>
                                                                                                                    </asp:UpdatePanel>--%>
                                                                                                                    <asp:TextBox ID="txtChequeNo" runat="server" Text='<%# Bind("ChequeNo") %>'  Height="26px" SkinID="skinTxtBoxGrid"
                                                                                                                        Width="95%" CssClass="cssTextBox" MaxLength="10"></asp:TextBox>
                                                                                                                </td>
                                                                                                            </tr>
                                                                                                            <tr>
                                                                                                                <td colspan="4">
                                                                                                                    <asp:UpdatePanel ID="UP1" runat="server" UpdateMode="Conditional">
                                                                                                                        <Triggers>
                                                                                                                            <asp:AsyncPostBackTrigger ControlID="txtTransDate" EventName="TextChanged" />
                                                                                                                        </Triggers>
                                                                                                                        <ContentTemplate>
                                                                                                                            <asp:HiddenField ID="hddatecheck" runat="server" Value="0" />
                                                                                                                        </ContentTemplate>
                                                                                                                    </asp:UpdatePanel>
                                                                                                                </td>
                                                                                                            </tr>
                                                                                                    </table>
                                                                                                </ContentTemplate>
                                                                                            </cc1:TabPanel>
                                                                                            <cc1:TabPanel ID="tabInsAddTab" runat="server" HeaderText="Additional Details">
                                                                                                <ContentTemplate>
                                                                                                    <table align="center" cellpadding="3" cellspacing="5" style="border: 0px solid #5078B3;
                                                                                                        width: 800px;">
                                                                                                        <tr>
                                                                                                            <td class="ControlLabel" style="width: 40%;">
                                                                                                                Against Bill No.
                                                                                                            </td>
                                                                                                            <td class="ControlTextBox3" style="width: 25%;">
                                                                                                                <asp:TextBox ID="txtBillAdd" runat="server" Text='<%# Bind("BillNo") %>' SkinID="skinTxtBoxGrid"></asp:TextBox>
                                                                                                            </td>
                                                                                                            <td style="width: 15%;">
                                                                                                            </td>
                                                                                                            <td style="width: 20%;">
                                                                                                            </td>
                                                                                                        </tr>
                                                                                                    </table>
                                                                                                </ContentTemplate>
                                                                                            </cc1:TabPanel>
                                                                                        </cc1:TabContainer>
                                                                                    </td>
                                                                                </tr>
                                                                                
                                                                                
                                                                                <tr style="height: 30px; text-align: center">
                                                                                    <td colspan="6">
                                                                                        <table width="100%" cellspacing="0" style="table-layout: fixed">
                                                                                            <tr>
                                                                                                <td style="width: 32%">
                                                                                                </td>
                                                                                                <td style="width: 18%">
                                                                                                    <asp:Button ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                                                                                                        OnClick="UpdateCancelButton_Click" SkinID="skinBtnCancel" CssClass="cancelbutton6"
                                                                                                        EnableTheming="false"></asp:Button>
                                                                                                </td>
                                                                                                <td style="width: 18%">
                                                                                                    <asp:Button ID="UpdateButton" runat="server" SkinID="skinBtnSave" OnClientClick="javascript:CheckDate();"
                                                                                                        OnClick="UpdateButton_Click" CssClass="Updatebutton1231" EnableTheming="false"></asp:Button>
                                                                                                    <asp:Button ID="SaveButton" runat="server" SkinID="skinBtnSave" OnClientClick="javascript:CheckDate();"
                                                                                                        OnClick="SaveButton_Click" CssClass="savebutton1231" EnableTheming="false"></asp:Button>
                                                                                                </td>
                                                                                                <td style="width: 32%">
                                                                                                    
                                                                                                    
                                                                                                </td>
                                                                                            </tr>
                                                                                            <tr>
                                                                                                <td>
                                                                                                    <asp:ObjectDataSource ID="srcBanks" runat="server" SelectMethod="ListBanks" TypeName="BusinessLogic">
                                                                                                        <SelectParameters>
                                                                                                            <asp:CookieParameter Name="connection" CookieName="Company" Type="String" />
                                                                                                        </SelectParameters>
                                                                                                    </asp:ObjectDataSource>
                                                                                                </td>
                                                                                                <td>
                                                                                                    <asp:ObjectDataSource ID="srcCreditorDebitorAdd" runat="server" SelectMethod="ListExpenses"
                                                                                                        TypeName="BusinessLogic">
                                                                                                        <SelectParameters>
                                                                                                            <asp:CookieParameter Name="connection" CookieName="Company" Type="String" />
                                                                                                        </SelectParameters>
                                                                                                    </asp:ObjectDataSource>
                                                                                                </td>
                                                                                                <td>
                                                                                                <td>
                                                                                                    <asp:ObjectDataSource ID="srcChequeNo" runat="server" SelectMethod="ListChequeNos" TypeName="BusinessLogic">
                                                                                                        <SelectParameters>
                                                                                                            <asp:CookieParameter Name="connection" CookieName="Company" Type="String" />
                                                                                                        </SelectParameters>
                                                                                                    </asp:ObjectDataSource>
                                                                                                </td>
                                                                                                </td>
                                                                                                <td>
                                                                                                </td>
                                                                                                <td>
                                                                                                </td>
                                                                                                <td>
                                                                                                </td>
                                                                                            </tr>
                                                                                        </table>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td>
                                                                                        <asp:Label runat="server" ID="Error" ForeColor="Red"></asp:Label>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </div>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                        </asp:Panel>
                    </td>
                </tr>
                <tr style="width: 100%;  margin: -4px 0px 0px 0px;">
                    <td style="width: 100%">
                        <table width="100%" style="margin: -6px 0px 0px 0px;">
                            <tr style="width: 100%">
                                <td>
                        <div class="mainGridHold" id="searchGrid">
                            <asp:GridView ID="GrdViewPayment" runat="server" AllowSorting="false" AutoGenerateColumns="False"
                                OnRowCreated="GrdViewPayment_RowCreated" Width="100.3%" DataSourceID="GridSource"
                                AllowPaging="True" DataKeyNames="TransNo" EmptyDataText="No Payment found!"
                                OnRowCommand="GrdViewPayment_RowCommand" OnRowDataBound="GrdViewPayment_RowDataBound"
                                OnSelectedIndexChanged="GrdViewPayment_SelectedIndexChanged" OnRowDeleting="GrdViewPayment_RowDeleting"
                                OnRowDeleted="GrdViewPayment_RowDeleted" CssClass="someClass">
                                <EmptyDataRowStyle CssClass="GrdContent" />
                                <Columns>
                                    <asp:BoundField DataField="TransNo" HeaderText="Trans. No." HeaderStyle-Wrap="false" HeaderStyle-BorderColor="Gray" />
                                    <asp:BoundField DataField="RefNo" HeaderText="Ref. No." HeaderStyle-Wrap="false"  HeaderStyle-BorderColor="Gray"/>
                                    <asp:BoundField DataField="TransDate" HeaderText="Transaction Date" HeaderStyle-Wrap="false" HeaderStyle-BorderColor="Gray"
                                        DataFormatString="{0:dd/MM/yyyy}" />
                                    <asp:BoundField DataField="Debi" HeaderText="Paid To" HeaderStyle-Wrap="false"  HeaderStyle-BorderColor="Gray"/>
                                    <asp:BoundField DataField="LedgerName" HeaderText="Bank Name / Cash" HeaderStyle-Wrap="false"  HeaderStyle-BorderColor="Gray"/>
                                    <asp:BoundField DataField="Amount" HeaderText="Amount" HeaderStyle-Wrap="false"  HeaderStyle-BorderColor="Gray"/>
                                    <asp:BoundField DataField="Narration" HeaderText="Narration" HeaderStyle-Wrap="false"  HeaderStyle-BorderColor="Gray"/>
                                    <asp:TemplateField ItemStyle-CssClass="command" HeaderStyle-Width="50px" HeaderText="Edit" HeaderStyle-BorderColor="Gray">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="btnEdit" CausesValidation="false" runat="server" SkinID="edit"
                                                CommandName="Select" />
                                            <asp:ImageButton ID="btnEditDisabled" Enabled="false" SkinID="editDisable" runat="Server"></asp:ImageButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ItemStyle-CssClass="command" HeaderStyle-Width="50px" HeaderText="Delete" HeaderStyle-BorderColor="Gray">
                                        <ItemTemplate>
                                            <cc1:ConfirmButtonExtender ID="CnrfmDel" TargetControlID="lnkB" ConfirmText="Are you sure to Delete this Payment?"
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
                                                <asp:DropDownList ID="ddlPageSelector" style="border:1px solid blue" runat="server" AutoPostBack="true" BackColor="#BBCAFB" Width="65px" Height="23px">
                                                </asp:DropDownList>
                                            </td>
                                            <td style="Width:5px; border-color:white">
                                            
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
                    <td align="left">
                        <asp:ObjectDataSource ID="GridSource" runat="server" SelectMethod="ListExpensesPayments"
                            TypeName="BusinessLogic" DeleteMethod="DeletePayment" OnDeleting="GridSource_Deleting">
                            <DeleteParameters>
                                <asp:CookieParameter Name="connection" CookieName="Company" Type="String" />
                                <asp:Parameter Name="TransNo" Type="Int32" />
                                <asp:Parameter Name="requireValidation" Type="Boolean" DefaultValue="true" />
                                <asp:Parameter Name="Username" Type="String" />
                            </DeleteParameters>
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
            <asp:HiddenField ID="hdPendingCount" runat="server" Value="0" />
            <asp:HiddenField ID="hddate" runat="server" Value="0" />
            <asp:HiddenField ID="hdPayment" runat="server" />
            <asp:HiddenField ID="hdEmailRequired" runat="server" Value="NO" />
            <br />
        </ContentTemplate>
    </asp:UpdatePanel>
    <table align="center">
        <tr>
            <td >
                <asp:Button ID="btnpay" runat="server"
                CssClass="exportexl6" EnableTheming="false" CausesValidation="false"
                OnClientClick="window.open('ReportExcelPayments.aspx?ID=ExpPay','Summary', 'toolbar=no,status=no,menu=no,location=no,height=280,width=650,left=405,top=220 ,resizable=yes, scrollbars=yes');"></asp:Button>
           </td>
         </tr>
     </table>
</asp:Content>