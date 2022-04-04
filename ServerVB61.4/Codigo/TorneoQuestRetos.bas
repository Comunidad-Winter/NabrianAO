Attribute VB_Name = "TorneoQuestRetos"
Public RetosAutomaticos As Boolean
Public RetosAutomaticosX As Boolean
Public CuposAbiertos As Integer
Public CuposRetosXmodalidad As Integer
Public EsUser1 As Integer
Public EsUser2 As Integer
Public EsUser3 As Integer
Public EsUser4 As Integer
Public EsUser5 As Integer
Public EsUser6 As Integer
Public EsUser7 As Integer
Public EsUser8 As Integer
Public EsUser9 As Integer
Public EsUser10 As Integer
Public EsRetosModalidad1vs1 As Boolean
Public EsRetosModalidad2vs2 As Boolean
Public EsRetosModalidad3vs3 As Boolean
Public EsRetosModalidad4vs4 As Boolean
Public Team1Count As Integer
Public Team2Count As Integer
Public CuentaQuestReto As Byte

Public LiberarCuposRetos As Integer
Public GanoelteamReto As Integer

Sub UserDeslogeaRetosAuto(Userindex As Integer)
If EsRetosModalidad1vs1 Then 'reto 1vs1111111111111111111111111111111111111111111111111111111111111
Call UserMuereRetoAuto(Userindex)
ElseIf EsRetosModalidad2vs2 Then 'reto 2vs222222222222222222222222222222222222222

If EsUser1 Then

ElseIf EsUser2 Then

ElseIf EsUser3 Then

ElseIf EsUser4 Then

End If

ElseIf EsRetosModalidad3vs3 Then 'reto 3vs333333333333333333333333333333333333333333333333333333333333333

If EsUser1 Then

ElseIf EsUser2 Then

ElseIf EsUser3 Then

ElseIf EsUser4 Then

ElseIf EsUser5 Then

ElseIf EsUser6 Then

End If

ElseIf EsRetosModalidad4vs4 Then 'reto 4vs4444444444444444444444444444444444444444444444444

If EsUser1 Then

ElseIf EsUser2 Then

ElseIf EsUser3 Then

ElseIf EsUser4 Then

ElseIf EsUser5 Then

ElseIf EsUser6 Then

ElseIf EsUser7 Then

ElseIf EsUser8 Then

End If

ElseIf EsRetosModalidad5vs5 Then 'reto 5vs5555555555555555555555555555555555555555555555555555

If EsUser1 Then

ElseIf EsUser2 Then

ElseIf EsUser3 Then

ElseIf EsUser4 Then

ElseIf EsUser5 Then

ElseIf EsUser6 Then

ElseIf EsUser7 Then

ElseIf EsUser8 Then

ElseIf EsUser9 Then

ElseIf EsUser10 Then

End If

End If

End Sub

Sub UserMuereRetoAuto(Userindex As Integer)

If EsRetosModalidad1vs1 Then 'reto 1vs11111111111111111111111111111111111111111111111111111

If EsUser1 = Userindex Then

If Team2Count > 0 Then Team2Count = 0

Team1Count = Team1Count + 1
If Team1Count = 5 Then
Call SendData(ToAll, 0, 0, "||Retos automáticos> Ganador " & UserList(EsUser2).Name & " por llevar " & Team1Count & " retos ganados." & FONTTYPE_TALK)
Call SendData(ToAll, 0, 0, "||Retos automáticos> Premio 500.000 monedas de oro, 1 punto de quest y +300 puntos de reputación." & FONTTYPE_TALK)
UserList(EsUser2).Stats.GLD = UserList(EsUser2).Stats.GLD + 500000
UserList(EsUser2).Stats.Reputacion = UserList(EsUser2).Stats.Reputacion + 300
UserList(EsUser2).Faccion.Quests = UserList(EsUser2).Faccion.Quests + 1
Call WarpUserChar(EsUser1, 1, 50, 50, True)
Call WarpUserChar(EsUser2, 1, 50, 50, True)
Call ResetearTodoRetos
Exit Sub
End If

Call SendData(ToAll, 0, 0, "||Retos automáticos> Gana " & UserList(EsUser2).Name & " Lleva " & Team1Count & " retos ganados." & FONTTYPE_BLANKO)
Call WarpUserChar(EsUser1, 1, 45, 38, True)
frmMain.TimerRetoAutomatico.Enabled = True
EsUser1 = 0
End If
If EsUser2 = Userindex Then

If Team1Count > 0 Then Team1Count = 0

Team2Count = Team2Count + 1
If Team2Count = 5 Then
Call SendData(ToAll, 0, 0, "||Retos automáticos> Ganador " & UserList(EsUser1).Name & " por llevar " & Team2Count & " retos ganados." & FONTTYPE_TALK)
Call SendData(ToAll, 0, 0, "||Retos automáticos> Premio 1.000.000 monedas de oro, 1 punto de quest y +300 puntos de reputación." & FONTTYPE_TALK)
UserList(EsUser1).Stats.GLD = UserList(EsUser1).Stats.GLD + 1000000
UserList(EsUser1).Stats.Reputacion = UserList(EsUser1).Stats.Reputacion + 300
UserList(EsUser1).Faccion.Quests = UserList(EsUser1).Faccion.Quests + 1
Call WarpUserChar(EsUser1, 1, 50, 50, True)
Call WarpUserChar(EsUser2, 1, 50, 50, True)
Call ResetearTodoRetos
Exit Sub
End If

Call SendData(ToAll, 0, 0, "||Retos automáticos> Gana " & UserList(EsUser1).Name & " Lleva " & Team2Count & " retos ganados." & FONTTYPE_BLANKO)
Call WarpUserChar(EsUser2, 1, 83, 48, True)
frmMain.TimerRetoAutomatico.Enabled = True
EsUser2 = 0
End If

ElseIf EsRetosModalidad2vs2 Then 'reto 2vs22222222222222222222222222222222222222222222222222222222222222222222222222222222222222222222
If UserList(EsUser1).flags.Muerto = 1 And UserList(EsUser3).flags.Muerto = 1 Then

If Team2Count > 0 Then Team2Count = 0

Team1Count = Team1Count + 1
If Team1Count = 5 Then
Call SendData(ToAll, 0, 0, "||Retos automáticos> Ganadores " & UserList(EsUser2).Name & "-" & UserList(EsUser4).Name & " por llevar " & Team1Count & " retos ganados." & FONTTYPE_TALK)
Call SendData(ToAll, 0, 0, "||Retos automáticos> Premio 16 puntos de canjeos + 1 punto de quest." & FONTTYPE_TALK)
UserList(EsUser2).flags.CanjesDonador = UserList(EsUser2).flags.CanjesDonador + 16
UserList(EsUser2).Faccion.Quests = UserList(EsUser2).Faccion.Quests + 1
UserList(EsUser4).flags.CanjesDonador = UserList(EsUser4).flags.CanjesDonador + 16
UserList(EsUser4).Faccion.Quests = UserList(EsUser4).Faccion.Quests + 1
Call WarpUserChar(EsUser1, 1, 50, 50, True)
Call WarpUserChar(EsUser2, 1, 50, 50, True)
Call WarpUserChar(EsUser3, 1, 50, 50, True)
Call WarpUserChar(EsUser4, 1, 50, 50, True)
Call ResetearTodoRetos
Exit Sub
End If

