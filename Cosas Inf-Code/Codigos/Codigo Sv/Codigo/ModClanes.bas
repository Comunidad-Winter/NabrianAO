Attribute VB_Name = "modClanes"
 
'director del proyecto: #Esteban(Neliam)

'servidor basado en fénixao 1.0
'medios de contacto:
'Skype: dc.esteban
'E-mail: nabrianao@gmail.com
Option Explicit

Public Guilds As New Collection
Public Sub ComputeVote(Userindex As Integer, ByVal rdata As String)

Dim myGuild As cGuild

Set myGuild = FetchGuild(UserList(Userindex).GuildInfo.GuildName)
If myGuild Is Nothing Then Exit Sub

If Not myGuild.Elections Then
   Call SendData(ToIndex, Userindex, 0, "2Z")
   Exit Sub
End If

If UserList(Userindex).GuildInfo.YaVoto = 1 Then
   Call SendData(ToIndex, Userindex, 0, "3Z")
   Exit Sub
End If

If Not myGuild.IsMember(rdata) Then
   Call SendData(ToIndex, Userindex, 0, "4Z")
   Exit Sub
End If


Call myGuild.Votes.Add(rdata)
UserList(Userindex).GuildInfo.YaVoto = 1
Call SendData(ToIndex, Userindex, 0, "5Z")


End Sub
Public Sub ResetUserVotes(myGuild As cGuild)
On Error GoTo errh

Dim k As Integer, Index As Integer
Dim UserFile As String

For k = 1 To myGuild.Members.Count
    Index = NameIndex(myGuild.Members(k))
    If Index Then
        UserList(Index).GuildInfo.YaVoto = 0
    Else
        UserFile = CharPath & UCase$(myGuild.Members(k)) & ".chr"
        If FileExist(UserFile, vbNormal) Then
                Call WriteVar(UserFile, "GUILD", "YaVoto", 0)
        End If
    End If
    
Next

errh:

End Sub
Public Function EsRojo(Numero As Integer) As Boolean

EsRojo = (Numero = 1 Or Numero = 3 Or Numero = 5 Or Numero = 7 Or Numero = 9 Or _
        Numero = 12 Or Numero = 14 Or Numero = 16 Or Numero = 18 Or Numero = 19 Or _
        Numero = 21 Or Numero = 23 Or Numero = 25 Or Numero = 27 Or Numero = 30 Or _
        Numero = 32 Or Numero = 34 Or Numero = 36)

End Function
Public Sub TirarRuleta(Userindex As Integer, Info As String)
Dim NumeroSalio As Integer, NroApuestas As Integer, i As Integer
Dim Apuesta As Integer, Fichas As Integer, Gano(1 To 5) As Integer, DineroGano As Long

NumeroSalio = RandomNumber(0, 36)
NroApuestas = ReadField(1, Info, 44)

For i = 1 To NroApuestas
    Apuesta = ReadField(2 * i, Info, 44)
    Fichas = ReadField(2 * i + 1, Info, 44)
    If NumeroSalio <> 0 Or Apuesta = 0 Then
        Select Case Apuesta
            Case Is <= 36
                If Apuesta = NumeroSalio Then Gano(i) = 36
            Case 37
                If NumeroSalio <= 12 Then Gano(i) = 3
            Case 38
                If NumeroSalio >= 13 And NumeroSalio <= 24 Then Gano(i) = 3
            Case 39
                If NumeroSalio >= 25 Then Gano(i) = 3
            Case 42
                If EsRojo(NumeroSalio) Then Gano(i) = 2
            Case 43
                If Not EsRojo(NumeroSalio) Then Gano(i) = 2
            Case 41
                If NumeroSalio / 2 = NumeroSalio \ 2 Then Gano(i) = 2
            Case 44
                If NumeroSalio / 2 <> NumeroSalio \ 2 Then Gano(i) = 2
            Case 40
                If NumeroSalio <= 18 Then Gano(i) = 2
            Case 45
                If NumeroSalio > 18 Then Gano(i) = 2
            Case Is <= 69
                Dim MiNum As Byte
                MiNum = 3 * Fix((Apuesta - 46) / 2) + 2
                If (NumeroSalio = MiNum - 1 And Apuesta Mod 2 = 0) Or (NumeroSalio = MiNum) Or (NumeroSalio = MiNum + 1 And Apuesta Mod 2 = 1) Then Gano(i) = 18
            Case Is <= 102
                If NumeroSalio = Apuesta - 69 Or _
                    NumeroSalio = Apuesta - 66 Then _
                    Gano(i) = 18
            Case Is <= 124
                MiNum = (3 * Fix((Apuesta - 101) / 2) - 1) - Buleano(Apuesta Mod 2 = 1)
                If NumeroSalio = MiNum Or NumeroSalio = MiNum + 1 Or _
                NumeroSalio = MiNum + 3 Or NumeroSalio = MiNum + 4 Then _
                    Gano(i) = 9
            Case Is <= 136
                MiNum = 1 + 3 * (Apuesta - 125)
                If NumeroSalio >= MiNum And NumeroSalio <= MiNum + 2 Then _
                    Gano(i) = 12
            Case Is <= 147
                MiNum = 1 + 3 * (Apuesta - 137)
                If NumeroSalio >= MiNum And NumeroSalio <= MiNum + 5 Then _
                    Gano(i) = 6
            Case Else
                If (Apuesta - 147) Mod 3 = NumeroSalio Mod 3 Then _
                    Gano(i) = 3
        End Select
    End If
    Gano(i) = Gano(i) - 1
    DineroGano = DineroGano + Gano(i) * Fichas * 10 ^ UserList(Userindex).flags.MesaCasino
