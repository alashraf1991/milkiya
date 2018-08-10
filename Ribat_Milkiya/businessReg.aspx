<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="businessReg.aspx.vb" Inherits="Ribat_Milkiya.businessReg" %>

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
                                        <asp:Literal ID="ltrClients" runat="server"></asp:Literal>
                                    </tbody>
                                </table>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>













    <div id="renew" class="modal" tabindex="-1" role="dialog">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">تجديد سجل تجاري</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="container">
                        <div class="row">

                            <div class="col-md-6">
                                رقم السجل التجاري
                                <input id="DCRNO" type="text" class="form-control" aria-label="Username" aria-describedby="basic-addon1" readonly>
                                إسم السجل التجاري
                                <input id="DCRNAME" type="text" class="form-control" aria-label="Username" aria-describedby="basic-addon1" readonly>


                                <label for="sel1">مدة التجديد</label>
                                <select class="form-control" id="sel1">
                                    <option>سنه</option>
                                    <option>3 سنوات</option>
                                    <option>5 سنوات</option>
                                </select>


                                <button style="margin-top:5px; float:left;" id="btnRenew" type="button" class="btn btn-info">تجديد</button>
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
                    <h3>تسجيل إسم عمل
                        <button class="btn btn-primary" id="btnNewReg">إسم عمل جديد</button></h3>
                </div>
            </div>

            <div class="container new_reg">
                <div class="row">

                    <div class="col-md-12 company">
                        <h2>بيانات إسم العمل</h2>
                        <br>
                        <div class="row">
                            <div class="col-md-4">
                                <input id="CLIENTID" type="text" class="form-control" aria-label="Username" aria-describedby="basic-addon1" readonly>
                            </div>

                            <div class="col-md-2">
                                <button id="btnSelect" style="float: right;" type="button" data-toggle="modal" data-target="#myModal" class="btn btn-primary">إختيار</button>
                            </div>
                        </div>

                        <br>
                        <div class="col-md-12">
                            الإسم التجاري
                        <input id="DCR_NAME" type="text" class="form-control" aria-label="Username" aria-describedby="basic-addon1">
                            مجال العمل
                        <input id="SECTOR" type="text" class="form-control" aria-label="Username" aria-describedby="basic-addon1">
                            نوع المؤسسه
                        <input id="TYPE" type="text" class="form-control" aria-label="Username" aria-describedby="basic-addon1">
                            رأس المال
                        <input id="FUND" type="number" class="form-control" aria-label="Username" aria-describedby="basic-addon1">




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
                                <th>رقم السجل التجاري</th>
                                <th>إسم العميل</th>
                                <th>إسم السجل التجاري</th>
                                <th>مجال العمل</th>
                                <th>نوع المؤسسه</th>
                                <th>رأس المال</th>
                                <th>تاريخ التسجيل</th>
                                <th>تاريخ الإنتهاء</th>
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
            var selectedID = "";

            $(".btnSelectClient").on("click", function () {

                selectedID = $(this).data("id");
                $("#CLIENTID").val($(this).data("name"));
            });


            $(".new_reg").css("display", "none");

            getBusinessList();
            function getBusinessList() {
                $.ajax({
                    type: "POST",
                    url: "data.aspx",
                    data: {
                        Operation: "getBusinessList"
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

                    var CLIENTID = selectedID;
                    var DCR_NAME = $("#DCR_NAME").val();
                    var SECTOR = $("#SECTOR").val();
                    var TYPE = $("#TYPE").val();
                    var FUND = $("#FUND").val();

                    $.ajax({
                        type: "POST",
                        url: "data.aspx",
                        data: {
                            CLIENTID: selectedID,
                            DCR_NAME: DCR_NAME,
                            SECTOR: SECTOR,
                            TYPE: TYPE,
                            FUND: FUND,
                            Operation: "saveBusiness"
                        },
                        success: function (result) {
                            if (result == "yes") {
                                $("#msg").html("تم الحفظ بنجاح");
                                $("#msg").css("color", "lime");
                                getBusinessList();
                                $(".new_reg").css("display", "none");

                                $("#DCR_NAME").val("");
                                $("#SECTOR").val("");
                                $("#TYPE").val("");
                                $("#FUND").val("");

                            } else {
                                $("#msg").html("حدث خطأ الرجاء المحاولة لاحقاً!");
                                $("#msg").css("color", "salmon");
                            }
                        }
                    });
                }

            });


            $(".btnSelectBusiness").on("click", function () {
                var dcrNo = $(this).children('td').eq(0);
                var dcrName = $(this).children('td').eq(0);

                $("#DCRNO").val(dcrNo);
                $("#DCRNAME").val(dcrName);

            });

        });
    </script>
</asp:Content>
