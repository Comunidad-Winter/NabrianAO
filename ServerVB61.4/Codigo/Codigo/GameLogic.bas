Attribute VB_Name = "Extra"
 
'director del proyecto: #Esteban(Neliam)

'servidor basado en fénixao 1.0
'medios de contacto:
'Skype: dc.esteban
'E-mail: nabrianao@gmail.com
Option Explicit
Public Function EsNewbie(Userindex As Integer) As Boolean

EsNewbie = (UserList(Userindex).Stats.ELV <= LimiteNewbie)

End Function
Public Sub DoTileEvents(Userindex As Integer)
On Error GoTo errhandler
Dim Map As Integer, X As Integer, y As Integer
Dim nPos As WorldPos, mPos As WorldPos

Map = UserList(Userindex).POS.Map
X = UserList(Userindex).POS.X
y = UserList(Userindex).POS.y


mPos = MapData(Map, X, y).TileExit
If Not MapaValido(mPos.Map) Or Not InMapBounds(mPos.X, mPos.y) Then Exit Sub


If MapData(28, X, y).TileExit.Map = 127 Then 'cambia x
'Dim ClanesCreados As Integer ' castillo
'Dim rutaa1 As Long, rutaa2 As Long

'rutaa1 = INICarga(App.Path & "\Guilds\GuildsInfo.inf")
'Call INIConf(rutaa1, 0, "", 0)

'rutaa2 = INIBuscarSeccion(rutaa1, "INIT")
'ClanesCreados = INIDarClaveInt(rutaa1, rutaa2, "NroGuilds")

'If ClanesCreados < 4 Then
'Call SendData(ToIndex, Userindex, 0, "||El castillo se activará cuando se creén 4 clanes." & FONTTYPE_FENIX)
'Exit Sub
'End If

If UserList(Userindex).GuildInfo.GuildName = "" Then
Call SendData(ToIndex, Userindex, 0, "||Necesitas tener clan para ingresar al castillo de clanes" & FONTTYPE_FENIX)
Exit Sub
End If
End If

If MapData(144, X, y).TileExit.Map = 89 Or MapData(116, X, y).TileExit.Map = 89 Or MapData(182, X, y).TileExit.Map = 89 Then   'cambia x
If Not TieneObjetos(Amuleto, 1, Userindex) And UserList(Userindex).flags.Templario = 0 Then
Call SendData(ToIndex, Userindex, 0, "||Para ingresar a Ultratumba debes ser templario o poseer un amuleto." & FONTTYPE_INFO)
Exit Sub
End If
End If


If MapInfo(mPos.Map).EsMapaEspecial Then
If Userindex = GranPoder Then
Call SendData(ToIndex, Userindex, 0, "||Has perdido el Gran Poder por entrar a un mapa seguro." & FONTTYPE_ORO)
GranPoder = 0
End If
ElseIf Not MapInfo(mPos.Map).Pk Then
If Userindex = GranPoder Then
Call SendData(ToIndex, Userindex, 0, "||Has perdido el Gran Poder por entrar a un mapa seguro." & FONTTYPE_ORO)
GranPoder = 0
End If
End If

If MapInfo(mPos.Map).Restringir And Not EsNewbie(Userindex) Then
    Call SendData(ToIndex, Userindex, 0, "1J")
ElseIf UserList(Userindex).Stats.ELV < MapInfo(mPos.Map).Nivel And Not (UserList(Userindex).Clase = PIRATA And UserList(Userindex).Recompensas(1) = 2) Then
    Call SendData(ToIndex, Userindex, 0, "%/" & MapInfo(mPos.Map).Nivel)
