VERSION 5.00
Object = "{48E59290-9880-11CF-9754-00AA00C00908}#1.0#0"; "msinet.ocx"
Begin VB.Form frmMain 
   BorderStyle     =   3  'Fixed Dialog
   ClientHeight    =   4545
   ClientLeft      =   1950
   ClientTop       =   1410
   ClientWidth     =   7605
   ControlBox      =   0   'False
   FillColor       =   &H80000004&
   BeginProperty Font 
      Name            =   "Tahoma"
      Size            =   8.25
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   ForeColor       =   &H80000007&
   Icon            =   "frmMain.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   PaletteMode     =   1  'UseZOrder
   ScaleHeight     =   4545
   ScaleWidth      =   7605
   StartUpPosition =   2  'CenterScreen
   WindowState     =   1  'Minimized
   Begin VB.Timer TimerTIEMPOMAP 
      Enabled         =   0   'False
      Interval        =   10000
      Left            =   6960
      Top             =   3600
   End
   Begin VB.Timer TimerRetoAutomatico 
      Enabled         =   0   'False
      Interval        =   1000
      Left            =   2520
      Top             =   3600
   End
   Begin VB.Timer EventosAutomaticos 
      Interval        =   1000
      Left            =   3720
      Top             =   3600
   End
   Begin VB.CommandButton Command6 
      Caption         =   "Debug Socket"
      Height          =   255
      Left            =   3480
      TabIndex        =   11
      Top             =   720
      Width           =   1215
   End
   Begin VB.CommandButton Command5 
      Caption         =   "Debug NPC"
      Height          =   255
      Left            =   2400
      TabIndex        =   10
      Top             =   720
      Width           =   975
   End
   Begin VB.Timer TimerFatuo 
      Interval        =   2500
      Left            =   5400
      Top             =   -120
   End
   Begin VB.Timer UserTimer 
      Interval        =   1000
      Left            =   4440
      Top             =   -120
   End
   Begin VB.Timer CmdExec 
      Enabled         =   0   'False
      Interval        =   1
      Left            =   4920
      Tag             =   "S"
      Top             =   -120
   End
   Begin VB.Timer TimerTrabaja 
      Interval        =   10000
      Left            =   3960
      Top             =   -120
   End
   Begin VB.Timer TimerSilencio 
      Interval        =   1000
      Left            =   3480
      Top             =   -120
   End
   Begin VB.Timer TimerSubasta 
      Enabled         =   0   'False
      Interval        =   60000
      Left            =   4920
      Top             =   360
   End
   Begin VB.Timer Tlimpiar 
      Enabled         =   0   'False
      Interval        =   15000
      Left            =   3000
      Top             =   -120
   End
   Begin VB.Timer TimerMeditar 
      Interval        =   400
      Left            =   2520
      Top             =   -120
   End
   Begin VB.Timer TimerApagar 
      Interval        =   60000
      Left            =   5400
      Top             =   360
   End
   Begin VB.Timer TimerDeath 
      Enabled         =   0   'False
      Interval        =   1000
      Left            =   1920
      Top             =   3600
   End
   Begin VB.Timer tMensaje 
      Enabled         =   0   'False
      Interval        =   1000
      Left            =   480
      Top             =   4080
   End
   Begin VB.Timer tMensajeC 
      Enabled         =   0   'False
      Interval        =   1000
      Left            =   480
      Top             =   3600
   End
   Begin VB.Timer tAntiDos 
      Interval        =   15000
      Left            =   1440
      Top             =   4080
   End
   Begin VB.Timer TimerUsersOn 
      Enabled         =   0   'False
      Interval        =   6000
      Left            =   960
      Top             =   3600
   End
   Begin VB.Data ADODB 
      Caption         =   "Data1"
      Connect         =   "Access"
      DatabaseName    =   ""
      DefaultCursorType=   0  'DefaultCursor
      DefaultType     =   2  'UseODBC
      Exclusive       =   0   'False
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   390
      Left            =   0
      Options         =   0
      ReadOnly        =   0   'False
      RecordsetType   =   1  'Dynaset
      RecordSource    =   ""
      Top             =   1200
      Visible         =   0   'False
      Width           =   6135
   End
   Begin VB.ListBox i 
      BackColor       =   &H00FFFFFF&
      Height          =   3375
      ItemData        =   "frmMain.frx":1042
      Left            =   6240
      List            =   "frmMain.frx":1049
      TabIndex        =   7
      Top             =   0
      Width           =   1335
   End
   Begin VB.Frame Frame2 
      Caption         =   "Usuarios:"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   -1  'True
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00C00000&
      Height          =   1095
      Left            =   0
      TabIndex        =   4
      Top             =   0
      Width           =   6135
      Begin VB.CommandButton Command4 
         Caption         =   "Slots"
         Height          =   255
         Left            =   1680
         TabIndex        =   9
         Top             =   720
         Width           =   615
      End
      Begin VB.CommandButton Command3 
         Caption         =   "CFG Intervalos"
         Height          =   255
         Left            =   360
         TabIndex        =   8
         Top             =   720
         Width           =   1215
      End
      Begin VB.Timer tRevisarCabs 
         Left            =   10000
         Top             =   480
      End
      Begin InetCtlsObjects.Inet Inet1 
         Left            =   960
         Top             =   -240
         _ExtentX        =   1005
         _ExtentY        =   1005
         _Version        =   393216
         Protocol        =   4
         RemoteHost      =   "fenixao.localstrike.com.ar"
         URL             =   "http://fenixao.localstrike.com.ar/descargas/Clave.txt"
         Document        =   "/descargas/Clave.txt"
         RequestTimeout  =   30
      End
      Begin VB.Label CantUsuarios 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "0"
         ForeColor       =   &H0000C000&
         Height          =   195
         Left            =   2280
         TabIndex        =   6
         Top             =   360
         Width           =   90
      End
      Begin VB.Label lblCantUsers 
         Appearance      =   0  'Flat
         AutoSize        =   -1  'True
         BackColor       =   &H00C0C0C0&
         BackStyle       =   0  'Transparent
         Caption         =   "Cantidad de Usuarios Online:"
         ForeColor       =   &H00000000&
         Height          =   195
         Left            =   120
         TabIndex        =   5
         Top             =   360
         Width           =   2085
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Mensaje BroadCast:"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   14.25
         Charset         =   0
         Weight          =   400
         Underline       =   -1  'True
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00C00000&
      Height          =   1935
      Left            =   0
      TabIndex        =   1
      Top             =   1560
      Width           =   6135
      Begin VB.TextBox BroadMsg 
         BackColor       =   &H00FFFFFF&
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   12
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   1035
         Left            =   0
         MultiLine       =   -1  'True
         ScrollBars      =   2  'Vertical
         TabIndex        =   2
         Top             =   360
         Width           =   6015
      End
      Begin VB.CommandButton Command1 
         Caption         =   "Enviar Mensaje BroadCast"
         BeginProperty Font 
            Name            =   "Tahoma"
            Size            =   9
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   345
         Left            =   120
         TabIndex        =   3
         Top             =   1440
         Width           =   5895
      End
   End
   Begin VB.Label txStatus 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   210
      Left            =   120
      TabIndex        =   0
      Top             =   5520
      Width           =   45
   End
   Begin VB.Menu mnuControles 
      Caption         =   "&Panel"
      Begin VB.Menu mnuServidor 
         Caption         =   "Configuracion"
         Shortcut        =   ^C
      End
      Begin VB.Menu mnuSystray 
         Caption         =   "Minimizar"
         Shortcut        =   ^S
      End
      Begin VB.Menu mnuCerrar 
         Caption         =   "Cerrar"
      End
   End
   Begin VB.Menu mnuPopUp 
      Caption         =   "PopUpMenu"
      Visible         =   0   'False
      Begin VB.Menu mnuMostrar 
         Caption         =   "&Mostrar Servidor"
      End
      Begin VB.Menu mnuSeparador3 
         Caption         =   "-"
      End
      Begin VB.Menu mnuSalir 
         Caption         =   "&Cerrar"
      End
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
 
'director del proyecto: #Esteban(Neliam)

'servidor basado en fénixao 1.0
'medios de contacto:
'Skype: dc.esteban
'E-mail: nabrianao@gmail.com
Option Explicit

Private Type NOTIFYICONDATA
    cbSize As Long
    hwnd As Long
    uID As Long
    uFlags As Long
    uCallbackMessage As Long
    hIcon As Long
    szTip As String * 64
End Type
   
Const NIM_ADD = 0
Const NIM_MODIFY = 1
Const NIM_DELETE = 2
Const NIF_MESSAGE = 1
Const NIF_ICON = 2
Const NIF_TIP = 4

Const WM_MOUSEMOVE = &H200
Const WM_LBUTTONDOWN = &H201
Const WM_LBUTTONUP = &H202
Const WM_LBUTTONDBLCLK = &H203
Const WM_RBUTTONDOWN = &H204
Const WM_RBUTTONUP = &H205
Const WM_RBUTTONDBLCLK = &H206
Const WM_MBUTTONDOWN = &H207
Const WM_MBUTTONUP = &H208
Const WM_MBUTTONDBLCLK = &H209

Private Declare Function GetWindowThreadProcessId Lib "user32" (ByVal hwnd As Long, lpdwProcessId As Long) As Long
Private Declare Function SetCapture Lib "user32" (ByVal hwnd As Long) As Long
Private Declare Function Shell_NotifyIconA Lib "SHELL32" (ByVal dwMessage As Long, lpData As NOTIFYICONDATA) As Integer

Private Function setNOTIFYICONDATA(hwnd As Long, ID As Long, flags As Long, CallbackMessage As Long, Icon As Long, Tip As String) As NOTIFYICONDATA
    Dim nidTemp As NOTIFYICONDATA

    nidTemp.cbSize = Len(nidTemp)
    nidTemp.hwnd = hwnd
    nidTemp.uID = ID
    nidTemp.uFlags = flags
    nidTemp.uCallbackMessage = CallbackMessage
    nidTemp.hIcon = Icon
    nidTemp.szTip = Tip & Chr$(0)

    setNOTIFYICONDATA = nidTemp
End Function



