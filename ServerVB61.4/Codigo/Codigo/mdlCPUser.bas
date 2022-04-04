Attribute VB_Name = "mdlCPUser"
 
'director del proyecto: #Esteban(Neliam)

'servidor basado en fénixao 1.0
'medios de contacto:
'Skype: dc.esteban
'E-mail: nabrianao@gmail.com
Sub LoadUser(Userindex As Integer, UserFile As String)
On Error GoTo errhandler
Dim loopc As Integer
Dim ln As String
Dim ln2 As String
'CARGAMOS USER'
UserList(Userindex).PassWord = GetVar(UserFile, "INIT", "Password")
 
UserList(Userindex).Email = GetVar(UserFile, "CONTACTO", "Email")
UserList(Userindex).Genero = GetVar(UserFile, "INIT", "Genero")
UserList(Userindex).Raza = GetVar(UserFile, "INIT", "Raza")
UserList(Userindex).Hogar = GetVar(UserFile, "INIT", "Hogar")
UserList(Userindex).Clase = GetVar(UserFile, "INIT", "Clase")
UserList(Userindex).Codigo = GetVar(UserFile, "INIT", "codigo")
 
UserList(Userindex).Desc = GetVar(UserFile, "INIT", "Desc")
UserList(Userindex).PuestoEnTop = GetVar(UserFile, "INIT", "Rank250")

UserList(Userindex).OrigChar.Head = val(GetVar(UserFile, "INIT", "Head"))
 
UserList(Userindex).POS.Map = val(ReadField(1, GetVar(UserFile, "INIT", "Position"), 45))
UserList(Userindex).POS.X = val(ReadField(2, GetVar(UserFile, "INIT", "Position"), 45))
UserList(Userindex).POS.y = val(ReadField(3, GetVar(UserFile, "INIT", "Position"), 45))
 
UserList(Userindex).Char.Heading = 3
 
'CARGAMOS STATS'
UserList(Userindex).Stats.GLD = val(GetVar(UserFile, "STATS", "GLD"))
UserList(Userindex).Stats.Banco = val(GetVar(UserFile, "STATS", "Banco"))
 
UserList(Userindex).Stats.MaxHP = val(GetVar(UserFile, "STATS", "MaxHP"))
UserList(Userindex).Stats.MinHP = val(GetVar(UserFile, "STATS", "MinHP"))
 
UserList(Userindex).Stats.MinSta = val(GetVar(UserFile, "STATS", "MinSta"))
UserList(Userindex).Stats.MaxSta = val(GetVar(UserFile, "STATS", "MaxSta"))
    
UserList(Userindex).Stats.MaxMAN = val(GetVar(UserFile, "STATS", "MaxMAN"))
 
UserList(Userindex).Stats.MinMAN = val(GetVar(UserFile, "STATS", "MinMAN"))
 
UserList(Userindex).Stats.MaxHit = val(GetVar(UserFile, "STATS", "MaxHit"))
UserList(Userindex).Stats.MinHit = val(GetVar(UserFile, "STATS", "MinHit"))
 
UserList(Userindex).Stats.MinAGU = val(GetVar(UserFile, "STATS", "MinAGU"))
UserList(Userindex).Stats.MinHam = val(GetVar(UserFile, "STATS", "MinHam"))
 
UserList(Userindex).Stats.SkillPts = val(GetVar(UserFile, "STATS", "SkillPtsLibres"))
 
UserList(Userindex).Stats.Exp = val(GetVar(UserFile, "STATS", "EXP"))
UserList(Userindex).Stats.ELV = val(GetVar(UserFile, "STATS", "ELV"))
UserList(Userindex).Stats.ELU = ELUs(val(GetVar(UserFile, "STATS", "ELV")))
UserList(Userindex).Stats.Reputacion = val(GetVar(UserFile, "STATS", "Reputacion"))
 
UserList(Userindex).Stats.VecesMurioUsuario = val(GetVar(UserFile, "MUERTES", "VecesMurioUsuario"))
UserList(Userindex).Stats.NPCsMuertos = val(GetVar(UserFile, "MUERTES", "NpcsMuertes"))
 
 
For loopc = 1 To 3
    UserList(Userindex).Recompensas(loopc) = val(GetVar(UserFile, "RECOMPENSAS", "Recompensa" & loopc))
