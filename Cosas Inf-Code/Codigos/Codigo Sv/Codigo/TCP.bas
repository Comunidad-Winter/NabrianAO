Attribute VB_Name = "TCP"
 
'director del proyecto: #Esteban(Neliam)

'servidor basado en fénixao 1.0
'medios de contacto:
'Skype: dc.esteban
'E-mail: nabrianao@gmail.com
Option Explicit
Public usercorreo As String

Public Const SOCKET_BUFFER_SIZE = 3072
Public Enpausa As Boolean

Public Const COMMAND_BUFFER_SIZE = 1000
Public entorneo As Byte
Public entorneop As Byte
Public entorneopp As Byte
Public entorneoppp As Byte

Public Const NingunArma = 2
Dim Response As String
Dim Start As Single, Tmr As Single

Public Const ToIndex = 0
Public Const ToAll = 1
Public Const ToMap = 2
Public Const ToPCArea = 3
Public Const ToNone = 4
Public Const ToAllButIndex = 5
Public Const ToMapButIndex = 6
Public Const ToGM = 7
Public Const ToNPCArea = 8
Public Const ToGuildMembers = 9
Public Const ToAdmins = 10
Public Const ToPCAreaButIndex = 11
Public Const ToMuertos = 12
Public Const ToPCAreaVivos = 13
Public Const ToNPCAreaG = 14
Public Const ToPCAreaButIndexG = 15
Public Const ToGMArea = 16
Public Const ToPCAreaG = 17
Public Const ToAlianza = 18
Public Const ToCaos = 19
Public Const ToParty = 20
Public Const ToMoreAdmins = 21
Public Const ToConse = 22
Public Const ToConci = 23
Public Const ToNeutral = 24
Public Const ToCasTLE = 25

#If UsarQueSocket = 0 Then
Public Const INVALID_HANDLE = -1
Public Const CONTROL_ERRIGNORE = 0
Public Const CONTROL_ERRDISPLAY = 1



Public Const SOCKET_OPEN = 1
Public Const SOCKET_CONNECT = 2
Public Const SOCKET_LISTEN = 3
Public Const SOCKET_ACCEPT = 4
Public Const SOCKET_CANCEL = 5
Public Const SOCKET_FLUSH = 6
Public Const SOCKET_CLOSE = 7
Public Const SOCKET_MACNNECT = 7
Public Const SOCKET_ABORT = 8


Public Const SOCKET_NONE = 0
Public Const SOCKET_IDLE = 1
Public Const SOCKET_LISTENING = 2
Public Const SOCKET_CONNECTING = 3
Public Const SOCKET_ACCEPTING = 4
Public Const SOCKET_RECEIVING = 5
Public Const SOCKET_SENDING = 6
Public Const SOCKET_CLOSING = 7


Public Const AF_UNSPEC = 0
Public Const AF_UNIX = 1
Public Const AF_INET = 2


Public Const SOCK_STREAM = 1
Public Const SOCK_DGRAM = 2
Public Const SOCK_RAW = 3
Public Const SOCK_RDM = 4
Public Const SOCK_SEQPACKET = 5


Public Const IPPROTO_IP = 0
Public Const IPPROTO_ICMP = 1
Public Const IPPROTO_GGP = 2
Public Const IPPROTO_TCP = 6
Public Const IPPROTO_PUP = 12
Public Const IPPROTO_UDP = 17
Public Const IPPROTO_IDP = 22
Public Const IPPROTO_ND = 77
Public Const IPPROTO_RAW = 255
Public Const IPPROTO_MAX = 256



Public Const INADDR_ANY = "0.0.0.0"
Public Const INADDR_LOOPBACK = "127.0.0.1"
Public Const INADDR_NONE = "255.055.255.255"


Public Const SOCKET_READ = 0
Public Const SOCKET_WRITE = 1
Public Const SOCKET_READWRITE = 2


Public Const SOCKET_ERRIGNORE = 0
Public Const SOCKET_ERRDISPLAY = 1


Public Const WSABASEERR = 24000
Public Const WSAEINTR = 24004
Public Const WSAEBADF = 24009
Public Const WSAEACCES = 24013
Public Const WSAEFAULT = 24014
Public Const WSAEINVAL = 24022
Public Const WSAEMFILE = 24024
Public Const WSAEWOULDBLOCK = 24035
Public Const WSAEINPROGRESS = 24036
Public Const WSAEALREADY = 24037
Public Const WSAENOTSOCK = 24038
Public Const WSAEDESTADDRREQ = 24039
Public Const WSAEMSGSIZE = 24040
Public Const WSAEPROTOTYPE = 24041
Public Const WSAENOPROTOOPT = 24042
Public Const WSAEPROTONOSUPPORT = 24043
Public Const WSAESOCKTNOSUPPORT = 24044
Public Const WSAEOPNOTSUPP = 24045
Public Const WSAEPFNOSUPPORT = 24046
Public Const WSAEAFNOSUPPORT = 24047
Public Const WSAEADDRINUSE = 24048
Public Const WSAEADDRNOTAVAIL = 24049
Public Const WSAENETDOWN = 24050
Public Const WSAENETUNREACH = 24051
Public Const WSAENETRESET = 24052
Public Const WSAECONNABORTED = 24053
Public Const WSAECONNRESET = 24054
Public Const WSAENOBUFS = 24055
Public Const WSAEISCONN = 24056
Public Const WSAENOTCONN = 24057
Public Const WSAESHUTDOWN = 24058
Public Const WSAETOOMANYREFS = 24059
Public Const WSAETIMEDOUT = 24060
Public Const WSAECONNREFUSED = 24061
Public Const WSAELOOP = 24062
Public Const WSAENAMETOOLONG = 24063
Public Const WSAEHOSTDOWN = 24064
Public Const WSAEHOSTUNREACH = 24065
Public Const WSAENOTEMPTY = 24066
Public Const WSAEPROCLIM = 24067
Public Const WSAEUSERS = 24068
Public Const WSAEDQUOT = 24069
Public Const WSAESTALE = 24070
Public Const WSAEREMOTE = 24071
Public Const WSASYSNOTREADY = 24091
Public Const WSAVERNOTSUPPORTED = 24092
Public Const WSANOTINITIALISED = 24093
Public Const WSAHOST_NOT_FOUND = 25001
Public Const WSATRY_AGAIN = 25002
Public Const WSANO_RECOVERY = 25003
Public Const WSANO_DATA = 25004
Public Const WSANO_ADDRESS = 2500
#End If

Public Data(1 To 3, 1 To 2, 1 To 2, 1 To 2) As Double
Public Onlines(1 To 3) As Long

Public Const minuto = 1
Public Const hora = 2
Public Const dia = 3

Public Const actual = 1
Public Const Last = 2

Public Const Enviada = 1
Public Const Recibida = 2

Public Const Mensages = 1
Public Const Letras = 2

Sub DarCuerpoYCabeza(UserBody As Integer, UserHead As Integer, Raza As Byte, Gen As Byte)

Select Case Gen
   Case HOMBRE
        Select Case Raza
        
                Case HUMANO
                    UserHead = CInt(RandomNumber(1, 24))
                    If UserHead > 24 Then UserHead = 24
                    UserBody = 1
                Case ELFO
                    UserHead = CInt(RandomNumber(1, 7)) + 100
                    If UserHead > 107 Then UserHead = 107
                    UserBody = 2
                Case ELFO_OSCURO
                    UserHead = CInt(RandomNumber(1, 4)) + 200
                    If UserHead > 204 Then UserHead = 204
                    UserBody = 3
                Case ENANO
                    UserHead = RandomNumber(1, 4) + 300
                    If UserHead > 304 Then UserHead = 304
                    UserBody = 52
                Case GNOMO
                    UserHead = RandomNumber(1, 3) + 400
                    If UserHead > 403 Then UserHead = 403
                    UserBody = 52
                Case Else
                    UserHead = 1
                    UserBody = 1
            
        End Select
   Case MUJER
        Select Case Raza
                Case HUMANO
                    UserHead = CInt(RandomNumber(1, 4)) + 69
                    If UserHead > 73 Then UserHead = 73
                    UserBody = 1
                Case ELFO
                    UserHead = CInt(RandomNumber(1, 5)) + 169
                    If UserHead > 174 Then UserHead = 174
                    UserBody = 2
                Case ELFO_OSCURO
                    UserHead = CInt(RandomNumber(1, 5)) + 269
                    If UserHead > 274 Then UserHead = 274
                    UserBody = 3
                Case GNOMO
                    UserHead = RandomNumber(1, 4) + 469
                    If UserHead > 473 Then UserHead = 473
                    UserBody = 52
                Case ENANO
                    UserHead = RandomNumber(1, 3) + 369
                    If UserHead > 372 Then UserHead = 372
                    UserBody = 52
                Case Else
                    UserHead = 70
                    UserBody = 1
        End Select
End Select

   
End Sub
Function AsciiValidos(ByVal cad As String) As Boolean
Dim car As Byte
Dim i As Integer

cad = LCase$(cad)

For i = 1 To Len(cad)
    car = Asc(Mid$(cad, i, 1))
    If (car < 97 Or car > 122) And (car <> 255) And (car <> 32) Then
        AsciiValidos = False
        Exit Function
    End If
Next

AsciiValidos = True

End Function

Function Numeric(ByVal cad As String) As Boolean
Dim car As Byte
Dim i As Integer

cad = LCase$(cad)

For i = 1 To Len(cad)
    car = Asc(Mid$(cad, i, 1))
    
    If (car < 48 Or car > 57) Then
        Numeric = False
        Exit Function
    End If
    
Next

Numeric = True

End Function
Function NombrePermitido(ByVal Nombre As String) As Boolean
Dim i As Integer

For i = 1 To UBound(ForbidenNames)
    If InStr(Nombre, ForbidenNames(i)) Then
        NombrePermitido = False
        Exit Function
    End If
Next

NombrePermitido = True

End Function

Function ValidateAtrib(Userindex As Integer) As Boolean
Dim loopc As Integer

For loopc = 1 To NUMATRIBUTOS
    If UserList(Userindex).Stats.UserAtributosBackUP(loopc) > 23 Or UserList(Userindex).Stats.UserAtributosBackUP(loopc) < 1 Then Exit Function
Next

ValidateAtrib = True

End Function

Function ValidateAtrib2(Userindex As Integer) As Boolean
Dim loopc As Integer

For loopc = 1 To NUMATRIBUTOS
    If UserList(Userindex).Stats.UserAtributosBackUP(loopc) > 18 Or UserList(Userindex).Stats.UserAtributosBackUP(loopc) < 1 Then
    ValidateAtrib2 = False
    Exit Function
    End If
Next

ValidateAtrib2 = True

End Function
Function ValidateSkills(Userindex As Integer) As Boolean
Dim loopc As Integer

For loopc = 1 To NUMSKILLS
    If UserList(Userindex).Stats.UserSkills(loopc) < 0 Then Exit Function
    If UserList(Userindex).Stats.UserSkills(loopc) > 100 Then UserList(Userindex).Stats.UserSkills(loopc) = 100
Next

ValidateSkills = True

End Function
Sub ConnectNewUser(Userindex As Integer, Name As String, PassWord As String, _
Body As Integer, Head As Integer, UserRaza As Byte, UserSexo As Byte, _
UA1 As String, UA2 As String, UA3 As String, UA4 As String, UA5 As String, _
US1 As String, US2 As String, US3 As String, US4 As String, US5 As String, _
US6 As String, US7 As String, US8 As String, US9 As String, US10 As String, _
US11 As String, US12 As String, US13 As String, US14 As String, US15 As String, _
US16 As String, US17 As String, US18 As String, US19 As String, US20 As String, _
US21 As String, US22 As String, UserEMail As String, Hogar As Byte, Mac As String, HDDisck As String, MotherNumber As String)

Dim i As Integer

If Restringido Then
    Call SendData(ToIndex, Userindex, 0, "ERREl servidor está restringido solo para GameMasters temporalmente.")
    Exit Sub
End If

If Len(Name) > 15 Then
                Call SendData(ToIndex, Userindex, 0, "ERREl nombre de usuario no puede tener más de 15 cáracteres.")
            Exit Sub
End If

If Not NombrePermitido(Name) Then
    Call SendData(ToIndex, Userindex, 0, "ERRLos nombres de los personajes deben pertencer a la fantasia, el nombre indicado es invalido.")
    Call SendData(ToIndex, Userindex, 0, "V8V" & 2)
    Exit Sub
End If

If Not AsciiValidos(Name) Then
    Call SendData(ToIndex, Userindex, 0, "ERRNombre invalido.")
    Call SendData(ToIndex, Userindex, 0, "V8V" & 2)
    Exit Sub
End If

Dim loopc As Integer
Dim totalskpts As Long
  

If FileExist(CharPath & UCase$(Name) & ".chr", vbNormal) = True Then
    Call SendData(ToIndex, Userindex, 0, "ERRYa existe el personaje.")
    Exit Sub
End If

UserList(Userindex).flags.Muerto = 0
UserList(Userindex).flags.Escondido = 0

UserList(Userindex).Name = Name
UserList(Userindex).Clase = CIUDADANO
UserList(Userindex).Raza = UserRaza
UserList(Userindex).Genero = UserSexo
UserList(Userindex).Email = UserEMail
UserList(Userindex).Hogar = Hogar