Next

UserList(Userindex).Stats.GLD = UserList(Userindex).Stats.GLD + DineroGano
BalanceCasa = BalanceCasa - DineroGano

Call SaveCasino
Call SendUserORO(Userindex)
Dim msg As String
msg = "RUL" & NumeroSalio

For i = 1 To NroApuestas
    msg = msg & "," & Gano(i)
Next

Call SendData(ToIndex, Userindex, 0, msg)

End Sub
Public Sub DayElapsed()
On Error GoTo ErrHandler

Dim MemberIndex As Integer
Dim UserFile As String, T%

For T% = 1 To Guilds.Count
    
    If Guilds(T%).DaysSinceLastElection < Guilds(T%).ElectionPeriod Then
        Guilds(T%).DaysSinceLastElection = Guilds(T%).DaysSinceLastElection + 1
    Else
       If Not Guilds(T%).Elections Then
            Guilds(T%).ResetVotes
            Call ResetUserVotes(Guilds(T%))
            Guilds(T%).Elections = True
            
            MemberIndex = DameGuildMemberIndex(Guilds(T%).GuildName)
            
            If MemberIndex Then
                Call SendData(ToGuildMembers, MemberIndex, 0, "6Z")
            End If
        Else
            If Guilds(T%).Members.Count > 1 Then
                    
                    Dim Leader$, newleaderindex As Integer, oldleaderindex As Integer
                    Leader$ = Guilds(T%).NuevoLider
                    Guilds(T%).Elections = False
                    MemberIndex = DameGuildMemberIndex(Guilds(T%).GuildName)
                    newleaderindex = NameIndex(Leader$)
                    oldleaderindex = NameIndex(Guilds(T%).Leader)
                        
                        If UCase$(Leader$) <> UCase$(Guilds(T%).Leader) Then
                        
                        If oldleaderindex Then
                            UserList(oldleaderindex).GuildInfo.EsGuildLeader = 0
                        Else
                            UserFile = CharPath & UCase$(Guilds(T%).Leader) & ".chr"
                            If FileExist(UserFile, vbNormal) Then
                                    Call WriteVar(UserFile, "GUILD", "EsGuildLeader", 0)
                            End If
                        End If
                        
                        If newleaderindex Then
                            UserList(newleaderindex).GuildInfo.EsGuildLeader = 1
                            Call AddtoVar(UserList(newleaderindex).GuildInfo.VecesFueGuildLeader, 1, 10000)
                        Else
                            UserFile = CharPath & UCase$(Leader$) & ".chr"
                            If FileExist(UserFile, vbNormal) Then
                                    Call WriteVar(UserFile, "GUILD", "EsGuildLeader", 1)
                            End If
                        End If
                        
                        Guilds(T%).Leader = Leader$
                    End If
                    
                    If MemberIndex Then
                            Call SendData(ToGuildMembers, MemberIndex, 0, "7Z" & Leader$)
                    End If
                    
                    If newleaderindex Then
                        Call SendData(ToIndex, newleaderindex, 0, "8Z")
                        Call GiveGuildPoints(400, newleaderindex)
                    End If
                    Guilds(T%).DaysSinceLastElection = 0
            End If
        End If
    End If
    
Next

Exit Sub

ErrHandler:
    Call LogError(Err.Description & " error en DayElapsed.")

End Sub

Public Sub GiveGuildPoints(ByVal Pts As Integer, Userindex As Integer, Optional ByVal SendNotice As Boolean = True)

If SendNotice Then _
   Call SendData(ToIndex, Userindex, 0, "9Z" & Pts)

Call AddtoVar(UserList(Userindex).GuildInfo.GuildPoints, Pts, 9000000)

End Sub

Public Sub DropGuildPoints(ByVal Pts As Integer, Userindex As Integer, Optional ByVal SendNotice As Boolean = True)

UserList(Userindex).GuildInfo.GuildPoints = UserList(Userindex).GuildInfo.GuildPoints - Pts





End Sub


Public Sub AcceptPeaceOffer(Userindex As Integer, ByVal rdata As String)

