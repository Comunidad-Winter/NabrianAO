Attribute VB_Name = "modHechizos"
 
'director del proyecto: #Esteban(Neliam)

'servidor basado en fénixao 1.0
'medios de contacto:
'Skype: dc.esteban
'E-mail: nabrianao@gmail.com
Option Explicit
Sub NpcLanzaSpellSobreUser(NpcIndex As Integer, Userindex As Integer, Spell As Integer)

If Userindex = GranPoder Then Exit Sub
If UserList(Userindex).flags.Privilegios Then Exit Sub

If Npclist(NpcIndex).CanAttack = 0 Then Exit Sub

Npclist(NpcIndex).CanAttack = 0
Dim Daño As Integer

If Hechizos(Spell).SubeHP = 1 Then
    If UserList(Userindex).flags.Muerto = 1 Then Exit Sub
    
    Daño = RandomNumber(Hechizos(Spell).MinHP, Hechizos(Spell).MaxHP)
    
     Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "TX" & Npclist(NpcIndex).Char.CharIndex & "," & UserList(Userindex).Char.CharIndex & "," & Hechizos(Spell).FXgrh & "," & Hechizos(Spell).Particula & "," & Hechizos(Spell).loops & "," & Hechizos(Spell).WAV)  'dx8

    UserList(Userindex).Stats.MinHP = UserList(Userindex).Stats.MinHP + Daño
    If UserList(Userindex).Stats.MinHP > UserList(Userindex).Stats.MaxHP Then UserList(Userindex).Stats.MinHP = UserList(Userindex).Stats.MaxHP
    
    Call SendData(ToIndex, Userindex, 0, "||" & Npclist(NpcIndex).Name & " te ha quitado " & Daño & " puntos de vida." & FONTTYPE_FIGHT)
    Call SubirSkill(Userindex, Resistencia)
    
    Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "HM" & FONTTYPE_ORO & "°" & Daño & "°" & UserList(Userindex).POS.X & "°" & UserList(Userindex).POS.Y & "°" & UserList(Userindex).Char.CharIndex)

    
ElseIf Hechizos(Spell).SubeHP = 2 Then
    Daño = RandomNumber(Hechizos(Spell).MinHP, Hechizos(Spell).MaxHP)

    If Npclist(NpcIndex).MaestroUser = 0 Then Daño = Daño * (1 - UserList(Userindex).Stats.UserSkills(Resistencia) / 200)

    If UserList(Userindex).Invent.CascoEqpObjIndex Then
        Dim Obj As ObjData
       Obj = ObjData(UserList(Userindex).Invent.CascoEqpObjIndex)
       If Obj.Gorro = 1 Then
       Dim absorbido As Integer
       absorbido = RandomNumber(Obj.MinDef, Obj.MaxDef)
       absorbido = absorbido
       Daño = Maximo(1, Daño - absorbido)
       End If
    End If
    
     Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "TX" & Npclist(NpcIndex).Char.CharIndex & "," & UserList(Userindex).Char.CharIndex & "," & Hechizos(Spell).FXgrh & "," & Hechizos(Spell).Particula & "," & Hechizos(Spell).loops & "," & Hechizos(Spell).WAV)  'dx8

    If Not UserList(Userindex).flags.Quest And UserList(Userindex).flags.Privilegios = 0 Then
        UserList(Userindex).Stats.MinHP = Maximo(0, UserList(Userindex).Stats.MinHP - Daño)
        Call SendUserHP(Userindex)
    End If
    
    Call SendData(ToIndex, Userindex, 0, "%A" & Npclist(NpcIndex).Name & "," & Daño)
    Call SubirSkill(Userindex, Resistencia)
    
    Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "HM" & FONTTYPE_ORO & "°" & Daño & "°" & UserList(Userindex).POS.X & "°" & UserList(Userindex).POS.Y & "°" & UserList(Userindex).Char.CharIndex)

    
    If UserList(Userindex).Stats.MinHP = 0 Then Call UserDie(Userindex)
    
End If
        
If Hechizos(Spell).Paraliza > 0 Then



     If UserList(Userindex).flags.Paralizado = 0 Then
        If UserList(Userindex).Clase = PIRATA And UserList(Userindex).Recompensas(3) = 1 Then Exit Sub
        UserList(Userindex).flags.Paralizado = 1
        UserList(Userindex).Counters.Paralisis = Timer - 15 * (UserList(Userindex).Clase = GUERRERO And UserList(Userindex).Recompensas(3))
        
     Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "TX" & Npclist(NpcIndex).Char.CharIndex & "," & UserList(Userindex).Char.CharIndex & "," & Hechizos(Spell).FXgrh & "," & Hechizos(Spell).Particula & "," & Hechizos(Spell).loops & "," & Hechizos(Spell).WAV)  'dx8

        Call SendData(ToIndex, Userindex, 0, ("P9"))
        Call SendData(ToIndex, Userindex, 0, "PU" & DesteEncripTE(UserList(Userindex).POS.X & "," & UserList(Userindex).POS.Y))
     End If
End If

If Hechizos(Spell).Ceguera = 1 Then
    UserList(Userindex).flags.Ceguera = 1
    UserList(Userindex).Counters.Ceguera = Timer
    
     Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "TX" & Npclist(NpcIndex).Char.CharIndex & "," & UserList(Userindex).Char.CharIndex & "," & Hechizos(Spell).FXgrh & "," & Hechizos(Spell).Particula & "," & Hechizos(Spell).loops & "," & Hechizos(Spell).WAV)  'dx8
    
    Call SendData(ToIndex, Userindex, 0, "CEGU")
    Call SendData(ToIndex, Userindex, 0, "%B")
End If

If Hechizos(Spell).RemoverParalisis = 1 Then
     If Npclist(NpcIndex).flags.Paralizado Then
          Npclist(NpcIndex).flags.Paralizado = 0
          Npclist(NpcIndex).Contadores.Paralisis = 0
     End If
End If

End Sub
Function TieneHechizo(ByVal i As Integer, Userindex As Integer) As Boolean

On Error GoTo ErrHandler
    
    Dim j As Integer
    For j = 1 To MAXUSERHECHIZOS
        If UserList(Userindex).Stats.UserHechizos(j) = i Then
            TieneHechizo = True
            Exit Function
        End If
    Next

Exit Function
ErrHandler:

End Function
Sub AgregarHechizo(Userindex As Integer, Slot As Byte)
Dim hIndex As Integer, j As Integer


hIndex = ObjData(UserList(Userindex).Invent.Object(Slot).OBJIndex).HechizoIndex

If Not TieneHechizo(hIndex, Userindex) Then
    For j = 1 To MAXUSERHECHIZOS
        If UserList(Userindex).Stats.UserHechizos(j) = 0 Then Exit For
    Next
        
    If UserList(Userindex).Stats.UserHechizos(j) Then
        Call SendData(ToIndex, Userindex, 0, "%C")
    Else
        UserList(Userindex).Stats.UserHechizos(j) = hIndex
        Call UpdateUserHechizos(False, Userindex, CByte(j))
        
        Call QuitarUnItem(Userindex, CByte(Slot))
        Call SendData(ToIndex, Userindex, 0, "||Has aprendido el hechizo " & Hechizos(hIndex).Nombre & "." & FONTTYPE_TALK)
    End If
Else
    Call SendData(ToIndex, Userindex, 0, "%D")
End If

End Sub
Sub Aprenderhechizo(Userindex As Integer, ByVal hechizoespecial As Integer)
Dim hIndex As Integer
Dim j As Integer
hIndex = hechizoespecial

If Not TieneHechizo(hIndex, Userindex) Then
    
    For j = 1 To MAXUSERHECHIZOS
        If UserList(Userindex).Stats.UserHechizos(j) = 0 Then Exit For
    Next
          
    If UserList(Userindex).Stats.UserHechizos(j) Then
        Call SendData(ToIndex, Userindex, 0, "%C")
    Else
        UserList(Userindex).Stats.UserHechizos(j) = hIndex
        Call UpdateUserHechizos(False, Userindex, CByte(j))
     
    End If
Else
    Call SendData(ToIndex, Userindex, 0, "%D")
    
End If

End Sub
Sub DecirPalabrasMagicas(ByVal S As String, Userindex As Integer)
On Error Resume Next

Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "||" & vbCyan & "°" & S & "°" & UserList(Userindex).Char.CharIndex)

End Sub
Function ManaHechizo(Userindex As Integer, Hechizo As Integer) As Integer

If UserList(Userindex).flags.Privilegios > 2 Or UserList(Userindex).flags.Quest Then Exit Function

If UserList(Userindex).Recompensas(3) = 1 And _
    ((UserList(Userindex).Clase = DRUIDA And Hechizo = 24) Or _
    (UserList(Userindex).Clase = PALADIN And Hechizo = 10)) Then
    ManaHechizo = 250
ElseIf UserList(Userindex).Clase = CLERIGO And UserList(Userindex).Recompensas(3) = 2 And Hechizo = 11 Then
    ManaHechizo = 1100
Else: ManaHechizo = Hechizos(Hechizo).ManaRequerido
End If

End Function
Function PuedeLanzar(Userindex As Integer, ByVal HechizoIndex As Integer) As Boolean
Dim wp2 As WorldPos

