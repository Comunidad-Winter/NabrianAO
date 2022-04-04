Attribute VB_Name = "InvNpc"
 
'director del proyecto: #Esteban(Neliam)

'servidor basado en fénixao 1.0
'medios de contacto:
'Skype: dc.esteban
'E-mail: nabrianao@gmail.com
Option Explicit
Public Function TirarItemAlPiso(POS As WorldPos, Obj As Obj) As WorldPos
On Error GoTo ErrHandler
Dim NuevaPos As WorldPos

Call Tilelibre(POS, NuevaPos)

If NuevaPos.X <> 0 And NuevaPos.y <> 0 Then
      Call MakeObj(ToMap, 0, POS.Map, _
      Obj, POS.Map, NuevaPos.X, NuevaPos.y)
      TirarItemAlPiso = NuevaPos
End If

Exit Function
ErrHandler:

End Function
Public Sub NPC_TIRAR_ITEMS(MiNPC As Npc, Userindex As Integer)

On Error Resume Next

If MiNPC.Invent.NroItems Then
    
    Dim i As Byte
    Dim MiObj As Obj
    Dim Prob As Integer
    
    For i = 1 To MAX_NPCINVENTORY_SLOTS
   
 If MiNPC.Probabilidad = 0 Then
        If MiNPC.Invent.Object(i).OBJIndex Then
              If val(MiNPC.MaxRecom) Then
              MiObj.Amount = RandomNumber(MiNPC.MinRecom, MiNPC.MaxRecom)
              Else
              MiObj.Amount = MiNPC.Invent.Object(i).Amount
              End If
              MiObj.OBJIndex = MiNPC.Invent.Object(i).OBJIndex
              
            
                 If MiNPC.Numero = 548 Then 'LEVIATAN esta en agua como lo va a tirar el culeado(?
                        Call MeterItemEnInventario(Userindex, MiObj)
              Else
              
             Call TirarItemAlPiso(MiNPC.POS, MiObj)
            
              End If
              
        End If
        Else
        Prob = RandomNumber(0, 100)
        If Prob <= MiNPC.Probabilidad Then
                If MiNPC.Invent.Object(i).OBJIndex Then
              If MiNPC.MaxRecom Then
              MiObj.Amount = RandomNumber(MiNPC.MinRecom, MiNPC.MaxRecom)
              Else
              MiObj.Amount = MiNPC.Invent.Object(i).Amount
              End If
              MiObj.OBJIndex = MiNPC.Invent.Object(i).OBJIndex
              
              If MiNPC.Numero = 548 Then 'LEVIATAN esta en agua como lo va a tirar el culeado(?
                        Call MeterItemEnInventario(Userindex, MiObj)
              Else
              
             Call TirarItemAlPiso(MiNPC.POS, MiObj)
            
              End If
              Call UpdateUserInv(True, Userindex, 0)
              
              
        End If
      End If
      End If
    Next
    
  
End If
End Sub
Function QuedanItems(NpcIndex As Integer, OBJIndex As Integer) As Boolean
On Error Resume Next
Dim i As Integer

If Npclist(NpcIndex).Invent.NroItems Then
    For i = 1 To MAX_NPCINVENTORY_SLOTS
        If Npclist(NpcIndex).Invent.Object(i).OBJIndex = OBJIndex Then
            QuedanItems = True
            Exit Function
        End If
    Next
End If

End Function
Sub ResetNpcInv(NpcIndex As Integer)
On Error Resume Next

Dim i As Integer

Npclist(NpcIndex).Invent.NroItems = 0

For i = 1 To MAX_NPCINVENTORY_SLOTS
   Npclist(NpcIndex).Invent.Object(i).OBJIndex = 0
   Npclist(NpcIndex).Invent.Object(i).Amount = 0
Next

Npclist(NpcIndex).InvReSpawn = 0

End Sub
Sub QuitarNpcInvItem(NpcIndex As Integer, Slot As Byte, Cantidad As Integer, Userindex As Integer)
Dim OBJIndex As Integer

OBJIndex = Npclist(NpcIndex).Invent.Object(Slot).OBJIndex

If Npclist(NpcIndex).InvReSpawn = 1 Then
    Npclist(NpcIndex).Invent.Object(Slot).Amount = Npclist(NpcIndex).Invent.Object(Slot).Amount - Cantidad
    If Npclist(NpcIndex).Invent.Object(Slot).Amount <= 0 Then
        Npclist(NpcIndex).Invent.NroItems = Npclist(NpcIndex).Invent.NroItems - 1
        Npclist(NpcIndex).Invent.Object(Slot).OBJIndex = 0
        Npclist(NpcIndex).Invent.Object(Slot).Amount = 0
        If Npclist(NpcIndex).Invent.NroItems = 0 And Npclist(NpcIndex).InvReSpawn <> 1 Then
           Call CargarInvent(NpcIndex)
        End If
    End If
    Call UpdateNPCInv(False, Userindex, NpcIndex, Slot)
End If

End Sub
Sub CargarInvent(NpcIndex As Integer)
Dim loopc As Integer, ln As String, npcfile As String

If Npclist(NpcIndex).Numero >= 500 Then
    npcfile = DatPath & "NPCs-HOSTILES.dat"
Else: npcfile = DatPath & "NPCs.dat"
End If

Npclist(NpcIndex).Invent.NroItems = val(GetVar(npcfile, "NPC" & Npclist(NpcIndex).Numero, "NROITEMS"))

For loopc = 1 To Npclist(NpcIndex).Invent.NroItems
    ln = GetVar(npcfile, "NPC" & Npclist(NpcIndex).Numero, "Obj" & loopc)
    Npclist(NpcIndex).Invent.Object(loopc).OBJIndex = val(ReadField(1, ln, 45))
    Npclist(NpcIndex).Invent.Object(loopc).Amount = val(ReadField(2, ln, 45))
Next

End Sub
