Attribute VB_Name = "Acciones"
 
'director del proyecto: #Esteban(Neliam)

'servidor basado en fénixao 1.0
'medios de contacto:
'Skype: dc.esteban
'E-mail: nabrianao@gmail.com
Public Cruz As Integer
Public Gema As Integer
Public ObjSlot1 As Byte
Public ObjSlot2 As Byte
Option Explicit
Sub ExtraObjs()

Cruz = UBound(ObjData) - 1
ObjData(Cruz).Name = "Cruz del Sacrificio"
ObjData(Cruz).GrhIndex = 116

Gema = UBound(ObjData)
ObjData(Gema).Name = "Piedra filosofal incompleta"
ObjData(Gema).GrhIndex = 705

End Sub
Public Sub DragObjects(Userindex As Integer, Item1 As Byte, Item2 As Byte)
Dim tObj As UserOBJ
Dim tObj2 As UserOBJ

tObj = UserList(Userindex).Invent.Object(Item1)
tObj2 = UserList(Userindex).Invent.Object(Item2)

UserList(Userindex).Invent.Object(Item1) = tObj2
UserList(Userindex).Invent.Object(Item2) = tObj

If tObj.Equipped = 1 Then
    Select Case ObjData(tObj.OBJIndex).ObjType
        Case OBJTYPE_WEAPON
            UserList(Userindex).Invent.WeaponEqpSlot = Item2
        Case OBJTYPE_HERRAMIENTAS
            UserList(Userindex).Invent.HerramientaEqpslot = Item2
        Case OBJTYPE_BARCOS
            UserList(Userindex).Invent.BarcoSlot = Item2
        Case OBJTYPE_ARMOUR
            Select Case ObjData(tObj.OBJIndex).SubTipo
                Case OBJTYPE_CASCO
                    UserList(Userindex).Invent.CascoEqpSlot = Item2
                Case OBJTYPE_ARMADURA
                    UserList(Userindex).Invent.ArmourEqpSlot = Item2
                Case OBJTYPE_ESCUDO
                    UserList(Userindex).Invent.EscudoEqpSlot = Item2
            End Select
        Case OBJTYPE_FLECHAS
            UserList(Userindex).Invent.MunicionEqpSlot = Item2
    End Select
End If

If tObj2.Equipped = 1 Then
    Select Case ObjData(tObj2.OBJIndex).ObjType
        Case OBJTYPE_WEAPON
            UserList(Userindex).Invent.WeaponEqpSlot = Item1
        Case OBJTYPE_HERRAMIENTAS
            UserList(Userindex).Invent.HerramientaEqpslot = Item1
        Case OBJTYPE_BARCOS
            UserList(Userindex).Invent.BarcoSlot = Item1
        Case OBJTYPE_ARMOUR
            Select Case ObjData(tObj2.OBJIndex).SubTipo
                Case OBJTYPE_CASCO
                    UserList(Userindex).Invent.CascoEqpSlot = Item1
                Case OBJTYPE_ARMADURA
                    UserList(Userindex).Invent.ArmourEqpSlot = Item1
                Case OBJTYPE_ESCUDO
                    UserList(Userindex).Invent.EscudoEqpSlot = Item1
            End Select
        Case OBJTYPE_FLECHAS
            UserList(Userindex).Invent.MunicionEqpSlot = Item1
    End Select
End If

Call UpdateUserInv(False, Userindex, Item1)
Call UpdateUserInv(False, Userindex, Item2)

End Sub
Sub Accion(Userindex As Integer, Map As Integer, X As Integer, y As Integer)
On Error Resume Next

If Not InMapBounds(X, y) Then Exit Sub
   
Dim FoundChar As Byte
Dim FoundSomething As Byte
Dim TempCharIndex As Integer

