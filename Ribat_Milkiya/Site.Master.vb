Public Class Site
    Inherits System.Web.UI.MasterPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If loggedIn = True And SYS_ADMIN = 1 Then
            ltrMenu.Text = ""
            lblStatus.Text = "<a href='#' id='logOff' class='advisor'>تسجيل الخروج</a>"

            ltrMenu.Text += " <li><a href='users.aspx'>إدارة المستخدمين</a></li>"
            ltrMenu.Text += " <li><a href='businessReg.aspx'>تسجيل بيانات إسم العمل</a></li>"
            ltrMenu.Text += " <li><a href='client.aspx'>تسجيل بيانات عميل</a></li>"

        ElseIf loggedIn = True And SYS_ADMIN = 0 Then
            ltrMenu.Text = ""
            lblStatus.Text = "<a href='#' id='logOff' class='advisor'>تسجيل الخروج</a>"

            ltrMenu.Text += " <li><a href='businessReg.aspx'>تسجيل بيانات إسم العمل</a></li>"
            ltrMenu.Text += " <li><a href='client.aspx'>تسجيل بيانات عميل</a></li>"
        Else
            lblStatus.Text = "<a href='login.aspx' class='advisor'>تسجيل الدخول</a>"
            ltrMenu.Text = ""
        End If
    End Sub

End Class