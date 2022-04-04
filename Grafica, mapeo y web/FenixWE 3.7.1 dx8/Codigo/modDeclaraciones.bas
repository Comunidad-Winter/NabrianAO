Attribute VB_Name = "modDeclaraciones"
Option Explicit

Public Radio As Byte
Public Type Light
    X As Integer
    Y As Integer
    Active As Boolean 'Do we ignore this light?
    id As Long
    map_x As Long 'Coordinates
    map_y As Long
    Color As Long 'Start colour
    Range As Long
    RGBCOLOR As D3DCOLORVALUE
End Type
Public MapData_Adyacente() As MapBlock
Public Lights() As Light
Public Meteo As New clsMeteo
Public Rect_Renderizar As RECT
Public Light As New clsLight

'Particle Groups

Public TotalStreams As Integer
Public StreamData() As Stream
 
'RGB Type
Public Type RGB
    R As Long
    G As Long
    B As Long
End Type
 
Public Type Stream
    Name As String
    NumOfParticles As Long
    NumGrhs As Long
    id As Long
    X1 As Long
    Y1 As Long
    X2 As Long
    Y2 As Long
    angle As Long
    vecx1 As Long
    vecx2 As Long
    vecy1 As Long
    vecy2 As Long
    life1 As Long
    life2 As Long
    friction As Long
    spin As Byte
    spin_speedL As Single
    spin_speedH As Single
    AlphaBlend As Byte
    gravity As Byte
    grav_strength As Long
    bounce_strength As Long
    XMove As Byte
    YMove As Byte
    move_x1 As Long
    move_x2 As Long
    move_y1 As Long
    move_y2 As Long
    grh_list() As Long
    colortint(0 To 3) As RGB
   
    Speed As Single
    life_counter As Long
End Type



Public NombreImagen As String
Public Const MSGMod As String = "Este mapa há sido modificado." & vbCrLf & "Si no lo guardas perderas todos los cambios ¿Deseas guardarlo?"
Public Const MSGDang As String = "CUIDADO! Este comando puede arruinar el mapa." & vbCrLf & "¿Estas seguro que desea continuar?"

Public Const ENDL As String * 2 = vbCrLf

Public REFAguasArr() As Integer
Rem yo - down
Public PosMouseX As Integer
Public PosMouseY As Integer

'Public VerBloqueoAgua As Boolean

Rem up
Public FocoEnLista As Boolean

Public SeleccionIX As Integer
Public SeleccionFX As Integer
Public SeleccionIY As Integer
Public SeleccionFY As Integer
Public SeleccionAncho As Integer
Public SeleccionAlto As Integer
Public Seleccionando As Boolean
Public SeleccionMap() As MapBlock

Public DeSeleccionOX As Integer
Public DeSeleccionOY As Integer
Public DeSeleccionIX As Integer
Public DeSeleccionFX As Integer
Public DeSeleccionIY As Integer
Public DeSeleccionFY As Integer
Public DeSeleccionAncho As Integer
Public DeSeleccionAlto As Integer
Public DeSeleccionando As Boolean
Public DeSeleccionMap() As MapBlock

Public VerBlockeados As Boolean
Public VerGrilla As Boolean
Public VerParticle As Boolean
Public VerTriggers As Boolean
Public VerCapa1 As Boolean
Public VerCapa2 As Boolean
Public VerCapa3 As Boolean
Public VerCapa4 As Boolean
Public VerTranslados As Boolean
Public VerObjetos As Boolean
Public VerNpcs As Boolean

' Objeto de Translado
Public Cfg_TrOBJ As Integer

'Path
Public IniPath As String
Public DirGraficos As String
Public DirMidi As String
Public DirIndex As String
Public DirDats As String

Public bAutoGuardarMapa As Byte
Public bAutoGuardarMapaCount As Byte
Public HotKeysAllow As Boolean  ' Control Automatico de HotKeys
Public vMostrando As Byte
Public WORK As Boolean
Public PATH_Save As String
Public NumMap_Save As Integer
Public NameMap_Save As String

' Client Config
Public ClienteHeight As Integer
Public ClienteWidth As Integer

Public SobreX As Byte   ' Posicion X bajo el Cursor
Public SobreY As Byte   ' Posicion Y bajo el Cursor

' Radar
Public MiRadarX As Integer
Public MiRadarY As Integer
Public bRefreshRadar As Boolean

Type SupData
    Name As String
    Grh As Integer
    Width As Byte
    Height As Byte
    Block As Boolean
    Capa As Byte
End Type
Public MaxSup As Integer
Public SupData() As SupData

Public Type NpcData
    Name As String
    Body As Integer
    Head As Integer
    Heading As Byte
End Type
Public NumNPCs As Integer
Public NumNPCsHOST As Integer
Public NpcData() As NpcData