Select Case UserList(Userindex).Raza
    Case HUMANO
        UserList(Userindex).Stats.UserAtributosBackUP(fuerza) = UserList(Userindex).Stats.UserAtributosBackUP(fuerza) + 1
        UserList(Userindex).Stats.UserAtributosBackUP(Agilidad) = UserList(Userindex).Stats.UserAtributosBackUP(Agilidad) + 1
        UserList(Userindex).Stats.UserAtributosBackUP(Constitucion) = UserList(Userindex).Stats.UserAtributosBackUP(Constitucion) + 2
    Case ELFO
        UserList(Userindex).Stats.UserAtributosBackUP(Agilidad) = UserList(Userindex).Stats.UserAtributosBackUP(Agilidad) + 3
        UserList(Userindex).Stats.UserAtributosBackUP(Constitucion) = UserList(Userindex).Stats.UserAtributosBackUP(Constitucion) + 1
        UserList(Userindex).Stats.UserAtributosBackUP(Inteligencia) = UserList(Userindex).Stats.UserAtributosBackUP(Inteligencia) + 1
        UserList(Userindex).Stats.UserAtributosBackUP(Carisma) = UserList(Userindex).Stats.UserAtributosBackUP(Carisma) + 2
    Case ELFO_OSCURO
        UserList(Userindex).Stats.UserAtributosBackUP(fuerza) = UserList(Userindex).Stats.UserAtributosBackUP(fuerza) + 1
        UserList(Userindex).Stats.UserAtributosBackUP(Agilidad) = UserList(Userindex).Stats.UserAtributosBackUP(Agilidad) + 1
        UserList(Userindex).Stats.UserAtributosBackUP(Carisma) = UserList(Userindex).Stats.UserAtributosBackUP(Carisma) - 3
        UserList(Userindex).Stats.UserAtributosBackUP(Inteligencia) = UserList(Userindex).Stats.UserAtributosBackUP(Inteligencia) + 2
    Case ENANO
        UserList(Userindex).Stats.UserAtributosBackUP(fuerza) = UserList(Userindex).Stats.UserAtributosBackUP(fuerza) + 3
        UserList(Userindex).Stats.UserAtributosBackUP(Agilidad) = UserList(Userindex).Stats.UserAtributosBackUP(Agilidad) - 1
        UserList(Userindex).Stats.UserAtributosBackUP(Constitucion) = UserList(Userindex).Stats.UserAtributosBackUP(Constitucion) + 3
        UserList(Userindex).Stats.UserAtributosBackUP(Inteligencia) = UserList(Userindex).Stats.UserAtributosBackUP(Inteligencia) - 6
        UserList(Userindex).Stats.UserAtributosBackUP(Carisma) = UserList(Userindex).Stats.UserAtributosBackUP(Carisma) - 3
    Case GNOMO
        UserList(Userindex).Stats.UserAtributosBackUP(fuerza) = UserList(Userindex).Stats.UserAtributosBackUP(fuerza) - 5
        UserList(Userindex).Stats.UserAtributosBackUP(Agilidad) = UserList(Userindex).Stats.UserAtributosBackUP(Agilidad) + 4
        UserList(Userindex).Stats.UserAtributosBackUP(Inteligencia) = UserList(Userindex).Stats.UserAtributosBackUP(Inteligencia) + 3
        UserList(Userindex).Stats.UserAtributosBackUP(Carisma) = UserList(Userindex).Stats.UserAtributosBackUP(Carisma) + 1
End Select

If Not ValidateAtrib(Userindex) Then
    Call SendData(ToIndex, Userindex, 0, "ERRAtributos invalidos.")
    Call SendData(ToIndex, Userindex, 0, "V8V" & 2)
    Exit Sub
End If

UserList(Userindex).Stats.UserSkills(1) = val(US1)
UserList(Userindex).Stats.UserSkills(2) = val(US2)
UserList(Userindex).Stats.UserSkills(3) = val(US3)
UserList(Userindex).Stats.UserSkills(4) = val(US4)
UserList(Userindex).Stats.UserSkills(5) = val(US5)
UserList(Userindex).Stats.UserSkills(6) = val(US6)
UserList(Userindex).Stats.UserSkills(7) = val(US7)
UserList(Userindex).Stats.UserSkills(8) = val(US8)
UserList(Userindex).Stats.UserSkills(9) = val(US9)
UserList(Userindex).Stats.UserSkills(10) = val(US10)
UserList(Userindex).Stats.UserSkills(11) = val(US11)
UserList(Userindex).Stats.UserSkills(12) = val(US12)
UserList(Userindex).Stats.UserSkills(13) = val(US13)
UserList(Userindex).Stats.UserSkills(14) = val(US14)
UserList(Userindex).Stats.UserSkills(15) = val(US15)
UserList(Userindex).Stats.UserSkills(16) = val(US16)
UserList(Userindex).Stats.UserSkills(17) = val(US17)
UserList(Userindex).Stats.UserSkills(18) = val(US18)
UserList(Userindex).Stats.UserSkills(19) = val(US19)
UserList(Userindex).Stats.UserSkills(20) = val(US20)
UserList(Userindex).Stats.UserSkills(21) = val(US21)
UserList(Userindex).Stats.UserSkills(22) = val(US22)

totalskpts = 0


For loopc = 1 To NUMSKILLS
    totalskpts = totalskpts + Abs(UserList(Userindex).Stats.UserSkills(loopc))
Next

miuseremail = UserEMail
If totalskpts > 10 Then
    Call LogHackAttemp(UserList(Userindex).Name & " intento hackear los skills.")
  
    Call CloseSocket(Userindex)
    Exit Sub
End If


UserList(Userindex).PassWord = PassWord

UserList(Userindex).Char.Heading = SOUTH

Call DarCuerpoYCabeza(UserList(Userindex).Char.Body, UserList(Userindex).Char.Head, UserList(Userindex).Raza, UserList(Userindex).Genero)
UserList(Userindex).OrigChar = UserList(Userindex).Char
   
UserList(Userindex).Char.WeaponAnim = NingunArma
UserList(Userindex).Char.ShieldAnim = NingunEscudo
UserList(Userindex).Char.CascoAnim = NingunCasco

UserList(Userindex).Stats.MET = 1
Dim MiInt
MiInt = RandomNumber(1, UserList(Userindex).Stats.UserAtributosBackUP(Constitucion) \ 3)

UserList(Userindex).Stats.MaxHP = 15 + MiInt
UserList(Userindex).Stats.MinHP = 15 + MiInt

UserList(Userindex).Stats.FIT = 1


MiInt = RandomNumber(1, UserList(Userindex).Stats.UserAtributosBackUP(Agilidad) \ 6)
If MiInt = 1 Then MiInt = 2

UserList(Userindex).Stats.MaxSta = 20 * MiInt
UserList(Userindex).Stats.MinSta = 20 * MiInt

UserList(Userindex).Stats.MaxAGU = 100
UserList(Userindex).Stats.MinAGU = 100

UserList(Userindex).Stats.MaxHam = 100
UserList(Userindex).Stats.MinHam = 100




UserList(Userindex).Stats.MaxMAN = 0
UserList(Userindex).Stats.MinMAN = 0


UserList(Userindex).Stats.MaxHit = 2
UserList(Userindex).Stats.MinHit = 1

UserList(Userindex).Stats.GLD = 0




UserList(Userindex).Stats.Exp = 0
UserList(Userindex).Stats.ELU = ELUs(1)
UserList(Userindex).Stats.ELV = 1



UserList(Userindex).Invent.NroItems = 5

UserList(Userindex).Invent.Object(1).OBJIndex = ManzanaNewbie
UserList(Userindex).Invent.Object(1).Amount = 100

UserList(Userindex).Invent.Object(2).OBJIndex = AguaNewbie
UserList(Userindex).Invent.Object(2).Amount = 100

UserList(Userindex).Invent.Object(3).OBJIndex = DagaNewbie
UserList(Userindex).Invent.Object(3).Amount = 1
UserList(Userindex).Invent.Object(3).Equipped = 1

Select Case UserList(Userindex).Raza
    Case HUMANO
        UserList(Userindex).Invent.Object(4).OBJIndex = 490
    Case ELFO
        UserList(Userindex).Invent.Object(4).OBJIndex = 490
    Case ELFO_OSCURO
        UserList(Userindex).Invent.Object(4).OBJIndex = 490
    Case Else
        UserList(Userindex).Invent.Object(4).OBJIndex = 486
End Select

UserList(Userindex).Invent.Object(4).Amount = 1
UserList(Userindex).Invent.Object(4).Equipped = 1

UserList(Userindex).Invent.Object(5).OBJIndex = PocionRojaNewbie
UserList(Userindex).Invent.Object(5).Amount = 150

UserList(Userindex).Invent.ArmourEqpSlot = 4
UserList(Userindex).Invent.ArmourEqpObjIndex = UserList(Userindex).Invent.Object(4).OBJIndex

UserList(Userindex).Invent.WeaponEqpObjIndex = UserList(Userindex).Invent.Object(3).OBJIndex
UserList(Userindex).Invent.WeaponEqpSlot = 3

Call SaveUser(Userindex, CharPath & UCase$(Name) & ".chr")
Call ConnectUser(Userindex, Name, PassWord, Mac, HDDisck, MotherNumber)

UserList(Userindex).Stats.UserSkills(1) = 10
UserList(Userindex).Stats.UserSkills(2) = 10
UserList(Userindex).Stats.UserSkills(3) = 10
UserList(Userindex).Stats.UserSkills(4) = 10
UserList(Userindex).Stats.UserSkills(5) = 10
UserList(Userindex).Stats.UserSkills(6) = 10
UserList(Userindex).Stats.UserSkills(7) = 10
UserList(Userindex).Stats.UserSkills(8) = 10
UserList(Userindex).Stats.UserSkills(9) = 10
UserList(Userindex).Stats.UserSkills(10) = 10
UserList(Userindex).Stats.UserSkills(11) = 10
UserList(Userindex).Stats.UserSkills(12) = 10
UserList(Userindex).Stats.UserSkills(13) = 10
UserList(Userindex).Stats.UserSkills(14) = 10
UserList(Userindex).Stats.UserSkills(15) = 10
UserList(Userindex).Stats.UserSkills(16) = 10
UserList(Userindex).Stats.UserSkills(17) = 10
UserList(Userindex).Stats.UserSkills(18) = 10
UserList(Userindex).Stats.UserSkills(19) = 10
UserList(Userindex).Stats.UserSkills(20) = 10
UserList(Userindex).Stats.UserSkills(21) = 10
UserList(Userindex).Stats.UserSkills(22) = 10

PersonajesCreados = PersonajesCreados + 1
Call WriteVar(IniPath & "Server.ini", "INIT", "PersonajesCreados", str(PersonajesCreados))
End Sub
Sub CloseSocket(ByVal Userindex As Integer, Optional ByVal cerrarlo As Boolean = True)
On Error GoTo errhandler
Dim loopc As Integer

Call aDos.RestarConexion(UserList(Userindex).ip)


If UserList(Userindex).flags.UserLogged Then
    If NumUsers > 0 Then NumUsers = NumUsers - 1
    If UserList(Userindex).flags.Privilegios = 0 Then NumNoGMs = NumNoGMs - 1
    Call EstadisticasWeb.Informar(CANTIDAD_ONLINE, NumUsers)
    Call CloseUser(Userindex)
End If

frmMain.CantUsuarios.caption = NumNoGMs

'ANTI TIRADA DE LOGIN
    Dim Hay_Socket As Long
    Dim i As Long
 
    For i = 1 To MAX_CONEX
        If Anti_DDOS(i).ip = UserList(Userindex).ip Then
            Anti_DDOS(i).Desconectadas = Anti_DDOS(i).Desconectadas + 1
                If Anti_DDOS(i).Desconectadas >= 50 Then
                    Exit Sub
                End If
        End If
    Next i
'ANTI TIRADA DE LOGIN

If UserList(Userindex).ConnID <> -1 Then Call ApiCloseSocket(UserList(Userindex).ConnID)



UserList(Userindex) = UserOffline

Exit Sub

errhandler:
    UserList(Userindex) = UserOffline
    Call LogError("Error en CloseSocket " & Err.Description)

End Sub

