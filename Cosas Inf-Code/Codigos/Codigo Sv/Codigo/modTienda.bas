Attribute VB_Name = "modTienda"
 
'director del proyecto: #Esteban(Neliam)

'servidor basado en fénixao 1.0
'medios de contacto:
'Skype: dc.esteban
'E-mail: nabrianao@gmail.com
Public DineroTotalVentas As Double
Public NumeroVentas As Long

Option Explicit
Sub TiendaVentaItem(Userindex As Integer, ByVal i As Integer, Cantidad As Integer, NpcIndex As Integer)
On Error GoTo ErrHandler
Dim Vendedor As Integer

If Cantidad < 1 Or Npclist(NpcIndex).NPCtype <> NPCTYPE_TIENDA Then Exit Sub


Vendedor = Npclist(NpcIndex).flags.TiendaUser

If UserList(Vendedor).Tienda.Object(i).OBJIndex = 0 Then Exit Sub 'BUG DUPEO

If UserList(Vendedor).Tienda.Object(i).Amount <= 0 Then Exit Sub 'BUG DUPEO

If UserList(Userindex).Stats.GLD >= (UserList(Vendedor).Tienda.Object(i).Precio * Cantidad) Then
    If UserList(Vendedor).Tienda.Object(i).Amount Then
         If Cantidad > UserList(Vendedor).Tienda.Object(i).Amount Then Cantidad = UserList(Vendedor).Tienda.Object(i).Amount
         Call TiendaCompraItem(Userindex, CInt(i), UserList(Userindex).flags.TargetNpc, Cantidad)
         Call SendUserORO(Userindex)
    Else
        Call SendData(ToIndex, Userindex, 0, "OTIV" & i)
    End If
Else
   Call SendData(ToIndex, Userindex, 0, "2Q")
   Exit Sub
End If

ErrHandler:

End Sub
Sub TiendaCompraItem(Userindex As Integer, Slot As Byte, NpcIndex As Integer, Cantidad As Integer)
Dim Vendedor As Integer
Dim ObjI As Integer
Dim Encontre As Boolean
Dim MiObj As Obj

Vendedor = Npclist(NpcIndex).flags.TiendaUser

If (UserList(Vendedor).Tienda.Object(Slot).Amount <= 0) Then Exit Sub

ObjI = UserList(Vendedor).Tienda.Object(Slot).OBJIndex

MiObj.OBJIndex = ObjI
MiObj.Amount = Cantidad

If Not MeterItemEnInventario(Userindex, MiObj) Then
    Call SendData(ToIndex, Userindex, 0, "5P")
    Exit Sub
End If

UserList(Userindex).Stats.GLD = UserList(Userindex).Stats.GLD - UserList(Vendedor).Tienda.Object(Slot).Precio * Cantidad

Call VendedorVenta(Vendedor, CByte(Slot), Cantidad, Userindex)

End Sub
Sub VendedorVenta(Vendedor As Integer, Slot As Byte, Cantidad As Integer, Comprador As Integer)

Call SendData(ToIndex, Vendedor, 0, "/R" & UserList(Comprador).Name & "," & ObjData(UserList(Vendedor).Tienda.Object(Slot).OBJIndex).Name & "," & Cantidad & "," & UserList(Vendedor).Tienda.Object(Slot).Precio * Cantidad)
UserList(Vendedor).Stats.Banco = UserList(Vendedor).Stats.Banco + UserList(Vendedor).Tienda.Object(Slot).Precio * Cantidad
UserList(Vendedor).Tienda.Gold = UserList(Vendedor).Tienda.Gold + UserList(Vendedor).Tienda.Object(Slot).Precio * Cantidad
DineroTotalVentas = DineroTotalVentas + UserList(Vendedor).Tienda.Object(Slot).Precio * Cantidad
NumeroVentas = NumeroVentas + 1

UserList(Vendedor).Tienda.Object(Slot).Amount = UserList(Vendedor).Tienda.Object(Slot).Amount - Cantidad

