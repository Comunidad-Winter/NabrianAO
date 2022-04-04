Attribute VB_Name = "SistemaCombate"
 
'director del proyecto: #Esteban(Neliam)

'servidor basado en fénixao 1.0
'medios de contacto:
'Skype: dc.esteban
'E-mail: nabrianao@gmail.com
Option Explicit

Public Declare Function Minimo Lib "aolib.dll" (ByVal a As Long, ByVal b As Long) As Long
Public Declare Function Maximo Lib "aolib.dll" (ByVal a As Long, ByVal b As Long) As Long
Public Declare Function PoderAtaqueWresterling Lib "aolib.dll" (ByVal Skill As Byte, ByVal Agilidad As Integer, Clase As Byte, ByVal Nivel As Byte) As Integer
Public Declare Function SD Lib "aolib.dll" (ByVal N As Integer) As Integer
Public Declare Function SDM Lib "aolib.dll" (ByVal N As Integer) As Integer
Public Declare Function Complex Lib "aolib.dll" (ByVal N As Integer) As Integer
Public Declare Function RandomNumber Lib "aolib.dll" (ByVal MIN As Long, ByVal MAX As Long) As Long

Public Const EVASION = 1
Public Const CUERPOACUERPO = 2
Public Const CONARCOS = 3
Public Const EVAESCUDO = 4
Public Const DANOCUERPOACUERPO = 5
Public Const DANOCONARCOS = 6

Public Mods(1 To 6, 1 To NUMCLASES) As Single
Public Const MAXDISTANCIAARCO = 12
Public Sub CargarMods()
Dim i As Byte, j As Integer
Dim file As String

file = DatPath & "Mods.dat"

For i = 1 To NUMCLASES
    If Len(ListaClases(i)) > 0 Then
        For j = 1 To UBound(Mods, 1)
            Mods(j, i) = Int(GetVar(file, ListaClases(i), "Mod" & j)) / 100
        Next
    End If
Next

End Sub
Public Sub SaveMod(a As Integer, b As Integer)

Call WriteVar(DatPath & "Mods.dat", ListaClases(b), "Mod" & a, str(Mods(a, b) * 100))

End Sub

Public Function PoderAtaqueProyectil(Userindex As Integer) As Integer

Select Case UserList(Userindex).Stats.UserSkills(Proyectiles)
    Case Is < 31
        PoderAtaqueProyectil = UserList(Userindex).Stats.UserSkills(Proyectiles) * Mods(CONARCOS, UserList(Userindex).Clase)
    Case Is < 61
        PoderAtaqueProyectil = (UserList(Userindex).Stats.UserSkills(Proyectiles) + UserList(Userindex).Stats.UserAtributos(Agilidad)) * Mods(CONARCOS, UserList(Userindex).Clase)
    Case Is < 91
        PoderAtaqueProyectil = (UserList(Userindex).Stats.UserSkills(Proyectiles) + 2 * UserList(Userindex).Stats.UserAtributos(Agilidad)) * Mods(CONARCOS, UserList(Userindex).Clase)
    Case Else
        PoderAtaqueProyectil = (UserList(Userindex).Stats.UserSkills(Proyectiles) + 3 * UserList(Userindex).Stats.UserAtributos(Agilidad)) * Mods(CONARCOS, UserList(Userindex).Clase)
End Select

PoderAtaqueProyectil = (PoderAtaqueProyectil + (2.5 * Maximo(UserList(Userindex).Stats.ELV - 12, 0)))

End Function
Public Function PoderAtaqueArma(Userindex As Integer) As Integer

Select Case UserList(Userindex).Stats.UserSkills(Armas)
    Case Is < 31
        PoderAtaqueArma = UserList(Userindex).Stats.UserSkills(Armas) * Mods(CUERPOACUERPO, UserList(Userindex).Clase)
    Case Is < 61
        PoderAtaqueArma = (UserList(Userindex).Stats.UserSkills(Armas) + UserList(Userindex).Stats.UserAtributos(Agilidad)) * Mods(CUERPOACUERPO, UserList(Userindex).Clase)
    Case Is < 91
        PoderAtaqueArma = (UserList(Userindex).Stats.UserSkills(Armas) + 2 * UserList(Userindex).Stats.UserAtributos(Agilidad)) * Mods(CUERPOACUERPO, UserList(Userindex).Clase)
    Case Else
        PoderAtaqueArma = (UserList(Userindex).Stats.UserSkills(Armas) + 3 * UserList(Userindex).Stats.UserAtributos(Agilidad)) * Mods(CUERPOACUERPO, UserList(Userindex).Clase)
End Select

PoderAtaqueArma = PoderAtaqueArma + 2.5 * Maximo(UserList(Userindex).Stats.ELV - 12, 0)

End Function
Public Function PoderEvasionEscudo(Userindex As Integer)

PoderEvasionEscudo = UserList(Userindex).Stats.UserSkills(Defensa) * Mods(EVAESCUDO, UserList(Userindex).Clase) / 2

End Function
Public Function PoderEvasion(Userindex As Integer) As Integer

Select Case UserList(Userindex).Stats.UserSkills(Tacticas)
    Case Is < 31
        PoderEvasion = UserList(Userindex).Stats.UserSkills(Tacticas) * Mods(EVASION, UserList(Userindex).Clase)
    Case Is < 61
        PoderEvasion = (UserList(Userindex).Stats.UserSkills(Tacticas) + UserList(Userindex).Stats.UserAtributos(Agilidad)) * Mods(EVASION, UserList(Userindex).Clase)
    Case Is < 91
        PoderEvasion = (UserList(Userindex).Stats.UserSkills(Tacticas) + 2 * UserList(Userindex).Stats.UserAtributos(Agilidad)) * Mods(EVASION, UserList(Userindex).Clase)
    Case Else
        PoderEvasion = (UserList(Userindex).Stats.UserSkills(Tacticas) + 3 * UserList(Userindex).Stats.UserAtributos(Agilidad)) * Mods(EVASION, UserList(Userindex).Clase)
End Select

PoderEvasion = PoderEvasion + (2.5 * Maximo(UserList(Userindex).Stats.ELV - 12, 0))

End Function
Public Function UserImpactoNpc(Userindex As Integer, NpcIndex As Integer) As Boolean
Dim PoderAtaque As Long
Dim Arma As Integer
Dim proyectil As Boolean
Dim ProbExito As Long

Arma = UserList(Userindex).Invent.WeaponEqpObjIndex
If Arma = 0 Then proyectil = False Else proyectil = ObjData(Arma).proyectil = 1

If Arma = 0 Then
    PoderAtaque = PoderAtaqueWresterling(UserList(Userindex).Stats.UserSkills(Wresterling), UserList(Userindex).Stats.UserAtributos(Agilidad), UserList(Userindex).Clase, UserList(Userindex).Stats.ELV) \ 4
ElseIf proyectil Then
    PoderAtaque = (1 + 0.05 * Buleano(UserList(Userindex).Clase = ARQUERO And UserList(Userindex).Recompensas(3) = 1) + 0.1 * Buleano(UserList(Userindex).Recompensas(3) = 1 And (UserList(Userindex).Clase = GUERRERO Or UserList(Userindex).Clase = CAZADOR))) _
    * PoderAtaqueProyectil(Userindex)
Else
    PoderAtaque = (1 + 0.05 * Buleano(UserList(Userindex).Clase = PALADIN And UserList(Userindex).Recompensas(3) = 2)) _
    * PoderAtaqueArma(Userindex)
End If