Public Type ObjData
    Name As String 'Nombre del obj
    ObjType As Integer 'Tipo enum que determina cuales son las caract del obj
    grhindex As Integer ' Indice del grafico que representa el obj
    GrhSecundario As Integer
    Info As String
    Ropaje As Integer 'Indice del grafico del ropaje
    WeaponAnim As Integer ' Apunta a una anim de armas
    ShieldAnim As Integer ' Apunta a una anim de escudo
    Texto As String
End Type
Public NumOBJs As Integer
Public ObjData() As ObjData

Public Conexion As New Connection
Public prgRun As Boolean
Public CurrentGrh As Grh
Public Play As Boolean
Public MapaCargado As Boolean
Public cFPS As Long
Public dTiempoGT As Double
Public dLastWalk As Double

'Hold info about each map
Public Type MapInfo
    TopPunto As Byte
    LeftPunto As Byte
    Music As String
    Name As String
    MapVersion As Integer
    Pk As Boolean
    NoMagia As Boolean
    Terreno As String
    Zona As String
    Restringir As Boolean
    Nivel As Byte
    BackUp As Byte
    Changed As Byte
End Type

'********** CONSTANTS ***********
'Heading Constants
Public Const NORTH As Byte = 1
Public Const EAST  As Byte = 2
Public Const SOUTH As Byte = 3
Public Const WEST  As Byte = 4

'Map sizes in tiles
Public Const XMaxMapSize As Byte = 100
Public Const XMinMapSize As Byte = 1
Public Const YMaxMapSize As Byte = 100
Public Const YMinMapSize As Byte = 1

'********** TYPES ***********
'Holds a local position
Public Type Position
    X As Integer
    Y As Integer
End Type

'Holds a world position
Public Type WorldPos
    Map As Integer
    X As Integer
    Y As Integer
End Type

'Points to a grhData and keeps animation info
Public Type Grh
    grhindex As Integer
    FrameCounter As Single
    SpeedCounter As Single
    Started As Byte
    angle As Single
End Type

'Holds data about where a bmp can be found,
'How big it is and animation info
Public Type GrhData
    SX As Integer
    SY As Integer
    FileNum As Integer
    PixelWidth As Integer
    PixelHeight As Integer
    TileWidth As Single
    TileHeight As Single
    NumFrames As Integer
    Frames(1 To 25) As Integer
    Speed As Integer
End Type

' Cuerpos body.dat
Public Type tIndiceCuerpo
    Body(1 To 4) As Integer
    HeadOffsetX As Integer
    HeadOffsetY As Integer
End Type
' Lista de Cuerpos body.dat
Public Type tBodyData
    Walk(1 To 4) As Grh
    HeadOffset As Position
End Type
' body.dat
Public BodyData() As tBodyData
Public NumBodies As Integer
'Lista de cabezas
Public Type tIndiceCabeza
    Head(1 To 4) As Integer
End Type
'Heads list
Public Type tHeadData
    Head(0 To 4) As Grh
End Type
Public HeadData() As tHeadData

'Hold info about a character
Public Type Char
    Active As Byte
    Heading As Byte
    Pos As Position
    Body As tBodyData
    Head As tHeadData
    MoveOffset As Position
    scrollDirectionX As Integer
    scrollDirectionY As Integer
    
    Moving As Byte
    MoveOffsetX As Single
    MoveOffsetY As Single
End Type

'Holds info about a object
Public Type Obj
    OBJIndex As Integer
    Amount As Integer
End Type

'Holds info about each tile position
Public Type MapBlock
    base_light(0 To 3) As Boolean 'Indica si el tile tiene luz propia.
    light_index As Integer
    light_base_value(0 To 3) As Long 'Luz propia del tile.
    light_value(0 To 3) As Long 'Color de luz con el que esta siendo renderizado.
    parti_index As Integer
    particle_group_index As Integer
    Graphic(1 To 4) As Grh
    CharIndex As Integer
    ObjGrh As Grh
    Trigger As Byte
    NpcIndex As Integer
    OBJInfo As Obj
    TileExit As WorldPos
    Blocked As Byte
    Agua As Byte
End Type

'********** Public VARS ***********
'Where the map borders are.. Set during load
Public MinXBorder As Byte
Public MaxXBorder As Byte
Public MinYBorder As Byte
Public MaxYBorder As Byte

'Object Constants
Public Const MAX_INVENORY_OBJS  As Integer = 10000

' Deshacer
Public Const maxDeshacer As Integer = 10
Public MapData_Deshacer(1 To maxDeshacer, XMinMapSize To XMaxMapSize, YMinMapSize To YMaxMapSize) As MapBlock
Type tDeshacerInfo
    Libre As Boolean
    Desc As String
End Type
Public MapData_Deshacer_Info(1 To maxDeshacer) As tDeshacerInfo

'********** Public ARRAYS ***********
Public GrhData() As GrhData 'Holds all the grh data
Public MapData() As MapBlock 'Holds map data for current map
Public MapInfo As MapInfo 'Holds map info for current map
Public CharList(1 To 10000) As Char 'Holds info about all characters on map