wp2.Map = UserList(Userindex).flags.TargetMap
wp2.X = UserList(Userindex).flags.TargetX
wp2.Y = UserList(Userindex).flags.TargetY

If Not EnPantalla(UserList(Userindex).POS, wp2, 1) Then Exit Function

If UserList(Userindex).flags.Muerto Then
    Call SendData(ToIndex, Userindex, 0, "MU")
    Exit Function
End If

If MapInfo(UserList(Userindex).POS.Map).NoMagia Then
    Call SendData(ToIndex, Userindex, 0, "/T")
    Exit Function
End If

If UserList(Userindex).Stats.ELV < Hechizos(HechizoIndex).Nivel Then
    Call SendData(ToIndex, Userindex, 0, "%%" & Hechizos(HechizoIndex).Nivel)
    Exit Function
End If

If UserList(Userindex).Stats.UserSkills(Magia) < Hechizos(HechizoIndex).MinSkill Then
    Call SendData(ToIndex, Userindex, 0, "%E")
    Exit Function
End If

If UserList(Userindex).Stats.MinMAN < ManaHechizo(Userindex, HechizoIndex) Then
    Call SendData(ToIndex, Userindex, 0, "%F")
    Exit Function
End If

If UserList(Userindex).Stats.MinSta < Hechizos(HechizoIndex).StaRequerido Then
    Call SendData(ToIndex, Userindex, 0, "9E")
    Exit Function
End If

PuedeLanzar = True

End Function
Sub HechizoInvocacion(Userindex As Integer, b As Boolean)
Dim Masc As Integer

If MapInfo(UserList(Userindex).POS.Map).EsMapaEspecial Then Exit Sub

    If MapInfo(UserList(Userindex).POS.Map).Pk = False Then
    Call SendData(ToIndex, Userindex, 0, "||No puedes invocar mascotas en zonas seguras." & FONTTYPE_TALK)
    Exit Sub
    End If

If Not MapInfo(UserList(Userindex).POS.Map).Pk Then
    Call SendData(ToIndex, Userindex, 0, "A&")
    Exit Sub
End If

If Not UserList(Userindex).flags.Quest And UserList(Userindex).NroMascotas >= 3 Then Exit Sub
If UserList(Userindex).NroMascotas >= MAXMASCOTAS Then Exit Sub

Dim H As Integer, j As Integer, ind As Integer, Index As Integer
Dim TargetPos As WorldPos

TargetPos.Map = UserList(Userindex).flags.TargetMap
TargetPos.X = UserList(Userindex).flags.TargetX
TargetPos.Y = UserList(Userindex).flags.TargetY

H = UserList(Userindex).Stats.UserHechizos(UserList(Userindex).flags.Hechizo)

For j = 1 To MAXMASCOTAS * Buleano(Not UserList(Userindex).flags.Quest)
    If UserList(Userindex).MascotasIndex(j) Then
        If Npclist(UserList(Userindex).MascotasIndex(j)).Numero = Hechizos(H).NumNPC Then Masc = Masc + 1
    End If
Next

If (Hechizos(H).NumNPC = 103 And Masc >= 2 And Not UserList(Userindex).flags.Quest) Or (Hechizos(H).NumNPC = 94 And Masc >= 1) Then
    Call SendData(ToIndex, Userindex, 0, "||No puedes invocar más mascotas de este tipo." & FONTTYPE_FIGHT)
    Exit Sub
End If

For j = 1 To Hechizos(H).Cant
    If (UserList(Userindex).NroMascotas < 3 Or UserList(Userindex).flags.Quest) And UserList(Userindex).NroMascotas < MAXMASCOTAS Then
        ind = SpawnNpc(Hechizos(H).NumNPC, TargetPos, True, False)
        If ind < MAXNPCS Then
        
            UserList(Userindex).NroMascotas = UserList(Userindex).NroMascotas + 1
            
            Index = FreeMascotaIndex(Userindex)
            
            UserList(Userindex).MascotasIndex(Index) = ind
            UserList(Userindex).MascotasType(Index) = Npclist(ind).Numero
            
            If UserList(Userindex).Clase = DRUIDA And UserList(Userindex).Recompensas(3) = 2 Then
                If Hechizos(H).NumNPC >= 92 And Hechizos(H).NumNPC <= 94 Then
                    Npclist(ind).Stats.MaxHP = Npclist(ind).Stats.MaxHP + 75
                    Npclist(ind).Stats.MinHP = Npclist(ind).Stats.MaxHP
                End If
            End If
            
            If Npclist(ind).Numero = 103 And UserList(Userindex).Raza <> ELFO_OSCURO Then
                Npclist(ind).Stats.MaxHP = Npclist(ind).Stats.MaxHP - 200
                Npclist(ind).Stats.MinHP = Npclist(ind).Stats.MinHP - 200
            End If
            
            Npclist(ind).MaestroUser = Userindex
            Npclist(ind).Contadores.TiempoExistencia = 60
            Npclist(ind).GiveGLD = 0
            
            Call FollowAmo(ind)
        End If
    Else: Exit For
    End If
Next

Call InfoHechizo(Userindex)
b = True

End Sub
Sub HechizoTerrenoEstado(Userindex As Integer, b As Boolean)
Dim PosCasteada As WorldPos
Dim TU As Integer
Dim H As Integer
Dim i As Integer

PosCasteada.X = UserList(Userindex).flags.TargetX
PosCasteada.Y = UserList(Userindex).flags.TargetY
PosCasteada.Map = UserList(Userindex).flags.TargetMap

H = UserList(Userindex).Stats.UserHechizos(UserList(Userindex).flags.Hechizo)

If Hechizos(H).Invisibilidad = 2 Then
    For i = 1 To MapInfo(UserList(Userindex).POS.Map).NumUsers
        TU = MapInfo(UserList(Userindex).POS.Map).Userindex(i)
        If EnPantalla(PosCasteada, UserList(TU).POS, -1) And UserList(TU).flags.Invisible = 1 And UserList(TU).flags.AdminInvisible = 0 Then
            Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "CFX" & UserList(TU).Char.CharIndex & "," & UserList(TU).Char.CharIndex & "," & Hechizos(H).FXgrh & "," & 0 & "," & Hechizos(H).loops) 'dx8
            Call QuitarInvisible(TU)
        End If
    Next
    b = True
End If

Call InfoHechizo(Userindex)

End Sub
Sub HandleHechizoTerreno(Userindex As Integer, ByVal uh As Integer)
Dim b As Boolean

Select Case Hechizos(uh).Tipo
    Case uInvocacion
       Call HechizoInvocacion(Userindex, b)
    Case uRadial
        Call HechizoTerrenoEstado(Userindex, b)
        Case uMaterializa 'matute
        Call HechizoMaterializar(Userindex, b)
End Select

If b Then
    Call SubirSkill(Userindex, Magia)
    Call QuitarSta(Userindex, Hechizos(uh).StaRequerido)
    UserList(Userindex).Stats.MinMAN = UserList(Userindex).Stats.MinMAN - ManaHechizo(Userindex, uh)
    If UserList(Userindex).Stats.MinMAN < 0 Then UserList(Userindex).Stats.MinMAN = 0
    Call SendUserMANASTA(Userindex)
End If

End Sub
Sub HandleHechizoUsuario(Userindex As Integer, ByVal uh As Integer)
Dim b As Boolean
Dim tempChr As Integer
Dim TU, tN As Integer

tempChr = UserList(Userindex).flags.TargetUser

If UserList(tempChr).flags.Protegido = 1 Or UserList(tempChr).flags.Protegido = 2 Then Exit Sub

Select Case Hechizos(uh).Tipo
    Case uTerreno
       Call HechizoInvocacion(Userindex, b)
    Case uEstado
       Call HechizoEstadoUsuario(Userindex, b)
    Case uPropiedades
       Call HechizoPropUsuario(Userindex, b)
End Select

If b Then
    Call SubirSkill(Userindex, Magia)
    UserList(Userindex).Stats.MinMAN = UserList(Userindex).Stats.MinMAN - ManaHechizo(Userindex, uh)
    If UserList(Userindex).Stats.MinMAN < 0 Then UserList(Userindex).Stats.MinMAN = 0
    Call QuitarSta(Userindex, Hechizos(uh).StaRequerido)
    Call SendUserMANASTA(Userindex)
    Call SendUserHPSTA(UserList(Userindex).flags.TargetUser)
    UserList(Userindex).flags.TargetUser = 0
End If

End Sub
Sub HandleHechizoNPC(Userindex As Integer, ByVal uh As Integer)
Dim b As Boolean

If Npclist(UserList(Userindex).flags.TargetNpc).flags.NoMagia = 1 Then
    Call SendData(ToIndex, Userindex, 0, "/U")
    Exit Sub
End If

If UserList(Userindex).flags.Protegido > 0 Then
    Call SendData(ToIndex, Userindex, 0, "||No podes atacar NPC's mientrás estas siendo protegido." & FONTTYPE_FIGHT)
    Exit Sub
End If

Select Case Hechizos(uh).Tipo
    Case uEstado
       Call HechizoEstadoNPC(UserList(Userindex).flags.TargetNpc, uh, b, Userindex)
    Case uPropiedades
       Call HechizoPropNPC(uh, UserList(Userindex).flags.TargetNpc, Userindex, b)
