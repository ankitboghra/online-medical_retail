using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Text.RegularExpressions;
using System.Configuration;
public partial class SalesReturn : System.Web.UI.Page
{
    //SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\v11.0;AttachDbFilename=C:\Users\Sai Infotech\Documents\Visual Studio 2012\WebSites\MedicalStore\App_Data\db_oms.mdf;Integrated Security=True");
    //SqlConnection con = new SqlConnection(@"Data Source=(LocalDB)\v11.0;AttachDbFilename=H:\_MSc IT\Ankit\Sem 6\060010603 Project\MedicalStore\App_Data\db_oms.mdf;Integrated Security=True");
    string conString = null;
    SqlConnection con = null;
    SqlCommand cmd;
    static List<TempData> l = new List<TempData>();
    static int records = 0;
    static int SalesReturn_id = 0;
    static double Total = 0.0;
    static double Sales = 0.0;
    static int Editor = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["UserName"] == null)
        {
            Response.Redirect("Login.aspx");
        }
        conString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;
        con = new SqlConnection(conString);
        //Session["medical_id"] = 1;

        if (IsPostBack)
        {
            validate(1);
        }
        setSalesReturnID();
        SqlDataReader dr;
        if (!IsPostBack)
        {
            txtSalesID.Focus();
        }
        //Fill Doctors
        adddoc();

        //Fill Patients
        
        addpatient();

        con.Open();
        cmd = new SqlCommand();
        cmd.CommandText = "sp_getProduct";
        cmd.Connection = con;
        cmd.CommandType = CommandType.StoredProcedure;
        //con.Open();
        //dr.Close();
        dr = cmd.ExecuteReader();
        if (!IsPostBack)
        {
            l.Clear();
            while (dr.Read())
            {
                productName.Items.Add(
                    new ListItem() { Text = dr[0].ToString(), Value = dr[0].ToString() }
                    );
            }
            TempData c = new TempData();
            if (records == 0)
            {
                l.Add(c);
                GridView3.DataSource = l.ToList();
                GridView3.DataBind();
                l.Clear();
            }
        }

        cmd = new SqlCommand();
        cmd.CommandText = "sp_getTax";
        cmd.Connection = con;
        cmd.CommandType = CommandType.StoredProcedure;
        //con.Open();
        dr.Close();
        dr = cmd.ExecuteReader();
        if (!IsPostBack)
        {
            while (dr.Read())
            {
                DDTax.Items.Add(new ListItem() { Text = dr[0].ToString(), Value = dr[1].ToString() });
            }
        }
        //con.Close();

        cmd = new SqlCommand();
        cmd.CommandText = "sp_getPayment";
        cmd.Connection = con;
        cmd.CommandType = CommandType.StoredProcedure;
        //con.Open();
        dr.Close();
        dr = cmd.ExecuteReader();
        if (!IsPostBack)
        {
            while (dr.Read())
            {
                DDPaymentType.Items.Add(new ListItem() { Text = dr[1].ToString(), Value = dr[0].ToString() });
            }
        }
        //con.Close();

        cmd = new SqlCommand();
        cmd.CommandText = "sp_getBookCode";
        cmd.Connection = con;
        cmd.CommandType = CommandType.StoredProcedure;
        //con.Open();
        dr.Close();
        dr = cmd.ExecuteReader();
        if (!IsPostBack)
        {
            while (dr.Read())
            {
                DDbook.Items.Add(new ListItem() { Text = dr[1].ToString(), Value = dr[0].ToString() });
            }
        }
        con.Close();

    }
    public void setSalesReturnID()
    {
        cmd = new SqlCommand();
        cmd.CommandText = "sp_getTransSR_ID";
        cmd.Connection = con;
        cmd.CommandType = CommandType.StoredProcedure;
        con.Open();
        SqlDataReader dr = cmd.ExecuteReader();
        string Transaction_ID = "0";
        txtDate.Text = DateTime.Today.ToString("yyyy/MM/dd");
        while (dr.Read())
        {
            Transaction_ID = dr[0].ToString();
        }
        if (Transaction_ID == "")
        {
            Transaction_ID = "0";
        }
        SalesReturn_id = (Convert.ToInt32(Transaction_ID) + 1);
        txtSalesID.Text = "SR-" + (SalesReturn_id.ToString()).PadLeft(5, '0');
        con.Close();
    }
    public void addpatient()
    {
        ViewState["p"] = DDPatient.SelectedValue;
        ViewState["pa"] = HiddenPAmo.Value;
        ViewState["add"] = HiddenPAdd.Value;
        DDPatient.Items.Clear();
        con.Open();
        cmd = new SqlCommand();
        cmd.CommandText = "sp_getPatient";
        cmd.Connection = con;
        cmd.CommandType = CommandType.StoredProcedure;

        SqlDataReader dr;
        dr = cmd.ExecuteReader();
        DDPatient.Items.Add("-Select Patient-");
        while (dr.Read())
        {
            DDPatient.Items.Add(
            new ListItem() { Text = dr[0].ToString(), Value = dr[0].ToString() }
            );
        }
        con.Close();
        if (DDPatient.SelectedValue != "-Select Patient-")
        {
            DDPatient.SelectedValue = ViewState["p"].ToString();
        }
        txtPendingAmount.Text = ViewState["pa"].ToString();
        txtAddress.Text = ViewState["add"].ToString();
    }
    public void adddoc()
    {
        DDDoctors.Items.Clear();
        con.Open();
        cmd = new SqlCommand();
        cmd.CommandText = "sp_getDoctors";
        cmd.Connection = con;
        cmd.CommandType = CommandType.StoredProcedure;
        SqlDataReader drdoc;
        drdoc = cmd.ExecuteReader();
        while (drdoc.Read())
        {
            DDDoctors.Items.Add(
                new ListItem() { Text = drdoc[0].ToString(), Value = drdoc[0].ToString() }
                );
        }
        con.Close();
        DDDoctors.SelectedValue = "Self";
    }
    protected void Button1_Click1(object sender, EventArgs e)
    {

    }
    public bool validate(int call)
    {
        Boolean state = true;
        Boolean p = true, b = true, size = true, strip = true, dis = true, patient = true;
        if (call == 0)
        {
            if (productName.Text == "-Select-")
            {
                productName.BorderColor = Color.Red;
                productName.BackColor = Color.Pink;
                p = false;
            }
            else if (batch.Text == "")
            {
                productName.BorderColor = Color.Empty;
                productName.BackColor = Color.Empty;
                p = true;
                //batch.BorderColor = Color.Red;
                //batch.BackColor = Color.Pink;
                //b = false;
            }
            else
            {
                batch.BorderColor = Color.Empty;
                batch.BackColor = Color.Empty;
                b = true;
            }
            if (Convert.ToInt16(txtSize.Text) <= 0)
            {
                txtSize.BorderColor = Color.Red;
                txtSize.BackColor = Color.Pink;
                size = false;
            }
            else
            {
                txtSize.BorderColor = Color.Empty;
                txtSize.BackColor = Color.Empty;
                size = true;
            }
            if (Convert.ToInt16(txtStrip.Text) <= 0)
            {
                txtStrip.BorderColor = Color.Red;
                txtStrip.BackColor = Color.Pink;
                strip = false;
            }
            else
            {
                txtStrip.BorderColor = Color.Empty;
                txtStrip.BackColor = Color.Empty;
                strip = true;
            }
            // Regex.IsMatch(txtDiscountPer.Text, @"^([0-9].*)(\.([0-9]?)$")
            if ((Regex.IsMatch(txtDiscountPer.Text, @"^[0-9]*[0-9]*\.?[0-9]*?[0-9]*?$")))
            {
                if (txtDiscountPer.Text == "" || Convert.ToDouble(txtDiscountPer.Text) < 0)
                {
                    txtDiscountPer.BorderColor = Color.Red;
                    txtDiscountPer.BackColor = Color.Pink;
                    dis = false;
                }
                else
                {
                    txtDiscountPer.BorderColor = Color.Empty;
                    txtDiscountPer.BackColor = Color.Empty;
                    dis = true;
                }
            }
            else
            {
                txtDiscountPer.BorderColor = Color.Red;
                txtDiscountPer.BackColor = Color.Pink;
                dis = false;
            }
        }
        if (call == 1)
        {
            if (DDPatient.Text == "-Select Patient-")
            {
                DDPatient.BorderColor = Color.Red;
                DDPatient.BackColor = Color.Pink;
                patient = false;
            }
            else
            {
                DDPatient.BorderColor = Color.Empty;
                DDPatient.BackColor = Color.Empty;
                patient = true;
            }
        }
        if (p == false || b == false || size == false || strip == false || dis == false || patient == false)
        {
            state = false;
        }
        else
        {
            state = true;
        }
        return state;
    }
    protected void txtBtn_Click(object sender, EventArgs e)
    {
        Boolean status = validate(0);
        if (status == true)
        {
            bool flagItemExist = false;
            for (int i = 0; i < records; i++)
            {
                if (l[i].Product == productName.SelectedItem.ToString() && l[i].Batch == hiddenBatch.Value)
                {
                    flagItemExist = true;
                    TempData tmpObj = l[i];
                    l[i].Quantity = l[i].Quantity + Convert.ToInt16(hiddenQty.Value);
                    l[i].Strip = l[i].Strip + Convert.ToInt16(txtStrip.Text);
                    l[i].MRP = l[i].MRP + Convert.ToDouble(hiddenMRPperUnit.Value);
                    l[i].DiscountValue = l[i].DiscountValue + Convert.ToDouble(hiddenDiscountValue.Value);
                    l[i].MarginTotal = l[i].MarginTotal + Convert.ToDouble(hiddenMargin.Value);
                    break;
                }
                else
                {
                    continue;
                }
            }
            batch.SelectedIndex = -1;
            if (!flagItemExist)
            {
                TempData c = new TempData();
                GridView3.Rows[0].Cells[2].Text = productName.SelectedItem.ToString();
                c.Product = productName.SelectedItem.ToString();
                productName.SelectedIndex = -1;
                c.Size = Convert.ToInt16(txtSize.Text);
                c.Strip = Convert.ToInt16(txtStrip.Text);
                c.Quantity = Convert.ToInt16(hiddenQty.Value);
                c.Batch = hiddenBatch.Value;
                c.PurchasePerUnit = Convert.ToDouble(hiddenPPU.Value);
                c.MrpPerUnit = Convert.ToDouble(hiddenMRPperUnit.Value);
                c.Expiry = hiddenExpiry.Value;
                c.MRP = Convert.ToDouble(hiddenMRPperUnit.Value);
                c.DiscountPer = Convert.ToDouble(hiddenDiscountPer.Value);
                c.DiscountValue = Convert.ToDouble(hiddenDiscountValue.Value);
                c.TAX = Convert.ToDouble(hiddenTAX.Value);
                c.MarginTotal = Convert.ToDouble(hiddenMargin.Value);
                l.Add(c);
                records++;
            }
            GridView3.DataSource = l.ToList();
            GridView3.DataBind();
            CalculateTotal();
            clear();
            //defaultColor();
            productName.Focus();
        }
    }
    protected void txtMargin_TextChanged(object sender, EventArgs e)
    { }
    public void CalculateTotal()
    {
        Total = 0;
        for (int i = 0; i < records; i++)
        {
            Total = Total + l[i].MarginTotal;

        }
        Sales = 0;
        for (int j = 0; j < records; j++)
        {
            Sales = Sales + (l[j].Quantity * l[j].PurchasePerUnit);
        }
        lblSales.Text = Math.Round(Sales, 2).ToString();
        lblTotal.Text = Math.Round(Total, 2).ToString();
    }
    protected void productName_SelectedIndexChanged(object sender, EventArgs e)
    {
        cmd = new SqlCommand();
        cmd.CommandText = "sp_getBatch_getQty";
        cmd.Connection = con;
        cmd.CommandType = CommandType.StoredProcedure;
        cmd.Parameters.AddWithValue("@bid", productName.SelectedValue);
        con.Open();
        SqlDataReader dr = cmd.ExecuteReader();
        while (dr.Read())
        {
            batch.Items.Add(dr[0].ToString());
        }
        con.Close();
    }
    protected void GridView3_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
    {
        //int id = e.NewSelectedIndex;
        //sel = 1;
        //productName.Text = GridView3.Rows[id].Cells[2].Text.ToString();
        //batch.SelectedValue = GridView3.Rows[id].Cells[4].Text.ToString();
        //txtSize.Text = GridView3.Rows[id].Cells[3].Text.ToString();        
        //txtQty.Text = GridView3.Rows[id].Cells[5].Text.ToString();
        //txtStrip.Text = GridView3.Rows[id].Cells[6].Text.ToString();
        //txtExpiry.Text = GridView3.Rows[id].Cells[7].Text.ToString();
        //txtPPU.Text = GridView3.Rows[id].Cells[8].Text.ToString();
        //txtMRPperUnit.Text = GridView3.Rows[id].Cells[9].Text.ToString();
        //txtMRP.Text = GridView3.Rows[id].Cells[10].Text.ToString();
        //txtBasePPU.Text = (Convert.ToDouble(txtPPU.Text) * Convert.ToDouble(txtQty.Text)).ToString();
        //txtDiscountPer.Text = GridView3.Rows[id].Cells[11].Text.ToString();
        //txtDiscountValue.Text = GridView3.Rows[id].Cells[12].Text.ToString();
        //string temptax = "0";
        //if (GridView3.Rows[id].Cells[13].Text.ToString() == "5")
        //{
        //    temptax = "4";
        //}
        //else if (GridView3.Rows[id].Cells[13].Text.ToString() == "15")
        //{
        //    temptax = "12.5";
        //}
        //else
        //{
        //    temptax = GridView3.Rows[id].Cells[13].Text.ToString();
        //}
        //DDTax.SelectedValue = temptax;
        //txtMargin.Text = GridView3.Rows[id].Cells[14].Text.ToString();
    }
    protected void btndoc_Click(object sender, EventArgs e)
    {
        int check = validateDoc();
        if (check == 0)
        {
            cmd = new SqlCommand();
            cmd.CommandText = "sp_addDoctor";
            cmd.Connection = con;
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@docName", txtdocname.Text);
            cmd.Parameters.AddWithValue("@qualification", txtqualification.Text);
            cmd.Parameters.AddWithValue("@docAddress", txtdocaddress.Text);
            cmd.Parameters.AddWithValue("@docContact", txtdoccontact.Text);
            cmd.Parameters.AddWithValue("@docHospital", txtdocHospital.Text);
            cmd.Parameters.AddWithValue("@docHospitalAdd", txtdochospitaladd.Text);
            cmd.Parameters.AddWithValue("@docHospitalNo", txtdochostitalcontactno.Text);
            try
            {
                con.Open();
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                con.Close();
            }
            DDDoctors.Items.Clear();
            adddoc();
        }
    }
    public int validateDoc()
    {
        int vali = 0;
        int dn = 0, q = 0, ad = 0, cn = 0, hos = 0, hosad = 0, hoscn = 0;
        // Regex.IsMatch(txtDiscountPer.Text, @"^(?:\d{1,2})?(?:\.\d{1,2})?$")
        //Doctor Name Validation
        if (txtdocname.Text == "" || !(Regex.IsMatch(txtdocname.Text, @"^[a-zA-Z\s\.]*$")))
        {
            txtdocname.BorderColor = Color.Red;
            dn = 1;
        }
        else
        {
            txtdocname.BorderColor = Color.Empty;
            dn = 0;
        }
        //Doctor Qualification Validation
        if (txtqualification.Text == "" || !(Regex.IsMatch(txtqualification.Text, @"^[a-zA-Z\s\.]*$")))
        {
            txtqualification.BorderColor = Color.Red;
            q = 1;
        }
        else
        {
            txtqualification.BorderColor = Color.Empty;
            q = 0;
        }
        //Doctor Address Validation
        if (txtdocaddress.Text == "" || !(Regex.IsMatch(txtdocaddress.Text, @"^[a-zA-Z\s0-9\.\,]*$")))
        {
            txtdocaddress.BorderColor = Color.Red;
            ad = 1;
        }
        else
        {
            txtdocaddress.BorderColor = Color.Empty;
            ad = 0;
        }
        //Doctor Contact No Validation
        if (txtdoccontact.Text == "" || !(Regex.IsMatch(txtdoccontact.Text, @"^\d{10}$")))
        {
            txtdoccontact.BorderColor = Color.Red;
            cn = 1;
        }
        else
        {
            txtdoccontact.BorderColor = Color.Empty;
            cn = 0;
        }
        //Doctor Hospital Validation
        if (txtdocHospital.Text == "" || !(Regex.IsMatch(txtdocHospital.Text, @"^[a-zA-Z\s]*$")))
        {
            txtdocHospital.BorderColor = Color.Red;
            hos = 1;
        }
        else
        {
            txtdocHospital.BorderColor = Color.Empty;
            hos = 0;
        }
        //Doctor Hospital Address Validation 
        if (txtdochospitaladd.Text == "" || !(Regex.IsMatch(txtdochospitaladd.Text, @"^[a-zA-Z\s\.\,0-9]*$")))
        {
            txtdochospitaladd.BorderColor = Color.Red;
            hosad = 1;
        }
        else
        {
            txtdochospitaladd.BorderColor = Color.Empty;
            hosad = 0;
        }
        //Doctor Hospital Contact no Validation 
        if (txtdochostitalcontactno.Text == "" || !(Regex.IsMatch(txtdochostitalcontactno.Text, @"^\d{10}$")))
        {
            txtdochostitalcontactno.BorderColor = Color.Red;
            hoscn = 1;
        }
        else
        {
            txtdochostitalcontactno.BorderColor = Color.Empty;
            hoscn = 0;
        }

        if (dn == 0 && q == 0 && ad == 0 && cn == 0 && hos == 0 && hosad == 0 && hoscn == 0)
        {
            vali = 0;
        }
        else
        {
            vali = 1;
        }
        return vali;
    }
    protected void btnaddpatient_Click(object sender, EventArgs e)
    {
        int ch = validatePatient();
        if (ch == 0)
        {
            cmd = new SqlCommand();
            cmd.CommandText = "sp_addPatient";
            cmd.Connection = con;
            string n = txtpatientcontact.Text + " " + txtpaientname.Text;
            cmd.CommandType = CommandType.StoredProcedure;
            cmd.Parameters.AddWithValue("@pname", n);
            cmd.Parameters.AddWithValue("@ppendingamo", txtpending.Text);
            cmd.Parameters.AddWithValue("@paddress", txtpatientaddress.Text);
            cmd.Parameters.AddWithValue("@pemail", txtpatientEmail.Text);
            cmd.Parameters.AddWithValue("@pdob", txtpatientDate.Text);
            try
            {
                con.Open();
                cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                con.Close();
            }
            ViewState["p"] = DDPatient.SelectedValue;
            ViewState["pa"] = HiddenPAmo.Value;
            ViewState["add"] = HiddenPAdd.Value;
            DDPatient.Items.Clear();
            addpatient();
        }
    }
    public int validatePatient()
    {
        int vali = 0;
        int pn = 0, cn = 0, pamo = 0, ad = 0, eid = 0, dob = 0;
        // Regex.IsMatch(txtDiscountPer.Text, @"^(?:\d{1,2})?(?:\.\d{1,2})?$")
        //Patient Name Validation
        if (txtpaientname.Text == "" || !(Regex.IsMatch(txtpaientname.Text, @"^[a-zA-Z\s\.]*$")))
        {
            txtpaientname.BorderColor = Color.Red;
            pn = 1;
        }
        else
        {
            txtpaientname.BorderColor = Color.Empty;
            pn = 0;
        }
        //Patient Contact No Validation
        if (txtpatientcontact.Text == "" || !(Regex.IsMatch(txtpatientcontact.Text, @"^\d{10}$")))
        {
            txtpatientcontact.BorderColor = Color.Red;
            cn = 1;
        }
        else
        {
            txtpatientcontact.BorderColor = Color.Empty;
            cn = 0;
        }
        //Patient Pending Amount Validation
        if (txtpending.Text == "" || !(Regex.IsMatch(txtpending.Text, @"^[0-9]*$")))
        {
            txtpending.BorderColor = Color.Red;
            pamo = 1;
        }
        else
        {
            txtpending.BorderColor = Color.Empty;
            pamo = 0;
        }
        //Patient Address Validation
        if (txtpatientaddress.Text == "" || !(Regex.IsMatch(txtpatientaddress.Text, @"^[a-zA-Z\s\.\,]*$")))
        {
            txtpatientaddress.BorderColor = Color.Red;
            ad = 1;
        }
        else
        {
            txtpatientaddress.BorderColor = Color.Empty;
            ad = 0;
        }
        //Patient Email Address Validation
        if (txtpatientEmail.Text == "" || !(Regex.IsMatch(txtpatientEmail.Text, @"^[a-zA-Z0-9\.]*@[a-zA-Z0-9]*\.[a-zA-Z]*$")))
        {
            txtpatientEmail.BorderColor = Color.Red;
            eid = 1;
        }
        else
        {
            txtpatientEmail.BorderColor = Color.Empty;
            eid = 0;
        }
        //Patient Patient Date Of Birth Validation
        if (txtpatientDate.Text == "")
        {
            txtpatientDate.BorderColor = Color.Red;
            dob = 1;
        }
        else
        {
            txtpatientDate.BorderColor = Color.Empty;
            dob = 0;
        }

        if (pn == 0 && cn == 0 && pamo == 0 && ad == 0 && eid == 0 && dob == 0)
        {
            vali = 0;
        }
        else
        {
            vali = 1;
        }
        return vali;
    }
    public int getpid(string pn)
    {
        SqlCommand cmd1 = new SqlCommand();
        string pname = productName.Text.ToString();
        cmd1.Parameters.AddWithValue("@pn", pn);
        cmd1.CommandText = "sp_getProductID";
        cmd1.CommandType = CommandType.StoredProcedure;
        cmd1.Connection = con;
        try
        {
            con.Open();
            SqlDataReader dr = cmd1.ExecuteReader();
            dr.Read();
            return Convert.ToInt16(dr[0]);

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
    public int getdid(string dn)
    {
        SqlCommand cmd1 = new SqlCommand();
        string pname = productName.Text.ToString();
        cmd1.Parameters.AddWithValue("@dn", dn);
        cmd1.CommandText = "sp_getDoctorID";
        cmd1.CommandType = CommandType.StoredProcedure;
        cmd1.Connection = con;
        try
        {
            con.Open();
            SqlDataReader dr = cmd1.ExecuteReader();
            dr.Read();
            return Convert.ToInt16(dr[0]);
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
    public int getpatientid(string dn)
    {
        SqlCommand cmd1 = new SqlCommand();
        string pname = DDPatient.Text.ToString();
        cmd1.Parameters.AddWithValue("@pname", pname);
        cmd1.CommandText = "sp_getPatientID";
        cmd1.CommandType = CommandType.StoredProcedure;
        cmd1.Connection = con;
        try
        {
            con.Open();
            SqlDataReader dr = cmd1.ExecuteReader();
            dr.Read();
            return Convert.ToInt16(dr[0]);
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
    public void updatebatch(int pid, int batchno, int qty)
    {
        SqlCommand cmd1 = new SqlCommand();
        cmd1.CommandText = "sp_SRBatchUpdate";
        cmd1.Connection = con;
        cmd1.CommandType = CommandType.StoredProcedure;
        cmd1.Parameters.Clear();
        cmd1.Parameters.AddWithValue("@PID", pid);
        cmd1.Parameters.AddWithValue("@Batch_no", batchno);
        cmd1.Parameters.AddWithValue("@Qty", qty);
        try
        {
            con.Open();
            cmd1.ExecuteNonQuery();
        }
        catch (Exception ex)
        {
            lblmsg.Text = ex.Message;
            throw ex;
        }
        finally
        {
            con.Close();
        }
    }
    protected void btnGenerate_Click(object sender, EventArgs e)
    {
        if (Editor == 0)
        {
            Boolean status = validate(1);
            if (status == true)
            {
                cmd = new SqlCommand();
                cmd.CommandText = "sp_salesReturn";
                cmd.Connection = con;
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.Parameters.Clear();
                lblmsg.Text += SalesReturn_id.ToString();
                for (int i = 0; i < records; i++)
                {
                    cmd.Parameters.AddWithValue("@Tid", SalesReturn_id);
                    cmd.Parameters.AddWithValue("@Mid", Session["medical_id"].ToString());
                    cmd.Parameters.AddWithValue("@TransactionDate", txtDate.Text);
                    cmd.Parameters.AddWithValue("@BookCode", DDbook.SelectedValue);
                    cmd.Parameters.AddWithValue("@PaymentType", DDPaymentType.Text);
                    cmd.Parameters.AddWithValue("@DoctorID", Convert.ToInt16(getdid(DDDoctors.SelectedValue)));
                    cmd.Parameters.AddWithValue("@PatientID", Convert.ToInt16(getpatientid(DDPatient.SelectedValue)));
                    //cmd.Parameters.AddWithValue("@FixDiscount", txtfixDiscount.Text);
                    cmd.Parameters.AddWithValue("@FixDiscount", "0");
                    cmd.Parameters.AddWithValue("@ProductID", Convert.ToInt16(getpid(GridView3.Rows[i].Cells[2].Text)));
                    cmd.Parameters.AddWithValue("@Batch", GridView3.Rows[i].Cells[4].Text);
                    cmd.Parameters.AddWithValue("@Size", Convert.ToInt16(GridView3.Rows[i].Cells[3].Text));
                    cmd.Parameters.AddWithValue("@Strip", Convert.ToInt16(GridView3.Rows[i].Cells[6].Text));
                    cmd.Parameters.AddWithValue("@DiscountPer", GridView3.Rows[i].Cells[11].Text);
                    cmd.Parameters.AddWithValue("@DiscountVar", GridView3.Rows[i].Cells[12].Text);
                    cmd.Parameters.AddWithValue("@TaxPer", GridView3.Rows[i].Cells[13].Text);
                    cmd.Parameters.AddWithValue("@Margin", GridView3.Rows[i].Cells[14].Text);
                    try
                    {
                        con.Open();
                        cmd.ExecuteNonQuery();
                        cmd.Parameters.Clear();
                    }
                    catch (Exception ex)
                    {
                        lblmsg.Text = ex.Message;
                        throw ex;
                    }
                    finally
                    {
                        con.Close();
                    }
                    int pid = Convert.ToInt16(getpid(GridView3.Rows[i].Cells[2].Text));
                    int bno = Convert.ToInt16(GridView3.Rows[i].Cells[4].Text);
                    int qty = Convert.ToInt16(GridView3.Rows[i].Cells[3].Text) * Convert.ToInt16(GridView3.Rows[i].Cells[6].Text);
                    cmd.Parameters.Clear();
                    updatebatch(pid, bno, qty);
                }
                Do_Transaction();
                l.Clear();
                TempData c = new TempData();
                l.Add(c);
                GridView3.DataSource = l.ToList();
                GridView3.DataBind();
                l.Clear();
                setSalesReturnID();
                lblTotal.Text = "0";
                lblSales.Text = "0";
                records = 0;
            }
        }
        else
        {
            System.Text.StringBuilder sb = new System.Text.StringBuilder();
            sb.Append("<script type = 'text/javascript'>window.onload=function(){alert(\"Can't Generate when Update in Progress!\")};</script>");
            ClientScript.RegisterClientScriptBlock(this.GetType(), "alert", sb.ToString());
        }
    }
    public void Do_Transaction()
    {
        SqlCommand cmdd = new SqlCommand();
        cmdd.CommandText = "sp_DoTransaction";
        cmdd.Connection = con;
        cmdd.CommandType = CommandType.StoredProcedure;
        cmdd.Parameters.Clear();
        cmdd.Parameters.AddWithValue("@billno", SalesReturn_id);
        cmdd.Parameters.AddWithValue("@Ttype", "SR");
        cmdd.Parameters.AddWithValue("@Tamo", Convert.ToInt16(lblTotal.Text));
        cmdd.Parameters.AddWithValue("@Ptype", DDPaymentType.Text);
        cmdd.Parameters.AddWithValue("@Tto", Convert.ToInt16(getpatientid(DDPatient.SelectedValue)));
        cmdd.Parameters.AddWithValue("@Tfrom",Convert.ToInt16(Session["medical_id"]));
        cmdd.Parameters.AddWithValue("@Tdate", txtDate.Text);
        try
        {
            con.Open();
            cmdd.ExecuteNonQuery();
            cmdd.Parameters.Clear();
        }
        catch (Exception ex)
        {
            lblmsg.Text = ex.Message;
            throw ex;
        }
        finally
        {
            con.Close();
        }
    }
    public void clear()
    {
        productName.Text = "-Select-";
        txtSize.Text = "0";
        txtExpiry.Text = "";
        txtStrip.Text = "0";
        txtQty.Text = "0";
        txtPPU.Text = "0";
        txtBasePPU.Text = "0";
        txtMRP.Text = "0";
        txtMRPperUnit.Text = "0";
        txtDiscountPer.Text = "0";
        txtDiscountValue.Text = "0";
        txtNetRate.Text = "0";
        DDTax.SelectedIndex = 0;
        txtTaxValue.Text = "0";
        txtMargin.Text = "0";
        productName.Focus();
    }
    protected void btndelete_Click(object sender, EventArgs e)
    {
        clear();
    }
    protected void Button1_Click(object sender, EventArgs e)
    {

        //Response.Write("<script type='text/javascript'>fillBatch();</script>");
        // Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "Call", "<script>fillBatch();</script>",true);
        //Page.ClientScript.RegisterClientScriptBlock(this.GetType(), "Call", "fillBatch()",true);
        //ScriptManager.RegisterClientScriptBlock(this,GetType(), "CA", "fillBatch()", true);
        //            .RegisterStartupScript(this, GetType(), "CA", "fillBatch()", true);
    }
    protected void GridView3_RowEditing(object sender, GridViewEditEventArgs e)
    {
        Editor = 1;
        GridView3.EditIndex = e.NewEditIndex;
        GridView3.DataSource = l.ToList();
        GridView3.DataBind();
    }
    protected void GridView3_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
        Editor = 0;
        GridView3.EditIndex = -1;
        GridView3.DataSource = l.ToList();
        GridView3.DataBind();
    }
    protected void GridView3_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        Editor = 0;
        int a = e.RowIndex;
        TextBox size = (TextBox)GridView3.Rows[a].Cells[3].Controls[0];
        size.Enabled = false;
        l[a].Size = Convert.ToInt32(size.Text);
        TextBox strip = (TextBox)GridView3.Rows[a].Cells[6].Controls[0];
        l[a].Strip = Convert.ToInt32(strip.Text);
        l[a].Quantity = Convert.ToInt32(strip.Text) * Convert.ToInt32(size.Text);
        TextBox mrpperunit = (TextBox)GridView3.Rows[a].Cells[9].Controls[0];
        double mrp = (Convert.ToDouble(mrpperunit.Text) * (Convert.ToDouble(strip.Text) * Convert.ToDouble(size.Text)));
        l[a].MRP = mrp;
        TextBox discount = (TextBox)GridView3.Rows[a].Cells[11].Controls[0];
        l[a].DiscountPer = Convert.ToDouble(discount.Text);
        double discountvalue = (Convert.ToDouble(discount.Text) / 100) * ((Convert.ToDouble(mrpperunit.Text)) * (Convert.ToInt32(strip.Text) * Convert.ToInt32(size.Text)));
        l[a].DiscountValue = discountvalue;
        double net = mrp - discountvalue;
        TextBox tax = (TextBox)GridView3.Rows[a].Cells[13].Controls[0];
        l[a].MarginTotal = net + ((Convert.ToDouble(tax.Text) / 100) * net);
        CalculateTotal();
        GridView3.EditIndex = -1;
        GridView3.DataSource = l.ToList();
        GridView3.DataBind();
    }
    protected void GridView3_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        int a = e.RowIndex;
        l.RemoveAt(a);
        records--;
        GridView3.DataSource = l.ToList();
        GridView3.DataBind();
        CalculateTotal();
        if (records == 0)
        {
            TempData cc = new TempData();
            l.Add(cc);
            GridView3.DataSource = l.ToList();
            GridView3.DataBind();
            l.Clear();
        }
    }
}