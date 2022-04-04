Attribute VB_Name = "Trabajo"
 
'director del proyecto: #Esteban(Neliam)

'servidor basado en fénixao 1.0
'medios de contacto:
'Skype: dc.esteban
'E-mail: nabrianao@gmail.com
Option Explicit

Public Sub DoOcultarse(Userindex As Integer)
On Error GoTo errhandler
Dim Suerte As Integer



If MapInfo(UserList(Userindex).POS.Map).EsMapaEspecial Then
Call SendData(ToIndex, Userindex, 0, "||No puedes ocultarte en este mapa." & FONTTYPE_INFO)
Exit Sub
End If

Suerte = 50 - 0.35 * UserList(Userindex).Stats.UserSkills(Ocultarse)

If TiempoTranscurrido(UserList(Userindex).Counters.LastOculto) < 0.5 Then Exit Sub
UserList(Userindex).Counters.LastOculto = Timer

If UserList(Userindex).Clase = CAZADOR Or UserList(Userindex).Clase = ASESINO Or UserList(Userindex).Clase = LADRON Then Suerte = Suerte - 5

If CInt(RandomNumber(1, Suerte)) <= 5 Then
    UserList(Userindex).flags.Oculto = 1
    UserList(Userindex).flags.Invisible = 1
    Call SendData(ToMap, 0, UserList(Userindex).POS.Map, ("V3" & DesteEncripTE("1," & UserList(Userindex).Char.CharIndex)))
    Call SendData(ToIndex, Userindex, 0, "V7")
    'Call SubirSkill(Userindex, Ocultarse, 15)
Else: Call SendData(ToIndex, Userindex, 0, "EN")
End If

Exit Sub




errhandler:
    Call LogError("Error en Sub DoOcultarse")

End Sub
Public Sub DoNavega(Userindex As Integer, Slot As Integer)
Dim Barco As ObjData, Skill As Byte

Barco = ObjData(UserList(Userindex).Invent.Object(Slot).OBJIndex)

If UserList(Userindex).Clase <> PIRATA And UserList(Userindex).Clase <> PESCADOR Then
    Skill = Barco.MinSkill * 2
ElseIf UserList(Userindex).Invent.Object(Slot).OBJIndex = 474 Then
    Skill = 40
Else: Skill = Barco.MinSkill
End If

If UserList(Userindex).Stats.UserSkills(Navegacion) < Skill Then
    If Skill <= 100 Then
        Call SendData(ToIndex, Userindex, 0, "!7" & Skill)
    Else: Call SendData(ToIndex, Userindex, 0, "||Esta embarcación solo puede ser usada por piratas." & FONTTYPE_INFO)
    End If
    Exit Sub
End If

If UserList(Userindex).Stats.ELV < 18 Then
    Call SendData(ToIndex, Userindex, 0, "||Debes ser nivel 18 o superior para poder navegar." & FONTTYPE_INFO)
    Exit Sub
End If

UserList(Userindex).Invent.BarcoObjIndex = UserList(Userindex).Invent.Object(Slot).OBJIndex
UserList(Userindex).Invent.BarcoSlot = Slot
           
If UserList(Userindex).flags.Navegando = 0 Then
    UserList(Userindex).Char.Head = 0
    
    If UserList(Userindex).flags.Muerto = 0 Then
        UserList(Userindex).Char.Body = Barco.Ropaje
    Else
        UserList(Userindex).Char.Body = iFragataFantasmal
    End If
    
    UserList(Userindex).Char.ShieldAnim = NingunEscudo
    UserList(Userindex).Char.WeaponAnim = NingunArma
    UserList(Userindex).Char.CascoAnim = NingunCasco
    UserList(Userindex).flags.Navegando = 1
Else
    UserList(Userindex).flags.Navegando = 0
    
    If UserList(Userindex).flags.Muerto = 0 Then
        UserList(Userindex).Char.Head = UserList(Userindex).OrigChar.Head
        
        If UserList(Userindex).Invent.ArmourEqpObjIndex Then
            UserList(Userindex).Char.Body = ObjData(UserList(Userindex).Invent.ArmourEqpObjIndex).Ropaje
        Else: Call DarCuerpoDesnudo(Userindex)
        End If
            
        If UserList(Userindex).Invent.EscudoEqpObjIndex Then _
            UserList(Userindex).Char.ShieldAnim = ObjData(UserList(Userindex).Invent.EscudoEqpObjIndex).ShieldAnim
        If UserList(Userindex).Invent.WeaponEqpObjIndex Then _
            UserList(Userindex).Char.WeaponAnim = ObjData(UserList(Userindex).Invent.WeaponEqpObjIndex).WeaponAnim
        If UserList(Userindex).Invent.CascoEqpObjIndex Then _
            UserList(Userindex).Char.CascoAnim = ObjData(UserList(Userindex).Invent.CascoEqpObjIndex).CascoAnim
    Else
        UserList(Userindex).Char.Body = iCuerpoMuerto
        UserList(Userindex).Char.Head = iCabezaMuerto
        UserList(Userindex).Char.ShieldAnim = NingunEscudo
        UserList(Userindex).Char.WeaponAnim = NingunArma
        UserList(Userindex).Char.CascoAnim = NingunCasco
    End If
End If

Call ChangeUserCharB(ToMap, 0, UserList(Userindex).POS.Map, Userindex, UserList(Userindex).Char.Body, UserList(Userindex).Char.Head, UserList(Userindex).Char.Heading, UserList(Userindex).Char.WeaponAnim, UserList(Userindex).Char.ShieldAnim, UserList(Userindex).Char.CascoAnim)
Call SendData(ToIndex, Userindex, 0, "NAVEG")

End Sub
Public Sub FundirMineral(Userindex As Integer)

If UserList(Userindex).flags.TargetObjInvIndex Then
    If ObjData(UserList(Userindex).flags.TargetObjInvIndex).MinSkill <= UserList(Userindex).Stats.UserSkills(Mineria) / ModFundicion(UserList(Userindex).Clase) Then
         Call DoLingotes(Userindex)
    Else: Call SendData(ToIndex, Userindex, 0, "!8")
    End If
End If

End Sub
Function TieneObjetos(ItemIndex As Integer, Cant As Integer, Userindex As Integer) As Boolean
Dim i As Byte
Dim Total As Long

For i = 1 To MAX_INVENTORY_SLOTS
    If UserList(Userindex).Invent.Object(i).OBJIndex = ItemIndex Then
        Total = Total + UserList(Userindex).Invent.Object(i).Amount
    End If
