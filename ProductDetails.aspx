<%@ Page Title="" Language="C#" MasterPageFile="~/ProductDetails.master" AutoEventWireup="true" CodeFile="ProductDetails.aspx.cs" Inherits="ProductDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <!-- Custom CSS -->
    <link href="css/shop-homepage.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <!-- Page Content -->
    <div class="container">
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
                <form id="Form1" runat="server">
                    <asp:ScriptManager runat="server" />
                    <asp:SqlDataSource ID="sqlProductDetails" runat="server"
                        ConnectionString="<%$ ConnectionStrings:ConnectionDB01 %>"
                        InsertCommand="INSERT INTO [ShoppingCart] ([CartSessionID], [ProductID], [OrderQty], [ProductName], [ProductDescription], [ProductImageURL], [ProductDetailURL]) VALUES (@CartSessionID, @ProductID, @OrderQty, @ProductName, @ProductDescription, @ProductImageURL, @ProductDetailURL)"
                        SelectCommand="SELECT [ProductID], [ProductName], [ProductDescription], [ProductImageURL], [Price], [ProductDetailURL] FROM [Product] WHERE ([ProductID] = @ProductID)">
                        <InsertParameters>
                            <asp:ControlParameter ControlID="hdnCartSessionID" Name="CartSessionID" PropertyName="Value" Type="String" />
                            <asp:ControlParameter ControlID="hdnProductID" Name="ProductID" PropertyName="Value" Type="String" />
                            <asp:ControlParameter ControlID="hdnProductName" Name="ProductName" PropertyName="Value" Type="String" />
                            <asp:ControlParameter ControlID="hdnProductDescription" Name="ProductDescription" PropertyName="Value" Type="String" />
                            <asp:ControlParameter ControlID="hdnProductImageURL" Name="ProductImageURL" PropertyName="Value" Type="String" />
                            <asp:ControlParameter ControlID="hdnProductDetailURL" Name="ProductDetailURL" PropertyName="Value" Type="String" />
                            <asp:ControlParameter ControlID="hdnOrderQty" Name="OrderQty" PropertyName="Value" Type="Int32" />
                        </InsertParameters>
                        <SelectParameters>
                            <asp:QueryStringParameter Name="ProductID" QueryStringField="ProductID" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="sqlProdName" runat="server"
                        ConnectionString="<%$ ConnectionStrings:ConnectionDB01 %>"
                        SelectCommand="SELECT [ProductName] FROM [Product] WHERE ([ProductID] = @ProductID)">
                        <SelectParameters>
                            <asp:QueryStringParameter Name="ProductID" QueryStringField="ProductID" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="sqlProdDesc" runat="server"
                        ConnectionString="<%$ ConnectionStrings:ConnectionDB01 %>"
                        SelectCommand="SELECT [ProductDescription] FROM [Product] WHERE ([ProductID] = @ProductID)">
                        <SelectParameters>
                            <asp:QueryStringParameter Name="ProductID" QueryStringField="ProductID" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="sqlProdImg" runat="server"
                        ConnectionString="<%$ ConnectionStrings:ConnectionDB01 %>"
                        SelectCommand="SELECT [ProductImageURL] FROM [Product] WHERE ([ProductID] = @ProductID)">
                        <SelectParameters>
                            <asp:QueryStringParameter Name="ProductID" QueryStringField="ProductID" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="sqlPrice" runat="server"
                        ConnectionString="<%$ ConnectionStrings:ConnectionDB01 %>"
                        SelectCommand="SELECT [Price] FROM [Product] WHERE ([ProductID] = @ProductID)">
                        <SelectParameters>
                            <asp:QueryStringParameter Name="ProductID" QueryStringField="ProductID" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="sqlProdURL" runat="server"
                        ConnectionString="<%$ ConnectionStrings:ConnectionDB01 %>"
                        SelectCommand="SELECT [ProductDetailURL] FROM [Product] WHERE ([ProductID] = @ProductID)">
                        <SelectParameters>
                            <asp:QueryStringParameter Name="ProductID" QueryStringField="ProductID" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <!--[ProductName], [ProductDescription], [ProductImageURL], [Price], [ProductDetailURL]-->
                    <asp:HiddenField runat="server" ID="hdnCartSessionID" Value="" />
                    <asp:HiddenField runat="server" ID="hdnProductID" Value="" />
                    <asp:HiddenField runat="server" ID="hdnProductName" Value="" />
                    <asp:HiddenField runat="server" ID="hdnProductDescription" Value="" />
                    <asp:HiddenField runat="server" ID="hdnProductImageURL" Value="" />
                    <asp:HiddenField runat="server" ID="hdnProductDetailURL" Value="" />
                    <asp:HiddenField runat="server" ID="hdnOrderQty" Value="" /> 
                    <asp:UpdatePanel ID="udpAddToCart" UpdateMode="Conditional" runat="server">
                        <ContentTemplate>
                            <asp:Repeater ID="rptProducts" runat="server" DataSourceID="sqlProductDetails" OnItemCommand="rptProducts_ItemCommand">
                                <ItemTemplate>
                                    <div class="col-lg-12 col-xs-12">
                                        <img class="img-thumbnail" style="max-height:350px;" src='<%#Eval("[ProductImageURL]") %>' alt='<%#Eval("[ProductName]") %>' />
                                        <div class="row">
                                            <div class="col-lg-12 col-xs-12">
                                                <div class="caption-full">
                                                    <h4 class="pull-right">$<%#Eval("[Price]") %></h4>
                                                    <h4><%#Eval("[ProductName]") %></h4>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-lg-12 col-xs-12">
                                                    <div class="pull-right">
                                                        <asp:Button ID="btnAddToCart" CssClass="btn btn-primary" Text="Add to Cart" CommandName="addToCart" runat="server" />
                                                    </div>
                                                    <div class="caption-full">
                                                        <p class="text-left" style="padding-left:15px;"><%#Eval("[ProductDescription]") %></p>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="ratings">
                                            <p class="pull-right">3 reviews</p>
                                            <p>
                                                <span class="glyphicon glyphicon-star"></span>
                                                <span class="glyphicon glyphicon-star"></span>
                                                <span class="glyphicon glyphicon-star"></span>
                                                <span class="glyphicon glyphicon-star"></span>
                                                <span class="glyphicon glyphicon-star-empty"></span>
                                                4.0 stars
                                            </p>
                                        </div>
                                    </div>
                                </ItemTemplate>
                            </asp:Repeater>
                            <asp:Label ID="lblSession" Text="" Font-Size="Large" Visible="false" runat="server" ForeColor="#339933" /><div style="display:inline;">
                                <asp:HyperLink runat="server" ID="hplGoToCart" Visible="false" CssClass="btn btn-primary pull-right" NavigateUrl="ShoppingCart.aspx" Text="Go to Shopping Cart" />
                            </div>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </form>
            </div>
        </div>

        <div class="well" style="margin-top: 20px;">

            <div class="text-right">
                <a class="btn btn-success">Leave a Review</a>
            </div>

            <hr />

            <div class="row">
                <div class="col-md-12">
                    <span class="glyphicon glyphicon-star"></span>
                    <span class="glyphicon glyphicon-star"></span>
                    <span class="glyphicon glyphicon-star"></span>
                    <span class="glyphicon glyphicon-star"></span>
                    <span class="glyphicon glyphicon-star-empty"></span>
                    Anonymous
                           
                            <span class="pull-right">10 days ago</span>
                    <p>This product was great in terms of quality. I would definitely buy another!</p>
                </div>
            </div>

            <hr />

            <div class="row">
                <div class="col-md-12">
                    <span class="glyphicon glyphicon-star"></span>
                    <span class="glyphicon glyphicon-star"></span>
                    <span class="glyphicon glyphicon-star"></span>
                    <span class="glyphicon glyphicon-star"></span>
                    <span class="glyphicon glyphicon-star-empty"></span>
                    Anonymous
                           
                            <span class="pull-right">12 days ago</span>
                    <p>I've alredy ordered another one!</p>
                </div>
            </div>

            <hr />

            <div class="row">
                <div class="col-md-12">
                    <span class="glyphicon glyphicon-star"></span>
                    <span class="glyphicon glyphicon-star"></span>
                    <span class="glyphicon glyphicon-star"></span>
                    <span class="glyphicon glyphicon-star"></span>
                    <span class="glyphicon glyphicon-star-empty"></span>
                    Anonymous
                           
                            <span class="pull-right">15 days ago</span>
                    <p>I've seen some better than this, but not at this price. I definitely recommend this item.</p>
                </div>
            </div>

        </div>

    </div>
    <!-- /.container -->


</asp:Content>

