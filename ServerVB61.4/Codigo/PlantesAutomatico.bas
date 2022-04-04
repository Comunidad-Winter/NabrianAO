Attribute VB_Name = "TorneoPlanteAutomatico"
 
'director del proyecto: #Esteban(Neliam)

'servidor basado en fénixao 1.0
'medios de contacto:
'Skype: dc.esteban
'E-mail: nabrianao@gmail.com
Option Explicit
' Codigo: Torneos Automaticos 100%
' Adaptado por: Joaqoo
Public Torneo_Activop As Boolean
Public Torneo_Esperandop As Boolean
Private Torneo_Rondasp As Integer
Private Torneo_Luchadoresp() As Integer
 
Private Const mapatorneop As Integer = 107
' esquinas superior isquierda del ring
Private Const esquina1xp As Integer = 49
Private Const esquina1yp As Integer = 50
' esquina inferior derecha del ring
Private Const esquina2xp As Integer = 50
Private Const esquina2yp As Integer = 50
' Donde esperan los tios
Private Const esperaxp As Integer = 52
Private Const esperayp As Integer = 27
' Mapa desconecta
Private Const mapa_fuerap As Integer = 1
Private Const fueraesperayp As Integer = 50
Private Const fueraesperaxp As Integer = 35
 ' estas son las pocisiones de las 2 esquinas de la zona de espera, en su mapa tienen que tener en la misma posicion las 2 esquinas.
Private Const X1p As Integer = 36
Private Const X2p As Integer = 65
Private Const Y1p As Integer = 24
Private Const Y2p As Integer = 30

Public Type ToCUENTIII
 Index As Integer
 Nick As String
End Type

Public CuentaTorneoDePlante(1 To 2) As ToCUENTIII

Public CuentaDeTorneoPlante As Byte

 
Sub Torneoautop_Cancela()
On Error GoTo errorh:
    If (Not Torneo_Activop And Not Torneo_Esperandop) Then Exit Sub
    Torneo_Activop = False
    Torneo_Esperandop = False
    
    Call SendData(ToAll, 0, 0, "||Torneo Automático> Torneo cancelado por falta de participantes." & FONTTYPE_TALK)
    InscripcionCosto = 100000 'reiniciamos default 100k de oro de inscripcion
    OroDeLosInscriptos = 0 'Reiniciamos a 0 sino se acumula como 100kkk de oro xD!
    Dim i As Integer
     For i = LBound(Torneo_Luchadoresp) To UBound(Torneo_Luchadoresp)
                If (Torneo_Luchadoresp(i) <> -1) Then
                 Dim NuevaPos As WorldPos
                  Dim FuturePos As WorldPos
                    FuturePos.Map = mapa_fuerap
                    FuturePos.X = fueraesperaxp: FuturePos.y = fueraesperayp
                    Call ClosestLegalPos(FuturePos, NuevaPos)
                    If NuevaPos.X <> 0 And NuevaPos.y <> 0 Then Call WarpUserChar(Torneo_Luchadoresp(i), NuevaPos.Map, NuevaPos.X, NuevaPos.y, True)
                      UserList(Torneo_Luchadoresp(i)).flags.automaticop = False
                End If
        Next i
