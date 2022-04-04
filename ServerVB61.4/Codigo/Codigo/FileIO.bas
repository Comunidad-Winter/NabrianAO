Attribute VB_Name = "ES"
 
'director del proyecto: #Esteban(Neliam)

'servidor basado en fénixao 1.0
'medios de contacto:
'Skype: dc.esteban
'E-mail: nabrianao@gmail.com
Public BalanceCasa As Double
Public Baneos As New Collection
Public SoporteS As New Collection

Option Explicit
Public Sub LoadCasino()

BalanceCasa = val(GetVar(App.Path & "\Logs\Casino.log", "INIT", "Balance"))

End Sub
Public Sub SaveCasino()

Call WriteVar(App.Path & "\Logs\Casino.log", "INIT", "Balance", str(BalanceCasa))

End Sub
Public Sub LoadVentas()

DineroTotalVentas = val(GetVar(App.Path & "\Dat\Ventas.dat", "INIT", "Dinero"))
NumeroVentas = val(GetVar(App.Path & "\Dat\Ventas.dat", "INIT", "Numero"))

End Sub
 Public Sub CargarPremiosList()
                Dim z As Integer, aaaaa As Integer
        z = val(GetVar(App.Path & "\Dat\Premiosdonador.dat", "INIT", "NumPremios"))

        ReDim PremiosListDonador(z) As tPremiosCanjes
       
           
        For aaaaa = 1 To z
            PremiosListDonador(aaaaa).ObjName = GetVar(App.Path & "\Dat\Premiosdonador.dat", "PREMIO" & aaaaa, "Nombre")
            PremiosListDonador(aaaaa).ObjIndexP = val(GetVar(App.Path & "\Dat\Premiosdonador.dat", "PREMIO" & aaaaa, "NumObj"))
            PremiosListDonador(aaaaa).ObjRequiere = val(GetVar(App.Path & "\Dat\Premiosdonador.dat", "PREMIO" & aaaaa, "Requiere"))
            PremiosListDonador(aaaaa).ObjMaxAt = GetVar(App.Path & "\Dat\Premiosdonador.dat", "PREMIO" & aaaaa, "AtaqueMaximo")
            PremiosListDonador(aaaaa).ObjMinAt = GetVar(App.Path & "\Dat\Premiosdonador.dat", "PREMIO" & aaaaa, "AtaqueMinimo")
            PremiosListDonador(aaaaa).ObjMindef = GetVar(App.Path & "\Dat\Premiosdonador.dat", "PREMIO" & aaaaa, "DefensaMinima")
            PremiosListDonador(aaaaa).ObjMaxdef = GetVar(App.Path & "\Dat\Premiosdonador.dat", "PREMIO" & aaaaa, "DefensaMaxima")
            PremiosListDonador(aaaaa).ObjMinAtMag = GetVar(App.Path & "\Dat\Premiosdonador.dat", "PREMIO" & aaaaa, "AtaqueMagicoMinimo")
            PremiosListDonador(aaaaa).ObjMaxAtMag = GetVar(App.Path & "\Dat\Premiosdonador.dat", "PREMIO" & aaaaa, "AtaqueMagicoMaximo")
            PremiosListDonador(aaaaa).ObjMinDefMag = GetVar(App.Path & "\Dat\Premiosdonador.dat", "PREMIO" & aaaaa, "DefensaMagicaMinima")
            PremiosListDonador(aaaaa).ObjMaxDefMag = GetVar(App.Path & "\Dat\Premiosdonador.dat", "PREMIO" & aaaaa, "DefensaMagicaMaxima")
            PremiosListDonador(aaaaa).ObjDescripcion = GetVar(App.Path & "\Dat\Premiosdonador.dat", "PREMIO" & aaaaa, "Descripcion")
            PremiosListDonador(aaaaa).templariobeneficio = GetVar(App.Path & "\Dat\Premiosdonador.dat", "PREMIO" & aaaaa, "devuelve")
            PremiosListDonador(aaaaa).cambiarpuntos = GetVar(App.Path & "\Dat\Premiosdonador.dat", "PREMIO" & aaaaa, "cambiarpuntos")
        Next aaaaa
    End Sub
Public Sub CargarSpawnList()
Dim N As Integer, loopc As Integer

N = val(GetVar(App.Path & "\Dat\Invokar.dat", "INIT", "NumNPCs"))

ReDim SpawnList(N) As tCriaturasEntrenador

For loopc = 1 To N
    SpawnList(loopc).NpcIndex = val(GetVar(App.Path & "\Dat\Invokar.dat", "LIST", "NI" & loopc))
    SpawnList(loopc).NpcName = GetVar(App.Path & "\Dat\Invokar.dat", "LIST", "NN" & loopc)
Next
    
End Sub
Function PJQuest(ByVal Name As String) As Boolean
Dim NumWizs As Integer
Dim WizNum As Integer
Dim Nomb As String

NumWizs = val(GetVar(IniPath & "Server.ini", "INIT", "PJsQuest"))

For WizNum = 1 To NumWizs
    Nomb = UCase$(GetVar(IniPath & "Server.ini", "PJsQuest", "PJQuest" & WizNum))
    If Left$(Nomb, 1) = "*" Or Left$(Nomb, 1) = "+" Then Nomb = Right$(Nomb, Len(Nomb) - 1)
    If UCase$(Name) = Nomb Then
        PJQuest = True
        Exit Function
    End If
Next

End Function
Function PuedeDenunciar(ByVal Name As String) As Boolean
Dim NumWizs As Integer
Dim WizNum As Integer
Dim Nomb As String

NumWizs = val(GetVar(IniPath & "Server.ini", "INIT", "SubGMs"))

For WizNum = 1 To NumWizs
    Nomb = UCase$(GetVar(IniPath & "Server.ini", "SubGMs", "SubGM" & WizNum))
    If Left$(Nomb, 1) = "*" Or Left$(Nomb, 1) = "+" Then Nomb = Right$(Nomb, Len(Nomb) - 1)
    If UCase$(Name) = Nomb Then
        PuedeDenunciar = True
        Exit Function
    End If
Next

End Function
Function EsSuperAdm(ByVal Name As String) As Boolean
Dim NumWizs As Integer
Dim WizNum As Integer
Dim Nomb As String

NumWizs = val(GetVar(IniPath & "Server.ini", "INIT", "SuperAdms"))

For WizNum = 1 To NumWizs
    Nomb = UCase$(GetVar(IniPath & "Server.ini", "SuperAdms", "SuperAdm" & WizNum))
    If Left$(Nomb, 1) = "*" Or Left$(Nomb, 1) = "+" Then Nomb = Right$(Nomb, Len(Nomb) - 1)
    If UCase$(Name) = Nomb Then
        EsSuperAdm = True
        Exit Function
    End If
Next

End Function
Function EsDios(ByVal Name As String) As Boolean
Dim NumWizs As Integer
Dim WizNum As Integer
Dim Nomb As String

NumWizs = val(GetVar(IniPath & "Server.ini", "INIT", "Administradores"))

For WizNum = 1 To NumWizs
    Nomb = UCase$(GetVar(IniPath & "Server.ini", "Administradores", "Administrador" & WizNum))
    If Left$(Nomb, 1) = "*" Or Left$(Nomb, 1) = "+" Then Nomb = Right$(Nomb, Len(Nomb) - 1)
    If UCase$(Name) = Nomb Then
        EsDios = True
        Exit Function
    End If
Next

End Function
Function EsSemiDios(ByVal Name As String) As Boolean
Dim NumWizs As Integer
Dim WizNum As Integer
Dim Nomb As String

NumWizs = val(GetVar(IniPath & "Server.ini", "INIT", "Eventos"))

For WizNum = 1 To NumWizs
    Nomb = UCase$(GetVar(IniPath & "Server.ini", "Eventos", "Evento" & WizNum))
    If Left$(Nomb, 1) = "*" Or Left$(Nomb, 1) = "+" Then Nomb = Right$(Nomb, Len(Nomb) - 1)
    If UCase$(Name) = Nomb Then
        EsSemiDios = True
        Exit Function
    End If
Next

End Function
Function EsConsejero(ByVal Name As String) As Boolean
Dim NumWizs As Integer
Dim WizNum As Integer
Dim Nomb As String

NumWizs = val(GetVar(IniPath & "Server.ini", "INIT", "Soportes"))

For WizNum = 1 To NumWizs
    Nomb = UCase$(GetVar(IniPath & "Server.ini", "Soportes", "Soporte" & WizNum))
    If Left$(Nomb, 1) = "*" Or Left$(Nomb, 1) = "+" Then Nomb = Right$(Nomb, Len(Nomb) - 1)
    If UCase$(Name) = Nomb Then
        EsConsejero = True
        Exit Function
    End If
Next

End Function
Public Function TxtDimension(ByVal Name As String) As Long
Dim N As Integer, cad As String, Tam As Long

N = FreeFile(1)

Open Name For Input As #N
    Tam = 0
    Do While Not EOF(N)
        Tam = Tam + 1
        Line Input #N, cad
    Loop
Close N

TxtDimension = Tam

End Function
Public Sub CargarForbidenWords()
ReDim ForbidenNames(1 To TxtDimension(DatPath & "NombresInvalidos.txt"))
Dim N As Integer, i As Integer

N = FreeFile(1)

Open DatPath & "NombresInvalidos.txt" For Input As #N
    For i = 1 To UBound(ForbidenNames)
        Line Input #N, ForbidenNames(i)
    Next
Close N

End Sub
Public Sub CargarHechizos()
On Error GoTo errhandler

If frmMain.Visible Then frmMain.txStatus.caption = "Cargando Hechizos."

Dim Hechizo As Integer

NumeroHechizos = val(GetVar(DatPath & "Hechizos.dat", "INIT", "NumeroHechizos"))
ReDim Hechizos(1 To NumeroHechizos) As tHechizo

