Attribute VB_Name = "NPCs"
 
'director del proyecto: #Esteban(Neliam)

'servidor basado en fénixao 1.0
'medios de contacto:
'Skype: dc.esteban
'E-mail: nabrianao@gmail.com
Option Explicit
Public rdata As String
Sub QuitarMascota(Userindex As Integer, ByVal NpcIndex As Integer)
Dim i As Integer

UserList(Userindex).NroMascotas = UserList(Userindex).NroMascotas - 1

For i = 1 To MAXMASCOTAS * Buleano(Not UserList(Userindex).flags.Quest)
  If UserList(Userindex).MascotasIndex(i) = NpcIndex Then
     UserList(Userindex).MascotasIndex(i) = 0
     UserList(Userindex).MascotasType(i) = 0
     Exit For
  End If
Next

End Sub
Sub QuitarMascotaNpc(Maestro As Integer, ByVal Mascota As Integer)

Npclist(Maestro).Mascotas = Npclist(Maestro).Mascotas - 1

End Sub
Sub MuereNpc(ByVal NpcIndex As Integer, Userindex As Integer)
On Error GoTo errhandler
Dim Exp As Long
Dim Bestia As Integer
Dim MiNPC As Npc
MiNPC = Npclist(NpcIndex)

If UserList(Userindex).flags.Questeando = 1 Then
Call MuereNpcQuest(Userindex, NpcIndex, UserList(Userindex).flags.UserNumQuest)
End If

'THETEAM
If Npclist(NpcIndex).Numero = 657 Then
Call SendData(ToAll, 0, 0, "TW207")
Call SumaThteH
Call EnviarBasesThte(Userindex)
CuentathteH = 30
Call QuitarNPC(NpcIndex)
Exit Sub
End If
If Npclist(NpcIndex).Numero = 658 Then
Call SendData(ToAll, 0, 0, "TW208")
Call SumaThteC
Call EnviarBasesThte(Userindex)
CuentathteC = 30
Call QuitarNPC(NpcIndex)
Exit Sub
End If
'THETEAM
'CASTILLO
If MiNPC.Numero = NPCRey Then
Call MuereRey(Userindex)
Call QuitarNPC(NpcIndex)
Exit Sub
End If
If MiNPC.Numero = 237 Then
DiosHades = 0
Call SendData(ToAll, 0, 0, "||Hades Cayo en manos de " & UserList(Userindex).Name & FONTTYPE_FIGHT)
Call SendData(ToAll, 0, 0, "TWmuertedios")
End If
'CASTILLO

If MiNPC.Stats.MaxHP > 9999 Then
UserList(Userindex).Stats.Reputacion = UserList(Userindex).Stats.Reputacion + 4
Call SendUserREP(Userindex)
End If

Call QuitarNPC(NpcIndex)

If MiNPC.MaestroUser = 0 Then
     If Userindex Then Call NPCTirarOro(MiNPC, Userindex)
     If Userindex Then Call NPC_TIRAR_ITEMS(MiNPC, Userindex)
End If

If Userindex > 0 Then Call SubirSkill(Userindex, Supervivencia, 40)
Call ReSpawnNpc(MiNPC)

Exit Sub

errhandler:
    Call LogError("Error en MuereNpc " & Err.Description)
    
End Sub
Function NPCListable(NpcIndex As Integer) As Boolean

NPCListable = (Npclist(NpcIndex).Attackable And Not Npclist(NpcIndex).flags.Respawn)

End Function
Sub QuitarNPC(ByVal NpcIndex As Integer)
On Error GoTo errhandler
Dim i As Integer

Npclist(NpcIndex).flags.NPCActive = False

If NPCListable(NpcIndex) Then Call QuitarNPCDeLista(Npclist(NpcIndex).Numero, Npclist(NpcIndex).POS.Map)

Call SendData(ToNPCArea, NpcIndex, Npclist(NpcIndex).POS.Map, "QDL" & Npclist(NpcIndex).Char.CharIndex)

If InMapBounds(Npclist(NpcIndex).POS.X, Npclist(NpcIndex).POS.y) Then Call EraseNPCChar(ToMap, 0, Npclist(NpcIndex).POS.Map, NpcIndex)

If Npclist(NpcIndex).MaestroUser Then Call QuitarMascota(Npclist(NpcIndex).MaestroUser, NpcIndex)
If Npclist(NpcIndex).MaestroNpc Then Call QuitarMascotaNpc(Npclist(NpcIndex).MaestroNpc, NpcIndex)

Npclist(NpcIndex) = NpcNoIniciado

For i = LastNPC To 1 Step -1
    If Npclist(i).flags.NPCActive Then
        LastNPC = i
        Exit For
    End If
Next

If NumNPCs Then NumNPCs = NumNPCs - 1

Exit Sub

errhandler:
    Npclist(NpcIndex).flags.NPCActive = False
    Call LogError("Error en QuitarNPC-" & Err.Description)

