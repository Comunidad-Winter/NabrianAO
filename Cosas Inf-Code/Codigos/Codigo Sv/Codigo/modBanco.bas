Attribute VB_Name = "modBanco"
 
'director del proyecto: #Esteban(Neliam)

'servidor basado en fénixao 1.0
'medios de contacto:
'Skype: dc.esteban
'E-mail: nabrianao@gmail.com
Option Explicit
Sub IniciarDeposito(Userindex As Integer)
On Error GoTo ErrHandler
Call SendData(ToIndex, Userindex, 0, "TW" & 210)
Call UpdateBancoInv(True, Userindex, 0)
Call SendData(ToIndex, Userindex, 0, "INITBANCO")
UserList(Userindex).flags.Comerciando = True

ErrHandler:

End Sub
Sub UpdateBancoInv(UpdateAll As Boolean, Userindex As Integer, Slot As Byte, Optional ByVal TodaInfo As Boolean)
Dim i As Byte

If UpdateAll Then
    For i = 1 To MAX_BANCOINVENTORY_SLOTS
        Call EnviarBancoItem(Userindex, i, UpdateAll)
    Next
Else
    Call EnviarBancoItem(Userindex, Slot, TodaInfo)
End If

End Sub
Sub EnviarBancoItem(Userindex As Integer, Slot As Byte, ByVal AllInfo As Boolean)
Dim MiObj As UserOBJ

MiObj = UserList(Userindex).BancoInvent.Object(Slot)

