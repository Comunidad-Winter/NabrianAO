Attribute VB_Name = "Torneo1vs1Automatico"
 
'director del proyecto: #Esteban(Neliam)

'servidor basado en fénixao 1.0
'medios de contacto:
'Skype: dc.esteban
'E-mail: nabrianao@gmail.com
Option Explicit
' Codigo: Torneos Automaticos 100%
' Autor: Joan Calderón - SaturoS.
Public Torneo_Activo As Boolean
Public Torneo_Esperando As Boolean
Private Torneo_Rondas As Integer
Private Torneo_Luchadores() As Integer
 
Private Const mapatorneo As Integer = 99
' esquinas superior isquierda del ring
Private Const esquina1x As Integer = 41
Private Const esquina1y As Integer = 44
' esquina inferior derecha del ring
Private Const esquina2x As Integer = 60
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
 
Sub Torneoauto_Cancela()
On Error GoTo errorh:
    If (Not Torneo_Activo And Not Torneo_Esperando) Then Exit Sub
    Torneo_Activo = False
    Torneo_Esperando = False
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
                      UserList(Torneo_Luchadores(i)).flags.automatico = False
                End If
        Next i
errorh:
End Sub
Sub Rondas_Cancela()
On Error GoTo errorh
    If (Not Torneo_Activo And Not Torneo_Esperando) Then Exit Sub
    Torneo_Activo = False
    Torneo_Esperando = False
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
                    UserList(Torneo_Luchadores(i)).flags.automatico = False
                End If
        Next i
errorh:
End Sub
Sub Rondas_UsuarioMuere(ByVal Userindex As Integer, Optional Real As Boolean = True, Optional CambioMapa As Boolean = False)
On Error GoTo rondas_usuariomuere_errorh
        Dim i As Integer, POS As Integer, j As Integer
        Dim combate As Integer, LI1 As Integer, LI2 As Integer
        Dim UI1 As Integer, UI2 As Integer
If (Not Torneo_Activo) Then
                Exit Sub
            ElseIf (Torneo_Activo And Torneo_Esperando) Then
                For i = LBound(Torneo_Luchadores) To UBound(Torneo_Luchadores)
                    If (Torneo_Luchadores(i) = Userindex) Then
                        Torneo_Luchadores(i) = -1
                        Call WarpUserChar(Userindex, mapa_fuera, fueraesperay, fueraesperax, True)
                         UserList(Userindex).flags.automatico = False
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
Call SendData(ToAll, 0, 0, "||Torneo Automático> " & UserList(Userindex).Name & " se fue del torneo mientras esperaba pelear." & FONTTYPE_BLANKO)
'Call WarpUserChar(Userindex, mapa_fuera, fueraesperax, fueraesperay, True)
UserList(Userindex).flags.automatico = False
Torneo_Luchadores(POS) = -1
Exit Sub
End If
 
        combate = 1 + (POS - 1) \ 2
 
        'ponemos li1 y li2 (luchador index) de los que combatian
        LI1 = 2 * (combate - 1) + 1
        LI2 = LI1 + 1
 
        'se informa a la gente
        If (Real) Then
                Call SendData(ToAll, 0, 0, "||Torneo Automático> " & UserList(Userindex).Name & " pierde el combate." & FONTTYPE_BLANKO)
        Else
                Call SendData(ToAll, 0, 0, "||Torneo Automático> " & UserList(Userindex).Name & " se fue del combate." & FONTTYPE_BLANKO)
        End If
 
        'se le teleporta fuera si murio
        If (Real) Then
                'Call WarpUserChar(Userindex, mapa_fuera, fueraesperax, fueraesperay, True)
                 UserList(Userindex).flags.automatico = False
        ElseIf (Not CambioMapa) Then
             
              '   Call WarpUserChar(Userindex, mapa_fuera, fueraesperax, fueraesperay, True)
                  UserList(Userindex).flags.automatico = False
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
        If AutomaticoCanjes = 1 Then Call WarpUserChar(Torneo_Luchadores(LI1), 198, 23, 64, True)
        If AutomaticoCanjes = 0 Then Call WarpUserChar(Torneo_Luchadores(LI1), 1, 50, 50, True)
        Call SendData(ToAll, 0, 0, "||Torneo Automático> Gana " & UserList(Torneo_Luchadores(LI1)).Name & " Gano " & PonerPuntos(OroDeLosInscriptos) & " monedas de oro, 1 torneo y +" & CantAuto & " puntos de reputación." & FONTTYPE_PARTY)
        UserList(Torneo_Luchadores(LI1)).Stats.GLD = UserList(Torneo_Luchadores(LI1)).Stats.GLD + OroDeLosInscriptos
        UserList(Torneo_Luchadores(LI1)).Stats.Reputacion = UserList(Torneo_Luchadores(LI1)).Stats.Reputacion + CantAuto
        Call SendUserORO(Torneo_Luchadores(LI1))
        Call SendUserREP(Torneo_Luchadores(LI1))
        If CantAuto = 2 Or CantAuto = 4 Then
        Call SendData(ToAll, 0, 0, "||Torneo Automático> No se le otorgo el punto de torneo debido a que fue un torneo de pocos participantes." & FONTTYPE_FIGHTT)
        Else
        UserList(Torneo_Luchadores(LI1)).Faccion.torneos = UserList(Torneo_Luchadores(LI1)).Faccion.torneos + 1
        End If
         UserList(Torneo_Luchadores(LI1)).flags.automatico = False
         Call SendData(ToIndex, Torneo_Luchadores(LI1), 0, "GANADORE")
         ClaseTorneo = "TODAS" 'reiniciamos clase
         InscripcionCosto = 100000 'reiniciamos default 100k de oro de inscripcion
         OroDeLosInscriptos = 0 'Reiniciamos a 0 sino se acumula como 100kkk de oro xD!
     '  Call SendUserStatsBox(Torneo_Luchadores(LI1))

        Torneo_Activo = False
        Exit Sub
    Else
        'a su compañero se le teleporta dentro, condicional por seguridad
        Call WarpUserChar(Torneo_Luchadores(LI1), mapatorneo, esperax, esperay, True)
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
        Call Rondas_Combate(1)
        Exit Sub
        End If
 
        'vamos al siguiente combate
        Call Rondas_Combate(combate + 1)
