<%@ Page Title="" Language="C#" MasterPageFile="~/ProductCatalog.master" AutoEventWireup="true" CodeFile="ProductCatalog.aspx.cs" Inherits="GoSurfer_ProductCatalog" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <!-- Custom CSS -->
    <link href="css/shop-homepage.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <form runat="server">
        <asp:ScriptManager runat="server" />
        <!-- Page Content -->
        <div class="container">
            <asp:HiddenField ID="hdnCartSessionID" runat="server" />
            <div class="row">
                <asp:SqlDataSource ID="sqlCatalogs" runat="server"
                    ConnectionString="<%$ ConnectionStrings:ConnectionDB01 %>"
                    SelectCommand="SELECT [CatalogID], [CatalogName], [CatalogURL] FROM [Catalog]" />
                <div class="col-md-3">
                    <p class="lead">Select a Category:</p>
                    <div class="list-group">
                        <asp:Repeater ID="rptCatalogs" runat="server" DataSourceID="sqlCatalogs">
                            <ItemTemplate>
                                <a href='<%# VirtualPathUtility.ToAbsolute("~/ProductCatalog.aspx?CatalogID=" + 
                                Eval("CatalogID")) %>'
                                    class="list-group-item "><%# Eval("[CatalogName]") %></a>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>

                <div class="col-md-9">

                    <div class="row carousel-holder">

                        <div class="col-md-12">
                            <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
                                <ol class="carousel-indicators">
                                    <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
                                    <li data-target="#carousel-example-generic" data-slide-to="1"></li>
                                    <li data-target="#carousel-example-generic" data-slide-to="2"></li>
                                </ol>
                                <div class="carousel-inner">
                                    <div class="item active">
                                        <a href="#.aspx">
                                            <img class="slide-image" src="images/tshirts800x300.jpg" alt="" /></a>
                                    </div>
                                    <div class="item">
                                        <a href="GoSurfer/SurfStickerCatalog/ProductDetailimnotlost300x150.aspx">
                                            <img class="slide-image" src="images/imnotlost800x300.jpg" alt="" /></a>
                                    </div>
                                    <div class="item">
                                        <a href="#">
                                            <img class="slide-image" src="images/overheadmonster800x300.gif" alt="" /></a>
                                    </div>
                                </div>
                                <a class="left carousel-control" href="#carousel-example-generic" data-slide="prev">
                                    <span class="glyphicon glyphicon-chevron-left"></span>
                                </a>
                                <a class="right carousel-control" href="#carousel-example-generic" data-slide="next">
                                    <span class="glyphicon glyphicon-chevron-right"></span>
                                </a>
                            </div>
                        </div>

                    </div>

                    <div class="row">
                        <asp:SqlDataSource ID="sqlProducts" runat="server"
                            ConnectionString="<%$ ConnectionStrings:ConnectionDB01 %>"
                            SelectCommand="SELECT [ProductID], [ProductName], [ProductDescription], [ProductImageURL], [Price], [ProductCatalog], [Active], [ProductDetailURL] FROM [Product] WHERE ([ProductCatalog] = @ProductCatalog)"
                            InsertCommand="INSERT INTO [ShoppingCart] ([CartSessionID], [ProductID], [OrderQty], [ProductName], [ProductDescription], [ProductImageURL], [ProductDetailURL]) VALUES (@CartSessionID, @ProductID, @OrderQty, @ProductName, @ProductDescription, @ProductImageURL, @ProductDetailURL)">
                            <InsertParameters>
                                <asp:Parameter Name="CartSessionID" Type="String" />
                                <asp:Parameter Name="ProductID" Type="String" />
                                <asp:Parameter Name="ProductName" Type="String" />
                                <asp:Parameter Name="ProductDescription" Type="String" />
                                <asp:Parameter Name="ProductImageURL" Type="String" />
                                <asp:Parameter Name="ProductDetailURL" Type="String" />
                                <asp:Parameter Name="OrderQty" Type="Int32" />
                            </InsertParameters>
                            <SelectParameters>
                                <asp:QueryStringParameter Name="ProductCatalog" QueryStringField="CatalogID" Type="Int32" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:UpdatePanel ID="udpAddToCart" UpdateMode="Conditional" runat="server">
                            <ContentTemplate>
                                <asp:Repeater ID="rptProducts" runat="server" DataSourceID="sqlProducts" OnItemCommand="rptProducts_ItemCommand">
                                    <ItemTemplate>
                                        <div class="col-sm-4 col-lg-4 col-md-4 thumbnail" style="padding: 10px;">
                                            <asp:HiddenField ID="hdnProductID" Value='<%#Eval("[ProductID]") %>' runat="server" />
                                            <asp:HiddenField runat="server" ID="hdnProductName" Value='<%#Eval("[ProductName]") %>' />
                                            <asp:HiddenField runat="server" ID="hdnProductDescription" Value='<%#Eval("[ProductDescription]") %>' />
                                            <asp:HiddenField runat="server" ID="hdnProductImageURL" Value='<%#Eval("[ProductImageURL]") %>' />
                                            <asp:HiddenField runat="server" ID="hdnProductDetailURL" Value='<%#Eval("[ProductDetailURL]") %>' />
                                            <asp:HiddenField runat="server" ID="hdnOrderQty" Value="" />
                                            <a href='<%# VirtualPathUtility.ToAbsolute("~/ProductDetails.aspx?ProductID=" + 
                                Eval("ProductID")) %>'>
                                                <img src='<%#Eval("[ProductImageURL]") %>' alt='<%#Eval("[ProductName]") %>' /></a>
                                            <div class="row">
                                                <div class="col-lg-9">
                                                    <h4 class="text-left form-inline"><a href='<%#Eval("[ProductDetailURL]") %>'><%#Eval("[ProductName]") %></a></h4>
                                                </div>
                                                <div class="col-lg-3">
                                                    <h4 class="text-right form-inline">$<%#Eval("[Price]") %></h4>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-lg-12">
                                                    <p><%#Eval("[ProductDescription]") %></p>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-lg-12 text-center">
                                                    <asp:Button ID="btnAddToCart" CssClass="btn btn-primary btn-lg center-block btnaddToCart" Text="Add to Cart" CommandName="addToCart" runat="server" />
                                                </div>
                                            </div>
                                        </div>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </ContentTemplate>
                        </asp:UpdatePanel>
                    </div>
                </div>
            </div>
        </div>

        <!-- jQuery -->
        <script src="javaScript/jquery.js"></script>

        <!-- Bootstrap Core JavaScript -->
        <script src="javaScript/bootstrap.min.js"></script>

        <script type="text/javascript">
            $(document).ready(function () {
                $(".btnaddToCart").on('click', function () {
                    var $this = $(this);
                    $this.toggleClass('btnaddToCart');
                    if ($this.hasClass('btnaddToCart')) {
                        $this.text('Add to Cart');
                    } else {
                        $this.text('Successfully Added to Cart!');
                    }
                });
            });
        </script>
    </form>
</asp:Content>

