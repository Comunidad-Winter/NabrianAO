VERSION 5.00
Object = "{3B7C8863-D78F-101B-B9B5-04021C009402}#1.2#0"; "richtx32.ocx"
Begin VB.Form frmComerciarUsu 
   BackColor       =   &H00000000&
   BorderStyle     =   0  'None
   ClientHeight    =   7920
   ClientLeft      =   0
   ClientTop       =   0
   ClientWidth     =   6780
   ControlBox      =   0   'False
   LinkTopic       =   "Form1"
   MaxButton       =   0   'False
   MinButton       =   0   'False
   ScaleHeight     =   528
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   452
   ShowInTaskbar   =   0   'False
   StartUpPosition =   2  'CenterScreen
   Begin VB.TextBox Text1 
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9.75
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      Height          =   285
      Left            =   120
      TabIndex        =   13
      Top             =   7560
      Width           =   3975
   End
   Begin VB.ListBox List5 
      Appearance      =   0  'Flat
      BackColor       =   &H00000000&
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H0080FFFF&
      Height          =   1080
      ItemData        =   "frmComerciarUsu.frx":0000
      Left            =   3420
      List            =   "frmComerciarUsu.frx":0002
      TabIndex        =   8
      Top             =   3885
      Width           =   540
   End
   Begin VB.ListBox List4 
      Appearance      =   0  'Flat
      BackColor       =   &H00000000&
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H0080FF80&
      Height          =   1500
      Left            =   3420
      TabIndex        =   7
      Top             =   1725
      Width           =   540
   End
   Begin VB.ListBox List3 
      Appearance      =   0  'Flat
      BackColor       =   &H00000000&
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   9
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   2955
      Left            =   315
      TabIndex        =   6
      Top             =   1110
      Width           =   2580
   End
   Begin VB.TextBox txtCant 
      Appearance      =   0  'Flat
      BackColor       =   &H00000000&
      BorderStyle     =   0  'None
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   11.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFFFF&
      Height          =   285
      Left            =   1560
      TabIndex        =   4
      Text            =   "0"
      Top             =   4245
      Width           =   1095
   End
   Begin VB.ListBox List2 
      Appearance      =   0  'Flat
      BackColor       =   &H00000000&
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H0080FFFF&
      Height          =   1080
      Left            =   3960
      TabIndex        =   3
      Top             =   3885
      Width           =   2535
   End
   Begin VB.ListBox List1 
      Appearance      =   0  'Flat
      BackColor       =   &H00000000&
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H0080FF80&
      Height          =   1500
      Left            =   3960
      TabIndex        =   2
      Top             =   1725
      Width           =   2535
   End
   Begin VB.PictureBox Picture1 
      Appearance      =   0  'Flat
      BackColor       =   &H00000000&
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   11.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H80000008&
      Height          =   540
      Left            =   2355
      ScaleHeight     =   510
      ScaleWidth      =   510
      TabIndex        =   0
      Top             =   165
      Width           =   540
   End
   Begin RichTextLib.RichTextBox ChatComer 
      Height          =   1365
      Left            =   120
      TabIndex        =   12
      TabStop         =   0   'False
      Top             =   6120
      Width           =   6585
      _ExtentX        =   11615
      _ExtentY        =   2408
      _Version        =   393217
      BackColor       =   0
      BorderStyle     =   0
      ReadOnly        =   -1  'True
      ScrollBars      =   2
      DisableNoScroll =   -1  'True
      Appearance      =   0
      AutoVerbMenu    =   -1  'True
      TextRTF         =   $"frmComerciarUsu.frx":0004
      BeginProperty Font {0BE35203-8F91-11CE-9DE3-00AA004BB851} 
         Name            =   "Verdana"
         Size            =   6.75
         Charset         =   0
         Weight          =   700
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
   End
   Begin VB.Image Image4 
      Height          =   300
      Left            =   4320
      Picture         =   "frmComerciarUsu.frx":0082
      Top             =   7560
      Width           =   2385
   End
   Begin VB.Label LabelOfrecido 
      BackColor       =   &H00000000&
      ForeColor       =   &H0000FFFF&
      Height          =   255
      Left            =   3405
      TabIndex        =   11
      Top             =   3240
      Width           =   3120
   End
   Begin VB.Image Image3 
      Height          =   255
      Left            =   480
      Top             =   5520
      Width           =   2295
   End
   Begin VB.Label LabelOroOferta 
      BackColor       =   &H00000000&
      ForeColor       =   &H0000FFFF&
      Height          =   255
      Left            =   3480
      TabIndex        =   10
      Top             =   4980
      Width           =   3075
   End
   Begin VB.Label lblEstadoDelOtro 
      Alignment       =   2  'Center
      BackColor       =   &H00FFFFFF&
      BackStyle       =   0  'Transparent
      Caption         =   "Tu comerciante aceptó, faltas tú!"
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   8.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H000000FF&
      Height          =   255
      Left            =   1920
      TabIndex        =   9
      Top             =   5880
      Visible         =   0   'False
      Width           =   2655
   End
   Begin VB.Image Image2 
      Height          =   375
      Left            =   480
      Top             =   5040
      Width           =   2295
   End
   Begin VB.Image Image1 
      Height          =   255
      Left            =   480
      Top             =   4680
      Width           =   2295
   End
   Begin VB.Image cmdAceptar 
      Height          =   375
      Left            =   5040
      MouseIcon       =   "frmComerciarUsu.frx":0936
      Top             =   5280
      Width           =   1455
   End
   Begin VB.Image cmdRechazar 
      Height          =   375
      Left            =   3360
      MouseIcon       =   "frmComerciarUsu.frx":0C40
      Top             =   5280
      Width           =   1575
   End
   Begin VB.Label Label1 
      Alignment       =   1  'Right Justify
      BackStyle       =   0  'Transparent
      Caption         =   "Cantidad:"
      Height          =   255
      Left            =   4020
      TabIndex        =   5
      Top             =   4560
      Width           =   1155
   End
   Begin VB.Image command2 
      Height          =   135
      Left            =   4440
      MouseIcon       =   "frmComerciarUsu.frx":0F4A
      Top             =   5760
      Width           =   2055
   End
   Begin VB.Label lblEstadoResp 
      Alignment       =   2  'Center
      BackStyle       =   0  'Transparent
      Caption         =   "Esperando respuesta..."
      BeginProperty Font 
         Name            =   "Arial"
         Size            =   11.25
         Charset         =   0
         Weight          =   400
         Underline       =   0   'False
         Italic          =   0   'False
         Strikethrough   =   0   'False
      EndProperty
      ForeColor       =   &H00FFFF80&
      Height          =   255
      Left            =   3480
      TabIndex        =   1
      Top             =   840
      Visible         =   0   'False
      Width           =   2970
   End