Next

If Cant <= Total Then
    TieneObjetos = True
    Exit Function
End If
        
End Function
Function QuitarObjetos(ItemIndex As Integer, Cant As Integer, Userindex As Integer) As Boolean
Dim i As Byte

For i = 1 To MAX_INVENTORY_SLOTS
    If UserList(Userindex).Invent.Object(i).OBJIndex = ItemIndex Then
        
        Call Desequipar(Userindex, i)
        
        UserList(Userindex).Invent.Object(i).Amount = UserList(Userindex).Invent.Object(i).Amount - Cant
        If (UserList(Userindex).Invent.Object(i).Amount <= 0) Then
            Cant = Abs(UserList(Userindex).Invent.Object(i).Amount)
            UserList(Userindex).Invent.Object(i).Amount = 0
            UserList(Userindex).Invent.Object(i).OBJIndex = 0
        Else
            Cant = 0
        End If
        
        Call UpdateUserInv(False, Userindex, i)
        
        If (Cant = 0) Then
            QuitarObjetos = True
            Exit Function
        End If
    End If
Next

End Function
Sub HerreroQuitarMateriales(Userindex As Integer, ItemIndex As Integer, cantT As Integer)
Dim Descuento As Single

Descuento = 1

If UserList(Userindex).Clase = HERRERO Then
    If UserList(Userindex).Recompensas(1) = 1 And ObjData(ItemIndex).SubTipo <> OBJTYPE_CASCO And ObjData(ItemIndex).SubTipo <> OBJTYPE_ESCUDO Then
        If CInt(RandomNumber(1, 4)) <= 1 Then Descuento = 0.5
    ElseIf UserList(Userindex).Recompensas(1) = 2 And (ObjData(ItemIndex).SubTipo = OBJTYPE_CASCO Or ObjData(ItemIndex).SubTipo = OBJTYPE_ESCUDO) Then
        Descuento = 0.5
    End If
    Descuento = Descuento * (1 - 0.25 * Buleano(UserList(Userindex).Recompensas(3) = 1 And ObjData(ItemIndex).SubTipo <> OBJTYPE_CASCO And ObjData(ItemIndex).SubTipo <> OBJTYPE_ESCUDO))
End If

If ObjData(ItemIndex).LingH Then Call QuitarObjetos(LingoteHierro, Descuento * Int(ObjData(ItemIndex).LingH * ModMateriales(UserList(Userindex).Clase) * cantT), Userindex)
If ObjData(ItemIndex).LingP Then Call QuitarObjetos(LingotePlata, Descuento * Int(ObjData(ItemIndex).LingP * ModMateriales(UserList(Userindex).Clase) * cantT), Userindex)
If ObjData(ItemIndex).LingO Then Call QuitarObjetos(LingoteOro, Descuento * Int(ObjData(ItemIndex).LingO * ModMateriales(UserList(Userindex).Clase) * cantT), Userindex)

End Sub
Sub CarpinteroQuitarMateriales(Userindex As Integer, ItemIndex As Integer, cantT As Integer)
Dim Descuento As Single

cantT = Maximo(1, cantT)

If UserList(Userindex).Clase = CARPINTERO And UserList(Userindex).Recompensas(2) = 2 And ObjData(ItemIndex).ObjType = OBJTYPE_BARCOS Then
    Descuento = 0.8
Else
    Descuento = 1
End If

If ObjData(ItemIndex).Madera Then

If TieneObjetos(Leña, CInt(Descuento * ObjData(ItemIndex).Madera * ModMadera(UserList(Userindex).Clase) * cantT), Userindex) Then
    Call QuitarObjetos(Leña, CInt(Descuento * ObjData(ItemIndex).Madera * ModMadera(UserList(Userindex).Clase) * cantT), Userindex)
End If

End If

If ObjData(ItemIndex).MaderaElfica Then
    Call QuitarObjetos(LeñaElfica, CInt(Descuento * ObjData(ItemIndex).MaderaElfica * ModMadera(UserList(Userindex).Clase) * cantT), Userindex)
End If

End Sub
Function CarpinteroTieneMateriales(Userindex As Integer, ItemIndex As Integer, cantT As Integer) As Boolean
Dim Descuento As Single

cantT = Maximo(1, cantT)

If UserList(Userindex).Clase = CARPINTERO And UserList(Userindex).Recompensas(2) = 2 And ObjData(ItemIndex).ObjType = OBJTYPE_BARCOS Then
    Descuento = 0.8
Else
    Descuento = 1
End If

If ObjData(ItemIndex).Madera Then
    If Not TieneObjetos(Leña, CInt(Descuento * ObjData(ItemIndex).Madera * ModMadera(UserList(Userindex).Clase) * cantT), Userindex) Then
        Call SendData(ToIndex, Userindex, 0, "!9")
        CarpinteroTieneMateriales = False
        Exit Function
    End If
End If

    
If ObjData(ItemIndex).MaderaElfica Then
    If Not TieneObjetos(LeñaElfica, CInt(Descuento * ObjData(ItemIndex).MaderaElfica * ModMadera(UserList(Userindex).Clase) * cantT), Userindex) Then
        Call SendData(ToIndex, Userindex, 0, "!9")
        CarpinteroTieneMateriales = False
        Exit Function
    End If
End If
    
CarpinteroTieneMateriales = True

End Function
Function Piel(Userindex As Integer, Tipo As Byte, Obj As Integer) As Integer

Select Case Tipo
    Case 1
        Piel = ObjData(Obj).PielLobo
        If UserList(Userindex).Clase = SASTRE And UserList(Userindex).Stats.ELV >= 18 Then Piel = Piel * 0.8
    Case 2
        Piel = ObjData(Obj).PielOsoPardo
        If UserList(Userindex).Clase = SASTRE And UserList(Userindex).Stats.ELV >= 18 Then Piel = Piel * 0.8
    Case 3
        Piel = ObjData(Obj).PielOsoPolar
        If UserList(Userindex).Clase = SASTRE And UserList(Userindex).Stats.ELV >= 18 Then Piel = Piel * 0.8
End Select

End Function
Function SastreTieneMateriales(Userindex As Integer, ItemIndex As Integer, cantT As Integer) As Boolean
Dim PielL As Integer, PielO As Integer, PielP As Integer
cantT = Maximo(1, cantT)

PielL = ObjData(ItemIndex).PielLobo
PielO = ObjData(ItemIndex).PielOsoPardo
PielP = ObjData(ItemIndex).PielOsoPolar

