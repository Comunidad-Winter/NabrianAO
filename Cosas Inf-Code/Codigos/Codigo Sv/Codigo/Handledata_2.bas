Attribute VB_Name = "Handledata_2"
 
'director del proyecto: #Esteban(Neliam)

'servidor basado en fénixao 1.0
'medios de contacto:
'Skype: dc.esteban
'E-mail: nabrianao@gmail.com
Public Sub HandleData2(Userindex As Integer, rdata As String, Procesado As Boolean)
Dim loopc As Integer, Tindex As Integer, N As Integer, X As Integer, y As Integer, tInt As Integer
Dim nPos As WorldPos
Dim tStr As String
Dim tLong As Long

Procesado = True

Select Case Left$(UCase$(rdata), 2)
    Case "#*"
        rdata = Right$(rdata, Len(rdata) - 2)
        Tindex = NameIndex(rdata)
        If Tindex Then
            If UserList(Tindex).flags.Privilegios < 2 Then
                Call SendData(ToIndex, Userindex, 0, "||El jugador " & UserList(Tindex).Name & " se encuentra online." & FONTTYPE_INFO)
            Else: Call SendData(ToIndex, Userindex, 0, "1A")
            End If
        Else: Call SendData(ToIndex, Userindex, 0, "1A")
        End If
        Exit Sub
    Case "#}"
        UserList(Userindex).flags.MesaCasino = 0
        Call SendUserORO(Userindex)
        Exit Sub
        
    Case "^A"
        rdata = Right$(rdata, Len(rdata) - 2)
        Call SendData(ToAdmins, 0, 0, "||" & UserList(Userindex).Name & ": " & rdata & FONTTYPE_FIGHT)
        Exit Sub
    
    Case "#$"
        rdata = Right$(rdata, Len(rdata) - 2)
        If UserList(Userindex).flags.Privilegios < 2 Then Exit Sub
        X = ReadField(1, rdata, 44)
        y = ReadField(2, rdata, 44)
        N = MapaPorUbicacion(X, y)
        If N Then Call WarpUserChar(Userindex, N, 50, 50, True)
        Call LogGM(UserList(Userindex).Name, "Se transporto por mapa a Mapa" & Mapa & " X:" & X & " Y:" & y, (UserList(Userindex).flags.Privilegios = 1))
        Exit Sub
    
    Case "#A"
        If UserList(Userindex).flags.Muerto Then
            Call SendData(ToIndex, Userindex, 0, "MU")
            Exit Sub
        End If
        If Not UserList(Userindex).flags.Meditando And UserList(Userindex).Stats.MinMAN = UserList(Userindex).Stats.MaxMAN Then Exit Sub
        Call SendData(ToIndex, Userindex, 0, "MEDOK")
        If Not UserList(Userindex).flags.Meditando Then
           Call SendData(ToIndex, Userindex, 0, "7M")
        Else
           Call SendData(ToIndex, Userindex, 0, "D9")
        End If
        UserList(Userindex).flags.Meditando = Not UserList(Userindex).flags.Meditando
        
        If UserList(Userindex).flags.Meditando Then
            UserList(Userindex).Counters.tInicioMeditar = Timer
            Call SendData(ToIndex, Userindex, 0, "8M" & TIEMPO_INICIOMEDITAR)


            UserList(Userindex).Char.loops = LoopAdEternum
            If UserList(Userindex).flags.Templario = 1 Then
            
            Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "CFX" & UserList(Userindex).Char.CharIndex & "," & UserList(Userindex).Char.CharIndex & "," & FXMEDITARTEMPLARIO & "," & 0 & "," & LoopAdEternum) 'dx8
            UserList(Userindex).Char.FX = FXMEDITARTEMPLARIO
            Else
            
       If UserList(Userindex).Stats.ELV < 15 Then
                Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "CFX" & UserList(Userindex).Char.CharIndex & "," & UserList(Userindex).Char.CharIndex & "," & FXMEDITARCHICO & "," & 0 & "," & LoopAdEternum) 'dx8
                Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "CFF" & UserList(Userindex).Char.CharIndex & "," & UserList(Userindex).Stats.ELV) 'dx8
                UserList(Userindex).Char.FX = FXMEDITARCHICO
            ElseIf UserList(Userindex).Stats.ELV < 30 Then
                Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "CFX" & UserList(Userindex).Char.CharIndex & "," & UserList(Userindex).Char.CharIndex & "," & FXMEDITARMEDIANO & "," & 0 & "," & LoopAdEternum) 'dx8
                Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "CFF" & UserList(Userindex).Char.CharIndex & "," & UserList(Userindex).Stats.ELV)  'dx8
                UserList(Userindex).Char.FX = FXMEDITARMEDIANO
            ElseIf UserList(Userindex).Stats.ELV < 50 Then
                Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "CFX" & UserList(Userindex).Char.CharIndex & "," & UserList(Userindex).Char.CharIndex & "," & FXMEDITARGRANDE & "," & 0 & "," & LoopAdEternum) 'dx8
                Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "CFF" & UserList(Userindex).Char.CharIndex & "," & UserList(Userindex).Stats.ELV)  'dx8
                UserList(Userindex).Char.FX = FXMEDITARGRANDE
            ElseIf UserList(Userindex).Stats.ELV < 51 Then
                Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "CFX" & UserList(Userindex).Char.CharIndex & "," & UserList(Userindex).Char.CharIndex & "," & FXMEDITARGIGANTE & "," & 0 & "," & LoopAdEternum) 'dx8
                Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "CFF" & UserList(Userindex).Char.CharIndex & "," & UserList(Userindex).Stats.ELV)  'dx8
                UserList(Userindex).Char.FX = FXMEDITARGIGANTE
            End If
            End If
            Else
                UserList(Userindex).Char.FX = 0
                UserList(Userindex).Char.loops = 0
                Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "CFX" & UserList(Userindex).Char.CharIndex & "," & UserList(Userindex).Char.CharIndex & "," & 0 & "," & 0 & "," & 0) 'dx8
        End If
        Exit Sub
    Case "#B"
        If UserList(Userindex).flags.Paralizado Then Exit Sub
    
        If (Not MapInfo(UserList(Userindex).POS.Map).Pk And TiempoTranscurrido(UserList(Userindex).Counters.LastRobo) > 10) Or UserList(Userindex).flags.Privilegios > 1 Then
            Call SendData(ToIndex, Userindex, 0, "FINOK")
            Call CloseSocket(Userindex)
            Exit Sub
        End If
    
        Call Cerrar_Usuario(Userindex)
        
        Exit Sub

    Case "#C"
        If CanCreateGuild(Userindex) Then Call SendData(ToIndex, Userindex, 0, "SHOWFUN" & UserList(Userindex).Faccion.Bando)
        Exit Sub
    
    Case "#D"
        Call SendData(ToIndex, Userindex, 0, "7L")
        Exit Sub
    
    Case "#G"
        
        If UserList(Userindex).flags.Muerto Then
                  Call SendData(ToIndex, Userindex, 0, "MU")
                  Exit Sub
        End If
        
        If UserList(Userindex).flags.TargetNpc = 0 Then
              Call SendData(ToIndex, Userindex, 0, "ZP")
              Exit Sub
        End If
        If Distancia(Npclist(UserList(Userindex).flags.TargetNpc).POS, UserList(Userindex).POS) > 3 Then
                  Call SendData(ToIndex, Userindex, 0, "DL")
                  Exit Sub
        End If
        If Npclist(UserList(Userindex).flags.TargetNpc).NPCtype <> NPCTYPE_BANQUERO _
        Or UserList(Userindex).flags.Muerto Then Exit Sub

        Call SendData(ToIndex, Userindex, 0, "3Q" & vbWhite & "°" & "Tenes " & UserList(Userindex).Stats.Banco & " monedas de oro en tu cuenta." & "°" & Npclist(UserList(Userindex).flags.TargetNpc).Char.CharIndex)
        Exit Sub
        
    Case "#H"
         
         If UserList(Userindex).flags.Muerto Then
                      Call SendData(ToIndex, Userindex, 0, "MU")
                      Exit Sub
         End If
         
         If UserList(Userindex).flags.TargetNpc = 0 Then
                  Call SendData(ToIndex, Userindex, 0, "ZP")
                  Exit Sub
         End If
         If Distancia(Npclist(UserList(Userindex).flags.TargetNpc).POS, UserList(Userindex).POS) > 10 Then
                      Call SendData(ToIndex, Userindex, 0, "DL")
                      Exit Sub
         End If
         If Npclist(UserList(Userindex).flags.TargetNpc).MaestroUser <> _
            Userindex Then Exit Sub
         Npclist(UserList(Userindex).flags.TargetNpc).Movement = ESTATICO
         Call Expresar(UserList(Userindex).flags.TargetNpc, Userindex)
         Exit Sub
    Case "#I"
        
        If UserList(Userindex).flags.Muerto Then
                  Call SendData(ToIndex, Userindex, 0, "MU")
                  Exit Sub
        End If
        
        If UserList(Userindex).flags.TargetNpc = 0 Then
              Call SendData(ToIndex, Userindex, 0, "ZP")
              Exit Sub
        End If
        If Distancia(Npclist(UserList(Userindex).flags.TargetNpc).POS, UserList(Userindex).POS) > 10 Then
                  Call SendData(ToIndex, Userindex, 0, "DL")
                  Exit Sub
        End If
        If Npclist(UserList(Userindex).flags.TargetNpc).MaestroUser <> _
          Userindex Then Exit Sub
        Call FollowAmo(UserList(Userindex).flags.TargetNpc)
        Call Expresar(UserList(Userindex).flags.TargetNpc, Userindex)
        Exit Sub
    Case "#J"
        
        If UserList(Userindex).flags.Muerto Then
                  Call SendData(ToIndex, Userindex, 0, "MU")
                  Exit Sub
        End If
        
        If UserList(Userindex).flags.TargetNpc = 0 Then
              Call SendData(ToIndex, Userindex, 0, "ZP")
              Exit Sub
        End If
        If Distancia(Npclist(UserList(Userindex).flags.TargetNpc).POS, UserList(Userindex).POS) > 10 Then
                  Call SendData(ToIndex, Userindex, 0, "DL")
                  Exit Sub
        End If
        If Npclist(UserList(Userindex).flags.TargetNpc).NPCtype <> NPCTYPE_ENTRENADOR Then Exit Sub
        Call EnviarListaCriaturas(Userindex, UserList(Userindex).flags.TargetNpc)
        Exit Sub
    Case "#K"
        If UserList(Userindex).flags.Muerto Then
            Call SendData(ToIndex, Userindex, 0, "MU")
            Exit Sub
        End If
        If HayOBJarea(UserList(Userindex).POS, FOGATA) Then
                Call SendData(ToIndex, Userindex, 0, "DOK")
                If Not UserList(Userindex).flags.Descansar Then
                    Call SendData(ToIndex, Userindex, 0, "3M")
                Else
                    Call SendData(ToIndex, Userindex, 0, "4M")
                End If
                UserList(Userindex).flags.Descansar = Not UserList(Userindex).flags.Descansar
        Else
                If UserList(Userindex).flags.Descansar Then
                    Call SendData(ToIndex, Userindex, 0, "4M")
                    
                    UserList(Userindex).flags.Descansar = False
                    Call SendData(ToIndex, Userindex, 0, "DOK")
                    Exit Sub
                End If
                Call SendData(ToIndex, Userindex, 0, "6M")
        End If
        Exit Sub

    Case "#L"
       
       If UserList(Userindex).flags.TargetNpc = 0 Then
           Call SendData(ToIndex, Userindex, 0, "ZP")
           Exit Sub
       End If
       
       If Npclist(UserList(Userindex).flags.TargetNpc).NPCtype <> NPCTYPE_REVIVIR _
       Or UserList(Userindex).flags.Muerto <> 1 Then Exit Sub
       If Distancia(UserList(Userindex).POS, Npclist(UserList(Userindex).flags.TargetNpc).POS) > 10 Then
           Call SendData(ToIndex, Userindex, 0, "DL")
           Exit Sub
       End If

       Call RevivirUsuarioNPC(Userindex)
       Call SendData(ToIndex, Userindex, 0, "RZ")
       Exit Sub
    Case "#M"
       
       If UserList(Userindex).flags.TargetNpc = 0 Then
           Call SendData(ToIndex, Userindex, 0, "ZP")
           Exit Sub
       End If
       If Npclist(UserList(Userindex).flags.TargetNpc).NPCtype <> NPCTYPE_REVIVIR _
       Or UserList(Userindex).flags.Muerto Then Exit Sub
       If Distancia(UserList(Userindex).POS, Npclist(UserList(Userindex).flags.TargetNpc).POS) > 10 Then
           Call SendData(ToIndex, Userindex, 0, "DL")
           Exit Sub
       End If
       UserList(Userindex).Stats.MinHP = UserList(Userindex).Stats.MaxHP
       Call SendUserHP(Userindex)
       Exit Sub
    Case "#N"
        If UserList(Userindex).flags.Muerto Then Exit Sub
        Call EnviarSubclase(Userindex)
        Exit Sub
    Case "#O"
        If PuedeRecompensa(Userindex) And Not UserList(Userindex).flags.Muerto Then _
        Call SendData(ToIndex, Userindex, 0, "RELON" & UserList(Userindex).Clase & "," & PuedeRecompensa(Userindex))
    Exit Sub
    

    
    Case "#P"
        
        If UserList(Userindex).flags.Privilegios > 0 Then
            For loopc = 1 To LastUser
                If Len(UserList(loopc).Name) > 0 And UserList(loopc).flags.Privilegios <= 1 Then
                    tStr = tStr & UserList(loopc).Name & ", "
                End If
            Next
            If Len(tStr) > 0 Then
                tStr = Left$(tStr, Len(tStr) - 2)
                Call SendData(ToIndex, Userindex, 0, "||" & tStr & FONTTYPE_INFO)
                Call SendData(ToIndex, Userindex, 0, "4L" & NumNoGMs)
            Else
                Call SendData(ToIndex, Userindex, 0, "6L")
            End If
        Else
           Call SendData(ToIndex, Userindex, 0, "4L" & NumNoGMs)
        End If
        Exit Sub

    Case "#Q"
        Call SendUserSTAtsTxt(Userindex, Userindex)
        Exit Sub
    Case "#R"
        If UserList(Userindex).Counters.Pena Then
            Call SendData(ToIndex, Userindex, 0, "9M" & CalcularTiempoCarcel(Userindex))
        Else
            Call SendData(ToIndex, Userindex, 0, "2N")
        End If
        Exit Sub
    Case "#S"
        If UserList(Userindex).flags.TargetUser Then
            If MapData(UserList(UserList(Userindex).flags.TargetUser).POS.Map, UserList(UserList(Userindex).flags.TargetUser).POS.X, UserList(UserList(Userindex).flags.TargetUser).POS.y).OBJInfo.OBJIndex > 0 And _
            UserList(UserList(Userindex).flags.TargetUser).flags.Muerto Then
                Call SendData(ToAdmins, 0, 0, "8T" & UserList(Userindex).Name & "," & UserList(UserList(Userindex).flags.TargetUser).Name)
                Call SendData(ToIndex, UserList(Userindex).flags.TargetUser, 0, "!!Fuiste echado por mantenerte sobre un item estando muerto.")
                Call SendData(ToIndex, UserList(Userindex).flags.TargetUser, 0, "FINOK")
                Call CloseSocket(UserList(Userindex).flags.TargetUser)
            End If
        End If
        Exit Sub
    Case "#)"
         If EVENTOPROTECTORACTIVADO = 0 Then Exit Sub
   

  If UserList(Userindex).Stats.ELV < 40 Then
   Call SendData(ToIndex, Userindex, 0, "||Debes ser nivel 40." & FONTTYPE_INFO)
  Exit Sub
  End If
 
      If MapInfo(UserList(Userindex).POS.Map).Pk = True Then
    Call SendData(ToIndex, Userindex, 0, "||Debes estar en una ciudad" & FONTTYPE_TALK)
    Exit Sub
    End If
    
    
    
         If UserList(Userindex).PartyIndex > 0 And MOD_EVENTO_Retos3vs3.EsPartyInscripto(UserList(Userindex).PartyIndex) = True Then
        Call SendData(ToIndex, Userindex, 0, "||Error: Estás anotado para 3vs3." & FONTTYPE_RETOS)
        Exit Sub
    End If
    
     If UserList(Userindex).POS.Map = Prision.Map Then
            Call SendData(ToIndex, Userindex, 0, "||Estas en la carcel" & FONTTYPE_INFO)
            Exit Sub
        End If
    
          If UserList(Userindex).POS.Map = 193 Then
            Call SendData(ToIndex, Userindex, 0, "||Ya estas dentro" & FONTTYPE_INFO)
            Exit Sub
        End If

         If UserList(Userindex).POS.Map = 194 Then
            Call SendData(ToIndex, Userindex, 0, "||Ya estas dentro" & FONTTYPE_INFO)
            Exit Sub
        End If

   If UserList(Userindex).Faccion.Bando = Real Then
   Call SendData(ToIndex, Userindex, 0, "||No puedes entrar siendo la facción opuesta." & FONTTYPE_TALK)
   Exit Sub
   End If
        
             If CaosPROTECTOR = pProtector Then Exit Sub
    
            If UserList(Userindex).Faccion.Bando = Neutral Then
             UserList(Userindex).Faccion.bandoEventos = 1
             End If
             
             CaosPROTECTOR = CaosPROTECTOR + 1
                  tInt = 2
             UserList(Userindex).Faccion.Bando = tInt
             Call UpdateUserChar(Userindex)
             
             Call WarpUserChar(Userindex, 193, 71, 46, True)
            If ProtectorCanjes = 1 Then
            If UserList(Userindex).Invent.ArmourEqpObjIndex Then Call Desequipar(Userindex, UserList(Userindex).Invent.ArmourEqpSlot)
            If UserList(Userindex).Invent.WeaponEqpObjIndex Then Call Desequipar(Userindex, UserList(Userindex).Invent.WeaponEqpSlot)
            If UserList(Userindex).Invent.EscudoEqpObjIndex Then Call Desequipar(Userindex, UserList(Userindex).Invent.EscudoEqpSlot)
            If UserList(Userindex).Invent.CascoEqpObjIndex Then Call Desequipar(Userindex, UserList(Userindex).Invent.CascoEqpSlot)
            If UserList(Userindex).Invent.HerramientaEqpObjIndex Then Call Desequipar(Userindex, UserList(Userindex).Invent.HerramientaEqpslot)
            If UserList(Userindex).Invent.MunicionEqpObjIndex Then Call Desequipar(Userindex, UserList(Userindex).Invent.MunicionEqpSlot)
            End If
         
             If CaosPROTECTOR = pProtector Then
             Call iniciatheProtector(Userindex)
             Exit Sub
             End If
    Exit Sub
       Case "#("
          If EVENTOPROTECTORACTIVADO = 0 Then Exit Sub
   

  If UserList(Userindex).Stats.ELV < 40 Then
   Call SendData(ToIndex, Userindex, 0, "||Debes ser nivel 40." & FONTTYPE_INFO)
  Exit Sub
  End If
 
      If MapInfo(UserList(Userindex).POS.Map).Pk = True Then
    Call SendData(ToIndex, Userindex, 0, "||Debes estar en una ciudad" & FONTTYPE_TALK)
    Exit Sub
    End If
    
         If UserList(Userindex).PartyIndex > 0 And MOD_EVENTO_Retos3vs3.EsPartyInscripto(UserList(Userindex).PartyIndex) = True Then
        Call SendData(ToIndex, Userindex, 0, "||Error: Estás anotado para 3vs3." & FONTTYPE_RETOS)
        Exit Sub
    End If
    
     If UserList(Userindex).POS.Map = Prision.Map Then
            Call SendData(ToIndex, Userindex, 0, "||Estas en la carcel" & FONTTYPE_INFO)
            Exit Sub
        End If
    
          If UserList(Userindex).POS.Map = 193 Then
            Call SendData(ToIndex, Userindex, 0, "||Ya estas dentro" & FONTTYPE_INFO)
            Exit Sub
        End If

         If UserList(Userindex).POS.Map = 194 Then
            Call SendData(ToIndex, Userindex, 0, "||Ya estas dentro" & FONTTYPE_INFO)
            Exit Sub
        End If

   If UserList(Userindex).Faccion.Bando = Caos Then
   Call SendData(ToIndex, Userindex, 0, "||No puedes entrar siendo la facción opuesta." & FONTTYPE_TALK)
   Exit Sub
   End If
        
             If RealPROTECTOR = pProtector Then Exit Sub
    
              If UserList(Userindex).Faccion.Bando = Neutral Then
             UserList(Userindex).Faccion.bandoEventos = 1
             End If
             
             RealPROTECTOR = RealPROTECTOR + 1
                  tInt = 1
             UserList(Userindex).Faccion.Bando = tInt
             Call UpdateUserChar(Userindex)
             
             Call WarpUserChar(Userindex, 194, 71, 46, True)
            If ProtectorCanjes = 1 Then
            If UserList(Userindex).Invent.ArmourEqpObjIndex Then Call Desequipar(Userindex, UserList(Userindex).Invent.ArmourEqpSlot)
            If UserList(Userindex).Invent.WeaponEqpObjIndex Then Call Desequipar(Userindex, UserList(Userindex).Invent.WeaponEqpSlot)
            If UserList(Userindex).Invent.EscudoEqpObjIndex Then Call Desequipar(Userindex, UserList(Userindex).Invent.EscudoEqpSlot)
            If UserList(Userindex).Invent.CascoEqpObjIndex Then Call Desequipar(Userindex, UserList(Userindex).Invent.CascoEqpSlot)
            If UserList(Userindex).Invent.HerramientaEqpObjIndex Then Call Desequipar(Userindex, UserList(Userindex).Invent.HerramientaEqpslot)
            If UserList(Userindex).Invent.MunicionEqpObjIndex Then Call Desequipar(Userindex, UserList(Userindex).Invent.MunicionEqpSlot)
            End If
    
             If RealPROTECTOR = pProtector Then
             Call iniciatheProtector(Userindex)
             Exit Sub
             End If
             
         Exit Sub
    
    Case "#,"
    
    If EVENTOTHETEAMACTIVADO = 0 Then Exit Sub
   
  If UserList(Userindex).Stats.ELV < 40 Then
  Call SendData(ToIndex, Userindex, 0, "||Debes ser nivel 40." & FONTTYPE_INFO)
  Exit Sub
  End If
 
   If UserList(Userindex).Faccion.Bando = Caos Then
   Call SendData(ToIndex, Userindex, 0, "||No puedes entrar siendo la facción opuesta." & FONTTYPE_TALK)
   Exit Sub
   End If
   
      If MapInfo(UserList(Userindex).POS.Map).Pk = True Then
    Call SendData(ToIndex, Userindex, 0, "||Debes estar en una ciudad" & FONTTYPE_TALK)
    Exit Sub
    End If
    
         If UserList(Userindex).PartyIndex > 0 And MOD_EVENTO_Retos3vs3.EsPartyInscripto(UserList(Userindex).PartyIndex) = True Then
        Call SendData(ToIndex, Userindex, 0, "||Error: Estás anotado para 3vs3." & FONTTYPE_RETOS)
        Exit Sub
    End If
    
     If UserList(Userindex).POS.Map = Prision.Map Then Exit Sub
    
          If UserList(Userindex).POS.Map = 196 Then
            Call SendData(ToIndex, Userindex, 0, "||Ya estas dentro" & FONTTYPE_INFO)
            Exit Sub
        End If
        
             If UserList(Userindex).POS.Map = 197 Then
            Call SendData(ToIndex, Userindex, 0, "||Ya entraste para un bando." & FONTTYPE_INFO)
            Exit Sub
        End If
        
             If RealTheTEAM = ptheteam Then Exit Sub
    
                 If UserList(Userindex).Faccion.Bando = Neutral Then
             UserList(Userindex).Faccion.bandoEventos = 1
             End If
             
             RealTheTEAM = RealTheTEAM + 1
                  tInt = 1
             UserList(Userindex).Faccion.Bando = tInt
             Call UpdateUserChar(Userindex)
            Call WarpUserChar(Userindex, MAP_ThTeazul, 71, 46, True)
            If AutomaticoTheTeam = 1 Then
            If UserList(Userindex).Invent.ArmourEqpObjIndex Then Call Desequipar(Userindex, UserList(Userindex).Invent.ArmourEqpSlot)
            If UserList(Userindex).Invent.WeaponEqpObjIndex Then Call Desequipar(Userindex, UserList(Userindex).Invent.WeaponEqpSlot)
            If UserList(Userindex).Invent.EscudoEqpObjIndex Then Call Desequipar(Userindex, UserList(Userindex).Invent.EscudoEqpSlot)
            If UserList(Userindex).Invent.CascoEqpObjIndex Then Call Desequipar(Userindex, UserList(Userindex).Invent.CascoEqpSlot)
            If UserList(Userindex).Invent.HerramientaEqpObjIndex Then Call Desequipar(Userindex, UserList(Userindex).Invent.HerramientaEqpslot)
            If UserList(Userindex).Invent.MunicionEqpObjIndex Then Call Desequipar(Userindex, UserList(Userindex).Invent.MunicionEqpSlot)
            End If

              If RealTheTEAM = ptheteam Then
             Call iniciathte(Userindex)
             Exit Sub
             End If
    
        Exit Sub
            Case "#%"
            
                If EVENTOTHETEAMACTIVADO = 0 Then Exit Sub
            
  If UserList(Userindex).Stats.ELV < 40 Then
  Call SendData(ToIndex, Userindex, 0, "||Debes ser nivel 40." & FONTTYPE_INFO)
  Exit Sub
  End If
            
               If UserList(Userindex).Faccion.Bando = Real Then
   Call SendData(ToIndex, Userindex, 0, "||No puedes entrar siendo la facción opuesta." & FONTTYPE_TALK)
   Exit Sub
   End If
            
      If MapInfo(UserList(Userindex).POS.Map).Pk = True Then
    Call SendData(ToIndex, Userindex, 0, "||Debes estar en una ciudad" & FONTTYPE_TALK)
    Exit Sub
    End If
    
     
         If UserList(Userindex).POS.Map = 194 Then
            Call SendData(ToIndex, Userindex, 0, "||Ya entraste para un bando." & FONTTYPE_INFO)
            Exit Sub
        End If
    
                    If UserList(Userindex).PartyIndex > 0 And MOD_EVENTO_Retos3vs3.EsPartyInscripto(UserList(Userindex).PartyIndex) = True Then
        Call SendData(ToIndex, Userindex, 0, "||Error: Estás anotado para 3vs3." & FONTTYPE_RETOS)
        Exit Sub
    End If
                  If UserList(Userindex).POS.Map = 193 Then
            Call SendData(ToIndex, Userindex, 0, "||Ya estas dentro" & FONTTYPE_INFO)
            Exit Sub
        End If
        
          If UserList(Userindex).POS.Map = Prision.Map Then Exit Sub

              If CaosTheTEAM = ptheteam Then Exit Sub
               
                            If UserList(Userindex).Faccion.Bando = Neutral Then
             UserList(Userindex).Faccion.bandoEventos = 1
             End If
               
               CaosTheTEAM = CaosTheTEAM + 1
               
                             tInt = 2
             UserList(Userindex).Faccion.Bando = tInt
             Call UpdateUserChar(Userindex)
               
                Call WarpUserChar(Userindex, MAP_ThTerojo, 71, 46, True)
              If AutomaticoTheTeam = 1 Then
              If UserList(Userindex).Invent.ArmourEqpObjIndex Then Call Desequipar(Userindex, UserList(Userindex).Invent.ArmourEqpSlot)
              If UserList(Userindex).Invent.WeaponEqpObjIndex Then Call Desequipar(Userindex, UserList(Userindex).Invent.WeaponEqpSlot)
              If UserList(Userindex).Invent.EscudoEqpObjIndex Then Call Desequipar(Userindex, UserList(Userindex).Invent.EscudoEqpSlot)
              If UserList(Userindex).Invent.CascoEqpObjIndex Then Call Desequipar(Userindex, UserList(Userindex).Invent.CascoEqpSlot)
              If UserList(Userindex).Invent.HerramientaEqpObjIndex Then Call Desequipar(Userindex, UserList(Userindex).Invent.HerramientaEqpslot)
              If UserList(Userindex).Invent.MunicionEqpObjIndex Then Call Desequipar(Userindex, UserList(Userindex).Invent.MunicionEqpSlot)
              End If

                If CaosTheTEAM = ptheteam Then
              Call iniciathte(Userindex)
              Exit Sub
              End If
    
        Exit Sub
    Case "#T"
        
             If UserList(Userindex).flags.EnReto Then Exit Sub
                  If UserList(Userindex).PartyIndex > 0 And MOD_EVENTO_Retos3vs3.EsPartyInscripto(UserList(Userindex).PartyIndex) = True Then
        Call SendData(ToIndex, Userindex, 0, "||Error: Estás anotado para 3vs3." & FONTTYPE_RETOS)
        Exit Sub
        End If
 
         If UserList(Userindex).Stats.ELV < 40 Then
        Call SendData(ToIndex, Userindex, 0, "||Debes ser nivel 40." & FONTTYPE_INFO)
        Exit Sub
        End If
  
        If UserList(Userindex).flags.Muerto Then
           Call SendData(ToIndex, Userindex, 0, "||Estas muerto!, No puedes participar del evento." & FONTTYPE_INFO)
           Exit Sub
        End If
        
        If MapInfo(UserList(Userindex).POS.Map).Pk = True Then
        Call SendData(ToIndex, Userindex, 0, "||Debes estar en una ciudad." & FONTTYPE_TALK)
        Exit Sub
        End If
        
        

