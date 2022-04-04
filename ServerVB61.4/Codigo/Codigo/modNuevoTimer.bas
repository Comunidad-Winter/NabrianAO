Attribute VB_Name = "modNuevoTimer"
 
'director del proyecto: #Esteban(Neliam)

'servidor basado en fénixao 1.0
'medios de contacto:
'Skype: dc.esteban
'E-mail: nabrianao@gmail.com
Option Explicit

Declare Function SetTimer Lib "user32" (ByVal hwnd As Long, ByVal nIDEvent As Long, ByVal uElapse As Long, ByVal lpTimerFunc As Long) As Long
Declare Function KillTimer Lib "user32" (ByVal hwnd As Long, ByVal nIDEvent As Long) As Long
Private Declare Function MoveFile Lib "kernel32" Alias "MoveFileA" (ByVal lpExistingFileName As String, ByVal lpNewFileName As String) As Long

Dim hGameTimer As Long
Dim hNpcCanAttack As Long
Dim hNpcAITimer As Long
Dim hAutoTimer As Long
Public Sub NpcAITimer(Enabled As Boolean)
On Error GoTo Error

If Enabled Then
    If hNpcAITimer Then KillTimer 0, hNpcAITimer
    hNpcAITimer = SetTimer(0, 0, 420, AddressOf NpcAITimerProc)
Else
    If hNpcAITimer = 0 Then Exit Sub
    KillTimer 0, hNpcAITimer
    hNpcAITimer = 0
End If

Exit Sub
Error:
    Call LogError("Error en NpcAiTimer: " & Err.Description)
End Sub
Sub NpcAITimerProc(ByVal hwnd As Long, ByVal hEvent As Long, ByVal TimerID As Long, ByVal lpTimerFunc As Long)
On Error GoTo ErrorHandler
Dim NpcIndex As Integer
Dim X As Integer
Dim y As Integer
Dim UseAI As Integer

If Not haciendoBK Then
    For NpcIndex = 1 To LastNPC
        If Npclist(NpcIndex).flags.NPCActive Then
           If Npclist(NpcIndex).flags.Paralizado = 0 Then
                If Npclist(NpcIndex).POS.Map Then
                     If MapInfo(Npclist(NpcIndex).POS.Map).NumUsers And Npclist(NpcIndex).Movement <> ESTATICO Then Call NPCMovementAI(NpcIndex)
                End If
           ElseIf Npclist(NpcIndex).flags.Paralizado = 2 Then Call NPCAtacaAlFrente(NpcIndex)
           End If
        End If
    Next
End If

Exit Sub

ErrorHandler:
 Call LogError("Error en TIMER_AI_Timer " & Npclist(NpcIndex).Name & " mapa:" & Npclist(NpcIndex).POS.Map)
 Call MuereNpc(NpcIndex, 0)

End Sub
Public Sub NpcCanAttack(Enabled As Boolean)
On Error GoTo Error

If Enabled Then
    If hNpcCanAttack Then KillTimer 0, hNpcCanAttack
    hNpcCanAttack = SetTimer(0, 0, 3000, AddressOf NpcCanAttackProc)
Else
    If hNpcCanAttack = 0 Then Exit Sub
    KillTimer 0, hNpcCanAttack
    hNpcCanAttack = 0
End If

Exit Sub
Error:
    Call LogError("Error en NpcCanAttack: " & Err.Description)
    
End Sub
Sub NpcCanAttackProc(ByVal hwnd As Long, ByVal hEvent As Long, ByVal TimerID As Long, ByVal lpTimerFunc As Long)
Dim Npc As Integer
On Error GoTo Error
    
For Npc = 1 To LastNPC
    If Npclist(Npc).flags.NPCActive And Npclist(Npc).POS.Map Then
        If Npclist(Npc).Numero <> 89 Then Npclist(Npc).CanAttack = 1
        If Npclist(Npc).flags.Paralizado Then Call EfectoParalisisNpc(Npc)
    End If
Next Npc

Exit Sub
Error:
    Call LogError("Error en NpcCanAttackProc: " & Err.Description)
End Sub
Public Sub AutoTimer(Enabled As Boolean)
On Error GoTo Error

If Enabled Then
    If hAutoTimer Then KillTimer 0, hAutoTimer
    hAutoTimer = SetTimer(0, 0, 60000, AddressOf AutoTimerProc)
Else
    If hAutoTimer = 0 Then Exit Sub
    KillTimer 0, hAutoTimer
    hAutoTimer = 0