If UserList(Userindex).GuildInfo.EsGuildLeader = 0 Then Exit Sub

Dim oGuild As cGuild

Set oGuild = FetchGuild(rdata)

If oGuild Is Nothing Then Exit Sub

If Not oGuild.IsEnemy(UserList(Userindex).GuildInfo.GuildName) Then
    Call SendData(ToIndex, Userindex, 0, "!A")
    Exit Sub
End If

Call oGuild.RemoveEnemy(UserList(Userindex).GuildInfo.GuildName)

Set oGuild = FetchGuild(UserList(Userindex).GuildInfo.GuildName)

If oGuild Is Nothing Then Exit Sub

Call oGuild.RemoveEnemy(rdata)
Call oGuild.RemoveProposition(rdata)

Dim MemberIndex As Integer

MemberIndex = NameIndex(rdata)

If MemberIndex Then _
Call SendData(ToGuildMembers, MemberIndex, 0, "!B" & UserList(Userindex).GuildInfo.GuildName)
    
Call SendData(ToGuildMembers, Userindex, 0, "!B" & rdata)




End Sub


Public Sub SendPeaceRequest(Userindex As Integer, ByVal rdata As String)

If UserList(Userindex).GuildInfo.EsGuildLeader = 0 Then Exit Sub

Dim oGuild As cGuild

Set oGuild = FetchGuild(UserList(Userindex).GuildInfo.GuildName)

If oGuild Is Nothing Then Exit Sub

Dim Soli As cSolicitud

Set Soli = oGuild.GetPeaceRequest(rdata)

If Soli Is Nothing Then Exit Sub

Call SendData(ToIndex, Userindex, 0, "PEACEDE" & Soli.Desc)

End Sub


Public Sub RecievePeaceOffer(Userindex As Integer, ByVal rdata As String)

If UserList(Userindex).GuildInfo.EsGuildLeader = 0 Then Exit Sub

Dim H$

H$ = UCase$(ReadField(1, rdata, 44))

If UCase$(UserList(Userindex).GuildInfo.GuildName) = UCase$(H$) Then Exit Sub

Dim oGuild As cGuild

Set oGuild = FetchGuild(H$)

If oGuild Is Nothing Then Exit Sub

If Not oGuild.IsEnemy(UserList(Userindex).GuildInfo.GuildName) Then
    Call SendData(ToIndex, Userindex, 0, "!C")
    Exit Sub
End If

If oGuild.IsAllie(UserList(Userindex).GuildInfo.GuildName) Then
    Call SendData(ToIndex, Userindex, 0, "!D")
    Exit Sub
End If

Dim peaceoffer As New cSolicitud

peaceoffer.Desc = ReadField(2, rdata, 44)
peaceoffer.UserName = UserList(Userindex).GuildInfo.GuildName

If Not oGuild.IncludesPeaceOffer(peaceoffer.UserName) Then
    Call oGuild.PeacePropositions.Add(peaceoffer)
    Call SendData(ToIndex, Userindex, 0, "!E")
Else
    Call SendData(ToIndex, Userindex, 0, "!F")
End If


End Sub


Public Sub SendPeacePropositions(Userindex As Integer)

If UserList(Userindex).GuildInfo.EsGuildLeader = 0 Then Exit Sub

Dim oGuild As cGuild

Set oGuild = FetchGuild(UserList(Userindex).GuildInfo.GuildName)

If oGuild Is Nothing Then Exit Sub

Dim L%, k$

If oGuild.PeacePropositions.Count = 0 Then Exit Sub

k$ = "PEACEPR" & oGuild.PeacePropositions.Count & ","

For L% = 1 To oGuild.PeacePropositions.Count
    k$ = k$ & oGuild.PeacePropositions(L%).UserName & ","
Next

Call SendData(ToIndex, Userindex, 0, k$)

End Sub
Public Sub EcharMember(Userindex As Integer, ByVal rdata As String, dato2 As String)
Dim MemberIndex As Integer
Dim echadas As Integer
Dim i As Integer

 
If UserList(Userindex).GuildInfo.EsGuildLeader = 0 Then Exit Sub
 
Dim oGuild As cGuild
Set oGuild = FetchGuild(UserList(Userindex).GuildInfo.GuildName)
If oGuild Is Nothing Then Exit Sub
 
MemberIndex = NameIndex(rdata)
 
If MemberIndex = Userindex Then Exit Sub
 
If MemberIndex Then
    Call SendData(ToGuildMembers, Userindex, 0, "!G" & UserList(MemberIndex).Name)
    Call SendData(ToIndex, MemberIndex, 0, "!H")
    Call AddtoVar(UserList(MemberIndex).GuildInfo.echadas, 1, 1000)
    UserList(MemberIndex).GuildInfo.GuildPoints = 0
    UserList(MemberIndex).GuildInfo.GuildName = ""
    Call UpdateUserChar(MemberIndex)
