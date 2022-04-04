Attribute VB_Name = "Mod_retos"
 
'director del proyecto: #Esteban(Neliam)

'servidor basado en fénixao 1.0
'medios de contacto:
'Skype: dc.esteban
'E-mail: nabrianao@gmail.com
Option Explicit
 
Private Const RetoMap As Integer = 7 'Mapa de retos
 
Private Const X1 As Byte = 34
Private Const X2 As Byte = 52
Private Const X3 As Byte = 34
Private Const X4 As Byte = 49
Private Const X5 As Byte = 13
Private Const X6 As Byte = 31
Private Const X7 As Byte = 44
Private Const X8 As Byte = 63

Private Const Y1 As Byte = 66
Private Const Y2 As Byte = 76
Private Const Y3 As Byte = 46
Private Const Y4 As Byte = 54
Private Const Y5 As Byte = 23
Private Const Y6 As Byte = 36
Private Const Y7 As Byte = 22
Private Const Y8 As Byte = 32

Private Const X1x As Byte = 17
Private Const X2x As Byte = 18
Private Const X3x As Byte = 17
Private Const X4x As Byte = 18
Private Const X5x As Byte = 67
Private Const X6x As Byte = 68
Private Const X7x As Byte = 67
Private Const X8x As Byte = 68

Private Const Y1x As Byte = 47
Private Const Y2x As Byte = 47
Private Const Y3x As Byte = 59
Private Const Y4x As Byte = 59
Private Const Y5x As Byte = 44
Private Const Y6x As Byte = 44
Private Const Y7x As Byte = 55
Private Const Y8x As Byte = 55
 
Public Type ApostaPTd
 Index As Integer
 Nick As String
End Type

Public CuentaR(1 To 2) As ApostaPTd
Public CuentaR1(1 To 2) As ApostaPTd
Public CuentaR2(1 To 2) As ApostaPTd
Public CuentaR3(1 To 2) As ApostaPTd
Public CuentaDeReto As Byte
Public CuentaDeReto1 As Byte
Public CuentaDeReto2 As Byte
Public CuentaDeReto3 As Byte

Public CuentaRx(1 To 2) As ApostaPTd
Public CuentaR1x(1 To 2) As ApostaPTd
Public CuentaR2x(1 To 2) As ApostaPTd
Public CuentaR3x(1 To 2) As ApostaPTd
Public CuentaDeRetox As Byte
Public CuentaDeReto1x As Byte
Public CuentaDeReto2x As Byte
Public CuentaDeReto3x As Byte
 
Public Arena1 As Boolean
Public Arena2 As Boolean
Public Arena3 As Boolean
Public Arena4 As Boolean
Public ArenaPlante1 As Boolean
Public ArenaPlante2 As Boolean
Public ArenaPlante3 As Boolean
Public ArenaPlante4 As Boolean
Public Sub Retos(ByVal Peleador As Integer, ByVal Peleador2 As Integer, ByVal Apuesta As Long)

If Apuesta < 0 Then Exit Sub 'Por las dudas (cantidades negativas) ¬¬
If Peleador2 <= 0 Then
Call SendData(ToIndex, Peleador, 0, "||El oponente se encuentra offline" & FONTTYPE_INFO)
Exit Sub 'Checkea si está off (:
End If
 
 If UserList(Peleador).flags.ModoRetoPlante = 0 Then
 If salallena = 4 Then
 Call SendData(ToIndex, Peleador, 0, "||Las salas se encuetran llenas espera a que se desocupen." & FONTTYPE_INFO)
 Exit Sub
 End If
 End If
 
 If UserList(Peleador).flags.ModoRetoPlante = 1 Then
 If salallenaplante = 4 Then
 Call SendData(ToIndex, Peleador, 0, "||Las salas se encuetran llenas espera a que se desocupen." & FONTTYPE_INFO)
 Exit Sub
 End If
 End If
 
If UserList(Peleador).flags.RetoBUGA > 0 Then
Call SendData(ToIndex, Peleador, 0, "||Tienes otro ofrecimiento pendiente, espera." & FONTTYPE_BLANCO)
Exit Sub
End If

If UserList(Peleador2).flags.RetoBUGP > 0 Then
Call SendData(ToIndex, Peleador, 0, "||Tiene otro ofrecimiento pendiente, espera." & FONTTYPE_BLANCO)
Exit Sub
End If

If UserList(Peleador).flags.RetoBUGP > 0 Then
Call SendData(ToIndex, Peleador, 0, "||Tienes otro ofrecimiento pendiente." & FONTTYPE_BLANCO)
Exit Sub
End If

If Distancia(UserList(Peleador2).POS, UserList(Peleador).POS) > 4 Then
                Call SendData(ToIndex, Peleador, 0, "DL")
                Exit Sub
          End If
 
With UserList(Peleador)
    If Not .POS.Map = 160 Then Exit Sub 'Si no estás en ulla como mandás papa?
    If Peleador = Peleador2 Then Exit Sub 'No podes mandarte a vos mismo joputa
    If .flags.Muerto = 1 Then Exit Sub 'Como caca mandas un reto muerto? ESTAS MUERTO FLACO!
    If .flags.Retando = True Then Exit Sub 'Estas retando pedazo de imbecil
    .flags.CantidadR = Apuesta 'Guardo la apuesta del reto en un flag.
    If .Stats.GLD < Apuesta Then
Call SendData(ToIndex, Peleador, 0, "||No tienes la cantidad ingresaste." & FONTTYPE_INFO)
Exit Sub
End If
End With
 
With UserList(Peleador2)
    If Peleador2 <= 0 Then Exit Sub 'Checkea si está off (:
    If Not .POS.Map = 160 Then Exit Sub 'Mismo de arriba, me da paja ponerlo de vuelta, chau.
    If .Name = UserList(Peleador).Name Then Exit Sub
    If .flags.Retando = True Then Exit Sub
    .flags.CantidadR = Apuesta
End With
 
Call SendData(ToIndex, Peleador, 0, "||El usuario ha recibido la solicitud." & FONTTYPE_TALK) 'Le avisa que mandó asi el pelotudo no manda 94984198 veces.
Call SendData(ToIndex, Peleador2, 0, "||" & UserList(Peleador2).Name & " te mando un retó. tipeá /rechazo para cancelar." & FONTTYPE_TALK)
'Call SendData(ToIndex, Peleador2, 0, "||El usuario " & UserList(Peleador).Name & " quiere retar contigo por " & Apuesta & " puntos de canjeos, para aceptar tipeá /ACEPTO " & UserList(Peleador).Name & FONTTYPE_RETOS1vS1)
Rem manda la solicitud y le avisa al otro usuario, el otro usuario guarda que recibio una solicitud de el.

  Call SendData(ToIndex, Peleador2, 0, "MS" & UserList(Peleador).Name) 'MANDA NICK
    Call SendData(ToIndex, Peleador2, 0, "MI" & Apuesta) 'MANDA CANJES
    
            UserList(Peleador).flags.RetoBUGP = 0
            UserList(Peleador).flags.RetoBUGA = Peleador2
            UserList(Peleador).Counters.RetoBUG = Timer
            UserList(Peleador2).flags.RetoBUGP = Peleador
            UserList(Peleador).flags.RetoBUGP = Peleador2
            UserList(Peleador).Counters.RetoBUG = Timer
            UserList(Peleador2).Counters.RetoBUG = Timer
    
    UserList(Peleador2).flags.Recibio = Peleador
    UserList(Peleador).flags.Recibio = 0
    UserList(Peleador).flags.NoAceptasSinFlag = True
    UserList(Peleador2).flags.notesaleelbug = True
    UserList(Peleador).flags.notesaleelbug = True
    UserList(Peleador).flags.tampocoteSale = True
End Sub
 
Public Sub AceptarR(ByVal ElQueAcepta As Integer, ByVal Luchador As Integer)
 
If UserList(Luchador).flags.NoAceptasSinFlag = False Then
Call SendData(ToIndex, ElQueAcepta, 0, "||El usuario no te mando reto." & FONTTYPE_INFO)
Exit Sub
End If