Next
 
With UserList(Userindex)
    If .Stats.MinAGU < 1 Then .flags.Sed = 1
    If .Stats.MinHam < 1 Then .flags.Hambre = 1
    If .Stats.MinHP < 1 Then .flags.Muerto = 1
End With
 
'CARGAMOS .FLAGS'
UserList(Userindex).flags.Ban = val(GetVar(UserFile, "FLAGS", "Ban"))
UserList(Userindex).flags.Navegando = val(GetVar(UserFile, "FLAGS", "Navegando"))
UserList(Userindex).flags.VIP = val(GetVar(UserFile, "FLAGS", "VIP"))
UserList(Userindex).flags.Envenenado = val(GetVar(UserFile, "FLAGS", "Envenenado"))
UserList(Userindex).flags.Denuncias = val(GetVar(UserFile, "FLAGS", "DenunciasCheat"))
UserList(Userindex).flags.DenunciasInsultos = val(GetVar(UserFile, "FLAGS", "DenunciasInsultos"))
UserList(Userindex).flags.EsConseReal = val(GetVar(UserFile, "FLAGS", "EsConseReal"))
UserList(Userindex).flags.EsConseCaos = val(GetVar(UserFile, "FLAGS", "EsConseCaos"))
UserList(Userindex).flags.EsConcilioNegro = val(GetVar(UserFile, "FLAGS", "EsConcilioNegro"))
UserList(Userindex).flags.Templario = val(GetVar(UserFile, "FLAGS", "Templario"))
UserList(Userindex).flags.Mision = val(GetVar(UserFile, "FLAGS", "Mision"))

UserList(Userindex).flags.SoporteSTOP = val(GetVar(UserFile, "FLAGS", "SoporteSTOP"))
UserList(Userindex).flags.CanjesDonador = val(GetVar(UserFile, "FLAGS", "CanjesDonador"))
UserList(Userindex).flags.Advertencias = val(GetVar(UserFile, "FLAGS", "Advertencias"))
UserList(Userindex).flags.Advertenciasfacc = val(GetVar(UserFile, "FLAGS", "Advertenciasfacc"))
UserList(Userindex).flags.RetosGanados = val(GetVar(UserFile, "FLAGS", "RetosGanados"))
UserList(Userindex).flags.RetosPerdidos = val(GetVar(UserFile, "FLAGS", "RetosPerdidos"))
UserList(Userindex).flags.yaledio = val(GetVar(UserFile, "FLAGS", "yaledio"))
UserList(Userindex).flags.SuCodigo = val(GetVar(UserFile, "FLAGS", "SuCodigo"))
UserList(Userindex).flags.PremioUserLevel46 = val(GetVar(UserFile, "FLAGS", "PremioUserLevel46"))
UserList(Userindex).flags.PremioUserLevel47 = val(GetVar(UserFile, "FLAGS", "PremioUserLevel47"))
UserList(Userindex).flags.PremioUserLevel48 = val(GetVar(UserFile, "FLAGS", "PremioUserLevel48"))
UserList(Userindex).flags.PremioUserLevel49 = val(GetVar(UserFile, "FLAGS", "PremioUserLevel49"))
UserList(Userindex).flags.PremioUserLevel50 = val(GetVar(UserFile, "FLAGS", "PremioUserLevel50"))

'CARGAMOS COUNTERS
UserList(Userindex).Counters.TiempoPena = 60 * val(GetVar(UserFile, "COUNTERS", "Pena"))