ElseIf FileExist(CharPath & UCase$(dato2) & ".chr", vbNormal) = True Then
    Dim UserFiL As String
    UserFiL = CharPath & UCase$(dato2) & ".chr"
    Call WriteVar(UserFiL, "GUILD", "Echadas", val(GetVar(UserFiL, "GUILD", "Echadas")) + 1)
    Call WriteVar(UserFiL, "GUILD", "GuildName", "")
    Call WriteVar(UserFiL, "GUILD", "GuildPoints", "0")
    Call SendData(ToIndex, Userindex, 0, "||Has echado a " & dato2 & " del clan. (offline)" & FONTTYPE_GUILD)
    Call oGuild.RemoveMember(dato2)
End If
 
Call oGuild.RemoveMember(rdata)

End Sub
Public Sub DenyRequest(Userindex As Integer, ByVal rdata As String, dato2 As String)

If UserList(Userindex).GuildInfo.EsGuildLeader = 0 And UserList(Userindex).GuildInfo.EsGuildLeader = 0 Then Exit Sub

Dim oGuild As cGuild

Set oGuild = FetchGuild(UserList(Userindex).GuildInfo.GuildName)

If oGuild Is Nothing Then Exit Sub

Dim Soli As cSolicitud

Set Soli = oGuild.GetSolicitud(rdata)

If Soli Is Nothing Then Exit Sub

Dim MemberIndex As Integer

MemberIndex = NameIndex(Soli.UserName)

If MemberIndex Then
    Call SendData(ToIndex, MemberIndex, 0, "1G")
    Call AddtoVar(UserList(MemberIndex).GuildInfo.SolicitudesRechazadas, 1, 10000)
Else
    If Not FileExist(CharPath & UCase$(dato2) & ".chr", vbNormal) = True Then Exit Sub
    Dim UserFile As String
    UserFile = CharPath & dato2 & ".CHR"
    Call WriteVar(UserFile, "GUILD", "SolicitudesRechazadas", val(GetVar(UserFile, "GUILD", "SolicitudesRechazadas")) + 1)
    Call SendData(ToIndex, Userindex, 0, "||Has rechazado la solicitud de " & dato2 & " para clan. (offline)" & FONTTYPE_GUILD)
    Call oGuild.RemoveSolicitud(dato2)
End If

Call oGuild.RemoveSolicitud(Soli.UserName)
UserList(Userindex).flags.InfoClanEstatica = 0

End Sub
Public Sub AcceptClanMember(Userindex As Integer, ByVal rdata As String, dato2 As String)

If UserList(Userindex).GuildInfo.EsGuildLeader = 0 And UserList(Userindex).GuildInfo.EsGuildLeader = 0 Then Exit Sub
Dim i As Integer
Dim oGuild As cGuild
 
Set oGuild = FetchGuild(UserList(Userindex).GuildInfo.GuildName)
 
If oGuild Is Nothing Then Exit Sub
 
Dim Soli As cSolicitud
 
Set Soli = oGuild.GetSolicitud(rdata)
 
If Soli Is Nothing Then Exit Sub
 
If oGuild.Members.Count >= 15 Then
    Call SendData(ToIndex, Userindex, 0, "!I")
    Exit Sub
End If
 
Dim MemberIndex As Integer
 
MemberIndex = NameIndex(Soli.UserName)
 
If MemberIndex Then
    If Len(UserList(MemberIndex).GuildInfo.GuildName) > 0 Then
        Call SendData(ToIndex, Userindex, 0, "1H")
        Exit Sub
    End If
    UserList(MemberIndex).GuildInfo.GuildName = UserList(Userindex).GuildInfo.GuildName
    Call AddtoVar(UserList(MemberIndex).GuildInfo.ClanesParticipo, 1, 1000)
    Call SendData(ToIndex, MemberIndex, 0, "!J" & UserList(Userindex).GuildInfo.GuildName)
    Call GiveGuildPoints(25, MemberIndex)
    Call UpdateUserChar(MemberIndex)
    
ElseIf FileExist(CharPath & UCase$(dato2) & ".chr", vbNormal) = True Then
Dim UserfileX As String
UserfileX = CharPath & dato2 & ".CHR"
If Len(GetVar(UserfileX, "GUILD", "GuildName")) = 0 Then
Call WriteVar(UserfileX, "GUILD", "GuildName", oGuild.GuildName)
Call WriteVar(UserfileX, "GUILD", "ClanesParticipo", val(GetVar(UserfileX, "GUILD", "ClanesParticipo")) + 1)
Call WriteVar(UserfileX, "GUILD", "GuildPts", val(GetVar(UserfileX, "GUILD", "GuildPts")) + 25)
Call oGuild.Members.Add(dato2)
Call oGuild.RemoveSolicitud(dato2)
Call SendData(ToGuildMembers, Userindex, 0, "1I" & rdata)
Exit Sub
End If
End If
 