Call Torneos_Entra(Userindex)
Call Torneos_Entrap(Userindex)
Call death_entra(Userindex)
Call MandarUsuariosAzar(Userindex)

        If entorneo Then
        Puesto = Puesto + 1

           
            jugadores = val(GetVar(App.Path & "/logs/torneo.log", "CANTIDAD", "CANTIDAD"))
            Dim jugador As Integer
            For jugador = 1 To jugadores
                If UCase$(GetVar(App.Path & "/logs/torneo.log", "JUGADORES", "JUGADOR" & jugador)) = UCase$(UserList(Userindex).Name) Then Exit Sub
            Next
            Call WriteVar(App.Path & "/logs/torneo.log", "CANTIDAD", "CANTIDAD", jugadores + 1)
            Call WriteVar(App.Path & "/logs/torneo.log", "JUGADORES", "JUGADOR" & jugadores + 1, UserList(Userindex).Name)
            Call SendData(ToIndex, Userindex, 0, "||HAS ENTRADO AL EVENTO!" & FONTTYPE_FENIZ)
           ' Call SendData(ToAdmins, 0, 0, "2U" & UserList(UserIndex).Name)
            PTorneo = PTorneo - 1
           
            Call WarpUserChar(Userindex, 191, 50, 50, True)
           
            
            If PTorneo = 0 Then
                Call SendData(ToAll, 0, 0, "||CUPO LLENO! FINALIZARON LAS INSCRIPCIONES!" & FONTTYPE_FENIX)
                entorneo = 0
                Exit Sub
            End If
        End If
        Exit Sub

    Case "#U"
        Dim NpcIndex As Integer
        Dim theading As Byte
        Dim atra1 As Integer
        Dim atra2 As Integer
        Dim atra3 As Integer
        Dim atra4 As Integer
        
        If Not LegalPos(UserList(Userindex).POS.Map, UserList(Userindex).POS.X - 1, UserList(Userindex).POS.y) And _
        Not LegalPos(UserList(Userindex).POS.Map, UserList(Userindex).POS.X + 1, UserList(Userindex).POS.y) And _
        Not LegalPos(UserList(Userindex).POS.Map, UserList(Userindex).POS.X, UserList(Userindex).POS.y - 1) And _
        Not LegalPos(UserList(Userindex).POS.Map, UserList(Userindex).POS.X, UserList(Userindex).POS.y + 1) Then
            If UserList(Userindex).flags.Muerto Then
                If MapData(UserList(Userindex).POS.Map, UserList(Userindex).POS.X - 1, UserList(Userindex).POS.y).NpcIndex Then
                    atra1 = MapData(UserList(Userindex).POS.Map, UserList(Userindex).POS.X - 1, UserList(Userindex).POS.y).NpcIndex
                    theading = WEST
                    Call MoveNPCChar(atra1, theading)
                End If
                If MapData(UserList(Userindex).POS.Map, UserList(Userindex).POS.X + 1, UserList(Userindex).POS.y).NpcIndex Then
                    atra2 = MapData(UserList(Userindex).POS.Map, UserList(Userindex).POS.X + 1, UserList(Userindex).POS.y).NpcIndex
                    theading = EAST
                    Call MoveNPCChar(atra2, theading)
                End If
                If MapData(UserList(Userindex).POS.Map, UserList(Userindex).POS.X, UserList(Userindex).POS.y - 1).NpcIndex Then
                    atra3 = MapData(UserList(Userindex).POS.Map, UserList(Userindex).POS.X, UserList(Userindex).POS.y - 1).NpcIndex
                    theading = NORTH
                    Call MoveNPCChar(atra3, theading)
                End If
                If MapData(UserList(Userindex).POS.Map, UserList(Userindex).POS.X, UserList(Userindex).POS.y + 1).NpcIndex Then
                    atra4 = MapData(UserList(Userindex).POS.Map, UserList(Userindex).POS.X, UserList(Userindex).POS.y + 1).NpcIndex
                    theading = SOUTH
                    Call MoveNPCChar(atra4, theading)
                 End If
            End If
        End If
        Exit Sub
        
    Case "#V"
     
          If Userindex = Subastador Then Exit Sub
          If Userindex = UltimoOfertador Then Exit Sub
          If UserList(Userindex).flags.notesaleelbug = True Then Exit Sub
          If UserList(Userindex).flags.Retando = True Then Exit Sub
          If UserList(Userindex).POS.Map = 108 Then Exit Sub
  
        If UserList(Userindex).flags.Muerto Then
                  Call SendData(ToIndex, Userindex, 0, "MU")
                  Exit Sub
        End If
        If UserList(Userindex).flags.Privilegios = 1 Then
            Exit Sub
        End If
        
        If UserList(Userindex).flags.TargetNpc Then
              
              If Npclist(UserList(Userindex).flags.TargetNpc).Comercia = 0 Then
                 If Len(Npclist(UserList(Userindex).flags.TargetNpc).Desc) > 0 Then Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "3Q" & vbWhite & "°" & "No tengo ningun interes en comerciar." & "°" & str(Npclist(UserList(Userindex).flags.TargetNpc).Char.CharIndex))
                 Exit Sub
              End If
              If Distancia(Npclist(UserList(Userindex).flags.TargetNpc).POS, UserList(Userindex).POS) > 3 Then
                  Call SendData(ToIndex, Userindex, 0, "DL")
                  Exit Sub
              End If
              
              Call IniciarComercioNPC(Userindex)
         

        ElseIf UserList(Userindex).flags.TargetUser Then
            
            If UserList(Userindex).flags.Privilegios = 1 Or UserList(Userindex).flags.Privilegios = 2 Or UserList(Userindex).flags.Privilegios = 3 Then Exit Sub
            If UserList(Userindex).POS.Map = Prision.Map Then
            Call SendData(ToIndex, Userindex, 0, "||No puedes comerciar estando en la cárcel." & FONTTYPE_TALK)
            Exit Sub
            End If

            If UserList(UserList(Userindex).flags.TargetUser).flags.Muerto Then
                Call SendData(ToIndex, Userindex, 0, "4U")
                Exit Sub
            End If
            
            If UserList(Userindex).flags.TargetUser = Userindex Then
                Call SendData(ToIndex, Userindex, 0, "5U")
                Exit Sub
            End If
            
            If Distancia(UserList(UserList(Userindex).flags.TargetUser).POS, UserList(Userindex).POS) > 3 Then
                Call SendData(ToIndex, Userindex, 0, "DL")
                Exit Sub
            End If
            
            Call IniciarComercioConUsuario(Userindex, UserList(Userindex).flags.TargetUser)

        Else
            Call SendData(ToIndex, Userindex, 0, "ZP")
        End If
        Exit Sub
    
    
    Case "#W"
        
        If UserList(Userindex).flags.Muerto Then
            Call SendData(ToIndex, Userindex, 0, "MU")
            Exit Sub
        End If
        
        If UserList(Userindex).flags.TargetNpc = 0 Then
            Call SendData(ToIndex, Userindex, 0, "ZP")
            Exit Sub
        End If
        
        If Distancia(Npclist(UserList(Userindex).flags.TargetNpc).POS, UserList(Userindex).POS) > 3 Then
            Call SendData(ToIndex, Userindex, 0, "DL")
            Exit Sub
        End If
        
        If Npclist(UserList(Userindex).flags.TargetNpc).NPCtype <> NPCTYPE_BANQUERO Then Exit Sub
        
        Call IniciarDeposito(Userindex)
    
        Exit Sub

    Case "#Y"
    
    
        If UserList(Userindex).flags.TargetNpc = 0 Then
            Call SendData(ToIndex, Userindex, 0, "ZP")
            Exit Sub
        End If
        
        If Npclist(UserList(Userindex).flags.TargetNpc).NPCtype <> NPCTYPE_NOBLE Or UserList(Userindex).flags.Muerto Then Exit Sub
       
        If Distancia(UserList(Userindex).POS, Npclist(UserList(Userindex).flags.TargetNpc).POS) > 4 Then
            Call SendData(ToIndex, Userindex, 0, "DL")
            Exit Sub
        End If
       
        If ClaseBase(UserList(Userindex).Clase) Or ClaseTrabajadora(UserList(Userindex).Clase) Then Exit Sub
       
        Call Enlistar(Userindex, Npclist(UserList(Userindex).flags.TargetNpc).flags.Faccion)
       
        Exit Sub
        

    Case "#1"
        
        If UserList(Userindex).flags.TargetNpc = 0 Then
            Call SendData(ToIndex, Userindex, 0, "ZP")
            Exit Sub
        End If
        If Npclist(UserList(Userindex).flags.TargetNpc).NPCtype <> NPCTYPE_NOBLE Or UserList(Userindex).flags.Muerto Or Not Npclist(UserList(Userindex).flags.TargetNpc).flags.Faccion Then Exit Sub
        If Distancia(UserList(Userindex).POS, Npclist(UserList(Userindex).flags.TargetNpc).POS) > 4 Then
            Call SendData(ToIndex, Userindex, 0, "DL")
            Exit Sub
        End If

        If UserList(Userindex).Faccion.Bando <> Npclist(UserList(Userindex).flags.TargetNpc).flags.Faccion Then
            Call SendData(ToIndex, Userindex, 0, Mensajes(Npclist(UserList(Userindex).flags.TargetNpc).flags.Faccion, 16) & str(Npclist(UserList(Userindex).flags.TargetNpc).Char.CharIndex))
            Exit Sub
        End If
        Call Recompensado(Userindex)
        Exit Sub
        
    Case "#5"
        rdata = Right$(rdata, Len(rdata) - 3)
        
        If UserList(Userindex).flags.Muerto Then
            Call SendData(ToIndex, Userindex, 0, "M4")
            Exit Sub
        End If
        
        If Not AsciiValidos(rdata) Then
            Call SendData(ToIndex, Userindex, 0, "7U")
            Exit Sub
        End If
        
        If Len(rdata) > 80 Then
            Call SendData(ToIndex, Userindex, 0, "||La descripción debe tener menos de 80 cáracteres de largo." & FONTTYPE_INFO)
            Exit Sub
        End If
        
        UserList(Userindex).Desc = rdata
        Call SendData(ToIndex, Userindex, 0, "8U")
        Exit Sub
        
    Case "#6 "
        rdata = Right$(rdata, Len(rdata) - 3)
        Call ComputeVote(Userindex, rdata)
        Exit Sub
            
    Case "#7"
        Call SendData(ToIndex, Userindex, 0, "||Este comando ya no anda, para hablar por tu clan presiona la tecla 3 y habla normalmente." & FONTTYPE_INFO)
        Exit Sub

    Case "#8"
        Call SendData(ToIndex, Userindex, 0, "||Este comando ya no se usa, pon /PASSWORD para cambiar tu password." & FONTTYPE_INFO)
        Exit Sub
        
    Case "#!"
        If PuedeFaccion(Userindex) Then Call SendData(ToIndex, Userindex, 0, "4&")
        Exit Sub
        
    Case "#9"
        rdata = Right$(rdata, Len(rdata) - 3)
        tLong = CLng(val(rdata))
        If tLong > 32000 Then tLong = 32000
        N = tLong
        If UserList(Userindex).flags.Muerto Then
            Call SendData(ToIndex, Userindex, 0, "MU")
        ElseIf UserList(Userindex).flags.TargetNpc = 0 Then
            
            Call SendData(ToIndex, Userindex, 0, "ZP")
        ElseIf Distancia(Npclist(UserList(Userindex).flags.TargetNpc).POS, UserList(Userindex).POS) > 10 Then
            Call SendData(ToIndex, Userindex, 0, "DL")
        ElseIf Npclist(UserList(Userindex).flags.TargetNpc).NPCtype <> NPCTYPE_APOSTADOR Then
            Call SendData(ToIndex, Userindex, 0, "3Q" & vbWhite & "°" & "No tengo ningun interes en apostar." & "°" & str(Npclist(UserList(Userindex).flags.TargetNpc).Char.CharIndex))
        ElseIf N < 1 Then
            Call SendData(ToIndex, Userindex, 0, "3Q" & vbWhite & "°" & "El minimo de apuesta es 1 moneda." & "°" & str(Npclist(UserList(Userindex).flags.TargetNpc).Char.CharIndex))
        ElseIf N > 5000 Then
            Call SendData(ToIndex, Userindex, 0, "3Q" & vbWhite & "°" & "El maximo de apuesta es 5000 monedas." & "°" & str(Npclist(UserList(Userindex).flags.TargetNpc).Char.CharIndex))
        ElseIf UserList(Userindex).Stats.GLD < N Then
            Call SendData(ToIndex, Userindex, 0, "3Q" & vbWhite & "°" & "No tienes esa cantidad." & "°" & str(Npclist(UserList(Userindex).flags.TargetNpc).Char.CharIndex))
        Else
            If RandomNumber(1, 100) <= 47 Then
                UserList(Userindex).Stats.GLD = UserList(Userindex).Stats.GLD + N
                Call SendData(ToIndex, Userindex, 0, "3Q" & vbWhite & "°" & "Felicidades! Has ganado " & CStr(N) & " monedas de oro!" & "°" & str(Npclist(UserList(Userindex).flags.TargetNpc).Char.CharIndex))
                
                Apuestas.Ganancias = Apuestas.Ganancias + N
                Call WriteVar(DatPath & "apuestas.dat", "Main", "Ganancias", CStr(Apuestas.Ganancias))
            Else
                UserList(Userindex).Stats.GLD = UserList(Userindex).Stats.GLD - N
                Call SendData(ToIndex, Userindex, 0, "3Q" & vbWhite & "°" & "Lo siento, has perdido " & CStr(N) & " monedas de oro." & "°" & str(Npclist(UserList(Userindex).flags.TargetNpc).Char.CharIndex))
            
                Apuestas.Perdidas = Apuestas.Perdidas + N
                Call WriteVar(DatPath & "apuestas.dat", "Main", "Perdidas", CStr(Apuestas.Perdidas))
            End If
            Apuestas.Jugadas = Apuestas.Jugadas + 1
            Call WriteVar(DatPath & "apuestas.dat", "Main", "Jugadas", CStr(Apuestas.Jugadas))
            
            Call SendUserORO(Userindex)
        End If
        Exit Sub
        
    Case "#/"
        rdata = Right$(rdata, Len(rdata) - 3)
        Tindex = NameIndex(ReadField(1, rdata, 32))
        If Tindex = 0 Then Exit Sub
        If ReadField(2, rdata, 32) = "0" Then
            Call SendData(ToIndex, Tindex, 0, "||" & UserList(Userindex).Name & " te ha dejado de ignorar." & FONTTYPE_INFO)
        Else: Call SendData(ToIndex, Tindex, 0, "||" & UserList(Userindex).Name & " te empezó a ignorar." & FONTTYPE_INFO)
        End If
        Exit Sub
               
    Case "#0"
        If UserList(Userindex).flags.Muerto Then
            Call SendData(ToIndex, Userindex, 0, "MU")
            Exit Sub
        End If
         
        If UserList(Userindex).flags.TargetNpc = 0 Then
            Call SendData(ToIndex, Userindex, 0, "ZP")
            Exit Sub
        End If
         
        If UserList(Userindex).flags.Muerto Then Exit Sub
         
        If Npclist(UserList(Userindex).flags.TargetNpc).NPCtype <> NPCTYPE_BANQUERO Then Exit Sub
         
        If Distancia(UserList(Userindex).POS, Npclist(UserList(Userindex).flags.TargetNpc).POS) > 10 Then
            Call SendData(ToIndex, Userindex, 0, "DL")
            Exit Sub
        End If
         
        rdata = Right$(rdata, Len(rdata) - 3)
        

