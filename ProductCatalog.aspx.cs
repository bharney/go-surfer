using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class GoSurfer_ProductCatalog : System.Web.UI.Page
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
            rptCatalogs.DataBind();
            rptProducts.DataBind();
        }
    }
    protected void rptProducts_ItemCommand(object source, RepeaterCommandEventArgs e)
    {
        if (e.CommandName == "addToCart")
        {
            hdnCartSessionID.Value = GetCartId();
            RepeaterItem rptRow = (RepeaterItem)((Control)e.CommandSource).NamingContainer;
            Button btnAddToCart = e.CommandSource as Button;
            sqlProducts.InsertParameters["CartSessionID"].DefaultValue = hdnCartSessionID.Value;
            sqlProducts.InsertParameters["ProductID"].DefaultValue = ((HiddenField)rptRow.FindControl("hdnProductID")).Value;
            sqlProducts.InsertParameters["ProductDetailURL"].DefaultValue = ((HiddenField)rptRow.FindControl("hdnProductDetailURL")).Value;
            sqlProducts.InsertParameters["ProductName"].DefaultValue = ((HiddenField)rptRow.FindControl("hdnProductName")).Value;
            sqlProducts.InsertParameters["OrderQty"].DefaultValue = "1";
            sqlProducts.InsertParameters["ProductDescription"].DefaultValue = ((HiddenField)rptRow.FindControl("hdnProductDescription")).Value;
            sqlProducts.InsertParameters["ProductImageURL"].DefaultValue = ((HiddenField)rptRow.FindControl("hdnProductImageURL")).Value;
            sqlProducts.Insert();
        }
    }
}