ProbExito = Maximo(10, Minimo(90, 50 + ((PoderAtaque - Npclist(NpcIndex).PoderEvasion) * 0.4)))

UserImpactoNpc = (RandomNumber(1, 100) <= ProbExito)

If UserImpactoNpc Then
    If Arma Then
       If proyectil Then
            Call SubirSkill(Userindex, Proyectiles)
       Else: Call SubirSkill(Userindex, Armas)
       End If
    Else
        Call SubirSkill(Userindex, Wresterling)
    End If
End If


End Function
Public Function NpcImpacto(ByVal NpcIndex As Integer, Userindex As Integer) As Boolean
Dim Rechazo As Boolean
Dim ProbRechazo As Long
Dim ProbExito As Long
Dim UserEvasion As Long

UserEvasion = (1 + 0.05 * Buleano(UserList(Userindex).Recompensas(3) = 2 And (UserList(Userindex).Clase = ARQUERO Or UserList(Userindex).Clase = NIGROMANTE))) _
            * PoderEvasion(Userindex)

If UserList(Userindex).Invent.EscudoEqpObjIndex Then UserEvasion = UserEvasion + PoderEvasionEscudo(Userindex)

ProbExito = Maximo(10, Minimo(90, 50 + ((Npclist(NpcIndex).PoderAtaque - UserEvasion) * 0.4)))

NpcImpacto = (RandomNumber(1, 100) <= ProbExito)

If UserList(Userindex).Invent.EscudoEqpObjIndex Then
   If Not NpcImpacto Then
      ProbRechazo = Maximo(10, Minimo(90, 100 * (UserList(Userindex).Stats.UserSkills(Defensa) / (UserList(Userindex).Stats.UserSkills(Defensa) + UserList(Userindex).Stats.UserSkills(Tacticas)))))
      Rechazo = (RandomNumber(1, 100) <= ProbRechazo)
      If Rechazo Then
         Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "TW" & SND_ESCUDO)
         Call SendData(ToIndex, Userindex, 0, "7")
         Call SubirSkill(Userindex, Defensa, 2)
      End If
   End If
End If

End Function
Public Function CalcularDaño(Userindex As Integer, Optional ByVal Dragon As Boolean) As Long
Dim ModifClase As Single
Dim DañoUsuario As Long
Dim DañoArma As Long
Dim DañoMaxArma As Long
Dim Arma As ObjData

DañoUsuario = RandomNumber(UserList(Userindex).Stats.MinHit, UserList(Userindex).Stats.MaxHit)

If UserList(Userindex).Invent.WeaponEqpObjIndex = 0 Then
    ModifClase = Mods(DANOCUERPOACUERPO, UserList(Userindex).Clase)
    CalcularDaño = Maximo(0, (UserList(Userindex).Stats.UserAtributos(fuerza) - 15)) + DañoUsuario * ModifClase
    Exit Function
End If

Arma = ObjData(UserList(Userindex).Invent.WeaponEqpObjIndex)

DañoMaxArma = Arma.MaxHit
        
If Arma.proyectil Then
    ModifClase = Mods(DANOCONARCOS, UserList(Userindex).Clase)
    DañoArma = RandomNumber(Arma.MinHit, DañoMaxArma) + RandomNumber(ObjData(UserList(Userindex).Invent.MunicionEqpObjIndex).MinHit + 10 * Buleano(UserList(Userindex).flags.BonusFlecha) + 5 * Buleano(UserList(Userindex).Clase = ARQUERO And UserList(Userindex).Recompensas(3) = 2), ObjData(UserList(Userindex).Invent.MunicionEqpObjIndex).MaxHit + 15 * Buleano(UserList(Userindex).flags.BonusFlecha) + 3 * Buleano(UserList(Userindex).Clase = ARQUERO And UserList(Userindex).Recompensas(3) = 2))
Else
    ModifClase = Mods(DANOCUERPOACUERPO, UserList(Userindex).Clase)
    If Arma.SubTipo = MATADRAGONES And Not Dragon Then
        CalcularDaño = 1
        Exit Function
    Else
        DañoArma = RandomNumber(Arma.MinHit, DañoMaxArma)
    End If
End If

CalcularDaño = (((3 * DañoArma) + ((DañoMaxArma / 5) * Maximo(0, (UserList(Userindex).Stats.UserAtributos(fuerza) - 15))) + DañoUsuario) * ModifClase)

End Function
Public Sub UserDañoNpc(Userindex As Integer, ByVal NpcIndex As Integer)
Dim Muere As Boolean
Dim Daño As Long
Dim j As Integer

Daño = CalcularDaño(Userindex, Npclist(NpcIndex).NPCtype = 6)

If UserList(Userindex).flags.Navegando = 1 Then Daño = Daño + RandomNumber(ObjData(UserList(Userindex).Invent.BarcoObjIndex).MinHit, ObjData(UserList(Userindex).Invent.BarcoObjIndex).MaxHit)

Daño = Maximo(0, Daño - Npclist(NpcIndex).Stats.Def)

    If GRANPODERActivado = True Then
    If Userindex = GranPoder Then Daño = Daño * 1.3
    End If

Call SendData(ToIndex, Userindex, 0, "U2" & Daño)




Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "HM" & FONTTYPE_ORO & "°" & Daño & "°" & Npclist(NpcIndex).POS.X & "°" & Npclist(NpcIndex).POS.y & "°" & Npclist(NpcIndex).Char.CharIndex)


Call ExperienciaPorGolpe(Userindex, NpcIndex, CInt(Daño))
If Daño >= Npclist(NpcIndex).Stats.MinHP Then Muere = True
Call VerNPCMuere(NpcIndex, Daño, Userindex)

If Not Muere Then
    If PuedeApuñalar(Userindex) Then
       Call DoApuñalar(Userindex, NpcIndex, 0, CInt(Daño))
       Call SubirSkill(Userindex, Apuñalar)
    End If
End If


End Sub
Public Sub NpcDaño(ByVal NpcIndex As Integer, Userindex As Integer)
Dim Daño As Integer, lugar As Integer, absorbido As Integer, npcfile As String
Dim antdaño As Integer, defbarco As Integer
Dim Obj As ObjData
Dim Obj2 As ObjData

If Userindex = GranPoder Then Exit Sub

Daño = RandomNumber(Npclist(NpcIndex).Stats.MinHit, Npclist(NpcIndex).Stats.MaxHit)
antdaño = Daño

If UserList(Userindex).flags.Navegando = 1 Then
    Obj = ObjData(UserList(Userindex).Invent.BarcoObjIndex)
    defbarco = RandomNumber(Obj.MinDef, Obj.MaxDef)
End If

If UserList(Userindex).flags.Montado = 1 Then
     defbarco = defbarco + UserList(Userindex).Caballos.Agi(UserList(Userindex).flags.CaballoMontado)
End If

lugar = RandomNumber(1, 6)

Select Case lugar
  Case bCabeza
        
        If UserList(Userindex).Invent.CascoEqpObjIndex Then
            Obj = ObjData(UserList(Userindex).Invent.CascoEqpObjIndex)
            If Obj.Gorro = 0 Then absorbido = RandomNumber(Obj.MinDef, Obj.MaxDef)
        End If
        
  Case Else
        
        If UserList(Userindex).Invent.ArmourEqpObjIndex Then
           Obj = ObjData(UserList(Userindex).Invent.ArmourEqpObjIndex)
           absorbido = RandomNumber(Obj.MinDef, Obj.MaxDef)
        End If
        
        If UserList(Userindex).Invent.EscudoEqpObjIndex Then
           Obj2 = ObjData(UserList(Userindex).Invent.EscudoEqpObjIndex)
            absorbido = absorbido + RandomNumber(Obj2.MinDef, Obj2.MaxDef)
        End If
        
