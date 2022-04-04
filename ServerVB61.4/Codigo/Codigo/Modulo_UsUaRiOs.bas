Attribute VB_Name = "UsUaRiOs"
 
'director del proyecto: #Esteban(Neliam)

'servidor basado en fénixao 1.0
'medios de contacto:
'Skype: dc.esteban
'E-mail: nabrianao@gmail.com
Option Explicit
Sub MostrarNumUsers()

Call SendData(ToAll, 0, 0, "NON" & NumNoGMs)

End Sub
Sub ActStats(ByVal VictimIndex As Integer, ByVal AttackerIndex As Integer)

'If UserList(AttackerIndex).POS.Map <> 190 Or UserList(AttackerIndex).POS.Map <> 170 Then
   ' Dim DaExp As Integer
   ' DaExp = CInt(UserList(VictimIndex).Stats.ELV * RandomNumber(1, 4))
   ' Call AddtoVar(UserList(AttackerIndex).Stats.Exp, DaExp, MAXEXP)
'End If


Call SendData(ToIndex, AttackerIndex, 0, "1Q" & UserList(VictimIndex).Name)
'Call SendData(ToIndex, AttackerIndex, 0, "EX" & DaExp)
Call SendData(ToIndex, VictimIndex, 0, "1R" & UserList(AttackerIndex).Name)

 If VictimIndex = GranPoder Then
        Call SendData(ToAll, 0, 0, "||Poder> " & UserList(VictimIndex).Name & " ha muerto por " & UserList(AttackerIndex).Name & ", se encuentra en el mapa " & UserList(GranPoder).POS.Map & "." & FONTTYPE_PODER)
        Call OtorgarGranPoder2(AttackerIndex)
    End If

   Call UserDie(VictimIndex)

UserList(AttackerIndex).Stats.Reputacion = UserList(AttackerIndex).Stats.Reputacion + 2
Call SendUserREP(AttackerIndex)

 If ApuestanPj = True Then
    If VictimIndex = ApostandoPj(1).Index And UCase$(UserList(VictimIndex).Name) = UCase$(UserList(ApostandoPj(1).Index).Name) Then
        If AttackerIndex = ApostandoPj(2).Index And UCase$(UserList(AttackerIndex).Name) = UCase$(UserList(ApostandoPj(2).Index).Name) Then
           Call GanaRoundRP(2)
        End If
     ElseIf VictimIndex = ApostandoPj(2).Index And UCase$(UserList(VictimIndex).Name) = UCase$(UserList(ApostandoPj(2).Index).Name) Then
        If AttackerIndex = ApostandoPj(1).Index And UCase$(UserList(AttackerIndex).Name) = UCase$(UserList(ApostandoPj(1).Index).Name) Then
            Call GanaRoundRP(1)
        End If
     
     End If
End If

If UserList(VictimIndex).flags.EnDM = True Then
UserList(AttackerIndex).Stats.GLD = UserList(AttackerIndex).Stats.GLD + 50000
Call SendUserStatsBox(AttackerIndex)
UserList(AttackerIndex).flags.DmKills = UserList(AttackerIndex).flags.DmKills + 1
Call SendData(ToIndex, AttackerIndex, 0, "||Has ganado 50.000 monedas de oro." & FONTTYPE_TALK)
UserList(VictimIndex).Stats.GLD = UserList(VictimIndex).Stats.GLD - 50000
Call SendUserStatsBox(VictimIndex)
UserList(VictimIndex).flags.DmMuertes = UserList(VictimIndex).flags.DmMuertes + 1
Call SendData(ToIndex, VictimIndex, 0, "||Has perdido 50.000 monedas de oro." & FONTTYPE_TALK)
Call WarpUserChar(VictimIndex, 191, 21, 14, True)
End If



'Torneo auto 2vs2.
 If (Torneo_ActivoX) Then
Select Case VictimIndex
    Case Pareja12vs2.User12vs2
        If UserList(Pareja12vs2.User22vs2).flags.Muerto = 1 Then
        Call Rondas_UsuarioMuere2vs2(Pareja12vs2.User12vs2)
                If AutomaticoCanjes = 1 Then Call WarpUserChar(Pareja12vs2.User12vs2, 198, 57, 56)
        If AutomaticoCanjes = 1 Then Call WarpUserChar(Pareja12vs2.User22vs2, 198, 57, 56)
        If AutomaticoCanjes = 0 Then Call WarpUserChar(Pareja12vs2.User12vs2, 1, 50, 50)
        If AutomaticoCanjes = 0 Then Call WarpUserChar(Pareja12vs2.User22vs2, 1, 50, 50)
        If AutomaticoCanjes = 1 Then Call TirarTodosLosItems(Pareja12vs2.User12vs2)
        If AutomaticoCanjes = 1 Then Call TirarTodosLosItems(Pareja12vs2.User22vs2)
        End If
    Exit Sub
    Case Pareja12vs2.User22vs2
        If UserList(Pareja12vs2.User12vs2).flags.Muerto = 1 Then
        Call Rondas_UsuarioMuere2vs2(Pareja12vs2.User12vs2)
        If AutomaticoCanjes = 1 Then Call WarpUserChar(Pareja12vs2.User12vs2, 198, 57, 56)
        If AutomaticoCanjes = 1 Then Call WarpUserChar(Pareja12vs2.User22vs2, 198, 57, 56)
        If AutomaticoCanjes = 0 Then Call WarpUserChar(Pareja12vs2.User12vs2, 1, 50, 50)
        If AutomaticoCanjes = 0 Then Call WarpUserChar(Pareja12vs2.User22vs2, 1, 50, 50)
        If AutomaticoCanjes = 1 Then Call TirarTodosLosItems(Pareja12vs2.User12vs2)
        If AutomaticoCanjes = 1 Then Call TirarTodosLosItems(Pareja12vs2.User22vs2)
        End If
    Exit Sub
    Case Pareja22vs2.User12vs2
        If UserList(Pareja22vs2.User22vs2).flags.Muerto = 1 Then
        Call Rondas_UsuarioMuere2vs2(Pareja22vs2.User12vs2)
        If AutomaticoCanjes = 1 Then Call WarpUserChar(Pareja22vs2.User12vs2, 198, 57, 56)
        If AutomaticoCanjes = 1 Then Call WarpUserChar(Pareja22vs2.User22vs2, 198, 57, 56)
        If AutomaticoCanjes = 0 Then Call WarpUserChar(Pareja22vs2.User12vs2, 1, 50, 50)
        If AutomaticoCanjes = 0 Then Call WarpUserChar(Pareja22vs2.User22vs2, 1, 50, 50)
        If AutomaticoCanjes = 1 Then Call TirarTodosLosItems(Pareja22vs2.User12vs2)
        If AutomaticoCanjes = 1 Then Call TirarTodosLosItems(Pareja22vs2.User22vs2)
        End If
    Exit Sub
    Case Pareja22vs2.User22vs2
        If UserList(Pareja22vs2.User12vs2).flags.Muerto = 1 Then
        Call Rondas_UsuarioMuere2vs2(Pareja22vs2.User12vs2)
        If AutomaticoCanjes = 1 Then Call WarpUserChar(Pareja22vs2.User12vs2, 198, 57, 56)
        If AutomaticoCanjes = 1 Then Call WarpUserChar(Pareja22vs2.User22vs2, 198, 57, 56)
        If AutomaticoCanjes = 0 Then Call WarpUserChar(Pareja22vs2.User12vs2, 1, 50, 50)
        If AutomaticoCanjes = 0 Then Call WarpUserChar(Pareja22vs2.User22vs2, 1, 50, 50)
        If AutomaticoCanjes = 1 Then Call TirarTodosLosItems(Pareja22vs2.User12vs2)
        If AutomaticoCanjes = 1 Then Call TirarTodosLosItems(Pareja22vs2.User22vs2)
        End If
    Exit Sub
    Case Else
    
End Select
End If
   
   




End Sub
Sub RevivirUsuarioNPC(Userindex As Integer)

Call SendData(ToIndex, Userindex, 0, "MH" & 0 & "," & TiempoReal)
UserList(Userindex).flags.Muerto = 0
UserList(Userindex).Stats.MinHP = UserList(Userindex).Stats.MaxHP

Call DarCuerpoDesnudo(Userindex)
Call ChangeUserChar(ToMap, 0, UserList(Userindex).POS.Map, Userindex, UserList(Userindex).Char.Body, UserList(Userindex).Char.Head, UserList(Userindex).Char.Heading, UserList(Userindex).Char.WeaponAnim, UserList(Userindex).Char.ShieldAnim, UserList(Userindex).Char.CascoAnim)
Call SendUserStatsBox(Userindex)

End Sub
Sub RevivirUsuario(ByVal Resucitador As Integer, Userindex As Integer, ByVal Lleno As Boolean)

UserList(Resucitador).Stats.MinHP = 30
UserList(Resucitador).Stats.MinMAN = 50
UserList(Resucitador).Stats.MinHam = 0
UserList(Resucitador).Stats.MinAGU = 0

UserList(Userindex).flags.Muerto = 0
Call SendData(ToIndex, Userindex, 0, "MH" & 0 & "," & TiempoReal)

If Lleno Then
    UserList(Userindex).Stats.MinHP = UserList(Userindex).Stats.MaxHP
    UserList(Userindex).Stats.MinSta = UserList(Userindex).Stats.MaxSta
    UserList(Userindex).Stats.MinMAN = UserList(Userindex).Stats.MaxMAN
    UserList(Userindex).Stats.MinHam = UserList(Userindex).Stats.MaxHam
    UserList(Userindex).Stats.MinAGU = UserList(Userindex).Stats.MaxAGU
    UserList(Userindex).flags.Sed = 0
    UserList(Userindex).flags.Hambre = 0
Else
    UserList(Userindex).Stats.MinHP = 1
    UserList(Userindex).Stats.MinSta = 0
    UserList(Userindex).Stats.MinMAN = 0
    UserList(Userindex).Stats.MinHam = 0
    UserList(Userindex).Stats.MinAGU = 0
    UserList(Userindex).flags.Sed = 1
    UserList(Userindex).flags.Hambre = 1
End If

Call DarCuerpoDesnudo(Userindex)
Call ChangeUserChar(ToMap, 0, UserList(Userindex).POS.Map, Userindex, UserList(Userindex).Char.Body, UserList(Userindex).Char.Head, UserList(Userindex).Char.Heading, UserList(Userindex).Char.WeaponAnim, UserList(Userindex).Char.ShieldAnim, UserList(Userindex).Char.CascoAnim)

Call SendUserStatsBox(Resucitador)
Call EnviarHambreYsed(Resucitador)

Call SendUserStatsBox(Userindex)
Call EnviarHambreYsed(Userindex)

End Sub
Sub ReNombrar(Userindex As Integer, NewNick As String)
 
If FileExist(CharPath & UCase$(UserList(Userindex).Name) & ".chr", vbNormal) Then
    Kill CharPath & UCase$(UserList(Userindex).Name) & ".chr"
End If

Call SendData(ToAll, 0, 0, "||El usuario " & UserList(Userindex).Name & " ha sido rebautizado como " & NewNick & "." & FONTTYPE_FIGHT)
UserList(Userindex).Name = NewNick
Call WarpUserChar(Userindex, UserList(Userindex).POS.Map, UserList(Userindex).POS.X, UserList(Userindex).POS.y, False)
 
End Sub
Sub AutoCuraUser(ByVal Userindex As Integer) 'Sacerdotes Automáticos
If UserList(Userindex).flags.Muerto = 1 Then
Call RevivirUsuarioNPC(Userindex)
UserList(Userindex).Stats.MinHP = UserList(Userindex).Stats.MaxHP
Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "TW111") 'Sonido
Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "TWresucitanpc")  'Sonido
Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "CFX" & UserList(Userindex).Char.CharIndex & "," & UserList(Userindex).Char.CharIndex & "," & 41 & "," & 0 & "," & 0) 'dx8
Call SendData(ToIndex, Userindex, 0, "||¡Hás sido resucitado!" & FONTTYPE_INFO)
Call SendUserStatsBox(Userindex)
End If

If UserList(Userindex).Stats.MinHP < UserList(Userindex).Stats.MaxHP Then
UserList(Userindex).Stats.MinHP = UserList(Userindex).Stats.MaxHP
Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "TW111")  'Sonido
Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "CFX" & UserList(Userindex).Char.CharIndex & "," & UserList(Userindex).Char.CharIndex & "," & 41 & "," & 0 & "," & 0) 'dx8
Call SendData(ToIndex, Userindex, 0, "||¡Hás sido curado!" & FONTTYPE_INFO)
Call SendUserStatsBox(Userindex)
End If
 
If UserList(Userindex).flags.Envenenado = 1 Then UserList(Userindex).flags.Envenenado = 0
End Sub 'Sacerdotes Automáticos
Sub ChangeUserChar(ByVal sndRoute As Byte, ByVal sndIndex As Integer, ByVal sndMap As Integer, Userindex As Integer, _
ByVal Body As Integer, ByVal Head As Integer, ByVal Heading As Byte, _
ByVal Arma As Integer, ByVal Escudo As Integer, ByVal Casco As Integer)

On Error Resume Next

UserList(Userindex).Char.Body = Body
UserList(Userindex).Char.Head = Head
UserList(Userindex).Char.Heading = Heading
UserList(Userindex).Char.WeaponAnim = Arma
UserList(Userindex).Char.ShieldAnim = Escudo
UserList(Userindex).Char.CascoAnim = Casco

Call SendData(sndRoute, sndIndex, sndMap, "CP" & UserList(Userindex).Char.CharIndex & "," & Body & "," & Head & "," & Heading & "," & Arma & "," & Escudo & "," & UserList(Userindex).Char.FX & "," & UserList(Userindex).Char.loops & "," & Casco)

End Sub
Sub ChangeUserCharB(ByVal sndRoute As Byte, ByVal sndIndex As Integer, ByVal sndMap As Integer, Userindex As Integer, _
ByVal Body As Integer, ByVal Head As Integer, ByVal Heading As Byte, _
ByVal Arma As Integer, ByVal Escudo As Integer, ByVal Casco As Integer)