If UserList(Userindex).Clase = SASTRE And UserList(Userindex).Stats.ELV >= 18 Then
    PielL = 0.8 * PielL
    PielO = 0.8 * PielO
    PielP = 0.8 * PielP
End If

If PielL Then
    If Not TieneObjetos(PLobo, CInt(PielL * ModSastre(UserList(Userindex).Clase)) * cantT, Userindex) Then
        Call SendData(ToIndex, Userindex, 0, "0A")
        SastreTieneMateriales = False
        Exit Function
    End If
End If

If PielO Then
    If Not TieneObjetos(POsoPardo, CInt(PielO * ModSastre(UserList(Userindex).Clase)) * cantT, Userindex) Then
        Call SendData(ToIndex, Userindex, 0, "0A")
        SastreTieneMateriales = False
        Exit Function
    End If
End If
    
If PielP Then
    If Not TieneObjetos(POsoPolar, CInt(PielP * ModSastre(UserList(Userindex).Clase)) * cantT, Userindex) Then
        Call SendData(ToIndex, Userindex, 0, "0A")
        SastreTieneMateriales = False
        Exit Function
    End If
End If
    
SastreTieneMateriales = True

End Function
Sub SastreQuitarMateriales(Userindex As Integer, ItemIndex As Integer, cantT As Integer)
Dim PielL As Integer, PielO As Integer, PielP As Integer

PielL = ObjData(ItemIndex).PielLobo
PielO = ObjData(ItemIndex).PielOsoPardo
PielP = ObjData(ItemIndex).PielOsoPolar

If UserList(Userindex).Clase = SASTRE And UserList(Userindex).Stats.ELV >= 18 Then
    PielL = 0.8 * PielL
    PielO = 0.8 * PielO
    PielP = 0.8 * PielP
End If

If PielL Then Call QuitarObjetos(PLobo, CInt(PielL * ModSastre(UserList(Userindex).Clase)) * cantT, Userindex)
If PielO Then Call QuitarObjetos(POsoPardo, CInt(PielO * ModSastre(UserList(Userindex).Clase)) * cantT, Userindex)
If PielP Then Call QuitarObjetos(POsoPolar, CInt(PielP * ModSastre(UserList(Userindex).Clase)) * cantT, Userindex)

End Sub
Public Sub SastreConstruirItem(Userindex As Integer, ItemIndex As Integer, cantT As Integer)

If SastreTieneMateriales(Userindex, ItemIndex, cantT) And _
   UserList(Userindex).Stats.UserSkills(Sastreria) / ModRopas(UserList(Userindex).Clase) >= _
   ObjData(ItemIndex).SkSastreria And _
   PuedeConstruirSastre(ItemIndex, Userindex) And _
   UserList(Userindex).Invent.HerramientaEqpObjIndex = HILAR_SASTRE Then
        
    Call SastreQuitarMateriales(Userindex, ItemIndex, cantT)
    Call SendData(ToIndex, Userindex, 0, "0C")
    
    Dim MiObj As Obj
    MiObj.Amount = Maximo(1, cantT)
    MiObj.OBJIndex = ItemIndex
    
    If Not MeterItemEnInventario(Userindex, MiObj) Then Call TirarItemAlPiso(UserList(Userindex).POS, MiObj)
    
    Call CheckUserLevel(Userindex)

    Call SubirSkill(Userindex, Sastreria, 5)

Else
    Call SendData(ToIndex, Userindex, 0, "0D")

End If

End Sub

Public Function PuedeConstruirSastre(ItemIndex As Integer, Userindex As Integer) As Boolean
Dim i As Long
Dim N As Integer

N = val(GetVar(DatPath & "ObjSastre.dat", "INIT", "NumObjs"))

For i = 1 To UBound(ObjSastre)
    If ObjSastre(i) = ItemIndex Then
        PuedeConstruirSastre = True
        Exit Function
    End If
Next

PuedeConstruirSastre = False

End Function

Function HerreroTieneMateriales(Userindex As Integer, ItemIndex As Integer, cantT As Integer) As Boolean
Dim Descuento As Single

Descuento = 1

If UserList(Userindex).Clase = HERRERO Then
    If UserList(Userindex).Recompensas(1) = 1 And ObjData(ItemIndex).SubTipo <> OBJTYPE_CASCO And ObjData(ItemIndex).SubTipo <> OBJTYPE_ESCUDO Then
        If CInt(RandomNumber(1, 4)) <= 1 Then Descuento = 0.5
    ElseIf UserList(Userindex).Recompensas(1) = 2 And (ObjData(ItemIndex).SubTipo = OBJTYPE_CASCO Or ObjData(ItemIndex).SubTipo = OBJTYPE_ESCUDO) Then
        Descuento = 0.5
    End If
    Descuento = Descuento * (1 - 0.25 * Buleano(UserList(Userindex).Recompensas(3) = 1 And ObjData(ItemIndex).SubTipo <> OBJTYPE_CASCO And ObjData(ItemIndex).SubTipo <> OBJTYPE_ESCUDO))
End If

If ObjData(ItemIndex).LingH Then
    If Not TieneObjetos(LingoteHierro, Descuento * Int(ObjData(ItemIndex).LingH * ModMateriales(UserList(Userindex).Clase) * cantT), Userindex) Then
        Call SendData(ToIndex, Userindex, 0, "0E")
        HerreroTieneMateriales = False
        Exit Function
    End If
End If
If ObjData(ItemIndex).LingP Then
    If Not TieneObjetos(LingotePlata, Descuento * Int(ObjData(ItemIndex).LingP * ModMateriales(UserList(Userindex).Clase) * cantT), Userindex) Then
        Call SendData(ToIndex, Userindex, 0, "0F")
        HerreroTieneMateriales = False
        Exit Function
    End If
End If
If ObjData(ItemIndex).LingO Then
    If Not TieneObjetos(LingoteOro, Descuento * Int(ObjData(ItemIndex).LingO * ModMateriales(UserList(Userindex).Clase) * cantT), Userindex) Then
        Call SendData(ToIndex, Userindex, 0, "0G")
        HerreroTieneMateriales = False
        Exit Function
    End If
End If
HerreroTieneMateriales = True
End Function

Public Function PuedeConstruir(Userindex As Integer, ItemIndex As Integer, cantT As Integer) As Boolean
PuedeConstruir = HerreroTieneMateriales(Userindex, ItemIndex, cantT) And UserList(Userindex).Stats.UserSkills(Herreria) >= ObjData(ItemIndex).SkHerreria * ModHerreriA(UserList(Userindex).Clase)
End Function
Public Function PuedeConstruirHerreria(ItemIndex As Integer) As Boolean
Dim i As Long

