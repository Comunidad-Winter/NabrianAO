Attribute VB_Name = "MOD_EVENTO_Retos2vs2"
Public Type Parej
User1 As Integer
User2 As Integer
End Type

Type Ring2v2
    CompletoJugando As Boolean
    Pareja1 As Parej
    Pareja2 As Parej
End Type

Private Rings2v2(1 To 2) As Ring2v2
Public Function EsMapa(Mapa As Integer) As Boolean
EsMapa = False
If Mapa = 8 Then EsMapa = True
End Function

Public Sub DebugParejas()
Call DevolverParticipantesH(1)
Call DevolverParticipantesH(2)
Call DevolverParticipantesH(3)
Call DevolverParticipantesH(4)
Dim i As Integer
For i = 1 To 4
    Call LimpiarUsuarios(i, 1, True)
    Call LimpiarUsuarios(i, 2, True)
    Call Limpiarpareja(i, 1)
    Call Limpiarpareja(i, 2)
    Rings2v2(i).CompletoJugando = False

Next

Call SendData(ToAdmins, 0, 0, "||Retos 2 Desbugeados." & FONTTYPE_FENIX)
End Sub

Private Sub MoveCasperAlMedio(ring As Integer, user As Integer, pareja As Integer)
Select Case ring
Case 1
    Call WarpUserChar(user, 90, 41, 22 + pareja, True)
Case 2
    Call WarpUserChar(user, 90, 42, 47 + pareja, True)
'Case 3
    'Call WarpUserChar(user, 170, 75, 53 + pareja, True)
'Case 4
 '   Call WarpUserChar(user, 170, 71, 22 + pareja, True)
End Select

End Sub

Sub MuereUser(Userindex As Integer)
Dim Ract  As Integer
Ract = JugandoEnQueRing(Userindex)
If (Ract > 0) Then
If UserList(Rings2v2(Ract).Pareja1.User1).flags.Muerto = 1 And UserList(Rings2v2(Ract).Pareja1.User2).flags.Muerto = 1 Then
      'TERMINADO
        Call SendData(ToMap, 0, 160, "||Reto> " & UserList(Rings2v2(Ract).Pareja2.User1).Name & " - " & UserList(Rings2v2(Ract).Pareja2.User2).Name & " derrotaron a " & UserList(Rings2v2(Ract).Pareja1.User1).Name & " - " & UserList(Rings2v2(Ract).Pareja1.User2).Name & FONTTYPE_BLAkCO)
        Call Pagar(Ract, 2)
        Call DevolverParticipantesH(Ract)
ElseIf UserList(Rings2v2(Ract).Pareja2.User1).flags.Muerto = 1 And UserList(Rings2v2(Ract).Pareja2.User2).flags.Muerto = 1 Then
        'TERMINADO
        Call SendData(ToMap, 0, 160, "||Reto> " & UserList(Rings2v2(Ract).Pareja1.User1).Name & " - " & UserList(Rings2v2(Ract).Pareja1.User2).Name & " derrotaron a " & UserList(Rings2v2(Ract).Pareja1.User1).Name & " - " & UserList(Rings2v2(Ract).Pareja1.User2).Name & FONTTYPE_BLAkCO)
        Call Pagar(Ract, 1)
        Call DevolverParticipantesH(Ract)
ElseIf Rings2v2(Ract).Pareja1.User1 = Userindex Or Rings2v2(Ract).Pareja1.User2 = Userindex Then
      '  Call MoveCasperAlMedio(Ract, Userindex, 1)
ElseIf Rings2v2(Ract).Pareja2.User1 = Userindex Or Rings2v2(Ract).Pareja2.User2 = Userindex Then
     '  Call MoveCasperAlMedio(Ract, Userindex, 2)
End If
End If
End Sub
'## listo
Private Sub CancelarReto(ring As Integer, user As Integer)
If Rings2v2(ring).Pareja1.User1 = user Or Rings2v2(ring).Pareja1.User2 = user Then
Call Pagar(ring, 2)
ElseIf Rings2v2(ring).Pareja2.User1 = user Or Rings2v2(ring).Pareja2.User2 = user Then
Call Pagar(ring, 1)
End If