If UserList(Luchador).POS.Map <> 160 Then
Call SendData(ToIndex, ElQueAcepta, 0, "||El usuario que te envio ya no esta en este mapa." & FONTTYPE_INFO)
Exit Sub
End If

  If UserList(ElQueAcepta).Counters.RetoBUG = 0 Or UserList(ElQueAcepta).flags.RetoBUGP = 0 Then
Call SendData(ToIndex, ElQueAcepta, 0, "||No tienes ofrecimiento pendiente." & FONTTYPE_BLANCO)
Exit Sub
End If

With UserList(ElQueAcepta)
    If .flags.Recibio <= 0 Then Exit Sub 'Andate a la concha de tu madre por tratar de bugear esto.
    If Not .flags.Recibio = Luchador Then Exit Sub 'Si no le acepta al que le mando que se muera
    If Not .POS.Map = 160 Then Exit Sub 'Si no está el ulla chupame el choto
    If .flags.Muerto = 1 Then Exit Sub 'Si estás muerto, jodete
    If .flags.Retando = True Then Exit Sub 'Si estás retando sos un hijo de puta.
    If .Name = UserList(Luchador).Name Then Exit Sub 'Por las dudas aunque lo checkié antes, uno nunca sabe, esto es AO ¬¬
    If .Stats.GLD < .flags.CantidadR Then
    Call SendData(ToIndex, ElQueAcepta, 0, "||No tienes suficientes puntos." & FONTTYPE_INFO)
    Exit Sub
    End If
End With
 
With UserList(Luchador)
    If Not .POS.Map = 160 Then Exit Sub 'No estas en ulla? Metete la espadita por el ano.
    If .flags.Retando = True Then Exit Sub 'Si estás retando sos un hijo de puta.
    If .Name = UserList(ElQueAcepta).Name Then Exit Sub 'Por las dudas aunque lo checkié antes, uno nunca sabe, esto es AO ¬¬
End With

Call SendData(ToMap, 0, 160, "||Reto> Se enfrenta " & UserList(Luchador).Name & " vs " & UserList(ElQueAcepta).Name & " en un reto por " & PonerPuntos(UserList(ElQueAcepta).flags.CantidadR) & " monedas de oro." & FONTTYPE_BLANKO)

Call BuscaArena(ElQueAcepta, Luchador) 'Mando a buscar si alguna arena está disponible.


End Sub

Public Sub BuscaArena(ByVal LuchadoR1 As Integer, ByVal luchadoR2 As Integer) 'Revisa las arenas para ver si están en uso.
 
 If UserList(LuchadoR1).flags.ModoRetoPlante = 0 Then
If Arena1 = False Then
salallena = salallena + 1

CuentaRx(1).Index = LuchadoR1
CuentaRx(1).Nick = UserList(LuchadoR1).Name
CuentaRx(2).Index = luchadoR2
CuentaRx(2).Nick = UserList(luchadoR2).Name

    Call WarpUserChar(luchadoR2, RetoMap, X1, Y1, False) 'Warp
    Call WarpUserChar(LuchadoR1, RetoMap, X2, Y2, False)
        Arena1 = True
            UserList(LuchadoR1).flags.Arena = 1
            UserList(luchadoR2).flags.Arena = 1
            UserList(LuchadoR1).Counters.RetoBUG = 0
            UserList(luchadoR2).Counters.RetoBUG = 0
            UserList(LuchadoR1).flags.RetandoCon = luchadoR2
            UserList(luchadoR2).flags.RetandoCon = LuchadoR1
            UserList(LuchadoR1).flags.Retando = True 'Asignamos la variable que estan retando
            UserList(luchadoR2).flags.Retando = True 'Asignamos la variable que estan retando
                            'Desequipamos al usuario
                            If UserList(LuchadoR1).flags.RetoSinCanje = 1 Then
If UserList(luchadoR2).Invent.ArmourEqpObjIndex Then Call Desequipar(luchadoR2, UserList(luchadoR2).Invent.ArmourEqpSlot)
If UserList(luchadoR2).Invent.WeaponEqpObjIndex Then Call Desequipar(luchadoR2, UserList(luchadoR2).Invent.WeaponEqpSlot)
If UserList(luchadoR2).Invent.EscudoEqpObjIndex Then Call Desequipar(luchadoR2, UserList(luchadoR2).Invent.EscudoEqpSlot)
If UserList(luchadoR2).Invent.CascoEqpObjIndex Then Call Desequipar(luchadoR2, UserList(luchadoR2).Invent.CascoEqpSlot)
If UserList(luchadoR2).Invent.HerramientaEqpObjIndex Then Call Desequipar(luchadoR2, UserList(luchadoR2).Invent.HerramientaEqpslot)
If UserList(luchadoR2).Invent.MunicionEqpObjIndex Then Call Desequipar(luchadoR2, UserList(luchadoR2).Invent.MunicionEqpSlot)
If UserList(LuchadoR1).Invent.ArmourEqpObjIndex Then Call Desequipar(LuchadoR1, UserList(LuchadoR1).Invent.ArmourEqpSlot)
If UserList(LuchadoR1).Invent.WeaponEqpObjIndex Then Call Desequipar(LuchadoR1, UserList(LuchadoR1).Invent.WeaponEqpSlot)
If UserList(LuchadoR1).Invent.EscudoEqpObjIndex Then Call Desequipar(LuchadoR1, UserList(LuchadoR1).Invent.EscudoEqpSlot)
If UserList(LuchadoR1).Invent.CascoEqpObjIndex Then Call Desequipar(LuchadoR1, UserList(LuchadoR1).Invent.CascoEqpSlot)
If UserList(LuchadoR1).Invent.HerramientaEqpObjIndex Then Call Desequipar(LuchadoR1, UserList(LuchadoR1).Invent.HerramientaEqpslot)
If UserList(LuchadoR1).Invent.MunicionEqpObjIndex Then Call Desequipar(LuchadoR1, UserList(LuchadoR1).Invent.MunicionEqpSlot)
                End If
                UserList(LuchadoR1).flags.Navegando = 1
                UserList(luchadoR2).flags.Navegando = 1
                CuentaDeRetox = 10
             'Desequipamos al usuario
Exit Sub
                            'Alto choclo hermano
ElseIf Arena1 = True And Arena2 = False Then
salallena = salallena + 1

CuentaR1x(1).Index = LuchadoR1
CuentaR1x(1).Nick = UserList(LuchadoR1).Name
CuentaR1x(2).Index = luchadoR2
CuentaR1x(2).Nick = UserList(luchadoR2).Name
    Call WarpUserChar(luchadoR2, RetoMap, X3, Y3, False)
    Call WarpUserChar(LuchadoR1, RetoMap, X4, Y4, False)
        Arena2 = True
            UserList(LuchadoR1).flags.Arena = 2
            UserList(luchadoR2).flags.Arena = 2
            UserList(LuchadoR1).Counters.RetoBUG = 0
            UserList(luchadoR2).Counters.RetoBUG = 0
            UserList(LuchadoR1).flags.Recibio = 0 'Se borra que recibió una solicitud de reto.
            UserList(LuchadoR1).flags.Retando = True 'Asignamos la variable que estan retando
            UserList(luchadoR2).flags.Retando = True 'Asignamos la variable que estan retando
            UserList(LuchadoR1).flags.RetandoCon = luchadoR2
            UserList(luchadoR2).flags.RetandoCon = LuchadoR1
                            'Desequipamos al usuario
                             If UserList(LuchadoR1).flags.RetoSinCanje = 1 Then