frmCargando.cargar.MIN = 0
frmCargando.cargar.MAX = NumeroHechizos
frmCargando.cargar.value = 0

For Hechizo = 1 To NumeroHechizos

    Hechizos(Hechizo).Nombre = GetVar(DatPath & "Hechizos.dat", "Hechizo" & Hechizo, "Nombre")
    Hechizos(Hechizo).Desc = GetVar(DatPath & "Hechizos.dat", "Hechizo" & Hechizo, "Desc")
    Hechizos(Hechizo).PalabrasMagicas = GetVar(DatPath & "Hechizos.dat", "Hechizo" & Hechizo, "PalabrasMagicas")
    
    Hechizos(Hechizo).HechizeroMsg = GetVar(DatPath & "Hechizos.dat", "Hechizo" & Hechizo, "HechizeroMsg")
    Hechizos(Hechizo).TargetMsg = GetVar(DatPath & "Hechizos.dat", "Hechizo" & Hechizo, "TargetMsg")
    Hechizos(Hechizo).PropioMsg = GetVar(DatPath & "Hechizos.dat", "Hechizo" & Hechizo, "PropioMsg")
    
    Hechizos(Hechizo).Tipo = val(GetVar(DatPath & "Hechizos.dat", "Hechizo" & Hechizo, "Tipo"))
    Hechizos(Hechizo).WAV = val(GetVar(DatPath & "Hechizos.dat", "Hechizo" & Hechizo, "WAV"))
    Hechizos(Hechizo).FXgrh = val(GetVar(DatPath & "Hechizos.dat", "Hechizo" & Hechizo, "Fxgrh"))
    
    Hechizos(Hechizo).loops = val(GetVar(DatPath & "Hechizos.dat", "Hechizo" & Hechizo, "Loops"))
    
    Hechizos(Hechizo).Resis = val(GetVar(DatPath & "Hechizos.dat", "Hechizo" & Hechizo, "Resis"))
    Hechizos(Hechizo).Baculo = val(GetVar(DatPath & "Hechizos.dat", "Hechizo" & Hechizo, "Baculo"))
       
    Hechizos(Hechizo).SubeHP = val(GetVar(DatPath & "Hechizos.dat", "Hechizo" & Hechizo, "SubeHP"))
    Hechizos(Hechizo).MinHP = val(GetVar(DatPath & "Hechizos.dat", "Hechizo" & Hechizo, "MinHP"))
    Hechizos(Hechizo).MaxHP = val(GetVar(DatPath & "Hechizos.dat", "Hechizo" & Hechizo, "MaxHP"))
    
    Hechizos(Hechizo).SubeMana = val(GetVar(DatPath & "Hechizos.dat", "Hechizo" & Hechizo, "SubeMana"))
    Hechizos(Hechizo).MiMana = val(GetVar(DatPath & "Hechizos.dat", "Hechizo" & Hechizo, "MinMana"))
    Hechizos(Hechizo).MaMana = val(GetVar(DatPath & "Hechizos.dat", "Hechizo" & Hechizo, "MaxMana"))
    
    Hechizos(Hechizo).SubeSta = val(GetVar(DatPath & "Hechizos.dat", "Hechizo" & Hechizo, "SubeSta"))
    Hechizos(Hechizo).MinSta = val(GetVar(DatPath & "Hechizos.dat", "Hechizo" & Hechizo, "MinSta"))
    Hechizos(Hechizo).MaxSta = val(GetVar(DatPath & "Hechizos.dat", "Hechizo" & Hechizo, "MaxSta"))
    
    Hechizos(Hechizo).SubeHam = val(GetVar(DatPath & "Hechizos.dat", "Hechizo" & Hechizo, "SubeHam"))
    Hechizos(Hechizo).MinHam = val(GetVar(DatPath & "Hechizos.dat", "Hechizo" & Hechizo, "MinHam"))
    Hechizos(Hechizo).MaxHam = val(GetVar(DatPath & "Hechizos.dat", "Hechizo" & Hechizo, "MaxHam"))
    
    Hechizos(Hechizo).SubeSed = val(GetVar(DatPath & "Hechizos.dat", "Hechizo" & Hechizo, "SubeSed"))
    Hechizos(Hechizo).MinSed = val(GetVar(DatPath & "Hechizos.dat", "Hechizo" & Hechizo, "MinSed"))
    Hechizos(Hechizo).MaxSed = val(GetVar(DatPath & "Hechizos.dat", "Hechizo" & Hechizo, "MaxSed"))
    
    Hechizos(Hechizo).SubeAgilidad = val(GetVar(DatPath & "Hechizos.dat", "Hechizo" & Hechizo, "SubeAG"))
    Hechizos(Hechizo).MinAgilidad = val(GetVar(DatPath & "Hechizos.dat", "Hechizo" & Hechizo, "MinAG"))
    Hechizos(Hechizo).MaxAgilidad = val(GetVar(DatPath & "Hechizos.dat", "Hechizo" & Hechizo, "MaxAG"))
    
    Hechizos(Hechizo).SubeFuerza = val(GetVar(DatPath & "Hechizos.dat", "Hechizo" & Hechizo, "SubeFU"))
    Hechizos(Hechizo).MinFuerza = val(GetVar(DatPath & "Hechizos.dat", "Hechizo" & Hechizo, "MinFU"))
    Hechizos(Hechizo).MaxFuerza = val(GetVar(DatPath & "Hechizos.dat", "Hechizo" & Hechizo, "MaxFU"))
    
    Hechizos(Hechizo).SubeCarisma = val(GetVar(DatPath & "Hechizos.dat", "Hechizo" & Hechizo, "SubeCA"))
    Hechizos(Hechizo).MinCarisma = val(GetVar(DatPath & "Hechizos.dat", "Hechizo" & Hechizo, "MinCA"))
    Hechizos(Hechizo).MaxCarisma = val(GetVar(DatPath & "Hechizos.dat", "Hechizo" & Hechizo, "MaxCA"))
    
    Hechizos(Hechizo).Invisibilidad = val(GetVar(DatPath & "Hechizos.dat", "Hechizo" & Hechizo, "Invisibilidad"))
    Hechizos(Hechizo).Paraliza = val(GetVar(DatPath & "Hechizos.dat", "Hechizo" & Hechizo, "Paraliza"))
    
    Hechizos(Hechizo).Transforma = val(GetVar(DatPath & "Hechizos.dat", "Hechizo" & Hechizo, "Transforma"))
    Hechizos(Hechizo).Envenena = val(GetVar(DatPath & "Hechizos.dat", "Hechizo" & Hechizo, "Envenena"))
    Hechizos(Hechizo).Ceguera = val(GetVar(DatPath & "Hechizos.dat", "Hechizo" & Hechizo, "Ceguera"))
    Hechizos(Hechizo).Estupidez = val(GetVar(DatPath & "Hechizos.dat", "Hechizo" & Hechizo, "Estupidez"))

    Hechizos(Hechizo).Revivir = val(GetVar(DatPath & "Hechizos.dat", "Hechizo" & Hechizo, "Revivir"))
    Hechizos(Hechizo).Flecha = val(GetVar(DatPath & "Hechizos.dat", "Hechizo" & Hechizo, "Flecha"))
    
    Hechizos(Hechizo).Metamorfosis = val(GetVar(DatPath & "Hechizos.dat", "Hechizo" & Hechizo, "Metamorfosis"))
    Hechizos(Hechizo).Maldicion = val(GetVar(DatPath & "Hechizos.dat", "Hechizo" & Hechizo, "Maldicion"))
    Hechizos(Hechizo).Bendicion = val(GetVar(DatPath & "Hechizos.dat", "Hechizo" & Hechizo, "Bendicion"))
 
    Hechizos(Hechizo).RemoverParalisis = val(GetVar(DatPath & "Hechizos.dat", "Hechizo" & Hechizo, "RemoverParalisis"))
    Hechizos(Hechizo).CuraVeneno = val(GetVar(DatPath & "Hechizos.dat", "Hechizo" & Hechizo, "CuraVeneno"))
    Hechizos(Hechizo).RemoverMaldicion = val(GetVar(DatPath & "Hechizos.dat", "Hechizo" & Hechizo, "RemoverMaldicion"))
    
    Hechizos(Hechizo).Invoca = val(GetVar(DatPath & "Hechizos.dat", "Hechizo" & Hechizo, "Invoca"))
    Hechizos(Hechizo).NumNPC = val(GetVar(DatPath & "Hechizos.dat", "Hechizo" & Hechizo, "NumNpc"))
    Hechizos(Hechizo).Cant = val(GetVar(DatPath & "Hechizos.dat", "Hechizo" & Hechizo, "Cant"))
    
    Hechizos(Hechizo).Materializa = val(GetVar(DatPath & "Hechizos.dat", "Hechizo" & Hechizo, "Materializa"))
    Hechizos(Hechizo).ItemIndex = val(GetVar(DatPath & "Hechizos.dat", "Hechizo" & Hechizo, "ItemIndex"))
    
    Hechizos(Hechizo).Nivel = val(GetVar(DatPath & "Hechizos.dat", "Hechizo" & Hechizo, "Nivel"))
    'Hechizos(Hechizo).MinSkill = val(GetVar(DatPath & "Hechizos.dat", "Hechizo" & Hechizo, "MinSkill"))
    Hechizos(Hechizo).MinSkill = 0
    Hechizos(Hechizo).ManaRequerido = val(GetVar(DatPath & "Hechizos.dat", "Hechizo" & Hechizo, "ManaRequerido"))
    Hechizos(Hechizo).StaRequerido = val(GetVar(DatPath & "Hechizos.dat", "Hechizo" & Hechizo, "StaRequerido"))
    
    Hechizos(Hechizo).Target = val(GetVar(DatPath & "Hechizos.dat", "Hechizo" & Hechizo, "Target"))
    Hechizos(Hechizo).Particula = val(GetVar(DatPath & "Hechizos.dat", "Hechizo" & Hechizo, "Particula"))
    
    frmCargando.cargar.value = frmCargando.cargar.value + 1
