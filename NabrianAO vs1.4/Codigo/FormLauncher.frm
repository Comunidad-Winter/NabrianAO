VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.ocx"
Begin VB.Form FormLauncher 
   AutoRedraw      =   -1  'True
   BackColor       =   &H00FFFFFF&
   BorderStyle     =   0  'None
   ClientHeight    =   8010
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   6105
   BeginProperty Font 
      Name            =   "MS Sans Serif"
      Size            =   12
      Charset         =   0
      Weight          =   700
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "FormLauncher.frx":0000
   LinkTopic       =   "Form2"
   MouseIcon       =   "FormLauncher.frx":000C
   Picture         =   "FormLauncher.frx":0CD6
   ScaleHeight     =   8010
   ScaleWidth      =   6105
   StartUpPosition =   2  'CenterScreen
   Begin VB.ComboBox Combo1 
      BackColor       =   &H00000000&
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00E0E0E0&
      Height          =   330
      ItemData        =   "FormLauncher.frx":39F59
      Left            =   600
      List            =   "FormLauncher.frx":39F69
      TabIndex        =   6
      Text            =   "Limite de FPS"
      Top             =   1920
      Width           =   1935
   End
   Begin VB.PictureBox Picture1 
      Height          =   15
      Left            =   5400
      ScaleHeight     =   15
      ScaleWidth      =   135
      TabIndex        =   5
      Top             =   6840
      Width           =   135
   End
   Begin VB.Timer TimerACC 
      Interval        =   500
      Left            =   360
      Top             =   1320
   End
   Begin RichTextLib.RichTextBox Imptxt 
      Height          =   2745
      Left            =   600
      TabIndex        =   4
      TabStop         =   0   'False
      Top             =   2280
      Width           =   5025
      _ExtentX        =   8864
      _ExtentY        =   4842
      _Version        =   393217
      BackColor       =   0
      BorderStyle     =   0
      ReadOnly        =   -1  'True
      ScrollBars      =   2
      DisableNoScroll =   -1  'True
      Appearance      =   0
      AutoVerbMenu    =   -1  'True
      TextRTF         =   $"FormLauncher.frx":39F92
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.Image Image6 
      Height          =   375
      Left            =   3240
      MouseIcon       =   "FormLauncher.frx":3A053
      Top             =   6720
      Width           =   2265
   End
   Begin VB.Image Image5 
      Height          =   375
      Left            =   2880
      MouseIcon       =   "FormLauncher.frx":3AD1D
      Top             =   1320
      Width           =   2535
   End
   Begin VB.Label Label3 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "Argentina"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   255
      Left            =   3240
      TabIndex        =   3
      Top             =   840
      Width           =   1695
   End
   Begin VB.Label Label2 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "(Descargar parches Manualmente)"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00E0E0E0&
      Height          =   255
      Left            =   480
      TabIndex        =   2
      Top             =   5590
      Width           =   5175
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "SERVIDOR: Espere unos segundos para comprobar"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H008080FF&
      Height          =   255
      Left            =   480
      TabIndex        =   1
      Top             =   5400
      Width           =   5175
   End
   Begin VB.Image Image2 
      Height          =   315
      Left            =   5400
      MouseIcon       =   "FormLauncher.frx":3B9E7
      Top             =   240
      Width           =   345
   End
   Begin VB.Image Image4 
      Height          =   495
      Left            =   720
      MouseIcon       =   "FormLauncher.frx":3C6B1
      Top             =   6000
      Width           =   2265
   End
   Begin VB.Image foro 
      Height          =   510
      Left            =   3240
      MouseIcon       =   "FormLauncher.frx":3D37B
      Top             =   6000
      Width           =   2265
   End
   Begin VB.Image Errores 
      Height          =   375
      Left            =   720
      MouseIcon       =   "FormLauncher.frx":3E045
      Top             =   6720
      Width           =   2265
   End
   Begin VB.Label LabelVersion 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "V 1.0.0"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   255
      Left            =   240
      TabIndex        =   0
      Top             =   1680
      Width           =   2415
   End
   Begin VB.Image Image3 
      Height          =   375
      Left            =   1680
      MouseIcon       =   "FormLauncher.frx":3ED0F
      Top             =   7320
      Width           =   2625
   End
   Begin VB.Image Image1 
      Height          =   375
      Left            =   1680
      MouseIcon       =   "FormLauncher.frx":3F9D9
      Top             =   7320
      Visible         =   0   'False
      Width           =   2625
   End
End
Attribute VB_Name = "FormLauncher"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Combo1_Click()
If Combo1.Text = "FPS 17" Then
   Call WriteVar(App.Path & "/Init/Opciones.opc", "CONFIG", "FPSLIBRE", 0)