If UserList(luchadoR2).Invent.ArmourEqpObjIndex Then Call Desequipar(luchadoR2, UserList(luchadoR2).Invent.ArmourEqpSlot)
If UserList(luchadoR2).Invent.WeaponEqpObjIndex Then Call Desequipar(luchadoR2, UserList(luchadoR2).Invent.WeaponEqpSlot)
If UserList(luchadoR2).Invent.EscudoEqpObjIndex Then Call Desequipar(luchadoR2, UserList(luchadoR2).Invent.EscudoEqpSlot)
If UserList(luchadoR2).Invent.CascoEqpObjIndex Then Call Desequipar(luchadoR2, UserList(luchadoR2).Invent.CascoEqpSlot)
If UserList(luchadoR2).Invent.HerramientaEqpObjIndex Then Call Desequipar(luchadoR2, UserList(luchadoR2).Invent.HerramientaEqpslot)
If UserList(luchadoR2).Invent.MunicionEqpObjIndex Then Call Desequipar(luchadoR2, UserList(luchadoR2).Invent.MunicionEqpSlot)
If UserList(LuchadoR1).Invent.ArmourEqpObjIndex Then Call Desequipar(LuchadoR1, UserList(LuchadoR1).Invent.ArmourEqpSlot)
If UserList(LuchadoR1).Invent.WeaponEqpObjIndex Then Call Desequipar(LuchadoR1, UserList(LuchadoR1).Invent.WeaponEqpSlot)
If UserList(LuchadoR1).Invent.EscudoEqpObjIndex Then Call Desequipar(LuchadoR1, UserList(LuchadoR1).Invent.EscudoEqpSlot)
If UserList(LuchadoR1).Invent.CascoEqpObjIndex Then Call Desequipar(LuchadoR1, UserList(LuchadoR1).Invent.CascoEqpSlot)
If UserList(LuchadoR1).Invent.HerramientaEqpObjIndex Then Call Desequipar(LuchadoR1, UserList(LuchadoR1).Invent.HerramientaEqpslot)
If UserList(LuchadoR1).Invent.MunicionEqpObjIndex Then Call Desequipar(LuchadoR1, UserList(LuchadoR1).Invent.MunicionEqpSlot)
             End If
             UserList(LuchadoR1).flags.Navegando = 1
             UserList(luchadoR2).flags.Navegando = 1
             CuentaDeReto1x = 10
             'Desequipamos al usuario
Exit Sub
                   'Alto choclo hermano
ElseIf Arena1 = True And Arena2 = True And Arena3 = False Then
salallena = salallena + 1

CuentaR2x(1).Index = LuchadoR1
CuentaR2x(1).Nick = UserList(LuchadoR1).Name
CuentaR2x(2).Index = luchadoR2
CuentaR2x(2).Nick = UserList(luchadoR2).Name
    Call WarpUserChar(luchadoR2, RetoMap, X5, Y5, False)
    Call WarpUserChar(LuchadoR1, RetoMap, X6, Y6, False)
        Arena3 = True
            UserList(LuchadoR1).flags.Arena = 3
            UserList(luchadoR2).flags.Arena = 3
            UserList(LuchadoR1).Counters.RetoBUG = 0
            UserList(luchadoR2).Counters.RetoBUG = 0
            UserList(LuchadoR1).flags.Recibio = 0 'Se borra que recibió una solicitud de reto.
            UserList(LuchadoR1).flags.Retando = True 'Asignamos la variable que estan retando
            UserList(luchadoR2).flags.Retando = True 'Asignamos la variable que estan retando
            UserList(LuchadoR1).flags.RetandoCon = luchadoR2
            UserList(luchadoR2).flags.RetandoCon = LuchadoR1
                            'Desequipamos al usuario
                             If UserList(LuchadoR1).flags.RetoSinCanje = 1 Then
If UserList(luchadoR2).Invent.ArmourEqpObjIndex Then Call Desequipar(luchadoR2, UserList(luchadoR2).Invent.ArmourEqpSlot)
If UserList(luchadoR2).Invent.WeaponEqpObjIndex Then Call Desequipar(luchadoR2, UserList(luchadoR2).Invent.WeaponEqpSlot)
If UserList(luchadoR2).Invent.EscudoEqpObjIndex Then Call Desequipar(luchadoR2, UserList(luchadoR2).Invent.EscudoEqpSlot)
If UserList(luchadoR2).Invent.CascoEqpObjIndex Then Call Desequipar(luchadoR2, UserList(luchadoR2).Invent.CascoEqpSlot)
If UserList(luchadoR2).Invent.HerramientaEqpObjIndex Then Call Desequipar(luchadoR2, UserList(luchadoR2).Invent.HerramientaEqpslot)
If UserList(luchadoR2).Invent.MunicionEqpObjIndex Then Call Desequipar(luchadoR2, UserList(luchadoR2).Invent.MunicionEqpSlot)
If UserList(LuchadoR1).Invent.ArmourEqpObjIndex Then Call Desequipar(LuchadoR1, UserList(LuchadoR1).Invent.ArmourEqpSlot)
If UserList(LuchadoR1).Invent.WeaponEqpObjIndex Then Call Desequipar(LuchadoR1, UserList(LuchadoR1).Invent.WeaponEqpSlot)
If UserList(LuchadoR1).Invent.EscudoEqpObjIndex Then Call Desequipar(LuchadoR1, UserList(LuchadoR1).Invent.EscudoEqpSlot)
If UserList(LuchadoR1).Invent.CascoEqpObjIndex Then Call Desequipar(LuchadoR1, UserList(LuchadoR1).Invent.CascoEqpSlot)
If UserList(LuchadoR1).Invent.HerramientaEqpObjIndex Then Call Desequipar(LuchadoR1, UserList(LuchadoR1).Invent.HerramientaEqpslot)
If UserList(LuchadoR1).Invent.MunicionEqpObjIndex Then Call Desequipar(LuchadoR1, UserList(LuchadoR1).Invent.MunicionEqpSlot)
             End If
             UserList(LuchadoR1).flags.Navegando = 1
             UserList(luchadoR2).flags.Navegando = 1
             CuentaDeReto2x = 10
             'Desequipamos al usuario
Exit Sub
                            'Alto choclo hermano
ElseIf Arena1 = True And Arena2 = True And Arena3 = True And Arena4 = False Then
salallena = salallena + 1

CuentaR3x(1).Index = LuchadoR1
CuentaR3x(1).Nick = UserList(LuchadoR1).Name
CuentaR3x(2).Index = luchadoR2
CuentaR3x(2).Nick = UserList(luchadoR2).Name
    Call WarpUserChar(luchadoR2, RetoMap, X7, Y7, False)
    Call WarpUserChar(LuchadoR1, RetoMap, X8, Y8, False)
        Arena4 = True
            UserList(LuchadoR1).flags.Arena = 4
            UserList(luchadoR2).flags.Arena = 4
            UserList(LuchadoR1).Counters.RetoBUG = 0
            UserList(luchadoR2).Counters.RetoBUG = 0
            UserList(LuchadoR1).flags.Recibio = 0 'Se borra que recibió una solicitud de reto.
                UserList(LuchadoR1).flags.RetandoCon = luchadoR2
                UserList(luchadoR2).flags.RetandoCon = LuchadoR1
                UserList(LuchadoR1).flags.Retando = True 'Asignamos la variable que estan retando
                UserList(luchadoR2).flags.Retando = True 'Asignamos la variable que estan retando
                'Desequipamos al usuario
                 If UserList(LuchadoR1).flags.RetoSinCanje = 1 Then
If UserList(luchadoR2).Invent.ArmourEqpObjIndex Then Call Desequipar(luchadoR2, UserList(luchadoR2).Invent.ArmourEqpSlot)
If UserList(luchadoR2).Invent.WeaponEqpObjIndex Then Call Desequipar(luchadoR2, UserList(luchadoR2).Invent.WeaponEqpSlot)
If UserList(luchadoR2).Invent.EscudoEqpObjIndex Then Call Desequipar(luchadoR2, UserList(luchadoR2).Invent.EscudoEqpSlot)
If UserList(luchadoR2).Invent.CascoEqpObjIndex Then Call Desequipar(luchadoR2, UserList(luchadoR2).Invent.CascoEqpSlot)
If UserList(luchadoR2).Invent.HerramientaEqpObjIndex Then Call Desequipar(luchadoR2, UserList(luchadoR2).Invent.HerramientaEqpslot)
If UserList(luchadoR2).Invent.MunicionEqpObjIndex Then Call Desequipar(luchadoR2, UserList(luchadoR2).Invent.MunicionEqpSlot)
If UserList(LuchadoR1).Invent.ArmourEqpObjIndex Then Call Desequipar(LuchadoR1, UserList(LuchadoR1).Invent.ArmourEqpSlot)
If UserList(LuchadoR1).Invent.WeaponEqpObjIndex Then Call Desequipar(LuchadoR1, UserList(LuchadoR1).Invent.WeaponEqpSlot)
If UserList(LuchadoR1).Invent.EscudoEqpObjIndex Then Call Desequipar(LuchadoR1, UserList(LuchadoR1).Invent.EscudoEqpSlot)
If UserList(LuchadoR1).Invent.CascoEqpObjIndex Then Call Desequipar(LuchadoR1, UserList(LuchadoR1).Invent.CascoEqpSlot)
If UserList(LuchadoR1).Invent.HerramientaEqpObjIndex Then Call Desequipar(LuchadoR1, UserList(LuchadoR1).Invent.HerramientaEqpslot)
If UserList(LuchadoR1).Invent.MunicionEqpObjIndex Then Call Desequipar(LuchadoR1, UserList(LuchadoR1).Invent.MunicionEqpSlot)
             End If
             UserList(LuchadoR1).flags.Navegando = 1
             UserList(luchadoR2).flags.Navegando = 1
             CuentaDeReto3x = 10
             'Desequipamos al usuario
