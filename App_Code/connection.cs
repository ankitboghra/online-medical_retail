using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Configuration;

/// <summary>
/// Summary description for connection
/// </summary>
public class connection
{
    //SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\v11.0;AttachDbFilename=C:\Users\Sai Infotech\Documents\Visual Studio 2012\WebSites\MedicalStore\App_Data\db_oms.mdf;Integrated Security=True");
    //SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\v11.0;AttachDbFilename=H:\_MSc IT\Ankit\Sem 6\060010603 Project\MedicalStore\App_Data\db_oms.mdf;Integrated Security=True");
    string conString = null;
    SqlConnection con = null;
    SqlCommand cmd;
	public connection()
	{
        conString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        con = new SqlConnection(conString);
	}
    public DataSet DisplayData(string sp_name,string param1, string param2, string param3)
    {
        SqlCommand command = new SqlCommand();
        SqlDataAdapter adapter = new SqlDataAdapter();
        DataSet ds = new DataSet();
        con.Open();
        command.Connection = con;
        command.CommandType = CommandType.StoredProcedure;
        command.CommandText = sp_name;
        if (param1 != "")
        command.Parameters.AddWithValue("@startDate", param1);
        if (param2 != "")
        command.Parameters.AddWithValue("@endDate", param2);
        if(param3!="")
            command.Parameters.AddWithValue("@param3", param3);
        //command.Parameters.Add("@endDate", SqlDbType.VarChar).Value = param1;
        adapter = new SqlDataAdapter(command);
        adapter.Fill(ds);
        con.Close();
        return ds;
    }
}