Call SendData(ToAll, 0, 0, "||Retos automáticos> Ganan " & UserList(EsUser2).Name & "-" & UserList(EsUser4).Name & " Llevan " & Team1Count & " retos ganados." & FONTTYPE_BLANKO)
Call WarpUserChar(EsUser1, 1, 45, 38, True)
Call WarpUserChar(EsUser3, 1, 45, 38, True)
frmMain.TimerRetoAutomatico.Enabled = True
EsUser1 = 0
EsUser3 = 0
GanoelteamReto = 1
LiberarCuposRetos = 0
MapInfo(88).Pk = False
End If

If UserList(EsUser2).flags.Muerto = 1 And UserList(EsUser4).flags.Muerto = 1 Then

If Team1Count > 0 Then Team1Count = 0

Team2Count = Team2Count + 1
If Team2Count = 5 Then
Call SendData(ToAll, 0, 0, "||Retos automáticos> Ganadores " & UserList(EsUser1).Name & "-" & UserList(EsUser3).Name & " por llevar " & Team2Count & " retos ganados." & FONTTYPE_TALK)
Call SendData(ToAll, 0, 0, "||Retos automáticos> Premio 16 puntos de canjeos + 1 punto de quest." & FONTTYPE_TALK)
UserList(EsUser1).flags.CanjesDonador = UserList(EsUser1).flags.CanjesDonador + 16
UserList(EsUser1).Faccion.Quests = UserList(EsUser1).Faccion.Quests + 1
UserList(EsUser3).flags.CanjesDonador = UserList(EsUser3).flags.CanjesDonador + 16
UserList(EsUser3).Faccion.Quests = UserList(EsUser3).Faccion.Quests + 1
Call WarpUserChar(EsUser1, 1, 50, 50, True)
Call WarpUserChar(EsUser2, 1, 50, 50, True)
Call WarpUserChar(EsUser3, 1, 50, 50, True)
Call WarpUserChar(EsUser4, 1, 50, 50, True)
Call ResetearTodoRetos
Exit Sub
End If

Call SendData(ToAll, 0, 0, "||Retos automáticos> Ganan " & UserList(EsUser1).Name & "-" & UserList(EsUser3).Name & " Llevan " & Team2Count & " retos ganados." & FONTTYPE_BLANKO)
Call WarpUserChar(EsUser2, 1, 83, 48, True)
Call WarpUserChar(EsUser4, 1, 83, 48, True)
frmMain.TimerRetoAutomatico.Enabled = True
EsUser2 = 0
EsUser4 = 0
GanoelteamReto = 2
LiberarCuposRetos = 0
MapInfo(88).Pk = False
End If
ElseIf EsRetosModalidad3vs3 Then 'reto 3vs3333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333333
If UserList(EsUser1).flags.Muerto = 1 And UserList(EsUser3).flags.Muerto = 1 And UserList(EsUser5).flags.Muerto = 1 Then

If Team2Count > 0 Then Team2Count = 0

Team1Count = Team1Count + 1
If Team1Count = 5 Then
Call SendData(ToAll, 0, 0, "||Retos automáticos> Ganadores " & UserList(EsUser6).Name & "-" & UserList(EsUser2).Name & "-" & UserList(EsUser4).Name & " por llevar " & Team1Count & " retos ganados." & FONTTYPE_TALK)
Call SendData(ToAll, 0, 0, "||Retos automáticos> Premio 16 puntos de canjeos + 1 punto de quest." & FONTTYPE_TALK)
UserList(EsUser2).flags.CanjesDonador = UserList(EsUser2).flags.CanjesDonador + 16
UserList(EsUser2).Faccion.Quests = UserList(EsUser2).Faccion.Quests + 1
UserList(EsUser4).flags.CanjesDonador = UserList(EsUser4).flags.CanjesDonador + 16
UserList(EsUser4).Faccion.Quests = UserList(EsUser4).Faccion.Quests + 1
UserList(EsUser6).flags.CanjesDonador = UserList(EsUser4).flags.CanjesDonador + 16
UserList(EsUser6).Faccion.Quests = UserList(EsUser4).Faccion.Quests + 1
Call WarpUserChar(EsUser1, 1, 50, 50, True)
Call WarpUserChar(EsUser2, 1, 50, 50, True)
Call WarpUserChar(EsUser3, 1, 50, 50, True)
Call WarpUserChar(EsUser4, 1, 50, 50, True)
Call WarpUserChar(EsUser5, 1, 50, 50, True)
Call WarpUserChar(EsUser6, 1, 50, 50, True)
Call ResetearTodoRetos
Exit Sub
End If

Call SendData(ToAll, 0, 0, "||Retos automáticos> Ganan " & UserList(EsUser6).Name & "-" & UserList(EsUser2).Name & "-" & UserList(EsUser4).Name & " Llevan " & Team1Count & " retos ganados." & FONTTYPE_BLANKO)
Call WarpUserChar(EsUser1, 1, 45, 38, True)
Call WarpUserChar(EsUser3, 1, 45, 38, True)
Call WarpUserChar(EsUser5, 1, 45, 38, True)
frmMain.TimerRetoAutomatico.Enabled = True
EsUser1 = 0
EsUser3 = 0
EsUser5 = 0
GanoelteamReto = 1
LiberarCuposRetos = 0
MapInfo(88).Pk = False
End If

If UserList(EsUser2).flags.Muerto = 1 And UserList(EsUser4).flags.Muerto = 1 And UserList(EsUser6).flags.Muerto = 1 Then

If Team1Count > 0 Then Team1Count = 0

Team2Count = Team2Count + 1
If Team2Count = 5 Then
Call SendData(ToAll, 0, 0, "||Retos automáticos> Ganadores " & UserList(EsUser5).Name & "-" & UserList(EsUser1).Name & "-" & UserList(EsUser3).Name & " por llevar " & Team2Count & " retos ganados." & FONTTYPE_TALK)
Call SendData(ToAll, 0, 0, "||Retos automáticos> Premio 16 puntos de canjeos + 1 punto de quest." & FONTTYPE_TALK)
UserList(EsUser1).flags.CanjesDonador = UserList(EsUser1).flags.CanjesDonador + 16
UserList(EsUser1).Faccion.Quests = UserList(EsUser1).Faccion.Quests + 1
UserList(EsUser3).flags.CanjesDonador = UserList(EsUser3).flags.CanjesDonador + 16
UserList(EsUser3).Faccion.Quests = UserList(EsUser3).Faccion.Quests + 1
UserList(EsUser5).flags.CanjesDonador = UserList(EsUser4).flags.CanjesDonador + 16
UserList(EsUser5).Faccion.Quests = UserList(EsUser4).Faccion.Quests + 1
Call WarpUserChar(EsUser1, 1, 50, 50, True)
Call WarpUserChar(EsUser2, 1, 50, 50, True)
Call WarpUserChar(EsUser3, 1, 50, 50, True)
Call WarpUserChar(EsUser4, 1, 50, 50, True)
Call WarpUserChar(EsUser5, 1, 50, 50, True)
Call WarpUserChar(EsUser6, 1, 50, 50, True)
Call ResetearTodoRetos
Exit Sub
End If

Call SendData(ToAll, 0, 0, "||Retos automáticos> Ganan " & UserList(EsUser5).Name & "-" & UserList(EsUser1).Name & "-" & UserList(EsUser3).Name & " Llevan " & Team2Count & " retos ganados." & FONTTYPE_BLANKO)
Call WarpUserChar(EsUser2, 1, 83, 48, True)
Call WarpUserChar(EsUser4, 1, 83, 48, True)
Call WarpUserChar(EsUser6, 1, 83, 48, True)
frmMain.TimerRetoAutomatico.Enabled = True
EsUser2 = 0
EsUser4 = 0
EsUser6 = 0
GanoelteamReto = 2
LiberarCuposRetos = 0
MapInfo(88).Pk = False
End If
ElseIf EsRetosModalidad4vs4 Then 'reto 4vs44444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444444
If UserList(EsUser1).flags.Muerto = 1 And UserList(EsUser3).flags.Muerto = 1 And UserList(EsUser5).flags.Muerto = 1 And UserList(EsUser7).flags.Muerto = 1 Then