For i = 1 To UBound(ArmasHerrero)
    If ArmasHerrero(i).Index = ItemIndex Then
        PuedeConstruirHerreria = True
        Exit Function
    End If
Next

For i = 1 To UBound(ArmadurasHerrero)
    If ArmadurasHerrero(i).Index = ItemIndex Then
        PuedeConstruirHerreria = True
        Exit Function
    End If
Next

For i = 1 To UBound(CascosHerrero)
    If CascosHerrero(i) = ItemIndex Then
        PuedeConstruirHerreria = True
        Exit Function
    End If
Next

For i = 1 To UBound(EscudosHerrero)
    If EscudosHerrero(i) = ItemIndex Then
        PuedeConstruirHerreria = True
        Exit Function
    End If
Next

PuedeConstruirHerreria = False

End Function
Public Sub HerreroConstruirItem(Userindex As Integer, ItemIndex As Integer, cantT As Integer)

If cantT > 10 Then
    Call SendData(ToIndex, Userindex, 0, "0H")
    Exit Sub
End If

If PuedeConstruir(Userindex, ItemIndex, cantT) And PuedeConstruirHerreria(ItemIndex) Then
    Call HerreroQuitarMateriales(Userindex, ItemIndex, cantT)
    
    Select Case ObjData(ItemIndex).ObjType
        Case OBJTYPE_WEAPON
            Call SendData(ToIndex, Userindex, 0, "0I")
        Case OBJTYPE_ESCUDO
            Call SendData(ToIndex, Userindex, 0, "0L")
        Case OBJTYPE_CASCO
            Call SendData(ToIndex, Userindex, 0, "0K")
        Case OBJTYPE_ARMOUR
            Call SendData(ToIndex, Userindex, 0, "0J")
    End Select
    cantT = cantT * (1 + Buleano(CInt(RandomNumber(1, 10)) <= 1 And UserList(Userindex).Clase = HERRERO And UserList(Userindex).Recompensas(3) = 2))
    Dim MiObj As Obj
    MiObj.Amount = cantT
    MiObj.OBJIndex = ItemIndex
    If Not MeterItemEnInventario(Userindex, MiObj) Then Call TirarItemAlPiso(UserList(Userindex).POS, MiObj)

    Call CheckUserLevel(Userindex)
    Call SubirSkill(Userindex, Herreria, 5)
    Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "TW" & MARTILLOHERRERO)
    Else

End If

End Sub
Public Function PuedeConstruirCarpintero(ItemIndex As Integer) As Boolean
Dim i As Long

For i = 1 To UBound(ObjCarpintero)
    If ObjCarpintero(i).Index = ItemIndex Then
        PuedeConstruirCarpintero = True
        Exit Function
    End If
Next
PuedeConstruirCarpintero = False

End Function
Public Sub CarpinteroConstruirItem(Userindex As Integer, ItemIndex As Integer, cantT As Integer)

If CarpinteroTieneMateriales(Userindex, ItemIndex, cantT) And _
   UserList(Userindex).Stats.UserSkills(Carpinteria) >= _
   ObjData(ItemIndex).SkCarpinteria And _
   PuedeConstruirCarpintero(ItemIndex) And _
   UserList(Userindex).Invent.HerramientaEqpObjIndex = SERRUCHO_CARPINTERO Then

    Call CarpinteroQuitarMateriales(Userindex, ItemIndex, cantT)
    Call SendData(ToIndex, Userindex, 0, "0M")
    
    Dim MiObj As Obj
    MiObj.Amount = cantT
    MiObj.OBJIndex = ItemIndex

    If Not MeterItemEnInventario(Userindex, MiObj) Then Call TirarItemAlPiso(UserList(Userindex).POS, MiObj)

    
    Call CheckUserLevel(Userindex)

    Call SubirSkill(Userindex, Carpinteria, 5)
    Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "TW" & LABUROCARPINTERO)
End If

End Sub
Public Sub DoLingotes(Userindex As Integer)
Dim Minimo As Integer

Select Case ObjData(UserList(Userindex).flags.TargetObjInvIndex).LingoteIndex
    Case LingoteHierro
        Minimo = 6
    Case LingotePlata
        Minimo = 18
    Case LingoteOro
        Minimo = 34
End Select

If UserList(Userindex).Invent.Object(UserList(Userindex).flags.TargetObjInvslot).Amount < Minimo Then
    Call SendData(ToIndex, Userindex, 0, "M3")
    Exit Sub
End If

Dim nPos As WorldPos
Dim MiObj As Obj

MiObj.Amount = UserList(Userindex).Invent.Object(UserList(Userindex).flags.TargetObjInvslot).Amount / Minimo
MiObj.OBJIndex = ObjData(UserList(Userindex).flags.TargetObjInvIndex).LingoteIndex

If Not MeterItemEnInventario(Userindex, MiObj) Then Call TirarItemAlPiso(UserList(Userindex).POS, MiObj)

UserList(Userindex).Invent.Object(UserList(Userindex).flags.TargetObjInvslot).Amount = 0
UserList(Userindex).Invent.Object(UserList(Userindex).flags.TargetObjInvslot).OBJIndex = 0

Call UpdateUserInv(False, Userindex, UserList(Userindex).flags.TargetObjInvslot)
Call SendData(ToIndex, Userindex, 0, "M1")

End Sub
Function ModFundicion(Clase As Byte) As Single

Select Case (Clase)
    Case MINERO, HERRERO
        ModFundicion = 1
    Case TRABAJADOR, EXPERTO_MINERALES
        ModFundicion = 2.5
    Case Else
        ModFundicion = 3
End Select

End Function
Function ModHerreriA(Clase As Byte) As Single

Select Case (Clase)
    Case HERRERO
        ModHerreriA = 1
    Case Else
        ModHerreriA = 3
End Select

End Function
Function ModCarpinteria(Clase As Byte) As Single

Select Case (Clase)
    Case CARPINTERO
        ModCarpinteria = 1
    Case Else
        ModCarpinteria = 3
End Select

End Function
Function ModMateriales(Clase As Byte) As Single

Select Case (Clase)
    Case HERRERO
        ModMateriales = 1
    Case Else
        ModMateriales = 3
End Select

End Function
Function ModMadera(Clase As Byte) As Double

Select Case (Clase)
    Case CARPINTERO
        ModMadera = 1
    Case Else
        ModMadera = 3
End Select