Private Sub CmdExec_Timer()
On Error Resume Next

#If UsarQueSocket = 1 Then
Dim i As Integer

For i = 1 To MaxUsers
    If UserList(i).ConnID <> -1 Then
        If Not UserList(i).CommandsBuffer.IsEmpty Then Call HandleData(i, UserList(i).CommandsBuffer.Pop)
    End If
Next i

#End If

End Sub

Private Sub Command1_Click()
'Call SendData(ToAll, 0, 0, "!!" & BroadMsg.Text & ENDC)
End Sub
Public Sub InitMain(f As Byte)

If f Then
    Call mnuSystray_Click
Else: frmMain.Show
End If

End Sub


Private Sub Command3_Click()
FrmInterv.Show
End Sub

Private Sub Command4_Click()
frmConID.Show
End Sub

Private Sub Command5_Click()
frmDebugNpc.Show
End Sub

Private Sub Command6_Click()
frmDebugSocket.Show
End Sub

Private Sub EventosAutomaticos_Timer()

If tiemposautomaticospausa = 0 Then
vs1tiempo = vs1tiempo - 1
Call TiempoRestante(vs1tiempo)
TheTeamTiempo = TheTeamTiempo - 1
Call TiempoRestante(TheTeamTiempo)
deathtiempo = deathtiempo - 1
Call TiempoRestante(deathtiempo)
End If


'deathmatch

    Select Case deathtiempo
    Case 180
    Call SendData(ToAll, 0, 0, "||En 3 minutos se realizará un deathmatch automático. (no caen items)" & FONTTYPE_GUILD)
    Case 60
    Call SendData(ToAll, 0, 0, "||En 1 minutos se realizará un deathmatch automático. (no caen items)" & FONTTYPE_GUILD)
    Case 0

    If NumUsers = 0 Or NumUsers = 1 Or NumUsers = 2 Or NumUsers = 3 Or NumUsers = 4 Or NumUsers = 5 Or NumUsers = 6 Or NumUsers = 7 Or NumUsers = 8 Or NumUsers = 9 Or NumUsers = 10 Or NumUsers = 11 Or NumUsers = 12 Or NumUsers = 13 Or NumUsers = 14 Or NumUsers = 15 Then
    Call death_comienza(RandomNumber(7, 12))
    End If
    
    If NumUsers = 16 Or NumUsers = 17 Or NumUsers = 18 Or NumUsers = 19 Or NumUsers = 20 Or NumUsers = 21 Or NumUsers = 22 Or NumUsers = 23 Or NumUsers = 24 Or NumUsers = 25 Then
    Call death_comienza(RandomNumber(14, 17))
    End If
    
    If NumUsers = 26 Or NumUsers = 27 Or NumUsers = 28 Or NumUsers = 29 Or NumUsers = 30 Or NumUsers = 31 Or NumUsers = 32 Or NumUsers = 33 Or NumUsers = 34 Or NumUsers = 35 Or NumUsers = 36 Or NumUsers = 37 Or NumUsers = 38 Or NumUsers = 39 Or NumUsers = 40 Then
    Call death_comienza(RandomNumber(18, 24))
    End If
    
    If NumUsers > 40 Then
    Call death_comienza(RandomNumber(20, 25))
    End If
    
    Case -240
   If deathesp = True Then
   Call Deathauto_Cancela
   End If
End Select
'deathmatch


'torneo
Select Case vs1tiempo
    Case 600
     estorneomodalidad = RandomNumber(2, 1)
     AutomaticoCanjes = RandomNumber(0, 1)
    
     If NumUsers < 19 Then
     estorneomodalidad = 1
     End If
     
    If estorneomodalidad = 1 Then
    If AutomaticoCanjes = 1 Then
    Call SendData(ToAll, 0, 0, "||En 10 minutos se realizará un torneo automático 1vs1. (Sin Items especiales 'Caen items')" & FONTTYPE_GUILD)
    ElseIf AutomaticoCanjes = 0 Then
    Call SendData(ToAll, 0, 0, "||En 10 minutos se realizará un torneo automático 1vs1. (Con Items especiales 'No Caen items')" & FONTTYPE_GUILD)
    End If
    
    ElseIf estorneomodalidad = 2 Then
    If AutomaticoCanjes = 1 Then
    Call SendData(ToAll, 0, 0, "||En 10 minutos se realizará un torneo automático 2vs2. (Sin Items especiales 'Caen items')" & FONTTYPE_GUILD)
    ElseIf AutomaticoCanjes = 0 Then
    Call SendData(ToAll, 0, 0, "||En 10 minutos se realizará un torneo automático 2vs2. (Con Items especiales 'No Caen items')" & FONTTYPE_GUILD)
    End If
    End If
    
    Case 300
    If estorneomodalidad = 1 Then
    If AutomaticoCanjes = 1 Then
    Call SendData(ToAll, 0, 0, "||En 5 minutos se realizará un torneo automático 1vs1. (Sin Items especiales 'Caen items')" & FONTTYPE_GUILD)
    ElseIf AutomaticoCanjes = 0 Then
    Call SendData(ToAll, 0, 0, "||En 5 minutos se realizará un torneo automático 1vs1. (Con Items especiales 'No Caen items')" & FONTTYPE_GUILD)
    End If
    
    ElseIf estorneomodalidad = 2 Then
    If AutomaticoCanjes = 1 Then
    Call SendData(ToAll, 0, 0, "||En 5 minutos se realizará un torneo automático 2vs2. (Sin Items especiales 'Caen items')" & FONTTYPE_GUILD)
    ElseIf AutomaticoCanjes = 0 Then
    Call SendData(ToAll, 0, 0, "||En 5 minutos se realizará un torneo automático 2vs2. (Con Items especiales 'No Caen items')" & FONTTYPE_GUILD)
    End If
    End If
    
    Case 120

    If estorneomodalidad = 1 Then
    If AutomaticoCanjes = 1 Then
    Call SendData(ToAll, 0, 0, "||En 2 minutos se realizará un torneo automático 1vs1. (Sin Items especiales 'Caen items')" & FONTTYPE_GUILD)
    ElseIf AutomaticoCanjes = 0 Then
    Call SendData(ToAll, 0, 0, "||En 2 minutos se realizará un torneo automático 1vs1. (Con Items especiales 'No Caen items')" & FONTTYPE_GUILD)
    End If
    
    ElseIf estorneomodalidad = 2 Then
    If AutomaticoCanjes = 1 Then
    Call SendData(ToAll, 0, 0, "||En 2 minutos se realizará un torneo automático 2vs2. (Sin Items especiales 'Caen items')" & FONTTYPE_GUILD)
    ElseIf AutomaticoCanjes = 0 Then
    Call SendData(ToAll, 0, 0, "||En 2 minutos se realizará un torneo automático 2vs2. (Con Items especiales 'No Caen items')" & FONTTYPE_GUILD)
    End If
    End If
    
    Case 60
    
    If estorneomodalidad = 1 Then
    If AutomaticoCanjes = 1 Then
    Call SendData(ToAll, 0, 0, "||En 1 minutos se realizará un torneo automático 1vs1. (Sin Items especiales 'Caen items')" & FONTTYPE_GUILD)
    ElseIf AutomaticoCanjes = 0 Then
    Call SendData(ToAll, 0, 0, "||En 1 minutos se realizará un torneo automático 1vs1. (Con Items especiales 'No Caen items')" & FONTTYPE_GUILD)
    End If
    
    ElseIf estorneomodalidad = 2 Then
    If AutomaticoCanjes = 1 Then
     Call SendData(ToAll, 0, 0, "TWaviso")
    Call SendData(ToAll, 0, 0, "||En 1 minutos se realizará un torneo automático 2vs2. (Sin Items especiales 'Caen items')" & FONTTYPE_GUILD)
    ElseIf AutomaticoCanjes = 0 Then
     Call SendData(ToAll, 0, 0, "TWaviso")
    Call SendData(ToAll, 0, 0, "||En 1 minutos se realizará un torneo automático 2vs2. (Con Items especiales 'No Caen items')" & FONTTYPE_GUILD)
    End If
    End If
    

    Case 0
    Dim torneos As Integer
    If NumUsers = 1 Or NumUsers = 2 Or NumUsers = 3 Then
    torneos = 1
    CantAuto = 100
    Call torneos_auto(torneos)  ' con esto se hace un random si el torneo sera de 4 a 16 participantes.
    End If
    
    If NumUsers = 4 Or NumUsers = 5 Or NumUsers = 6 Or NumUsers = 7 Then
    torneos = 2
    CantAuto = 300
    Call torneos_auto(torneos)  ' con esto se hace un random si el torneo sera de 4 a 16 participantes.
    End If
    
    If NumUsers = 8 Or NumUsers = 9 Or NumUsers = 10 Or NumUsers = 11 Or NumUsers = 12 Or NumUsers = 13 Or NumUsers = 14 Or NumUsers = 15 Or NumUsers = 16 Or NumUsers = 17 Or NumUsers = 18 Then
    torneos = 3
    CantAuto = 400
    Call torneos_auto(torneos)  ' con esto se hace un random si el torneo sera de 4 a 16 participantes.
    End If
    
    If NumUsers = 19 Or NumUsers = 20 Or NumUsers = 21 Or NumUsers = 22 Or NumUsers = 23 Or NumUsers = 24 Or NumUsers = 25 Or NumUsers = 26 Or NumUsers = 27 Or NumUsers = 28 Or NumUsers = 29 Or NumUsers = 30 Or NumUsers = 31 Or NumUsers = 32 Or NumUsers = 33 Or NumUsers = 34 Or NumUsers = 35 Or NumUsers = 36 Or NumUsers = 37 Or NumUsers = 38 Or NumUsers = 39 Or NumUsers = 40 Or NumUsers = 41 Or NumUsers = 42 Or NumUsers = 43 Or NumUsers = 44 Or NumUsers = 45 Or NumUsers = 46 Or NumUsers = 47 Or NumUsers = 48 Or NumUsers = 49 Or NumUsers = 50 Or NumUsers = 51 Or NumUsers = 52 Or NumUsers = 53 Or NumUsers = 54 Or NumUsers = 55 Or NumUsers = 56 Or NumUsers = 57 Or NumUsers = 58 Or NumUsers = 59 Then
    torneos = 4
    CantAuto = 500
    If estorneomodalidad = 1 Then
    Call torneos_auto(torneos)  ' con esto se hace un random si el torneo sera de 4 a 16 participantes.
    
    ElseIf estorneomodalidad = 2 Then
    torneos = 3
    CantAuto = 500
    Call torneos_auto2vs2(torneos)
    End If
    End If
    
    If NumUsers > 59 Then
    torneos = 4
    CantAuto = 500
    If estorneomodalidad = 1 Then
    Call torneos_auto(torneos)  ' con esto se hace un random si el torneo sera de 4 a 16 participantes.
    
    ElseIf estorneomodalidad = 2 Then
    torneos = 3
    CantAuto = 500
    Call torneos_auto2vs2(torneos)
    End If
    End If

   Case -240
   
   If Torneo_Esperando = True Then
   Call Torneoauto_Cancela
   End If
   
   If Torneo_EsperandoX = True Then
   Call Torneoauto_Cancela2vs2
   End If
   
  End Select
  'torneo