End Select

If b Then
    Call SubirSkill(Userindex, Magia)
    UserList(Userindex).flags.TargetNpc = 0
    Call QuitarSta(Userindex, Hechizos(uh).StaRequerido)
    UserList(Userindex).Stats.MinMAN = UserList(Userindex).Stats.MinMAN - ManaHechizo(Userindex, uh)
    If UserList(Userindex).Stats.MinMAN < 0 Then UserList(Userindex).Stats.MinMAN = 0
    Call SendUserMANASTA(Userindex)
End If

End Sub
Sub LanzarHechizo(Index As Integer, Userindex As Integer)
Dim uh As Integer
Dim exito As Boolean

If UserList(Userindex).flags.Protegido = 1 Then
    Call SendData(ToIndex, Userindex, 0, "||No podés tirar hechizos mientras estás siendo protegido por un GM." & FONTTYPE_FIGHT)
    Exit Sub
ElseIf UserList(Userindex).flags.Protegido = 2 Then
    Call SendData(ToIndex, Userindex, 0, "||No podés tirar hechizos tan pronto al conectarte." & FONTTYPE_FIGHT)
    Exit Sub
End If

uh = UserList(Userindex).Stats.UserHechizos(Index)

'automatico 1v1 2v2 no tirar hechiz a molestar solo spec

If MapData(UserList(Userindex).POS.Map, UserList(Userindex).POS.X, UserList(Userindex).POS.Y).trigger = 4 Then 'Si esta en zona de espera.
If (UserList(Userindex).POS.Map = 99 Or UserList(Userindex).POS.Map = 107) Then
If Hechizos(uh).Nombre = "Remover paralisis" Or Hechizos(uh).Nombre = "Celeridad" Or Hechizos(uh).Nombre = "Fuerza" Or Hechizos(uh).Nombre = "Llamado a las sombras" Or Hechizos(uh).Nombre = "Aura Divina" Or Hechizos(uh).Nombre = "Aura Divina" Or Hechizos(uh).Nombre = "Sombra de poder" Or Hechizos(uh).Nombre = "Curar heridas Leves" Or Hechizos(uh).Nombre = "Curar heridas Graves" Then
Call SendData(ToIndex, Userindex, 0, "||No puedes tirar hechizos a usuarios en el mapa de torneo espera tu turno." & FONTTYPE_INFO)
Exit Sub
End If
End If
Else
End If

If (UserList(Userindex).POS.Map = 148 Or UserList(Userindex).POS.Map = 150) And (Hechizos(uh).Invoca > 0 Or Hechizos(uh).SubeHP = 2 Or Hechizos(uh).Invisibilidad = 1 Or Hechizos(uh).Paraliza > 0 Or Hechizos(uh).Estupidez = 1) Then
    Call SendData(ToIndex, Userindex, 0, "||Una extraña energía te impide lanzar este hechizo..." & FONTTYPE_INFO)
    Exit Sub
End If

If TiempoTranscurrido(UserList(Userindex).Counters.LastHechizo) < IntervaloUserPuedeCastear Then Exit Sub
If TiempoTranscurrido(UserList(Userindex).Counters.LastGolpe) < IntervaloUserPuedeGolpeHechi Then Exit Sub
UserList(Userindex).Counters.LastHechizo = Timer
Call SendData(ToIndex, Userindex, 0, "LH")

If Hechizos(uh).Baculo > 0 And (UserList(Userindex).Clase = DRUIDA Or UserList(Userindex).Clase = MAGO Or UserList(Userindex).Clase = NIGROMANTE) Then
    If ObjData(UserList(Userindex).Invent.WeaponEqpObjIndex).Baculo < Hechizos(uh).Baculo Then
        If ObjData(UserList(Userindex).Invent.WeaponEqpObjIndex).Baculo = 0 Then
            Call SendData(ToIndex, Userindex, 0, "BN")
        Else: Call SendData(ToIndex, Userindex, 0, "||Debes equiparte un báculo de mayor rango para lanzar este hechizo." & FONTTYPE_INFO)
        End If
        Exit Sub
    End If
End If

If PuedeLanzar(Userindex, uh) Then
    Select Case Hechizos(uh).Target
        
        Case uUsuarios
            If UserList(Userindex).flags.TargetUser Then
                If UserList(UserList(Userindex).flags.TargetUser).POS.Y - UserList(Userindex).POS.Y >= 7 Then
                    Call SendData(ToIndex, Userindex, 0, "||Estas demasiado lejos para lanzar ese hechizo." & FONTTYPE_FIGHT)
                    Exit Sub
                End If
                Call HandleHechizoUsuario(Userindex, uh)
            Else
                Call SendData(ToIndex, Userindex, 0, "||Este hechizo actua solo sobre usuarios." & FONTTYPE_INFO)
            End If
            
        Case uNPC
            If UserList(Userindex).flags.TargetNpc Then
                Call HandleHechizoNPC(Userindex, uh)
            Else
                Call SendData(ToIndex, Userindex, 0, "||Este hechizo solo afecta a los npcs." & FONTTYPE_INFO)
            End If
            
        Case uUsuariosYnpc
            If UserList(Userindex).flags.TargetUser Then
                If UserList(UserList(Userindex).flags.TargetUser).POS.Y - UserList(Userindex).POS.Y >= 7 Then
                    Call SendData(ToIndex, Userindex, 0, "||Estas demasiado lejos para lanzar ese hechizo." & FONTTYPE_FIGHT)
                    Exit Sub
                End If
                Call HandleHechizoUsuario(Userindex, uh)
            ElseIf UserList(Userindex).flags.TargetNpc Then
                Call HandleHechizoNPC(Userindex, uh)
            Else
                Call SendData(ToIndex, Userindex, 0, "||Target invalido." & FONTTYPE_INFO)
            End If
            
        Case uTerreno
            Call HandleHechizoTerreno(Userindex, uh)
        
        Case uArea
            Call HandleHechizoArea(Userindex, uh)
        
    End Select
End If
                
End Sub
Sub HandleHechizoArea(Userindex As Integer, ByVal uh As Integer)
On Error GoTo Error
Dim TargetPos As WorldPos
Dim X2 As Integer, Y2 As Integer
Dim UI As Integer
Dim b As Boolean

TargetPos.Map = UserList(Userindex).flags.TargetMap
TargetPos.X = UserList(Userindex).flags.TargetX
TargetPos.Y = UserList(Userindex).flags.TargetY

For X2 = TargetPos.X - Hechizos(uh).RadioX To TargetPos.X + Hechizos(uh).RadioX
    For Y2 = TargetPos.Y - Hechizos(uh).RadioY To TargetPos.Y + Hechizos(uh).RadioY
        UI = MapData(TargetPos.Map, X2, Y2).Userindex
        If UI > 0 Then
            UserList(Userindex).flags.TargetUser = UI
            Select Case Hechizos(uh).Tipo
                Case uEstado
                    Call HechizoEstadoUsuario(Userindex, b)
                Case uPropiedades
                    Call HechizoPropUsuario(Userindex, b)
            End Select
        End If
    Next
Next

If b Then
    Call SubirSkill(Userindex, Magia)
    UserList(Userindex).Stats.MinMAN = UserList(Userindex).Stats.MinMAN - ManaHechizo(Userindex, uh)
    If UserList(Userindex).Stats.MinMAN < 0 Then UserList(Userindex).Stats.MinMAN = 0
    Call QuitarSta(Userindex, Hechizos(uh).StaRequerido)
    Call SendUserMANASTA(Userindex)
    UserList(Userindex).flags.TargetUser = 0
End If

Exit Sub
Error:
    Call LogError("Error en HandleHechizoArea")
End Sub
Public Function Amigos(Userindex As Integer, UI As Integer) As Boolean

Amigos = (((UserList(Userindex).Faccion.Bando = UserList(UI).Faccion.Bando) Or (EsNewbie(UI)) Or (EsNewbie(Userindex)))) Or (UserList(Userindex).POS.Map = 190) Or (UserList(Userindex).Faccion.Bando = Neutral)

End Function
Sub HechizoEstadoUsuario(Userindex As Integer, b As Boolean)
Dim H As Integer, TU As Integer, HechizoBueno As Boolean

H = UserList(Userindex).Stats.UserHechizos(UserList(Userindex).flags.Hechizo)
TU = UserList(Userindex).flags.TargetUser

HechizoBueno = Hechizos(H).RemoverParalisis Or Hechizos(H).CuraVeneno Or Hechizos(H).Invisibilidad Or Hechizos(H).Revivir Or Hechizos(H).Flecha Or Hechizos(H).Estupidez = 2 Or Hechizos(H).Transforma

If HechizoBueno Then
If UserList(Userindex).POS.Map = 77 Or UserList(Userindex).POS.Map = 190 Or UserList(Userindex).POS.Map = 88 Or UserList(Userindex).POS.Map = 94 Or UserList(Userindex).POS.Map = 107 Or UserList(Userindex).POS.Map = 90 Then
   ' If Not PuedeAtacar(Userindex, TU) Then Exit Sub ' todo esto es para que se puedan remover los crimis con neutros y  ciudas ^^ en esos mapas
    'If UserList(UserIndex).flags.Invisible Then Call BajarInvisible(UserIndex)
    Call UsuarioAtacadoPorUsuario(Userindex, TU)
