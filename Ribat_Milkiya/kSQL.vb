Imports System.Data
Imports System.Data.SqlClient

Public Class kSQL : Implements System.IDisposable
    Public Property Conn As SqlConnection

    Sub New(ConnectionString As String)
        Me.Conn = New SqlConnection(ConnectionString)
        Me.Conn.Open()
    End Sub

    Public Function SorguCalistir(ByVal sqlCmd As SqlCommand) As String
        Dim ID As String = "0"

        sqlCmd.Connection = Conn

        Dim da As New SqlDataAdapter(sqlCmd)
        Dim dt As New DataTable()
        da.Fill(dt)
        da.Dispose()
        If (dt.Rows.Count > 0) Then
            ID = dt.Rows(0)(0).ToString()
        End If
        dt.Dispose()
        sqlCmd.Dispose()
        sqlCmd = Nothing
        Return ID

    End Function

    Public Function DataTableGetir(ByVal sqlCmd As SqlCommand) As DataTable
        Dim dt As New DataTable("data")
        sqlCmd.Connection = Conn
        sqlCmd.CommandTimeout = 0

        Dim da As New SqlDataAdapter(sqlCmd)

        da.Fill(dt)

        da.Dispose()
        sqlCmd.Dispose()
        sqlCmd = Nothing

        Return dt
    End Function

    Public Shared Function rNull(Data As DataRow, Alan As String, Def As Object) As Object
        If Data.IsNull(Alan) Then
            Return Def
        Else
            Return Data.Item(Alan)
        End If
    End Function

#Region "IDisposable Support"
    Private disposedValue As Boolean ' To detect redundant calls

    Protected Overridable Sub Dispose(disposing As Boolean)
        If Not Me.disposedValue Then
            If disposing Then
                If Me.Conn.State <> ConnectionState.Closed Then Me.Conn.Close()
            End If
            Me.Conn = Nothing
        End If
        Me.disposedValue = True
    End Sub

    Public Sub Dispose() Implements IDisposable.Dispose
        ' Do not change this code.  Put cleanup code in Dispose(ByVal disposing As Boolean) above.
        Dispose(True)
        GC.SuppressFinalize(Me)
    End Sub
#End Region
End Class