If MiObj.OBJIndex Then
    If AllInfo Then
        Call SendData(ToIndex, Userindex, 0, "OTII" & Slot _
        & "," & ObjData(MiObj.OBJIndex).Name _
        & "," & MiObj.Amount _
        & "," & 0 _
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
        Call SendData(ToIndex, Userindex, 0, "OTIC" & Slot & "," & MiObj.Amount)
    End If
Else
    Call SendData(ToIndex, Userindex, 0, "OTIV" & Slot)
End If

End Sub
Sub UserRetiraItem(Userindex As Integer, ByVal i As Byte, Cantidad As Integer)
On Error GoTo ErrHandler

If Cantidad < 1 Then Exit Sub

If UserList(Userindex).BancoInvent.Object(i).Amount Then
     If Cantidad > UserList(Userindex).BancoInvent.Object(i).Amount Then Cantidad = UserList(Userindex).BancoInvent.Object(i).Amount
     
     Call UserReciveObj(Userindex, CInt(i), Cantidad)
     Call UpdateBancoInv(False, Userindex, i)
End If

ErrHandler:

End Sub
Sub UserReciveObj(Userindex As Integer, ByVal OBJIndex As Integer, Cantidad As Integer)
Dim Slot As Byte
Dim ObjI As Integer

If Cantidad < 1 Then Exit Sub
If UserList(Userindex).BancoInvent.Object(OBJIndex).Amount <= 0 Then Exit Sub

ObjI = UserList(Userindex).BancoInvent.Object(OBJIndex).OBJIndex

If ObjData(ObjI).EsItemValioso Then Call LogBove(UserList(Userindex).Name, UserList(Userindex).Name & " RETIRO:" & Cantidad & " Objeto:" & ObjData(ObjI).Name & " Objeto:" & OBJIndex, False)


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
                Call SendData(ToIndex, Userindex, 0, "5W")
                Exit Sub
            End If
        Loop
        UserList(Userindex).Invent.NroItems = UserList(Userindex).Invent.NroItems + 1
End If




If UserList(Userindex).Invent.Object(Slot).Amount + Cantidad <= MAX_INVENTORY_OBJS Then
    
    
    UserList(Userindex).Invent.Object(Slot).OBJIndex = ObjI
    UserList(Userindex).Invent.Object(Slot).Amount = UserList(Userindex).Invent.Object(Slot).Amount + Cantidad
    
                
    Call UpdateUserInv(False, Userindex, Slot)
    Call QuitarBancoInvItem(Userindex, CByte(OBJIndex), Cantidad)
    
Else
    Call SendData(ToIndex, Userindex, 0, "5W")
End If


End Sub

Sub QuitarBancoInvItem(Userindex As Integer, Slot As Byte, Cantidad As Integer)
Dim OBJIndex As Integer
OBJIndex = UserList(Userindex).BancoInvent.Object(Slot).OBJIndex

UserList(Userindex).BancoInvent.Object(Slot).Amount = UserList(Userindex).BancoInvent.Object(Slot).Amount - Cantidad

If UserList(Userindex).BancoInvent.Object(Slot).Amount <= 0 Then
    UserList(Userindex).BancoInvent.NroItems = UserList(Userindex).BancoInvent.NroItems - 1
    UserList(Userindex).BancoInvent.Object(Slot).OBJIndex = 0
    UserList(Userindex).BancoInvent.Object(Slot).Amount = 0
End If

End Sub
Sub UserDepositaItem(Userindex As Integer, ByVal Item As Integer, Cantidad As Integer)
On Error GoTo ErrHandler
   
If UserList(Userindex).Invent.Object(Item).Amount > 0 And UserList(Userindex).Invent.Object(Item).Equipped = 0 Then
    If Cantidad > 0 And Cantidad > UserList(Userindex).Invent.Object(Item).Amount Then Cantidad = UserList(Userindex).Invent.Object(Item).Amount
    Call UserDejaObj(Userindex, CInt(Item), Cantidad)
End If

ErrHandler:

End Sub
Sub UserDejaObj(Userindex As Integer, ByVal OBJIndex As Integer, Cantidad As Integer)
Dim Slot As Byte
Dim ObjI As Integer

If Cantidad < 1 Then Exit Sub

ObjI = UserList(Userindex).Invent.Object(OBJIndex).OBJIndex

If ObjData(ObjI).EsItemValioso Then Call LogBove(UserList(Userindex).Name, UserList(Userindex).Name & " DEPOSITO:" & Cantidad & " Objeto:" & ObjData(ObjI).Name & " Objeto:" & OBJIndex, False)

Slot = 1
Do Until UserList(Userindex).BancoInvent.Object(Slot).OBJIndex = ObjI And _
    UserList(Userindex).BancoInvent.Object(Slot).Amount + Cantidad <= MAX_INVENTORY_OBJS
    Slot = Slot + 1
    
    If Slot > MAX_BANCOINVENTORY_SLOTS Then Exit Do
Loop

If Slot > MAX_BANCOINVENTORY_SLOTS Then
    Slot = 1
    Do Until UserList(Userindex).BancoInvent.Object(Slot).OBJIndex = 0
        Slot = Slot + 1
        If Slot > MAX_BANCOINVENTORY_SLOTS Then
            Call SendData(ToIndex, Userindex, 0, "9Y")
            Exit Sub
            Exit Do
        End If
    Loop
    If Slot <= MAX_BANCOINVENTORY_SLOTS Then UserList(Userindex).BancoInvent.NroItems = UserList(Userindex).BancoInvent.NroItems + 1
End If

If UserList(Userindex).Tienda.NroItems + UserList(Userindex).BancoInvent.NroItems > MAX_BANCOINVENTORY_SLOTS Then
    Call SendData(ToIndex, Userindex, 0, "/L")
    Exit Sub
End If

If Slot <= MAX_BANCOINVENTORY_SLOTS Then
    If UserList(Userindex).BancoInvent.Object(Slot).Amount + Cantidad <= MAX_INVENTORY_OBJS Then
        UserList(Userindex).BancoInvent.Object(Slot).OBJIndex = ObjI
        UserList(Userindex).BancoInvent.Object(Slot).Amount = UserList(Userindex).BancoInvent.Object(Slot).Amount + Cantidad
        Call QuitarUserInvItem(Userindex, CByte(OBJIndex), Cantidad)
        Call UpdateBancoInv(False, Userindex, Slot, True)
    Else
        Call SendData(ToIndex, Userindex, 0, "9Y")
    End If
    Call UpdateUserInv(False, Userindex, CByte(OBJIndex))
Else
    Call QuitarUserInvItem(Userindex, CByte(OBJIndex), Cantidad)
End If

End Sub


