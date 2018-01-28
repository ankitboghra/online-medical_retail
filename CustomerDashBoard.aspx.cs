using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CustomerFiles_CustomerDashBoard : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        Response.Cache.SetNoStore();
        if (Session["UserName"] == null)
        {
            Response.Redirect("Login.aspx");
        }
        if (Session["Type"] == "super_user")
        {
            Response.Redirect("SuperCustomerDashBoard.aspx");
        }
        if (Session["Type"] == "local_user")
        {
            Response.Redirect("CustomerDashBoard.aspx");
        }
    }
}