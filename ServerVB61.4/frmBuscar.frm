VERSION 5.00
Begin VB.Form frmBuscar 
   BackColor       =   &H00000000&
   BorderStyle     =   3  'Fixed Dialog
   Caption         =   "Buscador + User on data (WEB)"
   ClientHeight    =   7230
   ClientLeft      =   45
   ClientTop       =   375
   ClientWidth     =   7140
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   7230
   ScaleWidth      =   7140
   ShowInTaskbar   =   0   'False
   StartUpPosition =   3  'Windows Default
   Begin VB.TextBox Text1 
      Height          =   3255
      Left            =   7680
      TabIndex        =   14
      Text            =   "Text1"
      Top             =   2520
      Width           =   3375
   End
   Begin VB.CommandButton Command4 
      Caption         =   "Buscar por MOTHER"
      Height          =   375
      Left            =   4920
      TabIndex        =   12
      Top             =   5640
      Width           =   2055
   End
   Begin VB.Timer datosweb 
      Interval        =   10000
      Left            =   2280
      Top             =   5760
   End
   Begin VB.Frame frameChars 
      BackColor       =   &H00000000&
      Caption         =   "Charfiles"
      ForeColor       =   &H00C0C0FF&
      Height          =   4935
      Left            =   120
      TabIndex        =   5
      Top             =   120
      Width           =   2775
      Begin VB.Timer Timer1 
         Interval        =   30000
         Left            =   2280
         Top             =   120
      End
      Begin VB.CommandButton cmbUpdateChars 
         BackColor       =   &H00C0C0C0&
         Caption         =   "Actualizar"
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         Height          =   375
         Left            =   240
         MaskColor       =   &H00FFFFFF&
         Style           =   1  'Graphical
         TabIndex        =   7
         Top             =   4080
         Width           =   2295
      End
      Begin VB.ListBox lstChars 
         BackColor       =   &H00000000&
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   9.75
            Charset         =   0
            Weight          =   400
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFFFF&
         Height          =   3660
         Left            =   240
         TabIndex        =   6
         Top             =   360
         Width           =   2295
      End
   End
   Begin VB.Frame frameResultados 
      BackColor       =   &H00000000&
      Caption         =   "Resultados"
      ForeColor       =   &H00C0C0FF&
      Height          =   4935
      Left            =   3000
      TabIndex        =   3
      Top             =   120
      Width           =   4095
      Begin VB.TextBox txtProcesado 
         BackColor       =   &H80000007&
         BeginProperty Font 
            Name            =   "MS Sans Serif"
            Size            =   12
            Charset         =   0
            Weight          =   700
            Underline       =   0   'False
            Italic          =   0   'False
            Strikethrough   =   0   'False
         EndProperty
         ForeColor       =   &H00FFFF00&
         Height          =   4455
         Left            =   120
         Locked          =   -1  'True
         MultiLine       =   -1  'True
         TabIndex        =   4
         Top             =   360
         Width           =   3855
      End
   End
   Begin VB.Frame frameAcciones 
      BackColor       =   &H00000000&
      Caption         =   "Acciones"
      ForeColor       =   &H00C0C0FF&
      Height          =   1095
      Left            =   120
      TabIndex        =   0
      Top             =   5040
      Width           =   6975
      Begin VB.TextBox Ruta 
         Height          =   375
         Left            =   120
         TabIndex        =   15
         Text            =   "C:\inetpub\wwwroot\"
         Top             =   600
         Width           =   2895
      End
      Begin VB.CommandButton Command5 
         Caption         =   "MANUAL"
         Height          =   255
         Left            =   2520
         TabIndex        =   13
         Top             =   0
         Width           =   975
      End
      Begin VB.CommandButton Command3 
         Caption         =   "Buscar usuarios por HD"
         Height          =   375
         Left            =   3000
         TabIndex        =   11
         Top             =   600
         Width           =   1815
      End
      Begin VB.TextBox txtDatos 
         BackColor       =   &H00000000&
         ForeColor       =   &H00FFFFFF&
         Height          =   375
         Left            =   120
         TabIndex        =   8
         Text            =   "127.0.0.1"
         Top             =   240
         Width           =   2655
      End
      Begin VB.CommandButton cmbMail 
         Caption         =   "Buscar usuario por Código"
         Height          =   375
         Left            =   4800
         TabIndex        =   2
         Top             =   240
         Width           =   2055
      End
      Begin VB.CommandButton cmbIP 
         Caption         =   "Busca usuarios por IP"
         Height          =   375
         Left            =   3000
         TabIndex        =   1
         Top             =   240
         Width           =   1815
      End
   End
   Begin VB.Label Label3 
      Alignment       =   2  'Center
      BackColor       =   &H00000000&
      BackStyle       =   0  'Transparent
      Caption         =   "Detector server.exe: AutoActivado"
      BeginProperty Font 
         Name            =   "MS Sans Serif"
         Size            =   18
         Charset         =   0
         Weight          =   700
         Underline       =   -1  'True
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00C0C0C0&
      Height          =   495
      Left            =   120
      TabIndex        =   10
      Top             =   6600
      Width           =   6975
   End
   Begin VB.Label lblStatus 
      BackColor       =   &H00000000&
      ForeColor       =   &H00E0E0E0&
      Height          =   255
      Left            =   0
      TabIndex        =   9
      Top             =   4680
      Width           =   2775
   End
End
Attribute VB_Name = "frmBuscar"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit

Private Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)

Dim Nicks(90000) As String ' max 10M de pjs
Dim MaxChar As Long ' ultimo numero de la array nicks
Dim Analizado As Long

Sub BuscarCodigo(Email As String)
Dim Path As String
Dim Archivo As String
Dim ContarChar As Long
Dim Nick As String
Dim IpPreArray() As String
Dim IpArray(4) As String
Path = App.Path & "\Charfile\"

ContarChar = 1

txtProcesado.Text = ""

lblStatus = "ANALIZANDO CHARFILES - ESPERE"
DoEvents

Do While ContarChar <= MaxChar
    Archivo = X6(Path & Nicks(ContarChar - 1), "CONTACTO", "Email")
    If Archivo = Email Then
        txtProcesado.Text = txtProcesado.Text & Nicks(ContarChar - 1) & vbCrLf
    End If
    ContarChar = ContarChar + 1
Loop

lblStatus = ""


End Sub

Sub BuscarMother(Email As String)
Dim Path As String
Dim Archivo As String
Dim ContarChar As Long
Dim Nick As String
Dim IpPreArray() As String
Dim IpArray(4) As String
Path = App.Path & "\Charfile\"

ContarChar = 1

txtProcesado.Text = ""

lblStatus = "ANALIZANDO CHARFILES - ESPERE"
DoEvents

Do While ContarChar <= MaxChar
    Archivo = X6(Path & Nicks(ContarChar - 1), "INIT", "Mother")
    If Archivo = Email Then
        txtProcesado.Text = txtProcesado.Text & Nicks(ContarChar - 1) & vbCrLf
    End If
    ContarChar = ContarChar + 1
Loop

lblStatus = ""


End Sub
Sub BuscarIP(IP As String)
Dim Path As String
Dim Archivo As String
Dim ContarChar As Long
Dim Nick As String
Dim IpPreArray() As String
Dim IpArray(4) As String
Path = App.Path & "\Charfile\"

ContarChar = 1

txtProcesado.Text = ""

lblStatus = "ANALIZANDO CHARFILES - ESPERE"
DoEvents