If MapData(Map, X, y).NpcIndex Then
        If Distancia(Npclist(UserList(Userindex).flags.TargetNpc).POS, UserList(Userindex).POS) > 10 Then
            'Call SendData(ToIndex, Userindex, 0, "DL")
            Exit Sub
        End If
        
    If Npclist(MapData(Map, X, y).NpcIndex).NPCtype = NPCTYPE_REVIVIR Then
        If UserList(Userindex).flags.Muerto Then
            Call RevivirUsuarioNPC(Userindex)
            Call SendData(ToIndex, Userindex, 0, "RZ")
            Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "CFX" & UserList(Userindex).Char.CharIndex & "," & UserList(Userindex).Char.CharIndex & "," & 41 & "," & 0 & "," & 0) 'dx8
            Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "TW111") 'Sonido
            Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "TWresucitanpc")  'Sonido
           
        Else
            If UserList(Userindex).Stats.MinHP = UserList(Userindex).Stats.MaxHP Then Exit Sub
            Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "CFX" & UserList(Userindex).Char.CharIndex & "," & UserList(Userindex).Char.CharIndex & "," & 41 & "," & 0 & "," & 0) 'dx8
            Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "TW111") 'Sonido
            UserList(Userindex).Stats.MinHP = UserList(Userindex).Stats.MaxHP
            Call SendUserHP(Userindex)
        End If
        Exit Sub
        
    End If
    
    If UserList(Userindex).flags.Muerto Then
        Call SendData(ToIndex, Userindex, 0, "MU")
        Exit Sub
    End If
    
    If Npclist(MapData(Map, X, y).NpcIndex).NPCtype = NPCTYPE_mision Then
    
     If UserList(Userindex).flags.Mision = 10 Then
     Call SendData(ToIndex, Userindex, 0, "||Ya eres templario." & FONTTYPE_WARNING)
     Exit Sub
     End If
    
     If TieneObjetos(855, 1, Userindex) Then
     Call SendData(ToIndex, Userindex, 0, "HUMDS" & "Tienes el Anillo de los Dioses Templarios, puedes pasar esta misión se anulara y pasaras a la siguiente.")
     Exit Sub
     End If
    
     If UserList(Userindex).Stats.ELV < STAT_MAXELV Then
     Call SendData(ToIndex, Userindex, 0, "||Para comenzar a hacer las misiones de templario necesitas ser nivel maximo." & FONTTYPE_INFO)
     Exit Sub
     End If
    
        If UserList(Userindex).flags.Templario = 0 Then
        If UserList(Userindex).flags.Mision = 0 Then
        Call SendData(ToIndex, Userindex, 0, "HUMDS" & "Tráeme 10 Cadávers de esqueleto, puedes conseguirlos matando Esqueletos en las afueras del bosque, la probabilidad de dropeo es de 90%")
        ElseIf UserList(Userindex).flags.Mision = 1 Then
        Call SendData(ToIndex, Userindex, 0, "HUMDS" & "Tráeme 10 Rubis de globin, puedes conseguirlos matando Globins en las afueras del bosque, la probabilidad de dropeo es de 80%")
        ElseIf UserList(Userindex).flags.Mision = 2 Then
        Call SendData(ToIndex, Userindex, 0, "HUMDS" & "Tráeme 10 Anillos Amarillos, puedes conseguirlos matando Lord Orcos, la probabilidad de dropeo es de 75%")
        ElseIf UserList(Userindex).flags.Mision = 3 Then
        Call SendData(ToIndex, Userindex, 0, "HUMDS" & "Tráeme 10 Collares de joyas, puedes conseguirlos matando Leviatánes en las aguas del mundo, la probabilidad de dropeo es de 70%")
        ElseIf UserList(Userindex).flags.Mision = 4 Then
        Call SendData(ToIndex, Userindex, 0, "HUMDS" & "Tráeme 10 Anillos de momia, puedes conseguirlos matando Momias, la probabilidad de dropeo es de %60")
        ElseIf UserList(Userindex).flags.Mision = 5 Then
        Call SendData(ToIndex, Userindex, 0, "HUMDS" & "Tráeme 216 Anillos de orco, puedes conseguirlos matando Rey Orcos, la probabilidad de dropeo es de 55%")
        ElseIf UserList(Userindex).flags.Mision = 6 Then
        Call SendData(ToIndex, Userindex, 0, "HUMDS" & "Tráeme 10 Anillos de Acólito, puedes conseguirlos matando Acólitos, la probabilidad de dropeo es de 50%, Extra: 500.000 Monedas de oro.")
        ElseIf UserList(Userindex).flags.Mision = 7 Then
        Call SendData(ToIndex, Userindex, 0, "HUMDS" & "Tráeme 15 Rubi de Oro, puedes conseguirlos matando Golems de Oro, la probabilidad de dropeo es de 40%, Extra: 3.000.000 Monedas de oro.")
        ElseIf UserList(Userindex).flags.Mision = 8 Then
        Call SendData(ToIndex, Userindex, 0, "HUMDS" & "Tráeme 15 Anillo del Drágon Azul, puedes conseguirlos matando Gran Drágones azules, la probabilidad de dropeo es de 20%, Extra: 5.000.000 Monedas de oro.")
        ElseIf UserList(Userindex).flags.Mision = 9 Then
        Call SendData(ToIndex, Userindex, 0, "HUMDS" & "Tráeme 20 Anillos de Rey Drágon, puedes conseguirlos matando Rey Drágones, la probabilidad de dropeo es de 5%, Extra: 1 torneos Ganados, 2 quest y 5.000.000 Monedas de oro.")
        End If
        End If
        Exit Sub
    End If

    If Npclist(MapData(Map, X, y).NpcIndex).NPCtype = NPCTYPE_BANQUERO Then
        Call IniciarDeposito(Userindex)
        Exit Sub
    End If
    
    If Npclist(MapData(Map, X, y).NpcIndex).NPCtype = NPCTYPE_DM Then
    Call SendData(ToIndex, Userindex, 0, "SHWDM")
        Exit Sub
    End If
    
    If Npclist(MapData(Map, X, y).NpcIndex).NPCtype = NPCTYPE_SACRI Then
    COMANDOS.PENDIENTEDESACRI (Userindex)
        Exit Sub
    End If
    
    If Npclist(MapData(Map, X, y).NpcIndex).NPCtype = NPCTYPE_AMULETO Then
    COMANDOS.AMULETOULTATUMBA (Userindex)
        Exit Sub
    End If
    
    If Npclist(MapData(Map, X, y).NpcIndex).NPCtype = NPCTYPE_QUEST Then
    If UserList(Userindex).flags.Privilegios = 1 Or UserList(Userindex).flags.Privilegios = 2 Or UserList(Userindex).flags.Privilegios = 3 Then Exit Sub
    Call SendData(ToIndex, Userindex, 0, "DAMEQUEST")
        Exit Sub
    End If
    
    If Npclist(MapData(Map, X, y).NpcIndex).NPCtype = NPCTYPE_TIENDA Then
        If Npclist(MapData(Map, X, y).NpcIndex).flags.TiendaUser > 0 And Npclist(MapData(Map, X, y).NpcIndex).flags.TiendaUser <> Userindex Then
            Call IniciarComercioTienda(Userindex, MapData(Map, X, y).NpcIndex)
        Else
            Call IniciarAlquiler(Userindex)
        End If
        Exit Sub
    End If
    
    If Npclist(MapData(Map, X, y).NpcIndex).Comercia Then
        Call IniciarComercioNPC(Userindex)
        Exit Sub
    End If
    
    If Npclist(MapData(Map, X, y).NpcIndex).flags.Apostador Then
        UserList(Userindex).flags.MesaCasino = Npclist(MapData(Map, X, y).NpcIndex).flags.Apostador
        Call SendData(ToIndex, Userindex, 0, "ABRU" & UserList(Userindex).flags.MesaCasino)
        Exit Sub
    End If
    
    If Npclist(MapData(Map, X, y).NpcIndex).NPCtype = NPCTYPE_ENTRENADOR Then
        Call EnviarListaCriaturas(Userindex, UserList(Userindex).flags.TargetNpc)
        Exit Sub
    End If
    
    If Npclist(MapData(Map, X, y).NpcIndex).NPCtype = NPCTYPE_VIEJO Then
        If (UserList(Userindex).Stats.ELV >= 40 And UserList(Userindex).Stats.RecompensaLevel <= 2) Then
            If Distancia(Npclist(UserList(Userindex).flags.TargetNpc).POS, UserList(Userindex).POS) > 4 Then
                Call SendData(ToIndex, Userindex, 0, "DL")
                Exit Sub
            End If
        End If
        If Not ClaseBase(UserList(Userindex).Clase) And Not ClaseTrabajadora(UserList(Userindex).Clase) And UserList(Userindex).Clase <= GUERRERO Then
            Call SendData(ToIndex, Userindex, 0, "RELOM" & UserList(Userindex).Clase & "," & UserList(Userindex).Stats.RecompensaLevel)
            Exit Sub
        End If
    End If

    If Npclist(MapData(Map, X, y).NpcIndex).NPCtype = NPCTYPE_NOBLE Then
        If ClaseBase(UserList(Userindex).Clase) Or ClaseTrabajadora(UserList(Userindex).Clase) Then Exit Sub
    
        If UserList(Userindex).Faccion.Bando <> Npclist(UserList(Userindex).flags.TargetNpc).flags.Faccion Then
            Call SendData(ToIndex, Userindex, 0, Mensajes(Npclist(UserList(Userindex).flags.TargetNpc).flags.Faccion, 16) & str(Npclist(UserList(Userindex).flags.TargetNpc).Char.CharIndex))
            Exit Sub
        End If
        
        If UserList(Userindex).Faccion.Jerarquia = 0 Then
            Call Enlistar(Userindex, Npclist(UserList(Userindex).flags.TargetNpc).flags.Faccion)
        Else
            Call Recompensado(Userindex)
        End If
        
        Exit Sub
    End If
