Public Class WebForm1
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If loggedIn = True And SYS_ADMIN = 1 Then
            Dim a = 1
        End If
    End Sub

End Class