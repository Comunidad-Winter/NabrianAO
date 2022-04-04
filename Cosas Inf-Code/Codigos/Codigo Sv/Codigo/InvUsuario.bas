Attribute VB_Name = "InvUsuario"
 
'director del proyecto: #Esteban(Neliam)

'servidor basado en fénixao 1.0
'medios de contacto:
'Skype: dc.esteban
'E-mail: nabrianao@gmail.com
Option Explicit
Public Sub AcomodarItems(Userindex As Integer, Item1 As Byte, Item2 As Byte)
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

Public Sub CalcularSta(Userindex As Integer)

Select Case UserList(Userindex).Clase
    Case CIUDADANO, TRABAJADOR, EXPERTO_MINERALES
        UserList(Userindex).Stats.MaxSta = 15 * UserList(Userindex).Stats.ELV
    Case MINERO
        UserList(Userindex).Stats.MaxSta = (15 + AdicionalSTMinero) * UserList(Userindex).Stats.ELV
    Case HERRERO
        UserList(Userindex).Stats.MaxSta = 15 * UserList(Userindex).Stats.ELV
    Case TALADOR
        UserList(Userindex).Stats.MaxSta = (15 + AdicionalSTLeñador) * UserList(Userindex).Stats.ELV
    Case CARPINTERO
        UserList(Userindex).Stats.MaxSta = 15 * UserList(Userindex).Stats.ELV
    Case PESCADOR
        UserList(Userindex).Stats.MaxSta = (15 + AdicionalSTPescador) * UserList(Userindex).Stats.ELV
    Case Is <= 37
        UserList(Userindex).Stats.MaxSta = 15 * UserList(Userindex).Stats.ELV
    Case MAGO, NIGROMANTE
        UserList(Userindex).Stats.MaxSta = (15 - AdicionalSTLadron / 2) * UserList(Userindex).Stats.ELV
    Case Else
        UserList(Userindex).Stats.MaxSta = 15 * UserList(Userindex).Stats.ELV
End Select

UserList(Userindex).Stats.MaxSta = 60 + UserList(Userindex).Stats.MaxSta
UserList(Userindex).Stats.MinSta = Minimo(UserList(Userindex).Stats.MinSta, UserList(Userindex).Stats.MaxSta)

End Sub
Public Sub VerObjetosEquipados(Userindex As Integer)

With UserList(Userindex).Invent
    If .CascoEqpSlot Then
        .Object(.CascoEqpSlot).Equipped = 1
        .CascoEqpObjIndex = .Object(.CascoEqpSlot).OBJIndex
        UserList(Userindex).Char.CascoAnim = ObjData(.CascoEqpObjIndex).CascoAnim
    Else
        UserList(Userindex).Char.CascoAnim = NingunCasco
    End If
    
    If .BarcoSlot Then .BarcoObjIndex = .Object(.BarcoSlot).OBJIndex
    
    If .ArmourEqpSlot Then
        .Object(.ArmourEqpSlot).Equipped = 1
        .ArmourEqpObjIndex = .Object(.ArmourEqpSlot).OBJIndex
        UserList(Userindex).Char.Body = ObjData(.ArmourEqpObjIndex).Ropaje
    Else
        Call DarCuerpoDesnudo(Userindex)
    End If
    
    If .WeaponEqpSlot Then
        .Object(.WeaponEqpSlot).Equipped = 1
        .WeaponEqpObjIndex = .Object(.WeaponEqpSlot).OBJIndex
        UserList(Userindex).Char.WeaponAnim = ObjData(.WeaponEqpObjIndex).WeaponAnim
    End If
    
    If .EscudoEqpSlot Then
        .Object(.EscudoEqpSlot).Equipped = 1
        .EscudoEqpObjIndex = .Object(.EscudoEqpSlot).OBJIndex
        UserList(Userindex).Char.ShieldAnim = ObjData(.EscudoEqpObjIndex).ShieldAnim
    Else
        UserList(Userindex).Char.ShieldAnim = NingunEscudo
    End If

    If .MunicionEqpSlot Then
        .Object(.MunicionEqpSlot).Equipped = 1
        .MunicionEqpObjIndex = .Object(.MunicionEqpSlot).OBJIndex
    End If
    
    If .HerramientaEqpslot Then
        .Object(.HerramientaEqpslot).Equipped = 1
        .HerramientaEqpObjIndex = .Object(.HerramientaEqpslot).OBJIndex
    End If
End With

End Sub
Public Function TieneObjetosRobables(Userindex As Integer) As Boolean
On Error Resume Next
Dim i As Byte

For i = 1 To MAX_INVENTORY_SLOTS
    If ObjEsRobable(Userindex, i) Then
        TieneObjetosRobables = True
        Exit For
    End If
Next

End Function
Function ClaseBase(Clase As Byte) As Boolean

ClaseBase = (Clase = CIUDADANO Or Clase = Luchador Or Clase = CON_MANA Or _
            Clase = HECHICERO Or Clase = ORDEN_SAGRADA Or Clase = NATURALISTA Or _
            Clase = SIGILOSO Or Clase = SIN_MANA Or Clase = BANDIDO Or _
            Clase = CABALLERO)

End Function
Function ClaseMana(Clase As Byte) As Boolean

ClaseMana = (Clase >= CON_MANA And Clase < SIN_MANA)

End Function
Function ClaseNoMana(Clase As Byte) As Boolean

ClaseNoMana = (Clase >= SIN_MANA)

End Function
Function ClaseTrabajadora(Clase As Byte) As Boolean

ClaseTrabajadora = (Clase > CIUDADANO And Clase < Luchador)

End Function
Function ClasePuedeHechizo(Userindex As Integer, ByVal OBJIndex As Integer) As Boolean
On Error GoTo manejador
Dim flag As Boolean

If UserList(Userindex).flags.Privilegios Then
    ClasePuedeHechizo = True
    Exit Function
End If

If ObjData(OBJIndex).ClaseProhibida(1) > 0 Then
    Dim i As Integer
    For i = 1 To NUMCLASES
        If ObjData(OBJIndex).ClaseProhibida(i) = UserList(Userindex).Clase Then
            ClasePuedeHechizo = True
            Exit Function
        End If
    Next
Else: ClasePuedeHechizo = True
End If

Exit Function

manejador:
    LogError ("Error en ClasePuedeUsarHechizo")
End Function
Function ClasePuedeUsarItem(Userindex As Integer, ByVal OBJIndex As Integer) As Boolean
On Error GoTo manejador
Dim flag As Boolean

If UserList(Userindex).flags.Privilegios Then
    ClasePuedeUsarItem = True
    Exit Function
End If

If Len(ObjData(OBJIndex).ClaseProhibida(1)) > 0 Then
    Dim i As Integer
    For i = 1 To NUMCLASES
    
        If ObjData(OBJIndex).ClaseProhibida(i) = UserList(Userindex).Clase Then
            ClasePuedeUsarItem = False
            Exit Function
        ElseIf ObjData(OBJIndex).ClaseProhibida(i) = 0 Then
            Exit For
        End If
    Next
End If

ClasePuedeUsarItem = True

Exit Function

manejador:
    LogError ("Error en ClasePuedeUsarItem")
End Function
Function RazaPuedeUsarItem(Userindex As Integer, ByVal OBJIndex As Integer) As Boolean
On Error GoTo manejador
Dim flag As Boolean

If UserList(Userindex).flags.Privilegios Then
    RazaPuedeUsarItem = True
    Exit Function
End If

        If Len(ObjData(OBJIndex).RazaProhibida(1)) > 0 Then
            Dim i As Integer
            For i = 1 To NUMRAZAS
                If (ObjData(OBJIndex).RazaProhibida(i)) = (UserList(Userindex).Raza) Then
                    RazaPuedeUsarItem = False
                    Exit Function
                End If
            Next
            RazaPuedeUsarItem = True
        Else
            RazaPuedeUsarItem = True
        End If
        
Exit Function

manejador:
    LogError ("Error en RazaPuedeUsarItem")
End Function
Sub QuitarNewbieObj(Userindex As Integer)
Dim j As Byte

For j = 1 To MAX_INVENTORY_SLOTS
    If UserList(Userindex).Invent.Object(j).OBJIndex Then
        If ObjData(UserList(Userindex).Invent.Object(j).OBJIndex).Newbie = 1 Then _
            Call QuitarVariosItem(Userindex, j, MAX_INVENTORY_OBJS)
            Call UpdateUserInv(False, Userindex, j)
    End If
Next



End Sub
Sub LimpiarInventario(Userindex As Integer)
Dim j As Byte

For j = 1 To MAX_INVENTORY_SLOTS
        UserList(Userindex).Invent.Object(j).OBJIndex = 0
        UserList(Userindex).Invent.Object(j).Amount = 0
        UserList(Userindex).Invent.Object(j).Equipped = 0
Next

UserList(Userindex).Invent.NroItems = 0

UserList(Userindex).Invent.ArmourEqpObjIndex = 0
UserList(Userindex).Invent.ArmourEqpSlot = 0

UserList(Userindex).Invent.WeaponEqpObjIndex = 0
UserList(Userindex).Invent.WeaponEqpSlot = 0

UserList(Userindex).Invent.CascoEqpObjIndex = 0
UserList(Userindex).Invent.CascoEqpSlot = 0

UserList(Userindex).Invent.EscudoEqpObjIndex = 0
UserList(Userindex).Invent.EscudoEqpSlot = 0

UserList(Userindex).Invent.HerramientaEqpObjIndex = 0
UserList(Userindex).Invent.HerramientaEqpslot = 0

UserList(Userindex).Invent.MunicionEqpObjIndex = 0
UserList(Userindex).Invent.MunicionEqpSlot = 0

UserList(Userindex).Invent.BarcoObjIndex = 0
UserList(Userindex).Invent.BarcoSlot = 0

End Sub
Sub TirarOro(ByVal Cantidad As Long, Userindex As Integer)
On Error GoTo errhandler


If MapInfo(UserList(Userindex).POS.Map).EsMapaEspecial Then Exit Sub

Dim nPos As WorldPos
If Cantidad > 100000 Then Exit Sub

If Cantidad <= 0 Or Cantidad > UserList(Userindex).Stats.GLD Then Exit Sub

Dim MiObj As Obj

MiObj.OBJIndex = iORO

If UserList(Userindex).flags.Privilegios Then Call LogGM(UserList(Userindex).Name, "Tiro cantidad:" & Cantidad & " Objeto:" & ObjData(MiObj.OBJIndex).Name, False)

Do While Cantidad > 0
    MiObj.Amount = Minimo(Cantidad, MAX_INVENTORY_OBJS)
        
    nPos = TirarItemAlPiso(UserList(Userindex).POS, MiObj)
    If nPos.Map = 0 Then Exit Sub
    
    UserList(Userindex).Stats.GLD = UserList(Userindex).Stats.GLD - MiObj.Amount
    Cantidad = Cantidad - MiObj.Amount
Loop
    
Exit Sub

errhandler:

End Sub
Sub QuitarUserInvItem(Userindex As Integer, ByVal Slot As Byte, Cantidad As Integer)
Dim MiObj As Obj

If Slot < 1 Or Slot > MAX_INVENTORY_SLOTS Then Exit Sub

If UserList(Userindex).Invent.Object(Slot).Equipped = 1 Then Call Desequipar(Userindex, Slot)