Exit Sub
End If
End If


If UserList(LuchadoR1).flags.ModoRetoPlante = 1 Then

If ArenaPlante1 = False Then
salallenaplante = salallenaplante + 1
CuentaR(1).Index = LuchadoR1
CuentaR(1).Nick = UserList(LuchadoR1).Name
CuentaR(2).Index = luchadoR2
CuentaR(2).Nick = UserList(luchadoR2).Name

    Call WarpUserChar(luchadoR2, RetoMap, X1x, Y1x, False) 'Warp
    Call WarpUserChar(LuchadoR1, RetoMap, X2x, Y2x, False)
        ArenaPlante1 = True
            UserList(LuchadoR1).flags.Arenaplante = 1
            UserList(luchadoR2).flags.Arenaplante = 1
            UserList(LuchadoR1).Counters.RetoBUG = 0
            UserList(luchadoR2).Counters.RetoBUG = 0
            UserList(LuchadoR1).flags.Recibio = 0 'Se borra que recibió una solicitud de reto.
            UserList(LuchadoR1).flags.RetandoCon = luchadoR2
            UserList(luchadoR2).flags.RetandoCon = LuchadoR1
            UserList(LuchadoR1).flags.Retando = True 'Asignamos la variable que estan retando
            UserList(luchadoR2).flags.Retando = True 'Asignamos la variable que estan retando
                            'Desequipamos al usuario
                            If UserList(LuchadoR1).flags.RetoSinCanje = 1 Then
If UserList(luchadoR2).Invent.ArmourEqpObjIndex Then Call Desequipar(luchadoR2, UserList(luchadoR2).Invent.ArmourEqpSlot)
If UserList(luchadoR2).Invent.WeaponEqpObjIndex Then Call Desequipar(luchadoR2, UserList(luchadoR2).Invent.WeaponEqpSlot)
If UserList(luchadoR2).Invent.EscudoEqpObjIndex Then Call Desequipar(luchadoR2, UserList(luchadoR2).Invent.EscudoEqpSlot)
If UserList(luchadoR2).Invent.CascoEqpObjIndex Then Call Desequipar(luchadoR2, UserList(luchadoR2).Invent.CascoEqpSlot)
If UserList(luchadoR2).Invent.HerramientaEqpObjIndex Then Call Desequipar(luchadoR2, UserList(luchadoR2).Invent.HerramientaEqpslot)
If UserList(luchadoR2).Invent.MunicionEqpObjIndex Then Call Desequipar(luchadoR2, UserList(luchadoR2).Invent.MunicionEqpSlot)
If UserList(LuchadoR1).Invent.ArmourEqpObjIndex Then Call Desequipar(LuchadoR1, UserList(LuchadoR1).Invent.ArmourEqpSlot)
If UserList(LuchadoR1).Invent.WeaponEqpObjIndex Then Call Desequipar(LuchadoR1, UserList(LuchadoR1).Invent.WeaponEqpSlot)
If UserList(LuchadoR1).Invent.EscudoEqpObjIndex Then Call Desequipar(LuchadoR1, UserList(LuchadoR1).Invent.EscudoEqpSlot)
If UserList(LuchadoR1).Invent.CascoEqpObjIndex Then Call Desequipar(LuchadoR1, UserList(LuchadoR1).Invent.CascoEqpSlot)
If UserList(LuchadoR1).Invent.HerramientaEqpObjIndex Then Call Desequipar(LuchadoR1, UserList(LuchadoR1).Invent.HerramientaEqpslot)
If UserList(LuchadoR1).Invent.MunicionEqpObjIndex Then Call Desequipar(LuchadoR1, UserList(LuchadoR1).Invent.MunicionEqpSlot)
                End If
             'Desequipamos al usuario
             UserList(LuchadoR1).flags.NoatacaPlante = 1
             UserList(luchadoR2).flags.NoatacaPlante = 1
             CuentaDeReto = 10
End If
Exit Sub
                            'Alto choclo hermano
ElseIf ArenaPlante1 = True And ArenaPlante2 = False Then
salallenaplante = salallenaplante + 1
CuentaR1(1).Index = LuchadoR1
CuentaR1(1).Nick = UserList(LuchadoR1).Name
CuentaR1(2).Index = luchadoR2
CuentaR1(2).Nick = UserList(luchadoR2).Name
    Call WarpUserChar(luchadoR2, RetoMap, X3x, Y3x, False)
    Call WarpUserChar(LuchadoR1, RetoMap, X4x, Y4x, False)
        ArenaPlante2 = True
            UserList(LuchadoR1).flags.Arenaplante = 2
            UserList(luchadoR2).flags.Arenaplante = 2
            UserList(LuchadoR1).Counters.RetoBUG = 0
            UserList(luchadoR2).Counters.RetoBUG = 0
            UserList(LuchadoR1).flags.Recibio = 0 'Se borra que recibió una solicitud de reto.
            UserList(LuchadoR1).flags.Retando = True 'Asignamos la variable que estan retando
            UserList(luchadoR2).flags.Retando = True 'Asignamos la variable que estan retando
            UserList(LuchadoR1).flags.RetandoCon = luchadoR2
            UserList(luchadoR2).flags.RetandoCon = LuchadoR1
                            'Desequipamos al usuario
                             If UserList(LuchadoR1).flags.RetoSinCanje = 1 Then
If UserList(luchadoR2).Invent.ArmourEqpObjIndex Then Call Desequipar(luchadoR2, UserList(luchadoR2).Invent.ArmourEqpSlot)
If UserList(luchadoR2).Invent.WeaponEqpObjIndex Then Call Desequipar(luchadoR2, UserList(luchadoR2).Invent.WeaponEqpSlot)
If UserList(luchadoR2).Invent.EscudoEqpObjIndex Then Call Desequipar(luchadoR2, UserList(luchadoR2).Invent.EscudoEqpSlot)
If UserList(luchadoR2).Invent.CascoEqpObjIndex Then Call Desequipar(luchadoR2, UserList(luchadoR2).Invent.CascoEqpSlot)
If UserList(luchadoR2).Invent.HerramientaEqpObjIndex Then Call Desequipar(luchadoR2, UserList(luchadoR2).Invent.HerramientaEqpslot)
If UserList(luchadoR2).Invent.MunicionEqpObjIndex Then Call Desequipar(luchadoR2, UserList(luchadoR2).Invent.MunicionEqpSlot)
If UserList(LuchadoR1).Invent.ArmourEqpObjIndex Then Call Desequipar(LuchadoR1, UserList(LuchadoR1).Invent.ArmourEqpSlot)
If UserList(LuchadoR1).Invent.WeaponEqpObjIndex Then Call Desequipar(LuchadoR1, UserList(LuchadoR1).Invent.WeaponEqpSlot)
If UserList(LuchadoR1).Invent.EscudoEqpObjIndex Then Call Desequipar(LuchadoR1, UserList(LuchadoR1).Invent.EscudoEqpSlot)
If UserList(LuchadoR1).Invent.CascoEqpObjIndex Then Call Desequipar(LuchadoR1, UserList(LuchadoR1).Invent.CascoEqpSlot)
If UserList(LuchadoR1).Invent.HerramientaEqpObjIndex Then Call Desequipar(LuchadoR1, UserList(LuchadoR1).Invent.HerramientaEqpslot)
If UserList(LuchadoR1).Invent.MunicionEqpObjIndex Then Call Desequipar(LuchadoR1, UserList(LuchadoR1).Invent.MunicionEqpSlot)
             End If
             'Desequipamos al usuario
             UserList(LuchadoR1).flags.NoatacaPlante = 1
             UserList(luchadoR2).flags.NoatacaPlante = 1
                          CuentaDeReto1 = 10