errorh:
End Sub
Sub Rondas_Cancelap()
On Error GoTo errorh
    If (Not Torneo_Activop And Not Torneo_Esperandop) Then Exit Sub
    Torneo_Activop = False
    Torneo_Esperandop = False

    Call SendData(ToAll, 0, 0, "||Torneo Automático> Torneo cancelado por Game Master." & FONTTYPE_TALK)
    InscripcionCosto = 100000 'reiniciamos default 100k de oro de inscripcion
    OroDeLosInscriptos = 0 'Reiniciamos a 0 sino se acumula como 100kkk de oro xD!
    Dim i As Integer
    For i = LBound(Torneo_Luchadoresp) To UBound(Torneo_Luchadoresp)
                If (Torneo_Luchadoresp(i) <> -1) Then
                        Dim NuevaPos As WorldPos
                  Dim FuturePos As WorldPos
                    FuturePos.Map = mapa_fuerap
                    FuturePos.X = fueraesperaxp: FuturePos.y = fueraesperayp
                    Call ClosestLegalPos(FuturePos, NuevaPos)
                    If NuevaPos.X <> 0 And NuevaPos.y <> 0 Then Call WarpUserChar(Torneo_Luchadoresp(i), NuevaPos.Map, NuevaPos.X, NuevaPos.y, True)
                    UserList(Torneo_Luchadoresp(i)).flags.automaticop = False
                End If
        Next i
errorh:
End Sub
Sub Rondas_UsuarioMuerep(ByVal Userindex As Integer, Optional Real As Boolean = True, Optional CambioMapa As Boolean = False)
On Error GoTo rondas_usuariomuerep_errorh
        Dim i As Integer, POS As Integer, j As Integer
        Dim combate As Integer, LI1 As Integer, LI2 As Integer
        Dim UI1 As Integer, UI2 As Integer
If (Not Torneo_Activop) Then
                Exit Sub
            ElseIf (Torneo_Activop And Torneo_Esperandop) Then
                For i = LBound(Torneo_Luchadoresp) To UBound(Torneo_Luchadoresp)
                    If (Torneo_Luchadoresp(i) = Userindex) Then
                        Torneo_Luchadoresp(i) = -1
                        Call WarpUserChar(Userindex, mapa_fuerap, fueraesperayp, fueraesperaxp, True)
                         UserList(Userindex).flags.automaticop = False
                        Exit Sub
                    End If
                Next i
                Exit Sub
            End If
 
        For POS = LBound(Torneo_Luchadoresp) To UBound(Torneo_Luchadoresp)
                If (Torneo_Luchadoresp(POS) = Userindex) Then Exit For
        Next POS
 
        ' si no lo ha encontrado
        If (Torneo_Luchadoresp(POS) <> Userindex) Then Exit Sub
       
 '  Ojo con esta parte, aqui es donde verifica si el usuario esta en la posicion de espera del torneo, en estas cordenadas tienen que fijarse al crear su Mapa de torneos.
 