End Sub
Function TestSpawnTrigger(POS As WorldPos) As Boolean

If Not InMapBounds(POS.X, POS.y) Or Not MapaValido(POS.Map) Then Exit Function

    TestSpawnTrigger = _
    MapData(POS.Map, POS.X, POS.y).trigger <> 3 And _
    MapData(POS.Map, POS.X, POS.y).trigger <> 2 And _
    MapData(POS.Map, POS.X, POS.y).trigger <> 1

End Function
Sub CrearNPC(NroNPC As Integer, Mapa As Integer, OrigPos As WorldPos)


Dim POS As WorldPos
Dim newpos As WorldPos
Dim nIndex As Integer
Dim PosicionValida As Boolean
Dim Iteraciones As Long
Dim Map As Integer
Dim X As Integer
Dim y As Integer
On Error GoTo Error

nIndex = OpenNPC(NroNPC)

If nIndex > MAXNPCS Then Exit Sub


If InMapBounds(OrigPos.X, OrigPos.y) Then
    
    Map = OrigPos.Map
    X = OrigPos.X
    y = OrigPos.y
    Npclist(nIndex).Orig = OrigPos
    Npclist(nIndex).POS = OrigPos
    
Else
    
    POS.Map = Mapa
    
    Do While Not PosicionValida
        DoEvents
        
        POS.X = CInt(Rnd * 100 + 1)
        POS.y = CInt(Rnd * 100 + 1)
        
        Call ClosestLegalPos(POS, newpos, Npclist(nIndex).flags.AguaValida = 1)
        
        
        If LegalPosNPC(newpos.Map, newpos.X, newpos.y, Npclist(nIndex).flags.AguaValida = 1) And _
           Not HayPCarea(newpos) And TestSpawnTrigger(newpos) Then
            
            Npclist(nIndex).POS.Map = newpos.Map
            Npclist(nIndex).POS.X = newpos.X
            Npclist(nIndex).POS.y = newpos.y
            PosicionValida = True
        Else
            newpos.X = 0
            newpos.y = 0
        
        End If
            
        
        Iteraciones = Iteraciones + 1
        If Iteraciones > MAXSPAWNATTEMPS Then
            Call QuitarNPC(nIndex)
            Call LogError(MAXSPAWNATTEMPS & " iteraciones en CrearNpc Mapa:" & Mapa & " NroNpc:" & NroNPC)
            Exit Sub
        End If
    Loop
    
    
    Map = newpos.Map
    X = Npclist(nIndex).POS.X
    y = Npclist(nIndex).POS.y
End If


Call MakeNPCChar(ToMap, 0, Map, nIndex, Map, X, y)

If NPCListable(nIndex) Then Call AgregarNPC(Npclist(nIndex).Numero, Mapa)
Exit Sub
Error:
    
    Call LogError("Error en CrearNPC." & Map & " " & X & " " & y & " " & nIndex)
End Sub
Sub MakeNPCChar(sndRoute As Byte, sndIndex As Integer, sndMap As Integer, ByVal NpcIndex As Integer, Map As Integer, X As Integer, y As Integer)
Dim CharIndex As Integer

If Npclist(NpcIndex).Char.CharIndex = 0 Then
    CharIndex = NextOpenCharIndex
    Npclist(NpcIndex).Char.CharIndex = CharIndex
    CharList(CharIndex) = NpcIndex
End If

MapData(Map, X, y).NpcIndex = NpcIndex

Call SendData(sndRoute, sndIndex, sndMap, ("CC" & Npclist(NpcIndex).Char.Body & "," & Npclist(NpcIndex).Char.Head & "," & Npclist(NpcIndex).Char.Heading & "," & Npclist(NpcIndex).Char.CharIndex & "," & X & "," & y & "," & Npclist(NpcIndex).Name))

End Sub

Sub ChangeNPCChar(NpcIndex As Integer, Body As Integer, Head As Integer, ByVal Heading As Byte)

If Npclist(NpcIndex).Char.Body = Body And _
    Npclist(NpcIndex).Char.Head = Head And _
    Npclist(NpcIndex).Char.Heading = Heading Then Exit Sub
If NpcIndex Then
    Npclist(NpcIndex).Char.Body = Body
    Npclist(NpcIndex).Char.Head = Head
    Npclist(NpcIndex).Char.Heading = Heading
    Call SendData(ToNPCAreaG, NpcIndex, Npclist(NpcIndex).POS.Map, "CP" & Npclist(NpcIndex).Char.CharIndex & "," & Body & "," & Head & "," & Heading)
End If

End Sub

Sub EraseNPCChar(sndRoute As Byte, sndIndex As Integer, sndMap As Integer, ByVal NpcIndex As Integer)

If Npclist(NpcIndex).Char.CharIndex Then CharList(Npclist(NpcIndex).Char.CharIndex) = 0

If Npclist(NpcIndex).Char.CharIndex = LastChar Then
    Do Until CharList(LastChar) > 0
        LastChar = LastChar - 1
        If LastChar < 1 Then Exit Do
    Loop
