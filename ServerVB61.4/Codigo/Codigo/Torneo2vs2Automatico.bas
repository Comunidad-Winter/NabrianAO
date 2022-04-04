Attribute VB_Name = "Torneo2vs2Automatico"
 
'director del proyecto: #Esteban(Neliam)

'servidor basado en fénixao 1.0
'medios de contacto:
'Skype: dc.esteban
'E-mail: nabrianao@gmail.com
Option Explicit
' Codigo: Torneos automatico2vs2s 100%
' Autor: Joan Calderón - SaturoS.
Public Torneo_ActivoX As Boolean
Public Torneo_EsperandoX As Boolean
Private Torneo_Rondas As Integer
Private Torneo_Luchadores() As Integer
 
 Public Type sabe2vs2
User12vs2 As Integer
User22vs2 As Integer
End Type

Public Pareja12vs2 As sabe2vs2
Public Pareja22vs2 As sabe2vs2
 
Private Const mapatorneo As Integer = 99
' esquinas superior isquierda del ring
Private Const esquina1x As Integer = 41
Private Const esquina1xx As Integer = 42
Private Const esquina1y As Integer = 44
' esquina inferior derecha del ring
Private Const esquina2x As Integer = 60
Private Const esquina2xx As Integer = 59
Private Const esquina2y As Integer = 56
' Donde esperan los tios
Private Const esperax As Integer = 52
Private Const esperay As Integer = 27
' Mapa desconecta
Private Const mapa_fuera As Integer = 1
Private Const fueraesperay As Integer = 50
Private Const fueraesperax As Integer = 50
 ' estas son las pocisiones de las 2 esquinas de la zona de espera, en su mapa tienen que tener en la misma posicion las 2 esquinas.
Private Const X1 As Integer = 36
Private Const X2 As Integer = 65
Private Const Y1 As Integer = 24
Private Const Y2 As Integer = 30

Public Type sdweXXXXXX
 Index As Integer
 Nick As String
End Type

Public CuentaME(1 To 4) As sdweXXXXXX
Public cuentaTorneo2vs2 As Byte

 
Sub Torneoauto_Cancela2vs2()
On Error GoTo errorh:
    If (Not Torneo_ActivoX And Not Torneo_EsperandoX) Then Exit Sub
    Torneo_ActivoX = False
    Torneo_EsperandoX = False

    Call SendData(ToAll, 0, 0, "||Torneo Automático> Torneo automático cancelado por falta de participantes." & FONTTYPE_TALK)
    InscripcionCosto = 100000 'reiniciamos default 100k de oro de inscripcion
    OroDeLosInscriptos = 0 'Reiniciamos a 0 sino se acumula como 100kkk de oro xD!
    Dim i As Integer
     For i = LBound(Torneo_Luchadores) To UBound(Torneo_Luchadores)
                If (Torneo_Luchadores(i) <> -1) Then
                 Dim NuevaPos As WorldPos
                  Dim FuturePos As WorldPos
                    FuturePos.Map = mapa_fuera
                    FuturePos.X = fueraesperax: FuturePos.y = fueraesperay
                    Call ClosestLegalPos(FuturePos, NuevaPos)
                    If NuevaPos.X <> 0 And NuevaPos.y <> 0 Then Call WarpUserChar(Torneo_Luchadores(i), NuevaPos.Map, NuevaPos.X, NuevaPos.y, True)
                    Call WarpUserChar(UserList(Torneo_Luchadores(i)).flags.pareja2vs2, NuevaPos.Map, NuevaPos.X, NuevaPos.y, True)
                      UserList(Torneo_Luchadores(i)).flags.automatico2vs2 = False
                      UserList(UserList(Torneo_Luchadores(i)).flags.Parejado2vs2).flags.automatico2vs2 = False
                      UserList(UserList(Torneo_Luchadores(i)).flags.Parejado2vs2).flags.EstaTorneoAuto2vs2 = False
                      UserList(UserList(Torneo_Luchadores(i)).flags.Parejado2vs2).flags.parejadel2v2 = 0
                     ' UserList(Torneo_Luchadores(i)).flags.pareja2vs2 = 0
                     ' UserList(Torneo_Luchadores(i)).flags.Parejado2vs2 = 0
                     ' UserList(UserList(Torneo_Luchadores(i)).flags.Parejado2vs2).flags.pareja2vs2 = 0
                     ' UserList(UserList(Torneo_Luchadores(i)).flags.Parejado2vs2).flags.Parejado2vs2 = 0


                End If
        Next i
