Attribute VB_Name = "Mod_TileEngine"
'Argentum Online 0.12.1 MENDUZ DX8 VERSION www.noicoder.com
'
'Copyright (C) 2002 Márquez Pablo Ignacio
'Copyright (C) 2002 Otto Perez
'Copyright (C) 2002 Aaron Perkins
'Copyright (C) 2002 Matías Fernando Pequeño
'
'This program is free software; you can redistribute it and/or modify
'it under the terms of the Affero General Public License;
'either version 1 of the License, or any later version.
'
'This program is distributed in the hope that it will be useful,
'but WITHOUT ANY WARRANTY; without even the implied warranty of
'MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
'Affero General Public License for more details.
'
'You should have received a copy of the Affero General Public License
'along with this program; if not, you can find it at http://www.affero.org/oagpl.html
'
'Argentum Online is based on Baronsoft's VB6 Online RPG
'You can contact the original creator of ORE at aaron@baronsoft.com
'for more information about ORE please visit http://www.baronsoft.com/
'
'
'You can contact me at:
'morgolock@speedy.com.ar
'www.geocities.com/gmorgolock
'Calle 3 número 983 piso 7 dto A
'La Plata - Pcia, Buenos Aires - Republica Argentina
'Código Postal 1900
'Pablo Ignacio Márquez



Option Explicit

'Map sizes in tiles
'Public Const XMaxMapSize As Byte = 100
'Public Const XMinMapSize As Byte = 1
'Public Const YMaxMapSize As Byte = 100
'Public Const YMinMapSize As Byte = 1

Private Const GrhFogata As Integer = 1521
Public mD3D As D3DX8
Public device As Direct3DDevice8
Const HASH_TABLE_SIZE As Long = 337
Public Const BYTES_PER_MB As Long = 1048576                        '1Mb = 1024 Kb = 1024 * 1024 bytes = 1048576 bytes
Public Const MIN_MEMORY_TO_USE As Long = 16 * BYTES_PER_MB          '4 Mb

 Public mFreeMemoryBytes As Long
 Public maxBytesToUse As Long
''
'Sets a Grh animation to loop indefinitely.
Private Const INFINITE_LOOPS As Integer = -1


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

'Posicion en un mapa
Public Type Position
    x As Long
    Y As Long
End Type

'Contiene info acerca de donde se puede encontrar un grh tamaño y animacion
'Public Type GrhData
'    sX As Integer
'    sY As Integer
    
'    FileNum As Long
'
'    pixelWidth As Integer
'    pixelHeight As Integer
'
'    TileWidth As Single
'    TileHeight As Single
'
'    NumFrames As Integer
'    Frames() As Long
    
'    Speed As Single
'End Type

'apunta a una estructura grhdata y mantiene la animacion
'Public Type Grh
'    grhindex As Integer
'    FrameCounter As Single
'    Speed As Single
'    Started As Byte
'    Loops As Integer
'    angle As Single
'End Type

'Lista de cuerpos
'Public Type BodyData
'    Walk(1 To 4) As Grh
'    HeadOffset As Position
'End Type

'Lista de cabezas
'Public Type HeadData
'    Head(1 To 4) As Grh
'End Type

'Lista de las animaciones de las armas
'Type WeaponAnimData
'    WeaponWalk(1 To 4) As Grh
'End Type

'Lista de las animaciones de los escudos
'Type ShieldAnimData
'    ShieldWalk(1 To 4) As Grh
'End Type


'Apariencia del personaje
'Public Type Char
'    active As Byte
'    Heading As Byte
'    Pos As Position
    
'    iHead As Integer
'    iBody As Integer
'    Body As BodyData
'    Head As HeadData
'    Casco As HeadData
'    Arma As WeaponAnimData
'    Escudo As ShieldAnimData
'    UsandoArma As Boolean
    
'    fX As Grh
'    FxIndex As Integer
    
'    Criminal As Byte
    
'    Nombre As String
    
'    scrollDirectionX As Integer
'    scrollDirectionY As Integer
    
'    Moving As Byte
'    MoveOffsetX As Single
'    MoveOffsetY As Single
    
'    pie As Boolean
'    muerto As Boolean
'    invisible As Boolean
'    priv As Byte
'End Type

