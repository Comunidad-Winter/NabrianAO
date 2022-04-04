Attribute VB_Name = "Comercio"
 
'director del proyecto: #Esteban(Neliam)

'servidor basado en fénixao 1.0
'medios de contacto:
'Skype: dc.esteban
'E-mail: nabrianao@gmail.com
Option Explicit
Sub UserCompraObj(Userindex As Integer, ByVal OBJIndex As Integer, NpcIndex As Integer, Cantidad As Integer)
Dim Infla As Integer
Dim Desc As Single
Dim unidad As Long, monto As Long
Dim Slot As Byte
Dim ObjI As Integer
Dim Encontre As Boolean

ObjI = Npclist(UserList(Userindex).flags.TargetNpc).Invent.Object(OBJIndex).OBJIndex

If Npclist(UserList(Userindex).flags.TargetNpc).Invent.Object(OBJIndex).OBJIndex = 0 Then Exit Sub 'BUG DUPEO


Call LogBove(UserList(Userindex).Name, UserList(Userindex).Name & " COMPRO:" & Cantidad & " Objeto:" & ObjData(ObjI).Name & " Objeto:" & OBJIndex, False)

Slot = 1
Do Until UserList(Userindex).Invent.Object(Slot).OBJIndex = ObjI And _
   UserList(Userindex).Invent.Object(Slot).Amount + Cantidad <= MAX_INVENTORY_OBJS
    
    Slot = Slot + 1
    If Slot > MAX_INVENTORY_SLOTS Then Exit Do
Loop

If Slot > MAX_INVENTORY_SLOTS Then
    Slot = 1
    Do Until UserList(Userindex).Invent.Object(Slot).OBJIndex = 0
        Slot = Slot + 1

        If Slot > MAX_INVENTORY_SLOTS Then
            Call SendData(ToIndex, Userindex, 0, "5P")
            Exit Sub
        End If
    Loop
    UserList(Userindex).Invent.NroItems = UserList(Userindex).Invent.NroItems + 1
End If

If UserList(Userindex).Invent.Object(Slot).Amount + Cantidad <= MAX_INVENTORY_OBJS Then
    UserList(Userindex).Invent.Object(Slot).OBJIndex = ObjI
    UserList(Userindex).Invent.Object(Slot).Amount = UserList(Userindex).Invent.Object(Slot).Amount + Cantidad
    Infla = (Npclist(NpcIndex).Inflacion * ObjData(ObjI).Valor) \ 100

    Desc = Descuento(Userindex)
    
    unidad = Int(((ObjData(Npclist(NpcIndex).Invent.Object(OBJIndex).OBJIndex).Valor + Infla) / Desc))
    If unidad = 0 Then unidad = 1
    monto = unidad * Cantidad
    UserList(Userindex).Stats.GLD = UserList(Userindex).Stats.GLD - monto
    
    Call SubirSkill(Userindex, Comerciar)
    
    If ObjData(ObjI).ObjType = OBJTYPE_LLAVES Then Call LogVentaCasa(UserList(Userindex).Name & " compro " & ObjData(ObjI).Name)
    Call SendData(ToIndex, Userindex, 0, "||Has comprado: " & ObjData(ObjI).Name & "." & FONTTYPE_TALK)
    Call QuitarNpcInvItem(UserList(Userindex).flags.TargetNpc, CByte(OBJIndex), Cantidad, Userindex)
    
    Call UpdateUserInv(False, Userindex, Slot)
Else
    Call SendData(ToIndex, Userindex, 0, "5P")
End If

End Sub
Sub UpdateNPCInv(UpdateAll As Boolean, Userindex As Integer, NpcIndex As Integer, Slot As Byte)
Dim i As Byte
Dim MiObj As UserOBJ

If UpdateAll Then
    For i = 1 To MAX_NPCINVENTORY_SLOTS
        Call SendNPCItem(Userindex, NpcIndex, i, UpdateAll)
    Next
Else
    Call SendNPCItem(Userindex, NpcIndex, i, UpdateAll)
End If

End Sub
Sub SendNPCItem(Userindex As Integer, NpcIndex As Integer, Slot As Byte, ByVal AllInfo As Boolean)
Dim MiObj As UserOBJ
Dim Infla As Long
Dim Desc As Single
Dim val As Long

MiObj = Npclist(NpcIndex).Invent.Object(Slot)

Desc = Descuento(Userindex)

If Desc >= 0 And Desc <= 1 Then Desc = 1




If MiObj.OBJIndex Then
    If AllInfo Then
        Infla = (Npclist(NpcIndex).Inflacion * ObjData(MiObj.OBJIndex).Valor) / 100
        val = Maximo(1, Int((ObjData(MiObj.OBJIndex).Valor + Infla) / Desc))
        Call SendData(ToIndex, Userindex, 0, "OTII" & Slot _
        & "," & ObjData(MiObj.OBJIndex).Name _
        & "," & MiObj.Amount _
        & "," & val _
        & "," & ObjData(MiObj.OBJIndex).GrhIndex _
        & "," & MiObj.OBJIndex _
        & "," & ObjData(MiObj.OBJIndex).ObjType _
        & "," & ObjData(MiObj.OBJIndex).MaxHit _
        & "," & ObjData(MiObj.OBJIndex).MinHit _
        & "," & ObjData(MiObj.OBJIndex).MaxDef _
        & "," & ObjData(MiObj.OBJIndex).MinDef _
        & "," & ObjData(MiObj.OBJIndex).TipoPocion _
        & "," & ObjData(MiObj.OBJIndex).MaxModificador _
        & "," & ObjData(MiObj.OBJIndex).MinModificador _
        & "," & PuedeUsarObjeto(Userindex, MiObj.OBJIndex) _
        & "," & ObjData(MiObj.OBJIndex).Minlvl)
    Else
        Call SendData(ToIndex, Userindex, 0, "OTIC" & Slot & "," & MiObj.Amount)
    End If