errorh:
End Sub
Sub Rondas_Cancela2vs2()
On Error GoTo errorh
    If (Not Torneo_ActivoX And Not Torneo_EsperandoX) Then Exit Sub
    Torneo_ActivoX = False
    Torneo_EsperandoX = False
    Call SendData(ToAll, 0, 0, "||Torneo Automático> Torneo automático cancelado por Game Master." & FONTTYPE_TALK)
     InscripcionCosto = 100000 'reiniciamos default 100k de oro de inscripcion
     OroDeLosInscriptos = 0 'Reiniciamos a 0 sino se acumula como 100kkk de oro xD!
    Dim i As Integer
    For i = LBound(Torneo_Luchadores) To UBound(Torneo_Luchadores)
                If (Torneo_Luchadores(i) <> -1) Then
                        Dim NuevaPos As WorldPos
                  Dim FuturePos As WorldPos
                    FuturePos.Map = mapa_fuera
                    FuturePos.X = fueraesperax: FuturePos.y = fueraesperay
                    Call ClosestLegalPos(FuturePos, NuevaPos)
                    If NuevaPos.X <> 0 And NuevaPos.y <> 0 Then Call WarpUserChar(Torneo_Luchadores(i), NuevaPos.Map, NuevaPos.X, NuevaPos.y, True)
                       Call WarpUserChar(UserList(Torneo_Luchadores(i)).flags.pareja2vs2, NuevaPos.Map, NuevaPos.X, NuevaPos.y, True)
                       UserList(Torneo_Luchadores(i)).flags.automatico2vs2 = False
                       UserList(UserList(Torneo_Luchadores(i)).flags.Parejado2vs2).flags.automatico2vs2 = False
                       UserList(UserList(Torneo_Luchadores(i)).flags.Parejado2vs2).flags.EstaTorneoAuto2vs2 = False
                       UserList(UserList(Torneo_Luchadores(i)).flags.Parejado2vs2).flags.parejadel2v2 = False
                      ' UserList(Torneo_Luchadores(i)).flags.pareja2vs2 = 0
                      ' UserList(Torneo_Luchadores(i)).flags.Parejado2vs2 = 0
                      ' UserList(UserList(Torneo_Luchadores(i)).flags.Parejado2vs2).flags.pareja2vs2 = 0
                      ' UserList(UserList(Torneo_Luchadores(i)).flags.Parejado2vs2).flags.Parejado2vs2 = 0
                End If
        Next i
errorh:
End Sub
Sub Rondas_UsuarioMuere2vs2(ByVal Userindex As Integer, Optional Real As Boolean = True, Optional CambioMapa As Boolean = False)
On Error GoTo rondas_usuariomuere_errorh
        Dim i As Integer, POS As Integer, j As Integer
        Dim combate As Integer, LI1 As Integer, LI2 As Integer
        Dim UI1 As Integer, UI2 As Integer
If (Not Torneo_ActivoX) Then
                Exit Sub
            ElseIf (Torneo_ActivoX And Torneo_EsperandoX) Then
                For i = LBound(Torneo_Luchadores) To UBound(Torneo_Luchadores)
                    If (Torneo_Luchadores(i) = Userindex) Then
                        Torneo_Luchadores(i) = -1
                        Call WarpUserChar(Userindex, mapa_fuera, fueraesperay, fueraesperax, True)
                         UserList(Userindex).flags.automatico2vs2 = False
                         UserList(UserList(Userindex).flags.Parejado2vs2).flags.automatico2vs2 = False
                         UserList(UserList(Userindex).flags.Parejado2vs2).flags.EstaTorneoAuto2vs2 = False
                         UserList(UserList(Userindex).flags.Parejado2vs2).flags.parejadel2v2 = 0
                        Exit Sub
                    End If
                Next i
                Exit Sub
            End If
 
        For POS = LBound(Torneo_Luchadores) To UBound(Torneo_Luchadores)
                If (Torneo_Luchadores(POS) = Userindex) Then Exit For
        Next POS
 
        ' si no lo ha encontrado
        If (Torneo_Luchadores(POS) <> Userindex) Then Exit Sub
       
 '  Ojo con esta parte, aqui es donde verifica si el usuario esta en la posicion de espera del torneo, en estas cordenadas tienen que fijarse al crear su Mapa de torneos.
 
