using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for TempData
/// </summary>
public class TempData
{     
    //public int sr {get; set;}
    public string Product { get; set; }
    public int Size { get; set; }
    public string Batch { get; set; }
    public int Quantity { get; set; }
    public int Strip { get; set; }
    public string Expiry { get; set; }
    public double PurchasePerUnit { get; set; }    
    public double MrpPerUnit { get; set; }
    public double MRP { get; set; }
    public double DiscountPer { get; set; }
    public double DiscountValue { get; set; }
    public double TAX { get; set; }
    public double MarginTotal { get; set; }
}