End If
Exit Sub
Error:
Call LogError("Error en AutoTimer:" & Err.Description)

End Sub
Public Sub EfectoParalisisNpc(NpcIndex As Integer)

If Npclist(NpcIndex).Contadores.Paralisis Then
    Npclist(NpcIndex).Contadores.Paralisis = Npclist(NpcIndex).Contadores.Paralisis - 2
Else
    Npclist(NpcIndex).flags.Paralizado = 0
    Npclist(NpcIndex).flags.QuienParalizo = 0
End If

End Sub
Sub RegistrarDataDia()
On Error GoTo ErrHandler
Dim FileAntiguo As String

FileAntiguo = App.Path & "\LOGS\Data " & Format(Now - 7, "dd-mm") & ".log"
If FileExist(FileAntiguo, vbNormal) Then Call Kill(FileAntiguo)

Dim nfile As Integer
nfile = FreeFile

Open App.Path & "\LOGS\Data\Data " & Format(Now, "dd-mm") & ".log" For Append Shared As #nfile
Print #nfile, "### " & Format(Now, "dd/mm") & " ###"
Print #nfile, "Enviada: " & Data(dia, actual, Enviada, Mensages) & "/" & Data(dia, actual, Enviada, Letras) & "(" & Round(Data(dia, actual, Enviada, Letras) / 1048576, 2) & " mb)"
Print #nfile, "Recibida: " & Data(dia, actual, Recibida, Mensages) & "/" & Data(dia, actual, Recibida, Letras) & "(" & Round(Data(dia, actual, Recibida, Letras) / 1048576, 2) & " mb)"
Print #nfile, "Users Online: " & Round(Onlines(dia) / 1440, 2)
Print #nfile, ""
Close #nfile

Exit Sub
ErrHandler:

End Sub
Sub RegistrarData()
On Error GoTo ErrHandler
Dim FileAntiguo As String

FileAntiguo = App.Path & "\LOGS\Data " & Format(Now - 7, "dd-mm") & ".log"
If FileExist(FileAntiguo, vbNormal) Then Call Kill(FileAntiguo)

Dim nfile As Integer
nfile = FreeFile

Open App.Path & "\LOGS\Data\Data " & Format(Now, "dd-mm") & ".log" For Append Shared As #nfile
Print #nfile, "### " & Format(Now - 1 / 24, "hh:mm") & "-" & Format(Now, "hh:mm") & " ###"
Print #nfile, "Enviada: " & Data(hora, actual, Enviada, Mensages) & "/" & Data(hora, actual, Enviada, Letras) & "(" & Round(Data(hora, actual, Enviada, Letras) / 1048576, 2) & " mb)"
Print #nfile, "Recibida: " & Data(hora, actual, Recibida, Mensages) & "/" & Data(hora, actual, Recibida, Letras) & "(" & Round(Data(hora, actual, Recibida, Letras) / 1048576, 2) & " mb)"
Print #nfile, "Users Online: " & Round(Onlines(actual) / 60, 2)
Print #nfile, ""
Close #nfile

Exit Sub
ErrHandler:

End Sub
Sub PasarDataDia()

Call RegistrarDataDia


Data(dia, actual, Recibida, Mensages) = 0
Data(dia, actual, Recibida, Letras) = 0

Data(dia, actual, Enviada, Mensages) = 0
Data(dia, actual, Enviada, Letras) = 0

Onlines(dia) = 0

End Sub
Sub PasarDataHora()

Call RegistrarData


Data(dia, actual, Recibida, Mensages) = Data(dia, actual, Recibida, Mensages) + Data(hora, actual, Recibida, Mensages)
Data(dia, actual, Recibida, Letras) = Data(dia, actual, Recibida, Letras) + Data(hora, actual, Recibida, Letras)

Data(dia, actual, Enviada, Mensages) = Data(dia, actual, Enviada, Mensages) + Data(hora, actual, Enviada, Mensages)
Data(dia, actual, Enviada, Letras) = Data(dia, actual, Enviada, Letras) + Data(hora, actual, Enviada, Letras)

Onlines(Last) = Onlines(actual)
Onlines(dia) = Onlines(dia) + Onlines(actual)


Data(hora, Last, Recibida, Mensages) = Data(hora, actual, Recibida, Mensages)
Data(hora, Last, Recibida, Letras) = Data(hora, actual, Recibida, Letras)

Data(hora, Last, Enviada, Mensages) = Data(hora, actual, Enviada, Mensages)
Data(hora, Last, Enviada, Letras) = Data(hora, actual, Enviada, Letras)