'If UserList(UserIndex).POS.X >= X1 And UserList(UserIndex).POS.X <= X2 And UserList(UserIndex).POS.Y >= Y1 And UserList(UserIndex).POS.Y <= Y2 Then
If MapData(UserList(Userindex).POS.Map, UserList(Userindex).POS.X, UserList(Userindex).POS.y).trigger = 4 Then 'Si esta en zona de espera.
Call SendData(ToAll, 0, 0, "||Torneo Automático> " & UserList(Userindex).Name & " - " & UserList(UserList(Userindex).flags.Parejado2vs2).Name & " se fueron del torneo mientras esperaban pelear." & FONTTYPE_BLANKO)
'Call WarpUserChar(Userindex, mapa_fuera, fueraesperax, fueraesperay, True)
If AutomaticoCanjes = 1 Then Call WarpUserChar(UserList(Userindex).flags.Parejado2vs2, 1, 50, 50, True)
If AutomaticoCanjes = 0 Then Call WarpUserChar(UserList(Userindex).flags.Parejado2vs2, mapa_fuera, fueraesperax, fueraesperay, True)
If AutomaticoCanjes = 1 Then Call TirarTodosLosItems(UserList(Userindex).flags.Parejado2vs2)
UserList(Userindex).flags.automatico2vs2 = False
UserList(UserList(Userindex).flags.Parejado2vs2).flags.automatico2vs2 = False
UserList(UserList(Userindex).flags.Parejado2vs2).flags.EstaTorneoAuto2vs2 = False
UserList(UserList(Userindex).flags.Parejado2vs2).flags.parejadel2v2 = 0
Torneo_Luchadores(POS) = -1
Exit Sub
End If
 
        combate = 1 + (POS - 1) \ 2
 
        'ponemos li1 y li2 (luchador index) de los que combatian
        LI1 = 2 * (combate - 1) + 1
        LI2 = LI1 + 1
 
        'se informa a la gente
        If (Real) Then
                Call SendData(ToAll, 0, 0, "||Torneo Automático> " & UserList(Userindex).Name & " - " & UserList(UserList(Userindex).flags.Parejado2vs2).Name & " pierden el combate." & FONTTYPE_BLANKO)
        Else
                Call SendData(ToAll, 0, 0, "||Torneo Automático> " & UserList(Userindex).Name & " - " & UserList(UserList(Userindex).flags.Parejado2vs2).Name & " se fueron del combate." & FONTTYPE_BLANKO)
        End If
 
        'se le teleporta fuera si murio
        If (Real) Then
                'Call WarpUserChar(Userindex, mapa_fuera, fueraesperax, fueraesperay, True)
                 If AutomaticoCanjes = 1 Then Call WarpUserChar(UserList(Userindex).flags.Parejado2vs2, 1, 50, 50, True)
                 If AutomaticoCanjes = 0 Then Call WarpUserChar(UserList(Userindex).flags.Parejado2vs2, mapa_fuera, fueraesperax, fueraesperay, True)
                 If AutomaticoCanjes = 1 Then Call TirarTodosLosItems(UserList(Userindex).flags.Parejado2vs2)
                 UserList(Userindex).flags.automatico2vs2 = False
                 UserList(UserList(Userindex).flags.Parejado2vs2).flags.automatico2vs2 = False
                 UserList(UserList(Userindex).flags.Parejado2vs2).flags.EstaTorneoAuto2vs2 = False
                 UserList(UserList(Userindex).flags.Parejado2vs2).flags.parejadel2v2 = 0
        ElseIf (Not CambioMapa) Then
             
                 'Call WarpUserChar(Userindex, mapa_fuera, fueraesperax, fueraesperay, True)
                  If AutomaticoCanjes = 1 Then Call WarpUserChar(UserList(Userindex).flags.Parejado2vs2, 1, 50, 50, True)
                  If AutomaticoCanjes = 0 Then Call WarpUserChar(UserList(Userindex).flags.Parejado2vs2, mapa_fuera, fueraesperax, fueraesperay, True)
                  If AutomaticoCanjes = 1 Then Call TirarTodosLosItems(UserList(Userindex).flags.Parejado2vs2)

                  UserList(Userindex).flags.automatico2vs2 = False
                  UserList(UserList(Userindex).flags.Parejado2vs2).flags.automatico2vs2 = False
                  UserList(UserList(Userindex).flags.Parejado2vs2).flags.EstaTorneoAuto2vs2 = False
                  UserList(UserList(Userindex).flags.Parejado2vs2).flags.parejadel2v2 = 0
        End If
 
        'se le borra de la lista y se mueve el segundo a li1
        If (Torneo_Luchadores(LI1) = Userindex) Then
                Torneo_Luchadores(LI1) = Torneo_Luchadores(LI2) 'cambiamos slot
                Torneo_Luchadores(LI2) = -1
        Else
                Torneo_Luchadores(LI2) = -1
        End If
 
 
    'si es la ultima ronda
 
    If (Torneo_Rondas = 1) Then
        If AutomaticoCanjes = 1 Then Call WarpUserChar(UserList(Torneo_Luchadores(LI1)).flags.Parejado2vs2, 198, 56, 57, True)
        If AutomaticoCanjes = 1 Then Call WarpUserChar(Torneo_Luchadores(LI1), 198, 56, 57, True)
        If AutomaticoCanjes = 0 Then Call WarpUserChar(UserList(Torneo_Luchadores(LI1)).flags.Parejado2vs2, 1, 50, 50, True)
        If AutomaticoCanjes = 0 Then Call WarpUserChar(Torneo_Luchadores(LI1), 1, 50, 50, True)
        Call SendData(ToAll, 0, 0, "||Torneo Automático> Ganan " & UserList(Torneo_Luchadores(LI1)).Name & " - " & UserList(UserList(Torneo_Luchadores(LI1)).flags.Parejado2vs2).Name & ". Ganaron " & PonerPuntos(OroDeLosInscriptos) & " monedas de oro y +" & CantAuto & " puntos de reputación." & FONTTYPE_PARTY)
        UserList(Torneo_Luchadores(LI1)).Stats.Reputacion = UserList(Torneo_Luchadores(LI1)).Stats.Reputacion + CantAuto
        UserList(Torneo_Luchadores(LI1)).Stats.GLD = UserList(Torneo_Luchadores(LI1)).Stats.GLD + OroDeLosInscriptos
        If CantAuto = 2 Or CantAuto = 4 Then
        Call SendData(ToAll, 0, 0, "||Torneo Automático> No se le otorgo el punto de torneo debido a que fue un torneo de pocos participantes." & FONTTYPE_FIGHTT)
        Else
        UserList(Torneo_Luchadores(LI1)).Faccion.torneos = UserList(Torneo_Luchadores(LI1)).Faccion.torneos + 1
        UserList(UserList(Torneo_Luchadores(LI1)).flags.Parejado2vs2).Faccion.torneos = UserList(UserList(Torneo_Luchadores(LI1)).flags.Parejado2vs2).Faccion.torneos + 1
        End If
        UserList(UserList(Torneo_Luchadores(LI1)).flags.Parejado2vs2).Stats.GLD = UserList(UserList(Torneo_Luchadores(LI1)).flags.Parejado2vs2).Stats.GLD + OroDeLosInscriptos
        UserList(UserList(Torneo_Luchadores(LI1)).flags.Parejado2vs2).Stats.Reputacion = UserList(UserList(Torneo_Luchadores(LI1)).flags.Parejado2vs2).Stats.Reputacion + CantAuto
        Call SendUserORO(UserList(Torneo_Luchadores(LI1)).flags.Parejado2vs2)
        Call SendUserORO(Torneo_Luchadores(LI1))
        Call SendUserREP(UserList(Torneo_Luchadores(LI1)).flags.Parejado2vs2)
        Call SendUserREP(Torneo_Luchadores(LI1))
        UserList(Torneo_Luchadores(LI1)).flags.automatico2vs2 = False
        UserList(UserList(Torneo_Luchadores(LI1)).flags.Parejado2vs2).flags.automatico2vs2 = False
        UserList(UserList(Torneo_Luchadores(LI1)).flags.Parejado2vs2).flags.EstaTorneoAuto2vs2 = False
        UserList(UserList(Torneo_Luchadores(LI1)).flags.Parejado2vs2).flags.parejadel2v2 = 0
          InscripcionCosto = 100000 'reiniciamos default 100k de oro de inscripcion
         OroDeLosInscriptos = 0 'Reiniciamos a 0 sino se acumula como 100kkk de oro xD!
        Torneo_ActivoX = False
        Exit Sub
    Else
        'a su compañero se le teleporta dentro, condicional por seguridad
        Call WarpUserChar(Torneo_Luchadores(LI1), mapatorneo, esperax, esperay, True)
        Call WarpUserChar(UserList(Torneo_Luchadores(LI1)).flags.Parejado2vs2, mapatorneo, esperax, esperay, True)
    End If
 
               
        'si es el ultimo combate de la ronda
        If (2 ^ Torneo_Rondas = 2 * combate) Then
 
                'Call SendData(ToAll, 0, 0, "||Siguiente ronda!" & FONTTYPE_TALK)
                Torneo_Rondas = Torneo_Rondas - 1
 
        'antes de llamar a la proxima ronda hay q copiar a los tipos
        For i = 1 To 2 ^ Torneo_Rondas
                UI1 = Torneo_Luchadores(2 * (i - 1) + 1)
                UI2 = Torneo_Luchadores(2 * i)
                If (UI1 = -1) Then UI1 = UI2
                Torneo_Luchadores(i) = UI1
        Next i