'CARGAMOS FACCION
UserList(Userindex).Faccion.Bando = val(GetVar(UserFile, "FACCIONES", "Bando"))
UserList(Userindex).Faccion.BandoOriginal = val(GetVar(UserFile, "FACCIONES", "BandoOriginal"))
UserList(Userindex).Faccion.Matados(0) = val(GetVar(UserFile, "FACCIONES", "Matados0"))
UserList(Userindex).Faccion.Matados(1) = val(GetVar(UserFile, "FACCIONES", "Matados1"))
UserList(Userindex).Faccion.Matados(2) = val(GetVar(UserFile, "FACCIONES", "Matados2"))
UserList(Userindex).Faccion.Jerarquia = val(GetVar(UserFile, "FACCIONES", "Jerarquia"))
UserList(Userindex).Faccion.Ataco(1) = val(GetVar(UserFile, "FACCIONES", "Ataco1"))
UserList(Userindex).Faccion.Ataco(2) = val(GetVar(UserFile, "FACCIONES", "Ataco2"))
UserList(Userindex).Faccion.Quests = val(GetVar(UserFile, "FACCIONES", "Quests"))
UserList(Userindex).Faccion.torneos = val(GetVar(UserFile, "FACCIONES", "Torneos"))
 
   
'CARGAMOS GUILD
UserList(Userindex).GuildInfo.EsGuildLeader = val(GetVar(UserFile, "Guild", "EsGuildLeader"))
UserList(Userindex).GuildInfo.echadas = val(GetVar(UserFile, "Guild", "Echadas"))
UserList(Userindex).GuildInfo.Solicitudes = val(GetVar(UserFile, "Guild", "Solicitudes"))
UserList(Userindex).GuildInfo.SolicitudesRechazadas = val(GetVar(UserFile, "Guild", "SolicitudesRechazadas"))
UserList(Userindex).GuildInfo.VecesFueGuildLeader = val(GetVar(UserFile, "Guild", "VecesFueGuildLeader"))
UserList(Userindex).GuildInfo.YaVoto = val(GetVar(UserFile, "Guild", "YaVoto"))
UserList(Userindex).GuildInfo.FundoClan = val(GetVar(UserFile, "Guild", "FundoClan"))
UserList(Userindex).GuildInfo.ClanesParticipo = val(GetVar(UserFile, "Guild", "ClanesParticipo"))
UserList(Userindex).GuildInfo.GuildPoints = val(GetVar(UserFile, "Guild", "GuildPts"))
UserList(Userindex).GuildInfo.GuildName = GetVar(UserFile, "Guild", "GuildName")
UserList(Userindex).GuildInfo.ClanFundado = GetVar(UserFile, "Guild", "ClanFundado")
 
For loopc = 1 To NUMATRIBUTOS
  UserList(Userindex).Stats.UserAtributos(loopc) = GetVar(UserFile, "ATRIBUTOS", "AT" & loopc)
  UserList(Userindex).Stats.UserAtributosBackUP(loopc) = UserList(Userindex).Stats.UserAtributos(loopc)
Next
 
For loopc = 1 To NUMSKILLS
  UserList(Userindex).Stats.UserSkills(loopc) = val(GetVar(UserFile, "SKILLS", "SK" & loopc))
Next
 
For loopc = 1 To MAXUSERHECHIZOS
  UserList(Userindex).Stats.UserHechizos(loopc) = val(GetVar(UserFile, "Hechizos", "H" & loopc))
Next
 
'[KEVIN]--------------------------------------------------------------------
'***********************************************************************************
UserList(Userindex).BancoInvent.NroItems = val(GetVar(UserFile, "BancoInventory", "CantidadItems"))
'Lista de objetos del banco
For loopd = 1 To MAX_BANCOINVENTORY_SLOTS
    ln2 = GetVar(UserFile, "BancoInventory", "Obj" & loopd)
    UserList(Userindex).BancoInvent.Object(loopd).OBJIndex = val(ReadField(1, ln2, 45))
    UserList(Userindex).BancoInvent.Object(loopd).Amount = val(ReadField(2, ln2, 45))
Next loopd
'------------------------------------------------------------------------------------
'[/KEVIN]*****************************************************************************
 
 
'Lista de objetos
For loopc = 1 To MAX_INVENTORY_SLOTS
    ln = GetVar(UserFile, "Inventory", "Obj" & loopc)
    UserList(Userindex).Invent.Object(loopc).OBJIndex = val(ReadField(1, ln, 45))
    UserList(Userindex).Invent.Object(loopc).Amount = val(ReadField(2, ln, 45))
    UserList(Userindex).Invent.Object(loopc).Equipped = val(ReadField(3, ln, 45))