rondas_usuariomuere_errorh:
 
End Sub
 
 
 
Sub Rondas_UsuarioDesconecta(ByVal Userindex As Integer)
On Error GoTo errorh

'Call SendUserStatsBox(Userindex)

        Call Rondas_UsuarioMuere(Userindex, False, False)
errorh:
End Sub
 
Sub Rondas_UsuarioCambiamapa(ByVal Userindex As Integer)
On Error GoTo errorh
        Call Rondas_UsuarioMuere(Userindex, False, True)
errorh:
End Sub
 
Sub torneos_auto(ByVal rondas As Integer)
On Error GoTo errorh
If (Torneo_Activo) Then
               
                Exit Sub
        End If
        Call SendData(ToAll, 0, 0, "||!!! Comenzo nuevo torneo 1vs1 de " & val(2 ^ rondas) & " participantes!! para participar tipeá /PARTICIPAR el costo de inscripcion es de " & PonerPuntos(InscripcionCosto) & " monedas de oro ¡¡¡" & FONTTYPE_TALK)
        Call SendData(ToAll, 0, 0, "TW123")
       
        Torneo_Rondas = rondas
        Torneo_Activo = True
        Torneo_Esperando = True
 
        ReDim Torneo_Luchadores(1 To 2 ^ rondas) As Integer
        Dim i As Integer
        For i = LBound(Torneo_Luchadores) To UBound(Torneo_Luchadores)
                Torneo_Luchadores(i) = -1
        Next i
errorh:
End Sub
 
Sub Torneos_Inicia(ByVal Userindex As Integer, ByVal rondas As Integer)
On Error GoTo errorh
        If (Torneo_Activo) Then
                Call SendData(ToIndex, Userindex, 0, "||Ya hay un torneo!." & FONTTYPE_INFO)
                Exit Sub
        End If
        Call SendData(ToAll, 0, 0, "||!!! Comenzo un nuevo torneo 1vs1 de " & val(2 ^ rondas) & " participantes!! para participar tipeá /PARTICIPAR el costo de inscripcion es de " & PonerPuntos(InscripcionCosto) & " monedas de oro ¡¡¡" & FONTTYPE_TALK)
        Call SendData(ToAll, 0, 0, "TW123")
        
        Torneo_Rondas = rondas
        Torneo_Activo = True
        Torneo_Esperando = True
        
        ReDim Torneo_Luchadores(1 To 2 ^ rondas) As Integer
        Dim i As Integer
        For i = LBound(Torneo_Luchadores) To UBound(Torneo_Luchadores)
                Torneo_Luchadores(i) = -1
        Next i