Exit Sub
                   'Alto choclo hermano
ElseIf ArenaPlante1 = True And ArenaPlante2 = True And ArenaPlante3 = False Then
salallenaplante = salallenaplante + 1
CuentaR2(1).Index = LuchadoR1
CuentaR2(1).Nick = UserList(LuchadoR1).Name
CuentaR2(2).Index = luchadoR2
CuentaR2(2).Nick = UserList(luchadoR2).Name
    Call WarpUserChar(luchadoR2, RetoMap, X5x, Y5x, False)
    Call WarpUserChar(LuchadoR1, RetoMap, X6x, Y6x, False)
        ArenaPlante3 = True
            UserList(LuchadoR1).flags.Arenaplante = 3
            UserList(luchadoR2).flags.Arenaplante = 3
            UserList(LuchadoR1).Counters.RetoBUG = 0
            UserList(luchadoR2).Counters.RetoBUG = 0
            UserList(LuchadoR1).flags.Recibio = 0 'Se borra que recibió una solicitud de reto.
            UserList(LuchadoR1).flags.Retando = True 'Asignamos la variable que estan retando
            UserList(luchadoR2).flags.Retando = True 'Asignamos la variable que estan retando
            UserList(LuchadoR1).flags.RetandoCon = luchadoR2
            UserList(luchadoR2).flags.RetandoCon = LuchadoR1
                            'Desequipamos al usuario
                             If UserList(LuchadoR1).flags.RetoSinCanje = 1 Then
If UserList(luchadoR2).Invent.ArmourEqpObjIndex Then Call Desequipar(luchadoR2, UserList(luchadoR2).Invent.ArmourEqpSlot)
If UserList(luchadoR2).Invent.WeaponEqpObjIndex Then Call Desequipar(luchadoR2, UserList(luchadoR2).Invent.WeaponEqpSlot)
If UserList(luchadoR2).Invent.EscudoEqpObjIndex Then Call Desequipar(luchadoR2, UserList(luchadoR2).Invent.EscudoEqpSlot)
If UserList(luchadoR2).Invent.CascoEqpObjIndex Then Call Desequipar(luchadoR2, UserList(luchadoR2).Invent.CascoEqpSlot)
If UserList(luchadoR2).Invent.HerramientaEqpObjIndex Then Call Desequipar(luchadoR2, UserList(luchadoR2).Invent.HerramientaEqpslot)
If UserList(luchadoR2).Invent.MunicionEqpObjIndex Then Call Desequipar(luchadoR2, UserList(luchadoR2).Invent.MunicionEqpSlot)
If UserList(LuchadoR1).Invent.ArmourEqpObjIndex Then Call Desequipar(LuchadoR1, UserList(LuchadoR1).Invent.ArmourEqpSlot)
If UserList(LuchadoR1).Invent.WeaponEqpObjIndex Then Call Desequipar(LuchadoR1, UserList(LuchadoR1).Invent.WeaponEqpSlot)
If UserList(LuchadoR1).Invent.EscudoEqpObjIndex Then Call Desequipar(LuchadoR1, UserList(LuchadoR1).Invent.EscudoEqpSlot)
If UserList(LuchadoR1).Invent.CascoEqpObjIndex Then Call Desequipar(LuchadoR1, UserList(LuchadoR1).Invent.CascoEqpSlot)
If UserList(LuchadoR1).Invent.HerramientaEqpObjIndex Then Call Desequipar(LuchadoR1, UserList(LuchadoR1).Invent.HerramientaEqpslot)
If UserList(LuchadoR1).Invent.MunicionEqpObjIndex Then Call Desequipar(LuchadoR1, UserList(LuchadoR1).Invent.MunicionEqpSlot)
             End If
             'Desequipamos al usuario
             UserList(LuchadoR1).flags.NoatacaPlante = 1
             UserList(luchadoR2).flags.NoatacaPlante = 1
                          CuentaDeReto2 = 10
Exit Sub
                            'Alto choclo hermano
ElseIf ArenaPlante1 = True And ArenaPlante2 = True And ArenaPlante3 = True And ArenaPlante4 = False Then
salallenaplante = salallenaplante + 1
CuentaR3(1).Index = LuchadoR1
CuentaR3(1).Nick = UserList(LuchadoR1).Name
CuentaR3(2).Index = luchadoR2
CuentaR3(2).Nick = UserList(luchadoR2).Name
    Call WarpUserChar(luchadoR2, RetoMap, X7x, Y7x, False)
    Call WarpUserChar(LuchadoR1, RetoMap, X8x, Y8x, False)
        ArenaPlante4 = True
            UserList(LuchadoR1).flags.Arenaplante = 4
            UserList(luchadoR2).flags.Arenaplante = 4
            UserList(LuchadoR1).Counters.RetoBUG = 0
            UserList(luchadoR2).Counters.RetoBUG = 0
            UserList(LuchadoR1).flags.Recibio = 0 'Se borra que recibió una solicitud de reto.
                UserList(LuchadoR1).flags.RetandoCon = luchadoR2
                UserList(luchadoR2).flags.RetandoCon = LuchadoR1
                UserList(LuchadoR1).flags.Retando = True 'Asignamos la variable que estan retando
                UserList(luchadoR2).flags.Retando = True 'Asignamos la variable que estan retando
                'Desequipamos al usuario
                 If UserList(LuchadoR1).flags.RetoSinCanje = 1 Then
If UserList(luchadoR2).Invent.ArmourEqpObjIndex Then Call Desequipar(luchadoR2, UserList(luchadoR2).Invent.ArmourEqpSlot)
If UserList(luchadoR2).Invent.WeaponEqpObjIndex Then Call Desequipar(luchadoR2, UserList(luchadoR2).Invent.WeaponEqpSlot)
If UserList(luchadoR2).Invent.EscudoEqpObjIndex Then Call Desequipar(luchadoR2, UserList(luchadoR2).Invent.EscudoEqpSlot)
If UserList(luchadoR2).Invent.CascoEqpObjIndex Then Call Desequipar(luchadoR2, UserList(luchadoR2).Invent.CascoEqpSlot)
If UserList(luchadoR2).Invent.HerramientaEqpObjIndex Then Call Desequipar(luchadoR2, UserList(luchadoR2).Invent.HerramientaEqpslot)
If UserList(luchadoR2).Invent.MunicionEqpObjIndex Then Call Desequipar(luchadoR2, UserList(luchadoR2).Invent.MunicionEqpSlot)
If UserList(LuchadoR1).Invent.ArmourEqpObjIndex Then Call Desequipar(LuchadoR1, UserList(LuchadoR1).Invent.ArmourEqpSlot)
If UserList(LuchadoR1).Invent.WeaponEqpObjIndex Then Call Desequipar(LuchadoR1, UserList(LuchadoR1).Invent.WeaponEqpSlot)
If UserList(LuchadoR1).Invent.EscudoEqpObjIndex Then Call Desequipar(LuchadoR1, UserList(LuchadoR1).Invent.EscudoEqpSlot)
If UserList(LuchadoR1).Invent.CascoEqpObjIndex Then Call Desequipar(LuchadoR1, UserList(LuchadoR1).Invent.CascoEqpSlot)
If UserList(LuchadoR1).Invent.HerramientaEqpObjIndex Then Call Desequipar(LuchadoR1, UserList(LuchadoR1).Invent.HerramientaEqpslot)
If UserList(LuchadoR1).Invent.MunicionEqpObjIndex Then Call Desequipar(LuchadoR1, UserList(LuchadoR1).Invent.MunicionEqpSlot)
             End If
             'Desequipamos al usuario
             UserList(LuchadoR1).flags.NoatacaPlante = 1
             UserList(luchadoR2).flags.NoatacaPlante = 1
                          CuentaDeReto3 = 10
Exit Sub
End If

End Sub
 
Public Sub TerminoReto(ByVal Morido As Integer) 'Este sub sirve ya sea por desconexión o por haber ganado normalmente.
    Dim ElOtro As Integer
