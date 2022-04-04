VERSION 5.00
Begin VB.Form FrmOpciones 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Configuración del juego"
   ClientHeight    =   4320
   ClientLeft      =   45
   ClientTop       =   375
   ClientWidth     =   5805
   Icon            =   "frmOpciones.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4320
   ScaleWidth      =   5805
   StartUpPosition =   2  'CenterScreen
   Begin VB.CheckBox CheckNpc 
      Caption         =   "Nombres de Npcs"
      Enabled         =   0   'False
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   6120
      TabIndex        =   20
      Top             =   480
      Width           =   2055
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Restablecer configuraciones"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   3240
      TabIndex        =   19
      Top             =   2040
      Width           =   2415
   End
   Begin VB.Frame Frame3 
      Caption         =   "Otras configuraciones"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1575
      Left            =   3240
      TabIndex        =   16
      Top             =   240
      Width           =   2415
      Begin VB.CheckBox CursoresCheck 
         Caption         =   "CURSORES GRAFICOS"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   120
         TabIndex        =   21
         Top             =   960
         Width           =   2055
      End
      Begin VB.CheckBox CheckDRAG 
         Caption         =   "Drag and drop"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   120
         TabIndex        =   18
         Top             =   480
         Width           =   2055
      End
      Begin VB.CheckBox CheckSegRetos 
         Caption         =   "Seguro de reto por oro"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   120
         TabIndex        =   17
         Top             =   720
         Width           =   2055
      End
   End
   Begin VB.CommandButton Command4 
      Caption         =   "Guardar y Cerrar"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   3240
      TabIndex        =   15
      Top             =   3840
      Width           =   2415
   End
   Begin VB.Frame Frame2 
      Caption         =   "Configuración de sonido"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   1455
      Left            =   120
      TabIndex        =   7
      Top             =   2760
      Width           =   3015
      Begin VB.CheckBox CheckMusic 
         Caption         =   "Musica"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   495
         Left            =   1800
         TabIndex        =   11
         Top             =   240
         Width           =   855
      End
      Begin VB.PictureBox Picvol 
         BackColor       =   &H00404040&
         BorderStyle     =   0  'None
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   195
         Left            =   240
         ScaleHeight     =   195
         ScaleWidth      =   2520
         TabIndex        =   9
         ToolTipText     =   "Set volume"
         Top             =   1080
         Width           =   2520
         Begin VB.Label Lblvol 
            BackColor       =   &H00E0E0E0&
            Enabled         =   0   'False
            Height          =   225
            Left            =   825
            TabIndex        =   10
            Top             =   0
            Width           =   90
         End
      End
      Begin VB.CheckBox CheckFXS 
         Caption         =   "Efectos de sonido"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   120
         TabIndex        =   8
         Top             =   360
         Width           =   2055
      End
      Begin VB.Label Label19 
         Alignment       =   2  'Center
         BackColor       =   &H00000000&
         BackStyle       =   0  'Transparent
         Caption         =   "Volumen del juego"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   9
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00000000&
         Height          =   255
         Left            =   120
         TabIndex        =   14
         Top             =   840
         Width           =   2655
      End
      Begin VB.Label slider2 
         BackColor       =   &H00808080&
         Height          =   225
         Left            =   240
         TabIndex        =   13
         Top             =   1070
         Width           =   2520
      End
      Begin VB.Label slider1 
         BackColor       =   &H00FFFFFF&
         Height          =   225
         Left            =   240
         TabIndex        =   12
         ToolTipText     =   "Seek the file"
         Top             =   1080
         Visible         =   0   'False
         Width           =   2520
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Configuración de video"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   2295
      Left            =   120
      TabIndex        =   2
      Top             =   240
      Width           =   3015
      Begin VB.ComboBox Combo1 
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   330
         ItemData        =   "frmOpciones.frx":000C
         Left            =   360
         List            =   "frmOpciones.frx":001C
         TabIndex        =   23
         Text            =   "Limite de FPS"
         Top             =   1680
         Width           =   2055
      End
      Begin VB.CheckBox CheckDamage 
         Caption         =   "Daño renderizado"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Left            =   120
         TabIndex        =   22
         Top             =   480
         Width           =   2055
      End
      Begin VB.CheckBox CheckAuras 
         Caption         =   "Auras"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   210
         Left            =   120
         TabIndex        =   6
         Top             =   255
         Width           =   2055
      End
      Begin VB.CheckBox CheckHechiz 
         Caption         =   "Hechizos con particulas"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   120
         TabIndex        =   5
         Top             =   960
         Width           =   2055
      End
      Begin VB.CheckBox CheckMedit 
         Caption         =   "Meditaciones con particulas"
         BeginProperty Font 
            Name            =   "Arial"
            Size            =   8.25
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   255
         Left            =   120
         TabIndex        =   4
         Top             =   720
         Width           =   2415
      End
      Begin VB.CheckBox CheckSombras 
         Caption         =   "Sombras"
         BeginProperty Font 
            Name            =   "Arial"
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
         Width           =   1215
      End
   End
   Begin VB.CommandButton Command3 
      Caption         =   "Cambiar Skin "
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   3240
      TabIndex        =   1
      Top             =   3360
      Width           =   2415
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Configuracion de teclas"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   3240
      TabIndex        =   0
      Top             =   2520
      Width           =   2415
   End
