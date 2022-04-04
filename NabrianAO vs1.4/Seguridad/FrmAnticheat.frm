VERSION 5.00
Begin VB.Form FrmAnticheat 
   BorderStyle     =   0  'None
   ClientHeight    =   6195
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   5955
   FillColor       =   &H00FFFFFF&
   ForeColor       =   &H00FFFFFF&
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Picture         =   "FrmAnticheat.frx":0000
   ScaleHeight     =   6195
   ScaleWidth      =   5955
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.Label LabelCHEAT 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   11.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   255
      Left            =   0
      TabIndex        =   0
      Top             =   4800
      Width           =   5895
   End
   Begin VB.Image Image1 
      Height          =   615
      Left            =   840
      Top             =   5160
      Width           =   4455
   End
End
Attribute VB_Name = "FrmAnticheat"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
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

Private Sub Image1_Click()
Call Audio.PlayWave(0, SND_CLICK)
Unload Me
End Sub