If UserList(Morido).flags.Retando = False Then Exit Sub 'Tomih.-
        ElOtro = UserList(Morido).flags.RetandoCon
    
    
  
 
    
    If UserList(Morido).flags.ModoRetoPlante = 0 Then
If UserList(Morido).flags.Arena = 1 And UserList(Morido).flags.Muerto = 1 Then
    Call WarpUserChar(Morido, RetoMap, 34, 66, True)
    Call WarpUserChar(ElOtro, RetoMap, 52, 76, True)

             UserList(Morido).flags.Navegando = 1
             UserList(ElOtro).flags.Navegando = 1
    UserList(ElOtro).flags.DueloGanado = UserList(ElOtro).flags.DueloGanado + 1
        If UserList(ElOtro).flags.DueloGanado = 1 Then Call RevivirUsuarioNPC(Morido)
        If UserList(ElOtro).flags.DueloGanado = 1 Then
             CuentaDeRetox = 10
        End If
End If
If UserList(Morido).flags.Arena = 2 And UserList(Morido).flags.Muerto = 1 Then
    Call WarpUserChar(Morido, RetoMap, 34, 46, True)
    Call WarpUserChar(ElOtro, RetoMap, 49, 54, True)

             UserList(Morido).flags.Navegando = 1
             UserList(ElOtro).flags.Navegando = 1
    UserList(ElOtro).flags.DueloGanado = UserList(ElOtro).flags.DueloGanado + 1
        If UserList(ElOtro).flags.DueloGanado = 1 Then Call RevivirUsuarioNPC(Morido)
        If UserList(ElOtro).flags.DueloGanado = 1 Then
             CuentaDeReto1x = 10
        End If
End If
If UserList(Morido).flags.Arena = 3 And UserList(Morido).flags.Muerto = 1 Then
    Call WarpUserChar(Morido, RetoMap, 13, 23, True)
    Call WarpUserChar(ElOtro, RetoMap, 31, 36, True)

             UserList(Morido).flags.Navegando = 1
             UserList(ElOtro).flags.Navegando = 1
    UserList(ElOtro).flags.DueloGanado = UserList(ElOtro).flags.DueloGanado + 1
        If UserList(ElOtro).flags.DueloGanado = 1 Then Call RevivirUsuarioNPC(Morido)
        If UserList(ElOtro).flags.DueloGanado = 1 Then
             CuentaDeReto2x = 10
        End If
End If
If UserList(Morido).flags.Arena = 4 And UserList(Morido).flags.Muerto = 1 Then
    Call WarpUserChar(Morido, RetoMap, 44, 22, True)
    Call WarpUserChar(ElOtro, RetoMap, 63, 32, True)

             UserList(Morido).flags.Navegando = 1
             UserList(ElOtro).flags.Navegando = 1
    UserList(ElOtro).flags.DueloGanado = UserList(ElOtro).flags.DueloGanado + 1
        If UserList(ElOtro).flags.DueloGanado = 1 Then Call RevivirUsuarioNPC(Morido)
        If UserList(ElOtro).flags.DueloGanado = 1 Then
             CuentaDeReto3x = 10
        End If
End If
End If

  If UserList(Morido).flags.ModoRetoPlante = 1 Then
If UserList(Morido).flags.Arenaplante = 1 And UserList(Morido).flags.Muerto = 1 Then
    Call WarpUserChar(Morido, RetoMap, X1x, Y1x, True)
    Call WarpUserChar(ElOtro, RetoMap, X2x, Y2x, True)

             UserList(Morido).flags.NoatacaPlante = 1
             UserList(ElOtro).flags.NoatacaPlante = 1
    UserList(ElOtro).flags.DueloGanado = UserList(ElOtro).flags.DueloGanado + 1
        If UserList(ElOtro).flags.DueloGanado = 1 Then Call RevivirUsuarioNPC(Morido)
       If UserList(ElOtro).flags.DueloGanado = 1 Then
             CuentaDeReto = 10
             Call SendData(ToIndex, Morido, 0, "PU" & DesteEncripTE(UserList(Morido).POS.X & "," & UserList(Morido).POS.y))
             End If
End If
If UserList(Morido).flags.Arenaplante = 2 And UserList(Morido).flags.Muerto = 1 Then
    Call WarpUserChar(Morido, RetoMap, X3x, Y3x, True)
    Call WarpUserChar(ElOtro, RetoMap, X4x, Y4x, True)

             UserList(Morido).flags.NoatacaPlante = 1
             UserList(ElOtro).flags.NoatacaPlante = 1
    UserList(ElOtro).flags.DueloGanado = UserList(ElOtro).flags.DueloGanado + 1
        If UserList(ElOtro).flags.DueloGanado = 1 Then Call RevivirUsuarioNPC(Morido)
            If UserList(ElOtro).flags.DueloGanado = 1 Then
             CuentaDeReto1 = 10
             Call SendData(ToIndex, Morido, 0, "PU" & DesteEncripTE(UserList(Morido).POS.X & "," & UserList(Morido).POS.y))
             End If
End If
If UserList(Morido).flags.Arenaplante = 3 And UserList(Morido).flags.Muerto = 1 Then
    Call WarpUserChar(Morido, RetoMap, X5x, Y5x, True)
    Call WarpUserChar(ElOtro, RetoMap, X6x, Y6x, True)

             UserList(Morido).flags.NoatacaPlante = 1
             UserList(ElOtro).flags.NoatacaPlante = 1
    UserList(ElOtro).flags.DueloGanado = UserList(ElOtro).flags.DueloGanado + 1
        If UserList(ElOtro).flags.DueloGanado = 1 Then Call RevivirUsuarioNPC(Morido)
            If UserList(ElOtro).flags.DueloGanado = 1 Then
             CuentaDeReto2 = 10
             Call SendData(ToIndex, Morido, 0, "PU" & DesteEncripTE(UserList(Morido).POS.X & "," & UserList(Morido).POS.y))
             End If
End If
If UserList(Morido).flags.Arenaplante = 4 And UserList(Morido).flags.Muerto = 1 Then
    Call WarpUserChar(Morido, RetoMap, X7x, Y7x, True)
    Call WarpUserChar(ElOtro, RetoMap, X8x, Y8x, True)

             UserList(Morido).flags.NoatacaPlante = 1
             UserList(ElOtro).flags.NoatacaPlante = 1
    UserList(ElOtro).flags.DueloGanado = UserList(ElOtro).flags.DueloGanado + 1
        If UserList(ElOtro).flags.DueloGanado = 1 Then Call RevivirUsuarioNPC(Morido)
               If UserList(ElOtro).flags.DueloGanado = 1 Then
             CuentaDeReto3 = 10
             Call SendData(ToIndex, Morido, 0, "PU" & DesteEncripTE(UserList(Morido).POS.X & "," & UserList(Morido).POS.y))
             End If
End If
End If


    If UserList(ElOtro).flags.DueloGanado = 2 Then
  
    Call WarpUserChar(Morido, 160, 51, 52, True) 'Los mando a ulla
    Call WarpUserChar(ElOtro, 160, 52, 52, True) 'Los mando a ulla
  Call SendData(ToMap, 0, 160, "||Reto> " & UserList(ElOtro).Name & " [" & UserList(ElOtro).flags.DueloGanado & "] Gana a [" & UserList(Morido).flags.DueloGanado & "] " & UserList(Morido).Name & ". Apuesta por " & PonerPuntos(UserList(Morido).flags.CantidadR) & " monedas de oro." & FONTTYPE_BLANKO)
        UserList(ElOtro).flags.tampocoteSale = False
        UserList(Morido).flags.tampocoteSale = False
        UserList(ElOtro).flags.notesaleelbug = False
        UserList(Morido).flags.notesaleelbug = False
        UserList(ElOtro).flags.Retando = False
        UserList(Morido).flags.Retando = False
        UserList(ElOtro).flags.RetandoCon = 0
'Tomih.-
        UserList(Morido).flags.RetandoCon = 0