End
Attribute VB_Name = "FrmOpciones"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Public MidiVOL As Boolean


Private Sub CheckFxs_Click()
If CheckFXS.value = 0 Then
    CheckFXS.value = 0
    FX = 1
Else
    CheckFXS.value = 1
    FX = 0
End If

End Sub



Private Sub CheckMusic_Click()
If CheckMusic.value = 1 Then
    Musica = 0
    Call WriteVar(App.Path & "/Init/Opciones.opc", "CONFIG", "Music", 0)
Else
    Musica = 1
    Call WriteVar(App.Path & "/Init/Opciones.opc", "CONFIG", "Music", 1)
    Call Audio.StopMidi
    Call Audio.MP3_Stop
End If
End Sub

Private Sub CheckAuras_Click()
If CheckAuras.value = 0 Then
    AurasAC = 1
    Call WriteVar(App.Path & "/Init/Opciones.opc", "CONFIG", "Auras", 1)
Else
    AurasAC = 0
    Call WriteVar(App.Path & "/Init/Opciones.opc", "CONFIG", "Auras", 0)
End If
End Sub

Private Sub CheckDRAG_Click()
If CheckDRAG.value = 1 Then
Call WriteVar(App.Path & "/Init/Opciones.opc", "CONFIG", "DragAndDrop", 0)
DragAndDropAC = 0
Else
Call WriteVar(App.Path & "/Init/Opciones.opc", "CONFIG", "DragAndDrop", 1)
DragAndDropAC = 1
End If
End Sub



Private Sub CheckHechiz_Click()
If CheckHechiz.value = 0 Then
   HechizAc = 1
   Call WriteVar(App.Path & "/Init/Opciones.opc", "CONFIG", "Hechiz", 1)
Else
    HechizAc = 0
    Call WriteVar(App.Path & "/Init/Opciones.opc", "CONFIG", "Hechiz", 0)
End If
End Sub

Private Sub CheckMedit_Click()
If CheckMedit.value = 0 Then
   MeditacionesAZ = 1
   Call WriteVar(App.Path & "/Init/Opciones.opc", "CONFIG", "Medit", 1)
Else
    MeditacionesAZ = 0
    Call WriteVar(App.Path & "/Init/Opciones.opc", "CONFIG", "Medit", 0)
End If
End Sub



