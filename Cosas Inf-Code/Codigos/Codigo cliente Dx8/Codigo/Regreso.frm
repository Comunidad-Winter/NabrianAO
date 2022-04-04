VERSION 5.00
Begin VB.Form Regreso 
   BorderStyle     =   0  'None
   ClientHeight    =   3990
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   3900
   LinkTopic       =   "Form1"
   ScaleHeight     =   3990
   ScaleWidth      =   3900
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.Image Image2 
      Height          =   495
      Left            =   2040
      Top             =   3240
      Width           =   1575
   End
   Begin VB.Image Image1 
      Height          =   495
      Left            =   240
      Top             =   3240
      Width           =   1575
   End
End
Attribute VB_Name = "Regreso"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Form_Load()
Me.Picture = LoadPicture(App.Path & "\graficos\Regreso.gif")
End Sub

Private Sub Image1_Click()
Call Audio.PlayWave(0, SND_CLICK)
Call SendData("/REGRESAR")
Unload Regreso
End Sub

Private Sub Image2_Click()
Call Audio.PlayWave(0, SND_CLICK)
Unload Regreso
End Sub