Next

Exit Sub

errhandler:
        Call LogErrorUrgente("Error cargando Hechizos.dat -" & Err.Description & "-" & Hechizo)
End Sub
Sub LoadMotd()
Dim i As Integer

DiasSinLluvia = val(GetVar(DatPath & "lluvia.dat", "INIT", "DiasSinLLuvia"))

MaxLines = val(GetVar(App.Path & "\Dat\Motd.ini", "INIT", "NumLines"))

ReDim MOTD(1 To MaxLines)

For i = 1 To MaxLines
    MOTD(i).Texto = GetVar(App.Path & "\Dat\Motd.ini", "Motd", "Line" & i)
    MOTD(i).Formato = ""
Next

End Sub

Sub SaveSoportes()
On Error Resume Next
Dim Num As Integer
Kill DatPath & "soportes.dat"
Call WriteVar(DatPath & "soportes.dat", "INIT", "Numero", SoporteS.Count)
For Num = 1 To SoporteS.Count
Call WriteVar(DatPath & "soportes.dat", "INIT", "SOPORTE" & Num, SoporteS.Item(Num))
Next
End Sub
 
Sub LoadSoportes()
Dim i As Integer
Dim SoportesX As Integer
If Not FileExist(DatPath & "soportes.dat", vbNormal) Then Exit Sub
For i = 1 To SoporteS.Count
Call SoporteS.Remove(1)
Next
 
 
SoportesX = val(GetVar(DatPath & "soportes.dat", "INIT", "Numero"))
For i = 1 To SoportesX
Call SoporteS.Add(GetVar(DatPath & "soportes.dat", "INIT", "SOPORTE" & i))
Next
End Sub

Sub SaveBans()
Dim Num As Integer

Call WriteVar(DatPath & "baneos.dat", "INIT", "NumeroBans", Baneos.Count)

For Num = 1 To Baneos.Count
    Call WriteVar(DatPath & "baneos.dat", "BANEO" & Num, "USER", Baneos(Num).Name)
    Call WriteVar(DatPath & "baneos.dat", "BANEO" & Num, "FECHA", Baneos(Num).FechaLiberacion)
    Call WriteVar(DatPath & "baneos.dat", "BANEO" & Num, "BANEADOR", Baneos(Num).Baneador)
    Call WriteVar(DatPath & "baneos.dat", "BANEO" & Num, "CAUSA", Baneos(Num).Causa)
Next

End Sub
Sub SaveBan(Num As Integer)

Call WriteVar(DatPath & "baneos.dat", "INIT", "NumeroBans", Baneos.Count)
Call WriteVar(DatPath & "baneos.dat", "BANEO" & Num, "USER", Baneos(Num).Name)
Call WriteVar(DatPath & "baneos.dat", "BANEO" & Num, "FECHA", Baneos(Num).FechaLiberacion)
Call WriteVar(DatPath & "baneos.dat", "BANEO" & Num, "BANEADOR", Baneos(Num).Baneador)
Call WriteVar(DatPath & "baneos.dat", "BANEO" & Num, "CAUSA", Baneos(Num).Causa)

End Sub
Sub LoadBans()
Dim BaneosTemporales As Integer
Dim tBan As tBaneo, i As Integer


Dim NumHDs As Integer
Dim NumMothers As Integer
Dim NumIps As Integer

NumHDs = val(GetVar(App.Path & "\Logs\BanHDs.dat", "INIT", "Cantidad"))
If NumHDs > 0 Then
For i = 1 To NumHDs
   BanHDs.Add GetVar(App.Path & "\Logs\BanHDs.dat", "BANS", "HD" & i)
Next
End If

NumMothers = val(GetVar(App.Path & "\Logs\BanMothers.dat", "INIT", "Cantidad"))
If NumMothers > 0 Then
For i = 1 To NumMothers
   BanMothers.Add GetVar(App.Path & "\Logs\BanMothers.dat", "BANS", "MOTHER" & i)
Next
End If



NumIps = val(GetVar(App.Path & "\BanIPs.txt", "INIT", "Cantidad"))
If NumIps > 0 Then
For i = 1 To NumIps
   BanIps.Add GetVar(App.Path & "\BanIPs.txt", "BANS", "IP" & i)
Next
End If

If Not FileExist(DatPath & "baneos.dat", vbNormal) Then Exit Sub

BaneosTemporales = val(GetVar(DatPath & "baneos.dat", "INIT", "NumeroBans"))

For i = 1 To BaneosTemporales
    Set tBan = New tBaneo
    With tBan
        .Name = GetVar(DatPath & "baneos.dat", "BANEO" & i, "USER")
        .FechaLiberacion = GetVar(DatPath & "baneos.dat", "BANEO" & i, "FECHA")
        .Causa = GetVar(DatPath & "baneos.dat", "BANEO" & i, "CAUSA")
        .Baneador = GetVar(DatPath & "baneos.dat", "BANEO" & i, "BANEADOR")
        
        Call Baneos.Add(tBan)
    End With
Next

End Sub
Public Sub ChekearNPCs()
Dim Map As Integer
Dim i As Integer
Dim j As Integer
Dim Try As Integer

For Map = 1 To NumMaps
    For i = 1 To UBound(MapInfo(Map).NPCsTeoricos)
        If MapInfo(Map).NPCsTeoricos(i).Numero > 0 And MapInfo(Map).NPCsTeoricos(i).Cantidad > MapInfo(Map).NPCsReales(i).Cantidad Then
            Do Until MapInfo(Map).NPCsTeoricos(i).Cantidad = MapInfo(Map).NPCsReales(i).Cantidad Or Try >= 100
                Call CrearNPC(MapInfo(Map).NPCsTeoricos(i).Numero, Map, Npclist(1).Orig)
                Try = Try + 1
            Loop
            Try = 0
        Else: Exit For
        End If
    Next
Next

End Sub
Public Sub SaveGuildsNew()
On Error GoTo errhandler
Dim j As Integer, file As String, i As Integer

Dim Carpeta As String
Carpeta = App.Path & "\Guilds\"

file = App.Path & "\Guilds\" & "GuildsInfo.inf"

Call WriteVar(file, "INIT", "NroGuilds", str(Guilds.Count))

For i = 1 To Guilds.Count
    Call WriteVar(file, "GUILD" & i, "GuildName", Guilds(i).GuildName)
    Call WriteVar(file, "GUILD" & i, "Founder", Guilds(i).Founder)
    Call WriteVar(file, "GUILD" & i, "Date", Guilds(i).FundationDate)
    Call WriteVar(file, "GUILD" & i, "Desc", Guilds(i).Description)
    Call WriteVar(file, "GUILD" & i, "Codex", Guilds(i).Codex)
    Call WriteVar(file, "GUILD" & i, "Leader", Guilds(i).Leader)
    Call WriteVar(file, "GUILD" & i, "URL", Guilds(i).URL)
    Call WriteVar(file, "GUILD" & i, "GuildExp", str(Guilds(i).GuildExperience))
    Call WriteVar(file, "GUILD" & i, "DaysLast", str(Guilds(i).DaysSinceLastElection))
    Call WriteVar(file, "GUILD" & i, "GuildNews", Guilds(i).GuildNews)
    Call WriteVar(file, "GUILD" & i, "Bando", str(Guilds(i).Bando))

    

    Call WriteVar(file, "GUILD" & i, "NumAliados", Guilds(i).AlliedGuilds.Count)
    
    For j = 1 To Guilds(i).AlliedGuilds.Count
        Call WriteVar(file, "GUILD" & i, "Aliado" & j, Guilds(i).AlliedGuilds(j))
    Next
    
    Call WriteVar(file, "GUILD" & i, "NumEnemigos", Guilds(i).EnemyGuilds.Count)
    
    For j = 1 To Guilds(i).EnemyGuilds.Count
        Call WriteVar(file, "GUILD" & i, "Enemigo" & j, Guilds(i).EnemyGuilds(j))
    Next
    
    
    
    Call WriteVar(file, "GUILD" & i, "NumMiembros", Guilds(i).Members.Count)
    
    For j = 1 To Guilds(i).Members.Count
        Call WriteVar(file, "GUILD" & i, "Miembro" & j, Guilds(i).Members(j))
    Next
    

    
    
    Call WriteVar(file, "GUILD" & i, "NumSolicitudes", Guilds(i).Solicitudes.Count)
    
    For j = 1 To Guilds(i).Solicitudes.Count
      Call WriteVar(file, "GUILD" & i, "Solicitud" & j, Guilds(i).Solicitudes(j).UserName & "¬" & Guilds(i).Solicitudes(j).Desc)
    Next
    
    
    
    Call WriteVar(file, "GUILD" & i, "NumProposiciones", Guilds(i).PeacePropositions.Count)
    
    For j = 1 To Guilds(i).PeacePropositions.Count
        Call WriteVar(file, "GUILD" & i, "Proposicion" & j, Guilds(i).PeacePropositions(j).UserName & "¬" & Guilds(i).PeacePropositions(j).Desc)
    Next

Next
Exit Sub

errhandler:
    Call LogError("Error en SaveGuildsNew: " & Err.Description & "-Clan: " & i & "-" & j)

End Sub

Public Sub DoBackUp(Optional Guilds As Boolean)