Private Sub CheckNpc_Click()
If CheckNpc.value = 1 Then
Call WriteVar(App.Path & "/Init/Opciones.opc", "CONFIG", "NombresNPC", 0)
activarnombresNpcs = 0
Else
Call WriteVar(App.Path & "/Init/Opciones.opc", "CONFIG", "NombresNPC", 1)
activarnombresNpcs = 1
End If
End Sub



Private Sub CheckDamage_Click()
If CheckDamage.value = 0 Then
   CreateDamageAC = 1
   Call WriteVar(App.Path & "/Init/Opciones.opc", "CONFIG", "CreateDamage", 1)
Else
   CreateDamageAC = 0
   Call WriteVar(App.Path & "/Init/Opciones.opc", "CONFIG", "CreateDamage", 0)
End If
End Sub

Private Sub CheckSegRetos_Click()
If CheckSegRetos.value = 0 Then
   RetosAC = 1
   Call WriteVar(App.Path & "/Init/Opciones.opc", "CONFIG", "RetosAC", 1)
Else
   RetosAC = 0
   Call WriteVar(App.Path & "/Init/Opciones.opc", "CONFIG", "RetosAC", 0)
End If
End Sub

Private Sub CheckSombras_Click()
If CheckSombras.value = 0 Then
   SombrasAC = 1
   Call WriteVar(App.Path & "/Init/Opciones.opc", "CONFIG", "Sombras", 1)
Else
   SombrasAC = 0
   Call WriteVar(App.Path & "/Init/Opciones.opc", "CONFIG", "Sombras", 0)
End If
End Sub

Private Sub Combo1_Click()
If Combo1.Text = "FPS 17" Then
   NoFps = 0
   Call WriteVar(App.Path & "/Init/Opciones.opc", "CONFIG", "FPSLIBRE", 0)
   ActivadoFps = 1
   FPslocos = 60
ElseIf Combo1.Text = "FPS 62" Then
   NoFps = 2
   Call WriteVar(App.Path & "/Init/Opciones.opc", "CONFIG", "FPSLIBRE", 2)
   ActivadoFps = 0
   FPslocos = 18
ElseIf Combo1.Text = "FPS 110" Then
   NoFps = 1
   Call WriteVar(App.Path & "/Init/Opciones.opc", "CONFIG", "FPSLIBRE", 1)
   ActivadoFps = 0
   FPslocos = 10
ElseIf Combo1.Text = "FPS LIBRES" Then
   NoFps = 3
   Call WriteVar(App.Path & "/Init/Opciones.opc", "CONFIG", "FPSLIBRE", 3)
   ActivadoFps = 0
   FPslocos = 1
End If
End Sub


Private Sub command1_Click()
Unload Me
    Call frmCustomKeys.Show(vbModeless, frmPrincipal)
End Sub

Private Sub Command2_Click()
CheckSegRetos.value = 0
CheckDamage.value = 1
CheckDRAG.value = 0
CheckAuras.value = 1
CheckHechiz.value = 0
CheckMedit.value = 1
CheckSombras.value = 0
CheckMusic.value = 1
CheckFXS.value = 1
CheckNpc.value = 0
CursoresCheck.value = 1

frmPrincipal.Picture = LoadPicture("Graficos\Principal0.jpg")
frmPrincipal.imgFondoInvent.Picture = LoadPicture("Graficos\Centronuevoinventario0.jpg")
frmPrincipal.imgFondoHechizos.Picture = LoadPicture("Graficos\Centronuevohechizos0.jpg")
Call WriteVar(App.Path & "/Init/Opciones.opc", "CONFIG", "SkinGrafico", 0)
SkinGrafico = 1


CreateDamageAC = 0
Call WriteVar(App.Path & "/Init/Opciones.opc", "CONFIG", "CreateDamage", 0)

SombrasAC = 1
Call WriteVar(App.Path & "/Init/Opciones.opc", "CONFIG", "Sombras", 1)

RetosAC = 1
Call WriteVar(App.Path & "/Init/Opciones.opc", "CONFIG", "RetosAC", 1)