'If UserList(UserIndex).POS.X >= X1p And UserList(UserIndex).POS.X <= X2p And UserList(UserIndex).POS.Y >= Y1p And UserList(UserIndex).POS.Y <= Y2p Then
If MapData(UserList(Userindex).POS.Map, UserList(Userindex).POS.X, UserList(Userindex).POS.y).trigger = 4 Then 'Si esta en zona de espera.
Call SendData(ToAll, 0, 0, "||Torneo Automático> " & UserList(Userindex).Name & " se fue del torneo mientras esperaba pelear." & FONTTYPE_BLANKO)
'Call WarpUserChar(Userindex, mapa_fuerap, fueraesperaxp, fueraesperayp, True)
UserList(Userindex).flags.automaticop = False
Torneo_Luchadoresp(POS) = -1
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
               ' Call WarpUserChar(Userindex, mapa_fuerap, fueraesperaxp, fueraesperayp, True)
                 UserList(Userindex).flags.automaticop = False
        ElseIf (Not CambioMapa) Then
             
                ' Call WarpUserChar(Userindex, mapa_fuerap, fueraesperaxp, fueraesperayp, True)
                  UserList(Userindex).flags.automaticop = False
        End If
 
        'se le borra de la lista y se mueve el segundo a li1
        If (Torneo_Luchadoresp(LI1) = Userindex) Then
                Torneo_Luchadoresp(LI1) = Torneo_Luchadoresp(LI2) 'cambiamos slot
                Torneo_Luchadoresp(LI2) = -1
        Else
                Torneo_Luchadoresp(LI2) = -1
        End If
 
    'si es la ultima ronda
  If (Torneo_Rondasp = 1) Then
        If AutomaticoCanjes = 1 Then Call WarpUserChar(Torneo_Luchadoresp(LI1), 198, 23, 64, True)
        If AutomaticoCanjes = 0 Then Call WarpUserChar(Torneo_Luchadoresp(LI1), 1, 50, 50, True)
        Call SendData(ToAll, 0, 0, "||Torneo Automático> Gana " & UserList(Torneo_Luchadoresp(LI1)).Name & " Gano " & PonerPuntos(OroDeLosInscriptos) & " monedas de oro, 1 torneo y +" & CantAutop & " puntos de reputación." & FONTTYPE_PARTY)
        UserList(Torneo_Luchadoresp(LI1)).Stats.GLD = UserList(Torneo_Luchadoresp(LI1)).Stats.GLD + OroDeLosInscriptos
        UserList(Torneo_Luchadoresp(LI1)).Stats.Reputacion = UserList(Torneo_Luchadoresp(LI1)).Stats.Reputacion + CantAutop
        Call SendUserORO(Torneo_Luchadoresp(LI1))
        Call SendUserREP(Torneo_Luchadoresp(LI1))
        If CantAutop = 2 Or CantAutop = 4 Then
        Call SendData(ToAll, 0, 0, "||Torneo Automático> No se le otorgo el punto de torneo debido a que fue un torneo de pocos participantes." & FONTTYPE_FIGHTT)
        Else
        UserList(Torneo_Luchadoresp(LI1)).Faccion.torneos = UserList(Torneo_Luchadoresp(LI1)).Faccion.torneos + 1
        End If
        InscripcionCosto = 100000 'reiniciamos default 100k de oro de inscripcion
        OroDeLosInscriptos = 0 'Reiniciamos a 0 sino se acumula como 100kkk de oro xD!
         UserList(Torneo_Luchadoresp(LI1)).flags.automaticop = False
 
        Call SendData(ToIndex, Torneo_Luchadoresp(LI1), 0, "GANADORE")
           
       
      ' Call SendUserStatsBox(Torneo_Luchadoresp(LI1))
        Torneo_Activop = False
        Exit Sub
    Else
        'a su compañero se le teleporta dentro, condicional por seguridad
        Call WarpUserChar(Torneo_Luchadoresp(LI1), mapatorneop, esperaxp, esperayp, True)
    End If
 
               
        'si es el ultimo combate de la ronda
        If (2 ^ Torneo_Rondasp = 2 * combate) Then
 
           
                Torneo_Rondasp = Torneo_Rondasp - 1
 
        'antes de llamar a la proxima ronda hay q copiar a los tipos
        For i = 1 To 2 ^ Torneo_Rondasp
                UI1 = Torneo_Luchadoresp(2 * (i - 1) + 1)
                UI2 = Torneo_Luchadoresp(2 * i)
                If (UI1 = -1) Then UI1 = UI2
                Torneo_Luchadoresp(i) = UI1
        Next i
ReDim Preserve Torneo_Luchadoresp(1 To 2 ^ Torneo_Rondasp) As Integer
        Call Rondas_Combatep(1)
        Exit Sub
        End If
 
        'vamos al siguiente combate
        Call Rondas_Combatep(combate + 1)
rondas_usuariomuerep_errorh:
 
End Sub
 
 
 
Sub Rondas_UsuarioDesconectap(ByVal Userindex As Integer)
On Error GoTo errorh
'Call SendUserStatsBox(Userindex)

        Call Rondas_UsuarioMuerep(Userindex, False, False)
errorh:
End Sub
 
 
 
Sub Rondas_UsuarioCambiamapap(ByVal Userindex As Integer)
On Error GoTo errorh
        Call Rondas_UsuarioMuerep(Userindex, False, True)
errorh:
End Sub
 
