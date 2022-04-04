VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "cCola"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False

Option Explicit

Private Const FRENTE = 1

Private Cola As Collection

Public Sub Reset()
On Error Resume Next

Dim i As Integer
For i = 1 To Me.Longitud
    Cola.Remove FRENTE
Next

End Sub

Public Property Get Longitud() As Integer
Longitud = Cola.Count
End Property

Private Function IndexValido(ByVal i As Integer) As Boolean
IndexValido = i >= 1 And i <= Me.Longitud
End Function

Private Sub Class_Initialize()
Set Cola = New Collection
End Sub
Public Function VerElemento(Index As Integer) As Variant
On Error Resume Next

If IndexValido(Index) Then
    VerElemento = Cola(Index)
Else: VerElemento = 0
End If

End Function
Public Sub Push(Info As String, Nombre As String)
On Error Resume Next

Call Cola.Add(UCase$(Nombre))

End Sub
Public Function Pop() As Variant
On Error Resume Next

If Cola.Count Then
    Pop = Cola(FRENTE)
    Call Cola.Remove(FRENTE)
End If

End Function
Public Function PopByVal() As Variant
On Error Resume Next

If Cola.Count Then PopByVal = Cola.Item(1)

End Function
Public Function Existe(ByVal Nombre As String) As Boolean
On Error Resume Next
Dim f As Boolean
Dim V As Variant
Dim i As Integer

Dim NombreEnMayusculas As String
NombreEnMayusculas = UCase$(Nombre)

i = 1
f = False

For i = 1 To Me.Longitud
    V = Me.VerElemento(i)
    If V = NombreEnMayusculas Then
        Existe = True
        Exit Function
   End If
Next

End Function
Public Sub Quitar(Nombre As String)
On Error Resume Next
Dim V As Variant
Dim i As Integer
Dim NombreEnMayusculas As String
 
NombreEnMayusculas = UCase$(Nombre)
 
For i = 1 To Me.Longitud
    V = Me.VerElemento(i)
    If V = NombreEnMayusculas Then
        Call Cola.Remove(i)
        Exit Sub
    End If
Next
 
End Sub
Public Sub QuitarIndex(Index As Integer)
On Error Resume Next

If IndexValido(Index) Then Call Cola.Remove(Index)

End Sub
Private Sub Class_Terminate()

Set Cola = Nothing

End Sub