End If

If MapData(Map, X, y).Userindex > 0 And UserList(Userindex).flags.Privilegios > 1 Then
            UserList(Userindex).flags.TargetUser = MapData(Map, X, y).Userindex
            If UserList(UserList(Userindex).flags.TargetUser).flags.Muerto = 1 Then
                Call RevivirUsuarioNPC(UserList(Userindex).flags.TargetUser)
                Call SendData(ToIndex, MapData(Map, X, y).Userindex, 0, "||" & UserList(Userindex).Name & " te ha resucitado." & FONTTYPE_INFO)
                Call SendData(ToIndex, Userindex, 0, "||Has resucitado al usuario: " & UserList(UserList(Userindex).flags.TargetUser).Name & FONTTYPE_INFO)
                Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "TW111")  'Sonido
            End If
        End If


If MapData(Map, X, y).OBJInfo.OBJIndex Then
    UserList(Userindex).flags.TargetObj = MapData(Map, X, y).OBJInfo.OBJIndex
    
    Select Case ObjData(MapData(Map, X, y).OBJInfo.OBJIndex).ObjType
        
        Case OBJTYPE_PUERTAS
            Call AccionParaPuerta(Map, X, y, Userindex)
        Case OBJTYPE_CARTELES
            Call AccionParaCartel(Map, X, y, Userindex)
        Case OBJTYPE_FOROS
            Call AccionParaForo(Map, X, y, Userindex)
        Case OBJTYPE_LEÑA
            If MapData(Map, X, y).OBJInfo.OBJIndex = FOGATA_APAG Then
                Call AccionParaRamita(Map, X, y, Userindex)
            End If
        Case OBJTYPE_ARBOLES
            Call AccionParaArbol(Map, X, y, Userindex)
        
    End Select