Sub torneos_autop(ByVal rondasp As Integer)
On Error GoTo errorh
If (Torneo_Activop) Then
               
                Exit Sub
        End If
          Call SendData(ToAll, 0, 0, "||Esta empezando un nuevo torneo automático para " & val(2 ^ rondasp) & " participantes!! para participar tipeá /PARTICIPAR el costo de inscripcion es de " & PonerPuntos(InscripcionCosto) & " monedas de oro" & FONTTYPE_TALK)
        Call SendData(ToAll, 0, 0, "TW123")
       
        Torneo_Rondasp = rondasp
        Torneo_Activop = True
        Torneo_Esperandop = True
 
        ReDim Torneo_Luchadoresp(1 To 2 ^ rondasp) As Integer
        Dim i As Integer
        For i = LBound(Torneo_Luchadoresp) To UBound(Torneo_Luchadoresp)
                Torneo_Luchadoresp(i) = -1
        Next i
errorh:
End Sub
 
Sub Torneos_Iniciap(ByVal Userindex As Integer, ByVal rondasp As Integer)
On Error GoTo errorh
        If (Torneo_Activop) Then
                Call SendData(ToIndex, Userindex, 0, "||Ya hay un torneo!." & FONTTYPE_INFO)
                Exit Sub
        End If
        Call SendData(ToAll, 0, 0, "||Comenzo un nuevo torneo automático para " & val(2 ^ rondasp) & " participantes!! para participar tipeá /PARTICIPAR el costo de inscripcion es de " & PonerPuntos(InscripcionCosto) & " monedas de oro" & FONTTYPE_TALK)
        Call SendData(ToAll, 0, 0, "TW123")
       
        Torneo_Rondasp = rondasp
        Torneo_Activop = True
        Torneo_Esperandop = True
 
        ReDim Torneo_Luchadoresp(1 To 2 ^ rondasp) As Integer
        Dim i As Integer
        For i = LBound(Torneo_Luchadoresp) To UBound(Torneo_Luchadoresp)
                Torneo_Luchadoresp(i) = -1
        Next i
errorh:
End Sub
 
 
 
Sub Torneos_Entrap(ByVal Userindex As Integer)
On Error GoTo errorh
        Dim i As Integer
       
        If (Not Torneo_Activop) Then
               
                Exit Sub
        End If
    
       
        If (Not Torneo_Esperandop) Then
               ' Call SendData(ToIndex, Userindex, 0, "||El torneo ya ha empezado, te quedaste fuera!." & FONTTYPE_INFO)
                Exit Sub
        End If
        
        If UserList(Userindex).Stats.GLD < InscripcionCosto Then
        Call SendData(ToIndex, Userindex, 0, "||No tienes suficiente oro para la inscripción: " & PonerPuntos(InscripcionCosto) & " monedas de oro." & FONTTYPE_INFO)
        Exit Sub
        End If
       
        For i = LBound(Torneo_Luchadoresp) To UBound(Torneo_Luchadoresp)
                If (Torneo_Luchadoresp(i) = Userindex) Then
                      '  Call SendData(ToIndex, Userindex, 0, "||Ya estas dentro!" & FONTTYPE_WARNING)
                        Exit Sub
                End If
        Next i
 
        For i = LBound(Torneo_Luchadoresp) To UBound(Torneo_Luchadoresp)
        If (Torneo_Luchadoresp(i) = -1) Then
                Torneo_Luchadoresp(i) = Userindex
                 Dim NuevaPos As WorldPos
                  Dim FuturePos As WorldPos
                    FuturePos.Map = mapatorneop
                    FuturePos.X = esperaxp: FuturePos.y = esperayp
                    Call ClosestLegalPos(FuturePos, NuevaPos)
                   
                    If NuevaPos.X <> 0 And NuevaPos.y <> 0 Then Call WarpUserChar(Torneo_Luchadoresp(i), NuevaPos.Map, NuevaPos.X, NuevaPos.y, True)
                 UserList(Torneo_Luchadoresp(i)).flags.automaticop = True
                 
                 UserList(Userindex).Stats.GLD = UserList(Userindex).Stats.GLD - InscripcionCosto
                 Call SendUserORO(Userindex)
                 OroDeLosInscriptos = OroDeLosInscriptos + InscripcionCosto
                 
                Call SendData(ToAll, 0, 0, "||Torneo Automático> Entra " & UserList(Userindex).Name & "" & FONTTYPE_INFO)
              If AutomaticoCanjesp = 1 Then