ElseIf Combo1.Text = "FPS 62" Then
   Call WriteVar(App.Path & "/Init/Opciones.opc", "CONFIG", "FPSLIBRE", 2)
ElseIf Combo1.Text = "FPS 110" Then
   Call WriteVar(App.Path & "/Init/Opciones.opc", "CONFIG", "FPSLIBRE", 1)
ElseIf Combo1.Text = "FPS LIBRES" Then
   Call WriteVar(App.Path & "/Init/Opciones.opc", "CONFIG", "FPSLIBRE", 3)
End If
End Sub


Private Sub Errores_Click()
Shell "ErroresFIX.exe"
End Sub

Private Sub foro_Click()
ShellExecute Me.hwnd, "open", "http://nabrianao.com/foro", "", "", 1
End Sub

Private Sub Image1_Click()
On Error Resume Next
Call MainShell

End Sub

Private Sub Form_Load()
On Error Resume Next
Me.Picture = LoadPicture(App.Path & "\graficos\Launcher.jpg")
VersionDelJuego = "v" & App.Major & "." & App.Minor & "." & App.Revision
LabelVersion = VersionDelJuego
'Call RunAsAdmin
SeguridadActiva = False
EncriptGraficosActiva = False

NoGuia = Val(GetVar(App.Path & "/Init/Opciones.opc", "CONFIG", "GuiaJuego"))


Call GetSerialNumber2

Call SetWindowLong(Imptxt.hwnd, GWL_EXSTYLE, WS_EX_TRANSPARENT) 'consola transparente
Imptxt.LoadFile "imp.txt", rtfText


If Val(GetVar(App.Path & "/Init/Opciones.opc", "CONFIG", "FPSLIBRE")) = 0 Then
Combo1.Text = "FPS 17"
ElseIf Val(GetVar(App.Path & "/Init/Opciones.opc", "CONFIG", "FPSLIBRE")) = 2 Then
Combo1.Text = "FPS 62"
ElseIf Val(GetVar(App.Path & "/Init/Opciones.opc", "CONFIG", "FPSLIBRE")) = 1 Then
Combo1.Text = "FPS 110"
ElseIf Val(GetVar(App.Path & "/Init/Opciones.opc", "CONFIG", "FPSLIBRE")) = 3 Then
Combo1.Text = "FPS LIBRES"
End If

If SeguridadActiva = True Then
If AoDefDebugger Then
Call AoDefAntiDebugger
End
End If

AoDefAntiShInitialize
AoDefOriginalClientName = "NabrianAO"
AoDefClientName = App.EXEName

'If AoDefChangeName Then
'Call AoDefClientOn
'End
'End If

If AoDefMultiClient Then
Call AoDefMultiClientOn
End
End If
End If

End Sub


Private Sub Image2_Click()
Unload Me
End
End Sub


Private Sub Form_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
   If bmoving = False And Button = vbLeftButton Then
      Dx3 = X
      dy = Y
      bmoving = True
   End If
End Sub
Private Sub Form_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
   If bmoving And ((X <> Dx3) Or (Y <> dy)) Then
      Move Left + (X - Dx3), Top + (Y - dy)
   End If
End Sub
Private Sub Form_MouseUp(Button As Integer, Shift As Integer, X As Single, Y As Single)
   If Button = vbLeftButton Then
      bmoving = False
   End If
End Sub



Private Sub Form_Unload(Cancel As Integer)
End
End Sub

Private Sub Image3_Click()
On Error Resume Next
If MsgBox("El servidor aún esta comprobando actualizaciones.. ¿Quieres jugar de todas formas?", vbYesNo) = vbYes Then
Call MainShell
Else
End If
End Sub

Private Sub Image4_Click()
Dim X
X = ShellExecute(Me.hwnd, "Open", "http://nabrianao.com/", &O0, &O0, SW_NORMAL)
End Sub

Private Sub Image5_Click()
MsgBox "No hay disponible ningún otro servidor en este momento."
End Sub

Private Sub Image6_Click()
Dim X
X = ShellExecute(Me.hwnd, "Open", "http://nabrianao.com/errores.php", &O0, &O0, SW_NORMAL)
End Sub

Private Sub Label2_Click()
Dim X
X = ShellExecute(Me.hwnd, "Open", "http://nabrianao.com/aup", &O0, &O0, SW_NORMAL)
End Sub

Private Sub TimerACC_Timer()
If TimerACC.Enabled = True Then
If NoGuia = 0 Then
Shell "ErroresFIX.exe"
MsgBox ("Es la primera ves que ejecutas el juego se registraran librerías para solucionar errores dentro del juego.")
End If

Call frmCargando.Analizar
TimerACC.Enabled = False
End If
End Sub