If Team2Count > 0 Then Team2Count = 0

Team1Count = Team1Count + 1
If Team1Count = 5 Then
Call SendData(ToAll, 0, 0, "||Retos automáticos> Ganadores " & UserList(EsUser8).Name & "-" & UserList(EsUser6).Name & "-" & UserList(EsUser2).Name & "-" & UserList(EsUser4).Name & " por llevar " & Team1Count & " retos ganados." & FONTTYPE_TALK)
Call SendData(ToAll, 0, 0, "||Retos automáticos> Premio 16 puntos de canjeos + 1 punto de quest." & FONTTYPE_TALK)
UserList(EsUser2).flags.CanjesDonador = UserList(EsUser2).flags.CanjesDonador + 16
UserList(EsUser2).Faccion.Quests = UserList(EsUser2).Faccion.Quests + 1
UserList(EsUser4).flags.CanjesDonador = UserList(EsUser4).flags.CanjesDonador + 16
UserList(EsUser4).Faccion.Quests = UserList(EsUser4).Faccion.Quests + 1
UserList(EsUser6).flags.CanjesDonador = UserList(EsUser4).flags.CanjesDonador + 16
UserList(EsUser6).Faccion.Quests = UserList(EsUser4).Faccion.Quests + 1
UserList(EsUser8).flags.CanjesDonador = UserList(EsUser4).flags.CanjesDonador + 16
UserList(EsUser8).Faccion.Quests = UserList(EsUser4).Faccion.Quests + 1
Call WarpUserChar(EsUser1, 1, 50, 50, True)
Call WarpUserChar(EsUser2, 1, 50, 50, True)
Call WarpUserChar(EsUser3, 1, 50, 50, True)
Call WarpUserChar(EsUser4, 1, 50, 50, True)
Call WarpUserChar(EsUser5, 1, 50, 50, True)
Call WarpUserChar(EsUser6, 1, 50, 50, True)
Call WarpUserChar(EsUser7, 1, 50, 50, True)
Call WarpUserChar(EsUser8, 1, 50, 50, True)
Call ResetearTodoRetos
Exit Sub
End If

Call SendData(ToAll, 0, 0, "||Retos automáticos> Ganan " & UserList(EsUser8).Name & "-" & UserList(EsUser6).Name & "-" & UserList(EsUser2).Name & "-" & UserList(EsUser4).Name & " Llevan " & Team1Count & " retos ganados." & FONTTYPE_BLANKO)
Call WarpUserChar(EsUser1, 1, 45, 38, True)
Call WarpUserChar(EsUser3, 1, 45, 38, True)
Call WarpUserChar(EsUser5, 1, 45, 38, True)
Call WarpUserChar(EsUser7, 1, 45, 38, True)
frmMain.TimerRetoAutomatico.Enabled = True
EsUser1 = 0
EsUser3 = 0
EsUser5 = 0
EsUser7 = 0
GanoelteamReto = 1
LiberarCuposRetos = 0
MapInfo(88).Pk = False
End If

If UserList(EsUser2).flags.Muerto = 1 And UserList(EsUser4).flags.Muerto = 1 And UserList(EsUser6).flags.Muerto = 1 And UserList(EsUser8).flags.Muerto = 1 Then

If Team1Count > 0 Then Team1Count = 0

Team2Count = Team2Count + 1
If Team2Count = 5 Then
Call SendData(ToAll, 0, 0, "||Retos automáticos> Ganadores " & UserList(EsUser7).Name & "-" & UserList(EsUser5).Name & "-" & UserList(EsUser1).Name & "-" & UserList(EsUser3).Name & " por llevar " & Team2Count & " retos ganados." & FONTTYPE_TALK)
Call SendData(ToAll, 0, 0, "||Retos automáticos> Premio 16 puntos de canjeos + 1 punto de quest." & FONTTYPE_TALK)
UserList(EsUser1).flags.CanjesDonador = UserList(EsUser1).flags.CanjesDonador + 16
UserList(EsUser1).Faccion.Quests = UserList(EsUser1).Faccion.Quests + 1
UserList(EsUser3).flags.CanjesDonador = UserList(EsUser3).flags.CanjesDonador + 16
UserList(EsUser3).Faccion.Quests = UserList(EsUser3).Faccion.Quests + 1
UserList(EsUser5).flags.CanjesDonador = UserList(EsUser4).flags.CanjesDonador + 16
UserList(EsUser5).Faccion.Quests = UserList(EsUser4).Faccion.Quests + 1
UserList(EsUser7).flags.CanjesDonador = UserList(EsUser4).flags.CanjesDonador + 16
UserList(EsUser7).Faccion.Quests = UserList(EsUser4).Faccion.Quests + 1
Call WarpUserChar(EsUser1, 1, 50, 50, True)
Call WarpUserChar(EsUser2, 1, 50, 50, True)
Call WarpUserChar(EsUser3, 1, 50, 50, True)
Call WarpUserChar(EsUser4, 1, 50, 50, True)
Call WarpUserChar(EsUser5, 1, 50, 50, True)
Call WarpUserChar(EsUser6, 1, 50, 50, True)
Call WarpUserChar(EsUser7, 1, 50, 50, True)
Call WarpUserChar(EsUser8, 1, 50, 50, True)
Call ResetearTodoRetos
Exit Sub
End If

Call SendData(ToAll, 0, 0, "||Retos automáticos> Ganan " & UserList(EsUser7).Name & "-" & UserList(EsUser5).Name & "-" & UserList(EsUser1).Name & "-" & UserList(EsUser3).Name & " Llevan " & Team2Count & " retos ganados." & FONTTYPE_BLANKO)
Call WarpUserChar(EsUser2, 1, 83, 48, True)
Call WarpUserChar(EsUser4, 1, 83, 48, True)
Call WarpUserChar(EsUser6, 1, 83, 48, True)
Call WarpUserChar(EsUser8, 1, 83, 48, True)
frmMain.TimerRetoAutomatico.Enabled = True
EsUser2 = 0
EsUser4 = 0
EsUser6 = 0
EsUser8 = 0
GanoelteamReto = 2
LiberarCuposRetos = 0
MapInfo(88).Pk = False
End If
ElseIf EsRetosModalidad5vs5 Then 'reto 5vs55555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555555
If UserList(EsUser1).flags.Muerto = 1 And UserList(EsUser3).flags.Muerto = 1 And UserList(EsUser5).flags.Muerto = 1 And UserList(EsUser7).flags.Muerto = 1 And UserList(EsUser9).flags.Muerto = 1 Then

If Team2Count > 0 Then Team2Count = 0