Else
    If LegalPos(mPos.Map, mPos.X, mPos.y, PuedeAtravesarAgua(Userindex)) Then
        If mPos.X <> 0 And mPos.y <> 0 Then Call WarpUserChar(Userindex, mPos.Map, mPos.X, mPos.y, ObjData(MapData(Map, X, y).OBJInfo.OBJIndex).ObjType = OBJTYPE_TELEPORT)
    Else
        Call ClosestStablePos(mPos, nPos)
        If nPos.X <> 0 And nPos.y Then Call WarpUserChar(Userindex, nPos.Map, nPos.X, nPos.y, ObjData(MapData(Map, X, y).OBJInfo.OBJIndex).ObjType = OBJTYPE_TELEPORT)
    End If
    Exit Sub
End If

Call ClosestStablePos(UserList(Userindex).POS, nPos)
If nPos.X <> 0 And nPos.y Then Call WarpUserChar(Userindex, nPos.Map, nPos.X, nPos.y, ObjData(MapData(Map, X, y).OBJInfo.OBJIndex).ObjType = OBJTYPE_TELEPORT)

Exit Sub

errhandler:
    Call LogError("Error en DoTileEvents-" & nPos.Map & "-" & nPos.X & "-" & nPos.y)

End Sub
Function InMapBounds(X As Integer, y As Integer) As Boolean

InMapBounds = (X >= MinXBorder And X <= MaxXBorder And y >= MinYBorder And y <= MaxYBorder)

End Function
Sub ClosestStablePos(POS As WorldPos, ByRef nPos As WorldPos)
Dim Notfound As Boolean
Dim loopc As Integer
Dim tX As Integer
Dim tY As Integer

nPos.Map = POS.Map

Do While Not LegalPos(POS.Map, nPos.X, nPos.y)
    If loopc > 12 Then
        Notfound = True
        Exit Do
    End If
    
    For tY = POS.y - loopc To POS.y + loopc
        For tX = POS.X - loopc To POS.X + loopc
            
            If LegalPos(nPos.Map, tX, tY) And MapData(nPos.Map, tX, tY).TileExit.Map = 0 Then
                nPos.X = tX
                nPos.y = tY

                tX = POS.X + loopc
                tY = POS.y + loopc
  
            End If
        
        Next tX
    Next tY
    
    loopc = loopc + 1
    
Loop

If Notfound = True Then
    nPos.X = 0
    nPos.y = 0
End If

End Sub
Sub ClosestLegalPos(POS As WorldPos, nPos As WorldPos, Optional AguaValida As Boolean)
Dim Notfound As Boolean
Dim loopc As Integer
Dim tX As Integer
Dim tY As Integer

nPos.Map = POS.Map

Do While Not LegalPos(POS.Map, nPos.X, nPos.y, AguaValida)
    If loopc > 12 Then
        Notfound = True
        Exit Do
    End If
    
    For tY = POS.y - loopc To POS.y + loopc
        For tX = POS.X - loopc To POS.X + loopc
            
            If LegalPos(nPos.Map, tX, tY, AguaValida) Then
                nPos.X = tX
                nPos.y = tY
                
                
                tX = POS.X + loopc
                tY = POS.y + loopc
  
            End If
        
        Next
    Next
    
    loopc = loopc + 1
    
Loop

If Notfound Then
    nPos.X = 0
    nPos.y = 0
End If

End Sub
Function ClaseIndex(ByVal Clase As String) As Integer
Dim i As Integer

For i = 1 To UBound(ListaClases)
    If UCase$(ListaClases(i)) = UCase$(Clase) Then
        ClaseIndex = i
        Exit Function
    End If
Next

End Function
Function NameIndex(ByVal Name As String) As Integer
Dim Userindex As Integer, i As Integer

Name = Replace$(Name, "+", " ")

If Len(Name) = 0 Then
    NameIndex = 0
    Exit Function
End If
  
Userindex = 1

If Right$(Name, 1) = "*" Then
    Name = Left$(Name, Len(Name) - 1)
    For i = 1 To LastUser
        If UCase$(UserList(i).Name) = UCase$(Name) Then
            NameIndex = i
            Exit Function
        End If
    Next
