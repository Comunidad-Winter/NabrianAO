VERSION 1.0 CLASS
BEGIN
  MultiUse = -1  'True
  Persistable = 0  'NotPersistable
  DataBindingBehavior = 0  'vbNone
  DataSourceBehavior  = 0  'vbNone
  MTSTransactionMode  = 0  'NotAnMTSObject
END
Attribute VB_Name = "clsLight"
Attribute VB_GlobalNameSpace = False
Attribute VB_Creatable = True
Attribute VB_PredeclaredId = False
Attribute VB_Exposed = False
Option Explicit
Public Light_Count As Integer

Public Sub LightSet(ByVal X As Byte, ByVal Y As Byte, ByVal Rounded As Boolean, ByVal Range As Integer, ByVal R As Byte, ByVal G As Byte, ByVal B As Byte)
    Dim min_x As Integer
    Dim min_y As Integer
    Dim max_x As Integer
    Dim max_y As Integer
    Dim ix As Integer
    Dim iy As Integer
    Dim i As Integer
    
    If Rounded Then
        For i = 1 To Light_Count
            If Light_Count = 0 Then Exit For
            If Lights(i).Active = 0 Then
                Exit For
            End If
        Next i
        If i > Light_Count Then
            Light_Count = Light_Count + 1
            i = Light_Count
        End If
        MapData(X, Y).light_index = i
        ReDim Preserve Lights(1 To Light_Count) As Light
        Lights(i).Active = True
        Lights(i).map_x = X
        Lights(i).map_y = Y
        Lights(i).X = X * 32
        Lights(i).Y = Y * 32
        Lights(i).Range = Range
        Lights(i).RGBCOLOR.A = 255
        Lights(i).RGBCOLOR.R = R
        Lights(i).RGBCOLOR.G = G
        Lights(i).RGBCOLOR.B = B
    Else
            For i = 1 To Light_Count
            If Light_Count = 0 Then Exit For
            If Lights(i).Active = 0 Then
                Exit For
            End If
        Next i
        If i > Light_Count Then
            Light_Count = Light_Count + 1
            i = Light_Count
        End If
        MapData(X, Y).light_index = i
        ReDim Preserve Lights(1 To Light_Count) As Light
        Lights(i).Active = True
        Lights(i).map_x = X
        Lights(i).map_y = Y
        Lights(i).X = X * 32
        Lights(i).Y = Y * 32
        Lights(i).Range = Range
        Lights(i).RGBCOLOR.A = 255
        Lights(i).RGBCOLOR.R = R
        Lights(i).RGBCOLOR.G = G
        Lights(i).RGBCOLOR.B = B
        
        'Set up light borders
        min_x = X - Range
        min_y = Y - Range
        max_x = X + Range
        max_y = Y + Range
    
        If InMapBounds(min_x, min_y) Then
            MapData(min_x, min_y).base_light(2) = True
            MapData(min_x, min_y).light_base_value(2) = D3DColorXRGB(R, G, B)
        End If
        If InMapBounds(min_x, max_y) Then
            MapData(min_x, max_y).base_light(3) = True
            MapData(min_x, max_y).light_base_value(3) = D3DColorXRGB(R, G, B)
        End If
        If InMapBounds(max_x, min_y) Then
            MapData(max_x, min_y).base_light(0) = True
            MapData(max_x, min_y).light_base_value(0) = D3DColorXRGB(R, G, B)
        End If
        If InMapBounds(max_x, max_y) Then
            MapData(max_x, max_y).base_light(1) = True
            MapData(max_x, max_y).light_base_value(1) = D3DColorXRGB(R, G, B)
        End If
        
        'Upper Border
        For ix = min_x + 1 To max_x - 1
            If InMapBounds(ix, min_y) Then
                MapData(ix, min_y).base_light(0) = True
                MapData(ix, min_y).light_base_value(0) = D3DColorXRGB(R, G, B)
                MapData(ix, min_y).base_light(2) = True
                MapData(ix, min_y).light_base_value(2) = D3DColorXRGB(R, G, B)
            End If
        Next ix
        
        'Lower Border
        For ix = min_x + 1 To max_x - 1
            If InMapBounds(ix, max_y) Then
                MapData(ix, max_y).base_light(3) = True
                MapData(ix, max_y).light_base_value(3) = D3DColorXRGB(R, G, B)
                MapData(ix, max_y).base_light(1) = True
                MapData(ix, max_y).light_base_value(1) = D3DColorXRGB(R, G, B)
            End If
        Next ix
        
        'Right Border
        For iy = min_y + 1 To max_y - 1
            If InMapBounds(max_x, iy) Then
                MapData(max_x, iy).base_light(1) = True
                MapData(max_x, iy).light_base_value(1) = D3DColorXRGB(R, G, B)
                MapData(max_x, iy).base_light(0) = True
                MapData(max_x, iy).light_base_value(0) = D3DColorXRGB(R, G, B)
            End If
        Next iy
        
        'Left Border
        For iy = min_y + 1 To max_y - 1
            If InMapBounds(min_x, iy) Then
                MapData(min_x, iy).base_light(3) = True
                MapData(min_x, iy).light_base_value(3) = D3DColorXRGB(R, G, B)
                MapData(min_x, iy).base_light(2) = True
                MapData(min_x, iy).light_base_value(2) = D3DColorXRGB(R, G, B)
            End If
        Next iy
        
        'Left Border
        For iy = min_y + 1 To max_y - 1
            For ix = min_x + 1 To max_x - 1
                If InMapBounds(ix, iy) Then
                    MapData(ix, iy).base_light(3) = True
                    MapData(ix, iy).light_base_value(3) = D3DColorXRGB(R, G, B)
                    MapData(ix, iy).base_light(2) = True
                    MapData(ix, iy).light_base_value(2) = D3DColorXRGB(R, G, B)
                    MapData(ix, iy).base_light(1) = True
                    MapData(ix, iy).light_base_value(1) = D3DColorXRGB(R, G, B)
                    MapData(ix, iy).base_light(0) = True
                    MapData(ix, iy).light_base_value(0) = D3DColorXRGB(R, G, B)
                End If
            Next ix
        Next iy
    End If
