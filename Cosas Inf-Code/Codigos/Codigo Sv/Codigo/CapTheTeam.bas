Attribute VB_Name = "CapTheTeam"
 
'director del proyecto: #Esteban(Neliam)

'servidor basado en fénixao 1.0
'medios de contacto:
'Skype: dc.esteban
'E-mail: nabrianao@gmail.com
Public Const MAP_ThTe As Integer = 197
Public Const MAP_ThTeazul As Integer = 196
Public Const MAP_ThTerojo As Integer = 195
Public Const NPCReyCIUDA As Integer = 658
Public Const NPCReyCRIMI As Integer = 657

Public teamtheesperando As Boolean

Sub QuitarNpcThTe()
 Dim Xnn As Integer
    Dim Ynn As Integer
    Dim MapaActual As Integer
    
For Ynn = YMinMapSize To YMaxMapSize
For Xnn = XMinMapSize To XMaxMapSize

 If MapData(197, Xnn, Ynn).NpcIndex Then Call QuitarNPC(MapData(197, Xnn, Ynn).NpcIndex)
Next
Next
End Sub
Sub VolverFaccionesOriginales()
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
Sub ganoTHTEazul(Userindex As Integer)
    Call QuitarNpcThTe
    Call SendData(ToAll, 0, 0, "||The team> ¡Gana equipo azul! Resultado: " & thvciuda & " - " & thvCrimi & FONTTYPE_ProtectorCiu)
    Call SendData(ToAll, 0, 0, "||The team> Premio 250.000 monedas de oro. C/U, punto de quest +120 puntos de reputación." & FONTTYPE_ProtectorCiu)
    Call darPremiOciudadano
    
    Dim loopc As Integer
    For loopc = 1 To LastUser
        If UserList(loopc).POS.Map = MAP_ThTe Or UserList(loopc).POS.Map = MAP_ThTerojo Or UserList(loopc).POS.Map = MAP_ThTeazul Then
            If UserList(loopc).Faccion.Bando = Real Then
            Call WarpUserChar(loopc, 1, 50, 50, True)
            Else
            Call WarpUserChar(loopc, 1, 50, 50, True)
            End If
        End If
        Next
        
    
    Call DesbloquearZonasTheTeam
    
    Call VolverFaccionesOriginales
    AutotheTeam = 0
    RealTheTEAM = 0
    CaosTheTEAM = 0

End Sub
Sub ganoTHTErojo(Userindex As Integer)
Call QuitarNpcThTe
Call SendData(ToAll, 0, 0, "||The team> ¡Gana equipo rojo! Resultado: " & thvCrimi & " - " & thvciuda & FONTTYPE_FIGHTT)
Call SendData(ToAll, 0, 0, "||The team> Premio 250.000 monedas de oro. C/U, punto de quest +120 puntos de reputación." & FONTTYPE_FIGHTT)
Call darPremiOcriminal

Dim loopc As Integer
    For loopc = 1 To LastUser
         If UserList(loopc).POS.Map = MAP_ThTe Or UserList(loopc).POS.Map = MAP_ThTerojo Or UserList(loopc).POS.Map = MAP_ThTeazul Then
            If UserList(loopc).Faccion.Bando = Real Then
            Call WarpUserChar(loopc, 1, 50, 50, True)
            Else
            Call WarpUserChar(loopc, 1, 50, 50, True)
            End If
        End If
        Next
        
    Call DesbloquearZonasTheTeam
    
    Call VolverFaccionesOriginales
    AutotheTeam = 0
    RealTheTEAM = 0
    CaosTheTEAM = 0

