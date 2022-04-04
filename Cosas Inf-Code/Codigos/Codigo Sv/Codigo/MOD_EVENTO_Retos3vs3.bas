Attribute VB_Name = "MOD_EVENTO_Retos3vs3"
 
'director del proyecto: #Esteban(Neliam)

'servidor basado en fénixao 1.0
'medios de contacto:
'Skype: dc.esteban
'E-mail: nabrianao@gmail.com
Option Explicit
Public Type trio
User1 As Integer
User2 As Integer
User3 As Integer
Party As Integer
End Type

Private CompletoJugando As Boolean
Private Trio1 As trio
Private Trio2 As trio
Public Function EsMapa(Mapa As Integer) As Boolean
EsMapa = False
If Mapa = 8 Then EsMapa = True
End Function

Public Sub DebugTrio()
Call DevolverParticipantesH
Limpiartrio (1)
CompletoJugando = False
Call SendData(ToAdmins, 0, 0, "||Admin's: Retos 3 Desbugeados." & FONTTYPE_gms)
End Sub

Public Sub MuereUser(Userindex As Integer)

If Trio1.Party = 0 Or Trio2.Party = 0 Then Exit Sub

If UserList(Userindex).PartyIndex = Trio1.Party Or UserList(Userindex).PartyIndex = Trio2.Party Then
If UserList(Trio1.User1).flags.Muerto = 1 And _
    UserList(Trio1.User2).flags.Muerto = 1 And _
    UserList(Trio1.User3).flags.Muerto = 1 Then
      'TERMINADO

            UserList(Trio1.User1).flags.RetosGanados = UserList(Trio1.User1).flags.RetosGanados + 1
            UserList(Trio1.User2).flags.RetosGanados = UserList(Trio1.User2).flags.RetosGanados + 1
            UserList(Trio1.User3).flags.RetosGanados = UserList(Trio1.User3).flags.RetosGanados + 1
            UserList(Trio2.User1).flags.RetosGanados = UserList(Trio1.User1).flags.RetosPerdidos + 1
            UserList(Trio2.User2).flags.RetosGanados = UserList(Trio1.User2).flags.RetosPerdidos + 1
            UserList(Trio2.User3).flags.RetosGanados = UserList(Trio1.User3).flags.RetosPerdidos + 1
            
            UserList(Trio1.User1).Stats.Reputacion = UserList(Trio1.User1).Stats.Reputacion + 5
            UserList(Trio1.User2).Stats.Reputacion = UserList(Trio1.User2).Stats.Reputacion + 5
            UserList(Trio1.User3).Stats.Reputacion = UserList(Trio1.User3).Stats.Reputacion + 5
            
            Call SendUserREP(Trio1.User1)
            Call SendUserREP(Trio1.User2)
            Call SendUserREP(Trio1.User3)
            

        Call Pagar(2)
        Call SendData(ToMap, 0, 160, "||Reto> " & UserList(Trio2.User1).Name & " - " & UserList(Trio2.User2).Name & " - " & UserList(Trio2.User3).Name & " derrotaron a " & _
        UserList(Trio1.User1).Name & " - " & UserList(Trio1.User2).Name & " - " & UserList(Trio1.User3).Name & FONTTYPE_BLANKO)
        Call DevolverParticipantesH
                