Call DevolverParticipantesH(ring)
Rings2v2(ring).CompletoJugando = False
Call SendData(ToMap, 0, 160, "||Reto> cancelado por la desconexión de " & UserList(user).Name & FONTTYPE_BLANCO)
End Sub
'## listo
Function JugandoEnQueRing(uIndex As Integer) As Integer
Dim i As Integer
For i = 1 To 2
If Rings2v2(i).Pareja1.User1 = uIndex Or Rings2v2(i).Pareja1.User2 = uIndex Or _
    Rings2v2(i).Pareja2.User1 = uIndex Or Rings2v2(i).Pareja2.User2 = uIndex Then
    JugandoEnQueRing = i
    Exit Function
    End If
Next
JugandoEnQueRing = -1
End Function
'## listo
Sub SeFue(Userindex As Integer)
On Error GoTo Wepa
Dim RCancelado  As Integer
RCancelado = JugandoEnQueRing(Userindex)
If RCancelado > 0 Then
    If Rings2v2(RCancelado).CompletoJugando = True Then
        Call CancelarReto(RCancelado, Userindex)
    ElseIf Rings2v2(RCancelado).CompletoJugando = False Then
        If Rings2v2(RCancelado).Pareja1.User1 = Userindex Or Rings2v2(RCancelado).Pareja1.User2 = Userindex Then
            Call LimpiarUsuarios(RCancelado, 1, True)
            Call Limpiarpareja(RCancelado, 1)
        ElseIf Rings2v2(RCancelado).Pareja2.User1 = Userindex Or Rings2v2(RCancelado).Pareja2.User2 = Userindex Then
            Call LimpiarUsuarios(RCancelado, 2, True)
            Call Limpiarpareja(RCancelado, 2)
        End If
    End If
Else
If UserList(UserList(Userindex).flags.pareja).flags.pareja > 0 Then
Call SendData(ToIndex, UserList(Userindex).flags.pareja, 0, "||Pareja Cancelada." & FONTTYPE_VENENO)
UserList(UserList(Userindex).flags.pareja).flags.pareja = 0
UserList(UserList(Userindex).flags.pareja).flags.Parejado = 0
End If
If UserList(Userindex).flags.pareja > 0 Then
Call SendData(ToIndex, Userindex, 0, "||Pareja Cancelada." & FONTTYPE_VENENO)
UserList(Userindex).flags.Parejado = 0
UserList(Userindex).flags.pareja = 0
End If
End If
Exit Sub
Wepa:
Call LogError("Error en SeFue user:" & UserList(Userindex).Name)
End Sub
'## listo
Private Sub DevolverParticipantesH(ring As Integer)
On Error GoTo erri

    If Rings2v2(ring).Pareja1.User1 > 0 Then Call WarpUserChar(Rings2v2(ring).Pareja1.User1, 160, 52, 57, True)
    If Rings2v2(ring).Pareja1.User1 > 0 Then Call WarpUserChar(Rings2v2(ring).Pareja1.User2, 160, 53, 57, True)
    If Rings2v2(ring).Pareja1.User1 > 0 Then Call WarpUserChar(Rings2v2(ring).Pareja2.User1, 160, 52, 56, True)
    If Rings2v2(ring).Pareja1.User1 > 0 Then Call WarpUserChar(Rings2v2(ring).Pareja2.User2, 160, 53, 56, True)
 
    Call LimpiarUsuarios(ring, 1, False)
    Call LimpiarUsuarios(ring, 2, False)
    Call Limpiarpareja(ring, 1)
    Call Limpiarpareja(ring, 2)

    Rings2v2(ring).CompletoJugando = False
    
Exit Sub
erri:
Call LogError("Error en DevolverParticipantes RETOS: " & ring)