End Sub
Sub iniciathte(Userindex As Integer)
Dim loopc As Integer

  If Not RealTheTEAM = ptheteam Then Exit Sub
  If Not CaosTheTEAM = ptheteam Then Exit Sub
  
    For loopc = 1 To LastUser
        If UserList(loopc).POS.Map = MAP_ThTeazul Or UserList(loopc).POS.Map = MAP_ThTerojo Then
            If UserList(loopc).Faccion.Bando = Real Then
            Call WarpUserChar(loopc, MAP_ThTe, 54, 20, True)
            Else
            Call WarpUserChar(loopc, MAP_ThTe, 54, 45, True)
            End If
        End If
        Next
        
    Call DesbloquearZonasTheTeam
    
    EVENTOTHETEAMACTIVADO = 0
    RealTheTEAM = 0
    CaosTheTEAM = 0
    ptheteam = 0
    AutotheTeam = 0
    Call SendData(ToAll, 0, 0, "||The team> Se inicia el round, Criminales y Ciudadanos, combatan!!" & FONTTYPE_TALK)
    teamtheesperando = False
    
    Call respawnciudA
    Call respawncrimI
    thvciuda = 0
    thvCrimi = 0
End Sub
Sub iniciathteC(Userindex As Integer)
If thvCrimi = 2 Then
Call ganoTHTErojo(Userindex)
Exit Sub
End If

Call QuitarNpcThTe
Dim loopc As Integer
    For loopc = 1 To LastUser
        If UserList(loopc).POS.Map = MAP_ThTeazul Or UserList(loopc).POS.Map = MAP_ThTerojo Then
            If UserList(loopc).Faccion.Bando = Real Then
            Call WarpUserChar(loopc, MAP_ThTe, 54, 20, True)
            Else
            Call WarpUserChar(loopc, MAP_ThTe, 54, 45, True)
            End If
        End If
        Next
        
    Call DesbloquearZonasTheTeam
    Call respawnciudA
    Call respawncrimI
      
End Sub
Sub iniciathteH(Userindex As Integer)
If thvciuda = 2 Then
Call ganoTHTEazul(Userindex)
Exit Sub
End If
Call QuitarNpcThTe
Dim loopc As Integer
    For loopc = 1 To LastUser
        If UserList(loopc).POS.Map = MAP_ThTeazul Or UserList(loopc).POS.Map = MAP_ThTerojo Then
            If UserList(loopc).Faccion.Bando = Real Then
            Call WarpUserChar(loopc, MAP_ThTe, 54, 20, True)
            Else
            Call WarpUserChar(loopc, MAP_ThTe, 54, 45, True)
            End If
        End If
        Next
        
      Call DesbloquearZonasTheTeam
      Call respawnciudA
      Call respawncrimI
      
End Sub
Sub SumaThteC()
thvCrimi = thvCrimi + 1
Call SendData(ToAll, 0, 0, "||The team> " & thvCrimi & " - " & thvciuda & " Victoria para el equipo rojo!" & FONTTYPE_FIGHTT)
Call BloquearZonasTheTeam
End Sub
Sub SumaThteH()
thvciuda = thvciuda + 1
Call SendData(ToAll, 0, 0, "||The team> " & thvciuda & " - " & thvCrimi & " Victoria para el equipo azul!" & FONTTYPE_ProtectorCiu)
Call BloquearZonasTheTeam
End Sub
Sub respawnciudA()
Dim iiDciuda As WorldPos
   
    iiDciuda.Map = 197
    iiDciuda.X = 54
    iiDciuda.y = 11
   
    Call SpawnNpc(NPCReyCIUDA, iiDciuda, True, False)
End Sub
Sub respawncrimI()
Dim iiDcrimi As WorldPos
 
    iiDcrimi.Map = 197
    iiDcrimi.X = 54
    iiDcrimi.y = 56
   
    Call SpawnNpc(NPCReyCRIMI, iiDcrimi, True, False)