On Error Resume Next

UserList(Userindex).Char.Body = Body
UserList(Userindex).Char.Head = Head
UserList(Userindex).Char.Heading = Heading
UserList(Userindex).Char.WeaponAnim = Arma
UserList(Userindex).Char.ShieldAnim = Escudo
UserList(Userindex).Char.CascoAnim = Casco

Call SendData(sndRoute, sndIndex, sndMap, "CP" & UserList(Userindex).Char.CharIndex & "," & Body & "," & Head & "," & Heading & "," & Arma & "," & Escudo & "," & UserList(Userindex).Char.FX & "," & UserList(Userindex).Char.loops & "," & Casco & "," & UserList(Userindex).flags.Navegando)

End Sub
Sub ChangeUserCasco(ByVal sndRoute As Byte, ByVal sndIndex As Integer, ByVal sndMap As Integer, Userindex As Integer, _
ByVal Casco As Integer)

On Error Resume Next

If UserList(Userindex).Char.CascoAnim <> Casco Then
UserList(Userindex).Char.CascoAnim = Casco
Call SendData(sndRoute, sndIndex, sndMap, "7C" & UserList(Userindex).Char.CharIndex & "," & Casco)
End If

End Sub
Sub ChangeUserEscudo(ByVal sndRoute As Byte, ByVal sndIndex As Integer, ByVal sndMap As Integer, Userindex As Integer, ByVal Escudo As Integer)
On Error Resume Next

If UserList(Userindex).Char.ShieldAnim <> Escudo Then
    UserList(Userindex).Char.ShieldAnim = Escudo
    Call SendData(sndRoute, sndIndex, sndMap, "6C" & UserList(Userindex).Char.CharIndex & "," & Escudo)
End If

End Sub


Sub ChangeUserArma(ByVal sndRoute As Byte, ByVal sndIndex As Integer, ByVal sndMap As Integer, Userindex As Integer, _
ByVal Arma As Integer)

On Error Resume Next

If UserList(Userindex).Char.WeaponAnim <> Arma Then
    UserList(Userindex).Char.WeaponAnim = Arma
    Call SendData(sndRoute, sndIndex, sndMap, "5C" & UserList(Userindex).Char.CharIndex & "," & Arma)
End If


End Sub


Sub ChangeUserHead(ByVal sndRoute As Byte, ByVal sndIndex As Integer, ByVal sndMap As Integer, Userindex As Integer, _
ByVal Head As Integer)

On Error Resume Next

If UserList(Userindex).Char.Head <> Head Then
UserList(Userindex).Char.Head = Head
Call SendData(sndRoute, sndIndex, sndMap, "4C" & UserList(Userindex).Char.CharIndex & "," & Head)
End If

End Sub

Sub ChangeUserBody(ByVal sndRoute As Byte, ByVal sndIndex As Integer, ByVal sndMap As Integer, Userindex As Integer, _
ByVal Body As Integer)

On Error Resume Next
UserList(Userindex).Char.Body = Body
Call SendData(sndRoute, sndIndex, sndMap, "3C" & UserList(Userindex).Char.CharIndex & "," & Body)


End Sub
Sub ChangeUserHeading(ByVal sndRoute As Byte, ByVal sndIndex As Integer, ByVal sndMap As Integer, Userindex As Integer, _
ByVal Heading As Byte)
On Error Resume Next

UserList(Userindex).Char.Heading = Heading
Call SendData(sndRoute, sndIndex, sndMap, "2C" & UserList(Userindex).Char.CharIndex & "," & Heading)

End Sub
Sub EnviarSubirNivel(Userindex As Integer, ByVal Puntos As Integer)

Call SendData(ToIndex, Userindex, 0, "SUNI" & Puntos)

End Sub
Sub EnviarSkills(Userindex As Integer)
Dim i As Integer
Dim cad As String

'For i = 1 To NUMSKILLS
'   cad = cad & UserList(Userindex).Stats.UserSkills(i) & ","
'Next

'SendData ToIndex, Userindex, 0, "SKILLS" & cad

End Sub
Sub EnviarFama(Userindex As Integer)
Dim cad As String

cad = UserList(Userindex).Faccion.Quests & ","
cad = cad & UserList(Userindex).Faccion.torneos & ","
    
If EsNewbie(Userindex) Then
    cad = cad & UserList(Userindex).Faccion.Matados(Caos) & ","
    cad = cad & UserList(Userindex).Faccion.Matados(Neutral)
    
    Call SendData(ToIndex, Userindex, 0, "FAMA3," & cad)
Else
    Select Case UserList(Userindex).Faccion.Bando
        Case Neutral
            cad = cad & UserList(Userindex).Faccion.BandoOriginal & ","
            cad = cad & UserList(Userindex).Faccion.Matados(Real) & ","
            cad = cad & UserList(Userindex).Faccion.Matados(Caos) & ","
            
        Case Real, Caos
            cad = cad & Titulo(Userindex) & ","
            cad = cad & UserList(Userindex).Faccion.Matados(Enemigo(UserList(Userindex).Faccion.Bando)) & ","
            
    End Select
    cad = cad & UserList(Userindex).Faccion.Matados(Neutral)
    Call SendData(ToIndex, Userindex, 0, "FAMA" & UserList(Userindex).Faccion.Bando & "," & cad)
End If

End Sub
Function GeneroLetras(Genero As Byte) As String

If Genero = 1 Then
    GeneroLetras = "Mujer"
Else
    GeneroLetras = "Hombre"
End If

End Function
Sub EnviarMiniSt(Userindex As Integer)
Dim cad As String

cad = cad & UserList(Userindex).Stats.VecesMurioUsuario & ","
cad = cad & UserList(Userindex).Faccion.Matados(Caos) & ","
cad = cad & UserList(Userindex).Stats.NPCsMuertos & ","
cad = cad & UserList(Userindex).Faccion.Matados(Neutral) + UserList(Userindex).Faccion.Matados(Real) + UserList(Userindex).Faccion.Matados(Caos) & ","
cad = cad & ListaClases(UserList(Userindex).Clase) & ","
cad = cad & ListaRazas(UserList(Userindex).Raza) & ","
cad = cad & UserList(Userindex).Faccion.Matados(Real) & ","

Call SendData(ToIndex, Userindex, 0, "MXST" & cad)
Call SendData(ToIndex, Userindex, 0, "MXSX" & UserList(Userindex).flags.RetosPerdidos & "," & UserList(Userindex).flags.RetosGanados & "," & UserList(Userindex).flags.Advertencias & "," & UserList(Userindex).flags.Advertenciasfacc)


End Sub
Sub EnviarAtrib(Userindex As Integer)
Dim i As Integer
Dim cad As String

For i = 1 To NUMATRIBUTOS
  cad = cad & UserList(Userindex).Stats.UserAtributos(i) & ","
Next

Call SendData(ToIndex, Userindex, 0, "ATR" & cad)

End Sub
Sub EraseUserChar(sndRoute As Byte, sndIndex As Integer, sndMap As Integer, Userindex As Integer)

On Error GoTo ErrorHandler

CharList(UserList(Userindex).Char.CharIndex) = 0

If UserList(Userindex).Char.CharIndex = LastChar Then
    Do Until CharList(LastChar) > 0
        LastChar = LastChar - 1
        If LastChar = 0 Then Exit Do
    Loop
End If

MapData(UserList(Userindex).POS.Map, UserList(Userindex).POS.X, UserList(Userindex).POS.y).Userindex = 0


Call SendData(ToMap, Userindex, UserList(Userindex).POS.Map, "BP" & UserList(Userindex).Char.CharIndex)

UserList(Userindex).Char.CharIndex = 0

NumChars = NumChars - 1

Exit Sub
    
ErrorHandler:
        Call LogError("Error en EraseUserchar")

End Sub
Sub UpdateUserChar(Userindex As Integer)
On Error Resume Next
Dim bCr As Byte
Dim Info As String

If UserList(Userindex).flags.Privilegios = 1 Then
    bCr = 9
ElseIf UserList(Userindex).flags.Privilegios = 2 Then
    bCr = 10
ElseIf UserList(Userindex).flags.Privilegios = 3 Then
    bCr = 1
ElseIf UserList(Userindex).flags.Privilegios = 4 Then
    bCr = 11
ElseIf UserList(Userindex).Faccion.Bando = Real Then
    bCr = 2
ElseIf UserList(Userindex).Faccion.Bando = Caos Then
    bCr = 3
ElseIf EsNewbie(Userindex) Then
    bCr = 4
Else: bCr = 5
End If

Info = "PW" & UserList(Userindex).Char.CharIndex & "," & bCr & "," & UserList(Userindex).Name

If Len(UserList(Userindex).GuildInfo.GuildName) > 0 Then Info = Info & " <" & UserList(Userindex).GuildInfo.GuildName & ">"

Call SendData(ToMap, Userindex, UserList(Userindex).POS.Map, (Info))

End Sub
Sub MakeUserChar(sndRoute As Byte, sndIndex As Integer, sndMap As Integer, Userindex As Integer, Map As Integer, X As Integer, y As Integer)
On Error Resume Next
Dim CharIndex As Integer

If Not InMapBounds(X, y) Then Exit Sub


If UserList(Userindex).Char.CharIndex = 0 Then
    CharIndex = NextOpenCharIndex
    UserList(Userindex).Char.CharIndex = CharIndex
    CharList(CharIndex) = Userindex
End If


MapData(Map, X, y).Userindex = Userindex


Dim klan$
klan$ = UserList(Userindex).GuildInfo.GuildName
Dim bCr As Byte
If UserList(Userindex).flags.Privilegios = 1 Then
    bCr = 9
ElseIf UserList(Userindex).flags.Privilegios = 2 Then
    bCr = 10
ElseIf UserList(Userindex).flags.Privilegios = 3 Then
    bCr = 1
ElseIf UserList(Userindex).flags.Privilegios = 4 Then
    bCr = 11
ElseIf UserList(Userindex).Faccion.Bando = Real And UserList(Userindex).flags.EsConseReal = 0 Then
    bCr = 2
ElseIf UserList(Userindex).Faccion.Bando = Caos And UserList(Userindex).flags.EsConseCaos = 0 Then
    bCr = 3
ElseIf EsNewbie(Userindex) Then
    bCr = 4
ElseIf UserList(Userindex).flags.EsConseCaos And UserList(Userindex).Faccion.Bando = Caos Then
    bCr = 6
ElseIf UserList(Userindex).flags.EsConseReal And UserList(Userindex).Faccion.Bando = Real Then
    bCr = 7
ElseIf UserList(Userindex).flags.EsConcilioNegro And UserList(Userindex).Faccion.Bando = Neutral Then
    bCr = 8
Else
    bCr = 5
End If

If Len(klan$) > 0 Then klan = " <" & klan$ & ">"

Call SendData(sndRoute, sndIndex, sndMap, ("CC" & UserList(Userindex).Char.Body & "," & UserList(Userindex).Char.Head & "," & UserList(Userindex).Char.Heading & "," & UserList(Userindex).Char.CharIndex & "," & X & "," & y & "," & UserList(Userindex).Char.WeaponAnim & "," & UserList(Userindex).Char.ShieldAnim & "," & UserList(Userindex).Char.FX & "," & 999 & "," & UserList(Userindex).Name & klan$ & "," & UserList(Userindex).Char.CascoAnim & "," & bCr & "," & UserList(Userindex).Char.Aura & "," & UserList(Userindex).flags.Invisible & "," & UserList(Userindex).flags.Privilegios))   'dx8 solo esta parte: "& "," & UserList(UserIndex).Char.Aura))"

If UserList(Userindex).flags.Meditando Then
    UserList(Userindex).Char.loops = LoopAdEternum
    
If UserList(Userindex).flags.Templario = 1 Then

Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "CFX" & UserList(Userindex).Char.CharIndex & "," & UserList(Userindex).Char.CharIndex & "," & FXMEDITARTEMPLARIO & "," & 0 & "," & LoopAdEternum) 'dx8
UserList(Userindex).Char.FX = FXMEDITARTEMPLARIO
Else

If UserList(Userindex).Stats.ELV < 15 Then
                Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "CFX" & UserList(Userindex).Char.CharIndex & "," & UserList(Userindex).Char.CharIndex & "," & FXMEDITARCHICO & "," & 0 & "," & LoopAdEternum) 'dx8
                Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "CFF" & UserList(Userindex).Char.CharIndex & "," & UserList(Userindex).Stats.ELV) 'dx8
                UserList(Userindex).Char.FX = FXMEDITARCHICO
            ElseIf UserList(Userindex).Stats.ELV < 30 Then
                Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "CFX" & UserList(Userindex).Char.CharIndex & "," & UserList(Userindex).Char.CharIndex & "," & FXMEDITARMEDIANO & "," & 0 & "," & LoopAdEternum) 'dx8
                Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "CFF" & UserList(Userindex).Char.CharIndex & "," & UserList(Userindex).Stats.ELV)  'dx8
                UserList(Userindex).Char.FX = FXMEDITARMEDIANO
            ElseIf UserList(Userindex).Stats.ELV < 50 Then
                Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "CFX" & UserList(Userindex).Char.CharIndex & "," & UserList(Userindex).Char.CharIndex & "," & FXMEDITARGRANDE & "," & 0 & "," & LoopAdEternum) 'dx8
                Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "CFF" & UserList(Userindex).Char.CharIndex & "," & UserList(Userindex).Stats.ELV)  'dx8
                UserList(Userindex).Char.FX = FXMEDITARGRANDE
            ElseIf UserList(Userindex).Stats.ELV < 51 Then
                Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "CFX" & UserList(Userindex).Char.CharIndex & "," & UserList(Userindex).Char.CharIndex & "," & FXMEDITARGIGANTE & "," & 0 & "," & LoopAdEternum) 'dx8
                Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "CFF" & UserList(Userindex).Char.CharIndex & "," & UserList(Userindex).Stats.ELV)  'dx8
                UserList(Userindex).Char.FX = FXMEDITARGIGANTE
    End If
End If
End If

End Sub
Function Redondea(ByVal Number As Single) As Integer