Else
    If Not Amigos(Userindex, TU) Then
        Call SendData(ToIndex, Userindex, 0, "2F")
        Exit Sub
    End If
End If
Else
    If Not PuedeAtacar(Userindex, TU) Then Exit Sub
    'If UserList(UserIndex).flags.Invisible Then Call BajarInvisible(UserIndex)
    Call UsuarioAtacadoPorUsuario(Userindex, TU)
End If

If Hechizos(H).Envenena Then
    UserList(TU).flags.Envenenado = Hechizos(H).Envenena
    UserList(TU).flags.EstasEnvenenado = Timer
    UserList(TU).Counters.Veneno = Timer
    Call InfoHechizo(Userindex)
    b = True
    Exit Sub
End If

If Hechizos(H).Maldicion = 1 Then
    UserList(TU).flags.Maldicion = 1
    Call InfoHechizo(Userindex)
    b = True
    Exit Sub
End If

If Hechizos(H).Paraliza > 0 Then
     If UserList(TU).flags.Paralizado = 0 Then
        If (UserList(TU).Clase = MINERO And UserList(TU).Recompensas(2) = 1) Or (UserList(TU).Clase = PIRATA And UserList(TU).Recompensas(3) = 1) Then
            Call SendData(ToIndex, Userindex, 0, "%&")
            Exit Sub
        End If
    
        UserList(TU).flags.QuienParalizo = Userindex
        UserList(TU).flags.Paralizado = 1
        UserList(TU).Counters.Paralisis = Timer - 15 * Buleano(UserList(TU).Clase = GUERRERO And UserList(TU).Recompensas(3) = 2)
        Call SendData(ToIndex, TU, 0, "PU" & DesteEncripTE(UserList(TU).POS.X & "," & UserList(TU).POS.Y))
        Call SendData(ToIndex, TU, 0, ("P9"))
        Call InfoHechizo(Userindex)
        b = True
        Exit Sub
    End If
End If

If Hechizos(H).Ceguera = 1 Then
    UserList(TU).flags.Ceguera = 1
    UserList(TU).Counters.Ceguera = Timer
    Call SendData(ToIndex, TU, 0, "CEGU")
    Call InfoHechizo(Userindex)
    b = True
    Exit Sub
End If

If Hechizos(H).Estupidez = 1 Then
    UserList(TU).flags.Estupidez = 1
    UserList(TU).Counters.Estupidez = Timer
    Call SendData(ToIndex, TU, 0, "DUMB")
    Call InfoHechizo(Userindex)
    b = True
    Exit Sub
End If

If Hechizos(H).Transforma = 1 Then
     If UserList(TU).flags.Transformado = 0 Then
        If UserList(TU).Stats.ELV > 39 And UserList(TU).Raza = ELFO And UserList(TU).Clase = DRUIDA Then
            Call DoMetamorfosis(Userindex)
        Else
            Call SendData(ToIndex, Userindex, 0, "{E")
        End If
        Call InfoHechizo(Userindex)
        b = True
        Exit Sub
    End If
End If

If Hechizos(H).Revivir = 1 Then
   If MapInfo(UserList(TU).POS.Map).EsMapaEspecial Then Exit Sub
   
    If MapInfo(UserList(TU).POS.Map).Pk = False Then
    Call SendData(ToIndex, TU, 0, "||No puedes tirar resucitar en zona segura." & FONTTYPE_TALK)
    Exit Sub
    End If

    If UserList(TU).flags.Muerto Then
        Call RevivirUsuario(Userindex, TU, UserList(Userindex).Clase = CLERIGO And UserList(Userindex).Recompensas(3) = 2)
        Call InfoHechizo(Userindex)
        b = True
        Exit Sub
    End If
End If

If UserList(TU).flags.Muerto Then
    Call SendData(ToIndex, Userindex, 0, "8C")
    Exit Sub
End If

If Hechizos(H).Estupidez = 2 Then
    If UserList(TU).flags.Estupidez = 1 Then
        UserList(TU).flags.Estupidez = 0
        UserList(TU).Counters.Estupidez = 0
        Call SendData(ToIndex, TU, 0, "NESTUP")
        Call InfoHechizo(Userindex)
        b = True
        Exit Sub
    End If
End If

If Hechizos(H).Flecha = 1 Then
    If TU <> Userindex Then
        Call SendData(ToIndex, Userindex, 0, "||Este hechizo solo puedes usarlo sobre ti mismo." & FONTTYPE_INFO)
        Exit Sub
    End If
    UserList(TU).flags.BonusFlecha = True
    UserList(TU).Counters.BonusFlecha = Timer
    Call InfoHechizo(Userindex)
    b = True
    Exit Sub
End If

If Hechizos(H).RemoverParalisis = 1 Then
    If UserList(TU).flags.Paralizado Then
    Call SendData(ToIndex, TU, 0, "P8")
        UserList(TU).flags.Paralizado = 0
        UserList(TU).flags.QuienParalizo = 0
        Call InfoHechizo(Userindex)
        b = True
        Exit Sub
    End If
End If

If Hechizos(H).Invisibilidad = 1 Then
If MapInfo(UserList(TU).POS.Map).EsMapaEspecial Then Exit Sub
    If UserList(TU).flags.Invisible Then Exit Sub
    UserList(TU).flags.Invisible = 1
    UserList(TU).Counters.Invisibilidad = Timer
    Call SendData(ToMap, 0, UserList(TU).POS.Map, ("V3" & DesteEncripTE("1," & UserList(TU).Char.CharIndex)))
    Call InfoHechizo(Userindex)
    b = True
    Exit Sub
End If

If Hechizos(H).CuraVeneno = 1 Then
    If UserList(TU).flags.Envenenado = 1 Then
        UserList(TU).flags.Envenenado = 0
        Call InfoHechizo(Userindex)
        b = True
        Exit Sub
    Else
        Call SendData(ToIndex, Userindex, 0, "||El usuario no está envenenado." & FONTTYPE_FIGHT)
        Exit Sub
    End If
End If

If Hechizos(H).RemoverMaldicion = 1 Then
    UserList(TU).flags.Maldicion = 0
    Call InfoHechizo(Userindex)
    b = True
    Exit Sub
End If

If Hechizos(H).Bendicion = 1 Then
    UserList(TU).flags.Bendicion = 1
    Call InfoHechizo(Userindex)
    b = True
    Exit Sub
End If

End Sub
Sub HechizoEstadoNPC(NpcIndex As Integer, ByVal hIndex As Integer, b As Boolean, Userindex As Integer)

If Npclist(NpcIndex).Attackable = 0 Then Exit Sub

If Hechizos(hIndex).Invisibilidad = 1 Then
   Call InfoHechizo(Userindex)
   Npclist(NpcIndex).flags.Invisible = 1
   b = True
End If

If Hechizos(hIndex).Envenena = 1 Then
   If Npclist(NpcIndex).Attackable = 0 Then
        Call SendData(ToIndex, Userindex, 0, "NO")
        Exit Sub
   End If
   Call InfoHechizo(Userindex)
   Npclist(NpcIndex).flags.Envenenado = 1
   b = True
End If

If Hechizos(hIndex).CuraVeneno = 1 Then
   Call InfoHechizo(Userindex)
   Npclist(NpcIndex).flags.Envenenado = 0
   b = True
End If

If Hechizos(hIndex).Maldicion = 1 Then
   If Npclist(NpcIndex).Attackable = 0 Then
        Call SendData(ToIndex, Userindex, 0, "NO")
        Exit Sub
   End If
   Call InfoHechizo(Userindex)
   Npclist(NpcIndex).flags.Maldicion = 1
   b = True
End If

If Hechizos(hIndex).RemoverMaldicion = 1 Then
   Call InfoHechizo(Userindex)
   Npclist(NpcIndex).flags.Maldicion = 0
   b = True
End If

If Hechizos(hIndex).Bendicion = 1 Then
   Call InfoHechizo(Userindex)
   Npclist(NpcIndex).flags.Bendicion = 1
   b = True
End If

If Hechizos(hIndex).Paraliza Then

    If Npclist(NpcIndex).flags.QuienParalizo <> 0 And Npclist(NpcIndex).flags.QuienParalizo <> Userindex Then Exit Sub
        If Npclist(NpcIndex).flags.AfectaParalisis = 0 Then
            Call InfoHechizo(Userindex)
            Npclist(NpcIndex).flags.Paralizado = Hechizos(hIndex).Paraliza
            Npclist(NpcIndex).flags.QuienParalizo = Userindex
            If Npclist(NpcIndex).flags.PocaParalisis = 1 Then
                Npclist(NpcIndex).Contadores.Paralisis = IntervaloParalizado / 4
            Else: Npclist(NpcIndex).Contadores.Paralisis = IntervaloParalizado
            End If
            b = True
    Else: Call SendData(ToIndex, Userindex, 0, "7D")
    End If
End If