Do While ContarChar <= MaxChar
    Archivo = X6(Path & Nicks(ContarChar - 1), "INIT", "LastIP")
    If Archivo = IP Then
        txtProcesado.Text = txtProcesado.Text & Nicks(ContarChar - 1) & vbCrLf
    End If
    ContarChar = ContarChar + 1
Loop

lblStatus = ""


End Sub

Sub BuscarHD(HD As String)
Dim Path As String
Dim Archivo As String
Dim ContarChar As Long
Dim Nick As String
Dim IpPreArray() As String
Dim IpArray(4) As String
Path = App.Path & "\Charfile\"

ContarChar = 1

txtProcesado.Text = ""

lblStatus = "ANALIZANDO CHARFILES - ESPERE"
DoEvents

Do While ContarChar <= MaxChar
    Archivo = X6(Path & Nicks(ContarChar - 1), "INIT", "LastHD")
    If Archivo = HD Then
        txtProcesado.Text = txtProcesado.Text & Nicks(ContarChar - 1) & vbCrLf
    End If
    ContarChar = ContarChar + 1
Loop

lblStatus = ""


End Sub

Private Sub cmbIP_Click()
If txtDatos.Text = "" Then
    lblStatus = "FALTAN DATOS"
    DoEvents
    Sleep (500)
    lblStatus = ""
    Exit Sub
End If

BuscarIP (txtDatos.Text)
End Sub

Sub BuscarChars()
Dim FileName As String
Dim count As Long
count = 1

FileName = Dir(App.Path & "\Charfile\*.chr", vbArchive)
lstChars.Clear
Do While FileName <> ""
    lstChars.AddItem FileName
    FileName = Dir
Loop

Do While count <= lstChars.ListCount
Nicks(count - 1) = lstChars.List(count - 1)
''MsgBox Nicks(count - 1)
count = count + 1
Loop

MaxChar = lstChars.ListCount
frameChars.Caption = "Charfiles: " & MaxChar

End Sub

Private Sub cmbMail_Click()

If txtDatos.Text = "" Then
    lblStatus = "FALTAN DATOS"
    DoEvents
    Sleep (500)
    lblStatus = ""
    Exit Sub
End If

BuscarCodigo (txtDatos.Text)
End Sub

Private Sub cmbUpdateChars_Click()
BuscarChars
DoEvents
End Sub



Private Sub Command3_Click()
If txtDatos.Text = "" Then
    lblStatus = "FALTAN DATOS"
    DoEvents
    Sleep (500)
    lblStatus = ""
    Exit Sub
End If

BuscarHD (txtDatos.Text)
End Sub

Private Sub Command4_Click()
If txtDatos.Text = "" Then
    lblStatus = "FALTAN DATOS"
    DoEvents
    Sleep (500)
    lblStatus = ""
    Exit Sub
End If

BuscarMother (txtDatos.Text)
End Sub

Private Sub Command5_Click()
 On Error Resume Next



'Dim foo As Integer
     '   foo = FreeFile
   ' Open Ruta.Text & "prepara.txt" For Input As #foo
    '    Text1.Text = Input(LOF(foo), #foo)
      '      Close #foo
            
            
            'Text1.Text = Replace(Text1.Text, vbCrLf, "")
            
        '    Dim i As Integer
       '      Dim A As Integer
             
             
             
           
      '      For i = 201 To 250
            
    '          Text1.Text = Replace(Text1.Text, "iv align='center'><span id='estadosv1x'>'.$me" & i & ".'</span></div></td> </tr>", "iv align='center'><span id='estadosv1x'>'.$me" & i & ".'</span></div></td> </tr> =?¿ & _")
             
            
    '        Text1.Text = Replace(Text1.Text, "'.$da" & i & ".'", "=?¿ & X6(App.Path & =?¿\G.log=?¿, =?¿Top" & i & "=?¿, =?¿Name=?¿) & =?¿")
   '              Text1.Text = Replace(Text1.Text, "'.$me" & i & ".'", "=?¿ & X6(App.Path & =?¿\G.log=?¿, =?¿Top" & i & "=?¿, =?¿RE=?¿) & =?¿")
 '  Next i
     '       Text1.Text = Replace(Text1.Text, "<tr> <td><span id='estadosv'>", "XD & =?¿")
                
        
            
            
            
    '        GuardarArchivo Ruta.Text & "archivo.txt", Text1

End Sub

Sub GuardarArchivo(Ruta As String, Texto As TextBox)
Dim fnum As Integer
On Error GoTo Ninguno
fnum = FreeFile
Open Ruta For Output As fnum
Print #fnum, Texto.Text
Close fnum
Exit Sub
Ninguno:

End Sub


Private Sub datosweb_Timer()
 On Error Resume Next


Dim cad As String
Kill Ruta.Text & "estadisticas.html"
cad = "<html><head><link href='stylestats.css' rel='stylesheet' type='text/css' /></head><p><span id='estadosv'>Estado:</span><span id='estadosv1'>Online</span><br></p><p><span id='estadosv1'>Usuarios jugando: " & X6(App.Path & "\Dat\UsersOn.siam", "USERSON", "UsuariosOnline") & "<br><span></p><p><span id='estadosv1'>Usuarios Creados: " & X6(App.Path & "\Dat\UsersOn.siam", "USERSON", "PersonajesCreados") & "<br></span></p><p><span id='estadosv1'>Exp: " & X6(App.Path & "\Server.ini", "INIT", "Experiencia") & " " & "<br></span></p><p><span id='estadosv1'>Oro: " & X6(App.Path & "\Server.ini", "INIT", "oro") & " " & "<br></span></p>"
Open Ruta.Text & "estadisticas.html" For Append As #2
Print #2, cad
Close #2


