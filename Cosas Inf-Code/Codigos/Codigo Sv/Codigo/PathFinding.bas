Attribute VB_Name = "PathFinding"
 
'director del proyecto: #Esteban(Neliam)

'servidor basado en fénixao 1.0
'medios de contacto:
'Skype: dc.esteban
'E-mail: nabrianao@gmail.com
Option Explicit

Private Const ROWS = 100
Private Const COLUMS = 100
Private Const MAXINT = 1000
Private Const Walkable = 0

Private Type tIntermidiateWork
    Known As Boolean
    DistV As Integer
    PrevV As tVertice
End Type

Dim TmpArray(1 To ROWS, 1 To COLUMS) As tIntermidiateWork

Dim TilePosX As Integer, TilePosY As Integer

Dim MyVert As tVertice
Dim MyFin As tVertice

Dim Iter As Integer

Private Function Limites(ByVal vfila As Integer, ByVal vcolu As Integer)
Limites = vcolu >= 1 And vcolu <= COLUMS And vfila >= 1 And vfila <= ROWS
End Function

Private Function IsWalkable(Map As Integer, ByVal row As Integer, ByVal Col As Integer, NpcIndex As Integer) As Boolean
IsWalkable = MapData(Map, row, Col).Blocked = 0 And MapData(Map, row, Col).NpcIndex = 0

If MapData(Map, row, Col).Userindex Then
     If MapData(Map, row, Col).Userindex <> Npclist(NpcIndex).PFINFO.TargetUser Then IsWalkable = False
End If

End Function

Private Sub ProcessAdjacents(MapIndex As Integer, T() As tIntermidiateWork, vfila As Integer, vcolu As Integer, NpcIndex As Integer)
    Dim V As tVertice
    Dim j As Integer
    
    j = vfila - 1
    If Limites(j, vcolu) Then
            If IsWalkable(MapIndex, j, vcolu, NpcIndex) Then
                    
                    If T(j, vcolu).DistV = MAXINT Then
                        
                        T(j, vcolu).DistV = T(vfila, vcolu).DistV + 1
                        T(j, vcolu).PrevV.X = vcolu
                        T(j, vcolu).PrevV.y = vfila
                        
                        V.X = vcolu
                        V.y = j
                        Call Push(V)
                    End If
            End If
    End If
    j = vfila + 1
    
    If Limites(j, vcolu) Then
            If IsWalkable(MapIndex, j, vcolu, NpcIndex) Then
                
                If T(j, vcolu).DistV = MAXINT Then
                    
                    T(j, vcolu).DistV = T(vfila, vcolu).DistV + 1
                    T(j, vcolu).PrevV.X = vcolu
                    T(j, vcolu).PrevV.y = vfila
                    
                    V.X = vcolu
                    V.y = j
                    Call Push(V)
                End If
            End If
    End If
    
    If Limites(vfila, vcolu - 1) Then
            If IsWalkable(MapIndex, vfila, vcolu - 1, NpcIndex) Then
                
                If T(vfila, vcolu - 1).DistV = MAXINT Then
                    
                    T(vfila, vcolu - 1).DistV = T(vfila, vcolu).DistV + 1
                    T(vfila, vcolu - 1).PrevV.X = vcolu
                    T(vfila, vcolu - 1).PrevV.y = vfila
                    
                    V.X = vcolu - 1
                    V.y = vfila
                    Call Push(V)
                End If
            End If
    End If
    
    If Limites(vfila, vcolu + 1) Then
            If IsWalkable(MapIndex, vfila, vcolu + 1, NpcIndex) Then
                
                If T(vfila, vcolu + 1).DistV = MAXINT Then
                    
                    T(vfila, vcolu + 1).DistV = T(vfila, vcolu).DistV + 1
                    T(vfila, vcolu + 1).PrevV.X = vcolu
                    T(vfila, vcolu + 1).PrevV.y = vfila
                    
                    V.X = vcolu + 1
                    V.y = vfila
                    Call Push(V)
                End If
            End If
    End If
   
   
End Sub


Public Sub SeekPath(NpcIndex As Integer, Optional ByVal MaxSteps As Integer = 30)







Dim cur_npc_pos As tVertice
Dim tar_npc_pos As tVertice
Dim V As tVertice
Dim NpcMap As Integer
Dim steps As Integer

NpcMap = Npclist(NpcIndex).POS.Map

steps = 0

cur_npc_pos.X = Npclist(NpcIndex).POS.y
cur_npc_pos.y = Npclist(NpcIndex).POS.X

tar_npc_pos.X = Npclist(NpcIndex).PFINFO.Target.X
tar_npc_pos.y = Npclist(NpcIndex).PFINFO.Target.y

Call InitializeTable(TmpArray, cur_npc_pos)
Call InitQueue


Call Push(cur_npc_pos)

Do While (Not IsEmpty)
    If steps > MaxSteps Then Exit Do
    V = Pop
    If V.X = tar_npc_pos.X And V.y = tar_npc_pos.y Then Exit Do
    Call ProcessAdjacents(NpcMap, TmpArray, V.y, V.X, NpcIndex)
Loop

Call MakePath(NpcIndex)

End Sub

Private Sub MakePath(NpcIndex As Integer)




Dim Pasos As Integer
Dim miV As tVertice
Dim i As Integer

Pasos = TmpArray(Npclist(NpcIndex).PFINFO.Target.y, Npclist(NpcIndex).PFINFO.Target.X).DistV
Npclist(NpcIndex).PFINFO.PathLenght = Pasos


If Pasos = MAXINT Then
    
    Npclist(NpcIndex).PFINFO.NoPath = True
    Npclist(NpcIndex).PFINFO.PathLenght = 0
    Exit Sub
End If

ReDim Npclist(NpcIndex).PFINFO.Path(0 To Pasos) As tVertice

miV.X = Npclist(NpcIndex).PFINFO.Target.X
miV.y = Npclist(NpcIndex).PFINFO.Target.y

For i = Pasos To 1 Step -1
    Npclist(NpcIndex).PFINFO.Path(i) = miV
    miV = TmpArray(miV.y, miV.X).PrevV
Next

Npclist(NpcIndex).PFINFO.CurPos = 1
Npclist(NpcIndex).PFINFO.NoPath = False
   
End Sub

Private Sub InitializeTable(T() As tIntermidiateWork, S As tVertice, Optional ByVal MaxSteps As Integer = 30)




Dim j As Integer, k As Integer
Const anymap = 1
For j = S.y - MaxSteps To S.y + MaxSteps
    For k = S.X - MaxSteps To S.X + MaxSteps
        If InMapBounds(j, k) Then
            T(j, k).Known = False
            T(j, k).DistV = MAXINT
            T(j, k).PrevV.X = 0
            T(j, k).PrevV.y = 0
        End If
    Next
Next

T(S.y, S.X).Known = False
T(S.y, S.X).DistV = 0

End Sub

