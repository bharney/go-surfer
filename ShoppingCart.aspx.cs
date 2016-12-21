using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class ShoppingCart : System.Web.UI.Page
{
    string db = ConfigurationManager.ConnectionStrings["ConnectionDB01"].ConnectionString;
    public const string CartSessionKey = "CartId";
    public string GetCartId()
    {
        if (HttpContext.Current.Session[CartSessionKey] == null)
        {
            if (!string.IsNullOrWhiteSpace(HttpContext.Current.User.Identity.Name))
            {
                HttpContext.Current.Session[CartSessionKey] = HttpContext.Current.User.Identity.Name;
            }
            else
            {
                // Generate a new random GUID using System.Guid class.     
                Guid tempCartId = Guid.NewGuid();
                HttpContext.Current.Session[CartSessionKey] = tempCartId.ToString();
            }
        }
        return HttpContext.Current.Session[CartSessionKey].ToString();
    }
    public class CartItem
    {
        public CartItem()
        {
        }

        // Properties.
        public int Id { get; internal set; }
        public string ProductTitle { get; set; }
        public string ProductDescription { get; set; }
        public string ProductImage { get; set; }
        public int Qty { get; internal set; }
        public double Price { get; internal set; }
        
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (!Page.IsPostBack)
        {
            hdnCartSessionID.Value = GetCartId();
            BindRepeater(hdnCartSessionID.Value);
        }
    }

    private void BindRepeater(string cartID)
    {
        using (SqlConnection con = new SqlConnection(db))
        {
            SqlDataAdapter sdaShoppingCart = new SqlDataAdapter("SELECT [RecordID], [OrderQty], [CartSessionID], [ProductID], [ProductDescription], [ProductImageURL], [ProductDetailURL], [ProductName] FROM [ShoppingCart] WHERE ([CartSessionID] = @CartSessionID)", con);
            sdaShoppingCart.SelectCommand.Parameters.AddWithValue("CartSessionID", cartID);
            DataTable dtShoppingCart = new DataTable();

            sdaShoppingCart.Fill(dtShoppingCart);

            DataView dvShoppingCart = new DataView(dtShoppingCart);
            rptProducts.DataSource = dvShoppingCart;
            rptProducts.DataBind();


            CartItem cartItem = new CartItem();
            using (SqlConnection sqlGetPrice = new SqlConnection(db))
            {

                foreach (RepeaterItem item in rptProducts.Items)
                {
                    cartItem.Id = Convert.ToInt32((item.FindControl("hdnProductID") as HiddenField).Value);
                    cartItem.Qty = Convert.ToInt32((item.FindControl("txtQty") as TextBox).Text);
                    try
                    {
                        sqlGetPrice.Open();
                        string sql = "SELECT [Price] FROM Product where [ProductID] = " + cartItem.Id.ToString();
                        SqlCommand cmd = new SqlCommand(sql, sqlGetPrice);
                        SqlDataReader reader;
                        reader = cmd.ExecuteReader();

                        while (reader.Read())
                        {
                            cartItem.Price = Convert.ToDouble(reader["Price"]);
                        }
                        sqlGetPrice.Close();
                    }
                    catch (Exception ex)
                    {
                        sqlGetPrice.Close();
                    }

                    (item.FindControl("lblPrice") as Label).Text = cartItem.Price.ToString();
                    (item.FindControl("lblLineTotal")as Label).Text = (cartItem.Qty * cartItem.Price).ToString();
                    //udpTotals.Update();
                }
            }
        }
    }

    protected void rptProducts_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        //if (e.CommandName == "btnUpdate")
        //{
        //    LinkButton lnkButton = e.CommandSource as LinkButton;
        //    int RepeaterItemIndex = ((RepeaterItem)lnkButton.NamingContainer).ItemIndex;
        //    foreach (RepeaterItem item1 in rptProducts.Items)
        //    {
        //        TextBox txtQty = (TextBox)item1.FindControl(("txtQty")) as TextBox;
        //        Label lblPrice = (Label)item1.FindControl(("lblPrice")) as Label;
        //        Label lblLineTotal = (Label)item1.FindControl(("lblLineTotal")) as Label;
        //        hdnLineTotal.Value = (Convert.ToDecimal(txtQty.Text) * Convert.ToDecimal(lblPrice.Text)).ToString();
        //        hdnRecordID.Value = (RepeaterItemIndex + 1).ToString();
        //        udpTotals.Update();
        //    }

        //}
        if (e.CommandName == "btnRemove")
        {
            RepeaterItem rptRow = (RepeaterItem)((Control)e.CommandSource).NamingContainer;
            LinkButton lnkButton = e.CommandSource as LinkButton;
            HiddenField hdnProductID = ((HiddenField)rptRow.FindControl("hdnProductID")) as HiddenField;
            sqlShoppingCart.DeleteParameters["CartSessionID"].DefaultValue = hdnCartSessionID.Value;
            sqlShoppingCart.DeleteParameters["ProductID"].DefaultValue = hdnProductID.Value;
            sqlShoppingCart.Delete();
            BindRepeater(hdnCartSessionID.Value);
            udpTotals.Update();
            //int RepeaterItemIndex = ((RepeaterItem)lnkButton.NamingContainer).ItemIndex;
            //hdnRecordID.Value = (RepeaterItemIndex + 1).ToString();
        }
    }
}