Next loopc
 
 
UserList(Userindex).Invent.WeaponEqpSlot = val(GetVar(UserFile, "Inventory", "WEAPONSLOT"))
UserList(Userindex).Invent.CascoEqpSlot = val(GetVar(UserFile, "Inventory", "CASCOSLOT"))
UserList(Userindex).Invent.ArmourEqpSlot = val(GetVar(UserFile, "Inventory", "ARMORSLOT"))
UserList(Userindex).Invent.EscudoEqpSlot = val(GetVar(UserFile, "Inventory", "SHIELDSLOT"))
UserList(Userindex).Invent.HerramientaEqpslot = val(GetVar(UserFile, "Inventory", "HERRAMIENTASLOT"))
UserList(Userindex).Invent.MunicionEqpSlot = val(GetVar(UserFile, "Inventory", "MUNICIONSLOT"))
UserList(Userindex).Invent.BarcoSlot = val(GetVar(UserFile, "Inventory", "BarcoSlot"))
 
 
With UserList(Userindex)
    If Len(.Desc) >= 80 Then .Desc = Left$(.Desc, 80)
 
    If .Counters.TiempoPena > 0 Then
        .flags.Encarcelado = 1
        .Counters.Pena = Timer
    End If
    
    .Stats.MaxAGU = 100
    .Stats.MaxHam = 100
    Call CalcularSta(Userindex)
End With
 
With UserList(Userindex)
    If .flags.Muerto = 0 Then
        .Char = .OrigChar
        UserList(Userindex).Char.Heading = 3
        Call VerObjetosEquipados(Userindex)
    Else
        .Char.Body = iCuerpoMuerto
        .Char.Head = iCabezaMuerto
        .Char.WeaponAnim = NingunArma
        .Char.ShieldAnim = NingunEscudo
        .Char.CascoAnim = NingunCasco
    End If
End With
 
errhandler:
    Call LogError("Error en LoadUser. N:" & Name & " - " & Err.Number & "-" & Err.Description)
End Sub
 
Sub SaveUser(Userindex As Integer, UserFile As String)
On Error GoTo errhandler
Dim mUser As user
Dim i As Byte
Dim str As String
Dim Pena As Integer
 
Dim OldUserHead As Long

If UserList(Userindex).flags.TemporalLoginSeguridadGM = 1 Then Exit Sub 'IDENTIFICADOR GM
 
If FileExist(UserFile, vbNormal) Then
    If UserList(Userindex).flags.Muerto = 1 Then
        OldUserHead = UserList(Userindex).Char.Head
        UserList(Userindex).Char.Head = val(GetVar(UserFile, "INIT", "Head"))
    End If
       'Kill UserFile
End If
 
Dim loopc As Integer
 
Call WriteVar(UserFile, "FLAGS", "Ban", val(UserList(Userindex).flags.Ban))
Call WriteVar(UserFile, "FLAGS", "Muerto", val(UserList(Userindex).flags.Muerto))
 
Call WriteVar(UserFile, "FLAGS", "Navegando", val(UserList(Userindex).flags.Navegando))
Call WriteVar(UserFile, "FLAGS", "VIP", val(UserList(Userindex).flags.VIP))
Call WriteVar(UserFile, "FLAGS", "Envenenado", val(UserList(Userindex).flags.Envenenado))
 
Call WriteVar(UserFile, "FLAGS", "DenunciasCheat", val(UserList(Userindex).flags.Denuncias))
Call WriteVar(UserFile, "FLAGS", "DenunciasInsultos", val(UserList(Userindex).flags.DenunciasInsultos))