errorh:
End Sub
 
 
 
Sub Torneos_Entra(ByVal Userindex As Integer)
On Error GoTo errorh
        Dim i As Integer

       
        If (Not Torneo_Activo) Then
        
                Exit Sub
        End If
        

       If UserList(Userindex).Clase = GUERRERO Then Exit Sub
       
        If (Not Torneo_Esperando) Then
                'Call SendData(ToIndex, Userindex, 0, "||El torneo ya ha empezado, te quedaste fuera!." & FONTTYPE_INFO)
                Exit Sub
        End If
        
        If Not ClaseTorneo = "TODAS" Then
        If Not UserList(Userindex).Clase = ClaseTorneovariable Then
        Call SendData(ToIndex, Userindex, 0, "||El torneo es solo para la clase: " & ClaseTorneo & "." & FONTTYPE_INFO)
        Exit Sub
        End If
        End If
        
        If UserList(Userindex).Stats.GLD < InscripcionCosto Then
        Call SendData(ToIndex, Userindex, 0, "||No tienes suficiente oro para la inscripción: " & PonerPuntos(InscripcionCosto) & " monedas de oro." & FONTTYPE_INFO)
        Exit Sub
        End If
       
        For i = LBound(Torneo_Luchadores) To UBound(Torneo_Luchadores)
                If (Torneo_Luchadores(i) = Userindex) Then
                        'Call SendData(ToIndex, Userindex, 0, "||Ya estas dentro!" & FONTTYPE_WARNING)
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
                 UserList(Torneo_Luchadores(i)).flags.automatico = True
                 UserList(Userindex).Stats.GLD = UserList(Userindex).Stats.GLD - InscripcionCosto
                Call SendUserORO(Userindex)

                OroDeLosInscriptos = OroDeLosInscriptos + InscripcionCosto
                 Call SendData(ToAll, 0, 0, "||Torneo Automático> Entra " & UserList(Userindex).Name & "" & FONTTYPE_INFO)
                If AutomaticoCanjes = 1 Then
If UserList(Userindex).Invent.ArmourEqpObjIndex Then Call Desequipar(Userindex, UserList(Userindex).Invent.ArmourEqpSlot)
If UserList(Userindex).Invent.WeaponEqpObjIndex Then Call Desequipar(Userindex, UserList(Userindex).Invent.WeaponEqpSlot)
If UserList(Userindex).Invent.EscudoEqpObjIndex Then Call Desequipar(Userindex, UserList(Userindex).Invent.EscudoEqpSlot)
If UserList(Userindex).Invent.CascoEqpObjIndex Then Call Desequipar(Userindex, UserList(Userindex).Invent.CascoEqpSlot)
If UserList(Userindex).Invent.HerramientaEqpObjIndex Then Call Desequipar(Userindex, UserList(Userindex).Invent.HerramientaEqpslot)
If UserList(Userindex).Invent.MunicionEqpObjIndex Then Call Desequipar(Userindex, UserList(Userindex).Invent.MunicionEqpSlot)
                End If
                
                If (i = UBound(Torneo_Luchadores)) Then
                Call SendData(ToAll, 0, 0, "||Torneo Automático> ¡Empieza el torneo!" & FONTTYPE_ORO)
                Torneo_Esperando = False
                Call Rondas_Combate(1)
                
                End If
                  Exit Sub
        End If
        Next i
