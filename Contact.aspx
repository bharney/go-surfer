<%@ Page Title="" Language="C#" MasterPageFile="~/GoSurfer.master" AutoEventWireup="true" CodeFile="Contact.aspx.cs" Inherits="Contact" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
        <!-- Custom CSS -->
    <link href="css/landing-page.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div class="container" style="padding-top: 50px;">
        <div class="row">
            <div class="col-xs-12 col-md-3">
                <section class="contact">
                    <header>
                        <h3>Contact Phone</h3>
                    </header>
                    <p class="indent">
                        <span>Brian Harney</span><br />
                        <span>630-849-6948</span>
                    </p>
                </section>
            </div>
            <div class="col-xs-12 col-md-3">
                <section class="contact">
                    <header>
                        <h3>Email</h3>
                    </header>
                    <p class="indent">
                        <span>Support: </span>
                        <span><a href="mailto:info@go-surfer.com">info@go-surfer.com</a></span>
                    </p>
                </section>
            </div>
            <div class="col-xs-12 col-md-3">
                <section class="contact">
                    <header>
                        <h3>Address:</h3>
                    </header>
                    <p>
                        1319 N. Campbell Ave.<br />
                        Chicago, IL 60622
                    </p>
                    <br />
                </section>
            </div>
        </div>
        <div class="contactForm">
            <header>
                <h3>Questions? Ask us anything!
                </h3>
            </header>
            <form>
                <table class="contactUs">
                    <tr>
                        <td style="padding-right: 5px; width: 20px;">Name:</td>
                        <td>
                            <input type="text" name="Name" id="Name" value="" style="align-items: flex-start; width: 100%; margin-bottom: 10px;" />
                        </td>
                        <td style="text-align: right; padding-left: 5px; padding-right: 5px;">E-mail:</td>
                        <td>
                            <input type="text" name="Email" id="Email" value="" style="width: 100%; margin-bottom: 10px;" />
                        </td>
                    </tr>
                    <tr style="margin-top: 10px;">
                        <td colspan="5">Comments/ Questions:</td>
                        <td></td>
                        <td></td>
                        <td></td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            <textarea rows="8" style="width: 100%;" name="Experience" id="Experience">
                            </textarea>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="5" style="text-align: right;">
                            <input type="submit" name="submit" id="submit" value="Submit" />
                        </td>
                    </tr>
                </table>
            </form>
            <br />
        </div>
    </div>


</asp:Content>