Rem reseteo flags.
 
        UserList(ElOtro).Stats.GLD = UserList(ElOtro).Stats.GLD + UserList(ElOtro).flags.CantidadR
        UserList(Morido).Stats.GLD = UserList(Morido).Stats.GLD - UserList(Morido).flags.CantidadR
        
        UserList(ElOtro).Stats.Reputacion = UserList(ElOtro).Stats.Reputacion + 5
        Call SendUserREP(ElOtro)
        
        Call SendUserORO(ElOtro)
        Call SendUserORO(Morido)
        UserList(ElOtro).flags.RetosGanados = UserList(ElOtro).flags.RetosGanados + 1
        UserList(Morido).flags.RetosPerdidos = UserList(ElOtro).flags.RetosPerdidos + 1
        Call LogRetos(UserList(ElOtro).Name, "" & UserList(Morido).Name & " Ganador: " & UserList(ElOtro).Name & " Apuesta por: " & PonerPuntos(UserList(Morido).flags.CantidadR) & " " & " ", False)

        UserList(ElOtro).flags.CantidadR = 0
Rem reseteo los flags
        UserList(Morido).flags.CantidadR = 0
        UserList(ElOtro).flags.NoAceptasSinFlag = False
        UserList(Morido).flags.NoAceptasSinFlag = False
 
 
If UserList(ElOtro).flags.Arena = 1 Then
    Arena1 = False 'Reseteo la arena
      salallena = salallena - 1
ElseIf UserList(ElOtro).flags.Arena = 2 Then
    Arena2 = False 'Reseteo la arena
      salallena = salallena - 1
ElseIf UserList(ElOtro).flags.Arena = 3 Then
    Arena3 = False 'Reseteo la arena
      salallena = salallena - 1
ElseIf UserList(ElOtro).flags.Arena = 4 Then
    Arena4 = False 'Reseteo la arena
      salallena = salallena - 1
End If

 
 If UserList(ElOtro).flags.Arenaplante = 1 Then
    ArenaPlante1 = False 'Reseteo la arena
      salallenaplante = salallenaplante - 1
ElseIf UserList(ElOtro).flags.Arenaplante = 2 Then
    ArenaPlante2 = False 'Reseteo la arena
      salallenaplante = salallenaplante - 1
ElseIf UserList(ElOtro).flags.Arenaplante = 3 Then
    ArenaPlante3 = False 'Reseteo la arena
      salallenaplante = salallenaplante - 1
ElseIf UserList(ElOtro).flags.Arenaplante = 4 Then
    ArenaPlante4 = False 'Reseteo la arena
      salallenaplante = salallenaplante - 1
End If
 

  
UserList(ElOtro).flags.Arena = 0
UserList(Morido).flags.Arena = 0
UserList(ElOtro).flags.Arenaplante = 0
UserList(Morido).flags.Arenaplante = 0
    UserList(ElOtro).flags.DueloGanado = 0
    UserList(Morido).flags.DueloGanado = 0
    UserList(ElOtro).flags.RetoSinCanje = 0
    UserList(Morido).flags.RetoSinCanje = 0
    UserList(ElOtro).flags.ModoRetoPlante = 0
    UserList(Morido).flags.ModoRetoPlante = 0
    UserList(ElOtro).flags.NoatacaPlante = 0
    UserList(Morido).flags.NoatacaPlante = 0
    UserList(ElOtro).flags.Navegando = 0
    UserList(Morido).flags.Navegando = 0
    UserList(ElOtro).flags.RetoBUGP = 0
    UserList(ElOtro).flags.RetoBUGPE = 0
    UserList(ElOtro).flags.RetoBUGPED = 0
    UserList(ElOtro).flags.RetoBUGA = 0
    UserList(ElOtro).flags.RetoBUGAE = 0
    UserList(ElOtro).flags.RetoBUGAED = 0
    UserList(Morido).flags.RetoBUGP = 0
    UserList(Morido).flags.RetoBUGPE = 0
    UserList(Morido).flags.RetoBUGPED = 0
    UserList(Morido).flags.RetoBUGA = 0
    UserList(Morido).flags.RetoBUGAE = 0
    UserList(Morido).flags.RetoBUGAED = 0
    Exit Sub
End If
 
End Sub

   Public Sub TerminoRetoPorConex(ByVal Morido As Integer) 'Este sub sirve ya sea por desconexión o por haber ganado normalmente.
  Dim ElOtro As Integer
If UserList(Morido).flags.Retando = False Then Exit Sub 'Tomih.-
        ElOtro = UserList(Morido).flags.RetandoCon


Call WarpUserChar(Morido, 160, 51, 52, True) 'Los mando a ulla
    Call WarpUserChar(ElOtro, 160, 52, 52, True) 'Los mando a ulla
    
    Call SendData(ToMap, 0, 160, "||Reto> Ganador: " & UserList(ElOtro).Name & ". por desconexión de su oponente."" Apuesta por " & PonerPuntos(UserList(Morido).flags.CantidadR) & " monedas de oro." & FONTTYPE_BLANKO)
   
   
        UserList(ElOtro).flags.Retando = False
        UserList(Morido).flags.Retando = False
        UserList(ElOtro).flags.RetandoCon = 0
'Tomih.-
        UserList(Morido).flags.RetandoCon = 0
Rem reseteo flags.
 
        UserList(ElOtro).Stats.GLD = UserList(ElOtro).Stats.GLD + UserList(ElOtro).flags.CantidadR
        UserList(Morido).Stats.GLD = UserList(Morido).Stats.GLD - UserList(Morido).flags.CantidadR
        
        UserList(ElOtro).Stats.Reputacion = UserList(ElOtro).Stats.Reputacion + 5
        Call SendUserREP(ElOtro)
        
        Call SendUserORO(ElOtro)
        Call SendUserORO(Morido)
        
        Call LogRetos(UserList(ElOtro).Name, "" & UserList(Morido).Name & " Ganador: " & UserList(ElOtro).Name & " Apuesta por: " & PonerPuntos(UserList(Morido).flags.CantidadR) & " " & " ", False)
        UserList(ElOtro).flags.RetosGanados = UserList(ElOtro).flags.RetosGanados + 1
        UserList(Morido).flags.RetosPerdidos = UserList(ElOtro).flags.RetosPerdidos + 1
        UserList(ElOtro).flags.CantidadR = 0
Rem reseteo los flags
        UserList(Morido).flags.CantidadR = 0
        UserList(ElOtro).flags.NoAceptasSinFlag = False
        UserList(Morido).flags.NoAceptasSinFlag = False
 
 
If UserList(ElOtro).flags.Arena = 1 Then
    Arena1 = False 'Reseteo la arena
ElseIf UserList(ElOtro).flags.Arena = 2 Then
    Arena2 = False 'Reseteo la arena
ElseIf UserList(ElOtro).flags.Arena = 3 Then
    Arena3 = False 'Reseteo la arena
ElseIf UserList(ElOtro).flags.Arena = 4 Then
    Arena4 = False 'Reseteo la arena
End If

If UserList(ElOtro).flags.Arenaplante = 1 Then
    ArenaPlante1 = False 'Reseteo la arena
ElseIf UserList(ElOtro).flags.Arenaplante = 2 Then
    ArenaPlante2 = False 'Reseteo la arena
ElseIf UserList(ElOtro).flags.Arenaplante = 3 Then
    ArenaPlante3 = False 'Reseteo la arena
ElseIf UserList(ElOtro).flags.Arenaplante = 4 Then
    ArenaPlante4 = False 'Reseteo la arena
End If

   salallena = salallena - 1
 
UserList(ElOtro).flags.Arena = 0
UserList(Morido).flags.Arena = 0
UserList(ElOtro).flags.Arenaplante = 0
UserList(Morido).flags.Arenaplante = 0
    UserList(ElOtro).flags.DueloGanado = 0
    UserList(Morido).flags.DueloGanado = 0
    UserList(ElOtro).flags.RetoSinCanje = 0
    UserList(Morido).flags.RetoSinCanje = 0
    UserList(ElOtro).flags.ModoRetoPlante = 0
    UserList(Morido).flags.ModoRetoPlante = 0
    UserList(ElOtro).flags.NoatacaPlante = 0
    UserList(Morido).flags.NoatacaPlante = 0
    UserList(ElOtro).flags.Navegando = 0
    UserList(Morido).flags.Navegando = 0
    UserList(ElOtro).flags.RetoBUGP = 0
    UserList(ElOtro).flags.RetoBUGPE = 0
    UserList(ElOtro).flags.RetoBUGPED = 0
    UserList(ElOtro).flags.RetoBUGA = 0
    UserList(ElOtro).flags.RetoBUGAE = 0
    UserList(ElOtro).flags.RetoBUGAED = 0
    UserList(Morido).flags.RetoBUGP = 0
    UserList(Morido).flags.RetoBUGPE = 0
    UserList(Morido).flags.RetoBUGPED = 0
    UserList(Morido).flags.RetoBUGA = 0
    UserList(Morido).flags.RetoBUGAE = 0
    UserList(Morido).flags.RetoBUGAED = 0