Else
    For i = 1 To LastUser
        If UCase$(Left$(UserList(i).Name, Len(Name))) = UCase$(Name) Then
            NameIndex = i
            Exit Function
        End If
    Next
End If

End Function
Function CheckForSameIP(Userindex As Integer, ByVal UserIP As String) As Boolean
Dim loopc As Integer

For loopc = 1 To MaxUsers
    If UserList(loopc).flags.UserLogged Then
        If UserList(loopc).ip = UserIP And Userindex <> loopc Then
            CheckForSameIP = True
            Exit Function
        End If
    End If
Next

End Function
Function CheckForSameName(Userindex As Integer, ByVal Name As String) As Boolean
Dim loopc As Integer

For loopc = 1 To LastUser
    If UserList(loopc).flags.UserLogged Then
        If UCase$(UserList(loopc).Name) = UCase$(Name) Then
            CheckForSameName = True
            Exit Function
        End If
    End If
Next

End Function
Sub HeadtoPos(Head As Byte, POS As WorldPos)
Dim X As Integer
Dim y As Integer
Dim nX As Integer
Dim nY As Integer

X = POS.X
y = POS.y

If Head = NORTH Then
    nX = X
    nY = y - 1
End If

If Head = SOUTH Then
    nX = X
    nY = y + 1
End If

If Head = EAST Then
    nX = X + 1
    nY = y
End If

If Head = WEST Then
    nX = X - 1
    nY = y
End If

POS.X = nX
POS.y = nY

End Sub
Function LegalPos(Map As Integer, X As Integer, y As Integer, Optional PuedeAgua As Boolean) As Boolean

If Not MapaValido(Map) Or Not InMapBounds(X, y) Then Exit Function

LegalPos = (MapData(Map, X, y).Blocked = 0) And _
           (MapData(Map, X, y).Userindex = 0) And _
           (MapData(Map, X, y).NpcIndex = 0) And _
           (MapData(Map, X, y).Agua = Buleano(PuedeAgua))

End Function
Function LegalPosNPC(Map As Integer, X As Integer, y As Integer, AguaValida As Boolean) As Boolean

If Not InMapBounds(X, y) Then Exit Function

LegalPosNPC = (MapData(Map, X, y).Blocked <> 1) And _
     (MapData(Map, X, y).Userindex = 0) And _
     (MapData(Map, X, y).NpcIndex = 0) And _
     (MapData(Map, X, y).trigger <> POSINVALIDA) _
     And Buleano(AguaValida) = MapData(Map, X, y).Agua
     
End Function
Public Sub SendNPC(Userindex As Integer, NpcIndex As Integer)
Dim Info As String
Dim CRI As Byte

Select Case UserList(Userindex).Stats.UserSkills(Supervivencia)
    Case Is <= 20
        If Npclist(NpcIndex).Stats.MinHP = Npclist(NpcIndex).Stats.MaxHP Then
            CRI = 5
        Else: CRI = 1
        End If
    Case Is < 40
        Select Case 100 * Npclist(NpcIndex).Stats.MinHP / Npclist(NpcIndex).Stats.MaxHP
            Case 100
                CRI = 5
            Case Is >= 50
                CRI = 2
            Case Else
                CRI = 3
        End Select
    Case Is < 60
        Select Case 100 * Npclist(NpcIndex).Stats.MinHP / Npclist(NpcIndex).Stats.MaxHP
            Case 100
                CRI = 5
            Case Is > 66
                CRI = 2
            Case Is > 33
                CRI = 3
            Case Else
                CRI = 4
        End Select
    Case Is < 100
        CRI = 5 + Fix(10 * (1 - (Npclist(NpcIndex).Stats.MinHP / Npclist(NpcIndex).Stats.MaxHP)))
    Case Else
        Info = "||" & Npclist(NpcIndex).Name & " [" & Npclist(NpcIndex).Stats.MinHP & "/" & Npclist(NpcIndex).Stats.MaxHP & "]"
        If Npclist(NpcIndex).flags.Paralizado Then Info = Info & " - PARALIZADO"
        Call SendData(ToIndex, Userindex, 0, Info & FONTTYPE_INFO)
        Exit Sub