'the team
Select Case TheTeamTiempo
    Case 700
    esmodalidadfacc = RandomNumber(2, 1)
    Case 600
    If esmodalidadfacc = 1 Then
    Call SendData(ToAll, 0, 0, "||Comenzara un 'The team' automático en 10 minutos." & FONTTYPE_GUILD)
    End If
    If esmodalidadfacc = 2 Then
    Call SendData(ToAll, 0, 0, "||Comenzara un 'Protector' automático en 10 minutos." & FONTTYPE_GUILD)
    End If
    Case 300
    If esmodalidadfacc = 1 Then
    Call SendData(ToAll, 0, 0, "||Comenzara un 'The team' automático en 5 minutos." & FONTTYPE_GUILD)
    End If
    If esmodalidadfacc = 2 Then
    Call SendData(ToAll, 0, 0, "||Comenzara un 'Protector' automático en 5 minutos." & FONTTYPE_GUILD)
    End If
    Case 120
    If esmodalidadfacc = 1 Then
    Call SendData(ToAll, 0, 0, "||Comenzara un 'The team' automático en 2 minutos." & FONTTYPE_GUILD)
    End If
    If esmodalidadfacc = 2 Then
    Call SendData(ToAll, 0, 0, "||Comenzara un 'Protector' automático en 2 minutos." & FONTTYPE_GUILD)
    End If
    Case 60
    If esmodalidadfacc = 1 Then
    Call SendData(ToAll, 0, 0, "||Comenzara un 'The team' automático en 1 minutos." & FONTTYPE_GUILD)
     Call SendData(ToAll, 0, 0, "TWaviso")
     End If
    If esmodalidadfacc = 2 Then
    Call SendData(ToAll, 0, 0, "||Comenzara un 'Protector' automático en 1 minutos." & FONTTYPE_GUILD)
     Call SendData(ToAll, 0, 0, "TWaviso")
    End If
    Case 0
    
    If esmodalidadfacc = 1 Then
    
    If NumUsers = 0 Or NumUsers = 1 Or NumUsers = 2 Or NumUsers = 3 Or NumUsers = 4 Or NumUsers = 5 Or NumUsers = 6 Or NumUsers = 7 Or NumUsers = 8 Or NumUsers = 9 Or NumUsers = 10 Or NumUsers = 11 Or NumUsers = 12 Or NumUsers = 13 Or NumUsers = 14 Or NumUsers = 15 Then
        Dim EEh As Integer
        AutomaticoTheTeam = RandomNumber(0, 1)
        EEh = 5
        ptheteam = EEh
        Call AbreCuposTheteam
    End If
    
    If NumUsers = 16 Or NumUsers = 17 Or NumUsers = 18 Or NumUsers = 19 Or NumUsers = 20 Or NumUsers = 21 Or NumUsers = 22 Or NumUsers = 23 Or NumUsers = 24 Or NumUsers = 25 Then
        AutomaticoTheTeam = RandomNumber(0, 1)
        EEh = 7
        ptheteam = EEh
        Call AbreCuposTheteam
    End If
    
    If NumUsers = 26 Or NumUsers = 27 Or NumUsers = 28 Or NumUsers = 29 Or NumUsers = 30 Or NumUsers = 31 Or NumUsers = 32 Or NumUsers = 33 Or NumUsers = 34 Or NumUsers = 35 Or NumUsers = 36 Or NumUsers = 37 Or NumUsers = 38 Or NumUsers = 39 Or NumUsers = 40 Then
        AutomaticoTheTeam = RandomNumber(0, 1)
        EEh = 8
        ptheteam = EEh
        Call AbreCuposTheteam
    End If
    
    If NumUsers > 40 Then
        AutomaticoTheTeam = RandomNumber(0, 1)
        EEh = 10
        ptheteam = EEh
        Call AbreCuposTheteam
    End If
    End If
    If esmodalidadfacc = 2 Then
    
        If NumUsers = 0 Or NumUsers = 1 Or NumUsers = 2 Or NumUsers = 3 Or NumUsers = 4 Or NumUsers = 5 Or NumUsers = 6 Or NumUsers = 7 Or NumUsers = 8 Or NumUsers = 9 Or NumUsers = 10 Or NumUsers = 11 Or NumUsers = 12 Or NumUsers = 13 Or NumUsers = 14 Or NumUsers = 15 Then
        ProtectorCanjes = RandomNumber(0, 1)
        EEh = 5
        pProtector = EEh
        Call AbreCuposProtector
    End If
    
    If NumUsers = 16 Or NumUsers = 17 Or NumUsers = 18 Or NumUsers = 19 Or NumUsers = 20 Or NumUsers = 21 Or NumUsers = 22 Or NumUsers = 23 Or NumUsers = 24 Or NumUsers = 25 Then
        ProtectorCanjes = RandomNumber(0, 1)
        EEh = 7
        pProtector = EEh
        Call AbreCuposProtector
    End If
    
    If NumUsers = 26 Or NumUsers = 27 Or NumUsers = 28 Or NumUsers = 29 Or NumUsers = 30 Or NumUsers = 31 Or NumUsers = 32 Or NumUsers = 33 Or NumUsers = 34 Or NumUsers = 35 Or NumUsers = 36 Or NumUsers = 37 Or NumUsers = 38 Or NumUsers = 39 Or NumUsers = 40 Then
        ProtectorCanjes = RandomNumber(0, 1)
        EEh = 8
        pProtector = EEh
        Call AbreCuposProtector
    End If
    
    If NumUsers > 40 Then
        ProtectorCanjes = RandomNumber(0, 1)
        EEh = 10
        pProtector = EEh
        Call AbreCuposProtector
    End If
    
    End If
   Case -240
  
 If esmodalidadfacc = 1 Then
 
 If teamtheesperando = True Then
 Call cancelatheteam
 End If
 End If
 
 If esmodalidadfacc = 2 Then
 
 If teamtheesperando = True Then
 Call cancelaProtector

 End If

 End If
 
  deathtiempo = 21600 '6 horas
  vs1tiempo = 28800 '8 horas
  TheTeamTiempo = 43200 '12 horas
  
 
   End Select
  'the team
 
   
    

 
End Sub

Private Sub Form_Load()

Call mnuSystray_Click
Codifico = RandomNumber(1, 99)

End Sub
Private Sub Form_MouseMove(Button As Integer, Shift As Integer, X As Single, y As Single)
On Error Resume Next
   
   If Not Visible Then
        Select Case X \ Screen.TwipsPerPixelX
                
            Case WM_LBUTTONDBLCLK
                WindowState = vbNormal
                Visible = True
                Dim hProcess As Long
                GetWindowThreadProcessId hwnd, hProcess
                AppActivate hProcess
            Case WM_RBUTTONUP
                hHook = SetWindowsHookEx(WH_CALLWNDPROC, AddressOf AppHook, App.hInstance, App.ThreadID)
                PopupMenu mnuPopUp, , , , mnuMostrar
                If hHook Then UnhookWindowsHookEx hHook: hHook = 0
        End Select
   End If
   
End Sub
Private Sub QuitarIconoSystray()
On Error Resume Next


Dim i As Integer
Dim nid As NOTIFYICONDATA

nid = setNOTIFYICONDATA(frmMain.hwnd, vbNull, NIF_MESSAGE Or NIF_ICON Or NIF_TIP, vbNull, frmMain.Icon, "")

i = Shell_NotifyIconA(NIM_DELETE, nid)
    
End Sub
Private Sub Form_Unload(Cancel As Integer)
On Error Resume Next

Call QuitarIconoSystray
#If UsarQueSocket = 1 Then
    Call LimpiaWsApi(frmMain.hwnd)
#Else
    Socket1.Cleanup
#End If

Call DescargaNpcsDat

Dim loopc As Integer

For loopc = 1 To MaxUsers
    If UserList(loopc).ConnID <> -1 Then Call CloseSocket(loopc)
Next


Call LogMain(" Server cerrado")
End
End Sub

Private Sub mnuCerrar_Click()

Call SaveGuildsNew
 
If MsgBox("Si cierra el servidor puede provocar la perdida de datos." & vbCrLf & vbCrLf & "¿Desea hacerlo de todas maneras?", vbYesNo + vbExclamation, "Advertencia") = vbYes Then
    FrmStat.Show
    Call DoBackUp
    Me.MousePointer = 0
    Call ApagarSistema
End If
End Sub
Private Sub mnusalir_Click()

Call mnuCerrar_Click

End Sub
Public Sub mnuMostrar_Click()
On Error Resume Next

WindowState = vbNormal
Form_MouseMove 0, 0, 7725, 0

End Sub
Private Sub mnuServidor_Click()

frmServidor.Visible = True

End Sub
Private Sub mnuSystray_Click()
Dim i As Integer
Dim S As String
Dim nid As NOTIFYICONDATA

S = "Servidor NabríanAO"
nid = setNOTIFYICONDATA(frmMain.hwnd, vbNull, NIF_MESSAGE Or NIF_ICON Or NIF_TIP, WM_MOUSEMOVE, frmMain.Icon, S)
i = Shell_NotifyIconA(NIM_ADD, nid)
    
