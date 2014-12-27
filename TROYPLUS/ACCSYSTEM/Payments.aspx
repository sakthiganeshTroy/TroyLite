﻿<%@ Page Language="C#" MasterPageFile="~/PageMaster.master" AutoEventWireup="true"
    CodeFile="Payments.aspx.cs" Inherits="Payments" Title="Payments" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cplhTab" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cplhControlPanel" runat="Server">
    <script language="javascript" type="text/javascript">

function PrintItem(ID) 
{ 
  window.showModalDialog('./PrintPayment.aspx?ID=' + ID ,self,'dialogWidth:700px;dialogHeight:430px;status:no;dialogHide:yes;unadorned:yes;') ;
}


function AdvancedTest(id) 
{ 
       
       var panel = document.getElementById('ctl00_cplhControlPanel_frmViewAdd_tabEdit_tabEditMain_tblBank');   
       var adv = document.getElementById('ctl00_cplhControlPanel_hidAdvancedState') ; 
       var grd = document.getElementById("<%= frmViewAdd.ClientID %>");  
       
       var rdoArray = grd.getElementsByTagName("input");  
       
       
       for(i=0;i<=rdoArray.length-1;i++)  
        {  
            //alert(rdoArray[i].type);
            if(rdoArray[i].type == 'radio')
            {
                
                if( rdoArray[i].value == 'Cash' && rdoArray[i].checked == true)
                {
                    panel.className = "hidden" ; 
                    adv.value = panel.className ; 
                }
                else if (rdoArray[i].value == 'Cheque' && rdoArray[i].checked == true) 
                { 
                    panel.className = "AdvancedSearch" ; 
                    adv.value = panel.className ; 
                }        
                
            }
        }  

} 

function AdvancedAdd(id) 
{ 
       
       var panel = document.getElementById('ctl00_cplhControlPanel_frmViewAdd_tablInsert_tabInsMain_tblBankAdd');   
       var adv = document.getElementById('ctl00_cplhControlPanel_hidAdvancedState') ; 
       var grd = document.getElementById("<%= frmViewAdd.ClientID %>");  
       
       var rdoArray = grd.getElementsByTagName("input");  
       
       
       for(i=0;i<=rdoArray.length-1;i++)  
        {  
            //alert(rdoArray[i].type);
            if(rdoArray[i].type == 'radio')
            {
                
                if( rdoArray[i].value == 'Cash' && rdoArray[i].checked == true)
                {
                    panel.className = "hidden" ; 
                    adv.value = panel.className ; 
                }
                else if (rdoArray[i].value == 'Cheque' && rdoArray[i].checked == true) 
                { 
                    panel.className = "AdvancedSearch" ; 
                    adv.value = panel.className ; 
                }        
                
            }
        }  
} 