Sub SendData(sndRoute As Byte, sndIndex As Integer, sndMap As Integer, sndData As String)
Dim loopc As Integer
Dim aux$
Dim dec$
Dim nfile As Integer
Dim Ret As Long
sndData = sndData & ENDC
Select Case sndRoute
    Case ToIndex
        If UserList(sndIndex).ConnID > -1 Then
             Call WsApiEnviar(sndIndex, sndData)
             Exit Sub
        End If
        Exit Sub
    Case ToMap
        For loopc = 1 To MapInfo(sndMap).NumUsers
            Call WsApiEnviar(MapInfo(sndMap).Userindex(loopc), sndData)
        Next
        Exit Sub
    Case ToPCArea
        For loopc = 1 To MapInfo(UserList(sndIndex).POS.Map).NumUsers
            If EnPantalla(UserList(sndIndex).POS, UserList(MapInfo(UserList(sndIndex).POS.Map).Userindex(loopc)).POS, 1) Then Call WsApiEnviar(MapInfo(UserList(sndIndex).POS.Map).Userindex(loopc), sndData)
        Next
        Exit Sub
    Case ToNone
        Exit Sub
    Case ToConci
        For loopc = 1 To LastUser
            If UserList(loopc).ConnID > -1 And (UserList(loopc).flags.EsConcilioNegro Or UserList(loopc).flags.EsConcilioNegro) Then Call WsApiEnviar(loopc, sndData)
        Next
        Exit Sub
    Case ToConse
        For loopc = 1 To LastUser
            If UserList(loopc).ConnID > -1 And (UserList(loopc).flags.EsConseCaos Or UserList(loopc).flags.EsConseReal) Then Call WsApiEnviar(loopc, sndData)
        Next
        Exit Sub
   Case ToNeutral
        For loopc = 1 To LastUser
            If UserList(loopc).ConnID > -1 And UserList(loopc).Faccion.Bando = Neutral Then Call WsApiEnviar(loopc, sndData)
        Next
        Exit Sub
    Case ToCasTLE
        For loopc = 1 To LastUser
            If UserList(loopc).ConnID > -1 And UserList(loopc).flags.DominandoCastillo Then Call WsApiEnviar(loopc, sndData)
        Next
        Exit Sub
    Case ToAdmins
        For loopc = 1 To LastUser
            If UserList(loopc).ConnID > -1 And UserList(loopc).flags.Privilegios Then Call WsApiEnviar(loopc, sndData)
        Next
        Exit Sub
    Case ToMoreAdmins
        For loopc = 1 To LastUser
            If UserList(loopc).ConnID > -1 And UserList(loopc).flags.Privilegios >= UserList(sndIndex).flags.Privilegios Then Call WsApiEnviar(loopc, sndData)
        Next
        Exit Sub
    Case ToParty
        Dim MiembroIndex As Integer
        If UserList(sndIndex).PartyIndex = 0 Then Exit Sub
        For loopc = 1 To MAXPARTYUSERS
            MiembroIndex = Party(UserList(sndIndex).PartyIndex).MiembrosIndex(loopc)
            If MiembroIndex > 0 Then
                If UserList(MiembroIndex).ConnID > -1 And UserList(MiembroIndex).flags.UserLogged And UserList(MiembroIndex).flags.Party > 0 Then Call WsApiEnviar(MiembroIndex, sndData)
            End If
        Next
        Exit Sub
    Case ToAll
        For loopc = 1 To LastUser
            If UserList(loopc).ConnID > -1 And UserList(loopc).flags.UserLogged Then Call WsApiEnviar(loopc, sndData)
        Next
        Exit Sub
    Case ToAllButIndex
        For loopc = 1 To LastUser
            If (UserList(loopc).ConnID > -1) And (loopc <> sndIndex) And UserList(loopc).flags.UserLogged Then Call WsApiEnviar(loopc, sndData)
        Next
        Exit Sub
    Case ToMapButIndex
        For loopc = 1 To MapInfo(UserList(sndIndex).POS.Map).NumUsers
            If MapInfo(UserList(sndIndex).POS.Map).Userindex(loopc) <> sndIndex Then Call WsApiEnviar(MapInfo(UserList(sndIndex).POS.Map).Userindex(loopc), sndData)
        Next
        Exit Sub
    Case ToGuildMembers
        If Len(UserList(sndIndex).GuildInfo.GuildName) = 0 Then Exit Sub
        For loopc = 1 To LastUser
            If (UserList(loopc).ConnID > -1) And UserList(sndIndex).GuildInfo.GuildName = UserList(loopc).GuildInfo.GuildName Then Call WsApiEnviar(loopc, sndData)
        Next
        Exit Sub
    Case ToGMArea
        For loopc = 1 To MapInfo(UserList(sndIndex).POS.Map).NumUsers
            If EnPantalla(UserList(sndIndex).POS, UserList(MapInfo(UserList(sndIndex).POS.Map).Userindex(loopc)).POS, 1) And UserList(MapInfo(UserList(sndIndex).POS.Map).Userindex(loopc)).flags.Privilegios Then Call WsApiEnviar(MapInfo(UserList(sndIndex).POS.Map).Userindex(loopc), sndData)
        Next
        Exit Sub
    Case ToPCAreaVivos
        For loopc = 1 To MapInfo(UserList(sndIndex).POS.Map).NumUsers
            If EnPantalla(UserList(sndIndex).POS, UserList(MapInfo(UserList(sndIndex).POS.Map).Userindex(loopc)).POS, 1) Then
                If Not UserList(MapInfo(UserList(sndIndex).POS.Map).Userindex(loopc)).flags.Muerto Or UserList(MapInfo(UserList(sndIndex).POS.Map).Userindex(loopc)).Clase = CLERIGO Then Call WsApiEnviar(MapInfo(UserList(sndIndex).POS.Map).Userindex(loopc), sndData)
            End If
        Next
        Exit Sub
    Case ToMuertos
        For loopc = 1 To MapInfo(UserList(sndIndex).POS.Map).NumUsers
            If EnPantalla(UserList(sndIndex).POS, UserList(MapInfo(UserList(sndIndex).POS.Map).Userindex(loopc)).POS, 1) Then
                If UserList(MapInfo(UserList(sndIndex).POS.Map).Userindex(loopc)).Clase = CLERIGO Or UserList(MapInfo(UserList(sndIndex).POS.Map).Userindex(loopc)).flags.Muerto Or UserList(MapInfo(UserList(sndIndex).POS.Map).Userindex(loopc)).flags.Privilegios Then Call WsApiEnviar(MapInfo(UserList(sndIndex).POS.Map).Userindex(loopc), sndData)
            End If
        Next
        Exit Sub
    Case ToPCAreaButIndex
        For loopc = 1 To MapInfo(UserList(sndIndex).POS.Map).NumUsers
            If EnPantalla(UserList(sndIndex).POS, UserList(MapInfo(UserList(sndIndex).POS.Map).Userindex(loopc)).POS, 1) And MapInfo(UserList(sndIndex).POS.Map).Userindex(loopc) <> sndIndex Then Call WsApiEnviar(MapInfo(UserList(sndIndex).POS.Map).Userindex(loopc), sndData)
        Next
        Exit Sub
    Case ToPCAreaButIndexG
        For loopc = 1 To MapInfo(UserList(sndIndex).POS.Map).NumUsers
            If EnPantalla(UserList(sndIndex).POS, UserList(MapInfo(UserList(sndIndex).POS.Map).Userindex(loopc)).POS, 3) And MapInfo(UserList(sndIndex).POS.Map).Userindex(loopc) <> sndIndex Then Call WsApiEnviar(MapInfo(UserList(sndIndex).POS.Map).Userindex(loopc), sndData)
        Next
        Exit Sub
    Case ToNPCArea
        For loopc = 1 To MapInfo(Npclist(sndIndex).POS.Map).NumUsers
            If EnPantalla(Npclist(sndIndex).POS, UserList(MapInfo(Npclist(sndIndex).POS.Map).Userindex(loopc)).POS, 1) Then Call WsApiEnviar(MapInfo(Npclist(sndIndex).POS.Map).Userindex(loopc), sndData)
        Next
        Exit Sub
    Case ToNPCAreaG
        For loopc = 1 To MapInfo(Npclist(sndIndex).POS.Map).NumUsers
            If EnPantalla(Npclist(sndIndex).POS, UserList(MapInfo(Npclist(sndIndex).POS.Map).Userindex(loopc)).POS, 3) Then Call WsApiEnviar(MapInfo(Npclist(sndIndex).POS.Map).Userindex(loopc), sndData)
        Next
        Exit Sub
    Case ToPCAreaG
        For loopc = 1 To MapInfo(UserList(sndIndex).POS.Map).NumUsers
            If EnPantalla(UserList(sndIndex).POS, UserList(MapInfo(UserList(sndIndex).POS.Map).Userindex(loopc)).POS, 3) Then Call WsApiEnviar(MapInfo(UserList(sndIndex).POS.Map).Userindex(loopc), sndData)
        Next
        Exit Sub
    Case ToAlianza
        For loopc = 1 To LastUser
            If UserList(loopc).ConnID > -1 And UserList(loopc).Faccion.Bando = Real Then Call WsApiEnviar(loopc, sndData)
        Next
        Exit Sub
    Case ToCaos
        For loopc = 1 To LastUser
            If UserList(loopc).ConnID > -1 And UserList(loopc).Faccion.Bando = Caos Then Call WsApiEnviar(loopc, sndData)
        Next
        Exit Sub
End Select
Exit Sub
Error:
    Call LogError("Error en SendData: " & sndData & "-" & Err.Description & "-Ruta: " & sndRoute & "-Index:" & sndIndex & "-Mapa" & sndMap)
End Sub
Function HayPCarea(POS As WorldPos) As Boolean
Dim i As Integer
For i = 1 To MapInfo(POS.Map).NumUsers
    If EnPantalla(POS, UserList(MapInfo(POS.Map).Userindex(i)).POS, 1) Then
        HayPCarea = True
        Exit Function
    End If
Next
End Function
Function HayOBJarea(POS As WorldPos, OBJIndex As Integer) As Boolean
Dim X As Integer, y As Integer
For y = POS.y - MinYBorder + 1 To POS.y + MinYBorder - 1
    For X = POS.X - MinXBorder + 1 To POS.X + MinXBorder - 1
        If MapData(POS.Map, X, y).OBJInfo.OBJIndex = OBJIndex Then
            HayOBJarea = True
            Exit Function
        End If
    Next
Next
End Function
Sub CorregirSkills(Userindex As Integer)
Dim k As Integer
For k = 1 To NUMSKILLS
  If UserList(Userindex).Stats.UserSkills(k) > MAXSKILLPOINTS Then UserList(Userindex).Stats.UserSkills(k) = MAXSKILLPOINTS
Next
For k = 1 To NUMATRIBUTOS
 If UserList(Userindex).Stats.UserAtributos(k) > MAXATRIBUTOS Then
    Call SendData(ToIndex, Userindex, 0, "ERREl personaje tiene atributos invalidos.")
    Exit Sub
 End If
Next
End Sub
Function ValidateChr(Userindex As Integer) As Boolean
ValidateChr = (UserList(Userindex).Char.Head <> 0 Or UserList(Userindex).flags.Navegando = 1) And _
UserList(Userindex).Char.Body <> 0 And ValidateSkills(Userindex)
End Function
Sub ConnectUser(Userindex As Integer, Name As String, PassWord As String, Mac As String, HDDisck As String, MotherNumber As String)
On Error GoTo Error
Dim Privilegios As Byte
Dim N As Integer
Dim loopc As Integer
Dim o As Integer

UserList(Userindex).flags.Apostandoa = 0
UserList(Userindex).flags.ApostandoPOR = 0

UserList(Userindex).Counters.Protegido = 4
UserList(Userindex).flags.Protegido = 2

UserList(Userindex).Mac = Mac
UserList(Userindex).HDDisck = HDDisck
UserList(Userindex).MotherNumber = MotherNumber


If NumUsers > MaxUsers2 Then
    If Not (EsSuperAdm(Name) Or EsDios(Name)) Then
        Call SendData(ToIndex, Userindex, 0, "ERREl servidor ha alcanzado el maximo de usuarios soportado, por favor vuelva a intertarlo más tarde.")
        Exit Sub
    End If
End If

If NumUsers >= MaxUsers Then
    Call SendData(ToIndex, Userindex, 0, "ERRLímite de usuarios alcanzado.")
    Call CloseSocket(Userindex)
    Exit Sub
End If

If AllowMultiLogins = 0 Then
    If CheckForSameIP(Userindex, UserList(Userindex).ip) Then
        Call SendData(ToIndex, Userindex, 0, "ERRNo es posible usar más de un personaje al mismo tiempo.")
        Call CloseSocket(Userindex)
        Exit Sub
    End If
End If

If FileExist(CharPath & UCase$(Name) & ".chr", vbNormal) = False Then
    Call SendData(ToIndex, Userindex, 0, "ERREl personaje no existe.")
    Call CloseSocket(Userindex)
    Exit Sub
End If

If UCase$(PassWord) <> UCase$(GetVar(CharPath & UCase$(Name) & ".chr", "INIT", "Password")) Then
    Call SendData(ToIndex, Userindex, 0, "ERRPassword incorrecto.")
    Call CloseSocket(Userindex)
    Exit Sub
End If

If CheckForSameName(Userindex, Name) Then
    If NameIndex(Name) = Userindex Then Call CloseSocket(NameIndex(Name))
    Call SendData(ToIndex, Userindex, 0, "ERREl usuario estaba conectado y fue desconectado, intenta nuevamente.")
    Call CloseSocket(Userindex)
    Call CloseSocket(NameIndex(Name))
    Exit Sub
End If