Else
    Call SendData(ToIndex, Userindex, 0, "OTIV" & Slot)
End If
  
End Sub
Sub IniciarComercioNPC(Userindex As Integer)
On Error GoTo ErrHandler

Call UpdateNPCInv(True, Userindex, UserList(Userindex).flags.TargetNpc, 0)
Call SendData(ToIndex, Userindex, 0, "INITCOM")
UserList(Userindex).flags.Comerciando = True

ErrHandler:

End Sub
Sub NPCVentaItem(Userindex As Integer, ByVal i As Integer, Cantidad As Integer, NpcIndex As Integer)
On Error GoTo ErrHandler
Dim Infla As Long
Dim val As Long
Dim Desc As Single

If Cantidad < 1 Then Exit Sub


Infla = (Npclist(NpcIndex).Inflacion * ObjData(Npclist(NpcIndex).Invent.Object(i).OBJIndex).Valor) / 100
Desc = Descuento(Userindex)

val = Fix((ObjData(Npclist(NpcIndex).Invent.Object(i).OBJIndex).Valor + Infla) / Desc)
If val = 0 Then val = 1

If UserList(Userindex).Stats.GLD >= (val * Cantidad) Then
    If Npclist(UserList(Userindex).flags.TargetNpc).Invent.Object(i).Amount > 0 Or Npclist(UserList(Userindex).flags.TargetNpc).InvReSpawn = 0 Then
         If Cantidad > Npclist(UserList(Userindex).flags.TargetNpc).Invent.Object(i).Amount And Npclist(UserList(Userindex).flags.TargetNpc).InvReSpawn = 1 Then Cantidad = Npclist(UserList(Userindex).flags.TargetNpc).Invent.Object(i).Amount
         Call UserCompraObj(Userindex, CInt(i), UserList(Userindex).flags.TargetNpc, Cantidad)
         Call SendUserORO(Userindex)
    End If
Else
    Call SendData(ToIndex, Userindex, 0, "2Q")
    Exit Sub
End If

ErrHandler:

End Sub
Sub NPCCompraItem(Userindex As Integer, ByVal Item As Byte, Cantidad As Integer)
On Error GoTo ErrHandler

If ObjData(UserList(Userindex).Invent.Object(Item).OBJIndex).Newbie = 1 Then
    Call SendData(ToIndex, Userindex, 0, "6P")
    Exit Sub
End If

If ObjData(UserList(Userindex).Invent.Object(Item).OBJIndex).ObjType = OBJTYPE_LEÑA Then
    Call SendData(ToIndex, Userindex, 0, "||No tengo interes en comprar madera." & FONTTYPE_WARNING)
    Exit Sub
End If

If ObjData(UserList(Userindex).Invent.Object(Item).OBJIndex).ObjType = OBJTYPE_BARCOS Then
    Call SendData(ToIndex, Userindex, 0, "||No tengo interes en comprar barcos." & FONTTYPE_WARNING)
    Exit Sub
End If

If ObjData(UserList(Userindex).Invent.Object(Item).OBJIndex).NoSeCae = 1 Or ObjData(UserList(Userindex).Invent.Object(Item).OBJIndex).Real > 0 Or ObjData(UserList(Userindex).Invent.Object(Item).OBJIndex).Caos > 0 Or ObjData(UserList(Userindex).Invent.Object(Item).OBJIndex).Newbie = 1 Then
    Call SendData(ToIndex, Userindex, 0, "||No puedes vender este item." & FONTTYPE_WARNING)
    Exit Sub
End If

 Call LogBove(UserList(Userindex).Name, UserList(Userindex).Name & " VENDIO:" & Cantidad & " Objeto:" & Item, False)

If UserList(Userindex).Invent.Object(Item).Amount > 0 And UserList(Userindex).Invent.Object(Item).Equipped = 0 Then
    If Cantidad > 0 And Cantidad > UserList(Userindex).Invent.Object(Item).Amount Then Cantidad = UserList(Userindex).Invent.Object(Item).Amount
    UserList(Userindex).Invent.Object(Item).Amount = UserList(Userindex).Invent.Object(Item).Amount - Cantidad
    UserList(Userindex).Stats.GLD = UserList(Userindex).Stats.GLD + (ObjData(UserList(Userindex).Invent.Object(Item).OBJIndex).Valor / 3 * Cantidad)
    If UserList(Userindex).Invent.Object(Item).Amount <= 0 Then
        UserList(Userindex).Invent.Object(Item).Amount = 0
        UserList(Userindex).Invent.Object(Item).OBJIndex = 0
        UserList(Userindex).Invent.Object(Item).Equipped = 0
    End If
    Call SubirSkill(Userindex, Comerciar)
    Call UpdateUserInv(False, Userindex, Item)
End If

Call SendUserORO(Userindex)
Exit Sub
ErrHandler:

End Sub
Public Function Descuento(Userindex As Integer) As Single

Descuento = CSng(Minimo(10 + (Fix((UserList(Userindex).Stats.UserSkills(Comerciar) + UserList(Userindex).Stats.UserAtributos(Carisma) - 10) / 10)), 20)) / 10

End Function