End Select

Info = "9Q" & Npclist(NpcIndex).Name & "," & CRI
Call SendData(ToIndex, Userindex, 0, Info)
                
End Sub
Public Sub Expresar(NpcIndex As Integer, Userindex As Integer)

If Npclist(NpcIndex).NroExpresiones Then
    Dim randomi
    randomi = RandomNumber(1, Npclist(NpcIndex).NroExpresiones)
    Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "3Q" & vbWhite & "°" & Npclist(NpcIndex).Expresiones(randomi) & "°" & Npclist(NpcIndex).Char.CharIndex)
End If
                    
End Sub
Sub LookatTile(Userindex As Integer, Map As Integer, X As Integer, y As Integer)

Dim FoundChar As Byte
Dim FoundSomething As Byte
Dim TempCharIndex As Integer
Dim Stat As String
Dim NPMUERTO As String
Dim Info As String


If InMapBounds(X, y) Then
    UserList(Userindex).flags.TargetMap = Map
    UserList(Userindex).flags.TargetX = X
    UserList(Userindex).flags.TargetY = y
    
    If MapData(Map, X, y).OBJInfo.OBJIndex Then
        
        If MapData(Map, X, y).OBJInfo.Amount = 1 Then
            Call SendData(ToIndex, Userindex, 0, "4Q" & ObjData(MapData(Map, X, y).OBJInfo.OBJIndex).Name)
        Else
            Call SendData(ToIndex, Userindex, 0, "5Q" & ObjData(MapData(Map, X, y).OBJInfo.OBJIndex).Name & "," & MapData(Map, X, y).OBJInfo.Amount)
        End If
        UserList(Userindex).flags.TargetObj = MapData(Map, X, y).OBJInfo.OBJIndex
        UserList(Userindex).flags.TargetObjMap = Map
        UserList(Userindex).flags.TargetObjX = X
        UserList(Userindex).flags.TargetObjY = y
        FoundSomething = 1
    ElseIf MapData(Map, X + 1, y).OBJInfo.OBJIndex Then
        
        If ObjData(MapData(Map, X + 1, y).OBJInfo.OBJIndex).ObjType = OBJTYPE_PUERTAS Then
            Call SendData(ToIndex, Userindex, 0, "6Q" & ObjData(MapData(Map, X + 1, y).OBJInfo.OBJIndex).Name)
            UserList(Userindex).flags.TargetObj = MapData(Map, X + 1, y).OBJInfo.OBJIndex
            UserList(Userindex).flags.TargetObjMap = Map
            UserList(Userindex).flags.TargetObjX = X + 1
            UserList(Userindex).flags.TargetObjY = y
            FoundSomething = 1
        End If
    ElseIf MapData(Map, X + 1, y + 1).OBJInfo.OBJIndex Then
        If ObjData(MapData(Map, X + 1, y + 1).OBJInfo.OBJIndex).ObjType = OBJTYPE_PUERTAS Then
            
            Call SendData(ToIndex, Userindex, 0, "6Q" & ObjData(MapData(Map, X + 1, y + 1).OBJInfo.OBJIndex).Name)
            UserList(Userindex).flags.TargetObj = MapData(Map, X + 1, y + 1).OBJInfo.OBJIndex
            UserList(Userindex).flags.TargetObjMap = Map
            UserList(Userindex).flags.TargetObjX = X + 1
            UserList(Userindex).flags.TargetObjY = y + 1
            FoundSomething = 1
        End If
    ElseIf MapData(Map, X, y + 1).OBJInfo.OBJIndex Then
        If ObjData(MapData(Map, X, y + 1).OBJInfo.OBJIndex).ObjType = OBJTYPE_PUERTAS Then
            
            Call SendData(ToIndex, Userindex, 0, "6Q" & ObjData(MapData(Map, X, y + 1).OBJInfo.OBJIndex).Name)
            UserList(Userindex).flags.TargetObj = MapData(Map, X, y).OBJInfo.OBJIndex
            UserList(Userindex).flags.TargetObjMap = Map
            UserList(Userindex).flags.TargetObjX = X
            UserList(Userindex).flags.TargetObjY = y + 1
            FoundSomething = 1
        End If
    End If
    
    If y + 1 <= YMaxMapSize Then
        If MapData(Map, X, y + 1).Userindex Then
            TempCharIndex = MapData(Map, X, y + 1).Userindex
            FoundChar = 1
        End If
        If MapData(Map, X, y + 1).NpcIndex Then
            TempCharIndex = MapData(Map, X, y + 1).NpcIndex
            FoundChar = 2
        End If
    End If
    
    If FoundChar = 0 Then
        If MapData(Map, X, y).Userindex Then
            TempCharIndex = MapData(Map, X, y).Userindex
            FoundChar = 1
        End If
        If MapData(Map, X, y).NpcIndex Then
            TempCharIndex = MapData(Map, X, y).NpcIndex
            FoundChar = 2
        End If
    End If
    
    
    
    If FoundChar = 1 Then
            
        If UserList(TempCharIndex).flags.AdminInvisible Then Exit Sub
      '  If UserList(TempCharIndex).flags.Privilegios = 0 And UserList(TempCharIndex).POS.Map = 16 Then Exit Sub 'PLAYER
        
        If UserList(TempCharIndex).Faccion.Bando Then
            If UserList(TempCharIndex).Faccion.BandoOriginal <> UserList(TempCharIndex).Faccion.Bando Then
                Stat = Stat & " <" & ListaBandos(UserList(TempCharIndex).Faccion.Bando) & "> <Mercenario>"
            ElseIf UserList(TempCharIndex).Faccion.Jerarquia Then
                Stat = Stat & " <" & ListaBandos(UserList(TempCharIndex).Faccion.Bando) & "> <" & Titulo(TempCharIndex) & ">"
            Else
                Stat = Stat & " <" & Titulo(TempCharIndex) & ">"
            End If
        End If
    
       If Len(UserList(TempCharIndex).GuildInfo.GuildName) > 0 Then
            Stat = Stat & " <" & UserList(TempCharIndex).GuildInfo.GuildName & ">"
        End If
        
        If Len(UserList(TempCharIndex).Desc) > 0 Then
            Stat = UserList(TempCharIndex).Name & Stat & " - " & UserList(TempCharIndex).Desc
        Else
            Stat = UserList(TempCharIndex).Name & Stat
        End If
        
        Call ClanGM(TempCharIndex)
        
        If UserList(TempCharIndex).flags.Privilegios > 1 Then
            Stat = "9J" & Stat
        Else
            If UserList(TempCharIndex).flags.Muerto Then
                Stat = "2K" & UserList(TempCharIndex).Name
            ElseIf UserList(TempCharIndex).Faccion.Bando = Real And UserList(TempCharIndex).flags.EsConseReal = 0 Then
                Stat = "3K" & Stat
            ElseIf UserList(TempCharIndex).Faccion.Bando = Caos And UserList(TempCharIndex).flags.EsConseCaos = 0 Then
                Stat = "4K" & Stat
            ElseIf EsNewbie(TempCharIndex) Then
                Stat = "H0" & Stat
            ElseIf UserList(TempCharIndex).Faccion.Bando = Caos And UserList(TempCharIndex).flags.EsConseCaos = 1 Then
                Stat = "H2" & Stat
            ElseIf UserList(TempCharIndex).Faccion.Bando = Real And UserList(TempCharIndex).flags.EsConseReal = 1 Then
                Stat = "H1" & Stat
            ElseIf UserList(TempCharIndex).Faccion.Bando = Neutral And UserList(TempCharIndex).flags.EsConcilioNegro = 1 Then
                Stat = "3U" & Stat
            Else
                Stat = "1&" & Stat
            End If
        End If
        