UserList(Userindex).Invent.Object(Slot).Amount = UserList(Userindex).Invent.Object(Slot).Amount - Cantidad

If UserList(Userindex).Invent.Object(Slot).Amount <= 0 Then
    UserList(Userindex).Invent.NroItems = UserList(Userindex).Invent.NroItems - 1
    UserList(Userindex).Invent.Object(Slot).OBJIndex = 0
    UserList(Userindex).Invent.Object(Slot).Amount = 0
End If
    
End Sub
Sub QuitarUnItem(Userindex As Integer, ByVal Slot As Byte)
Dim MiObj As Obj

If Slot < 1 Or Slot > MAX_INVENTORY_SLOTS Then Exit Sub

If UserList(Userindex).Invent.Object(Slot).Equipped = 1 And UserList(Userindex).Invent.Object(Slot).Amount = 1 Then Call Desequipar(Userindex, Slot)

UserList(Userindex).Invent.Object(Slot).Amount = UserList(Userindex).Invent.Object(Slot).Amount - 1

If UserList(Userindex).Invent.Object(Slot).Amount <= 0 Then
    UserList(Userindex).Invent.NroItems = UserList(Userindex).Invent.NroItems - 1
    UserList(Userindex).Invent.Object(Slot).OBJIndex = 0
    UserList(Userindex).Invent.Object(Slot).Amount = 0
    Call SendData(ToIndex, Userindex, 0, "3I" & Slot)
Else
    Call SendData(ToIndex, Userindex, 0, "2I" & Slot)
End If

End Sub
Sub QuitarBebida(Userindex As Integer, ByVal Slot As Byte)

Dim MiObj As Obj

If Slot < 1 Or Slot > MAX_INVENTORY_SLOTS Then Exit Sub

If UserList(Userindex).Invent.Object(Slot).Equipped = 1 Then Call Desequipar(Userindex, Slot)


    UserList(Userindex).Invent.Object(Slot).Amount = UserList(Userindex).Invent.Object(Slot).Amount - 1


If UserList(Userindex).Invent.Object(Slot).Amount <= 0 Then
    UserList(Userindex).Invent.NroItems = UserList(Userindex).Invent.NroItems - 1
    UserList(Userindex).Invent.Object(Slot).OBJIndex = 0
    UserList(Userindex).Invent.Object(Slot).Amount = 0
    Call SendData(ToIndex, Userindex, 0, "6I" & Slot & "," & UserList(Userindex).Stats.MinAGU)
    Call SendData(ToPCAreaButIndex, Userindex, UserList(Userindex).POS.Map, "TW" & "46")
    
Else
Call SendData(ToIndex, Userindex, 0, "6J" & Slot & "," & UserList(Userindex).Stats.MinAGU)
Call SendData(ToPCAreaButIndex, Userindex, UserList(Userindex).POS.Map, "TW" & "46")

End If
    
End Sub
Sub QuitarComida(Userindex As Integer, ByVal Slot As Byte)

Dim MiObj As Obj

If Slot < 1 Or Slot > MAX_INVENTORY_SLOTS Then Exit Sub

If UserList(Userindex).Invent.Object(Slot).Equipped = 1 Then Call Desequipar(Userindex, Slot)


    UserList(Userindex).Invent.Object(Slot).Amount = UserList(Userindex).Invent.Object(Slot).Amount - 1


If UserList(Userindex).Invent.Object(Slot).Amount <= 0 Then
    UserList(Userindex).Invent.NroItems = UserList(Userindex).Invent.NroItems - 1
    UserList(Userindex).Invent.Object(Slot).OBJIndex = 0
    UserList(Userindex).Invent.Object(Slot).Amount = 0
    Call SendData(ToIndex, Userindex, 0, "7K" & Slot & "," & UserList(Userindex).Stats.MinHam)
    Call SendData(ToPCAreaButIndex, Userindex, UserList(Userindex).POS.Map, "TW" & "7")

Else
Call SendData(ToIndex, Userindex, 0, "6K" & Slot & "," & UserList(Userindex).Stats.MinHam)
Call SendData(ToPCAreaButIndex, Userindex, UserList(Userindex).POS.Map, "TW" & "7")

End If
    
End Sub

Sub QuitarPocion(Userindex As Integer, ByVal Slot As Byte)

Dim MiObj As Obj

If Slot < 1 Or Slot > MAX_INVENTORY_SLOTS Then Exit Sub

If UserList(Userindex).Invent.Object(Slot).Equipped = 1 Then Call Desequipar(Userindex, Slot)


    UserList(Userindex).Invent.Object(Slot).Amount = UserList(Userindex).Invent.Object(Slot).Amount - 1

If UserList(Userindex).Invent.Object(Slot).Amount <= 0 Then
    UserList(Userindex).Invent.NroItems = UserList(Userindex).Invent.NroItems - 1
    UserList(Userindex).Invent.Object(Slot).OBJIndex = 0
    UserList(Userindex).Invent.Object(Slot).Amount = 0
    Call SendData(ToIndex, Userindex, 0, "4J" & Slot)
    Call SendData(ToPCAreaButIndex, Userindex, UserList(Userindex).POS.Map, "TW" & "46")

Else
Call SendData(ToIndex, Userindex, 0, "3J" & Slot)
Call SendData(ToPCAreaButIndex, Userindex, UserList(Userindex).POS.Map, "TW" & "46")
End If
    
End Sub

Sub QuitarPocionMana(Userindex As Integer, ByVal Slot As Byte)

Dim MiObj As Obj

If Slot < 1 Or Slot > MAX_INVENTORY_SLOTS Then Exit Sub

If UserList(Userindex).Invent.Object(Slot).Equipped = 1 Then Call Desequipar(Userindex, Slot)


UserList(Userindex).Invent.Object(Slot).Amount = UserList(Userindex).Invent.Object(Slot).Amount - 1


If UserList(Userindex).Invent.Object(Slot).Amount <= 0 Then
    UserList(Userindex).Invent.NroItems = UserList(Userindex).Invent.NroItems - 1
    UserList(Userindex).Invent.Object(Slot).OBJIndex = 0
    UserList(Userindex).Invent.Object(Slot).Amount = 0
    Call SendData(ToIndex, Userindex, 0, "8I" & Slot & "," & UserList(Userindex).Stats.MinMAN)
    Call SendData(ToPCAreaButIndex, Userindex, UserList(Userindex).POS.Map, "TW" & "46")

Else
Call SendData(ToIndex, Userindex, 0, "7I" & THeDEnCripTe(Slot & "," & UserList(Userindex).Stats.MinMAN, "STRINGGENM"))
Call SendData(ToPCAreaButIndex, Userindex, UserList(Userindex).POS.Map, "TW" & "46")

End If
    
End Sub
Sub QuitarPocionVida(Userindex As Integer, ByVal Slot As Byte)

Dim MiObj As Obj

If Slot < 1 Or Slot > MAX_INVENTORY_SLOTS Then Exit Sub

If UserList(Userindex).Invent.Object(Slot).Equipped = 1 Then Call Desequipar(Userindex, Slot)


    UserList(Userindex).Invent.Object(Slot).Amount = UserList(Userindex).Invent.Object(Slot).Amount - 1

If UserList(Userindex).Invent.Object(Slot).Amount <= 0 Then
    UserList(Userindex).Invent.NroItems = UserList(Userindex).Invent.NroItems - 1
    UserList(Userindex).Invent.Object(Slot).OBJIndex = 0
    UserList(Userindex).Invent.Object(Slot).Amount = 0
    Call SendData(ToIndex, Userindex, 0, "2J" & Slot & "," & UserList(Userindex).Stats.MinHP)
    Call SendData(ToPCAreaButIndex, Userindex, UserList(Userindex).POS.Map, "TW" & "46")

Else
Call SendData(ToIndex, Userindex, 0, "9I" & Slot & "," & UserList(Userindex).Stats.MinHP)
Call SendData(ToPCAreaButIndex, Userindex, UserList(Userindex).POS.Map, "TW" & "46")

End If
    
End Sub
Sub QuitarVariosItem(Userindex As Integer, ByVal Slot As Byte, Cantidad As Integer)

Dim MiObj As Obj

If Slot < 1 Or Slot > MAX_INVENTORY_SLOTS Then Exit Sub

If UserList(Userindex).Invent.Object(Slot).Equipped = 1 And UserList(Userindex).Invent.Object(Slot).Amount <= Cantidad Then Call Desequipar(Userindex, Slot)


UserList(Userindex).Invent.Object(Slot).Amount = UserList(Userindex).Invent.Object(Slot).Amount - Cantidad


If UserList(Userindex).Invent.Object(Slot).Amount <= 0 Then
    UserList(Userindex).Invent.NroItems = UserList(Userindex).Invent.NroItems - 1
    UserList(Userindex).Invent.Object(Slot).OBJIndex = 0
    UserList(Userindex).Invent.Object(Slot).Amount = 0
    Call SendData(ToIndex, Userindex, 0, "3I" & Slot)
Else
    Call SendData(ToIndex, Userindex, 0, "4I" & Slot & "," & Cantidad)
End If
    
End Sub
Sub UpdateUserInv(ByVal UpdateAll As Boolean, Userindex As Integer, Slot As Byte, Optional JustAmount As Boolean)
Dim i As Byte

Dim MiObj As UserOBJ
Dim ArrayInventario As String 'AREAS NUEVAS

If UpdateAll Then
    For i = 1 To MAX_INVENTORY_SLOTS
    MiObj = UserList(Userindex).Invent.Object(i)

        ArrayInventario = ArrayInventario & i & "," & ObjData(MiObj.OBJIndex).Name & "," & MiObj.Amount & "," & MiObj.Equipped & "," & ObjData(MiObj.OBJIndex).GrhIndex & "," _
        & ObjData(MiObj.OBJIndex).ObjType & "," & Round(ObjData(MiObj.OBJIndex).Valor / 3) & "," & ObjData(MiObj.OBJIndex).Minlvl

  Select Case ObjData(MiObj.OBJIndex).ObjType
            Case OBJTYPE_WEAPON
                ArrayInventario = ArrayInventario & "," & ObjData(MiObj.OBJIndex).MaxHit & "," & ObjData(MiObj.OBJIndex).MinHit & "@"
            Case OBJTYPE_ARMOUR
                ArrayInventario = ArrayInventario & "," & ObjData(MiObj.OBJIndex).SubTipo & "," & ObjData(MiObj.OBJIndex).MaxDef & "," & ObjData(MiObj.OBJIndex).MinDef & "," & ObjData(MiObj.OBJIndex).MinHit & "@"
            Case OBJTYPE_POCIONES
                ArrayInventario = ArrayInventario & "," & ObjData(MiObj.OBJIndex).TipoPocion & "," & ObjData(MiObj.OBJIndex).MaxModificador & "," & ObjData(MiObj.OBJIndex).MinModificador & "@"