ReDim Preserve Torneo_Luchadores(1 To 2 ^ Torneo_Rondas) As Integer
        Call Rondas_Combate2vs2(1)
        Exit Sub
        End If
 
        'vamos al siguiente combate
        Call Rondas_Combate2vs2(combate + 1)
rondas_usuariomuere_errorh:
 
End Sub
 
 
 
Sub Rondas_UsuarioDesconecta2vs2(ByVal Userindex As Integer)
On Error GoTo errorh

'Call SendUserStatsBox(Userindex)
        Call Rondas_UsuarioMuere2vs2(Userindex, False, False)
errorh:
End Sub
 
Sub Rondas_UsuarioCambiamapa2vs2(ByVal Userindex As Integer)
On Error GoTo errorh
        Call Rondas_UsuarioMuere2vs2(Userindex, False, True)
errorh:
End Sub
 
Sub torneos_auto2vs2(ByVal rondas As Integer)
On Error GoTo errorh
If (Torneo_ActivoX) Then
               
                Exit Sub
        End If
        Call SendData(ToAll, 0, 0, "||Esta empezando un torneo automático 2vs2 para " & val(2 ^ rondas) & " parejas, tipeá /TPAREJA ''NICK'' Sin comillas el costo de inscripcion es de " & PonerPuntos(InscripcionCosto) & " monedas de oro" & FONTTYPE_TALK)
        Call SendData(ToAll, 0, 0, "TW123")
       
        Torneo_Rondas = rondas
        Torneo_ActivoX = True
        Torneo_EsperandoX = True
 
        ReDim Torneo_Luchadores(1 To 2 ^ rondas) As Integer
        Dim i As Integer
        For i = LBound(Torneo_Luchadores) To UBound(Torneo_Luchadores)
                Torneo_Luchadores(i) = -1
        Next i
