Attribute VB_Name = "modEdicion"
Option Explicit

Dim oldtX As Byte, oldtY As Byte

''
' Vacia el Deshacer
'
Public Sub Deshacer_Clear()

Dim i As Integer

For i = 1 To maxDeshacer
    MapData_Deshacer_Info(i).Libre = True
Next

frmMain.mnuDeshacer.Enabled = False

End Sub
''
' Agrega un Deshacer
'
Public Sub Deshacer_Add(ByVal Desc As String)

If frmMain.mnuUtilizarDeshacer.Checked = False Then Exit Sub

Dim i As Integer
Dim F As Integer
Dim j As Integer
' Desplazo todos los deshacer uno hacia atras
For i = maxDeshacer To 2 Step -1
    For F = XMinMapSize To XMaxMapSize
        For j = YMinMapSize To YMaxMapSize
            MapData_Deshacer(i, F, j) = MapData_Deshacer(i - 1, F, j)
        Next
    Next
    MapData_Deshacer_Info(i) = MapData_Deshacer_Info(i - 1)
Next
' Guardo los valores
For F = XMinMapSize To XMaxMapSize
    For j = YMinMapSize To YMaxMapSize
        MapData_Deshacer(1, F, j) = MapData(F, j)
    Next
Next
MapData_Deshacer_Info(1).Desc = Desc
MapData_Deshacer_Info(1).Libre = False
frmMain.mnuDeshacer.Caption = "&Deshacer (Ultimo: " & MapData_Deshacer_Info(1).Desc & ")"
frmMain.mnuDeshacer.Enabled = True
End Sub

''
' Deshacer un paso del Deshacer
'
Public Sub Deshacer_Recover()

Dim i As Integer
Dim F As Integer
Dim j As Integer
Dim Body As Integer
Dim Head As Integer
Dim Heading As Byte

If MapData_Deshacer_Info(1).Libre = False Then
    ' Aplico deshacer
    For F = XMinMapSize To XMaxMapSize
        For j = YMinMapSize To YMaxMapSize
            If (MapData(F, j).NpcIndex <> 0 And MapData(F, j).NpcIndex <> MapData_Deshacer(1, F, j).NpcIndex) Or (MapData(F, j).NpcIndex <> 0 And MapData_Deshacer(1, F, j).NpcIndex = 0) Then
                ' Si ahi un NPC, y en el deshacer es otro lo borramos
                ' (o) Si aun no NPC y en el deshacer no esta
                MapData(F, j).NpcIndex = 0
                Call EraseChar(MapData(F, j).CharIndex)
            End If
            If MapData_Deshacer(1, F, j).NpcIndex <> 0 And MapData(F, j).NpcIndex = 0 Then
                ' Si ahi un NPC en el deshacer y en el no esta lo hacemos
                Body = NpcData(MapData_Deshacer(1, F, j).NpcIndex).Body
                Head = NpcData(MapData_Deshacer(1, F, j).NpcIndex).Head
                Heading = NpcData(MapData_Deshacer(1, F, j).NpcIndex).Heading
                Call MakeChar(NextOpenChar(), Body, Head, Heading, F, j)
            Else
                MapData(F, j) = MapData_Deshacer(1, F, j)
            End If
        Next
    Next
    MapData_Deshacer_Info(1).Libre = True
    ' Desplazo todos los deshacer uno hacia adelante
    For i = 1 To maxDeshacer - 1
        For F = XMinMapSize To XMaxMapSize
            For j = YMinMapSize To YMaxMapSize
                MapData_Deshacer(i, F, j) = MapData_Deshacer(i + 1, F, j)
            Next
        Next
        MapData_Deshacer_Info(i) = MapData_Deshacer_Info(i + 1)
    Next
    ' borro el ultimo
    MapData_Deshacer_Info(maxDeshacer).Libre = True
    ' ahi para deshacer?
    If MapData_Deshacer_Info(1).Libre = True Then
        frmMain.mnuDeshacer.Caption = "&Deshacer (no ahi nada que deshacer)"
        frmMain.mnuDeshacer.Enabled = False
    Else
        frmMain.mnuDeshacer.Caption = "&Deshacer (Ultimo: " & MapData_Deshacer_Info(1).Desc & ")"
        frmMain.mnuDeshacer.Enabled = True
    End If
Else
    MsgBox "No ahi acciones para deshacer", vbInformation
End If
End Sub

''
' Manda una advertencia de Edicion Critica
'
' @return   Nos devuelve si acepta o no el cambio

Private Function EditWarning() As Boolean
'*************************************************
'Author: ^[GS]^
'Last modified: 20/05/06
'*************************************************
If MsgBox(MSGDang, vbExclamation + vbYesNo) = vbNo Then
    EditWarning = True
Else
    EditWarning = False
End If
End Function


''
' Bloquea los Bordes del Mapa
'

Public Sub Bloquear_Bordes()

Dim Y As Integer
Dim X As Integer

If Not MapaCargado Then
    Exit Sub
End If

modEdicion.Deshacer_Add "Bloquear los bordes" ' Hago deshacer

For Y = YMinMapSize To YMaxMapSize
    For X = XMinMapSize To XMaxMapSize
        If X < MinXBorder Or X > MaxXBorder Or Y < MinYBorder Or Y > MaxYBorder Then
            MapData(X, Y).Blocked = 1
        End If
    Next X
Next Y

'Set changed flag
MapInfo.Changed = 1
End Sub

''
' Coloca la superficie seleccionada al azar en el mapa
'

Public Sub Superficie_Azar()
'*************************************************
'Author: ^[GS]^
'Last modified: 20/05/06
'*************************************************

On Error Resume Next
Dim Y As Integer
Dim X As Integer
Dim Cuantos As Integer
Dim k As Integer

If Not MapaCargado Then
    Exit Sub
End If