activarnombresNpcs = 1
Call WriteVar(App.Path & "/Init/Opciones.opc", "CONFIG", "NombresNPC", 1)


MeditacionesAZ = 0
Call WriteVar(App.Path & "/Init/Opciones.opc", "CONFIG", "Medit", 0)

HechizAc = 1
Call WriteVar(App.Path & "/Init/Opciones.opc", "CONFIG", "Hechiz", 1)

DragAndDropAC = 1
Call WriteVar(App.Path & "/Init/Opciones.opc", "CONFIG", "DragAndDrop", 1)

AurasAC = 0
Call WriteVar(App.Path & "/Init/Opciones.opc", "CONFIG", "Auras", 0)


NoFps = 1
Call WriteVar(App.Path & "/Init/Opciones.opc", "CONFIG", "FPSLIBRE", 1)
ActivadoFps = 0
FPslocos = 10

CheckFXS.value = 1
FX = 0
End Sub

Private Sub Command3_Click()

If FileExist("Graficos\Principal1.jpg", vbNormal) = True Then
If SkinGrafico = 0 Then
frmPrincipal.Picture = LoadPicture("Graficos\Principal0.jpg")
frmPrincipal.imgFondoInvent.Picture = LoadPicture("Graficos\Centronuevoinventario0.jpg")
frmPrincipal.imgFondoHechizos.Picture = LoadPicture("Graficos\Centronuevohechizos0.jpg")
Call WriteVar(App.Path & "/Init/Opciones.opc", "CONFIG", "SkinGrafico", 0)
SkinGrafico = 1
ElseIf SkinGrafico = 1 Then
frmPrincipal.Picture = LoadPicture("Graficos\Principal1.jpg")
frmPrincipal.imgFondoInvent.Picture = LoadPicture("Graficos\Centronuevoinventario1.jpg")
frmPrincipal.imgFondoHechizos.Picture = LoadPicture("Graficos\Centronuevohechizos1.jpg")
Call WriteVar(App.Path & "/Init/Opciones.opc", "CONFIG", "SkinGrafico", 1)
SkinGrafico = 2
ElseIf SkinGrafico = 2 Then
frmPrincipal.Picture = LoadPicture("Graficos\Principal3.jpg")
frmPrincipal.imgFondoInvent.Picture = LoadPicture("Graficos\Centronuevoinventario3.jpg")
frmPrincipal.imgFondoHechizos.Picture = LoadPicture("Graficos\Centronuevohechizos3.jpg")
Call WriteVar(App.Path & "/Init/Opciones.opc", "CONFIG", "SkinGrafico", 2)
SkinGrafico = 3
ElseIf SkinGrafico = 3 Then
frmPrincipal.Picture = LoadPicture("Graficos\Principal2.jpg")
frmPrincipal.imgFondoInvent.Picture = LoadPicture("Graficos\Centronuevoinventario2.jpg")
frmPrincipal.imgFondoHechizos.Picture = LoadPicture("Graficos\Centronuevohechizos2.jpg")
Call WriteVar(App.Path & "/Init/Opciones.opc", "CONFIG", "SkinGrafico", 3)
SkinGrafico = 0
End If
Else
MsgBox "No hay ningún Skin disponible."
End If
End Sub




Private Sub Command4_Click()
Unload Me
End Sub

Private Sub CursoresCheck_Click()
If CursoresCheck.value = 1 Then
    Dim CursorDir As String
    Dim Cursor As Long
  
    CursorDir = App.Path & "\INIT\MAIN.cur"
    hSwapCursor = SetClassLong(frmPrincipal.hwnd, GLC_HCURSOR, LoadCursorFromFile(CursorDir))
    hSwapCursor = SetClassLong(frmPrincipal.renderer.hwnd, GLC_HCURSOR, LoadCursorFromFile(CursorDir))
    hSwapCursor = SetClassLong(frmPrincipal.lstHechizos.hwnd, GLC_HCURSOR, LoadCursorFromFile(CursorDir))
    hSwapCursor = SetClassLong(frmPrincipal.frInvent.hwnd, GLC_HCURSOR, LoadCursorFromFile(CursorDir))
    hSwapCursor = SetClassLong(frmPrincipal.frHechizos.hwnd, GLC_HCURSOR, LoadCursorFromFile(CursorDir))
    
    Call WriteVar(App.Path & "/Init/Opciones.opc", "CONFIG", "Cursores", 0)
    CursorGrafico = 0
