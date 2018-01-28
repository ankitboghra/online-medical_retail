using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class Login : System.Web.UI.Page
{
    SqlConnection con = new SqlConnection(ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString);
    SqlCommand cmd;
    SqlDataAdapter adp = new SqlDataAdapter();
    protected void Page_Load(object sender, EventArgs e)
    {
        Show.Visible = false;
        txtusername.Focus();
        if (Session["UserName"] != null)
        {
            if (Session["Type"] == "super_user")
            {
                Response.Redirect("SuperCustomerDashBoard.aspx");
            }
            if (Session["Type"] == "local_user")
            {
                Response.Redirect("CustomerDashBoard.aspx");
            }
        }
        Session["UserName"]=null;
    }
    protected void btnlogin_Click(object sender, EventArgs e)
    {
        string user = txtusername.Text;
        string pass = txtpassword.Text;
        validate(user,pass);
    }
    protected void txtusername_TextChanged(object sender, EventArgs e)
    {
        if (txtusername.Text == "")
        {
            txtpassword.Enabled = false;
            btnlogin.Enabled = false;
        }
        else
        {
            txtpassword.Enabled = true;
            btnlogin.Enabled = true;
        }
    }

    public void validate(string usernname, string password)
    {
        con.Open();
        DataSet ds = new DataSet();
        string source = txtpassword.Text;
        try
        {
            cmd = new SqlCommand("select username,super_password, local_password,status,MedicalID from medical_master where username='" + usernname+"'", con);
            adp.SelectCommand = cmd;
            adp.Fill(ds);
            if (ds.Tables[0].Rows.Count > 0)
            {
                if (Convert.ToInt32(ds.Tables[0].Rows[0]["status"].ToString()) == 2)
                {
                    Response.Redirect("Paypal.aspx");
                }
                else
                {
                    if (password == ds.Tables[0].Rows[0]["super_password"].ToString())
                    {
                        Session["Type"] = "super_user";
                        Session["UserName"] = usernname;
                        Session["medical_id"] = ds.Tables[0].Rows[0]["MedicalID"].ToString();
                        //System.Text.StringBuilder sb = new System.Text.StringBuilder();
                        //sb.Append("<script type = 'text/javascript'>window.onload=function(){alert(\"" + Session["UserName"]+ "\")};</script>");
                        //ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", sb.ToString());
                        Response.Redirect("SuperCustomerDashBoard.aspx");
                    }
                    else if (password == ds.Tables[0].Rows[0]["local_password"].ToString())
                    {
                        Session["Type"] = "local_user";
                        Session["UserName"] = usernname;
                        Session["medical_id"] = ds.Tables[0].Rows[0]["MedicalID"].ToString();
                        //System.Text.StringBuilder sb = new System.Text.StringBuilder();
                        //sb.Append("<script type = 'text/javascript'>window.onload=function(){alert(\"" + Session["UserName"]+ "\")};</script>");
                        //ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", sb.ToString());
                        Response.Redirect("CustomerDashBoard.aspx");
                    }
                    else
                    {
                        Show.Text = "Invalid Username or Password...";
                        txtusername.Text = "";
                        txtpassword.Text = "";
                        txtusername.Focus();
                        Show.Visible = true;
                    }
                }
            }
            else
            {
                Show.Text = "User is Blocked...";
                txtusername.Text = "";
                txtpassword.Text = "";
                Show.Visible = true;
                txtusername.Focus();
            }
        }
        catch (Exception ex)
        {
            Show.Text = "Something went wrong..."+ex;
            txtusername.Text = "";
            txtpassword.Text = "";
            Show.Visible = true;
            txtusername.Focus();
        }
    }
}