If Hechizos(hIndex).RemoverParalisis = 1 Then
    If Npclist(NpcIndex).flags.QuienParalizo = Userindex Or Npclist(NpcIndex).MaestroUser = Userindex Then
       If Npclist(NpcIndex).flags.Paralizado Then
            Call InfoHechizo(Userindex)
            Npclist(NpcIndex).flags.Paralizado = 0
            Npclist(NpcIndex).Contadores.Paralisis = 0
            Npclist(NpcIndex).flags.QuienParalizo = 0
            b = True
       End If
    Else
        Call SendData(ToIndex, Userindex, 0, "8D")
    End If
End If

End Sub
Sub VerNPCMuere(ByVal NpcIndex As Integer, ByVal Daño As Long, ByVal Userindex As Integer)

If Npclist(NpcIndex).AutoCurar = 0 Then Npclist(NpcIndex).Stats.MinHP = Maximo(0, Npclist(NpcIndex).Stats.MinHP - Daño)

If Npclist(NpcIndex).Stats.MinHP <= 0 Then
    If Npclist(NpcIndex).flags.Snd3 Then Call SendData(ToNPCArea, NpcIndex, Npclist(NpcIndex).POS.Map, "TW" & Npclist(NpcIndex).flags.Snd3)
    
    If Userindex Then
        If UserList(Userindex).NroMascotas Then
            Dim T As Integer
            For T = 1 To MAXMASCOTAS * Buleano(Not UserList(Userindex).flags.Quest)
                If UserList(Userindex).MascotasIndex(T) Then
                    If Npclist(UserList(Userindex).MascotasIndex(T)).TargetNpc = NpcIndex Then Call FollowAmo(UserList(Userindex).MascotasIndex(T))
                End If
            Next
        End If
        Call AddtoVar(UserList(Userindex).Stats.NPCsMuertos, 1, 32000)
        
        UserList(Userindex).flags.TargetNpc = 0
        UserList(Userindex).flags.TargetNpcTipo = 0
    End If
    
    Call MuereNpc(NpcIndex, Userindex)
End If

End Sub
Sub ExperienciaPorGolpe(Userindex As Integer, ByVal NpcIndex As Integer, Daño As Integer)
Dim ExpDada As Long


Daño = Minimo(Daño, Npclist(NpcIndex).Stats.MinHP)

ExpDada = Npclist(NpcIndex).GiveEXP * (Daño / Npclist(NpcIndex).Stats.MaxHP) / 2

If Daño >= Npclist(NpcIndex).Stats.MinHP Then ExpDada = ExpDada + Npclist(NpcIndex).GiveEXP / 2
If ModoQuest Then ExpDada = ExpDada / 2

If UserList(Userindex).flags.Party = 0 Then
    UserList(Userindex).Stats.Exp = UserList(Userindex).Stats.Exp + ExpDada
    If Daño >= Npclist(NpcIndex).Stats.MinHP Then
        Call SendData(ToIndex, Userindex, 0, "EL" & ExpDada)
    Else: Call SendData(ToIndex, Userindex, 0, "EX" & ExpDada)
    End If
    Call SendUserEXP(Userindex)
    Call CheckUserLevel(Userindex)
    Exit Sub
Else: Call RepartirExp(Userindex, ExpDada, Daño >= Npclist(NpcIndex).Stats.MinHP)
End If
End Sub

Sub HechizoPropNPC(ByVal hIndex As Integer, NpcIndex As Integer, Userindex As Integer, b As Boolean)
Dim Daño As Integer
Dim ClanCastillo As Integer
Dim uh As Integer
uh = UserList(Userindex).Stats.UserHechizos(UserList(Userindex).flags.Hechizo)
If Npclist(NpcIndex).Attackable = 0 Then Exit Sub

If Npclist(NpcIndex).Numero = NPCRey Then
If UserList(Userindex).GuildInfo.GuildName = "" Then
Call SendData(ToIndex, Userindex, 0, "||No puedes atacar al rey de clanes sin tener clan." & FONTTYPE_INFO)
Exit Sub
End If
End If

If Not Hechizos(uh).Nombre = "Curar heridas Graves" Then
If Npclist(NpcIndex).Numero = NPCRey Then
If UserList(Userindex).flags.DominandoCastillo Then
Call SendData(ToCasTLE, 0, 0, "||No puedes atacar a tu rey." & FONTTYPE_FIGHTT)
Exit Sub
End If
End If
End If

If Npclist(NpcIndex).Numero = NPCRey Then
GolpesRey = GolpesRey + 1
If GolpesRey = 15 Then
Call SendData(ToCasTLE, 0, 0, "||El rey esta siendo atacado!!" & FONTTYPE_FIGHTT)
GolpesRey = 0
End If
End If

If Hechizos(hIndex).SubeHP = 1 Then
    Daño = DañoHechizo(Userindex, hIndex)

    
    Call AddtoVar(Npclist(NpcIndex).Stats.MinHP, Daño, Npclist(NpcIndex).Stats.MaxHP)
    Call SendData(ToIndex, Userindex, 0, "CU" & Daño)
    Call InfoHechizo(Userindex)
        Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "HM" & FONTTYPE_ORO & "°" & "+" & Daño & "°" & Npclist(NpcIndex).POS.X & "°" & Npclist(NpcIndex).POS.Y & "°" & Npclist(NpcIndex).Char.CharIndex & "º" & "1")
    
    b = True
ElseIf Hechizos(hIndex).SubeHP = 2 Then
    
    Daño = DañoHechizo(Userindex, hIndex)

    If ObjData(UserList(Userindex).Invent.WeaponEqpObjIndex).Name = "Baculo Ancestral" Then
        Daño = 1.05 * Daño
    ElseIf ObjData(UserList(Userindex).Invent.WeaponEqpObjIndex).Baculo = Hechizos(hIndex).Baculo Then
        Daño = 0.95 * Daño
    End If
    
    If GRANPODERActivado = True Then
    If Userindex = GranPoder Then Daño = Daño * 1.3
    End If

    If Npclist(NpcIndex).Attackable = 0 Then
        Call SendData(ToIndex, Userindex, 0, "NO")
        Exit Sub
    End If

    If UserList(Userindex).Faccion.Bando <> Neutral And Npclist(NpcIndex).MaestroUser Then
        If Not PuedeAtacarMascota(Userindex, (Npclist(NpcIndex).MaestroUser)) Then Exit Sub
    End If
    
    If UserList(Userindex).Faccion.Bando <> Neutral And UserList(Userindex).Faccion.Bando = Npclist(NpcIndex).flags.Faccion Then
        Call SendData(ToIndex, Userindex, 0, Mensajes(Npclist(NpcIndex).flags.Faccion, 19))
        Exit Sub
    End If
    

    b = True
    Call NpcAtacado(NpcIndex, Userindex)
    
    If Npclist(NpcIndex).flags.Snd2 Then Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "TW" & Npclist(NpcIndex).flags.Snd2)
    
    Call SendData(ToIndex, Userindex, 0, "X2" & Daño)
    
    Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "HM" & FONTTYPE_ORO & "°" & Daño & "°" & Npclist(NpcIndex).POS.X & "°" & Npclist(NpcIndex).POS.Y & "°" & Npclist(NpcIndex).Char.CharIndex)
    
    Call ExperienciaPorGolpe(Userindex, NpcIndex, Daño)
        


    Call VerNPCMuere(NpcIndex, Daño, Userindex)
    
        Call InfoHechizo(Userindex)
End If

End Sub
Sub InfoHechizo(Userindex As Integer)
Dim H As Integer
H = UserList(Userindex).Stats.UserHechizos(UserList(Userindex).flags.Hechizo)

Call DecirPalabrasMagicas(Hechizos(H).PalabrasMagicas, Userindex)
Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "TW" & Hechizos(H).WAV)

If UserList(Userindex).flags.TargetUser Then
     
    If UserList(Userindex).POS.Map = UserList(UserList(Userindex).flags.TargetUser).POS.Map Then
    Call SendData(ToPCArea, Userindex, UserList(UserList(Userindex).flags.TargetUser).POS.Map, "CFX" & UserList(Userindex).Char.CharIndex & "," & UserList(UserList(Userindex).flags.TargetUser).Char.CharIndex & "," & Hechizos(H).FXgrh & "," & Hechizos(H).Particula & "," & Hechizos(H).loops) 'dx8
    End If
    
ElseIf UserList(Userindex).flags.TargetNpc Then
     
    If Not Npclist(UserList(Userindex).flags.TargetNpc).Stats.MinHP < 0 Then
    Call SendData(ToPCArea, Userindex, Npclist(UserList(Userindex).flags.TargetNpc).POS.Map, "CFX" & UserList(Userindex).Char.CharIndex & "," & Npclist(UserList(Userindex).flags.TargetNpc).Char.CharIndex & "," & Hechizos(H).FXgrh & "," & Hechizos(H).Particula & "," & Hechizos(H).loops)  'dx8
    End If
    
End If

If UserList(Userindex).flags.TargetUser Then
    If Userindex <> UserList(Userindex).flags.TargetUser Then
        Call SendData(ToIndex, Userindex, 0, "||" & Hechizos(H).HechizeroMsg & " " & UserList(UserList(Userindex).flags.TargetUser).Name & FONTTYPE_ATACO)
        Call SendData(ToIndex, UserList(Userindex).flags.TargetUser, 0, "||" & UserList(Userindex).Name & " " & Hechizos(H).TargetMsg & FONTTYPE_FIGHT)
    Else
        Call SendData(ToIndex, Userindex, 0, "||" & Hechizos(H).PropioMsg & FONTTYPE_FIGHT)
    End If
