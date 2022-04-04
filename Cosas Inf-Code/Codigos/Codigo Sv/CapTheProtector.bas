Attribute VB_Name = "CapTheProtector"
 
'director del proyecto: #Esteban(Neliam)

'servidor basado en fénixao 1.0
'medios de contacto:
'Skype: dc.esteban
'E-mail: nabrianao@gmail.com

Sub cancelaProtector()
On Error Resume Next
    Call VolverFaccionesOriginalesProtector
    Dim loopc As Integer

    For loopc = 1 To LastUser
        If UserList(loopc).POS.Map = 192 Or UserList(loopc).POS.Map = 193 Or UserList(loopc).POS.Map = 194 Then
            If UserList(loopc).Faccion.Bando = Real Then
            Call WarpUserChar(loopc, 1, 50, 50, True)
            Else
            Call WarpUserChar(loopc, 1, 50, 50, True)
            End If
        End If
    Next
        Call SendData(ToAll, 0, 0, "||Protector> Evento Cancelado." & FONTTYPE_TALK)
  
        teamtheesperando = False
        RealPROTECTOR = 0
CaosPROTECTOR = 0
pProtector = 0
EVENTOPROTECTORACTIVADO = 0

End Sub

Sub AbreCuposProtector()
EVENTOPROTECTORACTIVADO = 1
Call SendData(ToAll, 0, 0, "TW48")
teamtheesperando = True
Call SendData(ToAll, 0, 0, "||Cupos abiertos evento Protector faccionario modalidad " & pProtector & " Vs. " & pProtector & " Si quieres entrar como ciudadano tipeá /PROTECTOR1, Como criminal /PROTECTOR2." & FONTTYPE_TALK)
Call BloquearZonasProtector

End Sub

Sub iniciatheProtector(Userindex As Integer)
Dim loopc As Integer

  If Not RealPROTECTOR = pProtector Then Exit Sub
  If Not CaosPROTECTOR = pProtector Then Exit Sub
  
    For loopc = 1 To LastUser
        If UserList(loopc).POS.Map = 193 Or UserList(loopc).POS.Map = 194 Then
            If UserList(loopc).Faccion.Bando = Real Then
            Call WarpUserChar(loopc, 192, 50, 35, True)
            Else
            Call WarpUserChar(loopc, 192, 50, 70, True)
            End If
        End If
        Next
    

    EVENTOPROTECTORACTIVADO = 0
    RealPROTECTOR = 0
    CaosPROTECTOR = 0
    pProtector = 0
    Call SendData(ToAll, 0, 0, "||Protector> ¡Comienza! Criminales y Ciudadanos a luchar." & FONTTYPE_TALK)
    teamtheesperando = False
    Call DesbloquearZonasProtector
    frmMain.tMensajeC.Enabled = True
frmMain.tMensaje.Enabled = True
    thvciuda = 0
    thvCrimi = 0
End Sub

Sub VolverFaccionesOriginalesProtector()
On Error Resume Next
Dim loopc As Integer
    For loopc = 1 To LastUser
           If UserList(loopc).Faccion.bandoEventos = 1 Then
           UserList(loopc).Faccion.Bando = 0
            UserList(loopc).Faccion.bandoEventos = 0
        Call UpdateUserChar(loopc)
        End If
            Next

End Sub

Sub darPremiOcriminalProtec()
   Dim loopc As Integer
   For loopc = 1 To LastUser
        If UserList(loopc).POS.Map = 192 Or UserList(loopc).POS.Map = 193 Or UserList(loopc).POS.Map = 194 Then
          If UserList(loopc).Faccion.Bando = Caos Then
            Call WarpUserChar(loopc, 1, 50, 50, True)
            UserList(loopc).Stats.GLD = UserList(loopc).Stats.GLD + 250000
            UserList(loopc).Stats.Reputacion = UserList(loopc).Stats.Reputacion + 120
            UserList(loopc).Faccion.Quests = UserList(loopc).Faccion.Quests + 1
            Call SendUserORO(loopc)
            Call SendUserREP(loopc)
            Else
            Call WarpUserChar(loopc, 1, 50, 50, True)
            End If
        End If
Next