Kill Ruta.Text & "topusers.html"
cad = "<!doctype html><html><head><meta http-equiv='Content-Type' content='text/html; charset=utf-8'><link href='statsindex.css' rel='stylesheet' type='text/css' /></head><table width='212' height='244' border='0' style='table-layout: fixed'>  <tr>    <td width='3'><span id='estadosv'>P</span></td>   <td width='10'><div align='left'><span id='estadosv1'>-Nick</span></div></td>    <td width='10'><span id='estadosv1'>Lvl</span></td>  </tr>  <tr>    <td><span id='estadosv'><img src='files/oro.png' width='32' height='32'> </span></td>    <td><div align='left'><span id='estadosv'>" & X6(App.Path & "\G.log", "Top1", "name") & "</span></div></td>    <td><div align='left'><span id='estadosv'>" & X6(App.Path & "\G.log", "Top1", "NivelReal") & "</span></td>  </tr>  <tr>    <td><span id='estadosv'><img src='files/plata.png' width='32' height='32'> </span></td>" & _
"<td><div align='left'><span id='estadosv'>" & X6(App.Path & "\G.log", "Top2", "name") & "</span></div></td>    <td><div align='left'><span id='estadosv'>" & X6(App.Path & "\G.log", "Top2", "NivelReal") & "</span></td>  </tr>  <tr>" & _
"<td><span id='estadosv'><img src='files/bronce.png' width='32' height='32'> </span></td>    <td><div align='left'><span id='estadosv'>" & X6(App.Path & "\G.log", "Top3", "name") & "</span></div></td>    <td><div align='left'><span id='estadosv'>" & X6(App.Path & "\G.log", "Top3", "NivelReal") & "</span></td>  </tr>  <tr>    <td><span id='estadosv'>4º</span></td>    <td><div align='left'><span id='estadosv1'>" & X6(App.Path & "\G.log", "Top4", "name") & "</span></div></td>    <td><div align='left'><span id='estadosv1'>" & X6(App.Path & "\G.log", "Top4", "NivelReal") & "</span></td>  </tr>  <tr>    <td><span id='estadosv'>5º</span></td>    <td><div align='left'><span id='estadosv1'>" & X6(App.Path & "\G.log", "Top5", "name") & "</span></div></td>    <td><div align='left'><span id='estadosv1'>" & X6(App.Path & "\G.log", "Top5", "NivelReal") & "</span></td>  </tr" & _
">  <tr>    <td><span id='estadosv'>6º</span></td>    <td><div align='left'><span id='estadosv1'>" & X6(App.Path & "\G.log", "Top6", "name") & "</span></div></td>    <td><div align='left'><span id='estadosv1'>" & X6(App.Path & "\G.log", "Top6", "NivelReal") & "</span></td>  </tr>  <tr>    <td><span id='estadosv'>7º</span></td>    <td><div align='left'><span id='estadosv1'>" & X6(App.Path & "\G.log", "Top7", "name") & "</span></div></td>    <td><div align='left'><span id='estadosv1'>" & X6(App.Path & "\G.log", "Top7", "NivelReal") & "</span></td>  </tr>  <tr>    <td><span id='estadosv'>8º</span></td>    <td><div align='left'><span id='estadosv1'>" & X6(App.Path & "\G.log", "Top8", "name") & "</span></div></td>    <td><div align='left'><span id='estadosv1'>" & X6(App.Path & "\G.log", "Top8", "NivelReal") & "</span></td>  </tr>  <tr>" & _
"<td><span id='estadosv'>9º</span></td>    <td><div align='left'><span id='estadosv1'>" & X6(App.Path & "\G.log", "Top9", "name") & "</span></div></td>    <td><div align='left'><span id='estadosv1'>" & X6(App.Path & "\G.log", "Top9", "NivelReal") & "</span></td>  </tr>  <tr>    <td><span id='estadosv'>10º</span></td>    <td><div align='left'><span id='estadosv1'>" & X6(App.Path & "\G.log", "Top10", "name") & "</span></div></td>    <td><div align='left'><span id='estadosv1'>" & X6(App.Path & "\G.log", "Top10", "NivelReal") & "</span></td>  </tr></table>"
Open Ruta.Text & "topusers.html" For Append As #2
Print #2, cad
Close #2

Kill Ruta.Text & "topretos.html"
cad = "<head><meta http-equiv='Content-Type' content='text/html; charset=utf-8'><link href='stylestats.css' rel='stylesheet' type='text/css' /></head><table width='739' height='244' border='1' style='table-layout: fixed'>  <tr>  <td width='40'><div align='center'><span id='estadosv1x'>P</span></div></td>" & _
"<td width='550'><div align='center'><span id='estadosv1x'>NOMBRE DEL USUARIO </span></div></td>    <td><div align='center'><span id='estadosv1x'>RG</span></div></td>  </tr>  <tr>   <td><span id='estadosv'><IMG SRC='files/oro.png'></span></td>    <td width='509'><div align='center'><span id='estadosvx'>" & X6(App.Path & "\Logs\TopRetos.log", "Top1", "name") & "</span></div></td>    <td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRetos.log", "Top1", "retosganados") & "</span></div></td>  </tr>  <tr>   <td><span id='estadosv'><IMG SRC='files/plata.png'></span></td>    <td height='23'><div align='center'><span id='estadosvx'>" & X6(App.Path & "\Logs\TopRetos.log", "Top2", "name") & "</span></div></td>" & _
"<td><div align='center'><span id='estadosv1x '>" & X6(App.Path & "\Logs\TopRetos.log", "Top2", "retosganados") & "</span></div></td>  </tr>  <tr>   <td><span id='estadosv'><IMG SRC='files/bronce.png'></span></td>    <td><div align='center'><span id='estadosvx'>" & X6(App.Path & "\Logs\TopRetos.log", "Top3", "name") & "</span></div></td>    <td><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRetos.log", "Top3", "retosganados") & "</span></div></td>  </tr>  <tr>      <td><span id='estadosv'>4º</span></td>    <td height='21'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRetos.log", "Top4", "name") & "</span></div></td>" & _
"<td><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRetos.log", "Top4", "retosganados") & "</span></div></td>  </tr>  <tr>        <td><span id='estadosv'>5º</span></td>    <td height='21'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRetos.log", "Top5", "name") & "</span></div></td>    <td><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRetos.log", "Top5", "retosganados") & "</span></div></td>  </tr>  <tr>" & _
"<td><span id='estadosv'>6º</span></td>    <td height='21'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRetos.log", "Top6", "name") & "</span></div></td>    <td><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRetos.log", "Top6", "retosganados") & "</span></div></td>  </tr>  <tr>        <td><span id='estadosv'>7º</span></td>    <td height='21'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRetos.log", "Top7", "name") & "</span></div></td>    <td><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRetos.log", "Top7", "retosganados") & "</span></div></td>  </tr>  <tr>        <td><span id='estadosv'>8º</span></td>    <td height='21'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRetos.log", "Top8", "name") & "</span></div></td>" & _
"<td><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRetos.log", "Top8", "retosganados") & "</span></div></td>  </tr>  <tr>        <td><span id='estadosv'>9º</span></td>" & _
"<td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRetos.log", "Top9", "name") & " </span></div></td>    <td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRetos.log", "Top9", "retosganados") & "</span></div></td>  </tr>  <tr>        <td><span id='estadosv'>10º</span></td>    <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRetos.log", "Top10", "name") & "</span></div></td>    <td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRetos.log", "Top10", "retosganados") & "</span></div></td>  </tr>  <tr>        <td><span id='estadosv'>11º</span></td>    <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRetos.log", "Top11", "name") & "</span></div></td>    <td width='214'><div align='center'><span id='estadosv1x" & _
"'>" & X6(App.Path & "\Logs\TopRetos.log", "Top11", "retosganados") & "</span></div></td>  </tr>  <tr>" & _
"<td><span id='estadosv'>12º</span></td>    <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRetos.log", "Top12", "name") & "</span></div></td>    <td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRetos.log", "Top12", "retosganados") & "</span></div></td>  </tr>  <tr>        <td><span id='estadosv'>13º</span></td>    <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRetos.log", "Top13", "name") & "</span></div></td>    <td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRetos.log", "Top13", "retosganados") & "</span></div></td>  </tr>  <tr>        <td><span id='estadosv'>14º</span></td>    <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRetos.log", "Top14", "name") & "</span></div></td>" & _
"<td width='214'><div align='center '><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRetos.log", "Top14", "retosganados") & "</span></div></td>  </tr>  <tr>" & _
"<td><span id='estadosv'>15º</span></td>    <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRetos.log", "Top15", "name") & "</span></div></td>    <td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRetos.log", "Top15", "retosganados") & "</span></div></td>  </tr>  <tr>        <td><span id='estadosv'>16º</span></td>    <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRetos.log", "Top16", "name") & "</span></div></td>    <td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRetos.log", "Top16", "retosganados") & "</span></div></td>  </tr>  <tr>        <td><span id='estadosv'>17º</span></td>    <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRetos.log", "Top17", "name") & "</span></div></td>    <" & _
"td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRetos.log", "Top17", "retosganados") & "</span></div></td>  </tr>  <tr>" & _
"<td><span id='estadosv'>18º</span></td>    <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRetos.log", "Top18", "name") & "</span></div></td>    <td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRetos.log", "Top18", "retosganados") & "</span></div></td>  </tr>  <tr>        <td><span id='estadosv'>19º</span></td>    <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRetos.log", "Top19", "name") & "</span></div></td>    <td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRetos.log", "Top19", "retosganados") & "</span></div></td>  </tr>  <tr>        <td><span id='estadosv'>20º</span></td>" & _
"<td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRetos.log", "Top20", "name") & "</span></div></td>    <td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRetos.log", "Top20", "retosganados") & "</span></div></td>  </tr></table>"
Open Ruta.Text & "topretos.html" For Append As #2
Print #2, cad
Close #2