If Number > Fix(Number) Then
    Redondea = Fix(Number) + 1
Else: Redondea = Number
End If

End Function


Sub CheckUserLevel(Userindex As Integer)
On Error GoTo errhandler
Dim Pts As Integer
Dim SubeHit As Integer
Dim AumentoST As Integer
Dim AumentoMANA As Integer
Dim WasNewbie As Boolean
Dim ObjetoPremio As Obj
    'Call Aprenderhechizo(UserIndex, 47) 'portal luminoso
Do Until UserList(Userindex).Stats.Exp < UserList(Userindex).Stats.ELU

If UserList(Userindex).Stats.ELV >= 46 Then

    If Not UserList(Userindex).flags.PremioUserLevel46 = 1 Then
    UserList(Userindex).flags.PremioUserLevel46 = 1
    UserList(Userindex).Stats.Reputacion = UserList(Userindex).Stats.Reputacion + 100
    Call SendUserREP(Userindex)
    End If
End If
If UserList(Userindex).Stats.ELV >= 47 Then

    If Not UserList(Userindex).flags.PremioUserLevel47 = 1 Then
    UserList(Userindex).flags.PremioUserLevel47 = 1
    UserList(Userindex).Stats.Reputacion = UserList(Userindex).Stats.Reputacion + 200
    Call SendUserREP(Userindex)
    End If
End If
If UserList(Userindex).Stats.ELV >= 48 Then

    If Not UserList(Userindex).flags.PremioUserLevel48 = 1 Then
    UserList(Userindex).flags.PremioUserLevel48 = 1
    UserList(Userindex).Stats.Reputacion = UserList(Userindex).Stats.Reputacion + 300
    Call SendUserREP(Userindex)
    End If
End If
If UserList(Userindex).Stats.ELV >= 49 Then

    If Not UserList(Userindex).flags.PremioUserLevel49 = 1 Then
    UserList(Userindex).flags.PremioUserLevel49 = 1
    UserList(Userindex).Stats.Reputacion = UserList(Userindex).Stats.Reputacion + 400
    Call SendUserREP(Userindex)
    End If
End If
If UserList(Userindex).Stats.ELV >= 50 Then
    UserList(Userindex).Stats.Exp = 0
    UserList(Userindex).Stats.ELU = 0
    
    Call SendData(ToIndex, Userindex, 0, "ELV")
    
    If Not UserList(Userindex).flags.PremioUserLevel50 = 1 Then
    UserList(Userindex).flags.PremioUserLevel50 = 1
    
    UserList(Userindex).Stats.Reputacion = UserList(Userindex).Stats.Reputacion + 500
    Call SendUserREP(Userindex)
    UserList(Userindex).Stats.GLD = UserList(Userindex).Stats.GLD + 700000
    Call SendUserStatsBox(Userindex)
    
    ObjetoPremio.Amount = 2
    ObjetoPremio.OBJIndex = SacriIndex
    
    If Not MeterItemEnInventario(Userindex, ObjetoPremio) Then Call TirarItemAlPiso(UserList(Userindex).POS, ObjetoPremio)
    
    Call SendData(ToIndex, Userindex, 0, "||¡Eres nivel 50, recibiste 700.000 monedas de oro y 2 Sacris de regalo!" & FONTTYPE_FENIZ)
    Call SendData(ToAll, 0, 0, "||El usuario " & UserList(Userindex).Name & " es nivel máximo." & FONTTYPE_FENIZ)
    Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "TWsoundlevel")
    End If
    Exit Sub
End If


WasNewbie = EsNewbie(Userindex)

If UserList(Userindex).Stats.Exp >= UserList(Userindex).Stats.ELU Then

    If UserList(Userindex).Stats.ELV >= 14 And ClaseBase(UserList(Userindex).Clase) Then
        Call SendData(ToIndex, Userindex, 0, "!6")
        UserList(Userindex).Stats.Exp = UserList(Userindex).Stats.ELU - 1
        Call SendUserEXP(Userindex)
        Exit Sub
    End If

    Call SendData(ToIndex, Userindex, 0, "1S" & UserList(Userindex).Stats.ELV + 1)
    
    If UserList(Userindex).Stats.ELV = 1 Then
        Pts = 15
    Else
        Pts = 15
    End If
    
    UserList(Userindex).Stats.SkillPts = UserList(Userindex).Stats.SkillPts + Pts
    
   ' Call SendData(ToIndex, UserIndex, 0, "1T" & Pts)
    
    UserList(Userindex).Stats.ELV = UserList(Userindex).Stats.ELV + 1
    UserList(Userindex).Stats.Exp = UserList(Userindex).Stats.Exp - UserList(Userindex).Stats.ELU
    UserList(Userindex).Stats.ELU = ELUs(UserList(Userindex).Stats.ELV)
    
    If UserList(Userindex).Stats.ELV <= 45 Then
    Dim AumentoHP As Integer
    Dim SubePromedio As Single
    
    SubePromedio = UserList(Userindex).Stats.UserAtributos(Constitucion) / 2 - Resta(UserList(Userindex).Clase)
    AumentoHP = RandomNumber(Fix(SubePromedio - 1), Redondea(SubePromedio + 1))
    SubeHit = AumentoHit(UserList(Userindex).Clase)

    Select Case UserList(Userindex).Clase
        Case CIUDADANO, TRABAJADOR, EXPERTO_MINERALES
            AumentoST = 15
            
        Case MINERO
            AumentoST = 15 + AdicionalSTMinero
            
        Case HERRERO
            AumentoST = 15
            
        Case EXPERTO_MADERA
            AumentoST = 15

        Case TALADOR
            AumentoST = 15 + AdicionalSTLeñador

        Case CARPINTERO
            AumentoST = 15
            
        Case PESCADOR
            AumentoST = 15 + AdicionalSTPescador
            
        Case SASTRE
            AumentoST = 15
            
        Case HECHICERO
            AumentoST = 15
            AumentoMANA = 2.2 * UserList(Userindex).Stats.UserAtributos(Inteligencia)
            
        Case MAGO
            AumentoST = Maximo(5, 15 - AdicionalSTLadron / 2)
            Select Case UserList(Userindex).Stats.MaxMAN
                Case Is < 2300
                    AumentoMANA = 3 * UserList(Userindex).Stats.UserAtributos(Inteligencia)
                Case Is < 2500
                    AumentoMANA = 2 * UserList(Userindex).Stats.UserAtributos(Inteligencia)
                Case Else
                    AumentoMANA = 1.5 * UserList(Userindex).Stats.UserAtributos(Inteligencia)
            End Select
            

            
        Case NIGROMANTE
            AumentoST = Maximo(5, 15 - AdicionalSTLadron / 2)
            AumentoMANA = 2.2 * UserList(Userindex).Stats.UserAtributos(Inteligencia)
            
        Case ORDEN_SAGRADA
            AumentoST = 15
            AumentoMANA = UserList(Userindex).Stats.UserAtributos(Inteligencia)
            
        Case PALADIN
            AumentoST = 15
            AumentoMANA = UserList(Userindex).Stats.UserAtributos(Inteligencia)
            
            If UserList(Userindex).Stats.MaxHit >= 99 Then SubeHit = 1
            
        Case CLERIGO
            AumentoST = 15
            AumentoMANA = 2 * UserList(Userindex).Stats.UserAtributos(Inteligencia)

        Case NATURALISTA
            AumentoST = 15
            AumentoMANA = 2 * UserList(Userindex).Stats.UserAtributos(Inteligencia)
            
        Case BARDO
            AumentoST = 15
            AumentoMANA = 2 * UserList(Userindex).Stats.UserAtributos(Inteligencia)

        Case DRUIDA
            AumentoST = 15
            AumentoMANA = 2.2 * UserList(Userindex).Stats.UserAtributos(Inteligencia)

        Case SIGILOSO
            AumentoST = 15
            AumentoMANA = UserList(Userindex).Stats.UserAtributos(Inteligencia)
            
        Case ASESINO
            AumentoST = 15
            AumentoMANA = UserList(Userindex).Stats.UserAtributos(Inteligencia)

            If UserList(Userindex).Stats.MaxHit >= 99 Then SubeHit = 1
            
        Case CAZADOR
            AumentoST = 15
            AumentoMANA = UserList(Userindex).Stats.UserAtributos(Inteligencia)

            If UserList(Userindex).Stats.MaxHit >= 99 Then SubeHit = 1
            
        Case SIN_MANA
            AumentoST = 15

        Case CABALLERO
            AumentoST = 15
            
        Case ARQUERO
            AumentoST = 15
         
            If UserList(Userindex).Stats.MaxHit >= 99 Then SubeHit = 2
            
        Case GUERRERO
            AumentoST = 15

            If UserList(Userindex).Stats.MaxHit >= 99 Then SubeHit = 2
           
        Case BANDIDO
            AumentoST = 15
            
        Case PIRATA
            AumentoST = 15

        Case LADRON
            AumentoST = 15
         
        Case Else
            AumentoST = 15 + AdicionalSTLadron
            
    End Select
       
    Call AddtoVar(UserList(Userindex).Stats.MaxHP, AumentoHP, STAT_MAXHP)
    UserList(Userindex).Stats.MaxSta = UserList(Userindex).Stats.MaxSta + AumentoST
    
    Call AddtoVar(UserList(Userindex).Stats.MaxMAN, AumentoMANA, 2200 + 800 * Buleano(UserList(Userindex).Clase And UserList(Userindex).Recompensas(2) = 2))
    UserList(Userindex).Stats.MaxHit = UserList(Userindex).Stats.MaxHit + SubeHit
    UserList(Userindex).Stats.MinHit = UserList(Userindex).Stats.MinHit + SubeHit
    
    Call SendData(ToIndex, Userindex, 0, "1U" & AumentoHP & "," & AumentoST & "," & AumentoMANA & "," & SubeHit)
    
    'Call SendData(ToIndex, Userindex, UserList(Userindex).POS.Map, "||" & vbCyan & "°" & "Vida +" & _
    AumentoHP & " Mana +" & AumentoMANA & " Golpe +" & SubeHit & " Energia +" & AumentoST & "." & "°" & UserList(Userindex).Char.CharIndex)
    
    UserList(Userindex).Stats.MinHP = UserList(Userindex).Stats.MaxHP
    End If
    
    Call EnviarSkills(Userindex)
    Call EnviarSubirNivel(Userindex, Pts)
   
    Call SendUserStatsBox(Userindex)


    If UserList(Userindex).Stats.ELV = 3 Then
    Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "TW20")
    ElseIf UserList(Userindex).Stats.ELV = 30 Then
    Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "TWsoundlevel")
    Else
    Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "TW6")
    End If

     If Not EsNewbie(Userindex) And WasNewbie Then
        If UserList(Userindex).POS.Map = 37 Or UserList(Userindex).POS.Map = 49 Then
            Call CiudadNatal(Userindex)
            Call SendData(ToIndex, Userindex, 0, "||¡Eres nivel 13 de ahora en mas deberas pasar de nivel en las afueras de estas tierras!" & FONTTYPE_FENIZ)
            Call SendData(ToIndex, Userindex, 0, "||Presiona F1 para abrir la Guía básica del servidor." & FONTTYPE_FENIZ)
            Call SendData(ToIndex, Userindex, 0, "TWsoundlevel")
        Else
            Call SendData(ToIndex, Userindex, 0, "||¡Eres nivel 13 de ahora en mas deberas pasar de nivel en las afueras de estas tierras!" & FONTTYPE_FENIZ)
            Call SendData(ToIndex, Userindex, 0, "||Presiona F1 para abrir la Guía básica del servidor." & FONTTYPE_FENIZ)
            Call SendData(ToIndex, Userindex, 0, "TWsoundlevel")
            Call UpdateUserChar(Userindex)
        End If
        Call QuitarNewbieObj(Userindex)
        Call SendData(ToIndex, Userindex, 0, "SUFA1")
    End If
    
    Call CheckUserLevel(Userindex)
    
Else

    Call SendUserEXP(Userindex)
    
End If

    
    If UserList(Userindex).Stats.ELV = 9 Then
    If UserList(Userindex).Stats.MaxMAN > 20 Then
    Call Aprenderhechizo(Userindex, 6)
    UserList(Userindex).Stats.Exp = 0
    Call SendData(ToIndex, Userindex, 0, "||¡Eres nivel 9! Se te ha dado el hechizo Flecha Mágica." & FONTTYPE_FENIZ)
    End If
    ElseIf UserList(Userindex).Stats.ELV = 15 Then
    If UserList(Userindex).Stats.MaxMAN > 20 Then
    Call Aprenderhechizo(Userindex, 7)
    UserList(Userindex).Stats.Exp = 0
    Call SendData(ToIndex, Userindex, 0, "||¡Eres nivel 15! Se te ha dado el hechizo Flecha Eléctrica." & FONTTYPE_FENIZ)
    End If
    ElseIf UserList(Userindex).Stats.ELV = 17 Then
    If UserList(Userindex).Stats.MaxMAN > 20 Then
    Call Aprenderhechizo(Userindex, 49)
    UserList(Userindex).Stats.Exp = 0
    Call SendData(ToIndex, Userindex, 0, "||¡Eres nivel 17! Se te ha dado el hechizo Misil fautico." & FONTTYPE_FENIZ)
    End If
    End If
    


If UserList(Userindex).Stats.ELV >= 5 And UserList(Userindex).Stats.ELV <= 10 Then
UserList(Userindex).Stats.UserSkills(1) = 20
UserList(Userindex).Stats.UserSkills(3) = 20
UserList(Userindex).Stats.UserSkills(4) = 20
UserList(Userindex).Stats.UserSkills(5) = 20
UserList(Userindex).Stats.UserSkills(6) = 20
UserList(Userindex).Stats.UserSkills(8) = 20
UserList(Userindex).Stats.UserSkills(10) = 20
UserList(Userindex).Stats.UserSkills(15) = 20
UserList(Userindex).Stats.UserSkills(16) = 20
UserList(Userindex).Stats.UserSkills(17) = 20
UserList(Userindex).Stats.UserSkills(18) = 20
UserList(Userindex).Stats.UserSkills(19) = 20
UserList(Userindex).Stats.UserSkills(21) = 20
UserList(Userindex).Stats.UserSkills(22) = 20

