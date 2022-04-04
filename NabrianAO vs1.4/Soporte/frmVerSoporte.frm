VERSION 5.00
Begin VB.Form frmVerSoporte 
   BackColor       =   &H00C0C0FF&
   BorderStyle     =   0  'None
   Caption         =   "soporte"
   ClientHeight    =   4830
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   5175
   LinkTopic       =   "Form1"
   ScaleHeight     =   322
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   345
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.Label respuestagm 
      BackStyle       =   0  'Transparent
      Caption         =   "SOPORTE"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000080FF&
      Height          =   255
      Left            =   3480
      TabIndex        =   1
      Top             =   4260
      Width           =   1575
   End
   Begin VB.Label lblR 
      BackColor       =   &H00000040&
      BackStyle       =   0  'Transparent
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   3015
      Left            =   360
      TabIndex        =   0
      Top             =   960
      Width           =   4395
   End
   Begin VB.Image imgCerrar 
      Height          =   375
      Left            =   360
      MouseIcon       =   "frmVerSoporte.frx":0000
      Top             =   4200
      Width           =   855
   End
End
Attribute VB_Name = "frmVerSoporte"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Sub Form_Load()
Me.Picture = LoadPicture(DirGraficos & "resos.jpg")
End Sub

Private Sub imgCerrar_Click()
Call Audio.PlayWave(0, SND_CLICK)
lblR.Caption = ""
Me.Hide
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