End Sub
Sub Rings(Userindex As Integer)
Dim i As Integer
For i = 1 To 2
If Rings2v2(i).CompletoJugando = True Then Call SendData(ToIndex, Userindex, 0, "||Reto> " & UserList(Rings2v2(i).Pareja1.User1).Name & " - " & UserList(Rings2v2(i).Pareja1.User2).Name & " contra " & UserList(Rings2v2(i).Pareja2.User1).Name & " - " & UserList(Rings2v2(i).Pareja2.User2).Name & FONTTYPE_BLANCO)
Next
End Sub
'## listo
 Private Sub LlevarParejas(ring As Integer)
    Call SendData(ToMap, 0, 160, "||Reto> " & UserList(Rings2v2(ring).Pareja1.User1).Name & " - " & UserList(Rings2v2(ring).Pareja1.User2).Name & " se enfrentan a " & UserList(Rings2v2(ring).Pareja2.User1).Name & " - " & UserList(Rings2v2(ring).Pareja2.User2).Name & FONTTYPE_BLANCO)
Select Case ring
Case 1
    Call WarpUserChar(Rings2v2(ring).Pareja1.User1, 90, 33, 16, True)
    Call WarpUserChar(Rings2v2(ring).Pareja1.User2, 90, 34, 16, True)
    Call WarpUserChar(Rings2v2(ring).Pareja2.User1, 90, 48, 28, True)
    Call WarpUserChar(Rings2v2(ring).Pareja2.User2, 90, 49, 28, True)
Case 2
    Call WarpUserChar(Rings2v2(ring).Pareja1.User1, 90, 34, 42, True)
    Call WarpUserChar(Rings2v2(ring).Pareja1.User2, 90, 35, 42, True)
    Call WarpUserChar(Rings2v2(ring).Pareja2.User1, 90, 48, 52, True)
    Call WarpUserChar(Rings2v2(ring).Pareja2.User2, 90, 49, 52, True)
'Case 3
 '   Call WarpUserChar(Rings2v2(ring).Pareja1.User1, 170, 67, 48, True)
  '  Call WarpUserChar(Rings2v2(ring).Pareja1.User2, 170, 67, 49, True)
   ' Call WarpUserChar(Rings2v2(ring).Pareja2.User1, 170, 83, 60, True)
    'Call WarpUserChar(Rings2v2(ring).Pareja2.User2, 170, 83, 59, True)
'Case 4
 '   Call WarpUserChar(Rings2v2(ring).Pareja1.User1, 170, 63, 18, True)
  '  Call WarpUserChar(Rings2v2(ring).Pareja1.User2, 170, 63, 17, True)
   ' Call WarpUserChar(Rings2v2(ring).Pareja2.User1, 170, 79, 28, True)
    'Call WarpUserChar(Rings2v2(ring).Pareja2.User2, 170, 79, 29, True)
End Select
    Rings2v2(ring).CompletoJugando = True
End Sub
'## listo
Private Sub Limpiarpareja(ring As Integer, pareja As Integer)
If pareja = 1 Then
    Rings2v2(ring).Pareja1.User1 = 0
    Rings2v2(ring).Pareja1.User2 = 0
Else
    Rings2v2(ring).Pareja2.User1 = 0
    Rings2v2(ring).Pareja2.User2 = 0
End If
End Sub
Private Sub LimpiarUsuarios(ring As Integer, pareja As Integer, completo As Boolean)

If pareja = 1 Then
UserList(Rings2v2(ring).Pareja1.User1).flags.EnReto = 0
UserList(Rings2v2(ring).Pareja1.User1).flags.Parejado = 0
UserList(Rings2v2(ring).Pareja1.User2).flags.EnReto = 0
UserList(Rings2v2(ring).Pareja1.User2).flags.Parejado = 0
    If completo Then
        UserList(Rings2v2(ring).Pareja1.User1).flags.pareja = 0
        UserList(Rings2v2(ring).Pareja1.User2).flags.pareja = 0
        Call SendData(ToIndex, Rings2v2(ring).Pareja1.User2, 0, "||Pareja Cancelada." & FONTTYPE_VENENO)
        Call SendData(ToIndex, Rings2v2(ring).Pareja1.User1, 0, "||Pareja Cancelada." & FONTTYPE_VENENO)
    End If