If UserList(TempCharIndex).flags.EnDM = True Then
Stat = Stat & " [DEATHMATCH] [Kills: "
Stat = Stat & UserList(TempCharIndex).flags.DmKills
Stat = Stat & "] [Muertes: " & UserList(TempCharIndex).flags.DmMuertes & "]"
End If
  
 If UserList(TempCharIndex).Faccion.Matados(0) + UserList(TempCharIndex).Faccion.Matados(1) + UserList(TempCharIndex).Faccion.Matados(2) > 0 And Not UserList(TempCharIndex).flags.Privilegios > 0 Then
        Stat = Stat & " <Frags: " & UserList(TempCharIndex).Faccion.Matados(0) + UserList(TempCharIndex).Faccion.Matados(1) + UserList(TempCharIndex).Faccion.Matados(2) & ">"
    End If
 If UserList(TempCharIndex).Faccion.Matados(0) + UserList(TempCharIndex).Faccion.Matados(1) + UserList(TempCharIndex).Faccion.Matados(2) < 0 And Not UserList(TempCharIndex).flags.Privilegios > 0 Then
        Stat = Stat & " <Frags: " & UserList(TempCharIndex).Faccion.Matados(0) + UserList(TempCharIndex).Faccion.Matados(1) + UserList(TempCharIndex).Faccion.Matados(2) & ">"
    End If
 If UserList(TempCharIndex).flags.EsConseReal Then
        Stat = Stat & " <Consejo de Banderbill>"
    End If
 If UserList(TempCharIndex).flags.EsConseCaos Then
        Stat = Stat & " <Concilio de Arghal>"
    End If
 If UserList(TempCharIndex).flags.EsConcilioNegro Then
        Stat = Stat & " <Gladiador>"
    End If
  
 If UserList(TempCharIndex).flags.Templario = 1 And Not UserList(TempCharIndex).flags.Privilegios > 0 Then
 Stat = Stat & " <Templario>"
 End If
 
