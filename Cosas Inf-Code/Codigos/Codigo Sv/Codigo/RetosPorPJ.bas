Attribute VB_Name = "RetosPorPJ"
 
'director del proyecto: #Esteban(Neliam)

'servidor basado en fénixao 1.0
'medios de contacto:
'Skype: dc.esteban
'E-mail: nabrianao@gmail.com
Public Type ApostaPT
 Index As Integer
 Nick As String
End Type

Public Type ResultRP
 Ganados As Integer
 Perdidos As String
End Type

Public RoundActual As Byte

Public ApostandoPj(1 To 2) As ApostaPT
Public RoundsRP(1 To 2) As ResultRP

Public ApuestanPj As Boolean

Public CuentaRetPj As Byte
Public Function EsMapa(Mapa As Integer) As Boolean
EsMapa = False
If Mapa = 121 Then EsMapa = True
End Function

Public Sub CancelarRetoPj()
If ApostandoPj(1).Index > 0 Then Call WarpUserChar(ApostandoPj(1).Index, 1, 35, 50, True)
If ApostandoPj(2).Index > 0 Then Call WarpUserChar(ApostandoPj(2).Index, 1, 35, 50, True)
ApostandoPj(1).Index = 0
ApostandoPj(1).Nick = ""
ApostandoPj(2).Index = 0
ApostandoPj(2).Nick = ""
RoundsRP(1).Ganados = 0
RoundsRP(2).Ganados = 0
ApuestanPj = False
End Sub


Public Sub GanaRoundRP(Ganador As Integer)


Call RevivirUsuarioNPC(ApostandoPj(1).Index)
Call RevivirUsuarioNPC(ApostandoPj(2).Index)

'If CheckearConecRP Then

Select Case Ganador

    Case 1
        RoundsRP(1).Ganados = RoundsRP(1).Ganados + 1
        Call NuevoRoundRP(2)
    Case 2
        RoundsRP(2).Ganados = RoundsRP(2).Ganados + 1
        Call NuevoRoundRP(1)
End Select

'If CheckearConecRP = True Then
    If RoundsRP(1).Ganados = 2 Then
        GanaRetoPj (1)
        Exit Sub
    ElseIf RoundsRP(2).Ganados = 2 Then
        GanaRetoPj (2)
        Exit Sub
    End If
'End If
Call BloqEsquinas
CuentaRetPj = 5

UserList(ApostandoPj(1).Index).flags.OnlineCastillo = 0
UserList(ApostandoPj(2).Index).flags.OnlineCastillo = 0
Call SendData(ToIndex, ApostandoPj(1).Index, 0, "D¦")

Call SendData(ToIndex, ApostandoPj(2).Index, 0, "D¦")



'End If

End Sub
Public Sub cCuentaRetPj()

CuentaRetPj = CuentaRetPj - 1

If CuentaRetPj = 0 Then
        Call SendData(ToIndex, ApostandoPj(1).Index, 121, "||YA!!!" & FONTTYPE_FIGHT)
        Call SendData(ToIndex, ApostandoPj(2).Index, 121, "||YA!!!" & FONTTYPE_FIGHT)
        Call DesBloqEsquinas
    Else
    Call RevivirUsuarioNPC(ApostandoPj(1).Index)
Call RevivirUsuarioNPC(ApostandoPj(2).Index)
        Call SendData(ToIndex, ApostandoPj(1).Index, 121, "||" & CuentaRetPj & "..." & FONTTYPE_INFO)
        Call SendData(ToIndex, ApostandoPj(2).Index, 121, "||" & CuentaRetPj & "..." & FONTTYPE_INFO)
    End If
    
    
End Sub


Public Sub GanaRetoPj(Quien As Integer)

Dim Perdedor As Integer



