Attribute VB_Name = "modGeneral"
Option Explicit

Public Type typDevMODE
    dmDeviceName       As String * 32
    dmSpecVersion      As Integer
    dmDriverVersion    As Integer
    dmSize             As Integer
    dmDriverExtra      As Integer
    dmFields           As Long
    dmOrientation      As Integer
    dmPaperSize        As Integer
    dmPaperLength      As Integer
    dmPaperWidth       As Integer
    dmScale            As Integer
    dmCopies           As Integer
    dmDefaultSource    As Integer
    dmPrintQuality     As Integer
    dmColor            As Integer
    dmDuplex           As Integer
    dmYResolution      As Integer
    dmTTOption         As Integer
    dmCollate          As Integer
    dmFormName         As String * 32
    dmUnusedPadding    As Integer
    dmBitsPerPel       As Integer
    dmPelsWidth        As Long
    dmPelsHeight       As Long
    dmDisplayFlags     As Long
    dmDisplayFrequency As Long
End Type
Public Declare Function EnumDisplaySettings Lib "user32" Alias "EnumDisplaySettingsA" (ByVal lpszDeviceName As Long, ByVal iModeNum As Long, lptypDevMode As Any) As Boolean
Public Declare Function ChangeDisplaySettings Lib "user32" Alias "ChangeDisplaySettingsA" (lptypDevMode As Any, ByVal dwFlags As Long) As Long


Public Const CCDEVICENAME = 32
Public Const CCFORMNAME = 32
Public Const DM_BITSPERPEL = &H40000
Public Const DM_PELSWIDTH = &H80000
Public Const DM_DISPLAYFREQUENCY = &H400000
Public Const DM_PELSHEIGHT = &H100000
Public Const CDS_UPDATEREGISTRY = &H1
Public Const CDS_TEST = &H4
Public Const DISP_CHANGE_SUCCESSFUL = 0
Public Const DISP_CHANGE_RESTART = 1

Public Declare Sub Sleep Lib "kernel32" (ByVal dwMilliseconds As Long)

Public Function MinInt(ByVal A As Integer, ByVal B As Integer)
If A <= B Then
    MinInt = A
Else
    MinInt = B
End If
End Function
Public Function MaxInt(ByVal A As Integer, ByVal B As Integer)
If A >= B Then
    MaxInt = A
Else
    MaxInt = B
End If
End Function

''
' Realiza acciones de desplasamiento segun las teclas que hallamos precionado
'

Public Sub CheckKeys()
'*************************************************
'Author: ^[GS]^
'Last modified: 01/11/08
'*************************************************
If frmMain.Visible = False Then Exit Sub
If frmMain.WindowState <> vbMaximized Then Exit Sub
If HotKeysAllow = False Then Exit Sub
        '[Loopzer]
        If GetKeyState(vbKeyControl) < 0 Then
            If Seleccionando Then
                If GetKeyState(vbKeyC) < 0 Then CopiarSeleccion
                If GetKeyState(vbKeyX) < 0 Then CortarSeleccion
                If GetKeyState(vbKeyB) < 0 Then BlockearSeleccion
                If GetKeyState(vbKeyD) < 0 Then AccionSeleccion
            Else
                If GetKeyState(vbKeyS) < 0 Then DePegar ' GS
                If GetKeyState(vbKeyV) < 0 Then PegarSeleccion
            End If
        End If
        '[/Loopzer]
        
