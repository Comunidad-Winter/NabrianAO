Attribute VB_Name = "ModFacciones"
 
'director del proyecto: #Esteban(Neliam)

'servidor basado en fénixao 1.0
'medios de contacto:
'Skype: dc.esteban
'E-mail: nabrianao@gmail.com
Option Explicit
Public Sub Recompensado(Userindex As Integer)
Dim Fuerzas As Byte
Dim MiObj As Obj
 
Fuerzas = UserList(Userindex).Faccion.Bando
 
 
If UserList(Userindex).Faccion.Jerarquia = 0 Then
    Call SendData(ToIndex, Userindex, 0, Mensajes(Fuerzas, 11))
    Exit Sub
End If
 
 If UserList(Userindex).Faccion.Jerarquia = 1 Then
            If UserList(Userindex).Faccion.Matados(Enemigo(Fuerzas)) < 100 Then
                Call SendData(ToIndex, Userindex, 0, Mensajes(Fuerzas, 12) & 100)
                Exit Sub
            End If
        
        UserList(Userindex).Stats.Reputacion = UserList(Userindex).Stats.Reputacion + 250
        UserList(Userindex).Faccion.Jerarquia = 2
        Call SendData(ToIndex, Userindex, 0, Mensajes(Fuerzas, 15) & Titulo(Userindex))
        
        '############
            ElseIf UserList(Userindex).Faccion.Jerarquia = 2 Then
                    If UserList(Userindex).Faccion.Matados(Enemigo(Fuerzas)) < 200 Then
                        Call SendData(ToIndex, Userindex, 0, Mensajes(Fuerzas, 12) & 200)
                        Exit Sub
                    End If
                    
                           If UserList(Userindex).Faccion.torneos < 1 Then
                                     Call SendData(ToIndex, Userindex, 0, Mensajes(Fuerzas, 13) & 1)
                                     Exit Sub
                                     End If
                                     
                        If Not TieneObjetos(910, 10, Userindex) Then
                                    Call SendData(ToIndex, Userindex, 0, "||No tienes los requisitos necesarios. Necesario: 10 Libros de Jerarquia." & FONTTYPE_INFO)
                                    Exit Sub
                                    End If
                                     
                            If UserList(Userindex).flags.Mision < 6 Then
                                     Call SendData(ToIndex, Userindex, 0, "||Debes haber realizado al menos hasta la misión 6 de templario." & FONTTYPE_TALK)
                                     Exit Sub
                                     End If
                Call QuitarObjetos(910, 10, Userindex)
                UserList(Userindex).Stats.Reputacion = UserList(Userindex).Stats.Reputacion + 250
                UserList(Userindex).Faccion.Jerarquia = 3
                Call SendData(ToIndex, Userindex, 0, Mensajes(Fuerzas, 15) & Titulo(Userindex))
                
                '#########
                    ElseIf UserList(Userindex).Faccion.Jerarquia = 3 Then
                            If UserList(Userindex).Faccion.Matados(Enemigo(Fuerzas)) < 450 Then
                                Call SendData(ToIndex, Userindex, 0, Mensajes(Fuerzas, 12) & 450)
                                   Exit Sub
                            End If
                            
                                   If UserList(Userindex).Faccion.torneos < 5 Then
                                     Call SendData(ToIndex, Userindex, 0, Mensajes(Fuerzas, 13) & 5)
                                     Exit Sub
                                     End If
                                     
                                    If UserList(Userindex).Faccion.Quests < 3 Then
                                     Call SendData(ToIndex, Userindex, 0, "||Necesitas tener 3 quests Ganadas." & FONTTYPE_ProtectorCiu)
                                     Exit Sub
                                     End If
                                     
                                    If Not TieneObjetos(910, 15, Userindex) Then
                                    Call SendData(ToIndex, Userindex, 0, "||No tienes los requisitos necesarios. Necesario: 15 Libros de Jerarquia." & FONTTYPE_INFO)
                                   Exit Sub
                                    End If
                                    
                                    If UserList(Userindex).flags.Mision < 8 Then
                                     Call SendData(ToIndex, Userindex, 0, "||Debes haber realizado al menos hasta la misión 8 de templario." & FONTTYPE_TALK)
                                     Exit Sub
                                     End If
                            

 
   Call QuitarObjetos(910, 15, Userindex)
   UserList(Userindex).Stats.Reputacion = UserList(Userindex).Stats.Reputacion + 250
   UserList(Userindex).Faccion.Jerarquia = 4
   Call SendData(ToIndex, Userindex, 0, Mensajes(Fuerzas, 15) & Titulo(Userindex))
   
             '#########
   If UserList(Userindex).Faccion.Bando = Caos Then
    Dim SuperOroX As Obj
    If UserList(Userindex).Raza = 1 Or UserList(Userindex).Raza = 3 Or UserList(Userindex).Raza = 4 Then
    SuperOroX.Amount = 1 'cantidad de items
    SuperOroX.OBJIndex = 131 'numero de item 872
    Else
    SuperOroX.Amount = 1 'cantidad de items
    SuperOroX.OBJIndex = 871 'numero de item 872
    End If
    If Not MeterItemEnInventario(Userindex, SuperOroX) Then Call TirarItemAlPiso(UserList(Userindex).POS, SuperOroX)
   ElseIf UserList(Userindex).Faccion.Bando = Real Then
    If UserList(Userindex).Raza = 1 Or UserList(Userindex).Raza = 3 Or UserList(Userindex).Raza = 4 Then
    SuperOroX.Amount = 1 'cantidad de items
    SuperOroX.OBJIndex = 132 'numero de item 872
    Else
    SuperOroX.Amount = 1 'cantidad de items
    SuperOroX.OBJIndex = 872 'numero de item 872
    End If
    If Not MeterItemEnInventario(Userindex, SuperOroX) Then Call TirarItemAlPiso(UserList(Userindex).POS, SuperOroX)
   End If