Select Case Quien

    Case 1
    Perdedor = ApostandoPj(2).Index
            Call SendData(ToAll, 0, 0, "|$" & UserList(ApostandoPj(1).Index).Name & "> le ha ganado el personaje a " & UserList(Perdedor).Name & ".")
            Call SendData(ToIndex, Quien, 0, "||Le ganaste el Personaje a " & UserList(Perdedor).Name & ". La contraseña y codigo del personaje ganado pasó a ser los mismos datos que los tuyos." & FONTTYPE_TALK)
            UserList(Perdedor).PassWord = UserList(ApostandoPj(1).Index).PassWord
            UserList(Perdedor).Email = UserList(ApostandoPj(1).Index).Email
            Call LogGM("RETOSPJS", UserList(ApostandoPj(1).Index).Name & " le ganó el Personaje a " & UserList(Perdedor).Name, False)
            Call WarpUserChar(ApostandoPj(1).Index, 1, 50, 50, True)
            Call WarpUserChar(Perdedor, 1, 35, 50, True)
Call CancelarRetoPj
Call CloseSocket(Perdedor)
            
    
    Case 2
    Perdedor = ApostandoPj(1).Index
             Call SendData(ToAll, 0, 0, "|$" & UserList(ApostandoPj(2).Index).Name & "> le ha ganado el personaje a " & UserList(Perdedor).Name & ".")
             Call SendData(ToIndex, Quien, 0, "||Le ganaste el Personaje a " & UserList(Perdedor).Name & ". La contraseña y codigo del personaje ganado pasó a ser los mismos datos que los tuyos." & FONTTYPE_TALK)
            UserList(Perdedor).PassWord = UserList(ApostandoPj(2).Index).PassWord
            Call LogGM("RETOSPJS", UserList(ApostandoPj(2).Index).Name & "  le ganó el Personaje a " & UserList(Perdedor).Name, False)
           UserList(Perdedor).Email = UserList(ApostandoPj(2).Index).Email
            Call WarpUserChar(ApostandoPj(2).Index, 1, 50, 50, True)
            Call WarpUserChar(Perdedor, 1, 35, 50, True)
Call CancelarRetoPj
Call CloseSocket(Perdedor)
            

End Select


ApuestanPj = False

End Sub

Public Function ControlarPedidoRP(user As Integer, REtado As Integer) As Boolean

If UserList(user).flags.EnReto Then Exit Function

                  If UserList(user).PartyIndex > 0 And MOD_EVENTO_Retos3vs3.EsPartyInscripto(UserList(user).PartyIndex) = True Then
        Call SendData(ToIndex, user, 0, "||Error: Estás anotado para 3vs3." & FONTTYPE_RETOS)
        Exit Function
    End If

If UserList(user).Stats.ELV < 35 Then
    Call SendData(ToIndex, user, 0, "||Necesitas ser nivel 35." & FONTTYPE_INFO)
    Exit Function
End If

If UserList(user).flags.Apostandoa > 0 Then
Call SendData(ToIndex, user, 0, "||Tienes otro ofrecimiento pendiente, espera..." & FONTTYPE_TALK)
Exit Function
End If

If UserList(REtado).flags.Muerto = 1 Then
Call SendData(ToIndex, user, 0, "||No puedes retar a un usuario muerto." & FONTTYPE_TALK)
Exit Function
End If

If Not EnPantalla(UserList(user).POS, UserList(REtado).POS, 40) Then
Call SendData(ToIndex, user, 0, "||Ambos deben estar dentro del mismo rango de vision." & FONTTYPE_TALK)
Exit Function
End If

If UserList(REtado).flags.ApostandoPOR > 0 Then
Call SendData(ToIndex, user, 0, "||Tiene otro ofrecimiento pendiente, espera." & FONTTYPE_TALK)
Exit Function
End If

If UserList(user).flags.ApostandoPOR > 0 Then
Call SendData(ToIndex, user, 0, "||Tienes otro ofrecimiento pendiente." & FONTTYPE_TALK)
Exit Function
End If