If GetKeyState(vbKeyUp) < 0 Then
        If UserPos.Y < 11 Then Exit Sub ' 10
        If LegalPos(UserPos.X, UserPos.Y - 1) And WalkMode = True Then
            If dLastWalk + 50 > GetTickCount Then Exit Sub
            UserPos.Y = UserPos.Y - 1
            MoveCharbyPos UserCharIndex, UserPos.X, UserPos.Y
            dLastWalk = GetTickCount
        ElseIf WalkMode = False Then
            UserPos.Y = UserPos.Y - 1
        End If
        bRefreshRadar = True ' Radar
        frmMain.SetFocus
        Exit Sub
    End If

    If GetKeyState(vbKeyRight) < 0 Then
        If UserPos.X > 100 Then Exit Sub ' 89
        If LegalPos(UserPos.X + 1, UserPos.Y) And WalkMode = True Then
            If dLastWalk + 50 > GetTickCount Then Exit Sub
            UserPos.X = UserPos.X + 1
            MoveCharbyPos UserCharIndex, UserPos.X, UserPos.Y
            dLastWalk = GetTickCount
        ElseIf WalkMode = False Then
            UserPos.X = UserPos.X + 1
        End If
        bRefreshRadar = True ' Radar
        frmMain.SetFocus
        Exit Sub
    End If

    If GetKeyState(vbKeyDown) < 0 Then
        If UserPos.Y > 100 Then Exit Sub ' 92
        If LegalPos(UserPos.X, UserPos.Y + 1) And WalkMode = True Then
            If dLastWalk + 50 > GetTickCount Then Exit Sub
            UserPos.Y = UserPos.Y + 1
            MoveCharbyPos UserCharIndex, UserPos.X, UserPos.Y
            dLastWalk = GetTickCount
        ElseIf WalkMode = False Then
            UserPos.Y = UserPos.Y + 1
        End If
        bRefreshRadar = True ' Radar
        frmMain.SetFocus
        Exit Sub
    End If

    If GetKeyState(vbKeyLeft) < 0 Then
        If UserPos.X < 13 Then Exit Sub ' 12
        If LegalPos(UserPos.X - 1, UserPos.Y) And WalkMode = True Then
            If dLastWalk + 50 > GetTickCount Then Exit Sub
            UserPos.X = UserPos.X - 1
            MoveCharbyPos UserCharIndex, UserPos.X, UserPos.Y
            dLastWalk = GetTickCount
        ElseIf WalkMode = False Then
            UserPos.X = UserPos.X - 1
        End If
        bRefreshRadar = True ' Radar
        frmMain.SetFocus
        Exit Sub
    End If
    

End Sub

Public Function ReadField(Pos As Integer, Text As String, SepASCII As Integer) As String
'*************************************************
'Author: Unkwown
'Last modified: 20/05/06
'*************************************************
Dim i As Integer
Dim LastPos As Integer
Dim CurChar As String * 1
Dim FieldNum As Integer
Dim Seperator As String

Seperator = Chr(SepASCII)
LastPos = 0
FieldNum = 0

For i = 1 To Len(Text)
    CurChar = mid(Text, i, 1)
    If CurChar = Seperator Then
        FieldNum = FieldNum + 1
        If FieldNum = Pos Then
            ReadField = mid(Text, LastPos + 1, (InStr(LastPos + 1, Text, Seperator, vbTextCompare) - 1) - (LastPos))
            Exit Function
        End If
        LastPos = i
    End If
Next i
FieldNum = FieldNum + 1

If FieldNum = Pos Then
    ReadField = mid(Text, LastPos + 1)
End If

End Function


''
' Completa y corrije un path
'
' @param Path Especifica el path con el que se trabajara
' @return   Nos devuelve el path completado