'guardamoslostiempos
Call WriteVar(App.Path & "\datas.txt", "TIEMPOS", "deathmatcht", deathtiempo + 0)
Call WriteVar(App.Path & "\datas.txt", "TIEMPOS", "torneo1vs1y2vs2", vs1tiempo + 0)
Call WriteVar(App.Path & "\datas.txt", "TIEMPOS", "eventofaccionario", TheTeamTiempo + 0)
Call WriteVar(App.Path & "\datas.txt", "CASTILLOPUNTOS", "puntosacumulados", HonorA + 0)
Call WriteVar(App.Path & "\datas.txt", "CASTILLOPUNTOS", "MinutosAcumula", MinutosBComando + 0)
Call WriteVar(App.Path & "\datas.txt", "CASTILLOPUNTOS", "MinutosAcumula1", MinutosB + 0)
'tiempos

haciendoBK = True

Call SendData(ToAll, 0, 0, "2P")
Call SendData(ToAll, 0, 0, "BKW")

Call SaveGuildsNew
Call LimpiarMundo

' Call WorldSave
'BETA
'Call ChekearNPCs

Call GuardarUsuarios
Call SaveSoportes

Call SendData(ToAll, 0, 0, "BKW")
Call SendData(ToAll, 0, 0, "3P")

haciendoBK = False

End Sub
Public Sub SaveMapData(ByVal N As Integer)
Dim SaveAs As String
Dim y As Byte
Dim X As Byte
 
SaveAs = App.Path & "\WorldBackUP\Map" & N & ".bkp"
 
If FileExist(SaveAs, vbNormal) Then
    Kill (SaveAs)
End If
 
Open SaveAs For Binary As #1
Seek #1, 1
 
For y = YMinMapSize To YMaxMapSize
    For X = XMinMapSize To XMaxMapSize
    
        If MapData(N, X, y).OBJInfo.OBJIndex Or MapData(N, X, y).NpcIndex Or MapData(N, X, y).TileExit.Map Then
            If ObjData(MapData(N, X, y).OBJInfo.OBJIndex).ObjType = OBJTYPE_FOGATA Then
                MapData(N, X, y).OBJInfo.OBJIndex = 0
                MapData(N, X, y).OBJInfo.Amount = 0
            ElseIf Not ItemEsDeMapa(N, CInt(X), CInt(y)) Or MapData(N, X, y).NpcIndex Or MapData(N, X, y).TileExit.Map Then
                Put #1, , X
                Put #1, , y
                Put #1, , MapData(N, X, y).OBJInfo.OBJIndex
                Put #1, , MapData(N, X, y).OBJInfo.Amount
                Put #1, , MapData(N, X, y).NpcIndex
                Put #1, , MapData(N, X, y).TileExit.Map
                Put #1, , MapData(N, X, y).TileExit.X
                Put #1, , MapData(N, X, y).TileExit.y
            End If
        End If
        
        
    Next
Next
Put #1, , CByte(100)
Close #1

End Sub
Sub LoadArmasHerreria()
Dim N As Integer, lc As Integer

N = val(GetVar(DatPath & "ArmasHerrero.dat", "INIT", "NumArmas"))

ReDim Preserve ArmasHerrero(1 To N) As InfoHerre

For lc = 1 To N
    ArmasHerrero(lc).Index = val(GetVar(DatPath & "ArmasHerrero.dat", "Arma" & lc, "Index"))
    ArmasHerrero(lc).Recompensa = val(GetVar(DatPath & "ArmasHerrero.dat", "Arma" & lc, "Recompensa"))
Next

End Sub
Sub LoadArmadurasHerreria()
Dim N As Integer, lc As Integer

N = val(GetVar(DatPath & "ArmadurasHerrero.dat", "INIT", "NumArmaduras"))

ReDim Preserve ArmadurasHerrero(1 To N) As InfoHerre

For lc = 1 To N
    ArmadurasHerrero(lc).Index = val(GetVar(DatPath & "ArmadurasHerrero.dat", "Armadura" & lc, "Index"))
    ArmadurasHerrero(lc).Recompensa = val(GetVar(DatPath & "ArmadurasHerrero.dat", "Armadura" & lc, "Recompensa"))
Next

End Sub

Sub LoadEscudosHerreria()

Dim N As Integer, lc As Integer

N = val(GetVar(DatPath & "EscudosHerrero.dat", "INIT", "NumEscudos"))

ReDim Preserve EscudosHerrero(1 To N) As Integer

For lc = 1 To N
    EscudosHerrero(lc) = val(GetVar(DatPath & "EscudosHerrero.dat", "Escudo" & lc, "Index"))
Next

End Sub
Sub LoadCascosHerreria()

Dim N As Integer, lc As Integer

N = val(GetVar(DatPath & "CascosHerrero.dat", "INIT", "NumCascos"))

ReDim Preserve CascosHerrero(1 To N) As Integer

For lc = 1 To N
    CascosHerrero(lc) = val(GetVar(DatPath & "CascosHerrero.dat", "Casco" & lc, "Index"))
Next

End Sub
Sub LoadObjCarpintero()
Dim N As Integer, lc As Integer

N = val(GetVar(DatPath & "ObjCarpintero.dat", "INIT", "NumObjs"))

ReDim Preserve ObjCarpintero(1 To N) As InfoHerre

For lc = 1 To N
    ObjCarpintero(lc).Index = val(GetVar(DatPath & "ObjCarpintero.dat", "Obj" & lc, "Index"))
    ObjCarpintero(lc).Recompensa = val(GetVar(DatPath & "ObjCarpintero.dat", "Obj" & lc, "Recompensa"))
Next

End Sub



Sub LoadObjSastre()

Dim N As Integer, lc As Integer

N = val(GetVar(DatPath & "ObjSastre.dat", "INIT", "NumObjs"))

ReDim Preserve ObjSastre(1 To N) As Integer

For lc = 1 To N
    ObjSastre(lc) = val(GetVar(DatPath & "ObjSastre.dat", "Obj" & lc, "Index"))
Next

End Sub
Sub LoadOBJData()



On Error GoTo errhandler
On Error GoTo 0

If frmMain.Visible Then frmMain.txStatus.caption = "Cargando base de datos de los objetos."




Dim Object As Integer

Dim a As Long, S As Long

a = INICarga(DatPath & "Obj.dat")
Call INIConf(a, 0, "", 0)



S = INIBuscarSeccion(a, "INIT")
NumObjDatas = INIDarClaveInt(a, S, "NumOBJs") + 2

frmCargando.cargar.MIN = 0
frmCargando.cargar.MAX = NumObjDatas
frmCargando.cargar.value = 0


ReDim ObjData(0 To NumObjDatas) As ObjData
  

