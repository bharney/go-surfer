<%@ Page Title="" Language="C#" MasterPageFile="~/GoSurfer.master" AutoEventWireup="true" CodeFile="Waves.aspx.cs" Inherits="Waves" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
        <!-- Custom CSS -->
    <link href="css/landing-page.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <div class="container" style="padding-top: 50px;">
        <div class="row">
            <div class="col-sm-12 col-md-4">
                <video width="320" height="240">
                    <source src="images/SurfVideo.mp4" type="video/mp4"/>
                    Your browser does not support the video tag.
                </video>
            </div>
            <div class="col-sm-12 col-md-4">
                <iframe width="320" height="240" src="https://www.youtube.com/embed/4Dd-Ozfc7s8"></iframe>
            </div>
            <div class="col-sm-12 col-md-4">
                <iframe width="320" height="240" src="https://www.youtube.com/embed/0p83I2cHHJw"></iframe>
            </div>
        </div>
    </div>

</asp:Content>