Kill Ruta.Text & "toptorneos.html"
cad = "<head><meta http-equiv='Content-Type' content='text/html; charset=utf-8'><link href='stylestats.css' rel='stylesheet' type='text/css' /></head><table width='739' height='244' border='1' style='table-layout: fixed'>  <tr>  <td width='40'><div align='center'><span id='estadosv1x'>P</span></div></td>    <td width='550'><div align='center'><span id='estadosv1x'>NOMBRE DEL USUARIO </span></div></td>    <td><div align='center'><span id='estadosv1x'>TORNEOS G</span></div></td>  </tr>  <tr>  <td><span id='estadosv'><IMG SRC='files/oro.png'></span></td>    <td width='509'><div align='center'><span id='estadosvx'>" & X6(App.Path & "\Logs\TopRanking.log", "Top1", "name") & "</span></div></td>    <td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRanking.log", "Top1", "canje") & "</span></div></td>  </tr>  <tr>  <td><span id='estadosv'><IMG SRC='files/plata.png'></span></td>" & _
"<td height='23'><div align='center'><span id='estadosvx'>" & X6(App.Path & "\Logs\TopRanking.log", "Top2", "name") & "</span></div></td>    <td><div align='center'><span id=" & _
"'estadosv1x'>" & X6(App.Path & "\Logs\TopRanking.log", "Top2", "canje") & "</span></div></td>  </tr>  <tr>  <td><span id='estadosv'><IMG SRC='files/bronce.png'></span></td>    <td><div align='center'><span id='estadosvx'>" & X6(App.Path & "\Logs\TopRanking.log", "Top3", "name") & "</span></div></td>    <td><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRanking.log", "Top3", "canje") & "</span></div></td>  </tr>  <tr>    <td><span id='estadosv'>4º</span></td>    <td height='21'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRanking.log", "Top4", "name") & "</span></div></td>    <td><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRanking.log", "Top4", "canje") & "</span></div></td>  </tr>  <tr>    <td><span id='estadosv'>5º</span></td>    <td height='21'>" & _
"<div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRanking.log", "Top5", "name") & "</span></div></td>    <td><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRanking.log", "Top5", "canje") & "</span></div></td>  </tr>  <tr>    <td><span id='estadosv'>6º</span></td>    <td height='21'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRanking.log", "Top6", "name") & "</span></div></td>    <td><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRanking.log", "Top6", "canje") & "</span></div></td>  </tr>  <tr>    <td><span id='estadosv'>7º</span></td>    <td height='21'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRanking.log", "Top7", "name") & "</span></div></td>    <td><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRanking.log", "Top7", "canje") & "</span></div></td>  </tr>  <tr>    <td><span id='estadosv'>8º</span></td>    <td height='21'><div align='center'>" & _
"<span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRanking.log", "Top8", "name") & "</span></div></td>    <td><div align='center'>" & _
"<span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRanking.log", "Top8", "canje") & "</span></div></td>  </tr>  <tr>    <td><span id='estadosv'>9º</span></td>    <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRanking.log", "Top9", "name") & "</span></div></td>    <td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRanking.log", "Top9", "canje") & "</span></div></td>  </tr>  <tr>    <td><span id='estadosv'>10º</span></td>    <td width='509'><div align='center'>" & _
"<span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRanking.log", "Top10", "name") & "</span></div></td>    <td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRanking.log", "Top10", "canje") & "</span></div></td>  </tr>  <tr>    <td><span id='estadosv'>11º</span></td>    <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRanking.log", "Top11", "name") & "</span>" & _
"</div></td>    <td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRanking.log", "Top11", "canje") & "</span></div></td>  </tr>  <tr>    <td><span id='estadosv'>12º</span></td>    <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRanking.log", "Top12", "name") & "</span></div></td>    <td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRanking.log", "Top12", "canje") & "</span></div></td>  </tr>  <tr>    <td><span id='estadosv'>13º</span></td>    <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRanking.log", "Top13", "name") & "</span></div></td>    <td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRanking.log", "Top13", "canje") & "</span></div></td>  </tr>  <tr>    <td><span id='estadosv'>14º</span></td>" & _
"<td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRanking.log", "Top14", "name") & "</span></div></td>    <td width='214'>" & _
"<div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRanking.log", "Top14", "canje") & "</span></div></td>  </tr>  <tr>    <td><span id='estadosv'>15º</span></td>" & _
"<td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRanking.log", "Top15", "name") & "</span></div></td>    <td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRanking.log", "Top15", "canje") & "</span></div></td>  </tr>  <tr>  <td><span id='estadosv'>16º</span></td>    <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRanking.log", "Top16", "name") & "</span></div></td>    <td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRanking.log", "Top16", "canje") & "</span></div></td>  </tr>  <tr>    <td><span id='estadosv'>17º</span></td>    <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRanking.log", "Top17", "name") & "</span></div></td>    <td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRanking.log", "Top17", "canje") & "</span></div></td>  </tr>  <tr>" & _
"<td><span id='estadosv'>18º</span></td>    <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRanking.log", "Top18", "name") & "</span></div></td>    <td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRanking.log", "Top18", "canje") & "</span></div></td>  </tr>  <tr>    <td><span id='estadosv'>19º</span></td>    <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRanking.log", "Top19", "name") & "</span></div></td>    <td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRanking.log", "Top19", "canje") & "</span></div></td>  </tr>  <tr>    <td><span id='estadosv'>20º</span></td>    <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRanking.log", "Top20", "name") & "</span></div></td>    <td width='214'><div align='center'>" & _
"<span id='estadosv1x'>" & X6(App.Path & "\Logs\TopRanking.log", "Top20", "canje") & "</span></div></td>  </tr></table>"
Open Ruta.Text & "toptorneos.html" For Append As #2
Print #2, cad
Close #2