Team1Count = Team1Count + 1
If Team1Count = 5 Then
Call SendData(ToAll, 0, 0, "||Retos automáticos> Ganadores " & UserList(EsUser10).Name & "-" & UserList(EsUser8).Name & "-" & UserList(EsUser6).Name & "-" & UserList(EsUser2).Name & "-" & UserList(EsUser4).Name & " por llevar " & Team1Count & " retos ganados." & FONTTYPE_TALK)
Call SendData(ToAll, 0, 0, "||Retos automáticos> Premio 16 puntos de canjeos + 1 punto de quest." & FONTTYPE_TALK)
UserList(EsUser2).flags.CanjesDonador = UserList(EsUser2).flags.CanjesDonador + 16
UserList(EsUser2).Faccion.Quests = UserList(EsUser2).Faccion.Quests + 1
UserList(EsUser4).flags.CanjesDonador = UserList(EsUser4).flags.CanjesDonador + 16
UserList(EsUser4).Faccion.Quests = UserList(EsUser4).Faccion.Quests + 1
UserList(EsUser6).flags.CanjesDonador = UserList(EsUser4).flags.CanjesDonador + 16
UserList(EsUser6).Faccion.Quests = UserList(EsUser4).Faccion.Quests + 1
UserList(EsUser8).flags.CanjesDonador = UserList(EsUser4).flags.CanjesDonador + 16
UserList(EsUser8).Faccion.Quests = UserList(EsUser4).Faccion.Quests + 1
UserList(EsUser10).flags.CanjesDonador = UserList(EsUser4).flags.CanjesDonador + 16
UserList(EsUser10).Faccion.Quests = UserList(EsUser4).Faccion.Quests + 1
Call WarpUserChar(EsUser1, 1, 50, 50, True)
Call WarpUserChar(EsUser2, 1, 50, 50, True)
Call WarpUserChar(EsUser3, 1, 50, 50, True)
Call WarpUserChar(EsUser4, 1, 50, 50, True)
Call WarpUserChar(EsUser5, 1, 50, 50, True)
Call WarpUserChar(EsUser6, 1, 50, 50, True)
Call WarpUserChar(EsUser7, 1, 50, 50, True)
Call WarpUserChar(EsUser8, 1, 50, 50, True)
Call WarpUserChar(EsUser9, 1, 50, 50, True)
Call WarpUserChar(EsUser10, 1, 50, 50, True)
Call ResetearTodoRetos
Exit Sub
End If

Call SendData(ToAll, 0, 0, "||Retos automáticos> Ganan " & UserList(EsUser10).Name & "-" & UserList(EsUser8).Name & "-" & UserList(EsUser6).Name & "-" & UserList(EsUser2).Name & "-" & UserList(EsUser4).Name & " Llevan " & Team1Count & " retos ganados." & FONTTYPE_BLANKO)
Call WarpUserChar(EsUser1, 1, 45, 38, True)
Call WarpUserChar(EsUser3, 1, 45, 38, True)
Call WarpUserChar(EsUser5, 1, 45, 38, True)
Call WarpUserChar(EsUser7, 1, 45, 38, True)
Call WarpUserChar(EsUser9, 1, 45, 38, True)
frmMain.TimerRetoAutomatico.Enabled = True
EsUser1 = 0
EsUser3 = 0
EsUser5 = 0
EsUser7 = 0
EsUser9 = 0
GanoelteamReto = 1
LiberarCuposRetos = 0
MapInfo(88).Pk = False
End If

If UserList(EsUser2).flags.Muerto = 1 And UserList(EsUser4).flags.Muerto = 1 And UserList(EsUser6).flags.Muerto = 1 And UserList(EsUser8).flags.Muerto = 1 And UserList(EsUser10).flags.Muerto = 1 Then

If Team1Count > 0 Then Team1Count = 0

Team2Count = Team2Count + 1
If Team2Count = 5 Then
Call SendData(ToAll, 0, 0, "||Retos automáticos> Ganadores " & UserList(EsUser9).Name & "-" & UserList(EsUser7).Name & "-" & UserList(EsUser5).Name & "-" & UserList(EsUser1).Name & "-" & UserList(EsUser3).Name & " por llevar " & Team2Count & " retos ganados." & FONTTYPE_TALK)
Call SendData(ToAll, 0, 0, "||Retos automáticos> Premio 16 puntos de canjeos + 1 punto de quest." & FONTTYPE_TALK)
UserList(EsUser1).flags.CanjesDonador = UserList(EsUser1).flags.CanjesDonador + 16
UserList(EsUser1).Faccion.Quests = UserList(EsUser1).Faccion.Quests + 1
UserList(EsUser3).flags.CanjesDonador = UserList(EsUser3).flags.CanjesDonador + 16
UserList(EsUser3).Faccion.Quests = UserList(EsUser3).Faccion.Quests + 1
UserList(EsUser5).flags.CanjesDonador = UserList(EsUser4).flags.CanjesDonador + 16
UserList(EsUser5).Faccion.Quests = UserList(EsUser4).Faccion.Quests + 1
UserList(EsUser7).flags.CanjesDonador = UserList(EsUser4).flags.CanjesDonador + 16
UserList(EsUser7).Faccion.Quests = UserList(EsUser4).Faccion.Quests + 1
UserList(EsUser9).flags.CanjesDonador = UserList(EsUser4).flags.CanjesDonador + 16
UserList(EsUser9).Faccion.Quests = UserList(EsUser4).Faccion.Quests + 1
Call WarpUserChar(EsUser1, 1, 50, 50, True)
Call WarpUserChar(EsUser2, 1, 50, 50, True)
Call WarpUserChar(EsUser3, 1, 50, 50, True)
Call WarpUserChar(EsUser4, 1, 50, 50, True)
Call WarpUserChar(EsUser5, 1, 50, 50, True)
Call WarpUserChar(EsUser6, 1, 50, 50, True)
Call WarpUserChar(EsUser7, 1, 50, 50, True)
Call WarpUserChar(EsUser8, 1, 50, 50, True)
Call WarpUserChar(EsUser9, 1, 50, 50, True)
Call WarpUserChar(EsUser10, 1, 50, 50, True)
Call ResetearTodoRetos
Exit Sub
End If

Call SendData(ToAll, 0, 0, "||Retos automáticos> Ganan " & UserList(EsUser9).Name & "-" & UserList(EsUser7).Name & "-" & UserList(EsUser5).Name & "-" & UserList(EsUser1).Name & "-" & UserList(EsUser3).Name & " Llevan " & Team2Count & " retos ganados." & FONTTYPE_BLANKO)
Call WarpUserChar(EsUser2, 1, 83, 48, True)
Call WarpUserChar(EsUser4, 1, 83, 48, True)
Call WarpUserChar(EsUser6, 1, 83, 48, True)
Call WarpUserChar(EsUser8, 1, 83, 48, True)
Call WarpUserChar(EsUser10, 1, 83, 48, True)
frmMain.TimerRetoAutomatico.Enabled = True
EsUser2 = 0
EsUser4 = 0
EsUser6 = 0
EsUser8 = 0
EsUser10 = 0
GanoelteamReto = 2
LiberarCuposRetos = 0
MapInfo(88).Pk = False
End If
End If

End Sub

Sub MandarUsuariosAzar(Userindex As Integer)
If RetosAutomaticosX = False Then 'Cuando gana 1 abre los cupos seteando en false la variable

  If Not ClaseTorneo = "TODAS" Then
        If Not UserList(Userindex).Clase = ClaseTorneovariable Then
        Call SendData(ToIndex, Userindex, 0, "||El torneo es solo para la clase: " & ClaseTorneo & "." & FONTTYPE_INFO)
        Exit Sub
        End If
        End If
        
If Userindex = EsUser1 Or Userindex = EsUser2 Or Userindex = EsUser3 Or Userindex = EsUser4 Or Userindex = EsUser5 Or Userindex = EsUser6 Or Userindex = EsUser7 Or Userindex = EsUser8 Or Userindex = EsUser9 Or Userindex = EsUser10 Then Exit Sub 'ya entraste gil

If EsRetosModalidad1vs1 Then 'reto 1vs111111111111111111111111111111111111111111111
If EsUser1 Then
EsUser2 = Userindex
Call MandarARetar(EsUser1, EsUser2)
Exit Sub
End If

