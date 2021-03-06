﻿using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Text;
using SMSLibrary;

public partial class CustReceipt : System.Web.UI.Page
{
    Double sumAmt = 0.0;
    public string sDataSource = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            sDataSource = ConfigurationManager.ConnectionStrings[Request.Cookies["Company"].Value].ToString();
            if (!Page.IsPostBack)
            {
                string connStr = string.Empty;

                if (Request.Cookies["Company"] != null)
                    connStr = System.Configuration.ConfigurationManager.ConnectionStrings[Request.Cookies["Company"].Value].ToString();
                else
                    Response.Redirect("~/Login.aspx");

                CheckSMSRequired();

                

                ddReceivedFrom.DataBind();

                GrdViewReceipt.PageSize = 11;

                string dbfileName = connStr.Remove(0, connStr.LastIndexOf(@"App_Data\") + 9);
                dbfileName = dbfileName.Remove(dbfileName.LastIndexOf(";Persist Security Info"));
                BusinessLogic objChk = new BusinessLogic();

                if (objChk.CheckForOffline(Server.MapPath("Offline\\" + dbfileName + ".offline")))
                {
                    lnkBtnAdd.Visible = false;
                    GrdViewReceipt.Columns[8].Visible = false;
                    GrdViewReceipt.Columns[7].Visible = false;
                }

                if (Session["SMSREQUIRED"] != null)
                {
                    if (Session["SMSREQUIRED"].ToString() == "NO")
                        hdSMSRequired.Value = "NO";
                    else
                        hdSMSRequired.Value = "YES";
                }
                else
                {
                    hdSMSRequired.Value = "NO";
                }

                if (Session["EMAILREQUIRED"] != null)
                {
                    if (Session["EMAILREQUIRED"].ToString() == "NO")
                        hdEmailRequired.Value = "NO";
                    else
                        hdEmailRequired.Value = "YES";
                }
                else
                {
                    hdEmailRequired.Value = "NO";
                }

                string connection = Request.Cookies["Company"].Value;
                string usernam = Request.Cookies["LoggedUserName"].Value;
                BusinessLogic bl = new BusinessLogic(sDataSource);

                if (bl.CheckUserHaveAdd(usernam, "CUSTRCT"))
                {
                    lnkBtnAdd.Enabled = false;
                    lnkBtnAdd.ToolTip = "You are not allowed to make Add New ";
                }
                else
                {
                    lnkBtnAdd.Enabled = true;
                    lnkBtnAdd.ToolTip = "Click to Add New ";
                }


                pnlEdit.Visible = false;
                //myRangeValidator.MinimumValue = System.DateTime.Now.AddYears(-100).ToShortDateString();
                //myRangeValidator.MaximumValue = System.DateTime.Now.ToShortDateString();

            }
        }
        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }
    }

    bool IsFutureDate(DateTime refDate)
    {
        DateTime today = DateTime.Today;
        return (refDate.Date != today) && (refDate > today);
    }

    protected void txtDate_TextChanged(object sender, EventArgs e)
    {

    }

    protected void BtnClearFilter_Click(object sender, EventArgs e)
    {
        txtSearch.Text = "";
       
        ddCriteria.SelectedIndex = 0;
    }

    protected void chkcash_CheckedChanged(object sender, EventArgs e)
    {
        DataSet ds = new DataSet();

        DataTable dt = new DataTable();
        DataColumn dc;
        DataRow drNew;
        div.Visible = true;

        if (chkcash.Checked == false)
        {
            if (Session["Ds"] == null)
            {
            }
            else
            {
                DataSet dst = (DataSet)Session["Ds"];
                if (dst != null)
                {
                    if (dst.Tables.Count > 0)
                    {
                        for (int i = 0; i < dst.Tables[0].Rows.Count; i++)
                        {
                            if (dst.Tables[0].Rows[i]["Type"].ToString() == "Cash")
                            {
                                dst.Tables[0].Rows[i].Delete();
                            }
                        }
                        // GrdViewItems.DataSource = dst;
                        //GrdViewItems.DataBind();
                    }
                }
            }
        }
        else
        {
            if (Session["Ds"] == null)
            {
               
                dc = new DataColumn("Type");
                dt.Columns.Add(dc);

                dc = new DataColumn("RefNo");
                dt.Columns.Add(dc);

                dc = new DataColumn("Amount");
                dt.Columns.Add(dc);

                dc = new DataColumn("ChequeNo");
                dt.Columns.Add(dc);

                dc = new DataColumn("Narration");
                dt.Columns.Add(dc);

                ds.Tables.Add(dt);

                drNew = dt.NewRow();


                drNew["Type"] = "Cash";
                drNew["RefNo"] = "";
                drNew["Amount"] = "";
                drNew["ChequeNo"] = "";
                drNew["Narration"] = "";
                
                ds.Tables[0].Rows.Add(drNew);
                Session["Ds"] = ds;

            }
            else
            {
                ds = (DataSet)Session["Ds"];
                drNew = ds.Tables[0].NewRow();

                drNew["Type"] = "Cash";
                drNew["RefNo"] = "";
                drNew["Amount"] = "";
                drNew["ChequeNo"] = "";
                drNew["Narration"] = "";

                ds.Tables[0].Rows.Add(drNew);

            }

            //cmdSaveProduct.Visible = true;
            //cmdUpdateProduct.Visible = false;
            //cmdCancelProduct.Visible = false;
            //GrdViewItems.DataSource = ds;
            //GrdViewItems.DataBind();

            //for (int vLoop = 0; vLoop < GrdViewItems.Rows.Count; vLoop++)
            //{
            //    Label txtttd = (Label)GrdViewItems.Rows[vLoop].FindControl("txtType");
            //    if(txtttd.Text == "Cash")
            //    {

            //    }
            //}

        }
        //UpdatePanel21.Update();
    }

    protected void chkcheque_CheckedChanged(object sender, EventArgs e)
    {
        DataSet ds = new DataSet();

        DataTable dt = new DataTable();
        DataColumn dc;
        DataRow drNew;
        div.Visible = true;

        if (chkcheque.Checked == false)
        {
            if (Session["Ds"] == null)
            {

            }
            else
            {
                DataSet dst = (DataSet)Session["Ds"];
                if(dst != null)
                {
                    if (dst.Tables.Count > 0)
                    {
                        for (int i = 0; i < dst.Tables[0].Rows.Count; i++)
                        {
                            if (dst.Tables[0].Rows[i]["Type"].ToString() == "Cheque")
                            {
                                dst.Tables[0].Rows[i].Delete();
                            }
                        }
                        //GrdViewItems.DataSource = dst;
                        //GrdViewItems.DataBind();
                    }
                }
               
            }
        }
        else
        {
            if (Session["Ds"] == null)
            {

                dc = new DataColumn("Type");
                dt.Columns.Add(dc);

                dc = new DataColumn("RefNo");
                dt.Columns.Add(dc);

                dc = new DataColumn("Amount");
                dt.Columns.Add(dc);

                dc = new DataColumn("ChequeNo");
                dt.Columns.Add(dc);

                dc = new DataColumn("Narration");
                dt.Columns.Add(dc);

                ds.Tables.Add(dt);

                drNew = dt.NewRow();


                drNew["Type"] = "Cheque";
                drNew["RefNo"] = "";
                drNew["Amount"] = "";
                drNew["ChequeNo"] = "";
                drNew["Narration"] = "";

                ds.Tables[0].Rows.Add(drNew);
                Session["Ds"] = ds;

            }
            else
            {
                ds = (DataSet)Session["Ds"];
                drNew = ds.Tables[0].NewRow();

                drNew["Type"] = "Cheque";
                drNew["RefNo"] = "";
                drNew["Amount"] = "";
                drNew["ChequeNo"] = "";
                drNew["Narration"] = "";

                ds.Tables[0].Rows.Add(drNew);

            }

            //cmdSaveProduct.Visible = true;
            //cmdUpdateProduct.Visible = false;
            //cmdCancelProduct.Visible = false;
            //GrdViewItems.DataSource = ds;
            //GrdViewItems.DataBind();
        }
        //UpdatePanel21.Update();
    }

    protected void chkcard_CheckedChanged(object sender, EventArgs e)
    {
        DataSet ds = new DataSet();

        DataTable dt = new DataTable();
        DataColumn dc;
        DataRow drNew;

        div.Visible = true;

        if (chkcard.Checked == false)
        {
            if (Session["Ds"] == null)
            {
            }
            else
            {
                DataSet dst = (DataSet)Session["Ds"];
                if (dst != null)
                {
                    if (dst.Tables.Count > 0)
                    {
                        for (int i = 0; i < dst.Tables[0].Rows.Count; i++)
                        {
                            if (dst.Tables[0].Rows[i]["Type"].ToString() == "Card")
                            {
                                dst.Tables[0].Rows[i].Delete();
                            }
                        }
                        //GrdViewItems.DataSource = dst;
                        //GrdViewItems.DataBind();
                    }
                }
            }
        }
        else
        {
            if (Session["Ds"] == null)
            {

                dc = new DataColumn("Type");
                dt.Columns.Add(dc);

                dc = new DataColumn("RefNo");
                dt.Columns.Add(dc);

                dc = new DataColumn("Amount");
                dt.Columns.Add(dc);

                dc = new DataColumn("ChequeNo");
                dt.Columns.Add(dc);

                dc = new DataColumn("Narration");
                dt.Columns.Add(dc);

                ds.Tables.Add(dt);

                drNew = dt.NewRow();


                drNew["Type"] = "Card";
                drNew["RefNo"] = "";
                drNew["Amount"] = "";
                drNew["ChequeNo"] = "";
                drNew["Narration"] = "";

                ds.Tables[0].Rows.Add(drNew);
                Session["Ds"] = ds;

            }
            else
            {
                ds = (DataSet)Session["Ds"];
                drNew = ds.Tables[0].NewRow();

                drNew["Type"] = "Card";
                drNew["RefNo"] = "";
                drNew["Amount"] = "";
                drNew["ChequeNo"] = "";
                drNew["Narration"] = "";

                ds.Tables[0].Rows.Add(drNew);

            }

            //cmdSaveProduct.Visible = true;
            //cmdUpdateProduct.Visible = false;
            //cmdCancelProduct.Visible = false;
            //GrdViewItems.DataSource = ds;
            //GrdViewItems.DataBind();
        }
        //UpdatePanel21.Update();
    }

    protected void txtTransDate_TextChanged(object sender, EventArgs e)
    {
        try
        {
            string refDate = string.Empty;
            refDate = txtTransDate.Text;
            ViewState.Add("TransDate", refDate);

            if (IsFutureDate(Convert.ToDateTime(refDate)))
            {
                hddatecheck.Value = "1";
                UP1.Update();
                return;
            }
            else
            {
                hddatecheck.Value = "0";
                UP1.Update();
            }
        }
        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }
    }

    private void ShowPendingBills()
    {
        string connStr = string.Empty;

        if (Request.Cookies["Company"] != null)
            connStr = System.Configuration.ConfigurationManager.ConnectionStrings[Request.Cookies["Company"].Value].ToString();
        else
            Response.Redirect("~/Login.aspx");

        BusinessLogic bl = new BusinessLogic();
        var customerID = ddReceivedFrom.SelectedValue.Trim();

        var dsSales = bl.ListCreditSales(connStr.Trim(), customerID);

        var receivedData = bl.GetCustReceivedAmount(connStr);

        if (dsSales != null)
        {

            foreach (DataRow dr in receivedData.Tables[0].Rows)
            {
                var billNo = dr["BillNo"].ToString();
                var billAmount = dr["TotalAmount"].ToString();

                for (int i = 0; i < dsSales.Tables[0].Rows.Count; i++)
                {
                    if (billNo.Trim() == dsSales.Tables[0].Rows[i]["BillNo"].ToString())
                    {
                        dsSales.Tables[0].Rows[i].BeginEdit();
                        double val = (double.Parse(dsSales.Tables[0].Rows[i]["PendingAmount"].ToString()) - double.Parse(billAmount));
                        dsSales.Tables[0].Rows[i]["PendingAmount"] = val;
                        dsSales.Tables[0].Rows[i].EndEdit();

                        if (val == 0.0)
                            dsSales.Tables[0].Rows[i].Delete();
                    }
                }
                dsSales.Tables[0].AcceptChanges();
            }

        }
        GrdViewSales.DataSource = dsSales;
        GrdViewSales.DataBind();

        //if (dsSales != null)
        //{
        //    hdPendingCount.Value = dsSales.Tables[0].Rows.Count.ToString();
        //}

    }

    private void ShowPendingBillsAuto()
    {
        string connStr = string.Empty;

        if (Request.Cookies["Company"] != null)
            connStr = System.Configuration.ConfigurationManager.ConnectionStrings[Request.Cookies["Company"].Value].ToString();
        else
            Response.Redirect("~/Login.aspx");

        BusinessLogic bl = new BusinessLogic();
        var customerID = drpLedger.SelectedValue.Trim();

        var dsSales = bl.ListCreditSales(connStr.Trim(), customerID);

        var receivedData = bl.GetCustReceivedAmount(connStr);

        if (dsSales != null)
        {

            foreach (DataRow dr in receivedData.Tables[0].Rows)
            {
                var billNo = dr["BillNo"].ToString();
                var billAmount = dr["TotalAmount"].ToString();

                for (int i = 0; i < dsSales.Tables[0].Rows.Count; i++)
                {
                    if (billNo.Trim() == dsSales.Tables[0].Rows[i]["BillNo"].ToString())
                    {
                        dsSales.Tables[0].Rows[i].BeginEdit();
                        double val = (double.Parse(dsSales.Tables[0].Rows[i]["PendingAmount"].ToString()) - double.Parse(billAmount));
                        dsSales.Tables[0].Rows[i]["PendingAmount"] = val;
                        dsSales.Tables[0].Rows[i].EndEdit();

                        if (val == 0.0)
                            dsSales.Tables[0].Rows[i].Delete();
                    }
                }
                dsSales.Tables[0].AcceptChanges();
            }

        }

        if (dsSales != null && dsSales.Tables[0].Rows.Count > 0)
        {
            DataTable dttt;
            DataRow drNew;
            DataColumn dct;
            DataSet dstd = new DataSet();
            dttt = new DataTable();

            dct = new DataColumn("Billno");
            dttt.Columns.Add(dct);

            dct = new DataColumn("Row");
            dttt.Columns.Add(dct);

            dct = new DataColumn("CustomerName");
            dttt.Columns.Add(dct);

            dct = new DataColumn("Amount");
            dttt.Columns.Add(dct);

            dct = new DataColumn("BillDate");
            dttt.Columns.Add(dct);

            dct = new DataColumn("PendingAmount");
            dttt.Columns.Add(dct);

            dct = new DataColumn("AdjustAmount");
            dttt.Columns.Add(dct);

            dct = new DataColumn("Completed");
            dttt.Columns.Add(dct);

            dct = new DataColumn("Amount1");
            dttt.Columns.Add(dct);

            dstd.Tables.Add(dttt);

            int sno = 1;
            if (dsSales != null)
            {
                if (dsSales.Tables[0].Rows.Count > 0)
                {
                    for (int i = 0; i < dsSales.Tables[0].Rows.Count; i++)
                    {
                        drNew = dttt.NewRow();
                        drNew["Row"] = sno;
                        drNew["Billno"] = Convert.ToInt32(dsSales.Tables[0].Rows[i]["Billno"]);
                        drNew["CustomerName"] = Convert.ToString(dsSales.Tables[0].Rows[i]["CustomerName"]);
                        drNew["PendingAmount"] = Convert.ToDouble(dsSales.Tables[0].Rows[i]["PendingAmount"]);
                        drNew["Amount"] = Convert.ToDouble(dsSales.Tables[0].Rows[i]["BillAmount"]);
                        string dtaa = Convert.ToDateTime(dsSales.Tables[0].Rows[i]["BillDate"]).ToString("dd/MM/yyyy");

                        drNew["BillDate"] = dtaa;
                        drNew["AdjustAmount"] = 0;
                        drNew["Amount1"] = 0;
                        drNew["Completed"] = "N";
                        dstd.Tables[0].Rows.Add(drNew);
                        sno = sno + 1;
                    }
                }
            }

            GridView1.DataSource = dstd;
            GridView1.DataBind();
        }
        else
        {
            GridView1.DataSource = null;
            GridView1.DataBind();
        }


        Panel4.Visible = true;
        //if (dsSales != null)
        //{
        //    hdPendingCount.Value = dsSales.Tables[0].Rows.Count.ToString();
        //}

    }

    protected void btnrec_Click(object sender, EventArgs e)
    {
        try
        {
            string CustRec = "CustRec";
            Response.Write("<script language='javascript'> window.open('ReportExcelReceipts.aspx?ID=" + CustRec + "' , 'window','toolbar=no,status=no,menu=no,location=no,height=320,width=700,left=320,top=220 ,resizable=yes, scrollbars=yes');</script>");
        }
        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }
    }

    private void loadBanks()
    {
        BusinessLogic bl = new BusinessLogic(sDataSource);
        DataSet ds = new DataSet();
        //ds = bl.ListBanks();

        ddBanks.Items.Clear();
        ListItem lifzzh = new ListItem("Select Bank", "0");
        lifzzh.Attributes.Add("style", "color:Black");
        ddBanks.Items.Add(lifzzh);
        ds = bl.ListBankLedgerpaymnetIsActive();
        ddBanks.DataSource = ds;
        ddBanks.DataTextField = "LedgerName";
        ddBanks.DataValueField = "LedgerID";
        ddBanks.DataBind();
    }

    private void loadBanksEdit()
    {
        BusinessLogic bl = new BusinessLogic(sDataSource);
        DataSet ds = new DataSet();
        //ds = bl.ListBanks();

        ddBanks.Items.Clear();
        ListItem lifzzh = new ListItem("Select Bank", "0");
        lifzzh.Attributes.Add("style", "color:Black");
        ddBanks.Items.Add(lifzzh);
        ds = bl.ListBankLedgerpaymnet();
        ddBanks.DataSource = ds;
        ddBanks.DataTextField = "LedgerName";
        ddBanks.DataValueField = "LedgerID";
        ddBanks.DataBind();
    }

    private void checkPendingBills(DataSet ds)
    {
        foreach (GridViewRow tt in GrdViewSales.Rows)
        {
            if (tt.RowType == DataControlRowType.DataRow)
            {
                string billNo = tt.Cells[0].Text;

                bool exists = false;

                if (ds != null)
                {
                    foreach (DataRow d in ds.Tables[0].Rows)
                    {
                        string bNo = d[1].ToString();

                        if (bNo == billNo)
                        {
                            exists = true;
                        }

                    }
                }

                if (!exists)
                {
                    hdPendingCount.Value = "1";
                    UpdatePanelPage.Update();
                    return;
                }

            }
        }

        hdPendingCount.Value = "0";
        UpdatePanelPage.Update();
    }

    private void CheckSMSRequired()
    {
        DataSet appSettings;
        string smsRequired = string.Empty;
        string emailRequired = string.Empty;

        if (Session["AppSettings"] != null)
        {
            appSettings = (DataSet)Session["AppSettings"];

            for (int i = 0; i < appSettings.Tables[0].Rows.Count; i++)
            {
                if (appSettings.Tables[0].Rows[i]["KEY"].ToString() == "SMSREQ")
                {
                    smsRequired = appSettings.Tables[0].Rows[i]["KEYVALUE"].ToString();
                    Session["SMSREQUIRED"] = smsRequired.Trim().ToUpper();
                }
                if (appSettings.Tables[0].Rows[i]["KEY"].ToString() == "EMAILREQ")
                {
                    emailRequired = appSettings.Tables[0].Rows[i]["KEYVALUE"].ToString();
                    Session["EMAILREQUIRED"] = emailRequired.Trim().ToUpper();
                }

                if (appSettings.Tables[0].Rows[i]["KEY"].ToString() == "OWNERMOB")
                {
                    Session["OWNERMOB"] = appSettings.Tables[0].Rows[i]["KEYVALUE"].ToString();
                }

            }
        }
        else
        {
            BusinessLogic bl = new BusinessLogic();
            DataSet ds = bl.GetAppSettings(Request.Cookies["Company"].Value);

            if (ds != null)
                Session["AppSettings"] = ds;

            appSettings = (DataSet)Session["AppSettings"];

            for (int i = 0; i < appSettings.Tables[0].Rows.Count; i++)
            {
                if (appSettings.Tables[0].Rows[i]["KEY"].ToString() == "SMSREQ")
                {
                    smsRequired = appSettings.Tables[0].Rows[i]["KEYVALUE"].ToString();
                    Session["SMSREQUIRED"] = smsRequired.Trim().ToUpper();
                }
                if (appSettings.Tables[0].Rows[i]["KEY"].ToString() == "EMAILREQ")
                {
                    emailRequired = appSettings.Tables[0].Rows[i]["KEYVALUE"].ToString();
                    Session["EMAILREQUIRED"] = emailRequired.Trim().ToUpper();
                }

                if (appSettings.Tables[0].Rows[i]["KEY"].ToString() == "OWNERMOB")
                {
                    Session["OWNERMOB"] = appSettings.Tables[0].Rows[i]["KEYVALUE"].ToString();
                }

            }
        }
    }

    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);
        //TextBox search = (TextBox)Accordion1.FindControl("txtSearch");
        GridSource.SelectParameters.Add(new CookieParameter("connection", "Company"));
        //DropDownList dropDown = (DropDownList)Accordion1.FindControl("ddCriteria");
        GridSource.SelectParameters.Add(new ControlParameter("txtSearch", TypeCode.String, txtSearch.UniqueID, "Text"));
        GridSource.SelectParameters.Add(new ControlParameter("dropDown", TypeCode.String, ddCriteria.UniqueID, "SelectedValue"));
    }

    protected void GrdViewReceipt_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Select")
        {
            /*//MyAccordion.Visible = false;
            frmViewAdd.Visible = true;
            frmViewAdd.DataBind();
            frmViewAdd.ChangeMode(FormViewMode.Edit);
            //GrdViewReceipt.Columns[7].Visible = false;
            lnkBtnAdd.Visible = false;
            GrdViewReceipt.Visible = false;
            //if (frmViewAdd.CurrentMode == FormViewMode.Edit)
                //Accordion1.SelectedIndex = 1;*/
        }
    }

    protected void GrdViewReceipt_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            GridViewRow Row = GrdViewReceipt.SelectedRow;
            string connection = Request.Cookies["Company"].Value;
            BusinessLogic bl = new BusinessLogic();
            string recondate = Row.Cells[2].Text;
            Session["BillData"] = null;
            //hd.Value = Convert.ToString(GrdViewReceipt.SelectedDataKey.Value);
            loadBanksEdit();

           
            connection = Request.Cookies["Company"].Value;
            DataSet dsd = new DataSet();
            dsd = bl.ListCusCategory(connection);
            drpCustomerCategoryAdd.Items.Clear();
            drpCustomerCategoryAdd.Items.Add(new ListItem("Select Customer Category", "0"));
            drpCustomerCategoryAdd.DataSource = dsd;
            drpCustomerCategoryAdd.DataBind();
            drpCustomerCategoryAdd.DataTextField = "CusCategory_Name";
            drpCustomerCategoryAdd.DataValueField = "CusCategory_Value";


            if (!bl.IsValidDate(connection, Convert.ToDateTime(recondate)))
            {
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('Date is invalid')", true);
                return;
            }
            else
            {
                //pnlEdit.Visible = true;
                DataSet ds = bl.GetReceiptForId(connection, int.Parse(GrdViewReceipt.SelectedDataKey.Value.ToString()));
                if (ds != null)
                {
                    txtRefNo.Text = ds.Tables[0].Rows[0]["RefNo"].ToString();
                    txtTransDate.Text = DateTime.Parse(ds.Tables[0].Rows[0]["TransDate"].ToString()).ToShortDateString();

                    ddReceivedFrom.SelectedValue = ds.Tables[0].Rows[0]["CreditorID"].ToString();
                    txtAmount.Text = ds.Tables[0].Rows[0]["Amount"].ToString();
                    txtMobile.Text = ds.Tables[0].Rows[0]["Mobile"].ToString();
                    chkPayTo.SelectedValue = ds.Tables[0].Rows[0]["paymode"].ToString();
                    txtNarration.Text = ds.Tables[0].Rows[0]["Narration"].ToString();
                    if (chkPayTo.SelectedItem != null)
                    {
                        if (chkPayTo.SelectedItem.Text == "Cheque")
                        {
                            tblBank.Attributes.Add("class", "AdvancedSearch");
                        }
                        else
                        {
                            tblBank.Attributes.Add("class", "hidden");
                        }
                    }
                    else
                    {
                        tblBank.Attributes.Add("class", "hidden");
                    }

                    txtChequeNo.Text = ds.Tables[0].Rows[0]["ChequeNo"].ToString();

                    string creditorID = ds.Tables[0].Rows[0]["DebtorID"].ToString();

                    ddBanks.ClearSelection();

                    ListItem li = ddBanks.Items.FindByValue(creditorID);
                    if (li != null) li.Selected = true;

                    DataSet billsData = bl.GetReceivedAmountId(connection, int.Parse(GrdViewReceipt.SelectedDataKey.Value.ToString()));

                    Session["BillData"] = billsData;

                    if (billsData.Tables[0].Rows[0]["BillNo"].ToString() == "0")
                    {
                        billsData = null;
                    }
                    GrdBills.DataSource = billsData;
                    GrdBills.DataBind();
                    Session["RMode"] = "Edit";
                    ShowPendingBillsAuto();
                    checkPendingBills(billsData);
                }

                //GrdViewReceipt.Visible = false;
                ////MyAccordion.Visible = false;
                //lnkBtnAdd.Visible = false;
                pnlEdit.Visible = true;
                Panel3.Visible = false;
                UpdateButton.Visible = true;
                SaveButton.Visible = false;
                ModalPopupExtender2.Show();
                ModalPopupExtender3.Hide();
            }
        }
        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }
    }

    protected void GrdBillsCancelEdit(object sender, GridViewCancelEditEventArgs e)
    {
        GrdBills.EditIndex = -1;
        if (Session["BillData"] != null)
        {
            GrdBills.DataSource = (DataSet)Session["BillData"];
            GrdBills.DataBind();
            checkPendingBills((DataSet)Session["BillData"]);
        }
    }

    protected void lnkAddBills_Click(object sender, EventArgs e)
    {
        try
        {
            pnlEdit.Visible = false;
            BusinessLogic bl = new BusinessLogic();
            string conn = GetConnectionString();
            ModalPopupExtender2.Show();
            pnlEdit.Visible = true;
            if (txtAmount.Text == "")
            {

                //ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('Please enter the Receipt Amount before Adding BillNo')", true);
                //CnrfmDel.ConfirmText = "Please enter the Receipt Amount before Adding BillNo";
                //CnrfmDel.TargetControlID = "lnkAddBills";
                txtAmount.Focus();
                return;
            }

            if (ddReceivedFrom.SelectedValue == "0")
            {
                //ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('Please Select the Customer before Adding Bills')", true);
                //pnlEdit.Visible = true;
                txtAmount.Focus();
                return;
            }

            if (GrdBills.Rows.Count == 0)
            {
                var ds = bl.GetReceivedAmountId(conn, -1);
                GrdBills.DataSource = ds;
                GrdBills.DataBind();
                GrdBills.Rows[0].Visible = false;
                checkPendingBills(ds);
            }
            pnlEdit.Visible = true;
            GrdBills.FooterRow.Visible = true;
            lnkAddBills.Visible = true;
            Session["RMode"] = "Add";
            //lnkBtnAdd.Visible = false;
        }
        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }
    }

    protected void UpdateCancelButton_Click(object sender, EventArgs e)
    {
        try
        {
            //MyAccordion.Visible = true;
            pnlEdit.Visible = false;
            ModalPopupExtender2.Hide();
            //lnkBtnAdd.Visible = true;
            //lnkAddBills.Visible = true;
            GrdViewReceipt.Visible = true;
            GrdViewReceipt.Columns[8].Visible = true;
            ClearPanel();

        }
        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }
    }


    protected void GrdViewReceipt_RowCreated(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.Pager)
            {
                PresentationUtils.SetPagerButtonStates(GrdViewReceipt, e.Row, this);
            }
        }
        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }
    }

    protected void ddlPageSelector_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            GrdViewSales.PageIndex = ((DropDownList)sender).SelectedIndex;

            ModalPopupExtender1.Show();
            ShowPendingBills();
        }
        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }
    }

    protected void GrdViewSales_RowCreated(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.Pager)
            {
                PresentationUtils.SetPagerButtonStates(GrdViewSales, e.Row, this);
            }
        }
        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }
    }

    protected void GrdViewSales_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            
        }
    }

    protected void GrdViewSales_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            GrdViewSales.PageIndex = e.NewPageIndex;

            ShowPendingBills();
            ModalPopupExtender1.Show();
        }
        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }
    }

    protected void GrdViewReceipt_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            GridView gridView = (GridView)sender;

            if (e.Row.RowType == DataControlRowType.Header)
            {
                int cellIndex = -1;

                foreach (DataControlField field in gridView.Columns)
                {
                    if (field.SortExpression == gridView.SortExpression)
                    {
                        cellIndex = gridView.Columns.IndexOf(field);
                    }
                    else if (field.SortExpression != "")
                    {
                        e.Row.Cells[gridView.Columns.IndexOf(field)].CssClass = "headerstyle";
                    }

                }

                if (cellIndex > -1)
                {
                    //  this is a header row,
                    //  set the sort style
                    e.Row.Cells[cellIndex].CssClass =
                        gridView.SortDirection == SortDirection.Ascending
                        ? "sortascheaderstyle" : "sortdescheaderstyle";
                }




            }

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                BusinessLogic bl = new BusinessLogic(sDataSource);
                string connection = Request.Cookies["Company"].Value;
                string usernam = Request.Cookies["LoggedUserName"].Value;

                if (bl.CheckUserHaveEdit(usernam, "CUSTRCT"))
                {
                    ((ImageButton)e.Row.FindControl("btnEdit")).Visible = false;
                    ((ImageButton)e.Row.FindControl("btnEditDisabled")).Visible = true;
                }

                if (bl.CheckUserHaveDelete(usernam, "CUSTRCT"))
                {
                    ((ImageButton)e.Row.FindControl("lnkB")).Visible = false;
                    ((ImageButton)e.Row.FindControl("lnkBDisabled")).Visible = true;
                }

                if (bl.CheckUserHaveView(usernam, "CUSTRCT"))
                {
                    ((Image)e.Row.FindControl("lnkprint")).Visible = false;
                    ((ImageButton)e.Row.FindControl("btnViewDisabled")).Visible = true;
                }
                else
                {
                    ((ImageButton)e.Row.FindControl("btnViewDisabled")).Visible = false;
                }
            }
        }
        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }
    }

    protected void lnkBtnAdd_Click(object sender, EventArgs e)
    {
        try
        {
            //if (!Helper.IsLicenced(Request.Cookies["Company"].Value))
            //{
            //    ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('This is Trial Version, Please upgrade to Full Version of this Software. Thank You.');", true);
            //    return;
            //}
            ModalPopupExtender2.Show();
            ModalPopupExtender3.Show();
            pnlEdit.Visible = false;
            Panel3.Visible = true;
            Session["Ds"] = null;
            //lnkBtnAdd.Visible = false;
            ////MyAccordion.Visible = false;
            //GrdViewReceipt.Visible = false;
            UpdateButton.Visible = false;
            SaveButton.Visible = false;
            ClearPanel();
            ShowPendingBillsAuto();

            chk.Enabled = false;

            FirstGridViewRow1();

            Panel4.Visible = true;
            loadBanks();
            drpLedger.SelectedIndex = 0;

            drpReceiptType.SelectedValue = "1";

            //txtTransDate.Text = DateTime.Now.ToShortDateString();

            DateTime indianStd = TimeZoneInfo.ConvertTimeBySystemTimeZoneId(DateTime.Now, "India Standard Time");
            string dtaa = Convert.ToDateTime(indianStd).ToString("dd/MM/yyyy");
            txtTransDate.Text = dtaa;
            txtDate.Text = dtaa;

            chkcard.Checked = false;
            chkcash.Checked = false;
            chkcheque.Checked = false;

            txtAddress.ReadOnly = true;
            txtAddress2.ReadOnly = true;
            txtAddress3.ReadOnly = true;

            //drpLedger.Focus();
            chkPayTo.SelectedValue = "Cash";
            div.Visible = true;
            Panel4.Visible = false;
            if (chkPayTo.SelectedItem != null)
            {
                if (chkPayTo.SelectedItem.Text == "Cheque")
                {
                    tblBank.Attributes.Add("class", "AdvancedSearch");
                }
                else
                {
                    tblBank.Attributes.Add("class", "hidden");
                }
            }
            else
            {
                if (tblBank != null)
                    tblBank.Attributes.Add("class", "hidden");
            }

            //Button clickedbutton = (Button)sender;
            //clickedbutton.Enabled = true;

            BusinessLogic bl = new BusinessLogic(sDataSource);
            string connection = string.Empty;
            connection = Request.Cookies["Company"].Value;
            DataSet dsd = new DataSet();
            dsd = bl.ListCusCategory(connection);
            drpCustomerCategoryAdd.Items.Clear();
            drpCustomerCategoryAdd.Items.Add(new ListItem("Select Customer Category", "0"));
            drpCustomerCategoryAdd.DataSource = dsd;
            drpCustomerCategoryAdd.DataBind();
            drpCustomerCategoryAdd.DataTextField = "CusCategory_Name";
            drpCustomerCategoryAdd.DataValueField = "CusCategory_Value";


            chk.Checked = true;
            totalrow123.Visible = false;
            totalrow1.Visible = false;
            totalrow.Visible = false;

        }
        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }
    }

    protected void GrdViewItems_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            BusinessLogic bl = new BusinessLogic(sDataSource);
            DataSet ds = new DataSet();

            ds = bl.ListBanks();

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                var ddl = (DropDownList)e.Row.FindControl("drpBank");
                ddl.Items.Clear();
                ListItem lifzzh = new ListItem("Select Ledger", "0");
                lifzzh.Attributes.Add("style", "color:Black");
                ddl.Items.Add(lifzzh);
                ddl.DataSource = ds;
                ddl.Items[0].Attributes.Add("background-color", "color:#bce1fe");
                ddl.DataBind();
                ddl.DataTextField = "LedgerName";
                ddl.DataValueField = "LedgerID";

                var ddll = (Label)e.Row.FindControl("txtType");
                if(ddll.Text == "Cash")
                {
                    var dd = (TextBox)e.Row.FindControl("txtChequeNo");
                    dd.Enabled = false;

                    var ddlll = (DropDownList)e.Row.FindControl("drpBank");
                    ddlll.Enabled = false;
                }
            }
        }
        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }
    }

    protected void UpdCancelButton_Click(object sender, EventArgs e)
    {
        ModalPopupExtender1.Hide();
        ModalPopupExtender2.Hide();
    }

    protected void UpdButton_Click(object sender, EventArgs e)
    {
        //if ((chkcard.Checked == false) && (chkcheque.Checked == false) && ( chkcash.Checked == false))
        //{
        //    ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('Please select any one')", true);
        //    return;
        //}

        string connection = string.Empty;
        connection = Request.Cookies["Company"].Value;

        string[] sDate;
        DateTime sBilldate;

        string delim = "/";
        char[] delimA = delim.ToCharArray();
        //CultureInfo culture = new CultureInfo("pt-BR");
        string sPath = string.Empty;
        BusinessLogic bl = new BusinessLogic(sDataSource);

        if (!bl.IsValidDate(connection, Convert.ToDateTime(txtDate.Text)))
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('Date is invalid')", true);
            return;
        }

        if (Request.Cookies["Company"] != null)
            sDataSource = Request.Cookies["Company"].Value;

        sPath = sDataSource;
        string usernam = Request.Cookies["LoggedUserName"].Value;

        

        for (int vLoop = 0; vLoop < GridView2.Rows.Count; vLoop++)
        {
            DropDownList txtttd = (DropDownList)GridView2.Rows[vLoop].FindControl("txtType");
            TextBox txttt = (TextBox)GridView2.Rows[vLoop].FindControl("txtRefNo");
            TextBox txt = (TextBox)GridView2.Rows[vLoop].FindControl("txtAmount");
            TextBox txtt = (TextBox)GridView2.Rows[vLoop].FindControl("txtNarration");
            DropDownList txttd = (DropDownList)GridView2.Rows[vLoop].FindControl("drpBank");
            TextBox txttdd = (TextBox)GridView2.Rows[vLoop].FindControl("txtChequeNo");

            int col = vLoop + 1;

            if (txttt.Text == "")
            {
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('Please fill RefNo in row " + col + " ')", true);
                return;
            }
            else if (txt.Text == "")
            {
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('Please fill Amount in row " + col + " ')", true);
                return;
            }
            else if (txtt.Text == "")
            {
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('Please fill Narration in row " + col + " ')", true);
                return;
            }
            else if (txttd.SelectedValue == "0")
            {
                if (txtttd.SelectedItem.Text != "Cash")
                {
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('Please select Bank in row " + col + " ')", true);
                    return;
                }
            }
            else if (txttdd.Text == "")
            {
                if (txtttd.SelectedItem.Text != "Cash")
                {
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('Please fill Cheque No in row " + col + " ')", true);
                    return;
                }
            }                       
        }




        int iq = 1;
        int ii = 1;
        string itemc = string.Empty;
        string itemcd = string.Empty;
       
            for (int vLoop = 0; vLoop < GridView2.Rows.Count; vLoop++)
            {
                TextBox txt = (TextBox)GridView2.Rows[vLoop].FindControl("txtChequeNo");
                DropDownList txt123 = (DropDownList)GridView2.Rows[vLoop].FindControl("txtType");

                itemc = txt.Text;
                itemcd = txt.Text;

                if ((itemc == null) || (itemc == ""))
                {
                }
                else
                {
                    for (int vLoop1 = 0; vLoop1 < GridView2.Rows.Count; vLoop1++)
                    {
                        TextBox txt1 = (TextBox)GridView2.Rows[vLoop1].FindControl("txtChequeNo");

                        if (ii == iq)
                        {
                        }
                        else
                        {
                            if (itemc == txt1.Text)
                            {
                                ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('Cheque/Card No - " + itemcd + " - cannot be duplicate.');", true);
                                return;
                            }
                        }
                        ii = ii + 1;
                    }
                }
                iq = iq + 1;
                ii = 1;
            }




            int iqq = 1;
            int iiq= 1;
            string itemcz = string.Empty;
            string itemcdz = string.Empty;

            for (int vLoop = 0; vLoop < GridView2.Rows.Count; vLoop++)
            {
                DropDownList txt123 = (DropDownList)GridView2.Rows[vLoop].FindControl("txtType");

                itemcz = txt123.SelectedItem.Text;
                itemcdz = txt123.SelectedItem.Text;

                if ((itemcz == null) || (itemcz == ""))
                {
                }
                else
                {
                    for (int vLoop1 = 0; vLoop1 < GridView2.Rows.Count; vLoop1++)
                    {
                        DropDownList txt1 = (DropDownList)GridView2.Rows[vLoop1].FindControl("txtType");

                        if (iiq == iqq)
                        {
                        }
                        else
                        {
                            if (itemcz == txt1.SelectedItem.Text)
                            {
                                if (txt1.SelectedItem.Text == "Cash")
                                {
                                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('Receipt Mode - " + itemcdz + " - cannot be duplicate.');", true);
                                    return;
                                }
                            }
                        }
                        iiq = iiq + 1;
                    }
                }
                iqq = iqq + 1;
                iiq = 1;
            }



        double tot = 0;

        for (int vLoop = 0; vLoop < GridView1.Rows.Count; vLoop++)
        {
            Label txttt = (Label)GridView1.Rows[vLoop].FindControl("txtBillno");
            Label txt = (Label)GridView1.Rows[vLoop].FindControl("txtBillDate");
            Label txtt = (Label)GridView1.Rows[vLoop].FindControl("txtCustomerName");
            Label txttd = (Label)GridView1.Rows[vLoop].FindControl("txtAmount");
            TextBox txttdd = (TextBox)GridView1.Rows[vLoop].FindControl("txtAdjustAmount");
            Label txttddd = (Label)GridView1.Rows[vLoop].FindControl("txtCompleted");
            Label txttdddd = (Label)GridView1.Rows[vLoop].FindControl("txtAmount1");

            tot = tot + Convert.ToDouble(txttdd.Text);

            int coll = vLoop + 1;

            if (Convert.ToDouble(txttd.Text) < Convert.ToDouble(txttdd.Text))
            {
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('Adjust Amount can not be greater than Amount in row " + coll + " ')", true);
                return;
            }

        }

        for (int vLoop = 0; vLoop < GridView2.Rows.Count; vLoop++)
        {
            TextBox txt = (TextBox)GridView2.FooterRow.FindControl("txttot");

            if (tot > Convert.ToDouble(txt.Text))
            {
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('Total Adjust Amount can not be greater than total receipt Amount ')", true);
                return;
            }
        }


        DataSet ds;
        DataTable dt;
        DataRow drNew;

        DataColumn dc;

        ds = new DataSet();

        dt = new DataTable();

        dc = new DataColumn("RefNo");
        dt.Columns.Add(dc);

        dc = new DataColumn("Date");
        dt.Columns.Add(dc);

        dc = new DataColumn("DebitorID");
        dt.Columns.Add(dc);

        dc = new DataColumn("Paymode");
        dt.Columns.Add(dc);

        dc = new DataColumn("Amount");
        dt.Columns.Add(dc);

        dc = new DataColumn("Narration");
        dt.Columns.Add(dc);

        dc = new DataColumn("VoucherType");
        dt.Columns.Add(dc);

        dc = new DataColumn("ChequeNo");
        dt.Columns.Add(dc);

        ds.Tables.Add(dt);

        for (int vLoop = 0; vLoop < GridView2.Rows.Count; vLoop++)
        {
            TextBox txttt = (TextBox)GridView2.Rows[vLoop].FindControl("txtRefNo");
            DropDownList txtttd = (DropDownList)GridView2.Rows[vLoop].FindControl("txtType");
            TextBox txt = (TextBox)GridView2.Rows[vLoop].FindControl("txtAmount");
            TextBox txtt = (TextBox)GridView2.Rows[vLoop].FindControl("txtNarration");
            DropDownList txttd = (DropDownList)GridView2.Rows[vLoop].FindControl("drpBank");
            TextBox txttdd = (TextBox)GridView2.Rows[vLoop].FindControl("txtChequeNo");

            sDate = txtDate.Text.Trim().Split(delimA);
            sBilldate = new DateTime(Convert.ToInt32(sDate[2].ToString()), Convert.ToInt32(sDate[1].ToString()), Convert.ToInt32(sDate[0].ToString()));

            drNew = dt.NewRow();
            drNew["RefNo"] = txttt.Text;
            drNew["Date"] = sBilldate;
            

            if (txtttd.SelectedItem.Text == "Cash")
            {
                drNew["DebitorID"] = 1;
                drNew["Paymode"] = "Cash";
                drNew["ChequeNo"] = 0;
            }
            else if (txtttd.SelectedItem.Text == "Cheque")
            {
                drNew["DebitorID"] = int.Parse(txttd.SelectedValue);
                drNew["Paymode"] = "Cheque";
                drNew["ChequeNo"] = txttdd.Text;
            }
            else if (txtttd.SelectedItem.Text == "Card")
            {
                drNew["DebitorID"] = int.Parse(txttd.SelectedValue);
                drNew["Paymode"] = "Card";
                drNew["ChequeNo"] = txttdd.Text;
            }

            //drNew["Creditor"] = Convert.ToInt32(txttd.SelectedItem.Value);
            drNew["Amount"] = txt.Text;
            drNew["Narration"] = txtt.Text;
            drNew["VoucherType"] = "Receipt";
            ds.Tables[0].Rows.Add(drNew);
        }

        string conn = GetConnectionString();

        DataSet dst = (DataSet)Session["BillData"];





        DataSet dsttN;
        DataTable dttN;
        DataRow drNewtN;

        DataColumn dctN;

        dsttN = new DataSet();

        dttN = new DataTable();

        dctN = new DataColumn("Billno");
        dttN.Columns.Add(dctN);

        dctN = new DataColumn("Row");
        dttN.Columns.Add(dctN);

        dctN = new DataColumn("CustomerName");
        dttN.Columns.Add(dctN);

        dctN = new DataColumn("Amount");
        dttN.Columns.Add(dctN);

        dctN = new DataColumn("BillDate");
        dttN.Columns.Add(dctN);

        dctN = new DataColumn("PendingAmount");
        dttN.Columns.Add(dctN);

        dctN = new DataColumn("AdjustAmount");
        dttN.Columns.Add(dctN);

        dctN = new DataColumn("Completed");
        dttN.Columns.Add(dctN);

        dctN = new DataColumn("Amount1");
        dttN.Columns.Add(dctN);

        dsttN.Tables.Add(dttN);

        int sno1 = 1;

        for (int vLoop = 0; vLoop < GridView1.Rows.Count; vLoop++)
        {
            Label txttt = (Label)GridView1.Rows[vLoop].FindControl("txtBillno");
            Label txt = (Label)GridView1.Rows[vLoop].FindControl("txtBillDate");
            Label txtt = (Label)GridView1.Rows[vLoop].FindControl("txtCustomerName");
            Label txttd = (Label)GridView1.Rows[vLoop].FindControl("txtAmount");
            Label txttd123 = (Label)GridView1.Rows[vLoop].FindControl("txtAmount123");
            TextBox txttdd = (TextBox)GridView1.Rows[vLoop].FindControl("txtAdjustAmount");
            Label txttddd = (Label)GridView1.Rows[vLoop].FindControl("txtCompleted");
            Label txttdddd = (Label)GridView1.Rows[vLoop].FindControl("txtAmount1");

            drNewtN = dttN.NewRow();
            drNewtN["Row"] = sno1;
            drNewtN["Billno"] = txttt.Text;
            drNewtN["CustomerName"] = txtt.Text;
            drNewtN["PendingAmount"] = txttd.Text;
            drNewtN["Amount"] = txttd123.Text;
            drNewtN["BillDate"] = txt.Text;
            drNewtN["AdjustAmount"] = Convert.ToDouble(txttdd.Text);
            drNewtN["Amount1"] = Convert.ToDouble(txttdd.Text);
            drNewtN["Completed"] = txttddd.Text;
            dsttN.Tables[0].Rows.Add(drNewtN);
            sno1 = sno1 + 1;
        }

        GridView1.DataSource = dsttN;
        GridView1.DataBind();







        DataSet dstt;
        DataTable dtt;
        DataRow drNewt;

        DataColumn dct;

        dstt = new DataSet();

        dtt = new DataTable();

        dct = new DataColumn("Billno");
        dtt.Columns.Add(dct);

        dct = new DataColumn("Row");
        dtt.Columns.Add(dct);

        dct = new DataColumn("CustomerName");
        dtt.Columns.Add(dct);

        dct = new DataColumn("Amount");
        dtt.Columns.Add(dct);

        dct = new DataColumn("BillDate");
        dtt.Columns.Add(dct);

        dct = new DataColumn("PendingAmount");
        dtt.Columns.Add(dct);

        dct = new DataColumn("AdjustAmount");
        dtt.Columns.Add(dct);

        dct = new DataColumn("Completed");
        dtt.Columns.Add(dct);

        dct = new DataColumn("Amount1");
        dtt.Columns.Add(dct);

        dstt.Tables.Add(dtt);

        int sno = 1;

        for (int vLoop = 0; vLoop < GridView1.Rows.Count; vLoop++)
        {
            Label txttt = (Label)GridView1.Rows[vLoop].FindControl("txtBillno");
            Label txt = (Label)GridView1.Rows[vLoop].FindControl("txtBillDate");
            Label txtt = (Label)GridView1.Rows[vLoop].FindControl("txtCustomerName");
            Label txttd = (Label)GridView1.Rows[vLoop].FindControl("txtAmount");
            TextBox txttdd = (TextBox)GridView1.Rows[vLoop].FindControl("txtAdjustAmount");
            Label txttddd = (Label)GridView1.Rows[vLoop].FindControl("txtCompleted");
            Label txttdddd = (Label)GridView1.Rows[vLoop].FindControl("txtAmount1");
            Label txttd123 = (Label)GridView1.Rows[vLoop].FindControl("txtAmount123");

            drNewt = dtt.NewRow();
            drNewt["Row"] = sno;
            drNewt["Billno"] = txttt.Text;
            drNewt["CustomerName"] = txtt.Text;
            drNewt["PendingAmount"] = txttd.Text;
            drNewt["Amount"] = txttd123.Text;
            drNewt["BillDate"] = txt.Text;
            drNewt["AdjustAmount"] = Convert.ToDouble(txttdd.Text);
            drNewt["Amount1"] = Convert.ToDouble(txttdd.Text);
            drNewt["Completed"] = txttddd.Text;
            dstt.Tables[0].Rows.Add(drNewt);
            sno = sno + 1;
        }


        //dct = new DataColumn("Billno");
        //dtt.Columns.Add(dct);

        //dct = new DataColumn("Amount");
        //dtt.Columns.Add(dct);

        //dstt.Tables.Add(dtt);

        //for (int vLoop = 0; vLoop < GridView1.Rows.Count; vLoop++)
        //{
        //    Label txttt = (Label)GridView1.Rows[vLoop].FindControl("txtBillno");
        //    //Label txtttd = (Label)GridView1.Rows[vLoop].FindControl("txtBillDate");
        //    //Label txt = (Label)GridView1.Rows[vLoop].FindControl("txtCustomerName");
        //    //Label txtt = (Label)GridView1.Rows[vLoop].FindControl("txtAmount");
        //    TextBox txttd = (TextBox)GridView1.Rows[vLoop].FindControl("txtAdjustAmount");

        //    drNewt = dtt.NewRow();
        //    drNewt["Billno"] = txttt.Text;
        //    drNewt["Amount"] = txttd.Text;
        //    dstt.Tables[0].Rows.Add(drNewt);
        //}



        int CreditorID = 0;
        string sCustomerName = string.Empty;

        string CName = string.Empty;
        string sCustomerAddress = string.Empty;
        string sCustomerAddress2 = string.Empty;
        string sCustomerAddress3 = string.Empty;
        string sCustomerContact = string.Empty;

        CName = txtCustomerName.Text;
        sCustomerAddress = txtAddress.Text;
        sCustomerAddress2 = txtAddress2.Text;
        sCustomerAddress3 = txtAddress3.Text;
        sCustomerContact = txtCustomerId.Text;

        string cuscat = string.Empty;
        cuscat = drpCustomerCategoryAdd.SelectedItem.Text;

        if (chk.Checked == false)
        {
            if (bl.IsLedgerAlreadyFound(connection, CName))
            {
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('Customer " + CName + " with this name already exists.');", true);
                return;
            }

            CreditorID = bl.InsertCustomerInfoDirect(connection, CName, CName, 1, 0, 0, 0, "", CName, sCustomerAddress, sCustomerAddress2, sCustomerAddress3, "", cuscat, 0, "", sCustomerContact, 0, 0, "NO", "NO", "NO", CName, usernam, "YES", "", 3);
            sCustomerName = txtCustomerName.Text;
        }
        else
        {
            sCustomerName = drpLedger.SelectedItem.Text;
            CreditorID = int.Parse(drpLedger.SelectedValue);
        }




        DataSet dsttt;
        DataTable dttt;
        DataRow drNewtt;

        DataColumn dctt;

        dsttt = new DataSet();

        dttt = new DataTable();

        dctt = new DataColumn("Billno");
        dttt.Columns.Add(dctt);

        dctt = new DataColumn("Amount");
        dttt.Columns.Add(dctt);

        dctt = new DataColumn("Type");
        dttt.Columns.Add(dctt);

        dctt = new DataColumn("Completed");
        dttt.Columns.Add(dctt);

        dctt = new DataColumn("Amount1");
        dttt.Columns.Add(dctt);

        dctt = new DataColumn("ChequeNo");
        dttt.Columns.Add(dctt);

        dsttt.Tables.Add(dttt);



            for (int vLoop1 = 0; vLoop1 < GridView2.Rows.Count; vLoop1++)
            {
                TextBox txt = (TextBox)GridView2.Rows[vLoop1].FindControl("txtAmount");
                DropDownList txtttd = (DropDownList)GridView2.Rows[vLoop1].FindControl("txtType");
                TextBox txtChequeNo = (TextBox)GridView2.Rows[vLoop1].FindControl("txtChequeNo");

                double adtotal = Convert.ToDouble(txt.Text);

                for (int vLoop = 0; vLoop < GridView1.Rows.Count; vLoop++)
                {
                    Label txttt = (Label)GridView1.Rows[vLoop].FindControl("txtBillno");
                    //Label txtttd = (Label)GridView1.Rows[vLoop].FindControl("txtBillDate");
                    //Label txt = (Label)GridView1.Rows[vLoop].FindControl("txtCustomerName");
                    Label txtamount = (Label)GridView1.Rows[vLoop].FindControl("txtAmount");
                    TextBox txttd = (TextBox)GridView1.Rows[vLoop].FindControl("txtAdjustAmount");
                    Label txtamount1 = (Label)GridView1.Rows[vLoop].FindControl("txtAmount1");
                    Label txttCompleted = (Label)GridView1.Rows[vLoop].FindControl("txtCompleted");
                    Label txttd123 = (Label)GridView1.Rows[vLoop].FindControl("txtAmount123");

                    if (txttCompleted.Text == "N")
                    {
                        drNewtt = dttt.NewRow();
                        drNewtt["Billno"] = txttt.Text;


                        if (adtotal > Convert.ToDouble(txtamount1.Text))
                        {
                            drNewtt["Type"] = txtttd.Text;
                            drNewtt["Amount"] = txtamount1.Text;
                            adtotal = adtotal - Convert.ToDouble(txtamount1.Text);
                            drNewtt["Completed"] = "Y";
                            if (txtttd.SelectedItem.Text == "Cash")
                            {
                                drNewtt["ChequeNo"] = 0;
                            }
                            else
                            {
                                drNewtt["ChequeNo"] = txtChequeNo.Text;
                            }

                            dsttt.Tables[0].Rows.Add(drNewtt);

                            for (int i = 0; i < dstt.Tables[0].Rows.Count; i++)
                            {
                                if (txttt.Text == dstt.Tables[0].Rows[i]["BillNo"].ToString())
                                {
                                    dstt.Tables[0].Rows[i].BeginEdit();
                                    dstt.Tables[0].Rows[i]["Completed"] = "Y";
                                    dstt.Tables[0].Rows[i]["Amount1"] = 0;
                                    dstt.Tables[0].Rows[i].EndEdit();
                                }
                            }
                            dstt.Tables[0].AcceptChanges();

                            GridView1.DataSource = dstt;
                            GridView1.DataBind();

                        }
                        else if (adtotal < Convert.ToDouble(txtamount1.Text))
                        {
                            drNewtt["Type"] = txtttd.Text;
                            drNewtt["Amount"] = adtotal;
                            adtotal = Convert.ToDouble(txtamount1.Text) - adtotal;
                            drNewtt["Completed"] = "N";
                            if (txtttd.SelectedItem.Text == "Cash")
                            {
                                drNewtt["ChequeNo"] = 0;
                            }
                            else
                            {
                                drNewtt["ChequeNo"] = txtChequeNo.Text;
                            }

                            dsttt.Tables[0].Rows.Add(drNewtt);

                            for (int i = 0; i < dstt.Tables[0].Rows.Count; i++)
                            {
                                if (txttt.Text == dstt.Tables[0].Rows[i]["BillNo"].ToString())
                                {
                                    dstt.Tables[0].Rows[i].BeginEdit();
                                    dstt.Tables[0].Rows[i]["Completed"] = "N";
                                    dstt.Tables[0].Rows[i]["Amount1"] = adtotal;
                                    dstt.Tables[0].Rows[i].EndEdit();
                                }
                            }
                            dstt.Tables[0].AcceptChanges();

                            GridView1.DataSource = dstt;
                            GridView1.DataBind();

                            break;
                        }
                        else if (adtotal == Convert.ToDouble(txtamount1.Text))
                        {
                            drNewtt["Type"] = txtttd.Text;

                            if ((Convert.ToDouble(txtamount.Text) - Convert.ToDouble(txtamount1.Text)) == 0)
                            {
                                drNewtt["Completed"] = "Y";
                                drNewtt["Amount"] = Convert.ToDouble(txtamount1.Text);
                                adtotal = 0;

                                if (txtttd.SelectedItem.Text == "Cash")
                                {
                                    drNewtt["ChequeNo"] = 0;
                                }
                                else
                                {
                                    drNewtt["ChequeNo"] = txtChequeNo.Text;
                                }

                                dsttt.Tables[0].Rows.Add(drNewtt);

                                for (int i = 0; i < dstt.Tables[0].Rows.Count; i++)
                                {
                                    if (txttt.Text == dstt.Tables[0].Rows[i]["BillNo"].ToString())
                                    {
                                        dstt.Tables[0].Rows[i].BeginEdit();
                                        dstt.Tables[0].Rows[i]["Completed"] = "Y";
                                        dstt.Tables[0].Rows[i]["Amount1"] = 0;
                                        dstt.Tables[0].Rows[i].EndEdit();
                                    }
                                }
                                dstt.Tables[0].AcceptChanges();

                                GridView1.DataSource = dstt;
                                GridView1.DataBind();

                                
                            }
                            else
                            {
                                adtotal = 0;
                                drNewtt["Completed"] = "N";
                                drNewtt["Amount"] = Convert.ToDouble(txtamount1.Text);

                                if (txtttd.SelectedItem.Text == "Cash")
                                {
                                    drNewtt["ChequeNo"] = 0;
                                }
                                else
                                {
                                    drNewtt["ChequeNo"] = txtChequeNo.Text;
                                }

                                dsttt.Tables[0].Rows.Add(drNewtt);

                                for (int i = 0; i < dstt.Tables[0].Rows.Count; i++)
                                {
                                    if (txttt.Text == dstt.Tables[0].Rows[i]["BillNo"].ToString())
                                    {
                                        dstt.Tables[0].Rows[i].BeginEdit();
                                        dstt.Tables[0].Rows[i]["Completed"] = "N";
                                        dstt.Tables[0].Rows[i]["Amount1"] = (Convert.ToDouble(txtamount.Text) - Convert.ToDouble(txtamount1.Text));
                                        dstt.Tables[0].Rows[i].EndEdit();
                                    }
                                }
                                dstt.Tables[0].AcceptChanges();

                                GridView1.DataSource = dstt;
                                GridView1.DataBind();
                            }

                            break;
                            
                            
                            

                            
                        }
                    }
                }          
            }





            bl.InsertMultipleCustReceipt(conn, ds, CreditorID, dsttt, usernam);

            string salestype = string.Empty;
            int ScreenNo = 0;
            string ScreenName = string.Empty;

            salestype = "Customer Receipt";
            ScreenName = "Customer Receipt";

            bool mobile = false;
            bool Email = false;
            string emailsubject = string.Empty;

            string emailcontent = string.Empty;
            if (hdEmailRequired.Value == "YES")
            {
                DataSet dsd = bl.GetLedgerInfoForId(connection, CreditorID);
                var toAddress = "";
                var toAdd = "";
                Int32 ModeofContact = 0;
                int ScreenType = 0;

                if (dsd != null)
                {
                    if (dsd.Tables[0].Rows.Count > 0)
                    {
                        foreach (DataRow dr in dsd.Tables[0].Rows)
                        {
                            toAdd = dr["EmailId"].ToString();
                            ModeofContact = Convert.ToInt32(dr["ModeofContact"]);
                        }
                    }
                }

                if (ds != null)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        foreach (DataRow drd in ds.Tables[0].Rows)
                        {
                            DataSet dsdd = bl.GetDetailsForScreenNo(connection, ScreenName, "");
                            if (dsdd != null)
                            {
                                if (dsdd.Tables[0].Rows.Count > 0)
                                {
                                    foreach (DataRow dr in dsdd.Tables[0].Rows)
                                    {
                                        ScreenType = Convert.ToInt32(dr["ScreenType"]);
                                        mobile = Convert.ToBoolean(dr["mobile"]);
                                        Email = Convert.ToBoolean(dr["Email"]);
                                        emailsubject = Convert.ToString(dr["emailsubject"]);
                                        emailcontent = Convert.ToString(dr["emailcontent"]);

                                        if (ScreenType == 1)
                                        {
                                            if (dr["Name1"].ToString() == "Sales Executive")
                                            {
                                                toAddress = toAdd;
                                            }
                                            else if (dr["Name1"].ToString() == "Customer")
                                            {
                                                if (ModeofContact == 2)
                                                {
                                                    toAddress = toAdd;
                                                }
                                                else
                                                {
                                                    break;
                                                }
                                            }
                                            else
                                            {
                                                toAddress = toAdd;
                                            }
                                        }
                                        else
                                        {
                                            toAddress = dr["EmailId"].ToString();
                                        }
                                        if (Email == true)
                                        {
                                            
                                            string body = "\n";

                                            int index123 = emailcontent.IndexOf("@Branch");
                                            body = Request.Cookies["Company"].Value;
                                            emailcontent = emailcontent.Remove(index123, 7).Insert(index123, body);

                                            int index132 = emailcontent.IndexOf("@Narration");
                                            body = Convert.ToString(drd["Narration"]);
                                            emailcontent = emailcontent.Remove(index132, 10).Insert(index132, body);

                                            int index312 = emailcontent.IndexOf("@User");
                                            body = usernam;
                                            emailcontent = emailcontent.Remove(index312, 5).Insert(index312, body);

                                            int index2 = emailcontent.IndexOf("@Date");
                                            body = Convert.ToString(drd["Date"]);
                                            emailcontent = emailcontent.Remove(index2, 5).Insert(index2, body);

                                            int index = emailcontent.IndexOf("@Customer");
                                            body = drpLedger.SelectedItem.Text;
                                            emailcontent = emailcontent.Remove(index, 9).Insert(index, body);

                                            int index1 = emailcontent.IndexOf("@Amount");
                                            body = Convert.ToString(drd["Amount"]);
                                            emailcontent = emailcontent.Remove(index1, 7).Insert(index1, body);

                                            string smtphostname = ConfigurationManager.AppSettings["SmtpHostName"].ToString();
                                            int smtpport = Convert.ToInt32(ConfigurationManager.AppSettings["SmtpPortNumber"]);
                                            var fromAddress = ConfigurationManager.AppSettings["FromAddress"].ToString();

                                            string fromPassword = ConfigurationManager.AppSettings["FromPassword"].ToString();

                                            EmailLogic.SendEmail(smtphostname, smtpport, fromAddress, toAddress, emailsubject, emailcontent, fromPassword);

                                            //ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('Email sent successfully')", true);

                                        }

                                    }
                                }
                            }
                        }
                    }
                }
            }

            //string conn = bl.CreateConnectionString(Request.Cookies["Company"].Value);
            UtilitySMS utilSMS = new UtilitySMS(conn);
            string UserID = Page.User.Identity.Name;

            string smscontent = string.Empty;
            if (hdSMSRequired.Value == "YES")
            {
                DataSet dsd = bl.GetLedgerInfoForId(connection, CreditorID);
                var toAddress = "";
                var toAdd = "";
                Int32 ModeofContact = 0;
                int ScreenType = 0;

                if (dsd != null)
                {
                    if (dsd.Tables[0].Rows.Count > 0)
                    {
                        foreach (DataRow dr in dsd.Tables[0].Rows)
                        {
                            toAdd = dr["Mobile"].ToString();
                            ModeofContact = Convert.ToInt32(dr["ModeofContact"]);
                        }
                    }
                }

                if (ds != null)
                {
                    if (ds.Tables[0].Rows.Count > 0)
                    {
                        foreach (DataRow drd in ds.Tables[0].Rows)
                        {
                            DataSet dsdd = bl.GetDetailsForScreenNo(connection, ScreenName, "");
                            if (dsdd != null)
                            {
                                if (dsdd.Tables[0].Rows.Count > 0)
                                {
                                    foreach (DataRow dr in dsdd.Tables[0].Rows)
                                    {
                                        ScreenType = Convert.ToInt32(dr["ScreenType"]);
                                        mobile = Convert.ToBoolean(dr["mobile"]);
                                        smscontent = Convert.ToString(dr["smscontent"]);

                                        if (ScreenType == 1)
                                        {
                                            if (dr["Name1"].ToString() == "Sales Executive")
                                            {
                                                toAddress = toAdd;
                                            }
                                            else if (dr["Name1"].ToString() == "Customer")
                                            {
                                                if (ModeofContact == 1)
                                                {
                                                    toAddress = toAdd;
                                                }
                                                else
                                                {
                                                    break;
                                                }
                                            }
                                            else
                                            {
                                                toAddress = toAdd;
                                            }
                                        }
                                        else
                                        {
                                            toAddress = dr["mobile"].ToString();
                                        }
                                        if (mobile == true)
                                        {

                                            string body = "\n";

                                            int index123 = smscontent.IndexOf("@Branch");
                                            body = Request.Cookies["Company"].Value;
                                            smscontent = smscontent.Remove(index123, 7).Insert(index123, body);

                                            int index132 = smscontent.IndexOf("@Narration");
                                            body = Convert.ToString(drd["Narration"]);
                                            smscontent = smscontent.Remove(index132, 10).Insert(index132, body);

                                            int index312 = smscontent.IndexOf("@User");
                                            body = usernam;
                                            smscontent = smscontent.Remove(index312, 5).Insert(index312, body);

                                            int index2 = smscontent.IndexOf("@Date");
                                            body = Convert.ToString(drd["Date"]);
                                            smscontent = smscontent.Remove(index2, 5).Insert(index2, body);

                                            int index = smscontent.IndexOf("@Customer");
                                            body = drpLedger.SelectedItem.Text;
                                            smscontent = smscontent.Remove(index, 9).Insert(index, body);

                                            int index1 = smscontent.IndexOf("@Amount");
                                            body = Convert.ToString(drd["Amount"]);
                                            smscontent = smscontent.Remove(index1, 7).Insert(index1, body);


                                            if (Session["Provider"] != null)
                                            {
                                                utilSMS.SendSMS(Session["Provider"].ToString(), Session["Priority"].ToString(), Session["SenderID"].ToString(), Session["UserName"].ToString(), Session["Password"].ToString(), toAddress, smscontent, true, UserID);
                                            }


                                        }

                                    }
                                }
                            }
                        }
                    }
                }
            }


        ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('Receipt Saved Successfully.');", true);

        ModalPopupExtender1.Hide();
        ModalPopupExtender2.Hide();

        GrdViewReceipt.DataBind();
        ClearPanel();
        UpdatePanelPage.Update();
    }

    protected void txtAdjustAmount_TextChanged(object sender, EventArgs e)
    {

    }

    private void AmountCalc(double total)
    {
        TextBox txt123 = (TextBox)GridView2.FooterRow.FindControl("txttot");

        txt123.Text =  Convert.ToString(total);
    }

    protected void txtAmount_TextChanged(object sender, EventArgs e)
    {
        double total = 0;
        double adtotal=0;
        for (int vLoop = 0; vLoop < GridView2.Rows.Count; vLoop++)
        {            
            TextBox txt = (TextBox)GridView2.Rows[vLoop].FindControl("txtAmount");
            

            if (txt.Text != "")
            {
                total = Convert.ToDouble(txt.Text) + total;
                adtotal = Convert.ToDouble(txt.Text) + adtotal;
                
            }
            AmountCalc(total);
        }
        


        if (GridView1.Rows.Count > 0)
        {
            DataTable dttt;
            DataRow drNew;
            DataColumn dct;
            DataSet dstd = new DataSet();
            dttt = new DataTable();

            dct = new DataColumn("Billno");
            dttt.Columns.Add(dct);

            dct = new DataColumn("Row");
            dttt.Columns.Add(dct);

            dct = new DataColumn("CustomerName");
            dttt.Columns.Add(dct);

            dct = new DataColumn("Amount");
            dttt.Columns.Add(dct);

            dct = new DataColumn("BillDate");
            dttt.Columns.Add(dct);

            dct = new DataColumn("AdjustAmount");
            dttt.Columns.Add(dct);

            dct = new DataColumn("PendingAmount");
            dttt.Columns.Add(dct);

            dct = new DataColumn("Completed");
            dttt.Columns.Add(dct);

            dct = new DataColumn("Amount1");
            dttt.Columns.Add(dct);

            dstd.Tables.Add(dttt);

            int sno = 1;

            for (int vLoop = 0; vLoop < GridView1.Rows.Count; vLoop++)
            {
                Label txttt = (Label)GridView1.Rows[vLoop].FindControl("txtBillno");
                Label txt = (Label)GridView1.Rows[vLoop].FindControl("txtBillDate");
                Label txtt = (Label)GridView1.Rows[vLoop].FindControl("txtCustomerName");
                Label txttd = (Label)GridView1.Rows[vLoop].FindControl("txtAmount");
                Label txttd123 = (Label)GridView1.Rows[vLoop].FindControl("txtAmount123");
                TextBox txttdd = (TextBox)GridView1.Rows[vLoop].FindControl("txtAdjustAmount");
                Label txttdtt = (Label)GridView1.Rows[vLoop].FindControl("txtAmount1");

                        drNew = dttt.NewRow();
                        drNew["Row"] = sno;
                        drNew["Billno"] = txttt.Text;
                        drNew["CustomerName"] = txtt.Text;
                        drNew["PendingAmount"] = txttd.Text;
                        drNew["Amount"] = txttd123.Text;

                        drNew["BillDate"] = txt.Text;
                        if (adtotal > Convert.ToDouble(txttd.Text))
                        {
                            drNew["AdjustAmount"] = Convert.ToDouble(txttd.Text);
                            drNew["Amount1"] = Convert.ToDouble(txttd.Text);     
                            adtotal = adtotal - Convert.ToDouble(txttd.Text);
                        }
                        else if (adtotal < Convert.ToDouble(txttd.Text))
                        {
                            drNew["AdjustAmount"] = adtotal;
                            drNew["Amount1"] = adtotal;     
                            adtotal = 0;
                        }
                        else if (adtotal == Convert.ToDouble(txttd.Text))
                        {
                            drNew["AdjustAmount"] = adtotal;
                            drNew["Amount1"] = adtotal;     
                            adtotal = 0;
                        }
                        drNew["Completed"] = "N";
                        dstd.Tables[0].Rows.Add(drNew);
                        sno = sno + 1;
                    }
            GridView1.DataSource = dstd;
            GridView1.DataBind();
        }
        else
        {
            GridView1.DataSource = null;
            GridView1.DataBind();
        }

        double tota = 0;
        for (int vLoop = 0; vLoop < GridView1.Rows.Count; vLoop++)
        {
            TextBox txt = (TextBox)GridView1.Rows[vLoop].FindControl("txtAdjustAmount");
            if (txt.Text != "")
            {
                tota = Convert.ToDouble(txt.Text) + tota;
            }

        }
        TextBox1.Text = Convert.ToString(tota);

        if (chk.Checked == true)
        {
            if (drpReceiptType.SelectedValue == "1")
            {
                totalrow1.Visible = true;
                totalrow.Visible = true;
                totalrow123.Visible = true;
            }
            else
            {
                totalrow1.Visible = false;
                totalrow.Visible = false;
                totalrow123.Visible = false;
            }
        }
        else
        {
            totalrow1.Visible = false;
            totalrow.Visible = false;
            totalrow123.Visible = false;
        }
    }

    private void ClearPanel()
    {
        txtRefNo.Text = "";
        txtTransDate.Text = "";
        txtNarration.Text = "";
        txtChequeNo.Text = "";
        txtAmount.Text = "";
        ddReceivedFrom.SelectedValue = "0";
        drpLedger.SelectedIndex = 0;
        txtAddress.ReadOnly = true;
        txtAddress2.ReadOnly = true;
        txtAddress3.ReadOnly = true;
        txtAddress.Text= "";
        txtAddress2.Text = "";
        txtAddress3.Text = "";
        drpMobile.SelectedIndex = 0;
        txtCustomerId.Visible = false;
        txtCustomerName.Visible = false;

        //txttot.Text = "0";
        txtMobile.Text = "";
        ddBanks.SelectedValue = "0";
        GrdBills.DataSource = null;
        GrdBills.DataBind();
        Session["BillData"] = null;
    }

    protected void ComboBox2_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            string debtorID = ddReceivedFrom.SelectedValue;
            BusinessLogic objBus = new BusinessLogic();

            string Mobile = objBus.GetLedgerMobileForId(Request.Cookies["Company"].Value, int.Parse(debtorID));

            txtMobile.Text = Mobile;

            txtAmount.Focus();
            GrdViewSales.PageSize = 6;

            if (chkPayTo.SelectedItem != null)
            {
                if (chkPayTo.SelectedItem.Text == "Cheque")
                {
                    tblBank.Attributes.Add("class", "AdvancedSearch");
                }
                else
                {
                    tblBank.Attributes.Add("class", "hidden");
                }
            }
            else
            {
                tblBank.Attributes.Add("class", "hidden");
            }

            ShowPendingBills();
            ModalPopupExtender2.Show();

            GrdViewSales.PageSize = 6;
        }
        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }
    }

    protected void txtType_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            for (int vLoop = 0; vLoop < GridView2.Rows.Count; vLoop++)
            {
                DropDownList txt = (DropDownList)GridView2.Rows[vLoop].FindControl("txtType");
                DropDownList txtt = (DropDownList)GridView2.Rows[vLoop].FindControl("drpBank");
                TextBox txttt = (TextBox)GridView2.Rows[vLoop].FindControl("txtChequeNo");

                if (txt.SelectedItem.Text == "Cash")
                {
                    txtt.Enabled = false;
                    txttt.Enabled = false;
                }
                else
                {
                    txtt.Enabled = true;
                    txttt.Enabled = true;
                }
            }


            int iq = 1;
            int ii = 1;
            string itemc = string.Empty;
            string itemcd = string.Empty;
            if (ViewState["CurrentTable1"] != null)
            {
                DataTable dtCurrentTable1 = (DataTable)ViewState["CurrentTable1"];
                for (int vLoop = 0; vLoop < GridView2.Rows.Count; vLoop++)
                {
                    DropDownList txt = (DropDownList)GridView2.Rows[vLoop].FindControl("txtType");
                    itemc = txt.Text;
                    itemcd = txt.SelectedItem.Text;

                    if ((itemc == null) || (itemc == ""))
                    {
                    }
                    else
                    {
                        for (int vLoop1 = 0; vLoop1 < GridView2.Rows.Count; vLoop1++)
                        {
                            DropDownList txt1 = (DropDownList)GridView2.Rows[vLoop1].FindControl("txtType");

                            if (ii == iq)
                            {
                            }
                            else
                            {
                                if (itemc == txt1.Text)
                                {
                                    if (txt1.SelectedItem.Text == "Cash")
                                    {
                                        ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('" + itemcd + "  already exists in the Grid.');", true);
                                        return;
                                    }
                                }
                            }
                            ii = ii + 1;
                        }
                    }
                    iq = iq + 1;
                    ii = 1;
                }
                //GridView2.DataSource = dtCurrentTable1;
                //GridView2.DataBind();
            }






            //if(txtType)
        }
        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }
    }

    protected void drpLedger_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            int debtorID = Convert.ToInt32(drpLedger.SelectedValue);
            BusinessLogic bl = new BusinessLogic(sDataSource);

            DataSet customerDs = bl.getAddressInfo(debtorID);

            if (customerDs != null && customerDs.Tables[0].Rows.Count > 0)
            {
                if (customerDs.Tables[0].Rows[0]["Add1"] != null)
                    txtAddress.Text = customerDs.Tables[0].Rows[0]["Add1"].ToString();

                if (customerDs.Tables[0].Rows[0]["Add2"] != null)
                    txtAddress2.Text = customerDs.Tables[0].Rows[0]["Add2"].ToString();

                if (customerDs.Tables[0].Rows[0]["Add3"] != null)
                    txtAddress3.Text = customerDs.Tables[0].Rows[0]["Add3"].ToString();

                if (customerDs.Tables[0].Rows[0]["Mobile"] != null)
                {
                    txtCustomerId.Text = Convert.ToString(customerDs.Tables[0].Rows[0]["Mobile"]);
                }

                drpMobile.ClearSelection();
                ListItem lit = drpMobile.Items.FindByValue(Convert.ToString(debtorID));
                if (lit != null) lit.Selected = true;

                drpCustomerCategoryAdd.SelectedValue = Convert.ToString(customerDs.Tables[0].Rows[0]["LedgerCategory"]);

            }
            else
            {
                txtAddress.Text = string.Empty;
                txtAddress2.Text = string.Empty;
                txtAddress3.Text = string.Empty;
                txtCustomerId.Text = string.Empty;
            }

            ShowPendingBillsAuto();
            Panel4.Visible = true;
            
        }
        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }
    }

    protected void chk_CheckedChanged(object sender, EventArgs e)
    {
        if (chk.Checked == false)
        {
            txtCustomerName.Visible = true;
            drpLedger.Visible = false;

            txtCustomerId.Visible = true;
            drpMobile.Visible = false;

            txtAddress.ReadOnly = false;
            txtAddress2.ReadOnly = false;
            txtAddress3.ReadOnly = false;
            txtCustomerId.Enabled = true;
            txtCustomerName.Enabled = true;

            drpCustomerCategoryAdd.Enabled = true;

            totalrow.Visible = false;
            totalrow1.Visible = false;
            totalrow123.Visible = false;
        }
        else
        {
            drpLedger.Visible = true;
            txtCustomerName.Visible = false;

            drpMobile.Visible = true;
            txtCustomerId.Visible = false;

            txtAddress.ReadOnly = true;
            txtAddress2.ReadOnly = true;
            txtAddress3.ReadOnly = true;
            txtCustomerId.Enabled = false;
            txtCustomerName.Enabled = false;

            drpCustomerCategoryAdd.Enabled = false;

            totalrow.Visible = true;
            totalrow1.Visible = true;
            totalrow123.Visible = true;
        }
        //UpdatePanel21.Update();
    }

    protected void chkPayTo_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (chkPayTo.SelectedItem.Text == "Cheque")
            {
                tblBank.Visible = true;
            }
            else
            {
                tblBank.Visible = false;
            }
        }
        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }
    }


    protected void btnSearch_Click(object sender, EventArgs e)
    {
        try
        {
            if (Page.IsValid)
            {
                GrdViewReceipt.DataBind();
            }
        }
        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }
    }
    protected void GrdViewReceipt_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        try
        {
            GrdViewReceipt.SelectedIndex = e.RowIndex;
        }
        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }
    }

    protected void GridSource_Deleting(object sender, ObjectDataSourceMethodEventArgs e)
    {
        try
        {
            if (GrdViewReceipt.SelectedDataKey != null)
                e.InputParameters["TransNo"] = GrdViewReceipt.SelectedDataKey.Value;

            e.InputParameters["Username"] = Request.Cookies["LoggedUserName"].Value;

            string salestype = string.Empty;
            int ScreenNo = 0;
            string ScreenName = string.Empty;

            BusinessLogic bl = new BusinessLogic();

            string usernam = Request.Cookies["LoggedUserName"].Value;

            string connection = Request.Cookies["Company"].Value;
            salestype = "Customer Receipt";
            ScreenName = "Customer Receipt";
            int DebitorID = 0;
            string TransDate = string.Empty;
            double Amount = 0;
            string PayTo = string.Empty;
            DataSet ds = bl.GetReceiptForId(connection, int.Parse(GrdViewReceipt.SelectedDataKey.Value.ToString()));
            if (ds != null)
            {
                TransDate = Convert.ToString(ds.Tables[0].Rows[0]["TransDate"].ToString());
                DebitorID = Convert.ToInt32(ds.Tables[0].Rows[0]["DebtorID"]);
                Amount = Convert.ToDouble(ds.Tables[0].Rows[0]["Amount"]);
                PayTo = ds.Tables[0].Rows[0]["paymode"].ToString();
            }

            bool mobile = false;
            bool Email = false;
            string emailsubject = string.Empty;

            string emailcontent = string.Empty;
            if (hdEmailRequired.Value == "YES")
            {
                DataSet dsd = bl.GetLedgerInfoForId(connection, DebitorID);
                var toAddress = "";
                var toAdd = "";
                Int32 ModeofContact = 0;
                int ScreenType = 0;

                if (dsd != null)
                {
                    if (dsd.Tables[0].Rows.Count > 0)
                    {
                        foreach (DataRow dr in dsd.Tables[0].Rows)
                        {
                            toAdd = dr["EmailId"].ToString();
                            ModeofContact = Convert.ToInt32(dr["ModeofContact"]);
                        }
                    }
                }
                

                DataSet dsdd = bl.GetDetailsForScreenNo(connection, ScreenName, "");
                if (dsdd != null)
                {
                    if (dsdd.Tables[0].Rows.Count > 0)
                    {
                        foreach (DataRow dr in dsdd.Tables[0].Rows)
                        {
                            ScreenType = Convert.ToInt32(dr["ScreenType"]);
                            mobile = Convert.ToBoolean(dr["mobile"]);
                            Email = Convert.ToBoolean(dr["Email"]);
                            emailsubject = Convert.ToString(dr["emailsubject"]);
                            emailcontent = Convert.ToString(dr["emailcontent"]);

                            if (ScreenType == 1)
                            {
                                if (dr["Name1"].ToString() == "Sales Executive")
                                {
                                    toAddress = toAdd;
                                }
                                else if (dr["Name1"].ToString() == "Customer")
                                {
                                    if (ModeofContact == 2)
                                    {
                                        toAddress = toAdd;
                                    }
                                    else
                                    {
                                        break;
                                    }
                                }
                                else
                                {
                                    toAddress = toAdd;
                                }
                            }
                            else
                            {
                                toAddress = dr["EmailId"].ToString();
                            }
                            if (Email == true)
                            {
                                //string subject = "Added - Customer Receipt in Branch " + Request.Cookies["Company"].Value;

                                string body = "\n";
                                //body += " Branch           : " + Request.Cookies["Company"].Value + "\n";
                                //body += " Trans No         : " + GrdViewReceipt.SelectedDataKey.Value + "\n";
                                //body += " User Name        : " + Request.Cookies["LoggedUserName"].Value + "\n";
                                //body += " Trans Date       : " + TransDate + "\n";
                                //body += " Amount           : " + Amount + "\n";
                                //body += " Narration        : " + Narration + "\n";
                                //body += " Customer         : " + ddReceivedFrom.SelectedItem.Text + "\n";

                                int index123 = emailcontent.IndexOf("@Branch");
                                body = Request.Cookies["Company"].Value;
                                emailcontent = emailcontent.Remove(index123, 7).Insert(index123, body);

                                int index132 = emailcontent.IndexOf("@PayMode");
                                body = PayTo;
                                emailcontent = emailcontent.Remove(index132, 10).Insert(index132, body);

                                int index312 = emailcontent.IndexOf("@User");
                                body = usernam;
                                emailcontent = emailcontent.Remove(index312, 5).Insert(index312, body);

                                int index2 = emailcontent.IndexOf("@Date");
                                body = TransDate.ToString();
                                emailcontent = emailcontent.Remove(index2, 5).Insert(index2, body);

                                //int index = emailcontent.IndexOf("@Customer");
                                //body = ddReceivedFrom.SelectedItem.Text;
                                //emailcontent = emailcontent.Remove(index, 9).Insert(index, body);

                                int index1 = emailcontent.IndexOf("@Amount");
                                body = Convert.ToString(Amount);
                                emailcontent = emailcontent.Remove(index1, 7).Insert(index1, body);

                                string smtphostname = ConfigurationManager.AppSettings["SmtpHostName"].ToString();
                                int smtpport = Convert.ToInt32(ConfigurationManager.AppSettings["SmtpPortNumber"]);
                                var fromAddress = ConfigurationManager.AppSettings["FromAddress"].ToString();

                                string fromPassword = ConfigurationManager.AppSettings["FromPassword"].ToString();

                                EmailLogic.SendEmail(smtphostname, smtpport, fromAddress, toAddress, emailsubject, emailcontent, fromPassword);

                                //ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('Email sent successfully')", true);

                            }

                        }
                    }
                }
            }


            string conn = bl.CreateConnectionString(Request.Cookies["Company"].Value);
            UtilitySMS utilSMS = new UtilitySMS(conn);
            string UserID = Page.User.Identity.Name;

            string smscontent = string.Empty;
            if (hdSMSRequired.Value == "YES")
            {
                DataSet dsd = bl.GetLedgerInfoForId(connection, DebitorID);
                var toAddress = "";
                var toAdd = "";
                Int32 ModeofContact = 0;
                int ScreenType = 0;

                if (dsd != null)
                {
                    if (dsd.Tables[0].Rows.Count > 0)
                    {
                        foreach (DataRow dr in dsd.Tables[0].Rows)
                        {
                            toAdd = dr["Mobile"].ToString();
                            ModeofContact = Convert.ToInt32(dr["ModeofContact"]);
                        }
                    }
                }


                DataSet dsdd = bl.GetDetailsForScreenNo(connection, ScreenName, "");
                if (dsdd != null)
                {
                    if (dsdd.Tables[0].Rows.Count > 0)
                    {
                        foreach (DataRow dr in dsdd.Tables[0].Rows)
                        {
                            ScreenType = Convert.ToInt32(dr["ScreenType"]);
                            mobile = Convert.ToBoolean(dr["mobile"]);
                            smscontent = Convert.ToString(dr["smscontent"]);

                            if (ScreenType == 1)
                            {
                                if (dr["Name1"].ToString() == "Sales Executive")
                                {
                                    toAddress = toAdd;
                                }
                                else if (dr["Name1"].ToString() == "Customer")
                                {
                                    if (ModeofContact == 1)
                                    {
                                        toAddress = toAdd;
                                    }
                                    else
                                    {
                                        break;
                                    }
                                }
                                else
                                {
                                    toAddress = toAdd;
                                }
                            }
                            else
                            {
                                toAddress = dr["mobile"].ToString();
                            }
                            if (mobile == true)
                            {

                                string body = "\n";

                                int index123 = smscontent.IndexOf("@Branch");
                                body = Request.Cookies["Company"].Value;
                                smscontent = smscontent.Remove(index123, 7).Insert(index123, body);

                                int index132 = smscontent.IndexOf("@PayMode");
                                body = PayTo;
                                smscontent = smscontent.Remove(index132, 10).Insert(index132, body);

                                int index312 = smscontent.IndexOf("@User");
                                body = usernam;
                                smscontent = smscontent.Remove(index312, 5).Insert(index312, body);

                                int index2 = smscontent.IndexOf("@Date");
                                body = TransDate.ToString();
                                smscontent = smscontent.Remove(index2, 5).Insert(index2, body);

                                //int index = emailcontent.IndexOf("@Customer");
                                //body = ddReceivedFrom.SelectedItem.Text;
                                //emailcontent = emailcontent.Remove(index, 9).Insert(index, body);

                                int index1 = smscontent.IndexOf("@Amount");
                                body = Convert.ToString(Amount);
                                smscontent = smscontent.Remove(index1, 7).Insert(index1, body);
                                
                                if (Session["Provider"] != null)
                                {
                                    utilSMS.SendSMS(Session["Provider"].ToString(), Session["Priority"].ToString(), Session["SenderID"].ToString(), Session["UserName"].ToString(), Session["Password"].ToString(), toAddress, smscontent, true, UserID);
                                }


                            }

                        }
                    }
                }

            }

        }
        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }
    }

    protected void drpReceiptType_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if(drpReceiptType.SelectedValue == "1")
            {
                txtAddress.ReadOnly = true;
                txtAddress2.ReadOnly = true;
                txtAddress3.ReadOnly = true;

                drpCustomerCategoryAdd.Enabled = false;

                drpLedger.Visible = true;
                drpMobile.Visible = true;
                txtCustomerId.Enabled = false;
                txtCustomerName.Enabled = false;
                chk.Checked = true;
                chk.Enabled = false;
                txtCustomerId.Visible = false;
                txtCustomerName.Visible = false;
            }
            else
            {
                txtAddress.ReadOnly = false;
                txtAddress2.ReadOnly = false;
                txtAddress3.ReadOnly = false;
                txtCustomerId.Enabled = true;
                txtCustomerName.Enabled = true;
                txtAddress.Text = "";
                txtAddress2.Text = "";
                txtAddress3.Text = "";
                txtCustomerId.Text = "";
                txtCustomerName.Text = "";
                chk.Checked = true;
                chk.Enabled = true;

                drpCustomerCategoryAdd.Enabled = true;
            }
        }
        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }
    }

    protected void drpMobile_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {

            BusinessLogic bl = new BusinessLogic(sDataSource);

            int iLedgerID = Convert.ToInt32(drpMobile.SelectedItem.Value);
                                   
            DataSet customerDs = bl.getAddressInfo(iLedgerID);
            string address = string.Empty;

            if (customerDs != null && customerDs.Tables[0].Rows.Count > 0)
            {
                if (customerDs.Tables[0].Rows[0]["Add1"] != null)
                    txtAddress.Text = customerDs.Tables[0].Rows[0]["Add1"].ToString();

                if (customerDs.Tables[0].Rows[0]["Add2"] != null)
                    txtAddress2.Text = customerDs.Tables[0].Rows[0]["Add2"].ToString();

                if (customerDs.Tables[0].Rows[0]["Add3"] != null)
                    txtAddress3.Text = customerDs.Tables[0].Rows[0]["Add3"].ToString();

                if (customerDs.Tables[0].Rows[0]["Mobile"] != null)
                {
                    txtCustomerId.Text = Convert.ToString(customerDs.Tables[0].Rows[0]["Mobile"]);
                }

                drpLedger.ClearSelection();
                ListItem lit = drpLedger.Items.FindByValue(Convert.ToString(iLedgerID));
                if (lit != null) lit.Selected = true;

                drpCustomerCategoryAdd.SelectedValue = Convert.ToString(customerDs.Tables[0].Rows[0]["LedgerCategory"]);

            }
            else
            {
                txtAddress.Text = string.Empty;
                txtAddress2.Text = string.Empty;
                txtAddress3.Text = string.Empty;
                txtCustomerId.Text = string.Empty;
            }

            ShowPendingBillsAuto();
            Panel4.Visible = true;
        }
        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }

    }

    protected void GrdViewReceipt_RowDeleted(object sender, GridViewDeletedEventArgs e)
    {
        try
        {
            if (e.Exception == null)
            {
                GrdViewReceipt.DataBind();
            }
            else
            {
                if (e.Exception.InnerException != null)
                {
                    StringBuilder script = new StringBuilder();
                    script.Append("alert('You are not allowed to delete the record. Please contact Administrator.');");

                    if (e.Exception.InnerException.Message.IndexOf("Invalid Date") > -1)
                        ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), script.ToString(), true);

                    e.ExceptionHandled = true;
                }
            }
        }
        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }
    }

    protected void EditBill(object sender, GridViewEditEventArgs e)
    {
        GrdBills.EditIndex = e.NewEditIndex;
        DataRow row = ((DataSet)Session["BillData"]).Tables[0].Rows[e.NewEditIndex];
        Session["EditedRow"] = e.NewEditIndex.ToString();
        Session["EditedAmount"] = row["Amount"].ToString();
        GrdBills.DataSource = (DataSet)Session["BillData"];
        GrdBills.DataBind();
    }

    private void calcSum()
    {
        var ds = (DataSet)GrdBills.DataSource;

        if (ds != null)
        {
            if (ds.Tables.Count > 0)
            {
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    if (dr["Amount"] != null)
                    {
                        sumAmt = sumAmt + Convert.ToDouble(dr["Amount"].ToString());
                    }
                }
            }
        }
    }

    private double calcDatasetSum(DataSet ds)
    {
        double total = 0.0;

        if (ds != null)
        {
            if (ds.Tables.Count > 0)
            {
                foreach (DataRow dr in ds.Tables[0].Rows)
                {
                    if (dr["Amount"] != null)
                    {
                        total = total + Convert.ToDouble(dr["Amount"].ToString());
                    }
                }
            }
        }

        return total;
    }

    protected void GrdBills_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Cancel")
        {
            GrdBills.FooterRow.Visible = false;
            var ds = (DataSet)Session["BillData"];
            GrdBills.EditIndex = -1;
            if (ds != null)
            {
                GrdBills.DataSource = ds;
            }
            GrdBills.DataBind();
            lnkAddBills.Visible = true;
            ModalPopupExtender2.Show();
            pnlEdit.Visible = true;
            Error.Text = "";
        }
        else if (e.CommandName == "Edit")
        {
            ModalPopupExtender2.Show();
            lnkAddBills.Visible = false;
        }
        else if (e.CommandName == "Insert")
        {
            try
            {
                ModalPopupExtender2.Show();
                DataTable dt;
                DataRow drNew;
                DataColumn dc;
                DataSet ds;
                BusinessLogic bl = new BusinessLogic(GetConnectionString());

                string billNo = ((TextBox)GrdBills.FooterRow.FindControl("txtAddBillNo")).Text;
                string amount = ((TextBox)GrdBills.FooterRow.FindControl("txtAddBillAmount")).Text;
                string CustomerID = ddReceivedFrom.SelectedValue.ToString().Trim();
                string TransNo = string.Empty;

                if (GrdViewReceipt.SelectedDataKey != null)
                    TransNo = GrdViewReceipt.SelectedDataKey.Value.ToString();
                else
                    TransNo = "";

                if (bl.GetIfBillNoExists(int.Parse(billNo), CustomerID) == 0)
                {
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('BillNo does not Exists. Please check BillNo.')", true);
                    //Error.Text = "BillNo does not Exists. Please check BillNo.";
                    pnlEdit.Visible = true;
                    ModalPopupExtender2.Show();
                    return;
                }

                var isBillExists = CheckIfBillExists(billNo);

                if (isBillExists)
                {
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('BillNo already Exists')", true);
                    //Error.Text = "BillNo already Exists";
                    ModalPopupExtender2.Show();
                    return;
                }


                double eligibleAmount = bl.GetSalesPendingAmount(int.Parse(billNo));

                if (double.Parse(amount) > eligibleAmount)
                {
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('The Amount you entered for BillNo:" + billNo + " is Greater than Pending Sales Amount of " + eligibleAmount.ToString() + ". Please check the Bill Amount')", true);
                    //Error.Text = "The Amount you entered for BillNo:" + billNo + " is Greater than Pending Sales Amount of " + eligibleAmount.ToString() + ". Please check the Bill Amount";
                    ModalPopupExtender2.Show();
                    return;
                }

                if ((Session["BillData"] == null) || (((DataSet)Session["BillData"]).Tables[0].Rows.Count == 0))
                {

                    if (double.Parse(amount) > double.Parse(txtAmount.Text))
                    {
                        ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('Total Bills amount is exceeding the Receipt Amount. Please check the Bill Amount')", true);
                        //Error.Text = "Total Bills amount is exceeding the Receipt Amount. Please check the Bill Amount";
                        ModalPopupExtender2.Show();
                        return;
                    }

                    ds = new DataSet();
                    dt = new DataTable();

                    dc = new DataColumn("ReceiptNo");
                    dt.Columns.Add(dc);

                    dc = new DataColumn("BillNo");
                    dt.Columns.Add(dc);

                    dc = new DataColumn("Amount");
                    dt.Columns.Add(dc);

                    ds.Tables.Add(dt);

                    drNew = dt.NewRow();

                    drNew["ReceiptNo"] = TransNo;
                    drNew["BillNo"] = billNo;
                    drNew["Amount"] = amount;

                    ds.Tables[0].Rows.Add(drNew);

                    Session["BillData"] = ds;
                    GrdBills.DataSource = ds;
                    GrdBills.DataBind();
                    GrdBills.EditIndex = -1;
                    lnkAddBills.Visible = true;

                }
                else
                {
                    ds = (DataSet)Session["BillData"];

                    if ((calcDatasetSum(ds) + double.Parse(amount)) > double.Parse(txtAmount.Text))
                    {
                        ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('Total Bills amount is exceeding the Receipt Amount. Please check the Bill Amount')", true);
                        //Error.Text = "Total Bills amount is exceeding the Receipt Amount. Please check the Bill Amount";
                        ModalPopupExtender2.Show();
                        return;
                    }

                    if (ds.Tables[0].Rows[0]["ReceiptNo"].ToString() == "0")
                    {
                        ds.Tables[0].Rows[0].Delete();
                        ds.Tables[0].AcceptChanges();
                    }

                    drNew = ds.Tables[0].NewRow();
                    drNew["ReceiptNo"] = TransNo;
                    drNew["BillNo"] = billNo;
                    drNew["Amount"] = amount;

                    ds.Tables[0].Rows.Add(drNew);
                    Session["BillData"] = ds;
                    //System.Threading.Thread.Sleep(1000);
                    GrdBills.DataSource = ds;
                    GrdBills.DataBind();
                    GrdBills.EditIndex = -1;
                    lnkAddBills.Visible = true;
                    ModalPopupExtender2.Show();
                    checkPendingBills(ds);
                }

            //}
            //catch (Exception ex)
            //{
            //    if (ex.InnerException != null)
            //    {
            //        StringBuilder script = new StringBuilder();
            //        script.Append("alert('Unit with this name already exists, Please try with a different name.');");

            //        if (ex.InnerException.Message.IndexOf("duplicate values in the index") > -1)
            //            ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), script.ToString(), true);

            //        ModalPopupExtender2.Show();
            //        return;
            //    }
            //}
            }
            catch (Exception ex)
            {
                TroyLiteExceptionManager.HandleException(ex);
                ModalPopupExtender2.Show();
                return;
            }
            finally
            {
                //checkPendingBills();
            }
        }
    }

    protected void GrdBills_RowUpdated(object sender, GridViewUpdatedEventArgs e)
    {
        try
        {
            System.Threading.Thread.Sleep(1000);
            GrdBills.DataBind();
            lnkAddBills.Visible = true;
            //checkPendingBills();
        }
        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }
    }

    private bool CheckIfBillExists(string billNo)
    {
        bool dupFlag = false;

        if (Session["BillData"] != null)
        {
            var checkDs = (DataSet)Session["BillData"];

            foreach (DataRow dR in checkDs.Tables[0].Rows)
            {
                if (dR["BillNo"] != null)
                {
                    if (dR["BillNo"].ToString().Trim() == billNo)
                    {
                        dupFlag = true;
                        break;
                    }
                }
            }
        }

        return dupFlag;
    }

    private int CheckNoOfBillExists(string billNo)
    {
        int count = 0;

        if (Session["BillData"] != null)
        {
            var checkDs = (DataSet)Session["BillData"];

            foreach (DataRow dR in checkDs.Tables[0].Rows)
            {
                if (dR["BillNo"] != null)
                {
                    if (dR["BillNo"].ToString().Trim() == billNo)
                    {
                        count = count + 1;
                    }
                }
            }
        }

        return count;
    }


    protected void GrdBills_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //checkPendingBills();
    }

    protected void GrdBills_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        DataSet ds;

        try
        {
            if (Session["BillData"] != null)
            {
                GridViewRow row = GrdBills.Rows[e.RowIndex];
                ds = (DataSet)Session["BillData"];
                ds.Tables[0].Rows[GrdBills.Rows[e.RowIndex].DataItemIndex].Delete();
                ds.Tables[0].AcceptChanges();
                GrdBills.DataSource = ds;
                GrdBills.DataBind();
                Session["BillData"] = ds;
                ModalPopupExtender2.Show();
            }
        }
        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }
    }

    protected void GrdBills_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        try
        {
            int curRow = 0;
            string billNo = ((TextBox)GrdBills.Rows[e.RowIndex].FindControl("txtBillNo")).Text;
            string amount = ((TextBox)GrdBills.Rows[e.RowIndex].FindControl("txtBillAmount")).Text;
            //string Id = GrdBills.DataKeys[e.RowIndex].Value.ToString();
            string CustomerID = ddReceivedFrom.SelectedValue.ToString().Trim();
            string TransNo = "0";
            ModalPopupExtender2.Show();

            if (GrdViewReceipt.SelectedDataKey != null)
                TransNo = GrdViewReceipt.SelectedDataKey.Value.ToString();


            DataSet ds = (DataSet)Session["BillData"];

            if ((calcDatasetSum(ds) + double.Parse(amount) - double.Parse(Session["EditedAmount"].ToString())) > double.Parse(txtAmount.Text))
            {
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('Total Bills amount is exceeding the Receipt Amount. Please check the Bill Amount')", true);
                //Error.Text = "Total Bills amount is exceeding the Receipt Amount. Please check the Bill Amount";
                return;
            }

            BusinessLogic bl = new BusinessLogic(GetConnectionString());

            if (bl.GetIfBillNoExists(int.Parse(billNo), CustomerID) == 0)
            {
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('BillNo does not Exists. Please check BillNo.')", true);
                //Error.Text = "BillNo does not Exists. Please check BillNo.";
                pnlEdit.Visible = true;
                ModalPopupExtender2.Show();
                return;
            }

            double eligibleAmount = bl.GetSalesPendingAmount(int.Parse(billNo));


            if ((double.Parse(amount) - double.Parse(Session["EditedAmount"].ToString())) > eligibleAmount)
            {
                var eliAmount = double.Parse(Session["EditedAmount"].ToString()) + eligibleAmount;
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('The Amount you entered for BillNo:" + billNo + " is Greater than Pending Sales Amount of " + eliAmount.ToString() + ". Please check the Bill Amount')", true);
                //Error.Text = "The Amount you entered for BillNo:" + billNo + " is Greater than Pending Sales Amount of " + eliAmount.ToString() + ". Please check the Bill Amount";
                return;
            }

            curRow = Convert.ToInt32(Session["EditedRow"].ToString());

            ds.Tables[0].Rows[curRow].BeginEdit();
            ds.Tables[0].Rows[curRow]["BillNo"] = billNo;
            ds.Tables[0].Rows[curRow]["Amount"] = amount;
            ds.Tables[0].Rows[curRow]["ReceiptNo"] = TransNo;

            var isBillExists = CheckNoOfBillExists(billNo);

            if (isBillExists > 1)
            {
                ds.Tables[0].Rows[curRow].RejectChanges();
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('BillNo already Exists')", true);
                //Error.Text = "BillNo already Exists";
                return;
            }

            ds.Tables[0].Rows[curRow].EndEdit();

            ds.Tables[0].Rows[curRow].AcceptChanges();
            GrdBills.DataSource = ds;
            GrdBills.EditIndex = -1;
            GrdBills.DataBind();
            Session["BillData"] = ds;
            lnkAddBills.Visible = true;
            checkPendingBills(ds);
        }
        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }
    }

    private string GetConnectionString()
    {
        string connStr = string.Empty;

        if (Request.Cookies["Company"] != null)
            connStr = System.Configuration.ConfigurationManager.ConnectionStrings[Request.Cookies["Company"].Value].ToString();
        else
            Response.Redirect("~/Login.aspx");

        return connStr;
    }

    protected void GrdBills_RowCreated(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.Pager)
            {
                PresentationUtils.SetPagerButtonStates(GrdBills, e.Row, this);
            }
        }
        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }
    }

    protected void Calc_Click(object sender, EventArgs e)
    {
        try
        {
        }
        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }
    }

    protected void ButtonAdd1_Click(object sender, EventArgs e)
    {
        AddNewRow1();

        double total = 0;
        for (int vLoop = 0; vLoop < GridView2.Rows.Count; vLoop++)
        {
            TextBox txt = (TextBox)GridView2.Rows[vLoop].FindControl("txtAmount");


            if (txt.Text != "")
            {
                total = Convert.ToDouble(txt.Text) + total;
            }
            AmountCalc(total);
        }
       
    }

    private void AddNewRow1()
    {
        int rowIndex = 0;

        if (ViewState["CurrentTable1"] != null)
        {
            DataTable dtCurrentTable = (DataTable)ViewState["CurrentTable1"];
            DataRow drCurrentRow = null;
            if (dtCurrentTable.Rows.Count > 0)
            {
                for (int i = 1; i <= dtCurrentTable.Rows.Count; i++)
                {

                    DropDownList DrpCreditor =
                     (DropDownList)GridView2.Rows[rowIndex].Cells[1].FindControl("txtType");
                    TextBox TextBoxRefNo =
                      (TextBox)GridView2.Rows[rowIndex].Cells[2].FindControl("txtRefNo");
                    DropDownList DrpBank =
                     (DropDownList)GridView2.Rows[rowIndex].Cells[1].FindControl("drpBank");
                    TextBox TextBoxChequeNo =
                      (TextBox)GridView2.Rows[rowIndex].Cells[3].FindControl("txtChequeNo");
                    TextBox TextBoxAmount =
                      (TextBox)GridView2.Rows[rowIndex].Cells[4].FindControl("txtAmount");
                    TextBox TextBoxNarration =
                     (TextBox)GridView2.Rows[rowIndex].Cells[4].FindControl("txtNarration");

                    drCurrentRow = dtCurrentTable.NewRow();
                    drCurrentRow["RowNumber"] = i + 1;

                    dtCurrentTable.Rows[i - 1]["Col1"] = DrpCreditor.SelectedValue;
                    dtCurrentTable.Rows[i - 1]["Col2"] = TextBoxRefNo.Text;
                    dtCurrentTable.Rows[i - 1]["Col3"] = TextBoxAmount.Text;
                    
                    dtCurrentTable.Rows[i - 1]["Col4"] = DrpBank.SelectedValue;
                    dtCurrentTable.Rows[i - 1]["Col5"] = TextBoxChequeNo.Text;
                    dtCurrentTable.Rows[i - 1]["Col6"] = TextBoxNarration.Text;

                    //if (DrpCreditor.SelectedValue =="1")
                    //{
                    //    DrpBank.Enabled = false;
                    //}
                    //else
                    //{
                    //    DrpBank.Enabled = true;
                    //}

                    rowIndex++;
                }
                dtCurrentTable.Rows.Add(drCurrentRow);
                ViewState["CurrentTable1"] = dtCurrentTable;

                GridView2.DataSource = dtCurrentTable;
                GridView2.DataBind();
            }
        }
        else
        {
            Response.Write("ViewState is null");
        }
        SetPreviousData1();
    }

    protected void GridView2_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        SetRowData1();
        if (ViewState["CurrentTable1"] != null)
        {
            DataTable dt = (DataTable)ViewState["CurrentTable1"];
            DataRow drCurrentRow = null;
            int rowIndex = Convert.ToInt32(e.RowIndex);
            if (dt.Rows.Count > 1)
            {
                dt.Rows.Remove(dt.Rows[rowIndex]);
                drCurrentRow = dt.NewRow();
                ViewState["CurrentTable1"] = dt;
                GridView2.DataSource = dt;
                GridView2.DataBind();


                

                for (int i = 0; i < GridView2.Rows.Count; i++)
                {
                    GridView2.Rows[i].Cells[0].Text = Convert.ToString(i + 1);
                }
                SetPreviousData1();

                txtAmount_TextChanged(sender, e);
            }
        }
    }

    private void SetRowData1()
    {
        int rowIndex = 0;

        if (ViewState["CurrentTable1"] != null)
        {
            DataTable dtCurrentTable = (DataTable)ViewState["CurrentTable1"];
            DataRow drCurrentRow = null;
            if (dtCurrentTable.Rows.Count > 0)
            {
                for (int i = 1; i <= dtCurrentTable.Rows.Count; i++)
                {

                    DropDownList DrpCreditor =
                     (DropDownList)GridView2.Rows[rowIndex].Cells[1].FindControl("txtType");
                    TextBox TextBoxRefNo =
                      (TextBox)GridView2.Rows[rowIndex].Cells[2].FindControl("txtRefNo");
                    DropDownList TextBoxBank =
                      (DropDownList)GridView2.Rows[rowIndex].Cells[3].FindControl("drpBank");
                    TextBox TextBoxAmount =
                      (TextBox)GridView2.Rows[rowIndex].Cells[4].FindControl("txtAmount");
                    TextBox TextBoxChequeNo =
                     (TextBox)GridView2.Rows[rowIndex].Cells[4].FindControl("txtChequeNo");
                    TextBox TextBoxNarration =
                     (TextBox)GridView2.Rows[rowIndex].Cells[4].FindControl("txtNarration");

                    drCurrentRow = dtCurrentTable.NewRow();
                    drCurrentRow["RowNumber"] = i + 1;

                    dtCurrentTable.Rows[i - 1]["Col1"] = DrpCreditor.SelectedValue;
                    dtCurrentTable.Rows[i - 1]["Col2"] = TextBoxRefNo.Text;
                    dtCurrentTable.Rows[i - 1]["Col3"] = TextBoxAmount.Text;
                    dtCurrentTable.Rows[i - 1]["Col4"] = TextBoxBank.SelectedValue;
                    dtCurrentTable.Rows[i - 1]["Col5"] = TextBoxChequeNo.Text;

                    dtCurrentTable.Rows[i - 1]["Col6"] = TextBoxNarration.Text;

                    rowIndex++;

                }

                ViewState["CurrentTable1"] = dtCurrentTable;
                GridView2.DataSource = dtCurrentTable;
                GridView2.DataBind();
            }
        }
        else
        {
            Response.Write("ViewState is null");
        }
        SetPreviousData1();
    }

    private void FirstGridViewRow1()
    {
        DataTable dtt = new DataTable();
        DataRow dr = null;
        dtt.Columns.Add(new DataColumn("RowNumber", typeof(string)));
        dtt.Columns.Add(new DataColumn("Col1", typeof(string)));
        dtt.Columns.Add(new DataColumn("Col2", typeof(string)));
        dtt.Columns.Add(new DataColumn("Col3", typeof(string)));
        dtt.Columns.Add(new DataColumn("Col4", typeof(string)));
        dtt.Columns.Add(new DataColumn("Col5", typeof(string)));
        dtt.Columns.Add(new DataColumn("Col6", typeof(string)));
        dr = dtt.NewRow();
        dr["RowNumber"] = 1;
        dr["Col1"] = string.Empty;
        dr["Col2"] = string.Empty;
        dr["Col3"] = string.Empty;
        dr["Col4"] = string.Empty;
        dr["Col5"] = string.Empty;
        dr["Col6"] = string.Empty;
        dtt.Rows.Add(dr);

        ViewState["CurrentTable1"] = dtt;


        GridView2.DataSource = dtt;
        GridView2.DataBind();
    }


    private void SetPreviousData1()
    {
        int rowIndex = 0;
        if (ViewState["CurrentTable1"] != null)
        {
            DataTable dt = (DataTable)ViewState["CurrentTable1"];
            if (dt.Rows.Count > 0)
            {
                for (int i = 0; i < dt.Rows.Count; i++)
                {
                    DropDownList DrpCreditor =
                     (DropDownList)GridView2.Rows[rowIndex].Cells[1].FindControl("txtType");
                    TextBox TextBoxRefNo =
                      (TextBox)GridView2.Rows[rowIndex].Cells[2].FindControl("txtRefNo");
                    DropDownList TextBoxBank =
                      (DropDownList)GridView2.Rows[rowIndex].Cells[3].FindControl("drpBank");
                    TextBox TextBoxAmount =
                      (TextBox)GridView2.Rows[rowIndex].Cells[4].FindControl("txtAmount");
                    TextBox TextBoxChequeNo =
                     (TextBox)GridView2.Rows[rowIndex].Cells[4].FindControl("txtChequeNo");
                    TextBox TextBoxNarration =
                     (TextBox)GridView2.Rows[rowIndex].Cells[4].FindControl("txtNarration");

                    DrpCreditor.SelectedValue = dt.Rows[i]["Col1"].ToString();
                    TextBoxRefNo.Text = dt.Rows[i]["Col2"].ToString();
                    TextBoxAmount.Text = dt.Rows[i]["Col3"].ToString();
                    TextBoxBank.SelectedValue = dt.Rows[i]["Col4"].ToString();
                    TextBoxChequeNo.Text = dt.Rows[i]["Col5"].ToString();
                    TextBoxNarration.Text = dt.Rows[i]["Col6"].ToString();

                    if (DrpCreditor.SelectedValue == "1")
                    {
                        TextBoxBank.Enabled = false;
                        TextBoxChequeNo.Enabled = false;
                    }
                    else
                    {
                        TextBoxBank.Enabled = true;
                        TextBoxChequeNo.Enabled = true;
                    }

                    rowIndex++;

                }
            }
        }
    }


    protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            BusinessLogic bl = new BusinessLogic(sDataSource);
            DataSet ds = new DataSet();

            ds = bl.ListBanks();

            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                var ddl = (DropDownList)e.Row.FindControl("drpBank");
                ddl.Items.Clear();
                ListItem lifzzh = new ListItem("Select Ledger", "0");
                lifzzh.Attributes.Add("style", "color:#006699");
                ddl.Items.Add(lifzzh);
                ddl.DataSource = ds;
                ddl.Items[0].Attributes.Add("background-color", "color:White");
                ddl.DataBind();
                ddl.DataTextField = "LedgerName";
                ddl.DataValueField = "LedgerID";

                var ddll = (DropDownList)e.Row.FindControl("txtType");
                if (ddll.Text == "Cash")
                {
                    var dd = (TextBox)e.Row.FindControl("txtChequeNo");
                    dd.Enabled = false;

                    var ddlll = (DropDownList)e.Row.FindControl("drpBank");
                    ddlll.Enabled = false;
                }
            }
        }
        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }
    }

    protected void SaveButton_Click(object sender, EventArgs e)
    {
        try
        {
            //Button clickedbutton = (Button)sender;
            //clickedbutton.ToolTip = "Button Already clicked";
            //clickedbutton.Enabled = false;

            DataSet dsData = (DataSet)Session["BillData"];

            string ChequeNot = string.Empty;
            ChequeNot = txtChequeNo.Text;

            if ((chkPayTo.SelectedValue == "Cheque") || (chkPayTo.SelectedValue == "Card"))
            {
                if ((ChequeNot == "") && (int.Parse(ddBanks.SelectedValue) == 0))
                {
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('Bank Name And Cheque No Mandatory');", true);
                    ModalPopupExtender2.Show();
                    return;
                }
                else if (ChequeNot == "")
                {
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('Cheque No Mandatory');", true);
                    ModalPopupExtender2.Show();
                    return;
                }
                else if (int.Parse(ddBanks.SelectedValue) == 0)
                {
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('Bank Name Mandatory');", true);
                    ModalPopupExtender2.Show();
                    return;
                }
            }

            if (calcDatasetSum(dsData) > double.Parse(txtAmount.Text))
            {
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('Total Bills amount is exceeding the Receipt Amount. Please check the Bill Amount')", true);
                return;
            }


            //if (chkPayTo.SelectedValue == "Cheque")
            //{
            //    cvBank.Enabled = true;
            //    rvChequeNo.Enabled = true;
            //}
            //else
            //{
            //    cvBank.Enabled = false;
            //    rvChequeNo.Enabled = false;
            //}

            Page.Validate();

            if (Page.IsValid)
            {

                int CreditorID = int.Parse(ddReceivedFrom.SelectedValue);

                string RefNo = txtRefNo.Text;

                DateTime TransDate = DateTime.Parse(txtTransDate.Text);

                int DebitorID = 0;
                string Paymode = string.Empty;
                double Amount = 0.0;
                string Narration = string.Empty;
                string VoucherType = string.Empty;
                string ChequeNo = string.Empty;

                if (chkPayTo.SelectedValue == "Cash")
                {
                    DebitorID = 1;
                    Paymode = "Cash";
                }
                else if (chkPayTo.SelectedValue == "Cheque")
                {
                    DebitorID = int.Parse(ddBanks.SelectedValue);
                    Paymode = "Cheque";
                }
                else if (chkPayTo.SelectedValue == "Card")
                {
                    DebitorID = int.Parse(ddBanks.SelectedValue);
                    Paymode = "Card";
                }

                Amount = double.Parse(txtAmount.Text);
                Narration = txtNarration.Text;
                VoucherType = "Receipt";
                ChequeNo = txtChequeNo.Text;

                BusinessLogic bl = new BusinessLogic();
                string connection = Request.Cookies["Company"].Value;

                //if (chkPayTo.SelectedValue == "Cheque")
                //{
                //    if (ChequeNo != "")
                //    {
                //        if (bl.IsChequeNoAlreadyPresent(connection, ChequeNo))
                //        {
                //            ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('Cheque No Already Billed')", true);
                //            return;
                //        }

                //        DataSet dsdat = new DataSet();
                //        dsdat = bl.GetChequeNoGiven(connection, ChequeNo);
                //        string datad = string.Empty;

                //        Int32 set = 0;
                //        Int32 setdd = 0;

                //        Int32 Cheque = 0;
                //        Cheque = Convert.ToInt32(txtChequeNo.Text);

                //        if (dsdat != null)
                //        {
                //            if (dsdat.Tables[0].Rows.Count > 0)
                //            {
                //                foreach (DataRow dr in dsdat.Tables[0].Rows)
                //                {
                //                    set = Convert.ToInt32(dr["FromChequeNo"]);
                //                    setdd = Convert.ToInt32(dr["ToChequeNo"]);

                //                    if ((Cheque >= set) && (Cheque <= setdd))
                //                    {
                //                        datad = "Y";
                //                        break;
                //                    }
                //                    else
                //                    {
                //                        datad = "N";
                //                    }
                //                }
                //                if (datad == "N")
                //                {
                //                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('Cheque No Not Found in Cheque Book')", true);
                //                    return;
                //                }
                //            }
                //        }
                //    }
                //}

                if (hdSMSRequired.Value == "YES")
                {

                    if (txtMobile.Text != "")
                        hdMobile.Value = txtMobile.Text;

                    hdText.Value = "Thank you for Payment of Rs." + txtAmount.Text;

                }


                string conn = GetConnectionString();
                int OutPut = 0;

                DataSet ds = (DataSet)Session["BillData"];


                //if (ds == null)
                //{
                //    ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('Not given the Bill Details')", true);

                //}

                string usernam = Request.Cookies["LoggedUserName"].Value;

                bl.InsertCustReceipt(out OutPut, conn, RefNo, TransDate, DebitorID, CreditorID, Amount, Narration, VoucherType, ChequeNo, Paymode, ds, usernam);

                ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('Receipt Saved Successfully. Transaction No : " + OutPut.ToString() + "');", true);

                if (hdSMS.Value == "YES")
                {
                    UtilitySMS utilSMS = new UtilitySMS(conn);
                    string UserID = Page.User.Identity.Name;

                    if (Session["Provider"] != null)
                        utilSMS.SendSMS(Session["Provider"].ToString(), Session["Priority"].ToString(), Session["SenderID"].ToString(), Session["UserName"].ToString(), Session["Password"].ToString(), hdMobile.Value, hdText.Value, true, UserID);
                    else
                    {
                        if (hdMobile.Value != "")
                            ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('you are not configured to send SMS. Please contact Administrator.');", true);
                    }
                }


                string salestype = string.Empty;
                int ScreenNo = 0;
                string ScreenName = string.Empty;

                salestype = "Customer Receipt";
                ScreenName = "Customer Receipt";
                
                //DataSet dsddd = bl.GetScreenNoForScreenName(connection, ScreenName);
                //if (dsddd != null)
                //{
                //    if (dsddd.Tables[0].Rows.Count > 0)
                //    {
                //        foreach (DataRow dr in dsddd.Tables[0].Rows)
                //        {
                //            ScreenNo = Convert.ToInt32(dr["ScreenNo"]);
                //        }
                //    }
                //}
                bool mobile = false;
                bool Email = false;
                string emailsubject = string.Empty;

                string emailcontent = string.Empty;
                if (hdEmailRequired.Value == "YES")
                {
                    DataSet dsd = bl.GetLedgerInfoForId(connection, DebitorID);
                    var toAddress = "";
                    var toAdd = "";
                    Int32 ModeofContact = 0;
                    int ScreenType = 0;

                    if (dsd != null)
                    {
                        if (dsd.Tables[0].Rows.Count > 0)
                        {
                            foreach (DataRow dr in dsd.Tables[0].Rows)
                            {
                                toAdd = dr["EmailId"].ToString();
                                ModeofContact = Convert.ToInt32(dr["ModeofContact"]);
                            }
                        }
                    }


                    DataSet dsdd = bl.GetDetailsForScreenNo(connection, ScreenName, "");
                    if (dsdd != null)
                    {
                        if (dsdd.Tables[0].Rows.Count > 0)
                        {
                            foreach (DataRow dr in dsdd.Tables[0].Rows)
                            {
                                ScreenType = Convert.ToInt32(dr["ScreenType"]);
                                mobile = Convert.ToBoolean(dr["mobile"]);
                                Email = Convert.ToBoolean(dr["Email"]);
                                emailsubject = Convert.ToString(dr["emailsubject"]);
                                emailcontent = Convert.ToString(dr["emailcontent"]);

                                if (ScreenType == 1)
                                {
                                    if (dr["Name1"].ToString() == "Sales Executive")
                                    {
                                        toAddress = toAdd;
                                    }
                                    else if (dr["Name1"].ToString() == "Customer")
                                    {
                                        if (ModeofContact == 2)
                                        {
                                            toAddress = toAdd;
                                        }
                                        else
                                        {
                                            break;
                                        }
                                    }
                                    else
                                    {
                                        toAddress = toAdd;
                                    }
                                }
                                else
                                {
                                    toAddress = dr["EmailId"].ToString();
                                }
                                if (Email == true)
                                {
                                    //string subject = "Added - Customer Receipt in Branch " + Request.Cookies["Company"].Value;

                                    string body = "\n";
                                    //body += " Branch           : " + Request.Cookies["Company"].Value + "\n";
                                    //body += " Trans No         : " + GrdViewReceipt.SelectedDataKey.Value + "\n";
                                    //body += " User Name        : " + Request.Cookies["LoggedUserName"].Value + "\n";
                                    //body += " Trans Date       : " + TransDate + "\n";
                                    //body += " Amount           : " + Amount + "\n";
                                    //body += " Narration        : " + Narration + "\n";
                                    //body += " Customer         : " + ddReceivedFrom.SelectedItem.Text + "\n";

                                    int index123 = emailcontent.IndexOf("@Branch");
                                    body = Request.Cookies["Company"].Value;
                                    emailcontent = emailcontent.Remove(index123, 7).Insert(index123, body);

                                    int index132 = emailcontent.IndexOf("@Narration");
                                    body = Narration;
                                    emailcontent = emailcontent.Remove(index132, 10).Insert(index132, body);

                                    int index312 = emailcontent.IndexOf("@User");
                                    body = usernam;
                                    emailcontent = emailcontent.Remove(index312, 5).Insert(index312, body);

                                    int index2 = emailcontent.IndexOf("@Date");
                                    body = TransDate.ToString();
                                    emailcontent = emailcontent.Remove(index2, 5).Insert(index2, body);

                                    int index = emailcontent.IndexOf("@Customer");
                                    body = ddReceivedFrom.SelectedItem.Text;
                                    emailcontent = emailcontent.Remove(index, 9).Insert(index, body);

                                    int index1 = emailcontent.IndexOf("@Amount");
                                    body = Convert.ToString(Amount);
                                    emailcontent = emailcontent.Remove(index1, 7).Insert(index1, body);

                                    string smtphostname = ConfigurationManager.AppSettings["SmtpHostName"].ToString();
                                    int smtpport = Convert.ToInt32(ConfigurationManager.AppSettings["SmtpPortNumber"]);
                                    var fromAddress = ConfigurationManager.AppSettings["FromAddress"].ToString();

                                    string fromPassword = ConfigurationManager.AppSettings["FromPassword"].ToString();

                                    EmailLogic.SendEmail(smtphostname, smtpport, fromAddress, toAddress, emailsubject, emailcontent, fromPassword);

                                    //ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('Email sent successfully')", true);

                                }
                                
                            }
                        }
                    }
                }

                pnlEdit.Visible = false;
                ModalPopupExtender2.Hide();
                lnkBtnAdd.Visible = true;
                //MyAccordion.Visible = true;
                GrdViewReceipt.Visible = true;
                GrdViewReceipt.DataBind();
                ClearPanel();
                UpdatePanelPage.Update();

            }
        }
        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }
    }

    protected void ShowPendingSales_Click(object sender, EventArgs e)
    {
        try
        {
            ModalPopupExtender1.Show();
            GrdViewSales.PageSize = 6;
        }
        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }
    }

    protected void UpdateButton_Click(object sender, EventArgs e)
    {
        try
        {
            DataSet dsData = (DataSet)Session["BillData"];

            string ChequeNot = string.Empty;
            ChequeNot = txtChequeNo.Text;

            if ((chkPayTo.SelectedValue == "Cheque") || (chkPayTo.SelectedValue == "Card"))
            {
                if ((ChequeNot == "") && (int.Parse(ddBanks.SelectedValue) == 0))
                {
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('Bank Name And Cheque No Mandatory');", true);
                    ModalPopupExtender2.Show();
                    return;
                }
                else if (ChequeNot == "")
                {
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('Cheque No Mandatory');", true);
                    ModalPopupExtender2.Show();
                    return;
                }
                else if (int.Parse(ddBanks.SelectedValue) == 0)
                {
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('Bank Name Mandatory');", true);
                    ModalPopupExtender2.Show();
                    return;
                }
            }


            if (calcDatasetSum(dsData) > double.Parse(txtAmount.Text))
            {
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('Total Bills amount is exceeding the Receipt Amount. Please check the Bill Amount')", true);
                return;
            }


            //if (chkPayTo.SelectedValue == "Cheque")
            //{
            //    cvBank.Enabled = true;
            //    rvChequeNo.Enabled = true;
            //}
            //else
            //{
            //    cvBank.Enabled = false;
            //    rvChequeNo.Enabled = false;
            //}

            Page.Validate();

            if (Page.IsValid)
            {

                int CreditorID = int.Parse(ddReceivedFrom.SelectedValue);

                string RefNo = txtRefNo.Text;

                DateTime TransDate = DateTime.Parse(txtTransDate.Text);

                int DebitorID = 0;
                string Paymode = string.Empty;
                double Amount = 0.0;
                string Narration = string.Empty;
                string VoucherType = string.Empty;
                string ChequeNo = string.Empty;
                int TransNo = 0;

                if (chkPayTo.SelectedValue == "Cash")
                {
                    DebitorID = 1;
                    Paymode = "Cash";
                }
                else if (chkPayTo.SelectedValue == "Cheque")
                {
                    DebitorID = int.Parse(ddBanks.SelectedValue);
                    Paymode = "Cheque";
                }
                else if (chkPayTo.SelectedValue == "Card")
                {
                    DebitorID = int.Parse(ddBanks.SelectedValue);
                    Paymode = "Card";
                }

                Amount = double.Parse(txtAmount.Text);
                Narration = txtNarration.Text;
                VoucherType = "Receipt";
                ChequeNo = txtChequeNo.Text;

                BusinessLogic bl = new BusinessLogic();

                string connection = Request.Cookies["Company"].Value;

                //if (chkPayTo.SelectedValue == "Cheque")
                //{
                //    if (ChequeNo != "")
                //    {
                //        if (bl.IsChequeNoAlreadyPresent(connection, ChequeNo))
                //        {
                //            ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('Cheque No Already Billed')", true);
                //            return;
                //        }

                //        DataSet dsdat = new DataSet();
                //        dsdat = bl.GetChequeNoGiven(connection, ChequeNo);
                //        string datad = string.Empty;

                //        Int32 set = 0;
                //        Int32 setdd = 0;

                //        Int32 Cheque = 0;
                //        Cheque = Convert.ToInt32(txtChequeNo.Text);

                //        if (dsdat != null)
                //        {
                //            if (dsdat.Tables[0].Rows.Count > 0)
                //            {
                //                foreach (DataRow dr in dsdat.Tables[0].Rows)
                //                {
                //                    set = Convert.ToInt32(dr["FromChequeNo"]);
                //                    setdd = Convert.ToInt32(dr["ToChequeNo"]);

                //                    if ((Cheque >= set) && (Cheque <= setdd))
                //                    {
                //                        datad = "Y";
                //                        break;
                //                    }
                //                    else
                //                    {
                //                        datad = "N";
                //                    }
                //                }
                //                if (datad == "N")
                //                {
                //                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('Cheque No Not Found in Cheque Book')", true);
                //                    return;
                //                }
                //            }
                //        }
                //    }
                //}


                TransNo = int.Parse(GrdViewReceipt.SelectedDataKey.Value.ToString());

                if (hdSMSRequired.Value == "YES")
                {

                    if (txtMobile.Text != "")
                        hdMobile.Value = txtMobile.Text;

                    hdText.Value = "Thank you for Payment of Rs." + txtAmount.Text;

                }


                string conn = GetConnectionString();
                int OutPut = 0;

                DataSet ds = (DataSet)Session["BillData"];

                string usernam = Request.Cookies["LoggedUserName"].Value;

                bl.UpdateCustReceipt(out OutPut, conn, TransNo, RefNo, TransDate, DebitorID, CreditorID, Amount, Narration, VoucherType, ChequeNo, Paymode, ds, usernam);

                ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('Receipt Updated Successfully. Transaction No : " + OutPut.ToString() + "');", true);

                UtilitySMS utilSMS = new UtilitySMS(conn);
                string UserID = Page.User.Identity.Name;

                if (hdSMS.Value == "YES")
                {
                    

                    if (Session["Provider"] != null)
                        utilSMS.SendSMS(Session["Provider"].ToString(), Session["Priority"].ToString(), Session["SenderID"].ToString(), Session["UserName"].ToString(), Session["Password"].ToString(), hdMobile.Value, hdText.Value, true, UserID);
                    else
                    {
                        if (hdMobile.Value != "")
                            ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('you are not configured to send SMS. Please contact Administrator.');", true);
                    }
                }

                string salestype = string.Empty;
                int ScreenNo = 0;
                string ScreenName = string.Empty;

                salestype = "Customer Receipt";
                ScreenName = "Customer Receipt";

                bool mobile = false;
                bool Email = false;
                string emailsubject = string.Empty;

                string emailcontent = string.Empty;
                if (hdEmailRequired.Value == "YES")
                {
                    DataSet dsd = bl.GetLedgerInfoForId(connection, DebitorID);
                    var toAddress = "";
                    var toAdd = "";
                    Int32 ModeofContact = 0;
                    int ScreenType = 0;

                    if (dsd != null)
                    {
                        if (dsd.Tables[0].Rows.Count > 0)
                        {
                            foreach (DataRow dr in dsd.Tables[0].Rows)
                            {
                                toAdd = dr["EmailId"].ToString();
                                ModeofContact = Convert.ToInt32(dr["ModeofContact"]);
                            }
                        }
                    }


                    DataSet dsdd = bl.GetDetailsForScreenNo(connection, ScreenName, "");
                    if (dsdd != null)
                    {
                        if (dsdd.Tables[0].Rows.Count > 0)
                        {
                            foreach (DataRow dr in dsdd.Tables[0].Rows)
                            {
                                ScreenType = Convert.ToInt32(dr["ScreenType"]);
                                mobile = Convert.ToBoolean(dr["mobile"]);
                                Email = Convert.ToBoolean(dr["Email"]);
                                emailsubject = Convert.ToString(dr["emailsubject"]);
                                emailcontent = Convert.ToString(dr["emailcontent"]);

                                if (ScreenType == 1)
                                {
                                    if (dr["Name1"].ToString() == "Sales Executive")
                                    {
                                        toAddress = toAdd;
                                    }
                                    else if (dr["Name1"].ToString() == "Customer")
                                    {
                                        if (ModeofContact == 2)
                                        {
                                            toAddress = toAdd;
                                        }
                                        else
                                        {
                                            break;
                                        }
                                    }
                                    else
                                    {
                                        toAddress = toAdd;
                                    }
                                }
                                else
                                {
                                    toAddress = dr["EmailId"].ToString();
                                }
                                if (Email == true)
                                {
                                    //string subject = "Added - Customer Receipt in Branch " + Request.Cookies["Company"].Value;

                                    string body = "\n";

                                    int index123 = emailcontent.IndexOf("@Branch");
                                    body = Request.Cookies["Company"].Value;
                                    emailcontent = emailcontent.Remove(index123, 7).Insert(index123, body);

                                    int index132 = emailcontent.IndexOf("@Narration");
                                    body = Narration;
                                    emailcontent = emailcontent.Remove(index132, 10).Insert(index132, body);

                                    int index312 = emailcontent.IndexOf("@User");
                                    body = usernam;
                                    emailcontent = emailcontent.Remove(index312, 5).Insert(index312, body);

                                    int index2 = emailcontent.IndexOf("@Date");
                                    body = TransDate.ToString();
                                    emailcontent = emailcontent.Remove(index2, 5).Insert(index2, body);

                                    int index = emailcontent.IndexOf("@Customer");
                                    body = ddReceivedFrom.SelectedItem.Text;
                                    emailcontent = emailcontent.Remove(index, 9).Insert(index, body);

                                    int index1 = emailcontent.IndexOf("@Amount");
                                    body = Convert.ToString(Amount);
                                    emailcontent = emailcontent.Remove(index1, 7).Insert(index1, body);

                                    string smtphostname = ConfigurationManager.AppSettings["SmtpHostName"].ToString();
                                    int smtpport = Convert.ToInt32(ConfigurationManager.AppSettings["SmtpPortNumber"]);
                                    var fromAddress = ConfigurationManager.AppSettings["FromAddress"].ToString();

                                    string fromPassword = ConfigurationManager.AppSettings["FromPassword"].ToString();

                                    EmailLogic.SendEmail(smtphostname, smtpport, fromAddress, toAddress, emailsubject, emailcontent, fromPassword);

                                    //ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('Email sent successfully')", true);

                                }

                            }
                        }
                    }
                }


                //string conn = bl.CreateConnectionString(Request.Cookies["Company"].Value);
                //UtilitySMS utilSMS = new UtilitySMS(conn);
                //string UserID = Page.User.Identity.Name;

                string smscontent = string.Empty;
                if (hdSMSRequired.Value == "YES")
                {
                    DataSet dsd = bl.GetLedgerInfoForId(connection, CreditorID);
                    var toAddress = "";
                    var toAdd = "";
                    Int32 ModeofContact = 0;
                    int ScreenType = 0;

                    if (dsd != null)
                    {
                        if (dsd.Tables[0].Rows.Count > 0)
                        {
                            foreach (DataRow dr in dsd.Tables[0].Rows)
                            {
                                toAdd = dr["Mobile"].ToString();
                                ModeofContact = Convert.ToInt32(dr["ModeofContact"]);
                            }
                        }
                    }

                    
                                DataSet dsdd = bl.GetDetailsForScreenNo(connection, ScreenName, "");
                                if (dsdd != null)
                                {
                                    if (dsdd.Tables[0].Rows.Count > 0)
                                    {
                                        foreach (DataRow dr in dsdd.Tables[0].Rows)
                                        {
                                            ScreenType = Convert.ToInt32(dr["ScreenType"]);
                                            mobile = Convert.ToBoolean(dr["mobile"]);
                                            smscontent = Convert.ToString(dr["smscontent"]);

                                            if (ScreenType == 1)
                                            {
                                                if (dr["Name1"].ToString() == "Sales Executive")
                                                {
                                                    toAddress = toAdd;
                                                }
                                                else if (dr["Name1"].ToString() == "Customer")
                                                {
                                                    if (ModeofContact == 1)
                                                    {
                                                        toAddress = toAdd;
                                                    }
                                                    else
                                                    {
                                                        break;
                                                    }
                                                }
                                                else
                                                {
                                                    toAddress = toAdd;
                                                }
                                            }
                                            else
                                            {
                                                toAddress = dr["mobile"].ToString();
                                            }
                                            if (mobile == true)
                                            {

                                                string body = "\n";

                                                int index123 = smscontent.IndexOf("@Branch");
                                                body = Request.Cookies["Company"].Value;
                                                smscontent = smscontent.Remove(index123, 7).Insert(index123, body);

                                                int index132 = smscontent.IndexOf("@Narration");
                                                body = Narration;
                                                smscontent = smscontent.Remove(index132, 10).Insert(index132, body);

                                                int index312 = smscontent.IndexOf("@User");
                                                body = usernam;
                                                smscontent = smscontent.Remove(index312, 5).Insert(index312, body);

                                                int index2 = smscontent.IndexOf("@Date");
                                                body = TransDate.ToString();
                                                smscontent = smscontent.Remove(index2, 5).Insert(index2, body);

                                                int index = smscontent.IndexOf("@Customer");
                                                body = ddReceivedFrom.SelectedItem.Text;
                                                smscontent = smscontent.Remove(index, 9).Insert(index, body);

                                                int index1 = smscontent.IndexOf("@Amount");
                                                body = Convert.ToString(Amount);
                                                smscontent = smscontent.Remove(index1, 7).Insert(index1, body);


                                                if (Session["Provider"] != null)
                                                {
                                                    utilSMS.SendSMS(Session["Provider"].ToString(), Session["Priority"].ToString(), Session["SenderID"].ToString(), Session["UserName"].ToString(), Session["Password"].ToString(), toAddress, smscontent, true, UserID);
                                                }


                                            }

                                        }
                                    }
                                }
                           
                }

                pnlEdit.Visible = false;
                //lnkBtnAdd.Visible = true;
                ////MyAccordion.Visible = true;
                //GrdViewReceipt.Visible = true;
                //ModalPopupExtender2.Hide();
                //popUp.Visible = false;
                GrdViewReceipt.DataBind();
                ClearPanel();
                UpdatePanelPage.Update();

            }
        }
        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }
    }
}