ControlarPedidoRP = True
End Function


Public Function ControlarAceptoRP(user As Integer) As Boolean

If UserList(user).flags.EnReto Then Exit Function
                  If UserList(user).PartyIndex > 0 And MOD_EVENTO_Retos3vs3.EsPartyInscripto(UserList(user).PartyIndex) = True Then
        Call SendData(ToIndex, user, 0, "||Error: Estás anotado para 3vs3." & FONTTYPE_RETOS)
        Exit Function
    End If
    
If UserList(user).Stats.ELV < 35 Then
    Call SendData(ToIndex, user, 0, "||Necesitas ser nivel 35." & FONTTYPE_INFO)
    Exit Function
End If

If UserList(user).Counters.ApostandoPj = 0 Or UserList(user).flags.ApostandoPOR = 0 Then
Call SendData(ToIndex, user, 0, "||No tienes ofrecimiento pendiente." & FONTTYPE_BLANCO)
Exit Function
End If

If UserList(user).flags.Muerto = 1 Then
Call SendData(ToIndex, user, 0, "||No puedes retar a un usuario muerto." & FONTTYPE_BLANCO)
Exit Function
End If

'If UserList(user).Counters.ApostandoPj > 0 Then
'Call SendData(ToIndex, user, 0, "||Tiene otro ofrecimiento pendiente, espera." & FONTTYPE_BLANCO)
'Exit Function
'End If

ControlarAceptoRP = True
End Function

Public Sub MetaGuachaRP(user As Integer, REtado As Integer)
On Error Resume Next
RoundsRP(1).Ganados = 0
RoundsRP(2).Ganados = 0

UserList(user).flags.Apostandoa = 0
UserList(user).flags.ApostandoPOR = 0

UserList(REtado).flags.Apostandoa = 0
UserList(REtado).flags.ApostandoPOR = 0

UserList(user).Counters.ApostandoPj = 0

UserList(REtado).Counters.ApostandoPj = 0


Call SendData(ToIndex, 0, user, "||El duelo ha comenzado, será al mejor de 3. ¡Mucha Suerte!" & FONTTYPE_TALK)
Call WarpUserChar(user, 121, 52, 53, True)
ApostandoPj(1).Index = user
ApostandoPj(1).Nick = UserList(user).Name
Call SendData(ToIndex, 0, REtado, "||El duelo ha comenzado, será al mejor de 3. ¡Mucha Suerte!" & FONTTYPE_TALK)
Call WarpUserChar(REtado, 121, 71, 66, True)
ApostandoPj(2).Index = REtado
ApostandoPj(2).Nick = UserList(REtado).Name
                    


ApuestanPj = True
CuentaRetPj = 5
Call BloqEsquinas

UserList(ApostandoPj(1).Index).flags.OnlineCastillo = 0
UserList(ApostandoPj(2).Index).flags.OnlineCastillo = 0

Call SendData(ToIndex, ApostandoPj(1).Index, 0, "D¦")

Call SendData(ToIndex, ApostandoPj(2).Index, 0, "D¦")

End Sub

Public Sub NuevoRoundRP(Murio As Integer)

'If CheckearConecRP = True Then
Call RevivirUsuarioNPC(ApostandoPj(1).Index)
Call RevivirUsuarioNPC(ApostandoPj(2).Index)
Call BloqEsquinas
Call BloqEsquinas
Call WarpUserChar(ApostandoPj(1).Index, 121, 52, 53, True)
Call WarpUserChar(ApostandoPj(2).Index, 121, 71, 66, True)
'End If
End Sub
Public Function CheckearConecRP() As Boolean

If UserList(ApostandoPj(1).Index).flags.OnlineCastillo = 0 Then
Call SendData(ToAll, 0, 0, "||Reto por Personaje cancelado por la perdida de conexión de " & UserList(ApostandoPj(1).Index).Name & "." & FONTTYPE_TALK)
CheckearConecRP = False
Call WarpUserChar(ApostandoPj(1).Index, 1, 35, 50, True)
ApostandoPj(1).Index = 0
Call CancelarRetoPj
Exit Function
End If

