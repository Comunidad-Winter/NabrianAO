Attribute VB_Name = "carrerasAutomaticas"
Option Explicit
' Codigo: Torneos Automaticos 100%
' Autor: Joan Calderón - SaturoS.
Public Torneo_ActivoC As Boolean
Public Torneo_EsperandoC As Boolean
Private Torneo_RondasC As Integer
Private Torneo_LuchadoresC() As Integer
 
Private Const mapatorneoC As Integer = 30
' esquinas superior isquierda del ring
Private Const esquina1xC As Integer = 51
Private Const esquina1yC As Integer = 77
' esquina inferior derecha del ring
Private Const esquina2xC As Integer = 59
Private Const esquina2yC As Integer = 77
' Donde esperan los tios
Private Const esperaxC As Integer = 27
Private Const esperayC As Integer = 85
' Mapa desconecta
Private Const mapa_fueraC As Integer = 1
Private Const fueraesperayC As Integer = 52
Private Const fueraesperaxC As Integer = 52
 ' estas son las pocisiones de las 2 esquinas de la zona de espera, en su mapa tienen que tener en la misma posicion las 2 esquinas.
Private Const X1C As Integer = 15
Private Const X2C As Integer = 44
Private Const Y1C As Integer = 82
Private Const Y2C As Integer = 88
 
Sub Torneoauto_CancelaC()
On Error GoTo errorh:
    If (Not Torneo_ActivoC And Not Torneo_EsperandoC) Then Exit Sub
    Torneo_ActivoC = False
    Torneo_EsperandoC = False
    frmMain.Carreras.Enabled = True

    Call SendData(ToAll, 0, 0, "||Carreras> canceladas por falta de participantes." & FONTTYPE_FENIZ)
    Dim i As Integer
     For i = LBound(Torneo_LuchadoresC) To UBound(Torneo_LuchadoresC)
                If (Torneo_LuchadoresC(i) <> -1) Then
                 Dim NuevaPos As WorldPos
                  Dim FuturePos As WorldPos
                    FuturePos.Map = mapa_fueraC
                    FuturePos.X = fueraesperaxC: FuturePos.Y = fueraesperayC
                    Call ClosestLegalPos(FuturePos, NuevaPos)
                    If NuevaPos.X <> 0 And NuevaPos.Y <> 0 Then Call WarpUserChar(Torneo_LuchadoresC(i), NuevaPos.Map, NuevaPos.X, NuevaPos.Y, True)
                      UserList(Torneo_LuchadoresC(i)).flags.Carreras = False
                End If
        Next i
errorh:
End Sub
Sub Rondas_CancelaC()
On Error GoTo errorh
    If (Not Torneo_ActivoC And Not Torneo_EsperandoC) Then Exit Sub
    Torneo_ActivoC = False
    Torneo_EsperandoC = False
    frmMain.Carreras.Enabled = True
  
    Call SendData(ToAll, 0, 0, "||Carreras> canceladas por Game Master" & FONTTYPE_FENIZ)
  
    Dim i As Integer
    For i = LBound(Torneo_LuchadoresC) To UBound(Torneo_LuchadoresC)
                If (Torneo_LuchadoresC(i) <> -1) Then
                        Dim NuevaPos As WorldPos
                  Dim FuturePos As WorldPos
                    FuturePos.Map = mapa_fueraC
                    FuturePos.X = fueraesperaxC: FuturePos.Y = fueraesperayC
                    Call ClosestLegalPos(FuturePos, NuevaPos)
                    If NuevaPos.X <> 0 And NuevaPos.Y <> 0 Then Call WarpUserChar(Torneo_LuchadoresC(i), NuevaPos.Map, NuevaPos.X, NuevaPos.Y, True)
                    UserList(Torneo_LuchadoresC(i)).flags.Carreras = False
                End If
        Next i
errorh:
End Sub
Sub Rondas_UsuarioMuereC(ByVal UserIndex As Integer, Optional Real As Boolean = True, Optional CambioMapa As Boolean = False)
On Error GoTo Rondas_UsuarioMuereC_errorh
        Dim i As Integer, POS As Integer, j As Integer
        Dim combate As Integer, LI1 As Integer, LI2 As Integer
        Dim UI1 As Integer, UI2 As Integer
    