End
Attribute VB_Name = "frmComerciarUsu"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Private Sub cmdAceptar_Click()
Call Audio.PlayWave(0, SND_CLICK)
Call SendData("ACEPTCM")
End Sub

Private Sub cmdRechazar_Click()
Call Audio.PlayWave(0, SND_CLICK)
Call SendData("TERMINC")
End Sub

Private Sub Command2_Click()
Call Audio.PlayWave(0, SND_CLICK)
Call SendData("TERMINC")
End Sub

Private Sub Form_Load()
Me.Picture = LoadPicture(DirGraficos & "ComerciarUsu.gif")

           For i = 1 To UBound(UserInventory)
           
                        frmComerciarUsu.List3.AddItem UserInventory(i).name
            Next

MsgBox "ATENCIÓN: Recuerda tener 4 slots vacíos en tu inventario, de lo contrario los item comerciados caerán en el piso.", , "Comercio Seguro"
End Sub


Private Sub Image1_Click()
Call Audio.PlayWave(0, SND_CLICK)
If ItemsOfrecidos = 4 Then
MsgBox "No puedes ofrecer mas de 4 item, si te falto alguno o queres cambiar la oferta, cancela la operación y vuelve a comerciar.", , "Comercio Seguro"
Exit Sub
End If

Call SendData("/OFERTA " & List3.ListIndex + 1 & " " & txtCant.Text & "")

End Sub





Private Sub Image2_Click()
Call Audio.PlayWave(0, SND_CLICK)
Call SendData("/OFERTI " & txtCant.Text & "")
End Sub


Private Sub Image3_Click()
Call Audio.PlayWave(0, SND_CLICK)
Call SendData("/OFERTU " & txtCant.Text & "")
End Sub