End Select

absorbido = absorbido + defbarco + 2 * Buleano(UserList(Userindex).Clase = GUERRERO And UserList(Userindex).Recompensas(2) = 2)

Daño = Maximo(1, Daño - absorbido)

Call SendData(ToIndex, Userindex, 0, "N2" & lugar & "," & Daño)

If UserList(Userindex).flags.Privilegios = 0 And Not UserList(Userindex).flags.Quest Then UserList(Userindex).Stats.MinHP = UserList(Userindex).Stats.MinHP - Daño
Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "HM" & FONTTYPE_ORO & "°" & Daño & "°" & UserList(Userindex).POS.X & "°" & UserList(Userindex).POS.y & "°" & UserList(Userindex).Char.CharIndex)

If UserList(Userindex).Stats.MinHP <= 0 Then

    Call SendData(ToIndex, Userindex, 0, "6")
    
   
    If Npclist(NpcIndex).MaestroUser Then
        Call AllFollowAmo(Npclist(NpcIndex).MaestroUser)
    Else
        
        If Npclist(NpcIndex).Stats.Alineacion = 0 Then
            Npclist(NpcIndex).Movement = Npclist(NpcIndex).flags.OldMovement
            Npclist(NpcIndex).Hostile = Npclist(NpcIndex).flags.OldHostil
            Npclist(NpcIndex).flags.AttackedBy = 0
        End If
    End If
    
    Call UserDie(Userindex)

End If

End Sub
Public Sub CheckPets(ByVal NpcIndex As Integer, Userindex As Integer)
Dim j As Integer

For j = 1 To MAXMASCOTAS * Buleano(Not UserList(Userindex).flags.Quest)
    If UserList(Userindex).MascotasIndex(j) Then
       If UserList(Userindex).MascotasIndex(j) <> NpcIndex Then
        If Npclist(UserList(Userindex).MascotasIndex(j)).TargetNpc = 0 Then Npclist(UserList(Userindex).MascotasIndex(j)).TargetNpc = NpcIndex
        Npclist(UserList(Userindex).MascotasIndex(j)).Movement = NPC_ATACA_NPC
       End If
    End If
Next

End Sub
Public Sub AllFollowAmo(Userindex As Integer)
Dim j As Integer

For j = 1 To MAXMASCOTAS * Buleano(Not UserList(Userindex).flags.Quest)
    If UserList(Userindex).MascotasIndex(j) Then
        Call FollowAmo(UserList(Userindex).MascotasIndex(j))
    End If
Next

End Sub
Public Sub NpcAtacaUser(ByVal NpcIndex As Integer, Userindex As Integer)

If Userindex = GranPoder Then Exit Sub
If Npclist(NpcIndex).AutoCurar = 1 Then Exit Sub
If Npclist(NpcIndex).Numero = 92 Then Exit Sub


If Npclist(NpcIndex).CanAttack = 1 Then
    Call CheckPets(NpcIndex, Userindex)
    
    If Npclist(NpcIndex).Target = 0 Then Npclist(NpcIndex).Target = Userindex
    
    If UserList(Userindex).flags.AtacadoPorNpc = 0 And _
       UserList(Userindex).flags.AtacadoPorUser = 0 Then UserList(Userindex).flags.AtacadoPorNpc = NpcIndex
Else
    Exit Sub
End If

Npclist(NpcIndex).CanAttack = 0

If Npclist(NpcIndex).flags.Snd1 Then Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "TW" & Npclist(NpcIndex).flags.Snd1)
        
If NpcImpacto(NpcIndex, Userindex) Then
    Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "TW" & SND_IMPACTO)
    
    If UserList(Userindex).flags.Navegando = 0 And Not UserList(Userindex).flags.Meditando Then Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "CFX" & UserList(Userindex).Char.CharIndex & "," & UserList(Userindex).Char.CharIndex & "," & FXSANGRE & "," & 0 & "," & 0) 'dx8
    

    Call NpcDaño(NpcIndex, Userindex)

    If Npclist(NpcIndex).Veneno = 1 Then Call NpcEnvenenarUser(Userindex)
Else
    Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "TWerraflecha")
    Call SendData(ToIndex, Userindex, 0, "N1")
End If

Call SubirSkill(Userindex, Tacticas)
Call SendUserHP(Userindex)

End Sub
Function NpcImpactoNpc(ByVal Atacante As Integer, ByVal Victima As Integer) As Boolean

NpcImpactoNpc = (RandomNumber(1, 100) <= Maximo(10, Minimo(90, 50 + ((Npclist(Atacante).PoderAtaque - Npclist(Victima).PoderEvasion) * 0.4))))

End Function
Public Sub NpcDañoNpc(ByVal Atacante As Integer, ByVal Victima As Integer)
Dim Daño As Integer
Dim ANpc As Npc
ANpc = Npclist(Atacante)

Daño = RandomNumber(ANpc.Stats.MinHit, ANpc.Stats.MaxHit)

If ANpc.MaestroUser Then Call ExperienciaPorGolpe(ANpc.MaestroUser, Victima, Daño)
Call VerNPCMuere(Victima, Daño, ANpc.MaestroUser)

If Npclist(Victima).Stats.MinHP <= 0 Then
    Call RestoreOldMovement(Atacante)
    If ANpc.MaestroUser Then Call FollowAmo(Atacante)
End If

End Sub
Public Sub NpcAtacaNpc(ByVal Atacante As Integer, ByVal Victima As Integer)

If Npclist(Atacante).CanAttack = 1 Then
    Npclist(Atacante).CanAttack = 0
    Npclist(Victima).TargetNpc = Atacante
Else: Exit Sub
End If

If Npclist(Atacante).flags.Snd1 Then Call SendData(ToNPCArea, Atacante, Npclist(Atacante).POS.Map, "TW" & Npclist(Atacante).flags.Snd1)

If NpcImpactoNpc(Atacante, Victima) Then
    
    If Npclist(Victima).flags.Snd2 Then
        Call SendData(ToNPCArea, Victima, Npclist(Victima).POS.Map, "TW" & Npclist(Victima).flags.Snd2)
    Else: Call SendData(ToNPCArea, Victima, Npclist(Victima).POS.Map, "TW" & SND_IMPACTO2)
    End If

    If Npclist(Atacante).MaestroUser Then
        Call SendData(ToNPCArea, Atacante, Npclist(Atacante).POS.Map, "TW" & SND_IMPACTO)
    Else: Call SendData(ToNPCArea, Victima, Npclist(Victima).POS.Map, "TW" & SND_IMPACTO)
    End If
    Call NpcDañoNpc(Atacante, Victima)
    
Else
    If Npclist(Atacante).MaestroUser Then
        Call SendData(ToNPCArea, Atacante, Npclist(Atacante).POS.Map, "TW" & SOUND_SWING)
    Else
        Call SendData(ToNPCArea, Victima, Npclist(Victima).POS.Map, "TW" & SOUND_SWING)
    End If
End If

End Sub
Public Sub UsuarioAtaca(Userindex As Integer)

If UserList(Userindex).flags.NoatacaPlante = 1 Then Exit Sub

If UserList(Userindex).flags.Protegido = 1 Then
    Call SendData(ToIndex, Userindex, 0, "||No podés atacar mientras estás siendo protegido por un GM." & FONTTYPE_INFO)
    Exit Sub
ElseIf UserList(Userindex).flags.Protegido = 2 Then
    Call SendData(ToIndex, Userindex, 0, "||No podés atacar tan pronto al conectarte." & FONTTYPE_INFO)
    Exit Sub