Call VolverFaccionesOriginalesProtector
RealPROTECTOR = 0
CaosPROTECTOR = 0
End Sub
Sub darPremiOciudadanoProtec()
   Dim loopc As Integer
   For loopc = 1 To LastUser
        If UserList(loopc).POS.Map = 192 Or UserList(loopc).POS.Map = 193 Or UserList(loopc).POS.Map = 194 Then
          If UserList(loopc).Faccion.Bando = Real Then
            Call WarpUserChar(loopc, 1, 50, 50, True)
            UserList(loopc).Stats.GLD = UserList(loopc).Stats.GLD + 250000
            UserList(loopc).Stats.Reputacion = UserList(loopc).Stats.Reputacion + 120
            UserList(loopc).Faccion.Quests = UserList(loopc).Faccion.Quests + 1
            Call SendUserORO(loopc)
            Call SendUserREP(loopc)
            Else
            Call WarpUserChar(loopc, 1, 50, 50, True)
            End If
        End If
        Next

Call VolverFaccionesOriginalesProtector
RealPROTECTOR = 0
CaosPROTECTOR = 0
End Sub

Sub ganoprotectorazul(Userindex As Integer)
 
    Call SendData(ToAll, 0, 0, "||Protector> ¡Gana equipo azul! Resultado: " & thvciuda & " - " & thvCrimi & FONTTYPE_ProtectorCiu)
    Call SendData(ToAll, 0, 0, "||Protector> Premio 250.000 monedas de oro. C/U, punto de quest +120 puntos de reputación." & FONTTYPE_ProtectorCiu)
    Call darPremiOciudadanoProtec
    
    Dim loopc As Integer
    For loopc = 1 To LastUser
        If UserList(loopc).POS.Map = 192 Or UserList(loopc).POS.Map = 193 Or UserList(loopc).POS.Map = 194 Then
            If UserList(loopc).Faccion.Bando = Real Then
            Call WarpUserChar(loopc, 1, 50, 50, True)
            Else
            Call WarpUserChar(loopc, 1, 50, 50, True)
            End If
        End If
        Next
        
    
    Call DesbloquearZonasProtector
    
    Call VolverFaccionesOriginalesProtector
    RealPROTECTOR = 0
    CaosPROTECTOR = 0
End Sub


Sub ganoprotectorrojo(Userindex As Integer)

Call SendData(ToAll, 0, 0, "||Protector> ¡Gana equipo rojo! Resultado: " & thvCrimi & " - " & thvciuda & FONTTYPE_FIGHTT)
Call SendData(ToAll, 0, 0, "||Protector> Premio 250.000 monedas de oro. C/U, punto de quest +120 puntos de reputación." & FONTTYPE_FIGHTT)
Call darPremiOcriminalProtec

Dim loopc As Integer
    For loopc = 1 To LastUser
         If UserList(loopc).POS.Map = 192 Or UserList(loopc).POS.Map = 193 Or UserList(loopc).POS.Map = 194 Then
            If UserList(loopc).Faccion.Bando = Real Then
            Call WarpUserChar(loopc, 1, 50, 50, True)
            Else
            Call WarpUserChar(loopc, 1, 50, 50, True)
            End If
        End If
        Next
        
    Call DesbloquearZonasProtector
    
    Call VolverFaccionesOriginalesProtector
    RealPROTECTOR = 0
    CaosPROTECTOR = 0
End Sub

Sub iniciaprotectorC(Userindex As Integer)
If thvCrimi = 2 Then
Call ganoprotectorrojo(Userindex)
Exit Sub
End If


Dim loopc As Integer
    For loopc = 1 To LastUser
        If UserList(loopc).POS.Map = 193 Or UserList(loopc).POS.Map = 194 Then
            If UserList(loopc).Faccion.Bando = Real Then
             Call WarpUserChar(loopc, 192, 50, 35, True)
            Else
             Call WarpUserChar(loopc, 192, 50, 70, True)
            End If
        End If
        Next
            frmMain.tMensajeC.Enabled = True
frmMain.tMensaje.Enabled = True
    Call DesbloquearZonasProtector

      
End Sub
Sub iniciaprotectorH(Userindex As Integer)
If thvciuda = 2 Then
Call ganoprotectorazul(Userindex)
Exit Sub
End If

Dim loopc As Integer
    For loopc = 1 To LastUser
        If UserList(loopc).POS.Map = 193 Or UserList(loopc).POS.Map = 194 Then
            If UserList(loopc).Faccion.Bando = Real Then
             Call WarpUserChar(loopc, 192, 50, 35, True)
            Else
             Call WarpUserChar(loopc, 192, 50, 70, True)
            End If
        End If
        Next
            frmMain.tMensajeC.Enabled = True