ElseIf MapData(Map, X + 1, y).OBJInfo.OBJIndex Then
    UserList(Userindex).flags.TargetObj = MapData(Map, X + 1, y).OBJInfo.OBJIndex
    Call SendData(ToIndex, Userindex, 0, "SELE" & ObjData(MapData(Map, X + 1, y).OBJInfo.OBJIndex).ObjType & "," & ObjData(MapData(Map, X + 1, y).OBJInfo.OBJIndex).Name & "," & "OBJ")
    Select Case ObjData(MapData(Map, X + 1, y).OBJInfo.OBJIndex).ObjType
        
        Case 6
            Call AccionParaPuerta(Map, X + 1, y, Userindex)
        
    End Select
ElseIf MapData(Map, X + 1, y + 1).OBJInfo.OBJIndex Then
    UserList(Userindex).flags.TargetObj = MapData(Map, X + 1, y + 1).OBJInfo.OBJIndex
    Call SendData(ToIndex, Userindex, 0, "SELE" & ObjData(MapData(Map, X + 1, y + 1).OBJInfo.OBJIndex).ObjType & "," & ObjData(MapData(Map, X + 1, y + 1).OBJInfo.OBJIndex).Name & "," & "OBJ")
    Select Case ObjData(MapData(Map, X + 1, y + 1).OBJInfo.OBJIndex).ObjType
        
        Case 6
            Call AccionParaPuerta(Map, X + 1, y + 1, Userindex)
        
    End Select