Else
UserList(Rings2v2(ring).Pareja2.User1).flags.EnReto = 0
UserList(Rings2v2(ring).Pareja2.User1).flags.Parejado = 0
UserList(Rings2v2(ring).Pareja2.User2).flags.EnReto = 0
UserList(Rings2v2(ring).Pareja2.User2).flags.Parejado = 0
    If completo Then
        UserList(Rings2v2(ring).Pareja2.User1).flags.pareja = 0
        UserList(Rings2v2(ring).Pareja2.User2).flags.pareja = 0
        Call SendData(ToIndex, Rings2v2(ring).Pareja2.User2, 0, "||Pareja Cancelada." & FONTTYPE_VENENO)
        Call SendData(ToIndex, Rings2v2(ring).Pareja2.User1, 0, "||Pareja Cancelada." & FONTTYPE_VENENO)
    End If

End If

End Sub

 Private Sub Pagar(ring As Integer, pareja As Integer)

        If pareja = 1 Then
            UserList(Rings2v2(ring).Pareja1.User1).Stats.GLD = UserList(Rings2v2(ring).Pareja1.User1).Stats.GLD + 200000
            UserList(Rings2v2(ring).Pareja1.User2).Stats.GLD = UserList(Rings2v2(ring).Pareja1.User2).Stats.GLD + 200000
            UserList(Rings2v2(ring).Pareja1.User1).flags.RetosGanados = UserList(Rings2v2(ring).Pareja1.User1).flags.RetosGanados + 1
            UserList(Rings2v2(ring).Pareja1.User2).flags.RetosGanados = UserList(Rings2v2(ring).Pareja1.User2).flags.RetosGanados + 1
            UserList(Rings2v2(ring).Pareja1.User1).Stats.Reputacion = UserList(Rings2v2(ring).Pareja2.User1).Stats.Reputacion + 5
            UserList(Rings2v2(ring).Pareja1.User2).Stats.Reputacion = UserList(Rings2v2(ring).Pareja2.User2).Stats.Reputacion + 5
            UserList(Rings2v2(ring).Pareja2.User1).flags.RetosPerdidos = UserList(Rings2v2(ring).Pareja2.User1).flags.RetosPerdidos + 1
            UserList(Rings2v2(ring).Pareja2.User2).flags.RetosPerdidos = UserList(Rings2v2(ring).Pareja2.User2).flags.RetosPerdidos + 1
            Call SendUserORO(Rings2v2(ring).Pareja1.User1)
            Call SendUserORO(Rings2v2(ring).Pareja1.User2)
            Call SendUserREP(Rings2v2(ring).Pareja1.User1)
            Call SendUserREP(Rings2v2(ring).Pareja1.User2)
            If UserList(Rings2v2(ring).Pareja1.User1).GuildInfo.GuildName = UserList(Rings2v2(ring).Pareja1.User2).GuildInfo.GuildName Then Call SumarPuntoRetoClan(UserList(Rings2v2(ring).Pareja1.User1).GuildInfo.GuildName)
            If UserList(Rings2v2(ring).Pareja2.User1).GuildInfo.GuildName = UserList(Rings2v2(ring).Pareja2.User2).GuildInfo.GuildName Then Call RestarPuntoRetoClan(UserList(Rings2v2(ring).Pareja2.User2).GuildInfo.GuildName)
        ElseIf pareja = 2 Then
            UserList(Rings2v2(ring).Pareja2.User1).Stats.GLD = UserList(Rings2v2(ring).Pareja2.User1).Stats.GLD + 200000
            UserList(Rings2v2(ring).Pareja2.User2).Stats.GLD = UserList(Rings2v2(ring).Pareja2.User2).Stats.GLD + 200000
            UserList(Rings2v2(ring).Pareja2.User1).flags.RetosGanados = UserList(Rings2v2(ring).Pareja2.User1).flags.RetosGanados + 1
            UserList(Rings2v2(ring).Pareja2.User2).flags.RetosGanados = UserList(Rings2v2(ring).Pareja2.User2).flags.RetosGanados + 1
            UserList(Rings2v2(ring).Pareja2.User1).Stats.Reputacion = UserList(Rings2v2(ring).Pareja2.User1).Stats.Reputacion + 5
            UserList(Rings2v2(ring).Pareja2.User2).Stats.Reputacion = UserList(Rings2v2(ring).Pareja2.User2).Stats.Reputacion + 5
            UserList(Rings2v2(ring).Pareja1.User1).flags.RetosPerdidos = UserList(Rings2v2(ring).Pareja1.User1).flags.RetosPerdidos + 1
            UserList(Rings2v2(ring).Pareja1.User2).flags.RetosPerdidos = UserList(Rings2v2(ring).Pareja1.User2).flags.RetosPerdidos + 1
            Call SendUserREP(Rings2v2(ring).Pareja2.User1)
            Call SendUserREP(Rings2v2(ring).Pareja2.User2)
            Call SendUserORO(Rings2v2(ring).Pareja2.User1)
            Call SendUserORO(Rings2v2(ring).Pareja2.User2)
            If UserList(Rings2v2(ring).Pareja2.User1).GuildInfo.GuildName = UserList(Rings2v2(ring).Pareja2.User2).GuildInfo.GuildName Then Call SumarPuntoRetoClan(UserList(Rings2v2(ring).Pareja2.User2).GuildInfo.GuildName)
            If UserList(Rings2v2(ring).Pareja1.User1).GuildInfo.GuildName = UserList(Rings2v2(ring).Pareja1.User2).GuildInfo.GuildName Then Call RestarPuntoRetoClan(UserList(Rings2v2(ring).Pareja1.User2).GuildInfo.GuildName)
        End If
     