End Sub

Public Sub cCuentaRetoPlante()

CuentaDeReto = CuentaDeReto - 1

If CuentaDeReto = 0 Then
        Call SendData(ToIndex, CuentaR(1).Index, 7, "||Reto> YA!!!" & FONTTYPE_FIGHTT)
        Call SendData(ToIndex, CuentaR(2).Index, 7, "||Reto> YA!!!" & FONTTYPE_FIGHTT)
        UserList(CuentaR(1).Index).flags.NoatacaPlante = 0
        UserList(CuentaR(2).Index).flags.NoatacaPlante = 0
    Else
        Call SendData(ToIndex, CuentaR(1).Index, 7, "||Reto> Comienza en " & CuentaDeReto & "..." & FONTTYPE_INFO)
        Call SendData(ToIndex, CuentaR(2).Index, 7, "||Reto> Comienza en " & CuentaDeReto & "..." & FONTTYPE_INFO)
    End If
    
    
End Sub

Public Sub cCuentaRetoPlante1()

CuentaDeReto1 = CuentaDeReto1 - 1

If CuentaDeReto1 = 0 Then
        Call SendData(ToIndex, CuentaR1(1).Index, 7, "||Reto> YA!!!" & FONTTYPE_FIGHTT)
        Call SendData(ToIndex, CuentaR1(2).Index, 7, "||Reto> YA!!!" & FONTTYPE_FIGHTT)
        UserList(CuentaR1(1).Index).flags.NoatacaPlante = 0
        UserList(CuentaR1(2).Index).flags.NoatacaPlante = 0
    Else
        Call SendData(ToIndex, CuentaR1(1).Index, 7, "||Reto> Comienza en " & CuentaDeReto1 & "..." & FONTTYPE_INFO)
        Call SendData(ToIndex, CuentaR1(2).Index, 7, "||Reto> Comienza en " & CuentaDeReto1 & "..." & FONTTYPE_INFO)
    End If
    
    
End Sub

Public Sub cCuentaRetoPlante2()

CuentaDeReto2 = CuentaDeReto2 - 1

If CuentaDeReto2 = 0 Then
        Call SendData(ToIndex, CuentaR2(1).Index, 7, "||Reto> YA!!!" & FONTTYPE_FIGHTT)
        Call SendData(ToIndex, CuentaR2(2).Index, 7, "||Reto> YA!!!" & FONTTYPE_FIGHTT)
        UserList(CuentaR2(1).Index).flags.NoatacaPlante = 0
        UserList(CuentaR2(2).Index).flags.NoatacaPlante = 0
    Else
        Call SendData(ToIndex, CuentaR2(1).Index, 7, "||Reto> Comienza en " & CuentaDeReto2 & "..." & FONTTYPE_INFO)
        Call SendData(ToIndex, CuentaR2(2).Index, 7, "||Reto> Comienza en " & CuentaDeReto2 & "..." & FONTTYPE_INFO)
    End If
    
    
End Sub

Public Sub cCuentaRetoPlante3()

CuentaDeReto3 = CuentaDeReto3 - 1

If CuentaDeReto3 = 0 Then
        Call SendData(ToIndex, CuentaR3(1).Index, 7, "||Reto> YA!!!" & FONTTYPE_FIGHTT)
        Call SendData(ToIndex, CuentaR3(2).Index, 7, "||Reto> YA!!!" & FONTTYPE_FIGHTT)
        UserList(CuentaR3(1).Index).flags.NoatacaPlante = 0
        UserList(CuentaR3(2).Index).flags.NoatacaPlante = 0
    Else
        Call SendData(ToIndex, CuentaR3(1).Index, 7, "||Reto> Comienza en " & CuentaDeReto3 & "..." & FONTTYPE_INFO)
        Call SendData(ToIndex, CuentaR3(2).Index, 7, "||Reto> Comienza en " & CuentaDeReto3 & "..." & FONTTYPE_INFO)
    End If
    
End Sub





Public Sub cCuentaRetoPlantex()

CuentaDeRetox = CuentaDeRetox - 1

If CuentaDeRetox = 0 Then
        Call SendData(ToIndex, CuentaRx(1).Index, 7, "||Reto> YA!!!" & FONTTYPE_FIGHTT)
        Call SendData(ToIndex, CuentaRx(2).Index, 7, "||Reto> YA!!!" & FONTTYPE_FIGHTT)
        UserList(CuentaRx(1).Index).flags.Navegando = 0
        UserList(CuentaRx(2).Index).flags.Navegando = 0
    Else
        Call SendData(ToIndex, CuentaRx(1).Index, 7, "||Reto> Comienza en " & CuentaDeRetox & "..." & FONTTYPE_INFO)
        Call SendData(ToIndex, CuentaRx(2).Index, 7, "||Reto> Comienza en " & CuentaDeRetox & "..." & FONTTYPE_INFO)
    End If
    
    
End Sub

Public Sub cCuentaRetoPlante1x()

CuentaDeReto1x = CuentaDeReto1x - 1

If CuentaDeReto1x = 0 Then
        Call SendData(ToIndex, CuentaR1x(1).Index, 7, "||Reto> YA!!!" & FONTTYPE_FIGHTT)
        Call SendData(ToIndex, CuentaR1x(2).Index, 7, "||Reto> YA!!!" & FONTTYPE_FIGHTT)
        UserList(CuentaR1x(1).Index).flags.Navegando = 0
        UserList(CuentaR1x(2).Index).flags.Navegando = 0
    Else
        Call SendData(ToIndex, CuentaR1x(1).Index, 7, "||Reto> Comienza en " & CuentaDeReto1x & "..." & FONTTYPE_INFO)
        Call SendData(ToIndex, CuentaR1x(2).Index, 7, "||Reto> Comienza en " & CuentaDeReto1x & "..." & FONTTYPE_INFO)
    End If
    
    
End Sub

Public Sub cCuentaRetoPlante2x()

CuentaDeReto2x = CuentaDeReto2x - 1

If CuentaDeReto2x = 0 Then
        Call SendData(ToIndex, CuentaR2x(1).Index, 7, "||Reto> YA!!!" & FONTTYPE_FIGHTT)
        Call SendData(ToIndex, CuentaR2x(2).Index, 7, "||Reto> YA!!!" & FONTTYPE_FIGHTT)
        UserList(CuentaR2x(1).Index).flags.Navegando = 0
        UserList(CuentaR2x(2).Index).flags.Navegando = 0
    Else
        Call SendData(ToIndex, CuentaR2x(1).Index, 7, "||Reto> Comienza en " & CuentaDeReto2x & "..." & FONTTYPE_INFO)
        Call SendData(ToIndex, CuentaR2x(2).Index, 7, "||Reto> Comienza en " & CuentaDeReto2x & "..." & FONTTYPE_INFO)
    End If
    
    
End Sub

Public Sub cCuentaRetoPlante3x()

CuentaDeReto3x = CuentaDeReto3x - 1

If CuentaDeReto3x = 0 Then
        Call SendData(ToIndex, CuentaR3x(1).Index, 7, "||Reto> YA!!!" & FONTTYPE_FIGHTT)
        Call SendData(ToIndex, CuentaR3x(2).Index, 7, "||Reto> YA!!!" & FONTTYPE_FIGHTT)
        UserList(CuentaR3x(1).Index).flags.Navegando = 0
        UserList(CuentaR3x(2).Index).flags.Navegando = 0
    Else
        Call SendData(ToIndex, CuentaR3x(1).Index, 7, "||Reto> Comienza en " & CuentaDeReto3x & "..." & FONTTYPE_INFO)
        Call SendData(ToIndex, CuentaR3x(2).Index, 7, "||Reto> Comienza en " & CuentaDeReto3x & "..." & FONTTYPE_INFO)
    End If
    
End Sub