Call SaveUser(Userindex, CharPath & UCase$(UserList(Userindex).Name) & ".chr")
ElseIf UserList(Userindex).Stats.ELV >= 15 And UserList(Userindex).Stats.ELV <= 20 Then
UserList(Userindex).Stats.UserSkills(1) = 40
UserList(Userindex).Stats.UserSkills(3) = 40
UserList(Userindex).Stats.UserSkills(4) = 40
UserList(Userindex).Stats.UserSkills(5) = 40
UserList(Userindex).Stats.UserSkills(6) = 40
UserList(Userindex).Stats.UserSkills(8) = 40
UserList(Userindex).Stats.UserSkills(10) = 40
UserList(Userindex).Stats.UserSkills(15) = 40
UserList(Userindex).Stats.UserSkills(16) = 40
UserList(Userindex).Stats.UserSkills(17) = 40
UserList(Userindex).Stats.UserSkills(18) = 40
UserList(Userindex).Stats.UserSkills(19) = 40
UserList(Userindex).Stats.UserSkills(21) = 40
UserList(Userindex).Stats.UserSkills(22) = 40

If UserList(Userindex).Clase = LADRON Or UserList(Userindex).Clase = GUERRERO Or UserList(Userindex).Clase = ARQUERO Or UserList(Userindex).Clase = CAZADOR Or UserList(Userindex).Clase = PIRATA Then
UserList(Userindex).Stats.UserSkills(Ocultarse) = 40
End If

If (ClaseTrabajadora(UserList(Userindex).Clase)) Then
UserList(Userindex).Stats.UserSkills(Herreria) = 100
UserList(Userindex).Stats.UserSkills(Sastreria) = 100
UserList(Userindex).Stats.UserSkills(Carpinteria) = 100
UserList(Userindex).Stats.UserSkills(Mineria) = 100
UserList(Userindex).Stats.UserSkills(Talar) = 100
UserList(Userindex).Stats.UserSkills(Pesca) = 100
End If

If UserList(Userindex).Clase = LADRON Then
UserList(Userindex).Stats.UserSkills(Robar) = 40
End If

Call SaveUser(Userindex, CharPath & UCase$(UserList(Userindex).Name) & ".chr")
ElseIf UserList(Userindex).Stats.ELV >= 22 And UserList(Userindex).Stats.ELV <= 26 Then
UserList(Userindex).Stats.UserSkills(1) = 60
UserList(Userindex).Stats.UserSkills(3) = 60
UserList(Userindex).Stats.UserSkills(4) = 60
UserList(Userindex).Stats.UserSkills(5) = 60
UserList(Userindex).Stats.UserSkills(6) = 60
UserList(Userindex).Stats.UserSkills(8) = 60
UserList(Userindex).Stats.UserSkills(10) = 60
UserList(Userindex).Stats.UserSkills(15) = 60
UserList(Userindex).Stats.UserSkills(16) = 60
UserList(Userindex).Stats.UserSkills(17) = 60
UserList(Userindex).Stats.UserSkills(18) = 60
UserList(Userindex).Stats.UserSkills(19) = 60
UserList(Userindex).Stats.UserSkills(21) = 60
UserList(Userindex).Stats.UserSkills(22) = 60

If (ClaseTrabajadora(UserList(Userindex).Clase)) Then
UserList(Userindex).Stats.UserSkills(Herreria) = 100
UserList(Userindex).Stats.UserSkills(Sastreria) = 100
UserList(Userindex).Stats.UserSkills(Carpinteria) = 100
UserList(Userindex).Stats.UserSkills(Mineria) = 100
UserList(Userindex).Stats.UserSkills(Talar) = 100
UserList(Userindex).Stats.UserSkills(Pesca) = 100
End If

If UserList(Userindex).Clase = LADRON Then
UserList(Userindex).Stats.UserSkills(Robar) = 80
End If

If UserList(Userindex).Clase = LADRON Or UserList(Userindex).Clase = GUERRERO Or UserList(Userindex).Clase = ARQUERO Or UserList(Userindex).Clase = CAZADOR Or UserList(Userindex).Clase = PIRATA Then
UserList(Userindex).Stats.UserSkills(Ocultarse) = 80
End If

Call SaveUser(Userindex, CharPath & UCase$(UserList(Userindex).Name) & ".chr")
ElseIf UserList(Userindex).Stats.ELV >= 34 And UserList(Userindex).Stats.ELV <= 40 Then
UserList(Userindex).Stats.UserSkills(1) = 85
UserList(Userindex).Stats.UserSkills(3) = 85
UserList(Userindex).Stats.UserSkills(4) = 85
UserList(Userindex).Stats.UserSkills(5) = 85
UserList(Userindex).Stats.UserSkills(6) = 85
UserList(Userindex).Stats.UserSkills(8) = 85
UserList(Userindex).Stats.UserSkills(10) = 85
UserList(Userindex).Stats.UserSkills(15) = 85
UserList(Userindex).Stats.UserSkills(16) = 85
UserList(Userindex).Stats.UserSkills(17) = 85
UserList(Userindex).Stats.UserSkills(18) = 85
UserList(Userindex).Stats.UserSkills(19) = 85
UserList(Userindex).Stats.UserSkills(21) = 85
UserList(Userindex).Stats.UserSkills(22) = 85

If (ClaseTrabajadora(UserList(Userindex).Clase)) Then
UserList(Userindex).Stats.UserSkills(Herreria) = 100
UserList(Userindex).Stats.UserSkills(Sastreria) = 100
UserList(Userindex).Stats.UserSkills(Carpinteria) = 100
UserList(Userindex).Stats.UserSkills(Mineria) = 100
UserList(Userindex).Stats.UserSkills(Talar) = 100
UserList(Userindex).Stats.UserSkills(Pesca) = 100
End If

If UserList(Userindex).Clase = ASESINO Then
UserList(Userindex).Stats.UserSkills(Apuñalar) = 100
End If

If UserList(Userindex).Clase = LADRON Then
UserList(Userindex).Stats.UserSkills(Robar) = 95
End If

If UserList(Userindex).Clase = LADRON Or UserList(Userindex).Clase = GUERRERO Or UserList(Userindex).Clase = ARQUERO Or UserList(Userindex).Clase = CAZADOR Or UserList(Userindex).Clase = PIRATA Then
UserList(Userindex).Stats.UserSkills(Ocultarse) = 90
End If

Call SaveUser(Userindex, CharPath & UCase$(UserList(Userindex).Name) & ".chr")

ElseIf UserList(Userindex).Stats.ELV >= 41 And UserList(Userindex).Stats.ELV <= 45 Then
UserList(Userindex).Stats.UserSkills(1) = 100
UserList(Userindex).Stats.UserSkills(3) = 100
UserList(Userindex).Stats.UserSkills(4) = 100
UserList(Userindex).Stats.UserSkills(5) = 100
UserList(Userindex).Stats.UserSkills(6) = 100
UserList(Userindex).Stats.UserSkills(8) = 100
UserList(Userindex).Stats.UserSkills(10) = 100
UserList(Userindex).Stats.UserSkills(15) = 100
UserList(Userindex).Stats.UserSkills(16) = 100
UserList(Userindex).Stats.UserSkills(17) = 100
UserList(Userindex).Stats.UserSkills(18) = 100
UserList(Userindex).Stats.UserSkills(19) = 100
UserList(Userindex).Stats.UserSkills(21) = 100
UserList(Userindex).Stats.UserSkills(22) = 100

If (ClaseTrabajadora(UserList(Userindex).Clase)) Then
UserList(Userindex).Stats.UserSkills(Herreria) = 100
UserList(Userindex).Stats.UserSkills(Sastreria) = 100
UserList(Userindex).Stats.UserSkills(Carpinteria) = 100
UserList(Userindex).Stats.UserSkills(Mineria) = 100
UserList(Userindex).Stats.UserSkills(Talar) = 100
UserList(Userindex).Stats.UserSkills(Pesca) = 100
End If

If UserList(Userindex).Clase = LADRON Or UserList(Userindex).Clase = GUERRERO Or UserList(Userindex).Clase = ARQUERO Or UserList(Userindex).Clase = CAZADOR Or UserList(Userindex).Clase = PIRATA Then
UserList(Userindex).Stats.UserSkills(Ocultarse) = 100
End If

If UserList(Userindex).Clase = LADRON Then
UserList(Userindex).Stats.UserSkills(Robar) = 100
End If

Call SaveUser(Userindex, CharPath & UCase$(UserList(Userindex).Name) & ".chr")
End If
    
    
    Call SendData(ToIndex, Userindex, 0, "SUFA1")
    
    Call CheckUserLevel(Userindex)
    

    
If PuedeSubirClase(Userindex) Then Call SendData(ToIndex, Userindex, 0, "SUCL1")
If PuedeRecompensa(Userindex) Then Call SendData(ToIndex, Userindex, 0, "SURE1")


Loop

Exit Sub

errhandler:
    LogError ("Error en la subrutina CheckUserLevel")
End Sub
Function PuedeRecompensa(Userindex As Integer) As Byte

If UserList(Userindex).Clase = SASTRE Then Exit Function

If UserList(Userindex).Recompensas(1) = 0 And UserList(Userindex).Stats.ELV >= 18 Then
    PuedeRecompensa = 1
    Exit Function
End If

If UserList(Userindex).Clase = TALADOR Or UserList(Userindex).Clase = PESCADOR Then Exit Function

If UserList(Userindex).Stats.ELV >= 25 And UserList(Userindex).Recompensas(2) = 0 Then
    PuedeRecompensa = 2
    Exit Function
End If
    
If UserList(Userindex).Clase = CARPINTERO Then Exit Function

If UserList(Userindex).Recompensas(3) = 0 And _
    (UserList(Userindex).Stats.ELV >= 34 Or _
    (ClaseTrabajadora(UserList(Userindex).Clase) And UserList(Userindex).Stats.ELV >= 32) Or _
    ((UserList(Userindex).Clase = PIRATA Or UserList(Userindex).Clase = LADRON) And UserList(Userindex).Stats.ELV >= 30)) Then
    PuedeRecompensa = 3
    Exit Function
End If

End Function
Function PuedeFaccion(Userindex As Integer) As Boolean

PuedeFaccion = Not EsNewbie(Userindex) And UserList(Userindex).Faccion.BandoOriginal = Neutral And Len(UserList(Userindex).GuildInfo.GuildName) = 0 And UserList(Userindex).flags.Privilegios = 0

End Function
Function PuedeSubirClase(Userindex As Integer) As Boolean

PuedeSubirClase = (UserList(Userindex).Stats.ELV >= 3 And UserList(Userindex).Clase = CIUDADANO) Or _
                (UserList(Userindex).Stats.ELV >= 6 And (UserList(Userindex).Clase = Luchador Or UserList(Userindex).Clase = TRABAJADOR)) Or _
                (UserList(Userindex).Stats.ELV >= 9 And (UserList(Userindex).Clase = EXPERTO_MINERALES Or UserList(Userindex).Clase = EXPERTO_MADERA Or UserList(Userindex).Clase = CON_MANA Or UserList(Userindex).Clase = SIN_MANA)) Or _
                (UserList(Userindex).Stats.ELV >= 12 And (UserList(Userindex).Clase = CABALLERO Or UserList(Userindex).Clase = BANDIDO Or UserList(Userindex).Clase = HECHICERO Or UserList(Userindex).Clase = NATURALISTA Or UserList(Userindex).Clase = ORDEN_SAGRADA Or UserList(Userindex).Clase = SIGILOSO))

End Function
Function PuedeAtravesarAgua(Userindex As Integer) As Boolean

PuedeAtravesarAgua = UserList(Userindex).flags.Navegando = 1

End Function
Private Sub EnviaNuevaPosUsuarioPj(Userindex As Integer, ByVal Quien As Integer)

Call SendData(ToIndex, Userindex, 0, ("LP" & UserList(Quien).Char.CharIndex & "," & UserList(Quien).POS.X & "," & UserList(Quien).POS.y & "," & UserList(Quien).Char.Heading))

End Sub
Private Sub EnviaNuevaPosNPC(Userindex As Integer, NpcIndex As Integer)

Call SendData(ToIndex, Userindex, 0, ("LP" & Npclist(NpcIndex).Char.CharIndex & "," & Npclist(NpcIndex).POS.X & "," & Npclist(NpcIndex).POS.y & "," & Npclist(NpcIndex).Char.Heading))

End Sub
Sub CalcularValores(Userindex As Integer)
Dim SubePromedio As Single
Dim HPReal As Integer
Dim HitReal As Integer
Dim i As Integer

HPReal = 15 + RandomNumber(1, UserList(Userindex).Stats.UserAtributos(Constitucion) \ 3)
HitReal = AumentoHit(UserList(Userindex).Clase) * UserList(Userindex).Stats.ELV
SubePromedio = UserList(Userindex).Stats.UserAtributos(Constitucion) / 2 - Resta(UserList(Userindex).Clase)

For i = 1 To UserList(Userindex).Stats.ELV - 1
    HPReal = HPReal + RandomNumber(Redondea(SubePromedio - 2), Fix(SubePromedio + 2))
Next

Call CalcularMana(Userindex)

UserList(Userindex).Stats.MinHit = HitReal
UserList(Userindex).Stats.MaxHit = HitReal + 1
    
UserList(Userindex).Stats.MinHP = Minimo(UserList(Userindex).Stats.MinHP, HPReal)
UserList(Userindex).Stats.MaxHP = HPReal
Call SendUserStatsBox(Userindex)

End Sub
Sub CalcularMana(Userindex As Integer)
Dim ManaReal As Integer

