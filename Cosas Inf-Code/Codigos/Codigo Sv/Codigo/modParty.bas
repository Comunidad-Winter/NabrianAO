Attribute VB_Name = "modParty"
 
'director del proyecto: #Esteban(Neliam)

'servidor basado en fénixao 1.0
'medios de contacto:
'Skype: dc.esteban
'E-mail: nabrianao@gmail.com
Option Explicit
Sub RepartirExp(Userindex As Integer, Experiencia As Long, Died As Boolean)
On Error GoTo Error
Dim i As Integer
Dim Miembro As Integer, Cant As Long, Exp As Long

For i = 1 To Party(UserList(Userindex).PartyIndex).NroMiembros
    Miembro = Party(UserList(Userindex).PartyIndex).MiembrosIndex(i)
    If Miembro > 0 Then
        With UserList(Miembro)
            If .flags.Muerto = 0 And .POS.Map = UserList(Userindex).POS.Map Then
                Cant = Cant + 1 + Buleano(Not ClaseTrabajadora(.Clase))
            End If
        End With
    End If
Next

For i = 1 To Party(UserList(Userindex).PartyIndex).NroMiembros
    Miembro = Party(UserList(Userindex).PartyIndex).MiembrosIndex(i)
    If Miembro > 0 Then
        With UserList(Miembro)
            If .flags.Muerto = 0 And .POS.Map = UserList(Userindex).POS.Map Then
                Exp = ((1 + Buleano(Not ClaseTrabajadora(.Clase))) * Experiencia) / Cant
                .Stats.Exp = .Stats.Exp + Exp
                If Userindex = Miembro Then
                    If Died Then
                        Call SendData(ToIndex, Userindex, 0, "EL" & Exp)
                    Else: Call SendData(ToIndex, Userindex, 0, "EX" & Exp)
                    End If
                End If
                Call SendUserEXP(Miembro)
                Call CheckUserLevel(Miembro)
            End If
        End With
    End If
Next

Exit Sub
Error:
    Call Logear("Errores", "Error en RepartirExp " & UserList(Userindex).Name & Err.Description)
End Sub

Sub EnviarIntegrantesParty(Userindex As Integer)
Dim i As Integer
Dim SD As String

If UserList(Userindex).flags.Party = 0 Then
    Call SendData(ToIndex, Userindex, 0, "PARTYN")
    Exit Sub
End If

For i = 1 To MAXPARTYUSERS
    If Party(UserList(Userindex).PartyIndex).MiembrosIndex(i) > 0 Then
        SD = SD & UserList(Party(UserList(Userindex).PartyIndex).MiembrosIndex(i)).Name & " (Lvl " & UserList(Party(UserList(Userindex).PartyIndex).MiembrosIndex(i)).Stats.ELV & "),"
    End If
Next

If Party(UserList(Userindex).PartyIndex).MiembrosIndex(1) = Userindex Then
    SD = "PARTYL" & SD
Else
    SD = "PARTYI" & SD
End If

Call SendData(ToIndex, Userindex, 0, SD)

End Sub
Public Function NoPuedeEntrarParty(Userindex As Integer, Invitado As Integer) As Byte

If EsNewbie(Userindex) Then
    NoPuedeEntrarParty = 1
    Exit Function
End If

If EsNewbie(Invitado) Then
    NoPuedeEntrarParty = 15
    Exit Function
End If

If UserList(Userindex).Stats.UserAtributos(Carisma) * UserList(Userindex).Stats.UserSkills(Liderazgo) < 100 Then
    NoPuedeEntrarParty = 2
    Exit Function
End If

If Userindex = Invitado Then
    NoPuedeEntrarParty = 3
    Exit Function
End If

If UserList(Invitado).Faccion.Bando = Enemigo(UserList(Userindex).Faccion.Bando) Then
    NoPuedeEntrarParty = 4
    Exit Function
End If

If UserList(Invitado).flags.Muerto Then
    NoPuedeEntrarParty = 5
    Exit Function
End If

If UserList(Invitado).flags.Party Then
    If UserList(Invitado).PartyIndex = UserList(Userindex).PartyIndex Then
        NoPuedeEntrarParty = 6
    Else: NoPuedeEntrarParty = 13
    End If
    Exit Function
End If