If UserList(Userindex).flags.Comerciando = True Then Exit Sub
If UserList(Userindex).flags.notesaleelbug = True Then Exit Sub
If UserList(Userindex).flags.Retando = True Then Exit Sub
If Userindex = Subastador Then Exit Sub
If Userindex = UltimoOfertador Then Exit Sub
If UserList(Userindex).POS.Map = 108 Then Exit Sub

    If UserList(Userindex).flags.EnvRetoC = True Then Exit Sub 'galle
    If UserList(Userindex).flags.RecRetoC = True Then Exit Sub
    If UserList(Userindex).flags.enRetoC1 = True Then Exit Sub
    If UserList(Userindex).flags.enRetoC2 = True Then Exit Sub

        If val(rdata) > 0 Then
            If val(rdata) > UserList(Userindex).Stats.Banco Then rdata = UserList(Userindex).Stats.Banco
            UserList(Userindex).Stats.Banco = UserList(Userindex).Stats.Banco - val(rdata)
            UserList(Userindex).Stats.GLD = UserList(Userindex).Stats.GLD + val(rdata)
            Call LogBove(UserList(Userindex).Name, UserList(Userindex).Name & " RETIRO ORO:" & PonerPuntos(CStr(rdata)), False)
            Call SendData(ToIndex, Userindex, 0, "3Q" & vbWhite & "°" & "Tenes " & UserList(Userindex).Stats.Banco & " monedas de oro en tu cuenta." & "°" & Npclist(UserList(Userindex).flags.TargetNpc).Char.CharIndex & FONTTYPE_INFO)
        End If
         
        Call SendUserORO(Userindex)
         
        Exit Sub

    Case "#Ñ"
        
        If UserList(Userindex).flags.Muerto Then
            Call SendData(ToIndex, Userindex, 0, "MU")
            Exit Sub
        End If

        If UserList(Userindex).flags.TargetNpc = 0 Then
            Call SendData(ToIndex, Userindex, 0, "ZP")
            Exit Sub
        End If
        
        If Distancia(Npclist(UserList(Userindex).flags.TargetNpc).POS, UserList(Userindex).POS) > 10 Then
            Call SendData(ToIndex, Userindex, 0, "DL")
            Exit Sub
        End If
        
        If Npclist(UserList(Userindex).flags.TargetNpc).NPCtype <> NPCTYPE_BANQUERO Or UserList(Userindex).flags.Muerto Then Exit Sub
        
        If Distancia(UserList(Userindex).POS, Npclist(UserList(Userindex).flags.TargetNpc).POS) > 10 Then
              Call SendData(ToIndex, Userindex, 0, "DL")
              Exit Sub
        End If
        
        rdata = Right$(rdata, Len(rdata) - 3)
        If UserList(Userindex).flags.Comerciando = True Then Exit Sub