Case OBJTYPE_USEONCE
ArrayInventario = ArrayInventario & "@"
Case OBJTYPE_ARBOLES
ArrayInventario = ArrayInventario & "@"
Case OBJTYPE_GUITA
ArrayInventario = ArrayInventario & "@"
Case OBJTYPE_PUERTAS
ArrayInventario = ArrayInventario & "@"
Case OBJTYPE_CONTENEDORES
ArrayInventario = ArrayInventario & "@"
Case OBJTYPE_CARTELES
ArrayInventario = ArrayInventario & "@"
Case OBJTYPE_LLAVES
ArrayInventario = ArrayInventario & "@"
Case OBJTYPE_FOROS
ArrayInventario = ArrayInventario & "@"
Case OBJTYPE_BEBIDA
ArrayInventario = ArrayInventario & "@"
Case OBJTYPE_LEÑA
ArrayInventario = ArrayInventario & "@"
Case OBJTYPE_FOGATA
ArrayInventario = ArrayInventario & "@"
Case OBJTYPE_HERRAMIENTAS
ArrayInventario = ArrayInventario & "@"
Case OBJTYPE_YACIMIENTO
ArrayInventario = ArrayInventario & "@"
Case OBJTYPE_PERGAMINOS
ArrayInventario = ArrayInventario & "@"
Case OBJTYPE_TELEPORT
ArrayInventario = ArrayInventario & "@"
Case OBJTYPE_YUNQUE
ArrayInventario = ArrayInventario & "@"
Case OBJTYPE_FRAGUA
ArrayInventario = ArrayInventario & "@"
Case OBJTYPE_MINERALES
ArrayInventario = ArrayInventario & "@"
Case OBJTYPE_CUALQUIERA
ArrayInventario = ArrayInventario & "@"
Case OBJTYPE_INSTRUMENTOS
ArrayInventario = ArrayInventario & "@"
Case OBJTYPE_BARCOS
ArrayInventario = ArrayInventario & "@"
Case OBJTYPE_FLECHAS
ArrayInventario = ArrayInventario & "@"
Case OBJTYPE_BOTELLAVACIA
ArrayInventario = ArrayInventario & "@"
Case OBJTYPE_BOTELLALLENA
ArrayInventario = ArrayInventario & "@"
Case OBJTYPE_MANCHAS
ArrayInventario = ArrayInventario & "@"
Case OBJTYPE_RAIZ
ArrayInventario = ArrayInventario & "@"
Case OBJTYPE_PIEL
ArrayInventario = ArrayInventario & "@"
Case OBJTYPE_WARP
ArrayInventario = ArrayInventario & "@"
Case OBJTYPE_ARMADURA
ArrayInventario = ArrayInventario & "@"
Case OBJTYPE_CASCO
ArrayInventario = ArrayInventario & "@"
Case OBJTYPE_ESCUDO
ArrayInventario = ArrayInventario & "@"
Case OBJTYPE_CAÑA
ArrayInventario = ArrayInventario & "@"
Case 0
ArrayInventario = ArrayInventario & "@"
Case Else
ArrayInventario = ArrayInventario & "@"
        End Select

    Next
    
    Call SendData(ToIndex, Userindex, 0, "CSU" & ArrayInventario)

    ArrayInventario = 0
Else
    Call SendUserItem(Userindex, Slot, JustAmount)
End If

End Sub
Sub DropObj(Userindex As Integer, Slot As Byte, ByVal Num As Integer, Map As Integer, X As Integer, y As Integer)
Dim Obj As Obj

If UserList(Userindex).flags.Privilegios = 1 Or UserList(Userindex).flags.Privilegios = 2 Or UserList(Userindex).flags.Privilegios = 3 Then
Call SendData(ToIndex, Userindex, 0, "||Los administradores no pueden tirar items." & FONTTYPE_TALK)
Exit Sub
End If

If Num Then
  If Num > UserList(Userindex).Invent.Object(Slot).Amount Then Num = UserList(Userindex).Invent.Object(Slot).Amount
  
  
  If MapData(UserList(Userindex).POS.Map, X, y).OBJInfo.OBJIndex = 0 Then
        If UserList(Userindex).Invent.Object(Slot).Equipped = 1 And UserList(Userindex).Invent.Object(Slot).Amount <= Num Then Call Desequipar(Userindex, Slot)
        Obj.OBJIndex = UserList(Userindex).Invent.Object(Slot).OBJIndex
        If UserList(Userindex).flags.Privilegios < 2 Then
            If ObjData(Obj.OBJIndex).NoComerciable = 1 Then
                Call SendData(ToIndex, Userindex, 0, "2W")
                Exit Sub
            End If
            
            If ObjData(Obj.OBJIndex).Newbie = 1 And EsNewbie(Userindex) Then
                Call SendData(ToIndex, Userindex, 0, "3W")
                Exit Sub
            End If
        End If
        
        Obj.Amount = Num
        
        Call MakeObj(ToMap, 0, Map, Obj, Map, X, y)
        Call QuitarVariosItem(Userindex, Slot, Num)
        
        If UserList(Userindex).flags.Privilegios Then Call LogGM(UserList(Userindex).Name, "Tiro cantidad:" & Num & " Objeto:" & ObjData(Obj.OBJIndex).Name & " EN:" & UserList(Userindex).POS.Map & "," & UserList(Userindex).POS.X & "," & UserList(Userindex).POS.y, False)
        If ObjData(Obj.OBJIndex).EsItemValioso Then Call LoGTirar(UserList(Userindex).Name, UserList(Userindex).Name & " Tiro cantidad:" & Num & " Objeto:" & ObjData(Obj.OBJIndex).Name & " EN:" & UserList(Userindex).POS.Map & "," & UserList(Userindex).POS.X & "," & UserList(Userindex).POS.y, False)
  Else
        Call SendData(ToIndex, Userindex, 0, "4W")
  End If
    
End If

End Sub

Sub EraseObj(ByVal sndRoute As Byte, ByVal sndIndex As Integer, ByVal sndMap As Integer, ByVal Num As Integer, Map As Integer, X As Integer, y As Integer)

MapData(Map, X, y).OBJInfo.Amount = MapData(Map, X, y).OBJInfo.Amount - Num

If MapData(Map, X, y).OBJInfo.Amount <= 0 Then
    MapData(Map, X, y).OBJInfo.OBJIndex = 0
    MapData(Map, X, y).OBJInfo.Amount = 0
    Call SendData(sndRoute, sndIndex, sndMap, "BO" & X & "," & y)
End If

End Sub

Sub MakeObj(ByVal sndRoute As Byte, ByVal sndIndex As Integer, ByVal sndMap As Integer, Obj As Obj, Map As Integer, X As Integer, y As Integer)


MapData(Map, X, y).OBJInfo = Obj
Call SendData(sndRoute, sndIndex, sndMap, "HO" & ObjData(Obj.OBJIndex).GrhIndex & "," & X & "," & y)
'Call SendData(sndRoute, sndIndex, sndMap, "HO" & ObjData(Obj.OBJIndex).GrhIndex & "," & X & "," & Y & "," & ObjData(Obj.OBJIndex).Name)
End Sub

Function MeterItemEnInventario(Userindex As Integer, MiObj As Obj) As Boolean
On Error GoTo errhandler


 
Dim X As Integer
Dim y As Integer
Dim Slot As Byte


Slot = 1
Do Until UserList(Userindex).Invent.Object(Slot).OBJIndex = MiObj.OBJIndex And _
         UserList(Userindex).Invent.Object(Slot).Amount + MiObj.Amount <= MAX_INVENTORY_OBJS
   Slot = Slot + 1
   If Slot > MAX_INVENTORY_SLOTS Then Exit Do
Loop
    

If Slot > MAX_INVENTORY_SLOTS Then
   Slot = 1
   Do Until UserList(Userindex).Invent.Object(Slot).OBJIndex = 0
       Slot = Slot + 1
       If Slot > MAX_INVENTORY_SLOTS Then
           Call SendData(ToIndex, Userindex, 0, "5W")
           MeterItemEnInventario = False
           Exit Function
       End If
   Loop
   UserList(Userindex).Invent.NroItems = UserList(Userindex).Invent.NroItems + 1
End If
    

If UserList(Userindex).Invent.Object(Slot).Amount + MiObj.Amount <= MAX_INVENTORY_OBJS Then
   
   UserList(Userindex).Invent.Object(Slot).OBJIndex = MiObj.OBJIndex
   UserList(Userindex).Invent.Object(Slot).Amount = UserList(Userindex).Invent.Object(Slot).Amount + MiObj.Amount
Else
   UserList(Userindex).Invent.Object(Slot).Amount = MAX_INVENTORY_OBJS
End If
    
MeterItemEnInventario = True
       
Call UpdateUserInv(False, Userindex, Slot)


Exit Function
errhandler:

End Function

Function MeterItemEnBancoOFF(nameuser As String, MiObj As Obj) As Boolean
On Error GoTo errhandler
Dim loopd As Integer
Dim ln2 As String
Dim UserFile As String
UserFile = CharPath & UCase$(nameuser) & ".chr"
Dim solounaves As Integer
solounaves = 0

If val(GetVar(UserFile, "BancoInventory", "CantidadItems")) < 40 Then

For loopd = 1 To MAX_BANCOINVENTORY_SLOTS
    
    If solounaves = 0 Then
    If val(GetVar(UserFile, "BancoInventory", "Obj" & loopd)) = 0 Then 'CHECKEA SLOT en 0
    Call WriteVar(UserFile, "BancoInventory", "CantidadItems", val(GetVar(UserFile, "BancoInventory", "CantidadItems")) + 1)
    Call WriteVar(UserFile, "BancoInventory", "Obj" & loopd, MiObj.OBJIndex & "-" & MiObj.Amount)
    solounaves = 1
    End If
    End If
    
Next loopd
 
 
Else ' no le da nada porque tiene mas de 40 item

End If





Exit Function
errhandler:

End Function
 




Sub GetObj(Userindex As Integer)

Dim Obj As ObjData
Dim MiObj As Obj



If MapData(UserList(Userindex).POS.Map, UserList(Userindex).POS.X, UserList(Userindex).POS.y).OBJInfo.OBJIndex Then
    
    If ObjData(MapData(UserList(Userindex).POS.Map, UserList(Userindex).POS.X, UserList(Userindex).POS.y).OBJInfo.OBJIndex).Agarrable <> 1 Then
        Dim X As Integer
        Dim y As Integer
        Dim Slot As Byte
        
        X = UserList(Userindex).POS.X
        y = UserList(Userindex).POS.y
        Obj = ObjData(MapData(UserList(Userindex).POS.Map, UserList(Userindex).POS.X, UserList(Userindex).POS.y).OBJInfo.OBJIndex)
        MiObj.Amount = MapData(UserList(Userindex).POS.Map, X, y).OBJInfo.Amount
        MiObj.OBJIndex = MapData(UserList(Userindex).POS.Map, X, y).OBJInfo.OBJIndex
        
        
        
        If ObjData(MapData(UserList(Userindex).POS.Map, UserList(Userindex).POS.X, UserList(Userindex).POS.y).OBJInfo.OBJIndex).ObjType = OBJTYPE_GUITA Then
        UserList(Userindex).Stats.GLD = UserList(Userindex).Stats.GLD + MapData(UserList(Userindex).POS.Map, X, y).OBJInfo.Amount
        Call SendUserORO(Userindex)
            Call EraseObj(ToMap, 0, UserList(Userindex).POS.Map, MapData(UserList(Userindex).POS.Map, X, y).OBJInfo.Amount, UserList(Userindex).POS.Map, UserList(Userindex).POS.X, UserList(Userindex).POS.y)
            If UserList(Userindex).flags.Privilegios Then Call LogGM(UserList(Userindex).Name, "Agarro oro:" & MiObj.Amount, False)

        Exit Sub
        End If


        If Not MeterItemEnInventario(Userindex, MiObj) Then
        
        Else
            
            Call EraseObj(ToMap, 0, UserList(Userindex).POS.Map, MapData(UserList(Userindex).POS.Map, X, y).OBJInfo.Amount, UserList(Userindex).POS.Map, UserList(Userindex).POS.X, UserList(Userindex).POS.y)
            If UserList(Userindex).flags.Privilegios Then Call LogGM(UserList(Userindex).Name, "Agarro:" & MiObj.Amount & " Objeto:" & ObjData(MiObj.OBJIndex).Name & " EN:" & UserList(Userindex).POS.Map & "," & UserList(Userindex).POS.X & "," & UserList(Userindex).POS.y, False)
            
            If ObjData(MiObj.OBJIndex).EsItemValioso Then Call LoGTirar(UserList(Userindex).Name, UserList(Userindex).Name & " Agarro:" & MiObj.Amount & " Objeto:" & ObjData(MiObj.OBJIndex).Name & " EN:" & UserList(Userindex).POS.Map & "," & UserList(Userindex).POS.X & "," & UserList(Userindex).POS.y, False)
        End If
        
    End If
