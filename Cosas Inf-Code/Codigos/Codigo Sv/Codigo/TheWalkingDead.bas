Attribute VB_Name = "TheWalkingDead"
Public Const torrezombieZ As Integer = 692


Sub torrezombie()
 Dim ii As WorldPos
   
   ii.Map = 22
    ii.X = 25
    ii.Y = 48

    Call SpawnNpc(torrezombieZ, ii, True, True)

End Sub

Sub gananEventozombie()

Dim LoopC As Integer
    For LoopC = 1 To LastUser
    
                       
If UserList(LoopC).POS.Map = 22 Or UserList(LoopC).POS.Map = 31 Then
If UserList(LoopC).flags.Zombie = 1 Then
  UserList(LoopC).Char.Head = UserList(LoopC).OrigChar.Head
 Call WarpUserChar(LoopC, 31, 39, 24, True)
ElseIf UserList(LoopC).flags.Humanoz = 1 Then
 Call WarpUserChar(LoopC, 31, 59, 24, True)
End If
End If
            
            
    
     If UserList(LoopC).POS.Map = 22 Or UserList(LoopC).POS.Map = 31 Then
      If UserList(LoopC).flags.Humanoz = 1 Then
       
        UserList(LoopC).flags.Canje = UserList(LoopC).flags.Canje + 4
         
           
                     
End If
End If
    Next
      Call poneBloq2
    MinutosEz = 0
    Call SendData(ToAll, 0, 0, "||EventoZombies> Ganan humanos reciben 4 canjeos C/U." & FONTTYPE_FIGHTT)
   frmMain.TimerZombiesEmpieza.Enabled = False
End Sub
Sub cancelaeventozombie()

Dim LoopC As Integer
    For LoopC = 1 To LastUser
       If UserList(LoopC).POS.Map = 22 Or UserList(LoopC).POS.Map = 31 Then
          UserList(LoopC).Char.Head = UserList(LoopC).OrigChar.Head
        
         
                    If UserList(LoopC).POS.Map = 22 Or UserList(LoopC).POS.Map = 31 Then
If UserList(LoopC).flags.Zombie = 1 Then
 Call WarpUserChar(LoopC, 31, 39, 24, True)
ElseIf UserList(LoopC).flags.Humanoz = 1 Then
 Call WarpUserChar(LoopC, 31, 59, 24, True)
End If
End If
            End If
    Next
    

            Call poneBloq2
     Call SendData(ToAll, 0, 0, "||EventoZombies> Cancelado." & FONTTYPE_FIGHTT)
    MinutosEz = 0
frmMain.TimerZombiesEmpieza.Enabled = False
End Sub
Sub terminaEventozombie()
Dim LoopC As Integer
    For LoopC = 1 To LastUser
    
                   If UserList(LoopC).POS.Map = 22 Or UserList(LoopC).POS.Map = 31 Then
If UserList(LoopC).flags.Zombie = 1 Then
 Call WarpUserChar(LoopC, 31, 39, 24, True)
ElseIf UserList(LoopC).flags.Humanoz = 1 Then
 Call WarpUserChar(LoopC, 31, 59, 24, True)
End If
End If
    
         If UserList(LoopC).POS.Map = 22 Or UserList(LoopC).POS.Map = 31 Then
      If UserList(LoopC).flags.Zombie = 1 Then

        UserList(LoopC).flags.Canje = UserList(LoopC).flags.Canje + 4
        
              UserList(LoopC).Char.Head = UserList(LoopC).OrigChar.Head
           
              
        End If
        End If
    Next
     Call poneBloq2
         Call SendData(ToAll, 0, 0, "||EventoZombies> Ganan zombies reciben 4 canjeos C/U." & FONTTYPE_FIGHTT)
 MinutosEz = 0