errorh:
End Sub
 
Sub Torneos_Inicia2vs2(ByVal Userindex As Integer, ByVal rondas As Integer)
On Error GoTo errorh
        If (Torneo_ActivoX) Then
                Call SendData(ToIndex, Userindex, 0, "||Ya hay un torneo!." & FONTTYPE_INFO)
                Exit Sub
        End If
        Call SendData(ToAll, 0, 0, "||Esta empezando un torneo automático 2vs2 para " & val(2 ^ rondas) & " parejas, tipeá /TPAREJA ''NICK'' Sin comillas el costo de inscripcion es de " & PonerPuntos(InscripcionCosto) & " monedas de oro" & FONTTYPE_TALK)
        Call SendData(ToAll, 0, 0, "TW123")
        
        Torneo_Rondas = rondas
        Torneo_ActivoX = True
        Torneo_EsperandoX = True
        
        ReDim Torneo_Luchadores(1 To 2 ^ rondas) As Integer
        Dim i As Integer
        For i = LBound(Torneo_Luchadores) To UBound(Torneo_Luchadores)
                Torneo_Luchadores(i) = -1
        Next i
errorh:
End Sub
 
 
 
Sub Torneos_Entra2vs2(ByVal Userindex As Integer)
On Error GoTo errorh
        Dim i As Integer

       
        If (Not Torneo_ActivoX) Then
        
                Exit Sub
        End If
    
       
        If (Not Torneo_EsperandoX) Then
                Call SendData(ToIndex, Userindex, 0, "|El torneo ha empezado tu pareja quedo fuera." & FONTTYPE_INFO)
                Exit Sub
        End If
        
        
        If UserList(Userindex).Stats.GLD < InscripcionCosto Then
        Call SendData(ToIndex, Userindex, 0, "||No tienes suficiente oro para la inscripción: " & PonerPuntos(InscripcionCosto) & " monedas de oro." & FONTTYPE_INFO)
        Exit Sub
        End If
        
        If UserList(UserList(Userindex).flags.Parejado2vs2).Stats.GLD < InscripcionCosto Then
        Call SendData(ToIndex, Userindex, 0, "||Tu pareja no tiene suficiente oro para la inscripción: " & InscripcionCosto & " monedas de oro." & FONTTYPE_INFO)
        Exit Sub
        End If
       
        For i = LBound(Torneo_Luchadores) To UBound(Torneo_Luchadores)
                If (Torneo_Luchadores(i) = Userindex) Then
                    
                        Exit Sub
                End If
        Next i
 
        For i = LBound(Torneo_Luchadores) To UBound(Torneo_Luchadores)
        If (Torneo_Luchadores(i) = -1) Then
                Torneo_Luchadores(i) = Userindex
                 Dim NuevaPos As WorldPos
                  Dim FuturePos As WorldPos
                    FuturePos.Map = mapatorneo
                    FuturePos.X = esperax: FuturePos.y = esperay
                    Call ClosestLegalPos(FuturePos, NuevaPos)
                   
                    If NuevaPos.X <> 0 And NuevaPos.y <> 0 Then Call WarpUserChar(Torneo_Luchadores(i), NuevaPos.Map, NuevaPos.X, NuevaPos.y, True)
                    Call WarpUserChar(UserList(Torneo_Luchadores(i)).flags.pareja2vs2, NuevaPos.Map, NuevaPos.X, NuevaPos.y, True)
                    
                 
                 
                 UserList(Torneo_Luchadores(i)).flags.automatico2vs2 = True
                 UserList(UserList(Torneo_Luchadores(i)).flags.Parejado2vs2).flags.automatico2vs2 = True
                  
                  UserList(Userindex).Stats.GLD = UserList(Userindex).Stats.GLD - InscripcionCosto
                  UserList(UserList(Torneo_Luchadores(i)).flags.Parejado2vs2).Stats.GLD = UserList(UserList(Torneo_Luchadores(i)).flags.Parejado2vs2).Stats.GLD - InscripcionCosto
                 Call SendUserORO(Userindex)
                 Call SendUserORO(UserList(Userindex).flags.Parejado2vs2)
                 
                 OroDeLosInscriptos = OroDeLosInscriptos + InscripcionCosto
                Call SendData(ToAll, 0, 0, "||Torneo Automático> Entran " & UserList(Userindex).Name & "-" & UserList(UserList(Userindex).flags.Parejado2vs2).Name & FONTTYPE_INFO)
                
                If AutomaticoCanjes = 1 Then