ElseIf UserList(Trio2.User1).flags.Muerto = 1 And _
        UserList(Trio2.User2).flags.Muerto = 1 And _
        UserList(Trio2.User3).flags.Muerto = 1 Then
      'TERMINADO

            UserList(Trio2.User1).flags.RetosGanados = UserList(Trio2.User1).flags.RetosGanados + 1
            UserList(Trio2.User2).flags.RetosGanados = UserList(Trio2.User2).flags.RetosGanados + 1
            UserList(Trio2.User3).flags.RetosGanados = UserList(Trio2.User3).flags.RetosGanados + 1
            UserList(Trio1.User1).flags.RetosGanados = UserList(Trio1.User1).flags.RetosPerdidos + 1
            UserList(Trio1.User2).flags.RetosGanados = UserList(Trio1.User2).flags.RetosPerdidos + 1
            UserList(Trio1.User3).flags.RetosGanados = UserList(Trio1.User3).flags.RetosPerdidos + 1
            
            UserList(Trio2.User1).Stats.Reputacion = UserList(Trio2.User1).Stats.Reputacion + 5
            UserList(Trio2.User2).Stats.Reputacion = UserList(Trio2.User2).Stats.Reputacion + 5
            UserList(Trio2.User3).Stats.Reputacion = UserList(Trio2.User3).Stats.Reputacion + 5
            
            Call SendUserREP(Trio2.User1)
            Call SendUserREP(Trio2.User2)
            Call SendUserREP(Trio2.User3)

            
        Call Pagar(1)
            Call SendData(ToMap, 0, 160, "||Reto> " & UserList(Trio1.User1).Name & " - " & UserList(Trio1.User2).Name & " - " & UserList(Trio1.User3).Name & " derrotaron a " & _
        UserList(Trio2.User1).Name & " - " & UserList(Trio2.User2).Name & " - " & UserList(Trio2.User3).Name & FONTTYPE_BLANKO)
        Call DevolverParticipantesH
            
ElseIf Trio1.User1 = Userindex Or Trio1.User2 Or Trio1.User3 = Userindex Then
    
ElseIf Trio2.User1 = Userindex Or Trio2.User2 Or Trio2.User3 = Userindex Then
      
End If
End If
End Sub
'## listo
Private Sub CancelarReto(PartyIndex As Integer)
If PartyIndex = 0 Then Exit Sub
If Trio1.Party = PartyIndex Then
    Call Pagar(2)
ElseIf Trio2.Party = PartyIndex Then
    Call Pagar(1)
End If

Call DevolverParticipantesH
Call SendData(ToMap, 0, 160, "||Reto> Reto 3vs3 cancelado." & FONTTYPE_BLANKO)
CompletoJugando = False

End Sub
'## listo
Public Sub PartyAlterado(PartyIndex As Integer)
On Error GoTo Wepa
If PartyIndex = 0 Then Exit Sub
If PartyIndex = Trio1.Party Or PartyIndex = Trio2.Party Then
    If CompletoJugando = True Then
        Call CancelarReto(PartyIndex)
    ElseIf CompletoJugando = False Then
        If Trio1.Party = PartyIndex Then
        Call SendData(ToParty, Trio1.User1, 0, "||Reto> Party alterado: echados del reto" & FONTTYPE_BLANKO)
            Call Limpiartrio(1)
        End If
        If Trio2.Party = PartyIndex Then
            Call SendData(ToParty, Trio2.User1, 0, "||Reto> Party alterado: echados del reto" & FONTTYPE_BLANKO)
            Call Limpiartrio(2)
        End If
    End If
End If
Exit Sub
Wepa:
Call LogError("Error en PartyAlterado")
End Sub
Sub SeFueD(Userindex As Integer)
On Error GoTo Wepa
If UserList(Userindex).PartyIndex = 0 Then Exit Sub

If UserList(Userindex).PartyIndex = Trio1.Party Or UserList(Userindex).PartyIndex = Trio2.Party Then
    If CompletoJugando = True Then
        Call CancelarReto(UserList(Userindex).PartyIndex)
    ElseIf CompletoJugando = False Then
        If Trio1.User1 = Userindex Or Trio1.User2 = Userindex Or Trio1.User3 = Userindex Then
Call SendData(ToParty, Userindex, 0, "||Trio Cancelado" & FONTTYPE_VENENO)
            Call Limpiartrio(1)
        End If
        If Trio2.User1 = Userindex Or Trio2.User2 = Userindex Or Trio2.User3 = Userindex Then
Call SendData(ToParty, Userindex, 0, "||Trio Cancelado" & FONTTYPE_VENENO)
            Call Limpiartrio(2)
        End If
    End If
End If
Exit Sub
Wepa:
Call LogError("Error en SeFue user:" & UserList(Userindex).Name)
End Sub