ElseIf UserList(Userindex).flags.TargetNpc Then
    Call SendData(ToIndex, Userindex, 0, "||" & Hechizos(H).HechizeroMsg & " " & "la criatura." & FONTTYPE_ATACO)
End If
    
End Sub
Function DañoHechizo(Userindex As Integer, Hechizo As Integer) As Integer

DañoHechizo = RandomNumber(Hechizos(Hechizo).MinHP + 5 _
+ 10 * Buleano(UserList(Userindex).Clase = NIGROMANTE And UserList(Userindex).Recompensas(3) = 1) _
+ 20 * Buleano(UserList(Userindex).Clase = CLERIGO And UserList(Userindex).Recompensas(3) = 1 And Hechizo = 5) _
+ 10 * Buleano(UserList(Userindex).Clase = MAGO And UserList(Userindex).Recompensas(3) = 2 And Hechizo = 25), _
Hechizos(Hechizo).MaxHP + 5 * Buleano(UserList(Userindex).Clase = LADRON And UserList(Userindex).Recompensas(3) = 2 And (Hechizo = 23 Or Hechizo = 25)) _
+ 20 * Buleano(UserList(Userindex).Clase = CLERIGO And UserList(Userindex).Recompensas(3) = 1 And Hechizo = 5) _
+ 10 * Buleano(UserList(Userindex).Clase = MAGO And UserList(Userindex).Recompensas(3) = 1 And Hechizo = 23))


'DañoHechizo = RandomNumber(Hechizos(Hechizo).MinHP + 5 * Buleano(UserList(Userindex).Clase = BARDO And UserList(Userindex).Recompensas(3) = 2 And (Hechizo = 23 Or Hechizo = 25)) _
'+ 10 * Buleano(UserList(Userindex).Clase = NIGROMANTE And UserList(Userindex).Recompensas(3) = 1) _
'+ 20 * Buleano(UserList(Userindex).Clase = CLERIGO And UserList(Userindex).Recompensas(3) = 1 And Hechizo = 5) _
'+ 10 * Buleano(UserList(Userindex).Clase = MAGO And UserList(Userindex).Recompensas(3) = 2 And Hechizo = 25), _
'Hechizos(Hechizo).MaxHP + 5 * Buleano(UserList(Userindex).Clase = BARDO Or Hechizos(Hechizo).MaxHP + 5 * Buleano(UserList(Userindex).Clase = CLERIGO And UserList(Userindex).Recompensas(3) = 2 And (Hechizo = 23 Or Hechizo = 25)) _
'+ 20 * Buleano(UserList(Userindex).Clase = CLERIGO And UserList(Userindex).Recompensas(3) = 1 And Hechizo = 5) _
'+ 10 * Buleano(UserList(Userindex).Clase = MAGO And UserList(Userindex).Recompensas(3) = 1 And Hechizo = 23)))

DañoHechizo = DañoHechizo + Porcentaje(DañoHechizo, 3 * 45)

'If UserList(Userindex).Stats.ELV <= 47 Then  ' por lvl 50
'    DañoHechizo = DañoHechizo + Porcentaje(DañoHechizo, 3 * UserList(Userindex).Stats.ELV)
'Else
'    DañoHechizo = DañoHechizo + Porcentaje(DañoHechizo, 3 * 47)
'End If

End Function
Sub HechizoPropUsuario(Userindex As Integer, b As Boolean)
Dim H As Integer
Dim Daño As Integer
Dim tempChr As Integer
Dim reducido As Integer
Dim HechizoBueno As Boolean
Dim msg As String

H = UserList(Userindex).Stats.UserHechizos(UserList(Userindex).flags.Hechizo)
tempChr = UserList(Userindex).flags.TargetUser

HechizoBueno = Hechizos(H).SubeHam = 1 Or Hechizos(H).SubeSed = 1 Or Hechizos(H).SubeHP = 1 Or Hechizos(H).SubeAgilidad = 1 Or Hechizos(H).SubeFuerza = 1 Or Hechizos(H).SubeFuerza = 3 Or Hechizos(H).SubeMana = 1 Or Hechizos(H).SubeSta = 1

If HechizoBueno And Not Amigos(Userindex, tempChr) Then
    Call SendData(ToIndex, Userindex, 0, "2F")
    Exit Sub
ElseIf Not HechizoBueno Then
    If Not PuedeAtacar(Userindex, tempChr) Then Exit Sub
    'If UserList(UserIndex).flags.Invisible Then Call BajarInvisible(UserIndex)
    Call UsuarioAtacadoPorUsuario(Userindex, tempChr)
End If

If Hechizos(H).Revivir = 0 And UserList(tempChr).flags.Muerto Then Exit Sub

If Hechizos(H).SubeHam = 1 Then
    
    Daño = RandomNumber(Hechizos(H).MinHam, Hechizos(H).MaxHam)
    Call InfoHechizo(Userindex)
    
    Call AddtoVar(UserList(tempChr).Stats.MinHam, Daño, UserList(tempChr).Stats.MaxHam)
    
    If Userindex <> tempChr Then
        Call SendData(ToIndex, Userindex, 0, "||Le has restaurado " & Daño & " puntos de hambre a " & UserList(tempChr).Name & FONTTYPE_FIGHT)
        Call SendData(ToIndex, tempChr, 0, "||" & UserList(Userindex).Name & " te ha restaurado " & Daño & " puntos de hambre." & FONTTYPE_FIGHT)
    Else
        Call SendData(ToIndex, Userindex, 0, "||Te has restaurado " & Daño & " puntos de hambre." & FONTTYPE_FIGHT)
    End If
    
    Call EnviarHyS(tempChr)
    b = True

ElseIf Hechizos(H).SubeHam = 2 Then

    If MapInfo(UserList(Userindex).POS.Map).EsMapaEspecial Then Exit Sub
    Daño = RandomNumber(Hechizos(H).MinHam, Hechizos(H).MaxHam)
    UserList(tempChr).Stats.MinHam = Maximo(0, UserList(tempChr).Stats.MinHam - Daño)
    
    Call InfoHechizo(Userindex)
    
    If Userindex <> tempChr Then
        Call SendData(ToIndex, Userindex, 0, "||Le has quitado " & Daño & " puntos de hambre a " & UserList(tempChr).Name & FONTTYPE_FIGHT)
        Call SendData(ToIndex, tempChr, 0, "||" & UserList(Userindex).Name & " te ha quitado " & Daño & " puntos de hambre." & FONTTYPE_FIGHT)
    Else
        Call SendData(ToIndex, Userindex, 0, "||Te has quitado " & Daño & " puntos de hambre." & FONTTYPE_FIGHT)
    End If
    If UserList(tempChr).Stats.MinHam = 0 Then UserList(tempChr).flags.Hambre = 1
    Call EnviarHyS(tempChr)
    b = True
End If


If Hechizos(H).SubeSed = 1 Then
    
    Call AddtoVar(UserList(tempChr).Stats.MinAGU, Daño, UserList(tempChr).Stats.MaxAGU)
    Call InfoHechizo(Userindex)
    
    If Userindex <> tempChr Then
      Call SendData(ToIndex, Userindex, 0, "||Le has restaurado " & Daño & " puntos de sed a " & UserList(tempChr).Name & FONTTYPE_FIGHT)
      Call SendData(ToIndex, tempChr, 0, "||" & UserList(Userindex).Name & " te ha restaurado " & Daño & " puntos de sed." & FONTTYPE_FIGHT)
    Else
      Call SendData(ToIndex, Userindex, 0, "||Te has restaurado " & Daño & " puntos de sed." & FONTTYPE_FIGHT)
    End If
    
    b = True

ElseIf Hechizos(H).SubeSed = 2 Then

    If MapInfo(UserList(Userindex).POS.Map).EsMapaEspecial Then Exit Sub
    Daño = RandomNumber(Hechizos(H).MinSed, Hechizos(H).MaxSed)
    UserList(tempChr).Stats.MinAGU = Maximo(0, UserList(tempChr).Stats.MinAGU - Daño)
    Call InfoHechizo(Userindex)
    
    If Userindex <> tempChr Then
        Call SendData(ToIndex, Userindex, 0, "||Le has quitado " & Daño & " puntos de sed a " & UserList(tempChr).Name & FONTTYPE_FIGHT)
        Call SendData(ToIndex, tempChr, 0, "||" & UserList(Userindex).Name & " te ha quitado " & Daño & " puntos de sed." & FONTTYPE_FIGHT)
    Else
        Call SendData(ToIndex, Userindex, 0, "||Te has quitado " & Daño & " puntos de sed." & FONTTYPE_FIGHT)
    End If
    
    If UserList(tempChr).Stats.MinAGU = 0 Then UserList(tempChr).flags.Sed = 1
    b = True