Call SendData(ToGuildMembers, Userindex, 0, "1I" & rdata)
 
Call oGuild.Members.Add(Soli.UserName)
Call oGuild.RemoveSolicitud(Soli.UserName)

End Sub
Public Sub SendPeticion(Userindex As Integer, ByVal rdata As String)
Dim Tindex As Integer

If UserList(Userindex).GuildInfo.EsGuildLeader = 0 And UserList(Userindex).GuildInfo.EsGuildLeader = 0 Then Exit Sub
    
Dim oGuild As cGuild

Set oGuild = FetchGuild(UserList(Userindex).GuildInfo.GuildName)

If oGuild Is Nothing Then Exit Sub

Dim Soli As cSolicitud

Set Soli = oGuild.GetSolicitud(rdata)

If Soli Is Nothing Then Exit Sub

Call SendData(ToIndex, Userindex, 0, "PETICIO" & Soli.Desc)

Tindex = NameIndex(oGuild.Leader)

If Tindex Then
    UserList(Tindex).flags.InfoClanEstatica = 0
End If

End Sub
Public Sub SolicitudIngresoClan(Userindex As Integer, ByVal Data As String)
Dim MiSol As New cSolicitud
Dim oGuild As cGuild
Dim Tindex As Integer
Dim Clan$

If EsNewbie(Userindex) Then
    Call SendData(ToIndex, Userindex, 0, "!L")
    Exit Sub
End If

Clan$ = ReadField(1, Data, 44)
Set oGuild = FetchGuild(Clan$)

If oGuild Is Nothing Then Exit Sub

If oGuild.IsMember(UserList(Userindex).Name) Then Exit Sub

If oGuild.Bando <> UserList(Userindex).Faccion.Bando Then Exit Sub

MiSol.Desc = ReadField(2, Data, 44)
MiSol.UserName = UserList(Userindex).Name

If oGuild.SolicitudesIncludes(MiSol.UserName) Then
    Call SendData(ToIndex, Userindex, 0, "!N")
    Exit Sub
End If
    
If oGuild.Bando <> UserList(Userindex).Faccion.Bando Then
    Select Case oGuild.Bando
        Case Neutral
            Call SendData(ToIndex, Userindex, 0, "{G")
        Case Real
            Call SendData(ToIndex, Userindex, 0, "!Ñ")
        Case Caos
            Call SendData(ToIndex, Userindex, 0, "!O")
    End Select
    Exit Sub
End If

Call AddtoVar(UserList(Userindex).GuildInfo.Solicitudes, 1, 1000)

Call oGuild.TestSolicitudBound
Call oGuild.Solicitudes.Add(MiSol)
 
Call SendData(ToIndex, Userindex, 0, "!M")
    
Tindex = NameIndex(oGuild.Leader)
       
If Tindex Then
    UserList(Tindex).flags.InfoClanEstatica = 0
    Call SendData(ToIndex, Tindex, 0, "%N" & UserList(Userindex).Name)
End If
    
End Sub
Public Sub UpdateGuildNews(ByVal rdata As String, Userindex As Integer)
Dim i As Integer

If UserList(Userindex).GuildInfo.EsGuildLeader = 0 And UserList(Userindex).GuildInfo.EsGuildLeader = 0 Then Exit Sub

Dim oGuild As cGuild

Set oGuild = FetchGuild(UserList(Userindex).GuildInfo.GuildName)

If oGuild Is Nothing Then Exit Sub

oGuild.GuildNews = rdata

For i = 1 To LastUser
    If UserList(i).GuildInfo.GuildName = oGuild.GuildName Then
        UserList(i).flags.InfoClanEstatica = 0
    End If
Next
            
End Sub
Public Sub UpdateCodexAndDesc(ByVal rdata As String, Userindex As Integer)

If UserList(Userindex).GuildInfo.EsGuildLeader = 0 Then Exit Sub

Dim oGuild As cGuild

Set oGuild = FetchGuild(UserList(Userindex).GuildInfo.GuildName)

If oGuild Is Nothing Then Exit Sub

Call oGuild.UpdateCodexAndDesc(rdata)

End Sub
Public Function Relation(ByVal oGuild As cGuild, GuildName As String) As Byte
Dim i As Integer

If oGuild.GuildName = GuildName Then
    Relation = 4
    Exit Function
End If

For i = 1 To oGuild.AlliedGuilds.Count
    If UCase$(oGuild.AlliedGuilds(i)) = UCase$(GuildName) Then
        Relation = 1
        Exit Function
    End If
Next

For i = 1 To oGuild.EnemyGuilds.Count
    If UCase$(oGuild.EnemyGuilds(i)) = UCase$(GuildName) Then
        Relation = 2
        Exit Function
    End If
Next

End Function
Public Sub SendGuildsStats(Userindex As Integer)
Dim msg As String
Dim i As Integer