Else

    CursorDir = App.Path & "\INIT\DEFAULT.cur"
    hSwapCursor = SetClassLong(frmPrincipal.hwnd, GLC_HCURSOR, LoadCursorFromFile(CursorDir))
    hSwapCursor = SetClassLong(frmPrincipal.renderer.hwnd, GLC_HCURSOR, LoadCursorFromFile(CursorDir))
    hSwapCursor = SetClassLong(frmPrincipal.lstHechizos.hwnd, GLC_HCURSOR, LoadCursorFromFile(CursorDir))
    hSwapCursor = SetClassLong(frmPrincipal.frInvent.hwnd, GLC_HCURSOR, LoadCursorFromFile(CursorDir))
    hSwapCursor = SetClassLong(frmPrincipal.frHechizos.hwnd, GLC_HCURSOR, LoadCursorFromFile(CursorDir))
    MsgBox "Si tienes un Cursor personalizado hara efecto la proxima ves que reinicies el juego."
    
   Call WriteVar(App.Path & "/Init/Opciones.opc", "CONFIG", "Cursores", 1)
   CursorGrafico = 1
End If
End Sub

Private Sub Form_Load()

'Me.PICTURE = LoadPicture(DirGraficos & "OpcionesDelJuego.gif")


If Val(GetVar(App.Path & "/Init/Opciones.opc", "CONFIG", "FPSLIBRE")) = 0 Then
Combo1.Text = "FPS 17"
ElseIf Val(GetVar(App.Path & "/Init/Opciones.opc", "CONFIG", "FPSLIBRE")) = 2 Then
Combo1.Text = "FPS 62"
ElseIf Val(GetVar(App.Path & "/Init/Opciones.opc", "CONFIG", "FPSLIBRE")) = 1 Then
Combo1.Text = "FPS 110"
ElseIf Val(GetVar(App.Path & "/Init/Opciones.opc", "CONFIG", "FPSLIBRE")) = 3 Then
Combo1.Text = "FPS LIBRES"
End If

If CreateDamageAC = 0 Then
CheckDamage.value = 1
Else
CheckDamage.value = 0
End If

If activarnombresNpcs = 0 Then
CheckNpc.value = 1
Else
CheckNpc.value = 0
End If


If DragAndDropAC = 0 Then
CheckDRAG.value = 1
Else
CheckDRAG.value = 0
End If

If AurasAC = 0 Then
CheckAuras.value = 1
Else
CheckAuras.value = 0
End If


If HechizAc = 0 Then
CheckHechiz.value = 1
Else
CheckHechiz.value = 0
End If

If MeditacionesAZ = 0 Then
CheckMedit.value = 1
Else
CheckMedit.value = 0
End If


If SombrasAC = 0 Then
CheckSombras.value = 1
Else
CheckSombras.value = 0
End If

If RetosAC = 0 Then
CheckSegRetos.value = 1
Else
CheckSegRetos.value = 0
End If

If Musica = 0 Then
    CheckMusic.value = 1
Else
    CheckMusic.value = 0
End If

If CursorGrafico = 0 Then
CursoresCheck.value = 1
Else
CursoresCheck.value = 0
End If

If FX = 0 Then
    CheckFXS.value = 1
Else
    CheckFXS.value = 0
End If



End Sub


Private Sub HScroll1_Change()
Volumen = HScroll1.value
End Sub