If UserList(Userindex).Invent.ArmourEqpObjIndex Then Call Desequipar(Userindex, UserList(Userindex).Invent.ArmourEqpSlot)
If UserList(Userindex).Invent.WeaponEqpObjIndex Then Call Desequipar(Userindex, UserList(Userindex).Invent.WeaponEqpSlot)
If UserList(Userindex).Invent.EscudoEqpObjIndex Then Call Desequipar(Userindex, UserList(Userindex).Invent.EscudoEqpSlot)
If UserList(Userindex).Invent.CascoEqpObjIndex Then Call Desequipar(Userindex, UserList(Userindex).Invent.CascoEqpSlot)
If UserList(Userindex).Invent.HerramientaEqpObjIndex Then Call Desequipar(Userindex, UserList(Userindex).Invent.HerramientaEqpslot)
If UserList(Userindex).Invent.MunicionEqpObjIndex Then Call Desequipar(Userindex, UserList(Userindex).Invent.MunicionEqpSlot)
If UserList(UserList(Userindex).flags.Parejado2vs2).Invent.ArmourEqpObjIndex Then Call Desequipar((UserList(Userindex).flags.Parejado2vs2), UserList(UserList(Userindex).flags.Parejado2vs2).Invent.ArmourEqpSlot)
If UserList(UserList(Userindex).flags.Parejado2vs2).Invent.WeaponEqpObjIndex Then Call Desequipar((UserList(Userindex).flags.Parejado2vs2), UserList(UserList(Userindex).flags.Parejado2vs2).Invent.WeaponEqpSlot)
If UserList(UserList(Userindex).flags.Parejado2vs2).Invent.EscudoEqpObjIndex Then Call Desequipar((UserList(Userindex).flags.Parejado2vs2), UserList(UserList(Userindex).flags.Parejado2vs2).Invent.EscudoEqpSlot)
If UserList(UserList(Userindex).flags.Parejado2vs2).Invent.CascoEqpObjIndex Then Call Desequipar((UserList(Userindex).flags.Parejado2vs2), UserList(UserList(Userindex).flags.Parejado2vs2).Invent.CascoEqpSlot)
If UserList(UserList(Userindex).flags.Parejado2vs2).Invent.HerramientaEqpObjIndex Then Call Desequipar((UserList(Userindex).flags.Parejado2vs2), UserList(UserList(Userindex).flags.Parejado2vs2).Invent.HerramientaEqpslot)
If UserList(UserList(Userindex).flags.Parejado2vs2).Invent.MunicionEqpObjIndex Then Call Desequipar((UserList(Userindex).flags.Parejado2vs2), UserList(UserList(Userindex).flags.Parejado2vs2).Invent.MunicionEqpSlot)
                End If
                
                If (i = UBound(Torneo_Luchadores)) Then
                Call SendData(ToAll, 0, 0, "||Torneo Automático> ¡Empieza el torneo!" & FONTTYPE_ORO)


                Torneo_EsperandoX = False
                Call Rondas_Combate2vs2(1)
                
                End If
                  Exit Sub
        End If
        Next i
