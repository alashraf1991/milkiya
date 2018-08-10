<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="users.aspx.vb" Inherits="Ribat_Milkiya.users" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        a {
            color: white !important;
        }

        th {
            text-align: right;
        }

        .testimonial_sec .row {
            padding-top: 20px;
        }
    </style>

    <div id="myModal" class="modal" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">قم بإختيار العميل</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="container">
                        <div class="row">

                            <div class="col-md-6">
                                <table id="tblClients" class="table table-striped">
                                    <thead>
                                        <tr>
                                            <th>رقم العميل</th>
                                            <th>إسم العميل</th>
                                            <th>الجنيسية</th>
                                            <th>الجنس</th>
                                            <th>الرقم الوطني</th>
                                            <th>تاريخ فتح الملف</th>
                                            <th>إختر</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                        <asp:literal id="ltrClients" runat="server"></asp:literal>
                                    </tbody>
                                </table>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <section class="testimonial_sec clear_fix">
        <div class="container">
            <div class="row">
                <div class="col-md-12 pull-left">
                    <h3>إضافة مستخدم
                        <button class="btn btn-primary" id="btnNewReg">مستخدم جديد</button></h3>
                </div>
            </div>

            <div class="container new_reg">
                <div class="row">

                    <div class="col-md-12 company">
                        <h2>بيانات المستخدم</h2>
                        <br>
                   
                        <br>
                        <div class="col-md-12">
                            إسم المستخدم
                        <input id="USERNAME" type="text" class="form-control" aria-label="Username" aria-describedby="basic-addon1">
                            كلمة السر
                        <input id="PASSWORD" type="text" class="form-control" aria-label="Username" aria-describedby="basic-addon1">

                            <div class="form-check">
                                <input class="form-check-input" type="checkbox" value="" id="ADMIN">
                                <label class="form-check-label" for="ADMIN">
                                    Amin?
                                </label>
                            </div>

                            <button id="btnCancel" style="margin-top: 5px; margin-left: 10px; float: left;" type="button" class="btn btn-warning">إلغاء</button>
                            <button id="btnSave" style="margin-top: 5px; margin-left: 10px; float: left;" type="button" class="btn btn-success">حفظ</button>


                            <p id="msg"></p>
                        </div>

                    </div>

                </div>
            </div>

            <div class="row">

                <div class="col-md-12">
                    <table id="tblBusiness" class="table table-striped">
                        <thead>
                            <tr>
                                <th>رقم المستخدم</th>
                                <th>إسم المستخدم</th>
                                <th>مدير نظام؟</th>
                                <th>حذف</th>
                            </tr>
                        </thead>

                        <tbody>
                        </tbody>
                    </table>
                </div>

            </div>

        </div>
    </section>
    <script type="text/javascript" src="scripts/jquery-1.10.2.min.js"></script>
    <script type="text/javascript">

        $(document).ready(function () {
            
            $(".new_reg").css("display", "none");

            getUsersList();
            function getUsersList() {
                $.ajax({
                    type: "POST",
                    url: "data.aspx",
                    data: {
                        Operation: "getUsersList"
                    },
                    success: function (result) {
                        $("#tblBusiness tbody").html(result);
                    }
                });
            }

            $("#btnNewReg").on("click", function () {
                $(".new_reg").css("display", "");
            });

            $("#btnCancel").on("click", function () {
                $(".new_reg").css("display", "none");
            });


            $("#btnSave").on("click", function () {
                var valid = true;

                $("input[type=text]").each(function (indx, li) {

                    if ($(this).val() == "") {
                        valid = false;
                    }
                });


                if (valid == false) {
                    $("#msg").html("الرجاء التأكد من ملء جميع الحقول");
                    $("#msg").css("color", "salmon");
                } else {
                    var ADMIN  = 0;

                    
                    if ($("#ADMIN").prop('checked') == true) {
                        ADMIN = 1;
                    }
                    
                    var USERNAME = $("#USERNAME").val();
                    var PASSWORD = $("#PASSWORD").val();
                                      
                    $.ajax({
                        type: "POST",
                        url: "data.aspx",
                        data: {                            
                            USERNAME: USERNAME,
                            PASSWORD: PASSWORD,
                            ADMIN: ADMIN,                            
                            Operation: "saveUser"
                        },
                        success: function (result) {
                            if (result == "yes") {
                                $("#msg").html("تم الحفظ بنجاح");
                                $("#msg").css("color", "lime");
                                getUsersList();
                                $(".new_reg").css("display", "none");

                                $("#USERNAME").val("");
                                $("#PASSWORD").val("");                                

                            } else {
                                $("#msg").html("حدث خطأ الرجاء المحاولة لاحقاً!");
                                $("#msg").css("color", "salmon");
                            }
                        }
                    });
                }

            });




        });
    </script>
</asp:Content>