End If


MapData(Npclist(NpcIndex).POS.Map, Npclist(NpcIndex).POS.X, Npclist(NpcIndex).POS.y).NpcIndex = 0


Call SendData(ToMap, 0, Npclist(NpcIndex).POS.Map, "BP" & Npclist(NpcIndex).Char.CharIndex)


Npclist(NpcIndex).Char.CharIndex = 0



NumChars = NumChars - 1


End Sub
Sub MoveNPCChar(NpcIndex As Integer, ByVal nHeading As Byte)
On Error GoTo errh
Dim nPos As WorldPos

If Npclist(NpcIndex).AutoCurar = 1 Then Exit Sub

nPos = Npclist(NpcIndex).POS
Call HeadtoPos(nHeading, nPos)

If (Npclist(NpcIndex).MaestroUser And LegalPos(Npclist(NpcIndex).POS.Map, nPos.X, nPos.y)) Or LegalPosNPC(Npclist(NpcIndex).POS.Map, nPos.X, nPos.y, Npclist(NpcIndex).flags.AguaValida = 1) Then
    If (Npclist(NpcIndex).flags.AguaValida = 0 And MapData(Npclist(NpcIndex).POS.Map, nPos.X, nPos.y).Agua = 1) Or (Npclist(NpcIndex).flags.TierraInvalida = 1 And MapData(Npclist(NpcIndex).POS.Map, nPos.X, nPos.y).Agua = 0) Then Exit Sub
        
    Call SendData(ToNPCAreaG, NpcIndex, Npclist(NpcIndex).POS.Map, "MP" & THeDEnCripTe(Npclist(NpcIndex).Char.CharIndex & "," & (nPos.X) & "," & (nPos.y), "STRINGGENM"))
    
    
    MapData(Npclist(NpcIndex).POS.Map, Npclist(NpcIndex).POS.X, Npclist(NpcIndex).POS.y).NpcIndex = 0
    Npclist(NpcIndex).POS = nPos
    Npclist(NpcIndex).Char.Heading = nHeading
    MapData(Npclist(NpcIndex).POS.Map, Npclist(NpcIndex).POS.X, Npclist(NpcIndex).POS.y).NpcIndex = NpcIndex
Else
    If Npclist(NpcIndex).Movement = NPC_PATHFINDING Then Npclist(NpcIndex).PFINFO.PathLenght = 0
End If

Exit Sub

errh:
    LogError ("Error en move npc " & NpcIndex)

End Sub
Function Bin(N)

 Dim S As String, i As Integer, uu, T
 
 uu = Int(Log(N) / Log(2))
 
 For i = 0 To uu
  S = (N Mod 2) & S
  T = N / 2
  N = Int(T)
 Next
  Bin = S
  
End Function
Function NextOpenNPC() As Integer
On Error GoTo errhandler

Dim loopc As Integer
  
For loopc = 1 To MAXNPCS + 1
    If loopc > MAXNPCS Then Exit For
    If Not Npclist(loopc).flags.NPCActive Then Exit For
Next
  
NextOpenNPC = loopc

Exit Function
errhandler:
    Call LogError("Error en NextOpenNPC")
End Function
Sub NpcEnvenenarUser(Userindex As Integer)
Dim N As Integer

N = RandomNumber(1, 10)

If N < 3 Then
    UserList(Userindex).flags.Envenenado = 1
    UserList(Userindex).flags.EstasEnvenenado = Timer
    UserList(Userindex).Counters.Veneno = Timer
    Call SendData(ToIndex, Userindex, 0, "1P")
End If

End Sub
Function SpawnNpc(NpcIndex As Integer, POS As WorldPos, ByVal FX As Boolean, ByVal Respawn As Boolean) As Integer
On Error GoTo Error
Dim newpos As WorldPos
Dim nIndex As Integer
Dim PosicionValida As Boolean
Dim Map As Integer
Dim X As Integer
Dim y As Integer
Dim it As Integer

nIndex = OpenNPC(NpcIndex, Respawn)

If nIndex > MAXNPCS Then
    SpawnNpc = nIndex
    Exit Function
End If

Do While Not PosicionValida
    Call ClosestLegalPos(POS, newpos)
    
    If LegalPos(newpos.Map, newpos.X, newpos.y) Then
        Npclist(nIndex).POS.Map = newpos.Map
        Npclist(nIndex).POS.X = newpos.X
        Npclist(nIndex).POS.y = newpos.y
        PosicionValida = True
    Else
        newpos.X = 0
        newpos.y = 0
    End If
    
    it = it + 1
    
    If it > MAXSPAWNATTEMPS Then
        Call QuitarNPC(nIndex)
        SpawnNpc = MAXNPCS
        Call LogError("Más de " & MAXSPAWNATTEMPS & " iteraciones en SpawnNpc Mapa:" & POS.Map & " Index:" & NpcIndex)
        Exit Function
    End If