If BANCheck(Name) Then
Dim Baneador As String
Dim Causa As String
Baneador = GetVar(App.Path & "\logs\BanDetail.dat", Name, "BannedBy")
Causa = GetVar(App.Path & "\logs\BanDetail.dat", Name, "Reason")
    For loopc = 1 To Baneos.Count
        If Baneos(loopc).Name = UCase$(Name) Then
            Call SendData(ToIndex, Userindex, 0, "ERR El GM: " & Baneador & " te ha baneado por la siguiente razón: " & Causa & ". Tu personaje estará baneado hasta el día " & Format(Baneos(loopc).FechaLiberacion, "dddddd") & " a las " & Format(Baneos(loopc).FechaLiberacion, "hh:mm am/pm" & ". Sí crees que este baneo fue injustamente realizá tu descargo de baneo en nuestro foro http://nabrianao.com/foro/ en la sección. 'Denuncias'"))
            Exit Sub
            End If
    Next
    Call SendData(ToIndex, Userindex, 0, "ERREl GM: " & Baneador & " te ha baneado por la siguiente razón: " & Causa & " tu personaje esta baneado permanentemente. realizá tu descargo de baneo en nuestro foro http://nabrianao.com/foro/ en la sección. 'Denuncias'.")
    Exit Sub
End If


If EsSuperAdm(Name) Then
    Privilegios = 4
    Call LogGM(Name, "Se conecto con ip:" & UserList(Userindex).ip & " HD> " & UserList(Userindex).HDDisck & " MotherNumber> " & UserList(Userindex).MotherNumber, False)
    Call SendData(ToIndex, Userindex, 0, "GMH")
ElseIf EsDios(Name) Then
    Privilegios = 3
    Call LogGM(Name, "Se conecto con ip:" & UserList(Userindex).ip & " HD> " & UserList(Userindex).HDDisck & " MotherNumber> " & UserList(Userindex).MotherNumber, False)
    Call SendData(ToIndex, Userindex, 0, "GMH")
ElseIf EsSemiDios(Name) Then
    Privilegios = 2
    Call LogGM(Name, "Se conecto con ip:" & UserList(Userindex).ip & " HD> " & UserList(Userindex).HDDisck & " MotherNumber> " & UserList(Userindex).MotherNumber, False)
    Call SendData(ToIndex, Userindex, 0, "GMH")
ElseIf EsConsejero(Name) Then
    Privilegios = 1
    Call LogGM(Name, "Se conecto con ip:" & UserList(Userindex).ip & " HD> " & UserList(Userindex).HDDisck & " MotherNumber> " & UserList(Userindex).MotherNumber, True)
    Else
    Call SendData(ToIndex, Userindex, 0, "GMJ")
End If

If SeguridadGM = 1 Then 'IDENTIFICADOR GM
If Privilegios > 0 Then
If UCase$(MotherNumber) <> UCase$(GetVar(CharPath & UCase$(Name) & ".chr", "INIT", "Mother")) Then
    Call SendData(ToIndex, Userindex, 0, "ERRIDENTIFICADOR NO VÁLIDO.")
    UserList(Userindex).flags.TemporalLoginSeguridadGM = 1
    Call CloseSocket(Userindex)
    Exit Sub
End If
If UCase$(HDDisck) <> UCase$(GetVar(CharPath & UCase$(Name) & ".chr", "INIT", "LastHD")) Then
    Call SendData(ToIndex, Userindex, 0, "ERRIDENTIFICADOR NO VÁLIDO.")
    UserList(Userindex).flags.TemporalLoginSeguridadGM = 1
    Call CloseSocket(Userindex)
    Exit Sub
End If
End If
End If


If Restringido And Privilegios = 0 Then
    If Not PuedeDenunciar(Name) Then
        Call SendData(ToIndex, Userindex, 0, "ERREl servidor está restringido solo para GameMasters temporalmente.")
        Exit Sub
    End If
End If

Dim Quest As Boolean
Quest = PJQuest(Name)
Call LoadUser(Userindex, CharPath & UCase$(Name) & ".chr")
UserList(Userindex).Counters.IdleCount = Timer
If UserList(Userindex).Counters.TiempoPena Then UserList(Userindex).Counters.Pena = Timer
If UserList(Userindex).flags.Envenenado Then UserList(Userindex).Counters.Veneno = Timer
UserList(Userindex).Counters.AGUACounter = Timer
UserList(Userindex).Counters.COMCounter = Timer

If Not ValidateChr(Userindex) Then
    Call SendData(ToIndex, Userindex, 0, "ERRError en el personaje.")
    Call CloseSocket(Userindex)
    Exit Sub
End If

For o = 1 To BanMothers.Count
    If BanMothers.Item(o) = UserList(Userindex).MotherNumber Then
       Call SendData(ToIndex, Userindex, 0, "ERRTu PC se encuentra baneada T0.")
       Call SendData(ToAdmins, 0, 0, "||NabrianSec> M:" & UserList(Userindex).MotherNumber & " HD> " & UserList(Userindex).HDDisck & " IP: " & UserList(Userindex).ip & " Intento entrar." & FONTTYPE_FIGHTT)
       Call CloseSocket(Userindex)
       Exit Sub
    End If
Next

For o = 1 To BanHDs.Count
    If BanHDs.Item(o) = UserList(Userindex).HDDisck Then
       Call SendData(ToIndex, Userindex, 0, "ERRTu PC se encuentra baneada T0.")
       Call SendData(ToAdmins, 0, 0, "||NabrianSec> M:" & UserList(Userindex).MotherNumber & " HD> " & UserList(Userindex).HDDisck & " IP: " & UserList(Userindex).ip & " Intento entrar." & FONTTYPE_FIGHTT)
       Call CloseSocket(Userindex)
       Exit Sub
    End If
Next

For o = 1 To BanIps.Count
    If BanIps.Item(o) = UserList(Userindex).ip Then
        Call SendData(ToIndex, Userindex, 0, "ERRTu PC se encuentra bajo Tolerancia 0.")
        Call SendData(ToAdmins, 0, 0, "||NabrianSec> M:" & UserList(Userindex).MotherNumber & " HD> " & UserList(Userindex).HDDisck & " IP: " & UserList(Userindex).ip & " Intento entrar." & FONTTYPE_FIGHTT)
        Call CloseSocket(Userindex)
        Exit Sub
    End If
Next

If UserList(Userindex).Invent.EscudoEqpSlot = 0 Then UserList(Userindex).Char.ShieldAnim = NingunEscudo
If UserList(Userindex).Invent.CascoEqpSlot = 0 Then UserList(Userindex).Char.CascoAnim = NingunCasco
If UserList(Userindex).Invent.WeaponEqpSlot = 0 Then UserList(Userindex).Char.WeaponAnim = NingunArma
Call UpdateUserInv(True, Userindex, 0)
Call UpdateUserHechizos(True, Userindex, 0)
If UserList(Userindex).flags.Navegando = 1 Then
    If UserList(Userindex).flags.Muerto = 1 Then
        UserList(Userindex).Char.Body = iFragataFantasmal
        UserList(Userindex).Char.Head = 0
        UserList(Userindex).Char.WeaponAnim = NingunArma
        UserList(Userindex).Char.ShieldAnim = NingunEscudo
        UserList(Userindex).Char.CascoAnim = NingunCasco
    Else
        UserList(Userindex).Char.Body = ObjData(UserList(Userindex).Invent.BarcoObjIndex).Ropaje
        UserList(Userindex).Char.Head = 0
        UserList(Userindex).Char.WeaponAnim = NingunArma
        UserList(Userindex).Char.ShieldAnim = NingunEscudo
        UserList(Userindex).Char.CascoAnim = NingunCasco
    End If
End If

UserList(Userindex).flags.Privilegios = Privilegios
UserList(Userindex).flags.PuedeDenunciar = PuedeDenunciar(Name)
UserList(Userindex).flags.Quest = Quest
If UserList(Userindex).flags.Privilegios > 1 Then
    If UserList(Userindex).flags.Privilegios = 4 Then
        UserList(Userindex).flags.AdminInvisible = 1
        UserList(Userindex).flags.Invisible = 1
    Else
        UserList(Userindex).POS.Map = 86
        UserList(Userindex).POS.X = 50
        UserList(Userindex).POS.y = 50
    End If
End If

If UserList(Userindex).flags.Paralizado Then Call SendData(ToIndex, Userindex, 0, "P9")

If UserList(Userindex).POS.Map = 0 Or UserList(Userindex).POS.Map > NumMaps Then

    Select Case UserList(Userindex).Hogar
        Case HOGAR_NIX
            UserList(Userindex).POS = NIX
        Case HOGAR_BANDERBILL
            UserList(Userindex).POS = BANRDEBILL
        Case HOGAR_LINDOS
            UserList(Userindex).POS = LINDOS
        Case HOGAR_ARGHAL
            UserList(Userindex).POS = ARGHAL
        Case Else
            UserList(Userindex).POS = ULLATHORPE
    End Select
    If UserList(Userindex).POS.Map > NumMaps Then UserList(Userindex).POS = ULLATHORPE
End If

If MapData(UserList(Userindex).POS.Map, UserList(Userindex).POS.X, UserList(Userindex).POS.y).Userindex Then
    Dim Tindex As Integer
    Dim NposMap As Integer
    Dim NposX As Integer
    Dim NposY As Integer
    NposMap = UserList(Userindex).POS.Map
    NposX = UserList(Userindex).POS.X
    NposY = UserList(Userindex).POS.y + 1
    Tindex = MapData(UserList(Userindex).POS.Map, UserList(Userindex).POS.X, UserList(Userindex).POS.y).Userindex
    Call WarpUserChar(Userindex, NposMap, NposX, NposY, True)
End If


UserList(Userindex).Name = Name

If UserList(Userindex).flags.Privilegios > 0 And UserList(Userindex).flags.Privilegios <= 4 Then Call SendData(ToMoreAdmins, Userindex, 0, "||" & UserList(Userindex).Name & " se conectó." & FONTTYPE_FENIX)
Call SendData(ToIndex, Userindex, 0, "IU" & Userindex)
Call SendData(ToIndex, Userindex, 0, "CM" & UserList(Userindex).POS.Map & "," & MapInfo(UserList(Userindex).POS.Map).MapVersion & "," & MapInfo(UserList(Userindex).POS.Map).Name & "," & MapInfo(UserList(Userindex).POS.Map).TopPunto & "," & MapInfo(UserList(Userindex).POS.Map).LeftPunto)
Call SendData(ToIndex, Userindex, 0, "TM" & MapInfo(UserList(Userindex).POS.Map).Music)
Call SendData(ToIndex, Userindex, 0, "TN" & MapInfo(UserList(Userindex).POS.Map).MusicNoMp3)
Call SendUserStatsBox(Userindex)
Call EnviarHambreYsed(Userindex)
UserList(Userindex).flags.TDead = UserList(Userindex).Faccion.Matados(0) + UserList(Userindex).Faccion.Matados(1) + UserList(Userindex).Faccion.Matados(2)
Call SendData(ToIndex, Userindex, 0, "FRA" & UserList(Userindex).flags.TDead)
Call SendUserREP(Userindex)
Call SendMOTD(Userindex)

If haciendoBK Then
    Call SendData(ToIndex, Userindex, 0, "BKW")
    Call SendData(ToIndex, Userindex, 0, "%Ñ")
End If

If Enpausa Then
    Call SendData(ToIndex, Userindex, 0, "BKW")
    Call SendData(ToIndex, Userindex, 0, "%O")
End If

UserList(Userindex).flags.UserLogged = True
Call AgregarAUsersPorMapa(Userindex)

If NumUsers > DayStats.MaxUsuarios Then DayStats.MaxUsuarios = NumUsers

If NumUsers > recordusuarios Then
    Call SendData(ToAll, 0, 0, "2L" & NumUsers)
    recordusuarios = NumUsers
    Call WriteVar(IniPath & "Server.ini", "INIT", "Record", str(recordusuarios))
    Call EstadisticasWeb.Informar(RECORD_USUARIOS, recordusuarios)
End If

If UserList(Userindex).flags.Privilegios > 0 Then UserList(Userindex).flags.Ignorar = 1
If Userindex > LastUser Then LastUser = Userindex
NumUsers = NumUsers + 1
If UserList(Userindex).flags.Privilegios = 0 Then NumNoGMs = NumNoGMs + 1
Call EstadisticasWeb.Informar(CANTIDAD_ONLINE, NumUsers)
frmMain.CantUsuarios.caption = NumNoGMs

Call UpdateFuerzaYAg(Userindex)
Set UserList(Userindex).GuildRef = FetchGuild(UserList(Userindex).GuildInfo.GuildName)
UserList(Userindex).flags.Seguro = True
Call MakeUserChar(ToMap, 0, UserList(Userindex).POS.Map, Userindex, UserList(Userindex).POS.Map, UserList(Userindex).POS.X, UserList(Userindex).POS.y)
Call SendData(ToIndex, Userindex, 0, "IP" & UserList(Userindex).Char.CharIndex)
If UserList(Userindex).flags.Navegando = 1 Then Call SendData(ToIndex, Userindex, 0, "NAVEG")
If UserList(Userindex).flags.AdminInvisible = 0 Then
Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "CFX" & UserList(Userindex).Char.CharIndex & "," & UserList(Userindex).Char.CharIndex & "," & FXWARP & "," & 1 & "," & 0) 'dx8
End If

Call SendData(ToIndex, Userindex, 0, "LOGGED")
UserList(Userindex).Counters.Sincroniza = Timer