Private Function autoCompletaPath(ByVal Path As String) As String
'*************************************************
'Author: ^[GS]^
'Last modified: 22/05/06
'*************************************************
Path = Replace(Path, "/", "\")
If Left(Path, 1) = "\" Then
    ' agrego app.path & path
    Path = App.Path & Path
End If
If Right(Path, 1) <> "\" Then
    ' me aseguro que el final sea con "\"
    Path = Path & "\"
End If
autoCompletaPath = Path
End Function

''
' Carga la configuracion del WorldEditor de WorldEditor.ini
'

Private Sub CargarMapIni()
'*************************************************
'Author: ^[GS]^
'Last modified: 02/10/06
'*************************************************
On Error GoTo Fallo
Dim tStr As String
Dim Leer As New clsIniReader

IniPath = App.Path & "\"

If FileExist(IniPath & "WorldEditor.ini", vbArchive) = False Then
    frmMain.mnuGuardarUltimaConfig.Checked = True
    DirGraficos = IniPath & "Graficos\"
    DirIndex = IniPath & "INIT\"
    DirMidi = IniPath & "MIDI\"
    frmMusica.fleMusicas.Path = DirMidi
    DirDats = IniPath & "DATS\"
    MaxGrhs = 15000
    UserPos.X = 50
    UserPos.Y = 50
    MsgBox "Falta el archivo 'WorldEditor.ini' de configuración.", vbInformation
    Exit Sub
End If

Call Leer.Initialize(IniPath & "WorldEditor.ini")

' Obj de Translado
Cfg_TrOBJ = Val(Leer.GetValue("CONFIGURACION", "ObjTranslado"))
frmMain.mnuAutoCapturarTranslados.Checked = Val(Leer.GetValue("CONFIGURACION", "AutoCapturarTrans"))
frmMain.mnuAutoCapturarSuperficie.Checked = Val(Leer.GetValue("CONFIGURACION", "AutoCapturarSup"))
frmMain.mnuUtilizarDeshacer.Checked = Val(Leer.GetValue("CONFIGURACION", "UtilizarDeshacer"))

' Guardar Ultima Configuracion
frmMain.mnuGuardarUltimaConfig.Checked = Val(Leer.GetValue("CONFIGURACION", "GuardarConfig"))

' Index
MaxGrhs = Val(GetVar(IniPath & "WorldEditor.ini", "INDEX", "MaxGrhs"))
If MaxGrhs < 1 Then MaxGrhs = 15000

'Reciente
frmMain.Dialog.InitDir = Leer.GetValue("PATH", "UltimoMapa")
DirGraficos = autoCompletaPath(Leer.GetValue("PATH", "DirGraficos"))
If DirGraficos = "\" Then
    DirGraficos = IniPath & "Graficos\"
End If
If FileExist(DirGraficos, vbDirectory) = False Then
    MsgBox "El directorio de Graficos es incorrecto", vbCritical + vbOKOnly
    End
End If
DirMidi = autoCompletaPath(Leer.GetValue("PATH", "DirMidi"))
If DirMidi = "\" Then
    DirMidi = IniPath & "MIDI\"
End If
If FileExist(DirMidi, vbDirectory) = False Then
    MsgBox "El directorio de MIDI es incorrecto", vbCritical + vbOKOnly
    End
End If
frmMusica.fleMusicas.Path = DirMidi
DirIndex = autoCompletaPath(Leer.GetValue("PATH", "DirIndex"))
If DirIndex = "\" Then
    DirIndex = IniPath & "INIT\"
End If
If FileExist(DirIndex, vbDirectory) = False Then
    MsgBox "El directorio de Index es incorrecto", vbCritical + vbOKOnly
    End
End If
DirDats = autoCompletaPath(Leer.GetValue("PATH", "DirDats"))
If DirDats = "\" Then
    DirDats = IniPath & "DATS\"
End If
If FileExist(DirDats, vbDirectory) = False Then
    MsgBox "El directorio de Dats es incorrecto", vbCritical + vbOKOnly
    End
End If

tStr = Leer.GetValue("MOSTRAR", "LastPos") ' x-y
UserPos.X = Val(ReadField(1, tStr, Asc("-")))
UserPos.Y = Val(ReadField(2, tStr, Asc("-")))
If UserPos.X < XMinMapSize Or UserPos.X > XMaxMapSize Then
    UserPos.X = 50
End If
If UserPos.Y < YMinMapSize Or UserPos.Y > YMaxMapSize Then
    UserPos.Y = 50
End If

' Menu Mostrar
frmMain.mnuVerAutomatico.Checked = Val(Leer.GetValue("MOSTRAR", "ControlAutomatico"))
frmMain.mnuVerCapa2.Checked = Val(Leer.GetValue("MOSTRAR", "Capa2"))
frmMain.mnuVerCapa3.Checked = Val(Leer.GetValue("MOSTRAR", "Capa3"))
frmMain.mnuVerCapa4.Checked = Val(Leer.GetValue("MOSTRAR", "Capa4"))
frmMain.mnuVerTranslados.Checked = Val(Leer.GetValue("MOSTRAR", "Translados"))
frmMain.mnuVerObjetos.Checked = Val(Leer.GetValue("MOSTRAR", "Objetos"))
frmMain.mnuVerNPCs.Checked = Val(Leer.GetValue("MOSTRAR", "NPCs"))
frmMain.mnuVerTriggers.Checked = Val(Leer.GetValue("MOSTRAR", "Triggers"))
frmMain.mnuVerBloqueos.Checked = Val(Leer.GetValue("MOSTRAR", "Bloqueos"))
'frmMain.cVerTriggers.value = frmMain.mnuVerTriggers.Checked
'frmMain.cVerBloqueos.value = frmMain.mnuVerBloqueos.Checked

' Tamaño de visualizacion en el cliente
ClienteHeight = Val(Leer.GetValue("MOSTRAR", "ClienteHeight"))
ClienteWidth = Val(Leer.GetValue("MOSTRAR", "ClienteWidth"))
If ClienteHeight <= 0 Then ClienteHeight = 13
If ClienteWidth <= 0 Then ClienteWidth = 17

Exit Sub
Fallo:
    MsgBox "ERROR " & Err.Number & " en WorldEditor.ini" & vbCrLf & Err.Description, vbCritical
    Resume Next
End Sub

Public Function TomarBPP() As Integer
    Dim ModoDeVideo As typDevMODE
    Call EnumDisplaySettings(0, -1, ModoDeVideo)
    TomarBPP = CInt(ModoDeVideo.dmBitsPerPel)
End Function
Public Sub CambioDeVideo()
'*************************************************
'Author: Loopzer
'*************************************************
Exit Sub
Dim ModoDeVideo As typDevMODE
Dim R As Long
Call EnumDisplaySettings(0, -1, ModoDeVideo)
    If ModoDeVideo.dmPelsWidth < 1024 Or ModoDeVideo.dmPelsHeight < 768 Then
        Select Case MsgBox("La aplicacion necesita una resolucion minima de 1024 X 768 ,¿Acepta el Cambio de resolucion?", vbInformation + vbOKCancel, "Fenix WE")
            Case vbOK
                ModoDeVideo.dmPelsWidth = 1024
                ModoDeVideo.dmPelsHeight = 768
                ModoDeVideo.dmFields = DM_PELSWIDTH Or DM_PELSHEIGHT
                R = ChangeDisplaySettings(ModoDeVideo, CDS_TEST)
                If R <> 0 Then
                    MsgBox "Error al cambiar la resolucion, La aplicacion se cerrara."
                    End
                End If
            Case vbCancel
                End
        End Select
    End If
End Sub

Public Sub Main()

    Set mD3D = D3DX
    Set device = D3DDevice
    mFreeMemoryBytes = 0
    maxBytesToUse = MIN_MEMORY_TO_USE

'*************************************************
'Author: Unkwown
'Last modified: 15/10/06 - GS
'Last modified: 09/12/09 - Deut
'*************************************************
On Error Resume Next
If App.PrevInstance = True Then End
CambioDeVideo
'Dim OffsetCounterX As Integer
'Dim OffsetCounterY As Integer
Dim Chkflag As Byte

Call CargarMapIni
Call IniciarCabecera(MiCabecera)

Rem tamaño del form - down
'frmMain.Width = 17520
'frmMain.Height = 11130
'
'frmMain.MainViewShp.Width = 705
'frmMain.MainViewShp.Height = 571
Rem up

frmCargando.verX = "v" & App.Major & "." & App.Minor & "." & App.Revision
frmCargando.Show
frmCargando.SetFocus

DoEvents

frmCargando.X.Caption = "Iniciando DirectSound..."

DoEvents

frmCargando.X.Caption = "Cargando Indice de Superficies..."
modIndices.CargarIndicesSuperficie
Rem yo - down
modIndices.CargarIndicesDeAgua
Rem up

DoEvents

frmCargando.X.Caption = "Indexando Cargado de Imagenes..."

DoEvents

LoadGrhData
CargarParticulas
'CargarFxs
'CargarCuerpos
DoEvents
    Meteo.Initialize
    Meteo.Set_Time 15, 0
'If InitTileEngine(frmMain.hWnd, frmMain.MainViewShp.Top + 50, frmMain.MainViewShp.Left + 4, 32, 32, Round(frmMain.MainViewShp.Height / 32), Round(frmMain.MainViewShp.Width / 32), 9) Then
    frmCargando.P1.Visible = True
    frmCargando.L(0).Visible = True
    frmCargando.X.Caption = "Cargando Cuerpos..."
    modIndices.CargarIndicesDeCuerpos
    DoEvents
    frmCargando.P2.Visible = True
    frmCargando.L(1).Visible = True
    frmCargando.X.Caption = "Cargando Cabezas..."
    modIndices.CargarIndicesDeCabezas
    DoEvents
    frmCargando.P3.Visible = True
    frmCargando.L(2).Visible = True
    frmCargando.X.Caption = "Cargando NPC's..."
    modIndices.CargarIndicesNPC
    DoEvents
    frmCargando.P4.Visible = True
    frmCargando.L(3).Visible = True
    frmCargando.X.Caption = "Cargando Objetos..."
    modIndices.CargarIndicesOBJ
    DoEvents
    frmCargando.P5.Visible = True
    frmCargando.L(4).Visible = True
    frmCargando.X.Caption = "Cargando Triggers..."
    modIndices.CargarIndicesTriggers
    DoEvents
    frmCargando.P6.Visible = True
    frmCargando.L(5).Visible = True
    DoEvents
'End If

frmCargando.Hide
frmMain.Show
'frmParticle.Show , frmMain
'frmParticle.Visible = False
modMapIO.NuevoMapa
DoEvents
engine.Engine_Init
prgRun = True

With Rect_Renderizar
        .Top = 0
        .Left = 0
        .Right = frmMain.Renderer.ScaleWidth '100 ' Width del picture (RenderConnect)
        .Bottom = frmMain.Renderer.ScaleHeight ' 100 ' Height del picture (RenderConnect)
End With
engine.Font_Create "Tahoma", 8, False, False

'MouseParticle = General_Particle_Create(59, -1, -1)
    
engine.Start
End Sub

Public Function GetVar(file As String, Main As String, Var As String) As String
'*************************************************
'Author: Unkwown
'Last modified: 20/05/06
'*************************************************
Dim L As Integer
Dim Char As String
Dim sSpaces As String ' This will hold the input that the program will retrieve
Dim szReturn As String ' This will be the defaul value if the string is not found
szReturn = vbNullString
sSpaces = Space(5000) ' This tells the computer how long the longest string can be. If you want, you can change the number 75 to any number you wish
GetPrivateProfileString Main, Var, szReturn, sSpaces, Len(sSpaces), file
GetVar = RTrim(sSpaces)
GetVar = Left(GetVar, Len(GetVar) - 1)
End Function

Public Sub WriteVar(file As String, Main As String, Var As String, value As String)
'*************************************************
'Author: Unkwown
'Last modified: 20/05/06
'*************************************************
writeprivateprofilestring Main, Var, value, file
End Sub

Public Sub ToggleWalkMode()
'*************************************************
'Author: Unkwown
'Last modified: 28/05/06 - GS
'*************************************************
On Error GoTo fin:
If WalkMode = False Then
    WalkMode = True
Else
    frmMain.mnuModoCaminata.Checked = False
    WalkMode = False
End If

If WalkMode = False Then
    'Erase character
    Call EraseChar(UserCharIndex)
    MapData(UserPos.X, UserPos.Y).CharIndex = 0
Else
    'MakeCharacter
    If LegalPos(UserPos.X, UserPos.Y) Then
        Call MakeChar(NextOpenChar(), 1, 1, SOUTH, UserPos.X, UserPos.Y)
        UserCharIndex = MapData(UserPos.X, UserPos.Y).CharIndex
        frmMain.mnuModoCaminata.Checked = True
    Else
        MsgBox "ERROR: Ubicacion ilegal."
        WalkMode = False
    End If
End If
fin:
End Sub

Public Sub FixCoasts(ByVal grhindex As Integer, ByVal X As Integer, ByVal Y As Integer)
'*************************************************
'Author: Unkwown
'Last modified: 20/05/06
'*************************************************

If grhindex = 7284 Or grhindex = 7290 Or grhindex = 7291 Or grhindex = 7297 Or _
   grhindex = 7300 Or grhindex = 7301 Or grhindex = 7302 Or grhindex = 7303 Or _
   grhindex = 7304 Or grhindex = 7306 Or grhindex = 7308 Or grhindex = 7310 Or _
   grhindex = 7311 Or grhindex = 7313 Or grhindex = 7314 Or grhindex = 7315 Or _
   grhindex = 7316 Or grhindex = 7317 Or grhindex = 7319 Or grhindex = 7321 Or _
   grhindex = 7325 Or grhindex = 7326 Or grhindex = 7327 Or grhindex = 7328 Or grhindex = 7332 Or _
   grhindex = 7338 Or grhindex = 7339 Or grhindex = 7345 Or grhindex = 7348 Or _
   grhindex = 7349 Or grhindex = 7350 Or grhindex = 7351 Or grhindex = 7352 Or _
   grhindex = 7349 Or grhindex = 7350 Or grhindex = 7351 Or _
   grhindex = 7354 Or grhindex = 7357 Or grhindex = 7358 Or grhindex = 7360 Or _
   grhindex = 7362 Or grhindex = 7363 Or grhindex = 7365 Or grhindex = 7366 Or _
   grhindex = 7367 Or grhindex = 7368 Or grhindex = 7369 Or grhindex = 7371 Or _
   grhindex = 7373 Or grhindex = 7375 Or grhindex = 7376 Then MapData(X, Y).Graphic(2).grhindex = 0

End Sub

Public Function RandomNumber(ByVal LowerBound As Variant, ByVal UpperBound As Variant) As Single
'*************************************************
'Author: Unkwown
'Last modified: 20/05/06
'*************************************************
Randomize Timer
RandomNumber = (UpperBound - LowerBound + 1) * Rnd + LowerBound
End Function

''
' Actualiza todos los Chars en el mapa

Public Sub RefreshAllChars()

On Error Resume Next

Dim LoopC As Integer

frmMain.ApuntadorRadar.Move UserPos.X - 12, UserPos.Y - 10
frmMain.picRadar.Cls

For LoopC = 1 To LastChar
    If CharList(LoopC).Active = 1 Then
        MapData(CharList(LoopC).Pos.X, CharList(LoopC).Pos.Y).CharIndex = LoopC
        If CharList(LoopC).Heading <> 0 Then
            frmMain.picRadar.ForeColor = vbGreen
            frmMain.picRadar.Line (0 + CharList(LoopC).Pos.X, 0 + CharList(LoopC).Pos.Y)-(2 + CharList(LoopC).Pos.X, 0 + CharList(LoopC).Pos.Y)
            frmMain.picRadar.Line (0 + CharList(LoopC).Pos.X, 1 + CharList(LoopC).Pos.Y)-(2 + CharList(LoopC).Pos.X, 1 + CharList(LoopC).Pos.Y)
        End If
    End If
Next LoopC

bRefreshRadar = False

End Sub

''
' Actualiza el Caption del menu principal
'
' @param Trabajando Indica el path del mapa con el que se esta trabajando
' @param Editado Indica si el mapa esta editado

Public Sub CaptionWorldEditor(ByVal Trabajando As String, ByVal Editado As Boolean)

If Trabajando = vbNullString Then
    Trabajando = "Nuevo Mapa"
End If

frmMain.Caption = "Fenix WE v" & App.Major & "." & App.Minor & " Build " & App.Revision & " - [" & Trabajando & "]"

If Editado = True Then
    frmMain.Caption = frmMain.Caption & " (modificado)"
End If

End Sub

Public Function Buleano(A As Boolean) As Byte
Buleano = -A
End Function

Public Function HayAgua(X As Integer, Y As Integer) As Boolean
'*************************************************
'Author: Unknown
'Last modified: 19/12/09 - Deut
'*************************************************
Dim finGrhIndex As Integer
Dim i As Integer

For i = 1 To UBound(REFAguasArr())
    finGrhIndex = SupData(REFAguasArr(i)).Grh + 15
    If MapData(X, Y).Graphic(1).grhindex >= SupData(REFAguasArr(i)).Grh And MapData(X, Y).Graphic(1).grhindex <= finGrhIndex Then
        If MapData(X, Y).Graphic(2).grhindex > 0 Then
            HayAgua = False
        Else
            HayAgua = True
        End If
        Exit Function
    End If
Next



HayAgua = False

End Function
Public Sub CargarParticulas()
'*************************************
'Coded by OneZero (onezero_ss@hotmail.com)
'Last Modified: 6/4/03
'Loads the Particles.ini file to the ComboBox
'Edited by Juan Martín Sotuyo Dodero to add speed and life
'*************************************
    Dim LoopC As Long
    Dim i As Long
    Dim GrhListing As String
    Dim TempSet As String
    Dim ColorSet As Long
 
    Dim StreamFile As String
    StreamFile = App.Path & "\init\" & "Particulas.ini"
 
    TotalStreams = Val(General_Var_Get(StreamFile, "INIT", "Total"))
   
    'resize StreamData array
    ReDim StreamData(1 To TotalStreams) As Stream
   
    'fill StreamData array with info from Particles.ini
    For LoopC = 1 To TotalStreams
        StreamData(LoopC).Name = General_Var_Get(StreamFile, Val(LoopC), "Name")
        frmMain.LstParticulas.AddItem LoopC & "-" & StreamData(LoopC).Name
        StreamData(LoopC).NumOfParticles = General_Var_Get(StreamFile, Val(LoopC), "NumOfParticles")
        StreamData(LoopC).X1 = General_Var_Get(StreamFile, Val(LoopC), "X1")
        StreamData(LoopC).Y1 = General_Var_Get(StreamFile, Val(LoopC), "Y1")
        StreamData(LoopC).X2 = General_Var_Get(StreamFile, Val(LoopC), "X2")
        StreamData(LoopC).Y2 = General_Var_Get(StreamFile, Val(LoopC), "Y2")
        StreamData(LoopC).angle = General_Var_Get(StreamFile, Val(LoopC), "Angle")
        StreamData(LoopC).vecx1 = General_Var_Get(StreamFile, Val(LoopC), "VecX1")
        StreamData(LoopC).vecx2 = General_Var_Get(StreamFile, Val(LoopC), "VecX2")
        StreamData(LoopC).vecy1 = General_Var_Get(StreamFile, Val(LoopC), "VecY1")
        StreamData(LoopC).vecy2 = General_Var_Get(StreamFile, Val(LoopC), "VecY2")
        StreamData(LoopC).life1 = General_Var_Get(StreamFile, Val(LoopC), "Life1")
        StreamData(LoopC).life2 = General_Var_Get(StreamFile, Val(LoopC), "Life2")
        StreamData(LoopC).friction = General_Var_Get(StreamFile, Val(LoopC), "Friction")
        StreamData(LoopC).spin = General_Var_Get(StreamFile, Val(LoopC), "Spin")
        StreamData(LoopC).spin_speedL = General_Var_Get(StreamFile, Val(LoopC), "Spin_SpeedL")
        StreamData(LoopC).spin_speedH = General_Var_Get(StreamFile, Val(LoopC), "Spin_SpeedH")
        StreamData(LoopC).AlphaBlend = 1 'Val(General_Var_Get(StreamFile, Val(LoopC), "AlphaBlend"))
        StreamData(LoopC).gravity = General_Var_Get(StreamFile, Val(LoopC), "Gravity")
        StreamData(LoopC).grav_strength = General_Var_Get(StreamFile, Val(LoopC), "Grav_Strength")
        StreamData(LoopC).bounce_strength = General_Var_Get(StreamFile, Val(LoopC), "Bounce_Strength")
        StreamData(LoopC).XMove = General_Var_Get(StreamFile, Val(LoopC), "XMove")
        StreamData(LoopC).YMove = General_Var_Get(StreamFile, Val(LoopC), "YMove")
        StreamData(LoopC).move_x1 = General_Var_Get(StreamFile, Val(LoopC), "move_x1")
        StreamData(LoopC).move_x2 = General_Var_Get(StreamFile, Val(LoopC), "move_x2")
        StreamData(LoopC).move_y1 = General_Var_Get(StreamFile, Val(LoopC), "move_y1")
        StreamData(LoopC).move_y2 = General_Var_Get(StreamFile, Val(LoopC), "move_y2")
        StreamData(LoopC).life_counter = General_Var_Get(StreamFile, Val(LoopC), "life_counter")
        StreamData(LoopC).Speed = Val(General_Var_Get(StreamFile, Val(LoopC), "Speed"))
       
        StreamData(LoopC).NumGrhs = General_Var_Get(StreamFile, Val(LoopC), "NumGrhs")
       
        ReDim StreamData(LoopC).grh_list(1 To StreamData(LoopC).NumGrhs)
        GrhListing = General_Var_Get(StreamFile, Val(LoopC), "Grh_List")
       
        For i = 1 To StreamData(LoopC).NumGrhs
            StreamData(LoopC).grh_list(i) = Val(General_Field_Read(i, GrhListing, Asc(",")))
        Next i
        StreamData(LoopC).grh_list(i - 1) = StreamData(LoopC).grh_list(i - 1)
        For ColorSet = 1 To 4
            TempSet = General_Var_Get(StreamFile, Val(LoopC), "ColorSet" & ColorSet)
            StreamData(LoopC).colortint(ColorSet - 1).R = Val(General_Field_Read(1, TempSet, Asc(",")))
            StreamData(LoopC).colortint(ColorSet - 1).G = Val(General_Field_Read(2, TempSet, Asc(",")))
            StreamData(LoopC).colortint(ColorSet - 1).B = Val(General_Field_Read(3, TempSet, Asc(",")))
        Next ColorSet
       
    Next LoopC
End Sub