Else
    Call SendData(ToIndex, Userindex, 0, "8K")
End If

End Sub
Sub Desequipar(Userindex As Integer, ByVal Slot As Byte)

Dim Obj As ObjData
If Slot = 0 Then Exit Sub
If UserList(Userindex).Invent.Object(Slot).OBJIndex = 0 Then Exit Sub

Obj = ObjData(UserList(Userindex).Invent.Object(Slot).OBJIndex)

Select Case Obj.ObjType


    Case OBJTYPE_WEAPON

        UserList(Userindex).Invent.Object(Slot).Equipped = 0
        UserList(Userindex).Invent.WeaponEqpObjIndex = 0
        UserList(Userindex).Invent.WeaponEqpSlot = 0
        If UserList(Userindex).flags.Transformado = 0 And UserList(Userindex).flags.Transformadodeath = 0 Then
        Call ChangeUserArma(ToMap, 0, UserList(Userindex).POS.Map, Userindex, NingunArma)
        UserList(Userindex).Char.Aura = 0 'dx8
        Call SendData(ToAll, Userindex, UserList(Userindex).POS.Map, "AUR" & UserList(Userindex).Char.CharIndex & "," & UserList(Userindex).Char.Aura) 'dx8
        End If
    Case OBJTYPE_FLECHAS
    
        UserList(Userindex).Invent.Object(Slot).Equipped = 0
        UserList(Userindex).Invent.MunicionEqpObjIndex = 0
        UserList(Userindex).Invent.MunicionEqpSlot = 0
        
    Case OBJTYPE_HERRAMIENTAS
            
        If UserList(Userindex).flags.Trabajando Then
            If UserList(Userindex).flags.CodigoTrabajo Then
                Exit Sub
            Else
                Call SacarModoTrabajo(Userindex)
            End If
        End If
        
        UserList(Userindex).Invent.Object(Slot).Equipped = 0
        UserList(Userindex).Invent.HerramientaEqpObjIndex = 0
        UserList(Userindex).Invent.HerramientaEqpslot = 0
        
    Case OBJTYPE_ARMOUR
        If UserList(Userindex).flags.Montado = 1 Then Exit Sub

        Select Case Obj.SubTipo
        
            Case OBJTYPE_ARMADURA
                UserList(Userindex).Invent.Object(Slot).Equipped = 0
                UserList(Userindex).Invent.ArmourEqpObjIndex = 0
                UserList(Userindex).Invent.ArmourEqpSlot = 0
                If UserList(Userindex).flags.Transformado = 0 And UserList(Userindex).flags.Transformadodeath = 0 Then
                    Call DarCuerpoDesnudo(Userindex)
                    Call ChangeUserBody(ToMap, 0, UserList(Userindex).POS.Map, Userindex, UserList(Userindex).Char.Body)
                End If
                
            Case OBJTYPE_CASCO
                UserList(Userindex).Invent.Object(Slot).Equipped = 0
                UserList(Userindex).Invent.CascoEqpObjIndex = 0
                UserList(Userindex).Invent.CascoEqpSlot = 0
                If UserList(Userindex).flags.Transformado = 0 And UserList(Userindex).flags.Transformadodeath = 0 Then
                    Call ChangeUserCasco(ToMap, 0, UserList(Userindex).POS.Map, Userindex, NingunCasco)
                End If
            Case OBJTYPE_ESCUDO
                UserList(Userindex).Invent.Object(Slot).Equipped = 0
                UserList(Userindex).Invent.EscudoEqpObjIndex = 0
                UserList(Userindex).Invent.EscudoEqpSlot = 0
                If UserList(Userindex).flags.Transformado = 0 And UserList(Userindex).flags.Transformadodeath = 0 Then
                    Call ChangeUserEscudo(ToMap, 0, UserList(Userindex).POS.Map, Userindex, NingunEscudo)
                End If
        End Select
    
End Select

Call DesequiparItem(Userindex, Slot)

End Sub
Function SexoPuedeUsarItem(Userindex As Integer, ByVal OBJIndex As Integer) As Boolean
On Error GoTo errhandler

If UserList(Userindex).flags.Privilegios Then
    SexoPuedeUsarItem = True
    Exit Function
End If

If ObjData(OBJIndex).MUJER = 1 Then
    SexoPuedeUsarItem = UserList(Userindex).Genero = MUJER
ElseIf ObjData(OBJIndex).HOMBRE = 1 Then
    SexoPuedeUsarItem = UserList(Userindex).Genero = HOMBRE
Else
    SexoPuedeUsarItem = True
End If

Exit Function
errhandler:
    Call LogError("SexoPuedeUsarItem")
End Function
Function FaccionClasePuedeUsarItem(Userindex As Integer, ByVal OBJIndex As Integer) As Boolean
Dim i As Integer

If UserList(Userindex).flags.Privilegios Then
    FaccionClasePuedeUsarItem = True
    Exit Function
End If

For i = 1 To Minimo(UserList(Userindex).Faccion.Jerarquia, 3)
    If Armaduras(UserList(Userindex).Faccion.Bando, i, TipoClase(Userindex), TipoRaza(Userindex)) = OBJIndex Then
        FaccionClasePuedeUsarItem = True
        Exit Function
    End If
Next

End Function
Function FaccionPuedeUsarItem(Userindex As Integer, ByVal OBJIndex As Integer) As Boolean

If UserList(Userindex).flags.Privilegios Then
    FaccionPuedeUsarItem = True
    Exit Function
End If

If ObjData(OBJIndex).Real >= 1 Then
    FaccionPuedeUsarItem = (UserList(Userindex).Faccion.Bando = Real And UserList(Userindex).Faccion.Jerarquia >= ObjData(OBJIndex).Jerarquia)
ElseIf ObjData(OBJIndex).Caos >= 1 Then
    FaccionPuedeUsarItem = (UserList(Userindex).Faccion.Bando = Caos And UserList(Userindex).Faccion.Jerarquia >= ObjData(OBJIndex).Jerarquia)
Else: FaccionPuedeUsarItem = True
End If

End Function
Function PuedeUsarObjeto(Userindex As Integer, ByVal OBJIndex As Integer) As Byte

Select Case ObjData(OBJIndex).ObjType
    Case OBJTYPE_WEAPON
    
        If Not (OBJIndex = 367 And UserList(Userindex).Clase = ASESINO) Then
            If Not RazaPuedeUsarItem(Userindex, OBJIndex) Then
                PuedeUsarObjeto = 5
                Exit Function
            End If
        
            If Not ClasePuedeUsarItem(Userindex, OBJIndex) Then
                 PuedeUsarObjeto = 2
                 Exit Function
            End If
        End If
        
        If Not SkillPuedeUsarItem(Userindex, OBJIndex) Then
            PuedeUsarObjeto = 4
            Exit Function
        End If
       
    Case OBJTYPE_HERRAMIENTAS
    
        If Not ClasePuedeUsarItem(Userindex, OBJIndex) Then
             PuedeUsarObjeto = 2
             Exit Function
        End If

    Case OBJTYPE_ARMOUR
         
         Select Case ObjData(OBJIndex).SubTipo
        
            Case OBJTYPE_ARMADURA
            
                If Not RazaPuedeUsarItem(Userindex, OBJIndex) Then
                    PuedeUsarObjeto = 5
                    Exit Function
                End If
                
                If Not SexoPuedeUsarItem(Userindex, OBJIndex) Then
                    PuedeUsarObjeto = 1
                    Exit Function
                End If
                 
                If ObjData(OBJIndex).Real = 0 And ObjData(OBJIndex).Caos = 0 Then
                    If Not ClasePuedeUsarItem(Userindex, OBJIndex) Then
                         PuedeUsarObjeto = 2
                         Exit Function
                    End If
                Else
                    If Not FaccionPuedeUsarItem(Userindex, OBJIndex) Then
                        PuedeUsarObjeto = 3
                        Exit Function
                    End If
                    If Not FaccionClasePuedeUsarItem(Userindex, OBJIndex) Then
                         PuedeUsarObjeto = 2
                         Exit Function
                    End If
                End If
            
                If Not SkillPuedeUsarItem(Userindex, OBJIndex) Then
                    PuedeUsarObjeto = 4
                    Exit Function
                End If

            Case OBJTYPE_CASCO
            
                 If Not ClasePuedeUsarItem(Userindex, OBJIndex) Then
                      PuedeUsarObjeto = 2
                      Exit Function
                 End If
                
                 If Not SkillPuedeUsarItem(Userindex, OBJIndex) Then
                     PuedeUsarObjeto = 4
                     Exit Function
                 End If
                
            Case OBJTYPE_ESCUDO
            
                If Not ClasePuedeUsarItem(Userindex, OBJIndex) Then
                    PuedeUsarObjeto = 2
                    Exit Function
                End If

                 If Not SkillPuedeUsarItem(Userindex, OBJIndex) Then
                     PuedeUsarObjeto = 4
                     Exit Function
                 End If
            
            Case OBJTYPE_PERGAMINOS
                If Not ClasePuedeUsarItem(Userindex, OBJIndex) Then
                    PuedeUsarObjeto = 2
                    Exit Function
                End If
            
        End Select
End Select

PuedeUsarObjeto = 0

End Function
Function SkillPuedeUsarItem(Userindex As Integer, ByVal OBJIndex As Integer) As Boolean

If UserList(Userindex).flags.Privilegios Then
    SkillPuedeUsarItem = True
    Exit Function
End If

If ObjData(OBJIndex).SkillCombate > UserList(Userindex).Stats.UserSkills(Armas) Then Exit Function
If ObjData(OBJIndex).SkillApuñalar > UserList(Userindex).Stats.UserSkills(Apuñalar) Then Exit Function
If ObjData(OBJIndex).SkillProyectiles > UserList(Userindex).Stats.UserSkills(Proyectiles) Then Exit Function
If ObjData(OBJIndex).SkResistencia > UserList(Userindex).Stats.UserSkills(Resis) Then Exit Function
If ObjData(OBJIndex).SkDefensa > UserList(Userindex).Stats.UserSkills(Defensa) Then Exit Function
If ObjData(OBJIndex).SkillTacticas > UserList(Userindex).Stats.UserSkills(Tacticas) Then Exit Function