If EsUser2 Then
EsUser1 = Userindex
Call MandarARetar(EsUser1, EsUser2)
Exit Sub
End If
ElseIf EsRetosModalidad2vs2 Then 'reto 2vs222222222222222222222222222222222222222222222222
LiberarCuposRetos = LiberarCuposRetos + 1

If GanoelteamReto = 1 Then
If LiberarCuposRetos = 1 Then
EsUser1 = Userindex
Call WarpUserChar(EsUser1, 88, 30, 55, True)
ElseIf LiberarCuposRetos = 2 Then
EsUser3 = Userindex
Call WarpUserChar(EsUser3, 88, 30, 55, True)
Call MandarARetar(EsUser1, EsUser2, EsUser3, EsUser4)
Exit Sub
End If
End If

If GanoelteamReto = 2 Then
If LiberarCuposRetos = 1 Then
EsUser2 = Userindex
Call WarpUserChar(EsUser2, 88, 30, 55, True)
ElseIf LiberarCuposRetos = 2 Then
EsUser4 = Userindex
Call WarpUserChar(EsUser4, 88, 30, 55, True)
Call MandarARetar(EsUser1, EsUser2, EsUser3, EsUser4)
Exit Sub
End If
End If

ElseIf EsRetosModalidad3vs3 Then 'reto 3vs3333333333333333333333333333333333333333333333333333333333
LiberarCuposRetos = LiberarCuposRetos + 1

If GanoelteamReto = 1 Then
If LiberarCuposRetos = 1 Then
EsUser1 = Userindex
Call WarpUserChar(EsUser1, 88, 30, 55, True)
ElseIf LiberarCuposRetos = 2 Then
EsUser3 = Userindex
Call WarpUserChar(EsUser3, 88, 30, 55, True)
ElseIf LiberarCuposRetos = 3 Then
EsUser5 = Userindex
Call WarpUserChar(EsUser5, 88, 30, 55, True)
Call MandarARetar(EsUser1, EsUser2, EsUser3, EsUser4, EsUser5, EsUser6)
Exit Sub
End If
End If

If GanoelteamReto = 2 Then
If LiberarCuposRetos = 1 Then
EsUser2 = Userindex
Call WarpUserChar(EsUser2, 88, 30, 55, True)
ElseIf LiberarCuposRetos = 2 Then
EsUser4 = Userindex
Call WarpUserChar(EsUser4, 88, 30, 55, True)
ElseIf LiberarCuposRetos = 3 Then
EsUser6 = Userindex
Call WarpUserChar(EsUser6, 88, 30, 55, True)
Call MandarARetar(EsUser1, EsUser2, EsUser3, EsUser4, EsUser5, EsUser6)
Exit Sub
End If
End If

ElseIf EsRetosModalidad4vs4 Then 'reto 4vs4444444444444444444444444444444444444444444444444444444444444444444444444
LiberarCuposRetos = LiberarCuposRetos + 1

If GanoelteamReto = 1 Then
If LiberarCuposRetos = 1 Then
EsUser1 = Userindex
Call WarpUserChar(EsUser1, 88, 30, 55, True)
ElseIf LiberarCuposRetos = 2 Then
EsUser3 = Userindex
Call WarpUserChar(EsUser3, 88, 30, 55, True)
ElseIf LiberarCuposRetos = 3 Then
EsUser5 = Userindex
Call WarpUserChar(EsUser5, 88, 30, 55, True)
ElseIf LiberarCuposRetos = 4 Then
EsUser7 = Userindex
Call WarpUserChar(EsUser7, 88, 30, 55, True)
Call MandarARetar(EsUser1, EsUser2, EsUser3, EsUser4, EsUser5, EsUser6, EsUser7, EsUser8)
Exit Sub
End If
End If

If GanoelteamReto = 2 Then
If LiberarCuposRetos = 1 Then
EsUser2 = Userindex
Call WarpUserChar(EsUser2, 88, 30, 55, True)
ElseIf LiberarCuposRetos = 2 Then
EsUser4 = Userindex
Call WarpUserChar(EsUser4, 88, 30, 55, True)
ElseIf LiberarCuposRetos = 3 Then
EsUser6 = Userindex
Call WarpUserChar(EsUser6, 88, 30, 55, True)
ElseIf LiberarCuposRetos = 4 Then
EsUser8 = Userindex
Call WarpUserChar(EsUser8, 88, 30, 55, True)
Call MandarARetar(EsUser1, EsUser2, EsUser3, EsUser4, EsUser5, EsUser6, EsUser7, EsUser8)
Exit Sub
End If
End If

ElseIf EsRetosModalidad5vs5 Then 'reto 5vs666666666666666666666666666666666666666666666666666666666
LiberarCuposRetos = LiberarCuposRetos + 1

If GanoelteamReto = 1 Then
If LiberarCuposRetos = 1 Then
EsUser1 = Userindex
Call WarpUserChar(EsUser1, 88, 30, 55, True)
ElseIf LiberarCuposRetos = 2 Then
EsUser3 = Userindex
Call WarpUserChar(EsUser3, 88, 30, 55, True)
ElseIf LiberarCuposRetos = 3 Then
EsUser5 = Userindex
Call WarpUserChar(EsUser5, 88, 30, 55, True)
ElseIf LiberarCuposRetos = 4 Then
EsUser7 = Userindex
Call WarpUserChar(EsUser7, 88, 30, 55, True)
ElseIf LiberarCuposRetos = 5 Then
EsUser9 = Userindex
Call WarpUserChar(EsUser9, 88, 30, 55, True)
Call MandarARetar(EsUser1, EsUser2, EsUser3, EsUser4, EsUser5, EsUser6, EsUser7, EsUser8, EsUser9, EsUser10)
Exit Sub
End If
End If

If GanoelteamReto = 2 Then
If LiberarCuposRetos = 1 Then
EsUser2 = Userindex
Call WarpUserChar(EsUser2, 88, 30, 55, True)
ElseIf LiberarCuposRetos = 2 Then
EsUser4 = Userindex
Call WarpUserChar(EsUser4, 88, 30, 55, True)
ElseIf LiberarCuposRetos = 3 Then
EsUser6 = Userindex
Call WarpUserChar(EsUser6, 88, 30, 55, True)
ElseIf LiberarCuposRetos = 4 Then
EsUser8 = Userindex
Call WarpUserChar(EsUser8, 88, 30, 55, True)
ElseIf LiberarCuposRetos = 5 Then
EsUser10 = Userindex
Call WarpUserChar(EsUser10, 88, 30, 55, True)
Call MandarARetar(EsUser1, EsUser2, EsUser3, EsUser4, EsUser5, EsUser6, EsUser7, EsUser8, EsUser9, EsUser10)
Exit Sub
End If
End If

End If
End If


If RetosAutomaticos = True Then 'abre los cupo seteando en true primera vez
If CuposRetosXmodalidad = CuposAbiertos Then Exit Sub ' cupo lleno
 
        If Not ClaseTorneo = "TODAS" Then
        If Not UserList(Userindex).Clase = ClaseTorneovariable Then
        Call SendData(ToIndex, Userindex, 0, "||El torneo es solo para la clase: " & ClaseTorneo & "." & FONTTYPE_INFO)
        Exit Sub
        End If
        End If
        
If Userindex = EsUser1 Or Userindex = EsUser2 Or Userindex = EsUser3 Or Userindex = EsUser4 Or Userindex = EsUser5 Or Userindex = EsUser6 Or Userindex = EsUser7 Or Userindex = EsUser8 Or Userindex = EsUser9 Or Userindex = EsUser10 Then Exit Sub 'ya entraste gil