If UserList(Vendedor).Tienda.Object(Slot).Amount <= 0 Then
    UserList(Vendedor).Tienda.Object(Slot).Amount = 0
    UserList(Vendedor).Tienda.Object(Slot).OBJIndex = 0
    UserList(Vendedor).Tienda.Object(Slot).Precio = 0
    UserList(Vendedor).Tienda.NroItems = UserList(Vendedor).Tienda.NroItems - 1
    If UserList(Vendedor).Tienda.NroItems <= 0 Then
        Npclist(UserList(Vendedor).Tienda.NpcTienda).flags.TiendaUser = 0
        UserList(Vendedor).Tienda.NpcTienda = 0
        Call SendData(ToIndex, Vendedor, 0, "/S")
        Call SendData(ToIndex, Comprador, 0, "FINCOMOK")
        Exit Sub
    End If
End If

Call UpdateTiendaC(False, Comprador, UserList(Vendedor).Tienda.NpcTienda, Slot)

Exit Sub
ErrHandler:

End Sub
Sub IniciarComercioTienda(Userindex As Integer, NpcIndex As Integer)

Call UpdateTiendaC(True, Userindex, NpcIndex, 0)
Call SendData(ToIndex, Userindex, 0, "INITCOM")
UserList(Userindex).flags.Comerciando = True

End Sub
Public Sub IniciarAlquiler(Userindex As Integer)

If Not (ClaseTrabajadora(UserList(Userindex).Clase) And Not EsNewbie(Userindex)) And Not (UserList(Userindex).Stats.ELV >= 25 And UserList(Userindex).Stats.UserSkills(Comerciar) >= 65) Then
    Call SendData(ToIndex, Userindex, 0, "/V" & str(Npclist(UserList(Userindex).flags.TargetNpc).Char.CharIndex))
    Exit Sub
End If

If UserList(Userindex).Tienda.NpcTienda > 0 And UserList(Userindex).Tienda.NpcTienda <> UserList(Userindex).flags.TargetNpc Then
    Call SendData(ToIndex, Userindex, 0, "/W" & str(Npclist(UserList(Userindex).flags.TargetNpc).Char.CharIndex))
    Exit Sub
End If

Call UpdateTiendaV(True, Userindex, 0)
Call SendData(ToIndex, Userindex, 0, "INITIENDA")
UserList(Userindex).flags.Comerciando = True

End Sub
Sub UpdateTiendaV(ByVal UpdateAll As Boolean, Userindex As Integer, Slot As Byte, Optional ByVal TodaInfo As Boolean)
Dim i As Byte

If UpdateAll Then
    For i = 1 To MAX_TIENDA_SLOTS
        Call SendTiendaItemV(Userindex, i, UpdateAll)
    Next
Else
    Call SendTiendaItemV(Userindex, Slot, TodaInfo)
End If

End Sub
Sub SendTiendaItemV(Userindex As Integer, Slot As Byte, TodaInfo As Boolean)
Dim MiObj As TiendaObj

MiObj = UserList(Userindex).Tienda.Object(Slot)

If MiObj.OBJIndex Then
    If TodaInfo Then
        Call SendData(ToIndex, Userindex, 0, "OTII" & Slot _
        & "," & ObjData(MiObj.OBJIndex).Name _
        & "," & MiObj.Amount _
        & "," & MiObj.Precio _
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
        & "," & "0" _
        & "," & ObjData(MiObj.OBJIndex).Minlvl)

    Else
        Call SendData(ToIndex, Userindex, 0, "OTIC " & Slot & "," & MiObj.Amount)
    End If
Else
    Call SendData(ToIndex, Userindex, 0, "OTIV" & Slot)
End If

End Sub
Sub UpdateTiendaC(ByVal UpdateAll As Boolean, Userindex As Integer, NpcIndex As Integer, Slot As Byte)
Dim i As Byte

If UpdateAll Then
    For i = 1 To MAX_TIENDA_SLOTS
        Call SendTiendaItemC(Userindex, NpcIndex, i, UpdateAll)
    Next
Else
    Call SendTiendaItemC(Userindex, NpcIndex, Slot, UpdateAll)
End If

End Sub
Sub SendTiendaItemC(Userindex As Integer, NpcIndex As Integer, Slot As Byte, ByVal TodaInfo As Boolean)
Dim MiObj As TiendaObj