Loop
    
Map = newpos.Map
X = Npclist(nIndex).POS.X
y = Npclist(nIndex).POS.y

Call MakeNPCChar(ToMap, 0, Map, nIndex, Map, X, y)

If NPCListable(nIndex) Then Call AgregarNPC(Npclist(nIndex).Numero, POS.Map)

If FX Then
    Call SendData(ToNPCArea, nIndex, Npclist(NpcIndex).POS.Map, "TW" & SND_WARP)
    Call SendData(ToNPCArea, nIndex, Npclist(NpcIndex).POS.Map, "CFX" & Npclist(nIndex).Char.CharIndex & "," & Npclist(nIndex).Char.CharIndex & "," & FXWARP & "," & 1 & "," & 0) 'dx8
End If

SpawnNpc = nIndex

Exit Function
Error:
    Call LogError("Error en SpawnNPC: " & Err.Description & " " & nIndex & " " & X & " " & y)
End Function
Sub ReSpawnNpc(MiNPC As Npc)

If (MiNPC.flags.Respawn = 0) Then Call CrearNPC(MiNPC.Numero, MiNPC.POS.Map, MiNPC.Orig)

End Sub
Function NPCHostiles(Map As Integer) As Integer
Dim i As Integer
Dim cont As Integer

cont = 0

For i = 1 To UBound(MapInfo(Map).NPCsTeoricos)
    cont = cont + MapInfo(Map).NPCsReales(i).Cantidad
Next

NPCHostiles = cont

End Function
Sub NPCTirarOro(MiNPC As Npc, Userindex As Integer)
Dim i As Integer, MiembroIndex As Integer

If MiNPC.GiveGLD Then
    If UserList(Userindex).PartyIndex = 0 Then
        If MiNPC.GiveGLD + UserList(Userindex).Stats.GLD <= MAXORO Then
            UserList(Userindex).Stats.GLD = UserList(Userindex).Stats.GLD + MiNPC.GiveGLD
            Call SendData(ToIndex, Userindex, 0, "||Has conseguido: " & PonerPuntos(MiNPC.GiveGLD) & " monedas de oro." & FONTTYPE_BLANCO)
            Call SendUserORO(Userindex)
        End If
    Else
        For i = 1 To Party(UserList(Userindex).PartyIndex).NroMiembros
            MiembroIndex = Party(UserList(Userindex).PartyIndex).MiembrosIndex(i)
            If MiNPC.GiveGLD + UserList(MiembroIndex).Stats.GLD <= MAXORO Then
                UserList(MiembroIndex).Stats.GLD = UserList(MiembroIndex).Stats.GLD + MiNPC.GiveGLD / Party(UserList(MiembroIndex).PartyIndex).NroMiembros
                 Call SendData(ToIndex, MiembroIndex, 0, "||Has conseguido: " & MiNPC.GiveGLD / Party(UserList(MiembroIndex).PartyIndex).NroMiembros & " monedas de oro." & FONTTYPE_BLANCO)
                Call SendUserORO(MiembroIndex)
            End If
        Next
    End If
End If

End Sub
Function NameNpc(Number As Integer) As String
Dim a As Long, S As Long

If Number > 499 Then
    a = Anpc_host
Else
    a = ANpc
End If

S = INIBuscarSeccion(a, "NPC" & Number)

NameNpc = INIDarClaveStr(a, S, "Name")

End Function
Function MaxhpNPC(Number As Integer) As String
Dim a As Long, S As Long

If Number > 499 Then
    a = Anpc_host
Else
    a = ANpc
End If

S = INIBuscarSeccion(a, "NPC" & Number)

MaxhpNPC = INIDarClaveStr(a, S, "MaxHP")

End Function
Function ExpNPC(Number As Integer) As String
Dim a As Long, S As Long

If Number > 499 Then
    a = Anpc_host
Else
    a = ANpc
End If

S = INIBuscarSeccion(a, "NPC" & Number)

ExpNPC = INIDarClaveStr(a, S, "GiveEXP")

End Function
Function OroNpc(Number As Integer) As String
Dim a As Long, S As Long

If Number > 499 Then
    a = Anpc_host
Else
    a = ANpc
End If

S = INIBuscarSeccion(a, "NPC" & Number)

OroNpc = INIDarClaveStr(a, S, "GiveGLD")

End Function
Function GrhNPC(Number As Integer) As String
Dim a As Long, S As Long

If Number > 499 Then
    a = Anpc_host
Else
    a = ANpc
End If

S = INIBuscarSeccion(a, "NPC" & Number)

GrhNPC = INIDarClaveStr(a, S, "Body")

End Function
Function OpenNPC(NPCNumber As Integer, Optional ByVal Respawn = True) As Integer

Dim NpcIndex As Integer

Dim a As Long, S As Long

If NPCNumber > 499 Then

    a = Anpc_host
Else

    a = ANpc
End If

S = INIBuscarSeccion(a, "NPC" & NPCNumber)