Kill Ruta.Text & "topfrags.html"
cad = "<head><meta http-equiv='Content-Type' content='text/html; charset=utf-8'><link href='stylestats.css' rel='stylesheet' type='text/css' />" & _
"</head><table width='739' height='244' border='1' style='table-layout: fixed'>  <tr>  <td width='40'><div align='center'><span id='estadosv1x'>P</span></div></td>    <td width='550'><div align='center'><span id='estadosv1x'>NOMBRE DEL USUARIO </span></div></td>    <td><div align='center'><span id='estadosv1x'>MATADOS</span></div></td>  </tr>  <tr>    <td><span id='estadosv'><IMG SRC='files/oro.png'></span></td>    <td width='509'><div align='center'><span id='estadosvx'>" & X6(App.Path & "\Logs\TopMatados.log", "Top1", "name") & "</span></div></td>    <td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopMatados.log", "Top1", "muertos") & "</span></div></td>  </tr>  <tr>    <td><span id='estadosv'><IMG SRC='files/plata.png'></span></td>    <td height='23'><div align='center'><span id='estadosvx'>" & X6(App.Path & "\Logs\TopMatados.log", "Top2", "name") & "</span></div></td>" & _
"<td><div align='center'><span" & _
"id='estadosv1x'>" & X6(App.Path & "\Logs\TopMatados.log", "Top2", "muertos") & "</span></div></td>  </tr>  <tr>    <td><span id='estadosv'><IMG SRC='files/bronce.png'></span></td>    <td><div align='center'><span id='estadosvx'>" & X6(App.Path & "\Logs\TopMatados.log", "Top3", "name") & "</span></div></td>    <td><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopMatados.log", "Top3", "muertos") & "</span></div></td>  </tr>  <tr>      <td><span id='estadosv'>4º</span></td>    <td height='21'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopMatados.log", "Top4", "name") & "</span></div></td>    <td><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopMatados.log", "Top4", "muertos") & "</span></div></td>  </tr>  <tr>        <td><span id='estadosv'>5º</span></td>    <td height='21'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopMatados.log", "Top5", "name") & "</span></div></td>    <td><div align='center'><span id='estadosv1" & _
"x'>" & X6(App.Path & "\Logs\TopMatados.log", "Top5", "muertos") & "</span></div></td>  </tr> " & _
"<tr>        <td><span id='estadosv'>6º</span></td>    <td height='21'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopMatados.log", "Top6", "name") & "</span></div></td>    <td><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopMatados.log", "Top6", "muertos") & "</span></div></td>  </tr>  <tr>        <td><span id='estadosv'>7º</span></td>    <td height='21'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopMatados.log", "Top7", "name") & "</span></div></td>    <td><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopMatados.log", "Top7", "muertos") & "</span></div></td>  </tr>  <tr>        <td><span id='estadosv'>8º</span></td>    <td height='21'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopMatados.log", "Top8", "name") & "</span></div></td>" & _
"<td><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopMatados.log", "Top8", "muertos") & "</span></div></td>" & _
"</tr>  <tr>        <td><span id='estadosv'>9º</span></td>    <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopMatados.log", "Top9", "name") & "</span></div></td>    <td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopMatados.log", "Top9", "muertos") & "</span></div></td>  </tr>  <tr>        <td><span id='estadosv'>10º</span></td>    <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopMatados.log", "Top10", "name") & "</span></div></td>    <td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopMatados.log", "Top10", "muertos") & "</span></div></td>  </tr>  <tr>        <td><span id='estadosv'>11º</span></td>    <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopMatados.log", "Top11", "name") & "</span></div></td>    <td width='214'><div align='center'><span id='estadosv1x" & _
"'>" & X6(App.Path & "\Logs\TopMatados.log", "Top11", "muertos") & "</span></div></td> " & _
"</tr>  <tr>        <td><span id='estadosv'>12º</span></td>    <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopMatados.log", "Top12", "name") & "</span></div></td>    <td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopMatados.log", "Top12", "muertos") & "</span></div></td>  </tr>  <tr>        <td><span id='estadosv'>13º</span></td>    <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopMatados.log", "Top13", "name") & "</span></div></td>    <td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopMatados.log", "Top13", "muertos") & "</span></div></td>  </tr>  <tr>        <td><span id='estadosv'>14º</span></td>    <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopMatados.log", "Top14", "name") & "</span></div></td>    <td width='214'><div align='cent" & _
"er'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopMatados.log", "Top14", "muertos") & "</span></div>" & _
"</td>  </tr>  <tr>        <td><span id='estadosv'>15º</span></td>    <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopMatados.log", "Top15", "name") & "</span></div></td>    <td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopMatados.log", "Top15", "muertos") & "</span></div></td>  </tr>  <tr>        <td><span id='estadosv'>16º</span></td>    <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopMatados.log", "Top16", "name") & "</span></div></td>    <td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopMatados.log", "Top16", "muertos") & "</span></div></td>  </tr>  <tr>        <td><span id='estadosv'>17º</span></td>    <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopMatados.log", "Top17", "name") & "</span></div></td>    <td wid" & _
"h='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopMatados.log", "Top17", "muertos") & "</span></div></td>  </tr>  <tr>        <td><span id='estadosv'>18º</span></td>    <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopMatados.log", "Top18", "name") & "</span></div></td>    <td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopMatados.log", "Top18", "muertos") & "</span></div></td>  </tr>  <tr>        <td><span id='estadosv'>19º</span></td>    <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopMatados.log", "Top19", "name") & "</span></div></td>    <td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopMatados.log", "Top19", "muertos") & "</span></div></td>  </tr>  <tr>        <td><span id='estadosv'>20º</span></td>    <td width='509'><div align='center'>" & _
"<span id='estadosv1x'>" & X6(App.Path & "\Logs\TopMatados.log", "Top20", "name") & "</span" & _
"></div></td>    <td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\Logs\TopMatados.log", "Top20", "muertos") & "</span></div></td>  </tr></table>"
Open Ruta.Text & "topfrags.html" For Append As #2
Print #2, cad
Close #2

Dim XD As String
XD = "<tr> <td><span id='estadosv'>"

Kill Ruta.Text & "topgeneral1.html"
cad = "<head><meta http-equiv='Content-Type' content='text/html; charset=utf-8'><link href='stylestats.css' rel='stylesheet' type='text/css' /></head><table width='739' height='244' border='1' style='table-layout: fixed'><tr><td width='40'><div align='center'><span id='estadosv1x'>P</span></div></td><td width='550'><div align='center'><span id='estadosv1x'>NOMBRE DEL USUARIO </span></div></td>" & _
"<td><div align='center'><span id='estadosv1x'>REPUTACIÓN</span></div></td></tr>" & XD & "<IMG SRC='files/oro.png'></span></td> <td width='509'><div align='center'><span id='estadosv'>" & X6(App.Path & "\G.log", "Top1", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv'>" & X6(App.Path & "\G.log", "Top1", "RE") & "</span></div></td> </tr>" & XD & "<IMG SRC='files/plata.png'></span></td> <td width='509'><div align='center'><span id='estadosv'>" & X6(App.Path & "\G.log", "Top2", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv'>" & X6(App.Path & "\G.log", "Top2", "RE") & "</span></div></td> </tr>" & XD & "<IMG SRC='files/bronce.png'></span></td> <td width='509'><div align='center'><span id='estadosv'>" & X6(App.Path & "\G.log", "Top3", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv'>" & X6(App.Path & "\G.log", "Top3", "RE") & "</span></div></td> </tr>" & _
XD & "4</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top4", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top4", "RE") & "</span></div></td> </tr>" & _
XD & "5</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top5", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top5", "RE") & "</span></div></td> </tr>" & XD & "6</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top6", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top6", "RE") & "</span></div></td> </tr>" & XD & "7</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top7", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top7", "RE") & "</span></div></td> </tr>" & _
XD & "8</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top8", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top8", "RE") & "</span></div></td> </tr>" & XD & "9</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top9", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top9", "RE") & "</span></div></td> </tr>" & XD & "10</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top10", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top10", "RE") & "</span></div></td> </tr>" & _
XD & "11</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top11", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top11", "RE") & "</span></div></td> </tr>" & XD & "12</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top12", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top12", "RE") & "</span></div></td> </tr>" & XD & "13</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top13", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top13", "RE") & "</span></div></td> </tr>" & _
XD & "14</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top14", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top14", "RE") & "</span></div></td> </tr>" & XD & "15</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top15", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top15", "RE") & "</span></div></td> </tr>" & XD & "19</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top19", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top19", "RE") & "</span></div></td> </tr>" & _
XD & "16</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top16", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top16", "RE") & "</span></div></td> </tr>" & XD & "17</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top17", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top17", "RE") & "</span></div></td> </tr>" & XD & "18</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top18", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top18", "RE") & "</span></div></td> </tr>" & _
XD & "20</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top20", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top20", "RE") & "</span></div></td> </tr>" & XD & "21</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top21", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top21", "RE") & "</span></div></td> </tr>" & XD & "22</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top22", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top22", "RE") & "</span></div></td> </tr>" & _
XD & "23</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top23", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top23", "RE") & "</span></div></td> </tr>" & XD & "24</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top24", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top24", "RE") & "</span></div></td> </tr>" & XD & "25</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top25", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top25", "RE") & "</span></div></td> </tr>" & _
XD & "26</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top26", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top26", "RE") & "</span></div></td> </tr>" & XD & "27</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top27", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top27", "RE") & "</span></div></td> </tr>" & XD & "28</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top28", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top28", "RE") & "</span></div></td> </tr>" & _
XD & "29</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top29", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top29", "RE") & "</span></div></td> </tr>" & XD & "30</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top30", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top30", "RE") & "</span></div></td> </tr>" & XD & "31</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top31", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top31", "RE") & "</span></div></td> </tr>" & _
XD & "32</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top32", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top32", "RE") & "</span></div></td> </tr>" & XD & "33</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top33", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top33", "RE") & "</span></div></td> </tr>" & _
 XD & "34</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top34", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top34", "RE") & "</span></div></td> </tr>" & XD & "35</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top35", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top35", "RE") & "</span></div></td> </tr>" & XD & "36</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top36", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top36", "RE") & "</span></div></td> </tr>" & _
 XD & "37</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top37", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top37", "RE") & "</span></div></td> </tr>" & XD & "38</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top38", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top38", "RE") & "</span></div></td> </tr>" & XD & "39</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top39", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top39", "RE") & "</span></div></td> </tr>" & _
 XD & "40</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top40", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top40", "RE") & "</span></div></td> </tr>" & XD & "41</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top41", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top41", "RE") & "</span></div></td> </tr>" & _
 XD & "42</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top42", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top42", "RE") & "</span></div></td> </tr>" & XD & "43</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top43", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top43", "RE") & "</span></div></td> </tr>" & XD & "44</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top44", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top44", "RE") & "</span></div></td> </tr>" & _
 XD & "45</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top45", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top45", "RE") & "</span></div></td> </tr>" & XD & "46</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top46", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top46", "RE") & "</span></div></td> </tr>" & _
 XD & "47</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top47", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top47", "RE") & "</span></div></td> </tr>" & XD & "48</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top48", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top48", "RE") & "</span></div></td> </tr>" & XD & "49</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top49", "Name") & "</span></div></td><td width='214'><div align='center'> " & _
 "<span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top49", "RE") & "</span></div></td> </tr>" & XD & "50</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top50", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top50", "RE") & "</span></div></td> </tr></table>"



