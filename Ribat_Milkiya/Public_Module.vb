Imports System.Data.SqlClient
Imports Ribat_Milkiya.kSQL

Module Public_Module
    Public strConn As String = ConfigurationManager.ConnectionStrings("strConn").ConnectionString.ToString
    Public loggedIn As Boolean = False
    Public SYS_ADMIN As Integer = 0


    Public Function CheckIfLoggedOf()
        Dim cmd As New SqlCommand
        cmd.CommandText = "SELECT COUNT(*) FROM USERS_LOG WHERE LOGGED_OFF = 1"

        Dim count As Integer = 0

        Using msql As New kSQL(strConn)
            count = msql.SorguCalistir(cmd)
        End Using

        If count = 0 Then
            loggedIn = True
        Else
            loggedIn = False
        End If


        Return loggedIn
    End Function
End Module