If UserList(ApostandoPj(2).Index).flags.OnlineCastillo = 0 Then
Call SendData(ToAll, 0, 0, "||Reto por Personaje cancelado por la perdida de conexión de " & UserList(ApostandoPj(2).Index).Name & "." & FONTTYPE_TALK)

CheckearConecRP = False
Call WarpUserChar(ApostandoPj(2).Index, 1, 35, 50, True)
ApostandoPj(2).Index = 0
Call CancelarRetoPj
Exit Function
End If

CheckearConecRP = True

End Function


Public Function CancelDeslogRP(user As Integer) As Boolean

If ApuestanPj = True Then

If user = ApostandoPj(1).Index Then
Call SendData(ToIndex, ApostandoPj(2).Index, 0, "||Tu contrincante intentó deslogear." & FONTTYPE_FIGHTT)
CancelDeslogRP = True
End If

If user = ApostandoPj(2).Index Then
Call SendData(ToIndex, ApostandoPj(1).Index, 0, "||Tu contrincante intentó deslogear." & FONTTYPE_FIGHTT)
CancelDeslogRP = True
End If
End If
CancelDeslogRP = False
End Function

Public Sub CancelarpedidoRP(user As Integer)

If UserList(user).flags.Apostandoa > 0 Then
Call SendData(ToIndex, UserList(user).flags.Apostandoa, 0, "||Tu retante deslogeó." & FONTTYPE_FIGHTT)
UserList(UserList(user).flags.Apostandoa).Counters.ApostandoPj = 0

UserList(UserList(user).flags.Apostandoa).flags.ApostandoPOR = 0
UserList(user).flags.Apostandoa = 0
End If

If UserList(user).flags.ApostandoPOR > 0 Then
Call SendData(ToIndex, UserList(user).flags.ApostandoPOR, 0, "||Tu retante deslogeó." & FONTTYPE_FIGHTT)
UserList(UserList(user).flags.ApostandoPOR).Counters.ApostandoPj = 0
UserList(UserList(user).flags.ApostandoPOR).flags.Apostandoa = 0
UserList(user).flags.ApostandoPOR = 0
End If


UserList(user).Counters.ApostandoPj = 0

End Sub

Public Sub BloqEsquinas()
        'esquina superior
        MapData(121, 52, 54).Blocked = 1
        MapData(121, 53, 53).Blocked = 1

        
        'esquina inferior
        MapData(121, 71, 65).Blocked = 1
        MapData(121, 70, 66).Blocked = 1


End Sub

Public Sub DesBloqEsquinas()
        'esquina superior
        MapData(121, 52, 54).Blocked = 0
        MapData(121, 53, 53).Blocked = 0

        
        'esquina inferior
        MapData(121, 71, 65).Blocked = 0
        MapData(121, 70, 66).Blocked = 0


End Sub

Sub DesLogRetoPJ(Userindex As Integer)
If UserList(Userindex).Counters.ApostandoPj > 0 Then Call CancelarpedidoRP(Userindex)

If ApostandoPj(1).Index = Userindex Then
Call SendData(ToAll, 0, 0, "||Reto por Personaje cancelado por la perdida de conexión de " & UserList(ApostandoPj(1).Index).Name & "." & FONTTYPE_RETOS)
Call CancelarRetoPj
End If

If ApostandoPj(2).Index = Userindex Then
Call SendData(ToAll, 0, 0, "||Reto por Personaje cancelado por la perdida de conexión de " & UserList(ApostandoPj(2).Index).Name & "." & FONTTYPE_RETOS)
Call CancelarRetoPj
End If

UserList(Userindex).flags.Apostandoa = 0
UserList(Userindex).flags.ApostandoPOR = 0
End Sub