frmMain.tMensaje.Enabled = True
      Call DesbloquearZonasProtector
      
End Sub
Sub SumaprotectorC()
thvCrimi = thvCrimi + 1
Call SendData(ToAll, 0, 0, "||Protector> " & thvCrimi & " - " & thvciuda & " Victoria para el equipo rojo!" & FONTTYPE_FIGHTT)
Call BloquearZonasProtector
End Sub
Sub SumaprotectorH()
thvciuda = thvciuda + 1
Call SendData(ToAll, 0, 0, "||Protector> " & thvciuda & " - " & thvCrimi & " Victoria para el equipo azul!" & FONTTYPE_ProtectorCiu)
Call BloquearZonasProtector
End Sub


Sub DesbloquearZonasProtector()
    MapData(193, 48, 55).Blocked = 0
    MapData(193, 48, 56).Blocked = 0
    MapData(193, 48, 57).Blocked = 0
    MapData(193, 48, 58).Blocked = 0
    MapData(193, 48, 59).Blocked = 0
    MapData(193, 48, 60).Blocked = 0
    MapData(193, 48, 61).Blocked = 0
    MapData(194, 48, 55).Blocked = 0
    MapData(194, 48, 56).Blocked = 0
    MapData(194, 48, 57).Blocked = 0
    MapData(194, 48, 58).Blocked = 0
    MapData(194, 48, 59).Blocked = 0
    MapData(194, 48, 60).Blocked = 0
    MapData(194, 48, 61).Blocked = 0
End Sub

Sub BloquearZonasProtector()
    MapData(193, 48, 55).Blocked = 1
    MapData(193, 48, 56).Blocked = 1
    MapData(193, 48, 57).Blocked = 1
    MapData(193, 48, 58).Blocked = 1
    MapData(193, 48, 59).Blocked = 1
    MapData(193, 48, 60).Blocked = 1
    MapData(193, 48, 61).Blocked = 1
    MapData(194, 48, 55).Blocked = 1
    MapData(194, 48, 56).Blocked = 1
    MapData(194, 48, 57).Blocked = 1
    MapData(194, 48, 58).Blocked = 1
    MapData(194, 48, 59).Blocked = 1
    MapData(194, 48, 60).Blocked = 1
    MapData(194, 48, 61).Blocked = 1
End Sub

Sub ProtectorCaosPorciento()
  Dim USI As Integer
    Dim SUMT As Boolean
   
    SUMT = False
    For USI = 1 To LastUser
      
            If UserList(USI).POS.Map = 192 Then
            If UserList(USI).Faccion.Bando = Caos Then
                If MapData(UserList(USI).POS.Map, UserList(USI).POS.X, UserList(USI).POS.y).trigger = 7 Then
                     SUMT = True
                End If
            End If
            End If
        
        If SUMT = True Then
            Exit For
        End If
    Next
 
    If SUMT = True Then
         Trans = Trans + 1
         If Trans > 100 Then
             Trans = 0
             For USI = 1 To LastUser
               
                    If UserList(USI).POS.Map = 192 Then
                    If UserList(USI).Faccion.Bando = Caos Then
                    If MapData(UserList(USI).POS.Map, UserList(USI).POS.X, UserList(USI).POS.y).trigger = 7 Then
                             
Call SumaprotectorC
CuentaProtectorC = 30
Call SendData(ToAll, 0, 0, "TW208")
    
    Dim loopc As Integer

    For loopc = 1 To LastUser
        If UserList(loopc).POS.Map = 192 Or UserList(loopc).POS.Map = 193 Or UserList(loopc).POS.Map = 194 Then
          If UserList(loopc).Faccion.Bando = Real Then
            Call WarpUserChar(loopc, 194, 71, 46, True)
            Else
            Call WarpUserChar(loopc, 193, 71, 46, True)
            End If
        End If
        Next
                        End If
                    End If
                End If
             Next
             frmMain.tMensajeC.Enabled = False
             frmMain.tMensaje.Enabled = False
         End If
    Else
         Trans = 0
    End If
 
    Call SendData(ToMap, 0, 192, "||Fuerza Caos> " & Trans & "%." & FONTTYPE_FIGHTT)
    Call SendData(ToMap, 0, 193, "||Fuerza Caos> " & Trans & "%." & FONTTYPE_FIGHTT)
    Call SendData(ToMap, 0, 194, "||Fuerza Caos> " & Trans & "%." & FONTTYPE_FIGHTT)
    Exit Sub