'Info de un objeto
'Public Type Obj
'    OBJIndex As Integer
'    Amount As Integer
'End Type

'Tipo de las celdas del mapa


'Info de cada mapa


'DX7 Objects
'Public DirectX As New DirectX7
'Public DirectDraw As DirectDraw7
'Private PrimarySurface As DirectDrawSurface7
'Private PrimaryClipper As DirectDrawClipper
'Private BackBufferSurface As DirectDrawSurface7

'Public IniPath As String
'Public MapPath As String


'Bordes del mapa
'Public MinXBorder As Byte
'Public MaxXBorder As Byte
'Public MinYBorder As Byte
'Public MaxYBorder As Byte

'Status del user
'Public CurMap As Integer 'Mapa actual
'Public UserIndex As Integer
Public UserMoving As Byte
'Public UserBody As Integer
'Public UserHead As Integer
'Public UserPos As Position 'Posicion
'Public AddtoUserPos As Position 'Si se mueve
'Public UserCharIndex As Integer

Public FPS As Long
Public FramesPerSecCounter As Long
Private fpsLastCheck As Long

'Tamaño del la vista en Tiles
Private WindowTileWidth As Integer
Private WindowTileHeight As Integer

Private HalfWindowTileWidth As Integer
Private HalfWindowTileHeight As Integer

'Offset del desde 0,0 del main view
Private MainViewTop As Integer
Private MainViewLeft As Integer

'Cuantos tiles el engine mete en el BUFFER cuando
'dibuja el mapa. Ojo un tamaño muy grande puede
'volver el engine muy lento
'Public TileBufferSize As Integer

Private TileBufferPixelOffsetx As Byte
Private TileBufferPixelOffsety As Byte

'Number of pixels the engine scrolls per frame. MUST divide evenly into pixels per tile
Public ScrollPixelsPerFrameX As Integer
Public ScrollPixelsPerFrameY As Integer

Dim timerElapsedTime As Single
Dim timerTicksPerFrame As Single
Dim engineBaseSpeed As Single


'Public NumBodies As Integer
'Public Numheads As Integer
'Public NumFxs As Integer

'Public NumChars As Integer
'Public LastChar As Integer
'Public NumWeaponAnims As Integer
'Public NumShieldAnims As Integer


Private MainDestRect   As RECT
Private MainViewRect   As RECT
Private BackBufferRect As RECT

Private MainViewWidth As Integer
Private MainViewHeight As Integer

Private MouseTileX As Byte
Private MouseTileY As Byte


Public Type tIndiceFx
    Animacion As Integer
    Offsetx As Byte
    Offsety As Byte
End Type

'¿?¿?¿?¿?¿?¿?¿?¿?¿?¿Graficos¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?
'Public GrhData() As GrhData 'Guarda todos los grh
'Public BodyData() As BodyData
'Public HeadData() As HeadData
'Public FxData() As tIndiceFx
'Public WeaponAnimData() As WeaponAnimData
'Public ShieldAnimData() As ShieldAnimData
'Public CascoAnimData() As HeadData
'¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?

'¿?¿?¿?¿?¿?¿?¿?¿?¿?¿Mapa?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?
' Mapa
 ' Info acerca del mapa en uso
'¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?

Public bRain        As Boolean 'está raineando?
Public bTecho       As Boolean 'hay techo?
Public brstTick     As Long

Private RLluvia(7)  As RECT  'RECT de la lluvia
Private iFrameIndex As Byte  'Frame actual de la LL
Private llTick      As Long  'Contador
Private LTLluvia(4) As Integer

'Public charlist(1 To 10000) As Char

#If SeguridadAlkon Then

Public MI(1 To 1233) As clsManagerInvisibles
Public CualMI As Integer

#End If

' Used by GetTextExtentPoint32
Private Type size
    cx As Long
    cy As Long
End Type

'[CODE 001]:MatuX
Public Enum PlayLoop
    plNone = 0
    plLluviain = 1
    plLluviaout = 2
End Enum
'[END]'
'
'       [END]
'¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?¿?

#If ConAlfaB Then

Private Declare Function BltAlphaFast Lib "vbabdx" (ByRef lpDDSDest As Any, ByRef lpDDSSource As Any, ByVal iWidth As Long, ByVal iHeight As Long, _
        ByVal pitchSrc As Long, ByVal pitchDst As Long, ByVal dwMode As Long) As Long
