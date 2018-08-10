<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="login.aspx.vb" Inherits="Ribat_Milkiya.login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <section class="testimonial_sec clear_fix">
        <div class="container">
            <div class="row">
                <div class="col-md-4"></div>
                <div class="col-md-4 company">
                    <h2>تسجيل الدخول</h2>
                    <br>

                    <div class="col-md-12">
                        <input id="txtUserName" type="text" class="form-control" placeholder="إسم المستخدم" aria-label="Username" aria-describedby="basic-addon1">
                        <input id="txtPw" style="margin-top: 5px;" type="password" class="form-control" placeholder="كلمة المرور" aria-label="Username" aria-describedby="basic-addon1">

                        <br />
                        <p id="msg"></p>

                        <button id="btnLogin" style="margin-top: 5px; float: left;" type="button" class="btn btn-success">تسجيل الدخول</button>

                    </div>

                </div>
                <div class="col-md-4"></div>
            </div>
        </div>
    </section>

    <script type="text/javascript" src="scripts/jquery-1.10.2.min.js"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $("#btnLogin").on("click", function () {
                var userName = $("#txtUserName").val();
                var pw = $("#txtPw").val();
                $("#msg").html("");

                if (userName == "" || pw == "") {
                    $("#msg").html("الرجاء التحقق من البريد الإلكتروني وكلمة المرور");
                    $("#msg").css("color", "salmon");
                } else {

                    
                    $.ajax({
                        type: "POST",
                        url: "data.aspx",
                        data: {
                            userName: userName,
                            pw: pw,
                            Operation: "login"
                        },
                        success: function (result) {
                            if (result == "yes") {
                                $("#msg").html("");
                                window.location.href = "default.aspx";
                            } else {
                                $("#msg").html("الرجاء التحقق من البريد الإلكتروني وكلمة المرور");
                                $("#msg").css("color", "salmon");
                            }
                        }
                    });


                }


            });
        });
    </script>
</asp:Content>

