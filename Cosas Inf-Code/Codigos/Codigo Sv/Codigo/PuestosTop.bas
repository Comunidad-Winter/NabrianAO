Attribute VB_Name = "PuestosTop"
 
'director del proyecto: #Esteban(Neliam)

'servidor basado en fénixao 1.0
'medios de contacto:
'Skype: dc.esteban
'E-mail: nabrianao@gmail.com
Option Explicit
Public Function PonerPuntos(Numero As Long) As String
Dim i As Integer
Dim Cifra As String
If Numero > 999999999 Then Exit Function 'evito crasg num maximo 999.999.999
Cifra = str(Numero)
Cifra = Right$(Cifra, Len(Cifra) - 1)
For i = 0 To 4
    If Len(Cifra) - 3 * i >= 3 Then
        If Mid$(Cifra, Len(Cifra) - (2 + 3 * i), 3) <> "" Then
            PonerPuntos = Mid$(Cifra, Len(Cifra) - (2 + 3 * i), 3) & "." & PonerPuntos
        End If
    Else
        If Len(Cifra) - 3 * i > 0 Then
            PonerPuntos = Left$(Cifra, Len(Cifra) - 3 * i) & "." & PonerPuntos
        End If
        Exit For
    End If
Next

PonerPuntos = Left$(PonerPuntos, Len(PonerPuntos) - 1)

End Function

Public Function TotalMatados(Userindex As Integer) As Integer

TotalMatados = UserList(Userindex).Faccion.Matados(0) + UserList(Userindex).Faccion.Matados(1) + UserList(Userindex).Faccion.Matados(2)

End Function
Public Function TotalRankRetos(Userindex As Integer) As Integer

TotalRankRetos = UserList(Userindex).flags.RetosGanados - UserList(Userindex).flags.RetosPerdidos

End Function
Public Sub RevisarTops(Userindex As Integer)

If UserList(Userindex).flags.Privilegios > 0 Then
    If IndexTop(Nivel, Userindex) <> UBound(Tops, 2) Then Call SacarTop(Nivel, Userindex)
    If IndexTop(Muertos, Userindex) <> UBound(Tops, 2) Then Call SacarTop(Muertos, Userindex)
    If IndexTop(RetosGanadosD, Userindex) <> UBound(Tops, 2) Then Call SacarTop(RetosGanadosD, Userindex)
    If IndexTop(Reputacion, Userindex) <> UBound(Tops, 2) Then Call SacarTop(Reputacion, Userindex)
Else
    If UserList(Userindex).Stats.ELV > Tops(Nivel, UBound(Tops, 2)).Nivel Then Call AgregarTop(Nivel, Userindex)
    If TotalMatados(Userindex) > Tops(Muertos, UBound(Tops, 2)).Muertos Then Call AgregarTop(Muertos, Userindex)
    If TotalRankRetos(Userindex) > Tops(RetosGanadosD, UBound(Tops, 2)).RetosGanadosD Then Call AgregarTop(RetosGanadosD, Userindex)
    If UserList(Userindex).Stats.Reputacion > Tops(Reputacion, UBound(Tops, 2)).Reputacion Then Call AgregarTop(Reputacion, Userindex)
End If

End Sub
Public Function IndexTop(Top As Byte, Userindex As Integer) As Integer
Dim i As Integer

For i = 1 To UBound(Tops, 2)
    If UCase$(Tops(Top, i).Nombre) = UCase$(UserList(Userindex).Name) Then
        IndexTop = i
        Exit Function
    End If
Next

IndexTop = UBound(Tops, 2)

End Function
Public Sub AgregarTop(Top As Byte, Userindex As Integer)
Dim i As Integer

i = IndexTop(Top, Userindex)

For i = i - 1 To 1 Step -1
    If (Top = Nivel And UserList(Userindex).Faccion.torneos <= Tops(Nivel, i).torneos) Or _
        (Top = Muertos And TotalMatados(Userindex) <= Tops(Muertos, i).Muertos) Or _
        (Top = RetosGanadosD And TotalRankRetos(Userindex) <= Tops(RetosGanadosD, i).RetosGanadosD) Or _
        (Top = Reputacion And UserList(Userindex).Stats.Reputacion <= Tops(Reputacion, i).Reputacion) Then
        i = i + 1
        Exit For
    End If
    Tops(Top, i + 1) = Tops(Top, i)
    Call SaveTop(Top, i + 1, Userindex)