End Sub

 Private Sub SumarPuntoRetoClan(UserClan As String)
On Error Resume Next
If Len(UserClan) < 1 Then Exit Sub
Dim cad As Integer
Dim Carpeta As String
Carpeta = App.Path & "\Retos2v2\" & UserClan & ".DAT"
cad = val(GetVar(Carpeta, "MAIN", "GANADOS"))
Call WriteVar(Carpeta, "MAIN", "GANADOS", str(cad + 1))


End Sub

Private Function RingLibre() As Integer
Dim i As Integer
For i = 1 To 2
    If Rings2v2(i).CompletoJugando = False Then
        RingLibre = i
        Exit Function
    End If
Next
RingLibre = -1
End Function
Private Sub RestarPuntoRetoClan(UserClan As String)
On Error Resume Next
If Len(UserClan) < 1 Then Exit Sub
Dim cad As Integer
Dim Carpeta As String
Carpeta = App.Path & "\Retos2v2\" & UserClan & ".DAT"
cad = val(GetVar(Carpeta, "MAIN", "PERDIDOS"))
Call WriteVar(Carpeta, "MAIN", "PERDIDOS", str(cad + 1))

End Sub
Public Sub PedirPareja(Userindex As Integer, Reto2vs2TU As Integer)

If ParejasDesactivado Then Exit Sub
If UserList(Userindex).flags.EnReto Then Exit Sub

If Distancia(UserList(Reto2vs2TU).POS, UserList(Userindex).POS) > 4 Then
                Call SendData(ToIndex, Userindex, 0, "DL")
                Exit Sub
          End If

If Reto2vs2TU = Userindex Then Exit Sub '' no me auto invito
If Reto2vs2TU <= 0 Then
        Call SendData(ToIndex, Userindex, 0, "||Debes seleccionar a alguien de pareja." & FONTTYPE_VENENO)
Exit Sub
End If