If MapData(UserList(UserIndex).POS.Map, UserList(UserIndex).POS.X, UserList(UserIndex).POS.Y).trigger = 3 Or MapData(UserList(UserIndex).POS.Map, UserList(UserIndex).POS.X, UserList(UserIndex).POS.Y).trigger = 4 Then Exit Sub
If (Not Torneo_ActivoC) Then
                Exit Sub
            ElseIf (Torneo_ActivoC And Torneo_EsperandoC) Then
                For i = LBound(Torneo_LuchadoresC) To UBound(Torneo_LuchadoresC)
                    If (Torneo_LuchadoresC(i) = UserIndex) Then
                        Torneo_LuchadoresC(i) = -1
                        Call WarpUserChar(UserIndex, mapa_fueraC, fueraesperayC, fueraesperaxC, True)
                         UserList(UserIndex).flags.Carreras = False
                        Exit Sub
                    End If
                Next i
                Exit Sub
            End If
 
        For POS = LBound(Torneo_LuchadoresC) To UBound(Torneo_LuchadoresC)
                If (Torneo_LuchadoresC(POS) = UserIndex) Then Exit For
        Next POS
 
        ' si no lo ha encontrado
        If (Torneo_LuchadoresC(POS) <> UserIndex) Then Exit Sub
       
 '  Ojo con esta parte, aqui es donde verifica si el usuario esta en la posicion de espera del torneo, en estas cordenadas tienen que fijarse al crear su Mapa de torneos.
       If UserList(UserIndex).POS.X >= X1C And UserList(UserIndex).POS.X <= X2C And UserList(UserIndex).POS.Y >= Y1C And UserList(UserIndex).POS.Y <= Y2C Then
Call WarpUserChar(UserIndex, mapa_fueraC, fueraesperaxC, fueraesperayC, True)
UserList(UserIndex).flags.Carreras = False
Torneo_LuchadoresC(POS) = -1
Exit Sub
End If
 
        combate = 1 + (POS - 1) \ 2
 
        'ponemos li1 y li2 (luchador index) de los que combatian
        LI1 = 2 * (combate - 1) + 1
        LI2 = LI1 + 1
 
        'se informa a la gente
        If (Real) Then
                Call SendData(ToAll, 0, 0, "||Carreras> " & UserList(UserIndex).Name & " pierde el combate." & FONTTYPE_FENIZ)
        Else
                Call SendData(ToAll, 0, 0, "||Carreras> " & UserList(UserIndex).Name & " se fue del combate." & FONTTYPE_FENIZ)
        End If
 
        'se le teleporta fuera si murio
        If (Real) Then
                Call WarpUserChar(UserIndex, mapa_fueraC, fueraesperaxC, fueraesperayC, True)
                 UserList(UserIndex).flags.Carreras = False
        ElseIf (Not CambioMapa) Then
             
                 Call WarpUserChar(UserIndex, mapa_fueraC, fueraesperaxC, fueraesperayC, True)
                  UserList(UserIndex).flags.Carreras = False
        End If
 
        'se le borra de la lista y se mueve el segundo a li1
        If (Torneo_LuchadoresC(LI1) = UserIndex) Then
                Torneo_LuchadoresC(LI1) = Torneo_LuchadoresC(LI2) 'cambiamos slot
                Torneo_LuchadoresC(LI2) = -1
        Else
                Torneo_LuchadoresC(LI2) = -1
        End If
 
 
    'si es la ultima ronda
 
    If (Torneo_RondasC = 1) Then
        Call WarpUserChar(Torneo_LuchadoresC(LI1), mapa_fueraC, 51, 51, True)
        Call SendData(ToAll, 0, 0, "||Carreras> Gana " & UserList(Torneo_LuchadoresC(LI1)).Name & " Gano 6 puntos de canjeos." & FONTTYPE_PARTY)
        UserList(Torneo_LuchadoresC(LI1)).flags.Canje = UserList(Torneo_LuchadoresC(LI1)).flags.Canje + 6
         UserList(Torneo_LuchadoresC(LI1)).flags.Carreras = False
         frmMain.Carreras.Enabled = True
   
       Call SendUserStatsBox(Torneo_LuchadoresC(LI1))
        Torneo_ActivoC = False
        Exit Sub
    Else
        'a su compañero se le teleporta dentro, condicional por seguridad
        Call WarpUserChar(Torneo_LuchadoresC(LI1), mapatorneoC, esperaxC, esperayC, True)
    End If
 
               
        'si es el ultimo combate de la ronda
        If (2 ^ Torneo_RondasC = 2 * combate) Then
 
                'Call SendData(ToAll, 0, 0, "||Siguiente ronda!" & FONTTYPE_TALK)
                Torneo_RondasC = Torneo_RondasC - 1
 
        'antes de llamar a la proxima ronda hay q copiar a los tipos
        For i = 1 To 2 ^ Torneo_RondasC
                UI1 = Torneo_LuchadoresC(2 * (i - 1) + 1)
                UI2 = Torneo_LuchadoresC(2 * i)
                If (UI1 = -1) Then UI1 = UI2
                Torneo_LuchadoresC(i) = UI1
        Next i