ElseIf MapData(Map, X, y + 1).OBJInfo.OBJIndex Then
    UserList(Userindex).flags.TargetObj = MapData(Map, X, y + 1).OBJInfo.OBJIndex
    Call SendData(ToIndex, Userindex, 0, "SELE" & ObjData(MapData(Map, X, y + 1).OBJInfo.OBJIndex).ObjType & "," & ObjData(MapData(Map, X, y + 1).OBJInfo.OBJIndex).Name & "," & "OBJ")
    Select Case ObjData(MapData(Map, X, y + 1).OBJInfo.OBJIndex).ObjType
        
        Case 6
            Call AccionParaPuerta(Map, X, y + 1, Userindex)
        
    End Select
    
Else
    UserList(Userindex).flags.TargetNpc = 0
    UserList(Userindex).flags.TargetNpcTipo = 0
    UserList(Userindex).flags.TargetUser = 0
    UserList(Userindex).flags.TargetObj = 0
End If

If MapData(Map, X, y).Agua = 1 Then Call AccionParaAgua(Map, X, y, Userindex)

'menu user
If y + 1 <= YMaxMapSize Then
        If MapData(Map, X, y + 1).Userindex > 0 Then
            TempCharIndex = MapData(Map, X, y + 1).Userindex
            If UserList(TempCharIndex).Name Then
                FoundChar = 1
            End If
        End If
        If MapData(Map, X, y + 1).NpcIndex > 0 Then
            TempCharIndex = MapData(Map, X, y + 1).NpcIndex
            FoundChar = 2
        End If
    End If
 
    If FoundChar = 0 Then
        If MapData(Map, X, y).Userindex > 0 Then
            TempCharIndex = MapData(Map, X, y).Userindex
            If UserList(TempCharIndex).Name Then
                FoundChar = 1
            End If
        End If
        If MapData(Map, X, y).NpcIndex > 0 Then
            TempCharIndex = MapData(Map, X, y).NpcIndex
            FoundChar = 2
        End If
    End If
   
    If FoundChar = 1 Then '
    FoundSomething = 1
            UserList(Userindex).flags.TargetUser = TempCharIndex
            UserList(Userindex).flags.TargetNpc = 0
            
        End If
End Sub
Sub AccionParaRamita(Map As Integer, X As Integer, y As Integer, Userindex As Integer)
On Error Resume Next
Dim Suerte As Byte
Dim exito As Byte
Dim Obj As Obj
Dim raise As Integer, nPos As WorldPos

nPos.Map = Map
nPos.X = X
nPos.y = y

If Distancia(nPos, UserList(Userindex).POS) > 4 Then
    Call SendData(ToIndex, Userindex, 0, "DL")
    Exit Sub
End If

If UserList(Userindex).Stats.UserSkills(Supervivencia) > 1 And UserList(Userindex).Stats.UserSkills(Supervivencia) < 6 Then
    Suerte = 3
ElseIf UserList(Userindex).Stats.UserSkills(Supervivencia) >= 6 And UserList(Userindex).Stats.UserSkills(Supervivencia) <= 10 Then
    Suerte = 2
ElseIf UserList(Userindex).Stats.UserSkills(Supervivencia) >= 10 And UserList(Userindex).Stats.UserSkills(Supervivencia) Then
    Suerte = 1
End If

exito = RandomNumber(1, Suerte)

If exito = 1 Then
    Obj.OBJIndex = FOGATA
    Obj.Amount = 1
    
    Call SendData(ToIndex, Userindex, 0, "7O")
    Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "FO")
    
    Call MakeObj(ToMap, 0, Map, Obj, Map, X, y)
    
    
Else
    Call SendData(ToIndex, Userindex, 0, "8O")
End If


If UserList(Userindex).flags.Hambre = 0 And UserList(Userindex).flags.Sed = 0 Then
    Call SubirSkill(Userindex, Supervivencia)
End If

End Sub
Sub AccionParaAgua(Map As Integer, X As Integer, y As Integer, Userindex As Integer)

If MapData(Map, X, y).Agua = 0 Then Exit Sub

If UserList(Userindex).Stats.UserSkills(Supervivencia) >= 75 And UserList(Userindex).Stats.MinAGU < UserList(Userindex).Stats.MaxAGU Then
    If UserList(Userindex).flags.Muerto Then
        Call SendData(ToIndex, Userindex, 0, "MU")
        Exit Sub
    End If
    UserList(Userindex).Stats.MinAGU = Minimo(UserList(Userindex).Stats.MinAGU + 10, UserList(Userindex).Stats.MaxAGU)
    UserList(Userindex).flags.Sed = 0
    Call SubirSkill(Userindex, Supervivencia, 75)
    Call SendData(ToIndex, Userindex, 0, "||Has tomado del agua del mar." & FONTTYPE_INFO)
    Call SendData(ToPCArea, Userindex, 0, "TW46")
    Call EnviarHyS(Userindex)