Private Sub Image1_Click()

Me.Visible = False

End Sub








Private Sub Image5_Click()
ShellExecute Me.hwnd, "open", "http://nabrianao.com/foro", "", "", 1
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





Private Sub Picvol_KeyDown(KeyCode As Integer, Shift As Integer)
    Form_KeyDown KeyCode, Shift
End Sub
Private Sub Picvol_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)
    If X < 0 Then X = 0
    If X > Picvol.Width Then X = Picvol.Width - 8
    If Button = 1 Then
        SetVol Percent(100, X / (slider1.Width / 100)), MidiVOL
        Lblvol.Left = Percent(Picvol.Width, GetVol(MidiVOL)) - (Lblvol.Width \ 2)
    End If
End Sub
Private Sub Picvol_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)
    Picvol_MouseDown Button, Shift, X, Y
End Sub
Private Sub VolUp()
    If GetVol(MidiVOL) < 100 Then SetVol GetVol(MidiVOL) + 1, MidiVOL
    Lblvol.Left = Percent(Picvol.Width, GetVol(MidiVOL)) - (Lblvol.Width \ 2)
End Sub
Private Sub VolDown()
    If GetVol(MidiVOL) > 0 Then SetVol GetVol(MidiVOL) - 1, MidiVOL
    Lblvol.Left = Percent(Picvol.Width, GetVol(MidiVOL)) - (Lblvol.Width \ 2)
End Sub
Private Sub ShowVol()
    Lblvol.Left = Percent(Picvol.Width, GetVol(MidiVOL)) - (Lblvol.Width \ 2)
End Sub
Private Sub VOL_KeyDown(KeyCode As Integer, Shift As Integer)
    Form_KeyDown KeyCode, Shift
End Sub
Private Sub Form_KeyDown(KeyCode As Integer, Shift As Integer)

    If KeyCode = 38 Then: VolUp: ShowVol
    If KeyCode = 40 Then: VolDown: ShowVol
    DoEvents
    'Debug.Print KeyCode
End Sub


Sub DibujarGrhPorMapa(Rdata As String)
Dim X As Integer
Dim Y As Integer
Dim LoopC As Integer
Dim datatotal As String

      For LoopC = 2 To ReadFieldOptimizado(1, Rdata, Asc("@")) + 1
      datatotal = ReadFieldOptimizado(LoopC, Rdata, Asc("@"))
    
      X = ReadFieldOptimizado(2, datatotal, 44)
      Y = ReadFieldOptimizado(3, datatotal, 44)
      
      MapData(X, Y).ObjGrh.GrhIndex = ReadFieldOptimizado(1, datatotal, 44)
      
      InitGrh MapData(X, Y).ObjGrh, MapData(X, Y).ObjGrh.GrhIndex
      Next LoopC
      
      LastPos.X = X
      LastPos.Y = Y
End Sub

Sub BloquearTodoBQ(Rdata As String)
Dim LoopC As Integer
Dim datatotal As String

      For LoopC = 2 To ReadFieldOptimizado(1, Rdata, Asc("@")) + 1
      datatotal = ReadFieldOptimizado(LoopC, Rdata, Asc("@"))
      MapData(Val(ReadFieldOptimizado(1, datatotal, 44)), Val(ReadFieldOptimizado(2, datatotal, 44))).Blocked = Val(ReadFieldOptimizado(3, datatotal, 44))
      MapData(Val(ReadFieldOptimizado(1, datatotal, 44)) - 1, Val(ReadFieldOptimizado(2, datatotal, 44))).Blocked = Val(ReadFieldOptimizado(3, datatotal, 44))
      Next LoopC
      
End Sub

Sub CargarListHechizosLogin(Rdata As String)