frmMain.TimerZombiesEmpieza.Enabled = False
End Sub
Sub comienzaeventozombie()
Call sacabloq
Call torrezombie
frmMain.TimerZombiesEmpieza.Enabled = True
 Call SendData(ToAll, 0, 0, "||EventoZombies> Comienza!" & FONTTYPE_FIGHTT)
 Dim LoopC As Integer
    For LoopC = 1 To LastUser
        If UserList(LoopC).POS.Map = 22 Or UserList(LoopC).POS.Map = 31 Then
        If UserList(LoopC).flags.Zombie = 1 Then
            Call WarpUserChar(LoopC, 22, 30, 48, True)
            End If
            End If
    Next
    cantidadZ = 0
    RealZombie = 0
    Caoszombie = 0
End Sub
Sub entra_eventozombie(ByVal UserIndex As Integer)

   If UserList(UserIndex).POS.Map = 6 Or UserList(UserIndex).POS.Map = 23 Then
            Call SendData(ToIndex, UserIndex, 0, "||Eres newbie no puedes entrar al evento." & FONTTYPE_INFO)
            Exit Sub
        End If

  If RealZombie = cantidadZ Then Exit Sub

      If MapInfo(UserList(UserIndex).POS.Map).Pk = True Then
    Call SendData(ToIndex, UserIndex, 0, "||Debes estar en una ciudad" & FONTTYPE_TALK)
    Exit Sub
    End If
    
         If UserList(UserIndex).POS.Map = 22 Then
            Call SendData(ToIndex, UserIndex, 0, "||Estas dentro." & FONTTYPE_INFO)
            Exit Sub
        End If
     
        If UserList(UserIndex).POS.Map = 31 Then
            Call SendData(ToIndex, UserIndex, 0, "||Estas dentro." & FONTTYPE_INFO)
            Exit Sub
        End If
    
     If UserList(UserIndex).POS.Map = 21 Then
            Call SendData(ToIndex, UserIndex, 0, "||No puedes ir estando en la carcel" & FONTTYPE_INFO)
            Exit Sub
        End If
             RealZombie = RealZombie + 1
        UserList(UserIndex).Char.Head = 501
        
         UserList(UserIndex).flags.Zombie = 1
 Call WarpUserChar(UserIndex, 31, 39, 25, True)
End Sub
Sub entra_eventozombieh(ByVal UserIndex As Integer)

   If UserList(UserIndex).POS.Map = 6 Or UserList(UserIndex).POS.Map = 23 Then
            Call SendData(ToIndex, UserIndex, 0, "||Eres newbie no puedes entrar al evento." & FONTTYPE_INFO)
            Exit Sub
        End If

  If Caoszombie = cantidadZ Then Exit Sub
             
      If MapInfo(UserList(UserIndex).POS.Map).Pk = True Then
    Call SendData(ToIndex, UserIndex, 0, "||Debes estar en una ciudad" & FONTTYPE_TALK)
    Exit Sub
    End If
        If UserList(UserIndex).POS.Map = 22 Then
            Call SendData(ToIndex, UserIndex, 0, "||Estas dentro" & FONTTYPE_INFO)
            Exit Sub
        End If
        
           If UserList(UserIndex).POS.Map = 31 Then
            Call SendData(ToIndex, UserIndex, 0, "||Estas dentro" & FONTTYPE_INFO)
            Exit Sub
        End If
    
     If UserList(UserIndex).POS.Map = 21 Then
            Call SendData(ToIndex, UserIndex, 0, "||No puedes ir estando en la carcel" & FONTTYPE_INFO)
            Exit Sub
        End If
        Caoszombie = Caoszombie + 1
           UserList(UserIndex).flags.Humanoz = 1
 Call WarpUserChar(UserIndex, 22, 60, 47, True)
End Sub