End Sub

Sub ProtectorCiudaPorciento()
 Dim USI As Integer
    Dim SUMT As Boolean
   
    SUMT = False
    For USI = 1 To LastUser
      
            If UserList(USI).POS.Map = 192 Then
             If UserList(USI).Faccion.Bando = Real Then
                If MapData(UserList(USI).POS.Map, UserList(USI).POS.X, UserList(USI).POS.y).trigger = 3 Then
                     SUMT = True
                End If
            End If
            End If
        
        If SUMT = True Then
            Exit For
        End If
    Next
 
    If SUMT = True Then
         TransC = TransC + 1
         If TransC > 100 Then
             TransC = 0
             For USI = 1 To LastUser
                    If UserList(USI).POS.Map = 192 Then
                    If UserList(USI).Faccion.Bando = Real Then
                    If MapData(UserList(USI).POS.Map, UserList(USI).POS.X, UserList(USI).POS.y).trigger = 3 Then
                             

   Call SumaprotectorH
   CuentaProtectorH = 30
    Call SendData(ToAll, 0, 0, "TW207")
    
    Dim loopc As Integer

    For loopc = 1 To LastUser
        If UserList(loopc).POS.Map = 192 Or UserList(loopc).POS.Map = 193 Or UserList(loopc).POS.Map = 194 Then
           If UserList(loopc).Faccion.Bando = Caos Then
            Call WarpUserChar(loopc, 193, 71, 46, True)
            Else
            Call WarpUserChar(loopc, 194, 71, 46, True)
            End If
        End If
        Next
                        End If
                    End If
                End If
             Next
            frmMain.tMensaje.Enabled = False
            frmMain.tMensajeC.Enabled = False
         End If
    Else
         TransC = 0
    End If
 
    Call SendData(ToMap, 0, 192, "||Fuerza Real> " & TransC & "%." & FONTTYPE_ProtectorCiu)
    Call SendData(ToMap, 0, 193, "||Fuerza Real> " & TransC & "%." & FONTTYPE_ProtectorCiu)
    Call SendData(ToMap, 0, 194, "||Fuerza Real> " & TransC & "%." & FONTTYPE_ProtectorCiu)
    Exit Sub
End Sub


Sub DesLogTheProtector(Userindex As Integer)
If UserList(Userindex).POS.Map = 192 Then
Call WarpUserChar(Userindex, 1, 50, 50, True)
End If

If UserList(Userindex).POS.Map = 193 Then
 Call WarpUserChar(Userindex, 1, 50, 50, True)
 CaosPROTECTOR = CaosPROTECTOR - 1
End If

If UserList(Userindex).POS.Map = 194 Then
Call WarpUserChar(Userindex, 1, 50, 50, True)
RealPROTECTOR = RealPROTECTOR - 1
End If

If UserList(Userindex).Faccion.bandoEventos = 1 Then
UserList(Userindex).Faccion.Bando = 0
UserList(Userindex).Faccion.bandoEventos = 0
End If
End Sub






Sub CCuentaprotectorc(ByVal Userindex As Integer)
    CuentaProtectorC = CuentaProtectorC - 1
    If CuentaProtectorC = 0 Then
        Call SendData(ToMap, 0, 193, "||YA!!!" & FONTTYPE_FIGHTT)
        Call SendData(ToMap, 0, 194, "||YA!!!" & FONTTYPE_FIGHTT)
        Call iniciaprotectorC(Userindex)
    Else
        Call SendData(ToMap, 0, 193, "||" & CuentaProtectorC & "..." & FONTTYPE_INFO)
        Call SendData(ToMap, 0, 194, "||" & CuentaProtectorC & "..." & FONTTYPE_INFO)
    End If

End Sub
Sub CCuentaprotectorh(ByVal Userindex As Integer)
    CuentaProtectorH = CuentaProtectorH - 1

    If CuentaProtectorH = 0 Then
        Call SendData(ToMap, 0, 193, "||YA!!!" & FONTTYPE_FIGHTT)
        Call SendData(ToMap, 0, 194, "||YA!!!" & FONTTYPE_FIGHTT)
        Call iniciaprotectorH(Userindex)
    Else
        Call SendData(ToMap, 0, 193, "||" & CuentaProtectorH & "..." & FONTTYPE_INFO)
        Call SendData(ToMap, 0, 194, "||" & CuentaProtectorH & "..." & FONTTYPE_INFO)
    End If

End Sub