End Function
Function ModSastre(Clase As Byte) As Double

Select Case (Clase)
    Case SASTRE
        ModSastre = 1
    Case Else
        ModSastre = 3
End Select

End Function
Function ModRopas(Clase As Byte) As Double

Select Case (Clase)
    Case SASTRE
        ModRopas = 1
    Case Else
        ModRopas = 3
End Select

End Function
Function FreeMascotaIndex(Userindex As Integer) As Integer
Dim j As Integer

For j = 1 To MAXMASCOTAS * Buleano(Not UserList(Userindex).flags.Quest)
    If UserList(Userindex).MascotasIndex(j) = 0 Then
        FreeMascotaIndex = j
        Exit Function
    End If
Next

End Function
Sub DoDomar(Userindex As Integer, NpcIndex As Integer)


If UserList(Userindex).NroMascotas < 3 Then
    
    If Npclist(NpcIndex).MaestroUser = Userindex Then
        Call SendData(ToIndex, Userindex, 0, "0N")
        Exit Sub
    End If
    
    If Npclist(NpcIndex).MaestroNpc > 0 Or Npclist(NpcIndex).MaestroUser > 0 Then
        Call SendData(ToIndex, Userindex, 0, "0Ñ")
        Exit Sub
    End If
    
    If Npclist(NpcIndex).flags.Domable <= UserList(Userindex).Stats.UserSkills(Domar) Then
        Dim Index As Integer
        UserList(Userindex).NroMascotas = UserList(Userindex).NroMascotas + 1
        Index = FreeMascotaIndex(Userindex)
        UserList(Userindex).MascotasIndex(Index) = NpcIndex
        UserList(Userindex).MascotasType(Index) = Npclist(NpcIndex).Numero
        
        Npclist(NpcIndex).MaestroUser = Userindex
        
        Call QuitarNPCDeLista(Npclist(NpcIndex).Numero, Npclist(NpcIndex).POS.Map)
        
        Call FollowAmo(NpcIndex)
        
        Call SendData(ToIndex, Userindex, 0, "0O")
        Call SubirSkill(Userindex, Domar)
        
    Else
    
        Call SendData(ToIndex, Userindex, 0, "||Necesitas " & Npclist(NpcIndex).flags.Domable & " puntos para domar a esta criatura. " & FONTTYPE_INFO)
        
    End If
Else
    Call SendData(ToIndex, Userindex, 0, "0Q")
End If

End Sub
Sub DoAdminInvisible(Userindex As Integer)

If UserList(Userindex).flags.AdminInvisible = 0 Then
    UserList(Userindex).flags.AdminInvisible = 1
    UserList(Userindex).flags.Invisible = 1
    Call SendData(ToMap, 0, UserList(Userindex).POS.Map, ("V3" & DesteEncripTE("1," & UserList(Userindex).Char.CharIndex)))
    Call SendData(ToMap, 0, UserList(Userindex).POS.Map, "QDL" & UserList(Userindex).Char.CharIndex)
Else
    UserList(Userindex).flags.AdminInvisible = 0
    UserList(Userindex).flags.Invisible = 0
    Call SendData(ToMap, 0, UserList(Userindex).POS.Map, ("V3" & DesteEncripTE("0," & UserList(Userindex).Char.CharIndex)))
End If
    
End Sub
Sub TratarDeHacerFogata(Map As Integer, X As Integer, y As Integer, Userindex As Integer)
Dim Suerte As Byte
Dim exito As Byte
Dim raise As Byte
Dim Obj As Obj, nPos As WorldPos

If UserList(Userindex).POS.Map <> 24 Then Exit Sub

If Not LegalPos(Map, X, y) Then Exit Sub
nPos.Map = Map
nPos.X = X
nPos.y = y

If Not MapInfo(Map).Pk Then
    Call SendData(ToIndex, Userindex, 0, "||No puedes hacer fogatas en zonas seguras." & FONTTYPE_WARNING)
    Exit Sub
End If

If Distancia(nPos, UserList(Userindex).POS) > 4 Then
    Call SendData(ToIndex, Userindex, 0, "DL")
    Exit Sub
End If

If MapData(Map, X, y).OBJInfo.Amount < 3 Then
    Call SendData(ToIndex, Userindex, 0, "0R")
    Exit Sub
End If

If UserList(Userindex).Stats.UserSkills(Supervivencia) > 1 And UserList(Userindex).Stats.UserSkills(Supervivencia) < 6 Then
    Suerte = 3
ElseIf UserList(Userindex).Stats.UserSkills(Supervivencia) >= 6 And UserList(Userindex).Stats.UserSkills(Supervivencia) <= 10 Then
    Suerte = 2
ElseIf UserList(Userindex).Stats.UserSkills(Supervivencia) >= 10 Then
    Suerte = 1
End If

exito = RandomNumber(1, Suerte)

If exito = 1 Then
    Obj.OBJIndex = FOGATA_APAG
    Obj.Amount = MapData(Map, X, y).OBJInfo.Amount / 3
    
    If Obj.Amount > 1 Then
        Call SendData(ToIndex, Userindex, 0, "0S" & Obj.Amount)
    Else
        Call SendData(ToIndex, Userindex, 0, "0T")
    End If
    
    Call MakeObj(ToMap, 0, Map, Obj, Map, X, y)
    
    Dim Fogatita As New cGarbage
    Fogatita.Map = Map
    Fogatita.X = X
    Fogatita.y = y
    Call TrashCollector.Add(Fogatita)
    
Else
    Call SendData(ToIndex, Userindex, 0, "0U")
End If

Call SubirSkill(Userindex, Supervivencia)


End Sub
Public Sub DoTalar(Userindex As Integer, Elfico As Boolean)
On Error GoTo errhandler
Dim MiObj As Obj
Dim Factor As Integer
Dim Esfuerzo As Integer

If UserList(Userindex).Clase = TALADOR Then
    Esfuerzo = EsfuerzoTalarLeñador
Else
    Esfuerzo = EsfuerzoTalarGeneral
End If

If UserList(Userindex).Stats.MinSta >= Esfuerzo Then
    Call QuitarSta(Userindex, Esfuerzo)
    Call SendUserSTA(Userindex)
Else
    Call SendData(ToIndex, Userindex, 0, "9E")
    Exit Sub
End If

If Elfico Then
    MiObj.OBJIndex = LeñaElfica
    Factor = 6
Else
    MiObj.OBJIndex = Leña
    Factor = 5
End If



