VERSION 5.00
Begin VB.Form FrmRenderer 
   Caption         =   "Renderizar Imagen."
   ClientHeight    =   8025
   ClientLeft      =   60
   ClientTop       =   405
   ClientWidth     =   15090
   LinkTopic       =   "Form1"
   ScaleHeight     =   535
   ScaleMode       =   3  'Pixel
   ScaleWidth      =   1006
   StartUpPosition =   3  'Windows Default
   Begin VB.CommandButton cmdGuardar 
      Caption         =   "GUARDAR"
      Height          =   255
      Left            =   10800
      TabIndex        =   2
      Top             =   7680
      Width           =   4095
   End
   Begin VB.PictureBox Picture2 
      BackColor       =   &H00000000&
      BorderStyle     =   0  'None
      Height          =   7500
      Left            =   7560
      ScaleHeight     =   500
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   500
      TabIndex        =   1
      Top             =   120
      Width           =   7500
   End
   Begin VB.PictureBox Picture1 
      BackColor       =   &H00000000&
      BorderStyle     =   0  'None
      Height          =   7500
      Left            =   0
      ScaleHeight     =   500
      ScaleMode       =   3  'Pixel
      ScaleWidth      =   500
      TabIndex        =   0
      Top             =   120
      Width           =   7500
   End
End
Attribute VB_Name = "FrmRenderer"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = False
Attribute VB_PredeclaredId = True
Attribute VB_Exposed = False
Option Explicit
Private Declare Function BitBlt Lib "gdi32" ( _
    ByVal hDestDC As Long, _
    ByVal X As Long, _
    ByVal Y As Long, _
    ByVal nWidth As Long, _
    ByVal nHeight As Long, _
    ByVal hSrcDC As Long, _
    ByVal xSrc As Long, _
    ByVal ySrc As Long, _
    ByVal dwRop As Long) As Long
 
' Recupera la imagen del área del control
Private Declare Function GetWindowDC Lib "user32" (ByVal hwnd As Long) As Long



Private Sub cmdGuardar_Click()
Call Capturar_Imagen(Picture1, Picture2)
 
Call SavePicture(FrmRenderer.Picture2.Image, App.Path & "\Mapa1.bmp")
 
Unload Me
End Sub

Private Sub Capturar_Imagen(Control As Control, Destino As Object)
 
    Dim hdc As Long
    Dim Escala_Anterior As Integer
    Dim Ancho As Long
    Dim Alto As Long
 
    ' Para que se mantenga la imagen por si se repinta la ventana
    Destino.AutoRedraw = True
 
    On Error Resume Next
    ' Si da error es por que el control está dentro de un Frame _
      ya que  los Frame no tiene  dicha propiedad
    Escala_Anterior = Control.Container.ScaleMode
 
    If Err.Number = 438 Then
       ' Si el control está en un Frame, convierte la escala
       Ancho = ScaleX(Control.Width, vbTwips, vbPixels)
       Alto = ScaleY(Control.Height, vbTwips, vbPixels)
    Else
       ' Si no cambia la escala del  contenedor a pixeles
       Control.Container.ScaleMode = vbPixels
       Ancho = Control.Width
       Alto = Control.Height
    End If
 
    ' limpia el error
    On Error GoTo 0
    ' Captura el área de pantalla correspondiente al control
    hdc = GetWindowDC(Control.hwnd)
    ' Copia esa área al picturebox
    BitBlt Destino.hdc, 0, 0, Ancho, Alto, hdc, 0, 0, vbSrcCopy
    ' Convierte la imagen anterior en un Mapa de bits
    Destino.Picture = Destino.Image
    ' Borra la imagen ya que ahora usa el Picture
    Destino.Cls
 
    On Error Resume Next
    If Err.Number = 0 Then
       ' Si el control no está en un  Frame, restaura la escala del contenedor
       Control.Container.ScaleMode = Escala_Anterior
    End If
 End Sub