Dim datatotal As String

           Dim LoopC As Integer '"SHX"
           For LoopC = 1 To MAXHECHI
                UserHechizos(LoopC) = 0
                If LoopC > frmPrincipal.lstHechizos.ListCount Then
                    frmPrincipal.lstHechizos.AddItem "Nada"
                Else
                    frmPrincipal.lstHechizos.List(LoopC - 1) = "Nada"
                End If
            Next LoopC

            For LoopC = 2 To ReadFieldOptimizado(1, Rdata, Asc("@")) + 1
            datatotal = ReadFieldOptimizado(LoopC, Rdata, Asc("@"))
            Slot = ReadFieldOptimizado(1, datatotal, 44)
            UserHechizos(Slot) = ReadFieldOptimizado(2, datatotal, 44)
            If Slot > frmPrincipal.lstHechizos.ListCount Then
                frmPrincipal.lstHechizos.AddItem ReadFieldOptimizado(3, datatotal, 44)
            Else
                frmPrincipal.lstHechizos.List(Slot - 1) = ReadFieldOptimizado(3, datatotal, 44)
            End If
            Next LoopC
            
End Sub

Sub ObjetosInventarioArray(Rdata As String)
Dim datatotal As String

           Dim LoopC As Integer
           For LoopC = 1 To 25
           datatotal = ReadFieldOptimizado(LoopC, Rdata, Asc("@"))

            Slot = ReadFieldOptimizado(1, datatotal, 44)
            UserInventory(Slot).name = ReadFieldOptimizado(2, datatotal, 44)
            UserInventory(Slot).Amount = ReadFieldOptimizado(3, datatotal, 44)
            UserInventory(Slot).Equipped = ReadFieldOptimizado(4, datatotal, 44)
            UserInventory(Slot).GrhIndex = Val(ReadFieldOptimizado(5, datatotal, 44))
            UserInventory(Slot).ObjType = Val(ReadFieldOptimizado(6, datatotal, 44))
            UserInventory(Slot).Valor = Val(ReadFieldOptimizado(7, datatotal, 44))
            UserInventory(Slot).MinLvl = Val(ReadFieldOptimizado(8, datatotal, 44))
            Select Case UserInventory(Slot).ObjType
                Case 2
                    UserInventory(Slot).MaxHit = Val(ReadFieldOptimizado(9, datatotal, 44))
                    UserInventory(Slot).MinHit = Val(ReadFieldOptimizado(10, datatotal, 44))
                Case 3
                    UserInventory(Slot).SubTipo = Val(ReadFieldOptimizado(9, datatotal, 44))
                    UserInventory(Slot).MaxDef = Val(ReadFieldOptimizado(10, datatotal, 44))
                    UserInventory(Slot).MinDef = Val(ReadFieldOptimizado(11, datatotal, 44))
                Case 11
                    UserInventory(Slot).TipoPocion = Val(ReadFieldOptimizado(8, datatotal, 44))
                    UserInventory(Slot).MaxModificador = Val(ReadFieldOptimizado(9, datatotal, 44))
                    UserInventory(Slot).MinModificador = Val(ReadFieldOptimizado(10, datatotal, 44))
            End Select

            If UserInventory(Slot).Equipped = 1 Then
                If UserInventory(Slot).ObjType = 2 Then
                    frmPrincipal.arma.Caption = UserInventory(Slot).MinHit & "/" & UserInventory(Slot).MaxHit
                ElseIf UserInventory(Slot).ObjType = 3 Then
                    Select Case UserInventory(Slot).SubTipo
                        Case 0
                            If UserInventory(Slot).MaxDef > 0 Then
                                frmPrincipal.armadura.Caption = UserInventory(Slot).MinDef & "/" & UserInventory(Slot).MaxDef
                            Else
                                frmPrincipal.armadura.Caption = "N/A"
                            End If
                            
                        Case 1
                            If UserInventory(Slot).MaxDef > 0 Then
                                frmPrincipal.casco.Caption = UserInventory(Slot).MinDef & "/" & UserInventory(Slot).MaxDef
                            Else
                                frmPrincipal.casco.Caption = "N/A"
                            End If
                            
                        Case 2
                            If UserInventory(Slot).MaxDef > 0 Then
                                frmPrincipal.escudo.Caption = UserInventory(Slot).MinDef & "/" & UserInventory(Slot).MaxDef
                            Else
                                frmPrincipal.escudo.Caption = "N/A"
                            End If
                        
                    End Select
                End If
            End If
        
            tempstr = ""
            If UserInventory(Slot).Equipped = 1 Then
                tempstr = tempstr & "(Eqp)"
            End If
            
            If UserInventory(Slot).Amount > 0 Then
                tempstr = tempstr & "(" & UserInventory(Slot).Amount & ") " & UserInventory(Slot).name
            Else
                tempstr = tempstr & UserInventory(Slot).name
            End If
            
            ActualizarInventario (Slot)
            

          
            Next LoopC
            