End Sub


Public Sub Map_LightsRender()
    Dim i As Integer
    
    Call Map_LightsClear
    
    For i = 1 To Light_Count
        Map_LightRender (i)
    Next i
End Sub

Private Function Map_LightsClear()
    Dim X As Integer
    Dim Y As Integer
    
    Dim AmbientColor As D3DCOLORVALUE
    Dim Color As Long
    
    Meteo.Get_AmbientLight AmbientColor
    Color = D3DColorXRGB(AmbientColor.R, AmbientColor.G, AmbientColor.B)
    
    For X = 1 To 100
        For Y = 1 To 100
            If InMapBounds(X, Y) Then
                With MapData(X, Y)
                    If .base_light(0) Then 'Si tiene luz propia, la seteamos.
                        .light_value(0) = .light_base_value(0)
                    Else
                        .light_value(0) = Color
                    End If
                    If .base_light(1) Then
                        .light_value(1) = .light_base_value(1)
                    Else
                        .light_value(1) = Color
                    End If
                    If .base_light(2) Then
                        .light_value(2) = .light_base_value(2)
                    Else
                        .light_value(2) = Color
                    End If
                    If .base_light(3) Then
                        .light_value(3) = .light_base_value(3)
                    Else
                        .light_value(3) = Color
                    End If
                End With
            End If
        Next Y
    Next X
End Function