If PuedeFaccion(Userindex) Then Call SendData(ToIndex, Userindex, 0, "SUFA1")
If PuedeSubirClase(Userindex) Then Call SendData(ToIndex, Userindex, 0, "SUCL1")
If PuedeRecompensa(Userindex) Then Call SendData(ToIndex, Userindex, 0, "SURE1")
If UserList(Userindex).Stats.SkillPts Then
    Call EnviarSkills(Userindex)
    Call EnviarSubirNivel(Userindex, UserList(Userindex).Stats.SkillPts)
End If

Call SendData(ToIndex, Userindex, 0, "INTA" & IntervaloUserPuedeAtacar * 10)
Call SendData(ToIndex, Userindex, 0, "INTS" & IntervaloUserPuedeCastear * 10)
Call SendData(ToIndex, Userindex, 0, "INTF" & IntervaloUserFlechas * 10)
Call SendData(ToIndex, Userindex, 0, "NON" & NumNoGMs)

Call SendData(ToIndex, Userindex, 0, "MH" & UserList(Userindex).flags.Muerto & "," & TiempoReal)

If Lloviendo Then Call SendData(ToIndex, Userindex, 0, "LLU")

Call ClanGM(Userindex)

If Len(UserList(Userindex).GuildInfo.GuildName) > 0 And UserList(Userindex).flags.Privilegios = 0 Then Call SendData(ToGuildMembers, Userindex, 0, "4B" & UserList(Userindex).Name)
If PuedeDestrabarse(Userindex) Then Call SendData(ToIndex, Userindex, 0, "||Estás encerrado, para destrabarte presiona la tecla Z." & FONTTYPE_INFO)

Dim TieneSoporte As String
TieneSoporte = GetVar(CharPath & UCase$(UserList(Userindex).Name) & ".chr", "STATS", "Respuesta")

If Len(TieneSoporte) Then
    If Right$(TieneSoporte, 3) <> "0k1" Then
    Call SendData(ToIndex, Userindex, 0, "TENSO")
    Call SendData(ToIndex, Tindex, 0, "TW125")
    End If
End If

If UCase$(UserList(Userindex).Name) = UCase$(SubastadorName) Then
        Subastador = Userindex
End If

Call UpdateUserMap(Userindex)

N = FreeFile
Open App.Path & "\logs\numusers.log" For Output As N
Print #N, NumUsers
Close #N



Exit Sub
Error:
    Call LogError("Error en ConnectUser: " & Name & " " & Err.Description)

End Sub

Sub SendMOTD(Userindex As Integer)
Dim j As Integer
For j = 1 To MaxLines
    Call SendData(ToIndex, Userindex, 0, "##" & MOTD(j).Texto)
    Call SendData(ToIndex, Userindex, 0, "||> Bienvenido " & UserList(Userindex).Name & ". Presiona f1 para abrir el Manual Iniciativo." & FONTTYPE_TALK)
    Call SendData(ToIndex, Userindex, 0, "||> NabrianAO server versión BETA " & App.Major & "." & App.Minor & "." & App.Revision & " Record: " & recordusuarios & FONTTYPE_VERSION)
    Call SendData(ToIndex, Userindex, 0, "||> El castillo pertecene al clan ' " & GetVar(App.Path & "\Dat\Castillitos.Siam", "CASTILLOS", "ClanCastillo") & " ' y lleva acumuladas " & PonerPuntos(HonorA) & " monedas de oro." & FONTTYPE_BLANCO)
    
    If HappyHourExp = 1 Then
    Call SendData(ToIndex, Userindex, 0, "||> HappyHour: Experiencia x35 y Oro x20 hasta las 20:00 horas." & FONTTYPE_ORO)
    End If
    
    If DiosHades = 1 Then Call SendData(ToIndex, Userindex, 0, "||> Hades se encuentra con vida." & FONTTYPE_FIGHT)
    
    If cOCUP Then
    If UserList(Userindex).GuildInfo.GuildName = UserList(RetoClan.lider1).GuildInfo.GuildName Or UserList(Userindex).GuildInfo.GuildName = UserList(RetoClan.lider2).GuildInfo.GuildName Then
    Call SendData(ToIndex, Userindex, 0, "||> Tú clan esta combatiendo en una Guerra de clanes por " & PonerPuntos(UserList(RetoClan.lider1).flags.ApuestaRetoClan) & " monedas de oro, tipeá /IRGUERRA si deseas participar." & FONTTYPE_FENIZ)
    End If
    End If
    
Next j
End Sub

Sub CloseUser(ByVal Userindex As Integer)
On Error GoTo errhandler
Dim i As Integer, aN As Integer
Dim Name As String
Name = UCase$(UserList(Userindex).Name)

aN = UserList(Userindex).flags.AtacadoPorNpc

If aN Then
    Npclist(aN).Movement = Npclist(aN).flags.OldMovement
    Npclist(aN).Hostile = Npclist(aN).flags.OldHostil
    Npclist(aN).flags.AttackedBy = 0
End If

If UserList(Userindex).Tienda.NpcTienda Then
    Call DevolverItemsVenta(Userindex)
    Npclist(UserList(Userindex).Tienda.NpcTienda).flags.TiendaUser = 0
End If

Call UserDeslogeaRetosAuto(Userindex)

If Userindex = GranPoder Then
    Call SendData(ToAll, Userindex, 0, "||Poder> " & UserList(Userindex).Name & " ha abandonado el juego." & FONTTYPE_PODER)
    GranPoder = 0
End If

If Userindex = RetoClan.lider1 Then
Call GanaClanLider2(1)
ElseIf Userindex = RetoClan.lider2 Then
Call GanaClanLider1(1)
End If

If UserList(Userindex).flags.ComerCiandoNuevo = True Then
If UserList(Userindex).flags.Comerciando = True Then 'ComercioNuevo
Call CanceloComercio(Userindex)
End If
End If

If UserList(Userindex).POS.Map = 198 Then
Call WarpUserChar(Userindex, 1, 50, 50)
End If

If UserList(Userindex).flags.enRetoC1 Then   'GUERRACLAN
   If UserList(Userindex).flags.Muerto = 0 Then Call UserDie(Userindex)
   CuposClan1 = CuposClan1 - 1
Call WarpUserChar(Userindex, 1, 50, 50)
ElseIf UserList(Userindex).flags.enRetoC2 Then
   If UserList(Userindex).flags.Muerto = 0 Then Call UserDie(Userindex)
   CuposClan2 = CuposClan2 - 1
Call WarpUserChar(Userindex, 1, 50, 50)
End If

If UserList(Userindex).Counters.CreoTeleport = True Then
Call ControlarPortalLum(Userindex) 'matute
UserList(Userindex).flags.TiroPortalL = 0
UserList(Userindex).Counters.TimeTeleport = 0
End If

If UserList(Userindex).flags.notesaleelbug = True Then
       UserList(Userindex).flags.notesaleelbug = False
       UserList(Userindex).flags.NoAceptasSinFlag = False
End If
       
If UserList(Userindex).flags.tampocoteSale = True Then
       UserList(Userindex).flags.tampocoteSale = False
End If
       


If (Torneo_ActivoX) Then
If UserList(Userindex).flags.automatico2vs2 = True Then
Call Rondas_UsuarioMuere2vs2(Userindex, False, False)
If AutomaticoCanjes = 1 Then Call WarpUserChar(Userindex, 198, 24, 65)
If AutomaticoCanjes = 0 Then Call WarpUserChar(Userindex, 1, 50, 50)
If AutomaticoCanjes = 1 Then Call TirarTodosLosItems(Userindex)
If UserList(Userindex).flags.EstaTorneoAuto2vs2 = True Then
Call Rondas_UsuarioMuere2vs2(UserList(Userindex).flags.parejadel2v2, False, False)
If AutomaticoCanjes = 1 Then Call WarpUserChar(UserList(Userindex).flags.parejadel2v2, 198, 24, 65)
If AutomaticoCanjes = 0 Then Call WarpUserChar(UserList(Userindex).flags.parejadel2v2, 1, 50, 50)
If AutomaticoCanjes = 1 Then Call TirarTodosLosItems(UserList(Userindex).flags.parejadel2v2)
End If
End If
End If

If UserList(Userindex).flags.automatico = True Then
Call Rondas_UsuarioMuere(Userindex, False, False)
If AutomaticoCanjes = 1 Then Call WarpUserChar(Userindex, 198, 24, 65)
If AutomaticoCanjes = 0 Then Call WarpUserChar(Userindex, 1, 50, 50)
If AutomaticoCanjes = 1 Then Call TirarTodosLosItems(Userindex)
End If

If UserList(Userindex).flags.automaticop = True Then
Call Rondas_UsuarioMuerep(Userindex, False, False)
If AutomaticoCanjes = 1 Then Call WarpUserChar(Userindex, 198, 24, 65)
If AutomaticoCanjes = 0 Then Call WarpUserChar(Userindex, 1, 50, 50)
If AutomaticoCanjes = 1 Then Call TirarTodosLosItems(Userindex)
End If

If UserList(Userindex).flags.EnDM = True Then 'Death Ulla
Call SaleUserDM(Userindex)
End If

Call MOD_EVENTO_Retos3vs3.SeFueD(Userindex)  'Reto3vs3
Call MOD_EVENTO_Retos2vs2.SeFue(Userindex) 'Reto2vs2
Call RetosPorPJ.DesLogRetoPJ(Userindex) 'retoPorPj
Call CapTheTeam.DesLogTheTeam(Userindex) 'theteam
Call CapTheProtector.DesLogTheProtector(Userindex) 'TheProtector

If UserList(Userindex).POS.Map = 127 Then
 Call WarpUserChar(Userindex, 1, 50, 50, True)
End If

If UserList(Userindex).POS.Map = 190 Then
 Call WarpUserChar(Userindex, 1, 50, 50, True)
End If

If UserList(Userindex).POS.Map = 191 Then
 Call WarpUserChar(Userindex, 1, 50, 50, True)
End If

If UserList(Userindex).flags.death = True Then 'death auto
UserList(Userindex).flags.death = False
Cantidaddeath = Cantidaddeath - 1
Call WarpUserChar(Userindex, 1, 50, 50, True)
End If

If UserList(Userindex).flags.Privilegios > 0 And UserList(Userindex).flags.Privilegios <= 4 Then
Call SendData(ToMoreAdmins, Userindex, 0, "||" & UserList(Userindex).Name & " se desconectó." & FONTTYPE_FENIX)
End If

If UserList(Userindex).flags.Party Then
    Call SendData(ToParty, Userindex, 0, "||" & UserList(Userindex).Name & " se desconectó." & FONTTYPE_PARTY)
    If Party(UserList(Userindex).PartyIndex).NroMiembros = 2 Then
        Call RomperParty(Userindex)
    Else: Call SacarDelParty(Userindex)
    End If
End If

If UserList(Userindex).flags.Retando = True Then
Call TerminoRetoPorConex(Userindex)
End If

Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "CFX" & UserList(Userindex).Char.CharIndex & "," & UserList(Userindex).Char.CharIndex & "," & 0 & "," & 0 & "," & 0) 'dx8

If UserList(Userindex).Caballos.Num And UserList(Userindex).flags.Montado = 1 Then Call Desmontar(Userindex)

If UserList(Userindex).flags.AdminInvisible Then Call DoAdminInvisible(Userindex)
If UserList(Userindex).flags.Transformado Then Call DoTransformar(Userindex, False)

Call SaveUser(Userindex, CharPath & Name & ".chr")

If MapInfo(UserList(Userindex).POS.Map).NumUsers Then Call SendData(ToMapButIndex, Userindex, UserList(Userindex).POS.Map, "QDL" & UserList(Userindex).Char.CharIndex)
If UserList(Userindex).Char.CharIndex Then Call EraseUserChar(ToMapButIndex, Userindex, UserList(Userindex).POS.Map, Userindex)
If UserList(Userindex).Caballos.Num Then Call QuitarCaballos(Userindex)

For i = 1 To MAXMASCOTAS * Buleano(Not UserList(Userindex).flags.Quest)
    If UserList(Userindex).MascotasIndex(i) Then
        If Npclist(UserList(Userindex).MascotasIndex(i)).flags.NPCActive Then _
                Call QuitarNPC(UserList(Userindex).MascotasIndex(i))
    End If
Next

If Userindex = LastUser Then
    Do Until UserList(LastUser).flags.UserLogged
        LastUser = LastUser - 1
        If LastUser < 1 Then Exit Do
    Loop
End If

If Len(UserList(Userindex).GuildInfo.GuildName) > 0 And UserList(Userindex).flags.Privilegios = 0 Then Call SendData(ToGuildMembers, Userindex, 0, "5B" & UserList(Userindex).Name)

Call QuitarDeUsersPorMapa(Userindex)

If MapInfo(UserList(Userindex).POS.Map).NumUsers < 0 Then MapInfo(UserList(Userindex).POS.Map).NumUsers = 0

Exit Sub

errhandler:
Call LogError("Error en CloseUser " & Err.Description)

End Sub
Sub ActivarTrampa(Userindex As Integer)
Dim i As Integer, TU As Integer