CuposRetosXmodalidad = CuposRetosXmodalidad + 1

If CuposRetosXmodalidad = 1 Then 'Entra el primero

EsUser1 = Userindex
Call WarpUserChar(EsUser1, 88, 30, 55, True)

ElseIf CuposRetosXmodalidad = 2 Then

EsUser2 = Userindex
Call WarpUserChar(EsUser2, 88, 30, 55, True)

If EsRetosModalidad1vs1 Then
Call MandarARetar(EsUser1, EsUser2)
End If

ElseIf CuposRetosXmodalidad = 3 Then

EsUser3 = Userindex
Call WarpUserChar(EsUser3, 88, 30, 55, True)

ElseIf CuposRetosXmodalidad = 4 Then

EsUser4 = Userindex
Call WarpUserChar(EsUser4, 88, 30, 55, True)

If EsRetosModalidad2vs2 Then
Call MandarARetar(EsUser1, EsUser2, EsUser3, EsUser4)
End If

ElseIf CuposRetosXmodalidad = 5 Then

EsUser5 = Userindex
Call WarpUserChar(EsUser5, 88, 30, 55, True)

ElseIf CuposRetosXmodalidad = 6 Then

EsUser6 = Userindex
Call WarpUserChar(EsUser6, 88, 30, 55, True)

If EsRetosModalidad3vs3 Then
Call MandarARetar(EsUser1, EsUser2, EsUser3, EsUser4, EsUser5, EsUser6)
End If

ElseIf CuposRetosXmodalidad = 7 Then

EsUser7 = Userindex
Call WarpUserChar(EsUser7, 88, 30, 55, True)

ElseIf CuposRetosXmodalidad = 8 Then

EsUser8 = Userindex
Call WarpUserChar(EsUser8, 88, 30, 55, True)

If EsRetosModalidad4vs4 Then
Call MandarARetar(EsUser1, EsUser2, EsUser3, EsUser4, EsUser5, EsUser6, EsUser7, EsUser8)
End If

ElseIf CuposRetosXmodalidad = 9 Then

EsUser9 = Userindex
Call WarpUserChar(EsUser9, 88, 30, 55, True)

ElseIf CuposRetosXmodalidad = 10 Then

EsUser10 = Userindex
Call WarpUserChar(EsUser10, 88, 30, 55, True)

If EsRetosModalidad5vs5 Then
Call MandarARetar(EsUser1, EsUser2, EsUser3, EsUser4, EsUser5, EsUser6, EsUser7, EsUser8, EsUser9, EsUser10)
End If

End If
End If
End Sub

Sub MandarARetar(EsUser1 As Integer, EsUser2 As Integer, Optional EsUser3 As Integer, Optional EsUser4 As Integer, Optional EsUser5 As Integer, Optional EsUser6 As Integer, Optional EsUser7 As Integer, Optional EsUser8 As Integer, Optional EsUser9 As Integer, Optional EsUser10 As Integer)
If EsRetosModalidad1vs1 Then
Call WarpUserChar(EsUser1, 88, 22, 48, True)
Call WarpUserChar(EsUser2, 88, 47, 65, True)
UserList(EsUser1).flags.Navegando = 1
UserList(EsUser2).flags.Navegando = 1
Call SendData(ToAll, 0, 0, "||Retos automáticos> Se enfrentan " & UserList(EsUser1).Name & " Vs. " & UserList(EsUser2).Name & " a un reto." & FONTTYPE_TALK)
ElseIf EsRetosModalidad2vs2 Then
Call WarpUserChar(EsUser1, 88, 22, 48, True)
Call WarpUserChar(EsUser2, 88, 47, 65, True)
Call WarpUserChar(EsUser3, 88, 23, 48, True)
Call WarpUserChar(EsUser4, 88, 46, 65, True)
UserList(EsUser1).flags.Navegando = 1
UserList(EsUser2).flags.Navegando = 1
UserList(EsUser3).flags.Navegando = 1
UserList(EsUser4).flags.Navegando = 1
Call SendData(ToAll, 0, 0, "||Retos automáticos> Se enfrentan " & UserList(EsUser1).Name & "-" & UserList(EsUser3).Name & " Vs. " & UserList(EsUser2).Name & "-" & UserList(EsUser4).Name & " a un reto." & FONTTYPE_TALK)
ElseIf EsRetosModalidad3vs3 Then
Call WarpUserChar(EsUser1, 88, 22, 48, True)
Call WarpUserChar(EsUser2, 88, 47, 65, True)
Call WarpUserChar(EsUser3, 88, 23, 48, True)
Call WarpUserChar(EsUser4, 88, 46, 65, True)
Call WarpUserChar(EsUser5, 88, 24, 48, True)
Call WarpUserChar(EsUser6, 88, 45, 65, True)
UserList(EsUser1).flags.Navegando = 1
UserList(EsUser2).flags.Navegando = 1
UserList(EsUser3).flags.Navegando = 1
UserList(EsUser4).flags.Navegando = 1
UserList(EsUser5).flags.Navegando = 1
UserList(EsUser6).flags.Navegando = 1
Call SendData(ToAll, 0, 0, "||Retos automáticos> Se enfrentan " & UserList(EsUser5).Name & "-" & UserList(EsUser1).Name & "-" & UserList(EsUser3).Name & " Vs. " & UserList(EsUser6).Name & "-" & UserList(EsUser2).Name & "-" & UserList(EsUser4).Name & " a un reto." & FONTTYPE_TALK)
ElseIf EsRetosModalidad4vs4 Then
Call WarpUserChar(EsUser1, 88, 22, 48, True)
Call WarpUserChar(EsUser2, 88, 47, 65, True)
Call WarpUserChar(EsUser3, 88, 23, 48, True)
Call WarpUserChar(EsUser4, 88, 46, 65, True)
Call WarpUserChar(EsUser5, 88, 24, 48, True)
Call WarpUserChar(EsUser6, 88, 45, 65, True)
Call WarpUserChar(EsUser7, 88, 22, 49, True)
Call WarpUserChar(EsUser8, 88, 47, 64, True)
UserList(EsUser1).flags.Navegando = 1
UserList(EsUser2).flags.Navegando = 1
UserList(EsUser3).flags.Navegando = 1
UserList(EsUser4).flags.Navegando = 1
UserList(EsUser5).flags.Navegando = 1
UserList(EsUser6).flags.Navegando = 1
UserList(EsUser7).flags.Navegando = 1
UserList(EsUser8).flags.Navegando = 1
Call SendData(ToAll, 0, 0, "||Retos automáticos> Se enfrentan " & UserList(EsUser7).Name & "-" & UserList(EsUser5).Name & "-" & UserList(EsUser1).Name & "-" & UserList(EsUser3).Name & " Vs. " & UserList(EsUser8).Name & "-" & UserList(EsUser6).Name & "-" & UserList(EsUser2).Name & "-" & UserList(EsUser4).Name & " a un reto." & FONTTYPE_TALK)
ElseIf EsRetosModalidad5vs5 Then
Call WarpUserChar(EsUser1, 88, 22, 48, True)
Call WarpUserChar(EsUser2, 88, 47, 65, True)
Call WarpUserChar(EsUser3, 88, 23, 48, True)
Call WarpUserChar(EsUser4, 88, 46, 65, True)
Call WarpUserChar(EsUser5, 88, 24, 48, True)
Call WarpUserChar(EsUser6, 88, 45, 65, True)
Call WarpUserChar(EsUser7, 88, 22, 49, True)
Call WarpUserChar(EsUser8, 88, 47, 64, True)
Call WarpUserChar(EsUser9, 88, 23, 49, True)
Call WarpUserChar(EsUser10, 88, 46, 64, True)
UserList(EsUser1).flags.Navegando = 1
UserList(EsUser2).flags.Navegando = 1
UserList(EsUser3).flags.Navegando = 1
UserList(EsUser4).flags.Navegando = 1
UserList(EsUser5).flags.Navegando = 1
UserList(EsUser6).flags.Navegando = 1
UserList(EsUser7).flags.Navegando = 1
UserList(EsUser8).flags.Navegando = 1
UserList(EsUser9).flags.Navegando = 1
UserList(EsUser10).flags.Navegando = 1
Call SendData(ToAll, 0, 0, "||Retos automáticos> Se enfrentan " & UserList(EsUser9).Name & "-" & UserList(EsUser7).Name & "-" & UserList(EsUser5).Name & "-" & UserList(EsUser1).Name & "-" & UserList(EsUser3).Name & " Vs. " & UserList(EsUser10).Name & "-" & UserList(EsUser8).Name & "-" & UserList(EsUser6).Name & "-" & UserList(EsUser2).Name & "-" & UserList(EsUser4).Name & " a un reto." & FONTTYPE_TALK)
End If