Data(hora, actual, Recibida, Mensages) = 0
Data(hora, actual, Recibida, Letras) = 0

Data(hora, actual, Enviada, Mensages) = 0
Data(hora, actual, Enviada, Letras) = 0

Onlines(actual) = 0

End Sub
Sub PasarDataMinuto()


Data(hora, actual, Recibida, Mensages) = Data(hora, actual, Recibida, Mensages) + Data(minuto, actual, Recibida, Mensages)
Data(hora, actual, Recibida, Letras) = Data(hora, actual, Recibida, Letras) + Data(minuto, actual, Recibida, Letras)

Data(hora, actual, Enviada, Mensages) = Data(hora, actual, Enviada, Mensages) + Data(minuto, actual, Enviada, Mensages)
Data(hora, actual, Enviada, Letras) = Data(hora, actual, Enviada, Letras) + Data(minuto, actual, Enviada, Letras)

Onlines(actual) = Onlines(actual) + NumUsers


Data(minuto, Last, Recibida, Mensages) = Data(minuto, actual, Recibida, Mensages)
Data(minuto, Last, Recibida, Letras) = Data(minuto, actual, Recibida, Letras)

Data(minuto, Last, Enviada, Mensages) = Data(minuto, actual, Enviada, Mensages)
Data(minuto, Last, Enviada, Letras) = Data(minuto, actual, Enviada, Letras)


Data(minuto, actual, Recibida, Mensages) = 0
Data(minuto, actual, Recibida, Letras) = 0

Data(minuto, actual, Enviada, Mensages) = 0
Data(minuto, actual, Enviada, Letras) = 0

End Sub
Sub AutoTimerProc(ByVal hwnd As Long, ByVal hEvent As Long, ByVal TimerID As Long, ByVal lpTimerFunc As Long)
Static Minutos As Long
Static minutosasdasd As Long
Static MinsSocketReset As Long
Static MinsPjesSave As Long
Static MinutosCodigoTrabajar As Long
Dim i As Integer
Static MinWSLargo As Long
On Error GoTo ErrHandler

Call ComprobarCerrar

For i = 1 To Baneos.Count
    If Baneos(i).FechaLiberacion <= Now Then
        Call SendData(ToAdmins, 0, 0, "||Se ha concluido la sentencia de ban de " & Baneos(i).Name & "." & FONTTYPE_FIGHT)
        Call ChangeBan(Baneos(i).Name, 0)
        Call Baneos.Remove(i)
        Call SaveBans
    End If
Next

If Len(MensajeRepeticion) > 0 Then
    If TiempoRepeticion > 0 Then
        TiempoRepeticion = TiempoRepeticion - 1
        If TiempoRepeticion Mod IntervaloRepeticion = 0 Then Call SendData(ToAll, 0, 0, "||" & MensajeRepeticion & FONTTYPE_TALK & ENDC)
        If TiempoRepeticion = 0 Then
            Call SendData(ToAdmins, 0, 0, "||Se ha terminado la repetición del mensaje: " & MensajeRepeticion & "." & FONTTYPE_FENIX)
            IntervaloRepeticion = 0
            MensajeRepeticion = ""
        End If
    Else
        TiempoRepeticion = TiempoRepeticion + 1
        If TiempoRepeticion Mod IntervaloRepeticion = 0 Then Call SendData(ToAll, 0, 0, "||" & MensajeRepeticion & FONTTYPE_TALK & ENDC)
        If TiempoRepeticion = 0 Then TiempoRepeticion = -IntervaloRepeticion
    End If
End If
    
Minutos = Minutos + 1
MinWSLargo = MinWSLargo + 1
minutosasdasd = minutosasdasd + 1

Call MostrarNumUsers

If MinWSLargo = 240 Then
Call SendData(ToAll, 0, 0, "||se realizara un mantenimiento en 1 minuto." & FONTTYPE_WARNING)
ElseIf MinWSLargo >= 241 Then
    Call DoBackUp(True)
    MinWSLargo = 0
    Minutos = 0
End If

If minutosasdasd >= 10 Then
    Call aClon.VaciarColeccion
    minutosasdasd = 0
End If

If Minutos = 120 Then
Call SendData(ToAll, 0, 0, "||se realizara un mantenimiento en 1 minuto." & FONTTYPE_WARNING)
ElseIf Minutos >= 121 Then
    Call DoBackUp
    Minutos = 0
End If

