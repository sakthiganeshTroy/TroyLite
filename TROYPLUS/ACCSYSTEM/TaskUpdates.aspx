﻿<%@ Page Language="C#" MasterPageFile="~/PageMaster.master" AutoEventWireup="true"
    CodeFile="TaskUpdates.aspx.cs" Inherits="TaskUpdates" Title="Resource > Task Updates" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cplhTab" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cplhControlPanel" runat="Server">
    <script language="javascript" type="text/javascript">
        function pageLoad() {
            //  get the behavior associated with the tab control
            var tabContainer = $find('ctl00_cplhControlPanel_tbMain');

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


    </script>

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

    <asp:UpdatePanel ID="UpdatePanel16" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            
            <table style="width: 100%">
            <tr style="width: 100%">
            <td style="width: 100%">
                    <%--<div class="mainConHd">
                        <table cellspacing="0" cellpadding="0" border="0">
                            <tr style="text-align: center; vertical-align: text-top">
                                <td>
                                    <span>Resource Work Entries</span>
                                </td>
                            </tr>
                        </table>
                    </div>--%>
                    <%--<table class="mainConHd" style="width: 994px;">
                                <tr valign="middle">
                                    <td style="font-size: 20px;">
                                        Resource Work Entries
                                    </td>
                                </tr>
                            </table>--%>
                    <div class="mainConBody">
                        <div style="text-align: left">
                            <table style="width: 99.8%; margin: -2px 0px 0px 1px;" cellpadding="3" cellspacing="2" class="searchbg">
                                <tr >
                                    <td style="width: 4%;">
                                        
                                    </td>
                                    <td style="width: 20%; font-size: 22px; color: White">
                                        Task Updates
                                    </td>
                                    <td style="width: 17%">
                                        <div style="text-align: right;">
                                            <asp:Panel ID="pnlSearch" runat="server" Width="100px">
                                                <asp:Button ID="lnkBtnAdd" runat="server" OnClick="lnkBtnAdd_Click" CssClass="NewAddButton"
                                                    EnableTheming="false" Width="80px" Text="" Visible="false"></asp:Button>
                                            </asp:Panel>
                                        </div>
                                    </td>
                                    <%--<td style="width: 12%" align="center">
                                        Executive Name
                                    </td>--%>
                                    
                                    <td style="width: 15%; color: White;" align="right">
                                         Search
                                    </td>
                                    <td style="width: 20%" class="NewBox">
                                        <asp:TextBox ID="txtSearch" runat="server" SkinID="skinTxtBoxSearch"></asp:TextBox>
                                    </td>
                                    <td style="width: 20%" class="NewBox">
                                        <div style="width: 150px; font-family: 'Trebuchet MS';">
                                                    <asp:DropDownList ID="ddCriteria" runat="server" BackColor="White" Width="157px" Height="24px" style="text-align:center;border:1px solid White ">
                                                        <asp:ListItem Value="0">All</asp:ListItem>
                                                        <asp:ListItem Value="TaskCode">Task Code</asp:ListItem>
                                                        <asp:ListItem Value="TaskDate">Task Date</asp:ListItem>
                                                        <asp:ListItem Value="TaskName">Task Name</asp:ListItem>
                                                        <asp:ListItem Value="ProjectCode">Project Code</asp:ListItem>
                                                        <asp:ListItem Value="ProjectName">Project Name</asp:ListItem>
                                                    </asp:DropDownList>
                                                </div>
                                    </td>
                                    <td style="width: 20%" class="tblLeftNoPad">
                                        <asp:Button ID="btnSearch" runat="server" Text="" OnClick="btnSearch_Click"
                                            CssClass="ButtonSearch6" EnableTheming="false" />
                                    </td>
                                    <td style="width: 16%" class="tblLeftNoPad">
                                            <asp:Button ID="BtnClearFilter" runat="server" OnClick="BtnClearFilter_Click" EnableTheming="false" Text="" CssClass="ClearFilter6" />
                                        </td>
                                </tr>
                                <tr style="display: none">
                                    <td>
                                    </td>
                                    <td style="width: 25%" class="tblRight">
                                        Expected Work Start Date
                                    </td>
                                    <td style="width: 22%" class="cssTextBoxbgnew2">
                                        <asp:TextBox ID="txtStartDate" runat="server" CssClass="cssTextBox" Width="100px"
                                            MaxLength="10" />
                                        <script type="text/javascript" language="JavaScript">
                                            new tcal({ 'formname': 'aspnetForm', 'controlname': GettxtBoxName('txtStartDate') });
                                        </script>
                                    </td>
                                    <td style="width: 15%">
                                        Expected Work End Date
                                    </td>
                                    <td style="width: 22%" class="cssTextBoxbgnew2">
                                        <asp:TextBox ID="txtEndDate" runat="server" CssClass="cssTextBox" Width="100px" MaxLength="10" />
                                        <script type="text/javascript" language="JavaScript">
                                            new tcal({ 'formname': 'aspnetForm', 'controlname': GettxtBoxName('txtEndDate') });
                                        </script>
                                    </td>
                                    <td style="width: 10%">
                                    </td>
                                </tr>
                                <tr style="display: none">
                                    <td>
                                    </td>
                                    <td style="width: 25%" class="tblRight">
                                        Creation Date
                                    </td>
                                    <td style="width: 22%" class="cssTextBoxbgnew2">
                                        <asp:TextBox ID="txtsCreationDate" runat="server" CssClass="cssTextBox" Width="100px"
                                            MaxLength="10" />
                                        <script type="text/javascript" language="JavaScript">                                            new tcal({ 'formname': 'aspnetForm', 'controlname': GettxtBoxName('txtsCreationDate') });</script>
                                    </td>
                                    <td style="width: 15%">
                                        Status
                                    </td>
                                    <td style="width: 22%">
                                        <div style="border-width: 1px; border-color: #90c9fc; border-style: solid; width: 130px;
                                            font-family: 'Trebuchet MS';">
                                            <asp:DropDownList ID="drpsStatus" runat="server" Width="98%" CssClass="drpDownListMedium" BackColor = "#90c9fc"
                                                AppendDataBoundItems="True">
                                                <asp:ListItem Value="" style="background-color: #90c9fc">All Status</asp:ListItem>
                                                <asp:ListItem Value="Open">Open</asp:ListItem>
                                                <asp:ListItem Value="Resolved">Resolved</asp:ListItem>
                                                <asp:ListItem Value="Closed">Closed</asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </td>
                                    <td style="width: 10%; text-align: left">
                                    </td>
                                </tr>
                                <tr style="display: none">
                                    <td align="left" colspan="4">
                                        <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="txtStartDate"
                                            ControlToValidate="txtEndDate" Display="None" ErrorMessage="Start Date Should Be Less Than the End Date"
                                            CssClass="lblFont" Operator="GreaterThanEqual" SetFocusOnError="True" Type="Date"></asp:CompareValidator>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            
                <asp:HiddenField ID="hdTse" runat="server" Value="0" />
                <input id="dummy" type="button" style="display: none" runat="server" />
                <input id="Button1" type="button" style="display: none" runat="server" />
                <cc1:ModalPopupExtender ID="ModalPopupExtender1" runat="server" BackgroundCssClass="modalBackground"
                    CancelControlID="Button1" DynamicServicePath="" Enabled="True" PopupControlID="popUp"
                    TargetControlID="dummy">
                </cc1:ModalPopupExtender>
                <div class="alignLeft">
                    <asp:Panel runat="server" ID="popUp" Style="width: 60%; display: none">
                        <div id="contentPopUp">
                            <table class="tblLeft" cellpadding="0" cellspacing="0" style="border: 0px solid #5078B3;
                                background-color: #fff; color: #000;" width="100%">
                                <tr>
                                    <td>
                                        <div class="divArea">
                                            <table class="tblLeft" cellpadding="3" cellspacing="3" style="border: 1px solid #5078B3;"
                                                width="100%">
                                                <tr>
                                                    <td colspan="4">
                                                        <table class="headerPopUp" style="border: 1px solid #86b2d1" width="100%">
                                                            <tr>
                                                                <td>
                                                                    Task Updates
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <div style="text-align: left">
                                                            <cc1:TabContainer ID="tbMain" runat="server" Width="100%" Visible="false" CssClass="fancy fancy-green">
                                                                <cc1:TabPanel ID="tabInsRates" runat="server" HeaderText="Task Update">
                                                                    <ContentTemplate>
                                                                        <table style="width: 800px;" align="center" cellpadding="2" cellspacing="2">
                                                                            <tr>
                                                                                    <td class="ControlLabel" style="width: 20%">
                                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" Text="*" runat="server"
                                                                                            ControlToValidate="txtActualStartDate" ValidationGroup="Save" ErrorMessage="Actual Start Date is mandatory"></asp:RequiredFieldValidator>
                                                                                        <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToCompare="txtActualStartDate"
                                                                                            ControlToValidate="txtActualEndDate" Text="*" ErrorMessage="Start Date Should Be Less Than the End Date"
                                                                                            CssClass="lblFont" Operator="GreaterThanEqual" ValidationGroup="Save" SetFocusOnError="True"
                                                                                            Type="Date"></asp:CompareValidator>
                                                                                        <asp:CompareValidator ID="CompareValidator4" runat="server" ControlToCompare="TextBox1"
                                                                                            ControlToValidate="txtActualStartDate" Text="*" ErrorMessage="Start Date Should Be Greater Than the Task Date"
                                                                                            CssClass="lblFont" Operator="GreaterThanEqual" ValidationGroup="Save" SetFocusOnError="True"
                                                                                            Type="Date"></asp:CompareValidator>
                                                                                        Actual Start Date *
                                                                                    </td>
                                                                                    <td style="width: 25%" class="ControlTextBox3">
                                                                                        <asp:TextBox ID="txtActualStartDate" runat="server" CssClass="cssTextBox" Width="100px"
                                                                                            MaxLength="10" TabIndex="1"/>
                                                                                        <cc1:CalendarExtender ID="CalendarExtender1" runat="server" Animated="true" Format="dd/MM/yyyy"
                                                                                            PopupButtonID="ImageButton2" PopupPosition="BottomLeft" TargetControlID="txtActualStartDate">
                                                                                        </cc1:CalendarExtender>
                                                                                    </td>
                                                                                    <td style="width: 5%">
                                                                                        <asp:ImageButton ID="ImageButton2" ImageUrl="App_Themes/NewTheme/images/cal.gif"
                                                                                            CausesValidation="false" Width="20px" runat="server" TabIndex="7"/>
                                                                                    </td>
                                                                                    <td class="ControlLabel" style="width: 15%">
                                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator10" Text="*" runat="server"
                                                                                            ControlToValidate="txtActualEndDate" ValidationGroup="Save" ErrorMessage="Actual End Date is mandatory"></asp:RequiredFieldValidator>
                                                                                        Actual End Date *
                                                                                    </td>
                                                                                    <td style="width: 25%" class="ControlTextBox3">
                                                                                        <asp:TextBox ID="txtActualEndDate" runat="server" CssClass="cssTextBox" Width="100px"
                                                                                            MaxLength="10" TabIndex="2"/>
                                                                                        <cc1:CalendarExtender ID="CalendarExtender2" runat="server" Animated="true" Format="dd/MM/yyyy"
                                                                                            PopupButtonID="ImageButton3" PopupPosition="BottomLeft" TargetControlID="txtActualEndDate">
                                                                                        </cc1:CalendarExtender>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:ImageButton ID="ImageButton3" ImageUrl="App_Themes/NewTheme/images/cal.gif"
                                                                                            CausesValidation="false" Width="20px" runat="server" TabIndex="9" />
                                                                                    </td>
                                                                                </tr>    
                                                                            <tr style="height: 2px">
                                                                                    </tr>
                                                                            <tr>
                                                                                    <td style="width: 20%" class="ControlLabel">
                                                                                        <asp:RequiredFieldValidator ValidationGroup="Save" ID="RequiredFieldValidator11" runat="server"
                                                                                            Text="*" ErrorMessage="Percentage of completion is mandatory" ControlToValidate="txtPer"></asp:RequiredFieldValidator>
                                                                                        Percentage of completion *
                                                                                    </td>
                                                                                    <td style="width: 25%" class="ControlTextBox3">
                                                                                        <asp:TextBox ID="txtPer"  runat="server" SkinID="skinTxtBoxGrid"
                                                                                            TabIndex="2" />
                                                                                    </td>
                                                                                    <td style="width: 5%">
                                                                                        
                                                                                    </td>
                                                                                    <td class="ControlLabel" style="width: 15%">
                                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator12" Text="*" runat="server"
                                                                                            ControlToValidate="txtTaskUpdateDate" ValidationGroup="Save" ErrorMessage="Task Update Date is mandatory"></asp:RequiredFieldValidator>
                                                                                        Task Update Date *
                                                                                    </td>
                                                                                    <td style="width: 25%" class="ControlTextBox3">
                                                                                        <asp:TextBox ID="txtTaskUpdateDate" Width="100px" MaxLength="10" runat="server" Enabled="false" CssClass="cssTextBox" TabIndex="4" />
                                                                                        <cc1:CalendarExtender ID="CalendarExtender3" runat="server" Animated="true" Format="dd/MM/yyyy"
                                                                                            PopupButtonID="ImageButton4" PopupPosition="BottomLeft" TargetControlID="txtTaskUpdateDate">
                                                                                        </cc1:CalendarExtender>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:ImageButton ID="ImageButton4" ImageUrl="App_Themes/NewTheme/images/cal.gif" CausesValidation="false"
                                                                                            Width="20px" runat="server" TabIndex="3" Visible="false"/>
                                                                                    </td>
                                                                                </tr> 
                                                                            <tr style="height: 2px">
                                                                                    </tr>
                                                                            <tr>
                                                                                     <td style="width: 20%" class="ControlLabel">
                                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator13" InitialValue="0" Text="*"
                                                                                            ErrorMessage="Task Status is mandatory" runat="server" ControlToValidate="drpTaskStatus"
                                                                                            ValidationGroup="Save"></asp:RequiredFieldValidator>
                                                                                        Task Status *
                                                                                    </td>
                                                                                    <td style="width: 25%" class="ControlDrpBorder">
                                                                                        <asp:DropDownList ID="drpTaskStatus" TabIndex="5" Enabled="True" EnableTheming="false" AppendDataBoundItems="true" CssClass="drpDownListMedium"
                                                                                            runat="server" Width="100%" DataTextField="Task_Status_Name" backcolor = "#e7e7e7" style="border: 1px solid #e7e7e7" height="26px"
                                                                                            DataValueField="Task_Status_Id" >
                                                                                            <asp:ListItem Text="Select Task Status" Value="0"></asp:ListItem>
                                                                                        </asp:DropDownList>
                                                                                    </td>
                                                                                    <td style="width: 5%">
                                                                                        
                                                                                    </td>
                                                                                    <td style="width: 15%;" class="ControlLabel">
                                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator14" InitialValue="0" Text="*"
                                                                                            ErrorMessage="Blocked flag is mandatory" runat="server" ControlToValidate="drpBlockedflag"
                                                                                            ValidationGroup="Save"></asp:RequiredFieldValidator>
                                                                                        Blocked flag *
                                                                                    </td>
                                                                                    <td style="width: 25%;" class="ControlDrpBorder">
                                                                                        <asp:UpdatePanel ID="UpdatePanel15" runat="server" UpdateMode="Conditional">
                                                                                            <ContentTemplate>
                                                                                                <asp:DropDownList ID="drpBlockedflag" TabIndex="6" Enabled="True" EnableTheming="false" AppendDataBoundItems="true" CssClass="drpDownListMedium"
                                                                                                    runat="server" Width="100%" backcolor = "#e7e7e7" style="border: 1px solid #e7e7e7" height="26px" OnSelectedIndexChanged="drpBlockedflag_SelectedIndexChanged" AutoPostBack="True"
                                                                                                    >
                                                                                                    <asp:ListItem Text="No" Value="N"></asp:ListItem>
                                                                                                    <asp:ListItem Text="Yes" Value="Y"></asp:ListItem>
                                                                                                </asp:DropDownList>
                                                                                            </ContentTemplate>
                                                                                        </asp:UpdatePanel>
                                                                                    </td>
                                                                                </tr>
                                                                            <tr style="height: 2px">
                                                                                    </tr>
                                                                            <tr>
                                                                                    <td style="width: 20%" class="ControlLabel">
                                                                                        Blocking Reason
                                                                                    </td>
                                                                                    <td style="width: 25%" class="ControlTextBox3">
                                                                                        <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
                                                                                            <ContentTemplate>
                                                                                                <asp:TextBox ID="txtBlockingReason"  runat="server" SkinID="skinTxtBoxGrid"
                                                                                                    TabIndex="7" />
                                                                                            </ContentTemplate>
                                                                                          </asp:UpdatePanel>
                                                                                    </td>
                                                                                    <td style="width: 5%">
                                                                                        
                                                                                    </td>
                                                                                    <td class="ControlLabel" style="width: 15%">
                                                                                        Task update
                                                                                    </td>
                                                                                    <td style="width: 25%" class="ControlTextBox3">
                                                                                        <asp:TextBox ID="txtTaskupdate"  runat="server" SkinID="skinTxtBoxGrid"
                                                                                            TabIndex="8" />
                                                                                    </td>
                                                                                </tr>   
                                                                            <tr style="height: 2px">
                                                                                    </tr>
                                                                            <tr>
                                                                                     <td style="width: 20%" class="ControlLabel">
                                                                                        Task Date
                                                                                    </td>
                                                                                    <td style="width: 25%" class="ControlTextBox3">
                                                                                       <asp:TextBox ID="TextBox1" MaxLength="10" runat="server" CssClass="cssTextBox" Width="100px" Enabled="false" />
                                                                                    </td>
                                                                                    <td style="width: 5%">
                                                                                        
                                                                                    </td>
                                                                                    <td style="width: 15%;" class="ControlLabel">
                                                                                        
                                                                                    </td>
                                                                                    <td style="width: 25%;">
                                                                                        
                                                                                    </td>
                                                                                </tr> 
                                                                            <tr style="height: 2px">
                                                                                    </tr>
                                                                        </table>
                                                                    </ContentTemplate>
                                                                </cc1:TabPanel>
                                                                <cc1:TabPanel ID="tabMaster" runat="server" HeaderText="Task Details">
                                                                    <ContentTemplate>
                                                                         <table style="width: 800px;" align="center" cellpadding="2" cellspacing="2">
                                                                                <tr>
                                                                                    <td style="width: 20%" class="ControlLabel">
                                                                                        <asp:RequiredFieldValidator ValidationGroup="Save" ID="RequiredFieldValidator2" runat="server"
                                                                                            Text="*" ErrorMessage="Task ID is mandatory" ControlToValidate="txtTaskID"></asp:RequiredFieldValidator>
                                                                                        Task Code *
                                                                                    </td>
                                                                                    <td style="width: 25%" class="ControlTextBox3">
                                                                                        <asp:TextBox ID="txtTaskID"  runat="server" SkinID="skinTxtBoxGrid"
                                                                                            TabIndex="1" Enabled="false" />
                                                                                    </td>
                                                                                    <td style="width: 5%">
                                                                                        
                                                                                    </td>
                                                                                    <td class="ControlLabel" style="width: 15%">
                                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" Text="*" runat="server"
                                                                                            ControlToValidate="txtCDate" ValidationGroup="Save" ErrorMessage="Creation Date is mandatory"></asp:RequiredFieldValidator>
                                                                                        Task Date *
                                                                                    </td>
                                                                                    <td style="width: 25%" class="ControlTextBox3">
                                                                                        <asp:TextBox ID="txtCDate" Width="100px" MaxLength="10" runat="server" CssClass="cssTextBox" TabIndex="2"  Enabled="false"/>
                                                                                        <cc1:CalendarExtender ID="calCDate" runat="server" Animated="true" Format="dd/MM/yyyy"
                                                                                            PopupButtonID="btnCDate" PopupPosition="BottomLeft" TargetControlID="txtCDate">
                                                                                        </cc1:CalendarExtender>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:ImageButton ID="btnCDate" ImageUrl="App_Themes/NewTheme/images/cal.gif" CausesValidation="false"
                                                                                            Width="20px" runat="server" TabIndex="3" Visible="false"/>
                                                                                    </td>
                                                                                </tr>
                                                                             <tr style="height: 2px">
                                                                                    </tr>
                                                                                <tr>
                                                                                    <td style="width: 20%" class="ControlLabel">
                                                                                        <asp:RequiredFieldValidator ValidationGroup="Save" ID="RequiredFieldValidator8" runat="server"
                                                                                            Text="*" ErrorMessage="Task Name is mandatory" ControlToValidate="txtTaskID"></asp:RequiredFieldValidator>
                                                                                        Task Name *
                                                                                    </td>
                                                                                    <td style="width: 25%" class="ControlTextBox3">
                                                                                        <asp:TextBox ID="txtTaskName"  runat="server" SkinID="skinTxtBoxGrid" Enabled="false"
                                                                                            TabIndex="4" />
                                                                                    </td>
                                                                                    <td style="width: 5%">
                                                                                        
                                                                                    </td>
                                                                                    <td class="ControlLabel" style="width: 15%">
                                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator15" Text="*" runat="server"
                                                                                            ControlToValidate="drpIsActive" ValidationGroup="Save" ErrorMessage="Is Active is mandatory"></asp:RequiredFieldValidator>
                                                                                        Is Active *
                                                                                    </td>
                                                                                    <td style="width: 25%" class="ControlDrpBorder">
                                                                                        <asp:DropDownList ID="drpIsActive" TabIndex="5"  Enabled="false" EnableTheming="false" AppendDataBoundItems="true" CssClass="drpDownListMedium"
                                                                                            runat="server" Width="100%" backcolor = "#e7e7e7" style="border: 1px solid #e7e7e7" height="26px"
                                                                                            >
                                                                                            <asp:ListItem Text="Yes" Value="Y"></asp:ListItem>
                                                                                            <asp:ListItem Text="No" Value="N"></asp:ListItem>
                                                                                        </asp:DropDownList>
                                                                                    </td>
                                                                                </tr> 
                                                                            <tr style="height: 2px">
                                                                                    </tr>
                                                                                <tr>
                                                                                     <td style="width: 20%" class="ControlLabel">
                                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator6" InitialValue="0" Text="*"
                                                                                            ErrorMessage="Project Code is mandatory" runat="server" ControlToValidate="drpProjectCode"
                                                                                            ValidationGroup="Save"></asp:RequiredFieldValidator>
                                                                                        Project Name *
                                                                                    </td>
                                                                                    <td style="width: 25%" class="ControlDrpBorder">
                                                                                        <asp:DropDownList ID="drpProjectCode" TabIndex="5" EnableTheming="false" AppendDataBoundItems="true" CssClass="drpDownListMedium"
                                                                                            runat="server" Width="100%" DataTextField="Project_Name" backcolor = "#e7e7e7" style="border: 1px solid #e7e7e7" height="26px" Enabled="false"
                                                                                            DataValueField="Project_Id" >
                                                                                            <asp:ListItem Text="Select Project Name" Value="0"></asp:ListItem>
                                                                                        </asp:DropDownList>
                                                                                    </td>
                                                                                    <td style="width: 5%">
                                                                                        
                                                                                    </td>
                                                                                    <td style="width: 15%;" class="ControlLabel">
                                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" InitialValue="0" Text="*"
                                                                                            ErrorMessage="Project Manager is mandatory" runat="server" ControlToValidate="drpIncharge"
                                                                                            ValidationGroup="Save"></asp:RequiredFieldValidator>
                                                                                        Owner *
                                                                                    </td>
                                                                                    <td style="width: 25%;" class="ControlDrpBorder">
                                                                                        <asp:DropDownList ID="drpIncharge" TabIndex="5"  EnableTheming="false" AppendDataBoundItems="true" CssClass="drpDownListMedium"
                                                                                            runat="server" Width="100%" DataTextField="empFirstName" backcolor = "#e7e7e7" style="border: 1px solid #e7e7e7" height="26px" Enabled="false"
                                                                                            DataValueField="empno" >
                                                                                            <asp:ListItem Text="Select Owner" Value="0"></asp:ListItem>
                                                                                        </asp:DropDownList>
                                                                                    </td>
                                                                                    
                                                                                </tr>
                                                                             <tr style="height: 2px">
                                                                                    </tr>
                                                                             <tr>
                                                                                     <td style="width: 20%" class="ControlLabel">
                                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" InitialValue="0" Text="*"
                                                                                            ErrorMessage="Task Type is mandatory" runat="server" ControlToValidate="drpTaskType"
                                                                                            ValidationGroup="Save"></asp:RequiredFieldValidator>
                                                                                        Task Type *
                                                                                    </td>
                                                                                    <td style="width: 25%" class="ControlDrpBorder">
                                                                                        <asp:DropDownList ID="drpTaskType" TabIndex="5" EnableTheming="false" AppendDataBoundItems="true" CssClass="drpDownListMedium"
                                                                                            runat="server" Width="100%" DataTextField="Task_Type_Name" backcolor = "#e7e7e7" style="border: 1px solid #e7e7e7" height="26px" Enabled="false"
                                                                                            DataValueField="Task_Type_Id" >
                                                                                            <asp:ListItem Text="Select Task Type" Value="0"></asp:ListItem>
                                                                                        </asp:DropDownList>
                                                                                    </td>
                                                                                    <td style="width: 5%">
                                                                                        
                                                                                    </td>
                                                                                    <td style="width: 15%;" class="ControlLabel">
                                                                                        <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator9" InitialValue="0" Text="*"
                                                                                            ErrorMessage="Dependency Task is mandatory" runat="server" ControlToValidate="drpDependencyTask"
                                                                                            ValidationGroup="Save"></asp:RequiredFieldValidator>--%>
                                                                                        Dependency Task
                                                                                    </td>
                                                                                    <td style="width: 25%;" class="ControlDrpBorder">
                                                                                        <asp:DropDownList ID="drpDependencyTask" TabIndex="5"  EnableTheming="false" AppendDataBoundItems="true" CssClass="drpDownListMedium"
                                                                                            runat="server" Width="100%" DataTextField="TaskId" backcolor = "#e7e7e7" style="border: 1px solid #e7e7e7" height="26px" Enabled="false"
                                                                                            DataValueField="Task_Id" >
                                                                                            <asp:ListItem Text="Select Dependency Task" Value="0"></asp:ListItem>
                                                                                        </asp:DropDownList>
                                                                                    </td>
                                                                                    
                                                                                </tr>
                                                                            <tr style="height: 2px">
                                                                                    </tr>
                                                                                <tr>
                                                                                    <td class="ControlLabel" style="width: 20%">
                                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" Text="*" runat="server"
                                                                                            ControlToValidate="txtEWstartDate" ValidationGroup="Save" ErrorMessage="Expected Start Date is mandatory"></asp:RequiredFieldValidator>
                                                                                        <asp:CompareValidator ID="CompareValidator3" runat="server" ControlToCompare="txtEWstartDate"
                                                                                            ControlToValidate="txtEWEndDate" Text="*" ErrorMessage="Start Date Should Be Less Than the End Date"
                                                                                            CssClass="lblFont" Operator="GreaterThanEqual" ValidationGroup="Save" SetFocusOnError="True"
                                                                                            Type="Date"></asp:CompareValidator>
                                                                                        Expected Start Date *
                                                                                    </td>
                                                                                    <td style="width: 25%" class="ControlTextBox3">
                                                                                        <asp:TextBox ID="txtEWstartDate" runat="server" CssClass="cssTextBox" Width="100px"
                                                                                            MaxLength="10" TabIndex="6" Enabled="false"/>
                                                                                        <cc1:CalendarExtender ID="calEWstartDate" runat="server" Animated="true" Format="dd/MM/yyyy"
                                                                                            PopupButtonID="btnEWstartDate" PopupPosition="BottomLeft" TargetControlID="txtEWstartDate">
                                                                                        </cc1:CalendarExtender>
                                                                                    </td>
                                                                                    <td style="width: 5%">
                                                                                        <asp:ImageButton ID="btnEWstartDate" ImageUrl="App_Themes/NewTheme/images/cal.gif"
                                                                                            CausesValidation="false" Width="20px" runat="server" TabIndex="7" Visible="false"/>
                                                                                    </td>
                                                                                    <td class="ControlLabel" style="width: 15%">
                                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" Text="*" runat="server"
                                                                                            ControlToValidate="txtEWEndDate" ValidationGroup="Save" ErrorMessage="Expected End Date is mandatory"></asp:RequiredFieldValidator>
                                                                                        Expected End Date *
                                                                                    </td>
                                                                                    <td style="width: 25%" class="ControlTextBox3">
                                                                                        <asp:TextBox ID="txtEWEndDate" runat="server" CssClass="cssTextBox" Width="100px"
                                                                                            MaxLength="10" TabIndex="8" Enabled="false"/>
                                                                                        <cc1:CalendarExtender ID="CalEWEndDate" runat="server" Animated="true" Format="dd/MM/yyyy"
                                                                                            PopupButtonID="ImageButton1" PopupPosition="BottomLeft" TargetControlID="txtEWEndDate">
                                                                                        </cc1:CalendarExtender>
                                                                                    </td>
                                                                                    <td>
                                                                                        <asp:ImageButton ID="ImageButton1" ImageUrl="App_Themes/NewTheme/images/cal.gif"
                                                                                            CausesValidation="false" Width="20px" runat="server" TabIndex="9"  Visible="false"/>
                                                                                    </td>
                                                                                </tr>     
                                                                                <tr style="height: 2px">
                                                                                    </tr>
                                                                                <tr>
                                                                                    <td colspan="5">
                                                                                        <table style="width: 100%">
                                                                                            <tr>
                                                                                                <td style="width: 22%" class="ControlLabel">
                                                                                                    Task Description
                                                                                                </td>
                                                                                                <td style="width: 82%" class="ControlTextBox66">
                                                                                                    <asp:TextBox ID="txtTaskDesc" runat="server" SkinID="skinTxtBoxGrid" TabIndex="12"
                                                                                                         style="overflow: hidden; font-family: 'Trebuchet MS'; font-size: 13px; background-color:#e7e7e7" Enabled="false"  height="100px" TextMode="MultiLine"/>
                                                                                                </td>
                                                                                            </tr>
                                                                                        </table>
                                                                                    </td>
                                                                                    
                                                                                </tr>    
                                                                                   <tr style="height: 2px">
                                                                                    </tr>               
                                                                            </table>                                                                                                                                              
                                                                    </ContentTemplate>
                                                                </cc1:TabPanel>
                                                                <cc1:TabPanel ID="TabPanel1" runat="server" HeaderText="Task Update History">
                                                                    <ContentTemplate>
                                                                         <table style="width: 800px;" align="center" cellpadding="2" cellspacing="2">
                                                                             <tr style="width: 100%">
                                                                                <td>
                                                                                    <asp:GridView ID="GridView1" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                                        HeaderStyle-HorizontalAlign="Center" RowStyle-HorizontalAlign="Center" Width="100%" CssClass="someClass"
                                                                                        AllowPaging="True" OnPageIndexChanging="GridView1_PageIndexChanging" OnRowCreated="GridView1_RowCreated"
                                                                                        EmptyDataText="No Task History Details found."
                                                                                        >
                                                                                        <HeaderStyle Height="70px" Font-Bold="true" />
                                                                                        <Columns>
                                                                                            <asp:BoundField DataField="Task_Update_Date" HeaderText="Task Update Date" DataFormatString="{0:dd/MM/yyyy}"  HeaderStyle-BorderColor="Gray"/>
                                                                                            <asp:BoundField DataField="Actual_Start_Date" HeaderText="Actual Start Date" HeaderStyle-BorderColor="Gray"
                                                                                                DataFormatString="{0:dd/MM/yyyy}" />
                                                                                            <asp:BoundField DataField="Actual_End_Date" HeaderText="Actual end date" HeaderStyle-BorderColor="Gray"
                                                                                                DataFormatString="{0:dd/MM/yyyy}" />
                                                                                            <asp:BoundField DataField="Task_Status_Name" HeaderText="Task Status"  HeaderStyle-BorderColor="Gray"/>
                                                                                            <asp:BoundField DataField="Per_of_Completion" HeaderText="Per of Completion"  HeaderStyle-BorderColor="Gray"/>
                                                                                            <asp:BoundField DataField="Task_update" HeaderText="Task Updates"  HeaderStyle-BorderColor="Gray" />                        
                                                                                            <asp:BoundField DataField="Blocked_Flag" HeaderText="Blocked Flag"  HeaderStyle-BorderColor="Gray"/>
                                                                                            <asp:BoundField DataField="Blocking_Reason" HeaderText="Blocking Reason"  HeaderStyle-BorderColor="Gray"/>
                                                                                        </Columns>
                                                                                        <PagerTemplate>
                                                                                            <table style=" border-color:white">
                                                                                                <tr style=" border-color:white">
                                                                                                    <td style=" border-color:white">
                                                                                                        Goto Page
                                                                                                    </td>
                                                                                                    <td style=" border-color:white">
                                                                                                        <asp:DropDownList ID="ddlPageSelector" runat="server" AutoPostBack="true"  Width="65px" style="border:1px solid blue"
                                                                                                            OnSelectedIndexChanged="ddlPageSelector_SelectedIndexChanged">
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
                                                                                    </asp:GridView>
                                                                                </td>
                                                                             </tr>
                                                                         </table>
                                                                    </ContentTemplate>
                                                               </cc1:TabPanel>
                                                            </cc1:TabContainer>
                                                            <asp:Panel ID="pnsSave" runat="server" Visible="False">
                                                                <table style="width: 100%;" cellpadding="1" cellspacing="2">
                                                                    <tr>
                                                                        <td style="width: 25%;">

                                                                        </td>
                                                                        <td style="width: 25%;" align="right">                                                                            
                                                                            <asp:Button ID="btnSave" ValidationGroup="Save" runat="server" CssClass="savebutton1231"
                                                                                EnableTheming="false" SkinID="skinBtnSave" OnClick="btnSave_Click" />
                                                                            <asp:Button ID="btnUpdate" runat="server" ValidationGroup="Save" CssClass="Updatebutton1231"
                                                                                EnableTheming="false" SkinID="skinBtnSave" OnClick="btnUpdate_Click" Enabled="false" />
                                                                        </td>
                                                                        <td style="width: 25%;" align="left">
                                                                            <asp:Button ID="btnCancel" runat="server" CssClass="cancelbutton6" EnableTheming="false"
                                                                                SkinID="skinBtnCancel" OnClick="btnCancel_Click" Enabled="false" />
                                                                        </td>
                                                                        <td style="width: 25%;">

                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </asp:Panel>
                                                            <asp:ValidationSummary ID="valSum" DisplayMode="BulletList" ShowMessageBox="true"
                                                                ValidationGroup="Save" ShowSummary="false" HeaderText="Validation Messages" Font-Names="'Trebuchet MS'"
                                                                Font-Size="12" runat="server" />
                                                        </div>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </asp:Panel>
                </div>
                <table width="100%" style="margin: -2px 0px 0px 0px;">
                                <tr style="width: 100%">
                                    <td>
                                        <div style="margin: -1px 0px 0px 0px;">
                <asp:GridView ID="GrdWME" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                    HeaderStyle-HorizontalAlign="Center" RowStyle-HorizontalAlign="Center" Width="100%" CssClass="someClass"
                    AllowPaging="True" OnPageIndexChanging="GrdWME_PageIndexChanging" OnRowCreated="GrdWME_RowCreated"
                    DataKeyNames="Task_Id" EmptyDataText="No Task Details found." OnSelectedIndexChanged="GrdWME_SelectedIndexChanged"
                    >
                    <HeaderStyle Height="70px" Font-Bold="true" />
                    <Columns>
                        <asp:BoundField DataField="Task_Id" HeaderText="Task ID" HeaderStyle-Wrap="false"  HeaderStyle-BorderColor="Gray" Visible="false"/>
                        <asp:BoundField DataField="Task_Code" HeaderText="Task Code"  HeaderStyle-BorderColor="Gray" />
                        <asp:BoundField DataField="Task_Date" HeaderText="Task Date" DataFormatString="{0:dd/MM/yyyy}"  HeaderStyle-BorderColor="Gray"/>
                        <asp:BoundField DataField="Task_Name" HeaderText="Task Name"  HeaderStyle-BorderColor="Gray" />         
                        <asp:BoundField DataField="ProjectCode" HeaderText="Project Code"  HeaderStyle-BorderColor="Gray"/>
                        <asp:BoundField DataField="ProjectName" HeaderText="Project Name"  HeaderStyle-BorderColor="Gray"/>               
                        <asp:BoundField DataField="Expected_Start_Date" HeaderText="Expected Start Date" HeaderStyle-BorderColor="Gray"
                            DataFormatString="{0:dd/MM/yyyy}" />
                        <asp:BoundField DataField="Actual_Start_Date" HeaderText="Actual Start Date" HeaderStyle-BorderColor="Gray"
                            DataFormatString="{0:dd/MM/yyyy}" />
                        <asp:BoundField DataField="Expected_End_Date" HeaderText="Expected end date" HeaderStyle-BorderColor="Gray"
                            DataFormatString="{0:dd/MM/yyyy}" />
                        <asp:BoundField DataField="Actual_End_Date" HeaderText="Actual end date" HeaderStyle-BorderColor="Gray"
                            DataFormatString="{0:dd/MM/yyyy}" />
                        <asp:BoundField DataField="empfirstname" HeaderText="Owner"  HeaderStyle-BorderColor="Gray"/>
                        <asp:TemplateField ItemStyle-CssClass="command" HeaderStyle-Width="50px" HeaderText="Edit" HeaderStyle-BorderColor="Gray"
                            ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <asp:ImageButton ID="btnEdit" runat="server" SkinID="edit" CommandName="Select" />
                                <asp:ImageButton ID="btnEditDisabled" Enabled="false" SkinID="editDisable" runat="Server"></asp:ImageButton>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <%--<asp:TemplateField ItemStyle-CssClass="command" HeaderStyle-Width="50px" HeaderText="Delete" HeaderStyle-BorderColor="Gray"
                            ItemStyle-HorizontalAlign="Center">
                            <ItemTemplate>
                                <cc1:ConfirmButtonExtender ID="CnrfmDel" TargetControlID="lnkB" ConfirmText="Are you sure to Delete this Task Entry?"
                                    runat="server">
                                </cc1:ConfirmButtonExtender>
                                <asp:ImageButton ID="lnkB" SkinID="delete" runat="Server" CommandName="Delete"></asp:ImageButton>
                                <asp:ImageButton ID="lnkBDisabled" Enabled="false" SkinID="deleteDisable" runat="Server"></asp:ImageButton>
                            </ItemTemplate>
                        </asp:TemplateField>--%>
                    </Columns>
                    <PagerTemplate>
                        <table style=" border-color:white">
                            <tr style=" border-color:white">
                                <td style=" border-color:white">
                                    Goto Page
                                </td>
                                <td style=" border-color:white">
                                    <asp:DropDownList ID="ddlPageSelector" runat="server" AutoPostBack="true"  Width="65px" style="border:1px solid blue"
                                        OnSelectedIndexChanged="ddlPageSelector_SelectedIndexChanged">
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
                </asp:GridView>
                </div>
                </td>
                </tr>
                    <tr>
                    <td>
                        <table align="center" style="width:100%">
                            <tr>
                                <td  style="width:35%">
                        
                                </td>
                                <td style="width:15%">
                                  <%--  <asp:Button ID="cmdhistory" runat="server" Text="" EnableTheming="false" CausesValidation="False" cssclass="ShowHistory"  OnClientClick="window.open('ReportExcelTaskUpdatesHistory.aspx','billSummary', 'toolbar=no,status=no,menu=no,location=no,resizable=yes,height=310,width=500,left=425,top=220, scrollbars=yes');"/>    --%>
                                </td>
                                <td  style="width: 15%">
                                    <asp:Button ID="btnExportToExcel" runat="server" CssClass="exportexl6" OnClientClick="window.open('ReportExcelTaskUpdates.aspx','billSummary', 'toolbar=no,status=no,menu=no,location=no,resizable=yes,height=310,width=500,left=425,top=220, scrollbars=yes');"
                                                            EnableTheming="false"></asp:Button>
                                </td>
                                <td  style="width:30%">
                        
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                </table>
            </div>
            </td>
            </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
