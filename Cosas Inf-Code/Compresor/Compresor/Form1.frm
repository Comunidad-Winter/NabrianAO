VERSION 5.00
Begin VB.Form Form1 
   Caption         =   "Compresor de Graficos - NAO"
   ClientHeight    =   2475
   ClientLeft      =   60
   ClientTop       =   450
   ClientWidth     =   4725
   LinkTopic       =   "Form1"
   ScaleHeight     =   2475
   ScaleWidth      =   4725
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton Command6 
      Caption         =   "Descomprimir WAV"
      Height          =   495
      Left            =   2880
      TabIndex        =   6
      Top             =   1440
      Width           =   1575
   End
   Begin VB.CommandButton Command5 
      Caption         =   "Comprimir WAV"
      Height          =   495
      Left            =   240
      TabIndex        =   5
      Top             =   1440
      Width           =   1575
   End
   Begin VB.CommandButton Command4 
      Caption         =   "Descomprimir MP3"
      Height          =   495
      Left            =   2880
      TabIndex        =   4
      Top             =   840
      Width           =   1575
   End
   Begin VB.CommandButton Command3 
      Caption         =   "Comprimir MP3"
      Height          =   495
      Left            =   240
      TabIndex        =   3
      Top             =   840
      Width           =   1575
   End
   Begin VB.CommandButton Command2 
      Caption         =   "Descomprimir Graficos"
      Height          =   495
      Left            =   2880
      TabIndex        =   1
      Top             =   240
      Width           =   1575
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Comprimir Graficos"
      Height          =   495
      Left            =   240
      TabIndex        =   0
      Top             =   240
      Width           =   1575
   End
   Begin VB.Label Label1 
      Alignment       =   2  'Center
      Caption         =   "Seleccione la acción deseada"
      Height          =   255
      Left            =   120
      TabIndex        =   2
      Top             =   2160
      Width           =   4455
   End
End
Attribute VB_Name = "Form1"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Sub Command1_Click()
Label1.Caption = "Comprimiendo graficos, espere..."
DoEvents
Compress_Files2 Graphics, "GRAFICOS", ""
Label1.Caption = "Terminado."
End Sub

Private Sub Command3_Click()
Label1.Caption = "Comprimiendo MP3, espere..."
DoEvents
Compress_Files2 MP3, "MP3", ""
Label1.Caption = "Terminado."
End Sub

Private Sub Command5_Click()
Label1.Caption = "Comprimiendo WAV, espere..."
DoEvents
Compress_Files2 WAV, "WAV", ""
Label1.Caption = "Terminado."
End Sub



Private Sub Command2_Click()
Label1.Caption = "Descomprimiendo graficos, espere..."
DoEvents
Extract_All_Files2 Graphics, "Recursos", True
Label1.Caption = "Terminado."
End Sub

Private Sub Command4_Click()
Label1.Caption = "Descomprimiendo MP3, espere..."
DoEvents
Extract_All_Files2 MP3, "Recursos", True
Label1.Caption = "Terminado."
End Sub

Private Sub Command6_Click()
Label1.Caption = "Descomprimiendo WAV, espere..."
DoEvents
Extract_All_Files2 WAV, "WAV", True
Label1.Caption = "Terminado."
End Sub