If UserList(Userindex).Clase = TALADOR Then
    If UserList(Userindex).Recompensas(1) Then
    MiObj.Amount = 26
    ElseIf UserList(Userindex).Recompensas(2) Then
    MiObj.Amount = 26
    Else
   ' MiObj.Amount = Fix(4 + ((0.29 + 0.07)) * UserList(Userindex).Stats.UserSkills(Talar))
   MiObj.Amount = Fix(4 + ((0.29 + 0.07)) * 50)
    End If
Else: MiObj.Amount = 1
End If

If Not MeterItemEnInventario(Userindex, MiObj) Then Call TirarItemAlPiso(UserList(Userindex).POS, MiObj)

Call SendData(ToPCArea, CInt(Userindex), UserList(Userindex).POS.Map, "TW" & SOUND_TALAR)
Call SubirSkill(Userindex, Talar, 5)

Exit Sub

errhandler:
    Call LogError("Error en DoTalar")

End Sub
Public Sub DoPescar(Userindex As Integer)
On Error GoTo errhandler
Dim Esfuerzo As Integer
Dim MiObj As Obj

If UserList(Userindex).Clase = PESCADOR Then
    Esfuerzo = EsfuerzoPescarPescador
Else
    Esfuerzo = EsfuerzoPescarGeneral
End If

If UserList(Userindex).Stats.MinSta >= Esfuerzo Then
    Call QuitarSta(Userindex, Esfuerzo)
    Call SendUserSTA(Userindex)
Else
    Call SendData(ToIndex, Userindex, 0, "9E")
    Exit Sub
End If

MiObj.OBJIndex = Pescado


If UserList(Userindex).Clase = PESCADOR Then
    If UserList(Userindex).Recompensas(1) = 2 And UserList(Userindex).flags.Navegando = 1 And UserList(Userindex).Invent.HerramientaEqpObjIndex = RED_PESCA And CInt(RandomNumber(1, 10)) <= 1 Then MiObj.OBJIndex = PescadoCaro + CInt(RandomNumber(1, 3))
    MiObj.Amount = Fix(4 + ((0.29 + 0.07 * Buleano(UserList(Userindex).Recompensas(1) = 1)) * UserList(Userindex).Stats.UserSkills(Pesca)))
    If UserList(Userindex).Invent.HerramientaEqpObjIndex <> RED_PESCA Then MiObj.Amount = MiObj.Amount / 2
Else: MiObj.Amount = 1
End If

Call SubirSkill(Userindex, Pesca, 5)
If Not MeterItemEnInventario(Userindex, MiObj) Then Call TirarItemAlPiso(UserList(Userindex).POS, MiObj)
Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "TW" & SOUND_PESCAR)

Exit Sub

errhandler:
    Call LogError("Error en DoPescar")

End Sub
Public Function Buleano(a As Boolean) As Byte

Buleano = -a

End Function
Public Sub DoRobar(LadronIndex As Integer, VictimaIndex As Integer)
Dim Res As Integer
Dim N As Long



If TriggerZonaPelea(LadronIndex, VictimaIndex) <> TRIGGER6_AUSENTE Then Exit Sub
If TriggerZonaPelea7(LadronIndex, VictimaIndex) <> TRIGGER6_AUSENTE Then Exit Sub

If Not PuedeRobar(LadronIndex, VictimaIndex) Then Exit Sub

If MapInfo(UserList(LadronIndex).POS.Map).EsMapaEspecial Then
Call SendData(ToIndex, LadronIndex, 0, "||No puedes robar en este mapa." & FONTTYPE_INFO)
Exit Sub
End If

UserList(LadronIndex).Counters.LastRobo = Timer

Res = RandomNumber(1, 100)

If Res > UserList(LadronIndex).Stats.UserSkills(Robar) \ 10 + 25 * Buleano(UserList(LadronIndex).Clase = LADRON) + 5 * Buleano(UserList(LadronIndex).Clase = LADRON And UserList(LadronIndex).Recompensas(1) = 2) Then
    Call SendData(ToIndex, LadronIndex, 0, "X0")
    Call SendData(ToIndex, VictimaIndex, 0, "Y0" & UserList(LadronIndex).Name)
ElseIf UserList(LadronIndex).Clase = LADRON And TieneObjetosRobables(VictimaIndex) And Res <= 10 * Buleano(UserList(LadronIndex).Recompensas(2) = 2) + 10 * Buleano(UserList(LadronIndex).Recompensas(3) = 2) Then
    Call RobarObjeto(LadronIndex, VictimaIndex)
ElseIf UserList(VictimaIndex).Stats.GLD = 0 Then
    Call SendData(ToIndex, LadronIndex, 0, "W0")
    Call SendData(ToIndex, VictimaIndex, 0, "Y0" & UserList(LadronIndex).Name)
Else
    N = Minimo((1 + 0.1 * Buleano(UserList(LadronIndex).Recompensas(1) = 1 And UserList(LadronIndex).Clase = LADRON)) * (RandomNumber(1, (UserList(LadronIndex).Stats.UserSkills(Robar) * (UserList(VictimaIndex).Stats.ELV / 10) * UserList(LadronIndex).Stats.ELV)) / (10 + 10 * Buleano(Not UserList(LadronIndex).Clase = LADRON))), UserList(VictimaIndex).Stats.GLD)
    
    UserList(VictimaIndex).Stats.GLD = UserList(VictimaIndex).Stats.GLD - N
    Call AddtoVar(UserList(LadronIndex).Stats.GLD, N, MAXORO)
   
    Call SendData(ToIndex, LadronIndex, 0, "U0" & UserList(VictimaIndex).Name & "," & N)
    Call SendData(ToIndex, VictimaIndex, 0, "V0" & UserList(LadronIndex).Name & "," & N)
    
    Call SendUserORO(LadronIndex)
    Call SendUserORO(VictimaIndex)
End If

'Call SubirSkill(LadronIndex, Robar)



End Sub
Public Function ObjEsRobable(VictimaIndex As Integer, Slot As Byte) As Boolean
Dim OI As Integer

OI = UserList(VictimaIndex).Invent.Object(Slot).OBJIndex
If OI = 0 Then Exit Function

ObjEsRobable = ObjData(OI).ObjType <> OBJTYPE_LLAVES And _
                ObjData(OI).ObjType <> OBJTYPE_BARCOS And _
                Not ObjData(OI).Real And _
                Not ObjData(OI).Caos And _
                Not ObjData(OI).NoSeCae

End Function
Public Sub RobarObjeto(LadronIndex As Integer, VictimaIndex As Integer)
Dim IndexRobo As Byte
Dim MiObj As Obj
Dim Num As Byte

