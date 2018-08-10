<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="client.aspx.vb" Inherits="Ribat_Milkiya.client" %>

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
                    <h5 class="modal-title">تسجيل عميل جديد</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="container">
                        <div class="row">

                            <div class="col-md-6 company">
                                <h2>البيانات الشخصية للعميل</h2>
                                <br>

                                <div class="col-md-12">
                                    الإسم الأول
                        <input id="txtName" type="text" class="form-control" aria-label="Username" aria-describedby="basic-addon1">
                                    إسم الأب
                        <input id="txtFname" type="text" class="form-control" aria-label="Username" aria-describedby="basic-addon1">
                                    إسم الجد
                        <input id="txtGname" type="text" class="form-control" aria-label="Username" aria-describedby="basic-addon1">
                                    الجنسية
                         <select class="form-control" id="combNat">
                             <option>سوداني</option>
                             <option>أجنبي</option>
                         </select>
                                    <br />
                                    الجنس
                        
                        <label style="margin-right: 20px;" class="radio-inline">
                            <input style="margin-right: -18px;" type="radio" name="optradio" checked>ذكر</label>
                                    <label class="radio-inline">
                                        <input style="margin-right: -18px;" type="radio" name="optradio">أنثى</label>


                                    <br />
                                    <br />
                                    تاريخ الميلاد
                        <input class="datepicker" style="direction: rtl;" data-provide="datepicker">

                                    <br />
                                    <br />
                                    الرقم الوطني
                        <input id="txtNatNo" type="text" class="form-control" aria-label="Username" aria-describedby="basic-addon1">

                                    <br />

                                    <div class="checkbox">
                                        <label>
                                            <input style="margin-right: -22px;" type="checkbox" value="">أقر بأني لست موظف حكومي</label>
                                    </div>
                                    <div class="checkbox">
                                        <label>
                                            <input style="margin-right: -22px;" type="checkbox" value="">أقر بأني أكبر من 18 عام</label>
                                    </div>


                                    <button id="btnCancel" style="margin-top: 5px; margin-left: 10px; float: left;" type="button" data-dismiss="modal" class="btn btn-warning">إلغاء</button>
                                    <button id="btnSave" style="margin-top: 5px; margin-left: 10px; float: left;" type="button" class="btn btn-success">حفظ</button>


                                    <p id="msg"></p>
                                </div>

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
                    <h3>تسجيل عميل جديد</h3>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12 pull-left">
                    <button id="btnNew" data-toggle="modal" data-target="#myModal" type="button" class="btn btn-success">عميل جديد</button>
                    <a style="color: white;" href="default.aspx" type="button" class="btn btn-danger">الرئيسية</a>
                </div>
            </div>
            <div class="row">

                <div class="col-md-12">
                    <table id="tblClients" class="table table-striped">
                        <thead>
                            <tr>
                                <th>رقم العميل</th>
                                <th>إسم العميل</th>
                                <th>الجنيسية</th>
                                <th>الجنس</th>
                                <th>الرقم الوطني</th>
                                <th>تاريخ فتح الملف</th>
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
            $('.datepicker').datepicker();

            getClients();
            function getClients() {
                $.ajax({
                    type: "POST",
                    url: "data.aspx",
                    data: {
                        toSelect: false,
                        Operation: "getClients"
                    },
                    success: function (result) {
                        $("#tblClients tbody").html(result);
                    }
                });
            }

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

                    var txtName = $("#txtName").val();
                    var combNat = $("#combNat").val();
                    var sex = $('input[name=optradio]:checked').val();
                    var natNo = $("#txtNatNo").val();

                    $.ajax({
                        type: "POST",
                        url: "data.aspx",
                        data: {
                            txtName: txtName,
                            combNat: combNat,
                            sex: sex,
                            natNo: natNo,
                            Operation: "saveClient"
                        },
                        success: function (result) {
                            if (result == "yes") {
                                $("#msg").html("تم الحفظ بنجاح");
                                $("#msg").css("color", "lime");
                                getClients();
                                window.location.href = "default.aspx";
                            } else {
                                $("#msg").html("الرقم الوطني مسجل مسبقاً!");
                                $("#msg").css("color", "salmon");
                            }
                        }
                    });
                }

            });

         

        });
    </script>
</asp:Content>