'## listo
Private Sub DevolverParticipantesH()
On Error GoTo erri

    If Trio1.User1 > 0 Then Call WarpUserChar(Trio1.User1, 160, 52, 34, True)
    If Trio1.User2 > 0 Then Call WarpUserChar(Trio1.User2, 160, 53, 34, True)
    If Trio1.User3 > 0 Then Call WarpUserChar(Trio1.User3, 160, 54, 34, True)
    If Trio2.User1 > 0 Then Call WarpUserChar(Trio2.User1, 160, 52, 35, True)
    If Trio2.User2 > 0 Then Call WarpUserChar(Trio2.User2, 160, 53, 35, True)
    If Trio2.User3 > 0 Then Call WarpUserChar(Trio2.User3, 160, 54, 35, True)
    
    Call Limpiartrio(1)
    Call Limpiartrio(2)
    CompletoJugando = False
    
Exit Sub
erri:
Call LogError("Error en DevolverParticipantesH RETOS3")

End Sub
Public Sub Trios(Userindex As Integer)
If CompletoJugando = True Then Call SendData(ToIndex, Userindex, 0, "||Reto> " & UserList(Trio1.User1).Name & " - " & UserList(Trio1.User2).Name & " - " & UserList(Trio1.User3).Name & " contra " & UserList(Trio2.User1).Name & " - " & UserList(Trio2.User2).Name & " - " & UserList(Trio2.User3).Name & FONTTYPE_BLANKO)
End Sub
'## listo
Private Sub Llevartrios()
    Call SendData(ToMap, 0, 160, "||Reto> " & UserList(Trio1.User1).Name & " - " & UserList(Trio1.User2).Name & " - " & UserList(Trio1.User3).Name & " contra " & UserList(Trio2.User1).Name & " - " & UserList(Trio2.User2).Name & " - " & UserList(Trio2.User3).Name & FONTTYPE_BLANKO)

    Call WarpUserChar(Trio1.User1, 90, 62, 20, True)
    Call WarpUserChar(Trio1.User2, 90, 63, 20, True)
    Call WarpUserChar(Trio1.User3, 90, 62, 21, True)
    Call WarpUserChar(Trio2.User1, 90, 80, 32, True)
    Call WarpUserChar(Trio2.User2, 90, 80, 33, True)
    Call WarpUserChar(Trio2.User3, 90, 79, 33, True)
    CompletoJugando = True
End Sub
'## listo
Private Sub Limpiartrio(trio As Integer)
If trio = 1 Then
    Trio1.User1 = 0
    Trio1.User2 = 0
    Trio1.User3 = 0
    Trio1.Party = 0
ElseIf trio = 2 Then
    Trio2.User1 = 0
    Trio2.User2 = 0
    Trio2.User3 = 0
    Trio2.Party = 0
End If
End Sub
Public Sub Cancelar(Userindex As Integer)
SeFueD (Userindex)

End Sub
Private Sub Pagar(pareja As Integer)
        If pareja = 1 Then
           ' Call SendUserStatsBox(Trio1.User1)
           ' Call SendUserStatsBox(Trio1.User2)
           ' Call SendUserStatsBox(Trio1.User3)

      ElseIf pareja = 2 Then
           ' Call SendUserStatsBox(Trio2.User1)
           ' Call SendUserStatsBox(Trio2.User2)
           ' Call SendUserStatsBox(Trio2.User3)

    End If
     
End Sub
Private Function TodosVivosTrio() As Boolean
If Trio1.Party = 0 Then
 TodosVivosTrio = False
Exit Function
End If

 If (UserList(Party(Trio1.Party).MiembrosIndex(1)).flags.Muerto = 1) Or _
    (UserList(Party(Trio1.Party).MiembrosIndex(2)).flags.Muerto = 1) Or _
    (UserList(Party(Trio1.Party).MiembrosIndex(3)).flags.Muerto = 1) Then
        TodosVivosTrio = False
         Call SendData(ToParty, Trio1.User1, 0, "||Echados del 3vs3, alguien está muerto" & FONTTYPE_BLANCO)
        Else
        TodosVivosTrio = True
    End If