If UserList(Userindex).Invent.ArmourEqpObjIndex Then Call Desequipar(Userindex, UserList(Userindex).Invent.ArmourEqpSlot)
If UserList(Userindex).Invent.WeaponEqpObjIndex Then Call Desequipar(Userindex, UserList(Userindex).Invent.WeaponEqpSlot)
If UserList(Userindex).Invent.EscudoEqpObjIndex Then Call Desequipar(Userindex, UserList(Userindex).Invent.EscudoEqpSlot)
If UserList(Userindex).Invent.CascoEqpObjIndex Then Call Desequipar(Userindex, UserList(Userindex).Invent.CascoEqpSlot)
If UserList(Userindex).Invent.HerramientaEqpObjIndex Then Call Desequipar(Userindex, UserList(Userindex).Invent.HerramientaEqpslot)
If UserList(Userindex).Invent.MunicionEqpObjIndex Then Call Desequipar(Userindex, UserList(Userindex).Invent.MunicionEqpSlot)
             End If
                If (i = UBound(Torneo_Luchadoresp)) Then
                 Call SendData(ToAll, 0, 0, "||Torneo Automático> ¡Empieza el torneo!" & FONTTYPE_ORO)

                Torneo_Esperandop = False
                Call Rondas_Combatep(1)
     
                End If
                  Exit Sub
        End If
        Next i