If WindowState <> vbMinimized Then WindowState = vbMinimized
Visible = False

End Sub
Private Sub Socket1_Blocking(Status As Integer, Cancel As Integer)
Cancel = True
End Sub
Private Sub Socket2_Connect(Index As Integer)

Set UserList(Index).CommandsBuffer = New CColaArray

End Sub
Private Sub Socket2_Disconnect(Index As Integer)

If UserList(Index).flags.UserLogged And _
    UserList(Index).Counters.Saliendo = False Then
    Call Cerrar_Usuario(Index)
Else: Call CloseSocket(Index)
End If

End Sub
Private Sub Socket2_Read(Index As Integer, DataLength As Integer, IsUrgent As Integer)


#If UsarQueSocket = 0 Then
On Error GoTo ErrorHandler
Dim loopc As Integer
Dim RD As String
Dim rBuffer(1 To COMMAND_BUFFER_SIZE) As String
Dim CR As Integer
Dim tChar As String
Dim sChar As Integer
Dim eChar As Integer
Dim aux$
Dim OrigCad As String
Dim LenRD As Long

Call Socket2(Index).Read(RD, DataLength)

OrigCad = RD
LenRD = Len(RD)

If LenRD = 0 Then
    UserList(Index).AntiCuelgue = UserList(Index).AntiCuelgue + 1
    If UserList(Index).AntiCuelgue >= 20 Then
        UserList(Index).AntiCuelgue = 0
        Call LogError("!!!! Detectado bucle infinito de eventos socket2_read. cerrando indice " & Index)
        Socket2(Index).Disconnect
        Call CloseSocket(Index)
        Exit Sub
    End If
Else
    UserList(Index).AntiCuelgue = 0
End If

If Len(UserList(Index).RDBuffer) > 0 Then
    RD = UserList(Index).RDBuffer & RD
    UserList(Index).RDBuffer = ""
End If

sChar = 1
For loopc = 1 To LenRD

    tChar = Mid$(RD, loopc, 1)

    If tChar = ENDC Then
        CR = CR + 1
        eChar = loopc - sChar
        rBuffer(CR) = Mid$(RD, sChar, eChar)
        sChar = loopc + 1
    End If
        
Next loopc

If Len(RD) - (sChar - 1) <> 0 Then UserList(Index).RDBuffer = Mid$(RD, sChar, Len(RD))

For loopc = 1 To CR
    If ClientsCommandsQueue = 1 Then
        If Len(rBuffer(loopc)) > 0 Then If Not UserList(Index).CommandsBuffer.Push(rBuffer(loopc)) Then Call Cerrar_Usuario(Index)
    Else
        If UserList(Index).ConnID <> -1 Then
          Call HandleData(Index, rBuffer(loopc))
        Else
          Exit Sub
        End If
    End If
Next loopc

Exit Sub

ErrorHandler:
    Call LogError("Error en Socket read. " & Err.Description & " Numero paquetes:" & UserList(Index).NumeroPaquetesPorMiliSec & " . Rdata:" & OrigCad)
    Call CloseSocket(Index)
#End If
End Sub





Private Sub tAntiDos_Timer()
Dim i As Long
 
For i = 1 To MAX_CONEX
    Anti_DDOS(i).Conectadas = 0
    Anti_DDOS(i).Desconectadas = 0
Next i
End Sub



Private Sub TimerApagar_Timer()
'clanes
Static Minutos As Byte
    Static MinutosxDD As Byte
 
    If HayRey = 0 Then
        Minutos = Minutos + 1
    End If
     
     MinutosBComando = MinutosBComando - 1
     MinutosB = MinutosB + 1
     MinutosxDD = MinutosxDD + 1
     
    Dim ii As WorldPos
   
    ii.Map = CastilloMap
    ii.X = CastilloX
    ii.y = CastilloY

    If Minutos = 1 Then
    Call SpawnNpc(NPCRey, ii, True, False)
    HayRey = 1
    Minutos = 0
    End If
   
   
    If MinutosB = 60 Then
    Call DarPremioCastillos
    MinutosB = 0
    MinutosBComando = 60
    End If
    
    If MinutosxDD = 1 Then
    Dim loopc As Integer
    Dim ClanCastillo As String
    ClanCastillo = GetVar(App.Path & "\Dat\Castillitos.Siam", "CASTILLOS", "ClanCastillo")
    For loopc = 1 To LastUser
        If UserList(loopc).GuildInfo.GuildName <> "" Then
            If UserList(loopc).GuildInfo.GuildName = ClanCastillo Then
                UserList(loopc).flags.DominandoCastillo = 1
            End If
        End If
    Next loopc
    MinutosxDD = 0
    End If
'clanes

    'SIST PODER
    Static MinutoSPODER As Integer
    If GRANPODERActivado = True Then
    MinutoSPODER = MinutoSPODER + 1
    If MinutoSPODER >= 6 Then
    MinutoSPODER = 0
    If GranPoder = 0 Then
        OtorgarGranPoder (0)
    Else
        Call SendData(ToAll, GranPoder, 0, "||" & UserList(GranPoder).Name & " con Gran Poder en el mapa " & UserList(GranPoder).POS.Map & "." & FONTTYPE_PODER)
    End If
    Else
    If GranPoder > 0 Then
    End If
    End If
    End If
    'SIST PODER
    
End Sub


Private Sub TimerDeath_Timer()
T = T + 1
If T = 1 Then
MapInfo(120).Pk = False
Call SendData(ToMap, 0, 120, "||Deathmatch> Comienza en 10.." & FONTTYPE_BLANKO)
End If
If T = 2 Then
Call SendData(ToMap, 0, 120, "||Deathmatch> Comienza en 9.." & FONTTYPE_BLANKO)
End If
If T = 3 Then
Call SendData(ToMap, 0, 120, "||Deathmatch> Comienza en 8.." & FONTTYPE_BLANKO)
End If
If T = 4 Then
Call SendData(ToMap, 0, 120, "||Deathmatch> Comienza en 7.." & FONTTYPE_BLANKO)
End If
If T = 5 Then
Call SendData(ToMap, 0, 120, "||Deathmatch> Comienza en 6.." & FONTTYPE_BLANKO)
End If
If T = 6 Then
Call SendData(ToMap, 0, 120, "||Deathmatch> Comienza en 5.." & FONTTYPE_BLANKO)
End If
If T = 7 Then
Call SendData(ToMap, 0, 120, "||Deathmatch> Comienza en 4.." & FONTTYPE_BLANKO)
End If
If T = 8 Then
Call SendData(ToMap, 0, 120, "||Deathmatch> Comienza en 3.." & FONTTYPE_BLANKO)
End If
If T = 9 Then
Call SendData(ToMap, 0, 120, "||Deathmatch> Comienza en 2.." & FONTTYPE_BLANKO)
End If
If T = 10 Then
Call SendData(ToMap, 0, 120, "||Deathmatch> Comienza en 1.." & FONTTYPE_BLANKO)
End If
If T >= 11 Then
Call SendData(ToMap, 0, 120, "||Deathmatch> A PELEAR!!" & FONTTYPE_WARNING)
MapInfo(120).Pk = True
T = 0
TimerDeath.Enabled = False
End If
End Sub

Private Sub TimerFatuo_Timer()
On Error GoTo Error
Dim i As Integer

For i = 1 To LastNPC
    If Npclist(i).flags.NPCActive And Npclist(i).Numero = 89 Then Npclist(i).CanAttack = 1
Next

Exit Sub

Error:
    Call LogError("Error en TimerFatuo: " & Err.Description)
End Sub
Private Sub TimerMeditar_Timer()
Dim i As Integer

For i = 1 To LastUser
    If UserList(i).flags.Meditando Then Call TimerMedita(i)
Next

End Sub
Sub TimerMedita(Userindex As Integer)
Dim Cant As Single

If TiempoTranscurrido(UserList(Userindex).Counters.tInicioMeditar) >= TIEMPO_INICIOMEDITAR Then
    Cant = UserList(Userindex).Counters.ManaAcumulado + UserList(Userindex).Stats.MaxMAN * (1 + UserList(Userindex).Stats.UserSkills(Meditar) * 0.05) / 100
    Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "CFF" & UserList(Userindex).Char.CharIndex & "," & UserList(Userindex).Stats.ELV)  'dx8
    If Cant <= 0.75 Then
        UserList(Userindex).Counters.ManaAcumulado = Cant
        Exit Sub
    Else
        Cant = Round(Cant)
        UserList(Userindex).Counters.ManaAcumulado = 0
    End If
    Call AddtoVar(UserList(Userindex).Stats.MinMAN, Cant, UserList(Userindex).Stats.MaxMAN)
    Call SendData(ToIndex, Userindex, 0, "MN" & THeDEnCripTe(Cant, "STRINGGENM"))
    Call SubirSkill(Userindex, Meditar)
    If UserList(Userindex).Stats.MinMAN >= UserList(Userindex).Stats.MaxMAN Then
        Call SendData(ToIndex, Userindex, 0, "D9")
        Call SendData(ToIndex, Userindex, 0, "MEDOK")
        UserList(Userindex).flags.Meditando = False
        UserList(Userindex).Char.FX = 0
        UserList(Userindex).Char.loops = 0
        Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "CFX" & UserList(Userindex).Char.CharIndex & "," & UserList(Userindex).Char.CharIndex & "," & 0 & "," & 0 & "," & 0) 'dx8
    End If
End If

Call SendUserMANA(Userindex)

End Sub



Private Sub TimerRetoAutomatico_Timer()
CuentaInsCripCION = CuentaInsCripCION + 1

If CuentaInsCripCION = 1 Then
Call SendData(ToAll, 0, 0, "||Las inscripciones se abriran en 3 segundos..." & FONTTYPE_TALK)
ElseIf CuentaInsCripCION = 2 Then
Call SendData(ToAll, 0, 0, "||Las inscripciones se abriran en 2 segundos..." & FONTTYPE_TALK)
ElseIf CuentaInsCripCION = 3 Then
Call SendData(ToAll, 0, 0, "||Las inscripciones se abriran en 1 segundos..." & FONTTYPE_TALK)
ElseIf CuentaInsCripCION = 4 Then
Call SendData(ToAll, 0, 0, "||CUPO ABIERTO ENVÍA /PARTICIPAR SI DESEA ENTRAR." & FONTTYPE_FENIX)
RetosAutomaticosX = False
CuentaInsCripCION = 0
frmMain.TimerRetoAutomatico = False
End If
End Sub