Next

i = Maximo(1, i)

Tops(Top, i).Nombre = UserList(Userindex).Name
Tops(Top, i).Bando = ListaBandos(UserList(Userindex).Faccion.Bando)
Tops(Top, i).torneos = UserList(Userindex).Faccion.torneos
Tops(Top, i).Muertos = TotalMatados(Userindex)
Tops(Top, i).RetosGanadosD = TotalRankRetos(Userindex)
Tops(Top, i).NivelReal = UserList(Userindex).Stats.ELV
Tops(Top, i).Reputacion = UserList(Userindex).Stats.Reputacion
Call SaveTop(Top, i, Userindex)




End Sub
Public Sub SacarTop(Top As Byte, Userindex As Integer)
Dim i As Integer

i = IndexTop(Top, Userindex)

For i = i To UBound(Tops, 2) - 1
    Tops(Top, i) = Tops(Top, i + 1)
    Call SaveTop(Top, i, Userindex)
Next

Tops(Top, UBound(Tops, 2)).Nombre = ""
Tops(Top, UBound(Tops, 2)).Bando = ""
Tops(Top, UBound(Tops, 2)).torneos = 0
Tops(Top, UBound(Tops, 2)).Muertos = 0
Tops(Top, UBound(Tops, 2)).RetosGanadosD = 0
Tops(Top, UBound(Tops, 2)).NivelReal = 0
Tops(Top, UBound(Tops, 2)).Reputacion = 0

Call SaveTop(Top, UBound(Tops, 2), Userindex)




End Sub
Public Sub SaveTop(Top As Byte, Puesto As Integer, Userindex As Integer)
Dim file As String
Dim i As Integer

If Len(Tops(Top, Puesto).Nombre) = 0 Then Exit Sub

Select Case Top
Case 1
file = App.Path & "\LOGS\TopRanking.log"
Case 2
file = App.Path & "\LOGS\TopMuertos.log"
Case 3
file = App.Path & "\LOGS\TopRetos.log"
Case 4
file = App.Path & "\G.log"
End Select

Call WriteVar(file, "Top" & Puesto, "Name", Tops(Top, Puesto).Nombre)
Call WriteVar(file, "Top" & Puesto, "canje", val(Tops(Top, Puesto).torneos))
Call WriteVar(file, "Top" & Puesto, "Muertos", val(Tops(Top, Puesto).Muertos))
Call WriteVar(file, "Top" & Puesto, "Bando", Tops(Top, Puesto).Bando)
Call WriteVar(file, "Top" & Puesto, "RetosGanados", val(Tops(Top, Puesto).RetosGanadosD))
Call WriteVar(file, "Top" & Puesto, "NivelReal", val(Tops(Top, Puesto).NivelReal))
Call WriteVar(file, "Top" & Puesto, "RE", val(Tops(Top, Puesto).Reputacion))


UserList(Userindex).PuestoEnTop = Puesto

End Sub
Public Sub LoadTops(Top As Byte)
Dim file As String, i As Integer

Select Case Top
Case 1
file = App.Path & "\LOGS\TopRanking.log"
Case 2
file = App.Path & "\LOGS\TopMuertos.log"
Case 3
file = App.Path & "\LOGS\TopRetos.log"
Case 4
file = App.Path & "\G.log"
End Select

If Not FileExist(file, vbNormal) Then
Open App.Path + "\archivo.txt" For Append As #2
Close #2
End If
Exit Sub

For i = 1 To UBound(Tops, 2)
    Tops(Top, i).Nombre = GetVar(file, "Top" & i, "Name")
    Tops(Top, i).torneos = val(GetVar(file, "Top" & i, "canje"))
    Tops(Top, i).Muertos = val(GetVar(file, "Top" & i, "Muertos"))
    Tops(Top, i).Bando = GetVar(file, "Top" & i, "Bando")
    Tops(Top, i).RetosGanadosD = GetVar(file, "Top" & i, "RetosGanados")
    Tops(Top, i).NivelReal = GetVar(file, "Top" & i, "NivelReal")
    Tops(Top, i).Reputacion = val(GetVar(file, "Top" & i, "RE"))
Next

End Sub