<!-- 
function Advanced() 
{ 
        var table = document.getElementById('tblBank'); 
        var adv = document.getElementById('ctl00_cplhControlPanel_hidAdvancedState') ; 
        
        var tr = table.getElementsByTagName('tr') ; 
        
        for (i = 0; i < tr.length; i++) 
        { 
                if (tr[i].className == "AdvancedSearch") 
                { 
                        tr[i].className = "hidden" ; 
                        adv.value = tr[i].className ; 
                } 
                else if (tr[i].className == "hidden") 
                { 
                        tr[i].className = "AdvancedSearch" ; 
                        adv.value = tr[i].className ; 
                }                               
        } 
} 
//--> 
    </script>
    <table style="width: 100%; vertical-align: top" align="center">
        <tr style="width: 100%">
            <td style="width: 100%">
                <cc1:Accordion ID="MyAccordion" runat="server" SelectedIndex="-1" HeaderCssClass="hdrSearch"
                    AutoSize="None" FadeTransitions="true" TransitionDuration="250" FramesPerSecond="40"
                    RequireOpenedPane="false" SuppressHeaderPostbacks="true">
                    <Panes>
                        <cc1:AccordionPane ID="AccordionPane1" HeaderCssClass="hdrSearch" HeaderSelectedCssClass="hdrSearch"
                            runat="server">
                            <Header>
                            </Header>
                            <Content>
                                <div class="mainConDiv">
                                    <div class="mainConHd">
                                        <table cellspacing="0" cellpadding="0" border="0">
                                            <tr valign="middle">
                                                <td>
                                                    <span>Search Payment </span>
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                    <div class="mainConBody">
                                        <div class="shadow1">
                                            &nbsp;
                                        </div>
                                        <div>
                                            <table cellspacing="0px" cellpadding="0px" border="0" width="100%" style="margin: 0px auto;">
                                                <tr style="height: 25px">
                                                    <td style="width: 25%">
                                                        Ref. No. / Pay To *
                                                        <asp:RequiredFieldValidator ID="rvSearch" runat="server" ControlToValidate="txtSearch"
                                                            Display="Dynamic" EnableClientScript="False" Enabled="false">Search is mandatory</asp:RequiredFieldValidator>
                                                    </td>
                                                    <td style="width: 25%">
                                                        <asp:TextBox ID="txtSearch" runat="server" SkinID="mobileTxtBox"></asp:TextBox>
                                                    </td>
                                                    <td style="width: 25%">
                                                        &nbsp;
                                                        <asp:DropDownList ID="ddCriteria" runat="server" CssClass="cssDropDown" Width="130px">
                                                            <asp:ListItem Value="0">-- All --</asp:ListItem>
                                                            <asp:ListItem Value="TransNo">Trans. No.</asp:ListItem>
                                                            <asp:ListItem Value="RefNo">Ref. No.</asp:ListItem>
                                                            <asp:ListItem Value="TransDate">Transaction Date</asp:ListItem>
                                                            <asp:ListItem Value="LedgerName">Paid To</asp:ListItem>
                                                            <asp:ListItem Value="Narration">Narration</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </td>
                                                    <td style="width: 25%">
                                                        <asp:Button ID="btnSearch" runat="server" Text="Search" SkinID="skinBtnSearch" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </div>
                                </div>
                            </Content>
                        </cc1:AccordionPane>
                    </Panes>
                </cc1:Accordion>
                <br />
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
                        <cc1:TabContainer ID="tabEdit" runat="server" Width="100%" CssClass="ajax__tab_yuitabview-theme"
                            ActiveTabIndex="0">
                            <cc1:TabPanel ID="tabEditMain" runat="server" HeaderText="Payment Details">
                                <ContentTemplate>
                                    <table style="width: 100%; vertical-align: text-top" align="center" cellpadding="3"
                                        cellspacing="3" style="border: 0px solid #86b2d1;">
                                        <tr>
                                            <td colspan="4">
                                            </td>
                                        </tr>
                                        <tr style="height: 30px" class="tblLeft">
                                            <td style="width: 25%" class="tblLeft">
                                                Ref. No. *
                                                <asp:RequiredFieldValidator ID="rvRefNo" runat="server" ControlToValidate="txtRefNo"
                                                    Text="*" ErrorMessage="Ref. No. is mandatory" CssClass="rfv" Display="Dynamic"
                                                    EnableClientScript="True"></asp:RequiredFieldValidator>
                                            </td>
                                            <td style="width: 25%">
                                                <asp:TextBox ID="txtRefNo" runat="server" Text='<%# Bind("RefNo") %>' SkinID="skinTxtBoxGrid"></asp:TextBox>
                                            </td>
                                            <td style="width: 25%" class="tblLeft">
                                                Date *
                                                <asp:RequiredFieldValidator ID="rvStock" runat="server" ControlToValidate="txtTransDate"
                                                    Text="*" ErrorMessage="Ref Date is mandatory" Display="Dynamic" EnableClientScript="True"></asp:RequiredFieldValidator>
                                                <asp:CompareValidator ControlToValidate="txtTransDate" Operator="DataTypeCheck" Type="Date"
                                                    Text="*" ErrorMessage="Please enter a valid date" runat="server" ID="cmpValtxtDate"></asp:CompareValidator>
                                                <asp:RangeValidator ID="myRangeValidator" runat="server" ControlToValidate="txtTransDate"
                                                    ErrorMessage="Payment date cannot be future date." Text="*" Type="Date"></asp:RangeValidator>
                                            </td>
                                            <td style="width: 25%">
                                                <asp:TextBox ID="txtTransDate" runat="server" Text='<%# Bind("TransDate","{0:dd/MM/yyyy}") %>'
                                                    CssClass="cssTextBox" Width="100px"></asp:TextBox>
                                                <script type="text/javascript" language="JavaScript">                                                    new tcal({ 'formname': 'aspnetForm', 'controlname': GettxtBoxName('txtTransDate') });</script>
                                            </td>
                                        </tr>
                                        <tr style="height: 30px" class="tblLeft">
                                            <td style="width: 25%" class="tblLeft">
                                                Paid To *
                                                <asp:CompareValidator ID="cvPayedTo" runat="server" ControlToValidate="ComboBox2"
                                                    Text="*" Display="Dynamic" EnableClientScript="True" ErrorMessage="Paid To is Mandatory"
                                                    Operator="GreaterThan" ValueToCompare="0"></asp:CompareValidator>
                                            </td>
                                            <td style="width: 25%">
                                                <asp:DropDownList ID="ComboBox2" runat="server" SkinID="skinDdlBox" AutoPostBack="False"
                                                    DataSourceID="srcCreditorDebitor" DataValueField="LedgerID" DataTextField="LedgerName"
                                                    AppendDataBoundItems="true" OnDataBound="ComboBox2_DataBound">
                                                    <asp:ListItem Text=" -- Please Select -- " Value="0"></asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                            <td style="width: 25%" class="tblLeft">
                                                Amount *
                                                <asp:RequiredFieldValidator ID="rvModel" runat="server" ControlToValidate="txtAmount"
                                                    ErrorMessage="Amount is mandatory" Display="Dynamic" EnableClientScript="True">*</asp:RequiredFieldValidator>
                                                <cc1:FilteredTextBoxExtender ID="fltAmt" runat="server" TargetControlID="txtAmount"
                                                    ValidChars="." FilterType="Numbers, Custom" />
                                            </td>
                                            <td style="width: 25%">
                                                <asp:TextBox ID="txtAmount" runat="server" Text='<%# Bind("Amount") %>' Width="100%"
                                                    SkinID="skinTxtBoxGrid"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr style="height: 30px" class="tblLeft">
                                            <td style="width: 25%; height: 34px;" class="tblLeft">
                                                Payment Made By *
                                                <asp:RequiredFieldValidator ID="rvBDate" runat="server" ControlToValidate="chkPayTo"
                                                    Display="Dynamic" EnableClientScript="True" ErrorMessage="Item Name is mandatory.">*</asp:RequiredFieldValidator>
                                            </td>
                                            <td style="width: 25%; height: 34px;">
                                                <asp:RadioButtonList ID="chkPayTo" onclick="javascript:AdvancedTest(this.id);" runat="server"
                                                    AutoPostBack="false" Width="100%" OnDataBound="chkPayTo_DataBound" OnSelectedIndexChanged="chkPayTo_SelectedIndexChanged">
                                                    <asp:ListItem Text="Cash" Selected="true"></asp:ListItem>
                                                    <asp:ListItem Text="Cheque"></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </td>
                                            <td style="width: 25%" class="tblLeft">
                                                Narration *
                                                <asp:RequiredFieldValidator ID="rvNarration" runat="server" ControlToValidate="txtNarration"
                                                    ErrorMessage="Narration is mandatory" Display="Dynamic" EnableClientScript="True">*</asp:RequiredFieldValidator>
                                            </td>
                                            <td style="width: 25%">
                                                <asp:TextBox ID="txtNarration" runat="server" Height="30px" TextMode="MultiLine"
                                                    Text='<%# Bind("Narration") %>' SkinID="skinTxtBoxGrid"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="4" width="100%">
                                                <asp:Panel ID="PanelBank" runat="server">
                                                    <table width="100%" id="tblBank" cellpadding="0" cellspacing="0" runat="server">
                                                        <tr>
                                                            <td style="width: 25%;" class="tblLeft">
                                                                Bank Name *
                                                                <asp:CompareValidator ID="cvBank" runat="server" ControlToValidate="ddBanks"
                                                                    Display="Dynamic" EnableClientScript="false" ErrorMessage="Phase is Mandatory"
                                                                    Operator="GreaterThan" ValueToCompare="0">*</asp:CompareValidator>
                                                            </td>
                                                            <td style="width: 25%">
                                                                <asp:DropDownList ID="ddBanks" runat="server" OnDataBound="ddBanks_DataBound" DataSourceID="srcBanks"
                                                                    DataTextField="LedgerName" DataValueField="LedgerID" AppendDataBoundItems="True"
                                                                    SkinID="skinDdlBox">
                                                                    <asp:ListItem Selected="True" Value="0">-- Please Select --</asp:ListItem>
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td style="width: 25%" class="tblLeft">
                                                                Cheque No. *
                                                                <asp:RequiredFieldValidator ID="rvChequeNo" runat="server" ControlToValidate="txtChequeNo"
                                                                    ErrorMessage="Cheque No. is mandatory" Display="Dynamic" EnableClientScript="false">*</asp:RequiredFieldValidator>
                                                            </td>
                                                            <td style="width: 25%;" class="tblLeftNoPad">
                                                                <asp:TextBox ID="txtChequeNo" runat="server" Text='<%# Bind("ChequeNo") %>' SkinID="skinTxtBoxGrid"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </asp:Panel>
                                            </td>
                                        </tr>
                                        <tr style="height: 30px" class="tblLeft">
                                            <td align="left" style="width: 25%" valign="bottom" colspan="2">
                                                <table cellspacing="0">
                                                    <tr width="100%">
                                                        <td style="width: 67px">
                                                            <asp:Button ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                                                                SkinID="skinBtnCancel" Text="Cancel" OnClick="UpdateCancelButton_Click"></asp:Button>
                                                        </td>
                                                        <td>
                                                        </td>
                                                        <td>
                                                            <asp:Button ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
                                                                SkinID="skinBtnSave" Text="Update" OnClick="UpdateButton_Click"></asp:Button>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td style="width: 25%">
                                                <asp:ObjectDataSource ID="srcBanks" runat="server" SelectMethod="ListBanks" TypeName="BusinessLogic">
                                                    <SelectParameters>
                                                        <asp:CookieParameter Name="connection" CookieName="Company" Type="String" />
                                                    </SelectParameters>
                                                </asp:ObjectDataSource>
                                            </td>
                                            <td style="width: 25%">
                                                <asp:ObjectDataSource ID="srcCreditorDebitor" runat="server" SelectMethod="ListCreditorDebitor"
                                                    TypeName="BusinessLogic">
                                                    <SelectParameters>
                                                        <asp:CookieParameter Name="connection" CookieName="Company" Type="String" />
                                                    </SelectParameters>
                                                </asp:ObjectDataSource>
                                            </td>
                                        </tr>
                                    </table>
                                </ContentTemplate>
                            </cc1:TabPanel>
                            <cc1:TabPanel ID="tabEditAddTab" runat="server" HeaderText="Additional Details">
                                <ContentTemplate>
                                    <table align="center" cellpadding="3" cellspacing="5" style="border: 0px solid #5078B3;
                                        width: 100%;">
                                        <tr style="height: 30px" class="tblLeft">
                                            <td style="width: 25%" class="tblLeft">
                                                Against Bill No.
                                            </td>
                                            <td style="width: 25%">
                                                <asp:TextBox ID="txtBill" runat="server" Text='<%# Bind("BillNo") %>' SkinID="skinTxtBoxGrid"></asp:TextBox>
                                            </td>
                                            <td style="width: 25%">
                                            </td>
                                            <td style="width: 25%">
                                            </td>
                                        </tr>
                                    </table>
                                </ContentTemplate>
                            </cc1:TabPanel>
                        </cc1:TabContainer>
                        <asp:ValidationSummary ID="valSum" DisplayMode="BulletList" ShowMessageBox="true"
                            ShowSummary="false" HeaderText="Validation Messages" Font-Names="'Trebuchet MS'"
                            Font-Size="12" runat="server" />
                    </EditItemTemplate>
                    <FooterTemplate>
                    </FooterTemplate>
                    <InsertItemTemplate>
                        <cc1:TabContainer ID="tablInsert" runat="server" Width="100%" CssClass="ajax__tab_yuitabview-theme"
                            ActiveTabIndex="0">
                            <cc1:TabPanel ID="tabInsMain" runat="server" HeaderText="Payment Details">
                                <ContentTemplate>
                                    <table style="width: 100%; vertical-align: text-top" align="center" cellpadding="3"
                                        cellspacing="3" style="border: 0px solid #86b2d1;">
                                        <tr>
                                            <td colspan="4">
                                            </td>
                                        </tr>
                                        <tr style="height: 30px" class="tblLeft">
                                            <td style="width: 25%" class="tblLeft">
                                                Ref. No. *
                                                <asp:RequiredFieldValidator ID="rvRefNoAdd" runat="server" ControlToValidate="txtRefNoAdd"
                                                    ErrorMessage="Ref. No. is mandatory" Display="Dynamic" EnableClientScript="True">*</asp:RequiredFieldValidator>
                                            </td>
                                            <td style="width: 25%">
                                                <asp:TextBox ID="txtRefNoAdd" runat="server" Text='<%# Bind("RefNo") %>' SkinID="skinTxtBoxGrid"></asp:TextBox>
                                            </td>
                                            <td style="width: 25%" class="tblLeft">
                                                Date *
                                                <asp:RequiredFieldValidator ID="rvStockAdd" runat="server" ControlToValidate="txtTransDateAdd"
                                                    ErrorMessage="Trasaction Date is mandatory" Display="Dynamic" EnableClientScript="True">*</asp:RequiredFieldValidator>
                                                <asp:CompareValidator ControlToValidate="txtTransDateAdd" Operator="DataTypeCheck"
                                                    Type="Date" ErrorMessage="Please enter a valid date" runat="server" ID="cmpValtxtDateAdd">*</asp:CompareValidator>
                                                <asp:RangeValidator ID="myRangeValidatorAdd" runat="server" ControlToValidate="txtTransDateAdd"
                                                    ErrorMessage="Payment date cannot be future date." Text="*" Type="Date"></asp:RangeValidator>
                                            </td>
                                            <td style="width: 25%">
                                                <asp:TextBox ID="txtTransDateAdd" runat="server" Text='<%# Bind("TransDate","{0:dd/MM/yyyy}") %>'
                                                    CssClass="cssTextBox" Width="100px"></asp:TextBox>
                                                <script type="text/javascript" language="JavaScript">                                                    new tcal({ 'formname': 'aspnetForm', 'controlname': GettxtBoxName('txtTransDateAdd') });</script>
                                            </td>
                                        </tr>
                                        <tr style="height: 30px" class="tblLeft">
                                            <td style="width: 25%" class="tblLeft">
                                                Paid To *
                                                <asp:CompareValidator ID="cvPayedToAdd" runat="server" ControlToValidate="ComboBox2Add"
                                                    Display="Dynamic" EnableClientScript="True" ErrorMessage="Paid To is Mandatory"
                                                    Operator="GreaterThan" ValueToCompare="0">*</asp:CompareValidator>
                                            </td>
                                            <td style="width: 25%">
                                                <asp:DropDownList ID="ComboBox2Add" runat="server" SkinID="skinDdlBox" AutoPostBack="False"
                                                    DataSourceID="srcCreditorDebitorAdd" DataValueField="LedgerID" DataTextField="LedgerName"
                                                    AppendDataBoundItems="true">
                                                    <asp:ListItem Text=" -- Please Select -- " Value="0"></asp:ListItem>
                                                </asp:DropDownList>
                                            </td>
                                            <td style="width: 25%" class="tblLeft">
                                                Amount *
                                                <asp:RequiredFieldValidator ID="rvModelAdd" runat="server" ControlToValidate="txtAmountAdd"
                                                    ErrorMessage="Amount is mandatory" Display="Dynamic" EnableClientScript="True">*</asp:RequiredFieldValidator>
                                                <cc1:FilteredTextBoxExtender ID="fltAmtAdd" runat="server" TargetControlID="txtAmountAdd"
                                                    ValidChars="." FilterType="Numbers, Custom" />
                                            </td>
                                            <td style="width: 25%">
                                                <asp:TextBox ID="txtAmountAdd" runat="server" Text='<%# Bind("Amount") %>' SkinID="skinTxtBoxGrid"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr class="tblLeft">
                                            <td style="width: 25%;" class="tblLeft">
                                                Payment Made By *
                                                <asp:RequiredFieldValidator ID="rvBDateAdd" runat="server" ControlToValidate="chkPayToAdd"
                                                    Display="Dynamic" EnableClientScript="True" ErrorMessage="Item Name is mandatory.">*</asp:RequiredFieldValidator>
                                            </td>
                                            <td style="width: 25%">
                                                <asp:RadioButtonList ID="chkPayToAdd" runat="server" OnDataBound="chkPayToAdd_DataBound"
                                                    onclick="javascript:AdvancedAdd(this.id);" AutoPostBack="false" Width="100%"
                                                    OnSelectedIndexChanged="chkPayToAdd_SelectedIndexChanged">
                                                    <asp:ListItem Text="Cash" Selected="true"></asp:ListItem>
                                                    <asp:ListItem Text="Cheque"></asp:ListItem>
                                                </asp:RadioButtonList>
                                            </td>
                                            <td style="width: 25%" class="tblLeft">
                                                Narration *
                                                <asp:RequiredFieldValidator ID="rvNarrationAdd" runat="server" ControlToValidate="txtNarrationAdd"
                                                    ErrorMessage="Narration is mandatory" Display="Dynamic" EnableClientScript="True">*</asp:RequiredFieldValidator>
                                            </td>
                                            <td colspan="3" style="width: 25%">
                                                <asp:TextBox ID="txtNarrationAdd" runat="server" Height="30px" TextMode="MultiLine"
                                                    Text='<%# Bind("Narration") %>' SkinID="skinTxtBoxGrid"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <td colspan="4" width="100%">
                                            <asp:Panel ID="PanelBankAdd" runat="server">
                                                <table width="100%" id="tblBankAdd" cellpadding="0" cellspacing="0" runat="server">
                                                    <tr>
                                                        <td style="width: 25%;" class="tblLeft">
                                                            Bank Name *
                                                            <asp:CompareValidator ID="cvBankAdd" runat="server" ControlToValidate="ddBanksAdd"
                                                                Display="Dynamic" EnableClientScript="false" ErrorMessage="Bank is Mandatory"
                                                                Operator="GreaterThan" ValueToCompare="0">*</asp:CompareValidator>
                                                        </td>
                                                        <td style="width: 25%;">
                                                            <asp:DropDownList ID="ddBanksAdd" runat="server" SelectedValue='<%# Bind("CreditorID") %>'
                                                                SkinID="skinDdlBox" DataSourceID="srcBanksAdd" DataTextField="LedgerName" DataValueField="LedgerID"
                                                                AppendDataBoundItems="True">
                                                                <asp:ListItem Selected="True" Value="0">-- Please Select --</asp:ListItem>
                                                            </asp:DropDownList>
                                                        </td>
                                                        <td style="width: 25%" class="tblLeft">
                                                            Cheque No. *
                                                            <asp:RequiredFieldValidator ID="rvChequeNoAdd" runat="server" ControlToValidate="txtChequeNoAdd"
                                                                ErrorMessage="Cheque No. is mandatory" Display="Dynamic" EnableClientScript="false">*</asp:RequiredFieldValidator>
                                                        </td>
                                                        <td style="width: 25%;" class="tblLeftNoPad">
                                                            <asp:TextBox ID="txtChequeNoAdd" runat="server" Text='<%# Bind("ChequeNo") %>' SkinID="skinTxtBoxGrid"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                        </td>
                                        <tr style="height: 30px" class="tblLeft">
                                            <td align="left" style="width: 50%" colspan="2">
                                                <table cellspacing="0" cellpadding="0">
                                                    <tr width="100%">
                                                        <td style="height: 26px">
                                                            <asp:Button ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                                                                SkinID="skinBtnCancel" Text="Cancel" OnClick="InsertCancelButton_Click"></asp:Button>
                                                        </td>
                                                        <td style="height: 26px">
                                                        </td>
                                                        <td style="height: 26px">
                                                            <asp:Button ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert"
                                                                SkinID="skinBtnSave" Text="Save" OnClick="InsertButton_Click"></asp:Button>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                            <td style="width: 25%">
                                                <asp:ObjectDataSource ID="srcCreditorDebitorAdd" runat="server" SelectMethod="ListCreditorDebitor"
                                                    TypeName="BusinessLogic">
                                                    <SelectParameters>
                                                        <asp:CookieParameter Name="connection" CookieName="Company" Type="String" />
                                                    </SelectParameters>
                                                </asp:ObjectDataSource>
                                            </td>
                                            <td style="width: 25%">
                                                <asp:ObjectDataSource ID="srcBanksAdd" runat="server" SelectMethod="ListBanks" TypeName="BusinessLogic">
                                                    <SelectParameters>
                                                        <asp:CookieParameter Name="connection" CookieName="Company" Type="String" />
                                                    </SelectParameters>
                                                </asp:ObjectDataSource>
                                            </td>
                                        </tr>
                                    </table>
                                </ContentTemplate>
                            </cc1:TabPanel>
                            <cc1:TabPanel ID="tabInsAddTab" runat="server" HeaderText="Additional Details">
                                <ContentTemplate>
                                    <table align="center" cellpadding="3" cellspacing="5" style="border: 0px solid #5078B3;
                                        width: 100%;">
                                        <tr style="height: 30px" class="tblLeft">
                                            <td style="width: 25%" class="tblLeft">
                                                Against Bill No.
                                            </td>
                                            <td style="width: 25%">
                                                <asp:TextBox ID="txtBillAdd" runat="server" Text='<%# Bind("BillNo") %>' SkinID="skinTxtBoxGrid"></asp:TextBox>
                                            </td>
                                            <td style="width: 25%">
                                            </td>
                                            <td style="width: 25%">
                                            </td>
                                        </tr>
                                    </table>
                                </ContentTemplate>
                            </cc1:TabPanel>
                        </cc1:TabContainer>
                        <asp:ValidationSummary ID="valSum" DisplayMode="BulletList" ShowMessageBox="true"
                            ShowSummary="false" HeaderText="Validation Messages" Font-Names="'Trebuchet MS'"
                            Font-Size="12" runat="server" />
                    </InsertItemTemplate>
                </asp:FormView>
            </td>
        </tr>
        <tr style="width: 100%" class="tblLeft">
            <td style="width: 100%">
                <asp:Button ID="lnkBtnAdd" runat="server" SkinID="skinBtnAddNew" OnClick="lnkBtnAdd_Click">
                </asp:Button>
            </td>
        </tr>
        <tr style="width: 100%">
            <td style="width: 100%">
                <br />
                <div class="mainGridHold" id="searchGrid">
                    <asp:GridView ID="GrdViewPayment" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                        OnRowCreated="GrdViewPayment_RowCreated" Width="100%" DataSourceID="GridSource"
                        AllowPaging="True" DataKeyNames="TransNo" EmptyDataText="No Payments found!"
                        OnRowCommand="GrdViewPayment_RowCommand" OnRowDataBound="GrdViewPayment_RowDataBound"
                        OnSelectedIndexChanged="GrdViewPayment_SelectedIndexChanged" OnRowDeleting="GrdViewPayment_RowDeleting"
                        OnRowDeleted="GrdViewPayment_RowDeleted">
                        <EmptyDataRowStyle CssClass="GrdContent" />
                        <Columns>
                            <asp:BoundField DataField="TransNo" HeaderStyle-Wrap="false" HeaderText="Trans. No." />
                            <asp:BoundField DataField="RefNo" HeaderStyle-Wrap="false" HeaderText="Ref. No." />
                            <asp:BoundField DataField="TransDate" HeaderStyle-Wrap="false" HeaderText="Trans. Date"
                                DataFormatString="{0:dd/MM/yyyy}" />
                            <asp:BoundField DataField="Debi" HeaderText="Paid To" HeaderStyle-Wrap="false" />
                            <asp:BoundField DataField="LedgerName" HeaderText="Bank Name / Cash" HeaderStyle-Wrap="false" />
                            <asp:BoundField DataField="Amount" HeaderText="Amount" HeaderStyle-Wrap="false" />
                            <asp:BoundField DataField="Narration" HeaderText="Narration" HeaderStyle-Wrap="false" />
                            <asp:TemplateField ItemStyle-CssClass="command" HeaderStyle-Width="25px">
                                <ItemTemplate>
                                    <asp:ImageButton ID="btnEdit" runat="server" SkinID="edit" CommandName="Select" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField ItemStyle-CssClass="command" HeaderStyle-Width="25px">
                                <ItemTemplate>
                                    <cc1:ConfirmButtonExtender ID="CnrfmDel" TargetControlID="lnkB" ConfirmText="Are you sure to Delete this Payment?"
                                        runat="server">
                                    </cc1:ConfirmButtonExtender>
                                    <asp:ImageButton ID="lnkB" SkinID="delete" runat="Server" CommandName="Delete"></asp:ImageButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderStyle-Width="25px">
                                <ItemTemplate>
                                    <a href='<%# DataBinder.Eval(Container, "DataItem.TransNo", "javascript:PrintItem({0});") %>'>
                                        <img alt="Print" border="0" src="App_Themes/DefaultTheme/Images/Print.png">
                                    </a>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField Visible="false">
                                <ItemTemplate>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <PagerTemplate>
                            <table>
                                <tr>
                                    <td>
                                        Goto Page
                                    </td>
                                    <td>
                                        <asp:DropDownList ID="ddlPageSelector" runat="server" AutoPostBack="true" SkinID="skinPagerDdlBox2">
                                        </asp:DropDownList>
                                    </td>
                                    <td style="Width:5px">
                                            
                                    </td>
                                    <td>
                                        <asp:Button Text="" CommandName="Page" CommandArgument="First" runat="server" CssClass="NewFirst" EnableTheming="false" Width="22px" Height="18px"
                                            ID="btnFirst" />
                                    </td>
                                    <td>
                                        <asp:Button Text="" CommandName="Page" CommandArgument="Prev" runat="server" CssClass="NewPrev" EnableTheming="false" Width="22px" Height="18px"
                                            ID="btnPrevious" />
                                    </td>
                                    <td>
                                        <asp:Button Text="" CommandName="Page" CommandArgument="Next" runat="server" CssClass="NewNext" EnableTheming="false" Width="22px" Height="18px"
                                            ID="btnNext" />
                                    </td>
                                    <td>
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
        <tr width="100%">
            <td style="width: 918px" align="left">
                <asp:ObjectDataSource ID="GridSource" runat="server" SelectMethod="ListPayments"
                    TypeName="BusinessLogic" DeleteMethod="DeletePayment" OnDeleting="GridSource_Deleting">
                    <DeleteParameters>
                        <asp:CookieParameter Name="connection" CookieName="Company" Type="String" />
                        <asp:Parameter Name="TransNo" Type="Int32" />
                        <asp:Parameter Name="requireValidation" Type="Boolean" DefaultValue="true" />
                    </DeleteParameters>
                </asp:ObjectDataSource>
                <asp:ObjectDataSource ID="frmSource" runat="server" SelectMethod="GetPaymentForId"
                    TypeName="BusinessLogic" InsertMethod="InsertPayment" OnUpdating="frmSource_Updating"
                    OnInserting="frmSource_Inserting" UpdateMethod="UpdatePayment" OnInserted="frmSource_Inserted"
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
                        <asp:Parameter Name="Billno" Type="String" />
                        <asp:Parameter Name="NewTransNo" Type="Int32" Direction="Output" />
                    </UpdateParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="GrdViewPayment" Name="TransNo" PropertyName="SelectedValue"
                            Type="Int32" />
                        <asp:CookieParameter CookieName="Company" Type="String" Name="connection" />
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
                        <asp:Parameter Name="PaymentMode" Type="String" />
                        <asp:Parameter Name="NewTransNo" Type="Int32" Direction="Output" />
                    </InsertParameters>
                </asp:ObjectDataSource>
            </td>
        </tr>
        <tr>
            <td style="width: 100%">
                <asp:HiddenField ID="hdPayment" runat="server" />
            </td>
        </tr>
    </table>
    <input type="hidden" id="hidAdvancedState" runat="server" />
    <br />
</asp:Content>