For Object = 1 To NumObjDatas
    
    S = INIBuscarSeccion(a, "OBJ" & Object)

    If S >= 0 Then
        ObjData(Object).Name = INIDarClaveStr(a, S, "Name")
        ObjData(Object).NoComerciable = INIDarClaveInt(a, S, "NoComerciable")
        
        ObjData(Object).GrhIndex = INIDarClaveInt(a, S, "GrhIndex")
        
        ObjData(Object).Jerarquia = INIDarClaveInt(a, S, "Jerarquia")
        ObjData(Object).EsItemValioso = INIDarClaveInt(a, S, "EsItemValioso") = 1
        ObjData(Object).NoSeCae = INIDarClaveInt(a, S, "NoSeCae") = 1
        ObjData(Object).ObjType = INIDarClaveInt(a, S, "ObjType")
        ObjData(Object).ArbolElfico = INIDarClaveInt(a, S, "ArbolElfico")
        ObjData(Object).SubTipo = INIDarClaveInt(a, S, "Subtipo")
        ObjData(Object).Dosmanos = INIDarClaveInt(a, S, "Dosmanos")
        ObjData(Object).Newbie = INIDarClaveInt(a, S, "Newbie")
        ObjData(Object).Aura = INIDarClaveInt(a, S, "Aura") 'dx8
        
        ObjData(Object).SkPociones = INIDarClaveInt(a, S, "SkPociones")
        ObjData(Object).SkSastreria = INIDarClaveInt(a, S, "SkSastreria")
        ObjData(Object).Raices = INIDarClaveInt(a, S, "Raices")
        ObjData(Object).PielLobo = INIDarClaveInt(a, S, "PielLobo")
        ObjData(Object).PielOsoPardo = INIDarClaveInt(a, S, "PielOsoPardo")
        ObjData(Object).PielOsoPolar = INIDarClaveInt(a, S, "PielOsoPolar ")
            
        If ObjData(Object).SubTipo = OBJTYPE_ESCUDO Then
            ObjData(Object).ShieldAnim = INIDarClaveInt(a, S, "Anim")
            ObjData(Object).LingH = INIDarClaveInt(a, S, "LingH")
            ObjData(Object).LingP = INIDarClaveInt(a, S, "LingP")
            ObjData(Object).LingO = INIDarClaveInt(a, S, "LingO")
    
            ObjData(Object).SkHerreria = INIDarClaveInt(a, S, "SkHerreria")
        End If
        
        If ObjData(Object).SubTipo = OBJTYPE_CASCO Then
            ObjData(Object).CascoAnim = INIDarClaveInt(a, S, "Anim")
            ObjData(Object).LingH = INIDarClaveInt(a, S, "LingH")
            ObjData(Object).Gorro = INIDarClaveInt(a, S, "Gorro")
            ObjData(Object).LingP = INIDarClaveInt(a, S, "LingP")
            ObjData(Object).LingO = INIDarClaveInt(a, S, "LingO")
            ObjData(Object).SkHerreria = INIDarClaveInt(a, S, "SkHerreria")
        
        End If
        
        ObjData(Object).Ropaje = INIDarClaveInt(a, S, "NumRopaje")
        ObjData(Object).HechizoIndex = INIDarClaveInt(a, S, "HechizoIndex")
        
        If ObjData(Object).ObjType = OBJTYPE_WEAPON Then
                ObjData(Object).Baculo = INIDarClaveInt(a, S, "Baculo")
                ObjData(Object).WeaponAnim = INIDarClaveInt(a, S, "Anim")
                ObjData(Object).Apuñala = INIDarClaveInt(a, S, "Apuñala")
                ObjData(Object).Envenena = INIDarClaveInt(a, S, "Envenena")
                ObjData(Object).MaxHit = INIDarClaveInt(a, S, "MaxHIT")
                ObjData(Object).MinHit = INIDarClaveInt(a, S, "MinHIT")
                ObjData(Object).LingH = INIDarClaveInt(a, S, "LingH")
                ObjData(Object).LingP = INIDarClaveInt(a, S, "LingP")
                ObjData(Object).LingO = INIDarClaveInt(a, S, "LingO")
                ObjData(Object).SkHerreria = INIDarClaveInt(a, S, "SkHerreria")
                ObjData(Object).Real = INIDarClaveInt(a, S, "Real")
                ObjData(Object).Caos = INIDarClaveInt(a, S, "Caos")
                ObjData(Object).proyectil = INIDarClaveInt(a, S, "Proyectil")
                ObjData(Object).Municion = INIDarClaveInt(a, S, "Municiones")
    
        End If
        
        If ObjData(Object).ObjType = OBJTYPE_ARMOUR Then
                ObjData(Object).LingH = INIDarClaveInt(a, S, "LingH")
                ObjData(Object).LingP = INIDarClaveInt(a, S, "LingP")
                ObjData(Object).LingO = INIDarClaveInt(a, S, "LingO")
                ObjData(Object).SkHerreria = INIDarClaveInt(a, S, "SkHerreria")
                ObjData(Object).Real = INIDarClaveInt(a, S, "Real")
                ObjData(Object).Caos = INIDarClaveInt(a, S, "Caos")
        End If
        
        If ObjData(Object).ObjType = OBJTYPE_HERRAMIENTAS Then
                ObjData(Object).LingH = INIDarClaveInt(a, S, "LingH")
                ObjData(Object).LingP = INIDarClaveInt(a, S, "LingP")
                ObjData(Object).LingO = INIDarClaveInt(a, S, "LingO")
                ObjData(Object).SkHerreria = INIDarClaveInt(a, S, "SkHerreria")
        End If
        
        If ObjData(Object).ObjType = OBJTYPE_INSTRUMENTOS Then
            ObjData(Object).Snd1 = INIDarClaveInt(a, S, "SND1")
            ObjData(Object).Snd2 = INIDarClaveInt(a, S, "SND2")
            ObjData(Object).Snd3 = INIDarClaveInt(a, S, "SND3")
            ObjData(Object).MinInt = INIDarClaveInt(a, S, "MinInt")
        End If
        
        ObjData(Object).LingoteIndex = INIDarClaveInt(a, S, "LingoteIndex")
        
        If ObjData(Object).ObjType = 31 Or ObjData(Object).ObjType = 23 Then
            'ObjData(Object).MinSkill = INIDarClaveInt(a, S, "MinSkill")
            ObjData(Object).MinSkill = 0
        End If
            
        ObjData(Object).MineralIndex = INIDarClaveInt(a, S, "MineralIndex")
        
        ObjData(Object).MaxHP = INIDarClaveInt(a, S, "MaxHP")
        ObjData(Object).MinHP = INIDarClaveInt(a, S, "MinHP")
        
        ObjData(Object).MUJER = INIDarClaveInt(a, S, "Mujer")
        ObjData(Object).HOMBRE = INIDarClaveInt(a, S, "Hombre")
        
        ObjData(Object).SkillCombate = INIDarClaveInt(a, S, "SkCombate")
        ObjData(Object).SkillTacticas = INIDarClaveInt(a, S, "SkTacticas")
        ObjData(Object).SkillProyectiles = INIDarClaveInt(a, S, "SkProyectiles")
        ObjData(Object).SkillApuñalar = INIDarClaveInt(a, S, "SkApuñalar")
        ObjData(Object).SkResistencia = INIDarClaveInt(a, S, "SkResistencia")
        ObjData(Object).SkDefensa = INIDarClaveInt(a, S, "SkEscudos")
        
        ObjData(Object).MinHam = INIDarClaveInt(a, S, "MinHam")
        ObjData(Object).MinSed = INIDarClaveInt(a, S, "MinAgu")
            
        ObjData(Object).MinDef = INIDarClaveInt(a, S, "MINDEF")
        ObjData(Object).MaxDef = INIDarClaveInt(a, S, "MAXDEF")
    
        ObjData(Object).Respawn = INIDarClaveInt(a, S, "ReSpawn")
        
        ObjData(Object).RazaEnana = INIDarClaveInt(a, S, "RazaEnana")
        
        ObjData(Object).Valor = INIDarClaveInt(a, S, "Valor")
        
        ObjData(Object).Crucial = INIDarClaveInt(a, S, "Crucial")
        
        ObjData(Object).Cerrada = INIDarClaveInt(a, S, "abierta")
        
        ObjData(Object).Minlvl = INIDarClaveInt(a, S, "Minlvl")
        
        ObjData(Object).Itemtemplario = INIDarClaveInt(a, S, "templario")
        
        If ObjData(Object).Cerrada = 1 Then
                ObjData(Object).Llave = INIDarClaveInt(a, S, "Llave")
                ObjData(Object).Clave = INIDarClaveInt(a, S, "Clave")
        End If
        
        
        If ObjData(Object).ObjType = OBJTYPE_PUERTAS Or ObjData(Object).ObjType = OBJTYPE_BOTELLAVACIA Or ObjData(Object).ObjType = OBJTYPE_BOTELLALLENA Then
            ObjData(Object).IndexAbierta = INIDarClaveInt(a, S, "IndexAbierta")
            ObjData(Object).IndexCerrada = INIDarClaveInt(a, S, "IndexCerrada")
            ObjData(Object).IndexCerradaLlave = INIDarClaveInt(a, S, "IndexCerradaLlave")
        End If
          If ObjData(Object).ObjType = OBJTYPE_WARP Then
                ObjData(Object).WMapa = INIDarClaveInt(a, S, "WMapa")
                ObjData(Object).WX = INIDarClaveInt(a, S, "WX")
                ObjData(Object).WY = INIDarClaveInt(a, S, "WY")
                ObjData(Object).WI = INIDarClaveInt(a, S, "WI")
        End If
        
        ObjData(Object).Clave = INIDarClaveInt(a, S, "Clave")
        
        ObjData(Object).Texto = INIDarClaveStr(a, S, "Texto")
        ObjData(Object).GrhSecundario = INIDarClaveInt(a, S, "VGrande")
        
        ObjData(Object).Agarrable = INIDarClaveInt(a, S, "Agarrable")
        ObjData(Object).ForoID = INIDarClaveStr(a, S, "ID")
        Dim Num As Integer
        
        Num = INIDarClaveInt(a, S, "NumClases")

        Dim i As Integer
        For i = 1 To Num
            ObjData(Object).ClaseProhibida(i) = INIDarClaveInt(a, S, "CP" & i)
        Next
        
        Num = INIDarClaveInt(a, S, "NumRazas")
         
        Dim d As Integer
        For d = 1 To Num
            ObjData(Object).RazaProhibida(d) = INIDarClaveInt(a, S, "RP" & d)
        Next
                
        ObjData(Object).Resistencia = INIDarClaveInt(a, S, "Resistencia")
        
        
        If ObjData(Object).ObjType = 11 Then
            ObjData(Object).TipoPocion = INIDarClaveInt(a, S, "TipoPocion")
            ObjData(Object).MaxModificador = INIDarClaveInt(a, S, "MaxModificador")
            ObjData(Object).MinModificador = INIDarClaveInt(a, S, "MinModificador")
            ObjData(Object).DuracionEfecto = INIDarClaveInt(a, S, "DuracionEfecto")
        
        End If
    
        ObjData(Object).SkCarpinteria = INIDarClaveInt(a, S, "SkCarpinteria")
        
        If ObjData(Object).SkCarpinteria Then
            ObjData(Object).Madera = INIDarClaveInt(a, S, "Madera")
                    ObjData(Object).MaderaElfica = INIDarClaveInt(a, S, "MaderaElfica")
        End If
        
        If ObjData(Object).ObjType = OBJTYPE_BARCOS Then
                ObjData(Object).MaxHit = INIDarClaveInt(a, S, "MaxHIT")
                ObjData(Object).MinHit = INIDarClaveInt(a, S, "MinHIT")
        End If
        
        If ObjData(Object).ObjType = OBJTYPE_FLECHAS Then
                ObjData(Object).MaxHit = INIDarClaveInt(a, S, "MaxHIT")
                ObjData(Object).MinHit = INIDarClaveInt(a, S, "MinHIT")
        End If
        
        ObjData(Object).MinSta = INIDarClaveInt(a, S, "MinST")
        
        frmCargando.cargar.value = frmCargando.cargar.value + 1
    End If
    
    DoEvents
    
Next

Call INIDescarga(a)
Call ExtraObjs

Exit Sub

errhandler:

Call INIDescarga(a)

Call LogErrorUrgente("Error cargando objetos: " & Err.Number & " : " & Err.Description)

End Sub
Function EnPantalla(wp1 As WorldPos, wp2 As WorldPos, Optional Sumar As Integer) As Boolean

EnPantalla = (wp1.Map = wp2.Map And Abs(wp1.X - wp2.X) < MinXBorder + Sumar And Abs(wp1.y - wp2.y) < MinYBorder + Sumar)

End Function
Function GetVar(file As String, Main As String, Var As String) As String
Dim sSpaces As String
  
sSpaces = Space$(5000)
  
getprivateprofilestring Main, Var, "", sSpaces, Len(sSpaces), file

GetVar = RTrim(sSpaces)
GetVar = Left$(GetVar, Len(GetVar) - 1)

End Function
Public Sub CargarBackUp()
Dim Map As Integer
Dim Load As String
Dim y As Byte
Dim X As Byte
Dim N As Integer
 