If UserList(Reto2vs2TU).flags.EnReto Then Exit Sub
If UserList(Userindex).flags.pareja > 0 Then Exit Sub
If UserList(Reto2vs2TU).flags.pareja > 0 Then Exit Sub

    If UserList(Reto2vs2TU).PartyIndex > 0 And MOD_EVENTO_Retos3vs3.EsPartyInscripto(UserList(Reto2vs2TU).PartyIndex) = True Then
        Call SendData(ToIndex, Userindex, 0, "||Error: Tu pareja esta anotado para 3vs3." & FONTTYPE_RETOS)
        Exit Sub
    End If
    
        If UserList(Userindex).PartyIndex > 0 And MOD_EVENTO_Retos3vs3.EsPartyInscripto(UserList(Userindex).PartyIndex) = True Then
        Call SendData(ToIndex, Userindex, 0, "||Error: Estás anotado para 3vs3." & FONTTYPE_RETOS)
        Exit Sub
    End If

If UserList(Userindex).Stats.GLD < 100000 Or UserList(Reto2vs2TU).Stats.GLD < 100000 Then
Call SendData(ToIndex, Userindex, 0, "||Tu o tu pareja no tienen suficiente oro necesario: 100.000 monedas de oro." & FONTTYPE_VENENO)
Exit Sub
End If


        
    UserList(Reto2vs2TU).flags.Parejado = Userindex
    UserList(Userindex).flags.Parejado = Reto2vs2TU
    Call SendData(ToIndex, Userindex, 0, "||Le has pedido ser su pareja a " & UserList(Reto2vs2TU).Name & FONTTYPE_gms)
    Call SendData(ToIndex, Reto2vs2TU, 0, "||" & UserList(Userindex).Name & " te ha pedido ser su pareja /SIPAREJA." & FONTTYPE_gms)
   
End Sub
Public Sub AceptarPareja(Userindex As Integer)
If ParejasDesactivado Then Exit Sub
If UserList(Userindex).flags.EnReto Then Exit Sub
Dim QuienPide As Integer
    QuienPide = UserList(Userindex).flags.Parejado
    If UserList(QuienPide).flags.EnReto Then Exit Sub
    If QuienPide < 1 Then Exit Sub
    If UserList(QuienPide).flags.pareja > 0 Then Exit Sub
    If UserList(Userindex).flags.pareja > 0 Then Exit Sub
    If UserList(QuienPide).flags.Parejado < 1 Then Exit Sub
    If UserList(QuienPide).flags.Parejado <> Userindex Then Exit Sub
    If UserList(QuienPide).flags.UserLogged = False Then Exit Sub

    If UserList(QuienPide).PartyIndex > 0 And MOD_EVENTO_Retos3vs3.EsPartyInscripto(UserList(QuienPide).PartyIndex) = True Then
        Call SendData(ToIndex, Userindex, 0, "||Error: tu pareja esta anotado para 3vs3" & FONTTYPE_RETOS)
        Exit Sub
    End If
    
        If UserList(Userindex).PartyIndex > 0 And MOD_EVENTO_Retos3vs3.EsPartyInscripto(UserList(Userindex).PartyIndex) = True Then
        Call SendData(ToIndex, Userindex, 0, "||Error: Estás anotado para 3vs3." & FONTTYPE_RETOS)
        Exit Sub
    End If

If UserList(Userindex).Stats.GLD < 100000 Or UserList(QuienPide).Stats.GLD < 100000 Then
Call SendData(ToIndex, Userindex, 0, "||Tu o tu pareja no tienen suficiente oro necesario: 100.000 monedas de oro." & FONTTYPE_VENENO)
Exit Sub
End If


UserList(Userindex).flags.pareja = QuienPide
UserList(QuienPide).flags.pareja = Userindex
UserList(Userindex).flags.Parejado = 0
UserList(QuienPide).flags.Parejado = 0