Cuantos = InputBox("Cuantos Grh se deben poner en este mapa?", "Poner Grh Al Azar", 0)
If Cuantos > 0 Then
    modEdicion.Deshacer_Add "Insertar Superficie al Azar" ' Hago deshacer
    For k = 1 To Cuantos
        X = RandomNumber(10, 90)
        Y = RandomNumber(10, 90)
        If frmConfigSup.MOSAICO.value = vbChecked Then
          Dim aux As Integer
          Dim dy As Integer
          Dim dX As Integer
          If frmConfigSup.DespMosaic.value = vbChecked Then
                        dy = Val(frmConfigSup.DMLargo)
                        dX = Val(frmConfigSup.DMAncho.Text)
          Else
                    dy = 0
                    dX = 0
          End If
                
          If frmMain.mnuAutoCompletarSuperficies.Checked = False Then
                aux = Val(frmMain.cGrh.Text) + _
                (((Y + dy) Mod frmConfigSup.mLargo.Text) * frmConfigSup.mAncho.Text) + ((X + dX) Mod frmConfigSup.mAncho.Text)
                If frmMain.cInsertarBloqueo.value = True Then
                    MapData(X, Y).Blocked = 1
                Else
                    MapData(X, Y).Blocked = 0
                End If
                MapData(X, Y).Graphic(Val(frmMain.cCapas.Text)).grhindex = aux
                InitGrh MapData(X, Y).Graphic(Val(frmMain.cCapas.Text)), aux
          Else
                Dim tXX As Integer, tYY As Integer, i As Integer, j As Integer, desptile As Integer
                tXX = X
                tYY = Y
                desptile = 0
                For i = 1 To frmConfigSup.mLargo.Text
                    For j = 1 To frmConfigSup.mAncho.Text
                        aux = Val(frmMain.cGrh.Text) + desptile
                         
                        If frmMain.cInsertarBloqueo.value = True Then
                            MapData(tXX, tYY).Blocked = 1
                        Else
                            MapData(tXX, tYY).Blocked = 0
                        End If

                         MapData(tXX, tYY).Graphic(Val(frmMain.cCapas.Text)).grhindex = aux
                         
                         InitGrh MapData(tXX, tYY).Graphic(Val(frmMain.cCapas.Text)), aux
                         tXX = tXX + 1
                         desptile = desptile + 1
                    Next
                    tXX = X
                    tYY = tYY + 1
                Next
                tYY = Y
          End If
        End If
    Next
End If

'Set changed flag
MapInfo.Changed = 1

End Sub

''
' Coloca la superficie seleccionada en todos los bordes
'

Public Sub Superficie_Bordes()
'*************************************************
'Author: ^[GS]^
'Last modified: 20/05/06
'*************************************************

Dim Y As Integer
Dim X As Integer

If Not MapaCargado Then
    Exit Sub
End If

modEdicion.Deshacer_Add "Insertar Superficie en todos los bordes" ' Hago deshacer

For Y = YMinMapSize To YMaxMapSize
    For X = XMinMapSize To XMaxMapSize

        If X < MinXBorder Or X > MaxXBorder Or Y < MinYBorder Or Y > MaxYBorder Then

          If frmConfigSup.MOSAICO.value = vbChecked Then
            Dim aux As Integer
            aux = Val(frmMain.cGrh.Text) + _
            ((Y Mod frmConfigSup.mLargo) * frmConfigSup.mAncho) + (X Mod frmConfigSup.mAncho)
            If frmMain.cInsertarBloqueo.value = True Then
                MapData(X, Y).Blocked = 1
          '  Else
         '       MapData(X, Y).Blocked = 0
            End If
            MapData(X, Y).Graphic(Val(frmMain.cCapas.Text)).grhindex = aux
            'Setup GRH
            InitGrh MapData(X, Y).Graphic(Val(frmMain.cCapas.Text)), aux
          Else
            'Else Place graphic
            If frmMain.cInsertarBloqueo.value = True Then
                MapData(X, Y).Blocked = 1
         '   Else
         '       MapData(X, Y).Blocked = 0
            End If
            
            MapData(X, Y).Graphic(Val(frmMain.cCapas.Text)).grhindex = Val(frmMain.cGrh.Text)
            
            'Setup GRH
    
            InitGrh MapData(X, Y).Graphic(Val(frmMain.cCapas.Text)), Val(frmMain.cGrh.Text)
        End If
             'Erase NPCs
            If MapData(X, Y).NpcIndex > 0 Then
                EraseChar MapData(X, Y).CharIndex
                MapData(X, Y).NpcIndex = 0
            End If

            'Erase Objs
            MapData(X, Y).OBJInfo.OBJIndex = 0
            MapData(X, Y).OBJInfo.Amount = 0
            MapData(X, Y).ObjGrh.grhindex = 0

            'Clear exits
            MapData(X, Y).TileExit.Map = 0
            MapData(X, Y).TileExit.X = 0
            MapData(X, Y).TileExit.Y = 0

        End If

    Next X
Next Y

'Set changed flag
MapInfo.Changed = 1

End Sub

''
' Coloca la misma superficie seleccionada en todo el mapa
'

Public Sub Superficie_Todo()
'*************************************************
'Author: ^[GS]^
'Last modified: 20/05/06
'*************************************************

If EditWarning Then Exit Sub

Dim Y As Integer
Dim X As Integer

If Not MapaCargado Then
    Exit Sub
End If

modEdicion.Deshacer_Add "Insertar Superficie en todo el mapa" ' Hago deshacer