If Len(UserList(Userindex).GuildInfo.GuildName) = 0 Then Exit Sub

Dim oGuild As cGuild
Set oGuild = FetchGuild(UserList(Userindex).GuildInfo.GuildName)
If oGuild Is Nothing Then Exit Sub

msg = "MEMBERI" & Guilds.Count & "¬"

For i = 1 To Guilds.Count
    msg = msg & Guilds(i).GuildName & Guilds(i).Bando & Relation(oGuild, Guilds(i).GuildName) & "¬"
Next

msg = msg & oGuild.Members.Count & "¬"

For i = 1 To oGuild.Members.Count
    msg = msg & oGuild.Members.Item(i) & "¬"
Next

msg = msg & Replace(oGuild.GuildNews, vbCrLf, "º")

Call SendData(ToIndex, Userindex, 0, msg)

UserList(Userindex).flags.InfoClanEstatica = 1

End Sub
Public Sub SendGuildLeaderInfo(Userindex As Integer)

If UserList(Userindex).GuildInfo.EsGuildLeader = 0 And UserList(Userindex).GuildInfo.EsGuildLeader = 0 Then Exit Sub

Dim cad As String, T%

Dim oGuild As cGuild
Set oGuild = FetchGuild(UserList(Userindex).GuildInfo.GuildName)
If oGuild Is Nothing Then Exit Sub

cad = "LEADERI" & Guilds.Count & "¬"

For T% = 1 To Guilds.Count
    cad = cad & Guilds(T%).GuildName & Guilds(T%).Bando & Relation(oGuild, Guilds(T%).GuildName) & "¬"
Next

cad = cad & oGuild.Members.Count & "¬"

For T% = 1 To oGuild.Members.Count
    cad = cad & oGuild.Members.Item(T%) & "¬"
Next




Dim GN$

GN$ = Replace(oGuild.GuildNews, vbCrLf, "º")

cad = cad & GN$ & "¬"



cad = cad & oGuild.Solicitudes.Count & "¬"

For T% = 1 To oGuild.Solicitudes.Count
    cad = cad & oGuild.Solicitudes.Item(T%).UserName & "¬"
Next

Call SendData(ToIndex, Userindex, 0, cad)

UserList(Userindex).flags.InfoClanEstatica = 1

End Sub
Public Sub SetNewURL(Userindex As Integer, ByVal rdata As String)

If UserList(Userindex).GuildInfo.EsGuildLeader = 0 Then Exit Sub

Dim oGuild As cGuild

Set oGuild = FetchGuild(UserList(Userindex).GuildInfo.GuildName)

If oGuild Is Nothing Then Exit Sub

oGuild.URL = rdata

Call SendData(ToIndex, Userindex, 0, "!P")

End Sub

Public Sub DeclareAllie(Userindex As Integer, ByVal rdata As String)
Dim i As Integer

If UserList(Userindex).GuildInfo.EsGuildLeader = 0 Then Exit Sub

If UCase$(UserList(Userindex).GuildInfo.GuildName) = UCase$(rdata) Then Exit Sub


Dim LeaderGuild As cGuild, enemyGuild As cGuild

Set LeaderGuild = FetchGuild(UserList(Userindex).GuildInfo.GuildName)

If LeaderGuild Is Nothing Then Exit Sub

Set enemyGuild = FetchGuild(rdata)

If enemyGuild Is Nothing Then Exit Sub

If LeaderGuild.IsEnemy(enemyGuild.GuildName) Then
    Call SendData(ToIndex, Userindex, 0, "!Q")
Else
   If Not LeaderGuild.IsAllie(enemyGuild.GuildName) Then
        Call LeaderGuild.AlliedGuilds.Add(enemyGuild.GuildName)
        Call enemyGuild.AlliedGuilds.Add(LeaderGuild.GuildName)
        
        Call SendData(ToGuildMembers, Userindex, 0, "!R" & enemyGuild.GuildName)
        
        For i = 1 To LastUser
            If UserList(i).GuildInfo.GuildName = enemyGuild.GuildName Or UserList(i).GuildInfo.GuildName = LeaderGuild.GuildName Then
                UserList(i).flags.InfoClanEstatica = 0
            End If
        Next
    
        Dim Index As Integer
        Index = DameGuildMemberIndex(enemyGuild.GuildName)
        If Index Then
            Call SendData(ToGuildMembers, Index, 0, "!S" & LeaderGuild.GuildName)
        End If
   Else
        Call SendData(ToIndex, Userindex, 0, "!T")
   End If
End If

    


End Sub

Public Sub DeclareWar(Userindex As Integer, ByVal rdata As String)
Dim i As Integer

If UserList(Userindex).GuildInfo.EsGuildLeader = 0 Then Exit Sub

If UCase$(UserList(Userindex).GuildInfo.GuildName) = UCase$(rdata) Then Exit Sub