For i = 1 To MapInfo(UserList(Userindex).POS.Map).NumUsers
    TU = MapInfo(UserList(Userindex).POS.Map).Userindex(i)
    If UserList(TU).flags.Paralizado = 0 And Abs(UserList(Userindex).POS.X - UserList(TU).POS.X) <= 3 And Abs(UserList(Userindex).POS.y - UserList(TU).POS.y) <= 3 And TU <> Userindex And PuedeAtacar(Userindex, TU) Then
       UserList(TU).flags.QuienParalizo = Userindex
       UserList(TU).flags.Paralizado = 1
       UserList(TU).Counters.Paralisis = Timer - 15 * Buleano(UserList(TU).Clase = GUERRERO And UserList(TU).Recompensas(3) = 2)
       Call SendData(ToIndex, TU, 0, "PU" & DesteEncripTE(UserList(TU).POS.X & "," & UserList(TU).POS.y))
       Call SendData(ToIndex, TU, 0, ("P9"))
       Call SendData(ToPCArea, TU, UserList(TU).POS.Map, "CFX" & UserList(TU).Char.CharIndex & "," & UserList(TU).Char.CharIndex & "," & 12 & "," & 0 & "," & 1) 'dx8
    End If
Next

Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "TW112")

End Sub
Sub HandleData3(Userindex As Integer, ByVal rdata As String)
On Error Resume Next
On Error GoTo ErrorHandler:

Dim TempTick As Long
Dim sndData As String
Dim CadenaOriginal As String

Dim loopc As Integer
Dim nPos As WorldPos
Dim tStr As String
Dim tInt As Integer
Dim tLong As Long
Dim numeromail As Integer
Dim Tindex As Integer
Dim tName As String
Dim Clase As Byte
Dim NumNPC As Integer
Dim tMessage As String
Dim i As Integer
Dim auxind As Integer
Dim arg1 As String
Dim arg2 As String
Dim arg3 As String
Dim Arg4 As String
Dim Arg5 As Integer
Dim Arg6 As String
Dim DummyInt As Integer
Dim Antes As Boolean
Dim Ver As String
Dim encpass As String
Dim pass As String
Dim Mapa As Integer
Dim usercon As String
Dim nameuser As String
Dim Name As String
Dim ind
Dim GMDia As String
Dim GMMapa As String
Dim GMPJ As String
Dim GMMail As String
Dim GMGM As String
Dim GMTitulo As String
Dim GMMensaje As String
Dim N As Integer
Dim wpaux As WorldPos
Dim mifile As Integer
Dim X As Integer
Dim y As Integer
Dim cliMD5 As String
Dim UserFile As String
Dim UserName As String
UserName = UserList(Userindex).Name
UserFile = CharPath & UCase$(UserName) & ".chr"
Dim ClientCRC As String
Dim ServerSideCRC As Long
Dim NombreIniChat As String
Dim cantidadenmapa As Integer
Dim Prueba1 As Integer
CadenaOriginal = rdata

If Userindex <= 0 Then
    Call CloseSocket(Userindex)
    Exit Sub
End If

UserList(Userindex).Counters.IdleCount = Timer

    If UCase$(Left$(rdata, 2)) = "XB" Then
          rdata = Right$(rdata, Len(rdata) - 2)
          Call EnviarDataMapa(rdata, Userindex)
    Exit Sub
    End If

    If UCase$(Left$(rdata, 2)) = "XH" Then
          rdata = Right$(rdata, Len(rdata) - 2)
          Call SendData(ToIndex, UserList(Userindex).ComercioNuevo.Usuario1, 0, "XH" & rdata)  'chat comercio
    Exit Sub
    End If

    If UCase$(Left$(rdata, 3)) = "IPM" Then
        rdata = Right$(rdata, Len(rdata) - 3)
          If val(rdata) > 0 And val(rdata) < UBound(PremiosListDonador) + 1 Then _
            Call SendData(ToIndex, Userindex, 0, "INF" & PremiosListDonador(val(rdata)).ObjRequiere & "," & PremiosListDonador(val(rdata)).ObjMaxAt & "," & PremiosListDonador(val(rdata)).ObjMinAt & "," & PremiosListDonador(val(rdata)).ObjMaxdef & "," & PremiosListDonador(val(rdata)).ObjMindef & "," & PremiosListDonador(val(rdata)).ObjMaxAtMag & "," & PremiosListDonador(val(rdata)).ObjMinAtMag & "," & PremiosListDonador(val(rdata)).ObjMaxDefMag & "," & PremiosListDonador(val(rdata)).ObjMinDefMag & "," & PremiosListDonador(rdata).ObjDescripcion & "," & UserList(rdata).flags.CanjesDonador & "," & ObjData(PremiosListDonador(rdata).ObjIndexP).GrhIndex)
        Exit Sub
    End If

            
If UCase$(Left$(rdata, 3)) = "SPM" Then
        rdata = Right$(rdata, Len(rdata) - 3)
        Dim Premio As Obj
        
   
If UserList(Userindex).flags.Privilegios = 1 Or UserList(Userindex).flags.Privilegios = 2 Or UserList(Userindex).flags.Privilegios = 3 Then Exit Sub
If Userindex = Subastador Then Exit Sub
If Userindex = UltimoOfertador Then Exit Sub
If UserList(Userindex).flags.notesaleelbug = True Then Exit Sub
If UserList(Userindex).POS.Map = 108 Then Exit Sub
If UserList(Userindex).flags.Retando = True Then Exit Sub

    If UserList(Userindex).flags.EnvRetoC = True Then Exit Sub ' galle
    If UserList(Userindex).flags.RecRetoC = True Then Exit Sub
        
                If val(rdata) > 0 And val(rdata) < UBound(PremiosListDonador) + 1 Then
     
            Premio.Amount = 1
            Premio.OBJIndex = PremiosListDonador(val(rdata)).ObjIndexP
           
            End If
            
            If ObjData(Premio.OBJIndex).Name = "" Then
            Call SendData(ToIndex, Userindex, 0, "||Error" & FONTTYPE_FIGHTT)
            Exit Sub
            End If
            
            If UserList(Userindex).flags.CanjesDonador < PremiosListDonador(val(rdata)).ObjRequiere Then
                   Call SendData(ToIndex, Userindex, 0, "||No tienes suficientes puntos para este objeto." & FONTTYPE_INFO)
            Exit Sub
            End If
            
            If PremiosListDonador(val(rdata)).cambiarpuntos > 1 Then
            
            UserList(Userindex).flags.CanjesDonador = UserList(Userindex).flags.CanjesDonador - PremiosListDonador(val(rdata)).ObjRequiere
            UserList(Userindex).Stats.GLD = UserList(Userindex).Stats.GLD + PremiosListDonador(val(rdata)).cambiarpuntos
            UserList(Userindex).Stats.Reputacion = UserList(Userindex).Stats.Reputacion + 30
            Call SendData(ToIndex, Userindex, 0, "||Has cambiado " & PremiosListDonador(val(rdata)).ObjRequiere & " puntos de donador por " & PonerPuntos(CStr(PremiosListDonador(val(rdata)).cambiarpuntos)) & " monedas de oro." & FONTTYPE_GUILD)
            If UserList(Userindex).flags.Templario = 1 Then Call SendData(ToIndex, Userindex, 0, "||Este cambio no te da beneficios de templario." & FONTTYPE_GUILD)
            Call SendUserREP(Userindex)
            Call SendUserORO(Userindex)
            Exit Sub
            End If
            
            If Not MeterItemEnInventario(Userindex, Premio) Then
            '   Call SendData(ToIndex, Userindex, 0, "||No puedo cargar mas objetos." & FONTTYPE_INFO)
            Exit Sub
            End If
           
           
           
            Call UpdateUserInv(True, Userindex, 0)

            Call SendData(ToIndex, Userindex, 0, "||Has canjeado: " & ObjData(Premio.OBJIndex).Name & " (Cantidad: " & Premio.Amount & ")" & FONTTYPE_GUILD)
            Call LogCanjes(UserList(Userindex).Name, "" & UserList(Userindex).Name & " canjeo " & ObjData(Premio.OBJIndex).Name, False)
            
            UserList(Userindex).flags.CanjesDonador = UserList(Userindex).flags.CanjesDonador - PremiosListDonador(val(rdata)).ObjRequiere
            If UserList(Userindex).flags.Templario = 1 Then
            UserList(Userindex).flags.CanjesDonador = UserList(Userindex).flags.CanjesDonador + PremiosListDonador(val(rdata)).templariobeneficio
            Call SendData(ToIndex, Userindex, 0, "||Beneficio por ser templario: " & PremiosListDonador(val(rdata)).templariobeneficio & " puntos de donador." & FONTTYPE_GUILD)
            End If
            Call SendUserREP(Userindex)
    
        Exit Sub
    End If


'usersssssssssssssssssssssssssssssss

If UCase$(Left$(rdata, 12)) = "/SEGURIDADGM" Then 'IDENTIFICADOR GM
rdata = Right$(rdata, Len(rdata) - 12)
If Not UserList(Userindex).Name = "Neliam" Then Exit Sub 'SOLO NELIAM LO USA
If SeguridadGM = 0 Then
SeguridadGM = 1
Call SendData(ToIndex, Userindex, 0, "||SEGURIDADGM; ACTIVADA." & FONTTYPE_INFO)
Else
SeguridadGM = 0
Call SendData(ToIndex, Userindex, 0, "||SEGURIDADGM; DESACTIVADA." & FONTTYPE_INFO)
End If
Exit Sub
End If

If UCase$(Left$(rdata, 7)) = "/MISION" Then
rdata = Right$(rdata, Len(rdata) - 7)
Call UserMisionTemplario(Userindex)
Exit Sub
End If

If UCase$(Left$(rdata, 11)) = "/TRANSFERIR" Then
rdata = Right$(rdata, Len(rdata) - 11)
Call SendData(ToIndex, Userindex, 0, "HC")
Exit Sub
End If

If UCase$(Left$(rdata, 12)) = "/TRANSFERIX " Then
rdata = Right$(rdata, Len(rdata) - 12)
Tindex = NameIndex(ReadField(1, rdata, 32))
arg1 = ReadField(2, rdata, 32)
arg2 = Replace$(ReadField(1, rdata, 32), "+", " ")
Call TransferirORO(Userindex, Tindex, arg1, arg2)
Exit Sub
End If


If UCase$(Left$(rdata, 9)) = "/CONSOLA " Then
   rdata = Right$(rdata, Len(rdata) - 9)
   
        If UserList(Userindex).flags.EsConseCaos Or UserList(Userindex).flags.Privilegios = 4 Then
           Call SendData(ToCaos, 0, 0, "||Concilio de Arghal [" & UserList(Userindex).Name & "] " & rdata & FONTTYPE_FIGHTT)
           Call SendData(ToAdmins, 0, 0, "||Concilio de Arghal [" & UserList(Userindex).Name & "] " & rdata & FONTTYPE_FIGHTT)
           Call LogGM(UserList(Userindex).Name, "CONSOLA BANDO ROJO:" & rdata, False)
        End If
        
        If UserList(Userindex).flags.EsConcilioNegro Or UserList(Userindex).flags.Privilegios = 4 = 2 Then
                  Call SendData(ToNeutral, 0, 0, "||Gladiador [" & UserList(Userindex).Name & "] " & rdata & FONTTYPE_TALK)
                  Call SendData(ToAdmins, 0, 0, "||Gladiador [" & UserList(Userindex).Name & "] " & rdata & FONTTYPE_TALK)
                  Call LogGM(UserList(Userindex).Name, "CONSOLA BANDO Gladiador:" & rdata, False)
        End If
        
        
        If UserList(Userindex).flags.EsConseReal Or UserList(Userindex).flags.Privilegios = 4 Then
            Call SendData(ToAlianza, 0, 0, "||Consejo de Banderbill [" & UserList(Userindex).Name & "] " & rdata & FONTTYPE_ProtectorCiu)
            Call SendData(ToAdmins, 0, 0, "||Consejo de Banderbill [" & UserList(Userindex).Name & "] " & rdata & FONTTYPE_ProtectorCiu)
            Call LogGM(UserList(Userindex).Name, "CONSOLA BANDO AZUL:" & rdata, False)
        End If
        
    Exit Sub
End If
        

   

If UCase$(Left$(rdata, 12)) = "/ACEPTCONCI " Then
If UserList(Userindex).flags.EsConcilioNegro Or UserList(Userindex).flags.Privilegios = 4 Or UserList(Userindex).flags.Privilegios = 3 Or UserList(Userindex).flags.Privilegios = 2 Then
        rdata = Right$(rdata, Len(rdata) - 12)
        Tindex = NameIndex(rdata)
        If Tindex <= 0 Then
            Call SendData(ToIndex, Userindex, 0, "||Usuario offline" & FONTTYPE_INFO)
        Else
            Call SendData(ToAll, 0, 0, "||¡¡ " & rdata & " Es el Gladiador de este Mes !!" & FONTTYPE_CONCILIONEGRO)
            UserList(Tindex).flags.EsConcilioNegro = 1
            Call WarpUserChar(Tindex, UserList(Tindex).POS.Map, UserList(Tindex).POS.X, UserList(Tindex).POS.y, False)
        End If
    End If
    Exit Sub
End If