For Y = YMinMapSize To YMaxMapSize
    For X = XMinMapSize To XMaxMapSize

        If frmConfigSup.MOSAICO.value = vbChecked Then
            Dim aux As Integer
            aux = Val(frmMain.cGrh.Text) + _
            ((Y Mod frmConfigSup.mLargo) * frmConfigSup.mAncho) + (X Mod frmConfigSup.mAncho)
             MapData(X, Y).Graphic(Val(frmMain.cCapas.Text)).grhindex = aux
            'Setup GRH
            InitGrh MapData(X, Y).Graphic(Val(frmMain.cCapas.Text)), aux
        Else
            'Else Place graphic
            MapData(X, Y).Graphic(Val(frmMain.cCapas.Text)).grhindex = Val(frmMain.cGrh.Text)
            'Setup GRH
            InitGrh MapData(X, Y).Graphic(Val(frmMain.cCapas.Text)), Val(frmMain.cGrh.Text)
        End If

    Next X
Next Y

'Set changed flag
MapInfo.Changed = 1

End Sub

''
' Modifica los bloqueos de todo mapa
'
' @param Valor Especifica el estado de Bloqueo que se asignara


Public Sub Bloqueo_Todo(ByVal Valor As Byte)
'*************************************************
'Author: ^[GS]^
'Last modified: 20/05/06
'*************************************************

If EditWarning Then Exit Sub


Dim Y As Integer
Dim X As Integer

If Not MapaCargado Then
    Exit Sub
End If

modEdicion.Deshacer_Add "Bloquear todo el mapa" ' Hago deshacer

For Y = YMinMapSize To YMaxMapSize
    For X = XMinMapSize To XMaxMapSize
        MapData(X, Y).Blocked = Valor
    Next X
Next Y

'Set changed flag
MapInfo.Changed = 1

End Sub

''
' Borra todo el Mapa menos los Triggers
'

Public Sub Borrar_Mapa()
'*************************************************
'Author: ^[GS]^
'Last modified: 20/05/06
'*************************************************

If EditWarning Then Exit Sub


Dim Y As Integer
Dim X As Integer

If Not MapaCargado Then
    Exit Sub
End If

modEdicion.Deshacer_Add "Borrar todo el mapa menos Triggers" ' Hago deshacer

For Y = YMinMapSize To YMaxMapSize
    For X = XMinMapSize To XMaxMapSize
        MapData(X, Y).Graphic(1).grhindex = 1
        'Change blockes status
        MapData(X, Y).Blocked = 0

        'Erase layer 2 and 3
        MapData(X, Y).Graphic(2).grhindex = 0
        MapData(X, Y).Graphic(3).grhindex = 0
        MapData(X, Y).Graphic(4).grhindex = 0

        'Erase NPCs
        If MapData(X, Y).NpcIndex > 0 Then
            EraseChar MapData(X, Y).CharIndex
            MapData(X, Y).NpcIndex = 0
        End If

        'Erase Objs
        MapData(X, Y).OBJInfo.OBJIndex = 0
        MapData(X, Y).OBJInfo.Amount = 0
        MapData(X, Y).ObjGrh.grhindex = 0

        'Clear exits
        MapData(X, Y).TileExit.Map = 0
        MapData(X, Y).TileExit.X = 0
        MapData(X, Y).TileExit.Y = 0
        
                   Light.LightDestroy X, Y
        If MapData(X, Y).particle_group_index Then
                Call engine.Particle_Group_Remove(MapData(X, Y).particle_group_index)
                MapData(X, Y).particle_group_index = 0
                MapData(X, Y).parti_index = 0
        End If
        InitGrh MapData(X, Y).Graphic(1), 1

    Next X
Next Y

'Set changed flag
MapInfo.Changed = 1
End Sub

''
' Elimita los NPCs del mapa
'
' @param Hostiles Indica si elimita solo hostiles o solo npcs no hostiles

Public Sub Quitar_NPCs(ByVal Hostiles As Boolean)
'*************************************************
'Author: ^[GS]^
'Last modified: 20/05/06
'*************************************************

If EditWarning Then Exit Sub

modEdicion.Deshacer_Add "Quitar todos los NPCs" & IIf(Hostiles = True, " Hostiles", "") ' Hago deshacer

Dim Y As Integer
Dim X As Integer

For Y = YMinMapSize To YMaxMapSize
    For X = XMinMapSize To XMaxMapSize
        If MapData(X, Y).NpcIndex > 0 Then
            If (Hostiles = True And MapData(X, Y).NpcIndex >= 500) Or (Hostiles = False And MapData(X, Y).NpcIndex < 500) Then
                Call EraseChar(MapData(X, Y).CharIndex)
                MapData(X, Y).NpcIndex = 0
            End If
        End If
    Next X
Next Y

bRefreshRadar = True ' Radar

'Set changed flag
MapInfo.Changed = 1
End Sub

''
' Elimita todos los Objetos del mapa
'

Public Sub Quitar_Objetos()
'*************************************************
'Author: ^[GS]^
'Last modified: 20/05/06
'*************************************************

If EditWarning Then Exit Sub

modEdicion.Deshacer_Add "Quitar todos los Objetos" ' Hago deshacer

Dim Y As Integer
Dim X As Integer

For Y = YMinMapSize To YMaxMapSize
    For X = XMinMapSize To XMaxMapSize
        If MapData(X, Y).OBJInfo.OBJIndex > 0 Then
            If MapData(X, Y).Graphic(3).grhindex = MapData(X, Y).ObjGrh.grhindex Then MapData(X, Y).Graphic(3).grhindex = 0
            MapData(X, Y).OBJInfo.OBJIndex = 0
            MapData(X, Y).OBJInfo.Amount = 0
        End If
    Next X
Next Y

'Set changed flag
MapInfo.Changed = 1
End Sub

''
' Elimina todos los Triggers del mapa
'

Public Sub Quitar_Triggers()
'*************************************************
'Author: ^[GS]^
'Last modified: 20/05/06
'*************************************************

If EditWarning Then Exit Sub

modEdicion.Deshacer_Add "Quitar todos los Triggers" ' Hago deshacer

Dim Y As Integer
Dim X As Integer