Sub poneBloq()
 Call SendData(ToAdmins, 0, 0, "||EventoZombies> Bloqueos activados." & FONTTYPE_TALK)
    MapData(22, 53, 44).Blocked = 1
    MapData(22, 53, 45).Blocked = 1
    MapData(22, 53, 46).Blocked = 1
    MapData(22, 53, 47).Blocked = 1
    MapData(22, 53, 48).Blocked = 1
    MapData(22, 53, 49).Blocked = 1
    MapData(22, 53, 50).Blocked = 1
    
        MapData(31, 36, 31).Blocked = 1
        MapData(31, 35, 31).Blocked = 1
        MapData(31, 34, 31).Blocked = 1
        MapData(31, 33, 31).Blocked = 1
        MapData(31, 32, 31).Blocked = 1
        MapData(31, 31, 31).Blocked = 1
        MapData(31, 30, 31).Blocked = 1
        MapData(31, 29, 31).Blocked = 1
        MapData(31, 28, 31).Blocked = 1
        
        MapData(31, 61, 31).Blocked = 1
        MapData(31, 62, 31).Blocked = 1
        MapData(31, 63, 31).Blocked = 1
        MapData(31, 64, 31).Blocked = 1
        MapData(31, 65, 31).Blocked = 1
        MapData(31, 66, 31).Blocked = 1
        MapData(31, 67, 31).Blocked = 1
        MapData(31, 68, 31).Blocked = 1
        MapData(31, 69, 31).Blocked = 1
        
          MapData(31, 43, 21).Blocked = 1
           MapData(31, 54, 21).Blocked = 1
End Sub

  

Sub poneBloq2()
 Call SendData(ToAdmins, 0, 0, "||EventoZombies> Bloqueos activados." & FONTTYPE_TALK)
    
        MapData(31, 36, 31).Blocked = 1
        MapData(31, 35, 31).Blocked = 1
        MapData(31, 34, 31).Blocked = 1
        MapData(31, 33, 31).Blocked = 1
        MapData(31, 32, 31).Blocked = 1
        MapData(31, 31, 31).Blocked = 1
        MapData(31, 30, 31).Blocked = 1
        MapData(31, 29, 31).Blocked = 1
        MapData(31, 28, 31).Blocked = 1
        
        MapData(31, 61, 31).Blocked = 1
        MapData(31, 62, 31).Blocked = 1
        MapData(31, 63, 31).Blocked = 1
        MapData(31, 64, 31).Blocked = 1
        MapData(31, 65, 31).Blocked = 1
        MapData(31, 66, 31).Blocked = 1
        MapData(31, 67, 31).Blocked = 1
        MapData(31, 68, 31).Blocked = 1
        MapData(31, 69, 31).Blocked = 1
        
         MapData(31, 43, 21).Blocked = 0
         MapData(31, 54, 21).Blocked = 0
End Sub

Sub sacabloq()
 Call SendData(ToAdmins, 0, 0, "||EventoZombies> Bloqueos desactivados." & FONTTYPE_TALK)
    MapData(22, 53, 44).Blocked = 0
    MapData(22, 53, 45).Blocked = 0
    MapData(22, 53, 46).Blocked = 0
    MapData(22, 53, 47).Blocked = 0
    MapData(22, 53, 48).Blocked = 0
    MapData(22, 53, 49).Blocked = 0
    MapData(22, 53, 50).Blocked = 0
    MapData(31, 61, 31).Blocked = 0
    MapData(31, 62, 31).Blocked = 0
    MapData(31, 63, 31).Blocked = 0
    MapData(31, 64, 31).Blocked = 0
    MapData(31, 65, 31).Blocked = 0
    MapData(31, 66, 31).Blocked = 0
    MapData(31, 67, 31).Blocked = 0
    MapData(31, 68, 31).Blocked = 0
    MapData(31, 69, 31).Blocked = 0
    MapData(31, 36, 31).Blocked = 0
    MapData(31, 35, 31).Blocked = 0
    MapData(31, 34, 31).Blocked = 0
    MapData(31, 33, 31).Blocked = 0
    MapData(31, 32, 31).Blocked = 0
    MapData(31, 31, 31).Blocked = 0
    MapData(31, 30, 31).Blocked = 0
    MapData(31, 29, 31).Blocked = 0
    MapData(31, 28, 31).Blocked = 0
End Sub