If UserList(Userindex).flags.notesaleelbug = True Then Exit Sub
If UserList(Userindex).flags.Retando = True Then Exit Sub
If Userindex = Subastador Then Exit Sub
If Userindex = UltimoOfertador Then Exit Sub
If UserList(Userindex).POS.Map = 108 Then Exit Sub

    If UserList(Userindex).flags.EnvRetoC = True Then Exit Sub 'galle
    If UserList(Userindex).flags.RecRetoC = True Then Exit Sub
    If UserList(Userindex).flags.enRetoC1 = True Then Exit Sub
    If UserList(Userindex).flags.enRetoC2 = True Then Exit Sub

        
        If CLng(val(rdata)) > 0 Then
            If CLng(val(rdata)) > UserList(Userindex).Stats.GLD Then rdata = UserList(Userindex).Stats.GLD
            UserList(Userindex).Stats.Banco = UserList(Userindex).Stats.Banco + val(rdata)
            UserList(Userindex).Stats.GLD = UserList(Userindex).Stats.GLD - val(rdata)
                    Call LogBove(UserList(Userindex).Name, UserList(Userindex).Name & " DEPOSITO ORO:" & PonerPuntos(CStr(rdata)), False)
            Call SendData(ToIndex, Userindex, 0, "3Q" & vbWhite & "°" & "Tenes " & UserList(Userindex).Stats.Banco & " monedas de oro en tu cuenta." & "°" & Npclist(UserList(Userindex).flags.TargetNpc).Char.CharIndex & FONTTYPE_INFO)
        End If
    
        Call SendUserORO(Userindex)
        
        Exit Sub
        
    Case "#2"
           If UserList(Userindex).GuildInfo.EsGuildLeader Then
        Call SendData(ToIndex, Userindex, 0, "||¡Eres líder/sublider del clan! No puedes abandonar hasta que haya elecciones." & FONTTYPE_INFO)
        Exit Sub
        End If
        If Len(UserList(Userindex).GuildInfo.GuildName) > 0 Then
            If UserList(Userindex).GuildInfo.EsGuildLeader And UserList(Userindex).flags.Privilegios < 2 Then
                Call SendData(ToIndex, Userindex, 0, "4V")
                Exit Sub
            End If
        Else
            Call SendData(ToIndex, Userindex, 0, "5V")
            Exit Sub
        End If
        
        Call SendData(ToGuildMembers, Userindex, 0, "6V" & UserList(Userindex).Name)
        Call SendData(ToIndex, Userindex, 0, "7V")
        
        Dim oGuild As cGuild
        
        Set oGuild = FetchGuild(UserList(Userindex).GuildInfo.GuildName)
        
        If oGuild Is Nothing Then Exit Sub
        
        For i = 1 To LastUser
            If UserList(i).GuildInfo.GuildName = oGuild.GuildName Then UserList(i).flags.InfoClanEstatica = 0
        Next
        
        UserList(Userindex).GuildInfo.GuildPoints = 0
        UserList(Userindex).GuildInfo.GuildName = ""
        Call oGuild.RemoveMember(UserList(Userindex).Name)
        
        Call UpdateUserChar(Userindex)
        
        Exit Sub
      
      Case "#€"