For Y = YMinMapSize To YMaxMapSize
    For X = XMinMapSize To XMaxMapSize
        If MapData(X, Y).Trigger > 0 Then
            MapData(X, Y).Trigger = 0
        End If
    Next X
Next Y

'Set changed flag
MapInfo.Changed = 1
End Sub

''
' Elimita todos los translados del mapa
'

Public Sub Quitar_Translados()
'*************************************************
'Author: ^[GS]^
'Last modified: 16/10/06
'*************************************************

If EditWarning Then Exit Sub

modEdicion.Deshacer_Add "Quitar todos los Translados" ' Hago deshacer

Dim Y As Integer
Dim X As Integer

For Y = YMinMapSize To YMaxMapSize
    For X = XMinMapSize To XMaxMapSize
        If MapData(X, Y).TileExit.Map > 0 Then
            MapData(X, Y).TileExit.Map = 0
            MapData(X, Y).TileExit.X = 0
            MapData(X, Y).TileExit.Y = 0
        End If
    Next X
Next Y

'Set changed flag
MapInfo.Changed = 1

End Sub
Public Sub Quitar_LUCES()
'*************************************************
'Author: ^[GS]^
'Last modified: 16/10/06
'*************************************************

If EditWarning Then Exit Sub

modEdicion.Deshacer_Add "Quitar todas las luces" ' Hago deshacer

Dim Y As Integer
Dim X As Integer

For Y = YMinMapSize To YMaxMapSize
    For X = XMinMapSize To XMaxMapSize
             Light.LightDestroy X, Y
      
    Next X
Next Y

'Set changed flag
MapInfo.Changed = 1

End Sub

Public Sub Quitar_Particulas()
'*************************************************
'Author: ^[GS]^
'Last modified: 16/10/06
'*************************************************

If EditWarning Then Exit Sub

modEdicion.Deshacer_Add "Quitar todas las particulas" ' Hago deshacer

Dim Y As Integer
Dim X As Integer

For Y = YMinMapSize To YMaxMapSize
    For X = XMinMapSize To XMaxMapSize
         If MapData(X, Y).particle_group_index Then
                Call engine.Particle_Group_Remove(MapData(X, Y).particle_group_index)
                MapData(X, Y).particle_group_index = 0
                MapData(X, Y).parti_index = 0
            End If
    Next X
Next Y

'Set changed flag
MapInfo.Changed = 1

End Sub

''
' Elimita todo lo que se encuentre en los bordes del mapa
'

Public Sub Quitar_Bordes()
'*************************************************
'Author: ^[GS]^
'Last modified: 20/05/06
'*************************************************

If EditWarning Then Exit Sub

'*****************************************************************
'Clears a border in a room with current GRH
'*****************************************************************

Dim Y As Integer
Dim X As Integer

If Not MapaCargado Then
    Exit Sub
End If

modEdicion.Deshacer_Add "Quitar todos los Bordes" ' Hago deshacer

For Y = YMinMapSize To YMaxMapSize
    For X = XMinMapSize To XMaxMapSize

        If X < MinXBorder Or X > MaxXBorder Or Y < MinYBorder Or Y > MaxYBorder Then
        
            MapData(X, Y).Graphic(1).grhindex = 1
            InitGrh MapData(X, Y).Graphic(1), 1
            MapData(X, Y).Blocked = 0
            
             'Erase NPCs
            If MapData(X, Y).NpcIndex > 0 Then
                EraseChar MapData(X, Y).CharIndex
                MapData(X, Y).NpcIndex = 0
            End If

            'Erase Objs
            MapData(X, Y).OBJInfo.OBJIndex = 0
            MapData(X, Y).OBJInfo.Amount = 0
            MapData(X, Y).ObjGrh.grhindex = 0

            'Clear exits
            MapData(X, Y).TileExit.Map = 0
            MapData(X, Y).TileExit.X = 0
            MapData(X, Y).TileExit.Y = 0
            
            ' Triggers
            MapData(X, Y).Trigger = 0

        End If

    Next X
Next Y

'Set changed flag
MapInfo.Changed = 1

End Sub

''
' Elimita una capa completa del mapa
'
' @param Capa Especifica la capa


Public Sub Quitar_Capa(ByVal Capa As Byte)
'*************************************************
'Author: ^[GS]^
'Last modified: 20/05/06
'*************************************************

If EditWarning Then Exit Sub

'*****************************************************************
'Clears one layer
'*****************************************************************

Dim Y As Integer
Dim X As Integer

If Not MapaCargado Then
    Exit Sub
End If
modEdicion.Deshacer_Add "Quitar Capa " & Capa ' Hago deshacer

For Y = YMinMapSize To YMaxMapSize
    For X = XMinMapSize To XMaxMapSize
        If Capa = 1 Then
            MapData(X, Y).Graphic(Capa).grhindex = 1
        Else
            MapData(X, Y).Graphic(Capa).grhindex = 0
        End If
    Next X
Next Y

'Set changed flag
MapInfo.Changed = 1
End Sub

''
' Acciona la operacion al hacer doble click en una posicion del mapa
'
' @param tX Especifica la posicion X en el mapa
' @param tY Espeficica la posicion Y en el mapa

Sub DobleClick(tx As Integer, ty As Integer)
'*************************************************
'Author: ^[GS]^
'Last modified: 28/05/06
'*************************************************
' Translados
Dim tTrans As WorldPos
tTrans = MapData(tx, ty).TileExit
If tTrans.Map > 0 Then
    If LenB(frmMain.Dialog.FileName) <> 0 Then
        If FileExist(PATH_Save & NameMap_Save & tTrans.Map & ".mcl", vbArchive) = True Then
            Call modMapIO.NuevoMapa
            frmMain.Dialog.FileName = PATH_Save & NameMap_Save & tTrans.Map & ".mcl"
            modMapIO.CargarMapa frmMain.Dialog.FileName
            UserPos.X = tTrans.X
            UserPos.Y = tTrans.Y
            If WalkMode = True Then
                MoveCharbyPos UserCharIndex, UserPos.X, UserPos.Y
                CharList(UserCharIndex).Heading = SOUTH
            End If
            frmMain.mnuReAbrirMapa.Enabled = True
        End If
    End If