End If

If TiempoTranscurrido(UserList(Userindex).Counters.LastGolpe) < IntervaloUserPuedeAtacar Then Exit Sub

UserList(Userindex).Counters.LastGolpe = Timer
Call SendData(ToIndex, Userindex, 0, "LG")

If TiempoTranscurrido(UserList(Userindex).Counters.LastHechizo) < IntervaloUserPuedeHechiGolpe Then Exit Sub
If TiempoTranscurrido(UserList(Userindex).Counters.LastFlecha) < IntervaloUserFlechas Then Exit Sub


If UserList(Userindex).flags.Oculto Then
    If Not ((UserList(Userindex).Clase = CAZADOR Or UserList(Userindex).Clase = ARQUERO) And UserList(Userindex).Invent.ArmourEqpObjIndex = 360) Then
        UserList(Userindex).flags.Oculto = 0
        UserList(Userindex).flags.Invisible = 0
        Call SendData(ToMap, 0, UserList(Userindex).POS.Map, ("V3" & DesteEncripTE("0," & UserList(Userindex).Char.CharIndex)))
        Call SendData(ToIndex, Userindex, 0, "V5")
    End If
End If

If UserList(Userindex).Stats.MinSta >= 10 Then
    Call QuitarSta(Userindex, RandomNumber(1, 10))
Else: Call SendData(ToIndex, Userindex, 0, "9E")
    Exit Sub
End If

Dim AttackPos As WorldPos
AttackPos = UserList(Userindex).POS
Call HeadtoPos(UserList(Userindex).Char.Heading, AttackPos)

If AttackPos.X < XMinMapSize Or AttackPos.X > XMaxMapSize Or AttackPos.y <= YMinMapSize Or AttackPos.y > YMaxMapSize Then
    Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "-" & UserList(Userindex).Char.CharIndex)
    Exit Sub
End If

Dim Index As Integer
Index = MapData(AttackPos.Map, AttackPos.X, AttackPos.y).Userindex

If Index Then
    Call UsuarioAtacaUsuario(Userindex, MapData(AttackPos.Map, AttackPos.X, AttackPos.y).Userindex)
    Call SendUserSTA(Userindex)
    Call SendUserHP(MapData(AttackPos.Map, AttackPos.X, AttackPos.y).Userindex)
    Exit Sub
End If

If MapData(AttackPos.Map, AttackPos.X, AttackPos.y).NpcIndex Then

    If Npclist(MapData(AttackPos.Map, AttackPos.X, AttackPos.y).NpcIndex).Attackable Then
        
        If (Npclist(MapData(AttackPos.Map, AttackPos.X, AttackPos.y).NpcIndex).MaestroUser > 0 And _
           MapInfo(Npclist(MapData(AttackPos.Map, AttackPos.X, AttackPos.y).NpcIndex).POS.Map).Pk = False) And (UserList(Userindex).POS.Map <> 190) Then
            Call SendData(ToIndex, Userindex, 0, "0Z")
            Exit Sub
        End If
           
        Call UsuarioAtacaNpc(Userindex, MapData(AttackPos.Map, AttackPos.X, AttackPos.y).NpcIndex)

    Else
        Call SendData(ToIndex, Userindex, 0, "NO")
    End If
    
    Call SendUserSTA(Userindex)
    
    Exit Sub


End If

Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "-" & UserList(Userindex).Char.CharIndex)
Call SendUserSTA(Userindex)

End Sub
Public Sub UsuarioAtacaNpc(Userindex As Integer, ByVal NpcIndex As Integer)
Dim ClanCastillo As Integer

   Call CheckPets(NpcIndex, Userindex) ' element
    

If Npclist(NpcIndex).Numero = NPCRey Then
If UserList(Userindex).GuildInfo.GuildName = "" Then
Call SendData(ToIndex, Userindex, 0, "||No puedes atacar al rey de clanes sin tener clan." & FONTTYPE_INFO)
Exit Sub
End If
End If

If Npclist(NpcIndex).Numero = NPCRey Then
If UserList(Userindex).flags.DominandoCastillo Then
Call SendData(ToCasTLE, 0, 0, "||No puedes atacar a tu rey." & FONTTYPE_FIGHTT)
Exit Sub
End If
End If

If Npclist(NpcIndex).Numero = NPCRey Then
GolpesRey = GolpesRey + 1
If GolpesRey = 15 Then
Call SendData(ToCasTLE, 0, 0, "||El rey esta siendo atacado!!" & FONTTYPE_FIGHTT)
GolpesRey = 0
End If
End If

'If Distancia(UserList(UserIndex).POS, Npclist(NpcIndex).POS) > MAXDISTANCIAARCO Then
'   Call SendData(ToIndex, UserIndex, 0, "3G")
'   Exit Sub
'End If

If (UserList(Userindex).Faccion.Bando <> Neutral Or EsNewbie(Userindex)) And Npclist(NpcIndex).MaestroUser Then
    If Not PuedeAtacarMascota(Userindex, (Npclist(NpcIndex).MaestroUser)) Then Exit Sub
End If

If Npclist(NpcIndex).flags.Faccion <> Neutral Then
    If UserList(Userindex).Faccion.Bando <> Neutral And UserList(Userindex).Faccion.Bando = Npclist(NpcIndex).flags.Faccion Then
        Call SendData(ToIndex, Userindex, 0, Mensajes(Npclist(NpcIndex).flags.Faccion, 19))
        Exit Sub
    ElseIf EsNewbie(Userindex) Then
        Call SendData(ToIndex, Userindex, 0, "%L")
        Exit Sub
    End If
End If

If UserList(Userindex).flags.Protegido > 0 Then
    Call SendData(ToIndex, Userindex, 0, "||No podes atacar NPC's mientrás estás siendo protegido." & FONTTYPE_FIGHT)
    Exit Sub
End If

Call NpcAtacado(NpcIndex, Userindex)

If UserImpactoNpc(Userindex, NpcIndex) Then
    If Npclist(NpcIndex).flags.Snd2 Then
        Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "\" & UserList(Userindex).Char.CharIndex & "," & Npclist(NpcIndex).flags.Snd2)
    Else
        Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "?" & UserList(Userindex).Char.CharIndex)
    End If
    
    'dx8
    If UserList(Userindex).Invent.MunicionEqpObjIndex And ObjData(UserList(Userindex).Invent.WeaponEqpObjIndex).proyectil = 1 Then
    SendData ToNPCArea, NpcIndex, 0, "FC" & UserList(Userindex).Char.CharIndex & "," & Npclist(NpcIndex).Char.CharIndex & "," & ObjData(UserList(Userindex).Invent.MunicionEqpObjIndex).GrhIndex
    End If
   
    Call UserDañoNpc(Userindex, NpcIndex)
Else
     Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "-" & UserList(Userindex).Char.CharIndex)
     Call SendData(ToIndex, Userindex, 0, "U1")
     
    'dx8
     If UserList(Userindex).Invent.MunicionEqpObjIndex And ObjData(UserList(Userindex).Invent.WeaponEqpObjIndex).proyectil = 1 Then
     SendData ToNPCArea, NpcIndex, 0, "FC" & UserList(Userindex).Char.CharIndex & "," & Npclist(NpcIndex).Char.CharIndex & "," & ObjData(UserList(Userindex).Invent.MunicionEqpObjIndex).GrhIndex & "," & 1
     End If

     
End If

End Sub
Public Function TiempoTranscurrido(ByVal Desde As Single) As Single