For Map = 1 To NumMaps
    Load = App.Path & "\WorldBackUP\Map" & Map & ".bkp"
    
    If FileExist(Load, vbNormal) Then
        Open Load For Binary As #1
            Seek #1, 1
            
            Do
                Get #1, , X
                If X = 100 Then Exit Do
                Get #1, , y
                Get #1, , MapData(Map, X, y).OBJInfo.OBJIndex
                Get #1, , MapData(Map, X, y).OBJInfo.Amount
                Get #1, , MapData(Map, X, y).NpcIndex
                Get #1, , MapData(N, X, y).TileExit.Map
                Get #1, , MapData(N, X, y).TileExit.X
                Get #1, , MapData(N, X, y).TileExit.y
            Loop
        Close #1
    End If
Next
 
End Sub
Sub Congela(Optional ByVal Descongelar As Boolean)

If Descongelar Then
    Call SendData(ToAll, 0, 0, "°¬")
Else: Call SendData(ToAll, 0, 0, "°°")
End If

End Sub
Sub LoadMapDats()
On Error GoTo Error
Dim a As Long, S As Long, i As Integer

a = INICarga(MapDatFile)
Call INIConf(a, 0, "", 0)

S = INIBuscarSeccion(a, "INIT")
NumMaps = INIDarClaveInt(a, S, "NumMaps")

ReDim MapData(1 To NumMaps, XMinMapSize To XMaxMapSize, YMinMapSize To YMaxMapSize) As MapBlock
ReDim MapInfo(1 To NumMaps) As MapInfo

For i = 1 To NumMaps

    S = INIBuscarSeccion(a, "Mapa" & i)
    If S > 0 Then
        MapInfo(i).Name = INIDarClaveStr(a, S, "Name")
        MapInfo(i).Music = INIDarClaveStr(a, S, "MusicNum")
        MapInfo(i).MusicNoMp3 = INIDarClaveStr(a, S, "MusicNumMidi")
        MapInfo(i).EsMapaEspecial = (INIDarClaveInt(a, S, "EsMapaEspecial") = 1)
        
        MapInfo(i).TopPunto = INIDarClaveInt(a, S, "TopPunto")
        MapInfo(i).LeftPunto = INIDarClaveInt(a, S, "LeftPunto")
        
        MapInfo(i).Pk = (INIDarClaveInt(a, S, "Pk") = 0)
        MapInfo(i).NoMagia = (INIDarClaveInt(a, S, "NoMagia") = 1)
        
        MapInfo(i).Terreno = INIDarClaveStr(a, S, "Terreno")
        MapInfo(i).Zona = INIDarClaveStr(a, S, "Zona")

        MapInfo(i).Restringir = (INIDarClaveInt(a, S, "Restringir") = 1)
        MapInfo(i).Nivel = INIDarClaveInt(a, S, "Nivel")
        
        MapInfo(i).BackUp = INIDarClaveInt(a, S, "BackUp")
    End If
Next
Exit Sub

Error:
    Call LogErrorUrgente("Error cargando Info.dat-" & Err.Description & "-" & i)
End Sub
Sub LoadMapDataNew()
On Error GoTo man
Dim Map As Integer
Dim loopc As Integer
Dim X As Integer
Dim y As Integer
Dim DummyInt As Integer
Dim TempInt As Integer
Dim npcfile As String
Dim InfoTile As Byte

If frmMain.Visible Then frmMain.txStatus.caption = "Cargando mapas."

Call LoadMapDats

frmCargando.cargar.MIN = 0
frmCargando.cargar.MAX = NumMaps
frmCargando.cargar.value = 0

For Map = 1 To NumMaps
    DoEvents

    Debug.Print Round(Map / NumMaps * 100, 2) & "%"
    frmCargando.Label1(2).caption = "Cargando mapas... " & Map & "/" & NumMaps
    
    Open MapPath & "Mapa" & Map & ".msv" For Binary As #1
    Seek #1, 1
    
    Get #1, , MapInfo(Map).MapVersion

    For y = YMinMapSize To YMaxMapSize
        For X = XMinMapSize To XMaxMapSize
            
            Get #1, , InfoTile

            MapData(Map, X, y).Blocked = (InfoTile And 1)
            MapData(Map, X, y).Agua = Buleano(InfoTile And 2)
            
            For loopc = 2 To 4
                If (InfoTile And 2 ^ loopc) Then MapData(Map, X, y).trigger = MapData(Map, X, y).trigger Or 2 ^ (loopc - 2)
            Next

            If InfoTile And 32 Then
                Get #1, , MapData(Map, X, y).NpcIndex
                
                MapData(Map, X, y).NpcIndex = OpenNPC(MapData(Map, X, y).NpcIndex)
                
                If MapData(Map, X, y).NpcIndex >= 500 Then
                    npcfile = DatPath & "NPCs-HOSTILES.dat"
                Else: npcfile = DatPath & "NPCs.dat"
                End If

                Dim fl As Byte
        
                If Npclist(MapData(Map, X, y).NpcIndex).flags.RespawnOrigPos Then
                    Npclist(MapData(Map, X, y).NpcIndex).Orig.Map = Map
                    Npclist(MapData(Map, X, y).NpcIndex).Orig.X = X
                    Npclist(MapData(Map, X, y).NpcIndex).Orig.y = y
                End If

                Npclist(MapData(Map, X, y).NpcIndex).POS.Map = Map
                Npclist(MapData(Map, X, y).NpcIndex).POS.X = X
                Npclist(MapData(Map, X, y).NpcIndex).POS.y = y
                
                
                If Npclist(MapData(Map, X, y).NpcIndex).Attackable = 1 And Npclist(MapData(Map, X, y).NpcIndex).flags.Respawn = 0 Then
                    Call AgregarNPCTeorico(Npclist(MapData(Map, X, y).NpcIndex).Numero, Map)
                    Call AgregarNPC(Npclist(MapData(Map, X, y).NpcIndex).Numero, Map)
                End If
                
                Call MakeNPCChar(ToNone, 0, 0, MapData(Map, X, y).NpcIndex, Map, X, y)
            
            End If
            
            If InfoTile And 64 Then
                Get #1, , MapData(Map, X, y).OBJInfo.OBJIndex
                Get #1, , MapData(Map, X, y).OBJInfo.Amount
            End If
            
            If MapData(Map, X, y).OBJInfo.OBJIndex > UBound(ObjData) Then
                MapData(Map, X, y).OBJInfo.OBJIndex = 0
                MapData(Map, X, y).OBJInfo.Amount = 0
            End If
            
            If InfoTile And 128 Then
                Get #1, , MapData(Map, X, y).TileExit.Map
                Get #1, , MapData(Map, X, y).TileExit.X
                Get #1, , MapData(Map, X, y).TileExit.y
            End If
            
        Next
    Next
    
    Close #1
    Close #2
        
    frmCargando.cargar.value = frmCargando.cargar.value + 1

    Dim i As Integer
    
    Dim nfile As Integer
    nfile = FreeFile
   ' If MapInfo(Map).NPCsTeoricos(1).Numero Then
        
        Open App.Path & "\Logs\NPCs.log" For Append Shared As #nfile
        Print #nfile, "[Mapa" & Map & "]"
        Print #nfile, "Name=" & MapInfo(Map).Name
        
        For i = 1 To 20
            If MapInfo(Map).NPCsTeoricos(i).Numero Then
                Print #nfile, "Npc" & i & "=" & MapInfo(Map).NPCsTeoricos(i).Cantidad & " " & NameNpc(MapInfo(Map).NPCsTeoricos(i).Numero)
            Else: Exit For
            End If
        Next
        Print #nfile, ""
        Close #nfile
  '  End If
Next

Exit Sub

man:
    Call LogErrorUrgente("Error durante carga de mapas: " & Map & "-" & X & "-" & y)
    Call LogError(Date & " " & Err.Description & " " & Err.HelpContext & " " & Err.HelpFile & " " & Err.Source)

    
End Sub
Sub LoadSini()
Dim Temporal As Long
Dim Temporal1 As Long
Dim loopc As Integer
Dim i As Integer
Dim j As Integer
Dim k As Integer
Dim L As Integer
Dim H As Integer
Dim M As Integer


If frmMain.Visible Then frmMain.txStatus.caption = "Cargando info de inicio del server."

BootDelBackUp = val(GetVar(IniPath & "Server.ini", "INIT", "IniciarDesdeBackUp"))
Puerto = val(GetVar(IniPath & "Server.ini", "INIT", "StartPort"))
HideMe = val(GetVar(IniPath & "Server.ini", "INIT", "Hide"))
MySql = val(GetVar(IniPath & "Server.ini", "INIT", "MySql"))
AllowMultiLogins = val(GetVar(IniPath & "Server.ini", "INIT", "AllowMultiLogins"))
IdleLimit = val(GetVar(IniPath & "Server.ini", "INIT", "IdleLimit"))

UltimaVersion = GetVar(IniPath & "Server.ini", "INIT", "Version")
AUVersion = GetVar(IniPath & "Server.ini", "INIT", "AUVersion")

IpdelServidor = GetVar(IniPath & "Server.ini", "INIT", "ServerIP")
SeguridadGM = GetVar(IniPath & "Server.ini", "INIT", "SeguridadGM")

PersonajesCreados = GetVar(IniPath & "Server.ini", "INIT", "PersonajesCreados")

PuedeCrearPersonajes = val(GetVar(IniPath & "Server.ini", "INIT", "PuedeCrearPersonajes"))

For i = 1 To UBound(Armaduras, 1)
    For j = 1 To UBound(Armaduras, 2)
        For k = 1 To UBound(Armaduras, 3)
            For L = 1 To UBound(Armaduras, 4)
                Armaduras(i, j, k, L) = val(GetVar(IniPath & "Server.ini", "INIT", "Armadura" & i & j & k & L))
            Next
        Next
    Next