If Len(UserList(Userindex).GuildInfo.GuildName) = 0 Then Exit Sub
With UserList(Userindex).GuildInfo
.Seguro = Not .Seguro
If .Seguro Then
 Call SendData(ToIndex, Userindex, 0, "||El seguro de clanes fue activado." & FONTTYPE_FENIZ)
Else
 Call SendData(ToIndex, Userindex, 0, "||El seguro de clanes fue desactivado." & FONTTYPE_FENIZ)
End If
End With
Exit Sub
      
    Case "#4"

        If UserList(Userindex).flags.TargetNpc = 0 Then
           Call SendData(ToIndex, Userindex, 0, "ZP")
           Exit Sub
       End If
       
        If Npclist(UserList(Userindex).flags.TargetNpc).NPCtype <> NPCTYPE_NOBLE Or UserList(Userindex).flags.Muerto Or Npclist(UserList(Userindex).flags.TargetNpc).flags.Faccion = 0 Then Exit Sub
        
        If Distancia(UserList(Userindex).POS, Npclist(UserList(Userindex).flags.TargetNpc).POS) > 4 Then
            Call SendData(ToIndex, Userindex, 0, "DL")
            Exit Sub
        End If
        
        If UserList(Userindex).Faccion.Bando <> Npclist(UserList(Userindex).flags.TargetNpc).flags.Faccion Then Exit Sub
        
        If Len(UserList(Userindex).GuildInfo.GuildName) > 0 Then
            Call SendData(ToIndex, Userindex, 0, Mensajes(UserList(Userindex).Faccion.Bando, 23) & str(Npclist(UserList(Userindex).flags.TargetNpc).Char.CharIndex))
            Exit Sub
        End If
        
        Call SendData(ToIndex, Userindex, 0, Mensajes(Npclist(UserList(Userindex).flags.TargetNpc).flags.Faccion, 18) & str(Npclist(UserList(Userindex).flags.TargetNpc).Char.CharIndex))

        UserList(Userindex).Faccion.Bando = Neutral
        UserList(Userindex).Faccion.Jerarquia = 0
        Call UpdateUserChar(Userindex)