If UserList(Invitado).flags.Ofreciente > 0 And UserList(Invitado).flags.Ofreciente <> Userindex Then
    NoPuedeEntrarParty = 14
    Exit Function
End If

If Distancia(UserList(Invitado).POS, UserList(Userindex).POS) > 6 Then
    NoPuedeEntrarParty = 8
    Exit Function
End If

If UserList(Userindex).flags.Party Then
    If UserList(Invitado).Faccion.Bando = Enemigo(Party(UserList(Userindex).PartyIndex).Bando) Then
        NoPuedeEntrarParty = 12
    ElseIf MinLevel(UserList(Userindex).PartyIndex) + 5 < UserList(Invitado).Stats.ELV Or MaxLevel(UserList(Userindex).PartyIndex) - 5 > UserList(Invitado).Stats.ELV Then
        NoPuedeEntrarParty = 10
    ElseIf Party(UserList(Userindex).PartyIndex).NroMiembros = MAXPARTYUSERS Then
        NoPuedeEntrarParty = 9
    ElseIf Party(UserList(Userindex).PartyIndex).MiembrosIndex(1) <> Userindex Then
        NoPuedeEntrarParty = 11
    End If
ElseIf Abs(UserList(Userindex).Stats.ELV - UserList(Invitado).Stats.ELV) > 5 Then
    NoPuedeEntrarParty = 10
End If

End Function
Public Sub DoInvitar(Userindex As Integer, Invitado As Integer)

If Userindex = 0 Or Invitado = 0 Then Exit Sub

Select Case NoPuedeEntrarParty(Userindex, Invitado)
    Case 0
        UserList(Invitado).flags.Ofreciente = Userindex
        Call SendData(ToIndex, Userindex, 0, "||Le ofreciste a " & UserList(Invitado).Name & " entrar en el party." & FONTTYPE_PARTY)
        Call SendData(ToIndex, Invitado, 0, "INVPAR" & UserList(Userindex).Name)
    Case 1
        Call SendData(ToIndex, Userindex, 0, "||Los newbies no pueden formar un party." & FONTTYPE_PARTY)
    Case 2
        Call SendData(ToIndex, Userindex, 0, "||Por tu carisma necesitas " & Redondea(100 / UserList(Userindex).Stats.UserAtributos(Carisma)) & " puntos de liderazgo para hacer un party." & FONTTYPE_PARTY)
    Case 3
        Call SendData(ToIndex, Userindex, 0, "||No podés invitarte a party a ti mismo." & FONTTYPE_PARTY)
    Case 4
        Call SendData(ToIndex, Userindex, 0, "||¡No podés entrar en party con miembros de " & ListaBandos(UserList(Invitado).Faccion.Bando) & "!" & FONTTYPE_PARTY)
    Case 5
        Call SendData(ToIndex, Userindex, 0, "||No podés invitar al party a un muerto." & FONTTYPE_PARTY)
    Case 6
        Call SendData(ToIndex, Userindex, 0, "||El usuario ya está en tu party." & FONTTYPE_PARTY)
    Case 7
        Call SendData(ToIndex, Userindex, 0, "||Ya le ofreciste party al usuario." & FONTTYPE_PARTY)
    Case 8
        Call SendData(ToIndex, Userindex, 0, "DL")
    Case 9
        Call SendData(ToIndex, Userindex, 0, "||Tu party ya está lleno." & FONTTYPE_PARTY)
    Case 10
        Call SendData(ToIndex, Userindex, 0, "||La diferencia de niveles es demasiado grande." & FONTTYPE_PARTY)
    Case 11
        Call SendData(ToIndex, Userindex, 0, "||Solo el lider del party (" & UserList(Party(UserList(Userindex).PartyIndex).MiembrosIndex(1)).Name & ") puede invitar gente a unirse al party." & FONTTYPE_PARTY)
    Case 12
        Call SendData(ToIndex, Userindex, 0, "||Tu party ya está asignado a " & ListaBandos(Party(UserList(Userindex).PartyIndex).Bando) & "." & FONTTYPE_PARTY)
    Case 13
        Call SendData(ToIndex, Userindex, 0, "||El usuario ya está en otro party." & FONTTYPE_PARTY)
    Case 14
        Call SendData(ToIndex, Userindex, 0, "||Alguien ya le ofreció party al usuario." & FONTTYPE_PARTY)
    Case 15
        Call SendData(ToIndex, Userindex, 0, "||No puedes invitar a un newbie a un party." & FONTTYPE_PARTY)