Next

ClientsCommandsQueue = val(GetVar(IniPath & "Server.ini", "INIT", "ClientsCommandsQueue"))


SanaIntervaloSinDescansar = val(GetVar(IniPath & "Server.ini", "INTERVALOS", "SanaIntervaloSinDescansar"))
FrmInterv.txtSanaIntervaloSinDescansar.Text = SanaIntervaloSinDescansar

StaminaIntervaloSinDescansar = val(GetVar(IniPath & "Server.ini", "INTERVALOS", "StaminaIntervaloSinDescansar"))
FrmInterv.txtStaminaIntervaloSinDescansar.Text = StaminaIntervaloSinDescansar

SanaIntervaloDescansar = val(GetVar(IniPath & "Server.ini", "INTERVALOS", "SanaIntervaloDescansar"))
FrmInterv.txtSanaIntervaloDescansar.Text = SanaIntervaloDescansar

StaminaIntervaloDescansar = val(GetVar(IniPath & "Server.ini", "INTERVALOS", "StaminaIntervaloDescansar"))
FrmInterv.txtStaminaIntervaloDescansar.Text = StaminaIntervaloDescansar

IntervaloSed = val(GetVar(IniPath & "Server.ini", "INTERVALOS", "IntervaloSed"))
FrmInterv.txtIntervaloSed.Text = IntervaloSed

IntervaloHambre = val(GetVar(IniPath & "Server.ini", "INTERVALOS", "IntervaloHambre"))
FrmInterv.txtIntervaloHambre.Text = IntervaloHambre

IntervaloVeneno = val(GetVar(IniPath & "Server.ini", "INTERVALOS", "IntervaloVeneno"))
FrmInterv.txtIntervaloVeneno.Text = IntervaloVeneno

IntervaloParalizado = val(GetVar(IniPath & "Server.ini", "INTERVALOS", "IntervaloParalizado"))
FrmInterv.txtIntervaloParalizado.Text = IntervaloParalizado

IntervaloParalizadoUsuario = val(GetVar(IniPath & "Server.ini", "INTERVALOS", "IntervaloParalizadoUsuario"))

IntervaloInvisible = val(GetVar(IniPath & "Server.ini", "INTERVALOS", "IntervaloInvisible"))
FrmInterv.txtIntervaloInvisible.Text = IntervaloInvisible

IntervaloFrio = val(GetVar(IniPath & "Server.ini", "INTERVALOS", "IntervaloFrio"))
FrmInterv.txtIntervaloFrio.Text = IntervaloFrio

IntervaloWavFx = val(GetVar(IniPath & "Server.ini", "INTERVALOS", "IntervaloWAVFX"))
FrmInterv.txtIntervaloWAVFX.Text = IntervaloWavFx

IntervaloInvocacion = val(GetVar(IniPath & "Server.ini", "INTERVALOS", "IntervaloInvocacion"))
FrmInterv.txtInvocacion.Text = IntervaloInvocacion

IntervaloParaConexion = val(GetVar(IniPath & "Server.ini", "INTERVALOS", "IntervaloParaConexion"))
FrmInterv.txtIntervaloParaConexion.Text = IntervaloParaConexion


MaxUsers2 = val(GetVar(IniPath & "Server.ini", "INIT", "MaxUsers2"))

IntervaloUserPuedeCastear = val(GetVar(IniPath & "Server.ini", "INTERVALOS", "IntervaloLanzaHechizo")) / 10
FrmInterv.txtIntervaloLanzaHechizo.Text = IntervaloUserPuedeCastear
IntervaloUserPuedeUsar = val(GetVar(IniPath & "Server.ini", "INTERVALOS", "IntervaloUserPuedeUsar"))

IntervaloFlechasCazadores = val(GetVar(IniPath & "Server.ini", "INTERVALOS", "IntervaloFlechasCazadores")) / 10

IntervaloUserPuedePocion = val(GetVar(IniPath & "Server.ini", "INTERVALOS", "IntervaloUserPuedePocion")) / 100
IntervaloUserPuedePocionC = val(GetVar(IniPath & "Server.ini", "INTERVALOS", "IntervaloUserPuedePocionC")) / 100

IntervaloUserPuedeAtacar = val(GetVar(IniPath & "Server.ini", "INTERVALOS", "IntervaloUserPuedeAtacar")) / 10
FrmInterv.txtPuedeAtacar.Text = IntervaloUserPuedeAtacar

IntervaloPocionesSEGURIDAD = val(GetVar(IniPath & "Server.ini", "INTERVALOS", "IntervaloPocionesSEGURIDAD")) / 10
IntervaloPociones = val(GetVar(IniPath & "Server.ini", "INTERVALOS", "IntervaloPociones")) / 10
IntervaloCaminar = val(GetVar(IniPath & "Server.ini", "INTERVALOS", "IntervaloCaminar")) / 10

IntervaloUserFlechas = val(GetVar(IniPath & "Server.ini", "INTERVALOS", "IntervaloUserFlechas")) / 10
IntervaloUserSH = val(GetVar(IniPath & "Server.ini", "INTERVALOS", "IntervaloUserSH"))

IntervaloUserPuedeGolpeHechi = val(GetVar(IniPath & "Server.ini", "INTERVALOS", "IntervaloUserPuedeGolpeHechi")) / 10
IntervaloUserPuedeHechiGolpe = val(GetVar(IniPath & "Server.ini", "INTERVALOS", "IntervaloUserPuedeHechiGolpe")) / 10

IntervaloCerrarConexion = val(GetVar(IniPath & "Server.ini", "INTERVALOS", "IntervaloCerrarConexion"))


ResPos.Map = val(ReadField(1, GetVar(IniPath & "Server.ini", "INIT", "ResPos"), 45))
ResPos.X = val(ReadField(2, GetVar(IniPath & "Server.ini", "INIT", "ResPos"), 45))
ResPos.y = val(ReadField(3, GetVar(IniPath & "Server.ini", "INIT", "ResPos"), 45))
  
recordusuarios = val(GetVar(IniPath & "Server.ini", "INIT", "Record"))
  

MaxUsers = val(GetVar(IniPath & "Server.ini", "INIT", "MaxUsers"))

ReDim UserList(1 To MaxUsers) As user
ReDim Party(1 To (MaxUsers / 2)) As Party

NIX.Map = GetVar(DatPath & "Ciudades.dat", "NIX", "Mapa")
NIX.X = GetVar(DatPath & "Ciudades.dat", "NIX", "X")
NIX.y = GetVar(DatPath & "Ciudades.dat", "NIX", "Y")

ULLATHORPE.Map = GetVar(DatPath & "Ciudades.dat", "Ullathorpe", "Mapa")
ULLATHORPE.X = GetVar(DatPath & "Ciudades.dat", "Ullathorpe", "X")
ULLATHORPE.y = GetVar(DatPath & "Ciudades.dat", "Ullathorpe", "Y")

BANRDEBILL.Map = GetVar(DatPath & "Ciudades.dat", "Banderbill", "Mapa")
BANRDEBILL.X = GetVar(DatPath & "Ciudades.dat", "Banderbill", "X")
BANRDEBILL.y = GetVar(DatPath & "Ciudades.dat", "Banderbill", "Y")

LINDOS.Map = GetVar(DatPath & "Ciudades.dat", "Lindos", "Mapa")
LINDOS.X = GetVar(DatPath & "Ciudades.dat", "Lindos", "X")
LINDOS.y = GetVar(DatPath & "Ciudades.dat", "Lindos", "Y")

ARGHAL.Map = 98
ARGHAL.X = 40
ARGHAL.y = 50

ReDim Hush(val(GetVar(IniPath & "Server.ini", "Hash", "HashAceptados")))
For loopc = 0 To UBound(Hush)
    Hush(loopc) = GetVar(IniPath & "Server.ini", "Hash", "HashAceptado" & (loopc + 1))
Next

End Sub
Sub WriteVar(file As String, Main As String, Var As String, value As String)

writeprivateprofilestring Main, Var, value, file
    
End Sub
Sub BackUPnPc(NpcIndex As Integer)



Dim NpcNumero As Integer
Dim npcfile As String
Dim loopc As Integer


NpcNumero = Npclist(NpcIndex).Numero

If NpcNumero > 499 Then
    npcfile = DatPath & "bkNPCs-HOSTILES.dat"
Else
    npcfile = DatPath & "bkNPCs.dat"
End If


Call WriteVar(npcfile, "NPC" & NpcNumero, "Name", Npclist(NpcIndex).Name)
Call WriteVar(npcfile, "NPC" & NpcNumero, "Desc", Npclist(NpcIndex).Desc)
Call WriteVar(npcfile, "NPC" & NpcNumero, "Head", val(Npclist(NpcIndex).Char.Head))
Call WriteVar(npcfile, "NPC" & NpcNumero, "Body", val(Npclist(NpcIndex).Char.Body))
Call WriteVar(npcfile, "NPC" & NpcNumero, "Heading", val(Npclist(NpcIndex).Char.Heading))
Call WriteVar(npcfile, "NPC" & NpcNumero, "Movement", val(Npclist(NpcIndex).Movement))
Call WriteVar(npcfile, "NPC" & NpcNumero, "Attackable", val(Npclist(NpcIndex).Attackable))
Call WriteVar(npcfile, "NPC" & NpcNumero, "Comercia", val(Npclist(NpcIndex).Comercia))
Call WriteVar(npcfile, "NPC" & NpcNumero, "TipoItems", val(Npclist(NpcIndex).TipoItems))
Call WriteVar(npcfile, "NPC" & NpcNumero, "Hostil", val(Npclist(NpcIndex).Hostile))
Call WriteVar(npcfile, "NPC" & NpcNumero, "GiveEXP", val(Npclist(NpcIndex).GiveEXP))
Call WriteVar(npcfile, "NPC" & NpcNumero, "GiveGLD", val(Npclist(NpcIndex).GiveGLD))
Call WriteVar(npcfile, "NPC" & NpcNumero, "VeInvis", val(Npclist(NpcIndex).VeInvis))
Call WriteVar(npcfile, "NPC" & NpcNumero, "Pocaparalisis", val(Npclist(NpcIndex).flags.PocaParalisis))