Select Case (UserList(Userindex).Clase)
    Case HECHICERO
        ManaReal = 100 + 2.2 * (UserList(Userindex).Stats.UserAtributos(Inteligencia) * (UserList(Userindex).Stats.ELV - 1))
    
    Case MAGO
        ManaReal = 100 + 3 * (UserList(Userindex).Stats.UserAtributos(Inteligencia) * (UserList(Userindex).Stats.ELV - 1))
        
    Case ORDEN_SAGRADA
        ManaReal = UserList(Userindex).Stats.UserAtributos(Inteligencia) * (UserList(Userindex).Stats.ELV - 1)
    
    Case CLERIGO
        ManaReal = 50 + 2 * UserList(Userindex).Stats.UserAtributos(Inteligencia) * (UserList(Userindex).Stats.ELV - 1)

    Case NATURALISTA
        ManaReal = 50 + 2 * UserList(Userindex).Stats.UserAtributos(Inteligencia) * (UserList(Userindex).Stats.ELV - 1)

    Case DRUIDA
        ManaReal = 50 + 2.1 * UserList(Userindex).Stats.UserAtributos(Inteligencia) * (UserList(Userindex).Stats.ELV - 1)
        
    Case SIGILOSO
        ManaReal = 50 + UserList(Userindex).Stats.UserAtributos(Inteligencia) * (UserList(Userindex).Stats.ELV - 1)
End Select

If ManaReal Then
    UserList(Userindex).Stats.MinMAN = Minimo(UserList(Userindex).Stats.MinMAN, ManaReal)
    UserList(Userindex).Stats.MaxMAN = ManaReal
End If

End Sub
Private Sub EnviaGenteEnNuevoRango(Userindex As Integer, ByVal nHeading As Byte)
Dim X As Integer, y As Integer
Dim M As Integer

M = UserList(Userindex).POS.Map

Select Case nHeading

Case NORTH, SOUTH

    If nHeading = NORTH Then
        y = UserList(Userindex).POS.y - MinYBorder - 3
    Else
        y = UserList(Userindex).POS.y + MinYBorder + 3
    End If
    For X = UserList(Userindex).POS.X - MinXBorder - 2 To UserList(Userindex).POS.X + MinXBorder + 2
        If MapData(M, X, y).Userindex Then
            Call EnviaNuevaPosUsuarioPj(Userindex, MapData(M, X, y).Userindex)
        ElseIf MapData(M, X, y).NpcIndex Then
            Call EnviaNuevaPosNPC(Userindex, MapData(M, X, y).NpcIndex)
        End If
    Next
Case EAST, WEST

    If nHeading = EAST Then
        X = UserList(Userindex).POS.X + MinXBorder + 3
    Else
        X = UserList(Userindex).POS.X - MinXBorder - 3
    End If
    For y = UserList(Userindex).POS.y - MinYBorder - 2 To UserList(Userindex).POS.y + MinYBorder + 2
        If MapData(M, X, y).Userindex Then
            Call EnviaNuevaPosUsuarioPj(Userindex, MapData(M, X, y).Userindex)
        ElseIf MapData(M, X, y).NpcIndex Then
            Call EnviaNuevaPosNPC(Userindex, MapData(M, X, y).NpcIndex)
        End If
    Next
End Select

End Sub
Sub CancelarSacrificio(Sacrificado As Integer)
Dim Sacrificador As Integer

Sacrificador = UserList(Sacrificado).flags.Sacrificador

UserList(Sacrificado).flags.Sacrificando = 0
UserList(Sacrificado).flags.Sacrificador = 0
UserList(Sacrificador).flags.Sacrificado = 0

Call SendData(ToIndex, Sacrificado, 0, "||¡El sacrificio fue cancelado!" & FONTTYPE_INFO)
Call SendData(ToIndex, Sacrificador, 0, "||¡El sacrificio fue cancelado!" & FONTTYPE_INFO)

End Sub
Sub MoveUserChar(Userindex As Integer, ByVal nHeading As Byte)
On Error Resume Next

Dim UserMIndex As Integer
Dim BlokeVacio As Byte 'Ahorramos comprobacion :)
    BlokeVacio = 0 'asegurarse¿?¿? xD Bromilla :P
    
Dim nPos As WorldPos

UserList(Userindex).Counters.Pasos = UserList(Userindex).Counters.Pasos + 1
    
nPos = UserList(Userindex).POS
Call HeadtoPos(nHeading, nPos)

If UserList(Userindex).flags.Sacrificado > 0 Then Call CancelarSacrificio(UserList(Userindex).flags.Sacrificado)
If UserList(Userindex).flags.Sacrificando = 1 Then Call CancelarSacrificio(Userindex)

If Not LegalPos(UserList(Userindex).POS.Map, nPos.X, nPos.y, PuedeAtravesarAgua(Userindex)) Then
    Call SendData(ToIndex, Userindex, 0, "PU" & DesteEncripTE(UserList(Userindex).POS.X & "," & UserList(Userindex).POS.y))
    If MapData(nPos.Map, nPos.X, nPos.y).Userindex Then
        Call EnviaNuevaPosUsuarioPj(Userindex, MapData(nPos.Map, nPos.X, nPos.y).Userindex)
    ElseIf MapData(nPos.Map, nPos.X, nPos.y).NpcIndex Then
        Call EnviaNuevaPosNPC(Userindex, MapData(nPos.Map, nPos.X, nPos.y).NpcIndex)
    End If
    Exit Sub
End If


Call SendData(ToPCAreaButIndexG, Userindex, UserList(Userindex).POS.Map, ("MP" & THeDEnCripTe(UserList(Userindex).Char.CharIndex & "," & nPos.X & "," & nPos.y, "STRINGGENM")))
Call EnviaGenteEnNuevoRango(Userindex, nHeading)
MapData(UserList(Userindex).POS.Map, UserList(Userindex).POS.X, UserList(Userindex).POS.y).Userindex = 0
UserList(Userindex).POS = nPos
UserList(Userindex).Char.Heading = nHeading
MapData(UserList(Userindex).POS.Map, UserList(Userindex).POS.X, UserList(Userindex).POS.y).Userindex = Userindex


If ZonaCura(Userindex) Then Call AutoCuraUser(Userindex)
Call DoTileEvents(Userindex)



End Sub
Sub DesequiparItem(Userindex As Integer, Slot As Byte)

Call SendData(ToIndex, Userindex, 0, "8J" & Slot)

End Sub
Sub EquiparItem(Userindex As Integer, Slot As Byte)
   
Call SendData(ToIndex, Userindex, 0, "7J" & Slot)

End Sub

Sub SendUserItem(Userindex As Integer, Slot As Byte, JustAmount As Boolean)
Dim MiObj As UserOBJ
Dim Info As String

MiObj = UserList(Userindex).Invent.Object(Slot)

If MiObj.OBJIndex Then
    If Not JustAmount Then
        Info = "CSI" & Slot & "," & ObjData(MiObj.OBJIndex).Name & "," & MiObj.Amount & "," & MiObj.Equipped & "," & ObjData(MiObj.OBJIndex).GrhIndex & "," _
        & ObjData(MiObj.OBJIndex).ObjType & "," & Round(ObjData(MiObj.OBJIndex).Valor / 3) & "," & ObjData(MiObj.OBJIndex).Minlvl
        Select Case ObjData(MiObj.OBJIndex).ObjType
            Case OBJTYPE_WEAPON
                Info = Info & "," & ObjData(MiObj.OBJIndex).MaxHit & "," & ObjData(MiObj.OBJIndex).MinHit
            Case OBJTYPE_ARMOUR
                Info = Info & "," & ObjData(MiObj.OBJIndex).SubTipo & "," & ObjData(MiObj.OBJIndex).MaxDef & "," & ObjData(MiObj.OBJIndex).MinDef
            Case OBJTYPE_POCIONES
                Info = Info & "," & ObjData(MiObj.OBJIndex).TipoPocion & "," & ObjData(MiObj.OBJIndex).MaxModificador & "," & ObjData(MiObj.OBJIndex).MinModificador
        End Select
        Call SendData(ToIndex, Userindex, 0, Info)
    Else: Call SendData(ToIndex, Userindex, 0, "CSO" & Slot & "," & MiObj.Amount)
    End If
Else: Call SendData(ToIndex, Userindex, 0, "2H" & Slot)
End If

End Sub
Function NextOpenCharIndex() As Integer
Dim loopc As Integer

For loopc = 1 To LastChar + 1
    If CharList(loopc) = 0 Then
        NextOpenCharIndex = loopc
        NumChars = NumChars + 1
        If loopc > LastChar Then LastChar = loopc
        Exit Function
    End If
Next

End Function
Function NextOpenUser() As Integer
Dim loopc As Integer
  
For loopc = 1 To MaxUsers + 1
  If loopc > MaxUsers Then Exit For
  If (UserList(loopc).ConnID = -1) Then Exit For
Next
  
NextOpenUser = loopc

End Function

Sub SendUserStatsBox(Userindex As Integer)
Call SendData(ToIndex, Userindex, 0, "EST" & DesteEncripTE(UserList(Userindex).Stats.MaxHP & "," & UserList(Userindex).Stats.MinHP & "," & UserList(Userindex).Stats.MaxMAN & "," & UserList(Userindex).Stats.MinMAN & "," & UserList(Userindex).Stats.MaxSta & "," & UserList(Userindex).Stats.MinSta & "," & UserList(Userindex).Stats.GLD & "," & UserList(Userindex).Stats.ELV & "," & UserList(Userindex).Stats.ELU & "," & UserList(Userindex).Stats.Exp & "," & UserList(Userindex).POS.Map))
End Sub
Sub SendUserHP(Userindex As Integer)
Call SendData(ToIndex, Userindex, 0, "5A" & DesteEncripTE(UserList(Userindex).Stats.MinHP))
End Sub
Sub SendUserMANA(Userindex As Integer)
Call SendData(ToIndex, Userindex, 0, "5D" & UserList(Userindex).Stats.MinMAN)
End Sub
Sub SendUserMAXHP(Userindex As Integer)
Call SendData(ToIndex, Userindex, 0, "8B" & UserList(Userindex).Stats.MaxHP)
End Sub
Sub SendUserMAXMANA(Userindex As Integer)
Call SendData(ToIndex, Userindex, 0, "9B" & UserList(Userindex).Stats.MaxMAN)
End Sub
Sub SendUserSTA(Userindex As Integer)
Call SendData(ToIndex, Userindex, 0, "5E" & UserList(Userindex).Stats.MinSta)
End Sub
Sub SendUserORO(Userindex As Integer)
Call SendData(ToIndex, Userindex, 0, "5F" & UserList(Userindex).Stats.GLD)
End Sub
Sub SendUserREP(Userindex As Integer)
Call SendData(ToIndex, Userindex, 0, "CAZ" & UserList(Userindex).flags.CanjesDonador & "," & UserList(Userindex).Stats.Reputacion)
End Sub
Sub SendUserEXP(Userindex As Integer)
Call SendData(ToIndex, Userindex, 0, "5G" & UserList(Userindex).Stats.Exp)
End Sub
Sub SendUserMANASTA(Userindex As Integer)
Call SendData(ToIndex, Userindex, 0, "5H" & UserList(Userindex).Stats.MinMAN & "," & UserList(Userindex).Stats.MinSta)
End Sub
Sub SendUserHPSTA(Userindex As Integer)
Call SendData(ToIndex, Userindex, 0, "5I" & UserList(Userindex).Stats.MinHP & "," & UserList(Userindex).Stats.MinSta)
End Sub
Sub EnviarHambreYsed(Userindex As Integer)
Call SendData(ToIndex, Userindex, 0, "EHYS" & UserList(Userindex).Stats.MaxAGU & "," & UserList(Userindex).Stats.MinAGU & "," & UserList(Userindex).Stats.MaxHam & "," & UserList(Userindex).Stats.MinHam)
End Sub
Sub EnviarHyS(Userindex As Integer)
Call SendData(ToIndex, Userindex, 0, "5J" & UserList(Userindex).Stats.MinAGU & "," & UserList(Userindex).Stats.MinHam)
End Sub

Sub SendUserSTAtsTxt(ByVal sendIndex As Integer, Userindex As Integer)

Call SendData(ToIndex, sendIndex, 0, "||Estadisticas de: " & UserList(Userindex).Name & FONTTYPE_INFO)
Call SendData(ToIndex, sendIndex, 0, "||Nivel: " & UserList(Userindex).Stats.ELV & "  EXP: " & UserList(Userindex).Stats.Exp & "/" & UserList(Userindex).Stats.ELU & FONTTYPE_INFO)
Call SendData(ToIndex, sendIndex, 0, "||Vitalidad: " & UserList(Userindex).Stats.FIT & FONTTYPE_INFO)
Call SendData(ToIndex, sendIndex, 0, "||Salud: " & UserList(Userindex).Stats.MinHP & "/" & UserList(Userindex).Stats.MaxHP & "  Mana: " & UserList(Userindex).Stats.MinMAN & "/" & UserList(Userindex).Stats.MaxMAN & "  Vitalidad: " & UserList(Userindex).Stats.MinSta & "/" & UserList(Userindex).Stats.MaxSta & FONTTYPE_INFO)

If UserList(Userindex).Invent.WeaponEqpObjIndex Then
    Call SendData(ToIndex, sendIndex, 0, "||Menor Golpe/Mayor Golpe: " & UserList(Userindex).Stats.MinHit & "/" & UserList(Userindex).Stats.MaxHit & " (" & ObjData(UserList(Userindex).Invent.WeaponEqpObjIndex).MinHit & "/" & ObjData(UserList(Userindex).Invent.WeaponEqpObjIndex).MaxHit & ")" & FONTTYPE_INFO)
Else
    Call SendData(ToIndex, sendIndex, 0, "||Menor Golpe/Mayor Golpe: " & UserList(Userindex).Stats.MinHit & "/" & UserList(Userindex).Stats.MaxHit & FONTTYPE_INFO)
End If

Call SendData(ToIndex, sendIndex, 0, "||(CUERPO) Min Def/Max Def: " & ObjData(UserList(Userindex).Invent.ArmourEqpObjIndex).MinDef + 2 * Buleano(UserList(Userindex).Clase = GUERRERO And UserList(Userindex).Recompensas(2) = 2) & "/" & ObjData(UserList(Userindex).Invent.ArmourEqpObjIndex).MaxDef + 2 * Buleano(UserList(Userindex).Clase = GUERRERO And UserList(Userindex).Recompensas(2) = 2) & FONTTYPE_INFO)