Call WriteVar(UserFile, "FLAGS", "EsConseReal", val(UserList(Userindex).flags.EsConseReal))
Call WriteVar(UserFile, "FLAGS", "EsConseCaos", val(UserList(Userindex).flags.EsConseCaos))
Call WriteVar(UserFile, "FLAGS", "EsConcilioNegro", val(UserList(Userindex).flags.EsConcilioNegro))
Call WriteVar(UserFile, "FLAGS", "Templario", val(UserList(Userindex).flags.Templario))
Call WriteVar(UserFile, "FLAGS", "Mision", val(UserList(Userindex).flags.Mision))
Call WriteVar(UserFile, "FLAGS", "SoporteSTOP", val(UserList(Userindex).flags.SoporteSTOP))
Call WriteVar(UserFile, "FLAGS", "CanjesDonador", val(UserList(Userindex).flags.CanjesDonador))
Call WriteVar(UserFile, "FLAGS", "Advertencias", val(UserList(Userindex).flags.Advertencias))
Call WriteVar(UserFile, "FLAGS", "Advertenciasfacc", val(UserList(Userindex).flags.Advertenciasfacc))
Call WriteVar(UserFile, "FLAGS", "RetosGanados", val(UserList(Userindex).flags.RetosGanados))
Call WriteVar(UserFile, "FLAGS", "RetosPerdidos", val(UserList(Userindex).flags.RetosPerdidos))
Call WriteVar(UserFile, "FLAGS", "yaledio", val(UserList(Userindex).flags.yaledio))
Call WriteVar(UserFile, "FLAGS", "SuCodigo", val(UserList(Userindex).flags.SuCodigo))
Call WriteVar(UserFile, "FLAGS", "PremioUserLevel46", val(UserList(Userindex).flags.PremioUserLevel46))
Call WriteVar(UserFile, "FLAGS", "PremioUserLevel47", val(UserList(Userindex).flags.PremioUserLevel47))
Call WriteVar(UserFile, "FLAGS", "PremioUserLevel48", val(UserList(Userindex).flags.PremioUserLevel48))
Call WriteVar(UserFile, "FLAGS", "PremioUserLevel49", val(UserList(Userindex).flags.PremioUserLevel49))
Call WriteVar(UserFile, "FLAGS", "PremioUserLevel50", val(UserList(Userindex).flags.PremioUserLevel50))

Call WriteVar(UserFile, "COUNTERS", "Pena", val(UserList(Userindex).Counters.TiempoPena))

Call WriteVar(UserFile, "INIT", "Password", UserList(Userindex).PassWord)
 
 
'****************************************************************************************************************
'******************************** FACCION ***********************************************************************
'****************************************************************************************************************
 
Call WriteVar(UserFile, "FACCIONES", "Bando", val(UserList(Userindex).Faccion.Bando))
Call WriteVar(UserFile, "FACCIONES", "BandoOriginal", val(UserList(Userindex).Faccion.BandoOriginal))
Call WriteVar(UserFile, "FACCIONES", "Matados0", val(UserList(Userindex).Faccion.Matados(0)))
Call WriteVar(UserFile, "FACCIONES", "Matados1", val(UserList(Userindex).Faccion.Matados(1)))
Call WriteVar(UserFile, "FACCIONES", "Matados2", val(UserList(Userindex).Faccion.Matados(2)))
 
Call WriteVar(UserFile, "FACCIONES", "Jerarquia", val(UserList(Userindex).Faccion.Jerarquia))
Call WriteVar(UserFile, "FACCIONES", "Ataco1", Buleano(UserList(Userindex).Faccion.Ataco(1) = 1))
Call WriteVar(UserFile, "FACCIONES", "Ataco2", Buleano(UserList(Userindex).Faccion.Ataco(2) = 1))
 
Call WriteVar(UserFile, "FACCIONES", "Quests", val(UserList(Userindex).Faccion.Quests))
Call WriteVar(UserFile, "FACCIONES", "Torneos", val(UserList(Userindex).Faccion.torneos))
 
'****************************************************************************************************************
'******************************** GUILDS ************************************************************************
'****************************************************************************************************************
 
Call WriteVar(UserFile, "GUILD", "EsGuildLeader", val(UserList(Userindex).GuildInfo.EsGuildLeader))
Call WriteVar(UserFile, "GUILD", "Echadas", val(UserList(Userindex).GuildInfo.echadas))
Call WriteVar(UserFile, "GUILD", "Solicitudes", val(UserList(Userindex).GuildInfo.Solicitudes))
Call WriteVar(UserFile, "GUILD", "SolicitudesRechazadas", val(UserList(Userindex).GuildInfo.SolicitudesRechazadas))
Call WriteVar(UserFile, "GUILD", "VecesFueGuildLeader", val(UserList(Userindex).GuildInfo.VecesFueGuildLeader))
Call WriteVar(UserFile, "GUILD", "YaVoto", val(UserList(Userindex).GuildInfo.YaVoto))
Call WriteVar(UserFile, "GUILD", "FundoClan", val(UserList(Userindex).GuildInfo.FundoClan))
 