SkillPuedeUsarItem = True

End Function
Sub EquiparInvItem(Userindex As Integer, Slot As Byte)
On Error GoTo errhandler


If UserList(Userindex).Stats.ELV < ObjData(UserList(Userindex).Invent.Object(Slot).OBJIndex).Minlvl Then
    Call SendData(ToIndex, Userindex, 0, "||Necesitas ser nivel " & ObjData(UserList(Userindex).Invent.Object(Slot).OBJIndex).Minlvl & " para usar este objeto." & FONTTYPE_INFO)
    Exit Sub
End If

If UserList(Userindex).Invent.Object(Slot).OBJIndex = 697 Then ' costurero
If Not UserList(Userindex).Clase = SASTRE Then
Call SendData(ToIndex, Userindex, 0, "||Solo los sastres pueden usar este objeto." & FONTTYPE_INFO)
Exit Sub
End If
End If

If UserList(Userindex).Invent.Object(Slot).OBJIndex = 198 Then ' costurero
If Not UserList(Userindex).Clase = CARPINTERO Then
Call SendData(ToIndex, Userindex, 0, "||Solo los Carpinteros pueden usar este objeto." & FONTTYPE_INFO)
Exit Sub
End If
End If

If UserList(Userindex).Invent.Object(Slot).OBJIndex = 389 Then ' MARTILLO HERRER
If Not UserList(Userindex).Clase = HERRERO Then
Call SendData(ToIndex, Userindex, 0, "||Solo los herreros pueden usar este objeto." & FONTTYPE_INFO)
Exit Sub
End If
End If

      If UserList(Userindex).Invent.Object(Slot).OBJIndex = 718 Or UserList(Userindex).Invent.Object(Slot).OBJIndex = 721 Or UserList(Userindex).Invent.Object(Slot).OBJIndex = 724 Then 'chupin triple
                If UserList(Userindex).Faccion.Bando = 1 Then
                 UserList(Userindex).Invent.Object(Slot).OBJIndex = 718
          
                ElseIf UserList(Userindex).Faccion.Bando = 2 Then
                 UserList(Userindex).Invent.Object(Slot).OBJIndex = 721
      
                ElseIf UserList(Userindex).Faccion.Bando = 0 Then
                 UserList(Userindex).Invent.Object(Slot).OBJIndex = 724
              
                End If
                End If


If ObjData(UserList(Userindex).Invent.Object(Slot).OBJIndex).Jerarquia Then
If Not UserList(Userindex).Faccion.Bando = ObjData(UserList(Userindex).Invent.Object(Slot).OBJIndex).Jerarquia Then
Call SendData(ToIndex, Userindex, 0, "||Tu facción no puede usar este objeto." & FONTTYPE_INFO)
Exit Sub
End If
End If

'Sin canjes torneo/retos
 If UserList(Userindex).POS.Map = 7 Then
       If UserList(Userindex).flags.RetoSinCanje = 1 Then
       If ObjData(UserList(Userindex).Invent.Object(Slot).OBJIndex).EsItemValioso Then
                    Call Desequipar(Userindex, Slot)
                    Exit Sub
                End If
End If
End If
 If UserList(Userindex).POS.Map = 99 Then
       If AutomaticoCanjes = 1 Then
       If ObjData(UserList(Userindex).Invent.Object(Slot).OBJIndex).EsItemValioso Then
                    Call Desequipar(Userindex, Slot)
                    Exit Sub
                End If
End If
End If
 If UserList(Userindex).POS.Map = 107 Then
       If AutomaticoCanjesp = 1 Then
       If ObjData(UserList(Userindex).Invent.Object(Slot).OBJIndex).EsItemValioso Then
                    Call Desequipar(Userindex, Slot)
                    Exit Sub
                End If
End If
End If
 If UserList(Userindex).POS.Map = 195 Or UserList(Userindex).POS.Map = 196 Or UserList(Userindex).POS.Map = 197 Then
       If AutomaticoTheTeam = 1 Then
       If ObjData(UserList(Userindex).Invent.Object(Slot).OBJIndex).EsItemValioso Then
                    Call Desequipar(Userindex, Slot)
                    Exit Sub
                End If
End If
End If
 If UserList(Userindex).POS.Map = 192 Or UserList(Userindex).POS.Map = 193 Or UserList(Userindex).POS.Map = 194 Then
       If ProtectorCanjes = 1 Then
       If ObjData(UserList(Userindex).Invent.Object(Slot).OBJIndex).EsItemValioso Then
                    Call Desequipar(Userindex, Slot)
                    Exit Sub
                End If
End If
End If
'Sin canjes torneo/retos
Dim Obj As ObjData
Dim OBJIndex As Integer

OBJIndex = UserList(Userindex).Invent.Object(Slot).OBJIndex
Obj = ObjData(OBJIndex)

If Obj.Newbie = 1 And Not EsNewbie(Userindex) Then
     Call SendData(ToIndex, Userindex, 0, "6W")
     Exit Sub
End If

Select Case Obj.ObjType
    Case OBJTYPE_WEAPON
    
        If Not (OBJIndex = 367 And UserList(Userindex).Clase = ASESINO) Then
            If Not RazaPuedeUsarItem(Userindex, OBJIndex) Then
                Call SendData(ToIndex, Userindex, 0, "8W")
                Exit Sub
            End If
        
            If Not ClasePuedeUsarItem(Userindex, OBJIndex) Then
                 Call SendData(ToIndex, Userindex, 0, "2X")
                 Exit Sub
            End If
        End If
        
        If Not SkillPuedeUsarItem(Userindex, OBJIndex) Then
            Call SendData(ToIndex, Userindex, 0, "7W")
            Exit Sub
        End If
                  
            If UserList(Userindex).Invent.Object(Slot).Equipped Then
                Call Desequipar(Userindex, Slot)
                Exit Sub
            End If
            
            
            If UserList(Userindex).Invent.WeaponEqpObjIndex Then Call Desequipar(Userindex, UserList(Userindex).Invent.WeaponEqpSlot)

            UserList(Userindex).Invent.Object(Slot).Equipped = 1
            UserList(Userindex).Invent.WeaponEqpObjIndex = UserList(Userindex).Invent.Object(Slot).OBJIndex
            UserList(Userindex).Invent.WeaponEqpSlot = Slot
            
            
            If ObjData(UserList(Userindex).Invent.WeaponEqpObjIndex).proyectil > 0 And UserList(Userindex).Invent.EscudoEqpSlot > 0 Then
                Call Desequipar(Userindex, UserList(Userindex).Invent.EscudoEqpSlot)
                Call ChangeUserEscudo(ToMap, 0, UserList(Userindex).POS.Map, Userindex, 0)
           End If
            
            Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "TW" & SOUND_SACARARMA)
            
            UserList(Userindex).Char.Aura = Obj.Aura 'dx8
            Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "AUR" & UserList(Userindex).Char.CharIndex & "," & UserList(Userindex).Char.Aura) 'dx8

             If UserList(Userindex).flags.Transformado = 0 And UserList(Userindex).flags.Transformadodeath = 0 Then Call ChangeUserArma(ToMap, 0, UserList(Userindex).POS.Map, Userindex, Obj.WeaponAnim)
            Call EquiparItem(Userindex, Slot)
       
    Case OBJTYPE_HERRAMIENTAS
        If Not RazaPuedeUsarItem(Userindex, OBJIndex) Then
            Call SendData(ToIndex, Userindex, 0, "8W")
            Exit Sub
        End If
    
    
        If Not ClasePuedeUsarItem(Userindex, OBJIndex) Then
             Call SendData(ToIndex, Userindex, 0, "2X")
             Exit Sub
        End If
       
        
        If UserList(Userindex).Invent.Object(Slot).Equipped Then
            
            Call Desequipar(Userindex, Slot)
            Exit Sub
        End If
        
        
        If UserList(Userindex).Invent.HerramientaEqpObjIndex Then
            Call Desequipar(Userindex, UserList(Userindex).Invent.HerramientaEqpslot)
        End If

        UserList(Userindex).Invent.Object(Slot).Equipped = 1
        UserList(Userindex).Invent.HerramientaEqpObjIndex = OBJIndex
        UserList(Userindex).Invent.HerramientaEqpslot = Slot
        Call EquiparItem(Userindex, Slot)
                
    Case OBJTYPE_FLECHAS
        
         
         If UserList(Userindex).Invent.Object(Slot).Equipped Then
             
             Call Desequipar(Userindex, Slot)
             Exit Sub
         End If
         
         
         If UserList(Userindex).Invent.MunicionEqpObjIndex Then
             Call Desequipar(Userindex, UserList(Userindex).Invent.MunicionEqpSlot)
         End If
 
         UserList(Userindex).Invent.Object(Slot).Equipped = 1
         UserList(Userindex).Invent.MunicionEqpObjIndex = UserList(Userindex).Invent.Object(Slot).OBJIndex
         UserList(Userindex).Invent.MunicionEqpSlot = Slot
         Call EquiparItem(Userindex, Slot)
    
    Case OBJTYPE_ARMOUR
 
         If Not UserList(Userindex).POS.Map = 7 Or UserList(Userindex).POS.Map = 88 Then 'retos monturas
         If UserList(Userindex).flags.Navegando = 1 Then Exit Sub
         End If
         
         Select Case Obj.SubTipo
         
            Case OBJTYPE_ARMADURA
            
                If Not RazaPuedeUsarItem(Userindex, OBJIndex) Then
                    Call SendData(ToIndex, Userindex, 0, "8W")
                    Exit Sub
                End If
                
                If Not SexoPuedeUsarItem(Userindex, OBJIndex) Then
                    Call SendData(ToIndex, Userindex, 0, "8W")
                    Exit Sub
                End If
                 
                If ObjData(OBJIndex).Real = 0 And ObjData(OBJIndex).Caos = 0 Then
                    If Not ClasePuedeUsarItem(Userindex, OBJIndex) Then
                        Call SendData(ToIndex, Userindex, 0, "2X")
                        Exit Sub
                    End If
                Else
                    If Not FaccionPuedeUsarItem(Userindex, OBJIndex) Then
                        Call SendData(ToIndex, Userindex, 0, "%?")
                        Exit Sub
                    End If
                    If Not FaccionClasePuedeUsarItem(Userindex, OBJIndex) Then
                        Call SendData(ToIndex, Userindex, 0, "||Tu clase o raza no puede usar ese objeto." & FONTTYPE_INFO)
                        Exit Sub
                    End If
                End If
                
                If Not SkillPuedeUsarItem(Userindex, OBJIndex) Then
                    Call SendData(ToIndex, Userindex, 0, "7W")
                    Exit Sub
                End If
                   
               
                If UserList(Userindex).Invent.Object(Slot).Equipped Then
                    Call Desequipar(Userindex, Slot)
                    Exit Sub
                End If
        
                
                If UserList(Userindex).Invent.ArmourEqpObjIndex Then
                    Call Desequipar(Userindex, UserList(Userindex).Invent.ArmourEqpSlot)
                End If
                
        
                
                UserList(Userindex).Invent.Object(Slot).Equipped = 1
                UserList(Userindex).Invent.ArmourEqpObjIndex = UserList(Userindex).Invent.Object(Slot).OBJIndex
                UserList(Userindex).Invent.ArmourEqpSlot = Slot
                    
                UserList(Userindex).flags.Desnudo = 0
                
                   If UserList(Userindex).flags.Transformado = 0 And UserList(Userindex).flags.Transformadodeath = 0 Then Call ChangeUserBody(ToMap, 0, UserList(Userindex).POS.Map, Userindex, Obj.Ropaje)

             
                Call EquiparItem(Userindex, Slot)

            Case OBJTYPE_CASCO
            
                 If Not ClasePuedeUsarItem(Userindex, OBJIndex) Then
                      Call SendData(ToIndex, Userindex, 0, "2X")
                      Exit Sub
                 End If
                
                 If Not SkillPuedeUsarItem(Userindex, OBJIndex) Then
                     Call SendData(ToIndex, Userindex, 0, "7W")
                     Exit Sub
                 End If
                 
                If UserList(Userindex).Invent.Object(Slot).Equipped Then
                    Call Desequipar(Userindex, Slot)
                    Exit Sub
                End If
        
                
                If UserList(Userindex).Invent.CascoEqpObjIndex Then
                    Call Desequipar(Userindex, UserList(Userindex).Invent.CascoEqpSlot)
                End If
        
                
                
                UserList(Userindex).Invent.Object(Slot).Equipped = 1
                UserList(Userindex).Invent.CascoEqpObjIndex = UserList(Userindex).Invent.Object(Slot).OBJIndex
                UserList(Userindex).Invent.CascoEqpSlot = Slot
            
                 If UserList(Userindex).flags.Transformado = 0 And UserList(Userindex).flags.Transformadodeath = 0 Then Call ChangeUserCasco(ToMap, 0, UserList(Userindex).POS.Map, Userindex, Obj.CascoAnim)
                Call EquiparItem(Userindex, Slot)
                
            Case OBJTYPE_ESCUDO
            
                If Not ClasePuedeUsarItem(Userindex, OBJIndex) Then
                    Call SendData(ToIndex, Userindex, 0, "2X")
                    Exit Sub
                End If
                
                If Not SkillPuedeUsarItem(Userindex, OBJIndex) Then
                    Call SendData(ToIndex, Userindex, 0, "7W")
                    Exit Sub
                End If
                
                If UserList(Userindex).Invent.Object(Slot).Equipped Then
                    Call Desequipar(Userindex, Slot)
                    Exit Sub
                End If
                
                
                If UserList(Userindex).Invent.Object(Slot).Equipped Then
                    Call Desequipar(Userindex, Slot)
                    Exit Sub
                End If
        
                
                If UserList(Userindex).Invent.EscudoEqpObjIndex Then Call Desequipar(Userindex, UserList(Userindex).Invent.EscudoEqpSlot)
        
                
                
                UserList(Userindex).Invent.Object(Slot).Equipped = 1
                UserList(Userindex).Invent.EscudoEqpObjIndex = UserList(Userindex).Invent.Object(Slot).OBJIndex
                UserList(Userindex).Invent.EscudoEqpSlot = Slot
                
                If ObjData(UserList(Userindex).Invent.WeaponEqpObjIndex).proyectil Then
                    Call Desequipar(Userindex, UserList(Userindex).Invent.WeaponEqpSlot)
                    Call ChangeUserArma(ToMap, 0, UserList(Userindex).POS.Map, Userindex, 0)
                End If
            
                 If UserList(Userindex).flags.Transformado = 0 And UserList(Userindex).flags.Transformadodeath = 0 Then Call ChangeUserEscudo(ToMap, 0, UserList(Userindex).POS.Map, Userindex, Obj.ShieldAnim)
                Call EquiparItem(Userindex, Slot)

        End Select
