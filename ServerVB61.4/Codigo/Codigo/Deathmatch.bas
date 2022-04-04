Attribute VB_Name = "Deathmatch"
 
'director del proyecto: #Esteban(Neliam)

'servidor basado en fénixao 1.0
'medios de contacto:
'Skype: dc.esteban
'E-mail: nabrianao@gmail.com
Sub EntraUserDM(ByVal Userindex As Integer)

If UserList(Userindex).POS.Map <> 1 Then Exit Sub

If UserList(Userindex).flags.EnReto Then Exit Sub
If UserList(Userindex).PartyIndex > 0 And MOD_EVENTO_Retos3vs3.EsPartyInscripto(UserList(Userindex).PartyIndex) = True Then
Call SendData(ToIndex, Userindex, 0, "||Error: Estás anotado para 3vs3." & FONTTYPE_RETOS)
Exit Sub
End If

If UserList(Userindex).Stats.GLD < 50000 Then
Call SendData(ToIndex, Userindex, 0, "||La minima cantidad para entrar es de 50.000 monedas de oro." & FONTTYPE_TALK)
Exit Sub
End If

UserList(Userindex).flags.EnDM = True
Call WarpUserChar(Userindex, 108, RandomNumber(36, 52), RandomNumber(49, 57), True)
Call SendData(ToIndex, Userindex, 0, "||Has entrado al deathmatch para abandonar tipéa /ABANDONARDM." & FONTTYPE_TALK)
Call SendData(ToMap, 0, 108, "||" & UserList(Userindex).Name & " Ha ingresado a la sala." & FONTTYPE_TALK)
End Sub

Sub EntraUserDM2(ByVal Userindex As Integer)

If UserList(Userindex).POS.Map <> 191 Then Exit Sub

If UserList(Userindex).flags.EnReto Then Exit Sub
If UserList(Userindex).PartyIndex > 0 And MOD_EVENTO_Retos3vs3.EsPartyInscripto(UserList(Userindex).PartyIndex) = True Then
'Call SendData(ToIndex, UserIndex, 0, "||Error: Estás anotado para 3vs3." & FONTTYPE_RETOS)
Exit Sub
End If

If UserList(Userindex).Stats.GLD < 50000 Then
Call SendData(ToIndex, Userindex, 0, "||La minima cantidad para entrar es de 50.000 monedas de oro." & FONTTYPE_TALK)
Exit Sub
End If

UserList(Userindex).flags.EnDM = True
Call WarpUserChar(Userindex, 108, RandomNumber(36, 52), RandomNumber(49, 57), True)
Call SendData(ToIndex, Userindex, 0, "||Has entrado al deathmatch para abandonar tipéa /ABANDONARDM." & FONTTYPE_TALK)
Call SendData(ToMap, 0, 108, "||" & UserList(Userindex).Name & " Ha ingresado a la sala." & FONTTYPE_TALK)
End Sub

Sub SaleUserDM(ByVal Userindex As Integer)

If UserList(Userindex).flags.EnDM = False Then
Call SendData(ToIndex, Userindex, 0, "||No estas en deathmatch." & FONTTYPE_TALK)
Exit Sub
End If

UserList(Userindex).flags.EnDM = False
UserList(Userindex).flags.DmKills = 0
UserList(Userindex).flags.DmMuertes = 0
Call WarpUserChar(Userindex, 1, 50, 50, True)
Call SendData(ToMap, 0, 108, "||" & UserList(Userindex).Name & " Ha salido de la sala." & FONTTYPE_TALK)
Call SendData(ToIndex, Userindex, 0, "||Has salido del deathmatch." & FONTTYPE_TALK)
End Sub

