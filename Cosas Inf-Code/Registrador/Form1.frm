VERSION 5.00
Begin VB.Form Basic 
   BorderStyle     =   1  'Fixed Single
   Caption         =   "Nabrian Control (v1)"
   ClientHeight    =   3690
   ClientLeft      =   45
   ClientTop       =   330
   ClientWidth     =   4065
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   3690
   ScaleWidth      =   4065
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox Text2 
      Enabled         =   0   'False
      Height          =   285
      Left            =   4440
      TabIndex        =   4
      Top             =   1320
      Width           =   1455
   End
   Begin VB.TextBox Text1 
      Enabled         =   0   'False
      Height          =   285
      Left            =   4440
      TabIndex        =   3
      Top             =   1080
      Width           =   1455
   End
   Begin VB.Timer Timer2 
      Enabled         =   0   'False
      Interval        =   200
      Left            =   4920
      Top             =   1680
   End
   Begin VB.Timer Timer1 
      Enabled         =   0   'False
      Interval        =   100
      Left            =   4440
      Top             =   1680
   End
   Begin VB.Label Label7 
      Alignment       =   2  'Center
      BackColor       =   &H008080FF&
      Caption         =   "http://nabrianao.com/"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   120
      TabIndex        =   8
      Top             =   3240
      Width           =   3855
   End
   Begin VB.Label Label6 
      BackColor       =   &H00404040&
      Caption         =   $"Form1.frx":0000
      ForeColor       =   &H00FFFFFF&
      Height          =   1455
      Left            =   120
      TabIndex        =   7
      Top             =   1680
      Width           =   3855
   End
   Begin VB.Label Label4 
      BackColor       =   &H00404040&
      Caption         =   "            ¿Como ejecutar como administrador?"
      ForeColor       =   &H0080C0FF&
      Height          =   255
      Left            =   120
      TabIndex        =   6
      Top             =   1440
      Width           =   3855
   End
   Begin VB.Label Label3 
      BackColor       =   &H00404040&
      Caption         =   "Leer: Si tenes windows 7, 8, vista, deberás ejecutar este archivo como administrador para que cumpla su función correctamente."
      ForeColor       =   &H00FFFFFF&
      Height          =   615
      Left            =   120
      TabIndex        =   5
      Top             =   840
      Width           =   3855
   End
   Begin VB.Label Label2 
      Alignment       =   2  'Center
      BackColor       =   &H000080FF&
      Caption         =   "-"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   255
      Left            =   -120
      TabIndex        =   2
      Top             =   240
      Width           =   4215
   End
   Begin VB.Label Label5 
      BackColor       =   &H00C0C0FF&
      Caption         =   "Presione registrar para comenzar.."
      Height          =   255
      Left            =   0
      TabIndex        =   1
      Top             =   0
      Width           =   4095
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      BackColor       =   &H0080C0FF&
      Caption         =   "-"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   12
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   375
      Left            =   -120
      TabIndex        =   0
      Top             =   480
      Width           =   4215
   End
End
Attribute VB_Name = "Basic"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub Command1_Click()
Label5.Caption = "Copiando:"
Timer2.Enabled = True
End Sub



Private Sub Form_Load()
Call EJECUTOCOMO
 Dim lR As Long
 lR = SetTopMostWindow(Basic.hwnd, True)
         
Timer2.Enabled = True
End Sub

Private Sub Timer1_Timer()
Static Registrar As Byte

Registrar = Registrar + 1

If Registrar = 1 Then
Shell "regsvr32 -s DX7VB.DLL"
Label1.Caption = "DX7VB.DLL"
ElseIf Registrar = 2 Then
Shell "regsvr32 -s msvbvm60.dll"
Label1.Caption = "msvbvm60.dll"
ElseIf Registrar = 3 Then
Shell "regsvr32 -s MSWINSCK.OCX"
Label1.Caption = "MSWINSCK.OCX"
ElseIf Registrar = 4 Then
Shell "regsvr32 -s TABCTL32.OCX"
Label1.Caption = "TABCTL32.OCX"
ElseIf Registrar = 5 Then
Shell "regsvr32 -s MSINET.OCX"
Label1.Caption = "MSINET.OCX"
ElseIf Registrar = 6 Then
Shell "regsvr32 -s MSVBVM50.DLL"
Label1.Caption = "MSVBVM50.DLL"
ElseIf Registrar = 7 Then
Shell "regsvr32 -s vbalProgBar6.ocx"
Label1.Caption = "vbalProgBar6.ocx"
ElseIf Registrar = 8 Then
Shell "regsvr32 -s COMCTL32.OCX"
Label1.Caption = "COMCTL32.OCX"
ElseIf Registrar = 9 Then
Shell "regsvr32 -s CSWSK32.OCX"
Label1.Caption = "CSWSK32.OCX"
ElseIf Registrar = 10 Then
Shell "regsvr32 -s Unzip32.dll"
Label1.Caption = "Unzip32.dll"
ElseIf Registrar = 11 Then
Shell "regsvr32 -s Captura.ocx"
Label1.Caption = "Captura.ocx"
ElseIf Registrar = 12 Then
Shell "regsvr32 -s dx8vb.dll"
Label1.Caption = "dx8vb.dll"
ElseIf Registrar = 13 Then
Shell "regsvr32 -s vbabdx.dll"
Label1.Caption = "vbabdx.dll"
ElseIf Registrar = 14 Then
Label1.Caption = "¡Finalizado!"
End
End If
End Sub

Private Sub Timer2_Timer()
Static Registrar As Byte

Registrar = Registrar + 1

If Registrar = 1 Then
Call copiar
Label2.Caption = "DX7VB.DLL"
ElseIf Registrar = 1 Then
Call copiar1
Call copiar1a
Label2.Caption = "Captura.ocx"
ElseIf Registrar = 2 Then
Call copiar2
Label2.Caption = "msvbvm60.dll"
ElseIf Registrar = 3 Then
Call copiar3
Label2.Caption = "MSWINSCK.OCX"
ElseIf Registrar = 4 Then
Call copiar4
Label2.Caption = "TABCTL32.OCX"
ElseIf Registrar = 5 Then
Call copiar5
Label2.Caption = "MSINET.OCX"
ElseIf Registrar = 6 Then
Call copiar6
Label2.Caption = "MSVBVM50.DLL"
ElseIf Registrar = 7 Then
Call copiar7
Label2.Caption = "vbalProgBar6.ocx"
ElseIf Registrar = 8 Then
Call copiar8
Label2.Caption = "COMCTL32.OCX"
ElseIf Registrar = 9 Then
Call copiar9
Label2.Caption = "CSWSK32.OCX"
ElseIf Registrar = 10 Then
Call copiar10
Label2.Caption = "Unzip32.dll"
ElseIf Registrar = 11 Then
Call copiar11
Call copiar11a
Label2.Caption = "dx8vb.dll"
ElseIf Registrar = 12 Then
Call copiar12
Label2.Caption = "vbabdx.dll"
ElseIf Registrar = 13 Then
Label2.Caption = "¡Copia de archivos terminada!"
Label5.Caption = "Registrando:"
Timer1.Enabled = True
Timer2.Enabled = False
End If
End Sub