If Time >= #12:00:00 AM# And Time <= #12:00:01 AM# And Worldsaves Then
    Call SendData(ToAll, 0, 0, "||Un nuevo día ha comenzado..." & FONTTYPE_FENIX)
    Call SaveDayStats
    DayStats.MaxUsuarios = 0
    DayStats.segundos = 0
    DayStats.Promedio = 0
    Call DayElapsed
End If


If Time >= #12:00:00 PM# And Time <= #12:00:01 PM# Then
If DiosHades = 0 Then
  Dim iiee As WorldPos
  iiee.Map = 91
  iiee.X = 50
  iiee.y = 50
  Call SendData(ToAll, 0, 0, "||Ha Renacido Hades en Ultratumba." & FONTTYPE_FIGHT)
  Call SpawnNpc(237, iiee, True, False)
  DiosHades = 1
  Call SendData(ToAll, 0, 0, "TW" & 124)
End If
ElseIf Time >= #7:00:00 PM# And Time <= #7:00:01 PM# Then
  'Call SendData(ToAll, 0, 0, "||HappyHour> Experiencia x35 y oro x20 hasta las 20:00 horas." & FONTTYPE_ORO)
  'HappyHourExp = 1
ElseIf Time >= #8:00:00 PM# And Time <= #8:00:01 PM# Then
  'Call SendData(ToAll, 0, 0, "||HappyHour> Terminado." & FONTTYPE_ORO)
  'HappyHourExp = 0
End If

If Time >= #7:00:00 AM# And Time <= #9:59:59 AM# Then
TiempoReal = 195
ElseIf Time >= #10:00:00 AM# And Time <= #11:59:59 AM# Then
TiempoReal = 220
ElseIf Time >= #12:00:00 PM# And Time <= #4:59:59 PM# Then
TiempoReal = 220
ElseIf Time >= #5:00:00 PM# And Time <= #8:59:59 PM# Then
TiempoReal = 210
ElseIf Time >= #9:00:00 PM# And Time <= #11:59:59 PM# Then
TiempoReal = 200
ElseIf Time >= #12:00:00 AM# And Time <= #6:59:59 AM# Then
TiempoReal = 190
End If



Dim N As Integer
N = FreeFile(1)
Open App.Path & "\LOGS\numusers.log" For Output Shared As N
Print #N, NumUsers
Close #N

Exit Sub
ErrHandler:
    Call LogError("Error en TimerAutoSave")

End Sub
Public Sub ComprobarCerrar()

If val(GetVar(App.Path & "\Executor.ini", "EXECUTOR", "Cerrar")) = 1 Then
    Call LogMain(" Server apagado por el Executor.")
    Call WriteVar(App.Path & "\Executor.ini", "EXECUTOR", "Cerrar", 0)
    Call DoBackUp(True)
    Call SaveGuildsNew
    End
End If

End Sub

Sub ControlarPortalLum(ByVal Userindex As Integer)
   Dim Mapa As Integer
Dim X As Integer
Dim y As Integer
Dim i As Integer
 
          Mapa = UserList(Userindex).flags.DondeTiroMap
X = UserList(Userindex).flags.DondeTiroX
y = UserList(Userindex).flags.DondeTiroY
            MapData(Mapa, X, y).TileExit.Map = 0
            MapData(Mapa, X, y).TileExit.X = 0
            MapData(Mapa, X, y).TileExit.y = 0
        Call EraseObj(ToMap, 0, UserList(Userindex).flags.DondeTiroMap, MapData(UserList(Userindex).flags.DondeTiroMap, UserList(Userindex).flags.DondeTiroX, UserList(Userindex).flags.DondeTiroY).OBJInfo.Amount, UserList(Userindex).flags.DondeTiroMap, UserList(Userindex).flags.DondeTiroX, UserList(Userindex).flags.DondeTiroY) 'verificamos que destruye el objeto anterior.
       ' MapData(UserList(UserIndex).flags.DondeTiroMap, UserList(UserIndex).flags.DondeTiroX, UserList(UserIndex).flags.DondeTiroY).TileExit.Map = 0
        'MapData(UserList(UserIndex).flags.DondeTiroMap, UserList(UserIndex).flags.DondeTiroX, UserList(UserIndex).flags.DondeTiroY).TileExit.X = 0
        'MapData(UserList(UserIndex).flags.DondeTiroMap, UserList(UserIndex).flags.DondeTiroX, UserList(UserIndex).flags.DondeTiroY).TileExit.Y = 0
End Sub