'Encabezado bmp
Type BITMAPFILEHEADER
        bfType As Integer
        bfSize As Long
        bfReserved1 As Integer
        bfReserved2 As Integer
        bfOffBits As Long
End Type

'Info del encabezado del bmp
Type BITMAPINFOHEADER
        biSize As Long
        biWidth As Long
        biHeight As Long
        biPlanes As Integer
        biBitCount As Integer
        biCompression As Long
        biSizeImage As Long
        biXPelsPerMeter As Long
        biYPelsPerMeter As Long
        biClrUsed As Long
        biClrImportant As Long
End Type

' DirectMusic
Public IsPlayingCheck As Boolean

' DirectSound
Public Const NumSoundBuffers As Byte = 20

Public LastSoundBufferUsed As Integer

Public gDespX As Integer
Public gDespY As Integer

'User status vars
Public CurMap As Integer 'Current map loaded
Public UserIndex As Integer
Global UserBody As Integer
Global UserHead As Integer
Public UserPos As Position 'Holds current user pos
Public AddtoUserPos As Position 'For moving user
Public UserCharIndex As Integer

Public EngineRun As Boolean
Public FramesPerSec As Integer
Public FramesPerSecCounter As Long

'Main view size size in tiles
Public WindowTileWidth As Integer
Public WindowTileHeight As Integer

'Pixel offset of main view screen from 0,0
Public MainViewTop As Integer
Public MainViewLeft As Integer

'How many tiles the engine "looks ahead" when
'drawing the screen
Public TileBufferSize As Integer

'Handle to where all the drawing is going to take place
Public DisplayFormhWnd As Long

'Tile size in pixels
Public TilePixelHeight As Integer
Public TilePixelWidth As Integer

'Map editor variables
Public WalkMode As Boolean

'Totals
Public NumMaps As Integer 'Number of maps
Public Numheads As Integer
Public NumGrhFiles As Integer 'Number of bmps
Public MaxGrhs As Integer 'Number of Grhs
Global NumChars As Integer
Global LastChar As Integer

'********** Direct X ***********
Public MainViewRect As RECT
Public MainDestRect As RECT
Public MainViewWidth As Integer
Public MainViewHeight As Integer
Public BackBufferRect As RECT

'********** OUTSIDE FUNCTIONS ***********
'Good old BitBlt
Public Declare Function BitBlt Lib "gdi32" (ByVal hDestDC As Long, ByVal X As Long, ByVal Y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal hSrcDC As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal dwRop As Long) As Long
Private Declare Function SetPixel Lib "gdi32" (ByVal hdc As Long, ByVal X As Long, ByVal Y As Long, ByVal crColor As Long) As Long

'Sound stuff
Public Declare Function mciSendString Lib "winmm.dll" Alias "mciSendStringA" (ByVal lpstrCommand As String, ByVal lpstrReturnString As String, ByVal uRetrunLength As Long, ByVal hwndCallback As Long) As Long
Public Declare Function sndPlaySound Lib "winmm.dll" Alias "sndPlaySoundA" (ByVal lpszSoundName As String, ByVal uFlags As Long) As Long

'For Get and Write Var
Public Declare Function writeprivateprofilestring Lib "kernel32" Alias "WritePrivateProfileStringA" (ByVal lpApplicationname As String, ByVal lpKeyname As Any, ByVal lpString As String, ByVal lpfilename As String) As Long
Public Declare Function GetPrivateProfileString Lib "kernel32" Alias "GetPrivateProfileStringA" (ByVal lpApplicationname As String, ByVal lpKeyname As Any, ByVal lpdefault As String, ByVal lpreturnedstring As String, ByVal nSize As Long, ByVal lpfilename As String) As Long
    
'For KeyInput
Public Declare Function GetKeyState Lib "user32" (ByVal nVirtKey As Long) As Integer

Public Declare Function GetTickCount Lib "kernel32" () As Long
'Old fashion BitBlt functions
Public Const SRCCOPY = &HCC0020
Public Declare Function CreateCompatibleDC Lib "gdi32" (ByVal hdc As Long) As Long
Public Declare Function SelectObject Lib "gdi32" (ByVal hdc As Long, ByVal hObject As Long) As Long
Public Declare Function DeleteDC Lib "gdi32" (ByVal hdc As Long) As Long
Public Declare Function TransparentBlt Lib "msimg32" (ByVal hdcDest As Long, ByVal nXOriginDest As Long, ByVal nYOriginDest As Long, ByVal nWidthDest As Long, ByVal nHeightDest As Long, ByVal hdcsrc As Long, ByVal nXOriginSrc As Long, ByVal nYOriginSrc As Long, ByVal nWidthSrc As Long, ByVal nHeightSrc As Long, ByVal crTransparent As Long) As Long