TiempoTranscurrido = Timer - Desde

If TiempoTranscurrido < -5 Then
    TiempoTranscurrido = TiempoTranscurrido + 86400
ElseIf TiempoTranscurrido < 0 Then
    TiempoTranscurrido = 0
End If

End Function
Public Function UsuarioImpacto(ByVal AtacanteIndex As Integer, ByVal VictimaIndex As Integer) As Boolean
Dim ProbRechazo As Long
Dim Rechazo As Boolean
Dim ProbExito As Long
Dim PoderAtaque As Long
Dim UserPoderEvasion As Long
Dim proyectil As Boolean

If UserList(AtacanteIndex).Invent.WeaponEqpObjIndex = 0 Then
    proyectil = False
Else: proyectil = ObjData(UserList(AtacanteIndex).Invent.WeaponEqpObjIndex).proyectil = 1
End If

UserPoderEvasion = (1 + 0.05 * Buleano(UserList(VictimaIndex).Recompensas(3) = 2 And (UserList(VictimaIndex).Clase = ARQUERO Or UserList(VictimaIndex).Clase = NIGROMANTE))) _
                    * PoderEvasion(VictimaIndex)

If UserList(VictimaIndex).Invent.EscudoEqpObjIndex Then UserPoderEvasion = UserPoderEvasion + PoderEvasionEscudo(VictimaIndex)


If UserList(AtacanteIndex).Invent.WeaponEqpObjIndex Then
    If proyectil Then
        PoderAtaque = (1 + 0.05 * Buleano(UserList(AtacanteIndex).Clase = ARQUERO And UserList(AtacanteIndex).Recompensas(3) = 1) + 0.1 * Buleano(UserList(AtacanteIndex).Recompensas(3) = 1 And (UserList(AtacanteIndex).Clase = GUERRERO Or UserList(AtacanteIndex).Clase = CAZADOR))) _
        * PoderAtaqueProyectil(AtacanteIndex)
    Else
        PoderAtaque = (1 + 0.05 * Buleano(UserList(AtacanteIndex).Clase = PALADIN And UserList(AtacanteIndex).Recompensas(3) = 2)) _
        * PoderAtaqueArma(AtacanteIndex)
    End If
Else
    PoderAtaque = PoderAtaqueWresterling(UserList(AtacanteIndex).Stats.UserSkills(Wresterling), UserList(AtacanteIndex).Stats.UserAtributos(Agilidad), UserList(AtacanteIndex).Clase, UserList(AtacanteIndex).Stats.ELV)
End If

ProbExito = Maximo(10, Minimo(90, 50 + ((PoderAtaque - UserPoderEvasion) * 0.4)))

UsuarioImpacto = (RandomNumber(1, 100) <= ProbExito)


If UserList(VictimaIndex).Invent.EscudoEqpObjIndex Then
    
    
    If Not UsuarioImpacto Then
      ProbRechazo = Maximo(10, Minimo(90, 100 * (UserList(VictimaIndex).Stats.UserSkills(Defensa) / (UserList(VictimaIndex).Stats.UserSkills(Defensa) + UserList(VictimaIndex).Stats.UserSkills(Tacticas)))))
      Rechazo = (RandomNumber(1, 100) <= ProbRechazo)
      If Rechazo Then
            
            Call SendData(ToPCArea, AtacanteIndex, UserList(AtacanteIndex).POS.Map, "&" & UserList(AtacanteIndex).Char.CharIndex)
            Call SendData(ToIndex, AtacanteIndex, 0, "8")
            Call SendData(ToIndex, VictimaIndex, 0, "7")
            Call SubirSkill(VictimaIndex, Defensa, 25)
      End If
    End If
End If
    
If UsuarioImpacto Then
    If UserList(AtacanteIndex).Invent.WeaponEqpObjIndex Then
        If Not proyectil Then
            Call SubirSkill(AtacanteIndex, Armas)
        Else: Call SubirSkill(AtacanteIndex, Proyectiles)
        End If
    Else
        Call SubirSkill(AtacanteIndex, Wresterling)
    End If
End If

End Function
Public Sub UsuarioAtacaUsuario(ByVal AtacanteIndex As Integer, ByVal VictimaIndex As Integer)

If Not PuedeAtacar(AtacanteIndex, VictimaIndex) Then Exit Sub

'If Distancia(UserList(AtacanteIndex).POS, UserList(VictimaIndex).POS) > MAXDISTANCIAARCO Then
'   Call SendData(ToIndex, AtacanteIndex, 0, "3G")
'   Exit Sub
'End If

Call UsuarioAtacadoPorUsuario(AtacanteIndex, VictimaIndex)

If UsuarioImpacto(AtacanteIndex, VictimaIndex) Then
    'If UserList(AtacanteIndex).flags.Invisible Then Call BajarInvisible(AtacanteIndex)
    
    Call SendData(ToPCArea, AtacanteIndex, UserList(AtacanteIndex).POS.Map, "TW" & "10")
    
    
    If UserList(AtacanteIndex).POS.Map = UserList(VictimaIndex).POS.Map Then
    If UserList(VictimaIndex).flags.Navegando = 0 And Not UserList(VictimaIndex).flags.Meditando Then Call SendData(ToPCArea, VictimaIndex, UserList(VictimaIndex).POS.Map, "CFX" & UserList(VictimaIndex).Char.CharIndex & "," & UserList(VictimaIndex).Char.CharIndex & "," & FXSANGRE & "," & 0 & "," & 0) 'dx8
    End If
    
    Call UserDañoUser(AtacanteIndex, VictimaIndex)
Else
    Call SendData(ToPCArea, AtacanteIndex, UserList(AtacanteIndex).POS.Map, "-" & UserList(AtacanteIndex).Char.CharIndex)
    Call SendData(ToIndex, AtacanteIndex, 0, "U1")
    Call SendData(ToIndex, VictimaIndex, 0, "U3" & UserList(AtacanteIndex).Name)
    
      'dx8
      If ObjData(UserList(AtacanteIndex).Invent.WeaponEqpObjIndex).proyectil Then
        SendData ToPCArea, VictimaIndex, 0, "FC" & UserList(AtacanteIndex).Char.CharIndex & "," & UserList(VictimaIndex).Char.CharIndex & "," & ObjData(UserList(AtacanteIndex).Invent.MunicionEqpObjIndex).GrhIndex & "," & 1
      End If
      
End If

End Sub
Public Sub UserDañoUser(ByVal AtacanteIndex As Integer, ByVal VictimaIndex As Integer)
Dim Daño As Long, antdaño As Integer
Dim lugar As Integer, absorbido As Long
Dim defbarco As Integer
Dim Obj As ObjData
Dim Obj2 As ObjData
Dim j As Integer

Daño = CalcularDaño(AtacanteIndex)

antdaño = Daño

If UserList(AtacanteIndex).flags.Navegando = 1 Then
     Obj = ObjData(UserList(AtacanteIndex).Invent.BarcoObjIndex)
     Daño = Daño + RandomNumber(Obj.MinHit, Obj.MaxHit)
End If

If UserList(VictimaIndex).flags.Navegando = 1 Then
     Obj = ObjData(UserList(VictimaIndex).Invent.BarcoObjIndex)
     defbarco = RandomNumber(Obj.MinDef, Obj.MaxDef)
End If

lugar = RandomNumber(1, 6)