End Select


Exit Sub
errhandler:
Call LogError("EquiparInvItem Slot:" & Slot)
End Sub

Private Function CheckRazaUsaRopa(Userindex As Integer, ItemIndex As Integer) As Boolean
On Error GoTo errhandler


If UserList(Userindex).Raza = HUMANO Or _
   UserList(Userindex).Raza = ELFO Or _
   UserList(Userindex).Raza = ELFO_OSCURO Then
        CheckRazaUsaRopa = (ObjData(ItemIndex).RazaEnana = 0)
Else
        CheckRazaUsaRopa = (ObjData(ItemIndex).RazaEnana = 1)
End If


Exit Function
errhandler:
    Call LogError("Error CheckRazaUsaRopa ItemIndex:" & ItemIndex)

End Function
Sub SacarModoTrabajo(Userindex As Integer)

UserList(Userindex).flags.Trabajando = 0
UserList(Userindex).TrabajoPos.X = 0
UserList(Userindex).TrabajoPos.y = 0
UserList(Userindex).flags.CodigoTrabajo = 0

Call SendData(ToIndex, Userindex, 0, "%I")
Call SendData(ToIndex, Userindex, 0, "MT")

End Sub
Sub UseInvItem(Userindex As Integer, Slot As Byte, ByVal Click As Byte)
Dim Obj As ObjData
Dim OBJIndex As Integer
Dim TargObj As ObjData
Dim MiObj As Obj

Obj = ObjData(UserList(Userindex).Invent.Object(Slot).OBJIndex)

If Obj.Newbie = 1 And Not EsNewbie(Userindex) Then
    Call SendData(ToIndex, Userindex, 0, "6W")
    Exit Sub
End If

If ObjData(UserList(Userindex).Invent.Object(Slot).OBJIndex).Itemtemplario = 1 Then
If UserList(Userindex).flags.Templario = 0 Then
Call SendData(ToIndex, Userindex, 0, "||Solo los templarios pueden usar este pasaje." & FONTTYPE_INFO)
Exit Sub
End If
End If


OBJIndex = UserList(Userindex).Invent.Object(Slot).OBJIndex
UserList(Userindex).flags.TargetObjInvIndex = OBJIndex
UserList(Userindex).flags.TargetObjInvslot = Slot