errorh:
End Sub
 
 
Sub Rondas_Combatep(combate As Integer)
On Error GoTo errorh
Dim UI1 As Integer, UI2 As Integer
    UI1 = Torneo_Luchadoresp(2 * (combate - 1) + 1)
    UI2 = Torneo_Luchadoresp(2 * combate)
   
    If (UI2 = -1) Then
        UI2 = Torneo_Luchadoresp(2 * (combate - 1) + 1)
        UI1 = Torneo_Luchadoresp(2 * combate)
    End If
   
    If (UI1 = -1) Then
        Call SendData(ToAll, 0, 0, "||Torneo Automático> combate anulado porque un participante involucrado se desconecto." & FONTTYPE_BLANKO)
            If (Torneo_Rondasp = 1) Then
        If (UI2 <> -1) Then
        Call SendData(ToAll, 0, 0, "||Torneo Automático> Torneo terminado. Ganador del torneo por eliminacion: " & UserList(UI2).Name & FONTTYPE_TALK)
        Call SendData(ToAll, 0, 0, "||Premio> " & PonerPuntos(OroDeLosInscriptos) & " monedas de oro +" & CantAutop & " puntos de reputación." & FONTTYPE_PARTY)
        If CantAutop = 2 Or CantAutop = 4 Then
        Call SendData(ToAll, 0, 0, "||Torneo Automático> No se le otorgo el punto de torneo debido a que fue un torneo de pocos participantes." & FONTTYPE_FIGHTT)
        Else
        UserList(UI2).Faccion.torneos = UserList(UI2).Faccion.torneos + 1
        End If
        UserList(UI2).flags.automatico = False
        UserList(UI2).Stats.GLD = UserList(UI2).Stats.GLD + OroDeLosInscriptos
        UserList(UI2).Stats.Reputacion = UserList(UI2).Stats.Reputacion + CantAutop
        Call SendUserORO(UI2)
        Call SendUserREP(UI2)
         InscripcionCosto = 100000 'reiniciamos default 100k de oro de inscripcion
         OroDeLosInscriptos = 0 'Reiniciamos a 0 sino se acumula como 100kkk de oro xD!
         If AutomaticoCanjes = 1 Then Call WarpUserChar(UI2, 198, 23, 64, True)
         If AutomaticoCanjes = 0 Then Call WarpUserChar(UI2, 1, 50, 50, True)
         Call SendData(ToIndex, UI2, 0, "GANADORE")
        ' dale_recompensa()
        Torneo_Activop = False
       Exit Sub
    End If
            Call SendData(ToAll, 0, 0, "||Torneo Automático> Torneo terminado. No hay ganador porque todos se fueron." & FONTTYPE_BLANKO)
         InscripcionCosto = 100000 'reiniciamos default 100k de oro de inscripcion
         OroDeLosInscriptos = 0 'Reiniciamos a 0 sino se acumula como 100kkk de oro xD!
            Exit Sub
        End If
        If (UI2 <> -1) Then _
            Call SendData(ToAll, 0, 0, "||Torneo Automático> " & UserList(UI2).Name & " pasa al siguiente combate." & FONTTYPE_WARNING)
    
        If (2 ^ Torneo_Rondasp = 2 * combate) Then
        
            Torneo_Rondasp = Torneo_Rondasp - 1
            'antes de llamar a la proxima ronda hay q copiar a los tipos
            Dim i As Integer, j As Integer
            For i = 1 To 2 ^ Torneo_Rondasp
                UI1 = Torneo_Luchadoresp(2 * (i - 1) + 1)
                UI2 = Torneo_Luchadoresp(2 * i)
                If (UI1 = -1) Then UI1 = UI2
                Torneo_Luchadoresp(i) = UI1
            Next i
            ReDim Preserve Torneo_Luchadoresp(1 To 2 ^ Torneo_Rondasp) As Integer
            Call Rondas_Combatep(1)
            Exit Sub
        End If
        Call Rondas_Combatep(combate + 1)
        Exit Sub
    End If
 
    Call SendData(ToAll, 0, 0, "||Torneo Automático> " & UserList(UI1).Name & " Vs. " & UserList(UI2).Name & ". Peleen!" & FONTTYPE_TALK)
    MapInfo(107).Pk = False
    CuentaTorneoDePlante(1).Index = UI1
    CuentaTorneoDePlante(1).Nick = UserList(UI1).Name
    CuentaTorneoDePlante(2).Index = UI2
    CuentaTorneoDePlante(2).Nick = UserList(UI2).Name
    CuentaDeTorneoPlante = 10
    Call WarpUserChar(UI1, mapatorneop, esquina1xp, esquina1yp, True)
    Call WarpUserChar(UI2, mapatorneop, esquina2xp, esquina2yp, True)
errorh:
End Sub

Public Sub cCuentaTorneoPlante()

CuentaDeTorneoPlante = CuentaDeTorneoPlante - 1

If CuentaDeTorneoPlante = 0 Then
        Call SendData(ToIndex, CuentaTorneoDePlante(1).Index, 7, "||Torneo automático> YA!!!" & FONTTYPE_WARNING)
        Call SendData(ToIndex, CuentaTorneoDePlante(2).Index, 7, "||Torneo automático> YA!!!" & FONTTYPE_WARNING)
        MapInfo(107).Pk = True
    Else
        Call SendData(ToIndex, CuentaTorneoDePlante(1).Index, 7, "||Torneo automático> Comienza en " & CuentaDeTorneoPlante & ".." & FONTTYPE_INFO)
        Call SendData(ToIndex, CuentaTorneoDePlante(2).Index, 7, "||Torneo automático> Comienza en " & CuentaDeTorneoPlante & ".." & FONTTYPE_INFO)
    End If
    
    
End Sub