ReDim Preserve Torneo_LuchadoresC(1 To 2 ^ Torneo_RondasC) As Integer
        Call Rondas_CombateC(1)
        Exit Sub
        End If
 
        'vamos al siguiente combate
        Call Rondas_CombateC(combate + 1)
Rondas_UsuarioMuereC_errorh:
 
End Sub
 


 
Sub Rondas_UsuarioCambiamapaC(ByVal UserIndex As Integer)
On Error GoTo errorh
        Call Rondas_UsuarioMuereC(UserIndex, False, True)
errorh:
End Sub
 
Sub torneos_autoC(ByVal rondas As Integer)
On Error GoTo errorh
If (Torneo_ActivoC) Then
               
                Exit Sub
        End If
        Call SendData(ToAll, 0, 0, "||Carreras> automaticas para " & val(2 ^ rondas) & " participantes!! para participar pon /CORRER" & FONTTYPE_FENIZ)
       
        Torneo_RondasC = rondas
        Torneo_ActivoC = True
        Torneo_EsperandoC = True
 
        ReDim Torneo_LuchadoresC(1 To 2 ^ rondas) As Integer
        Dim i As Integer
        For i = LBound(Torneo_LuchadoresC) To UBound(Torneo_LuchadoresC)
                Torneo_LuchadoresC(i) = -1
        Next i
errorh:
End Sub
 
Sub Torneos_IniciaC(ByVal UserIndex As Integer, ByVal rondas As Integer)
On Error GoTo errorh
        If (Torneo_ActivoC) Then
          
                Exit Sub
        End If
         Call SendData(ToAll, 0, 0, "||Carreras> automaticas para " & val(2 ^ rondas) & " participantes!! para participar pon /CORRER" & FONTTYPE_FENIZ)
        
        Torneo_RondasC = rondas
        Torneo_ActivoC = True
        Torneo_EsperandoC = True
        
        ReDim Torneo_LuchadoresC(1 To 2 ^ rondas) As Integer
        Dim i As Integer
        For i = LBound(Torneo_LuchadoresC) To UBound(Torneo_LuchadoresC)
                Torneo_LuchadoresC(i) = -1
        Next i
errorh:
End Sub
 
 
 
Sub Torneos_EntraC(ByVal UserIndex As Integer)
On Error GoTo errorh
        Dim i As Integer

       
        If (Not Torneo_ActivoC) Then
        
                Exit Sub
        End If
    
       
        If (Not Torneo_EsperandoC) Then
             
                Exit Sub
        End If
       
        For i = LBound(Torneo_LuchadoresC) To UBound(Torneo_LuchadoresC)
                If (Torneo_LuchadoresC(i) = UserIndex) Then
                        Call SendData(ToIndex, UserIndex, 0, "||Ya estas dentro!" & FONTTYPE_WARNING)
                        Exit Sub
                End If
        Next i
 
        For i = LBound(Torneo_LuchadoresC) To UBound(Torneo_LuchadoresC)
        If (Torneo_LuchadoresC(i) = -1) Then
                Torneo_LuchadoresC(i) = UserIndex
                 Dim NuevaPos As WorldPos
                  Dim FuturePos As WorldPos
                    FuturePos.Map = mapatorneoC
                    FuturePos.X = esperaxC: FuturePos.Y = esperayC
                    Call ClosestLegalPos(FuturePos, NuevaPos)
                   
                    If NuevaPos.X <> 0 And NuevaPos.Y <> 0 Then Call WarpUserChar(Torneo_LuchadoresC(i), NuevaPos.Map, NuevaPos.X, NuevaPos.Y, True)
                 UserList(Torneo_LuchadoresC(i)).flags.Carreras = True
                 

                If (i = UBound(Torneo_LuchadoresC)) Then
                Call SendData(ToAll, 0, 0, "||Carreras> ¡Comienzan las carreras!" & FONTTYPE_ORO)
                
                frmMain.Carreras.Enabled = False
                
                Torneo_EsperandoC = False
                Call Rondas_CombateC(1)
                
                End If
                  Exit Sub
        End If
        Next i