Select Case lugar
  
  Case bCabeza
        If UserList(VictimaIndex).Invent.CascoEqpObjIndex Then
            If Not (UserList(AtacanteIndex).Clase = CAZADOR And UserList(AtacanteIndex).Recompensas(3) = 2) Then
                Obj = ObjData(UserList(VictimaIndex).Invent.CascoEqpObjIndex)
                absorbido = RandomNumber(Obj.MinDef, Obj.MaxDef)
            End If
        End If
        
  Case Else
        If UserList(VictimaIndex).Invent.ArmourEqpObjIndex Then
           Obj = ObjData(UserList(VictimaIndex).Invent.ArmourEqpObjIndex)
           absorbido = RandomNumber(Obj.MinDef, Obj.MaxDef)
        End If
        
        If UserList(VictimaIndex).Invent.EscudoEqpObjIndex Then
           Obj2 = ObjData(UserList(VictimaIndex).Invent.EscudoEqpObjIndex)
            absorbido = absorbido + RandomNumber(Obj2.MinDef, Obj2.MaxDef)
        End If
        
End Select

absorbido = absorbido + defbarco + 2 * Buleano(UserList(VictimaIndex).Clase = GUERRERO And UserList(VictimaIndex).Recompensas(2) = 2)
Daño = Maximo(1, Daño - absorbido)

If GRANPODERActivado = True Then
If AtacanteIndex = GranPoder Then Daño = Daño * 1.3
End If

Call SendData(ToIndex, AtacanteIndex, 0, "N5" & lugar & "," & Daño & "," & UserList(VictimaIndex).Name)
Call SendData(ToIndex, VictimaIndex, 0, "N4" & lugar & "," & Daño & "," & UserList(AtacanteIndex).Name)



If Not UserList(VictimaIndex).flags.Quest Then UserList(VictimaIndex).Stats.MinHP = UserList(VictimaIndex).Stats.MinHP - Daño

If UserList(AtacanteIndex).flags.Hambre = 0 And UserList(AtacanteIndex).flags.Sed = 0 Then
    If UserList(AtacanteIndex).Invent.WeaponEqpObjIndex Then
        If ObjData(UserList(AtacanteIndex).Invent.WeaponEqpObjIndex).proyectil Then
            Call SubirSkill(AtacanteIndex, Proyectiles)
            
             'dx8
             SendData ToPCArea, VictimaIndex, 0, "FC" & UserList(AtacanteIndex).Char.CharIndex & "," & UserList(VictimaIndex).Char.CharIndex & "," & ObjData(UserList(AtacanteIndex).Invent.MunicionEqpObjIndex).GrhIndex
             
        Else: Call SubirSkill(AtacanteIndex, Armas)
        End If
    Else
        Call SubirSkill(AtacanteIndex, Wresterling)
    End If
    
    Call SubirSkill(AtacanteIndex, Tacticas)
    
    
    If PuedeApuñalar(AtacanteIndex) Then
        Call DoApuñalar(AtacanteIndex, 0, VictimaIndex, Daño)
        Call SubirSkill(AtacanteIndex, Apuñalar)
    End If
End If

If UserList(VictimaIndex).Stats.MinHP <= 0 Then
     Call ContarMuerte(VictimaIndex, AtacanteIndex)
     
     

     For j = 1 To MAXMASCOTAS * Buleano(Not UserList(AtacanteIndex).flags.Quest)
        If UserList(AtacanteIndex).MascotasIndex(j) Then
            If Npclist(UserList(AtacanteIndex).MascotasIndex(j)).Target = VictimaIndex Then Npclist(UserList(AtacanteIndex).MascotasIndex(j)).Target = 0
            Call FollowAmo(UserList(AtacanteIndex).MascotasIndex(j))
        End If
     Next

     Call ActStats(VictimaIndex, AtacanteIndex)
End If
        


Call CheckUserLevel(AtacanteIndex)


Call SendData(ToPCArea, VictimaIndex, UserList(VictimaIndex).POS.Map, "HM" & FONTTYPE_ORO & "°" & Daño & "°" & UserList(VictimaIndex).POS.X & "°" & UserList(VictimaIndex).POS.y & "°" & UserList(VictimaIndex).Char.CharIndex)

End Sub
Sub UsuarioAtacadoPorUsuario(ByVal AttackerIndex As Integer, ByVal VictimIndex As Integer)

If TriggerZonaPelea(AttackerIndex, VictimIndex) = TRIGGER6_PERMITE Then Exit Sub
If TriggerZonaPelea7(AttackerIndex, VictimIndex) = TRIGGER6_PERMITE Then Exit Sub

Call AllMascotasAtacanUser(AttackerIndex, VictimIndex)
Call AllMascotasAtacanUser(VictimIndex, AttackerIndex)

End Sub
Sub AllMascotasAtacanUser(ByVal victim As Integer, ByVal Maestro As Integer)
Dim iCount As Integer

For iCount = 1 To MAXMASCOTAS * Buleano(Not UserList(Maestro).flags.Quest)
    If UserList(Maestro).MascotasIndex(iCount) Then
        Npclist(UserList(Maestro).MascotasIndex(iCount)).flags.AttackedBy = victim
        Npclist(UserList(Maestro).MascotasIndex(iCount)).Movement = NPCDEFENSA
        Npclist(UserList(Maestro).MascotasIndex(iCount)).Hostile = 1
    End If
Next

End Sub
Public Function PuedeAtacar(ByVal AttackerIndex As Integer, ByVal VictimIndex As Integer) As Boolean
If UserList(VictimIndex).flags.NoatacaPlante = 1 Then Exit Function
If UserList(AttackerIndex).flags.NoatacaPlante = 1 Then Exit Function

If UserList(AttackerIndex).GuildInfo.Seguro And UserList(AttackerIndex).GuildInfo.GuildName = UserList(VictimIndex).GuildInfo.GuildName Then
    Call SendData(ToIndex, AttackerIndex, 0, "||Tienes el seguro de clan activado desactivalo, presiona F3." & FONTTYPE_FENIZ)
    Exit Function
End If

 If AttackerIndex = VictimIndex Then
    Call SendData(ToIndex, AttackerIndex, 0, "%3")
    Exit Function
End If

If UserList(VictimIndex).flags.Party And UserList(AttackerIndex).PartyIndex = UserList(VictimIndex).PartyIndex Then
    Call SendData(ToIndex, AttackerIndex, 0, "||No puedes atacar a miembros de tu party." & FONTTYPE_FIGHT)
    Exit Function
End If

If UserList(AttackerIndex).flags.Invisible Then Call QuitarInvisible(AttackerIndex)
If UserList(AttackerIndex).flags.AdminInvisible = 1 Then UserList(AttackerIndex).flags.AdminInvisible = 0

If UserList(AttackerIndex).flags.Muerto Then
    Call SendData(ToIndex, AttackerIndex, 0, "MU")
    Exit Function
End If

If UserList(VictimIndex).flags.Muerto Then
    Call SendData(ToIndex, AttackerIndex, 0, "0X")
    Exit Function
End If

If AttackerIndex = VictimIndex Then
    If UserList(AttackerIndex).flags.Privilegios >= 1 Then
        PuedeAtacar = True
        Exit Function
    Else
        Call SendData(ToIndex, AttackerIndex, 0, "%3")
        Exit Function
    End If
End If

If UserList(VictimIndex).flags.Protegido = 1 Then
    Call SendData(ToIndex, AttackerIndex, 0, "||El usuario está siendo protegido por un GM." & FONTTYPE_FIGHT)
    Exit Function
ElseIf UserList(VictimIndex).flags.Protegido = 2 Then
    Call SendData(ToIndex, AttackerIndex, 0, "||El usuario está siendo protegido por conexión." & FONTTYPE_FIGHT)
    Exit Function
End If