NpcIndex = NextOpenNPC

If NpcIndex > MAXNPCS Then
    OpenNPC = NpcIndex
    Exit Function
End If

Npclist(NpcIndex).Numero = NPCNumber






If S >= 0 Then
    Npclist(NpcIndex).Name = INIDarClaveStr(a, S, "Name")
    Npclist(NpcIndex).Desc = INIDarClaveStr(a, S, "Desc")
    
    Npclist(NpcIndex).Movement = INIDarClaveInt(a, S, "Movement")
    Npclist(NpcIndex).flags.OldMovement = Npclist(NpcIndex).Movement
    
    Npclist(NpcIndex).flags.AguaValida = INIDarClaveInt(a, S, "AguaValida")
    Npclist(NpcIndex).flags.TierraInvalida = INIDarClaveInt(a, S, "TierraInValida")
    Npclist(NpcIndex).flags.Faccion = INIDarClaveInt(a, S, "Faccion")
    
    Npclist(NpcIndex).NPCtype = INIDarClaveInt(a, S, "NpcType")
    
    Npclist(NpcIndex).Char.Body = INIDarClaveInt(a, S, "Body")
    Npclist(NpcIndex).Char.Head = INIDarClaveInt(a, S, "Head")
    Npclist(NpcIndex).Char.Heading = INIDarClaveInt(a, S, "Heading")
    
    Npclist(NpcIndex).Attackable = INIDarClaveInt(a, S, "Attackable")
    Npclist(NpcIndex).Comercia = INIDarClaveInt(a, S, "Comercia")
    Npclist(NpcIndex).Hostile = INIDarClaveInt(a, S, "Hostile")
    Npclist(NpcIndex).flags.OldHostil = Npclist(NpcIndex).Hostile
    
    Dim CantidadEXP As Integer
    CantidadEXP = val(GetVar(IniPath & "Server.ini", "INIT", "Experiencia"))
    Npclist(NpcIndex).GiveEXP = INIDarClaveInt(a, S, "GiveEXP") * CantidadEXP
    
    Npclist(NpcIndex).Veneno = INIDarClaveInt(a, S, "Veneno")
    
    Npclist(NpcIndex).flags.Domable = INIDarClaveInt(a, S, "Domable")
    
    Npclist(NpcIndex).MaxRecom = INIDarClaveInt(a, S, "MaxRecom")
    Npclist(NpcIndex).MinRecom = INIDarClaveInt(a, S, "MinRecom")
    Npclist(NpcIndex).Probabilidad = INIDarClaveInt(a, S, "Probabilidad")
    
    Dim CantidadORO As Integer
    CantidadORO = val(GetVar(IniPath & "Server.ini", "INIT", "Oro"))
    Npclist(NpcIndex).GiveGLD = INIDarClaveInt(a, S, "GiveGLD") * CantidadORO
    
    Npclist(NpcIndex).PoderAtaque = INIDarClaveInt(a, S, "PoderAtaque")
    Npclist(NpcIndex).PoderEvasion = INIDarClaveInt(a, S, "PoderEvasion")
    
    Npclist(NpcIndex).AutoCurar = INIDarClaveInt(a, S, "Autocurar")
    Npclist(NpcIndex).Stats.MaxHP = INIDarClaveInt(a, S, "MaxHP")
    Npclist(NpcIndex).Stats.MinHP = INIDarClaveInt(a, S, "MinHP")
    Npclist(NpcIndex).Stats.MaxHit = INIDarClaveInt(a, S, "MaxHIT")
    Npclist(NpcIndex).Stats.MinHit = INIDarClaveInt(a, S, "MinHIT")
    Npclist(NpcIndex).Stats.Def = INIDarClaveInt(a, S, "DEF")
    Npclist(NpcIndex).Stats.Alineacion = INIDarClaveInt(a, S, "Alineacion")
    Npclist(NpcIndex).Stats.ImpactRate = INIDarClaveInt(a, S, "ImpactRate")
    Npclist(NpcIndex).InvReSpawn = INIDarClaveInt(a, S, "InvReSpawn")
    
    
    Dim loopc As Integer
    Dim ln As String
    Npclist(NpcIndex).Invent.NroItems = INIDarClaveInt(a, S, "NROITEMS")
    
    For loopc = 1 To Minimo(30, Npclist(NpcIndex).Invent.NroItems)
        ln = INIDarClaveStr(a, S, "Obj" & loopc)
        Npclist(NpcIndex).Invent.Object(loopc).OBJIndex = val(ReadField(1, ln, 45))
    Next
    
    If Npclist(NpcIndex).InvReSpawn Or Npclist(NpcIndex).Comercia = 0 Then
        For loopc = 1 To Minimo(30, Npclist(NpcIndex).Invent.NroItems)
            ln = INIDarClaveStr(a, S, "Obj" & loopc)
            Npclist(NpcIndex).Invent.Object(loopc).Amount = val(ReadField(2, ln, 45))
        Next
    End If
    
    Npclist(NpcIndex).flags.LanzaSpells = INIDarClaveInt(a, S, "LanzaSpells")
    If Npclist(NpcIndex).flags.LanzaSpells Then ReDim Npclist(NpcIndex).Spells(1 To Npclist(NpcIndex).flags.LanzaSpells)
    For loopc = 1 To Npclist(NpcIndex).flags.LanzaSpells
        Npclist(NpcIndex).Spells(loopc) = INIDarClaveInt(a, S, "Sp" & loopc)
    Next
    
    
    If Npclist(NpcIndex).NPCtype = NPCTYPE_ENTRENADOR Then
        Npclist(NpcIndex).NroCriaturas = INIDarClaveInt(a, S, "NroCriaturas")
        ReDim Npclist(NpcIndex).Criaturas(1 To Npclist(NpcIndex).NroCriaturas) As tCriaturasEntrenador
        For loopc = 1 To Npclist(NpcIndex).NroCriaturas
            Npclist(NpcIndex).Criaturas(loopc).NpcIndex = INIDarClaveInt(a, S, "CI" & loopc)
            Npclist(NpcIndex).Criaturas(loopc).NpcName = INIDarClaveStr(a, S, "CN" & loopc)
    
        Next
    End If
    
    
    Npclist(NpcIndex).Inflacion = INIDarClaveInt(a, S, "Inflacion")
    
    Npclist(NpcIndex).flags.NPCActive = True
    Npclist(NpcIndex).flags.UseAINow = False
    
    If Respawn Then
        Npclist(NpcIndex).flags.Respawn = INIDarClaveInt(a, S, "ReSpawn")
    Else
        Npclist(NpcIndex).flags.Respawn = 1
    End If
    
    Npclist(NpcIndex).flags.RespawnOrigPos = INIDarClaveInt(a, S, "OrigPos")
    Npclist(NpcIndex).flags.AfectaParalisis = INIDarClaveInt(a, S, "AfectaParalisis")
    Npclist(NpcIndex).flags.GolpeExacto = INIDarClaveInt(a, S, "GolpeExacto")
    Npclist(NpcIndex).flags.Apostador = INIDarClaveInt(a, S, "Apostador")
    Npclist(NpcIndex).flags.PocaParalisis = INIDarClaveInt(a, S, "PocaParalisis")
    Npclist(NpcIndex).flags.NoMagia = INIDarClaveInt(a, S, "NoMagia")
    Npclist(NpcIndex).VeInvis = INIDarClaveInt(a, S, "VerInvis")
    
    Npclist(NpcIndex).flags.Snd1 = INIDarClaveInt(a, S, "Snd1")
    Npclist(NpcIndex).flags.Snd2 = INIDarClaveInt(a, S, "Snd2")
    Npclist(NpcIndex).flags.Snd3 = INIDarClaveInt(a, S, "Snd3")
    Npclist(NpcIndex).flags.Snd4 = INIDarClaveInt(a, S, "Snd4")
    
    
    
    Dim aux As Long
    aux = INIDarClaveInt(a, S, "NROEXP")
    Npclist(NpcIndex).NroExpresiones = (aux)
        
    If aux Then
        ReDim Npclist(NpcIndex).Expresiones(1 To Npclist(NpcIndex).NroExpresiones) As String
        For loopc = 1 To Npclist(NpcIndex).NroExpresiones
            Npclist(NpcIndex).Expresiones(loopc) = INIDarClaveStr(a, S, "Exp" & loopc)
        Next
    End If
    
    
    
    
    Npclist(NpcIndex).TipoItems = INIDarClaveInt(a, S, "TipoItems")