MiObj = UserList(Npclist(NpcIndex).flags.TiendaUser).Tienda.Object(Slot)

If MiObj.OBJIndex Then
    If TodaInfo Then
        Call SendData(ToIndex, Userindex, 0, "OTII" & Slot _
        & "," & ObjData(MiObj.OBJIndex).Name _
        & "," & MiObj.Amount _
        & "," & MiObj.Precio _
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
Sub UserSacaVenta(Userindex As Integer, Slot As Byte, Cantidad As Integer)
On Error GoTo ErrHandler

If UserList(Userindex).Tienda.Object(Slot).Amount Then
    If Cantidad > UserList(Userindex).Tienda.Object(Slot).Amount Then Cantidad = UserList(Userindex).Tienda.Object(Slot).Amount
    Call UserSacaObjVenta(Userindex, CInt(Slot), Cantidad)
End If

Exit Sub
ErrHandler:

End Sub
Sub UserPoneVenta(Userindex As Integer, Slot As Byte, Cantidad As Integer, Precio As Long)
On Error GoTo ErrHandler

If ObjData(UserList(Userindex).Invent.Object(Slot).OBJIndex).Newbie Then
    Call SendData(ToIndex, Userindex, 0, "/H")
    Exit Sub
End If

If ObjData(UserList(Userindex).Invent.Object(Slot).OBJIndex).NoSeCae Then
    Call SendData(ToIndex, Userindex, 0, "||No puedes poner este objeto a la venta." & FONTTYPE_INFO)
    Exit Sub
End If

If ObjData(UserList(Userindex).Invent.Object(Slot).OBJIndex).Caos > 0 Or ObjData(UserList(Userindex).Invent.Object(Slot).OBJIndex).Real Then
    Call SendData(ToIndex, Userindex, 0, "/I")
    Exit Sub
End If

If Precio = 0 Then
    Call SendData(ToIndex, Userindex, 0, "/M")
    Exit Sub
End If

If UserList(Userindex).Tienda.NpcTienda = 0 Then
    UserList(Userindex).Tienda.NpcTienda = UserList(Userindex).flags.TargetNpc
    Npclist(UserList(Userindex).flags.TargetNpc).flags.TiendaUser = Userindex
End If

If UserList(Userindex).Invent.Object(Slot).Amount > 0 And UserList(Userindex).Invent.Object(Slot).Equipped = 0 Then
    If Cantidad > 0 And Cantidad > UserList(Userindex).Invent.Object(Slot).Amount Then Cantidad = UserList(Userindex).Invent.Object(Slot).Amount
    Call UserDaObjVenta(Userindex, CInt(Slot), Cantidad, Precio)
End If

Exit Sub
ErrHandler:

End Sub
Sub UserSacaObjVenta(Userindex As Integer, ByVal Itemslot As Byte, Cantidad As Integer)
Dim MiObj As Obj

If Cantidad < 1 Then Exit Sub

MiObj.OBJIndex = UserList(Userindex).Tienda.Object(Itemslot).OBJIndex
MiObj.Amount = Cantidad

If Not MeterItemEnInventario(Userindex, MiObj) Then
    Call SendData(ToIndex, Userindex, 0, "/J")
    Exit Sub
End If

UserList(Userindex).Tienda.Object(Itemslot).Amount = UserList(Userindex).Tienda.Object(Itemslot).Amount - Cantidad

If UserList(Userindex).Tienda.Object(Itemslot).Amount <= 0 Then
    UserList(Userindex).Tienda.Object(Itemslot).Amount = 0
    UserList(Userindex).Tienda.Object(Itemslot).OBJIndex = 0
    UserList(Userindex).Tienda.Object(Itemslot).Precio = 0
    UserList(Userindex).Tienda.NroItems = UserList(Userindex).Tienda.NroItems - 1
    If UserList(Userindex).Tienda.NroItems <= 0 Then
        Npclist(UserList(Userindex).Tienda.NpcTienda).flags.TiendaUser = 0
        UserList(Userindex).Tienda.NpcTienda = 0
    End If
End If

Call UpdateTiendaV(False, Userindex, Itemslot)

End Sub
Sub UserDaObjVenta(Userindex As Integer, ByVal Itemslot As Byte, Cantidad As Integer, ByVal Precio As Long)
Dim Slot As Byte
Dim ObjI As Integer
Dim SlotHayado As Boolean

If Cantidad < 1 Then Exit Sub

ObjI = UserList(Userindex).Invent.Object(Itemslot).OBJIndex
    
For Slot = 1 To MAX_TIENDA_SLOTS
    If UserList(Userindex).Tienda.Object(Slot).OBJIndex = ObjI Then
        SlotHayado = True
        Exit For
    End If
Next

If Not SlotHayado Then
    For Slot = 1 To MAX_TIENDA_SLOTS
        If UserList(Userindex).Tienda.Object(Slot).OBJIndex = 0 Then
            If UserList(Userindex).Tienda.NroItems + UserList(Userindex).BancoInvent.NroItems + 1 > MAX_BANCOINVENTORY_SLOTS Then
                Call SendData(ToIndex, Userindex, 0, "/K")
                Exit Sub
            End If
            UserList(Userindex).Tienda.NroItems = UserList(Userindex).Tienda.NroItems + 1
            SlotHayado = True
            Exit For
        End If
    Next
End If

If Not SlotHayado Then
    Call SendData(ToIndex, Userindex, 0, "/G")
    Exit Sub
End If

If UserList(Userindex).Tienda.Object(Slot).Amount + Cantidad <= MAX_INVENTORY_OBJS Then
    UserList(Userindex).Tienda.Object(Slot).OBJIndex = ObjI
    UserList(Userindex).Tienda.Object(Slot).Amount = UserList(Userindex).Tienda.Object(Slot).Amount + Cantidad
    UserList(Userindex).Tienda.Object(Slot).Precio = Precio
    Call QuitarUserInvItem(Userindex, CByte(Itemslot), Cantidad)
Else
    Call SendData(ToIndex, Userindex, 0, "/G")
End If

Call UpdateUserInv(False, Userindex, CByte(Itemslot))
Call UpdateTiendaV(False, Userindex, Slot, True)

End Sub
Sub DevolverItemsVenta(Userindex As Integer)
Dim i As Byte


For i = 1 To MAX_TIENDA_SLOTS
    If UserList(Userindex).Tienda.Object(i).OBJIndex Then Call TiendaABoveda(Userindex, i)
Next

End Sub
Sub TiendaABoveda(Userindex As Integer, Itemslot As Byte)
Dim Slot As Byte
Dim ObjI As Integer
Dim SlotHayado As Boolean

ObjI = UserList(Userindex).Tienda.Object(Itemslot).OBJIndex
    
For Slot = 1 To MAX_BANCOINVENTORY_SLOTS
    If UserList(Userindex).BancoInvent.Object(Slot).OBJIndex = ObjI Then
        SlotHayado = True
        Exit For
    End If
Next

If Not SlotHayado Then
    For Slot = 1 To MAX_BANCOINVENTORY_SLOTS
        If UserList(Userindex).BancoInvent.Object(Slot).OBJIndex = 0 Then
            UserList(Userindex).BancoInvent.NroItems = UserList(Userindex).BancoInvent.NroItems + 1
            SlotHayado = True
            Exit For
        End If
    Next
End If

If Not SlotHayado Then Exit Sub

If UserList(Userindex).BancoInvent.Object(Slot).Amount + UserList(Userindex).Tienda.Object(Itemslot).Amount <= MAX_INVENTORY_OBJS Then
    UserList(Userindex).BancoInvent.Object(Slot).OBJIndex = ObjI
    UserList(Userindex).BancoInvent.Object(Slot).Amount = UserList(Userindex).BancoInvent.Object(Slot).Amount + UserList(Userindex).Tienda.Object(Itemslot).Amount
    UserList(Userindex).Tienda.Object(Itemslot).Amount = 0
    UserList(Userindex).Tienda.Object(Itemslot).OBJIndex = 0
    UserList(Userindex).Tienda.Object(Itemslot).Precio = 0
    UserList(Userindex).Tienda.NroItems = UserList(Userindex).Tienda.NroItems - 1
End If

End Sub