Open Ruta.Text & "topgeneral1.html" For Append As #2
Print #2, cad
Close #2

Kill Ruta.Text & "topgeneral2.html"
cad = "<head><meta http-equiv='Content-Type' content='text/html; charset=utf-8'><link href='stylestats.css' rel='stylesheet' type='text/css' /></head><table width='739' height='244' border='1' style='table-layout: fixed'><tr><td width='40'><div align='center'><span id='estadosv1x'>P</span></div></td><td width='550'><div align='center'><span id='estadosv1x'>NOMBRE DEL USUARIO </span></div></td><td><div align='center'><span id='estadosv1x'>REPUTACIÓN</span></div></td></tr> " & _
XD & "51</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top51", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top51", "RE") & "</span></div></td> </tr> " & XD & "52</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top52", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top52", "RE") & "</span></div></td> </tr> " & XD & "53</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top53", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top53", "RE") & "</span></div></td> </tr> " & _
XD & "54</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top54", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top54", "RE") & "</span></div></td> </tr> " & XD & "55</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top55", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top55", "RE") & "</span></div></td> </tr> " & XD & "56</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top56", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top56", "RE") & "</span></div></td> </tr> " & _
XD & "57</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top57", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top57", "RE") & "</span></div></td> </tr> " & XD & "58</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top58", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top58", "RE") & "</span></div></td> </tr> " & XD & "59</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top59", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top59", "RE") & "</span></div></td> </tr> " & _
XD & "60</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top60", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top60", "RE") & "</span></div></td> </tr> " & XD & "61</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top61", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top61", "RE") & "</span></div></td> </tr> " & XD & "62</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top62", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top62", "RE") & "</span></div></td> </tr> " & _
XD & "63</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top63", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top63", "RE") & "</span></div></td> </tr> " & XD & "64</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top64", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top64", "RE") & "</span></div></td> </tr> " & XD & "65</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top65", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top65", "RE") & "</span></div></td> </tr> " & _
XD & "66</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top66", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top66", "RE") & "</span></div></td> </tr> " & XD & "67</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top67", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top67", "RE") & "</span></div></td> </tr> " & XD & "68</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top68", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top68", "RE") & "</span></div></td> </tr> " & _
XD & "69</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top69", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top69", "RE") & "</span></div></td> </tr> " & XD & "70</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top70", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top70", "RE") & "</span></div></td> </tr> " & XD & "71</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top71", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top71", "RE") & "</span></div></td> </tr> " & _
XD & "72</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top72", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top72", "RE") & "</span></div></td> </tr> " & XD & "73</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top73", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top73", "RE") & "</span></div></td> </tr> " & XD & "74</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top74", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top74", "RE") & "</span></div></td> </tr> " & _
XD & "75</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top75", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top75", "RE") & "</span></div></td> </tr> " & XD & "76</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top76", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top76", "RE") & "</span></div></td> </tr> " & XD & "77</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top77", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top77", "RE") & "</span></div></td> </tr> " & _
XD & "78</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top78", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top78", "RE") & "</span></div></td> </tr> " & XD & "79</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top79", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top79", "RE") & "</span></div></td> </tr> " & XD & "80</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top80", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top80", "RE") & "</span></div></td> </tr> " & _
XD & "81</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top81", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top81", "RE") & "</span></div></td> </tr> " & XD & "82</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top82", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top82", "RE") & "</span></div></td> </tr> " & _
XD & "83</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top83", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top83", "RE") & "</span></div></td> </tr> " & XD & "84</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top84", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top84", "RE") & "</span></div></td> </tr> " & XD & "85</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top85", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top85", "RE") & "</span></div></td> </tr> " & _
XD & "86</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top86", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top86", "RE") & "</span></div></td> </tr> " & XD & "87</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top87", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top87", "RE") & "</span></div></td> </tr> " & XD & "88</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top88", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top88", "RE") & "</span></div></td> </tr> " & _
XD & "89</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top89", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top89", "RE") & "</span></div></td> </tr> " & XD & "90</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top90", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top90", "RE") & "</span></div></td> </tr> " & XD & "91</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top91", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top91", "RE") & "</span></div></td> </tr> " & _
XD & "92</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top92", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top92", "RE") & "</span></div></td> </tr> " & XD & "93</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top93", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top93", "RE") & "</span></div></td> </tr> " & XD & "94</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top94", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top94", "RE") & "</span></div></td> </tr> " & _
XD & "95</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top95", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top95", "RE") & "</span></div></td> </tr> " & XD & "96</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top96", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top96", "RE") & "</span></div></td> </tr> " & XD & "97</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top97", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top97", "RE") & "</span></div></td> </tr> " & _
XD & "98</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top98", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top98", "RE") & "</span></div></td> </tr> " & XD & "99</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top99", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top99", "RE") & "</span></div></td> </tr> " & XD & "100</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top100", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top100", "RE") & "</span></div></td> </tr></table>"


Open Ruta.Text & "topgeneral2.html" For Append As #2
Print #2, cad
Close #2