Do
    IndexRobo = RandomNumber(1, MAX_INVENTORY_SLOTS)
    If ObjEsRobable(VictimaIndex, IndexRobo) Then Exit Do
Loop

MiObj.OBJIndex = UserList(VictimaIndex).Invent.Object(IndexRobo).OBJIndex

Num = Minimo(RandomNumber(1, 4 + 96 * Buleano(ObjData(MiObj.OBJIndex).ObjType = OBJTYPE_POCIONES)), UserList(VictimaIndex).Invent.Object(IndexRobo).Amount)

If UserList(VictimaIndex).Invent.Object(IndexRobo).Equipped = 1 Then Call Desequipar(VictimaIndex, IndexRobo)

MiObj.Amount = Num

UserList(VictimaIndex).Invent.Object(IndexRobo).Amount = UserList(VictimaIndex).Invent.Object(IndexRobo).Amount - Num
If UserList(VictimaIndex).Invent.Object(IndexRobo).Amount <= 0 Then Call QuitarUserInvItem(VictimaIndex, CByte(IndexRobo), 1)

If Not MeterItemEnInventario(LadronIndex, MiObj) Then Call TirarItemAlPiso(UserList(LadronIndex).POS, MiObj)

Call SendData(ToIndex, LadronIndex, 0, "||Has robado " & ObjData(MiObj.OBJIndex).Name & " (" & MiObj.Amount & ")." & FONTTYPE_INFO)
Call UpdateUserInv(False, VictimaIndex, CByte(IndexRobo))

End Sub
Public Sub DoApuñalar(Userindex As Integer, ByVal VictimNpcIndex As Integer, ByVal VictimUserIndex As Integer, ByVal Daño As Integer)
Dim Prob As Integer

Prob = 20 - 1.2 * UserList(Userindex).Stats.UserSkills(Apuñalar) \ 10

Select Case UserList(Userindex).Clase
    Case ASESINO
        'Prob = Prob - 3 - Buleano(UserList(Userindex).Recompensas(3) = 2)
        Prob = Prob - 2 - Buleano(UserList(Userindex).Recompensas(3) = 1) ' le pongo como el bardo o no para de apuñalar el forro
    Case BARDO
        Prob = Prob - 2 - Buleano(UserList(Userindex).Recompensas(3) = 1)
End Select

If RandomNumber(1, Prob) <= 1 Then
    If VictimUserIndex Then
        If UserList(Userindex).Clase = ASESINO And UserList(Userindex).Recompensas(3) = 1 Then
            Daño = Daño * 1.6
        Else: Daño = Daño * 1.5
        End If
        If Not UserList(VictimUserIndex).flags.Quest And UserList(VictimUserIndex).flags.Privilegios = 0 Then
            UserList(VictimUserIndex).Stats.MinHP = UserList(VictimUserIndex).Stats.MinHP - Daño
            Call SendUserHP(VictimUserIndex)
        End If
        Call SendData(ToIndex, Userindex, 0, "5K" & UserList(VictimUserIndex).Name & "," & Daño)
        Call SendData(ToIndex, VictimUserIndex, 0, "5L" & UserList(Userindex).Name & "," & Daño)
    
        Call SendData(ToPCArea, VictimUserIndex, UserList(VictimUserIndex).POS.Map, "HM" & FONTTYPE_ORO & "°" & Daño & "°" & UserList(VictimUserIndex).POS.X & "°" & UserList(VictimUserIndex).POS.y & "°" & UserList(VictimUserIndex).Char.CharIndex & "°" & "2")

        Call SendData(ToPCArea, Userindex, 0, "TW201") ' apu fx y wav
        Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "CFX" & UserList(Userindex).Char.CharIndex & "," & UserList(VictimUserIndex).Char.CharIndex & "," & 36 & "," & 0 & "," & 0) 'dx8
    ElseIf VictimNpcIndex Then
        Select Case UserList(Userindex).Clase
            Case ASESINO
                Daño = Daño * 2
            Case Else
                Daño = Daño * 1.5
        End Select
        Call SendData(ToIndex, Userindex, 0, "5M" & Daño)
        Call ExperienciaPorGolpe(Userindex, VictimNpcIndex, Daño)
                Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "CFX" & UserList(Userindex).Char.CharIndex & "," & Npclist(VictimNpcIndex).Char.CharIndex & "," & 36 & "," & 0 & "," & 0) 'dx8
        Call VerNPCMuere(VictimNpcIndex, Daño, Userindex)
        Call SendData(ToPCArea, Userindex, 0, "TW201") ' apu fx y wav
        
        Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "HM" & FONTTYPE_ORO & "°" & Daño & "°" & UserList(VictimNpcIndex).POS.X & "°" & UserList(VictimNpcIndex).POS.y & "°" & UserList(VictimNpcIndex).Char.CharIndex & "°" & "2")
        

    End If
Else
    Call SendData(ToIndex, Userindex, 0, "5N")
End If

End Sub
Public Sub QuitarSta(Userindex As Integer, Cantidad As Integer)

If UserList(Userindex).flags.Quest Or UserList(Userindex).flags.Privilegios > 2 Then Exit Sub
UserList(Userindex).Stats.MinSta = UserList(Userindex).Stats.MinSta - Cantidad
If UserList(Userindex).Stats.MinSta < 0 Then UserList(Userindex).Stats.MinSta = 0

End Sub
Public Sub DoMineria(Userindex As Integer, Mineral As Integer)
On Error GoTo errhandler
Dim MiObj As Obj
Dim Esfuerzo As Integer

If UserList(Userindex).Clase = MINERO Then
    Esfuerzo = EsfuerzoExcavarMinero
Else: Esfuerzo = EsfuerzoExcavarGeneral
End If

If UserList(Userindex).Stats.MinSta >= Esfuerzo Then
    Call QuitarSta(Userindex, Esfuerzo)
    Call SendUserSTA(Userindex)
Else
    Call SendData(ToIndex, Userindex, 0, "9E")
    Exit Sub
End If

MiObj.OBJIndex = Mineral



If UserList(Userindex).Clase = MINERO Then
    MiObj.Amount = Fix(4 + ((0.29 + 0.07 * Buleano(UserList(Userindex).Recompensas(1) = 1 And UserList(Userindex).Invent.HerramientaEqpObjIndex = PICO_EXPERTO)) * UserList(Userindex).Stats.UserSkills(Mineria)))
Else: MiObj.Amount = 1
End If