errorh:
End Sub
 
 
Sub Rondas_CombateC(combate As Integer)
On Error GoTo errorh
Dim UI1 As Integer, UI2 As Integer
    UI1 = Torneo_LuchadoresC(2 * (combate - 1) + 1)
    UI2 = Torneo_LuchadoresC(2 * combate)
   
    If (UI2 = -1) Then
        UI2 = Torneo_LuchadoresC(2 * (combate - 1) + 1)
        UI1 = Torneo_LuchadoresC(2 * combate)
    End If
   
   If UI1 = -1 Then
        Call SendData(ToAll, 0, 0, "||Carreras> carrera anulada porque un participante involucrado deslogeo." & FONTTYPE_BLANKO)
        
         If (Torneo_RondasC = 1) Then
        If (UI2 <> -1) Then
        Call SendData(ToAll, 0, 0, "||Carreras> Carreras terminadas. Ganador de las carreras: " & UserList(UI2).Name & FONTTYPE_PARTY)
        Call SendData(ToAll, 0, 0, "||Premio> 6 puntos de canjeo." & FONTTYPE_PARTY)
        frmMain.Carreras.Enabled = True
      
        UserList(UI2).flags.Carreras = False
        UserList(UI2).flags.Canje = UserList(UI2).flags.Canje + 6
        ' dale_recompensa()
        Torneo_ActivoC = False
       Exit Sub
    End If
            Call SendData(ToAll, 0, 0, "||Carreras> No hay ganador porque todos se fueron." & FONTTYPE_FENIZ)
            frmMain.Carreras.Enabled = True
           
            Exit Sub
        End If
        If (UI2 <> -1) Then _
            Call SendData(ToAll, 0, 0, "||Carreras> " & UserList(UI2).Name & " pasa a la siguiente carrera!" & FONTTYPE_FENIZ)
   
        If (2 ^ Torneo_RondasC = 2 * combate) Then
            'Call SendData(ToAll, 0, 0, "||Siguiente ronda!" & FONTTYPE_TALK)
            Torneo_RondasC = Torneo_RondasC - 1
            'antes de llamar a la proxima ronda hay q copiar a los tipos
            Dim i As Integer, j As Integer
            For i = 1 To 2 ^ Torneo_RondasC
                UI1 = Torneo_LuchadoresC(2 * (i - 1) + 1)
                UI2 = Torneo_LuchadoresC(2 * i)
                If (UI1 = -1) Then UI1 = UI2
                Torneo_LuchadoresC(i) = UI1
            Next i
            ReDim Preserve Torneo_LuchadoresC(1 To 2 ^ Torneo_RondasC) As Integer
            Call Rondas_CombateC(1)
            Exit Sub
        End If
        Call Rondas_CombateC(combate + 1)
        Exit Sub
    End If
 
    Call SendData(ToAll, 0, 0, "||Carreras> " & UserList(UI1).Name & " versus " & UserList(UI2).Name & ". a correr!" & FONTTYPE_FENIZ)
    frmMain.carrerasBloq.Enabled = True
    Call WarpUserChar(UI1, mapatorneoC, esquina1xC, esquina1yC, True)
    Call WarpUserChar(UI2, mapatorneoC, esquina2xC, esquina2yC, True)
errorh:

End Sub

Sub usuarioGana(ByVal UserIndex As Integer)
 For UserIndex = 1 To LastUser
If UserList(UserIndex).POS.Map = 30 Then ' ¿Esta en el mapa 30?
Call Rondas_UsuarioMuereC(UserIndex)
End If
  Next
End Sub

 

Sub sefuecarrera(ByVal UserIndex As Integer, Optional Real As Boolean = True, Optional CambioMapa As Boolean = False)
On Error GoTo Rondas_UsuarioMuereC_errorh
        Dim i As Integer, POS As Integer, j As Integer
        Dim combate As Integer, LI1 As Integer, LI2 As Integer
        Dim UI1 As Integer, UI2 As Integer

