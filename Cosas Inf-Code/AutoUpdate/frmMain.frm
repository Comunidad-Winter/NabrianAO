VERSION 5.00
Object = "{48E59290-9880-11CF-9754-00AA00C00908}#1.0#0"; "MSINET.OCX"
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "RICHTX32.OCX"
Object = "{55473EAC-7715-4257-B5EF-6E14EBD6A5DD}#1.0#0"; "vbalProgBar6.ocx"
Begin VB.Form frmMain 
   BorderStyle     =   4  'Fixed ToolWindow
   ClientHeight    =   2265
   ClientLeft      =   -45
   ClientTop       =   -150
   ClientWidth     =   6660
   ClipControls    =   0   'False
   ControlBox      =   0   'False
   Icon            =   "frmMain.frx":0000
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   2265
   ScaleWidth      =   6660
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.CommandButton Command2 
      Caption         =   "Forzar Actualización"
      Height          =   375
      Left            =   3240
      TabIndex        =   9
      Top             =   1800
      Width           =   1695
   End
   Begin VB.CommandButton Command1 
      Caption         =   "Cancel"
      Height          =   375
      Left            =   5040
      TabIndex        =   3
      Top             =   1800
      Width           =   1335
   End
   Begin VB.Timer Timer1 
      Interval        =   1000
      Left            =   5280
      Top             =   240
   End
   Begin vbalProgBarLib6.vbalProgressBar ProgressBar1 
      Height          =   330
      Left            =   240
      TabIndex        =   1
      Top             =   600
      Width           =   6135
      _ExtentX        =   10821
      _ExtentY        =   582
      Picture         =   "frmMain.frx":4888A
      BackColor       =   8421504
      ForeColor       =   16777215
      BarColor        =   49344
      BarPicture      =   "frmMain.frx":488A6
      BarPictureMode  =   0
      BackPictureMode =   0
      ShowText        =   -1  'True
      Text            =   "Espera un momento las actualizaciones comenzaran automáticamente"
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "MS Sans Serif"
         Size            =   8.25
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin RichTextLib.RichTextBox RichTextBox1 
      Height          =   2055
      Left            =   8280
      TabIndex        =   0
      Top             =   120
      Width           =   5055
      _ExtentX        =   8916
      _ExtentY        =   3625
      _Version        =   393217
      BackColor       =   0
      BorderStyle     =   0
      ReadOnly        =   -1  'True
      Appearance      =   0
      TextRTF         =   $"frmMain.frx":488C2
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin InetCtlsObjects.Inet Inet1 
      Left            =   5640
      Top             =   0
      _ExtentX        =   1005
      _ExtentY        =   1005
      _Version        =   393216
   End
   Begin VB.Label Label5 
      Caption         =   "---------------------------------------------------"
      Height          =   255
      Left            =   840
      TabIndex        =   8
      Top             =   1440
      Width           =   3855
   End
   Begin VB.Label Label4 
      Caption         =   "Acción:"
      Height          =   255
      Left            =   240
      TabIndex        =   7
      Top             =   1440
      Width           =   615
   End
   Begin VB.Label Label3 
      Caption         =   "Nabrian Controls, buscando actualizaciones."
      Height          =   255
      Left            =   240
      TabIndex        =   6
      Top             =   360
      Width           =   6135
   End
   Begin VB.Label Label2 
      Caption         =   "[0% Completado.]"
      Height          =   255
      Left            =   1920
      TabIndex        =   5
      Top             =   1080
      Width           =   2655
   End
   Begin VB.Label Label1 
      Caption         =   "Indicador de complet:"
      Height          =   255
      Left            =   240
      TabIndex        =   4
      Top             =   1080
      Width           =   2055
   End
   Begin VB.Label LSize 
      BackStyle       =   0  'Transparent
      Caption         =   "0 MBs de 0 MBs"
      ForeColor       =   &H0000FFFF&
      Height          =   255
      Left            =   240
      TabIndex        =   2
      Top             =   1800
      Visible         =   0   'False
      Width           =   2175
   End
End
Attribute VB_Name = "frmMain"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Const GWL_EXSTYLE = -20
Private Const WS_EX_LAYERED = &H80000
Private Const WS_EX_TRANSPARENT As Long = &H20&
Dim Directory As String, bDone As Boolean, dError As Boolean, F As Integer
Rem Programado por Shedark