Exit Sub

Case "#3"
    If Len(UserList(Userindex).GuildInfo.GuildName) = 0 Then
        Call SendData(ToIndex, Userindex, 0, "5V")
        Exit Sub
    End If
    
    For loopc = 1 To LastUser
        If UserList(loopc).GuildInfo.GuildName = UserList(Userindex).GuildInfo.GuildName Then
        If UserList(loopc).flags.Privilegios > UserList(Userindex).flags.Privilegios Then
            tStr = tStr & UserList(loopc).Name & ", "
        End If
        End If
    Next
    
    If Len(tStr) > 0 Then
        tStr = Left$(tStr, Len(tStr) - 2)
        Call SendData(ToIndex, Userindex, 0, "||Miembros de tu clan online:" & tStr & "." & FONTTYPE_GUILD)
    Else: Call SendData(ToIndex, Userindex, 0, "8V")
    End If
    Exit Sub
    
    
    Case "#^"
    Dim stri As String
    Dim jugadorxxxx As Integer
    stri = ""
  
    jugadorxxxx = 1
    For jugadorxxxx = 1 To LastUser
    If UserList(jugadorxxxx).GuildInfo.GuildName <> "" Then
    If UserList(jugadorxxxx).GuildInfo.EsGuildLeader = 1 Then
        stri = stri & UserList(jugadorxxxx).GuildInfo.GuildName & "@"
        End If
        End If
    Next
  Call SendData(ToIndex, Userindex, 0, "PPZ" & " @" & stri)
    
    stri = ""
  
    jugadorxxxx = 1
    For jugadorxxxx = 1 To LastUser
    If UserList(jugadorxxxx).GuildInfo.GuildName <> "" Then
    If UserList(jugadorxxxx).GuildInfo.EsGuildLeader = 1 Then
        stri = stri & UserList(jugadorxxxx).Name & "@"
    End If
    End If
    Next

  Call SendData(ToIndex, Userindex, 0, "PPL" & " @" & stri)
    
   Exit Sub
 
