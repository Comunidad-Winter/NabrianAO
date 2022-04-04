Attribute VB_Name = "mod_Castillo"
 
'director del proyecto: #Esteban(Neliam)

'servidor basado en fénixao 1.0
'medios de contacto:
'Skype: dc.esteban
'E-mail: nabrianao@gmail.com
Option Explicit
Public Const NPCRey As Integer = 690 ' aca tienen q pner el npc del bichos.dat o como se llame
'Public Const DaPuntosHonor As Integer = 500
Public Const CastilloMap As Byte = 127 ' aca el mapa donde respawnea
Public Const CastilloX As Byte = 78 ' aca x donde respawnea
Public Const CastilloY As Byte = 16 'aca Y donde respawnea
Public GolpesRey As Byte
Public HayRey As Byte
 
Public Sub MuereRey(ByVal Userindex As Integer)
    
        Dim loopc As Integer
    Dim ClanCastillo As String
    ClanCastillo = GetVar(App.Path & "\Dat\Castillitos.Siam", "CASTILLOS", "ClanCastillo")

 
    For loopc = 1 To LastUser
        If UserList(loopc).GuildInfo.GuildName <> "" Then
   
            If UserList(loopc).GuildInfo.GuildName = ClanCastillo Then
                UserList(loopc).Stats.GLD = UserList(loopc).Stats.GLD + HonorA ' esto lo acoto,  por lo q explique arriba
                UserList(loopc).Stats.Reputacion = UserList(loopc).Stats.Reputacion + 30
                Call SendUserREP(loopc)
                Call SendUserORO(loopc)
                Call SendData(ToIndex, loopc, 0, "||Las monedas de oro de tu clan acumuladas fueron entregadas por estar conectado, vuelve a conquistar el castillo y tipeá /Castillo para saber en que momento acumula premios." & FONTTYPE_GUILD)
                UserList(loopc).flags.DominandoCastillo = 0
            End If
        End If
    Next loopc
    
    Call SendData(ToAll, 0, 0, "||El castillo de clanes pertenece al clan '" & UserList(Userindex).GuildInfo.GuildName & "'" & FONTTYPE_GUILD)
    Call WriteVar(IniPath & "\Dat\Castillitos.Siam", "CASTILLOS", "ClanCastillo", UserList(Userindex).GuildInfo.GuildName)
    Call SendData(ToAll, 0, 0, "TW" & SND_CREACIONCLAN)
    HayRey = 0
    HonorA = 0
End Sub
 
Public Sub DarPremioCastillos()
HonorA = HonorA + 53500
End Sub