If PuedeAtacarAdmins = 1 Then

Else
If UserList(VictimIndex).flags.Privilegios >= 1 Then
    If UserList(VictimIndex).flags.AdminInvisible = 0 Then Call SendData(ToIndex, AttackerIndex, 0, "E0")
    Exit Function
End If
End If
 

If UserList(AttackerIndex).flags.Protegido = 1 Then
    Call SendData(ToIndex, AttackerIndex, 0, "||No podes atacar mientrás estás siendo protegido por un GM." & FONTTYPE_FIGHT)
    Exit Function
ElseIf UserList(AttackerIndex).flags.Protegido = 2 Then
    Call SendData(ToIndex, AttackerIndex, 0, "||No podes atacar tan pronto al conectarte." & FONTTYPE_FIGHT)
    Exit Function
End If

Dim T As Trigger6
T = TriggerZonaPelea7(AttackerIndex, VictimIndex)
 
If T = TRIGGER6_PERMITE Then
    PuedeAtacar = True
    Exit Function
ElseIf T = TRIGGER6_PROHIBE Then
    PuedeAtacar = False
    Exit Function
End If

If UserList(VictimIndex).POS.Map <> 190 Then
    If Not MapInfo(UserList(VictimIndex).POS.Map).Pk And Not TiempoTranscurrido(UserList(VictimIndex).Counters.LastRobo <= 10) Then
        Call SendData(ToIndex, AttackerIndex, 0, "7G")
        Exit Function
    End If
End If


T = TriggerZonaPelea(AttackerIndex, VictimIndex)
 
If T = TRIGGER6_PERMITE Then
    PuedeAtacar = True
    Exit Function
ElseIf T = TRIGGER6_PROHIBE Then
    PuedeAtacar = False
    Exit Function
End If

If MapData(UserList(VictimIndex).POS.Map, UserList(VictimIndex).POS.X, UserList(VictimIndex).POS.y).trigger = 4 Or MapData(UserList(AttackerIndex).POS.Map, UserList(AttackerIndex).POS.X, UserList(AttackerIndex).POS.y).trigger = 4 Then
    Call SendData(ToIndex, AttackerIndex, 0, "8G")
    Exit Function
End If

If Not ModoQuest And Len(UserList(VictimIndex).GuildInfo.GuildName) > 0 And UserList(AttackerIndex).GuildInfo.GuildName = UserList(VictimIndex).GuildInfo.GuildName Then
    PuedeAtacar = True
    Exit Function
End If

If UserList(AttackerIndex).Faccion.Bando <> Neutral And UserList(AttackerIndex).Faccion.Bando = UserList(VictimIndex).Faccion.Bando Then
    If Len(UserList(AttackerIndex).GuildInfo.GuildName) = 0 Or Len(UserList(VictimIndex).GuildInfo.GuildName) = 0 Then
        Call SendData(ToIndex, AttackerIndex, 0, Mensajes(UserList(AttackerIndex).Faccion.Bando, 20))
        Exit Function
    End If
    If Not UserList(AttackerIndex).GuildRef.IsEnemy(UserList(VictimIndex).GuildInfo.GuildName) Then
        Call SendData(ToIndex, AttackerIndex, 0, Mensajes(UserList(AttackerIndex).Faccion.Bando, 20))
        Exit Function
    End If
    If ModoQuest Then
        Call SendData(ToIndex, AttackerIndex, 0, "||Durante una quest no puedes atacar a miembros de tu facción aunque pertenezcan a clanes enemigos." & FONTTYPE_FIGHT)
        Exit Function
    End If
End If

If EsNewbie(VictimIndex) And (EsNewbie(AttackerIndex) Or UserList(AttackerIndex).Faccion.Bando = Real) Then
    Call SendData(ToIndex, AttackerIndex, 0, "%1")
    Exit Function
End If

If EsNewbie(AttackerIndex) And UserList(VictimIndex).Faccion.Bando = Real Then
    Call SendData(ToIndex, AttackerIndex, 0, "%2")
    Exit Function
End If

PuedeAtacar = True

End Function
Public Function PuedeAtacarMascota(ByVal AttackerIndex As Integer, ByVal VictimIndex As Integer) As Boolean

If AttackerIndex = VictimIndex Then
    PuedeAtacarMascota = True
    Exit Function
End If

If UserList(VictimIndex).flags.Protegido = 1 Then
    Call SendData(ToIndex, AttackerIndex, 0, "||No puedes atacar mascotas de usuarios protegidos por GMs." & FONTTYPE_FIGHT)
    Exit Function
ElseIf UserList(VictimIndex).flags.Protegido = 2 Then
    Call SendData(ToIndex, AttackerIndex, 0, "||No puedes atacar mascotas de usuarios protegidos por conexión." & FONTTYPE_FIGHT)
    Exit Function
End If

If UserList(VictimIndex).flags.Privilegios >= 1 Then Exit Function

If UserList(AttackerIndex).flags.Protegido = 1 Then
    Call SendData(ToIndex, AttackerIndex, 0, "||No podes atacar mientrás estás siendo protegido por un GM." & FONTTYPE_FIGHT)
    Exit Function
ElseIf UserList(AttackerIndex).flags.Protegido = 2 Then
    Call SendData(ToIndex, AttackerIndex, 0, "||No podes atacar tan pronto al conectarte." & FONTTYPE_FIGHT)
    Exit Function
End If

If UserList(VictimIndex).POS.Map <> 190 Then
    If Not MapInfo(UserList(VictimIndex).POS.Map).Pk And Not TiempoTranscurrido(UserList(VictimIndex).Counters.LastRobo <= 10) Then
        Call SendData(ToIndex, AttackerIndex, 0, "||No podes atacar mascotas en zonas seguras." & FONTTYPE_FIGHT)
        Exit Function
    End If
End If

If MapData(UserList(VictimIndex).POS.Map, UserList(VictimIndex).POS.X, UserList(VictimIndex).POS.y).trigger = 4 Or MapData(UserList(AttackerIndex).POS.Map, UserList(AttackerIndex).POS.X, UserList(AttackerIndex).POS.y).trigger = 4 Then
    Call SendData(ToIndex, AttackerIndex, 0, "8G")
    Exit Function
End If

If Len(UserList(VictimIndex).GuildInfo.GuildName) > 0 And UserList(AttackerIndex).GuildInfo.GuildName = UserList(VictimIndex).GuildInfo.GuildName Then
    PuedeAtacarMascota = True
    Exit Function
End If

If UserList(AttackerIndex).Faccion.Bando <> Neutral And UserList(AttackerIndex).Faccion.Bando = UserList(VictimIndex).Faccion.Bando Then
    If Len(UserList(AttackerIndex).GuildInfo.GuildName) = 0 Or Len(UserList(VictimIndex).GuildInfo.GuildName) = 0 Then
        Call SendData(ToIndex, AttackerIndex, 0, "||No puedes atacar mascotas de tu bando." & FONTTYPE_INFO)
        Exit Function
    End If
    If Not UserList(AttackerIndex).GuildRef.IsEnemy(UserList(VictimIndex).GuildInfo.GuildName) Then
        Call SendData(ToIndex, AttackerIndex, 0, "||No puedes atacar mascotas de tu bando a menos que tu clan este en guerra con el del dueño." & FONTTYPE_INFO)
        Exit Function
    End If
End If

If EsNewbie(VictimIndex) And (EsNewbie(AttackerIndex) Or UserList(AttackerIndex).Faccion.Bando = Real) Then
    Call SendData(ToIndex, AttackerIndex, 0, "||Los miembros de la Alianza del Nabrian no pueden atacar mascotas de newbies." & FONTTYPE_INFO)
    Exit Function