MapInfo(88).Pk = True
RetosAutomaticos = False
RetosAutomaticosX = True
CuentaQuestReto = 10
LiberarCuposRetos = 0
End Sub

Sub AbrirQuestRetos(Modalidad As String)
If RetosAutomaticos = False Then
RetosAutomaticos = True
RetosAutomaticosX = True
CuposRetosXmodalidad = 0
MapInfo(88).Pk = False
LiberarCuposRetos = 0
GanoelteamReto = 0

Call SendData(ToAll, 0, 0, "TW123")

If Modalidad = 1 Then
Call SendData(ToAll, 0, 0, "||Retos automáticos> Esta comenzando un evento de retos 1vs1 al AZAR envía /PARTICIPAR si desea entrar." & FONTTYPE_TALK)
CuposAbiertos = 2
EsRetosModalidad1vs1 = True
ElseIf Modalidad = 2 Then
Call SendData(ToAll, 0, 0, "||Retos automáticos> Esta comenzando un evento de retos 2vs2 al AZAR envía /PARTICIPAR si desea entrar." & FONTTYPE_TALK)
CuposAbiertos = 4
EsRetosModalidad2vs2 = True
ElseIf Modalidad = 3 Then
Call SendData(ToAll, 0, 0, "||Retos automáticos> Esta comenzando un evento de retos 3vs3 al AZAR envía /PARTICIPAR si desea entrar." & FONTTYPE_TALK)
CuposAbiertos = 6
EsRetosModalidad3vs3 = True
ElseIf Modalidad = 4 Then
Call SendData(ToAll, 0, 0, "||Retos automáticos> Esta comenzando un evento de retos 4vs4 al AZAR envía /PARTICIPAR si desea entrar." & FONTTYPE_TALK)
CuposAbiertos = 8
EsRetosModalidad4vs4 = True
ElseIf Modalidad = 5 Then
Call SendData(ToAll, 0, 0, "||Retos automáticos> Esta comenzando un evento de retos 5vs5 al AZAR envía /PARTICIPAR si desea entrar." & FONTTYPE_TALK)
CuposAbiertos = 10
EsRetosModalidad5vs5 = True
End If
End If
End Sub

Sub CancelarQuestRetos()

Dim loopc As Integer
    For loopc = 1 To LastUser
        If UserList(loopc).POS.Map = 88 Then
            Call WarpUserChar(loopc, 1, 50, 50, True)
        End If
        Next
        
Call SendData(ToAll, 0, 0, "||Retos automáticos> Evento cancelado." & FONTTYPE_TALK)
Call ResetearTodoRetos
End Sub


Sub ResetearTodoRetos()
EsUser1 = 0
EsUser2 = 0
EsUser3 = 0
EsUser4 = 0
EsUser5 = 0
EsUser6 = 0
EsUser7 = 0
EsUser8 = 0
EsUser9 = 0
EsUser10 = 0

 RetosAutomaticos = False
 RetosAutomaticosX = True
 CuposAbiertos = 0
 CuposRetosXmodalidad = 0
 GanoelteamReto = 0
 LiberarCuposRetos = 0
 EsRetosModalidad1vs1 = False
 EsRetosModalidad2vs2 = False
 EsRetosModalidad3vs3 = False
 EsRetosModalidad4vs4 = False
 Team1Count = 0
 Team2Count = 0
End Sub


Public Sub CCuentaQuestReto()

CuentaQuestReto = CuentaQuestReto - 1


If CuentaQuestReto = 0 Then

If EsRetosModalidad1vs1 Then

UserList(EsUser1).flags.Navegando = 0
UserList(EsUser2).flags.Navegando = 0

Call SendData(ToIndex, EsUser1, 88, "||Reto> YA!!!" & FONTTYPE_FIGHTT)
Call SendData(ToIndex, EsUser2, 88, "||Reto> YA!!!" & FONTTYPE_FIGHTT)

ElseIf EsRetosModalidad2vs2 Then

UserList(EsUser1).flags.Navegando = 0
UserList(EsUser2).flags.Navegando = 0
UserList(EsUser3).flags.Navegando = 0
UserList(EsUser4).flags.Navegando = 0

Call SendData(ToIndex, EsUser1, 88, "||Reto> YA!!!" & FONTTYPE_FIGHTT)
Call SendData(ToIndex, EsUser2, 88, "||Reto> YA!!!" & FONTTYPE_FIGHTT)
Call SendData(ToIndex, EsUser3, 88, "||Reto> YA!!!" & FONTTYPE_FIGHTT)
Call SendData(ToIndex, EsUser4, 88, "||Reto> YA!!!" & FONTTYPE_FIGHTT)

ElseIf EsRetosModalidad3vs3 Then

UserList(EsUser1).flags.Navegando = 0
UserList(EsUser2).flags.Navegando = 0
UserList(EsUser3).flags.Navegando = 0
UserList(EsUser4).flags.Navegando = 0
UserList(EsUser5).flags.Navegando = 0
UserList(EsUser6).flags.Navegando = 0

Call SendData(ToIndex, EsUser1, 88, "||Reto> YA!!!" & FONTTYPE_FIGHTT)
Call SendData(ToIndex, EsUser2, 88, "||Reto> YA!!!" & FONTTYPE_FIGHTT)
Call SendData(ToIndex, EsUser3, 88, "||Reto> YA!!!" & FONTTYPE_FIGHTT)
Call SendData(ToIndex, EsUser4, 88, "||Reto> YA!!!" & FONTTYPE_FIGHTT)
Call SendData(ToIndex, EsUser5, 88, "||Reto> YA!!!" & FONTTYPE_FIGHTT)
Call SendData(ToIndex, EsUser6, 88, "||Reto> YA!!!" & FONTTYPE_FIGHTT)

ElseIf EsRetosModalidad4vs4 Then

UserList(EsUser1).flags.Navegando = 0
UserList(EsUser2).flags.Navegando = 0
UserList(EsUser3).flags.Navegando = 0
UserList(EsUser4).flags.Navegando = 0
UserList(EsUser5).flags.Navegando = 0
UserList(EsUser6).flags.Navegando = 0
UserList(EsUser7).flags.Navegando = 0
UserList(EsUser8).flags.Navegando = 0