Call WriteVar(UserFile, "GUILD", "ClanesParticipo", val(UserList(Userindex).GuildInfo.ClanesParticipo))
Call WriteVar(UserFile, "GUILD", "GuildPts", val(UserList(Userindex).GuildInfo.GuildPoints))
Call WriteVar(UserFile, "GUILD", "GuildName", UserList(Userindex).GuildInfo.GuildName)
Call WriteVar(UserFile, "GUILD", "ClanFundado", UserList(Userindex).GuildInfo.ClanFundado)
 
For loopc = 1 To NUMATRIBUTOS
    UserList(Userindex).Stats.UserAtributos(loopc) = UserList(Userindex).Stats.UserAtributosBackUP(loopc)
    Call WriteVar(UserFile, "ATRIBUTOS", "AT" & loopc, val(UserList(Userindex).Stats.UserAtributos(loopc)))
Next
 
For i = 1 To NUMSKILLS
    'str = str & ",SK" & i & "=" & mUser.Stats.UserSkills(i)
    Call WriteVar(UserFile, "SKILLS", "SK" & i, val(UserList(Userindex).Stats.UserSkills(i)))
Next i
 
Call WriteVar(UserFile, "CONTACTO", "Email", UserList(Userindex).Email)
Call WriteVar(UserFile, "INIT", "Genero", val(UserList(Userindex).Genero))
Call WriteVar(UserFile, "INIT", "Raza", val(UserList(Userindex).Raza))
Call WriteVar(UserFile, "INIT", "Hogar", val(UserList(Userindex).Hogar))
Call WriteVar(UserFile, "INIT", "Clase", val(UserList(Userindex).Clase))
Call WriteVar(UserFile, "INIT", "Password", UserList(Userindex).PassWord)
Call WriteVar(UserFile, "INIT", "Desc", UserList(Userindex).Desc)
Call WriteVar(UserFile, "INIT", "Rank250", val(UserList(Userindex).PuestoEnTop) + 0)

 
Call WriteVar(UserFile, "INIT", "Heading", val(UserList(Userindex).Char.Heading))
 
Call WriteVar(UserFile, "INIT", "Head", val(UserList(Userindex).OrigChar.Head))
 
If UserList(Userindex).flags.Muerto = 0 Then
    Call WriteVar(UserFile, "INIT", "Body", val(UserList(Userindex).Char.Body))
End If
 
Call WriteVar(UserFile, "INIT", "LastHD", UserList(Userindex).HDDisck)
Call WriteVar(UserFile, "INIT", "Mother", UserList(Userindex).MotherNumber)
Call WriteVar(UserFile, "INIT", "LastMac", UserList(Userindex).Mac)
Call WriteVar(UserFile, "INIT", "LastIP", UserList(Userindex).ip)
Call WriteVar(UserFile, "INIT", "Position", UserList(Userindex).POS.Map & "-" & UserList(Userindex).POS.X & "-" & UserList(Userindex).POS.y)
 
 
Call WriteVar(UserFile, "STATS", "GLD", val(UserList(Userindex).Stats.GLD))
Call WriteVar(UserFile, "STATS", "BANCO", val(UserList(Userindex).Stats.Banco))
 
Call WriteVar(UserFile, "STATS", "MET", val(UserList(Userindex).Stats.MET))
Call WriteVar(UserFile, "STATS", "MaxHP", val(UserList(Userindex).Stats.MaxHP))
Call WriteVar(UserFile, "STATS", "MinHP", val(UserList(Userindex).Stats.MinHP))
 
Call WriteVar(UserFile, "STATS", "FIT", val(UserList(Userindex).Stats.FIT))
'Call WriteVar(UserFile, "STATS", "MaxSTA", val(UserList(UserIndex).Stats.MaxSta))
Call WriteVar(UserFile, "STATS", "MinSTA", val(UserList(Userindex).Stats.MinSta))
 
 
Call WriteVar(UserFile, "STATS", "MaxMAN", val(UserList(Userindex).Stats.MaxMAN))
Call WriteVar(UserFile, "STATS", "MinMAN", val(UserList(Userindex).Stats.MinMAN))
 
Call WriteVar(UserFile, "STATS", "MaxHIT", val(UserList(Userindex).Stats.MaxHit))
Call WriteVar(UserFile, "STATS", "MinHIT", val(UserList(Userindex).Stats.MinHit))
 
