VERSION 5.00
Begin VB.Form frmServidor 
   BackColor       =   &H00808000&
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Servidor"
   ClientHeight    =   4335
   ClientLeft      =   -15
   ClientTop       =   270
   ClientWidth     =   7440
   ControlBox      =   0   'False
   FillColor       =   &H000080FF&
   ForeColor       =   &H0000FF00&
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   4335
   ScaleWidth      =   7440
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton Command17 
      Caption         =   "Actualizar npcs.dat"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   3720
      TabIndex        =   14
      Top             =   2160
      Width           =   3015
   End
   Begin VB.CommandButton Command14 
      Caption         =   "Update MOTD"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   3720
      TabIndex        =   12
      Top             =   1800
      Width           =   3015
   End
   Begin VB.CommandButton Command19 
      Caption         =   "Unban All IPs"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   3720
      TabIndex        =   16
      Top             =   1440
      Width           =   3015
   End
   Begin VB.CommandButton Command5 
      Caption         =   "Cargar BackUp del mundo"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   240
      TabIndex        =   1
      Top             =   3600
      Width           =   6975
   End
   Begin VB.CommandButton Command18 
      Caption         =   "Guardar todos los personajes"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   240
      TabIndex        =   15
      Top             =   3360
      Width           =   6975
   End
   Begin VB.CommandButton Command15 
      Caption         =   "Unban All"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   3720
      TabIndex        =   11
      Top             =   1080
      Width           =   3015
   End
   Begin VB.CommandButton Command12 
      Caption         =   "Debug Npcs"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   3720
      TabIndex        =   10
      Top             =   720
      Width           =   3015
   End
   Begin VB.CommandButton Command11 
      Caption         =   "Stats de los slots"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   3720
      TabIndex        =   8
      Top             =   360
      Width           =   3015
   End
   Begin VB.CommandButton Command10 
      Caption         =   "Trafico"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   600
      TabIndex        =   7
      Top             =   2160
      Width           =   3135
   End
   Begin VB.CommandButton Command9 
      Caption         =   "Reload Lista Nombres Prohibidos"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   600
      TabIndex        =   6
      Top             =   1800
      Width           =   3135
   End
   Begin VB.CommandButton Command8 
      Caption         =   "Actualizar hechizos"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   600
      TabIndex        =   5
      Top             =   1440
      Width           =   3135
   End
   Begin VB.CommandButton Command7 
      Caption         =   "Configurar intervalos"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   600
      TabIndex        =   4
      Top             =   1080
      Width           =   3135
   End
   Begin VB.CommandButton Command6 
      Caption         =   "ReSpawn Guardias en posiciones originales"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   600
      TabIndex        =   9
      Top             =   720
      Width           =   3135
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Actualizar objetos.dat"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   600
      TabIndex        =   3
      Top             =   360
      Width           =   3135
   End
   Begin VB.CommandButton Command4 
      Caption         =   "Hacer un Backup del mundo"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   240
      TabIndex        =   2
      Top             =   3120
      Width           =   6975
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Aceptar"
      Default         =   -1  'True
      Height          =   255
      Left            =   6240
      TabIndex        =   0
      Top             =   4080
      Width           =   945
   End
   Begin VB.CommandButton Command16 
      Caption         =   "Reload Server.ini"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   600
      TabIndex        =   13
      Top             =   2520
      Width           =   6135
   End
   Begin VB.Shape Shape3 
      BackColor       =   &H80000006&
      BorderColor     =   &H00000000&
      FillColor       =   &H008080FF&
      Height          =   2895
      Left            =   120
      Top             =   120
      Width           =   7215
   End
   Begin VB.Shape Shape2 
      Height          =   975
      Left            =   120
      Top             =   3000
      Width           =   7215
   End
End
Attribute VB_Name = "frmServidor"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Option Explicit
Private Sub Command1_Click()
Call LoadOBJData
End Sub

Private Sub Command10_Click()
frmTrafic.Show
End Sub

Private Sub Command11_Click()
frmConID.Show
End Sub

Private Sub Command12_Click()
frmDebugNpc.Show
End Sub


Private Sub Command14_Click()
Call LoadMotd
End Sub

Private Sub Command15_Click()
On Error Resume Next

Dim Fn As String
Dim cad As String
Dim N As Integer, k As Integer

Fn = App.Path & "\logs\GenteBanned.log"

If FileExist(Fn, vbNormal) Then
    N = FreeFile
    Open Fn For Input Shared As #N
    Do While Not EOF(N)
        k = k + 1
        Input #N, cad
        Call ChangeBan(cad, 0)
        
    Loop
    Close #N
    MsgBox "Se han desbaneado " & k & " personajes."
    Kill Fn
End If




End Sub

Private Sub Command16_Click()
Call LoadSini
End Sub

Private Sub Command17_Click()
Call DescargaNpcsDat
Call CargaNpcsDat

End Sub
Private Sub Command18_Click()

Me.MousePointer = 11
Call GuardarUsuarios
Me.MousePointer = 0
MsgBox "Grabado de personajes OK!"

End Sub

Private Sub Command19_Click()
Dim i As Long, N As Long

N = BanIps.Count
For i = 1 To BanIps.Count
    BanIps.Remove 1
Next
Kill "BanIPs.txt"

MsgBox "Se han desbaneado " & N & " IPS."

End Sub

Private Sub Command2_Click()
frmServidor.Visible = False
End Sub

Private Sub Command4_Click()

On Error GoTo eh
    Me.MousePointer = 11
    'FrmStat.Show
    Call DoBackUp
    Me.MousePointer = 0
    MsgBox "WORLDSAVE OK!!"
Exit Sub

eh:
Call LogError("Error en WORLDSAVE")
End Sub

Private Sub Command5_Click()


On Error Resume Next

If frmMain.Visible Then frmMain.txStatus.caption = "Reiniciando."

'FrmStat.Show

If FileExist(App.Path & "\logs\errores.log", vbNormal) Then Kill App.Path & "\logs\errores.log"
If FileExist(App.Path & "\logs\HackAttemps.log", vbNormal) Then Kill App.Path & "\logs\HackAttemps.log"



Dim LoopC As Integer

For LoopC = 1 To MaxUsers
    Call CloseSocket(LoopC)
Next

LastUser = 0
NumUsers = 0
NumNoGMs = 0

ReDim Npclist(1 To MAXNPCS) As Npc
ReDim CharList(1 To MAXCHARS) As Integer

Call LoadSini
Call CargarBackUp
Call LoadOBJData



If frmMain.Visible Then frmMain.txStatus.caption = "Escuchando conexiones entrantes ..."

End Sub

Private Sub Command6_Click()
Call ReSpawnOrigPosNpcs
End Sub

Private Sub Command7_Click()
FrmInterv.Show
End Sub

Private Sub Command8_Click()
Call CargarHechizos

End Sub

Private Sub Command9_Click()
Call CargarForbidenWords
End Sub

Private Sub Form_Deactivate()
frmServidor.Visible = False
End Sub
