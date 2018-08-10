Imports System.Data.SqlClient
Imports Ribat_Milkiya.kSQL

Public Class businessReg
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If loggedIn = False Then
            Response.Redirect("login.aspx")
        Else
            getClients()
        End If
    End Sub

    Sub getClients()

        Dim cmd As New SqlCommand
        cmd.CommandText = "SELECT ID,NAME,NATIONALITY,SEX,NAT_NO,REG_DATE FROM CLIENTS"
        Dim temp As String = ""

        Using msql As New kSQL(strConn)
            Dim tb = msql.DataTableGetir(cmd)

            For Each row As DataRow In tb.Rows
                ltrClients.Text += "<tr> " &
                    "<td>" & kSQL.rNull(row, "ID", 0) & "</td> " &
                    "<td>" & kSQL.rNull(row, "NAME", "") & "</td> " &
                    "<td>" & kSQL.rNull(row, "NATIONALITY", "") & "</td> " &
                    "<td>" & kSQL.rNull(row, "SEX", "") & "</td> " &
                    "<td>" & kSQL.rNull(row, "NAT_NO", "") & "</td> " &
                    "<td>" & kSQL.rNull(row, "REG_DATE", "") & "</td> " &
                    "<td><button class='btn btn-success btnSelectClient' data-id=" & kSQL.rNull(row, "ID", 0) & " data-name='" & kSQL.rNull(row, "NAME", "") & "'>إختر</button></td> " &
                    "</tr>"
            Next
        End Using
    End Sub
End Class