Private Sub Analizar()
On Error Resume Next
    Dim i As Integer, iX As Integer, tX As Integer, DifX As Integer, dNum As String
    
    'lEstado.Caption = "Obteniendo datos..."
    Call addConsole("Buscando actualizaciones... Espere porfavor.", 0, 200, 0, False, False)
    frmMain.Timer1.Enabled = False
  
    
    iX = Inet1.OpenURL("http://nabrianupd.ddns.net/aup/VEREXE.txt") 'Host
    tX = LeerInt(App.Path & "\INIT\Update.ini")

    DifX = iX - tX
    
    
    If Not (DifX = 0) Then

    ProgressBar1.Visible = True
             Label3.Caption = "NabrianControls Iniciado, se han encontrado " & DifX & " actualizaciones."
            Call addConsole("Iniciando, se han encontrado " & DifX & " actualizaciones.", 255, 255, 255, False, False)   '>> Informacion
        For i = 1 To DifX
            Inet1.AccessType = icUseDefault
            dNum = i + tX
            
            #If BuscarLinks Then 'Buscamos el link en el host (1)
                Inet1.URL = Inet1.OpenURL("http://nabrianupd.ddns.net/aup/Link" & dNum & ".txt") 'Host
            #Else                'Generamos Link por defecto (0)
                Inet1.URL = "http://nabrianupd.ddns.net/aup/parche" & dNum & ".zip" 'Host
            #End If
            
            Directory = App.Path & "\INIT\parche" & dNum & ".zip"
            bDone = False
            dError = False
            
            'lURL.Caption = Inet1.URL
            'lName.Caption = "Parche" & dNum & ".zip"
            'lDirectorio.Caption = App.Path & "\"
                
            frmMain.Inet1.Execute , "GET"
            
            Do While bDone = False
            DoEvents
            Loop
            
            If dError Then Exit Sub
            
            UnZip Directory, App.Path & "\"
            Kill Directory
        Next i
    End If
     
    Call GuardarInt(App.Path & "\INIT\Update.ini", iX)
    
  Label5.Caption = "Actualizaciones completadas ya puedes jugar."
    Call addConsole("Actualizaciones completadas ya puedes jugar.", 255, 255, 0, False, False)
    'Image1.Visible = True
    ProgressBar1.value = 0
    If MsgBox("¿Desea ejecutar NabrianAO?", vbQuestion + vbYesNo, "Resolución") = vbYes Then
        Shell "NabrianAO.exe"
        End
    Else
        
End If

End Sub

Private Sub Command1_Click()
End
End Sub

Private Sub Command2_Click()
    Dim i As Integer, iX As Integer, tX As Integer, DifX As Integer, dNum As String
  
    tX = LeerInt(App.Path & "\INIT\Update.ini")
    Call GuardarInt(App.Path & "\INIT\Update.ini", 0)
    
MsgBox "Actualizaciones Forzadas, Vuelve a ejecutar el juego o el AutoUpdate y espera a que se descarge desde la actualización numero 1"
End
End Sub

Private Sub Form_Load()
On Error Resume Next
ProgressBar1.value = 0
'ProgressBar1.Height = 0
End Sub


Private Sub Image2_Click()


Call Analizar

End Sub

Private Sub Image2_MouseDown(Button As Integer, Shift As Integer, X As Single, Y As Single)

End Sub

Private Sub Image2_MouseMove(Button As Integer, Shift As Integer, X As Single, Y As Single)

End Sub

Private Sub Inet1_StateChanged(ByVal State As Integer)
On Error Resume Next
    Select Case State
        Case icError
            Call addConsole("Error en la conexión, descarga abortada.", 255, 0, 0, False, False)
            
            bDone = True
            dError = True
           ' Image1.Visible = True
        Case icResponseCompleted
            Dim vtData As Variant
            Dim tempArray() As Byte
            Dim FileSize As Long
            
            FileSize = Inet1.GetHeader("Content-length")
            ProgressBar1.Max = FileSize
            Call addConsole("Descagando actualizacion.", 255, 128, 64, False, False)
             Label5.Caption = "Descagando actualizacion."
           ' Image1.Visible = False
            Open Directory For Binary Access Write As #1
                vtData = Inet1.GetChunk(1024, icByteArray)
                DoEvents
                
                
                Do While Not Len(vtData) = 0
                    tempArray = vtData
                    Put #1, , tempArray
                    
                vtData = Inet1.GetChunk(1024, icByteArray)
                    
                    ProgressBar1.value = ProgressBar1.value + Len(vtData) * 2
                    LSize.Caption = (ProgressBar1.value + Len(vtData) * 2) / 1000000 & "MBs de " & (FileSize / 1000000) & "MBs"
                    Label2.Caption = "[" & CLng((ProgressBar1.value * 100) / ProgressBar1.Max) & "% Completado.]"
                    ProgressBar1.Text = "" & LSize.Caption & ""
                    DoEvents
                Loop
            Close #1
            Call addConsole("Extrayendo archivo .zip", 255, 255, 255, False, False)
            Call addConsole("Archivo extraido extraido exitosamente.", 0, 200, 0, False, False)
            Call addConsole("Actualizacion descargada con exito.", 0, 255, 0, False, False)
            Label5.Caption = "Extrayendo archivo .zip"
           ' Label5.Caption = "Archivo extraido extraido exitosamente."
          '  Label5.Caption = "Actualizacion descargada con exito."
               
            LSize.Caption = FileSize & "bytes"
            ProgressBar1.value = 0
            
            bDone = True
    End Select
End Sub

Private Sub Form_Unload(Cancel As Integer)
End
End Sub

Private Function LeerInt(ByVal Ruta As String) As Integer
    F = FreeFile
    Open Ruta For Input As F
    LeerInt = Input$(LOF(F), #F)
    Close #F
End Function

Private Sub GuardarInt(ByVal Ruta As String, ByVal data As Integer)
    F = FreeFile
    Open Ruta For Output As F
    Print #F, data
    Close #F
End Sub




Private Sub Timer1_Timer()
Call Analizar
End Sub