End Sub

Sub CargarPersonajesWARP(Rdata As String)
Dim datatotal As String

            For LoopC = 2 To ReadFieldDarkFly2(1, Rdata, Asc("@")) + 1
            datatotal = ReadFieldDarkFly2(LoopC, Rdata, Asc("@"))
            CharIndex = ReadFieldDarkFly2(4, datatotal, 44)
            X = ReadFieldDarkFly2(5, datatotal, 44)
            Y = ReadFieldDarkFly2(6, datatotal, 44)
            CharList(CharIndex).FX = Val(ReadFieldDarkFly2(9, datatotal, 44))
            CharList(CharIndex).FxLoopTimes = Val(ReadFieldDarkFly2(10, datatotal, 44))
            CharList(CharIndex).Nombre = ReadFieldDarkFly2(11, datatotal, 44)
            CharList(CharIndex).NombreNPC = ReadFieldDarkFly2(7, datatotal, 44)
            If Right$(CharList(CharIndex).Nombre, 2) = "<>" Then
                CharList(CharIndex).Nombre = Left$(CharList(CharIndex).Nombre, Len(CharList(CharIndex).Nombre) - 2)
            End If
            
            'meditaciones
            If MeditacionesAZ = 0 Then
            If CharList(CharIndex).FX = 4 Or CharList(CharIndex).FX = 5 Or CharList(CharIndex).FX = 6 Or CharList(CharIndex).FX = 25 Then
                 CharList(CharIndex).FX = 0
                 End If
            End If
            
            CharList(CharIndex).Criminal = Val(ReadFieldDarkFly2(13, datatotal, 44))
            CharList(CharIndex).Privilegios = Val(ReadFieldDarkFly2(16, datatotal, 44))
            
            CharList(CharIndex).invisible = (Val(ReadFieldDarkFly2(15, datatotal, 44)) = 1)
            Call MakeChar(CharIndex, ReadFieldDarkFly2(1, datatotal, 44), ReadFieldDarkFly2(2, datatotal, 44), ReadFieldDarkFly2(3, datatotal, 44), X, Y, Val(ReadFieldDarkFly2(7, datatotal, 44)), Val(ReadFieldDarkFly2(8, datatotal, 44)), Val(ReadFieldDarkFly2(12, datatotal, 44)))
            CharList(CharIndex).aura_Index = Val(ReadFieldDarkFly2(14, datatotal, 44))
            Call InitGrh(CharList(CharIndex).Aura, Val(ReadFieldDarkFly2(14, datatotal, 44)))
            Next LoopC
            
End Sub
       
Sub RecibedatosMap(Rdata As String)
Dim datatotal As String
        frmMapa.ListNpcs.Clear
        frmMapa.LblMAP.Caption = ReadFieldOptimizado(1, Rdata, Asc("@"))
        
         For LoopC = 2 To 20 'Max 20 Npcs
            frmMapa.ListNpcs.AddItem ReadFieldOptimizado(LoopC, Rdata, Asc("@"))
        Next LoopC
        
End Sub