If UserList(Userindex).Invent.CascoEqpObjIndex Then
    Call SendData(ToIndex, sendIndex, 0, "||(CABEZA) Min Def/Max Def: " & ObjData(UserList(Userindex).Invent.CascoEqpObjIndex).MinDef & "/" & ObjData(UserList(Userindex).Invent.CascoEqpObjIndex).MaxDef & FONTTYPE_INFO)
Else
    Call SendData(ToIndex, sendIndex, 0, "||(CABEZA) Min Def/Max Def: 0" & FONTTYPE_INFO)
End If

If UserList(Userindex).Invent.EscudoEqpObjIndex Then
    Call SendData(ToIndex, sendIndex, 0, "||(ESCUDO) Defensa extra: " & ObjData(UserList(Userindex).Invent.EscudoEqpObjIndex).MinDef & " / " & ObjData(UserList(Userindex).Invent.EscudoEqpObjIndex).MaxDef & FONTTYPE_INFO)
End If

If Len(UserList(Userindex).GuildInfo.GuildName) > 0 Then
    Call SendData(ToIndex, sendIndex, 0, "||Clan: " & UserList(Userindex).GuildInfo.GuildName & FONTTYPE_INFO)
    Else
        Call SendData(ToIndex, sendIndex, 0, "||Status: " & UserList(Userindex).GuildInfo.GuildPoints & FONTTYPE_INFO)
    End If
    Call SendData(ToIndex, sendIndex, 0, "||User GuildPoints: " & UserList(Userindex).GuildInfo.GuildPoints & FONTTYPE_INFO)
    If UserList(Userindex).GuildInfo.EsGuildLeader = 1 Then
       If UserList(Userindex).GuildInfo.ClanFundado = UserList(Userindex).GuildInfo.GuildName Then
            Call SendData(ToIndex, sendIndex, 0, "||Status: " & "Fundador/Lider" & FONTTYPE_INFO)
       Else
            Call SendData(ToIndex, sendIndex, 0, "||Status: " & "Lider" & FONTTYPE_INFO)
       End If
    Else
        Call SendData(ToIndex, sendIndex, 0, "||Status: " & UserList(Userindex).GuildInfo.GuildPoints & FONTTYPE_INFO)
    End If
    Call SendData(ToIndex, sendIndex, 0, "||User GuildPoints: " & UserList(Userindex).GuildInfo.GuildPoints & FONTTYPE_INFO)

Call SendData(ToIndex, sendIndex, 0, "||Posicion: " & UserList(Userindex).POS.X & "," & UserList(Userindex).POS.y & " en mapa " & UserList(Userindex).POS.Map & FONTTYPE_INFO)

Call SendData(ToIndex, sendIndex, 0, "||Ciudadanos matados: " & UserList(Userindex).Faccion.Matados(Real) & " / Criminales matados: " & UserList(Userindex).Faccion.Matados(Caos) & " / Neutrales matados: " & UserList(Userindex).Faccion.Matados(Neutral) & FONTTYPE_INFO)

Call SendData(ToIndex, sendIndex, 0, "||Retos Ganados: " & UserList(Userindex).flags.RetosGanados & "" & FONTTYPE_INFO)
Call SendData(ToIndex, sendIndex, 0, "||Retos Perdidos: " & UserList(Userindex).flags.RetosPerdidos & "" & FONTTYPE_INFO)

Call SendData(ToIndex, sendIndex, 0, "||Advertencias: " & UserList(Userindex).flags.Advertencias & "" & FONTTYPE_INFO)

Call SendData(ToIndex, sendIndex, 0, "||Advertencias de facción: " & UserList(Userindex).flags.Advertenciasfacc & "" & FONTTYPE_INFO)
End Sub
Sub SendUserInvTxt(ByVal sendIndex As Integer, Userindex As Integer)
On Error Resume Next
Dim j As Byte

Call SendData(ToIndex, sendIndex, 0, "||" & UserList(Userindex).Name & FONTTYPE_INFO)
Call SendData(ToIndex, sendIndex, 0, "|| Tiene " & UserList(Userindex).Invent.NroItems & " objetos." & FONTTYPE_INFO)

For j = 1 To MAX_INVENTORY_SLOTS
    If UserList(Userindex).Invent.Object(j).OBJIndex Then
        Call SendData(ToIndex, sendIndex, 0, "|| Objeto " & j & " " & ObjData(UserList(Userindex).Invent.Object(j).OBJIndex).Name & " Cantidad:" & UserList(Userindex).Invent.Object(j).Amount & FONTTYPE_INFO)
    End If
Next

End Sub

Sub SendUserSkillsTxt(ByVal sendIndex As Integer, Userindex As Integer)
On Error Resume Next
Dim j As Integer
Call SendData(ToIndex, sendIndex, 0, "||" & UserList(Userindex).Name & FONTTYPE_INFO)
For j = 1 To NUMSKILLS
    Call SendData(ToIndex, sendIndex, 0, "|| " & SkillsNames(j) & " = " & UserList(Userindex).Stats.UserSkills(j) & FONTTYPE_INFO)
Next
End Sub
Sub Parpa(Userindex As Integer)
Call SendData(ToIndex, Userindex, 0, "PARPA")
End Sub
Sub UpdateFuerzaYAg(Userindex As Integer)
Dim Fue As Integer
Dim Agi As Integer

Fue = UserList(Userindex).Stats.UserAtributos(fuerza)
If Fue = UserList(Userindex).Stats.UserAtributosBackUP(fuerza) Then Fue = 0

Agi = UserList(Userindex).Stats.UserAtributos(Agilidad)
If Agi = UserList(Userindex).Stats.UserAtributosBackUP(Agilidad) Then Agi = 0

Call SendData(ToIndex, Userindex, 0, "EIFYA" & Fue & "," & Agi)

End Sub
Sub UpdateUserMap(Userindex As Integer)
On Error GoTo ErrorHandler
Dim TempChar As Integer
Dim X As Integer
Dim y As Integer
Dim i As Integer
Dim Map As Integer

Dim Eltotal As String 'AREAS NUEVAS
Dim EltotalBloq As String
Dim EltotalNpcs As String

Dim Cantidadpormapa As Integer
Dim Cantidadpormapabloq As Integer
Dim CantidadPorMapaNpcs As Integer


Eltotal = "@"
EltotalBloq = "@"
EltotalNpcs = "@"

Map = UserList(Userindex).POS.Map

Call SendData(ToIndex, Userindex, 0, "ET")

'Call DibujarUsuarios(userindex) 'AREAS NUEVAS MODIFICAR BUG


For i = 1 To MapInfo(Map).NumUsers
    TempChar = MapInfo(Map).Userindex(i)
    Call MakeUserChar(ToIndex, Userindex, 0, TempChar, Map, UserList(TempChar).POS.X, UserList(TempChar).POS.y)
Next

For i = 1 To LastNPC
    If Npclist(i).flags.NPCActive And UserList(Userindex).POS.Map = Npclist(i).POS.Map Then
        CantidadPorMapaNpcs = CantidadPorMapaNpcs + 1
        X = Npclist(i).POS.X
        y = Npclist(i).POS.y
        EltotalNpcs = EltotalNpcs & Npclist(i).Char.Body & "," & Npclist(i).Char.Head & "," & Npclist(i).Char.Heading & "," & Npclist(i).Char.CharIndex & "," & X & "," & y & "," & Npclist(i).Name & "@"
    End If
Next


For y = YMinMapSize To YMaxMapSize
    For X = XMinMapSize To XMaxMapSize
        If MapData(Map, X, y).OBJInfo.OBJIndex Then
            If ObjData(MapData(Map, X, y).OBJInfo.OBJIndex).ObjType <> OBJTYPE_ARBOLES Or MapData(Map, X, y).trigger = 2 Then
                If y >= 40 Then
                    y = y
                End If
                
                
                Cantidadpormapa = Cantidadpormapa + 1
                Eltotal = Eltotal & ObjData(MapData(Map, X, y).OBJInfo.OBJIndex).GrhIndex & "," & X & "," & y & "@" 'AREAS NUEVAS
                
                If ObjData(MapData(Map, X, y).OBJInfo.OBJIndex).ObjType = OBJTYPE_PUERTAS Then
                    Cantidadpormapabloq = Cantidadpormapabloq + 1
                    EltotalBloq = EltotalBloq & X & "," & y & "," & MapData(Map, X, y).Blocked & "@" 'AREAS NUEVAS
                End If
            End If
        End If
    Next
Next

Call SendData(ToIndex, Userindex, 0, "CX" & CantidadPorMapaNpcs & EltotalNpcs) 'AREAS NUEVAS
Call SendData(ToIndex, Userindex, 0, "HE" & Cantidadpormapa & Eltotal) 'AREAS NUEVAS
Call SendData(ToIndex, Userindex, 0, "BK" & Cantidadpormapabloq & EltotalBloq) 'AREAS NUEVAS


EltotalNpcs = 0
Eltotal = 0
EltotalBloq = 0
Cantidadpormapa = 0
Cantidadpormapabloq = 0
CantidadPorMapaNpcs = 0
Exit Sub
ErrorHandler:
    Call LogError("Error en el sub.UpdateUserMap. Mapa: " & Map & "-" & X & "-" & y)

End Sub
Sub DibujarUsuarios(Userindex As Integer)
Dim i As Integer
Dim EltotalUsuarios As String
Dim klan$
Dim bCr As Byte
Dim Map As Integer

Dim X As Integer
Dim y As Integer

Map = UserList(Userindex).POS.Map

klan$ = UserList(Userindex).GuildInfo.GuildName
If Len(klan$) > 0 Then klan = " <" & klan$ & ">"

If UserList(Userindex).flags.Privilegios = 1 Then
    bCr = 9
ElseIf UserList(Userindex).flags.Privilegios = 2 Then
    bCr = 10
ElseIf UserList(Userindex).flags.Privilegios = 3 Then
    bCr = 1
ElseIf UserList(Userindex).flags.Privilegios = 4 Then
    bCr = 11
ElseIf UserList(Userindex).Faccion.Bando = Real And UserList(Userindex).flags.EsConseReal = 0 Then
    bCr = 2
ElseIf UserList(Userindex).Faccion.Bando = Caos And UserList(Userindex).flags.EsConseCaos = 0 Then
    bCr = 3
ElseIf EsNewbie(Userindex) Then
    bCr = 4
ElseIf UserList(Userindex).flags.EsConseCaos And UserList(Userindex).Faccion.Bando = Caos Then
    bCr = 6
ElseIf UserList(Userindex).flags.EsConseReal And UserList(Userindex).Faccion.Bando = Real Then
    bCr = 7
ElseIf UserList(Userindex).flags.EsConcilioNegro And UserList(Userindex).Faccion.Bando = Neutral Then
    bCr = 8
Else
    bCr = 5
End If

EltotalUsuarios = "@" & UserList(Userindex).Char.Body & "," & UserList(Userindex).Char.Head & "," & UserList(Userindex).Char.Heading & "," & UserList(Userindex).Char.CharIndex & "," & UserList(Userindex).POS.X & "," & UserList(Userindex).POS.y & "," & UserList(Userindex).Char.WeaponAnim & "," & UserList(Userindex).Char.ShieldAnim & "," & UserList(Userindex).Char.FX & "," & 999 & "," & UserList(Userindex).Name & klan$ & "," & UserList(Userindex).Char.CascoAnim & "," & bCr & "," & UserList(Userindex).Char.Aura & "," & UserList(Userindex).flags.Invisible & "," & UserList(Userindex).flags.Privilegios & "@"

For i = 1 To MapInfo(Map).NumUsers
If Not i = Userindex Then
        X = UserList(i).POS.X
        y = UserList(i).POS.y
        
          
klan$ = UserList(i).GuildInfo.GuildName
If UserList(i).flags.Privilegios = 1 Then
    bCr = 9
ElseIf UserList(i).flags.Privilegios = 2 Then
    bCr = 10
ElseIf UserList(i).flags.Privilegios = 3 Then
    bCr = 1
ElseIf UserList(i).flags.Privilegios = 4 Then
    bCr = 11
ElseIf UserList(i).Faccion.Bando = Real And UserList(i).flags.EsConseReal = 0 Then
    bCr = 2
ElseIf UserList(i).Faccion.Bando = Caos And UserList(i).flags.EsConseCaos = 0 Then
    bCr = 3
ElseIf EsNewbie(i) Then
    bCr = 4
ElseIf UserList(i).flags.EsConseCaos And UserList(i).Faccion.Bando = Caos Then
    bCr = 6
ElseIf UserList(i).flags.EsConseReal And UserList(i).Faccion.Bando = Real Then
    bCr = 7
ElseIf UserList(i).flags.EsConcilioNegro And UserList(i).Faccion.Bando = Neutral Then
    bCr = 8
Else
    bCr = 5
End If

If Len(klan$) > 0 Then klan = " <" & klan$ & ">"

EltotalUsuarios = EltotalUsuarios & UserList(i).Char.Body & "," & UserList(i).Char.Head & "," & UserList(i).Char.Heading & "," & UserList(i).Char.CharIndex & "," & X & "," & y & "," & UserList(i).Char.WeaponAnim & "," & UserList(i).Char.ShieldAnim & "," & UserList(i).Char.FX & "," & 999 & "," & UserList(i).Name & klan$ & "," & UserList(i).Char.CascoAnim & "," & bCr & "," & UserList(i).Char.Aura & "," & UserList(i).flags.Invisible & "," & UserList(i).flags.Privilegios & "@"
End If
Next

Call SendData(ToIndex, Userindex, UserList(Userindex).POS.Map, "CX" & MapInfo(Map).NumUsers & EltotalUsuarios) 'AREAS NUEVAS
EltotalUsuarios = 0
End Sub
Function DameUserindex(SocketId As Integer) As Integer

Dim loopc As Integer
  
loopc = 1
  
Do Until UserList(loopc).ConnID = SocketId

    loopc = loopc + 1
    
    If loopc > MaxUsers Then
        DameUserindex = 0
        Exit Function
    End If
    