If Not MeterItemEnInventario(Userindex, MiObj) Then Call TirarItemAlPiso(UserList(Userindex).POS, MiObj)
Call SubirSkill(Userindex, Mineria, 5)
Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "TW" & SOUND_MINERO)

Exit Sub

errhandler:
    Call LogError("Error en Sub DoMineria")

End Sub
Public Sub DoMeditar(Userindex As Integer)

UserList(Userindex).Counters.IdleCount = Timer

Dim Suerte As Integer
Dim Res As Integer
Dim Cant As Integer

If UserList(Userindex).Stats.MinMAN >= UserList(Userindex).Stats.MaxMAN Then
    Call SendData(ToIndex, Userindex, 0, "D9")
    Call SendData(ToIndex, Userindex, 0, "MEDOK")
    UserList(Userindex).flags.Meditando = False
    UserList(Userindex).Char.FX = 0
    UserList(Userindex).Char.loops = 0
    Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "CFX" & UserList(Userindex).Char.CharIndex & "," & UserList(Userindex).Char.CharIndex & "," & 0 & "," & 0 & "," & 0) 'dx8
    Exit Sub
End If

If UserList(Userindex).Stats.UserSkills(Meditar) <= 10 _
   And UserList(Userindex).Stats.UserSkills(Meditar) >= -1 Then
                    Suerte = 35
ElseIf UserList(Userindex).Stats.UserSkills(Meditar) <= 20 _
   And UserList(Userindex).Stats.UserSkills(Meditar) >= 11 Then
                    Suerte = 30
ElseIf UserList(Userindex).Stats.UserSkills(Meditar) <= 30 _
   And UserList(Userindex).Stats.UserSkills(Meditar) >= 21 Then
                    Suerte = 28
ElseIf UserList(Userindex).Stats.UserSkills(Meditar) <= 40 _
   And UserList(Userindex).Stats.UserSkills(Meditar) >= 31 Then
                    Suerte = 24
ElseIf UserList(Userindex).Stats.UserSkills(Meditar) <= 50 _
   And UserList(Userindex).Stats.UserSkills(Meditar) >= 41 Then
                    Suerte = 22
ElseIf UserList(Userindex).Stats.UserSkills(Meditar) <= 60 _
   And UserList(Userindex).Stats.UserSkills(Meditar) >= 51 Then
                    Suerte = 20
ElseIf UserList(Userindex).Stats.UserSkills(Meditar) <= 70 _
   And UserList(Userindex).Stats.UserSkills(Meditar) >= 61 Then
                    Suerte = 18
ElseIf UserList(Userindex).Stats.UserSkills(Meditar) <= 80 _
   And UserList(Userindex).Stats.UserSkills(Meditar) >= 71 Then
                    Suerte = 15
ElseIf UserList(Userindex).Stats.UserSkills(Meditar) <= 90 _
   And UserList(Userindex).Stats.UserSkills(Meditar) >= 81 Then
                    Suerte = 10
ElseIf UserList(Userindex).Stats.UserSkills(Meditar) <= 99 _
   And UserList(Userindex).Stats.UserSkills(Meditar) >= 91 Then
                    Suerte = 8

ElseIf UserList(Userindex).Stats.UserSkills(Meditar) = 100 Then

                    Suerte = 5
End If
Res = RandomNumber(1, Suerte)

If Res = 1 Then
    If UserList(Userindex).Stats.MaxMAN > 0 Then Cant = Maximo(1, Porcentaje(UserList(Userindex).Stats.MaxMAN, 3))
    Call AddtoVar(UserList(Userindex).Stats.MinMAN, Cant, UserList(Userindex).Stats.MaxMAN)
    Call SendData(ToIndex, Userindex, 0, "MN" & THeDEnCripTe(Cant, "STRINGGENM"))
    Call SendUserMANA(Userindex)
    Call SubirSkill(Userindex, Meditar)
End If

End Sub
Public Sub InicioTrabajo(Userindex As Integer, Trabajo As Long, TrabajoPos As WorldPos)


If Distancia(TrabajoPos, UserList(Userindex).POS) > 2 Then
    Call SendData(ToIndex, Userindex, 0, "DL")
    Exit Sub
End If


Select Case Trabajo
    
    

    Case Pesca
    
        
        If UserList(Userindex).Invent.HerramientaEqpObjIndex <> OBJTYPE_CAÑA And UserList(Userindex).Invent.HerramientaEqpObjIndex <> RED_PESCA Then
            Call SendData(ToIndex, Userindex, 0, "%6")
            Exit Sub
        End If
        
        If MapData(UserList(Userindex).POS.Map, TrabajoPos.X, TrabajoPos.y).Agua = 0 Then
            Call SendData(ToIndex, Userindex, 0, "6N")
            Exit Sub
        End If

    Case Talar
        
        If Trabajo = Talar Then
            If UserList(Userindex).Invent.HerramientaEqpObjIndex <> HACHA_LEÑADOR Then
                Call SendData(ToIndex, Userindex, 0, "%7")
                Exit Sub
            End If
        End If
        
        
        
        If MapData(UserList(Userindex).POS.Map, UserList(Userindex).POS.X, UserList(Userindex).POS.y).trigger = 4 Then
            Call SendData(ToIndex, Userindex, 0, "0W")
            Exit Sub
        End If

        If Not ObjData(MapData(TrabajoPos.Map, TrabajoPos.X, TrabajoPos.y).OBJInfo.OBJIndex).ObjType = OBJTYPE_ARBOLES Then
            Call SendData(ToIndex, Userindex, 0, "2S")
            Exit Sub
        End If
                   
    Case Mineria
        
        If UserList(Userindex).Invent.HerramientaEqpObjIndex <> PIQUETE_MINERO And UserList(Userindex).Invent.HerramientaEqpObjIndex <> PICO_EXPERTO Then
            Call SendData(ToIndex, Userindex, 0, "%9")
            Exit Sub
        End If
        
        If Not ObjData(MapData(TrabajoPos.Map, TrabajoPos.X, TrabajoPos.y).OBJInfo.OBJIndex).ObjType = OBJTYPE_YACIMIENTO Then
            Call SendData(ToIndex, Userindex, 0, "7N")
            Exit Sub
        End If

End Select


UserList(Userindex).flags.Trabajando = Trabajo

UserList(Userindex).TrabajoPos.X = TrabajoPos.X
UserList(Userindex).TrabajoPos.y = TrabajoPos.y
Call SendData(ToIndex, Userindex, 0, "%0")
Call SendData(ToIndex, Userindex, 0, "MT")


End Sub