End If
End Sub


Sub RepetirEnForm(tx As Integer, ty As Integer)
'*************************************************
'Author: Deut
'Last modified: 09/12/09
'*************************************************
If tx = oldtX And ty = oldtY Then Exit Sub
        
        ' Posicion
        frmMain.LabelPosX.Caption = "X= " & tx
        frmMain.LabelPosY.Caption = "Y= " & ty
        
        ' Bloqueos
        If MapData(tx, ty).Blocked = 1 Then
            frmMain.LabelBloqueado.ForeColor = &HC0&
            frmMain.LabelBloqueado.Caption = "Bloqueado"
        Else
            frmMain.LabelBloqueado.ForeColor = &H80000012
            frmMain.LabelBloqueado.Caption = "Sin Bloqueo"
        End If
        
        ' Traslados
        If MapData(tx, ty).TileExit.Map > 0 Then
            frmMain.LabelTrasMapa.Caption = "Mapa= " & MapData(tx, ty).TileExit.Map
            frmMain.LabelTrasX.Caption = "X= " & MapData(tx, ty).TileExit.X
            frmMain.LabelTrasY.Caption = "Y= " & MapData(tx, ty).TileExit.Y
        Else
            frmMain.LabelTrasMapa.Caption = ""
            frmMain.LabelTrasX.Caption = ""
            frmMain.LabelTrasY.Caption = ""
        End If
        
        ' NPCs
        If MapData(tx, ty).NpcIndex > 0 Then
            frmMain.LabelNPCIndex.Caption = "Index= " & MapData(tx, ty).NpcIndex
            frmMain.LabelNPCName.Caption = "Name= " & NpcData(MapData(tx, ty).NpcIndex).Name
            If MapData(tx, ty).NpcIndex > 499 Then
                frmMain.LabelTipoNPC.Caption = "Hostil"
            Else
                frmMain.LabelTipoNPC = "Pacífico"
            End If
        Else
            frmMain.LabelTipoNPC.Caption = ""
            frmMain.LabelNPCIndex.Caption = ""
            frmMain.LabelNPCName.Caption = ""
        End If
        
        ' OBJs
        If MapData(tx, ty).OBJInfo.OBJIndex > 0 Then
            frmMain.LabelOBJIndex.Caption = "Index= " & MapData(tx, ty).OBJInfo.OBJIndex
            frmMain.LabelOBJName.Caption = "Name= " & ObjData(MapData(tx, ty).OBJInfo.OBJIndex).Name
            frmMain.LabelOBJCantidad.Caption = "Cantidad= " & MapData(tx, ty).OBJInfo.Amount
        Else
            frmMain.LabelOBJIndex.Caption = ""
            frmMain.LabelOBJName.Caption = ""
            frmMain.LabelOBJCantidad.Caption = ""
        End If
        
        ' Capas
        frmMain.LabelCapa(1).Caption = "Capa1= " & NameDeSup(MapData(tx, ty).Graphic(1).grhindex)
        frmMain.LabelCapa(2).Caption = "Capa2= " & NameDeSup(MapData(tx, ty).Graphic(2).grhindex)
        frmMain.LabelCapa(3).Caption = "Capa3= " & NameDeSup(MapData(tx, ty).Graphic(3).grhindex)
        frmMain.LabelCapa(4).Caption = "Capa4= " & NameDeSup(MapData(tx, ty).Graphic(4).grhindex)
     
        
        ' Último Tile Informado
        oldtX = tx
        oldtY = ty

End Sub




''
' Realiza una operacion de edicion aislada sobre el mapa
'
' @param Button Indica el estado del Click del mouse
' @param tX Especifica la posicion X en el mapa
' @param tY Especifica la posicion Y en el mapa