End If


If NpcIndex > LastNPC Then LastNPC = NpcIndex
NumNPCs = NumNPCs + 1



OpenNPC = NpcIndex

End Function


Function OpenNPC_Viejo(NPCNumber As Integer, Optional ByVal Respawn = True) As Integer

Dim NpcIndex As Integer
Dim npcfile As String

If NPCNumber > 499 Then
        npcfile = DatPath & "NPCs-HOSTILES.dat"
Else
        npcfile = DatPath & "NPCs.dat"
End If


NpcIndex = NextOpenNPC

If NpcIndex > MAXNPCS Then
    OpenNPC_Viejo = NpcIndex
    Exit Function
End If

Npclist(NpcIndex).Numero = NPCNumber
Npclist(NpcIndex).Name = GetVar(npcfile, "NPC" & NPCNumber, "Name")
Npclist(NpcIndex).Desc = GetVar(npcfile, "NPC" & NPCNumber, "Desc")

Npclist(NpcIndex).Movement = val(GetVar(npcfile, "NPC" & NPCNumber, "Movement"))
Npclist(NpcIndex).flags.OldMovement = Npclist(NpcIndex).Movement

Npclist(NpcIndex).flags.AguaValida = val(GetVar(npcfile, "NPC" & NPCNumber, "AguaValida"))
Npclist(NpcIndex).flags.TierraInvalida = val(GetVar(npcfile, "NPC" & NPCNumber, "TierraInValida"))
Npclist(NpcIndex).flags.Faccion = val(GetVar(npcfile, "NPC" & NPCNumber, "Faccion"))