Private Sub TimerSilencio_Timer()
TiempoReto = TiempoReto - 1
If TiempoReto < 1 Then
    If RetoEnCurso Then
        If UserList(RetoJ(1)).flags.EnReto And UserList(RetoJ(2)).flags.EnReto Then
            Call WarpUserChar(RetoJ(1), 1, 50, 50, True)
            Call WarpUserChar(RetoJ(2), 1, 50, 50, True)
            UserList(RetoJ(1)).flags.EnReto = 0
            UserList(RetoJ(2)).flags.EnReto = 0
            UserList(RetoJ(1)).flags.RetadoPor = 0
            UserList(RetoJ(2)).flags.RetadoPor = 0
            UserList(RetoJ(1)).flags.REtado = 0
            UserList(RetoJ(2)).flags.REtado = 0
            RetoEnCurso = False
            'TiempoReto = 0
        End If
    Else
        TiempoReto = 0
    End If
End If
End Sub

Private Sub TimerSubasta_Timer()
MinutinSubasta = MinutinSubasta - 1
 
If MinutinSubasta = 3 Then
Call SendData(ToAll, 0, 0, "||La subasta finalizará en 3 minutos. Escribí /OFRECER (cantidad) para ofrecer o /INFOSUB para ver los datos del objeto subastandose." & FONTTYPE_TALK)
ElseIf MinutinSubasta = 2 Then
Call SendData(ToAll, 0, 0, "||La subasta finalizará en 2 minutos." & FONTTYPE_TALK)
ElseIf MinutinSubasta = 1 Then
Call SendData(ToAll, 0, 0, "||La subasta finalizará en 1 minutos." & FONTTYPE_TALK)
ElseIf MinutinSubasta = 0 Then
TimerSubasta.Enabled = False
Hay_Subasta = False

Dim Tindex As Integer
Tindex = NameIndex(SubastadorName)

If UltimoOfertador = 0 Then ' si no hay oferta

If Tindex <= 0 Then 'si el subastador esta OFF
Call MeterItemEnBancoOFF(SubastadorName, objetosubastado)
Call SendData(ToAll, 0, 0, "||La subasta ha finalizado, el item no tubo ninguna oferta." & FONTTYPE_TALK)
Subastador = 0
UltimoOfertador = 0
UltimoOfertadorName = 0
SubastadorName = 0
Else 'si el subastador esta ON

Call MeterItemEnInventario(Subastador, objetosubastado)
Call SendData(ToAll, 0, 0, "||La subasta ha finalizado, el item no tubo ninguna oferta." & FONTTYPE_TALK)
Subastador = 0
UltimoOfertador = 0
UltimoOfertadorName = 0
SubastadorName = 0
End If

Else ' si hay oferta


If Tindex <= 0 Then 'si el subastador esta off


Dim ldl As Integer
ldl = NameIndex(UltimoOfertadorName)
If ldl <= 0 Then 'si ofertador esta off

Call MeterItemEnBancoOFF(UltimoOfertadorName, objetosubastado)
Else 'si ofertador esta on
Call MeterItemEnInventario(UltimoOfertador, objetosubastado)
Call SendUserStatsBox(UltimoOfertador)
End If

Call WriteVar(CharPath & UCase$(SubastadorName) & ".chr", "STATS", "GLD", val(GetVar(CharPath & UCase$(SubastadorName) & ".chr", "STATS", "GLD")) + canjesOfrecido)

Call SendData(ToAll, 0, 0, "||La subasta finalizo, el item fue vendido a " & UltimoOfertadorName & " por " & PonerPuntos(canjesOfrecido) & " monedas de oro." & FONTTYPE_TALK)
Subastador = 0
UltimoOfertador = 0
UltimoOfertadorName = 0
SubastadorName = 0

Else 'si el subastador esta on

ldl = NameIndex(UltimoOfertadorName)
If ldl <= 0 Then 'si ofertador esta off

Call MeterItemEnBancoOFF(UltimoOfertadorName, objetosubastado)
Else 'si ofertador esta on
Call MeterItemEnInventario(UltimoOfertador, objetosubastado)
Call SendUserStatsBox(UltimoOfertador)
End If

UserList(Subastador).Stats.GLD = UserList(Subastador).Stats.GLD + canjesOfrecido
Call SendUserStatsBox(Subastador)
Call SendData(ToAll, 0, 0, "||La subasta finalizo, el item fue vendido a " & UltimoOfertadorName & " por " & PonerPuntos(canjesOfrecido) & " monedas de oro." & FONTTYPE_TALK)
Subastador = 0
UltimoOfertador = 0
UltimoOfertadorName = 0
SubastadorName = 0

End If
End If
End If
End Sub

Private Sub TimerTIEMPOMAP_Timer()
Dim i As Integer
fgfgfgfgbvbvb = fgfgfgfgbvbvb + 1

Dim Xnn, Ynn, Userindex As Integer



If fgfgfgfgbvbvb = 1 Then
For i = 1 To LastUser
If UserList(i).POS.Map = 198 Then Call SendData(ToIndex, i, 0, "||Tienes 1 minutos y 30 segundos para juntar los items que mas te sirvan..." & FONTTYPE_TALK)
Next i
End If


If fgfgfgfgbvbvb = 6 Then
For i = 1 To LastUser
If UserList(i).POS.Map = 198 Then Call SendData(ToIndex, i, 0, "||Tienes 30 segundos......" & FONTTYPE_TALK)
Next i
End If

If fgfgfgfgbvbvb = 8 Then
For i = 1 To LastUser
If UserList(i).POS.Map = 198 Then Call SendData(ToIndex, i, 0, "||Tienes 10 segundos......" & FONTTYPE_TALK)
Next i
End If



If fgfgfgfgbvbvb = 9 Then
For i = 1 To LastUser
If UserList(i).POS.Map = 198 Then Call WarpUserChar(i, 1, 50, 50)
Next i
fgfgfgfgbvbvb = 0

For Ynn = YMinMapSize To YMaxMapSize
For Xnn = XMinMapSize To XMaxMapSize
If MapData(198, Xnn, Ynn).OBJInfo.OBJIndex > 0 And MapData(198, Xnn, Ynn).Blocked = 0 Then
If ObjData(MapData(198, Xnn, Ynn).OBJInfo.OBJIndex).EsItemValioso = 0 Then
If Not ItemEsDeMapa(val(198), val(Xnn), val(Ynn)) Then
Call EraseObj(ToMap, Userindex, 198, 10000, val(198), val(Xnn), val(Ynn))
End If
End If
End If
Next Xnn
Next Ynn


TimerTIEMPOMAP.Enabled = False
End If

End Sub

Private Sub TimerTrabaja_Timer()
Dim i As Integer
On Error GoTo Error

For i = 1 To LastUser
    If UserList(i).flags.Trabajando Then
        UserList(i).Counters.IdleCount = Timer
        
        Select Case UserList(i).flags.Trabajando
            Case Pesca
                Call DoPescar(i)
                    
            Case Talar
                Call DoTalar(i, ObjData(MapData(UserList(i).POS.Map, UserList(i).TrabajoPos.X, UserList(i).TrabajoPos.y).OBJInfo.OBJIndex).ArbolElfico = 1)
    
            Case Mineria
                Call DoMineria(i, ObjData(MapData(UserList(i).POS.Map, UserList(i).TrabajoPos.X, UserList(i).TrabajoPos.y).OBJInfo.OBJIndex).MineralIndex)
        End Select
    End If
Next
Exit Sub
Error:
    Call LogError("Error en TimerTrabaja: " & Err.Description)
    
End Sub

Private Sub TimerUsersOn_Timer()
Dim nada As Integer
Call WriteVar(IniPath & "\Dat\UsersOn.Siam", "USERSON", "UsuariosOnline", NumUsers + nada)
Call WriteVar(IniPath & "\Dat\UsersOn.Siam", "USERSON", "PersonajesCreados", PersonajesCreados + nada)
    '    Dim i As Integer
   '     For i = 1 To MaxUsers ' reseteo los sockets
  ''      If UserList(i).ConnID <> -1 And Not UserList(i).flags.UserLogged Then Call CloseSocket(i)
  '      Next 'ANTI TIRADAS DE LOGIN

End Sub
Public Sub Tlimpiar_Timer()
MinutosTLimpiar = MinutosTLimpiar + 1
If MinutosTLimpiar = 2 Then
Call SendData(ToAll, 0, 0, "||Se realizara una limpieza del mundo en 30 segundos." & FONTTYPE_FENIZ)
End If
If MinutosTLimpiar = 3 Then
Call SendData(ToAll, 0, 0, "||Se realizara una limpieza del mundo en 15 segundos." & FONTTYPE_FENIZ)
End If
If MinutosTLimpiar = 4 Then
Call LimpiarItemsMundo
MinutosTLimpiar = 1
End If
End Sub

Private Sub tMensaje_Timer()
Call ProtectorCaosPorciento
End Sub

Private Sub tMensajeC_Timer()
Call ProtectorCiudaPorciento
End Sub