Private Declare Function BltEfectoNoche Lib "vbabdx" (ByRef lpDDSDest As Any, ByVal iWidth As Long, ByVal iHeight As Long, _
        ByVal pitchDst As Long, ByVal dwMode As Long) As Long
Private Declare Function SelectObject Lib "gdi32" (ByVal hdc As Long, ByVal hObject As Long) As Long
#End If

Private Declare Function BitBlt Lib "gdi32" (ByVal hDestDC As Long, ByVal x As Long, ByVal Y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal hSrcDC As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal dwRop As Long) As Long
Private Declare Function SelectObject Lib "gdi32" (ByVal hdc As Long, ByVal hObject As Long) As Long
Private Declare Function CreateCompatibleDC Lib "gdi32" (ByVal hdc As Long) As Long
Private Declare Function DeleteDC Lib "gdi32" (ByVal hdc As Long) As Long
Private Declare Function DeleteObject Lib "gdi32" (ByVal hObject As Long) As Long


'Added by Juan Martín Sotuyo Dodero
Private Declare Function StretchBlt Lib "gdi32" (ByVal hDestDC As Long, ByVal x As Long, ByVal Y As Long, ByVal nWidth As Long, ByVal nHeight As Long, ByVal hSrcDC As Long, ByVal xSrc As Long, ByVal ySrc As Long, ByVal nSrcWidth As Long, ByVal nSrcHeight As Long, ByVal dwRop As Long) As Long
Private Declare Function SetPixel Lib "gdi32" (ByVal hdc As Long, ByVal x As Long, ByVal Y As Long, ByVal crColor As Long) As Long
Private Declare Function GetPixel Lib "gdi32" (ByVal hdc As Long, ByVal x As Long, ByVal Y As Long) As Long
'Added by Barrin


'Very percise counter 64bit system counter
Private Declare Function QueryPerformanceFrequency Lib "kernel32" (lpFrequency As Currency) As Long
Private Declare Function QueryPerformanceCounter Lib "kernel32" (lpPerformanceCount As Currency) As Long

'Text width computation. Needed to center text.
Private Declare Function GetTextExtentPoint32 Lib "gdi32" Alias "GetTextExtentPoint32A" (ByVal hdc As Long, ByVal lpsz As String, ByVal cbString As Long, lpSize As size) As Long


'Standelf
Sub ConvertCPtoTP(ByVal viewPortX As Single, ByVal viewPortY As Single, ByRef tx As Byte, ByRef ty As Byte)
On Error Resume Next
'******************************************
'Converts where the mouse is in the main window to a tile position. MUST be called eveytime the mouse moves.
'******************************************
    tx = UserPos.x + viewPortX \ 32 - frmMain.Renderer.ScaleWidth \ 64
    ty = UserPos.Y + viewPortY \ 32 - frmMain.Renderer.ScaleHeight \ 64
    Debug.Print tx; ty
End Sub
Sub MakeChar(ByVal CharIndex As Integer, ByVal Body As Integer, ByVal Head As Integer, ByVal Heading As Byte, ByVal x As Integer, ByVal Y As Integer)
On Error Resume Next
    'Apuntamos al ultimo Char
    If CharIndex > LastChar Then LastChar = CharIndex
    
    With CharList(CharIndex)
        'If the char wasn't allready active (we are rewritting it) don't increase char count
        If .Active = 0 Then _
            NumChars = NumChars + 1
        
        '.Head = Head
        '.Body = Body
        CharList(CharIndex).Head = HeadData(Head)
        CharList(CharIndex).Body = BodyData(Body)
        
        .Heading = Heading
        
        'Reset moving stats
        .Moving = 0
        .MoveOffsetX = 0
        .MoveOffsetY = 0
        
        'Update position
        .Pos.x = x
        .Pos.Y = Y
        
        'Make active
        .Active = 1
    End With
    
    'Plot on map
    MapData(x, Y).CharIndex = CharIndex