If UCase$(Left$(rdata, 12)) = "/ACEPTCONSE " Then
    If UserList(Userindex).flags.EsConseReal Or UserList(Userindex).flags.Privilegios = 4 Or UserList(Userindex).flags.Privilegios = 3 Or UserList(Userindex).flags.Privilegios = 2 Then
        rdata = Right$(rdata, Len(rdata) - 12)
        Tindex = NameIndex(rdata)
        If Tindex <= 0 Then
            Call SendData(ToIndex, Userindex, 0, "||Usuario offline" & FONTTYPE_INFO)
        Else
            Call SendData(ToAll, 0, 0, "||" & rdata & " fue aceptado en el honorable Consejo de Banderbill." & FONTTYPE_CONSEJO)
        UserList(Tindex).flags.EsConseReal = 1
        Call WarpUserChar(Tindex, UserList(Tindex).POS.Map, UserList(Tindex).POS.X, UserList(Tindex).POS.y, False)
        End If
    End If
    Exit Sub
End If

If UCase$(Left$(rdata, 16)) = "/ACEPTCONSECAOS " Then
   If UserList(Userindex).flags.EsConseCaos Or UserList(Userindex).flags.Privilegios = 4 Or UserList(Userindex).flags.Privilegios = 3 Or UserList(Userindex).flags.Privilegios = 2 Then
       rdata = Right$(rdata, Len(rdata) - 16)
       Tindex = NameIndex(rdata)
       If Tindex <= 0 Then
           Call SendData(ToIndex, Userindex, 0, "||Usuario offline" & FONTTYPE_INFO)
       Else
           Call SendData(ToAll, 0, 0, "||" & rdata & " fue aceptado en el Concilio de Arghal." & FONTTYPE_CONSEJOCAOS)
           UserList(Tindex).flags.EsConseCaos = 1
           Call WarpUserChar(Tindex, UserList(Tindex).POS.Map, UserList(Tindex).POS.X, UserList(Tindex).POS.y, False)
       End If
   End If
   Exit Sub
End If

If UCase$(Left$(rdata, 11)) = "/KICKCONSE " Then
    If UserList(Userindex).flags.EsConseReal Or UserList(Userindex).flags.Privilegios = 4 Or UserList(Userindex).flags.Privilegios = 3 Or UserList(Userindex).flags.Privilegios = 2 Then
        rdata = Right$(rdata, Len(rdata) - 11)
        Tindex = NameIndex(rdata)
        If Tindex <= 0 Then
            Call SendData(ToIndex, Userindex, 0, "||Usuario offline" & FONTTYPE_INFO)
        Else
            If UserList(Tindex).flags.EsConseReal = 1 Then
                Call SendData(ToAll, 0, 0, "||" & rdata & " fue echado del honorable Consejo De Banderbill." & FONTTYPE_CONSEJO)
                UserList(Tindex).flags.EsConseReal = 0
                Call WarpUserChar(Tindex, UserList(Tindex).POS.Map, UserList(Tindex).POS.X, UserList(Tindex).POS.y, False)
                Exit Sub
            End If
            If UserList(Tindex).flags.EsConseReal = 0 Then
                Call SendData(ToIndex, Userindex, 0, "||" & rdata & " no es consejero." & FONTTYPE_FENIX)
            End If
        End If
    End If
    Exit Sub
End If

If UCase$(Left$(rdata, 15)) = "/KICKCONSECAOS " Then
If UserList(Userindex).flags.EsConseCaos Or UserList(Userindex).flags.Privilegios = 4 Or UserList(Userindex).flags.Privilegios = 3 Or UserList(Userindex).flags.Privilegios = 2 Then
        rdata = Right$(rdata, Len(rdata) - 15)
        Tindex = NameIndex(rdata)
        If Tindex <= 0 Then
            Call SendData(ToIndex, Userindex, 0, "||Usuario offline" & FONTTYPE_INFO)
        Else
            If UserList(Tindex).flags.EsConseCaos = 1 Then
                Call SendData(ToAll, 0, 0, "||" & rdata & " fue echado del Concilio de Arghal." & FONTTYPE_CONSEJOCAOS)
                UserList(Tindex).flags.EsConseCaos = 0
                Call WarpUserChar(Tindex, UserList(Tindex).POS.Map, UserList(Tindex).POS.X, UserList(Tindex).POS.y, False)
                Exit Sub
            End If
        If UserList(Tindex).flags.EsConseCaos = 0 Then
                Call SendData(ToIndex, Userindex, 0, "||" & rdata & " no pertenece al Concilio." & FONTTYPE_FENIX)
            End If
        End If
    End If
    Exit Sub
End If

If UCase$(Left$(rdata, 11)) = "/KICKCONCI " Then
If UserList(Userindex).flags.EsConcilioNegro Or UserList(Userindex).flags.Privilegios = 4 Or UserList(Userindex).flags.Privilegios = 3 Or UserList(Userindex).flags.Privilegios = 2 Then
        rdata = Right$(rdata, Len(rdata) - 11)
        Tindex = NameIndex(rdata)
        If Tindex <= 0 Then
        Call SendData(ToIndex, Userindex, 0, "||Usuario offline" & FONTTYPE_INFO)
    Else
        If UserList(Tindex).flags.EsConcilioNegro = 1 Then
           ' Call SendData(ToAll, 0, 0, "||" & rdata & " fue echado del Concilio Neutro." & FONTTYPE_CONCILIONEGRO)
            UserList(Tindex).flags.EsConcilioNegro = 0
            Call WarpUserChar(Tindex, UserList(Tindex).POS.Map, UserList(Tindex).POS.X, UserList(Tindex).POS.y, False)
        Exit Sub
        End If
        If UserList(Tindex).flags.EsConcilioNegro = 0 Then
        Call SendData(ToIndex, Userindex, 0, "||" & rdata & " no es del Gladiador." & FONTTYPE_FENIX)
    End If
        End If
    End If
    Exit Sub
End If

If UCase$(Left$(rdata, 7)) = "/STAFF " Then
    rdata = Right$(rdata, Len(rdata) - 7)
    If UserList(Userindex).flags.EsConseReal Or UserList(Userindex).flags.EsConseCaos Or UserList(Userindex).flags.EsConcilioNegro Or UserList(Userindex).flags.Privilegios = 4 Or UserList(Userindex).flags.Privilegios = 3 Or UserList(Userindex).flags.Privilegios = 2 Or UserList(Userindex).flags.Privilegios = 1 Then
    If Len(rdata) > 0 Then
        Call SendData(ToConci, 0, 0, "||" & UserList(Userindex).Name & "> " & rdata & "~255~255~255~0~1")
        Call SendData(ToConse, 0, 0, "||" & UserList(Userindex).Name & "> " & rdata & "~255~255~255~0~1")
        Call SendData(ToAdmins, 0, 0, "||" & UserList(Userindex).Name & "> " & rdata & "~255~255~255~0~1")
         Call LogGM(UserList(Userindex).Name, "Staff:" & rdata, False)
    End If
    End If
    Exit Sub
End If

If UCase$(Left$(rdata, 14)) = "/REINCORPORAR " Then
         rdata = Right$(rdata, Len(rdata) - 14)
          If UserList(Userindex).flags.EsConseCaos Then
          Tindex = NameIndex(rdata)
          If Tindex = 0 Then
          Call SendData(ToIndex, Userindex, 0, "||Usuario offline." & FONTTYPE_INFO)
          End If
          If UserList(Tindex).Faccion.Bando = Real Then
          Call SendData(ToIndex, Userindex, 0, "||El bando del usuario " & rdata & " no es bienvenido en la facción criminal. [Notificación enviada al staff]" & FONTTYPE_FIGHTT)
          Call LogGM(UserList(Userindex).Name, "Intento reincorporar a un ciudadano : " & rdata, False)
          End If
          If UserList(Tindex).Faccion.Bando = Neutral Then
          UserList(Tindex).Faccion.Bando = 2
          Call SendData(ToAll, Userindex, 0, "||Concilio de Arghal [" & UserList(Userindex).Name & "] Reincorporo a " & rdata & " para el bando criminal." & FONTTYPE_FIGHTT)
          Call LogGM(UserList(Userindex).Name, "Reincorporo a : " & rdata, False)
          End If
          Exit Sub
          End If
          If UserList(Userindex).flags.EsConseReal Then
          Tindex = NameIndex(rdata)
          If Tindex = 0 Then
          Call SendData(ToIndex, Userindex, 0, "||Usuario offline." & FONTTYPE_INFO)
          End If
          If UserList(Tindex).Faccion.Bando = Caos Then
          Call SendData(ToIndex, Userindex, 0, "||El bando del usuario " & rdata & " no es bienvenido en la facción ciudadana. [Notificación enviada al staff]" & FONTTYPE_ProtectorCiu)
          Call LogGM(UserList(Userindex).Name, "Intento reincorporar a un criminal : " & rdata, False)
          End If
          If UserList(Tindex).Faccion.Bando = Neutral Then
          UserList(Tindex).Faccion.Bando = 1
          Call SendData(ToAll, Userindex, 0, "||Consejo de banderbill [" & UserList(Userindex).Name & "] Reincorporo a " & rdata & " para el bando ciudadano." & FONTTYPE_ProtectorCiu)
          Call LogGM(UserList(Userindex).Name, "Reincorporo a : " & rdata, False)
          End If
          Exit Sub
          End If
    End If
          
        If UCase$(Left$(rdata, 14)) = "/ECHARFACCION " Then
          rdata = Right$(rdata, Len(rdata) - 14)
          If UserList(Userindex).flags.EsConseReal Then
          Tindex = NameIndex(rdata)
          If Tindex <= 0 Then
          Call SendData(ToIndex, Userindex, 0, "||Usuario offline." & FONTTYPE_INFO)
          End If
          If UserList(Tindex).Faccion.Bando = Caos Then
          Call SendData(ToIndex, Userindex, 0, "||No puedes echar a un miembro del bando criminal. [Esta notificación fue enviada al staff]." & FONTTYPE_FIGHTT)
          Call LogGM(UserList(Userindex).Name, "Intento echar a un criminal : " & rdata, False)
          End If
          If UserList(Tindex).Faccion.Bando = Real Then
          UserList(Tindex).Faccion.Bando = 0
          Call SendData(ToAll, Userindex, 0, "||Consejo de banderbill [" & UserList(Userindex).Name & "] " & "echó a " & rdata & " del bando ciudadano." & FONTTYPE_ProtectorCiu)
          Call LogGM(UserList(Userindex).Name, "Echo de la faccion a : " & rdata, False)
          End If
          Exit Sub
          End If
          If UserList(Userindex).flags.EsConseCaos Then
          Tindex = NameIndex(rdata)
          If Tindex <= 0 Then
          Call SendData(ToIndex, Userindex, 0, "||Usuario offline." & FONTTYPE_INFO)
          End If
          If UserList(Tindex).Faccion.Bando = Real Then
          Call SendData(ToIndex, Userindex, 0, "||No puedes echar a un miembro del bando ciudadano. [Esta notificación fue enviada al staff]." & FONTTYPE_ProtectorCiu)
          Call LogGM(UserList(Userindex).Name, "Intento echar a un ciudadano : " & rdata, False)
          End If
          If UserList(Tindex).Faccion.Bando = Caos Then
          UserList(Tindex).Faccion.Bando = 0
          Call SendData(ToAll, Userindex, 0, "||Concilio de Arghal [" & UserList(Userindex).Name & "] " & "echó a " & rdata & " del bando criminal." & FONTTYPE_FIGHTT)
          Call LogGM(UserList(Userindex).Name, "Echo de la faccion a : " & rdata, False)
          End If
          Exit Sub
          End If
          End If

 If UCase$(Left$(rdata, 9)) = "/REGRESAR" Then
        rdata = Right$(rdata, Len(rdata) - 9)
        If UserList(Userindex).flags.Muerto = 0 Then Exit Sub
        If MapInfo(UserList(Userindex).POS.Map).EsMapaEspecial Then Exit Sub
        Call CiudadNatal(Userindex)
        Call SendData(ToIndex, Userindex, 0, "||Has vuelto a la ciudad." & FONTTYPE_INFO)
        Exit Sub
        End If
        
 If UCase$(Left$(rdata, 11)) = "/RESPUESTA " Then
        rdata = Right$(rdata, Len(rdata) - 11)
        If HayPreg = False Then
        Call SendData(ToIndex, Userindex, 0, "||En este momento no hay ninguna pregunta." & FONTTYPE_INFO)
        ElseIf Not UCase$(rdata) = UCase$(Respuesta) Then
        Call SendData(ToIndex, Userindex, 0, "||La respuesta es incorrecta." & FONTTYPE_INFO)
        Else
        Call SendData(ToAll, 0, 0, "||[Preguntas automáticas] " & UserList(Userindex).Name & " respondio correctamente gana 100.000 monedas de oro." & FONTTYPE_FENIZ)
        UserList(Userindex).Stats.GLD = UserList(Userindex).Stats.GLD + 100000
        Call SendUserStatsBox(Userindex)
        Pista = ""
        HayPreg = False
        Preg = ""
        Respuesta = ""
        Exit Sub
        End If
        End If

 If UCase$(Left$(rdata, 10)) = "/CASTILLOS" Then
    rdata = Right$(rdata, Len(rdata) - 10)
    Call SendData(ToIndex, Userindex, 0, "||El castillo pertecene al clan ' " & GetVar(App.Path & "\Dat\Castillitos.Siam", "CASTILLOS", "ClanCastillo") & " ' Oro Acumulado: " & HonorA & "." & FONTTYPE_INFO)
    Call SendData(ToIndex, Userindex, 0, "||El castillo acumulara oro en: " & MinutosBComando & " minutos." & FONTTYPE_INFO)
    Exit Sub
    End If
        
   If UCase$(Left$(rdata, 9)) = "/TPAREJA " Then
        rdata = Right$(rdata, Len(rdata) - 9)
        Tindex = NameIndex(ReadField(1, rdata, 32))
        If (Torneo_ActivoX) Then
        If UserList(Userindex).flags.EnReto Then Exit Sub
        If UserList(Userindex).Stats.ELV < 40 Then
        Call SendData(ToIndex, Userindex, 0, "||Debes ser nivel 40." & FONTTYPE_INFO)
        Exit Sub
        End If

        If UserList(Userindex).PartyIndex > 0 And MOD_EVENTO_Retos3vs3.EsPartyInscripto(UserList(Userindex).PartyIndex) = True Then
        Call SendData(ToIndex, Userindex, 0, "||Error: Estás anotado para 3vs3." & FONTTYPE_RETOS)
        Exit Sub
        End If
    
        If UserList(Userindex).POS.Map = 99 Then Exit Sub

        If MapInfo(UserList(Userindex).POS.Map).Pk = True Then
        Call SendData(ToIndex, Userindex, 0, "||Debes estar en una ciudad" & FONTTYPE_TALK)
        Exit Sub
        End If
          
        If Tindex <= 0 Then
        Call SendData(ToIndex, Userindex, 0, "||Usuario offline." & FONTTYPE_INFO)
        Exit Sub
        End If
        
        If UserList(Tindex).POS.Map = 99 Then
        Call SendData(ToIndex, Userindex, 0, "||El usuario ya esta en 2vs2." & FONTTYPE_INFO)
        Exit Sub
        End If
         
        If Tindex = Userindex Then
        Call SendData(ToIndex, Userindex, 0, "||No puedes formar pareja contigo mismo" & FONTTYPE_INFO)
        Exit Sub
        End If
       
        If UserList(Userindex).flags.Muerto = 1 Then
        Call SendData(ToIndex, Userindex, 0, "||¡Estas muerto!" & FONTTYPE_INFO)
        Exit Sub
        End If
       
          UserList(Tindex).flags.Parejado2vs2 = Userindex
          UserList(Userindex).flags.parejadel2v2 = Tindex
    Call SendData(ToIndex, Userindex, 0, "||Torneo Automático> Has pedido ser pareja a " & UserList(Tindex).Name & "." & FONTTYPE_TALK)
    Call SendData(ToIndex, Tindex, 0, "||" & UserList(Userindex).Name & " te ha pedido ser su pareja para el torneo 2vs2. /ACEPTAR" & FONTTYPE_TALK)
         Exit Sub
         End If
         End If
         