Kill Ruta.Text & "topgeneral3.html"
cad = "<head><meta http-equiv='Content-Type' content='text/html; charset=utf-8'><link href='stylestats.css' rel='stylesheet' type='text/css' /></head><table width='739' height='244' border='1' style='table-layout: fixed'><tr><td width='40'><div align='center'><span id='estadosv1x'>P</span></div></td><td width='550'><div align='center'><span id='estadosv1x'>NOMBRE DEL USUARIO </span></div></td><td><div align='center'><span id='estadosv1x'>REPUTACIÓN</span></div></td></tr>" & _
XD & "101</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top101", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top101", "RE") & "</span></div></td> </tr> " & XD & "102</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top102", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top102", "RE") & "</span></div></td> </tr> " & _
XD & "103</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top103", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top103", "RE") & "</span></div></td> </tr> " & XD & "104</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top104", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top104", "RE") & "</span></div></td> </tr> " & XD & "105</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top105", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top105", "RE") & "</span></div></td> </tr> " & _
XD & "106</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top106", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top106", "RE") & "</span></div></td> </tr> " & XD & "107</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top107", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top107", "RE") & "</span></div></td> </tr> " & XD & "108</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top108", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top108", "RE") & "</span></div></td> </tr> " & _
XD & "109</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top109", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top109", "RE") & "</span></div></td> </tr> " & XD & "110</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top110", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top110", "RE") & "</span></div></td> </tr> " & XD & "111</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top111", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top111", "RE") & "</span></div></td> </tr> " & _
XD & "112</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top112", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top112", "RE") & "</span></div></td> </tr> " & XD & "113</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top113", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top113", "RE") & "</span></div></td> </tr> " & XD & "114</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top114", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top114", "RE") & "</span></div></td> </tr> " & _
XD & "115</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top115", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top115", "RE") & "</span></div></td> </tr> " & XD & "116</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top116", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top116", "RE") & "</span></div></td> </tr> " & XD & "117</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top117", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top117", "RE") & "</span></div></td> </tr> " & _
XD & "118</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top118", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top118", "RE") & "</span></div></td> </tr> " & XD & "119</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top119", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top119", "RE") & "</span></div></td> </tr> " & XD & "120</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top120", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top120", "RE") & "</span></div></td> </tr> " & _
XD & "121</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top121", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top121", "RE") & "</span></div></td> </tr> " & XD & "122</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top122", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top122", "RE") & "</span></div></td> </tr> " & XD & "123</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top123", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top123", "RE") & "</span></div></td> </tr> " & _
XD & "124</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top124", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top124", "RE") & "</span></div></td> </tr> " & XD & "125</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top125", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top125", "RE") & "</span></div></td> </tr> " & XD & "126</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top126", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top126", "RE") & "</span></div></td> </tr> " & _
XD & "127</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top127", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top127", "RE") & "</span></div></td> </tr> " & XD & "128</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top128", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top128", "RE") & "</span></div></td> </tr> " & XD & "129</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top129", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top129", "RE") & "</span></div></td> </tr> " & _
XD & "130</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top130", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top130", "RE") & "</span></div></td> </tr> " & XD & "131</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top131", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top131", "RE") & "</span></div></td> </tr> " & XD & "132</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top132", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top132", "RE") & "</span></div></td> </tr> " & _
XD & "133</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top133", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top133", "RE") & "</span></div></td> </tr> " & XD & "134</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top134", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top134", "RE") & "</span></div></td> </tr> " & XD & "135</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top135", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top135", "RE") & "</span></div></td> </tr> " & _
XD & "136</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top136", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top136", "RE") & "</span></div></td> </tr> " & XD & "137</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top137", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top137", "RE") & "</span></div></td> </tr> " & XD & "138</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top138", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top138", "RE") & "</span></div></td> </tr> " & _
XD & "139</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top139", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top139", "RE") & "</span></div></td> </tr> " & XD & "140</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top140", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top140", "RE") & "</span></div></td> </tr> " & XD & "141</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top141", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top141", "RE") & "</span></div></td> </tr> " & _
XD & "142</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top142", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top142", "RE") & "</span></div></td> </tr> " & XD & "143</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top143", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top143", "RE") & "</span></div></td> </tr> " & XD & "144</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top144", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top144", "RE") & "</span></div></td> </tr> " & _
XD & "145</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top145", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top145", "RE") & "</span></div></td> </tr> " & XD & "146</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top146", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top146", "RE") & "</span></div></td> </tr> " & XD & "147</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top147", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top147", "RE") & "</span></div></td> </tr> " & _
XD & "148</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top148", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top148", "RE") & "</span></div></td> </tr> " & XD & "149</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top149", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top149", "RE") & "</span></div></td> </tr> " & XD & "150</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top150", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top150", "RE") & "</span></div></td> </tr></table>"


Open Ruta.Text & "topgeneral3.html" For Append As #2
Print #2, cad
Close #2

Kill Ruta.Text & "topgeneral4.html"

cad = "<head><meta http-equiv='Content-Type' content='text/html; charset=utf-8'><link href='stylestats.css' rel='stylesheet' type='text/css' /></head><table width='739' height='244' border='1' style='table-layout: fixed'><tr><td width='40'><div align='center'><span id='estadosv1x'>P</span></div></td><td width='550'><div align='center'><span id='estadosv1x'>NOMBRE DEL USUARIO </span></div></td><td><div align='center'><span id='estadosv1x'>REPUTACIÓN</span></div></td></tr>" & _
XD & "151</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top151", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top151", "RE") & "</span></div></td> </tr> " & XD & "152</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top152", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top152", "RE") & "</span></div></td> </tr> " & _
XD & "153</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top153", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top153", "RE") & "</span></div></td> </tr> " & XD & "154</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top154", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top154", "RE") & "</span></div></td> </tr> " & XD & "155</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top155", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top155", "RE") & "</span></div></td> </tr> " & _
XD & "156</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top156", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top156", "RE") & "</span></div></td> </tr> " & XD & "157</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top157", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top157", "RE") & "</span></div></td> </tr> " & XD & "158</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top158", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top158", "RE") & "</span></div></td> </tr> " & _
XD & "159</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top159", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top159", "RE") & "</span></div></td> </tr> " & XD & "160</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top160", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top160", "RE") & "</span></div></td> </tr> " & XD & "161</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top161", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top161", "RE") & "</span></div></td> </tr> " & _
XD & "162</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top162", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top162", "RE") & "</span></div></td> </tr> " & XD & "163</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top163", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top163", "RE") & "</span></div></td> </tr> " & XD & "164</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top164", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top164", "RE") & "</span></div></td> </tr> " & _
XD & "165</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top165", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top165", "RE") & "</span></div></td> </tr> " & XD & "166</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top166", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top166", "RE") & "</span></div></td> </tr> " & XD & "167</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top167", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top167", "RE") & "</span></div></td> </tr> " & _
XD & "168</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top168", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top168", "RE") & "</span></div></td> </tr> " & XD & "169</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top169", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top169", "RE") & "</span></div></td> </tr> " & XD & "170</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top170", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top170", "RE") & "</span></div></td> </tr> " & _
XD & "171</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top171", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top171", "RE") & "</span></div></td> </tr> " & XD & "172</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top172", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top172", "RE") & "</span></div></td> </tr> " & XD & "173</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top173", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top173", "RE") & "</span></div></td> </tr> " & _
XD & "174</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top174", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top174", "RE") & "</span></div></td> </tr> " & XD & "175</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top175", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top175", "RE") & "</span></div></td> </tr> " & XD & "176</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top176", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top176", "RE") & "</span></div></td> </tr> " & _
XD & "177</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top177", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top177", "RE") & "</span></div></td> </tr> " & XD & "178</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top178", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top178", "RE") & "</span></div></td> </tr> " & XD & "179</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top179", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top179", "RE") & "</span></div></td> </tr> " & _
XD & "180</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top180", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top180", "RE") & "</span></div></td> </tr> " & XD & "181</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top181", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top181", "RE") & "</span></div></td> </tr> " & XD & "182</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top182", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top182", "RE") & "</span></div></td> </tr> " & _
XD & "183</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top183", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top183", "RE") & "</span></div></td> </tr> " & XD & "184</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top184", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top184", "RE") & "</span></div></td> </tr> " & XD & "185</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top185", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top185", "RE") & "</span></div></td> </tr> " & _
XD & "186</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top186", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top186", "RE") & "</span></div></td> </tr> " & XD & "187</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top187", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top187", "RE") & "</span></div></td> </tr> " & XD & "188</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top188", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top188", "RE") & "</span></div></td> </tr> " & _
XD & "189</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top189", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top189", "RE") & "</span></div></td> </tr> " & XD & "190</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top190", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top190", "RE") & "</span></div></td> </tr> " & XD & "191</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top191", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top191", "RE") & "</span></div></td> </tr> " & _
XD & "192</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top192", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top192", "RE") & "</span></div></td> </tr> " & XD & "193</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top193", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top193", "RE") & "</span></div></td> </tr> " & XD & "194</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top194", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top194", "RE") & "</span></div></td> </tr> " & _
XD & "195</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top195", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top195", "RE") & "</span></div></td> </tr> " & XD & "196</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top196", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top196", "RE") & "</span></div></td> </tr> " & XD & "197</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top197", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top197", "RE") & "</span></div></td> </tr> " & _
XD & "198</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top198", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top198", "RE") & "</span></div></td> </tr> " & XD & "199</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top199", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top199", "RE") & "</span></div></td> </tr> " & XD & "200</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top200", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top200", "RE") & "</span></div></td> </tr></table>"