End If
   
If UserList(Userindex).Faccion.Jerarquia < 4 Then
    MiObj.Amount = 1
    MiObj.OBJIndex = Armaduras(Fuerzas, UserList(Userindex).Faccion.Jerarquia, TipoClase(Userindex), TipoRaza(Userindex))
    If Not MeterItemEnInventario(Userindex, MiObj) Then Call TirarItemAlPiso(UserList(Userindex).POS, MiObj)
Else
    Call SendData(ToIndex, Userindex, 0, Mensajes(Fuerzas, 22) & str(Npclist(UserList(Userindex).flags.TargetNpc).Char.CharIndex))
End If
 
 
End Sub
Public Sub Expulsar(Userindex As Integer)

Call SendData(ToIndex, Userindex, 0, Mensajes(UserList(Userindex).Faccion.Bando, 8))
UserList(Userindex).Faccion.Bando = Neutral
Call UpdateUserChar(Userindex)

End Sub
Public Sub Enlistar(Userindex As Integer, ByVal Fuerzas As Byte)
Dim MiObj As Obj
 
If UserList(Userindex).Faccion.Bando = Neutral Then
    Call SendData(ToIndex, Userindex, 0, Mensajes(Fuerzas, 1) & str(Npclist(UserList(Userindex).flags.TargetNpc).Char.CharIndex))
    Exit Sub
End If
 
If UserList(Userindex).Faccion.Bando = Enemigo(Fuerzas) Then
    Call SendData(ToIndex, Userindex, 0, Mensajes(Fuerzas, 2) & str(Npclist(UserList(Userindex).flags.TargetNpc).Char.CharIndex))
    Exit Sub
End If
 
Dim oGuild As cGuild
 
Set oGuild = FetchGuild(UserList(Userindex).GuildInfo.GuildName)
 
If Len(UserList(Userindex).GuildInfo.GuildName) > 0 Then
    If oGuild.Bando <> Fuerzas Then
        Call SendData(ToIndex, Userindex, 0, Mensajes(Fuerzas, 3) & str(Npclist(UserList(Userindex).flags.TargetNpc).Char.CharIndex))
        Exit Sub
    End If
End If
 
If UserList(Userindex).Faccion.Jerarquia Then
    Call SendData(ToIndex, Userindex, 0, Mensajes(Fuerzas, 4) & str(Npclist(UserList(Userindex).flags.TargetNpc).Char.CharIndex))
    Exit Sub
End If
 
If UserList(Userindex).Faccion.Matados(Enemigo(Fuerzas)) < 50 Then
    Call SendData(ToIndex, Userindex, 0, Mensajes(Fuerzas, 5) & UserList(Userindex).Faccion.Matados(Enemigo(Fuerzas)) & "!°" & str(Npclist(UserList(Userindex).flags.TargetNpc).Char.CharIndex))
    Exit Sub
End If
 
If UserList(Userindex).Stats.ELV < 25 Then
    Call SendData(ToIndex, Userindex, 0, Mensajes(Fuerzas, 6) & str(Npclist(UserList(Userindex).flags.TargetNpc).Char.CharIndex))
    Exit Sub
End If
 
Call SendData(ToIndex, Userindex, 0, Mensajes(Fuerzas, 7) & str(Npclist(UserList(Userindex).flags.TargetNpc).Char.CharIndex))
 
UserList(Userindex).Faccion.Jerarquia = 1
 
MiObj.Amount = 1
MiObj.OBJIndex = Armaduras(Fuerzas, UserList(Userindex).Faccion.Jerarquia, TipoClase(Userindex), TipoRaza(Userindex))
If Not MeterItemEnInventario(Userindex, MiObj) Then Call TirarItemAlPiso(UserList(Userindex).POS, MiObj)
Call LogBando(Fuerzas, UserList(Userindex).Name)
 
End Sub
Public Function Titulo(Userindex As Integer) As String

Select Case UserList(Userindex).Faccion.Bando
    Case Real
        Select Case UserList(Userindex).Faccion.Jerarquia
            Case 0
                Titulo = "Fiel al rey"
            Case 1
                Titulo = "Soldado real"
            Case 2
                Titulo = "Experto del bien"
            Case 3
                Titulo = "Protector de Newbies"
            Case 4
                Titulo = "Campeon de la luz"
            Case 5
                Titulo = "Dios de la Armada"
        End Select
    Case Caos
        Select Case UserList(Userindex).Faccion.Jerarquia
            Case 0
                Titulo = "Fiel a Lord Thek"
            Case 1
                Titulo = "Maligno sobreviviente"
            Case 2
                Titulo = "Experto del mal"
            Case 3
                Titulo = "Protector del Infierno"
            Case 4
                Titulo = "Maestro del Mal"
            Case 5
                Titulo = "Dios del Infierno"
        End Select
End Select


End Function