Select Case Obj.ObjType

    Case OBJTYPE_USEONCE
        If UserList(Userindex).flags.Muerto Then
            Call SendData(ToIndex, Userindex, 0, "MU")
            Exit Sub
        End If

        Call AddtoVar(UserList(Userindex).Stats.MinHam, Obj.MinHam, UserList(Userindex).Stats.MaxHam)
        UserList(Userindex).flags.Hambre = 0
        
        Call QuitarComida(Userindex, Slot)
            
    Case OBJTYPE_GUITA
        If UserList(Userindex).flags.Muerto Then
            Call SendData(ToIndex, Userindex, 0, "MU")
            Exit Sub
        End If
        
        UserList(Userindex).Stats.GLD = UserList(Userindex).Stats.GLD + UserList(Userindex).Invent.Object(Slot).Amount
        UserList(Userindex).Invent.Object(Slot).Amount = 0
        UserList(Userindex).Invent.Object(Slot).OBJIndex = 0
        UserList(Userindex).Invent.NroItems = UserList(Userindex).Invent.NroItems - 1
        Call SendUserORO(Userindex)
        
    Case OBJTYPE_WEAPON
        If UserList(Userindex).flags.Muerto Then
            Call SendData(ToIndex, Userindex, 0, "MU")
            Exit Sub
        End If

        If ObjData(OBJIndex).proyectil = 1 Then
            If TiempoTranscurrido(UserList(Userindex).Counters.LastFlecha) < IntervaloUserFlechas Then Exit Sub
            If TiempoTranscurrido(UserList(Userindex).Counters.LastHechizo) < IntervaloUserPuedeHechiGolpe Then Exit Sub
            Call SendData(ToIndex, Userindex, 0, "T01" & Proyectiles)
        Else
            If UserList(Userindex).flags.TargetObj = 0 Then Exit Sub
            If ObjData(UserList(Userindex).flags.TargetObj).ObjType = OBJTYPE_LEÑA And UserList(Userindex).Invent.Object(Slot).OBJIndex = DAGA Then Call TratarDeHacerFogata(UserList(Userindex).flags.TargetObjMap, UserList(Userindex).flags.TargetObjX, UserList(Userindex).flags.TargetObjY, Userindex)
        End If
        
    Case OBJTYPE_POCIONES
        If TiempoTranscurrido(UserList(Userindex).Counters.LastGolpe) < (IntervaloUserPuedeAtacar / 2) Then
            Call SendData(ToIndex, Userindex, 0, "6X")
            Exit Sub
        End If
                
        If UserList(Userindex).flags.Muerto Then
            Call SendData(ToIndex, Userindex, 0, "MU")
            Exit Sub
        End If
                
       

        Select Case Obj.TipoPocion
        
            Case 1
                UserList(Userindex).flags.DuracionEfecto = Timer
                UserList(Userindex).flags.TomoPocion = True
                
                Call AddtoVar(UserList(Userindex).Stats.UserAtributos(Agilidad), RandomNumber(Obj.MinModificador, Obj.MaxModificador), Minimo(UserList(Userindex).Stats.UserAtributosBackUP(Agilidad) * 2, MAXATRIBUTOS))
                Call UpdateFuerzaYAg(Userindex)
                
                Call QuitarPocion(Userindex, Slot)
                
        
            Case 2
                UserList(Userindex).flags.DuracionEfecto = Timer
                UserList(Userindex).flags.TomoPocion = True
                
                Call AddtoVar(UserList(Userindex).Stats.UserAtributos(fuerza), RandomNumber(Obj.MinModificador, Obj.MaxModificador), Minimo(UserList(Userindex).Stats.UserAtributosBackUP(fuerza) * 2, MAXATRIBUTOS))
                Call UpdateFuerzaYAg(Userindex)
                
                Call QuitarPocion(Userindex, Slot)
                
            Case 3
                
                
                AddtoVar UserList(Userindex).Stats.MinHP, RandomNumber(Obj.MinModificador, Obj.MaxModificador), UserList(Userindex).Stats.MaxHP
                
                Call QuitarPocionVida(Userindex, Slot)
                
            
            Case 4
                
                Call AddtoVar(UserList(Userindex).Stats.MinMAN, Porcentaje(UserList(Userindex).Stats.MaxMAN, Obj.MaxModificador), UserList(Userindex).Stats.MaxMAN)
                
                Call QuitarPocionMana(Userindex, Slot)
            Case 5
                If UserList(Userindex).flags.Envenenado = 1 Then
                    UserList(Userindex).flags.Envenenado = 0
                    Call SendData(ToIndex, Userindex, 0, "8X")
                End If
                
                Call QuitarPocion(Userindex, Slot)
                   
       End Select
       
     Case OBJTYPE_BEBIDA
        If UserList(Userindex).flags.Muerto Then
            Call SendData(ToIndex, Userindex, 0, "MU")
            Exit Sub
        End If
        AddtoVar UserList(Userindex).Stats.MinAGU, Obj.MinSed, UserList(Userindex).Stats.MaxAGU
        UserList(Userindex).flags.Sed = 0
        
        
        Call QuitarBebida(Userindex, Slot)
    
    Case OBJTYPE_LLAVES
        If UserList(Userindex).flags.Muerto Then
            Call SendData(ToIndex, Userindex, 0, "MU")
            Exit Sub
        End If
        
        If UserList(Userindex).flags.TargetObj = 0 Then Exit Sub
        TargObj = ObjData(UserList(Userindex).flags.TargetObj)
        
        If TargObj.ObjType = OBJTYPE_PUERTAS Then
            
            If TargObj.Cerrada = 1 Then
                  
                  If TargObj.Llave Then
                     If TargObj.Clave = Obj.Clave Then
         
                        MapData(UserList(Userindex).flags.TargetObjMap, UserList(Userindex).flags.TargetObjX, UserList(Userindex).flags.TargetObjY).OBJInfo.OBJIndex _
                        = ObjData(MapData(UserList(Userindex).flags.TargetObjMap, UserList(Userindex).flags.TargetObjX, UserList(Userindex).flags.TargetObjY).OBJInfo.OBJIndex).IndexCerrada
                        UserList(Userindex).flags.TargetObj = MapData(UserList(Userindex).flags.TargetObjMap, UserList(Userindex).flags.TargetObjX, UserList(Userindex).flags.TargetObjY).OBJInfo.OBJIndex
                        Call SendData(ToIndex, Userindex, 0, "9X")
                        Exit Sub
                     Else
                        Call SendData(ToIndex, Userindex, 0, "2Y")
                        Exit Sub
                     End If
                  Else
                     If TargObj.Clave = Obj.Clave Then
                        MapData(UserList(Userindex).flags.TargetObjMap, UserList(Userindex).flags.TargetObjX, UserList(Userindex).flags.TargetObjY).OBJInfo.OBJIndex _
                        = ObjData(MapData(UserList(Userindex).flags.TargetObjMap, UserList(Userindex).flags.TargetObjX, UserList(Userindex).flags.TargetObjY).OBJInfo.OBJIndex).IndexCerradaLlave
                        Call SendData(ToIndex, Userindex, 0, "3Y")
                        UserList(Userindex).flags.TargetObj = MapData(UserList(Userindex).flags.TargetObjMap, UserList(Userindex).flags.TargetObjX, UserList(Userindex).flags.TargetObjY).OBJInfo.OBJIndex
                        Exit Sub
                     Else
                        Call SendData(ToIndex, Userindex, 0, "2Y")
                        Exit Sub
                     End If
                  End If
            Else
                  Call SendData(ToIndex, Userindex, 0, "4Y")
                  Exit Sub
            End If
            
        End If
    
    Case OBJTYPE_BOTELLAVACIA
        If UserList(Userindex).flags.Muerto Then
            Call SendData(ToIndex, Userindex, 0, "MU")
            Exit Sub
        End If
        If MapData(UserList(Userindex).POS.Map, UserList(Userindex).flags.TargetX, UserList(Userindex).flags.TargetY).Agua = 0 Then
            Call SendData(ToIndex, Userindex, 0, "9F")
            Exit Sub
        End If
        MiObj.Amount = 1
        MiObj.OBJIndex = ObjData(UserList(Userindex).Invent.Object(Slot).OBJIndex).IndexAbierta
        Call QuitarUnItem(Userindex, Slot)
        If Not MeterItemEnInventario(Userindex, MiObj) Then
            Call TirarItemAlPiso(UserList(Userindex).POS, MiObj)
        End If
            
    Case OBJTYPE_BOTELLALLENA
        If UserList(Userindex).flags.Muerto Then
            Call SendData(ToIndex, Userindex, 0, "MU")
            Exit Sub
        End If
        AddtoVar UserList(Userindex).Stats.MinAGU, Obj.MinSed, UserList(Userindex).Stats.MaxAGU
        UserList(Userindex).flags.Sed = 0
        Call EnviarHyS(Userindex)
        MiObj.Amount = 1
        MiObj.OBJIndex = ObjData(UserList(Userindex).Invent.Object(Slot).OBJIndex).IndexCerrada
        Call QuitarUnItem(Userindex, Slot)
        If Not MeterItemEnInventario(Userindex, MiObj) Then
            Call TirarItemAlPiso(UserList(Userindex).POS, MiObj)
        End If
             
    Case OBJTYPE_HERRAMIENTAS

        If UserList(Userindex).flags.Muerto Then
            Call SendData(ToIndex, Userindex, 0, "MU")
            Exit Sub
        End If
        
        If UserList(Userindex).Stats.MinSta = 0 Then
            Call SendData(ToIndex, Userindex, 0, "9E")
            Exit Sub
        End If

        If UserList(Userindex).Invent.Object(Slot).Equipped = 0 Then
            Call SendData(ToIndex, Userindex, 0, "%J")
            Exit Sub
        End If
        
        If UserList(Userindex).flags.Trabajando Then
            Call SendData(ToIndex, Userindex, 0, "%K")
            Exit Sub
        End If
        
        Select Case OBJIndex
            Case OBJTYPE_CAÑA, RED_PESCA
                Call SendData(ToIndex, Userindex, 0, "T01" & Pesca)
            Case HACHA_LEÑADOR
                Call SendData(ToIndex, Userindex, 0, "T01" & Talar)
            Case PIQUETE_MINERO, PICO_EXPERTO
                Call SendData(ToIndex, Userindex, 0, "T01" & Mineria)
            Case MARTILLO_HERRERO
                Call SendData(ToIndex, Userindex, 0, "T01" & Herreria)
            Case SERRUCHO_CARPINTERO
                Call EnviarObjConstruibles(Userindex)
                Call SendData(ToIndex, Userindex, 0, "SFC")
            Case HILAR_SASTRE
                Call EnviarRopasConstruibles(Userindex)
                Call SendData(ToIndex, Userindex, 0, "SFS")
                
        End Select

     Case OBJTYPE_WARP
    
        If UserList(Userindex).flags.Muerto Then
            Call SendData(ToIndex, Userindex, 0, "MU" & FONTTYPE_INFO)
            Exit Sub
        End If
        If Not UserList(Userindex).flags.TargetNpcTipo = 6 Then
               Call SendData(ToIndex, Userindex, 0, "5Y")
               Exit Sub
        Else
               If Distancia(Npclist(UserList(Userindex).flags.TargetNpc).POS, UserList(Userindex).POS) > 4 Then
                    Call SendData(ToIndex, Userindex, 0, "6Y")
                    Exit Sub
               Else
                    If val(Obj.WI) = val(UserList(Userindex).POS.Map) Then
                        Call WarpUserChar(Userindex, Obj.WMapa, Obj.WX, Obj.WY, True)
                        Call QuitarUserInvItem(Userindex, Slot, 1)
                        Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "TW" & SND_WARP)
                        Call UpdateUserInv(False, Userindex, Slot)
                    Else
                        Call WarpUserChar(Userindex, Obj.WMapa, Obj.WX, Obj.WY, True)
                        Call QuitarUserInvItem(Userindex, Slot, 1)
                        Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "TW" & SND_WARP)
                        Call UpdateUserInv(False, Userindex, Slot)
                        'Call SendData(ToIndex, UserIndex, 0, "3Q" & vbWhite & "°" & "Ese pasaje no te lo he vendido yo, lárgate!" & "°" & str(Npclist(UserList(UserIndex).flags.TargetNpc).Char.CharIndex))
                        Exit Sub
                    End If
               End If
        End If
        
        Case OBJTYPE_PERGAMINOS
            If UserList(Userindex).flags.Muerto Then
                Call SendData(ToIndex, Userindex, 0, "MU")
                Exit Sub
            End If
            
            If Not ClasePuedeHechizo(Userindex, UserList(Userindex).Invent.Object(Slot).OBJIndex) Then
                Call SendData(ToIndex, Userindex, 0, "||Tu clase no puede aprender este hechizo." & FONTTYPE_INFO)
                Exit Sub
            End If
            
            If UserList(Userindex).flags.Hambre = 0 And _
               UserList(Userindex).flags.Sed = 0 Then
                Call AgregarHechizo(Userindex, Slot)
                Call UpdateUserInv(False, Userindex, Slot)
            Else
               Call SendData(ToIndex, Userindex, 0, "7F")
            End If
       
       Case OBJTYPE_MINERALES
           If UserList(Userindex).flags.Muerto Then
                Call SendData(ToIndex, Userindex, 0, "MU")
                Exit Sub
           End If
           Call SendData(ToIndex, Userindex, 0, "T01" & FundirMetal)
       
       Case OBJTYPE_INSTRUMENTOS
            If UserList(Userindex).flags.Muerto Then
                Call SendData(ToIndex, Userindex, 0, "MU")
                Exit Sub
            End If
            Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "TW" & Obj.Snd1)
       
       Case OBJTYPE_BARCOS
               If UserList(Userindex).flags.Montado = 1 Then Exit Sub
           If UserList(Userindex).POS.Map = 7 Or UserList(Userindex).POS.Map = 88 Then Exit Sub 'retos monturas
        If ((LegalPos(UserList(Userindex).POS.Map, UserList(Userindex).POS.X - 1, UserList(Userindex).POS.y, True) Or _
            LegalPos(UserList(Userindex).POS.Map, UserList(Userindex).POS.X, UserList(Userindex).POS.y - 1, True) Or _
            LegalPos(UserList(Userindex).POS.Map, UserList(Userindex).POS.X + 1, UserList(Userindex).POS.y, True) Or _
            LegalPos(UserList(Userindex).POS.Map, UserList(Userindex).POS.X, UserList(Userindex).POS.y + 1, True)) And _
            UserList(Userindex).flags.Navegando = 0) _
            Or UserList(Userindex).flags.Navegando = 1 Then
                Call DoNavega(Userindex, CInt(Slot))
        Else
            Call SendData(ToIndex, Userindex, 0, "2G")
        End If
           
End Select

End Sub
Sub EnviarArmasConstruibles(Userindex As Integer)
Dim i As Integer, cad As String
Dim Descuento As Single

If UserList(Userindex).Clase = HERRERO And UserList(Userindex).Recompensas(3) = 1 Then
    Descuento = 0.75
Else: Descuento = 1
End If

For i = 1 To UBound(ArmasHerrero)
    If ObjData(ArmasHerrero(i).Index).SkHerreria <= UserList(Userindex).Stats.UserSkills(Herreria) / ModHerreriA(UserList(Userindex).Clase) Then
        If ArmasHerrero(i).Recompensa = 0 Or UserList(Userindex).Recompensas(2) = 1 Then
            cad = cad & ObjData(ArmasHerrero(i).Index).Name & " (" & ObjData(ArmasHerrero(i).Index).MinHit & "/" & ObjData(ArmasHerrero(i).Index).MaxHit & ")" & " - (" & Int(val(ObjData(ArmasHerrero(i).Index).LingH * Descuento) * ModMateriales(UserList(Userindex).Clase)) & "/" & Int(val(ObjData(ArmasHerrero(i).Index).LingP * Descuento) * ModMateriales(UserList(Userindex).Clase)) & "/" & Int(val(ObjData(ArmasHerrero(i).Index).LingO * Descuento) * ModMateriales(UserList(Userindex).Clase)) & ")" _
            & "," & ArmasHerrero(i).Index & ","
        End If
    End If
Next

Call SendData(ToIndex, Userindex, 0, "LAH" & cad)

End Sub
Sub EnviarObjConstruibles(Userindex As Integer)
Dim i As Integer, cad As String, Coste As Integer