End Sub
Sub EraseChar(ByVal CharIndex As Integer)
'*****************************************************************
'Erases a character from CharList and map
'*****************************************************************
On Error Resume Next
    CharList(CharIndex).Active = 0
    
    'Update lastchar
    If CharIndex = LastChar Then
        Do Until CharList(LastChar).Active = 1
            LastChar = LastChar - 1
            If LastChar = 0 Then Exit Do
        Loop
    End If
    
    MapData(CharList(CharIndex).Pos.x, CharList(CharIndex).Pos.Y).CharIndex = 0
    
    'Call ResetCharInfo(CharIndex)
    
    'Update NumChars
    NumChars = NumChars - 1
End Sub

Sub InitGrh(ByRef Grh As Grh, ByVal grhindex As Integer, Optional Started As Byte = 2)

On Error Resume Next

Grh.grhindex = grhindex

If Grh.grhindex <> 0 Then ' 31/05/2006
    If Started = 2 Then
        If GrhData(Grh.grhindex).NumFrames > 1 Then
            Grh.Started = 1
        Else
            Grh.Started = 0
        End If
    Else
        Grh.Started = Started
    End If
    Grh.FrameCounter = 1
    Grh.SpeedCounter = GrhData(Grh.grhindex).Speed
Else
    Grh.FrameCounter = 1
    Grh.Started = 0
    Grh.SpeedCounter = 0
End If

End Sub


Private Function EstaPCarea(ByVal CharIndex As Integer) As Boolean
    With CharList(CharIndex).Pos
        EstaPCarea = .x > UserPos.x - MinXBorder And .x < UserPos.x + MinXBorder And .Y > UserPos.Y - MinYBorder And .Y < UserPos.Y + MinYBorder
    End With
End Function

Sub MoveCharbyPos(ByVal CharIndex As Integer, ByVal nX As Integer, ByVal nY As Integer)
On Error Resume Next
    Dim x As Integer
    Dim Y As Integer
    Dim addx As Integer
    Dim addy As Integer
    Dim nHeading As Byte
    
    With CharList(CharIndex)
        x = .Pos.x
        Y = .Pos.Y
        
        MapData(x, Y).CharIndex = 0
        
        addx = nX - x
        addy = nY - Y
        
        If Sgn(addx) = 1 Then
            nHeading = EAST
        End If
        
        If Sgn(addx) = -1 Then
            nHeading = WEST
        End If
        
        If Sgn(addy) = -1 Then
            nHeading = NORTH
        End If
        
        If Sgn(addy) = 1 Then
            nHeading = SOUTH
        End If
        
        MapData(nX, nY).CharIndex = CharIndex
        
        
        .Pos.x = nX
        .Pos.Y = nY
        
        .MoveOffsetX = -1 * (TilePixelWidth * addx)
        .MoveOffsetY = -1 * (TilePixelHeight * addy)
        
        .Moving = 1
        .Heading = nHeading
        
        .scrollDirectionX = Sgn(addx)
        .scrollDirectionY = Sgn(addy)
    End With

End Sub

Sub MoveScreen(ByVal nHeading As Byte)
'******************************************
'Starts the screen moving in a direction
'******************************************
    Dim x As Integer
    Dim Y As Integer
    Dim tx As Byte
    Dim ty As Byte
    
    'Figure out which way to move
    Select Case nHeading
        Case NORTH
            Y = -1
        
        Case EAST
            x = 1
        
        Case SOUTH
            Y = 1
        
        Case WEST
            x = -1
    End Select
    
    'Fill temp pos
    tx = UserPos.x + x
    ty = UserPos.Y + Y
    
    'Check to see if its out of bounds
    If tx < MinXBorder Or tx > MaxXBorder Or ty < MinYBorder Or ty > MaxYBorder Then
        Exit Sub
    Else
        'Start moving... MainLoop does the rest
        AddtoUserPos.x = x
        UserPos.x = tx
        AddtoUserPos.Y = Y
        UserPos.Y = ty
        UserMoving = 1
        
        bTecho = IIf(MapData(UserPos.x, UserPos.Y).Trigger = 1 Or _
                MapData(UserPos.x, UserPos.Y).Trigger = 2 Or _
                MapData(UserPos.x, UserPos.Y).Trigger = 4, True, False)
    End If
End Sub