Loop
  
DameUserindex = loopc

End Function
Function EsMascotaCiudadano(NpcIndex As Integer, Userindex As Integer) As Boolean

If Npclist(NpcIndex).MaestroUser Then
    EsMascotaCiudadano = UserList(Userindex).Faccion.Bando = Real
    If EsMascotaCiudadano Then Call SendData(ToIndex, Npclist(NpcIndex).MaestroUser, 0, "F0" & UserList(Userindex).Name)
End If

End Function
Function EsMascotaCriminal(NpcIndex As Integer, Userindex As Integer) As Boolean

If Npclist(NpcIndex).MaestroUser Then
    EsMascotaCriminal = Not UserList(Userindex).Faccion.Bando = Caos
    If EsMascotaCriminal Then Call SendData(ToIndex, Npclist(NpcIndex).MaestroUser, 0, "F0" & UserList(Userindex).Name)
End If

End Function
Sub NpcAtacado(NpcIndex As Integer, Userindex As Integer)

Npclist(NpcIndex).flags.AttackedBy = Userindex

If Npclist(NpcIndex).MaestroUser Then Call AllMascotasAtacanUser(Userindex, Npclist(NpcIndex).MaestroUser)
If Npclist(NpcIndex).flags.Faccion <> Neutral Then
    If UserList(Userindex).Faccion.Ataco(Npclist(NpcIndex).flags.Faccion) = 0 Then UserList(Userindex).Faccion.Ataco(Npclist(NpcIndex).flags.Faccion) = 2
End If

Npclist(NpcIndex).Movement = NPCDEFENSA
Npclist(NpcIndex).Hostile = 1

End Sub
Function PuedeApuñalar(Userindex As Integer) As Boolean

If UserList(Userindex).Invent.WeaponEqpObjIndex Then PuedeApuñalar = ((UserList(Userindex).Stats.UserSkills(Apuñalar) >= MIN_APUÑALAR) And (ObjData(UserList(Userindex).Invent.WeaponEqpObjIndex).Apuñala = 1)) Or ((UserList(Userindex).Clase = ASESINO) And (ObjData(UserList(Userindex).Invent.WeaponEqpObjIndex).Apuñala = 1))

End Function
Sub SubirSkill(Userindex As Integer, Skill As Integer, Optional Prob As Integer)
On Error GoTo errhandler

If UserList(Userindex).flags.Hambre = 1 Or UserList(Userindex).flags.Sed = 1 Then Exit Sub

If Prob = 0 Then
    If UserList(Userindex).Stats.ELV <= 3 Then
        Prob = 2
    ElseIf UserList(Userindex).Stats.ELV > 3 _
        And UserList(Userindex).Stats.ELV < 6 Then
        Prob = 2
    ElseIf UserList(Userindex).Stats.ELV >= 6 _
        And UserList(Userindex).Stats.ELV < 10 Then
        Prob = 2
    ElseIf UserList(Userindex).Stats.ELV >= 10 _
        And UserList(Userindex).Stats.ELV < 20 Then
        Prob = 2
    Else
        Prob = 2
    End If
End If

If UserList(Userindex).Stats.UserSkills(Skill) = MAXSKILLPOINTS Then Exit Sub

If Int(RandomNumber(1, Prob)) = 2 And UserList(Userindex).Stats.UserSkills(Skill) < LevelSkill(UserList(Userindex).Stats.ELV).LevelValue Then
    Call AddtoVar(UserList(Userindex).Stats.UserSkills(Skill), 1, MAXSKILLPOINTS)
   ' Call SendData(ToIndex, Userindex, 0, "G0" & SkillsNames(Skill) & "," & UserList(Userindex).Stats.UserSkills(Skill))
   ' Call AddtoVar(UserList(UserIndex).Stats.Exp, 50, MAXEXP)
   ' Call SendData(ToIndex, UserIndex, 0, "EX" & 50)
   ' Call SendUserEXP(UserIndex)
   ' Call CheckUserLevel(UserIndex)
End If
Exit Sub

errhandler:
    Call LogError("Error en SubirSkill: " & Err.Description & "-" & UserList(Userindex).Name & "-" & SkillsNames(Skill))
End Sub
Sub BajarInvisible(Userindex As Integer)

If UserList(Userindex).Stats.ELV >= 34 Or UserList(Userindex).flags.GolpeoInvi Then
    Call QuitarInvisible(Userindex)
Else: UserList(Userindex).flags.GolpeoInvi = 1
End If

End Sub
Sub QuitarInvisible(Userindex As Integer)

UserList(Userindex).Counters.Invisibilidad = 0
UserList(Userindex).flags.Invisible = 0
UserList(Userindex).flags.GolpeoInvi = 0
UserList(Userindex).flags.Oculto = 0
Call SendData(ToMap, 0, UserList(Userindex).POS.Map, ("V3" & DesteEncripTE("0," & UserList(Userindex).Char.CharIndex)))

End Sub
Sub UserDie(Userindex As Integer)
On Error GoTo ErrorHandler


If UserList(Userindex).Genero = 1 Then
Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "TWM1")
Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "TWrespawn")
Else
Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "TWH1")
Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "TWrespawn")
End If

If MapInfo(UserList(Userindex).POS.Map).EsMapaEspecial Then
Else
If Not TieneObjetos(SacriIndex, 1, Userindex) Then 'sacri
Call SendData(ToIndex, Userindex, 0, "SSSMMM")
End If
End If


Call SendData(ToIndex, Userindex, 0, "MH" & 1 & "," & TiempoReal)

If UserList(Userindex).GuildInfo.GuildName <> "" Then
Call SendData(ToGuildMembers, Userindex, 0, "||" & UserList(Userindex).Name & " ha muerto en " & UserList(Userindex).POS.Map & ", " & UserList(Userindex).POS.X & ", " & UserList(Userindex).POS.y & "." & FONTTYPE_GUILD)
End If

If UserList(Userindex).flags.Montado = 1 Then Desmontar (Userindex)

Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "QDL" & UserList(Userindex).Char.CharIndex)

UserList(Userindex).Stats.MinHP = 0
UserList(Userindex).flags.AtacadoPorNpc = 0
UserList(Userindex).flags.AtacadoPorUser = 0
UserList(Userindex).flags.Envenenado = 0
UserList(Userindex).flags.Muerto = 1

If UserList(Userindex).POS.Map = 192 Then
If UserList(Userindex).Faccion.Bando = Real Then
Call WarpUserChar(Userindex, 194, 71, 46, True)
ElseIf UserList(Userindex).Faccion.Bando = Caos Then
Call WarpUserChar(Userindex, 193, 71, 46, True)
End If
End If


If UserList(Userindex).flags.ComerCiandoNuevo = True Then
    If UserList(Userindex).flags.Comerciando = True Then 'ComercioNuevo
    Call CanceloComercio(Userindex)
    End If
End If

If UserList(Userindex).POS.Map = 197 Then
If UserList(Userindex).Faccion.Bando = Real Then
Call WarpUserChar(Userindex, MAP_ThTeazul, 71, 46, True)
ElseIf UserList(Userindex).Faccion.Bando = Caos Then
Call WarpUserChar(Userindex, MAP_ThTerojo, 71, 46, True)
End If
End If

Dim aN As Integer

aN = UserList(Userindex).flags.AtacadoPorNpc

If aN Then
      Npclist(aN).Movement = Npclist(aN).flags.OldMovement
      Npclist(aN).Hostile = Npclist(aN).flags.OldHostil
      Npclist(aN).flags.AttackedBy = 0
End If

If UserList(Userindex).flags.Paralizado Then
    Call SendData(ToIndex, Userindex, 0, "P8")
    UserList(Userindex).flags.Paralizado = 0
End If

If UserList(Userindex).flags.Trabajando Then Call SacarModoTrabajo(Userindex)

If UserList(Userindex).flags.Invisible And UserList(Userindex).flags.AdminInvisible = 0 Then
    Call QuitarInvisible(Userindex)
End If

If UserList(Userindex).flags.Ceguera = 1 Then
  UserList(Userindex).Counters.Ceguera = 0
  UserList(Userindex).flags.Ceguera = 0
  Call SendData(ToMap, 0, UserList(Userindex).POS.Map, "NSEGUE")
End If

If UserList(Userindex).flags.Estupidez = 1 Then
  UserList(Userindex).Counters.Estupidez = 0
  UserList(Userindex).flags.Estupidez = 0
  Call SendData(ToMap, 0, UserList(Userindex).POS.Map, "NESTUP")
End If

If UserList(Userindex).flags.Descansar Then
    UserList(Userindex).flags.Descansar = False
    Call SendData(ToIndex, Userindex, 0, "DOK")
End If

If UserList(Userindex).flags.Meditando Then
    UserList(Userindex).flags.Meditando = False
    Call SendData(ToIndex, Userindex, 0, "MEDOK")
End If

If UserList(Userindex).Invent.ArmourEqpObjIndex Then Call Desequipar(Userindex, UserList(Userindex).Invent.ArmourEqpSlot)
If UserList(Userindex).Invent.WeaponEqpObjIndex Then Call Desequipar(Userindex, UserList(Userindex).Invent.WeaponEqpSlot)
If UserList(Userindex).Invent.EscudoEqpObjIndex Then Call Desequipar(Userindex, UserList(Userindex).Invent.EscudoEqpSlot)
If UserList(Userindex).Invent.CascoEqpObjIndex Then Call Desequipar(Userindex, UserList(Userindex).Invent.CascoEqpSlot)
If UserList(Userindex).Invent.HerramientaEqpObjIndex Then Call Desequipar(Userindex, UserList(Userindex).Invent.HerramientaEqpslot)
If UserList(Userindex).Invent.MunicionEqpObjIndex Then Call Desequipar(Userindex, UserList(Userindex).Invent.MunicionEqpSlot)


    If Not EsNewbie(Userindex) Then
        Call TirarTodo(Userindex)
    Else: Call TirarTodosLosItemsNoNewbies(Userindex)
    End If

If UserList(Userindex).Char.loops = LoopAdEternum Then
    UserList(Userindex).Char.FX = 0
    UserList(Userindex).Char.loops = 0
End If

Call UserMuereRetoAuto(Userindex)


If JugandoEnQueRing(Userindex) > 0 Then
    MOD_EVENTO_Retos2vs2.MuereUser (Userindex)
End If

If UserList(Userindex).flags.death = True Then
Call death_muere(Userindex)
UserList(Userindex).flags.death = False
Call WarpUserChar(Userindex, 1, 50, 50, True)
Call SendData(ToIndex, Userindex, 0, "PERDISTE")
End If

If UserList(Userindex).flags.automaticop = True Then
Call Rondas_UsuarioMuerep(Userindex)
If AutomaticoCanjes = 1 Then Call WarpUserChar(Userindex, 198, 24, 65)
If AutomaticoCanjes = 0 Then Call WarpUserChar(Userindex, 1, 50, 50)
If AutomaticoCanjes = 1 Then Call TirarTodosLosItems(Userindex)
Call SendData(ToIndex, Userindex, 0, "PERDISTE")
End If

If UserList(Userindex).flags.automatico = True Then
Call Rondas_UsuarioMuere(Userindex)
If AutomaticoCanjes = 1 Then Call WarpUserChar(Userindex, 198, 24, 65)
If AutomaticoCanjes = 0 Then Call WarpUserChar(Userindex, 1, 50, 50)
If AutomaticoCanjes = 1 Then Call TirarTodosLosItems(Userindex)
Call SendData(ToIndex, Userindex, 0, "PERDISTE")
End If

If UserList(Userindex).flags.Navegando = 0 Then
    UserList(Userindex).Char.Body = iCuerpoMuerto
    UserList(Userindex).Char.Head = iCabezaMuerto
    UserList(Userindex).Char.ShieldAnim = NingunEscudo
    UserList(Userindex).Char.WeaponAnim = NingunArma
    UserList(Userindex).Char.CascoAnim = NingunCasco
Else
    UserList(Userindex).Char.Body = iFragataFantasmal
End If

Dim i As Integer
For i = 1 To MAXMASCOTAS * Buleano(Not UserList(Userindex).flags.Quest)
    If UserList(Userindex).MascotasIndex(i) Then
           If Npclist(UserList(Userindex).MascotasIndex(i)).Contadores.TiempoExistencia Then
                Call QuitarNPC(UserList(Userindex).MascotasIndex(i))
           Else
                Npclist(UserList(Userindex).MascotasIndex(i)).MaestroUser = 0
                Npclist(UserList(Userindex).MascotasIndex(i)).Movement = Npclist(UserList(Userindex).MascotasIndex(i)).flags.OldMovement
                Npclist(UserList(Userindex).MascotasIndex(i)).Hostile = Npclist(UserList(Userindex).MascotasIndex(i)).flags.OldHostil
                UserList(Userindex).MascotasIndex(i) = 0
                UserList(Userindex).MascotasType(i) = 0
           End If
    End If
    
Next




If UserList(Userindex).POS.Map <> 190 Then UserList(Userindex).Stats.VecesMurioUsuario = UserList(Userindex).Stats.VecesMurioUsuario + 1

UserList(Userindex).NroMascotas = 0

Call ChangeUserChar(ToMap, 0, UserList(Userindex).POS.Map, val(Userindex), UserList(Userindex).Char.Body, UserList(Userindex).Char.Head, UserList(Userindex).Char.Heading, NingunArma, NingunEscudo, NingunCasco)
If PuedeDestrabarse(Userindex) Then
End If 'Call SendData(ToIndex, UserIndex, 0, "||Estás encerrado, para destrabarte presiona la tecla Z." & FONTTYPE_INFO)



Call SendUserStatsBox(Userindex)

If MOD_EVENTO_Retos3vs3.EsPartyInscripto(UserList(Userindex).PartyIndex) Then
    MOD_EVENTO_Retos3vs3.MuereUser (Userindex)
End If

If cACT = False Then
'##################### GUERRACLAN by GALLE ###################
If UserList(Userindex).flags.enRetoC1 = True Then
   If Not Clan1CUP = 0 Then 'SI NUMERO DE MUERTOS DE UN CLAN = NUMERO DE JUGADORES DEL CLAN
    Clan1CUP = Clan1CUP - 1 'resta
   End If
    