Case "#¨" '/ACEPTCLAN by GALLE
 
     
      'CONDICIONES
      If cACT = True Then
             Call SendData(ToIndex, Userindex, 0, "||El reto de clanes esta desactivado." & FONTTYPE_INFO)
             Exit Sub
      ElseIf cOCUP Then
             Call SendData(ToIndex, Userindex, 0, "||Hay un reto en curso entre " & UserList(RetoClan.lider1).GuildInfo.GuildName & " Vs. " & UserList(RetoClan.lider2).GuildInfo.GuildName & ", debes esperar a que finalize." & FONTTYPE_INFO)
             Exit Sub
      ElseIf UserList(Userindex).flags.Muerto Then
             Call SendData(ToIndex, Userindex, 0, "MU")
             Exit Sub
      ElseIf UserList(Userindex).GuildInfo.EsGuildLeader = 0 Then
             Call SendData(ToIndex, Userindex, 0, "||Tu no eres el lider." & FONTTYPE_INFO)
             Exit Sub
      ElseIf UserList(Userindex).flags.RecRetoC = False Then
             Call SendData(ToIndex, Userindex, 0, "||No has sido retado o se canceló por limite de tiempo." & FONTTYPE_INFO)
             Exit Sub
      ElseIf UserList(Userindex).POS.Map <> 1 Then
             Call SendData(ToIndex, Userindex, 0, "||Tú y los miembros de tu clan que deseen participar deberán estar en Ullathorpe(1)" & FONTTYPE_INFO)
             Exit Sub
      ElseIf UserList(Userindex).Stats.GLD < UserList(Userindex).flags.ApuestaRetoClan Then
      Call SendData(ToIndex, Userindex, 0, "||No tienes el oro que marca la apuesta." & FONTTYPE_INFO)
      Exit Sub
      ElseIf UserList(UserList(Userindex).flags.DesafGuerra).Stats.GLD < UserList(Userindex).flags.ApuestaRetoClan Then
      Call SendData(ToIndex, Userindex, 0, "||Tu contrincante no tiene el oro suficiente." & FONTTYPE_INFO)
      Exit Sub
      ElseIf UserList(Userindex).flags.RecRetoCcuent = 0 Then
      Call SendData(ToIndex, Userindex, 0, "||No tienes ningún ofrecimiento pendiente." & FONTTYPE_INFO)
      Exit Sub
      End If
      'CONDICIONES
   
      'SENTENCIAS
        Call SendData(ToIndex, Userindex, 0, "||Aceptaste el reto de clanes." & FONTTYPE_TALK)
        RetoClan.lider1 = Userindex
        RetoClan.lider2 = UserList(Userindex).flags.DesafGuerra
        Call SendData(ToAll, Userindex, 0, "||Los clanes " & UserList(RetoClan.lider1).GuildInfo.GuildName & " Vs. " & UserList(RetoClan.lider2).GuildInfo.GuildName & " se enfrentan en un reto de clanes." & FONTTYPE_FENIX)
        
        UserList(RetoClan.lider1).flags.EnvRetoC = False
        UserList(RetoClan.lider1).flags.DesafGuerra = 0
        UserList(RetoClan.lider2).flags.RecRetoC = False
        UserList(RetoClan.lider2).flags.DesafGuerra = 0
       


                  Call SendData(ToGuildMembers, RetoClan.lider1, 0, "||El lider de tu clan comenzó un reto contra el clan: " & UserList(RetoClan.lider2).GuildInfo.GuildName & " para entrar tipeá /IRGUERRA." & FONTTYPE_FENIX)
    
                  Call SendData(ToGuildMembers, RetoClan.lider2, 0, "||El lider de tu clan comenzó un reto contra el clan: " & UserList(RetoClan.lider1).GuildInfo.GuildName & " para entrar tipeá /IRGUERRA." & FONTTYPE_FENIX)

        
                   If UserList(RetoClan.lider1).Stats.GLD > UserList(RetoClan.lider1).flags.ApuestaRetoClan - 1 Then
                   UserList(RetoClan.lider1).Stats.GLD = UserList(RetoClan.lider1).Stats.GLD - UserList(RetoClan.lider1).flags.ApuestaRetoClan
                   Call SendData(ToIndex, RetoClan.lider1, 0, "||Se te desconto la apuesta, recuerda que si te desconectas o pierdes la conexión, pierdes tu apuesta." & FONTTYPE_TALK)
                   Call SendUserORO(RetoClan.lider1)
                   Call WarpUserChar(RetoClan.lider1, 94, 83, 24) 'ACA VA EL CLAN1
                   UserList(RetoClan.lider1).flags.enRetoC1 = True
                   Clan1CUP = Clan1CUP + 1