If UserList(TempCharIndex).flags.Privilegios = 1 Then
Stat = Stat & " <Soporte>"
ElseIf UserList(TempCharIndex).flags.Privilegios = 2 Then
Stat = Stat & " <Eventos>"
ElseIf UserList(TempCharIndex).flags.Privilegios = 3 Then
Stat = Stat & " <Administrador>"
ElseIf UserList(TempCharIndex).flags.Privilegios = 4 Then
Stat = Stat & " <SuperAdmin>"
End If

If TempCharIndex = GranPoder Then
Stat = Stat & " [Bendecido por los dioses]"
End If

If UserList(TempCharIndex).Stats.ELV > 5 Then ' mas de lvl 18
If UserList(TempCharIndex).PuestoEnTop < 5000 Then ' si no esta en minimo rank 250
If Not UserList(TempCharIndex).PuestoEnTop = 0 Then ' el puesto 0 no lo rankea porque no existe )? XD
Stat = Stat & " [Rank: " & UserList(TempCharIndex).PuestoEnTop & "]"
End If
End If
End If


        Call SendData(ToIndex, Userindex, 0, Stat)
        
        FoundSomething = 1
        UserList(Userindex).flags.TargetUser = TempCharIndex
        UserList(Userindex).flags.TargetNpc = 0
        UserList(Userindex).flags.TargetNpcTipo = 0
       
       
    ElseIf FoundChar = 2 Then
            
            Dim wPos As WorldPos
            wPos.Map = Map
            wPos.X = X
            wPos.y = y
            If Distancia(Npclist(TempCharIndex).POS, wPos) > 1 Then
                MapData(Map, X, y).NpcIndex = 0
                Exit Sub
            End If
                
            If Npclist(TempCharIndex).flags.TiendaUser Then
                If Userindex = Npclist(TempCharIndex).flags.TiendaUser Then
                    If UserList(Userindex).Tienda.Gold Then
                        Call SendData(ToIndex, Userindex, 0, "/O" & UserList(Userindex).Tienda.Gold & "," & Npclist(TempCharIndex).Char.CharIndex)
                    Else
                        Call SendData(ToIndex, Userindex, 0, "/P" & Npclist(TempCharIndex).Char.CharIndex)
                    End If
                Else
                    Call SendData(ToIndex, Userindex, 0, "/Q" & UserList(Npclist(TempCharIndex).flags.TiendaUser).Name & "," & Npclist(TempCharIndex).Char.CharIndex)
                End If
            ElseIf Len(Npclist(TempCharIndex).Desc) > 1 Then
                Call SendData(ToIndex, Userindex, 0, "3Q" & vbWhite & "°" & Npclist(TempCharIndex).Desc & "°" & Npclist(TempCharIndex).Char.CharIndex)
            ElseIf Npclist(TempCharIndex).MaestroUser Then
                Call SendData(ToIndex, Userindex, 0, "7Q" & Npclist(TempCharIndex).Name & "," & UserList(Npclist(TempCharIndex).MaestroUser).Name & "," & Npclist(TempCharIndex).Contadores.TiempoExistencia)
            ElseIf Npclist(TempCharIndex).AutoCurar = 1 Then
                Call SendData(ToIndex, Userindex, 0, "8Q" & Npclist(TempCharIndex).Name)
            Else
                Call SendNPC(Userindex, TempCharIndex)
            End If
            FoundSomething = 1
            UserList(Userindex).flags.TargetNpcTipo = Npclist(TempCharIndex).NPCtype
            UserList(Userindex).flags.TargetNpc = TempCharIndex
            UserList(Userindex).flags.TargetUser = 0
            UserList(Userindex).flags.TargetObj = 0
    End If
    
    If FoundChar = 0 Then
        UserList(Userindex).flags.TargetNpc = 0
        UserList(Userindex).flags.TargetNpcTipo = 0
        UserList(Userindex).flags.TargetUser = 0
    End If
    
    If FoundSomething = 0 Then
        UserList(Userindex).flags.TargetNpc = 0
        UserList(Userindex).flags.TargetNpcTipo = 0
        UserList(Userindex).flags.TargetUser = 0
        UserList(Userindex).flags.TargetObj = 0
        UserList(Userindex).flags.TargetObjMap = 0
        UserList(Userindex).flags.TargetObjX = 0
        UserList(Userindex).flags.TargetObjY = 0
    End If