errorh:
End Sub
 
 
Sub Rondas_Combate2vs2(combate As Integer)
On Error GoTo errorh
Dim UI1 As Integer, UI2 As Integer
    UI1 = Torneo_Luchadores(2 * (combate - 1) + 1)
    UI2 = Torneo_Luchadores(2 * combate)
   
    If (UI2 = -1) Then
        UI2 = Torneo_Luchadores(2 * (combate - 1) + 1)
        UI1 = Torneo_Luchadores(2 * combate)
    End If
   
   If UI1 = -1 Then
        Call SendData(ToAll, 0, 0, "||Torneo Automático> Combate anulado por deslogeo de parejas." & FONTTYPE_BLANKO)
        
         If (Torneo_Rondas = 1) Then
        If (UI2 <> -1) Then
        Call SendData(ToAll, 0, 0, "||Torneo Automático> Ganadores del torneo por eliminacion: " & UserList(UI2).Name & " - " & UserList(UserList(UI2).flags.Parejado2vs2).Name & "." & FONTTYPE_TALK)
        Call SendData(ToAll, 0, 0, "||Premio> " & PonerPuntos(OroDeLosInscriptos) & " monedas de oro +" & CantAuto & " puntos de reputación." & FONTTYPE_PARTY)
        If CantAuto = 2 Or CantAuto = 4 Then
        Call SendData(ToAll, 0, 0, "||Torneo Automático> No se le otorgo el punto de torneo debido a que fue un torneo de pocos participantes." & FONTTYPE_FIGHTT)
        Else
        UserList(UI2).Faccion.torneos = UserList(UI2).Faccion.torneos + 1
        UserList(UserList(UI2).flags.Parejado2vs2).Faccion.torneos = UserList(UserList(UI2).flags.Parejado2vs2).Faccion.torneos + 1
        End If
        
        UserList(UI2).flags.automatico2vs2 = False
        UserList(UserList(UI2).flags.Parejado2vs2).flags.automatico2vs2 = False
        UserList(UserList(UI2).flags.Parejado2vs2).flags.EstaTorneoAuto2vs2 = False
        UserList(UserList(UI2).flags.Parejado2vs2).flags.parejadel2v2 = 0
        UserList(UserList(UI2).flags.Parejado2vs2).Stats.GLD = UserList(UserList(UI2).flags.Parejado2vs2).Stats.GLD + OroDeLosInscriptos
        UserList(UI2).Stats.GLD = UserList(UI2).Stats.GLD + OroDeLosInscriptos
        UserList(UserList(UI2).flags.Parejado2vs2).Stats.Reputacion = UserList(UserList(UI2).flags.Parejado2vs2).Stats.Reputacion + CantAuto
        UserList(UI2).Stats.Reputacion = UserList(UI2).Stats.Reputacion + CantAuto
        Call SendUserORO(UserList(UI2).flags.Parejado2vs2)
        Call SendUserORO(UI2)
        Call SendUserREP(UserList(UI2).flags.Parejado2vs2)
        Call SendUserREP(UI2)
        
         InscripcionCosto = 100000 'reiniciamos default 100k de oro de inscripcion
         OroDeLosInscriptos = 0 'Reiniciamos a 0 sino se acumula como 100kkk de oro xD!
        
        If AutomaticoCanjes = 1 Then Call WarpUserChar(UI2, 198, 56, 57, True)
        If AutomaticoCanjes = 1 Then Call WarpUserChar(UserList(UI2).flags.Parejado2vs2, 198, 56, 57, True)
        If AutomaticoCanjes = 0 Then Call WarpUserChar(UI2, 1, 50, 50, True)
        If AutomaticoCanjes = 0 Then Call WarpUserChar(UserList(UI2).flags.Parejado2vs2, 1, 50, 50, True)
        ' dale_recompensa()
        Torneo_ActivoX = False
       Exit Sub
    End If
            Call SendData(ToAll, 0, 0, "||Torneo Automático> Torneo terminado. No hay ganador porque todos se fueron." & FONTTYPE_BLANKO)
            InscripcionCosto = 100000 'reiniciamos default 100k de oro de inscripcion
            OroDeLosInscriptos = 0 'Reiniciamos a 0 sino se acumula como 100kkk de oro xD!
             Exit Sub
        End If
        If (UI2 <> -1) Then _
            Call SendData(ToAll, 0, 0, "||Torneo Automático> " & UserList(UI2).Name & " - " & UserList(UserList(UI2).flags.Parejado2vs2).Name & " pasan de ronda." & FONTTYPE_WARNING)
   
        If (2 ^ Torneo_Rondas = 2 * combate) Then
           
            Torneo_Rondas = Torneo_Rondas - 1
         
            Dim i As Integer, j As Integer
            For i = 1 To 2 ^ Torneo_Rondas
                UI1 = Torneo_Luchadores(2 * (i - 1) + 1)
                UI2 = Torneo_Luchadores(2 * i)
                If (UI1 = -1) Then UI1 = UI2
                Torneo_Luchadores(i) = UI1
            Next i
            ReDim Preserve Torneo_Luchadores(1 To 2 ^ Torneo_Rondas) As Integer
            Call Rondas_Combate2vs2(1)
            Exit Sub
        End If
        Call Rondas_Combate2vs2(combate + 1)
        Exit Sub
    End If
    
    Call SendData(ToAll, 0, 0, "||Torneo Automático> " & UserList(UI1).Name & " - " & UserList(UserList(UI1).flags.Parejado2vs2).Name & " Vs. " & UserList(UI2).Name & " - " & UserList(UserList(UI2).flags.Parejado2vs2).Name & "." & FONTTYPE_TALK)
    
    CuentaME(1).Index = UI1
    CuentaME(1).Nick = UserList(UI1).Name
    CuentaME(2).Index = UserList(UI1).flags.pareja2vs2
    CuentaME(2).Nick = UserList(UserList(UI1).flags.Parejado2vs2).Name
    CuentaME(3).Index = UI2
    CuentaME(3).Nick = UserList(UI2).Name
    CuentaME(4).Index = UserList(UI2).flags.pareja2vs2
    CuentaME(4).Nick = UserList(UserList(UI2).flags.Parejado2vs2).Name
    
    MapData(99, 60, 55).Blocked = 1
    MapData(99, 59, 55).Blocked = 1
    MapData(99, 58, 55).Blocked = 1
    MapData(99, 58, 56).Blocked = 1
    
    MapData(99, 43, 44).Blocked = 1
    MapData(99, 43, 45).Blocked = 1
    MapData(99, 42, 45).Blocked = 1
    MapData(99, 41, 45).Blocked = 1
    
    Call RevivirUsuarioNPC(UserList(UI1).flags.pareja2vs2)
    Call RevivirUsuarioNPC(UserList(UI2).flags.pareja2vs2)
    Call RevivirUsuarioNPC(UI1)
    Call RevivirUsuarioNPC(UI2)
    
    cuentaTorneo2vs2 = 10
    Call WarpUserChar(UserList(UI1).flags.pareja2vs2, mapatorneo, esquina1xx, esquina1y, True)
    Call WarpUserChar(UserList(UI2).flags.pareja2vs2, mapatorneo, esquina2xx, esquina2y, True)
    Call WarpUserChar(UI1, mapatorneo, esquina1x, esquina1y, True)
    Call WarpUserChar(UI2, mapatorneo, esquina2x, esquina2y, True)
    
   'seteo a 0 antes de que setee los otros entonces no se bugea xD
   Pareja12vs2.User12vs2 = 0
   Pareja12vs2.User22vs2 = 0
   Pareja22vs2.User12vs2 = 0
   Pareja22vs2.User22vs2 = 0

   Pareja12vs2.User12vs2 = UI1
   Pareja12vs2.User22vs2 = UserList(UI1).flags.pareja2vs2

   Pareja22vs2.User12vs2 = UI2
   Pareja22vs2.User22vs2 = UserList(UI2).flags.pareja2vs2

    