errorh:
End Sub
 
 
Sub Rondas_Combate(combate As Integer)
On Error GoTo errorh
Dim UI1 As Integer, UI2 As Integer
    UI1 = Torneo_Luchadores(2 * (combate - 1) + 1)
    UI2 = Torneo_Luchadores(2 * combate)
   
    If (UI2 = -1) Then
        UI2 = Torneo_Luchadores(2 * (combate - 1) + 1)
        UI1 = Torneo_Luchadores(2 * combate)
    End If
   
   If UI1 = -1 Then
        Call SendData(ToAll, 0, 0, "||Torneo Automático> Combate anulado porque un participante involucrado se desconecto" & FONTTYPE_BLANKO)
        
         If (Torneo_Rondas = 1) Then
        If (UI2 <> -1) Then
        Call SendData(ToAll, 0, 0, "||Torneo Automático> Torneo terminado. Ganador del torneo por eliminacion: " & UserList(UI2).Name & FONTTYPE_TALK)
        Call SendData(ToAll, 0, 0, "||Premio> " & PonerPuntos(OroDeLosInscriptos) & " monedas de oro +" & CantAuto & " puntos de reputación." & FONTTYPE_PARTY)
        If CantAuto = 2 Or CantAuto = 4 Then
        Call SendData(ToAll, 0, 0, "||Torneo Automático> No se le otorgo el punto de torneo debido a que fue un torneo de pocos participantes." & FONTTYPE_FIGHTT)
        Else
        UserList(UI2).Faccion.torneos = UserList(UI2).Faccion.torneos + 1
        End If
        UserList(UI2).flags.automatico = False
        UserList(UI2).Stats.GLD = UserList(UI2).Stats.GLD + OroDeLosInscriptos
        UserList(UI2).Stats.Reputacion = UserList(UI2).Stats.Reputacion + CantAuto
        Call SendUserORO(UI2)
        Call SendUserREP(UI2)
        If AutomaticoCanjes = 1 Then Call WarpUserChar(UI2, 198, 23, 64, True)
        If AutomaticoCanjes = 0 Then Call WarpUserChar(UI2, 1, 50, 50, True)
        Call SendData(ToIndex, UI2, 0, "GANADORE")
        ClaseTorneo = "TODAS" 'reiniciamos clase
         InscripcionCosto = 100000 'reiniciamos default 100k de oro de inscripcion
         OroDeLosInscriptos = 0 'Reiniciamos a 0 sino se acumula como 100kkk de oro xD!
        ' dale_recompensa()
        Torneo_Activo = False
       Exit Sub
    End If
            Call SendData(ToAll, 0, 0, "||Torneo Automático> Torneo terminado. No hay ganador porque todos se fueron." & FONTTYPE_BLANKO)
            ClaseTorneo = "TODAS" 'reiniciamos clase
            InscripcionCosto = 100000 'reiniciamos default 100k de oro de inscripcion
            OroDeLosInscriptos = 0 'Reiniciamos a 0 sino se acumula como 100kkk de oro xD!
             Exit Sub
        End If
        If (UI2 <> -1) Then _
            Call SendData(ToAll, 0, 0, "||Torneo Automático> " & UserList(UI2).Name & " pasa a la siguiente ronda!" & FONTTYPE_WARNING)
   
        If (2 ^ Torneo_Rondas = 2 * combate) Then
            'Call SendData(ToAll, 0, 0, "||Siguiente ronda!" & FONTTYPE_TALK)
            Torneo_Rondas = Torneo_Rondas - 1
            'antes de llamar a la proxima ronda hay q copiar a los tipos
            Dim i As Integer, j As Integer
            For i = 1 To 2 ^ Torneo_Rondas
                UI1 = Torneo_Luchadores(2 * (i - 1) + 1)
                UI2 = Torneo_Luchadores(2 * i)
                If (UI1 = -1) Then UI1 = UI2
                Torneo_Luchadores(i) = UI1
            Next i
            ReDim Preserve Torneo_Luchadores(1 To 2 ^ Torneo_Rondas) As Integer
            Call Rondas_Combate(1)
            Exit Sub
        End If
        Call Rondas_Combate(combate + 1)
        Exit Sub
    End If
 
    Call SendData(ToAll, 0, 0, "||Torneo Automático> " & UserList(UI1).Name & " versus " & UserList(UI2).Name & ". Esquinas! Comienza!" & FONTTYPE_TALK)
 
    Call WarpUserChar(UI1, mapatorneo, esquina1x, esquina1y, True)
    Call WarpUserChar(UI2, mapatorneo, esquina2x, esquina2y, True)
errorh:

End Sub
 