Call SendData(ToIndex, EsUser1, 88, "||Reto> YA!!!" & FONTTYPE_FIGHTT)
Call SendData(ToIndex, EsUser2, 88, "||Reto> YA!!!" & FONTTYPE_FIGHTT)
Call SendData(ToIndex, EsUser3, 88, "||Reto> YA!!!" & FONTTYPE_FIGHTT)
Call SendData(ToIndex, EsUser4, 88, "||Reto> YA!!!" & FONTTYPE_FIGHTT)
Call SendData(ToIndex, EsUser5, 88, "||Reto> YA!!!" & FONTTYPE_FIGHTT)
Call SendData(ToIndex, EsUser6, 88, "||Reto> YA!!!" & FONTTYPE_FIGHTT)
Call SendData(ToIndex, EsUser7, 88, "||Reto> YA!!!" & FONTTYPE_FIGHTT)
Call SendData(ToIndex, EsUser8, 88, "||Reto> YA!!!" & FONTTYPE_FIGHTT)

ElseIf EsRetosModalidad5vs5 Then

UserList(EsUser1).flags.Navegando = 0
UserList(EsUser2).flags.Navegando = 0
UserList(EsUser3).flags.Navegando = 0
UserList(EsUser4).flags.Navegando = 0
UserList(EsUser5).flags.Navegando = 0
UserList(EsUser6).flags.Navegando = 0
UserList(EsUser7).flags.Navegando = 0
UserList(EsUser8).flags.Navegando = 0
UserList(EsUser9).flags.Navegando = 0
UserList(EsUser10).flags.Navegando = 0

Call SendData(ToIndex, EsUser1, 88, "||Reto> YA!!!" & FONTTYPE_FIGHTT)
Call SendData(ToIndex, EsUser2, 88, "||Reto> YA!!!" & FONTTYPE_FIGHTT)
Call SendData(ToIndex, EsUser3, 88, "||Reto> YA!!!" & FONTTYPE_FIGHTT)
Call SendData(ToIndex, EsUser4, 88, "||Reto> YA!!!" & FONTTYPE_FIGHTT)
Call SendData(ToIndex, EsUser5, 88, "||Reto> YA!!!" & FONTTYPE_FIGHTT)
Call SendData(ToIndex, EsUser6, 88, "||Reto> YA!!!" & FONTTYPE_FIGHTT)
Call SendData(ToIndex, EsUser7, 88, "||Reto> YA!!!" & FONTTYPE_FIGHTT)
Call SendData(ToIndex, EsUser8, 88, "||Reto> YA!!!" & FONTTYPE_FIGHTT)
Call SendData(ToIndex, EsUser9, 88, "||Reto> YA!!!" & FONTTYPE_FIGHTT)
Call SendData(ToIndex, EsUser10, 88, "||Reto> YA!!!" & FONTTYPE_FIGHTT)

End If

Else

If EsRetosModalidad1vs1 Then

        Call SendData(ToIndex, EsUser1, 88, "||Reto> Comienza en " & CuentaQuestReto & "..." & FONTTYPE_INFO)
        Call SendData(ToIndex, EsUser2, 88, "||Reto> Comienza en " & CuentaQuestReto & "..." & FONTTYPE_INFO)

ElseIf EsRetosModalidad2vs2 Then

        Call SendData(ToIndex, EsUser1, 88, "||Reto> Comienza en " & CuentaQuestReto & "..." & FONTTYPE_INFO)
        Call SendData(ToIndex, EsUser2, 88, "||Reto> Comienza en " & CuentaQuestReto & "..." & FONTTYPE_INFO)
        Call SendData(ToIndex, EsUser3, 88, "||Reto> Comienza en " & CuentaQuestReto & "..." & FONTTYPE_INFO)
        Call SendData(ToIndex, EsUser4, 88, "||Reto> Comienza en " & CuentaQuestReto & "..." & FONTTYPE_INFO)

ElseIf EsRetosModalidad3vs3 Then

        Call SendData(ToIndex, EsUser1, 88, "||Reto> Comienza en " & CuentaQuestReto & "..." & FONTTYPE_INFO)
        Call SendData(ToIndex, EsUser2, 88, "||Reto> Comienza en " & CuentaQuestReto & "..." & FONTTYPE_INFO)
        Call SendData(ToIndex, EsUser3, 88, "||Reto> Comienza en " & CuentaQuestReto & "..." & FONTTYPE_INFO)
        Call SendData(ToIndex, EsUser4, 88, "||Reto> Comienza en " & CuentaQuestReto & "..." & FONTTYPE_INFO)
        Call SendData(ToIndex, EsUser5, 88, "||Reto> Comienza en " & CuentaQuestReto & "..." & FONTTYPE_INFO)
        Call SendData(ToIndex, EsUser6, 88, "||Reto> Comienza en " & CuentaQuestReto & "..." & FONTTYPE_INFO)

ElseIf EsRetosModalidad4vs4 Then

        Call SendData(ToIndex, EsUser1, 88, "||Reto> Comienza en " & CuentaQuestReto & "..." & FONTTYPE_INFO)
        Call SendData(ToIndex, EsUser2, 88, "||Reto> Comienza en " & CuentaQuestReto & "..." & FONTTYPE_INFO)
        Call SendData(ToIndex, EsUser3, 88, "||Reto> Comienza en " & CuentaQuestReto & "..." & FONTTYPE_INFO)
        Call SendData(ToIndex, EsUser4, 88, "||Reto> Comienza en " & CuentaQuestReto & "..." & FONTTYPE_INFO)
        Call SendData(ToIndex, EsUser5, 88, "||Reto> Comienza en " & CuentaQuestReto & "..." & FONTTYPE_INFO)
        Call SendData(ToIndex, EsUser6, 88, "||Reto> Comienza en " & CuentaQuestReto & "..." & FONTTYPE_INFO)
        Call SendData(ToIndex, EsUser7, 88, "||Reto> Comienza en " & CuentaQuestReto & "..." & FONTTYPE_INFO)
        Call SendData(ToIndex, EsUser8, 88, "||Reto> Comienza en " & CuentaQuestReto & "..." & FONTTYPE_INFO)


ElseIf EsRetosModalidad5vs5 Then

        Call SendData(ToIndex, EsUser1, 88, "||Reto> Comienza en " & CuentaQuestReto & "..." & FONTTYPE_INFO)
        Call SendData(ToIndex, EsUser2, 88, "||Reto> Comienza en " & CuentaQuestReto & "..." & FONTTYPE_INFO)
        Call SendData(ToIndex, EsUser3, 88, "||Reto> Comienza en " & CuentaQuestReto & "..." & FONTTYPE_INFO)
        Call SendData(ToIndex, EsUser4, 88, "||Reto> Comienza en " & CuentaQuestReto & "..." & FONTTYPE_INFO)
        Call SendData(ToIndex, EsUser5, 88, "||Reto> Comienza en " & CuentaQuestReto & "..." & FONTTYPE_INFO)
        Call SendData(ToIndex, EsUser6, 88, "||Reto> Comienza en " & CuentaQuestReto & "..." & FONTTYPE_INFO)
        Call SendData(ToIndex, EsUser7, 88, "||Reto> Comienza en " & CuentaQuestReto & "..." & FONTTYPE_INFO)
        Call SendData(ToIndex, EsUser8, 88, "||Reto> Comienza en " & CuentaQuestReto & "..." & FONTTYPE_INFO)
        Call SendData(ToIndex, EsUser9, 88, "||Reto> Comienza en " & CuentaQuestReto & "..." & FONTTYPE_INFO)
        Call SendData(ToIndex, EsUser10, 88, "||Reto> Comienza en " & CuentaQuestReto & "..." & FONTTYPE_INFO)


End If

    End If
    
    
End Sub