ElseIf Hechizos(H).SubeSed = 3 Then
    
    UserList(tempChr).Stats.MinAGU = 0
    UserList(tempChr).Stats.MinHam = 0
    UserList(tempChr).Stats.MinSta = 0
    UserList(tempChr).flags.Sed = 1
    UserList(tempChr).flags.Hambre = 1
    
    Call InfoHechizo(Userindex)
    
    If Userindex <> tempChr Then
        Call SendData(ToIndex, Userindex, 0, "S3" & UserList(tempChr).Name)
        Call SendData(ToIndex, tempChr, 0, "S4" & UserList(Userindex).Name)
    Else
        Call SendData(ToIndex, Userindex, 0, "S5")
    End If
    Call SendData(ToIndex, tempChr, 0, "2G")
    
    b = True
End If


If Hechizos(H).SubeAgilidad = 1 Then
    Daño = RandomNumber(Hechizos(H).MinAgilidad, Hechizos(H).MaxAgilidad)
    
    UserList(tempChr).flags.DuracionEfecto = Timer
    Call AddtoVar(UserList(tempChr).Stats.UserAtributos(Agilidad), Daño, Minimo(UserList(tempChr).Stats.UserAtributosBackUP(Agilidad) * 2, MAXATRIBUTOS))
    Call InfoHechizo(Userindex)
    Call UpdateFuerzaYAg(tempChr)
    UserList(tempChr).flags.TomoPocion = True
    b = True

ElseIf Hechizos(H).SubeAgilidad = 2 Then
    UserList(tempChr).flags.TomoPocion = True
    Daño = RandomNumber(Hechizos(H).MinAgilidad, Hechizos(H).MaxAgilidad)
    UserList(tempChr).flags.DuracionEfecto = Timer
    Call RestVar(UserList(tempChr).Stats.UserAtributos(Agilidad), Daño, MINATRIBUTOS)
    Call InfoHechizo(Userindex)
    Call UpdateFuerzaYAg(tempChr)
    b = True
ElseIf Hechizos(H).SubeAgilidad = 3 Then
    UserList(tempChr).flags.TomoPocion = True
    Daño = RandomNumber(Hechizos(H).MinAgilidad, Hechizos(H).MaxAgilidad)
    UserList(tempChr).flags.DuracionEfecto = Timer
    Call RestVar(UserList(tempChr).Stats.UserAtributos(Agilidad), Daño, MINATRIBUTOS)
    Call RestVar(UserList(tempChr).Stats.UserAtributos(fuerza), Daño, MINATRIBUTOS)
    Call InfoHechizo(Userindex)
    Call UpdateFuerzaYAg(tempChr)
    b = True
End If


If Hechizos(H).SubeFuerza = 1 Then
    Daño = RandomNumber(Hechizos(H).MinFuerza, Hechizos(H).MaxFuerza)
    UserList(tempChr).flags.DuracionEfecto = Timer
    Call AddtoVar(UserList(tempChr).Stats.UserAtributos(fuerza), Daño, Minimo(UserList(tempChr).Stats.UserAtributosBackUP(fuerza) * 2, MAXATRIBUTOS))
    Call InfoHechizo(Userindex)
    Call UpdateFuerzaYAg(tempChr)
    UserList(tempChr).flags.TomoPocion = True
    b = True
ElseIf Hechizos(H).SubeFuerza = 2 Then
    UserList(tempChr).flags.TomoPocion = True
    Daño = RandomNumber(Hechizos(H).MinFuerza, Hechizos(H).MaxFuerza)
    UserList(tempChr).flags.DuracionEfecto = Timer
    Call RestVar(UserList(tempChr).Stats.UserAtributos(fuerza), Daño, MINATRIBUTOS)
    Call InfoHechizo(Userindex)
    Call UpdateFuerzaYAg(tempChr)
    b = True
ElseIf Hechizos(H).SubeFuerza = 3 Then
    Daño = RandomNumber(Hechizos(H).MinFuerza, Hechizos(H).MaxFuerza)
    UserList(tempChr).flags.DuracionEfecto = Timer
    Call AddtoVar(UserList(tempChr).Stats.UserAtributos(fuerza), Daño, Minimo(UserList(tempChr).Stats.UserAtributosBackUP(fuerza) * 2, MAXATRIBUTOS))
    Call AddtoVar(UserList(tempChr).Stats.UserAtributos(Agilidad), Daño, Minimo(UserList(tempChr).Stats.UserAtributosBackUP(Agilidad) * 2, MAXATRIBUTOS))
    Call InfoHechizo(Userindex)
    Call UpdateFuerzaYAg(tempChr)
    UserList(tempChr).flags.TomoPocion = True
    b = True
End If


If Hechizos(H).SubeHP = 1 Then
    If UserList(tempChr).flags.Muerto = 1 Then Exit Sub
    
    If UserList(tempChr).Stats.MinHP = UserList(tempChr).Stats.MaxHP Then
        Call SendData(ToIndex, Userindex, 0, "9D")
        Exit Sub
    End If
    Daño = DañoHechizo(Userindex, H)
    
    Call AddtoVar(UserList(tempChr).Stats.MinHP, Daño, UserList(tempChr).Stats.MaxHP)
    Call InfoHechizo(Userindex)
    
    If Userindex <> tempChr Then
        Call SendData(ToIndex, Userindex, 0, "R3" & Daño & "," & UserList(tempChr).Name)
        Call SendData(ToIndex, tempChr, 0, "R4" & UserList(Userindex).Name & "," & Daño)
    Else
        Call SendData(ToIndex, Userindex, 0, "R5" & Daño)
    End If
      Call SendData(ToPCArea, tempChr, UserList(tempChr).POS.Map, "HM" & FONTTYPE_ORO & "°" & "+" & Daño & "°" & UserList(tempChr).POS.X & "°" & UserList(tempChr).POS.Y & "°" & UserList(tempChr).Char.CharIndex & "°" & "1")

    b = True
ElseIf Hechizos(H).SubeHP = 2 Then
    Daño = DañoHechizo(Userindex, H)
    
    If Hechizos(H).Baculo > 0 And (UserList(Userindex).Clase = DRUIDA Or UserList(Userindex).Clase = MAGO Or UserList(Userindex).Clase = NIGROMANTE) Then
        If ObjData(UserList(Userindex).Invent.WeaponEqpObjIndex).Baculo < Hechizos(H).Baculo Then
            Call SendData(ToIndex, Userindex, 0, "BN")
            Exit Sub
        Else
            If ObjData(UserList(Userindex).Invent.WeaponEqpObjIndex).Name = "Báculo Oscuro" Then
                Daño = 1.05 * Daño
            ElseIf ObjData(UserList(Userindex).Invent.WeaponEqpObjIndex).Baculo = Hechizos(H).Baculo Then
                Daño = 0.95 * Daño
            End If
        End If
    End If
    
    If UserList(tempChr).Invent.CascoEqpObjIndex Then
        Dim Obj As ObjData
        Obj = ObjData(UserList(tempChr).Invent.CascoEqpObjIndex)
        If Obj.Gorro = 1 Then Daño = Maximo(1, (1 - (RandomNumber(Obj.MinDef, Obj.MaxDef) / 100)) * Daño)
        Daño = Maximo(1, Daño)
    End If
    
    If GRANPODERActivado = True Then
    If Userindex = GranPoder Then Daño = Daño * 1.3
    End If
    
    If Not UserList(tempChr).flags.Quest Then UserList(tempChr).Stats.MinHP = UserList(tempChr).Stats.MinHP - Daño
    Call InfoHechizo(Userindex)
    
    Call SendData(ToIndex, Userindex, 0, "6B" & Daño & "," & UserList(tempChr).Name)
    Call SendData(ToIndex, tempChr, 0, "7B" & Daño & "," & UserList(Userindex).Name)
    
    Call SendData(ToPCArea, tempChr, UserList(tempChr).POS.Map, "HM" & FONTTYPE_ORO & "°" & Daño & "°" & UserList(tempChr).POS.X & "°" & UserList(tempChr).POS.Y & "°" & UserList(tempChr).Char.CharIndex)

    
    If UserList(tempChr).Stats.MinHP > 0 Then
        Call SubirSkill(tempChr, Resistencia)
    Else
        Call ContarMuerte(tempChr, Userindex)
        UserList(tempChr).Stats.MinHP = 0
        Call ActStats(tempChr, Userindex)
    End If
    
    b = True
End If


If Hechizos(H).SubeMana = 1 Then
    Call AddtoVar(UserList(tempChr).Stats.MinMAN, Daño, UserList(tempChr).Stats.MaxMAN)
    Call InfoHechizo(Userindex)
    
    If Userindex <> tempChr Then
        Call SendData(ToIndex, Userindex, 0, "||Le has restaurado " & Daño & " puntos de mana a " & UserList(tempChr).Name & FONTTYPE_FIGHT)
        Call SendData(ToIndex, tempChr, 0, "||" & UserList(Userindex).Name & " te ha restaurado " & Daño & " puntos de mana." & FONTTYPE_FIGHT)
    Else
        Call SendData(ToIndex, Userindex, 0, "||Te has restaurado " & Daño & " puntos de mana." & FONTTYPE_FIGHT)
    End If
    
    b = True

