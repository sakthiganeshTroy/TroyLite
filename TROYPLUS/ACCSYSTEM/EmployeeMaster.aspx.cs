﻿﻿using System;
using System.Configuration;
using System.Data;
using System.Drawing;
using System.Text;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class EmployeeMaster : System.Web.UI.Page
{
    private string sDataSource = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            sDataSource = ConfigurationManager.ConnectionStrings[Request.Cookies["Company"].Value].ToString();

            if (!IsPostBack)
            {
                string connStr = string.Empty;

                if (Request.Cookies["Company"] != null)
                    connStr = System.Configuration.ConfigurationManager.ConnectionStrings[Request.Cookies["Company"].Value].ToString();
                else
                    Response.Redirect("~/Login.aspx");

                string dbfileName = connStr.Remove(0, connStr.LastIndexOf(@"App_Data\") + 9);
                dbfileName = dbfileName.Remove(dbfileName.LastIndexOf(";Persist Security Info"));
                BusinessLogic objChk = new BusinessLogic();

                if (objChk.CheckForOffline(Server.MapPath("Offline\\" + dbfileName + ".offline")))
                {
                    lnkBtnAdd.Visible = false;
                    GrdEmp.Columns[9].Visible = false;
                    GrdEmp.Columns[10].Visible = false;
                }

                GrdEmp.PageSize = 8;

                BindEmp();
                loadEmp();
                loadEmployeeRoles();
                string connection = Request.Cookies["Company"].Value;
                string usernam = Request.Cookies["LoggedUserName"].Value;
                BusinessLogic bl = new BusinessLogic(sDataSource);

                if (bl.CheckUserHaveAdd(usernam, "EMPMST"))
                {
                    lnkBtnAdd.Enabled = false;
                    lnkBtnAdd.ToolTip = "You are not allowed to make Add New ";
                }
                else
                {
                    lnkBtnAdd.Enabled = true;
                    lnkBtnAdd.ToolTip = "Click to Add New ";
                }


            }
        }
        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }
    }

    protected void GrdEmp_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                BusinessLogic bl = new BusinessLogic(sDataSource);
                string connection = Request.Cookies["Company"].Value;
                string usernam = Request.Cookies["LoggedUserName"].Value;

                if (bl.CheckUserHaveEdit(usernam, "EMPMST"))
                {
                    ((ImageButton)e.Row.FindControl("btnEdit")).Visible = false;
                    ((ImageButton)e.Row.FindControl("btnEditDisabled")).Visible = true;
                }

                if (bl.CheckUserHaveDelete(usernam, "EMPMST"))
                {
                    ((ImageButton)e.Row.FindControl("lnkB")).Visible = false;
                    ((ImageButton)e.Row.FindControl("lnkBDisabled")).Visible = true;
                }
            }
        }
        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }
    }

    private void BindEmp()
    {
        sDataSource = ConfigurationManager.ConnectionStrings[Request.Cookies["Company"].Value].ToString();
        BusinessLogic bl = new BusinessLogic(sDataSource);
        int empNO = 0;
        string sEmpName = string.Empty;
        string sDesig = string.Empty;
        string dDOJ = string.Empty;

        string textt = string.Empty;
        string dropd = string.Empty;

        string connection = Request.Cookies["Company"].Value;

        //if (txtSEmpno.Text.Trim() != string.Empty)
        //    empNO = Convert.ToInt32(txtSEmpno.Text.Trim());

        //if (txtSEmpName.Text.Trim() != string.Empty)
        //    sEmpName = txtSEmpName.Text.Trim();

        //if (txtSDesig.Text.Trim() != string.Empty)
        //    sDesig = txtSDesig.Text.Trim();

        //if (txtSDoj.Text.Trim() != string.Empty)
        //    dDOJ = txtSDoj.Text.Trim();

        textt = txtSearch.Text;
        dropd = ddCriteria.SelectedValue;


        DataSet ds = bl.SearchEmployee(connection,textt, dropd);
        GrdEmp.DataSource = ds;
        GrdEmp.DataBind();
    }

    private void loadEmp()
    {
        BusinessLogic bl = new BusinessLogic(sDataSource);
        DataSet ds = new DataSet();
        string connection = ConfigurationManager.ConnectionStrings[Request.Cookies["Company"].Value].ToString();
        drpIncharge.Items.Clear();
        drpIncharge.Items.Add(new ListItem("Select Manager", "0"));
        ds = bl.ListExecutive();
        drpIncharge.DataSource = ds;
        drpIncharge.DataBind();
        drpIncharge.DataTextField = "empFirstName";
        drpIncharge.DataValueField = "empno";

    }

    private void loadEmployeeRoles()
    {
        BusinessLogic bl = new BusinessLogic(sDataSource);
        
        string connection = ConfigurationManager.ConnectionStrings[Request.Cookies["Company"].Value].ToString();
        ddlRole.Items.Clear();
        ddlRole.Items.Add(new ListItem("Select Role", "0"));

        ddlRole.DataSource = bl.ListEmployeeRoles();
        ddlRole.DataTextField = "RoleName";
        ddlRole.DataValueField = "ID";
        ddlRole.DataBind();
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

            pnlEmp.Visible = true;
            btnSave.Visible = true;
            btnSave.Enabled = true;
            btnUpdate.Visible = false;
            btnCancel.Visible = true;
            sDataSource = ConfigurationManager.ConnectionStrings[Request.Cookies["Company"].Value].ToString();
            rowremarks.Visible = false;
            //txtDoj.Text = DateTime.Now.ToString("dd/MM/yyyy");

            DateTime indianStd = TimeZoneInfo.ConvertTimeBySystemTimeZoneId(DateTime.Now, "India Standard Time");
            string dtaa = Convert.ToDateTime(indianStd).ToString("dd/MM/yyyy");
            txtDoj.Text = dtaa;
            loadEmp();
            loadEmployeeRoles();
            ModalPopupExtender2.Show();
            //BusinessLogic bl = new BusinessLogic(sDataSource);
            //int empnum = bl.GetNextEmpno();
            //empnum = empnum + 1;
            //txtEmpno.Text = Convert.ToString(empnum);
            //txtEmpno.Enabled = false;
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
            BindEmp();
        }
        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        try
        {
            sDataSource = ConfigurationManager.ConnectionStrings[Request.Cookies["Company"].Value].ToString();
            BusinessLogic bl = new BusinessLogic(sDataSource);
            int empNO = 0;
            string sEmpFName = string.Empty;
            string sempNO = string.Empty;
            string sEmpMName = string.Empty;
            string sEmpSName = string.Empty;
            string sDesig = string.Empty;
            string sRemarks = string.Empty;
            string sTitle = string.Empty;
            int ManagerId = 0;
            int roleId = 0;

            string dDOJ = string.Empty;
            string dDOB = string.Empty;
            string UserGroup = string.Empty;

            if (Page.IsValid)
            {
                if (txtEmpno.Text.Trim() != string.Empty)
                {
                    empNO = Convert.ToInt32(txtEmpno.Text.Trim());
                    sempNO = txtEmpno.Text.Trim();
                }
                if (txtEmpFName.Text.Trim() != string.Empty)
                    sEmpFName = txtEmpFName.Text.Trim();
                if (txtEmpMName.Text.Trim() != string.Empty)
                    sEmpMName = txtEmpMName.Text.Trim();
                if (txtEmpSName.Text.Trim() != string.Empty)
                    sEmpSName = txtEmpSName.Text.Trim();
                if (txtDesig.Text.Trim() != string.Empty)
                    sDesig = txtDesig.Text.Trim();
                if (txtDoj.Text.Trim() != string.Empty)
                    dDOJ = txtDoj.Text.Trim();
                if (txtDOB.Text.Trim() != string.Empty)
                    dDOB = txtDOB.Text.Trim();
                if (txtRemarks.Text.Trim() != string.Empty)
                    sRemarks = txtRemarks.Text.Trim();
                if (drpIncharge.Text.Trim() != string.Empty)
                    ManagerId = Convert.ToInt32(drpIncharge.SelectedValue);                
                if (txtUserGroup.Text.Trim() != string.Empty)
                    UserGroup = txtUserGroup.Text.Trim();
                if (!string.IsNullOrEmpty(ddlRole.SelectedValue))
                    int.TryParse(ddlRole.SelectedValue, out roleId);

                sTitle = drpTitle.SelectedItem.Text;
                string stype = drptype.SelectedItem.Text;

                string connection = Request.Cookies["Company"].Value;

                //DataSet checkemp = bl.SearchEmp(empNO, "", "", "");
                DataSet checkemp = bl.SearchEmployee(connection, sempNO, "PartnerNo");

                if (checkemp == null || checkemp.Tables[0].Rows.Count == 0)
                {
                    //int empno = bl.InsertEmpDetails(empNO, sTitle, sEmpFName, sEmpMName, sEmpSName, sDesig, sRemarks, dDOJ, dDOB, stype);
                    int empno = bl.InsertEmpDetails(empNO, sTitle, sEmpFName, sEmpMName, sEmpSName, sDesig, sRemarks, dDOJ, dDOB, ManagerId, UserGroup,roleId);

                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('Business Partner Details Saved Successfully.');", true);
                    Reset();
                    ResetSearch();
                    BindEmp();
                    pnlEmp.Visible = false;
                    lnkBtnAdd.Visible = true;
                    txtEmpno.Enabled = true;
                    //MyAccordion.Visible = true;
                    GrdEmp.Visible = true;
                    UpdatePanelPage.Update();
                    ModalPopupExtender2.Hide();
                }
                else
                {
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('Partner No " + empNO + " already Exists. Please try with different number.');", true);
                    ModalPopupExtender2.Show();
                }
            }
        }
        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }
    }
    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        try
        {
            sDataSource = ConfigurationManager.ConnectionStrings[Request.Cookies["Company"].Value].ToString();
            BusinessLogic bl = new BusinessLogic(sDataSource);
            int empNO = 0;
            string sEmpFName = string.Empty;
            string sEmpMName = string.Empty;
            string sEmpSName = string.Empty;
            string sDesig = string.Empty;
            string sRemarks = string.Empty;
            string sTitle = string.Empty;
            int ManagerId = 0;
            int roleId = 0;
            string UserGroup = string.Empty;
            string dDOJ = string.Empty;
            string dDOB = string.Empty;

            if (Page.IsValid)
            {

                if (hdEmp.Value.Trim() != string.Empty)
                    empNO = Convert.ToInt32(hdEmp.Value.Trim());
                if (txtEmpFName.Text.Trim() != string.Empty)
                    sEmpFName = txtEmpFName.Text.Trim();
                if (txtEmpMName.Text.Trim() != string.Empty)
                    sEmpMName = txtEmpMName.Text.Trim();
                if (txtEmpSName.Text.Trim() != string.Empty)
                    sEmpSName = txtEmpSName.Text.Trim();
                if (txtDesig.Text.Trim() != string.Empty)
                    sDesig = txtDesig.Text.Trim();
                if (txtDoj.Text.Trim() != string.Empty)
                    dDOJ = txtDoj.Text.Trim();
                if (txtDOB.Text.Trim() != string.Empty)
                    dDOB = txtDOB.Text.Trim();
                if (txtRemarks.Text.Trim() != string.Empty)
                    sRemarks = txtRemarks.Text.Trim();
                sTitle = drpTitle.SelectedItem.Text;
                string stype = drptype.SelectedItem.Text;

                if (drpIncharge.Text.Trim() != string.Empty)
                    ManagerId = Convert.ToInt32(drpIncharge.SelectedValue);
                if (txtUserGroup.Text.Trim() != string.Empty)
                    UserGroup = txtUserGroup.Text.Trim();
                if (!string.IsNullOrEmpty(ddlRole.SelectedValue))
                    int.TryParse(ddlRole.SelectedValue, out roleId);

                //int empno = bl.UpdateEmpDetails(empNO, sTitle, sEmpFName, sEmpMName, sEmpSName, sDesig, sRemarks, dDOJ, dDOB, stype);
                int empno = bl.UpdateEmpDetails(empNO, sTitle, sEmpFName, sEmpMName, sEmpSName, sDesig, sRemarks, dDOJ, dDOB, ManagerId, UserGroup,roleId);

                ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('Business Partner Details Updated Successfully. Partner No " + empno + "');", true);


                Reset();
                BindEmp();
                btnUpdate.Enabled = false;
                btnSave.Enabled = true;
                ResetSearch();
                pnlEmp.Visible = false;
                lnkBtnAdd.Visible = true;
                txtEmpno.Enabled = true;
                //MyAccordion.Visible = true;
                GrdEmp.Visible = true;
                UpdatePanelPage.Update();
                ModalPopupExtender2.Hide();
            }
        }
        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }
    }
    protected void btnCancel_Click(object sender, EventArgs e)
    {
        try
        {
            Reset();
            //MyAccordion.Visible = true;
            pnlEmp.Visible = false;
            lnkBtnAdd.Visible = true;
            txtEmpno.Enabled = true;
            GrdEmp.Visible = true;
            UpdatePanelPage.Update();
            ModalPopupExtender2.Hide();
        }
        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }
    }
    public void Reset()
    {

        txtEmpno.Text = "";
        txtEmpFName.Text = "";
        txtEmpMName.Text = "";
        txtEmpSName.Text = "";
        txtDOB.Text = "";
        txtRemarks.Text = "";
        txtDesig.Text = "";
        txtDoj.Text = "";
        drpTitle.SelectedIndex = 0;

    }

    public void ResetSearch()
    {
        txtSEmpno.Text = "";
        txtSEmpName.Text = "";
        txtSDesig.Text = "";
        txtSDoj.Text = "";
    }
    protected void ddlPageSelector_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            GrdEmp.PageIndex = ((DropDownList)sender).SelectedIndex;
            BindEmp();
        }
        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }
    }

    protected void GrdEmp_PageIndexChanging(object sender, GridViewPageEventArgs e)
    {
        try
        {
            GrdEmp.PageIndex = e.NewPageIndex;
            BindEmp();
        }
        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }
    }

    protected void GrdEmp_RowCreated(object sender, GridViewRowEventArgs e)
    {
        try
        {
            if (e.Row.RowType == DataControlRowType.Pager)
            {
                PresentationUtils.SetPagerButtonStates(GrdEmp, e.Row, this);
            }
        }
        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }
    }

    protected void GrdEmp_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            GridViewRow row = GrdEmp.SelectedRow;

            int empNo = Convert.ToInt32(GrdEmp.SelectedDataKey.Value);

            sDataSource = ConfigurationManager.ConnectionStrings[Request.Cookies["Company"].Value].ToString();
            BusinessLogic bl = new BusinessLogic(sDataSource);

            DataSet ds = bl.GetEmployeeDetails(empNo);

            if (ds != null)
            {
                hdEmp.Value = Convert.ToString(empNo);
                txtEmpno.Text = Convert.ToString(empNo);
                drpTitle.ClearSelection();
                ListItem li2 = drpTitle.Items.FindByText(ds.Tables[0].Rows[0]["empTitle"].ToString());
                if (li2 != null) li2.Selected = true;

                //drptype.ClearSelection();
                //ListItem li222 = drptype.Items.FindByText(ds.Tables[0].Rows[0]["empType"].ToString());
                //if (li222 != null) li222.Selected = true;

                txtEmpFName.Text = ds.Tables[0].Rows[0]["empFirstName"].ToString();
                txtEmpMName.Text = ds.Tables[0].Rows[0]["empMiddleName"].ToString();
                txtEmpSName.Text = ds.Tables[0].Rows[0]["empSurName"].ToString();
                txtDoj.Text = DateTime.Parse(ds.Tables[0].Rows[0]["empDOJ"].ToString()).ToShortDateString();
                txtDOB.Text = DateTime.Parse(ds.Tables[0].Rows[0]["empDOB"].ToString()).ToShortDateString();
                txtDesig.Text = ds.Tables[0].Rows[0]["empdesig"].ToString();
                txtRemarks.Text = ds.Tables[0].Rows[0]["empRemarks"].ToString(); ;
                rowremarks.Visible = true;
                //BindEmp();
                ddlRole.SelectedValue = ds.Tables[0].Rows[0]["EmployeeRoleId"].ToString();
                btnUpdate.Visible = true;
                btnUpdate.Enabled = true;
                btnSave.Visible = false;
                pnlEmp.Visible = true;
                txtEmpno.Enabled = false;
                GrdEmp.Visible = false;
                ModalPopupExtender2.Show();
            }
        }
        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }
    }

    protected void GrdEmp_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        try
        {
            int empno = (int)GrdEmp.DataKeys[e.RowIndex].Value;

            BusinessLogic bl = new BusinessLogic(sDataSource);
            bl.DeleteEmpDetails(empno);
            BindEmp();
            btnUpdate.Enabled = false;
            btnSave.Enabled = true;
        }
        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }
    }

    protected void GrdEmp_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            if (e.CommandName == "ManagePay")
            {
                string EmpName = string.Empty;
                int EmpId = 0;

                //FormViewManageLeave.Visible = true;
                //FormViewManageLeave.ChangeMode(FormViewMode.Insert);

                string[] args = e.CommandArgument.ToString().Split(new char[] { ':' });
                if (args.Length == 2)
                {
                    EmpName = args[0];

                    EmpId = Convert.ToInt32(args[1]);
                }

                GetPayComponent(string.Empty);

                GetEmpPayComponent(EmpId);

                txtManagePayCompRoleName.Text = EmpName;
                ManagePayRoleID.Value = EmpId.ToString();

                txtfrmDate.Enabled = false;
                btnEditDate.Enabled = false;
                txtDeclaredAmt.Enabled = false;

                txtfrmDate.Text = null;
                txtDeclaredAmt.Text = null;

                ModalPopupExtender3.Show();
                EmployeePayCompPopUp.Visible = true;
            }            

        }
        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }
    }

    #region Private Methods

    public void GetPayComponent(string searchTxt)
    {
        BusinessLogic bLogic = new BusinessLogic(sDataSource);

        DataSet ds = new DataSet();
        ds = bLogic.GetPayCompForEmpManage(searchTxt);

        if (ds != null)
        {
            ManagePayComponentGrid.DataSource = ds.Tables[0];
        }
        else
        {
            ManagePayComponentGrid.DataSource = ds;
        }

        ManagePayComponentGrid.DataBind();
    }

    public void GetEmpPayComponent(int EmpID)
    {
        BusinessLogic bLogic = new BusinessLogic(sDataSource);

        DataSet ds = new DataSet();
        ds = bLogic.GetEmpPayComp(EmpID);

        if (ds != null)
        {
            PayCompRolePayGrid.DataSource = ds.Tables[0];
        }
        else
        {
            PayCompRolePayGrid.DataSource = ds;
        }
        PayCompRolePayGrid.DataBind();
    }

    #endregion

    protected void ManagePayComponentGrid_SelectedIndexChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow row in ManagePayComponentGrid.Rows)
        {
            if (row.RowIndex == ManagePayComponentGrid.SelectedIndex)
            {
                row.BackColor = ColorTranslator.FromHtml("#A1DCF2");
                row.ToolTip = string.Empty;

                //ViewState["PayCompId"] = (int)ManagePayComponentGrid.DataKeys[ManagePayComponentGrid.SelectedIndex].Value;

                txtfrmDate.Enabled = true;
                btnEditDate.Enabled = true;
                txtDeclaredAmt.Enabled = true;

                ModalPopupExtender3.Show();
                EmployeePayCompPopUp.Visible = true;
            }
            else
            {
                row.BackColor = ColorTranslator.FromHtml("#FFFFFF");
                row.ToolTip = "Click to select this row.";

                ModalPopupExtender3.Show();
                EmployeePayCompPopUp.Visible = true;
            }
        }
    }

    protected void ManagePayComponentGrid_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(ManagePayComponentGrid, "Select$" + e.Row.RowIndex);
            e.Row.ToolTip = "Click to select this row.";
        }
    }

    protected void SearchRoleBtn_Click(object sender, EventArgs e)
    {
        //if (roleSearch.Text == "")
        //{
        //    ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('Enter Pay Component Name');", true);
        //    ModalPopupExtender3.Show();
        //    EmployeePayCompPopUp.Visible = true;
        //}
        //else
        //{
            GetPayComponent(roleSearch.Text);

            ModalPopupExtender3.Show();
            EmployeePayCompPopUp.Visible = true;
        //}

    }

    protected void managePayCompAssignbtn_Click(object sender, EventArgs e)
    {
       
    }

    protected void addSelectedBtn_Click(object sender, EventArgs e)
    {
        //Get Selected Index in Grid
        int isValid = 0;
        string Message = string.Empty;
        try
        {
            if (txtfrmDate.Text == null || txtfrmDate.Text == string.Empty)
            {
                isValid = 1;
                Message += " From Date is mandatory.";
            }

            if (txtDeclaredAmt.Text == null || txtDeclaredAmt.Text == string.Empty)
            {
                isValid = 1;
                Message += " Declared Amount is mandatory.";
            }

            if (isValid == 0)
            {

                int EmpID = Convert.ToInt32(ManagePayRoleID.Value);

                if (ManagePayComponentGrid.SelectedDataKey.Value != null)
                {
                    int payCompId = Convert.ToInt32(ManagePayComponentGrid.SelectedDataKey.Value);

                    DateTime frmDate = Convert.ToDateTime(txtfrmDate.Text);

                    int declaredAmount = Convert.ToInt32(txtDeclaredAmt.Text);

                    BusinessLogic bL = new BusinessLogic(sDataSource);

                    bL.InsertEmpPayComp(EmpID, payCompId, frmDate, declaredAmount);

                    GetEmpPayComponent(EmpID);

                    txtDeclaredAmt.Text = null;
                    txtfrmDate.Text = null;
                    txtfrmDate.Enabled = false;
                    btnEditDate.Enabled = false;
                    txtDeclaredAmt.Enabled = false;
                    ManagePayComponentGrid.SelectedIndex = -1;

                    ModalPopupExtender3.Show();
                    EmployeePayCompPopUp.Visible = true;
                }
                else
                {
                    StringBuilder scriptMsg = new StringBuilder();
                    scriptMsg.Append("alert('Please select paycomponent');");
                    ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), scriptMsg.ToString(), true);
                }
            }
            else
            {
                //txtDeclaredAmt.Text = null;
                //txtfrmDate.Text = null;
                //txtfrmDate.Enabled = false;
                //btnEditDate.Enabled = false;
                //txtDeclaredAmt.Enabled = false;
                //ManagePayComponentGrid.SelectedIndex = -1;

                ModalPopupExtender3.Show();
                EmployeePayCompPopUp.Visible = true;


                ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert('Validation : " + Message + "');", true);
            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert(Failed :" + ex.Message.ToString() + "');", true);
        }
    }

    protected void CancelRolePayMapBtn_Click(object sender, EventArgs e)
    {
        
    }

    protected void removeSelectedBtn_Click(object sender, EventArgs e)
    {
        try
        {
            if (PayCompRolePayGrid.SelectedDataKey != null)
            {
                int EmpID = Convert.ToInt32(ManagePayRoleID.Value);

                int payCompId = Convert.ToInt32(PayCompRolePayGrid.SelectedDataKey.Value);

                BusinessLogic bL = new BusinessLogic(sDataSource);

                bL.DeleteEmpPayComp(EmpID, payCompId);

                txtDeclaredAmt.Text = null;
                txtfrmDate.Text = null;
                txtfrmDate.Enabled = false;
                btnEditDate.Enabled = false;
                txtDeclaredAmt.Enabled = false;
                PayCompRolePayGrid.SelectedIndex = -1;
                roleSearch.Text = "";

                GetPayComponent(string.Empty);

                GetEmpPayComponent(EmpID);

                ModalPopupExtender3.Show();
                EmployeePayCompPopUp.Visible = true;

            }
            else
            {
                ModalPopupExtender3.Show();
                EmployeePayCompPopUp.Visible = true;
                StringBuilder scriptMsg = new StringBuilder();
                scriptMsg.Append("alert('Please select paycomponent');");
                ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), scriptMsg.ToString(), true);
            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), "alert(Failed :" + ex.Message.ToString() + "');", true);
        }
    }


    protected void AssignRolePayMapBtn_Click(object sender, EventArgs e)
    {
        if (PayCompRolePayGrid.Rows.Count == 0)
        {
            ModalPopupExtender3.Show();
            EmployeePayCompPopUp.Visible = true;

            StringBuilder scriptMsg = new StringBuilder();
            scriptMsg.Append("alert('Pay Components is empty');");
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), Guid.NewGuid().ToString(), scriptMsg.ToString(), true);
        }
    }
    protected void PayCompRolePayGrid_SelectedIndexChanged(object sender, EventArgs e)
    {
        foreach (GridViewRow row in PayCompRolePayGrid.Rows)
        {
            if (row.RowIndex == PayCompRolePayGrid.SelectedIndex)
            {
                row.BackColor = ColorTranslator.FromHtml("#A1DCF2");
                row.ToolTip = string.Empty;

                //ViewState["PayCompId"] = (int)ManagePayComponentGrid.DataKeys[ManagePayComponentGrid.SelectedIndex].Value;

                //txtfrmDate.Enabled = true;
                //btnEditDate.Enabled = true;
                //txtDeclaredAmt.Enabled = true;

                ModalPopupExtender3.Show();
                EmployeePayCompPopUp.Visible = true;

            }
            else
            {
                row.BackColor = ColorTranslator.FromHtml("#FFFFFF");
                row.ToolTip = "Click to select this row.";

                ModalPopupExtender3.Show();
                EmployeePayCompPopUp.Visible = true;
            }
        }
    }
    protected void PayCompRolePayGrid_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            e.Row.Attributes["onclick"] = Page.ClientScript.GetPostBackClientHyperlink(PayCompRolePayGrid, "Select$" + e.Row.RowIndex);
            e.Row.ToolTip = "Click to select this row.";
        }
    }
}