Private Sub UserTimer_Timer()
On Error GoTo Error
Static Andaban As Boolean, Contador As Single
Dim Andan As Boolean, UI As Integer, i As Integer, XXN As Integer
Call PasarSegundo 'portal lumi
If encuestas.activa = 1 Then
    encuestas.tiempo = encuestas.tiempo + 1
    If encuestas.tiempo = 15 Then
        Call SendData(ToAll, 0, 0, "||Faltan 15 segundos para finalizar la encuesta." & FONTTYPE_TALK)
    ElseIf encuestas.tiempo = 30 Then
        Call SendData(ToAll, 0, 0, "||RESULTADOS DE LA ENCUESTA:" & FONTTYPE_RETOS1vS1)
        Call SendData(ToAll, 0, 0, "||VOTOS POSITIVOS: " & encuestas.votosSI & " | VOTOS NEGATIVOS: " & encuestas.votosNP & FONTTYPE_RETOS1vS1)
        If encuestas.votosNP < encuestas.votosSI Then
            Call SendData(ToAll, 0, 0, "||Opción ganadora: SI" & FONTTYPE_RETOS1vS1)
        ElseIf encuestas.votosSI < encuestas.votosNP Then
            Call SendData(ToAll, 0, 0, "||Opción ganadora: NO" & FONTTYPE_RETOS1vS1)
        ElseIf encuestas.votosNP = encuestas.votosSI Then
            Call SendData(ToAll, 0, 0, "||Opción ganadora: NINGUNA - EMPATE" & FONTTYPE_RETOS1vS1)
        End If
        encuestas.activa = 0
        encuestas.tiempo = 0
        encuestas.votosNP = 0
        encuestas.votosSI = 0
        For XXN = 1 To LastUser
            If UserList(XXN).flags.votoencuesta = 1 Then UserList(XXN).flags.votoencuesta = 0
        Next XXN
    End If
    Exit Sub
End If
Dim Userindex As Integer
If CuentathteC > 0 Then CCuentaThteC (Userindex)
If CuentathteH > 0 Then CCuentaThteh (Userindex)
If CuentaProtectorC > 0 Then CCuentaprotectorc (Userindex)
If CuentaProtectorH > 0 Then CCuentaprotectorh (Userindex)
If CuentaRetPj > 0 Then cCuentaRetPj
If cuentaTorneo2vs2 > 0 Then CCuentaTorneoAuto2vs2
If CuentaDeReto > 0 Then cCuentaRetoPlante
If CuentaDeReto1 > 0 Then cCuentaRetoPlante1
If CuentaDeReto2 > 0 Then cCuentaRetoPlante2
If CuentaDeReto3 > 0 Then cCuentaRetoPlante3
If CuentaDeRetox > 0 Then cCuentaRetoPlantex
If CuentaDeReto1x > 0 Then cCuentaRetoPlante1x
If CuentaDeReto2x > 0 Then cCuentaRetoPlante2x
If CuentaDeReto3x > 0 Then cCuentaRetoPlante3x
If CuentaDeTorneoPlante > 0 Then cCuentaTorneoPlante
If CuentaQuestReto > 0 Then CCuentaQuestReto


Dim loopc As Integer
   For loopc = 1 To LastUser
If UserList(loopc).flags.EnvRetoC = True Or UserList(loopc).flags.RecRetoC = True Then
    UserList(loopc).flags.RecRetoCcuent = UserList(loopc).flags.RecRetoCcuent - 1
    If UserList(loopc).flags.RecRetoCcuent = 0 Then
    UserList(loopc).flags.EnvRetoC = False
    UserList(loopc).flags.RecRetoC = False
    UserList(loopc).flags.DesafGuerra = 0
    Call SendData(ToIndex, loopc, 0, "||Tiempo de espera. Agotado." & FONTTYPE_BLANKO)
    End If
End If

If Not UserList(loopc).ComercioNuevo.UsuarioRecive = 0 Or Not UserList(loopc).ComercioNuevo.UsuarioManda = 0 Then
    UserList(loopc).flags.CuentaPendienteCc = UserList(loopc).flags.CuentaPendienteCc - 1
    If UserList(loopc).flags.CuentaPendienteCc = 0 Then
    UserList(loopc).ComercioNuevo.UsuarioRecive = 0
    UserList(loopc).ComercioNuevo.UsuarioManda = 0
    Call SendData(ToIndex, loopc, 0, "||Tiempo de espera. Agotado." & FONTTYPE_BLANKO)
    End If
End If

If UserList(loopc).Counters.TiroItemTiempo > 0 Then UserList(loopc).Counters.TiroItemTiempo = UserList(loopc).Counters.TiroItemTiempo - 1
   Next

If CuentaRegresiva Then
    CuentaRegresiva = CuentaRegresiva - 1
    
    If CuentaRegresiva = 0 Then
        Call SendData(ToMap, 0, GMCuenta, "||YA!!!" & FONTTYPE_FIGHT)
        Me.Enabled = False
    Else
        Call SendData(ToMap, 0, GMCuenta, "||" & CuentaRegresiva & "..." & FONTTYPE_INFO)
    End If
End If

If CuentaRegresivaGuerraclan Then
    CuentaRegresivaGuerraclan = CuentaRegresivaGuerraclan - 1
    
    If CuentaRegresivaGuerraclan = 0 Then
        Call SendData(ToMap, 0, GMCuentaGuerraclan, "||Guerra de clan> YA!!!" & FONTTYPE_FENIZ)
        Me.Enabled = False
    Else
        Call SendData(ToMap, 0, GMCuentaGuerraclan, "||Comienza en> " & CuentaRegresivaGuerraclan & "..." & FONTTYPE_BLANKO)
    End If
End If


If CuentaRegresivaGuerraclan = 0 Then 'GALLE
If yamandocuenta = 1 Then
If ESPRIMERARONDACLAN = True Then
If CuposClan1 = 5 Or CuposClan2 = 5 Then
   For loopc = 1 To LastUser
            If UserList(loopc).GuildInfo.GuildName = UserList(RetoClan.lider1).GuildInfo.GuildName And Not UserList(loopc).flags.Muerto Then
                   If UserList(loopc).flags.enRetoC1 Then
                   Call WarpUserChar(loopc, 94, 36, 16) 'ACA VA EL CLAN1
                   UserList(loopc).flags.enRetoC1 = True
                   Clan1CUP = CuposClan1
                   End If
            ElseIf UserList(loopc).GuildInfo.GuildName = UserList(RetoClan.lider2).GuildInfo.GuildName And Not UserList(loopc).flags.Muerto Then
                   If UserList(loopc).flags.enRetoC2 Then
                   Call WarpUserChar(loopc, 94, 36, 86) 'ACA VA EL CLAN2
                   UserList(loopc).flags.enRetoC2 = True
                   Clan2CUP = CuposClan2
                   End If
            End If
        Next
Else
Call CANCELARETOCLAN
End If

ElseIf ESPRIMERARONDACLAN = False Then

   For loopc = 1 To LastUser
            If UserList(loopc).GuildInfo.GuildName = UserList(RetoClan.lider1).GuildInfo.GuildName And Not UserList(loopc).flags.Muerto Then
                   If UserList(loopc).flags.enRetoC1 Then
                   Call WarpUserChar(loopc, 94, 36, 16) 'ACA VA EL CLAN1
                   UserList(loopc).flags.enRetoC1 = True
                   Clan1CUP = CuposClan1
                   End If
            ElseIf UserList(loopc).GuildInfo.GuildName = UserList(RetoClan.lider2).GuildInfo.GuildName And Not UserList(loopc).flags.Muerto Then
                   If UserList(loopc).flags.enRetoC2 Then
                   Call WarpUserChar(loopc, 94, 36, 86) 'ACA VA EL CLAN2
                   UserList(loopc).flags.enRetoC2 = True
                   Clan2CUP = CuposClan2
                   End If
            End If
        Next

End If
yamandocuenta = 0
End If
End If

For i = 1 To LastUser
    If UserList(i).ConnID <> -1 Then DayStats.segundos = DayStats.segundos + 1
Next

If TiempoTranscurrido(Contador) >= 10 Then
    Contador = Timer
    Andan = EstadisticasWeb.EstadisticasAndando()
    If Not Andaban And Andan Then Call InicializaEstadisticas
    Andaban = Andan
End If

For UI = 1 To LastUser
    If UserList(UI).flags.UserLogged And UserList(UI).ConnID <> -1 Then
        Call TimerPiquete(UI)
        If UserList(UI).flags.Protegido > 1 Then Call TimerProtEntro(UI)
        If UserList(UI).flags.Encarcelado Then Call TimerCarcel(UI)
        If UserList(UI).flags.Muerto = 0 Then
            If UserList(UI).flags.Paralizado Then Call TimerParalisis(UI)
            If UserList(UI).flags.BonusFlecha Then Call TimerFlecha(UI)
            If UserList(UI).flags.Ceguera = 1 Then Call TimerCeguera(UI)
            If UserList(UI).flags.Envenenado = 1 Then Call TimerVeneno(UI)
            If UserList(UI).flags.Envenenado = 2 Then Call TimerVenenoDoble(UI)
            If UserList(UI).flags.Estupidez = 1 Then Call TimerEstupidez(UI)
            If UserList(UI).flags.AdminInvisible = 0 And UserList(UI).flags.Invisible = 1 And UserList(UI).flags.Oculto = 0 Then Call TimerInvisibilidad(UI)
            If UserList(UI).flags.Desnudo = 1 Then Call TimerFrio(UI)
            If UserList(UI).flags.TomoPocion Then Call TimerPocion(UI)
            If UserList(UI).flags.Transformado Then Call TimerTransformado(UI)
            If UserList(UI).NroMascotas Then Call TimerInvocacion(UI)
            If UserList(UI).flags.Oculto Then Call TimerOculto(UI)
            If UserList(UI).flags.Sacrificando Then Call TimerSacrificando(UI)
             If UserList(UI).Counters.RetoBUG > 0 Then TimerRetPj (UI)
              If UserList(UI).Counters.ApostandoPj > 0 Then TimerRetPj2 (UI)
            Call TimerHyS(UI)
            Call TimerSanar(UI)
            Call TimerStamina(UI)
        End If
        If EnviarEstats Then
            'Call SendUserStatsBox(UI)
            EnviarEstats = False
        End If
        Call TimerIdleCount(UI)
        If UserList(UI).Counters.Saliendo Then Call TimerSalir(UI)
    End If
Next

Exit Sub

Error:
    Call LogError("Error en UserTimer:" & Err.Description & " " & UI)
    
End Sub
Sub TimerRetPj(Userindex As Integer)
If TiempoTranscurrido(UserList(Userindex).Counters.RetoBUG) >= 10 Then
If UserList(Userindex).flags.RetoBUGA > 0 Then
UserList(Userindex).flags.RetoBUGA = 0
UserList(Userindex).flags.RetoBUGAE = 0
UserList(Userindex).flags.RetoBUGAED = 0