End Function
Public Function EsPartyInscripto(userparty As Integer) As Boolean
If userparty = 0 Then
EsPartyInscripto = False
Exit Function
End If

If userparty = Trio1.Party Or userparty = Trio2.Party Then
EsPartyInscripto = True
Else
EsPartyInscripto = False
End If
End Function
Public Sub inscribir(Userindex As Integer)
If UserList(Userindex).PartyIndex = 0 Then Exit Sub
Dim partyact As Integer
partyact = UserList(Userindex).PartyIndex

If Party(partyact).MiembrosIndex(1) <> Userindex Then
        Call SendData(ToIndex, Userindex, 0, "||Solo el lider del party puede anotarlos al 3vs3" & FONTTYPE_VENENO)
        Exit Sub
End If
    
If Party(partyact).NroMiembros < 3 Then
     Call SendData(ToIndex, Userindex, 0, "||Debe haber 3 en el party para jugar" & FONTTYPE_VENENO)
        Exit Sub
    End If
    
 If partyact = Trio1.Party Or partyact = Trio2.Party Then
        Call SendData(ToIndex, Userindex, 0, "||Ya inscriptos" & FONTTYPE_RETOS)
        Exit Sub
 End If
 
 If CompletoJugando = True Then
        Call SendData(ToIndex, Userindex, 0, "||Ring 3vs3 ocupado" & FONTTYPE_RETOS)
        Exit Sub
 End If
 
    
    If Party(partyact).NroMiembros > 3 Then
     Call SendData(ToIndex, Userindex, 0, "||Solo puede haber 3 en el party para jugar" & FONTTYPE_VENENO)
        Exit Sub
    End If
            
                
    If (UserList(Party(partyact).MiembrosIndex(1)).flags.pareja > 0) Or _
    (UserList(Party(partyact).MiembrosIndex(2)).flags.pareja > 0) Or _
    (UserList(Party(partyact).MiembrosIndex(3)).flags.pareja > 0) Then
        Call SendData(ToIndex, Userindex, 0, "||Ninguno de los 3 debe estar jugando retos 2 vs 2" & FONTTYPE_VENENO)
        Exit Sub
    End If

    
    If (UserList(Party(partyact).MiembrosIndex(1)).flags.Muerto = 1) Or _
    (UserList(Party(partyact).MiembrosIndex(2)).flags.Muerto = 1) Or _
    (UserList(Party(partyact).MiembrosIndex(3)).flags.Muerto = 1) Then
        Call SendData(ToIndex, Userindex, 0, "||Los 3 deben estar vivos" & FONTTYPE_VENENO)
        Exit Sub
    End If
    
    If (UserList(Party(partyact).MiembrosIndex(1)).POS.Map <> 160) Or _
    (UserList(Party(partyact).MiembrosIndex(2)).POS.Map <> 160) Or _
    (UserList(Party(partyact).MiembrosIndex(3)).POS.Map <> 160) Then
        Call SendData(ToIndex, Userindex, 0, "||Los 3 deben estar en el mapa 32" & FONTTYPE_VENENO)
        Exit Sub
    End If
 
 
 Call SendData(ToParty, Userindex, 0, "||Inscriptos al 3vs3, para cancelar el trio pon /DISOLVER." & FONTTYPE_BLANCO)
    


    If Trio1.User1 < 1 Or Not TodosVivosTrio Then
        Trio1.User1 = Party(partyact).MiembrosIndex(1)
        Trio1.User2 = Party(partyact).MiembrosIndex(2)
        Trio1.User3 = Party(partyact).MiembrosIndex(3)
        Trio1.Party = partyact
    Else
    
        Trio2.User1 = Party(partyact).MiembrosIndex(1)
        Trio2.User2 = Party(partyact).MiembrosIndex(2)
        Trio2.User3 = Party(partyact).MiembrosIndex(3)
        Trio2.Party = partyact
    End If

    If Trio1.Party > 0 And Trio2.Party > 0 Then
        Call Llevartrios
    End If

Exit Sub
    
End Sub