If (Not Torneo_ActivoC) Then
                Exit Sub
            ElseIf (Torneo_ActivoC And Torneo_EsperandoC) Then
                For i = LBound(Torneo_LuchadoresC) To UBound(Torneo_LuchadoresC)
                    If (Torneo_LuchadoresC(i) = UserIndex) Then
                        Torneo_LuchadoresC(i) = -1
                        Call WarpUserChar(UserIndex, mapa_fueraC, fueraesperayC, fueraesperaxC, True)
                         UserList(UserIndex).flags.Carreras = False
                        Exit Sub
                    End If
                Next i
                Exit Sub
            End If
 
        For POS = LBound(Torneo_LuchadoresC) To UBound(Torneo_LuchadoresC)
                If (Torneo_LuchadoresC(POS) = UserIndex) Then Exit For
        Next POS
 
        ' si no lo ha encontrado
        If (Torneo_LuchadoresC(POS) <> UserIndex) Then Exit Sub
       
 '  Ojo con esta parte, aqui es donde verifica si el usuario esta en la posicion de espera del torneo, en estas cordenadas tienen que fijarse al crear su Mapa de torneos.
       If UserList(UserIndex).POS.X >= X1C And UserList(UserIndex).POS.X <= X2C And UserList(UserIndex).POS.Y >= Y1C And UserList(UserIndex).POS.Y <= Y2C Then
Call WarpUserChar(UserIndex, mapa_fueraC, fueraesperaxC, fueraesperayC, True)
UserList(UserIndex).flags.Carreras = False
Torneo_LuchadoresC(POS) = -1
Exit Sub
End If
 
        combate = 1 + (POS - 1) \ 2
 
        'ponemos li1 y li2 (luchador index) de los que combatian
        LI1 = 2 * (combate - 1) + 1
        LI2 = LI1 + 1
 
        'se informa a la gente
        If (Real) Then
                Call SendData(ToAll, 0, 0, "||Carreras> " & UserList(UserIndex).Name & " pierde el combate." & FONTTYPE_FENIZ)
        Else
                Call SendData(ToAll, 0, 0, "||Carreras> " & UserList(UserIndex).Name & " se fue del combate." & FONTTYPE_FENIZ)
        End If
 
        'se le teleporta fuera si murio
        If (Real) Then
                Call WarpUserChar(UserIndex, mapa_fueraC, fueraesperaxC, fueraesperayC, True)
                 UserList(UserIndex).flags.Carreras = False
        ElseIf (Not CambioMapa) Then
             
                 Call WarpUserChar(UserIndex, mapa_fueraC, fueraesperaxC, fueraesperayC, True)
                  UserList(UserIndex).flags.Carreras = False
        End If
 
        'se le borra de la lista y se mueve el segundo a li1
        If (Torneo_LuchadoresC(LI1) = UserIndex) Then
                Torneo_LuchadoresC(LI1) = Torneo_LuchadoresC(LI2) 'cambiamos slot
                Torneo_LuchadoresC(LI2) = -1
        Else
                Torneo_LuchadoresC(LI2) = -1
        End If
 
 
    'si es la ultima ronda
 
    If (Torneo_RondasC = 1) Then
        Call WarpUserChar(Torneo_LuchadoresC(LI1), mapa_fueraC, 51, 51, True)
        Call SendData(ToAll, 0, 0, "||Carreras> Gana " & UserList(Torneo_LuchadoresC(LI1)).Name & " Gano 6 puntos de canjeos." & FONTTYPE_PARTY)
        UserList(Torneo_LuchadoresC(LI1)).flags.Canje = UserList(Torneo_LuchadoresC(LI1)).flags.Canje + 6
         UserList(Torneo_LuchadoresC(LI1)).flags.Carreras = False
         frmMain.Carreras.Enabled = True
   
       Call SendUserStatsBox(Torneo_LuchadoresC(LI1))
        Torneo_ActivoC = False
        Exit Sub
    Else
        'a su compañero se le teleporta dentro, condicional por seguridad
        Call WarpUserChar(Torneo_LuchadoresC(LI1), mapatorneoC, esperaxC, esperayC, True)
    End If
 
               
        'si es el ultimo combate de la ronda
        If (2 ^ Torneo_RondasC = 2 * combate) Then
 
                'Call SendData(ToAll, 0, 0, "||Siguiente ronda!" & FONTTYPE_TALK)
                Torneo_RondasC = Torneo_RondasC - 1
 
        'antes de llamar a la proxima ronda hay q copiar a los tipos
        For i = 1 To 2 ^ Torneo_RondasC
                UI1 = Torneo_LuchadoresC(2 * (i - 1) + 1)
                UI2 = Torneo_LuchadoresC(2 * i)
                If (UI1 = -1) Then UI1 = UI2
                Torneo_LuchadoresC(i) = UI1
        Next i
ReDim Preserve Torneo_LuchadoresC(1 To 2 ^ Torneo_RondasC) As Integer
        Call Rondas_CombateC(1)
        Exit Sub
        End If
 
        'vamos al siguiente combate
        Call Rondas_CombateC(combate + 1)
Rondas_UsuarioMuereC_errorh:
 
End Sub