End Select

End Sub
Function MaxLevel(PartyIndex As Integer) As Byte
Dim i As Integer

For i = 1 To Party(PartyIndex).NroMiembros
    If Party(PartyIndex).MiembrosIndex(i) > 0 Then
        If UserList(Party(PartyIndex).MiembrosIndex(i)).Stats.ELV > MaxLevel Then
            MaxLevel = UserList(Party(PartyIndex).MiembrosIndex(i)).Stats.ELV
        End If
    End If
Next

End Function
Function MinLevel(PartyIndex As Integer) As Byte
Dim i As Integer

MinLevel = STAT_MAXELV

For i = 1 To Party(PartyIndex).NroMiembros
    If Party(PartyIndex).MiembrosIndex(i) > 0 Then
        If UserList(Party(PartyIndex).MiembrosIndex(i)).Stats.ELV < MinLevel Then
            MinLevel = UserList(Party(PartyIndex).MiembrosIndex(i)).Stats.ELV
        End If
    End If
Next

End Function
Sub CrearParty(Userindex As Integer)
Dim PartyIndex As Integer
Dim Lider As Integer
Dim i As Integer

If Userindex = 0 Then Exit Sub
Lider = UserList(Userindex).flags.Ofreciente
If Lider = 0 Then Exit Sub

For i = 1 To UBound(Party)
    If Party(i).NroMiembros = 0 Then
        PartyIndex = i
        Party(PartyIndex).NroMiembros = 2
        Party(PartyIndex).MiembrosIndex(1) = Lider
        Party(PartyIndex).MiembrosIndex(2) = Userindex
        UserList(Lider).PartyIndex = PartyIndex
        UserList(Userindex).PartyIndex = PartyIndex
        UserList(Lider).flags.Party = 1
        UserList(Userindex).flags.Party = 1
        UserList(Userindex).flags.Ofreciente = 0
        UserList(Lider).flags.Ofreciente = 0
        Call SendData(ToIndex, Userindex, 0, "||Entraste en party con " & UserList(Lider).Name & "." & FONTTYPE_PARTY)
        Call SendData(ToIndex, Lider, 0, "||" & UserList(Userindex).Name & " aceptó entrar en party con vos." & FONTTYPE_PARTY)
        Party(PartyIndex).Bando = UserList(Lider).Faccion.Bando
        If UserList(Userindex).Faccion.Bando Then Party(PartyIndex).Bando = UserList(Userindex).Faccion.Bando
        Exit Sub
    End If
Next

End Sub
Sub EntrarAlParty(Userindex As Integer, PartyIndex As Integer)
Dim i As Integer

If Userindex = 0 Or PartyIndex = 0 Then Exit Sub
If EsPartyInscripto(PartyIndex) And _
UserList(Party(PartyIndex).MiembrosIndex(1)).POS.Map = 8 Then Exit Sub

Call PartyAlterado(PartyIndex)
For i = 1 To MAXPARTYUSERS
    If Party(PartyIndex).MiembrosIndex(i) = 0 Then
        Party(PartyIndex).MiembrosIndex(i) = Userindex
        Party(PartyIndex).NroMiembros = Party(PartyIndex).NroMiembros + 1
        UserList(Userindex).flags.Party = 1
        UserList(Userindex).PartyIndex = PartyIndex
        UserList(Userindex).flags.Ofreciente = 0
        Call SendData(ToIndex, Userindex, 0, "||Entraste al party." & FONTTYPE_PARTY)
        Call SendData(ToParty, Userindex, 0, "||" & UserList(Userindex).Name & " entró al party." & FONTTYPE_PARTY)
        If Party(PartyIndex).Bando = Neutral Then Party(PartyIndex).Bando = UserList(Userindex).Faccion.Bando
        Exit Sub
    End If
Next

End Sub
Sub EcharDelParty(Userindex As Integer)
Dim PartyIndex As Integer
Dim i As Integer
Dim NroMiembro As Integer

If Userindex = 0 Then Exit Sub