End If
    
End Sub
Sub AccionParaArbol(Map As Integer, X As Integer, y As Integer, Userindex As Integer)

If MapData(Map, X, y).OBJInfo.OBJIndex = 0 Then Exit Sub
If ObjData(MapData(Map, X, y).OBJInfo.OBJIndex).ObjType <> OBJTYPE_ARBOLES Then Exit Sub

If UserList(Userindex).Stats.UserSkills(Supervivencia) >= 85 And UserList(Userindex).Stats.MinHam < UserList(Userindex).Stats.MaxHam Then
    If UserList(Userindex).flags.Muerto Then
        Call SendData(ToIndex, Userindex, 0, "MU")
        Exit Sub
    End If
    UserList(Userindex).Stats.MinHam = Minimo(UserList(Userindex).Stats.MinHam + 10, UserList(Userindex).Stats.MaxHam)
    UserList(Userindex).flags.Hambre = 0
    Call SubirSkill(Userindex, Supervivencia, 75)
    Call SendData(ToIndex, Userindex, 0, "||Has comido de los frutos del árbol." & FONTTYPE_INFO)
    Call SendData(ToPCArea, Userindex, 0, "TW7")
    Call EnviarHyS(Userindex)
End If

End Sub
Sub AccionParaForo(Map As Integer, X As Integer, y As Integer, Userindex As Integer)
On Error Resume Next


Dim f As String, tit As String, men As String, Base As String, auxcad As String
f = App.Path & "\foros\" & UCase$(ObjData(MapData(Map, X, y).OBJInfo.OBJIndex).ForoID) & ".for"
If FileExist(f, vbNormal) Then
    Dim Num As Integer
    Num = val(GetVar(f, "INFO", "CantMSG"))
    Base = Left$(f, Len(f) - 4)
    Dim i As Integer
    Dim N As Integer
    For i = 1 To Num
        N = FreeFile
        f = Base & i & ".for"
        Open f For Input Shared As #N
        Input #N, tit
        men = ""
        auxcad = ""
        Do While Not EOF(N)
            Input #N, auxcad
            men = men & vbCrLf & auxcad
        Loop
        Close #N
        Call SendData(ToIndex, Userindex, 0, "FMSG" & tit & Chr$(176) & men)
        
    Next
End If
Call SendData(ToIndex, Userindex, 0, "MFOR")
End Sub


Sub AccionParaPuerta(Map As Integer, X As Integer, y As Integer, Userindex As Integer)
On Error Resume Next

Dim MiObj As Obj
Dim wp As WorldPos

If Not (Distance(UserList(Userindex).POS.X, UserList(Userindex).POS.y, X, y) > 2) Then
    If ObjData(MapData(Map, X, y).OBJInfo.OBJIndex).Llave = 0 Then
        If ObjData(MapData(Map, X, y).OBJInfo.OBJIndex).Cerrada Then
                
                If ObjData(MapData(Map, X, y).OBJInfo.OBJIndex).Llave = 0 Then
                          
                     MapData(Map, X, y).OBJInfo.OBJIndex = ObjData(MapData(Map, X, y).OBJInfo.OBJIndex).IndexAbierta
                                  
                     Call MakeObj(ToMap, 0, Map, MapData(Map, X, y).OBJInfo, Map, X, y)
                     
                     
                     MapData(Map, X, y).Blocked = 0
                     MapData(Map, X - 1, y).Blocked = 0
                     
                     
                     Call Bloquear(ToMap, 0, Map, Map, X, y, 0)
                     Call Bloquear(ToMap, 0, Map, Map, X - 1, y, 0)
                     
                       
                     
                     SendData ToPCArea, Userindex, UserList(Userindex).POS.Map, "TW" & SND_PUERTA
                    
                Else
                     Call SendData(ToIndex, Userindex, 0, "9O")
                End If
        Else
                
                MapData(Map, X, y).OBJInfo.OBJIndex = ObjData(MapData(Map, X, y).OBJInfo.OBJIndex).IndexCerrada
                
                Call MakeObj(ToMap, 0, Map, MapData(Map, X, y).OBJInfo, Map, X, y)
                
                
                MapData(Map, X, y).Blocked = 1
                MapData(Map, X - 1, y).Blocked = 1
                
                
                Call Bloquear(ToMap, 0, Map, Map, X - 1, y, 1)
                Call Bloquear(ToMap, 0, Map, Map, X, y, 1)
                
                SendData ToPCArea, Userindex, UserList(Userindex).POS.Map, "TW" & SND_PUERTA
        End If
        
        UserList(Userindex).flags.TargetObj = MapData(Map, X, y).OBJInfo.OBJIndex
    Else
        Call SendData(ToIndex, Userindex, 0, "9O")
    
    End If