For i = 1 To UBound(ObjCarpintero)
    If ObjData(ObjCarpintero(i).Index).SkCarpinteria <= UserList(Userindex).Stats.UserSkills(Carpinteria) / ModCarpinteria(UserList(Userindex).Clase) Then
        If ObjCarpintero(i).Recompensa = 0 Or (UserList(Userindex).Clase = CARPINTERO And UserList(Userindex).Recompensas(1) = ObjCarpintero(i).Recompensa) Then
            Coste = ObjData(ObjCarpintero(i).Index).Madera
            If UserList(Userindex).Clase = CARPINTERO And UserList(Userindex).Recompensas(2) = 2 And ObjData(ObjCarpintero(i).Index).ObjType = OBJTYPE_BARCOS Then Coste = Coste * 0.8
            cad = cad & ObjData(ObjCarpintero(i).Index).Name & " (" & CLng(Coste * ModMadera(UserList(Userindex).Clase)) & ") - (" & CLng(val(ObjData(ObjCarpintero(i).Index).MaderaElfica) * ModMadera(UserList(Userindex).Clase)) & ")" & "," & ObjCarpintero(i).Index & ","
        End If
    End If
Next

Call SendData(ToIndex, Userindex, 0, "OBR" & cad)

End Sub
Sub EnviarRopasConstruibles(Userindex As Integer)
Dim PielP As Integer, PielL As Integer, PielO As Integer
Dim N As Integer

Dim i As Integer, cad As String
N = val(GetVar(DatPath & "ObjSastre.dat", "INIT", "NumObjs"))

For i = 1 To UBound(ObjSastre)
    If ObjData(ObjSastre(i)).SkSastreria <= UserList(Userindex).Stats.UserSkills(Sastreria) / ModRopas(UserList(Userindex).Clase) Then
        PielP = ObjData(ObjSastre(i)).PielOsoPolar
        PielL = ObjData(ObjSastre(i)).PielLobo
        PielO = ObjData(ObjSastre(i)).PielOsoPardo
        If UserList(Userindex).Clase = SASTRE And UserList(Userindex).Stats.ELV >= 18 Then
            PielL = PielL * 0.8
            PielO = PielO * 0.8
            PielP = PielP * 0.8
        End If
        cad = cad & ObjData(ObjSastre(i)).Name & " (" & ObjData(ObjSastre(i)).MinDef & "/" & ObjData(ObjSastre(i)).MaxDef & ")" & " - (" & CLng(PielL * ModSastre(UserList(Userindex).Clase)) & "/" & CLng(PielO * ModSastre(UserList(Userindex).Clase)) & "/" & CLng(PielP * ModSastre(UserList(Userindex).Clase)) & ")" & "," & ObjSastre(i) & ","
    End If
Next

Call SendData(ToIndex, Userindex, 0, "SAR" & cad)

End Sub
Sub EnviarArmadurasConstruibles(Userindex As Integer)
Dim i As Integer, cad As String
Dim Descuento As Single

If UserList(Userindex).Clase = HERRERO And UserList(Userindex).Recompensas(3) = 1 Then
    Descuento = 0.75
Else: Descuento = 1
End If

For i = 1 To UBound(ArmadurasHerrero)
    If ObjData(ArmadurasHerrero(i).Index).SkHerreria <= UserList(Userindex).Stats.UserSkills(Herreria) / ModHerreriA(UserList(Userindex).Clase) Then
        If ArmadurasHerrero(i).Recompensa = 0 Or UserList(Userindex).Recompensas(2) = 2 Then
            cad = cad & ObjData(ArmadurasHerrero(i).Index).Name & " (" & ObjData(ArmadurasHerrero(i).Index).MinDef & "/" & ObjData(ArmadurasHerrero(i).Index).MaxDef & ")" & " - (" & Int(val(ObjData(ArmadurasHerrero(i).Index).LingH * Descuento) * ModMateriales(UserList(Userindex).Clase)) & "/" & Int(val(ObjData(ArmadurasHerrero(i).Index).LingP * Descuento) * ModMateriales(UserList(Userindex).Clase)) & "/" & Int(val(ObjData(ArmadurasHerrero(i).Index).LingO * Descuento) * ModMateriales(UserList(Userindex).Clase)) & ")" _
            & "," & ArmadurasHerrero(i).Index & ","
        End If
    End If
Next

Call SendData(ToIndex, Userindex, 0, "LAR" & cad)


End Sub
Sub EnviarCascosConstruibles(Userindex As Integer)
Dim i As Integer, cad As String
Dim Descuento As Single

If UserList(Userindex).Clase = HERRERO And UserList(Userindex).Recompensas(1) = 2 Then
    Descuento = 0.5
Else: Descuento = 1
End If

For i = 1 To UBound(CascosHerrero)
    If ObjData(CascosHerrero(i)).SkHerreria <= UserList(Userindex).Stats.UserSkills(Herreria) / ModHerreriA(UserList(Userindex).Clase) Then
        cad = cad & ObjData(CascosHerrero(i)).Name & " (" & ObjData(CascosHerrero(i)).MinDef & "/" & ObjData(CascosHerrero(i)).MaxDef & ")" & " - (" & Int(val(ObjData(CascosHerrero(i)).LingH * Descuento) * ModMateriales(UserList(Userindex).Clase)) & "/" & Int(val(ObjData(CascosHerrero(i)).LingP * Descuento) * ModMateriales(UserList(Userindex).Clase)) & "/" & Int(val(ObjData(CascosHerrero(i)).LingO * Descuento) * ModMateriales(UserList(Userindex).Clase)) & ")" _
        & "," & CascosHerrero(i) & ","
    End If
Next

Call SendData(ToIndex, Userindex, 0, "CAS" & cad)

End Sub
Sub EnviarEscudosConstruibles(Userindex As Integer)
Dim i As Integer, cad As String
Dim Descuento As Single

If UserList(Userindex).Clase = HERRERO And UserList(Userindex).Recompensas(1) = 2 Then
    Descuento = 0.5
Else: Descuento = 1
End If

For i = 1 To UBound(EscudosHerrero)
    If ObjData(EscudosHerrero(i)).SkHerreria <= UserList(Userindex).Stats.UserSkills(Herreria) / ModHerreriA(UserList(Userindex).Clase) Then
        cad = cad & ObjData(EscudosHerrero(i)).Name & " (" & ObjData(EscudosHerrero(i)).MinDef & "/" & ObjData(EscudosHerrero(i)).MaxDef & ") - (" & Int(val(ObjData(EscudosHerrero(i)).LingH * Descuento) * ModMateriales(UserList(Userindex).Clase)) & "/" & Int(val(ObjData(EscudosHerrero(i)).LingP * Descuento) * ModMateriales(UserList(Userindex).Clase)) & "/" & Int(val(ObjData(EscudosHerrero(i)).LingO * Descuento) * ModMateriales(UserList(Userindex).Clase)) & ")" _
        & "," & EscudosHerrero(i) & ","
    End If
Next

Call SendData(ToIndex, Userindex, 0, "ESC" & cad)



End Sub
Sub TirarTodo(Userindex As Integer)
On Error Resume Next

Call TirarTodosLosItems(Userindex)
Call TirarOro(UserList(Userindex).Stats.GLD, Userindex)

End Sub
Public Function ItemSeCae(Index As Integer) As Boolean

ItemSeCae = (ObjData(Index).Real = 0 And _
            ObjData(Index).Caos = 0 And _
            ObjData(Index).ObjType <> OBJTYPE_LLAVES And _
            ObjData(Index).ObjType <> OBJTYPE_BARCOS And _
            Not ObjData(Index).NoSeCae)

End Function
Sub TirarTodosLosItems(Userindex As Integer)

Dim i As Byte
Dim NuevaPos As WorldPos
Dim MiObj As Obj
Dim ItemIndex As Integer
Dim PosibilidadesZafa As Integer
Dim ZafaMinerales As Boolean

If MapInfo(UserList(Userindex).POS.Map).EsMapaEspecial Then Exit Sub



If UserList(Userindex).Clase = PIRATA And UserList(Userindex).Recompensas(2) = 1 And CInt(RandomNumber(1, 10)) <= 1 Then Exit Sub

If UserList(Userindex).Clase = MINERO Then
    If UserList(Userindex).Recompensas(1) = 2 Then PosibilidadesZafa = 2
    If UserList(Userindex).Recompensas(3) = 2 Then PosibilidadesZafa = PosibilidadesZafa + 3
    ZafaMinerales = CInt(RandomNumber(1, 10)) <= PosibilidadesZafa
End If


'sacri
 For i = 1 To MAX_INVENTORY_SLOTS
        If UserList(Userindex).Invent.Object(i).OBJIndex = SacriIndex Then
            If DestruirSacri = 0 Then
                NuevaPos.X = 0: NuevaPos.y = 0
                MiObj.Amount = UserList(Userindex).Invent.Object(i).Amount: MiObj.OBJIndex = SacriIndex
                Call Tilelibre(UserList(Userindex).POS, NuevaPos)
                If NuevaPos.X <> 0 And NuevaPos.y <> 0 Then Call DropObj(Userindex, i, 1, NuevaPos.Map, NuevaPos.X, NuevaPos.y)
            Else
                Call QuitarUserInvItem(Userindex, i, 1)
                Call UpdateUserInv(False, Userindex, i)
                Call CiudadNatal(Userindex)
            End If
            Exit Sub
        End If
    Next i
'sacri

For i = 1 To MAX_INVENTORY_SLOTS
    ItemIndex = UserList(Userindex).Invent.Object(i).OBJIndex
    If ItemIndex Then
        If ItemSeCae(ItemIndex) And Not (ObjData(ItemIndex).ObjType = OBJTYPE_MINERALES And ZafaMinerales) Then
            NuevaPos.X = 0
            NuevaPos.y = 0
            Call Tilelibre(UserList(Userindex).POS, NuevaPos)
            If NuevaPos.X <> 0 And NuevaPos.y Then
                If MapData(NuevaPos.Map, NuevaPos.X, NuevaPos.y).OBJInfo.OBJIndex = 0 Then Call DropObj(Userindex, i, MAX_INVENTORY_OBJS, NuevaPos.Map, NuevaPos.X, NuevaPos.y)
            End If
        End If
  End If
  
Next

If UserList(Userindex).POS.Map = 198 Then
Call WarpUserChar(Userindex, 1, 50, 50)
End If

End Sub
Function ItemNewbie(ItemIndex As Integer) As Boolean

ItemNewbie = ObjData(ItemIndex).Newbie = 1

End Function
Sub TirarTodosLosItemsNoNewbies(Userindex As Integer)
Dim i As Byte
Dim NuevaPos As WorldPos
Dim MiObj As Obj
Dim ItemIndex As Integer

For i = 1 To MAX_INVENTORY_SLOTS
  ItemIndex = UserList(Userindex).Invent.Object(i).OBJIndex
  If ItemIndex Then
         If ItemSeCae(ItemIndex) And Not ItemNewbie(ItemIndex) Then
                NuevaPos.X = 0
                NuevaPos.y = 0
                Tilelibre UserList(Userindex).POS, NuevaPos
                If NuevaPos.X <> 0 And NuevaPos.y Then
                    If MapData(NuevaPos.Map, NuevaPos.X, NuevaPos.y).OBJInfo.OBJIndex = 0 Then Call DropObj(Userindex, i, MAX_INVENTORY_OBJS, NuevaPos.Map, NuevaPos.X, NuevaPos.y)
                End If
         End If
         
  End If
Next

End Sub