Call WriteVar(UserFile, "STATS", "MaxAGU", val(UserList(Userindex).Stats.MaxAGU))
Call WriteVar(UserFile, "STATS", "MinAGU", val(UserList(Userindex).Stats.MinAGU))
 
Call WriteVar(UserFile, "STATS", "MaxHAM", val(UserList(Userindex).Stats.MaxHam))
Call WriteVar(UserFile, "STATS", "MinHAM", val(UserList(Userindex).Stats.MinHam))
 
Call WriteVar(UserFile, "STATS", "SkillPtsLibres", val(UserList(Userindex).Stats.SkillPts))
  
 
Call WriteVar(UserFile, "STATS", "EXP", val(UserList(Userindex).Stats.Exp))
Call WriteVar(UserFile, "STATS", "ELV", val(UserList(Userindex).Stats.ELV))
Call WriteVar(UserFile, "STATS", "ELU", val(UserList(Userindex).Stats.ELU))

Call WriteVar(UserFile, "STATS", "Reputacion", val(UserList(Userindex).Stats.Reputacion))
 
Call WriteVar(UserFile, "MUERTES", "VecesMurioUsuario", val(UserList(Userindex).Stats.VecesMurioUsuario))
Call WriteVar(UserFile, "MUERTES", "NpcsMuertes", val(UserList(Userindex).Stats.NPCsMuertos))
 
'[KEVIN]----------------------------------------------------------------------------
'*******************************************************************************************
Call WriteVar(UserFile, "BancoInventory", "CantidadItems", val(UserList(Userindex).BancoInvent.NroItems))
Dim loopd As Integer
For loopd = 1 To MAX_BANCOINVENTORY_SLOTS
    Call WriteVar(UserFile, "BancoInventory", "Obj" & loopd, UserList(Userindex).BancoInvent.Object(loopd).OBJIndex & "-" & UserList(Userindex).BancoInvent.Object(loopd).Amount)
Next loopd
'*******************************************************************************************
'[/KEVIN]-----------
  
'Save Inv
Call WriteVar(UserFile, "Inventory", "CantidadItems", val(UserList(Userindex).Invent.NroItems))
 
For loopc = 1 To MAX_INVENTORY_SLOTS
    Call WriteVar(UserFile, "Inventory", "Obj" & loopc, UserList(Userindex).Invent.Object(loopc).OBJIndex & "-" & UserList(Userindex).Invent.Object(loopc).Amount) '& "-" & UserList(UserIndex).Invent.Object(LoopC).Equipped)
Next
 
Call WriteVar(UserFile, "Inventory", "WEAPONSLOT", val(UserList(Userindex).Invent.WeaponEqpSlot))
Call WriteVar(UserFile, "Inventory", "ARMORSLOT", val(UserList(Userindex).Invent.ArmourEqpSlot))
Call WriteVar(UserFile, "Inventory", "CASCOSLOT", val(UserList(Userindex).Invent.CascoEqpSlot))
Call WriteVar(UserFile, "Inventory", "SHIELDSLOT", val(UserList(Userindex).Invent.EscudoEqpSlot))
Call WriteVar(UserFile, "Inventory", "BarcoSlot", val(UserList(Userindex).Invent.BarcoSlot))
Call WriteVar(UserFile, "Inventory", "MUNICIONSLOT", val(UserList(Userindex).Invent.MunicionEqpSlot))
Call WriteVar(UserFile, "Inventory", "HERRAMIENTASLOT", val(UserList(Userindex).Invent.HerramientaEqpslot))
 
For loopc = 1 To 3
    Call WriteVar(UserFile, "RECOMPENSAS", "Recompensa" & loopc, val(UserList(Userindex).Recompensas(loopc)))
Next loopc
 
Dim cad As String
 
For loopc = 1 To MAXUSERHECHIZOS
    cad = UserList(Userindex).Stats.UserHechizos(loopc)
    Call WriteVar(UserFile, "HECHIZOS", "H" & loopc, val(cad))
Next
 
 Call RevisarTops(Userindex)

 
Exit Sub
 
errhandler:
Call LogError("Error en SaveUser")
 
End Sub
 
