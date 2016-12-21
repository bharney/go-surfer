<%@ Page Title="" Language="C#" MasterPageFile="~/GoSurfer.master" AutoEventWireup="true"
    CodeFile="ShoppingCart.aspx.cs" Inherits="ShoppingCart" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container" style="padding-top: 70px;">
        <form id="cartForm" runat="server">
            <asp:ScriptManager ID="MainScriptManager" runat="server" />
            <div class="row">
                <asp:SqlDataSource ID="sqlShoppingCart" runat="server" ConnectionString="<%$ ConnectionStrings:ConnectionDB01 %>"
                    DeleteCommand="DELETE FROM [ShoppingCart] WHERE [ProductID] = @ProductID AND CartSessionID = @CartSessionID"
                    SelectCommand="SELECT [RecordID], [OrderQty], [CartSessionID], [ProductID], [ProductDescription], [ProductImageURL], [ProductDetailURL], [ProductName] FROM [ShoppingCart] WHERE ([CartSessionID] = @CartSessionID)"
                    UpdateCommand="UPDATE [ShoppingCart] SET [OrderQty] = @OrderQty WHERE [RecordID] = @RecordID">
                    <DeleteParameters>
                        <asp:Parameter Name="CartSessionID" Type="String" />
                        <asp:Parameter Name="ProductID" Type="Int32" />
                    </DeleteParameters>
                    <SelectParameters>
                        <asp:Parameter Name="CartSessionID" Type="String" />
                    </SelectParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="OrderQty" Type="String" />
                        <asp:Parameter Name="RecordID" Type="String" />
                    </UpdateParameters>
                </asp:SqlDataSource>
                <asp:HiddenField ID="hdnCartSessionID" runat="server" Value="" />
                <asp:HiddenField ID="hdnRecordID" runat="server" Value="" />
                <asp:HiddenField ID="hdnLineTotal" runat="server" Value="" />
                <div class="col-sm-12 col-md-10 col-md-offset-1">
                    <table id="shoppingCart" class="table table-hover">
                        <thead>
                            <tr>
                                <th>Product
                                </th>
                                <th>Quantity
                                </th>
                                <th class="text-center">Price
                                </th>
                                <th class="text-center">Total
                                </th>
                                <th></th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <asp:UpdatePanel ID="udpTotals" runat="server" UpdateMode="Conditional">
                                <ContentTemplate>
                                    <asp:Repeater ID="rptProducts" runat="server" OnItemCommand="rptProducts_ItemCommand">
                                        <ItemTemplate>
                                            <asp:HiddenField runat="server" ID="hdnProductID" Value='<%#Eval("[ProductID]") %>' />
                                            <asp:HiddenField ID="cartRecordID" runat="server" Value="" />
                                            <tr>
                                                <td class="col-sm-8 col-md-6">
                                                    <div class="media">
                                                        <a class="thumbnail pull-left" style="border: 0;" href='<%# VirtualPathUtility.ToAbsolute("~/ProductDetails.aspx?ProductID=" + Eval("ProductID")) %>'>
                                                            <img class="media-object" src='<%#Eval("[ProductImageURL]") %>' alt='<%#Eval("[ProductName]") %>'
                                                                style="max-width: 72px;"></a>
                                                        <div class="media-body">
                                                            <h4 class="media-heading">
                                                                <a href='<%#Eval("[ProductDetailURL]") %>'>
                                                                    <%#Eval("[ProductName]") %></a></h4>
                                                            <!-- <span>Status: </span><span class="text-success"><strong>In Stock</strong></span> -->
                                                        </div>
                                                    </div>
                                                </td>
                                                <td class="col-sm-1 col-md-1 text-center">
                                                    <asp:TextBox ID="txtQty" CssClass="form-control qty" Text='<%#Eval("[OrderQty]") %>' runat="server" />
                                                    <asp:RegularExpressionValidator ID="revNumbersOnly" ControlToValidate="txtQty" runat="server" ForeColor="Red" ErrorMessage="Only Numbers Allowed" ValidationExpression="\d+"></asp:RegularExpressionValidator>
                                                </td>
                                                <td class="col-sm-1 col-md-1 text-center">
                                                    <strong>$
                                                    <asp:Label ID="lblPrice" Text="" CssClass="price" runat="server" /></strong>
                                                </td>
                                                <td class="col-sm-1 col-md-1 text-center">
                                                    <strong>$
                                                    <asp:Label ID="lblLineTotal" runat="server" CssClass="total" Text="" /></strong>
                                                </td>
                                                <%--                                                <td class="col-sm-1 col-md-1">
                                                    <asp:LinkButton ID="lbnUpdate" CssClass="btn btn-warning" CommandName="btnUpdate"
                                                        runat="server">Update
                                            <i aria-hidden="true" class="glyphicon glyphicon-update"></i>
                                                    </asp:LinkButton>
                                                </td>--%>
                                                <td class="col-sm-1 col-md-1">
                                                    <asp:LinkButton ID="lbnRemoveLine" CssClass="btn btn-danger" CommandName="btnRemove"
                                                        runat="server">Remove
                                            <i aria-hidden="true" class="glyphicon glyphicon-remove"></i>
                                                    </asp:LinkButton>
                                                </td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </ContentTemplate>
                            </asp:UpdatePanel>
                            <tr>
                                <td></td>
                                <td></td>
                                <td></td>
                                <td>
                                    <asp:HyperLink NavigateUrl="Default.aspx" CssClass="btn btn-default" runat="server">Continue Shopping
                                        <i aria-hidden="true" class="glyphicon glyphicon-shopping-cart"></i>
                                    </asp:HyperLink>
                                </td>
                                <td>
                                    <button type="button" class="btn btn-success">
                                        Checkout <span class="glyphicon glyphicon-play"></span>
                                    </button>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </form>
        <!-- jQuery -->
        <script src="JavaScript/jquery.js"></script>
        <script type="text/javascript">
            $(document).ready(function () {
                $(".qty").on('keyup keypress', function () {
                    var row = $(this).closest("tr");
                    var price = $(".price", row).text();
                    price = price.replace('[-+]?([0-9]*.[0-9]+|[0-9]+)', '');
                    var qty = $(this).val();
                    var total = (qty * price).formatMoney(2);
                    $(".total", row).text(total);
                });

                $('#cartForm').on('keyup keypress', function (e) {
                    var keyCode = e.keyCode || e.which;
                    if (keyCode === 13) {
                        e.preventDefault();
                        return false;
                    }
                });
            });


            Number.prototype.formatMoney = function (c, d, t) {
                var n = this,
                    c = isNaN(c = Math.abs(c)) ? 2 : c,
                    d = d == undefined ? "." : d,
                    t = t == undefined ? "," : t,
                    s = n < 0 ? "-" : "",
                    i = parseInt(n = Math.abs(+n || 0).toFixed(c)) + "",
                    j = (j = i.length) > 3 ? j % 3 : 0;
                return s + (j ? i.substr(0, j) + t : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t) + (c ? d + Math.abs(n - i).toFixed(c).slice(2) : "");
            };

        </script>
    </div>
</asp:Content>