Dim LeaderGuild As cGuild, enemyGuild As cGuild

Set LeaderGuild = FetchGuild(UserList(Userindex).GuildInfo.GuildName)

If LeaderGuild Is Nothing Then Exit Sub

Set enemyGuild = FetchGuild(rdata)

If enemyGuild Is Nothing Then Exit Sub

If Not LeaderGuild.IsEnemy(enemyGuild.GuildName) Then
    Call LeaderGuild.RemoveAllie(enemyGuild.GuildName)
    Call enemyGuild.RemoveAllie(LeaderGuild.GuildName)
    
    Call LeaderGuild.EnemyGuilds.Add(enemyGuild.GuildName)
    Call enemyGuild.EnemyGuilds.Add(LeaderGuild.GuildName)
    
    For i = 1 To LastUser
        If UserList(i).GuildInfo.GuildName = enemyGuild.GuildName Or UserList(i).GuildInfo.GuildName = LeaderGuild.GuildName Then
            UserList(i).flags.InfoClanEstatica = 0
        End If
    Next
    
    Call SendData(ToGuildMembers, Userindex, 0, "!U" & enemyGuild.GuildName)
    
    Dim Index As Integer
    Index = DameGuildMemberIndex(enemyGuild.GuildName)
    If Index Then
        Call SendData(ToGuildMembers, Index, 0, "!V" & LeaderGuild.GuildName)
    End If
Else
   Call SendData(ToIndex, Userindex, 0, "!W")
End If


End Sub

Public Function DameGuildMemberIndex(ByVal GuildName As String) As Integer

Dim loopc As Integer
  
loopc = 1
  
GuildName = UCase$(GuildName)
  
Do Until UCase$(UserList(loopc).GuildInfo.GuildName) = GuildName

    loopc = loopc + 1
    
    If loopc > MaxUsers Then
        DameGuildMemberIndex = 0
        Exit Function
    End If
    
Loop
  
DameGuildMemberIndex = loopc



End Function

Public Sub SendGuildsList(Userindex As Integer)

Dim cad As String, T%

cad = "GL" & Guilds.Count & ","

For T% = 1 To Guilds.Count
    cad = cad & Guilds(T%).GuildName & ","
Next

UserList(Userindex).flags.InfoClanEstatica = 1

Call SendData(ToIndex, Userindex, 0, cad)

End Sub
Public Function FetchGuild(ByVal GuildName As String) As Object
Dim k As Integer

For k = 1 To Guilds.Count
    If UCase$(Guilds.Item(k).GuildName) = UCase$(GuildName) Then
        Set FetchGuild = Guilds.Item(k)
        Exit Function
    End If
Next

Set FetchGuild = Nothing

End Function

Public Sub SendGuildDetails(Userindex As Integer, ByVal GuildName As String)
On Error GoTo ErrHandler

Dim oGuild As cGuild

If Guilds.Count = 0 Then Exit Sub

Set oGuild = FetchGuild(GuildName)

If oGuild Is Nothing Then Exit Sub

Dim cad As String

cad = "CLANDET"

cad = cad & oGuild.GuildName
cad = cad & "¬" & oGuild.Founder
cad = cad & "¬" & oGuild.FundationDate
cad = cad & "¬" & oGuild.Leader
cad = cad & "¬" & oGuild.URL
cad = cad & "¬" & oGuild.Members.Count
cad = cad & "¬" & oGuild.DaysSinceLastElection
cad = cad & "¬" & oGuild.Bando
cad = cad & "¬" & oGuild.EnemyGuilds.Count
cad = cad & "¬" & oGuild.AlliedGuilds.Count
cad = cad & "¬" & UserList(Userindex).Faccion.Bando
cad = cad & "¬" & oGuild.CodexLenght
cad = cad & "¬" & Replace(oGuild.Codex, "|", "¬")
cad = cad & "¬" & oGuild.Description

Call SendData(ToIndex, Userindex, 0, cad)

ErrHandler:

End Sub
Public Function CanCreateGuild(Userindex As Integer) As Boolean


If TieneObjetos(852, 1, Userindex) Then 'Gema de los dioses
If UserList(Userindex).GuildInfo.FundoClan > 0 Then
    Call SendData(ToIndex, Userindex, 0, "8L")
    Exit Function
End If
 
If Len(UserList(Userindex).GuildInfo.GuildName) > 0 Then
    Call SendData(ToIndex, Userindex, 0, "||ya perteneces a un clan." & FONTTYPE_INFO)
    Exit Function
End If

If UserList(Userindex).Stats.ELV < 50 Then
    Call SendData(ToIndex, Userindex, 0, "||Necesitas ser nivel 50." & FONTTYPE_INFO)
    Exit Function
End If

If Len(UserList(Userindex).GuildInfo.GuildName) > 0 Then
    Call SendData(ToIndex, Userindex, 0, "||ya perteneces a un clan." & FONTTYPE_INFO)
    Exit Function