Private Sub Image4_Click()
If Text1.Text = "" Then Exit Sub
Call SendData("XH" & UserName & "> " & Text1.Text)
AddtoRichTextBox frmComerciarUsu.ChatComer, UserName & "> " & Text1, 255, 255, 255, 0, 0
End Sub

Private Sub Form_KeyUp(KeyCode As Integer, Shift As Integer)

If KeyCode = vbKeyReturn Then
If Text1.Text = "" Then Exit Sub
Call SendData("XH" & UserName & "> " & Text1.Text)
AddtoRichTextBox frmComerciarUsu.ChatComer, UserName & "> " & Text1, 255, 255, 255, 0, 0
End If


End Sub

Private Sub List1_Click()
Call Audio.PlayWave(0, SND_CLICK)
    SincListBox List1, List4
End Sub

Private Sub List2_Click()
Call Audio.PlayWave(0, SND_CLICK)
    SincListBox List2, List5
End Sub

Private Sub List3_Click()
Call Audio.PlayWave(0, SND_CLICK)
Call DrawGrhtoHdc(Picture1.hDC, UserInventory(List3.ListIndex + 1).GrhIndex)
End Sub

Private Sub List4_Click()
Call Audio.PlayWave(0, SND_CLICK)
    SincListBox List4, List1
End Sub

Private Sub List5_Click()
Call Audio.PlayWave(0, SND_CLICK)
    SincListBox List5, List2
End Sub


Private Sub txtCant_KeyDown(KeyCode As Integer, Shift As Integer)

If Not ((KeyCode >= 48 And KeyCode <= 57) Or KeyCode = vbKeyBack Or _
        KeyCode = vbKeyDelete Or (KeyCode >= 37 And KeyCode <= 40)) Then
    
    KeyCode = 0
End If

End Sub
Private Sub txtCant_KeyPress(KeyAscii As Integer)

If Not ((KeyAscii >= 48 And KeyAscii <= 57) Or KeyAscii = vbKeyBack Or _
        KeyAscii = vbKeyDelete Or (KeyAscii >= 37 And KeyAscii <= 40)) Then
    
    KeyAscii = 0
End If

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



Private Sub SincListBox(elListOrig As Control, elListDest As Control)
    Static EnListBox As Boolean
        
    'Sincronizar el elListDest con el elListOrig
    If Not EnListBox Then
    
        EnListBox = True
        
'        'Desmarcar los elementos seleccionados
'        QuitarListSelected elListDest
'
'        'Marcar en el 1º ListBox los seleccionados del 2º
'        PonerListSelected elListOrig, elListDest
        
        'Poner en el ListDest los mismos que en ListOrig
        ListSelected elListOrig, elListDest
        
        'Posicionar el elemento superior
     '   elListDest.TopIndex = elListOrig.TopIndex
        
        EnListBox = False
    End If
End Sub
Private Sub QuitarListSelected(unList As Control)
    'Quitar los elementos seleccionados del listbox indicado
    'Parámetros:
    '   unList      el List a controlar
    '
    Dim i&
    
    With unList
        'Sólo hacer el bucle si permite multiselección
        If .MultiSelect Then
            For i = 0 To .ListCount - 1
                .Selected(i) = False
            Next
        End If
    End With
End Sub

Private Sub ListSelected(elListOrig As Control, elListDest As Control)
    'Marca en el ListDest los elementos seleccionados del ListOrig
    '
    'Los dos listbox deben tener el mismo número de elementos
    '
    Dim i&
    
    'Por si no tienen los mismos elementos
    On Local Error Resume Next
    
    With elListOrig
        For i = 0 To .ListCount - 1
            'Si el origen está seleccionado...
            If .Selected(i) Then
                elListDest.Selected(i) = .Selected(i)
            Else
                'sino, quitar la posible selección
                elListDest.Selected(i) = False
            End If
        Next
    End With
        
    Err = 0
End Sub

Private Sub PonerListSelected(elListOrig As Control, elListDest As Control)
    'Marca en el ListDest los elementos seleccionados del ListOrig
    '
    'Los dos listbox deben tener el mismo número de elementos
    '
    Dim i&
    
    'Por si no tienen los mismos elementos
    On Local Error Resume Next
    
    With elListOrig
        For i = 0 To .ListCount - 1
            elListDest.Selected(i) = .Selected(i)
        Next
    End With
        
    Err = 0
End Sub