ElseIf Hechizos(H).SubeMana = 2 Then

    Call InfoHechizo(Userindex)
    
    If Userindex <> tempChr Then
        Call SendData(ToIndex, Userindex, 0, "||Le has quitado " & Daño & " puntos de mana a " & UserList(tempChr).Name & FONTTYPE_FIGHT)
        Call SendData(ToIndex, tempChr, 0, "||" & UserList(Userindex).Name & " te ha quitado " & Daño & " puntos de mana." & FONTTYPE_FIGHT)
    Else
        Call SendData(ToIndex, Userindex, 0, "||Te has quitado " & Daño & " puntos de mana." & FONTTYPE_FIGHT)
    End If
    
    UserList(tempChr).Stats.MinMAN = Maximo(0, UserList(tempChr).Stats.MinMAN - Daño)
    b = True
    
End If


If Hechizos(H).SubeSta = 1 Then
    Call AddtoVar(UserList(tempChr).Stats.MinSta, Daño, UserList(tempChr).Stats.MaxSta)
    
    Call InfoHechizo(Userindex)
    
    If Userindex <> tempChr Then
         Call SendData(ToIndex, Userindex, 0, "||Le has restaurado " & Daño & " puntos de vitalidad a " & UserList(tempChr).Name & FONTTYPE_FIGHT)
         Call SendData(ToIndex, tempChr, 0, "||" & UserList(Userindex).Name & " te ha restaurado " & Daño & " puntos de vitalidad." & FONTTYPE_FIGHT)
    Else
        Call SendData(ToIndex, Userindex, 0, "||Te has restaurado " & Daño & " puntos de vitalidad." & FONTTYPE_FIGHT)
    End If
    Call SendData(ToPCArea, tempChr, UserList(tempChr).POS.Map, "HM" & FONTTYPE_ORO & "°" & Daño & "°" & UserList(tempChr).POS.X & "°" & UserList(tempChr).POS.Y & "°" & UserList(tempChr).Char.CharIndex & "°" & "1")

    b = True
ElseIf Hechizos(H).SubeSta = 2 Then
    Call InfoHechizo(Userindex)

    If Userindex <> tempChr Then
        Call SendData(ToIndex, Userindex, 0, "||Le has quitado " & Daño & " puntos de vitalidad a " & UserList(tempChr).Name & FONTTYPE_FIGHT)
        Call SendData(ToIndex, tempChr, 0, "||" & UserList(Userindex).Name & " te ha quitado " & Daño & " puntos de vitalidad." & FONTTYPE_FIGHT)
    Else
        Call SendData(ToIndex, Userindex, 0, "||Te has quitado " & Daño & " puntos de vitalidad." & FONTTYPE_FIGHT)
    End If
    Call QuitarSta(tempChr, Daño)
    b = True
End If


End Sub

Sub UpdateUserHechizos(ByVal UpdateAll As Boolean, Userindex As Integer, Slot As Byte)
Dim loopc As Byte
Dim ArrayHechiz As String 'AREAS NUEVAS
Dim CantidadHechiz As Integer
ArrayHechiz = "@"

If Not UpdateAll Then
    If UserList(Userindex).Stats.UserHechizos(Slot) Then
        Call ChangeUserHechizo(Userindex, Slot, UserList(Userindex).Stats.UserHechizos(Slot))
    Else
        Call ChangeUserHechizo(Userindex, Slot, 0)
    End If
Else
    For loopc = 1 To MAXUSERHECHIZOS
        If UserList(Userindex).Stats.UserHechizos(loopc) Then
            CantidadHechiz = CantidadHechiz + 1
            ArrayHechiz = ArrayHechiz & loopc & "," & UserList(Userindex).Stats.UserHechizos(loopc) & "," & Hechizos(UserList(Userindex).Stats.UserHechizos(loopc)).Nombre & "@"
        End If
    Next

    Call SendData(ToIndex, Userindex, 0, "SHX" & DesteEncripTE(CantidadHechiz & ArrayHechiz))

    ArrayHechiz = 0
    CantidadHechiz = 0
End If

End Sub
Sub ChangeUserHechizo(Userindex As Integer, Slot As Byte, ByVal Hechizo As Integer)

UserList(Userindex).Stats.UserHechizos(Slot) = Hechizo

If Hechizo > 0 And Hechizo < NumeroHechizos + 1 Then
    Call SendData(ToIndex, Userindex, 0, "SHS" & DesteEncripTE(Slot & "," & Hechizo & "," & Hechizos(Hechizo).Nombre))
Else
    Call SendData(ToIndex, Userindex, 0, "SHS" & DesteEncripTE(Slot & "," & "0" & "," & "Nada"))
End If

End Sub
Public Sub DesplazarHechizo(Userindex As Integer, ByVal Dire As Integer, ByVal CualHechizo As Byte)

If Not (Dire >= 1 And Dire <= 2) Then Exit Sub
If Not (CualHechizo >= 1 And CualHechizo <= MAXUSERHECHIZOS) Then Exit Sub

Dim TempHechizo As Integer

If Dire = 1 Then
    If CualHechizo = 1 Then
        Call SendData(ToIndex, Userindex, 0, "%G")
        Exit Sub
    Else
        TempHechizo = UserList(Userindex).Stats.UserHechizos(CualHechizo)
        UserList(Userindex).Stats.UserHechizos(CualHechizo) = UserList(Userindex).Stats.UserHechizos(CualHechizo - 1)
        UserList(Userindex).Stats.UserHechizos(CualHechizo - 1) = TempHechizo
        
        Call UpdateUserHechizos(False, Userindex, CualHechizo - 1)
    End If
Else
    If CualHechizo = MAXUSERHECHIZOS Then
        Call SendData(ToIndex, Userindex, 0, "%G")
        Exit Sub
    Else
        TempHechizo = UserList(Userindex).Stats.UserHechizos(CualHechizo)
        UserList(Userindex).Stats.UserHechizos(CualHechizo) = UserList(Userindex).Stats.UserHechizos(CualHechizo + 1)
        UserList(Userindex).Stats.UserHechizos(CualHechizo + 1) = TempHechizo
        
        Call UpdateUserHechizos(False, Userindex, CualHechizo + 1)
    End If
End If

Call UpdateUserHechizos(False, Userindex, CualHechizo)

End Sub

Sub HechizoMaterializar(Userindex As Integer, b As Boolean)
 
Dim TU As Integer
Dim H As Integer
Dim i As Integer
 
Dim PosTIROTELEPORT As WorldPos 'matute
 
H = UserList(Userindex).Stats.UserHechizos(UserList(Userindex).flags.Hechizo)
 
If Hechizos(H).Nombre = "Portal Luminoso" Then
    If MapInfo(UserList(Userindex).POS.Map).EsMapaEspecial Then Exit Sub
    If UserList(Userindex).flags.TiroPortalL = 1 Then
        Call SendData(ToIndex, Userindex, 0, "||Espera a que se termine el portal invocado anteriormente." & FONTTYPE_INFO)
        Exit Sub
    End If
    'If UserList(UserIndex).Counters.TimeTeleport <> 0 Then Exit Sub 'Ya invocó. 'comentar
End If
 
If Hechizos(H).Materializa = 1 Then 'matute
   
    'If UserList(UserIndex).flags.TiroPortalL = True Then Exit Sub
   
    PosTIROTELEPORT.X = UserList(Userindex).flags.TargetX
    PosTIROTELEPORT.Y = UserList(Userindex).flags.TargetY
    PosTIROTELEPORT.Map = UserList(Userindex).flags.TargetMap
   
    UserList(Userindex).flags.DondeTiroMap = PosTIROTELEPORT.Map
    UserList(Userindex).flags.DondeTiroX = PosTIROTELEPORT.X
    UserList(Userindex).flags.DondeTiroY = PosTIROTELEPORT.Y
   
    If MapData(UserList(Userindex).POS.Map, UserList(Userindex).flags.TargetX, UserList(Userindex).flags.TargetY).OBJInfo.OBJIndex Then 'si hay algo...
        Exit Sub
    End If
   
    If MapData(UserList(Userindex).POS.Map, UserList(Userindex).flags.TargetX, UserList(Userindex).flags.TargetY).TileExit.Map Then
        Exit Sub
    End If
   
    If MapData(UserList(Userindex).POS.Map, UserList(Userindex).flags.TargetX, UserList(Userindex).flags.TargetY).Blocked Then
        Exit Sub
    End If
   
    If Not MapaValido(UserList(Userindex).POS.Map) Or Not InMapBounds(UserList(Userindex).flags.TargetX, UserList(Userindex).flags.TargetY) Then Exit Sub
   
   
    Dim ET As Obj
    ET.Amount = 1
    ET.OBJIndex = 831 'veamos asd - [Primer FX que se ve en la imagen 1] -VER OBJ.DAT
   
   
    Call MakeObj(ToMap, Userindex, UserList(Userindex).POS.Map, ET, UserList(Userindex).flags.TargetMap, UserList(Userindex).flags.TargetX, UserList(Userindex).flags.TargetY)
    b = True
                       
     UserList(Userindex).Counters.TimeTeleport = 0
    UserList(Userindex).Counters.CreoTeleport = True
    UserList(Userindex).flags.TiroPortalL = 1
End If
 
Call InfoHechizo(Userindex)
 
End Sub