End If

UserList(Userindex).Stats.Reputacion = UserList(Userindex).Stats.Reputacion + 100
Call SendUserREP(Userindex)

CanCreateGuild = True
Exit Function
End If

If UserList(Userindex).Stats.UserAtributos(Carisma) < 18 Then
    Call SendData(ToIndex, Userindex, 0, "!X")
    Exit Function
End If

If UserList(Userindex).Stats.UserAtributos(Inteligencia) < 15 Then
    Call SendData(ToIndex, Userindex, 0, "!Y")
    Exit Function
End If

If Not UserList(Userindex).Clase = PIRATA Then
     Call SendData(ToIndex, Userindex, 0, "||Solo los piratas pueden fundar clan en estas tierras, puedes fundar clan con otra clase pero no posees la Gema de los Dioses esta misma se consigue donando al servidor." & FONTTYPE_FENIZ)
 Exit Function
End If

If UserList(Userindex).Stats.ELV < 45 Then
    Call SendData(ToIndex, Userindex, 0, "||Necesitas ser nivel 45." & FONTTYPE_INFO)
    Exit Function
End If

If Not TieneObjetos(411, 1, Userindex) Then
     Call SendData(ToIndex, Userindex, 0, "||No tienes los requisitos necesarios para fundar clan. Necesario: Gema Lunar" & FONTTYPE_INFO)
    Exit Function
End If

If Not TieneObjetos(909, 10, Userindex) Then
     Call SendData(ToIndex, Userindex, 0, "||No tienes los requisitos necesarios para fundar clan. Necesario: 10 Libros del Liderazgo." & FONTTYPE_INFO)
    Exit Function
End If

If UserList(Userindex).Stats.GLD < 15000000 Then
     Call SendData(ToIndex, Userindex, 0, "||No tienes los requisitos necesarios para fundar clan Necesario: 15.000.000 Monedas de oro." & FONTTYPE_INFO)
 Exit Function
End If
 
If UserList(Userindex).GuildInfo.FundoClan > 0 Then
    Call SendData(ToIndex, Userindex, 0, "8L")
    Exit Function
End If
 
If Len(UserList(Userindex).GuildInfo.GuildName) > 0 Then
    Call SendData(ToIndex, Userindex, 0, "||ya perteneces a un clan." & FONTTYPE_INFO)
    Exit Function
End If

UserList(Userindex).Stats.Reputacion = UserList(Userindex).Stats.Reputacion + 100
Call SendUserREP(Userindex)
 
CanCreateGuild = True
 
End Function
Public Function ExisteGuild(ByVal Name As String) As Boolean

Dim k As Integer
Name = UCase$(Name)

For k = 1 To Guilds.Count
    If UCase$(Guilds(k).GuildName) = Name Then
            ExisteGuild = True
            Exit Function
    End If
Next

End Function
Public Function CreateGuild(ByVal FounderName As String, ByVal Index As Integer, ByVal GuildInfo As String) As Boolean
Dim i As Integer

If Not CanCreateGuild(Index) Then
    CreateGuild = False
    Exit Function
End If

Dim miClan As New cGuild

If Not miClan.Initialize(GuildInfo, FounderName) Then
    CreateGuild = False
    Call SendData(ToIndex, Index, 0, "!2")
    Exit Function
End If

If ExisteGuild(miClan.GuildName) Then
    CreateGuild = False
    Call SendData(ToIndex, Index, 0, "!3")
    Exit Function
End If

Call miClan.Members.Add(UCase$(UserList(Index).Name))

Call Guilds.Add(miClan, miClan.GuildName)

UserList(Index).GuildInfo.FundoClan = 1
UserList(Index).GuildInfo.EsGuildLeader = 1

Call AddtoVar(UserList(Index).GuildInfo.VecesFueGuildLeader, 1, 10000)
Call AddtoVar(UserList(Index).GuildInfo.ClanesParticipo, 1, 10000)

UserList(Index).GuildInfo.ClanFundado = miClan.GuildName
UserList(Index).GuildInfo.GuildName = UserList(Index).GuildInfo.ClanFundado

Call GiveGuildPoints(5000, Index)

Call SendData(ToAll, 0, 0, "!4" & UserList(Index).Name & "," & UserList(Index).GuildInfo.GuildName)

If TieneObjetos(852, 1, Index) Then 'Gema de los dioses
Call QuitarObjetos(852, 1, Index)
Else
Call QuitarObjetos(411, 1, Index) 'le saco el objeto
Call QuitarObjetos(909, 10, Index) 'le saco el objeto
UserList(Index).Stats.GLD = UserList(Index).Stats.GLD - 15000000
End If

For i = 1 To LastUser
    If UserList(i).flags.UserLogged Then UserList(i).flags.InfoClanEstatica = 0
Next

CreateGuild = True

End Function