Npclist(NpcIndex).NPCtype = val(GetVar(npcfile, "NPC" & NPCNumber, "NpcType"))

Npclist(NpcIndex).Char.Body = val(GetVar(npcfile, "NPC" & NPCNumber, "Body"))
Npclist(NpcIndex).Char.Head = val(GetVar(npcfile, "NPC" & NPCNumber, "Head"))
Npclist(NpcIndex).Char.Heading = val(GetVar(npcfile, "NPC" & NPCNumber, "Heading"))

Npclist(NpcIndex).Attackable = val(GetVar(npcfile, "NPC" & NPCNumber, "Attackable"))
Npclist(NpcIndex).Comercia = val(GetVar(npcfile, "NPC" & NPCNumber, "Comercia"))
Npclist(NpcIndex).Hostile = val(GetVar(npcfile, "NPC" & NPCNumber, "Hostile"))
Npclist(NpcIndex).flags.OldHostil = Npclist(NpcIndex).Hostile


Npclist(NpcIndex).MaxRecom = val(GetVar(npcfile, "NPC" & NPCNumber, "MaxRecom"))
Npclist(NpcIndex).MinRecom = val(GetVar(npcfile, "NPC" & NPCNumber, "MinRecom"))
Npclist(NpcIndex).Probabilidad = val(GetVar(npcfile, "NPC" & NPCNumber, "Probabilidad"))


Npclist(NpcIndex).GiveEXP = val(GetVar(npcfile, "NPC" & NPCNumber, "GiveEXP"))

Npclist(NpcIndex).Veneno = val(GetVar(npcfile, "NPC" & NPCNumber, "Veneno"))

Npclist(NpcIndex).flags.Domable = val(GetVar(npcfile, "NPC" & NPCNumber, "Domable"))


Npclist(NpcIndex).GiveGLD = val(GetVar(npcfile, "NPC" & NPCNumber, "GiveGLD"))

Npclist(NpcIndex).PoderAtaque = val(GetVar(npcfile, "NPC" & NPCNumber, "PoderAtaque"))
Npclist(NpcIndex).PoderEvasion = val(GetVar(npcfile, "NPC" & NPCNumber, "PoderEvasion"))

Npclist(NpcIndex).InvReSpawn = val(GetVar(npcfile, "NPC" & NPCNumber, "InvReSpawn"))
Npclist(NpcIndex).AutoCurar = val(GetVar(npcfile, "NPC" & NPCNumber, "autocurar"))


Npclist(NpcIndex).Stats.MaxHP = val(GetVar(npcfile, "NPC" & NPCNumber, "MaxHP"))
Npclist(NpcIndex).Stats.MinHP = val(GetVar(npcfile, "NPC" & NPCNumber, "MinHP"))
Npclist(NpcIndex).Stats.MaxHit = val(GetVar(npcfile, "NPC" & NPCNumber, "MaxHIT"))
Npclist(NpcIndex).Stats.MinHit = val(GetVar(npcfile, "NPC" & NPCNumber, "MinHIT"))
Npclist(NpcIndex).Stats.Def = val(GetVar(npcfile, "NPC" & NPCNumber, "DEF"))
Npclist(NpcIndex).Stats.Alineacion = val(GetVar(npcfile, "NPC" & NPCNumber, "Alineacion"))
Npclist(NpcIndex).Stats.ImpactRate = val(GetVar(npcfile, "NPC" & NPCNumber, "ImpactRate"))


Dim loopc As Integer
Dim ln As String
Npclist(NpcIndex).Invent.NroItems = val(GetVar(npcfile, "NPC" & NPCNumber, "NROITEMS"))
For loopc = 1 To Npclist(NpcIndex).Invent.NroItems
    ln = GetVar(npcfile, "NPC" & NPCNumber, "Obj" & loopc)
    Npclist(NpcIndex).Invent.Object(loopc).OBJIndex = val(ReadField(1, ln, 45))
    Npclist(NpcIndex).Invent.Object(loopc).Amount = val(ReadField(2, ln, 45))

Next

Npclist(NpcIndex).flags.LanzaSpells = val(GetVar(npcfile, "NPC" & NPCNumber, "LanzaSpells"))
If Npclist(NpcIndex).flags.LanzaSpells Then ReDim Npclist(NpcIndex).Spells(1 To Npclist(NpcIndex).flags.LanzaSpells)
For loopc = 1 To Npclist(NpcIndex).flags.LanzaSpells
    Npclist(NpcIndex).Spells(loopc) = val(GetVar(npcfile, "NPC" & NPCNumber, "Sp" & loopc))
Next


