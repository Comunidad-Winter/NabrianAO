Attribute VB_Name = "modMetamorfosis"
 
'director del proyecto: #Esteban(Neliam)

'servidor basado en fénixao 1.0
'medios de contacto:
'Skype: dc.esteban
'E-mail: nabrianao@gmail.com
Sub DoMetamorfosis(Userindex As Integer)

metacuerpo = RandomNumber(1, 10)

Select Case (metacuerpo)
    Case 1
        metacuerpo = 9
    Case 2
        metacuerpo = 11
    Case 3
        metacuerpo = 42
    Case 4
        metacuerpo = 243
    Case 5
        metacuerpo = 149
    Case 6
        metacuerpo = 151
    Case 7
        metacuerpo = 155
    Case 8
        metacuerpo = 157
    Case 9
        metacuerpo = 159
    Case 10
        metacuerpo = 141
End Select


UserList(Userindex).flags.Transformado = 1
UserList(Userindex).Counters.Transformado = Timer

Call ChangeUserChar(ToMap, 0, UserList(Userindex).POS.Map, val(Userindex), metacuerpo, 0, UserList(Userindex).Char.Heading, NingunArma, NingunEscudo, NingunCasco)
        
If UserList(Userindex).flags.Desnudo Then UserList(Userindex).flags.Desnudo = 0

Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "TW" & SND_MORPH)
Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "CFX" & UserList(Userindex).Char.CharIndex & "," & UserList(Userindex).Char.CharIndex & "," & FXWARPMORPH & "," & 0 & "," & 0) 'dx8


End Sub
Sub DoTransformar(Userindex As Integer, Optional ByVal FX As Boolean = True)

UserList(Userindex).flags.Transformado = 0
UserList(Userindex).Counters.Transformado = 0

If UserList(Userindex).Invent.ArmourEqpObjIndex = 0 Then
    Call DarCuerpoDesnudo(Userindex)
Else
    UserList(Userindex).Char.Body = ObjData(UserList(Userindex).Invent.ArmourEqpObjIndex).Ropaje
End If

If UserList(Userindex).Invent.CascoEqpObjIndex = 0 Then
   UserList(Userindex).Char.CascoAnim = NingunCasco
Else
    UserList(Userindex).Char.CascoAnim = ObjData(UserList(Userindex).Invent.CascoEqpObjIndex).CascoAnim
End If

If UserList(Userindex).Invent.EscudoEqpObjIndex = 0 Then
   UserList(Userindex).Char.ShieldAnim = NingunEscudo
Else
    UserList(Userindex).Char.ShieldAnim = ObjData(UserList(Userindex).Invent.EscudoEqpObjIndex).ShieldAnim
End If

If UserList(Userindex).Invent.WeaponEqpObjIndex = 0 Then
   UserList(Userindex).Char.WeaponAnim = NingunArma
Else
    UserList(Userindex).Char.WeaponAnim = ObjData(UserList(Userindex).Invent.WeaponEqpObjIndex).WeaponAnim
End If

Call ChangeUserChar(ToMap, 0, UserList(Userindex).POS.Map, Userindex, UserList(Userindex).Char.Body, UserList(Userindex).OrigChar.Head, UserList(Userindex).Char.Heading, UserList(Userindex).Char.WeaponAnim, UserList(Userindex).Char.ShieldAnim, UserList(Userindex).Char.CascoAnim)

If FX Then
    Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "TW" & SND_WARPMORPH)
    Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "CFX" & UserList(Userindex).Char.CharIndex & "," & UserList(Userindex).Char.CharIndex & "," & FXWARPMORPH & "," & 0 & "," & 0) 'dx8
End If

End Sub

'DEATH
Sub ponerbodydeath(Userindex As Integer)

metacuerpo = RandomNumber(1, 10)

Select Case (metacuerpo)
    Case 1
        metacuerpo = 9
    Case 2
        metacuerpo = 11
    Case 3
        metacuerpo = 42
    Case 4
        metacuerpo = 243
    Case 5
        metacuerpo = 149
    Case 6
        metacuerpo = 151
    Case 7
        metacuerpo = 155
    Case 8
        metacuerpo = 157
    Case 9
        metacuerpo = 159
    Case 10
        metacuerpo = 141
End Select

UserList(Userindex).flags.Transformadodeath = 1

Call ChangeUserChar(ToMap, 0, UserList(Userindex).POS.Map, val(Userindex), metacuerpo, 0, UserList(Userindex).Char.Heading, NingunArma, NingunEscudo, NingunCasco)

UserList(Userindex).Char.Body = 2
UserList(Userindex).Char.Head = 2
UserList(Userindex).Char.WeaponAnim = 8
UserList(Userindex).Char.ShieldAnim = 6

If UserList(Userindex).flags.Desnudo Then UserList(Userindex).flags.Desnudo = 0
End Sub
Sub sacarbodydeath(Userindex As Integer, Optional ByVal FX As Boolean = True)

UserList(Userindex).flags.Transformadodeath = 0

If UserList(Userindex).Invent.ArmourEqpObjIndex = 0 Then
    Call DarCuerpoDesnudo(Userindex)
Else
    UserList(Userindex).Char.Body = ObjData(UserList(Userindex).Invent.ArmourEqpObjIndex).Ropaje
End If

If UserList(Userindex).Invent.CascoEqpObjIndex = 0 Then
   UserList(Userindex).Char.CascoAnim = NingunCasco
Else
    UserList(Userindex).Char.CascoAnim = ObjData(UserList(Userindex).Invent.CascoEqpObjIndex).CascoAnim
End If

If UserList(Userindex).Invent.EscudoEqpObjIndex = 0 Then
   UserList(Userindex).Char.ShieldAnim = NingunEscudo
Else
    UserList(Userindex).Char.ShieldAnim = ObjData(UserList(Userindex).Invent.EscudoEqpObjIndex).ShieldAnim
End If

If UserList(Userindex).Invent.WeaponEqpObjIndex = 0 Then
   UserList(Userindex).Char.WeaponAnim = NingunArma
Else
    UserList(Userindex).Char.WeaponAnim = ObjData(UserList(Userindex).Invent.WeaponEqpObjIndex).WeaponAnim
End If

Call ChangeUserChar(ToMap, 0, UserList(Userindex).POS.Map, Userindex, UserList(Userindex).Char.Body, UserList(Userindex).OrigChar.Head, UserList(Userindex).Char.Heading, UserList(Userindex).Char.WeaponAnim, UserList(Userindex).Char.ShieldAnim, UserList(Userindex).Char.CascoAnim)

End Sub

'DEATH