End Sub
Sub cancelatheteam()
On Error Resume Next
    Call VolverFaccionesOriginales
    Dim loopc As Integer

    For loopc = 1 To LastUser
        If UserList(loopc).POS.Map = MAP_ThTe Or UserList(loopc).POS.Map = MAP_ThTerojo Or UserList(loopc).POS.Map = MAP_ThTeazul Then
            If UserList(loopc).Faccion.Bando = Real Then
            Call WarpUserChar(loopc, 1, 50, 50, True)
            Else
            Call WarpUserChar(loopc, 1, 50, 50, True)
            End If
        End If
    Next
        Call SendData(ToAll, 0, 0, "||The team> Evento Cancelado." & FONTTYPE_TALK)
        Call QuitarNpcThTe
        teamtheesperando = False
   ptheteam = 0
   RealTheTEAM = 0
   CaosTheTEAM = 0
   EVENTOTHETEAMACTIVADO = 0
   AutotheTeam = 0

End Sub
Sub AbreCuposTheteam()
EVENTOTHETEAMACTIVADO = 1
Call SendData(ToAll, 0, 0, "TW48")
teamtheesperando = True
Call SendData(ToAll, 0, 0, "||Cupos abiertos evento the team faccionario modalidad " & ptheteam & " Vs. " & ptheteam & " Si quieres entrar como ciudadano tipeá /TEAM1, Como criminal /TEAM2." & FONTTYPE_TALK)
Call BloquearZonasTheTeam

End Sub
Sub darPremiOciudadano()
Dim loopc As Integer
    For loopc = 1 To LastUser
        If UserList(loopc).POS.Map = MAP_ThTe Or UserList(loopc).POS.Map = MAP_ThTerojo Or UserList(loopc).POS.Map = MAP_ThTeazul Then
            If UserList(loopc).Faccion.Bando = Real Then
            UserList(loopc).Stats.GLD = UserList(loopc).Stats.GLD + 250000
            UserList(loopc).Stats.Reputacion = UserList(loopc).Stats.Reputacion + 120
            UserList(loopc).Faccion.Quests = UserList(loopc).Faccion.Quests + 1
            Call SendUserORO(loopc)
            Call SendUserREP(loopc)
            End If
        End If
        Next
End Sub
Sub darPremiOcriminal()
Dim loopc As Integer
    For loopc = 1 To LastUser
        If UserList(loopc).POS.Map = MAP_ThTe Or UserList(loopc).POS.Map = MAP_ThTerojo Or UserList(loopc).POS.Map = MAP_ThTeazul Then
            If UserList(loopc).Faccion.Bando = Caos Then
            UserList(loopc).Stats.GLD = UserList(loopc).Stats.GLD + 250000
            UserList(loopc).Stats.Reputacion = UserList(loopc).Stats.Reputacion + 120
            UserList(loopc).Faccion.Quests = UserList(loopc).Faccion.Quests + 1
            Call SendUserORO(loopc)
            Call SendUserREP(loopc)
            End If
        End If
        Next
End Sub
Sub CCuentaThteC(ByVal Userindex As Integer)
    CuentathteC = CuentathteC - 1
    If CuentathteC = 0 Then
        Call SendData(ToMap, 0, 195, "||YA!!!" & FONTTYPE_FIGHTT)
        Call SendData(ToMap, 0, 196, "||YA!!!" & FONTTYPE_FIGHTT)
        Call iniciathteC(Userindex)
    Else
        Call SendData(ToMap, 0, 195, "||" & CuentathteC & "..." & FONTTYPE_INFO)
        Call SendData(ToMap, 0, 196, "||" & CuentathteC & "..." & FONTTYPE_INFO)
    End If

End Sub
Sub CCuentaThteh(ByVal Userindex As Integer)
    CuentathteH = CuentathteH - 1

    If CuentathteH = 0 Then
        Call SendData(ToMap, 0, 195, "||YA!!!" & FONTTYPE_FIGHTT)
        Call SendData(ToMap, 0, 196, "||YA!!!" & FONTTYPE_FIGHTT)
        Call iniciathteH(Userindex)
    Else
        Call SendData(ToMap, 0, 195, "||" & CuentathteH & "..." & FONTTYPE_INFO)
        Call SendData(ToMap, 0, 196, "||" & CuentathteH & "..." & FONTTYPE_INFO)
    End If