Sub ClickEdit(Button As Integer, tx As Byte, ty As Byte)
'*************************************************
'Author: Unknown
'Last modified: 15/12/09 - Deut
'*************************************************

    Dim LoopC As Integer
    Dim NpcIndex As Integer
    Dim OBJIndex As Integer
    Dim Head As Integer
    Dim Body As Integer
    Dim Heading As Byte
    
    If ty < 1 Or ty > 100 Then Exit Sub
    If tx < 1 Or tx > 100 Then Exit Sub
    
    
    If Button = 0 Then
        SobreY = ty
        SobreX = tx
    End If
    
    'Right
    
    If Button = vbRightButton Then
    
        If tx = oldtX And ty = oldtY Then Exit Sub
        
        ' Posicion
        frmMain.StatTxt.Text = frmMain.StatTxt.Text & ENDL & ENDL & "Posición " & tx & "," & ty
        
        ' Bloqueos
        If MapData(tx, ty).Blocked = 1 Then frmMain.StatTxt.Text = frmMain.StatTxt.Text & " (BLOQ)"
        
        ' Traslados
        If MapData(tx, ty).TileExit.Map > 0 Then
            If frmMain.mnuAutoCapturarTranslados.Checked = True Then
                frmMain.tTMapa.Text = MapData(tx, ty).TileExit.Map
                frmMain.tTX.Text = MapData(tx, ty).TileExit.X
                frmMain.tTY = MapData(tx, ty).TileExit.Y
            End If
            frmMain.StatTxt.Text = frmMain.StatTxt.Text & " (Trans.: " & MapData(tx, ty).TileExit.Map & "," & MapData(tx, ty).TileExit.X & "," & MapData(tx, ty).TileExit.Y & ")"
        End If
        
        ' NPCs
        If MapData(tx, ty).NpcIndex > 0 Then
            If MapData(tx, ty).NpcIndex > 499 Then
                frmMain.StatTxt.Text = frmMain.StatTxt.Text & " (NPC-Hostil: " & MapData(tx, ty).NpcIndex & " - " & NpcData(MapData(tx, ty).NpcIndex).Name & ")"
            Else
                frmMain.StatTxt.Text = frmMain.StatTxt.Text & " (NPC: " & MapData(tx, ty).NpcIndex & " - " & NpcData(MapData(tx, ty).NpcIndex).Name & ")"
            End If
        End If
        
        ' OBJs
        If MapData(tx, ty).OBJInfo.OBJIndex > 0 Then
            frmMain.StatTxt.Text = frmMain.StatTxt.Text & " (Obj: " & MapData(tx, ty).OBJInfo.OBJIndex & " - " & ObjData(MapData(tx, ty).OBJInfo.OBJIndex).Name & " - Cant.:" & MapData(tx, ty).OBJInfo.Amount & ")"
        End If
        
        ' Capas
        frmMain.StatTxt.Text = frmMain.StatTxt.Text & ENDL & "Capa1: " & MapData(tx, ty).Graphic(1).grhindex & " - Capa2: " & MapData(tx, ty).Graphic(2).grhindex & " - Capa3: " & MapData(tx, ty).Graphic(3).grhindex & " - Capa4: " & MapData(tx, ty).Graphic(4).grhindex
        If frmMain.mnuAutoCapturarSuperficie.Checked = True And frmMain.cSeleccionarSuperficie.value = False Then
            If MapData(tx, ty).Graphic(4).grhindex <> 0 Then
                frmMain.cCapas.Text = 4
                frmMain.cGrh.Text = MapData(tx, ty).Graphic(4).grhindex
            ElseIf MapData(tx, ty).Graphic(3).grhindex <> 0 Then
                frmMain.cCapas.Text = 3
                frmMain.cGrh.Text = MapData(tx, ty).Graphic(3).grhindex
            ElseIf MapData(tx, ty).Graphic(2).grhindex <> 0 Then
                frmMain.cCapas.Text = 2
                frmMain.cGrh.Text = MapData(tx, ty).Graphic(2).grhindex
            ElseIf MapData(tx, ty).Graphic(1).grhindex <> 0 Then
                frmMain.cCapas.Text = 1
                frmMain.cGrh.Text = MapData(tx, ty).Graphic(1).grhindex
            End If
        End If
        
        ' Limpieza
        If Len(frmMain.StatTxt.Text) > 4000 Then
            frmMain.StatTxt.Text = Right(frmMain.StatTxt.Text, 3000)
        End If
        frmMain.StatTxt.SelStart = Len(frmMain.StatTxt.Text)
        
        Rem yo - down
        'Call RepetirEnForm(tx, ty)
        Rem up
        
        oldtX = tx
        oldtY = ty
        
        
        
        Exit Sub
    End If
    
    
    'Left click
    If Button = vbLeftButton Then
            
            'Erase 2-3
            If frmMain.cQuitarEnTodasLasCapas.value = True Then
                modEdicion.Deshacer_Add "Quitar Todas las Capas (2/3)" ' Hago deshacer
                MapInfo.Changed = 1 'Set changed flag
                For LoopC = 2 To 3
                    MapData(tx, ty).Graphic(LoopC).grhindex = 0
                Next LoopC
                
                Exit Sub
            End If
    
            'Borrar "esta" Capa
            If frmMain.cQuitarEnEstaCapa.value = True Then
                If Val(frmMain.cCapas.Text) = 1 Then
                    If MapData(tx, ty).Graphic(1).grhindex <> 1 Then
                        modEdicion.Deshacer_Add "Quitar Capa 1" ' Hago deshacer
                        MapInfo.Changed = 1 'Set changed flag
                        MapData(tx, ty).Graphic(1).grhindex = 1
                        Exit Sub
                    End If
                ElseIf MapData(tx, ty).Graphic(Val(frmMain.cCapas.Text)).grhindex <> 0 Then
                    modEdicion.Deshacer_Add "Quitar Capa " & frmMain.cCapas.Text  ' Hago deshacer
                    MapInfo.Changed = 1 'Set changed flag
                    MapData(tx, ty).Graphic(Val(frmMain.cCapas.Text)).grhindex = 0
                    Exit Sub
                End If
            End If
    
        '************** Place grh
        If frmMain.cSeleccionarSuperficie.value = True Then
            
            If frmConfigSup.MOSAICO.value = vbChecked Then
              Dim aux As Integer
              Dim dy As Integer
              Dim dX As Integer
              If frmConfigSup.DespMosaic.value = vbChecked Then
                            dy = Val(frmConfigSup.DMLargo)
                            dX = Val(frmConfigSup.DMAncho.Text)
              Else
                        dy = 0
                        dX = 0
              End If
                    
              If frmMain.mnuAutoCompletarSuperficies.Checked = False Then
                    modEdicion.Deshacer_Add "Insertar Superficie' Hago deshacer"
                    MapInfo.Changed = 1 'Set changed flag
                    aux = Val(frmMain.cGrh.Text) + _
                    (((ty + dy) Mod frmConfigSup.mLargo.Text) * frmConfigSup.mAncho.Text) + ((tx + dX) Mod frmConfigSup.mAncho.Text)
                     If MapData(tx, ty).Graphic(Val(frmMain.cCapas.Text)).grhindex <> aux Or MapData(tx, ty).Blocked <> frmMain.SelectPanel(2).value Then
                        MapData(tx, ty).Graphic(Val(frmMain.cCapas.Text)).grhindex = aux
                        InitGrh MapData(tx, ty).Graphic(Val(frmMain.cCapas.Text)), aux
                    End If
              Else
                modEdicion.Deshacer_Add "Insertar Auto-Completar Superficie' Hago deshacer"
                MapInfo.Changed = 1 'Set changed flag
                Dim tXX As Integer, tYY As Integer, i As Integer, j As Integer, desptile As Integer
                tXX = tx
                tYY = ty
                desptile = 0
                For i = 1 To frmConfigSup.mLargo.Text
                    For j = 1 To frmConfigSup.mAncho.Text
                        aux = Val(frmMain.cGrh.Text) + desptile
                        MapData(tXX, tYY).Graphic(Val(frmMain.cCapas.Text)).grhindex = aux
                        InitGrh MapData(tXX, tYY).Graphic(Val(frmMain.cCapas.Text)), aux
                        tXX = tXX + 1
                        desptile = desptile + 1
                    Next
                    tXX = tx
                    tYY = tYY + 1
                Next
                tYY = ty
                    
                    
              End If
              
            Else
                'Else Place graphic
                If MapData(tx, ty).Blocked <> frmMain.SelectPanel(2).value Or MapData(tx, ty).Graphic(Val(frmMain.cCapas.Text)).grhindex <> Val(frmMain.cGrh.Text) Then
                    modEdicion.Deshacer_Add "Quitar Superficie en Capa " & frmMain.cCapas.Text ' Hago deshacer
                    MapInfo.Changed = 1 'Set changed flag
                    MapData(tx, ty).Graphic(Val(frmMain.cCapas.Text)).grhindex = Val(frmMain.cGrh.Text)
                    'Setup GRH
                    InitGrh MapData(tx, ty).Graphic(Val(frmMain.cCapas.Text)), Val(frmMain.cGrh.Text)
                End If
            End If
            
        End If
        '************** Place blocked tile
        If frmMain.cInsertarBloqueo.value = True Then
            If MapData(tx, ty).Blocked <> 1 Then
                modEdicion.Deshacer_Add "Insertar Bloqueo" ' Hago deshacer
                MapInfo.Changed = 1 'Set changed flag
                MapData(tx, ty).Blocked = 1
            End If
        ElseIf frmMain.cQuitarBloqueo.value = True Then
            If MapData(tx, ty).Blocked <> 0 Then
                modEdicion.Deshacer_Add "Quitar Bloqueo" ' Hago deshacer
                MapInfo.Changed = 1 'Set changed flag
                MapData(tx, ty).Blocked = 0
            End If
        End If
    
        '************** Place exit
        If frmMain.cInsertarTrans.value = True Then
            If Cfg_TrOBJ > 0 And Cfg_TrOBJ <= NumOBJs And frmMain.cInsertarTransOBJ.value = True Then
                If ObjData(Cfg_TrOBJ).ObjType = 19 Then
                    modEdicion.Deshacer_Add "Insertar Objeto de Translado" ' Hago deshacer
                    MapInfo.Changed = 1 'Set changed flag
                    InitGrh MapData(tx, ty).ObjGrh, ObjData(Cfg_TrOBJ).grhindex
                    MapData(tx, ty).OBJInfo.OBJIndex = Cfg_TrOBJ
                    MapData(tx, ty).OBJInfo.Amount = 1
                End If
            End If
            If Val(frmMain.tTMapa.Text) < 0 Or Val(frmMain.tTMapa.Text) > 9000 Then
                MsgBox "Valor de Mapa invalido", vbCritical + vbOKOnly
                Exit Sub
            ElseIf Val(frmMain.tTX.Text) < 0 Or Val(frmMain.tTX.Text) > 100 Then
                MsgBox "Valor de X invalido", vbCritical + vbOKOnly
                Exit Sub
            ElseIf Val(frmMain.tTY.Text) < 0 Or Val(frmMain.tTY.Text) > 100 Then
                MsgBox "Valor de Y invalido", vbCritical + vbOKOnly
                Exit Sub
            End If
                If frmMain.cUnionManual.value = True Then
                    modEdicion.Deshacer_Add "Insertar Translado de Union Manual' Hago deshacer"
                    MapInfo.Changed = 1 'Set changed flag
                    MapData(tx, ty).TileExit.Map = Val(frmMain.tTMapa.Text)
                    If tx >= 90 Then ' 21 ' derecha
                              MapData(tx, ty).TileExit.X = 12
                              MapData(tx, ty).TileExit.Y = ty
                    ElseIf tx <= 11 Then ' 9 ' izquierda
                        MapData(tx, ty).TileExit.X = 91
                        MapData(tx, ty).TileExit.Y = ty
                    End If
                    If ty >= 91 Then ' 94 '''' hacia abajo
                             MapData(tx, ty).TileExit.Y = 11
                             MapData(tx, ty).TileExit.X = tx
                    ElseIf ty <= 10 Then ''' hacia arriba
                        MapData(tx, ty).TileExit.Y = 90
                        MapData(tx, ty).TileExit.X = tx
                    End If
                Else
                    modEdicion.Deshacer_Add "Insertar Translado" ' Hago deshacer
                    MapInfo.Changed = 1 'Set changed flag
                    MapData(tx, ty).TileExit.Map = Val(frmMain.tTMapa.Text)
                    MapData(tx, ty).TileExit.X = Val(frmMain.tTX.Text)
                    MapData(tx, ty).TileExit.Y = Val(frmMain.tTY.Text)
                End If
        ElseIf frmMain.cQuitarTrans.value = True Then
                modEdicion.Deshacer_Add "Quitar Translado" ' Hago deshacer
                MapInfo.Changed = 1 'Set changed flag
                MapData(tx, ty).TileExit.Map = 0
                MapData(tx, ty).TileExit.X = 0
                MapData(tx, ty).TileExit.Y = 0
        End If
    
        '************** Place NPC
        If frmMain.cInsertarFunc(0).value = True Then
            If frmMain.cNumFunc(0).Text > 0 Then
                NpcIndex = frmMain.cNumFunc(0).Text
                If NpcIndex <> MapData(tx, ty).NpcIndex Then
                    modEdicion.Deshacer_Add "Insertar NPC" ' Hago deshacer
                    MapInfo.Changed = 1 'Set changed flag
                    Body = NpcData(NpcIndex).Body
                    Head = NpcData(NpcIndex).Head
                    Heading = NpcData(NpcIndex).Heading
                    Call MakeChar(NextOpenChar(), Body, Head, Heading, tx, ty)
                    MapData(tx, ty).NpcIndex = NpcIndex
                End If
            End If
        ElseIf frmMain.cInsertarFunc(1).value = True Then
            If frmMain.cNumFunc(1).Text > 0 Then
                NpcIndex = frmMain.cNumFunc(1).Text
                If NpcIndex <> (MapData(tx, ty).NpcIndex) Then
                    modEdicion.Deshacer_Add "Insertar NPC Hostil' Hago deshacer"
                    MapInfo.Changed = 1 'Set changed flag
                    Body = NpcData(NpcIndex).Body
                    Head = NpcData(NpcIndex).Head
                    Heading = NpcData(NpcIndex).Heading
                    Call MakeChar(NextOpenChar(), Body, Head, Heading, tx, ty)
                    MapData(tx, ty).NpcIndex = NpcIndex
                End If
            End If
        ElseIf frmMain.cQuitarFunc(0).value = True Or frmMain.cQuitarFunc(1).value = True Then
            If MapData(tx, ty).NpcIndex > 0 Then
                modEdicion.Deshacer_Add "Quitar NPC" ' Hago deshacer
                MapInfo.Changed = 1 'Set changed flag
                MapData(tx, ty).NpcIndex = 0
                Call EraseChar(MapData(tx, ty).CharIndex)
            End If
        End If
    
        ' ***************** Control de Funcion de Objetos *****************
        If frmMain.cInsertarFunc(2).value = True Then ' Insertar Objeto
            If frmMain.cNumFunc(2).Text > 0 Then
                OBJIndex = frmMain.cNumFunc(2).Text
                If MapData(tx, ty).OBJInfo.OBJIndex <> OBJIndex Or MapData(tx, ty).OBJInfo.Amount <> Val(frmMain.cCantFunc(2).Text) Then
                    modEdicion.Deshacer_Add "Insertar Objeto" ' Hago deshacer
                    MapInfo.Changed = 1 'Set changed flag
                    InitGrh MapData(tx, ty).ObjGrh, ObjData(OBJIndex).grhindex
                    MapData(tx, ty).OBJInfo.OBJIndex = OBJIndex
                    MapData(tx, ty).OBJInfo.Amount = Val(frmMain.cCantFunc(2).Text)
                    Select Case ObjData(OBJIndex).ObjType
                        Case 4, 8, 10, 22 ' Arboles, Carteles, Foros, Yacimientos
                            MapData(tx, ty).Graphic(3) = MapData(tx, ty).ObjGrh
                    End Select
                End If
            End If
        ElseIf frmMain.cQuitarFunc(2).value = True Then ' Quitar Objeto
            If MapData(tx, ty).OBJInfo.OBJIndex <> 0 Or MapData(tx, ty).OBJInfo.Amount <> 0 Then
                modEdicion.Deshacer_Add "Quitar Objeto" ' Hago deshacer
                MapInfo.Changed = 1 'Set changed flag
                If MapData(tx, ty).Graphic(3).grhindex = MapData(tx, ty).ObjGrh.grhindex Then MapData(tx, ty).Graphic(3).grhindex = 0
                MapData(tx, ty).ObjGrh.grhindex = 0
                MapData(tx, ty).OBJInfo.OBJIndex = 0
                MapData(tx, ty).OBJInfo.Amount = 0
            End If
        End If
        
        ' ***************** Control de Funcion de Triggers *****************
        If frmMain.cInsertarTrigger.value = True Then ' Insertar Trigger
            If MapData(tx, ty).Trigger <> frmMain.lListado(4).ListIndex + 1 Then
                modEdicion.Deshacer_Add "Insertar Trigger" ' Hago deshacer
                MapInfo.Changed = 1 'Set changed flag
                MapData(tx, ty).Trigger = frmMain.lListado(4).ListIndex + 1
            End If
        ElseIf frmMain.cQuitarTrigger.value = True Then ' Quitar Trigger
            If MapData(tx, ty).Trigger <> 0 Then
                modEdicion.Deshacer_Add "Quitar Trigger" ' Hago deshacer
                MapInfo.Changed = 1 'Set changed flag
                MapData(tx, ty).Trigger = 0
            End If
        End If
        
         ' ***************** Control de Funcion de Particles! *****************
        If frmMain.cInsertarParticula Then
            'If Val(frmMain.txtParticula) = 0 Then Exit Sub
            MapData(tx, ty).particle_group_index = General_Particle_Create(Val(frmMain.LstParticulas.ListIndex + 1), tx, ty, -1)
            MapData(tx, ty).parti_index = Val(frmMain.LstParticulas.ListIndex + 1)
        ElseIf frmMain.cQuitarParticula Then
            If MapData(tx, ty).particle_group_index Then
                Call engine.Particle_Group_Remove(MapData(tx, ty).particle_group_index)
                MapData(tx, ty).particle_group_index = 0
                MapData(tx, ty).parti_index = 0
            End If

        End If
        
        If frmMain.cInsertarLuz.value Then
            If Val(frmMain.cRango = 0) Then Exit Sub
            Light.LightSet tx, ty, False, frmMain.cRango, Val(frmMain.R), Val(frmMain.G), Val(frmMain.B)
        ElseIf frmMain.cQuitarLuz.value Then
            Light.LightDestroy tx, ty
        End If
    End If

End Sub
