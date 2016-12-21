using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

public partial class ProductDetails : System.Web.UI.Page
{
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

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {

        }
    }

    protected void rptProducts_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName == "addToCart")
        {
            hdnCartSessionID.Value = GetCartId();
            hdnProductID.Value = Request.QueryString["ProductID"];
            DataView dvProdDesc = (DataView)sqlProdDesc.Select(DataSourceSelectArguments.Empty);
            foreach (DataRowView drvSql in dvProdDesc)
            {
                hdnProductDescription.Value = drvSql["ProductDescription"].ToString();
            }
            DataView dvProdImg = (DataView)sqlProdImg.Select(DataSourceSelectArguments.Empty);
            foreach (DataRowView drvSql in dvProdImg)
            {
                hdnProductImageURL.Value = drvSql["ProductImageURL"].ToString();
            }
            DataView dvProdURL = (DataView)sqlProdURL.Select(DataSourceSelectArguments.Empty);
            foreach (DataRowView drvSql in dvProdURL)
            {
                hdnProductDetailURL.Value = drvSql["ProductDetailURL"].ToString();
            }
            DataView dvProdName = (DataView)sqlProdName.Select(DataSourceSelectArguments.Empty);
            foreach (DataRowView drvSql in dvProdName)
            {
                hdnProductName.Value = drvSql["ProductName"].ToString();
            }

            sqlProductDetails.InsertParameters["OrderQty"].DefaultValue = "1";
            sqlProductDetails.Insert();
            lblSession.Visible = true;
            lblSession.Text = "Successfully added item to shopping cart!";
            hplGoToCart.Visible = true;
            udpAddToCart.Update();

        }
    }
}