Private Sub Map_LightRender(ByVal light_index As Integer)
    Dim min_x As Integer
    Dim min_y As Integer
    Dim max_x As Integer
    Dim max_y As Integer
    Dim Ya As Integer
    Dim Xa As Integer
    
    Dim AmbientColor As D3DCOLORVALUE
    Dim LightColor As D3DCOLORVALUE
    
    Dim XCoord As Integer
    Dim YCoord As Integer
        
        LightColor = Lights(light_index).RGBCOLOR
        Meteo.Get_AmbientLight AmbientColor
        
        If Not Lights(light_index).Active = True Then Exit Sub
        
        min_x = Lights(light_index).map_x - Lights(light_index).Range
        max_x = Lights(light_index).map_x + Lights(light_index).Range
        min_y = Lights(light_index).map_y - Lights(light_index).Range
        max_y = Lights(light_index).map_y + Lights(light_index).Range
        
        For Ya = min_y To max_y
            For Xa = min_x To max_x
                If InMapBounds(Xa, Ya) Then
                    XCoord = Xa * 32
                    YCoord = Ya * 32
                    'Color = LightCalculate(lights(light_index).range, lights(light_index).x, lights(light_index).y, XCoord, YCoord, mapdata(Xa, Ya).light_value(1), LightColor, AmbientColor)
                    MapData(Xa, Ya).light_value(1) = LightCalculate(Lights(light_index).Range, Lights(light_index).X, Lights(light_index).Y, XCoord, YCoord, MapData(Xa, Ya).light_value(1), LightColor, AmbientColor)

                    XCoord = Xa * 32 + 32
                    YCoord = Ya * 32
                    MapData(Xa, Ya).light_value(3) = LightCalculate(Lights(light_index).Range, Lights(light_index).X, Lights(light_index).Y, XCoord, YCoord, MapData(Xa, Ya).light_value(3), LightColor, AmbientColor)
                       
                    XCoord = Xa * 32
                    YCoord = Ya * 32 + 32
                    MapData(Xa, Ya).light_value(0) = LightCalculate(Lights(light_index).Range, Lights(light_index).X, Lights(light_index).Y, XCoord, YCoord, MapData(Xa, Ya).light_value(0), LightColor, AmbientColor)
    
                    XCoord = Xa * 32 + 32
                    YCoord = Ya * 32 + 32
                    MapData(Xa, Ya).light_value(2) = LightCalculate(Lights(light_index).Range, Lights(light_index).X, Lights(light_index).Y, XCoord, YCoord, MapData(Xa, Ya).light_value(2), LightColor, AmbientColor)
                End If
            Next Xa
        Next Ya
End Sub

Private Function LightCalculate(ByVal cRadio As Integer, ByVal LightX As Integer, ByVal LightY As Integer, ByVal XCoord As Integer, ByVal YCoord As Integer, TileLight As Long, LightColor As D3DCOLORVALUE, AmbientColor As D3DCOLORVALUE) As Long
    Dim XDist As Single
    Dim YDist As Single
    Dim VertexDist As Single
    Dim pRadio As Integer
    
    Dim CurrentColor As D3DCOLORVALUE
    
    pRadio = cRadio * 32
    
    XDist = LightX + 16 - XCoord
    YDist = LightY + 16 - YCoord
    
    VertexDist = Sqr(XDist * XDist + YDist * YDist)
    
    If VertexDist <= pRadio Then
        Call D3DXColorLerp(CurrentColor, LightColor, AmbientColor, VertexDist / pRadio)
        LightCalculate = D3DColorXRGB(CurrentColor.R, CurrentColor.G, CurrentColor.B)
        If TileLight > LightCalculate Then LightCalculate = TileLight
    Else
        LightCalculate = TileLight
    End If
End Function

Public Sub LightDestroy(ByVal X As Byte, ByVal Y As Byte)
    If MapData(X, Y).light_index Then
        Lights(MapData(X, Y).light_index).Active = False
        MapData(X, Y).light_index = 0
    Else
        MapData(X, Y).base_light(0) = False
        MapData(X, Y).base_light(1) = False
        MapData(X, Y).base_light(2) = False
        MapData(X, Y).base_light(3) = False
    End If
End Sub

Public Sub LightDestroyAll()
    Dim X As Integer
    Dim Y As Integer
    For X = 1 To 100
        For Y = 1 To 100
        Call LightDestroy(X, Y)
        Next Y
    Next X
End Sub