End If

If EsNewbie(AttackerIndex) And UserList(VictimIndex).Faccion.Bando = Real Then
    Call SendData(ToIndex, AttackerIndex, 0, "||Los newbies no pueden atacar mascotas de la Alianza del Nabrian." & FONTTYPE_INFO)
    Exit Function
End If

PuedeAtacarMascota = True

End Function
Public Function PuedeRobar(ByVal AttackerIndex As Integer, ByVal VictimIndex As Integer) As Boolean

If UserList(AttackerIndex).flags.Muerto Then
    Call SendData(ToIndex, AttackerIndex, 0, "MU")
    Exit Function
End If

If UserList(VictimIndex).flags.Muerto Then
    Call SendData(ToIndex, AttackerIndex, 0, "0X")
    Exit Function
End If

If AttackerIndex = VictimIndex Then
    Call SendData(ToIndex, AttackerIndex, 0, "%3")
    Exit Function
End If

If UserList(VictimIndex).flags.Protegido = 1 Then
    Call SendData(ToIndex, AttackerIndex, 0, "||El usuario está siendo protegido por un GM." & FONTTYPE_FIGHT)
    Exit Function
ElseIf UserList(VictimIndex).flags.Protegido = 2 Then
    Call SendData(ToIndex, AttackerIndex, 0, "||El usuario está siendo protegido por conexión." & FONTTYPE_FIGHT)
    Exit Function
End If

If UserList(VictimIndex).flags.Privilegios >= 1 Then
    If UserList(VictimIndex).flags.AdminInvisible = 0 Then Call SendData(ToIndex, AttackerIndex, 0, "/F")
    Exit Function
End If

If UserList(AttackerIndex).flags.Protegido = 1 Then
    Call SendData(ToIndex, AttackerIndex, 0, "||No podes atacar mientrás estás siendo protegido por un GM." & FONTTYPE_FIGHT)
    Exit Function
ElseIf UserList(AttackerIndex).flags.Protegido = 2 Then
    Call SendData(ToIndex, AttackerIndex, 0, "||No podes atacar tan pronto al conectarte." & FONTTYPE_FIGHT)
    Exit Function
End If

If UserList(VictimIndex).POS.Map <> 190 Then
    If Not MapInfo(UserList(VictimIndex).POS.Map).Pk And Not TiempoTranscurrido(UserList(VictimIndex).Counters.LastRobo <= 10) Then
        Call SendData(ToIndex, AttackerIndex, 0, "/A")
        Exit Function
    End If
End If

If MapData(UserList(VictimIndex).POS.Map, UserList(VictimIndex).POS.X, UserList(VictimIndex).POS.y).trigger = 4 Or MapData(UserList(AttackerIndex).POS.Map, UserList(AttackerIndex).POS.X, UserList(AttackerIndex).POS.y).trigger = 4 Then
    Call SendData(ToIndex, AttackerIndex, 0, "/B")
    Exit Function
End If

If UserList(VictimIndex).flags.Party And UserList(AttackerIndex).PartyIndex = UserList(VictimIndex).PartyIndex Then
    Call SendData(ToIndex, AttackerIndex, 0, "||No puedes atacar a miembros de tu party." & FONTTYPE_FIGHT)
    Exit Function
End If

If UserList(VictimIndex).Stats.MinSta < UserList(VictimIndex).Stats.MaxSta / 10 Then
    Call SendData(ToIndex, AttackerIndex, 0, "||No puedes atacar usuarios que tienen menos del 10% de su stamina total." & FONTTYPE_INFO)
    Exit Function
End If

If Len(UserList(VictimIndex).GuildInfo.GuildName) > 0 And UserList(AttackerIndex).GuildInfo.GuildName = UserList(VictimIndex).GuildInfo.GuildName Then
    PuedeRobar = True
    Exit Function
End If

If UserList(AttackerIndex).Faccion.Bando <> Neutral And UserList(AttackerIndex).Faccion.Bando = UserList(VictimIndex).Faccion.Bando Then
    If Len(UserList(AttackerIndex).GuildInfo.GuildName) = 0 Or Len(UserList(VictimIndex).GuildInfo.GuildName) = 0 Then
        Call SendData(ToIndex, AttackerIndex, 0, Mensajes(UserList(AttackerIndex).Faccion.Bando, 20))
        Exit Function
    End If
    If Not UserList(AttackerIndex).GuildRef.IsEnemy(UserList(VictimIndex).GuildInfo.GuildName) Then
        Call SendData(ToIndex, AttackerIndex, 0, Mensajes(UserList(AttackerIndex).Faccion.Bando, 20))
        Exit Function
    End If
End If

If EsNewbie(VictimIndex) And (EsNewbie(AttackerIndex) Or UserList(AttackerIndex).Faccion.Bando = Real) Then
    Call SendData(ToIndex, AttackerIndex, 0, "%1")
    Exit Function
End If

If EsNewbie(AttackerIndex) And UserList(VictimIndex).Faccion.Bando = Real Then
    Call SendData(ToIndex, AttackerIndex, 0, "%2")
    Exit Function
End If

PuedeRobar = True

Call AllMascotasAtacanUser(AttackerIndex, VictimIndex)
Call AllMascotasAtacanUser(VictimIndex, AttackerIndex)

End Function

Public Function TriggerZonaPelea(ByVal Origen As Integer, ByVal Destino As Integer) As Trigger6
 
If Origen > 0 And Destino > 0 And Origen <= UBound(UserList) And Destino <= UBound(UserList) Then
    If MapData(UserList(Origen).POS.Map, UserList(Origen).POS.X, UserList(Origen).POS.y).trigger = 6 Or _
        MapData(UserList(Destino).POS.Map, UserList(Destino).POS.X, UserList(Destino).POS.y).trigger = 6 Then
        If (MapData(UserList(Origen).POS.Map, UserList(Origen).POS.X, UserList(Origen).POS.y).trigger = MapData(UserList(Destino).POS.Map, UserList(Destino).POS.X, UserList(Destino).POS.y).trigger) Then
            TriggerZonaPelea = TRIGGER6_PERMITE
        Else
            TriggerZonaPelea = TRIGGER6_PROHIBE
        End If
    Else
        TriggerZonaPelea = TRIGGER6_AUSENTE
    End If
Else
    TriggerZonaPelea = TRIGGER6_AUSENTE
End If
 
End Function

Public Function TriggerZonaPelea7(ByVal Origen As Integer, ByVal Destino As Integer) As Trigger6
 
If Origen > 0 And Destino > 0 And Origen <= UBound(UserList) And Destino <= UBound(UserList) Then
    If MapData(UserList(Origen).POS.Map, UserList(Origen).POS.X, UserList(Origen).POS.y).trigger = 7 Or _
        MapData(UserList(Destino).POS.Map, UserList(Destino).POS.X, UserList(Destino).POS.y).trigger = 7 Then
        If (MapData(UserList(Origen).POS.Map, UserList(Origen).POS.X, UserList(Origen).POS.y).trigger = MapData(UserList(Destino).POS.Map, UserList(Destino).POS.X, UserList(Destino).POS.y).trigger) Then
            TriggerZonaPelea7 = TRIGGER6_PERMITE
        Else
            TriggerZonaPelea7 = TRIGGER6_PROHIBE
        End If
    Else
        TriggerZonaPelea7 = TRIGGER6_AUSENTE
    End If
Else
    TriggerZonaPelea7 = TRIGGER6_AUSENTE
End If
 
End Function