PartyIndex = UserList(Userindex).PartyIndex
If PartyIndex = 0 Then Exit Sub
If EsPartyInscripto(PartyIndex) And _
UserList(Party(PartyIndex).MiembrosIndex(1)).POS.Map = 8 Then Exit Sub
Call PartyAlterado(PartyIndex)
Party(PartyIndex).NroMiembros = Party(PartyIndex).NroMiembros - 1

For i = 1 To MAXPARTYUSERS
    If Party(PartyIndex).MiembrosIndex(i) = Userindex Then
        NroMiembro = i
        Exit For
    End If
Next

For i = NroMiembro + 1 To MAXPARTYUSERS
    Party(PartyIndex).MiembrosIndex(i - 1) = Party(PartyIndex).MiembrosIndex(i)
Next

Party(PartyIndex).MiembrosIndex(MAXPARTYUSERS) = 0

Call SendData(ToParty, Userindex, 0, "||" & UserList(Userindex).Name & " fue echado del party." & FONTTYPE_PARTY)
Call SendData(ToIndex, Userindex, 0, "||Fuiste echado del party." & FONTTYPE_PARTY)
Call SendData(ToIndex, Userindex, 0, "PARTYN")

UserList(Userindex).flags.Party = 0
UserList(Userindex).PartyIndex = 0

End Sub
Sub SacarDelParty(Userindex As Integer)
Dim PartyIndex As Integer
Dim i As Integer
Dim NroMiembro As Integer

If Userindex = 0 Then Exit Sub

PartyIndex = UserList(Userindex).PartyIndex
If PartyIndex = 0 Then Exit Sub
If EsPartyInscripto(PartyIndex) And _
UserList(Party(PartyIndex).MiembrosIndex(1)).POS.Map = 90 Then Exit Sub
Call PartyAlterado(PartyIndex)
Party(PartyIndex).NroMiembros = Party(PartyIndex).NroMiembros - 1

For i = 1 To MAXPARTYUSERS
    If Party(PartyIndex).MiembrosIndex(i) = Userindex Then
        NroMiembro = i
        Exit For
    End If
Next

If NroMiembro = 1 Then
    Call RomperParty(Userindex)
    Exit Sub
End If

For i = NroMiembro + 1 To MAXPARTYUSERS
    Party(PartyIndex).MiembrosIndex(i - 1) = Party(PartyIndex).MiembrosIndex(i)
Next

Party(PartyIndex).MiembrosIndex(MAXPARTYUSERS) = 0

Call SendData(ToParty, Userindex, 0, "||" & UserList(Userindex).Name & " salió del party." & FONTTYPE_PARTY)

Call SendData(ToIndex, Userindex, 0, "||Saliste del party." & FONTTYPE_PARTY)


Call SendData(ToIndex, Userindex, 0, "PARTYN")
UserList(Userindex).flags.Party = 0
UserList(Userindex).PartyIndex = 0

Exit Sub

Error:
    Call Logear("Errores", "Error en SacarDelParty-" & Err.Description)
End Sub
Sub RomperParty(Userindex As Integer)
On Error GoTo Error
Dim i As Integer
Dim PartyIndex As Integer

If Userindex = 0 Then Exit Sub

PartyIndex = UserList(Userindex).PartyIndex

If PartyIndex = 0 Then Exit Sub
If EsPartyInscripto(PartyIndex) And _
UserList(Party(PartyIndex).MiembrosIndex(1)).POS.Map = 90 Then Exit Sub
Call PartyAlterado(PartyIndex)
Call SendData(ToParty, Userindex, 0, "||El party fue disuelto." & FONTTYPE_PARTY)
Call SendData(ToParty, Userindex, 0, "PARTYN")

For i = 1 To MAXPARTYUSERS
    If Party(PartyIndex).MiembrosIndex(i) > 0 Then
        UserList(Party(PartyIndex).MiembrosIndex(i)).flags.Party = 0
        UserList(Party(PartyIndex).MiembrosIndex(i)).PartyIndex = 0
        Party(PartyIndex).MiembrosIndex(i) = 0
        Party(PartyIndex).Bando = Neutral
    End If
Next

Party(PartyIndex).NroMiembros = 0
Exit Sub
Error:
    Call Logear("Errores", "Error en RomperParty-" & Err.Description)
End Sub