If Clan1CUP = 0 Then

If Clan1CUPRONDAS = 0 Or Clan1CUPRONDAS = 1 Then
      GMCuentaGuerraclan = UserList(Userindex).POS.Map
      CuentaRegresivaGuerraclan = 60
      yamandocuenta = 1
      For i = 1 To LastUser
          If UserList(i).flags.enRetoC1 Then
             Call WarpUserChar(i, 94, 83, 24)
          ElseIf UserList(i).flags.enRetoC2 Then
             Call WarpUserChar(i, 94, 83, 81)
          End If
          Call RevivirUsuarioNPC(i)
      Next
            ESPRIMERARONDACLAN = False
            Clan1CUPRONDAS = Clan1CUPRONDAS + 1
            Call SendData(ToGuildMembers, RetoClan.lider1, 0, "||Gana " & UserList(RetoClan.lider2).GuildInfo.GuildName & " [" & Clan1CUPRONDAS & "] a [" & Clan2CUPRONDAS & "] Pueden ingresar nuevos participantes con el comando /IRGUERRA." & FONTTYPE_FENIX)
            Call SendData(ToGuildMembers, RetoClan.lider2, 0, "||Gana " & UserList(RetoClan.lider2).GuildInfo.GuildName & " [" & Clan1CUPRONDAS & "] a [" & Clan2CUPRONDAS & "] Pueden ingresar nuevos participantes con el comando /IRGUERRA." & FONTTYPE_FENIX)
End If

If Clan1CUPRONDAS = 2 Then
    Call GanaClanLider2(0)
      End If
End If
   End If
End If

If UserList(Userindex).flags.enRetoC2 = True Then


   If Not Clan2CUP = 0 Then  'SI NUMERO DE MUERTOS DE UN CLAN = NUMERO DE JUGADORES DEL CLAN
     Clan2CUP = Clan2CUP - 1 'resta

   End If
   
If Clan2CUP = 0 Then

If Clan2CUPRONDAS = 0 Or Clan2CUPRONDAS = 1 Then
      GMCuentaGuerraclan = UserList(Userindex).POS.Map
      CuentaRegresivaGuerraclan = 60
      yamandocuenta = 1
      For i = 1 To LastUser
          If UserList(i).flags.enRetoC1 Then
             Call WarpUserChar(i, 94, 83, 24)
          ElseIf UserList(i).flags.enRetoC2 Then
             Call WarpUserChar(i, 94, 83, 81)
          End If
          Call RevivirUsuarioNPC(i)
      Next
      ESPRIMERARONDACLAN = False
      Clan2CUPRONDAS = Clan2CUPRONDAS + 1
      Call SendData(ToGuildMembers, RetoClan.lider1, 0, "||Gana " & UserList(RetoClan.lider1).GuildInfo.GuildName & " [" & Clan2CUPRONDAS & "] a [" & Clan2CUPRONDAS & "] Pueden ingresar nuevos participantes con el comando /IRGUERRA." & FONTTYPE_FENIX)
      Call SendData(ToGuildMembers, RetoClan.lider2, 0, "||Gana " & UserList(RetoClan.lider1).GuildInfo.GuildName & " [" & Clan2CUPRONDAS & "] a [" & Clan2CUPRONDAS & "] Pueden ingresar nuevos participantes con el comando /IRGUERRA." & FONTTYPE_FENIX)
End If
   
If Clan2CUPRONDAS = 2 Then
     Call GanaClanLider1(0)
   End If
End If
End If




If UserList(Userindex).flags.Retando = True Then
Call TerminoReto(Userindex)
End If

Exit Sub


ErrorHandler:
    Call LogError("Error en SUB USERDIE")

End Sub
Sub ContarMuerte(Muerto As Integer, Atacante As Integer)
If EsNewbie(Muerto) Then Exit Sub

If UserList(Atacante).flags.LastMatado(UserList(Muerto).Faccion.Bando) <> UCase$(UserList(Muerto).Name) Then
    UserList(Atacante).flags.LastMatado(UserList(Muerto).Faccion.Bando) = UCase$(UserList(Muerto).Name)
    Call AddtoVar(UserList(Atacante).Faccion.Matados(UserList(Muerto).Faccion.Bando), 1, 65000)
End If

End Sub

Sub Tilelibre(POS As WorldPos, nPos As WorldPos)


Dim Notfound As Boolean
Dim loopc As Integer
Dim tX As Integer
Dim tY As Integer
Dim hayobj As Boolean
hayobj = False
nPos.Map = POS.Map

Do While Not LegalPos(POS.Map, nPos.X, nPos.y) Or hayobj
    
    If loopc > 15 Then
        Notfound = True
        Exit Do
    End If
    
    For tY = POS.y - loopc To POS.y + loopc
        For tX = POS.X - loopc To POS.X + loopc
        
            If LegalPos(nPos.Map, tX, tY) Then
               hayobj = (MapData(nPos.Map, tX, tY).OBJInfo.OBJIndex > 0)
               If Not hayobj And MapData(nPos.Map, tX, tY).TileExit.Map = 0 Then
                     nPos.X = tX
                     nPos.y = tY
                     tX = POS.X + loopc
                     tY = POS.y + loopc
                End If
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
Sub AgregarAUsersPorMapa(Userindex As Integer)


MapInfo(UserList(Userindex).POS.Map).NumUsers = MapInfo(UserList(Userindex).POS.Map).NumUsers + 1
If MapInfo(UserList(Userindex).POS.Map).NumUsers < 0 Then MapInfo(UserList(Userindex).POS.Map).NumUsers = 0

If MapInfo(UserList(Userindex).POS.Map).NumUsers = 1 Then
    ReDim MapInfo(UserList(Userindex).POS.Map).Userindex(1 To 1)
Else
    
    ReDim Preserve MapInfo(UserList(Userindex).POS.Map).Userindex(1 To MapInfo(UserList(Userindex).POS.Map).NumUsers)
End If


MapInfo(UserList(Userindex).POS.Map).Userindex(MapInfo(UserList(Userindex).POS.Map).NumUsers) = Userindex
    
End Sub
Sub QuitarDeUsersPorMapa(Userindex As Integer)


MapInfo(UserList(Userindex).POS.Map).NumUsers = MapInfo(UserList(Userindex).POS.Map).NumUsers - 1
If MapInfo(UserList(Userindex).POS.Map).NumUsers < 0 Then MapInfo(UserList(Userindex).POS.Map).NumUsers = 0

If MapInfo(UserList(Userindex).POS.Map).NumUsers Then
    Dim i As Integer
        
    For i = 1 To MapInfo(UserList(Userindex).POS.Map).NumUsers + 1
        
        If MapInfo(UserList(Userindex).POS.Map).Userindex(i) = Userindex Then Exit For
    Next
    
    For i = i To MapInfo(UserList(Userindex).POS.Map).NumUsers
        
        MapInfo(UserList(Userindex).POS.Map).Userindex(i) = MapInfo(UserList(Userindex).POS.Map).Userindex(i + 1)
    Next
    
    ReDim Preserve MapInfo(UserList(Userindex).POS.Map).Userindex(1 To MapInfo(UserList(Userindex).POS.Map).NumUsers)
Else
    ReDim MapInfo(UserList(Userindex).POS.Map).Userindex(0)
End If
    
End Sub
Sub WarpUserChar(Userindex As Integer, Map As Integer, X As Integer, y As Integer, Optional FX As Boolean = False)

If Map = 198 Then
frmMain.TimerTIEMPOMAP.Enabled = True
End If

Call SendData(ToMap, 0, UserList(Userindex).POS.Map, "QDL" & UserList(Userindex).Char.CharIndex)
Call SendData(ToIndex, Userindex, UserList(Userindex).POS.Map, "QTDL")

Dim OldMap As Integer
Dim OldX As Integer
Dim OldY As Integer

UserList(Userindex).Counters.Protegido = 2
UserList(Userindex).flags.Protegido = 3

OldMap = UserList(Userindex).POS.Map
OldX = UserList(Userindex).POS.X
OldY = UserList(Userindex).POS.y

Call EraseUserChar(ToMap, 0, OldMap, Userindex)

UserList(Userindex).POS.X = X
UserList(Userindex).POS.y = y

If OldMap = Map Then
    Call MakeUserChar(ToMap, 0, UserList(Userindex).POS.Map, Userindex, UserList(Userindex).POS.Map, UserList(Userindex).POS.X, UserList(Userindex).POS.y)
    Call SendData(ToIndex, Userindex, 0, "IP" & UserList(Userindex).Char.CharIndex)
Else
    Call QuitarDeUsersPorMapa(Userindex)
    UserList(Userindex).POS.Map = Map
    Call AgregarAUsersPorMapa(Userindex)
     
    Call SendData(ToIndex, Userindex, 0, "CM" & UserList(Userindex).POS.Map & "," & MapInfo(UserList(Userindex).POS.Map).MapVersion & "," & MapInfo(UserList(Userindex).POS.Map).Name & "," & MapInfo(UserList(Userindex).POS.Map).TopPunto & "," & MapInfo(UserList(Userindex).POS.Map).LeftPunto)
    If MapInfo(Map).Music <> MapInfo(OldMap).Music Then Call SendData(ToIndex, Userindex, 0, "TM" & MapInfo(Map).Music)
    If MapInfo(Map).MusicNoMp3 <> MapInfo(OldMap).MusicNoMp3 Then Call SendData(ToIndex, Userindex, 0, "TN" & MapInfo(Map).MusicNoMp3)
    
    Call MakeUserChar(ToMap, 0, UserList(Userindex).POS.Map, Userindex, UserList(Userindex).POS.Map, UserList(Userindex).POS.X, UserList(Userindex).POS.y)
    Call SendData(ToIndex, Userindex, 0, "IP" & UserList(Userindex).Char.CharIndex)
End If

Call UpdateUserMap(Userindex)

If FX And UserList(Userindex).flags.AdminInvisible = 0 And Not UserList(Userindex).flags.Meditando Then
    Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "TW" & SND_WARP)
    
Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "CFX" & UserList(Userindex).Char.CharIndex & "," & UserList(Userindex).Char.CharIndex & "," & FXWARP & "," & 1 & "," & 0) 'dx8

End If
Dim i As Integer

For i = 1 To MAXMASCOTAS * Buleano(Not UserList(Userindex).flags.Quest)
    If UserList(Userindex).MascotasIndex(i) Then
        If Npclist(UserList(Userindex).MascotasIndex(i)).flags.NPCActive Then
            Call QuitarNPC(UserList(Userindex).MascotasIndex(i))
        End If
    End If
Next

End Sub
Sub WarpMascotas(Userindex As Integer)
Dim i As Integer

Dim UMascRespawn  As Boolean
Dim miflag As Byte, MascotasReales As Integer
Dim prevMacotaType As Integer

Dim PetTypes(1 To MAXMASCOTAS) As Integer
Dim PetRespawn(1 To MAXMASCOTAS) As Boolean
Dim PetTiempoDeVida(1 To MAXMASCOTAS) As Integer

Dim NroPets As Integer

NroPets = UserList(Userindex).NroMascotas

For i = 1 To MAXMASCOTAS * Buleano(Not UserList(Userindex).flags.Quest)
    If UserList(Userindex).MascotasIndex(i) Then
        PetRespawn(i) = Npclist(UserList(Userindex).MascotasIndex(i)).flags.Respawn = 0
        If PetRespawn(i) Then
            PetTypes(i) = UserList(Userindex).MascotasType(i)
            PetTiempoDeVida(i) = Npclist(UserList(Userindex).MascotasIndex(i)).Contadores.TiempoExistencia
            Call QuitarNPC(UserList(Userindex).MascotasIndex(i))
        Else
            PetTypes(i) = UserList(Userindex).MascotasType(i)
            PetTiempoDeVida(i) = 1
            Call QuitarNPC(UserList(Userindex).MascotasIndex(i))
        End If
    End If
Next

For i = 1 To MAXMASCOTAS * Buleano(Not UserList(Userindex).flags.Quest)
    If PetTypes(i) Then
        UserList(Userindex).MascotasIndex(i) = SpawnNpc(PetTypes(i), UserList(Userindex).POS, False, PetRespawn(i))
        UserList(Userindex).MascotasType(i) = PetTypes(i)
        
        If UserList(Userindex).MascotasIndex(i) = MAXNPCS Then
                UserList(Userindex).MascotasIndex(i) = 0
                UserList(Userindex).MascotasType(i) = 0
                If UserList(Userindex).NroMascotas Then UserList(Userindex).NroMascotas = UserList(Userindex).NroMascotas - 1
                Exit Sub
        End If
        Npclist(UserList(Userindex).MascotasIndex(i)).MaestroUser = Userindex
        Npclist(UserList(Userindex).MascotasIndex(i)).Movement = SIGUE_AMO
        Npclist(UserList(Userindex).MascotasIndex(i)).Target = 0
        Npclist(UserList(Userindex).MascotasIndex(i)).TargetNpc = 0
        Npclist(UserList(Userindex).MascotasIndex(i)).Contadores.TiempoExistencia = PetTiempoDeVida(i)
        Call QuitarNPCDeLista(Npclist(UserList(Userindex).MascotasIndex(i)).Numero, UserList(Userindex).POS.Map)
        Call FollowAmo(UserList(Userindex).MascotasIndex(i))
    End If
Next

UserList(Userindex).NroMascotas = NroPets

End Sub
Sub Cerrar_Usuario(Userindex As Integer)

If UserList(Userindex).flags.UserLogged And Not UserList(Userindex).Counters.Saliendo Then
    UserList(Userindex).Counters.Saliendo = True
    UserList(Userindex).Counters.Salir = Timer - 8 * Buleano(UserList(Userindex).Clase = PIRATA And UserList(Userindex).Recompensas(3) = 2)
    Call SendData(ToIndex, Userindex, 0, "1Z" & IntervaloCerrarConexion - 8 * Buleano(UserList(Userindex).Clase = PIRATA And UserList(Userindex).Recompensas(3) = 2))
End If
    
End Sub

