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
using System.Xml.Linq;

public partial class ProjectReport : System.Web.UI.Page
{
    private string sDataSource = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            if (!IsPostBack)
            {
                sDataSource = ConfigurationManager.ConnectionStrings[Request.Cookies["Company"].Value].ToString();
                loadEmp();
                loadmanager();
            }
           
        }
        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }
    }
    private void loadEmp()
    {
        BusinessLogic bl = new BusinessLogic(sDataSource);
        DataSet ds = new DataSet();
        string connection = ConfigurationManager.ConnectionStrings[Request.Cookies["Company"].Value].ToString();
        drpEmployee.Items.Clear();
        drpEmployee.Items.Add(new ListItem("Select Manager", "0"));
        ds = bl.ListExecutive();
        drpEmployee.DataSource = ds;
        drpEmployee.DataBind();
        drpEmployee.DataTextField = "empFirstName";
        drpEmployee.DataValueField = "empno";


        drpTaskStatus.Items.Clear();
        drpTaskStatus.Items.Add(new ListItem("---ALL---", "0"));
        DataSet dsd = bl.ListTaskStatusInfo(connection, "", "");
        drpTaskStatus.DataSource = dsd;
        drpTaskStatus.DataBind();
        drpTaskStatus.DataTextField = "Task_Status_Name";
        drpTaskStatus.DataValueField = "Task_Status_Id";

    }

    private void loadmanager()
    {
        BusinessLogic bl = new BusinessLogic(sDataSource);
        DataSet ds = new DataSet();
        string connection = ConfigurationManager.ConnectionStrings[Request.Cookies["Company"].Value].ToString();

        string Username = Request.Cookies["LoggedUserName"].Value;

        ds = bl.ListManager(Username);

        //ds = bl.ListExecutive();
        drpIncharge.DataSource = ds;
        drpIncharge.DataBind();
        drpIncharge.DataTextField = "empFirstName";
        drpIncharge.DataValueField = "empno";



        drpEmployee.Items.Clear();
        drpEmployee.Items.Add(new ListItem("---ALL---", "0"));
        // ds = bl.ListExecutive();
        string Usernam = Request.Cookies["LoggedUserName"].Value;
        ds = bl.ListOwner(connection, Usernam);
        drpEmployee.DataSource = ds;
        drpEmployee.DataBind();
        drpEmployee.DataTextField = "empFirstName";
        drpEmployee.DataValueField = "empno";

    }

    protected void drpmanager_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            BusinessLogic bl = new BusinessLogic(sDataSource);
            int Emp_Id = 0;
            string connection = Request.Cookies["Company"].Value;

            Emp_Id = Convert.ToInt32(drpIncharge.SelectedValue);
            drpproject.Items.Clear();
            drpproject.Items.Add(new ListItem("---ALL---", "0"));
            DataSet ds = bl.getfilterprojectfromemployee(connection, Emp_Id);
            drpproject.DataSource = ds;
            drpproject.DataBind();
            drpproject.DataTextField = "Project_Name";
            drpproject.DataValueField = "Project_Id";
          //  drpproject.Items.Add(new ListItem("---ALL---", "0"));
            
            UpdatePanel5.Update();

            drpproject_SelectedIndexChanged(sender, e);
           
        }

        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }
        // UpdatePanel2.Update();
    }
    protected void drpproject_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            BusinessLogic bl = new BusinessLogic(sDataSource);
            int Project_Id = 0;

            string connection = Request.Cookies["Company"].Value;
            Project_Id = Convert.ToInt32(drpproject.SelectedValue);

                drptask.Items.Clear();
                drptask.Items.Add(new ListItem("---ALL---", "0"));
                DataSet ds = bl.GetDependencytask(connection, Project_Id);

                drptask.DataSource = ds;
                drptask.DataBind();
                drptask.DataTextField = "Task_Name";
                drptask.DataValueField = "Task_Id";
                UpdatePanel2.Update();

                drpdependencytask.Items.Clear();
                drpdependencytask.Items.Add(new ListItem("---ALL---", "0"));
                drpdependencytask.DataSource = ds;
                drpdependencytask.DataBind();
                drpdependencytask.DataTextField = "Task_Name";
                drpdependencytask.DataValueField = "Task_Id";
                UpdatePanel3.Update();

            
           
        }

        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }
      
    }

    protected void radblocktask_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            if (radblocktask.SelectedItem.Text == "YES")
            {
                BusinessLogic bl = new BusinessLogic(sDataSource);
                int Project_Id = 0;

                string connection = Request.Cookies["Company"].Value;
                Project_Id = Convert.ToInt32(drpproject.SelectedValue);

                drptask.Items.Clear();
                drptask.Items.Add(new ListItem("---ALL---", "0"));
                DataSet ds = bl.GetblocktaskYES(connection, Project_Id);

                drptask.DataSource = ds;
                drptask.DataBind();
                drptask.DataTextField = "Task_Name";
                drptask.DataValueField = "Task_Id";
                UpdatePanel2.Update();
                if (drpTaskStatus.SelectedValue != Convert.ToString(0))
                {
                    drpTaskStatus_SelectedIndexChanged(sender, e);
                }
               
            }
            else if (radblocktask.SelectedItem.Text == "NO")
            {
                BusinessLogic bl = new BusinessLogic(sDataSource);
                int Project_Id = 0;

                string connection = Request.Cookies["Company"].Value;
                Project_Id = Convert.ToInt32(drpproject.SelectedValue);

                drptask.Items.Clear();
                drptask.Items.Add(new ListItem("---ALL---", "0"));
                DataSet ds = bl.GetblocktaskNO(connection, Project_Id);

                drptask.DataSource = ds;
                drptask.DataBind();
                drptask.DataTextField = "Task_Name";
                drptask.DataValueField = "Task_Id";
                UpdatePanel2.Update();
                if (drpTaskStatus.SelectedValue != Convert.ToString(0))
                {
                    drpTaskStatus_SelectedIndexChanged(sender, e);
                }
            }
          
        }
        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }
    }
    protected void drpTaskStatus_SelectedIndexChanged (object sender, EventArgs e)
    {
        try
        {
            BusinessLogic bl = new BusinessLogic(sDataSource);
            int stat_Id = 0;
            int pro_Id = 0;
          
            string connection = Request.Cookies["Company"].Value;

            stat_Id = Convert.ToInt32(drpTaskStatus.SelectedValue);
            pro_Id = Convert.ToInt32(drpproject.SelectedValue);
            if (radblocktask.SelectedItem.Text == "YES" && drpproject.SelectedValue != null && radisactive.SelectedItem.Text == "YES")
            {



                drptask.Items.Clear();
               
                drptask.Items.Add(new ListItem("---ALL---", "0"));
                DataSet ds = bl.Getstatustasksyes(connection, stat_Id, pro_Id);
                drptask.DataSource = ds;
                drptask.DataBind();
                drptask.DataTextField = "Task_Name";
                drptask.DataValueField = "Task_Id";
                UpdatePanel2.Update();
               // drpemployee_SelectedIndexChanged(sender, e);
            }
            else if (radblocktask.SelectedItem.Text == "NO" && drpproject.SelectedValue!=null && radisactive.SelectedItem.Text=="NO")
            {
                drptask.Items.Clear();
               
                drptask.Items.Add(new ListItem("---ALL---", "0"));
                DataSet ds = bl.Getstatustasksno(connection, stat_Id, pro_Id);
                drptask.DataSource = ds;
                drptask.DataBind();
                drptask.DataTextField = "Task_Name";
                drptask.DataValueField = "Task_Id";
                UpdatePanel2.Update();
                //drpemployee_SelectedIndexChanged(sender, e);

            }
            else
            {
                drptask.Items.Clear();
              
                drptask.Items.Add(new ListItem("---ALL---", "0"));
                DataSet ds = bl.Getstatustasksnostatus(connection, stat_Id, pro_Id);
                drptask.DataSource = ds;
                drptask.DataBind();
                drptask.DataTextField = "Task_Name";
                drptask.DataValueField = "Task_Id";
                UpdatePanel2.Update();
               // drpemployee_SelectedIndexChanged(sender, e);

            }

           

           // drpproject_SelectedIndexChanged(sender, e);

        }

        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }
        // UpdatePanel2.Update();
    }

    protected void drpemployee_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            BusinessLogic bl = new BusinessLogic(sDataSource);
            int Emp_Id = 0;
            string connection = Request.Cookies["Company"].Value;

            Emp_Id = Convert.ToInt32(drpEmployee.SelectedValue);
            drptask.Items.Clear();

            drptask.Items.Add(new ListItem("---ALL---", "0"));
            DataSet ds = bl.Gettaskfromemployee(connection, Emp_Id);
            drptask.DataSource = ds;
            drptask.DataBind();
            drptask.DataTextField = "Task_Name";
            drptask.DataValueField = "Task_Id";
            UpdatePanel2.Update();
            //  drpproject.Items.Add(new ListItem("---ALL---", "0"));

        }

        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }
        // UpdatePanel2.Update();
    }

    protected void radisactive_SelectedIndexChanged(object sender, EventArgs e)
    {
        try
        {
            BusinessLogic bl = new BusinessLogic(sDataSource);
            int Project_Id = 0;

            if (radisactive.SelectedItem.Text == "Y")
            {

                string connection = Request.Cookies["Company"].Value;
                Project_Id = Convert.ToInt32(drpproject.SelectedValue);

                drptask.Items.Clear();
                drptask.Items.Add(new ListItem("---ALL---", "0"));
                DataSet ds = bl.Getactivetask(connection, Project_Id);

                drptask.DataSource = ds;
                drptask.DataBind();
                drptask.DataTextField = "Task_Name";
                drptask.DataValueField = "Task_Id";
                UpdatePanel2.Update();
            }
            else
            {


                string connection = Request.Cookies["Company"].Value;
                Project_Id = Convert.ToInt32(drpproject.SelectedValue);

                drptask.Items.Clear();
                drptask.Items.Add(new ListItem("---ALL---", "0"));
                DataSet ds = bl.Getinactivetask(connection, Project_Id);

                drptask.DataSource = ds;
                drptask.DataBind();
                drptask.DataTextField = "Task_Name";
                drptask.DataValueField = "Task_Id";
                UpdatePanel2.Update();
            }

         



        }

        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }

    }

    protected void btnprojectreport_Click(object sender, EventArgs e)
    {
        try
        {
            int Empno = 0;
            int ProjectId = 0;
            string BlockedTask = "";
            int CompletedTask = 0;
            int Task = 0;
            int DependencyTask = 0;
            string isactive = "";
            int incharge = 0;
            Empno = Convert.ToInt32(drpEmployee.SelectedValue);
            incharge = Convert.ToInt32(drpIncharge.SelectedValue);

            ProjectId = Convert.ToInt32(drpproject.SelectedValue);
            BlockedTask = radblocktask.SelectedItem.Text;
            CompletedTask = Convert.ToInt32(drpTaskStatus.SelectedValue);
            Task = Convert.ToInt32(drptask.SelectedValue);
            DependencyTask = Convert.ToInt32(drpdependencytask.SelectedValue);
            isactive = radisactive.SelectedItem.Text;
            string cond = getCond();

            Response.Write("<script language='javascript'> window.open('ProjectReport1.aspx?incharge =" + Convert.ToInt32(incharge) + "&employee=" + Convert.ToInt32(Empno) + "&project=" + Convert.ToInt32(ProjectId) + "&BlockedTask=" + BlockedTask + "&CompletedTask=" + Convert.ToInt32(CompletedTask) + "&Task=" + Convert.ToInt32(Task) + "&DependencyTask=" + Convert.ToInt32(DependencyTask) + "&isactive=" + isactive + "&cond =" + cond + " ' , 'window','height=700,width=1000,left=172,top=10,toolbar=yes,scrollbars=yes,resizable=yes');</script>");

            //Response.Redirect("ProjectReport1.aspx");
        }
        catch (Exception ex)
        {
            TroyLiteExceptionManager.HandleException(ex);
        }
    }

    protected string getCond()
    {
        string cond = "";

        //cond = "1=1";


        if ((drpproject.SelectedItem.Text != "---ALL---"))
        {


            cond += " and tblProjects.ProjectId=" + drpproject.SelectedValue + "";
        }
       
        if ((drpEmployee.SelectedItem.Text != "---ALL---"))
        {

            cond += " and tblEmployee.empno=" + drpEmployee.SelectedValue + "";
        }
        
        

            cond += " and  tblTaskUpdates.Blocked_Flag ='" + radblocktask.SelectedValue + "'";
        

        if ((drpTaskStatus.SelectedItem.Text != "---ALL---"))
        {

            cond += " and tblTaskUpdates.Task_Status =" + Convert.ToInt32(drpTaskStatus.SelectedValue) + " ";

        }
        if ((drptask.SelectedItem.Text != "---ALL---"))
        {

            cond += " and tblTasks.Task_Id =" + Convert.ToInt32(drptask.SelectedValue) + " ";
        }

        if ((drpdependencytask.SelectedItem.Text != "---ALL---"))
        {

            cond += " and tblTasks.Dependency_Task =" + Convert.ToInt32(drpdependencytask.SelectedValue) + " ";
        }
     

            cond += " and tblTasks.IsActive ='" + radisactive.SelectedValue + "' ";
        

        cond += " and tblEmployee.ManagerID='" + drpIncharge.SelectedValue + "'";


        return cond;
    }


    
}