Else
    If FoundSomething = 0 Then
        UserList(Userindex).flags.TargetNpc = 0
        UserList(Userindex).flags.TargetNpcTipo = 0
        UserList(Userindex).flags.TargetUser = 0
        UserList(Userindex).flags.TargetObj = 0
        UserList(Userindex).flags.TargetObjMap = 0
        UserList(Userindex).flags.TargetObjX = 0
        UserList(Userindex).flags.TargetObjY = 0
    End If
End If

End Sub
Function FindDirection(POS As WorldPos, Target As WorldPos) As Byte
Dim X As Integer, y As Integer

X = POS.X - Target.X
y = POS.y - Target.y

If Sgn(X) = -1 And Sgn(y) = 1 Then
    FindDirection = NORTH
    Exit Function
End If

If Sgn(X) = 1 And Sgn(y) = 1 Then
    FindDirection = WEST
    Exit Function
End If

If Sgn(X) = 1 And Sgn(y) = -1 Then
    FindDirection = WEST
    Exit Function
End If

If Sgn(X) = -1 And Sgn(y) = -1 Then
    FindDirection = SOUTH
    Exit Function
End If

If Sgn(X) = 0 And Sgn(y) = -1 Then
    FindDirection = SOUTH
    Exit Function
End If

If Sgn(X) = 0 And Sgn(y) = 1 Then
    FindDirection = NORTH
    Exit Function