Private Function HayFogata(ByRef location As Position) As Boolean
    Dim j As Long
    Dim k As Long
    
    For j = UserPos.x - 8 To UserPos.x + 8
        For k = UserPos.Y - 6 To UserPos.Y + 6
            If InMapBounds(CLng(j), CLng(k)) Then
                If MapData(j, k).ObjGrh.grhindex = GrhFogata Then
                    location.x = j
                    location.Y = k
                    
                    HayFogata = True
                    Exit Function
                End If
            End If
        Next k
    Next j
End Function

Function NextOpenChar() As Integer
'*************************************************
'Author: Standelf
'Last modified: 16/07/09
'Fix
'*************************************************
Dim LoopC As Integer

LoopC = 1
Do While CharList(LoopC).Active
    LoopC = LoopC + 1
Loop

NextOpenChar = LoopC

End Function


''
' Loads grh data using the new file format.
'
' @return   True if the load was successfull, False otherwise.


Function LegalPos(ByVal x As Integer, ByVal Y As Integer) As Boolean
'*****************************************************************
'Checks to see if a tile position is legal
'*****************************************************************
    'Limites del mapa
    If x < MinXBorder Or x > MaxXBorder Or Y < MinYBorder Or Y > MaxYBorder Then
        Exit Function
    End If
    
    'Tile Bloqueado?
    If MapData(x, Y).Blocked = 1 Then
        Exit Function
    End If
    
    '¿Hay un personaje?
    If MapData(x, Y).CharIndex > 0 Then
        Exit Function
    End If
   
  
    
    LegalPos = True
End Function

Function GetBitmapDimensions(ByVal BmpFile As String, ByRef bmWidth As Long, ByRef bmHeight As Long)
'*****************************************************************
'Gets the dimensions of a bmp
'*****************************************************************
    Dim BMHeader As BITMAPFILEHEADER
    Dim BINFOHeader As BITMAPINFOHEADER
    
    Open BmpFile For Binary Access Read As #1
    
    Get #1, , BMHeader
    Get #1, , BINFOHeader
    
    Close #1
    
    bmWidth = BINFOHeader.biWidth
    bmHeight = BINFOHeader.biHeight
End Function

Public Sub Grh_Render_To_Hdc(ByVal desthDC As Long, grh_index As Long, ByVal screen_x As Integer, ByVal screen_y As Integer, Optional transparent As Boolean = False)
'**************************************************************
'Author: Aaron Perkins
'Last Modify Date: 8/30/2004
'This method is SLOW... Don't use in a loop if you care about
'speed!
'Modified by Juan Martín Sotuyo Dodero
'*************************************************************
    
    On Error GoTo ErrorHandler
    
    Dim file_path As String
    Dim src_x As Integer
    Dim src_y As Integer
    Dim src_width As Integer
    Dim src_height As Integer
    Dim hdcsrc As Long
    Dim MaskDC As Long
    Dim PrevObj As Long
    Dim PrevObj2 As Long

    If grh_index <= 0 Then Exit Sub

    'If it's animated switch grh_index to first frame
    If GrhData(grh_index).NumFrames <> 1 Then
        grh_index = GrhData(grh_index).Frames(1)
    End If

        file_path = App.Path & "\graficos\" & GrhData(grh_index).FileNum & ".bmp"
        
        src_x = GrhData(grh_index).SX
        src_y = GrhData(grh_index).SY
        src_width = GrhData(grh_index).pixelWidth
        src_height = GrhData(grh_index).pixelHeight
            
        hdcsrc = CreateCompatibleDC(desthDC)
        PrevObj = SelectObject(hdcsrc, LoadPicture(file_path))
        
        If transparent = False Then
            BitBlt desthDC, screen_x, screen_y, src_width, src_height, hdcsrc, src_x, src_y, vbSrcCopy
        Else
            MaskDC = CreateCompatibleDC(desthDC)
            
            PrevObj2 = SelectObject(MaskDC, LoadPicture(file_path))
            
            Grh_Create_Mask hdcsrc, MaskDC, src_x, src_y, src_width, src_height
            
            'Render tranparently
            BitBlt desthDC, screen_x, screen_y, src_width, src_height, MaskDC, src_x, src_y, vbSrcAnd
            BitBlt desthDC, screen_x, screen_y, src_width, src_height, hdcsrc, src_x, src_y, vbSrcPaint
            
            Call DeleteObject(SelectObject(MaskDC, PrevObj2))
            
            DeleteDC MaskDC
        End If
        
        Call DeleteObject(SelectObject(hdcsrc, PrevObj))
        DeleteDC hdcsrc
        
   
    
    
    Exit Sub
    