Open Ruta.Text & "topgeneral4.html" For Append As #2
Print #2, cad
Close #2

Kill Ruta.Text & "topgeneral5.html"
cad = "<head><meta http-equiv='Content-Type' content='text/html; charset=utf-8'><link href='stylestats.css' rel='stylesheet' type='text/css' /></head><table width='739' height='244' border='1' style='table-layout: fixed'><tr><td width='40'><div align='center'><span id='estadosv1x'>P</span></div></td><td width='550'><div align='center'><span id='estadosv1x'>NOMBRE DEL USUARIO </span></div></td><td><div align='center'><span id='estadosv1x'>REPUTACIÓN</span></div></td></tr> " & _
XD & "201</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top201", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top201", "RE") & "</span></div></td> </tr> " & XD & "202</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top202", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top202", "RE") & "</span></div></td> </tr> " & _
XD & "203</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top203", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top203", "RE") & "</span></div></td> </tr> " & XD & "204</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top204", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top204", "RE") & "</span></div></td> </tr> " & XD & "205</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top205", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top205", "RE") & "</span></div></td> </tr> " & _
XD & "206</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top206", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top206", "RE") & "</span></div></td> </tr> " & XD & "207</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top207", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top207", "RE") & "</span></div></td> </tr> " & XD & "208</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top208", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top208", "RE") & "</span></div></td> </tr> " & _
XD & "209</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top209", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top209", "RE") & "</span></div></td> </tr> " & XD & "210</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top210", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top210", "RE") & "</span></div></td> </tr> " & XD & "211</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top211", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top211", "RE") & "</span></div></td> </tr> " & _
XD & "212</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top212", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top212", "RE") & "</span></div></td> </tr> " & XD & "213</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top213", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top213", "RE") & "</span></div></td> </tr> " & XD & "214</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top214", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top214", "RE") & "</span></div></td> </tr> " & _
XD & "215</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top215", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top215", "RE") & "</span></div></td> </tr> " & XD & "216</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top216", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top216", "RE") & "</span></div></td> </tr> " & XD & "217</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top217", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top217", "RE") & "</span></div></td> </tr> " & _
XD & "218</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top218", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top218", "RE") & "</span></div></td> </tr> " & XD & "219</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top219", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top219", "RE") & "</span></div></td> </tr> " & XD & "220</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top220", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top220", "RE") & "</span></div></td> </tr> " & _
XD & "221</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top221", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top221", "RE") & "</span></div></td> </tr> " & XD & "222</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top222", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top222", "RE") & "</span></div></td> </tr> " & XD & "223</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top223", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top223", "RE") & "</span></div></td> </tr> " & _
XD & "224</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top224", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top224", "RE") & "</span></div></td> </tr> " & XD & "225</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top225", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top225", "RE") & "</span></div></td> </tr> " & XD & "226</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top226", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top226", "RE") & "</span></div></td> </tr> " & _
XD & "227</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top227", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top227", "RE") & "</span></div></td> </tr> " & XD & "228</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top228", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top228", "RE") & "</span></div></td> </tr> " & XD & "229</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top229", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top229", "RE") & "</span></div></td> </tr> " & _
XD & "230</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top230", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top230", "RE") & "</span></div></td> </tr> " & XD & "231</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top231", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top231", "RE") & "</span></div></td> </tr> " & XD & "232</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top232", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top232", "RE") & "</span></div></td> </tr> " & _
XD & "233</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top233", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top233", "RE") & "</span></div></td> </tr> " & XD & "234</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top234", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top234", "RE") & "</span></div></td> </tr> " & XD & "235</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top235", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top235", "RE") & "</span></div></td> </tr> " & _
XD & "236</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top236", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top236", "RE") & "</span></div></td> </tr> " & XD & "237</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top237", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top237", "RE") & "</span></div></td> </tr> " & XD & "238</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top238", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top238", "RE") & "</span></div></td> </tr> " & _
XD & "239</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top239", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top239", "RE") & "</span></div></td> </tr> " & XD & "240</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top240", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top240", "RE") & "</span></div></td> </tr> " & XD & "241</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top241", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top241", "RE") & "</span></div></td> </tr> " & _
XD & "242</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top242", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top242", "RE") & "</span></div></td> </tr> " & XD & "243</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top243", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top243", "RE") & "</span></div></td> </tr> " & XD & "244</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top244", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top244", "RE") & "</span></div></td> </tr> " & _
XD & "245</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top245", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top245", "RE") & "</span></div></td> </tr> " & XD & "246</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top246", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top246", "RE") & "</span></div></td> </tr> " & XD & "247</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top247", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top247", "RE") & "</span></div></td> </tr> " & _
XD & "248</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top248", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top248", "RE") & "</span></div></td> </tr> " & XD & "249</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top249", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top249", "RE") & "</span></div></td> </tr> " & XD & "250</span></td> <td width='509'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top250", "Name") & "</span></div></td><td width='214'><div align='center'><span id='estadosv1x'>" & X6(App.Path & "\G.log", "Top250", "RE") & "</span></div></td> </tr></table>"



Open Ruta.Text & "topgeneral5.html" For Append As #2
Print #2, cad
Close #2




End Sub

Private Sub Form_Load()
BuscarChars
End Sub

Private Sub Label3_Click()
If Timer1.Enabled = False Then
Label3.Caption = "Detector server.exe: ACTIVADO"
Timer1.Enabled = True
ElseIf Timer1.Enabled = True Then
Label3.Caption = "Detector server.exe: DESACTIVADO"
Timer1.Enabled = False
End If
End Sub

Private Sub Timer1_Timer()
Shell "server.exe"
End Sub