End If

If Sgn(X) = 1 And Sgn(y) = 0 Then
    FindDirection = WEST
    Exit Function
End If

If Sgn(X) = -1 And Sgn(y) = 0 Then
    FindDirection = EAST
    Exit Function
End If

If Sgn(X) = 0 And Sgn(y) = 0 Then
    FindDirection = 0
    Exit Function
End If

End Function
Public Function ItemEsDeMapa(ByVal Map As Integer, X As Integer, y As Integer) As Boolean

ItemEsDeMapa = ObjData(MapData(Map, X, y).OBJInfo.OBJIndex).Agarrable Or MapData(Map, X, y).Blocked

End Function

Sub PasarSegundo()
Dim Mapa As Integer
Dim X As Integer
Dim y As Integer
Dim i As Integer
 
'listo, fijate si asi anda...
 
 
       
For i = 1 To LastUser
   Mapa = UserList(i).flags.DondeTiroMap
X = UserList(i).flags.DondeTiroX
y = UserList(i).flags.DondeTiroY
    If UserList(i).Counters.CreoTeleport = True Then  'si el usuario creo un teleport....
        UserList(i).Counters.TimeTeleport = UserList(i).Counters.TimeTeleport + 1 'sumamos 1 cont
 
        If UserList(i).Counters.TimeTeleport = 3 Then 'cuando llega a 3
            Call EraseObj(ToMap, 0, UserList(i).flags.DondeTiroMap, MapData(UserList(i).flags.DondeTiroMap, UserList(i).flags.DondeTiroX, UserList(i).flags.DondeTiroY).OBJInfo.Amount, UserList(i).flags.DondeTiroMap, UserList(i).flags.DondeTiroX, UserList(i).flags.DondeTiroY) 'verificamos que destruye el objeto anterior.
            Dim ET As Obj
            ET.Amount = 1
            ET.OBJIndex = Teleport 'Acá se puede cambiar por su telep personalizado
                       
            Call MakeObj(ToMap, 0, UserList(i).POS.Map, ET, UserList(i).flags.DondeTiroMap, UserList(i).flags.DondeTiroX, UserList(i).flags.DondeTiroY)
            MapData(UserList(i).POS.Map, UserList(i).flags.DondeTiroX, UserList(i).flags.DondeTiroY).TileExit.Map = 1 'llevams a ulla
            MapData(UserList(i).POS.Map, UserList(i).flags.DondeTiroX, UserList(i).flags.DondeTiroY).TileExit.X = 50
            MapData(UserList(i).POS.Map, UserList(i).flags.DondeTiroX, UserList(i).flags.DondeTiroY).TileExit.y = 50
        ElseIf UserList(i).Counters.TimeTeleport >= 10 Then
            UserList(i).flags.TiroPortalL = 0
            UserList(i).Counters.TimeTeleport = 0
            UserList(i).Counters.CreoTeleport = False
            Call EraseObj(ToMap, 0, UserList(i).flags.DondeTiroMap, MapData(UserList(i).flags.DondeTiroMap, UserList(i).flags.DondeTiroX, UserList(i).flags.DondeTiroY).OBJInfo.Amount, UserList(i).flags.DondeTiroMap, UserList(i).flags.DondeTiroX, UserList(i).flags.DondeTiroY) 'verificamos que destruye el objeto anterior.
            MapData(Mapa, X, y).TileExit.Map = 0
            MapData(Mapa, X, y).TileExit.X = 0
            MapData(Mapa, X, y).TileExit.y = 0
            
        End If
    End If
 
Next i
 
End Sub