End If

                   If UserList(RetoClan.lider2).Stats.GLD > UserList(RetoClan.lider2).flags.ApuestaRetoClan - 1 Then
                   UserList(RetoClan.lider2).Stats.GLD = UserList(RetoClan.lider2).Stats.GLD - UserList(RetoClan.lider2).flags.ApuestaRetoClan
                   Call SendData(ToIndex, RetoClan.lider2, 0, "||Se te desconto la apuesta, recuerda que si te desconectas o pierdes la conexión, pierdes tu apuesta." & FONTTYPE_TALK)
                   Call SendUserORO(RetoClan.lider2)
                   Call WarpUserChar(RetoClan.lider2, 94, 83, 81) 'ACA VA EL CLAN2
                   UserList(RetoClan.lider2).flags.enRetoC2 = True
                   Clan2CUP = Clan2CUP + 1
        End If
 
        

        
        ESPRIMERARONDACLAN = True

        CuposClan1 = Clan1CUP
        CuposClan2 = Clan2CUP
        
      GMCuentaGuerraclan = UserList(Userindex).POS.Map
      CuentaRegresivaGuerraclan = 60
      yamandocuenta = 1
           
        cOCUP = True
      'SENTENCIAS
       
        Exit Sub
    
    End Select

    Procesado = False
End Sub