Call WriteVar(npcfile, "NPC" & NpcNumero, "Hostil", val(Npclist(NpcIndex).Hostile))
Call WriteVar(npcfile, "NPC" & NpcNumero, "Inflacion", val(Npclist(NpcIndex).Inflacion))
Call WriteVar(npcfile, "NPC" & NpcNumero, "InvReSpawn", val(Npclist(NpcIndex).InvReSpawn))
Call WriteVar(npcfile, "NPC" & NpcNumero, "NpcType", val(Npclist(NpcIndex).NPCtype))


Call WriteVar(npcfile, "NPC" & NpcNumero, "Alineacion", val(Npclist(NpcIndex).Stats.Alineacion))
Call WriteVar(npcfile, "NPC" & NpcNumero, "DEF", val(Npclist(NpcIndex).Stats.Def))
Call WriteVar(npcfile, "NPC" & NpcNumero, "MaxHit", val(Npclist(NpcIndex).Stats.MaxHit))
Call WriteVar(npcfile, "NPC" & NpcNumero, "MaxHp", val(Npclist(NpcIndex).Stats.MaxHP))
Call WriteVar(npcfile, "NPC" & NpcNumero, "MinHit", val(Npclist(NpcIndex).Stats.MinHit))
Call WriteVar(npcfile, "NPC" & NpcNumero, "MinHp", val(Npclist(NpcIndex).Stats.MinHP))


Call WriteVar(npcfile, "NPC" & NpcNumero, "ReSpawn", val(Npclist(NpcIndex).flags.Respawn))
Call WriteVar(npcfile, "NPC" & NpcNumero, "Domable", val(Npclist(NpcIndex).flags.Domable))


Call WriteVar(npcfile, "NPC" & NpcNumero, "NroItems", val(Npclist(NpcIndex).Invent.NroItems))
If Npclist(NpcIndex).Invent.NroItems Then
   For loopc = 1 To MAX_NPCINVENTORY_SLOTS
        Call WriteVar(npcfile, "NPC" & NpcNumero, "Obj" & loopc, Npclist(NpcIndex).Invent.Object(loopc).OBJIndex & "-" & Npclist(NpcIndex).Invent.Object(loopc).Amount)
   Next
End If

End Sub
Sub CargarNpcBackUp(NpcIndex As Integer, NPCNumber As Integer)
Dim npcfile As String

If frmMain.Visible Then frmMain.txStatus.caption = "Cargando backup Npc"

If NPCNumber >= 500 Then
    npcfile = DatPath & "bkNPCs-HOSTILES.dat"
Else: npcfile = DatPath & "bkNPCs.dat"
End If

Npclist(NpcIndex).Numero = NPCNumber
Npclist(NpcIndex).Name = GetVar(npcfile, "NPC" & NPCNumber, "Name")
Npclist(NpcIndex).Desc = GetVar(npcfile, "NPC" & NPCNumber, "Desc")
Npclist(NpcIndex).Movement = val(GetVar(npcfile, "NPC" & NPCNumber, "Movement"))
Npclist(NpcIndex).NPCtype = val(GetVar(npcfile, "NPC" & NPCNumber, "NpcType"))

Npclist(NpcIndex).Char.Body = val(GetVar(npcfile, "NPC" & NPCNumber, "Body"))
Npclist(NpcIndex).Char.Head = val(GetVar(npcfile, "NPC" & NPCNumber, "Head"))
Npclist(NpcIndex).Char.Heading = val(GetVar(npcfile, "NPC" & NPCNumber, "Heading"))

Npclist(NpcIndex).Attackable = val(GetVar(npcfile, "NPC" & NPCNumber, "Attackable"))
Npclist(NpcIndex).Comercia = val(GetVar(npcfile, "NPC" & NPCNumber, "Comercia"))
Npclist(NpcIndex).Hostile = val(GetVar(npcfile, "NPC" & NPCNumber, "Hostile"))
Npclist(NpcIndex).GiveEXP = val(GetVar(npcfile, "NPC" & NPCNumber, "GiveEXP")) * 30
Npclist(NpcIndex).VeInvis = val(GetVar(npcfile, "NPC" & NPCNumber, "VeInvis"))
Npclist(NpcIndex).flags.PocaParalisis = val(GetVar(npcfile, "NPC" & NPCNumber, "pocaparalisis"))
Npclist(NpcIndex).flags.Apostador = val(GetVar(npcfile, "NPC" & NPCNumber, "Apostador"))

Npclist(NpcIndex).GiveGLD = val(GetVar(npcfile, "NPC" & NPCNumber, "GiveGLD")) * 30

Npclist(NpcIndex).InvReSpawn = val(GetVar(npcfile, "NPC" & NPCNumber, "InvReSpawn"))

Npclist(NpcIndex).Stats.MaxHP = val(GetVar(npcfile, "NPC" & NPCNumber, "MaxHP"))
Npclist(NpcIndex).Stats.MinHP = val(GetVar(npcfile, "NPC" & NPCNumber, "MinHP"))
Npclist(NpcIndex).AutoCurar = val(GetVar(npcfile, "NPC" & NPCNumber, "autocurar"))

Npclist(NpcIndex).Stats.MaxHit = val(GetVar(npcfile, "NPC" & NPCNumber, "MaxHIT"))
Npclist(NpcIndex).Stats.MinHit = val(GetVar(npcfile, "NPC" & NPCNumber, "MinHIT"))
Npclist(NpcIndex).Stats.Def = val(GetVar(npcfile, "NPC" & NPCNumber, "DEF"))
Npclist(NpcIndex).Stats.Alineacion = val(GetVar(npcfile, "NPC" & NPCNumber, "Alineacion"))
Npclist(NpcIndex).Stats.ImpactRate = val(GetVar(npcfile, "NPC" & NPCNumber, "ImpactRate"))


Dim loopc As Integer
Dim ln As String
Npclist(NpcIndex).Invent.NroItems = val(GetVar(npcfile, "NPC" & NPCNumber, "NROITEMS"))
If Npclist(NpcIndex).Invent.NroItems Then
    For loopc = 1 To MAX_NPCINVENTORY_SLOTS
        ln = GetVar(npcfile, "NPC" & NPCNumber, "Obj" & loopc)
        Npclist(NpcIndex).Invent.Object(loopc).OBJIndex = val(ReadField(1, ln, 45))
        Npclist(NpcIndex).Invent.Object(loopc).Amount = val(ReadField(2, ln, 45))
    Next
Else
    For loopc = 1 To MAX_NPCINVENTORY_SLOTS
        Npclist(NpcIndex).Invent.Object(loopc).OBJIndex = 0
        Npclist(NpcIndex).Invent.Object(loopc).Amount = 0
    Next
End If

Npclist(NpcIndex).Inflacion = val(GetVar(npcfile, "NPC" & NPCNumber, "Inflacion"))


Npclist(NpcIndex).flags.NPCActive = True
Npclist(NpcIndex).flags.UseAINow = False
Npclist(NpcIndex).flags.Respawn = val(GetVar(npcfile, "NPC" & NPCNumber, "ReSpawn"))
Npclist(NpcIndex).flags.Domable = val(GetVar(npcfile, "NPC" & NPCNumber, "Domable"))
Npclist(NpcIndex).flags.RespawnOrigPos = val(GetVar(npcfile, "NPC" & NPCNumber, "OrigPos"))


Npclist(NpcIndex).TipoItems = val(GetVar(npcfile, "NPC" & NPCNumber, "TipoItems"))

End Sub
Sub LogBan(ByVal BannedIndex As Integer, Userindex As Integer, ByVal Motivo As String)

Call WriteVar(App.Path & "\logs\" & "BanDetail.dat", UserList(BannedIndex).Name, "BannedBy", UserList(Userindex).Name)
Call WriteVar(App.Path & "\logs\" & "BanDetail.dat", UserList(BannedIndex).Name, "Reason", Motivo)
Call WriteVar(App.Path & "\logs\" & "BanDetail.dat", UserList(BannedIndex).Name, "IP", UserList(BannedIndex).ip)
Call WriteVar(App.Path & "\logs\" & "BanDetail.dat", UserList(BannedIndex).Name, "Codigo", UserList(BannedIndex).Email)
Call WriteVar(App.Path & "\logs\" & "BanDetail.dat", UserList(BannedIndex).Name, "Fecha", Format(Now, "dd/mm/yy hh:mm:ss"))

Dim mifile As Integer
mifile = FreeFile
Open App.Path & "\logs\GenteBanned.log" For Append Shared As #mifile
Print #mifile, UserList(BannedIndex).Name
Close #mifile

End Sub
Sub LogBanOffline(ByVal BannedIndex As String, Userindex As Integer, ByVal Motivo As String, ip As String)

Call WriteVar(App.Path & "\logs\" & "BanDetail.dat", BannedIndex, "BannedBy", UserList(Userindex).Name)
Call WriteVar(App.Path & "\logs\" & "BanDetail.dat", BannedIndex, "Reason", Motivo)
Call WriteVar(App.Path & "\logs\" & "BanDetail.dat", BannedIndex, "IP", ip)

Dim mifile As Integer
mifile = FreeFile
Open App.Path & "\logs\GenteBanned.log" For Append Shared As #mifile
Print #mifile, BannedIndex
Close #mifile

End Sub

Function Criminal()
 
 
End Function


