Imports System.Data.SqlClient
Imports Ribat_Milkiya.kSQL

Public Class data

    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Request.Form("Operation") = "login" Then
            SystemLogin()

        ElseIf Request.Form("Operation") = "logOff" Then
            loggedIn = False
            SYS_ADMIN = 0

            Dim cmd As New SqlCommand
            cmd.CommandText = "UPDATE USERS_LOG SET LOGGED_OFF = 1"
            Using msql As New kSQL(strConn)
                Dim a = msql.SorguCalistir(cmd)
            End Using
            Response.Write("done")
        ElseIf Request.Form("Operation") = "saveClient" Then
            saveClient()
        ElseIf Request.Form("Operation") = "getClients" Then
            getClients()
        ElseIf Request.Form("Operation") = "getBusinessList" Then
            getBusinessList()
        ElseIf Request.Form("Operation") = "saveBusiness" Then
            saveBusiness()
        ElseIf Request.Form("Operation") = "getUsersList" Then
            getUsersList()
        ElseIf Request.Form("Operation") = "saveUser" Then
            saveUser()
        End If
    End Sub

    Sub getClients()
        Dim toSelect As Boolean = Request.Form("toSelect")
        Dim style As String = " style='display: none;'"
        If toSelect = True Then
            style = " style='display:;'"
        End If

        Dim cmd As New SqlCommand
        cmd.CommandText = "SELECT ID,NAME,NATIONALITY,SEX,NAT_NO,REG_DATE FROM CLIENTS"
        Dim temp As String = ""

        Using msql As New kSQL(strConn)
            Dim tb = msql.DataTableGetir(cmd)

            For Each row As DataRow In tb.Rows
                temp += "<tr> " &
                    "<td>" & kSQL.rNull(row, "ID", 0) & "</td> " &
                    "<td>" & kSQL.rNull(row, "NAME", "") & "</td> " &
                    "<td>" & kSQL.rNull(row, "NATIONALITY", "") & "</td> " &
                    "<td>" & kSQL.rNull(row, "SEX", "") & "</td> " &
                    "<td>" & kSQL.rNull(row, "NAT_NO", "") & "</td> " &
                    "<td>" & kSQL.rNull(row, "REG_DATE", "") & "</td> " &
                    "<td " & style & "><button class='btn btn-success btnSelect' data-id=" & kSQL.rNull(row, "ID", 0) & " data-name='" & kSQL.rNull(row, "NAME", "") & "' id='btnSelectClient'>إختر</button></td> " &
                    "</tr>"
            Next
        End Using

        Response.Write(temp)
    End Sub

    Sub getBusinessList()
        Dim cmd As New SqlCommand
        cmd.CommandText = "SELECT ID,CLIENTID,DCR_NO,DCR_NAME,SECTOR,TYPE,FUND,REG_DATE,END_DATE FROM REGISTRATION"
        Dim temp As String = ""

        Using msql As New kSQL(strConn)
            Dim tb = msql.DataTableGetir(cmd)

            For Each row As DataRow In tb.Rows
                temp += "<tr> " &
                    "<td>" & kSQL.rNull(row, "DCR_NO", "") & "</td> " &
                    "<td>" & GetClientName(kSQL.rNull(row, "CLIENTID", 0)) & "</td> " &
                    "<td>" & kSQL.rNull(row, "DCR_NAME", "") & "</td> " &
                    "<td>" & kSQL.rNull(row, "SECTOR", "") & "</td> " &
                    "<td>" & kSQL.rNull(row, "TYPE", "") & "</td> " &
                    "<td>" & kSQL.rNull(row, "FUND", 0) & "</td> " &
                    "<td>" & kSQL.rNull(row, "REG_DATE", "") & "</td> " &
                    "<td>" & kSQL.rNull(row, "END_DATE", "") & "</td> " &
                    "<td><button class='btn btn-success btnSelectBusiness' data-toggle='modal' data-target='#renew' data-id=" & kSQL.rNull(row, "ID", 0) & " data-name='" & kSQL.rNull(row, "DCR_NO", "") & "'>تجديد</button></td> " &
                    "</tr>"
            Next
        End Using

        Response.Write(temp)
    End Sub

    Sub getUsersList()
        Dim cmd As New SqlCommand
        cmd.CommandText = "SELECT ID,USERNAME,ADMIN FROM USERS"
        Dim temp As String = ""

        Using msql As New kSQL(strConn)
            Dim tb = msql.DataTableGetir(cmd)

            For Each row As DataRow In tb.Rows
                temp += "<tr> " &
                    "<td>" & kSQL.rNull(row, "ID", "") & "</td> " &
                    "<td>" & kSQL.rNull(row, "USERNAME", "") & "</td> " &
                    "<td>" & IIf(kSQL.rNull(row, "ADMIN", "") = 1, "نعم", "لا") & "</td> " &
                    "<td><button class='btn btn-success btnSelectBusiness' data-id=" & kSQL.rNull(row, "ID", 0) & "'>حذف</button></td> " &
                    "</tr>"
            Next
        End Using

        Response.Write(temp)
    End Sub

    Function GetClientName(ByVal client_id)
        Dim cmd As New SqlCommand
        cmd.CommandText = "SELECT NAME FROM CLIENTS WHERE ID=" & client_id & ""

        Dim client_name As String = ""
        Using msql As New kSQL(strConn)
            client_name = msql.SorguCalistir(cmd)
        End Using

        Return client_name

    End Function

    Sub saveClient()
        Dim NAME As String = Request.Form("txtName")
        Dim NATIONALITY As String = Request.Form("combNat")
        Dim sex As String = Request.Form("sex")
        Dim NAT_NO As String = Request.Form("natNo")

        Try
            Dim cmd As New SqlCommand
            cmd.CommandText = "INSERT INTO CLIENTS (NAME,NATIONALITY,SEX,NAT_NO) VALUES (@NAME,@NATIONALITY,@SEX,@NAT_NO)"
            cmd.Parameters.Clear()
            cmd.Parameters.AddWithValue("@NAME", NAME)
            cmd.Parameters.AddWithValue("@NATIONALITY", NATIONALITY)
            cmd.Parameters.AddWithValue("@SEX", sex)
            cmd.Parameters.AddWithValue("@NAT_NO", NAT_NO)


            Using msql As New kSQL(strConn)
                Dim dt = msql.SorguCalistir(cmd)
            End Using

            Response.Write("yes")
        Catch ex As Exception
            Response.Write("no")
        End Try


    End Sub

    Sub saveBusiness()
        Dim CLIENTID As Integer = CInt(Request.Form("CLIENTID"))
        Dim DCR_NAME As String = Request.Form("DCR_NAME")
        Dim SECTOR As String = Request.Form("SECTOR")
        Dim TYPE As String = Request.Form("TYPE")
        Dim FUND As String = Request.Form("FUND")

        Try
            Dim cmd As New SqlCommand

            cmd.CommandText = "SELECT ISNULL(COUNT(*),0) C FROM REGISTRATION WHERE CLIENTID=@CLIENTID"
            cmd.Parameters.Clear()
            cmd.Parameters.AddWithValue("@CLIENTID", CLIENTID)
            Dim count As Integer = 0
            Using msql As New kSQL(strConn)
                count = msql.SorguCalistir(cmd) + 1
            End Using

            cmd.CommandText = "INSERT INTO REGISTRATION (CLIENTID,DCR_NO,DCR_NAME,SECTOR,TYPE,FUND,END_DATE) VALUES (@CLIENTID,@DCR_NO,@DCR_NAME,@SECTOR,@TYPE,@FUND,DATEADD(YEAR,1,GETDATE()))"
            cmd.Parameters.Clear()
            cmd.Parameters.AddWithValue("@CLIENTID", CLIENTID)
            cmd.Parameters.AddWithValue("@DCR_NO", Date.Now.Year & "-DCR-" & CLIENTID & "-" & count)
            cmd.Parameters.AddWithValue("@DCR_NAME", DCR_NAME)
            cmd.Parameters.AddWithValue("@SECTOR", SECTOR)
            cmd.Parameters.AddWithValue("@TYPE", TYPE)
            cmd.Parameters.AddWithValue("@FUND", FUND)


            Using msql As New kSQL(strConn)
                Dim dt = msql.SorguCalistir(cmd)
            End Using

            Response.Write("yes")
        Catch ex As Exception
            Response.Write("no")
        End Try


    End Sub

    Sub saveUser()
        Dim USERNAME As Integer = CInt(Request.Form("USERNAME"))
        Dim PASSWORD As String = Request.Form("PASSWORD")
        Dim ADMIN As Integer = Request.Form("ADMIN")

        Try
            Dim cmd As New SqlCommand

            cmd.CommandText = "INSERT INTO USERS (USERNAME,PASSWORD,ADMIN) VALUES (@USERNAME,@PASSWORD,@ADMIN)"
            cmd.Parameters.Clear()
            cmd.Parameters.AddWithValue("@USERNAME", USERNAME)
            cmd.Parameters.AddWithValue("@PASSWORD", PASSWORD)
            cmd.Parameters.AddWithValue("@ADMIN", ADMIN)


            Using msql As New kSQL(strConn)
                Dim dt = msql.SorguCalistir(cmd)
            End Using

            Response.Write("yes")
        Catch ex As Exception
            Response.Write("no")
        End Try


    End Sub

    Sub SystemLogin()
        Dim USERNAME As String = Request.Form("userName")
        Dim PASSWORD As String = Request.Form("pw")

        Dim i As Integer = 0
        Dim U_ID, U_NAME As String
        Dim ADMIN As Integer = 0

        Dim cmd As New SqlCommand
        cmd.CommandText = "SELECT ID,USERNAME,ADMIN FROM USERS WHERE USERNAME =@USERNAME AND PASSWORD=@PASSWORD"
        cmd.Parameters.Clear()
        cmd.Parameters.AddWithValue("@USERNAME", USERNAME)
        cmd.Parameters.AddWithValue("@PASSWORD", PASSWORD)
        Using mSql As New kSQL(strConn)
            Dim tb = mSql.DataTableGetir(cmd)

            For Each row As DataRow In tb.Rows
                i += 1
                U_ID = kSQL.rNull(row, "ID", 0)
                U_NAME = kSQL.rNull(row, "USERNAME", "")
                ADMIN = kSQL.rNull(row, "ADMIN", 0)

                loggedIn = True

                If ADMIN = 1 Then
                    SYS_ADMIN = 1
                End If
            Next

            cmd.CommandText = "DELETE FROM USERS_LOG "
            Dim dl = mSql.SorguCalistir(cmd)

            cmd.CommandText = "INSERT INTO USERS_LOG (USERID,LOGGED_OFF) VALUES (@USERID,0)"
            cmd.Parameters.Clear()
            cmd.Parameters.AddWithValue("@USERID", U_ID)

            Dim a = mSql.SorguCalistir(cmd)
        End Using

        If i = 1 Then
            Response.Write("yes")
        Else
            Response.Write("no")
        End If

    End Sub

End Class