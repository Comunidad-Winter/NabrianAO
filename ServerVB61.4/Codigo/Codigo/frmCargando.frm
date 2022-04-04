VERSION 5.00
Object = "{6B7E6392-850A-101B-AFC0-4210102A8DA7}#1.3#0"; "COMCTL32.OCX"
Begin VB.Form frmCargando 
   BackColor       =   &H00C0C0C0&
   BorderStyle     =   1  'Fixed Single
   ClientHeight    =   480
   ClientLeft      =   1425
   ClientTop       =   3075
   ClientWidth     =   6855
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   40.376
   ScaleMode       =   0  'User
   ScaleWidth      =   457
   StartUpPosition =   2  'CenterScreen
   Begin ComctlLib.ProgressBar cargar 
      Height          =   255
      Left            =   120
      TabIndex        =   1
      Top             =   120
      Width           =   4530
      _ExtentX        =   7990
      _ExtentY        =   450
      _Version        =   327682
      Appearance      =   0
      Min             =   1e-4
   End
   Begin VB.Label Label1 
      Alignment       =   1  'Right Justify
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   " aa"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00000000&
      Height          =   240
      Index           =   2
      Left            =   6480
      TabIndex        =   0
      Top             =   120
      Width           =   270
   End
End
Attribute VB_Name = "frmCargando"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False



Private Sub Form_Load()

'Picture1.Picture = LoadPicture(App.Path & "\logo.jpg")

      If App.PrevInstance Then
            msg = App.EXEName & "SV.EXE" & " ya está en ejecución"
            End
        End If
End Sub

Private Sub Frame1_DragDrop(Source As Control, X As Single, y As Single)

End Sub

