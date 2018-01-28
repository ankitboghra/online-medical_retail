using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;

public partial class ClientSide : System.Web.UI.Page
{
    //SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\v11.0;AttachDbFilename=H:\_MSc IT\Ankit\Sem 6\060010603 Project\MedicalStore\App_Data\db_oms.mdf;Integrated Security=True");
    //SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\v11.0;AttachDbFilename=C:\Users\Sai Infotech\Documents\Visual Studio 2012\WebSites\MedicalStore\App_Data\db_oms.mdf;Integrated Security=True");
    string conString = null;
    SqlConnection con = null;
    SqlCommand cmd;
    DataSet ds = new DataSet("tempBill");
    //static int BillAryCnt = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        conString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        con = new SqlConnection(conString);
        int choice = Convert.ToInt32(Request.QueryString["c"]);
        if (choice == 1)
        {
            string i = Request.QueryString["id"].ToString();
            cmd = new SqlCommand();
            cmd.CommandText = "select b.batchNo, b.productId, a.Product_id, a.Product_Name from tbl_batch b, tbl_product a where b.productId = a.Product_id and a.Product_Name = '" + i+"'";
            cmd.Connection = con;
            SqlDataReader dr;
            try
            {
                con.Open();
                dr = cmd.ExecuteReader();
                string a = "";
                while (dr.Read())
                {                    
                    Response.Write("<option value= " + dr[0] + " >" + dr[0] + "</option>");
                }
                Response.Write(a + "-End1-");
            }
            catch (Exception ex) {
                Response.Write(ex.Message);
            }
            finally
            {
                con.Close();
            }
        }
         else if (choice == 2)
        {
            string i = Request.QueryString["id"].ToString();
            int batch = Convert.ToInt32(Request.QueryString["batch"]);
            cmd = new SqlCommand();
            cmd.CommandText = "select b.expiryDate, b.purchasePrice, b.sellingPrice, b.batchNo, b.productID, a.Product_id from tbl_batch b, tbl_product a where b.productId = a.Product_id and a.Product_Name='" + i + "' and b.batchNo=" + batch;
            cmd.Connection = con;
            SqlDataReader dr;
            try
            {
                con.Open();
                dr = cmd.ExecuteReader();
                dr.Read();
                Response.Write(dr[0] + "-End1-" + dr[1] + "-End2-" + dr[2] + "-End3-");
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                con.Close();
            }
        }
        else if (choice == 3)
        {
            string i = Request.QueryString["id"].ToString();
            cmd=new SqlCommand();
            cmd.CommandText = "select b.quantity, b.productId, a.Product_id, a.Product_Name from tbl_batch b,tbl_product a where b.productId=a.Product_id and a.Product_Name='" + i + "'";
            cmd.Connection = con; 
            SqlDataReader dr;
            try
            {
                int a = 0;
                con.Open();
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    a = a + dr.GetInt32(0);
                }
                Response.Write(a);
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
            finally
            {
                con.Close();
            }
        }
        else if (choice == 4)
        {
            string i = Request.QueryString["id"].ToString();
            int batcha = Convert.ToInt16(Request.QueryString["batch"]);
            cmd = new SqlCommand();
            cmd.CommandText = "select b.quantity, b.productId, b.batchNo, a.Product_id from tbl_batch b,tbl_product a where b.batchNo=" + batcha + "and  b.productId=a.Product_id and a.Product_Name='" + i+"'";
            cmd.Connection = con;
            SqlDataReader dr;
            try
            {
                int a = 0;
                con.Open();
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    a = a + dr.GetInt32(0);
                }
                Response.Write(a);
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
            finally
            {
                con.Close();
            }
        }
        else if (choice == 5)
        {
            string i = Request.QueryString["id"].ToString();
            cmd = new SqlCommand();
            cmd.CommandText = "select PendingAmount,Address from tbl_Patient where PatientName='"+i+"'";
            cmd.Connection = con;
            SqlDataReader dr;
            try
            {
                string a = "",b="";               
                con.Open();
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    a = dr[0].ToString();
                    b = dr[1].ToString();
                }
                Response.Write(a + "-End1-" + b + "-End2-");
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
            finally
            {
                con.Close();
            }           
        }
        else if (choice == 6)
        {
            string i = Request.QueryString["taxvalue"].ToString();
            cmd = new SqlCommand();
            cmd.CommandText = "select additionalTax from tbl_tax_master where taxPercentage='"+i+"'";
            cmd.Connection = con;
            SqlDataReader dr;
            try 
            {
                con.Open();
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    Response.Write(dr[0]);                    
                }
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
            finally
            {
                con.Close();
            }
        }
        else if (choice == 7)
        {
            string i = Request.QueryString["id"].ToString();
            cmd = new SqlCommand();
            cmd.CommandText = "select mainperson,address from tbl_Supplier where firm='" + i + "'";
            cmd.Connection = con;
            SqlDataReader dr;
            try
            {
                string a = "", b = "";
                con.Open();
                dr = cmd.ExecuteReader();
                while (dr.Read())
                {
                    a = dr[0].ToString();
                    b = dr[1].ToString();
                }
                Response.Write(a + "-End1-" + b + "-End2-");
            }
            catch (Exception ex)
            {
                Response.Write(ex.Message);
            }
            finally
            {
                con.Close();
            }
        }

    }
}