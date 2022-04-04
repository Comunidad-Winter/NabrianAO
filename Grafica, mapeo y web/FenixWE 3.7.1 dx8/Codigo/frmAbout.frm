VERSION 5.00
Begin VB.Form frmAbout 
   BorderStyle     =   4  'Fixed ToolWindow
   Caption         =   "Acerca de Fenix WE"
   ClientHeight    =   3525
   ClientLeft      =   2340
   ClientTop       =   1815
   ClientWidth     =   4365
   ClipControls    =   0   'False
   Icon            =   "frmAbout.frx":0000
   LinkTopic       =   "Form2"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   Picture         =   "frmAbout.frx":628A
   ScaleHeight     =   2433.018
   ScaleMode       =   0  'User
   ScaleWidth      =   4098.96
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.Label lblCred 
      Alignment       =   2  'Center
      BackColor       =   &H00000000&
      Caption         =   "Mejorado por Deut (Tritio)"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00C0FFC0&
      Height          =   240
      Index           =   5
      Left            =   720
      TabIndex        =   7
      Top             =   1200
      Width           =   3075
   End
   Begin VB.Label lblCred 
      Alignment       =   2  'Center
      BackColor       =   &H00000000&
      Caption         =   "Adaptado por Rubio93"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H0000FFFF&
      Height          =   240
      Index           =   4
      Left            =   720
      TabIndex        =   6
      Top             =   1440
      Width           =   3075
   End
   Begin VB.Label lblCred 
      Alignment       =   2  'Center
      BackColor       =   &H00000000&
      Caption         =   "Actualizaciones de About, Loopzer y Salvito."
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   480
      Index           =   1
      Left            =   720
      TabIndex        =   5
      Top             =   1920
      Width           =   3075
   End
   Begin VB.Label lblTitle 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Fenix WE"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   26.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   615
      Left            =   1200
      TabIndex        =   4
      Top             =   60
      Width           =   2310
   End
   Begin VB.Label lblVersion 
      AutoSize        =   -1  'True
      BackStyle       =   0  'Transparent
      Caption         =   "Versión"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   11.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00E0E0E0&
      Height          =   270
      Left            =   1800
      TabIndex        =   3
      Top             =   570
      Width           =   810
   End
   Begin VB.Label lblCred 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "Basado en códigos de BaronSoft, Dunga, Maraxus y Morgolock"
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
      Height          =   450
      Index           =   0
      Left            =   960
      TabIndex        =   2
      Top             =   2400
      Width           =   2565
   End
   Begin VB.Label lblCred 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "Agradecimientos especiales: Dunga, Manikke, Maraxus, Kiko, Koke y todos ;)"
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
      Height          =   645
      Index           =   3
      Left            =   960
      TabIndex        =   1
      Top             =   2880
      Width           =   2565
   End
   Begin VB.Label lblCred 
      Alignment       =   2  'Center
      BackColor       =   &H00000000&
      Caption         =   "Programado por ^[GS]^"
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   9
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H0000FF00&
      Height          =   240
      Index           =   2
      Left            =   720
      TabIndex        =   0
      Top             =   1680
      Width           =   3075
   End
   Begin VB.Shape Shape1 
      BackColor       =   &H00FFFF00&
      BackStyle       =   1  'Opaque
      BorderColor     =   &H00FF0000&
      DrawMode        =   9  'Not Mask Pen
      FillColor       =   &H00C0C0FF&
      FillStyle       =   0  'Solid
      Height          =   2385
      Left            =   120
      Shape           =   4  'Rounded Rectangle
      Top             =   960
      Width           =   4095
   End
End
Attribute VB_Name = "frmAbout"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub Form_Load()
'*************************************************
'Author: ^[GS]^
'Last modified: 20/05/06
'*************************************************
    Me.Caption = "Acerca de " & App.Title
    lblVersion.Caption = "Versión " & App.Major & "." & App.Minor & "." & App.Revision
    lblTitle.Caption = App.Title
End Sub