ErrorHandler:

    
End Sub


Function HayUserAbajo(ByVal x As Integer, ByVal Y As Integer, ByVal grhindex As Integer) As Boolean
    If grhindex > 0 Then
        HayUserAbajo = _
            CharList(UserCharIndex).Pos.x >= x - (GrhData(grhindex).TileWidth \ 2) _
                And CharList(UserCharIndex).Pos.x <= x + (GrhData(grhindex).TileWidth \ 2) _
                And CharList(UserCharIndex).Pos.Y >= Y - (GrhData(grhindex).TileHeight - 1) _
                And CharList(UserCharIndex).Pos.Y <= Y
    End If
End Function

Sub LoadGraphics()
'**************************************************************
'Author: Juan Martín Sotuyo Dodero - complete rewrite
'Last Modify Date: 11/03/2006
'Initializes the SurfaceDB and sets up the rain rects
'**************************************************************
    'New surface manager :D
    'Call SurfaceDB.Initialize(DirectDraw, ClientSetup.bUseVideo, DirGraficos, ClientSetup.byMemory)
    
    'Set up te rain rects
    RLluvia(0).Top = 0:      RLluvia(1).Top = 0:      RLluvia(2).Top = 0:      RLluvia(3).Top = 0
    RLluvia(0).Left = 0:     RLluvia(1).Left = 128:   RLluvia(2).Left = 256:   RLluvia(3).Left = 384
    RLluvia(0).Right = 128:  RLluvia(1).Right = 256:  RLluvia(2).Right = 384:  RLluvia(3).Right = 512
    RLluvia(0).Bottom = 128: RLluvia(1).Bottom = 128: RLluvia(2).Bottom = 128: RLluvia(3).Bottom = 128
    
    RLluvia(4).Top = 128:    RLluvia(5).Top = 128:    RLluvia(6).Top = 128:    RLluvia(7).Top = 128
    RLluvia(4).Left = 0:     RLluvia(5).Left = 128:   RLluvia(6).Left = 256:   RLluvia(7).Left = 384
    RLluvia(4).Right = 128:  RLluvia(5).Right = 256:  RLluvia(6).Right = 384:  RLluvia(7).Right = 512
    RLluvia(4).Bottom = 256: RLluvia(5).Bottom = 256: RLluvia(6).Bottom = 256: RLluvia(7).Bottom = 256
    
    'We are done!
    'Saco esto porque el texto del cargar queda horrible
    'AddtoRichTextBox frmCargando.status, "Hecho.", , , , 1, , False
End Sub




#If ConAlfaB Then

Public Sub EfectoNoche(ByRef Surface As DirectDrawSurface7)
    Dim dArray() As Byte
    Dim ddsdDest As DDSURFACEDESC2
    Dim Modo As Long
    Dim rRect As RECT
    
    Surface.GetSurfaceDesc ddsdDest
    
    With rRect
        .Left = 0
        .Top = 0
        .Right = ddsdDest.lWidth
        .Bottom = ddsdDest.lHeight
    End With
    
    If ddsdDest.ddpfPixelFormat.lGBitMask = &H3E0 Then
        Modo = 0
    ElseIf ddsdDest.ddpfPixelFormat.lGBitMask = &H7E0 Then
        Modo = 1
    Else
        Modo = 2
    End If
    
    Dim DstLock As Boolean
    DstLock = False
    
    On Local Error GoTo HayErrorAlpha
    
    Surface.Lock rRect, ddsdDest, DDLOCK_WAIT, 0
    DstLock = True
    
    Surface.GetLockedArray dArray()
    Call BltEfectoNoche(ByVal VarPtr(dArray(0, 0)), _
        ddsdDest.lWidth, ddsdDest.lHeight, ddsdDest.lPitch, _
        Modo)
    
HayErrorAlpha:
    If DstLock = True Then
        Surface.Unlock rRect
        DstLock = False
    End If
End Sub

#End If