End Sub
Sub EnviarBasesThte(ByVal Userindex As Integer)
Dim loopc As Integer
    For loopc = 1 To LastUser
         If UserList(loopc).POS.Map = MAP_ThTe Or UserList(loopc).POS.Map = MAP_ThTerojo Or UserList(loopc).POS.Map = MAP_ThTeazul Then
            If UserList(loopc).Faccion.Bando = Real Then
             Call WarpUserChar(loopc, MAP_ThTeazul, 71, 46, True)
             Else
             Call WarpUserChar(loopc, MAP_ThTerojo, 71, 46, True)
            End If
        End If
        Next
End Sub

Sub BloquearZonasTheTeam()
    MapData(MAP_ThTeazul, 48, 55).Blocked = 1
    MapData(MAP_ThTeazul, 48, 56).Blocked = 1
    MapData(MAP_ThTeazul, 48, 57).Blocked = 1
    MapData(MAP_ThTeazul, 48, 58).Blocked = 1
    MapData(MAP_ThTeazul, 48, 59).Blocked = 1
    MapData(MAP_ThTeazul, 48, 60).Blocked = 1
    MapData(MAP_ThTeazul, 48, 61).Blocked = 1
    MapData(MAP_ThTerojo, 48, 55).Blocked = 1
    MapData(MAP_ThTerojo, 48, 56).Blocked = 1
    MapData(MAP_ThTerojo, 48, 57).Blocked = 1
    MapData(MAP_ThTerojo, 48, 58).Blocked = 1
    MapData(MAP_ThTerojo, 48, 59).Blocked = 1
    MapData(MAP_ThTerojo, 48, 60).Blocked = 1
    MapData(MAP_ThTerojo, 48, 61).Blocked = 1
End Sub

Sub DesbloquearZonasTheTeam()
    MapData(MAP_ThTeazul, 48, 55).Blocked = 0
    MapData(MAP_ThTeazul, 48, 56).Blocked = 0
    MapData(MAP_ThTeazul, 48, 57).Blocked = 0
    MapData(MAP_ThTeazul, 48, 58).Blocked = 0
    MapData(MAP_ThTeazul, 48, 59).Blocked = 0
    MapData(MAP_ThTeazul, 48, 60).Blocked = 0
    MapData(MAP_ThTeazul, 48, 61).Blocked = 0
    MapData(MAP_ThTerojo, 48, 55).Blocked = 0
    MapData(MAP_ThTerojo, 48, 56).Blocked = 0
    MapData(MAP_ThTerojo, 48, 57).Blocked = 0
    MapData(MAP_ThTerojo, 48, 58).Blocked = 0
    MapData(MAP_ThTerojo, 48, 59).Blocked = 0
    MapData(MAP_ThTerojo, 48, 60).Blocked = 0
    MapData(MAP_ThTerojo, 48, 61).Blocked = 0
End Sub

Sub DesLogTheTeam(Userindex As Integer)
If UserList(Userindex).POS.Map = 195 Then
Call WarpUserChar(Userindex, 1, 50, 50, True)
End If

If UserList(Userindex).POS.Map = 196 Then
Call WarpUserChar(Userindex, 1, 50, 50, True)
RealTheTEAM = RealTheTEAM - 1
End If

If UserList(Userindex).POS.Map = 197 Then
Call WarpUserChar(Userindex, 1, 50, 50, True)
CaosTheTEAM = CaosTheTEAM - 1
End If

If UserList(Userindex).Faccion.bandoEventos = 1 Then
UserList(Userindex).Faccion.Bando = 0
UserList(Userindex).Faccion.bandoEventos = 0
End If
End Sub