If Npclist(NpcIndex).NPCtype = NPCTYPE_ENTRENADOR Then
    Npclist(NpcIndex).NroCriaturas = val(GetVar(npcfile, "NPC" & NPCNumber, "NroCriaturas"))
    ReDim Npclist(NpcIndex).Criaturas(1 To Npclist(NpcIndex).NroCriaturas) As tCriaturasEntrenador
    For loopc = 1 To Npclist(NpcIndex).NroCriaturas
        Npclist(NpcIndex).Criaturas(loopc).NpcIndex = GetVar(npcfile, "NPC" & NPCNumber, "CI" & loopc)
        Npclist(NpcIndex).Criaturas(loopc).NpcName = GetVar(npcfile, "NPC" & NPCNumber, "CN" & loopc)
    Next
End If


Npclist(NpcIndex).Inflacion = val(GetVar(npcfile, "NPC" & NPCNumber, "Inflacion"))

Npclist(NpcIndex).flags.NPCActive = True
Npclist(NpcIndex).flags.UseAINow = False

If Respawn Then
    Npclist(NpcIndex).flags.Respawn = val(GetVar(npcfile, "NPC" & NPCNumber, "ReSpawn"))
Else
    Npclist(NpcIndex).flags.Respawn = 1
End If

Npclist(NpcIndex).flags.RespawnOrigPos = val(GetVar(npcfile, "NPC" & NPCNumber, "OrigPos"))
Npclist(NpcIndex).flags.AfectaParalisis = val(GetVar(npcfile, "NPC" & NPCNumber, "AfectaParalisis"))
Npclist(NpcIndex).flags.GolpeExacto = val(GetVar(npcfile, "NPC" & NPCNumber, "GolpeExacto"))
Npclist(NpcIndex).flags.PocaParalisis = val(GetVar(npcfile, "NPC" & NPCNumber, "PocaParalisis"))
Npclist(NpcIndex).VeInvis = val(GetVar(npcfile, "NPC" & NPCNumber, "veinvis"))



Npclist(NpcIndex).flags.Snd1 = val(GetVar(npcfile, "NPC" & NPCNumber, "Snd1"))
Npclist(NpcIndex).flags.Snd2 = val(GetVar(npcfile, "NPC" & NPCNumber, "Snd2"))
Npclist(NpcIndex).flags.Snd3 = val(GetVar(npcfile, "NPC" & NPCNumber, "Snd3"))
Npclist(NpcIndex).flags.Snd4 = val(GetVar(npcfile, "NPC" & NPCNumber, "Snd4"))



Dim aux As String
aux = GetVar(npcfile, "NPC" & NPCNumber, "NROEXP")
If Len(aux) = 0 Then
    Npclist(NpcIndex).NroExpresiones = 0
Else
    Npclist(NpcIndex).NroExpresiones = val(aux)
    ReDim Npclist(NpcIndex).Expresiones(1 To Npclist(NpcIndex).NroExpresiones) As String
    For loopc = 1 To Npclist(NpcIndex).NroExpresiones
        Npclist(NpcIndex).Expresiones(loopc) = GetVar(npcfile, "NPC" & NPCNumber, "Exp" & loopc)
    Next
End If




Npclist(NpcIndex).TipoItems = val(GetVar(npcfile, "NPC" & NPCNumber, "TipoItems"))


If NpcIndex > LastNPC Then LastNPC = NpcIndex
NumNPCs = NumNPCs + 1



OpenNPC_Viejo = NpcIndex

End Function

Sub EnviarListaCriaturas(Userindex As Integer, NpcIndex)
  Dim SD As String
  Dim k As Integer
  SD = SD & Npclist(NpcIndex).NroCriaturas & ","
  For k = 1 To Npclist(NpcIndex).NroCriaturas
        SD = SD & Npclist(NpcIndex).Criaturas(k).NpcName & ","
  Next
  SD = "LSTCRI" & SD
  Call SendData(ToIndex, Userindex, 0, SD)
End Sub


Sub DoFollow(NpcIndex As Integer, Userindex As Integer)

If Npclist(NpcIndex).flags.Follow Then
  Npclist(NpcIndex).flags.AttackedBy = 0
  Npclist(NpcIndex).flags.Follow = False
  Npclist(NpcIndex).Movement = Npclist(NpcIndex).flags.OldMovement
  Npclist(NpcIndex).Hostile = Npclist(NpcIndex).flags.OldHostil
Else
  Npclist(NpcIndex).flags.AttackedBy = Userindex
  Npclist(NpcIndex).flags.Follow = True
  Npclist(NpcIndex).Movement = 4
  Npclist(NpcIndex).Hostile = 0
End If

End Sub

Sub FollowAmo(ByVal NpcIndex As Integer)

  Npclist(NpcIndex).flags.Follow = True
  Npclist(NpcIndex).Movement = SIGUE_AMO
  Npclist(NpcIndex).Hostile = 0
  Npclist(NpcIndex).Target = 0
  Npclist(NpcIndex).TargetNpc = 0

End Sub

