VERSION 5.00
Begin VB.Form frmConID 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "ConiD nabrian"
   ClientHeight    =   2535
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   6885
   BeginProperty Font 
      Name            =   "Tahoma"
      Size            =   8.25
      Charset         =   0
      Weight          =   400
      Underline       =   0   'False
      Italic          =   0   'False
      Strikethrough   =   0   'False
   EndProperty
   Icon            =   "frmConID.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   ScaleHeight     =   2535
   ScaleWidth      =   6885
   StartUpPosition =   2  'CenterScreen
   Begin VB.Frame Frame2 
      Caption         =   "Panel:"
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
      Height          =   2295
      Left            =   4200
      TabIndex        =   5
      Top             =   120
      Width           =   2535
      Begin VB.CommandButton Command1 
         Caption         =   "Cerrar"
         Height          =   390
         Left            =   120
         TabIndex        =   3
         Top             =   1335
         Width           =   2250
      End
      Begin VB.CommandButton Command2 
         Caption         =   "Ver estado"
         Height          =   390
         Left            =   135
         TabIndex        =   1
         Top             =   360
         Width           =   2250
      End
      Begin VB.CommandButton Command3 
         Caption         =   "Liberar todos los slots"
         Height          =   390
         Left            =   135
         TabIndex        =   2
         Top             =   855
         Width           =   2250
      End
      Begin VB.Label Label1 
         Caption         =   "Esperando información..."
         Height          =   255
         Left            =   120
         TabIndex        =   6
         Top             =   1920
         Width           =   2295
      End
   End
   Begin VB.Frame Frame1 
      Caption         =   "Lista ID:"
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
      Height          =   2295
      Left            =   120
      TabIndex        =   4
      Top             =   120
      Width           =   3975
      Begin VB.ListBox List1 
         Height          =   1815
         Left            =   120
         TabIndex        =   0
         Top             =   360
         Width           =   3735
      End
   End
End
Attribute VB_Name = "frmConID"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False



Private Sub Command1_Click()
Unload Me
End Sub

Private Sub Command2_Click()

List1.Clear

Dim c As Integer
Dim i As Integer

For i = 1 To MaxUsers
    List1.AddItem "UserIndex " & i & " -- " & UserList(i).ConnID
    If UserList(i).ConnID <> -1 Then c = c + 1
Next

If c = MaxUsers Then
    Label1.caption = "No hay slots vacios!"
Else
    Label1.caption = "Hay " & MaxUsers - c & " slots vacios!"
End If

End Sub

Private Sub Command3_Click()
Dim i As Integer

For i = 1 To MaxUsers
    If UserList(i).ConnID <> -1 And Not UserList(i).flags.UserLogged Then Call CloseSocket(i)
Next

End Sub