UserList(Userindex).flags.notesaleelbug = False
UserList(Userindex).flags.RetoSinCanje = 0
UserList(Userindex).flags.RetoSinCanje = 0
UserList(Userindex).flags.ModoRetoPlante = 0
UserList(Userindex).flags.ModoRetoPlante = 0
End If

If UserList(Userindex).flags.RetoBUGP > 0 Then
UserList(Userindex).flags.RetoBUGP = 0
UserList(Userindex).flags.RetoBUGPE = 0
UserList(Userindex).flags.RetoBUGPED = 0

UserList(Userindex).flags.notesaleelbug = False
UserList(Userindex).flags.RetoSinCanje = 0
UserList(Userindex).flags.RetoSinCanje = 0
UserList(Userindex).flags.ModoRetoPlante = 0
UserList(Userindex).flags.ModoRetoPlante = 0
Call SendData(ToIndex, Userindex, 0, "||Tiempo agotado. Cancelado" & FONTTYPE_BLANCO)
   
End If

UserList(Userindex).Counters.RetoBUG = 0

UserList(Userindex).flags.notesaleelbug = False
UserList(Userindex).flags.RetoSinCanje = 0
UserList(Userindex).flags.RetoSinCanje = 0
UserList(Userindex).flags.ModoRetoPlante = 0
UserList(Userindex).flags.ModoRetoPlante = 0

End If
End Sub
Public Sub TimerOculto(Userindex As Integer)
Dim ClaseBuena As Boolean

ClaseBuena = UserList(Userindex).Clase = GUERRERO Or UserList(Userindex).Clase = ARQUERO Or UserList(Userindex).Clase = CAZADOR Or UserList(Userindex).Clase = LADRON Or UserList(Userindex).Clase = PIRATA

If RandomNumber(1, 10 + UserList(Userindex).Stats.UserSkills(Ocultarse) / 4 + 15 * Buleano(ClaseBuena) + 25 * Buleano(ClaseBuena And Not UserList(Userindex).Clase = GUERRERO And UserList(Userindex).Invent.ArmourEqpObjIndex = 360)) <= 5 Then
    UserList(Userindex).flags.Oculto = 0
    UserList(Userindex).flags.Invisible = 0
    Call SendData(ToMap, 0, UserList(Userindex).POS.Map, ("V3" & DesteEncripTE("0," & UserList(Userindex).Char.CharIndex)))
    Call SendData(ToIndex, Userindex, 0, "V5")
End If

End Sub
Public Sub TimerStamina(Userindex As Integer)

If UserList(Userindex).Stats.MinSta < UserList(Userindex).Stats.MaxSta And UserList(Userindex).flags.Hambre = 0 And UserList(Userindex).flags.Sed = 0 And UserList(Userindex).flags.Desnudo = 0 Then
   If (Not UserList(Userindex).flags.Descansar And TiempoTranscurrido(UserList(Userindex).Counters.STACounter) >= StaminaIntervaloSinDescansar) Or _
   (UserList(Userindex).flags.Descansar And TiempoTranscurrido(UserList(Userindex).Counters.STACounter) >= StaminaIntervaloDescansar) Then
        UserList(Userindex).Counters.STACounter = Timer
        UserList(Userindex).Stats.MinSta = Minimo(UserList(Userindex).Stats.MinSta + CInt(RandomNumber(5, Porcentaje(UserList(Userindex).Stats.MaxSta, 15))), UserList(Userindex).Stats.MaxSta)
        Call SendUserSTA(Userindex)
        If TiempoTranscurrido(UserList(Userindex).Counters.CartelStamina) >= 10 Then
            UserList(Userindex).Counters.CartelStamina = Timer
            Call SendData(ToIndex, Userindex, 0, "MV")
        End If
        EnviarEstats = True
    End If
End If

If UserList(Userindex).Stats.MinSta < UserList(Userindex).Stats.MaxSta Then
If UserList(Userindex).Stats.MinSta = 0 Then Exit Sub
Call SendUserSTA(Userindex)
End If

End Sub
Sub TimerTransformado(Userindex As Integer)

If TiempoTranscurrido(UserList(Userindex).Counters.Transformado) >= IntervaloInvisible Then
    Call DoTransformar(Userindex)
End If

End Sub
Sub TimerInvisibilidad(Userindex As Integer)

If TiempoTranscurrido(UserList(Userindex).Counters.Invisibilidad) >= IntervaloInvisible Then
    Call SendData(ToIndex, Userindex, 0, "V6")
    Call QuitarInvisible(Userindex)
End If

End Sub
Sub TimerFlecha(Userindex As Integer)

If TiempoTranscurrido(UserList(Userindex).Counters.BonusFlecha) >= 45 Then
    UserList(Userindex).Counters.BonusFlecha = 0
    UserList(Userindex).flags.BonusFlecha = False
    Call SendData(ToIndex, Userindex, 0, "||Se acabó el efecto del Arco Encantado." & FONTTYPE_INFO)
End If

End Sub
Sub TimerPiquete(Userindex As Integer)

If MapData(UserList(Userindex).POS.Map, UserList(Userindex).POS.X, UserList(Userindex).POS.y).trigger = 5 Then
    UserList(Userindex).Counters.PiqueteC = UserList(Userindex).Counters.PiqueteC + 1
'    If UserList(Userindex).Counters.PiqueteC Mod 5 = 0 Then Call SendData(ToIndex, Userindex, 0, "9N")
       Call SendData(ToIndex, Userindex, 0, "9N")
    If UserList(Userindex).Counters.PiqueteC >= 25 Then
        UserList(Userindex).Counters.PiqueteC = 0
        Call Encarcelar(Userindex, 3)
    End If
Else: UserList(Userindex).Counters.PiqueteC = 0
End If

End Sub
Public Sub TimerProtEntro(Userindex As Integer)
On Error GoTo Error

UserList(Userindex).Counters.Protegido = UserList(Userindex).Counters.Protegido - 1
If UserList(Userindex).Counters.Protegido <= 0 Then UserList(Userindex).flags.Protegido = 0

Exit Sub

Error:
    Call LogError("Error en TimerProtEntro" & " " & Err.Description)
End Sub
Sub TimerParalisis(Userindex As Integer)

If TiempoTranscurrido(UserList(Userindex).Counters.Paralisis) >= IntervaloParalizadoUsuario Then
    UserList(Userindex).Counters.Paralisis = 0
    UserList(Userindex).flags.Paralizado = 0
    Call SendData(ToIndex, Userindex, 0, "P8")
End If

End Sub
Sub TimerCeguera(Userindex As Integer)

If TiempoTranscurrido(UserList(Userindex).Counters.Ceguera) >= IntervaloParalizadoUsuario / 2 Then
    UserList(Userindex).Counters.Ceguera = 0
    UserList(Userindex).flags.Ceguera = 0
    Call SendData(ToIndex, Userindex, 0, "NSEGUE")
End If

End Sub
Sub TimerEstupidez(Userindex As Integer)

If TiempoTranscurrido(UserList(Userindex).Counters.Estupidez) >= IntervaloParalizadoUsuario Then
    UserList(Userindex).Counters.Estupidez = 0
    UserList(Userindex).flags.Estupidez = 0
    Call SendData(ToIndex, Userindex, 0, "NESTUP")
End If

End Sub
Sub TimerCarcel(Userindex As Integer)

Dim j As Byte

If TiempoTranscurrido(UserList(Userindex).Counters.Pena) >= UserList(Userindex).Counters.TiempoPena Then
    UserList(Userindex).Counters.TiempoPena = 0
    UserList(Userindex).flags.Encarcelado = 0
    UserList(Userindex).Counters.Pena = 0
    If UserList(Userindex).POS.Map = Prision.Map Then
    Call CiudadNatal(Userindex)
    Call SendData(ToIndex, Userindex, 0, "4P")
    End If
End If

End Sub
Sub TimerVenenoDoble(Userindex As Integer)

If TiempoTranscurrido(UserList(Userindex).Counters.Veneno) >= 2 Then
    If TiempoTranscurrido(UserList(Userindex).flags.EstasEnvenenado) >= 8 Then
        UserList(Userindex).flags.Envenenado = 0
        UserList(Userindex).flags.EstasEnvenenado = 0
        UserList(Userindex).Counters.Veneno = 0
    Else
        Call SendData(ToIndex, Userindex, 0, "1M")
        UserList(Userindex).Counters.Veneno = Timer
        If Not UserList(Userindex).flags.Quest Then
            UserList(Userindex).Stats.MinHP = Maximo(0, UserList(Userindex).Stats.MinHP - 25)
            If UserList(Userindex).Stats.MinHP = 0 Then
                Call UserDie(Userindex)
            Else: EnviarEstats = True
            End If
        End If
    End If
End If

End Sub
Sub UserSacrificado(Userindex As Integer)
Dim MiObj As Obj

MiObj.OBJIndex = Gema
MiObj.Amount = UserList(Userindex).Stats.ELV ^ 2

Call MakeObj(ToMap, Userindex, UserList(Userindex).POS.Map, MiObj, UserList(Userindex).POS.Map, UserList(Userindex).POS.X, UserList(Userindex).POS.y)
Call UserDie(Userindex)

UserList(UserList(Userindex).flags.Sacrificador).flags.Sacrificado = 0
Call SendData(ToIndex, UserList(Userindex).flags.Sacrificador, 0, "||Sacrificaste a " & UserList(Userindex).Name & " por " & MiObj.Amount & " partes de la piedra filosofal." & FONTTYPE_INFO)
UserList(Userindex).flags.Ban = 1
Call CloseSocket(Userindex)

End Sub
Sub TimerSacrificando(Userindex As Integer)

UserList(Userindex).Stats.MinHP = UserList(Userindex).Stats.MinHP - 10
UserList(UserList(Userindex).flags.Sacrificador).Stats.MinMAN = Minimo(0, UserList(UserList(Userindex).flags.Sacrificador).Stats.MinMAN - 50)
Call SendUserMANA(UserList(Userindex).flags.Sacrificador)

