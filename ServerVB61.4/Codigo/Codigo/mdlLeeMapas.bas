Attribute VB_Name = "mdlLeeMapas"
 
'director del proyecto: #Esteban(Neliam)

'servidor basado en fénixao 1.0
'medios de contacto:
'Skype: dc.esteban
'E-mail: nabrianao@gmail.com
Option Explicit







Public Type TileMap
    bloqueado As Byte
    
    grafs1 As Integer
    grafs2 As Integer
    grafs3 As Integer
    grafs4 As Integer
    trigger As Integer

    t1 As Integer
End Type

Public Type TileInf
    dest_mapa As Integer
    dest_x As Integer
    dest_y As Integer
    
    Npc As Integer
    
    obj_ind As Integer
    obj_cant As Integer
    
    t1 As Integer
    t2 As Integer
End Type

Public Declare Function MAPCargaMapa Lib "LeeMapas.dll" (ByVal archmap As String, ByVal archinf As String) As Long
Public Declare Function MAPCierraMapa Lib "LeeMapas.dll" (ByVal Dm As Long) As Long

Public Declare Function MAPLeeMapa Lib "LeeMapas.dll" (ByVal Dm As Long, Tile_Map As TileMap, Tile_Inf As TileInf) As Long