Private Function GetElapsedTime() As Single
'**************************************************************
'Author: Aaron Perkins
'Last Modify Date: 10/07/2002
'Gets the time that past since the last call
'**************************************************************
    Dim start_time As Currency
    Static end_time As Currency
    Static timer_freq As Currency

    'Get the timer frequency
    If timer_freq = 0 Then
        QueryPerformanceFrequency timer_freq
    End If
    
    'Get current time
    Call QueryPerformanceCounter(start_time)
    
    'Calculate elapsed time
    GetElapsedTime = (start_time - end_time) / timer_freq * 1000
    
    'Get next end time
    Call QueryPerformanceCounter(end_time)
End Function


Private Sub CleanViewPort()
'***************************************************
'Author: Juan Martín Sotuyo Dodero (Maraxus)
'Last Modify Date: 12/03/04
'Fills the viewport with black.
'***************************************************

End Sub
Private Sub Grh_Create_Mask(ByRef hdcsrc As Long, ByRef MaskDC As Long, ByVal src_x As Integer, ByVal src_y As Integer, ByVal src_width As Integer, ByVal src_height As Integer)
'**************************************************************
'Author: Juan Martín Sotuyo Dodero
'Last Modify Date: 8/30/2004
'Creates a Mask hDC, and sets the source hDC to work for trans bliting.
'**************************************************************
    Dim x As Integer
    Dim Y As Integer
    Dim TransColor As Long
    Dim ColorKey As String
    
    'ColorKey = hex(COLOR_KEY)
    
    'Check if it has an alpha component
    'If Len(ColorKey) > 6 Then
         'get rid of alpha
    '    ColorKey = "&H" & Right$(ColorKey, 6)
    'End If
    'piluex prueba
    'TransColor = Val(ColorKey)
    ColorKey = "0"
    TransColor = &H0

    'Make it a mask (set background to black and foreground to white)
    'And set the sprite's background white
    For Y = src_y To src_height + src_y
        For x = src_x To src_width + src_x
            If GetPixel(hdcsrc, x, Y) = TransColor Then
                SetPixel MaskDC, x, Y, vbWhite
                SetPixel hdcsrc, x, Y, vbBlack
            Else
                SetPixel MaskDC, x, Y, vbBlack
            End If
        Next x
    Next Y
End Sub

Public Function General_Random_Number(ByVal LowerBound As Long, ByVal UpperBound As Long) As Long
    Randomize Timer
    General_Random_Number = (UpperBound - LowerBound) * Rnd + LowerBound
End Function



Public Function General_Field_Read(ByVal field_pos As Long, ByVal Text As String, ByVal delimiter As Byte) As String
'*****************************************************************
'Author: Aaron Perkins
'Last Modify Date: 10/07/2002
'Gets a field from a delimited string
'*****************************************************************
    Dim i As Long
    Dim LastPos As Long
    Dim FieldNum As Long
   
    LastPos = 0
    FieldNum = 0
    For i = 1 To Len(Text)
        If delimiter = CByte(Asc(mid$(Text, i, 1))) Then
            FieldNum = FieldNum + 1
            If FieldNum = field_pos Then
                General_Field_Read = mid$(Text, LastPos + 1, (InStr(LastPos + 1, Text, Chr$(delimiter), vbTextCompare) - 1) - (LastPos))
                Exit Function
            End If
            LastPos = i
        End If
    Next i
    FieldNum = FieldNum + 1
    If FieldNum = field_pos Then
        General_Field_Read = mid$(Text, LastPos + 1)
    End If
End Function
Public Function General_Var_Get(ByVal file As String, ByVal Main As String, ByVal Var As String) As String
'*****************************************************************
'Author: Aaron Perkins
'Last Modify Date: 10/07/2002
'Get a var to from a text file
'*****************************************************************
    Dim sSpaces As String 'Input that the program will retrieve
    Dim szReturn As String 'Default value if the string is not found
   
    szReturn = ""
   
    sSpaces = Space$(5000)
   
    GetPrivateProfileString Main, Var, szReturn, sSpaces, Len(sSpaces), file
   
    General_Var_Get = RTrim$(sSpaces)
    General_Var_Get = Left$(General_Var_Get, Len(General_Var_Get) - 1)
End Function