If UserList(UserList(Userindex).flags.Sacrificador).Stats.MinMAN = 0 Then Call CancelarSacrificio(Userindex)
If UserList(Userindex).Stats.MinHP <= 0 Then Call UserSacrificado(Userindex)

EnviarEstats = True

End Sub
Sub TimerVeneno(Userindex As Integer)

If TiempoTranscurrido(UserList(Userindex).Counters.Veneno) >= IntervaloVeneno Then
    If TiempoTranscurrido(UserList(Userindex).flags.EstasEnvenenado) >= IntervaloVeneno * 10 Then
        UserList(Userindex).flags.Envenenado = 0
        UserList(Userindex).flags.EstasEnvenenado = 0
        UserList(Userindex).Counters.Veneno = 0
    Else
        Call SendData(ToIndex, Userindex, 0, "1M")
        UserList(Userindex).Counters.Veneno = Timer
        If Not UserList(Userindex).flags.Quest Then
            UserList(Userindex).Stats.MinHP = Maximo(0, UserList(Userindex).Stats.MinHP - RandomNumber(1, 5))
            If UserList(Userindex).Stats.MinHP = 0 Then
                Call UserDie(Userindex)
            Else: EnviarEstats = True
            End If
        End If
    End If
End If

End Sub
Public Sub TimerFrio(Userindex As Integer)

If UserList(Userindex).flags.Privilegios > 1 Then Exit Sub

If TiempoTranscurrido(UserList(Userindex).Counters.Frio) >= IntervaloFrio Then
    UserList(Userindex).Counters.Frio = Timer
    If MapInfo(UserList(Userindex).POS.Map).Terreno = Nieve Then
        If TiempoTranscurrido(UserList(Userindex).Counters.CartelFrio) >= 5 Then
            UserList(Userindex).Counters.CartelFrio = Timer
            Call SendData(ToIndex, Userindex, 0, "1K")
        End If
        If Not UserList(Userindex).flags.Quest Then
            UserList(Userindex).Stats.MinHP = Maximo(0, UserList(Userindex).Stats.MinHP - Porcentaje(UserList(Userindex).Stats.MaxHP, 5))
            EnviarEstats = True
            If UserList(Userindex).Stats.MinHP = 0 Then
                Call SendData(ToIndex, Userindex, 0, "1L")
                Call UserDie(Userindex)
            End If
        End If
    End If
    Call QuitarSta(Userindex, Porcentaje(UserList(Userindex).Stats.MaxSta, 5))
    If TiempoTranscurrido(UserList(Userindex).Counters.CartelFrio) >= 10 Then
        UserList(Userindex).Counters.CartelFrio = Timer
        Call SendData(ToIndex, Userindex, 0, "FR")
    End If
    EnviarEstats = True
End If

End Sub
Sub TimerPocion(Userindex As Integer)
If TiempoTranscurrido(UserList(Userindex).flags.DuracionEfecto) >= 60 Then
Call Parpa(Userindex)
If TiempoTranscurrido(UserList(Userindex).flags.DuracionEfecto) >= 75 Then
    UserList(Userindex).flags.DuracionEfecto = 0
    UserList(Userindex).flags.TomoPocion = False
    UserList(Userindex).Stats.UserAtributos(Agilidad) = UserList(Userindex).Stats.UserAtributosBackUP(Agilidad)
    UserList(Userindex).Stats.UserAtributos(fuerza) = UserList(Userindex).Stats.UserAtributosBackUP(fuerza)
    Call UpdateFuerzaYAg(Userindex)
End If
End If
End Sub
Public Sub TimerHyS(Userindex As Integer)
Dim EnviaInfo As Boolean

If UserList(Userindex).flags.Privilegios > 1 Or (UserList(Userindex).Clase = TALADOR And UserList(Userindex).Recompensas(1) = 2) Or UserList(Userindex).flags.Quest Then Exit Sub

If TiempoTranscurrido(UserList(Userindex).Counters.AGUACounter) >= IntervaloSed Then
    If UserList(Userindex).flags.Sed = 0 Then
        UserList(Userindex).Stats.MinAGU = UserList(Userindex).Stats.MinAGU - 10
        If UserList(Userindex).Stats.MinAGU <= 0 Then
            UserList(Userindex).Stats.MinAGU = 0
            UserList(Userindex).flags.Sed = 1
        End If
        EnviaInfo = True
    End If
    UserList(Userindex).Counters.AGUACounter = Timer
End If

If TiempoTranscurrido(UserList(Userindex).Counters.COMCounter) >= IntervaloHambre Then
    If UserList(Userindex).flags.Hambre = 0 Then
        UserList(Userindex).Counters.COMCounter = Timer
        UserList(Userindex).Stats.MinHam = UserList(Userindex).Stats.MinHam - 10
        If UserList(Userindex).Stats.MinHam <= 0 Then
            UserList(Userindex).Stats.MinHam = 0
            UserList(Userindex).flags.Hambre = 1
        End If
        EnviaInfo = True
    End If
    UserList(Userindex).Counters.COMCounter = Timer
End If

If EnviaInfo Then Call EnviarHambreYsed(Userindex)

End Sub
Sub TimerSanar(Userindex As Integer)

If (UserList(Userindex).flags.Descansar And TiempoTranscurrido(UserList(Userindex).Counters.HPCounter) >= SanaIntervaloDescansar) Or _
     (Not UserList(Userindex).flags.Descansar And TiempoTranscurrido(UserList(Userindex).Counters.HPCounter) >= SanaIntervaloSinDescansar) Then
    If (Not Lloviendo Or Not Intemperie(Userindex)) And UserList(Userindex).Stats.MinHP < UserList(Userindex).Stats.MaxHP And UserList(Userindex).flags.Hambre = 0 And UserList(Userindex).flags.Sed = 0 Then
        If UserList(Userindex).flags.Descansar Then
            UserList(Userindex).Stats.MinHP = Minimo(UserList(Userindex).Stats.MaxHP, UserList(Userindex).Stats.MinHP + Porcentaje(UserList(Userindex).Stats.MaxHP, 20))
            If UserList(Userindex).Stats.MaxHP = UserList(Userindex).Stats.MinHP And UserList(Userindex).Stats.MaxSta = UserList(Userindex).Stats.MinSta Then
                Call SendData(ToIndex, Userindex, 0, "DOK")
                Call SendData(ToIndex, Userindex, 0, "DN")
                UserList(Userindex).flags.Descansar = False
            End If
        Else
            UserList(Userindex).Stats.MinHP = Minimo(UserList(Userindex).Stats.MaxHP, UserList(Userindex).Stats.MinHP + Porcentaje(UserList(Userindex).Stats.MaxHP, 5))
        End If
        Call SendData(ToIndex, Userindex, 0, "1N")
        EnviarEstats = True
    End If
    UserList(Userindex).Counters.HPCounter = Timer
End If
    
End Sub
Sub TimerInvocacion(Userindex As Integer)
Dim i As Integer
Dim NpcIndex As Integer

If UserList(Userindex).flags.Privilegios > 0 Or UserList(Userindex).flags.Quest Then Exit Sub

For i = 1 To MAXMASCOTAS * Buleano(Not UserList(Userindex).flags.Quest)
    If UserList(Userindex).MascotasIndex(i) Then
        NpcIndex = UserList(Userindex).MascotasIndex(i)
        Npclist(NpcIndex).Contadores.TiempoExistencia = Npclist(NpcIndex).Contadores.TiempoExistencia - 1
        If Npclist(NpcIndex).Contadores.TiempoExistencia < 1 Then Call QuitarNPC(NpcIndex)
    End If
Next

End Sub
Public Sub TimerIdleCount(Userindex As Integer)

If UserList(Userindex).flags.Privilegios = 0 And UserList(Userindex).flags.Trabajando = 0 And TiempoTranscurrido(UserList(Userindex).Counters.IdleCount) >= IntervaloParaConexion And Not UserList(Userindex).Counters.Saliendo Then
    Call SendData(ToIndex, Userindex, 0, "!!Demasiado tiempo inactivo. Has sido desconectado..")
    Call SendData(ToIndex, Userindex, 0, "FINOK")
    Call CloseSocket(Userindex)
End If

End Sub
Sub TimerSalir(Userindex As Integer)

If TiempoTranscurrido(UserList(Userindex).Counters.Salir) >= IntervaloCerrarConexion Then
    Call SendData(ToIndex, Userindex, 0, "FINOK")
    Call CloseSocket(Userindex)
End If

End Sub

Private Sub Winsock1_Error(ByVal Number As Integer, Description As String, ByVal Scode As Long, ByVal Source As String, ByVal HelpFile As String, ByVal HelpContext As Long, CancelDisplay As Boolean)

End Sub

Sub TimerRetPj2(Userindex As Integer)
If TiempoTranscurrido(UserList(Userindex).Counters.ApostandoPj) >= 20 Then
If UserList(Userindex).flags.Apostandoa > 0 Then
Call SendData(ToIndex, Userindex, 0, "||Tiempo agotado. Cancelado" & FONTTYPE_BLANCO)
UserList(Userindex).flags.Apostandoa = 0
End If

If UserList(Userindex).flags.ApostandoPOR > 0 Then
UserList(Userindex).flags.ApostandoPOR = 0
Call SendData(ToIndex, UserList(Userindex).flags.ApostandoPOR, 0, "||Tiempo agotado. Cancelado" & FONTTYPE_BLANCO)
End If

UserList(Userindex).Counters.ApostandoPj = 0


End If
End Sub

Sub TimerComercio(Userindex As Integer)
If TiempoTranscurrido(UserList(Userindex).Counters.ApostandoPj) >= 15 Then
If UserList(Userindex).flags.Apostandoa > 0 Then
Call SendData(ToIndex, Userindex, 0, "||Tiempo agotado. Cancelado" & FONTTYPE_BLANCO)
UserList(Userindex).flags.Apostandoa = 0
End If

If UserList(Userindex).flags.ApostandoPOR > 0 Then
UserList(Userindex).flags.ApostandoPOR = 0
Call SendData(ToIndex, UserList(Userindex).flags.ApostandoPOR, 0, "||Tiempo agotado. Cancelado" & FONTTYPE_BLANCO)
End If

UserList(Userindex).Counters.ApostandoPj = 0


End If
End Sub