Call SendData(ToIndex, Userindex, 0, "||Has aceptado ser la pareja de " & UserList(QuienPide).Name & " para cancelar escribe /DISOLVER." & FONTTYPE_BLANCO)
Call SendData(ToIndex, QuienPide, 0, "||" & UserList(Userindex).Name & " ha aceptado ser tu pareja, para cancelar escribe /DISOLVER." & FONTTYPE_BLANCO)
Call SendData(ToIndex, Userindex, 0, "||Para incribirse uno de los parejados debe tipear, /JUGAR." & FONTTYPE_gms)
Call SendData(ToIndex, QuienPide, 0, "||Para incribirse uno de los parejados debe tipear, /JUGAR." & FONTTYPE_gms)


End Sub
Public Sub Jugar(Userindex As Integer)
If ParejasDesactivado Then Exit Sub
Dim MiPareja As Integer
    MiPareja = UserList(Userindex).flags.pareja
 If MiPareja < 1 Then Exit Sub
 
If Not UserList(MiPareja).flags.pareja = Userindex Then Exit Sub

If UserList(MiPareja).POS.Map <> 160 Then Exit Sub
If UserList(MiPareja).flags.Muerto = 1 Then Exit Sub
If UserList(MiPareja).flags.EnReto Then Exit Sub

If UserList(Userindex).POS.Map <> 160 Then Exit Sub
If UserList(Userindex).flags.Muerto = 1 Then Exit Sub
If UserList(Userindex).flags.EnReto Then Exit Sub

If UserList(MiPareja).flags.UserLogged = False Then Exit Sub

Dim libre As Integer
libre = RingLibre
 If libre < 0 Then
        Call SendData(ToIndex, Userindex, 0, "||Todos los Rings están ocupados, tipeá /RETANDO para ver quienes estan combatiendo." & FONTTYPE_gms)
        Exit Sub
 End If

If UserList(Userindex).Stats.GLD < 100000 Or UserList(MiPareja).Stats.GLD < 100000 Then
Call SendData(ToIndex, Userindex, 0, "||Tu o tu pareja no tienen suficiente oro necesario: 100.000 monedas de oro." & FONTTYPE_VENENO)
Exit Sub
End If

If JugandoEnQueRing(Userindex) > 0 Then
Call SendData(ToIndex, Userindex, 0, "||Ya estaban inscriptos" & FONTTYPE_VENENO)
Exit Sub
End If





UserList(Userindex).flags.EnReto = 1
UserList(MiPareja).flags.EnReto = 1

UserList(Userindex).Stats.GLD = UserList(Userindex).Stats.GLD - 100000
UserList(MiPareja).Stats.GLD = UserList(MiPareja).Stats.GLD - 100000

    If Rings2v2(libre).Pareja1.User1 < 1 Then
        Rings2v2(libre).Pareja1.User1 = Userindex
        Rings2v2(libre).Pareja1.User2 = MiPareja
        Call ControlarRings(libre)
    Else
        Rings2v2(libre).Pareja2.User1 = Userindex
        Rings2v2(libre).Pareja2.User2 = MiPareja
    End If

        Call SendData(ToIndex, Userindex, 0, "||¡Pareja inscripta!" & FONTTYPE_VENENO)
        Call SendData(ToIndex, MiPareja, 0, "||¡Pareja inscripta" & FONTTYPE_VENENO)
        
If Rings2v2(libre).Pareja1.User1 > 0 And Rings2v2(libre).Pareja2.User1 > 0 Then
    Call LlevarParejas(libre)
End If
End Sub
Private Sub ControlarRings(actual As Integer)
Dim i As Integer
For i = (actual + 1) To 2
    If Rings2v2(i).CompletoJugando = False Then '' ring incompleto
        If Rings2v2(i).Pareja1.User1 > 0 Then '' hacemos el cambio
            Rings2v2(actual).Pareja2.User1 = Rings2v2(i).Pareja1.User1
            Rings2v2(actual).Pareja2.User2 = Rings2v2(i).Pareja1.User2
            Rings2v2(i).Pareja1.User2 = 0
            Rings2v2(i).Pareja1.User1 = 0
        End If
    End If
Next
End Sub