Else
    Call SendData(ToIndex, Userindex, 0, "DL")
End If

End Sub
Sub AccionParaCartel(Map As Integer, X As Integer, y As Integer, Userindex As Integer)
On Error Resume Next

Dim MiObj As Obj

If ObjData(MapData(Map, X, y).OBJInfo.OBJIndex).ObjType = 8 Then
  
  If Len(ObjData(MapData(Map, X, y).OBJInfo.OBJIndex).Texto) > 0 Then
       Call SendData(ToIndex, Userindex, 0, "MCAR" & _
        ObjData(MapData(Map, X, y).OBJInfo.OBJIndex).Texto & _
        Chr$(176) & ObjData(MapData(Map, X, y).OBJInfo.OBJIndex).GrhSecundario)
  End If
  
End If

End Sub
Sub OtorgarGranPoder(Userindex As Integer)
On Error Resume Next
Dim loopc As Integer
Dim EncontroIdeal As Boolean
If GRANPODERActivado = True Then
If LastUser = 0 Then Exit Sub
If Userindex = 0 Then
    Do While EncontroIdeal = False And loopc < 500
        loopc = loopc + 1
        Userindex = RandomNumber(1, LastUser)
        
         If NumUsers = 0 Or NumUsers = 1 Or NumUsers = 2 Or NumUsers = 3 Or NumUsers = 4 Or NumUsers = 5 Or NumUsers = 6 Or NumUsers = 7 Or NumUsers = 8 Or NumUsers = 9 Or NumUsers = 10 Or NumUsers = 11 Or NumUsers = 12 Or NumUsers = 13 Or NumUsers = 14 Or NumUsers = 15 Then
         GranPoder = 0
         Userindex = 0
         Exit Sub
         End If
          
        If MapInfo(UserList(Userindex).POS.Map).EsMapaEspecial Then
           GranPoder = 0
           Userindex = 0
           Exit Sub
        End If

           
        If UserList(Userindex).flags.UserLogged = True And UserList(Userindex).flags.Muerto = 0 And UserList(Userindex).flags.Privilegios = 0 Then
            EncontroIdeal = True
            Exit Do
        End If
     
    Loop
    If Not EncontroIdeal Then
        Userindex = 0
        GranPoder = 0
    End If
    End If
    If Userindex > 0 Then
    If UserList(Userindex).flags.Muerto <> 0 Then Call OtorgarGranPoder(0)
    GranPoder = Userindex
    
    Call SendData(ToAll, Userindex, 0, "||Poder> Los dioses le otorgan el Gran Poder a " & UserList(Userindex).Name & " en el mapa " & UserList(Userindex).POS.Map & "." & FONTTYPE_PODER)
End If
End If
End Sub
Sub OtorgarGranPoder2(Userindex As Integer)
On Error Resume Next
If GRANPODERActivado = True Then
If NumUsers = 0 Or NumUsers = 1 Or NumUsers = 2 Or NumUsers = 3 Or NumUsers = 4 Or NumUsers = 5 Or NumUsers = 6 Or NumUsers = 7 Or NumUsers = 8 Or NumUsers = 9 Or NumUsers = 10 Or NumUsers = 11 Or NumUsers = 12 Or NumUsers = 13 Or NumUsers = 14 Or NumUsers = 15 Then
Call SendData(ToIndex, Userindex, 0, "||Poder> Hay menos de 15 usuarios conectados no se te otorgara el Gran Poder." & FONTTYPE_PODER)
GranPoder = 0
Exit Sub
End If

If MapInfo(UserList(Userindex).POS.Map).EsMapaEspecial Then
            GranPoder = 0
           Exit Sub
        End If

    GranPoder = Userindex
End If
End Sub