If UCase$(rdata) = "/ACEPTAR" Then
If (Torneo_ActivoX) Then
If UserList(Userindex).flags.Muerto = 1 Then Exit Sub
If UserList(Userindex).flags.Parejado2vs2 = 0 Then Exit Sub
If UserList(UserList(Userindex).flags.Parejado2vs2).flags.Muerto = 1 Then Exit Sub

       If UserList(Userindex).flags.EnReto Then Exit Sub
         If UserList(Userindex).Stats.ELV < 40 Then
         Call SendData(ToIndex, Userindex, 0, "||Debes ser nivel 40." & FONTTYPE_INFO)
            Exit Sub
       End If

         If UserList(Userindex).PartyIndex > 0 And MOD_EVENTO_Retos3vs3.EsPartyInscripto(UserList(Userindex).PartyIndex) = True Then
         Call SendData(ToIndex, Userindex, 0, "||Error: Estás anotado para 3vs3." & FONTTYPE_RETOS)
            Exit Sub
       End If
         
       If UserList(Userindex).POS.Map = 99 Then Exit Sub
        
        If UserList(UserList(Userindex).flags.Parejado2vs2).POS.Map = 99 Then
        Call SendData(ToIndex, Userindex, 0, "||El usuario ya esta en 2vs2." & FONTTYPE_INFO)
            Exit Sub
       End If
        
    If MapInfo(UserList(Userindex).POS.Map).Pk = True Then
    Call SendData(ToIndex, Userindex, 0, "||Debes estar en una ciudad" & FONTTYPE_TALK)
    Exit Sub
    End If

If UserList(UserList(Userindex).flags.Parejado2vs2).flags.UserLogged = False Then Exit Sub

UserList(Userindex).flags.pareja2vs2 = UserList(Userindex).flags.Parejado2vs2
UserList(UserList(Userindex).flags.Parejado2vs2).flags.pareja2vs2 = Userindex
UserList(UserList(Userindex).flags.Parejado2vs2).flags.EstaTorneoAuto2vs2 = True

Call Torneos_Entra2vs2(Userindex)
Call SendData(ToIndex, Userindex, 0, "||Torneo Automático> Has aceptado ser la pareja de " & UserList(UserList(Userindex).flags.Parejado2vs2).Name & "." & FONTTYPE_TALK)
Call SendData(ToIndex, UserList(Userindex).flags.Parejado, 0, "||" & UserList(Userindex).Name & " ha aceptado ser tu pareja para el torneo 2vs2." & FONTTYPE_TALK)
Exit Sub
End If
End If

'SOPORTEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
If UserList(Userindex).flags.Privilegios < 1 Then Exit Sub 'SOPORTEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
'SOPORTEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE

If UCase$(Left$(rdata, 10)) = "/LEERCLAN " Then
    rdata = Right$(rdata, Len(rdata) - 10)
    GMClan = rdata
    UserList(Userindex).GuildInfo.GuildName = ""
    Call SendData(ToIndex, Userindex, 0, "||Te uniste al clan para leerlo, para salir tipeá el mismo comando con el nombre de tu clan." & FONTTYPE_INFO)
    Exit Sub
End If

'EVENTOSSSSSSSS
If UserList(Userindex).flags.Privilegios < 2 Then Exit Sub 'EVENTOSSSSSSSS
'EVENTOSSSSSSSS

If UCase$(rdata) = "/RESP" Then
    If HayPreg = False Then
    Call SendData(ToIndex, Userindex, 0, "||En este momento no hay ninguna pregunta." & FONTTYPE_INFO)
    Else
    Call SendData(ToIndex, Userindex, 0, "||Admin's: Pregunta " & Preg & " Respuesta: " & Respuesta & "." & FONTTYPE_FENIZ)
Exit Sub
End If
End If

If UCase$(Left$(rdata, 9)) = "/PISTAGM " Then
    rdata = Right$(rdata, Len(rdata) - 9)
    If HayPreg = False Then
    Call SendData(ToIndex, Userindex, 0, "||En este momento no hay ninguna pregunta." & FONTTYPE_INFO)
    Else
    Pista = rdata
    Call SendData(ToAll, 0, 0, "||[Preguntas automáticas] Pista: '" & Pista & "'" & FONTTYPE_FENIZ)
    Exit Sub
End If
End If

If UCase$(Left$(rdata, 6)) = "/PREG " Then
    rdata = Right$(rdata, Len(rdata) - 6)
    Preg = ReadField(1, rdata, 64)
    Respuesta = ReadField(2, rdata, 64)
    If HayPreg = True Then
    Call SendData(ToIndex, Userindex, 0, "||En este momento ya hay una pregunta, Tipea /FINPREG." & FONTTYPE_INFO)
    ElseIf UCase$(Preg) = "" Then
    Call SendData(ToIndex, Userindex, 0, "||Debes escribir una pregunta." & FONTTYPE_INFO)
    ElseIf UCase$(Respuesta) = "" Then
    Call SendData(ToIndex, Userindex, 0, "||Debes escribir una respuesta." & FONTTYPE_INFO)
    Else
    Call SendData(ToAdmins, 0, 0, "||Admin's Pregunta: ¿" & Preg & "? Respuesta: " & Respuesta & FONTTYPE_INFO)
    Call SendData(ToAll, 0, 0, "||[Preguntas automáticas] ¿" & Preg & "? Para responder escribe /RESPUESTA." & FONTTYPE_FENIZ)
    HayPreg = True
    Exit Sub
    End If
End If

'ADMINNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
If UserList(Userindex).flags.Privilegios < 3 Then Exit Sub 'ADMINNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
'ADMINNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN

If UCase$(Left$(rdata, 6)) = "/DONO " Then
rdata = Right$(rdata, Len(rdata) - 6)
Tindex = NameIndex(ReadField(1, rdata, 32))
arg1 = ReadField(2, rdata, 32)
arg2 = Replace$(ReadField(1, rdata, 32), "+", " ")
   If Len(arg1) = 0 Or Len(arg2) Then
        Call SendData(ToIndex, Userindex, 0, "||La estructura del comando es /DONO NICK+COMPLETO 200(SIN el $)" & FONTTYPE_FENIX)
    End If
Call UsuarioDono(Userindex, Tindex, arg1, arg2)
Exit Sub
End If

If UCase$(Left$(rdata, 7)) = "/NOMANA" Then
    rdata = Right$(rdata, Len(rdata) - 7)
    UserList(Userindex).Stats.MinMAN = 0
    Call SendUserMANA(Userindex)
    Exit Sub
End If
    
If UCase$(rdata) = "/DIE" Then
    Call UserDie(Userindex)
    Exit Sub
End If

If UCase$(Left$(rdata, 7)) = "/SEGURO" Then
        If MapInfo(UserList(Userindex).POS.Map).Pk = True Then
            MapInfo(UserList(Userindex).POS.Map).Pk = False
            Call SendData(ToIndex, Userindex, 0, "||Ahora es zona segura." & FONTTYPE_INFO)
            Exit Sub
        Else
            MapInfo(UserList(Userindex).POS.Map).Pk = True
            Call SendData(ToIndex, Userindex, 0, "||Ahora es zona insegura." & FONTTYPE_INFO)
            Exit Sub
        End If
        Exit Sub
End If

'SUPERADMMMMMMMM
If UserList(Userindex).flags.Privilegios < 4 Then Exit Sub 'SUPERADMMMMMMMMMMMMMMMMMMMMMMM
'SUPERADMMMMMMMM

If UCase$(Left$(rdata, 8)) = "/KBTODOS" Then
Call SendData(ToAll, 0, 0, "JD")
Call SendData(ToAdmins, 0, 0, "||Admin's: Cierre ao a todos." & FONTTYPE_gms)
    Exit Sub
End If

If UCase$(rdata) = "/DATS" Then
    Call SendData(ToAdmins, 0, 0, "||Admin's: " & UserList(Userindex).Name & " Actualizo los dats y los intervalos de seguridad." & FONTTYPE_gms)
    Call CargarHechizos
    Call LoadOBJData
    Call DescargaNpcsDat
    Call CargaNpcsDat
    Call CargarMods
    Call CargarPremiosList 'canjeos
    
    IntervaloCaminar = val(GetVar(IniPath & "Server.ini", "INTERVALOS", "IntervaloCaminar")) / 10
    IntervaloPocionesSEGURIDAD = val(GetVar(IniPath & "Server.ini", "INTERVALOS", "IntervaloPocionesSEGURIDAD")) / 10
    IntervaloPociones = val(GetVar(IniPath & "Server.ini", "INTERVALOS", "IntervaloPociones")) / 10
    Exit Sub
End If

If UCase$(Left$(rdata, 5)) = "/NPC " Then
        If UserList(Userindex).flags.TargetNpc > 0 Then
            tStr = Right$(rdata, Len(rdata) - 5)
            Call SendData(ToNPCArea, UserList(Userindex).flags.TargetNpc, Npclist(UserList(Userindex).flags.TargetNpc).POS.Map, "||" & vbWhite & "°" & tStr & "°" & CStr(Npclist(UserList(Userindex).flags.TargetNpc).Char.CharIndex))
            Call LogGM(UserList(Userindex).Name, "Dijo x NPC: " & tStr, False)
       Else
        Call SendData(ToIndex, Userindex, 0, "||Debes seleccionar el NPC por el que quieres hablar antes de usar este comando." & FONTTYPE_INFO)
        End If
   Exit Sub
End If

If UCase$(Left$(rdata, 6)) = "/USER " Then
     tStr = Right$(rdata, Len(rdata) - 6)
        If UserList(Userindex).flags.TargetUser > 0 Then
            Call SendData(ToPCArea, UserList(Userindex).flags.TargetUser, UserList(UserList(Userindex).flags.TargetUser).POS.Map, "||" & vbWhite & "°" & tStr & "°" & CStr(UserList(UserList(Userindex).flags.TargetUser).Char.CharIndex))
            Call LogGM(UserList(Userindex).Name, "Dijo x Usuario: " & tStr, False)
        Else
            Call SendData(ToIndex, Userindex, 0, "||Debes seleccionar el usuario por el que quieres hablar antes de usar este comando." & FONTTYPE_INFO)
        End If
End If

Exit Sub



ErrorHandler:
' Call LogError("HandleData3. CadOri:" & CadenaOriginal & " Nom:" & UserList(UserIndex).Name & " UI:" & UserIndex & " N: " & Err.Number & " D: " & Err.Description)
' Call Cerrar_Usuario(UserIndex)
End Sub