errorh:

End Sub
Public Sub CCuentaTorneoAuto2vs2()

cuentaTorneo2vs2 = cuentaTorneo2vs2 - 1

If cuentaTorneo2vs2 = 0 Then
        Call SendData(ToIndex, CuentaME(1).Index, 7, "||Torneo automático> Comienza en YA!!!" & FONTTYPE_FIGHTT)
        Call SendData(ToIndex, CuentaME(2).Index, 7, "||Torneo automático> Comienza en YA!!!" & FONTTYPE_FIGHTT)
        Call SendData(ToIndex, CuentaME(3).Index, 7, "||Torneo automático> Comienza en YA!!!" & FONTTYPE_FIGHTT)
        Call SendData(ToIndex, CuentaME(4).Index, 7, "||Torneo automático> Comienza en YA!!!" & FONTTYPE_FIGHTT)
        MapData(99, 60, 55).Blocked = 0
        MapData(99, 59, 55).Blocked = 0
        MapData(99, 58, 55).Blocked = 0
        MapData(99, 58, 56).Blocked = 0
    
        MapData(99, 43, 44).Blocked = 0
        MapData(99, 43, 45).Blocked = 0
        MapData(99, 42, 45).Blocked = 0
        MapData(99, 41, 45).Blocked = 0
    Else
        Call SendData(ToIndex, CuentaME(1).Index, 7, "||Torneo automático> Comienza en " & cuentaTorneo2vs2 & ".." & FONTTYPE_INFO)
        Call SendData(ToIndex, CuentaME(2).Index, 7, "||Torneo automático> Comienza en " & cuentaTorneo2vs2 & ".." & FONTTYPE_INFO)
        Call SendData(ToIndex, CuentaME(3).Index, 7, "||Torneo automático> Comienza en " & cuentaTorneo2vs2 & ".." & FONTTYPE_INFO)
        Call SendData(ToIndex, CuentaME(4).Index, 7, "||Torneo automático> Comienza en " & cuentaTorneo2vs2 & ".." & FONTTYPE_INFO)
    End If
    
    
End Sub





