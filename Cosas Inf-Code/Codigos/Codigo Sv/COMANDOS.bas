Attribute VB_Name = "COMANDOS"

'If UCase$(Left$(Rdata, 8)) = "/DONARON" Then
'Rdata = Right$(Rdata, Len(Rdata) - 8)
'Dim lecturadonador As String
'Dim obj_FSO As Object
'Dim Archivo As Object
'   Set obj_FSO = CreateObject("Scripting.FileSystemObject")
'   Set Archivo = obj_FSO.OpenTextFile(App.Path & "\Donadores.log", 1)
'   lecturadonador = Archivo.ReadAll
'   Archivo.Close
'   Set obj_FSO = Nothing
'   Set Archivo = Nothing
'Call SendData(ToIndex, Userindex, 0, "||" & lecturadonador & "" & FONTTYPE_INFO)
'Exit Sub
'End If


Private SuperOro As Obj
Private SuperOroX As Obj

Sub UserMisionTemplario(Userindex As Integer)
     If UserList(Userindex).flags.Mision = 10 Then
     Call SendData(ToIndex, Userindex, 0, "||Ya eres templario." & FONTTYPE_WARNING)
     Exit Sub
     End If
     
     If TieneObjetos(855, 1, Userindex) Then
     Call QuitarObjetos(855, 1, Userindex)

            If UserList(Userindex).flags.Mision = 0 Then
             
             UserList(Userindex).flags.Mision = 1
             UserList(Userindex).Stats.Reputacion = UserList(Userindex).Stats.Reputacion + 100
             Call SendUserREP(Userindex)
             Call SendData(ToIndex, Userindex, 0, "||Has cumplido la misión te quedan 9 misiones restantes." & FONTTYPE_INFO)
             
             ElseIf UserList(Userindex).flags.Mision = 1 Then
             
             UserList(Userindex).flags.Mision = 2
             UserList(Userindex).Stats.Reputacion = UserList(Userindex).Stats.Reputacion + 200
             Call SendUserREP(Userindex)
             Call SendData(ToIndex, Userindex, 0, "||Has cumplido la misión te quedan 8 misiones restantes." & FONTTYPE_INFO)
             
             ElseIf UserList(Userindex).flags.Mision = 2 Then
             
             UserList(Userindex).flags.Mision = 3
             UserList(Userindex).Stats.Reputacion = UserList(Userindex).Stats.Reputacion + 300
             Call SendUserREP(Userindex)
             Call SendData(ToIndex, Userindex, 0, "||Has cumplido la misión te quedan 7 misiones restantes." & FONTTYPE_INFO)
             
             ElseIf UserList(Userindex).flags.Mision = 3 Then
             
             UserList(Userindex).flags.Mision = 4
             UserList(Userindex).Stats.Reputacion = UserList(Userindex).Stats.Reputacion + 400
             Call SendUserREP(Userindex)
             Call SendData(ToIndex, Userindex, 0, "||Has cumplido la misión te quedan 6 misiones restantes." & FONTTYPE_INFO)
             
             ElseIf UserList(Userindex).flags.Mision = 4 Then
             
             UserList(Userindex).flags.Mision = 5
             UserList(Userindex).Stats.Reputacion = UserList(Userindex).Stats.Reputacion + 500
             Call SendUserREP(Userindex)
             Call SendData(ToIndex, Userindex, 0, "||Has cumplido la misión te quedan 5 misiones restantes." & FONTTYPE_INFO)
             
             ElseIf UserList(Userindex).flags.Mision = 5 Then
             
             UserList(Userindex).flags.Mision = 6
             UserList(Userindex).Stats.Reputacion = UserList(Userindex).Stats.Reputacion + 600
             Call SendUserREP(Userindex)
             Call SendData(ToIndex, Userindex, 0, "||Has cumplido la misión te quedan 4 misiones restantes." & FONTTYPE_INFO)
             
             ElseIf UserList(Userindex).flags.Mision = 6 Then
 
             UserList(Userindex).flags.Mision = 7
             UserList(Userindex).Stats.Reputacion = UserList(Userindex).Stats.Reputacion + 700
             Call SendUserREP(Userindex)
             Call SendData(ToIndex, Userindex, 0, "||Has cumplido la misión te quedan 3 misiones restantes." & FONTTYPE_INFO)
             
             ElseIf UserList(Userindex).flags.Mision = 7 Then
             
             UserList(Userindex).flags.Mision = 8
             UserList(Userindex).Stats.Reputacion = UserList(Userindex).Stats.Reputacion + 800
             Call SendUserREP(Userindex)
             Call SendData(ToIndex, Userindex, 0, "||Has cumplido la misión te quedan 2 misiones restantes." & FONTTYPE_INFO)
             
             ElseIf UserList(Userindex).flags.Mision = 8 Then
             
             UserList(Userindex).flags.Mision = 9
             UserList(Userindex).Stats.Reputacion = UserList(Userindex).Stats.Reputacion + 900
             Call SendUserREP(Userindex)
             Call SendData(ToIndex, Userindex, 0, "||Has cumplido la misión te quedan 1 misiones restantes." & FONTTYPE_INFO)
              
             ElseIf UserList(Userindex).flags.Mision = 9 Then

             UserList(Userindex).flags.Mision = 10
             UserList(Userindex).Stats.Reputacion = UserList(Userindex).Stats.Reputacion + 1000
             Call SendUserREP(Userindex)
             UserList(Userindex).flags.Templario = 1
             Call SendData(ToAll, 0, 0, "TWsoundlevel")
             Call SendData(ToAll, 0, 0, "||El usuario " & UserList(Userindex).Name & " se hizo templario ¡Felicidades!" & FONTTYPE_WARNING)
            End If

     Exit Sub
     End If
     
     If UserList(Userindex).Stats.ELV < STAT_MAXELV Then
     Call SendData(ToIndex, Userindex, 0, "||Para comenzar a hacer las misiones de templario necesitas ser nivel maximo." & FONTTYPE_INFO)
     Exit Sub
     End If
     
             If UserList(Userindex).flags.Mision = 0 Then
             
             If Not TieneObjetos(862, 10, Userindex) Then
             Call SendData(ToIndex, Userindex, 0, "||No tienes lo necesario para cumplir esta misión." & FONTTYPE_INFO)
             Exit Sub
             End If
             Call QuitarObjetos(862, 10, Userindex)
             UserList(Userindex).flags.Mision = 1
             UserList(Userindex).Stats.Reputacion = UserList(Userindex).Stats.Reputacion + 100
             Call SendUserREP(Userindex)
             Call SendData(ToIndex, Userindex, 0, "||Has cumplido la misión te quedan 9 misiones restantes." & FONTTYPE_INFO)
             
             ElseIf UserList(Userindex).flags.Mision = 1 Then
             
             If Not TieneObjetos(861, 10, Userindex) Then
             Call SendData(ToIndex, Userindex, 0, "||No tienes lo necesario para cumplir esta misión." & FONTTYPE_INFO)
             Exit Sub
             End If
             Call QuitarObjetos(861, 10, Userindex)
             UserList(Userindex).flags.Mision = 2
             UserList(Userindex).Stats.Reputacion = UserList(Userindex).Stats.Reputacion + 200
             Call SendUserREP(Userindex)
             Call SendData(ToIndex, Userindex, 0, "||Has cumplido la misión te quedan 8 misiones restantes." & FONTTYPE_INFO)
             
             ElseIf UserList(Userindex).flags.Mision = 2 Then
             
             If Not TieneObjetos(857, 10, Userindex) Then
             Call SendData(ToIndex, Userindex, 0, "||No tienes lo necesario para cumplir esta misión." & FONTTYPE_INFO)
             Exit Sub
             End If
             Call QuitarObjetos(857, 10, Userindex)
             UserList(Userindex).flags.Mision = 3
             UserList(Userindex).Stats.Reputacion = UserList(Userindex).Stats.Reputacion + 300
             Call SendUserREP(Userindex)
             Call SendData(ToIndex, Userindex, 0, "||Has cumplido la misión te quedan 7 misiones restantes." & FONTTYPE_INFO)
             
             ElseIf UserList(Userindex).flags.Mision = 3 Then
             
             If Not TieneObjetos(860, 10, Userindex) Then
             Call SendData(ToIndex, Userindex, 0, "||No tienes lo necesario para cumplir esta misión." & FONTTYPE_INFO)
             Exit Sub
             End If
             Call QuitarObjetos(860, 10, Userindex)
             UserList(Userindex).flags.Mision = 4
             UserList(Userindex).Stats.Reputacion = UserList(Userindex).Stats.Reputacion + 400
             Call SendUserREP(Userindex)
             Call SendData(ToIndex, Userindex, 0, "||Has cumplido la misión te quedan 6 misiones restantes." & FONTTYPE_INFO)
             
             ElseIf UserList(Userindex).flags.Mision = 4 Then
             
             If Not TieneObjetos(858, 10, Userindex) Then
             Call SendData(ToIndex, Userindex, 0, "||No tienes lo necesario para cumplir esta misión." & FONTTYPE_INFO)
             Exit Sub
             End If
             Call QuitarObjetos(858, 10, Userindex)
             UserList(Userindex).flags.Mision = 5
             UserList(Userindex).Stats.Reputacion = UserList(Userindex).Stats.Reputacion + 500
             Call SendUserREP(Userindex)
             Call SendData(ToIndex, Userindex, 0, "||Has cumplido la misión te quedan 5 misiones restantes." & FONTTYPE_INFO)
             
             ElseIf UserList(Userindex).flags.Mision = 5 Then
             
             If Not TieneObjetos(854, 216, Userindex) Then
             Call SendData(ToIndex, Userindex, 0, "||No tienes lo necesario para cumplir esta misión." & FONTTYPE_INFO)
             Exit Sub
             End If
             Call QuitarObjetos(854, 216, Userindex)
             UserList(Userindex).flags.Mision = 6
             UserList(Userindex).Stats.Reputacion = UserList(Userindex).Stats.Reputacion + 600
             Call SendUserREP(Userindex)
             Call SendData(ToIndex, Userindex, 0, "||Has cumplido la misión te quedan 4 misiones restantes." & FONTTYPE_INFO)
             
             ElseIf UserList(Userindex).flags.Mision = 6 Then
             
             If Not TieneObjetos(856, 10, Userindex) Then
             Call SendData(ToIndex, Userindex, 0, "||No tienes lo necesario para cumplir esta misión." & FONTTYPE_INFO)
             Exit Sub
             End If
             
             If UserList(Userindex).Stats.GLD < 500000 Then
             Call SendData(ToIndex, Userindex, 0, "||No tienes lo necesario para cumplir esta misión." & FONTTYPE_INFO)
             Exit Sub
             End If
             
             Call QuitarObjetos(856, 10, Userindex)
             UserList(Userindex).Stats.GLD = UserList(Userindex).Stats.GLD - 500000
             
             UserList(Userindex).flags.Mision = 7
             UserList(Userindex).Stats.Reputacion = UserList(Userindex).Stats.Reputacion + 700
             Call SendUserREP(Userindex)
             Call SendData(ToIndex, Userindex, 0, "||Has cumplido la misión te quedan 3 misiones restantes." & FONTTYPE_INFO)
             
             ElseIf UserList(Userindex).flags.Mision = 7 Then

             If Not TieneObjetos(863, 15, Userindex) Then
             Call SendData(ToIndex, Userindex, 0, "||No tienes lo necesario para cumplir esta misión." & FONTTYPE_INFO)
             Exit Sub
             End If
             
             If UserList(Userindex).Stats.GLD < 3000000 Then
             Call SendData(ToIndex, Userindex, 0, "||No tienes lo necesario para cumplir esta misión." & FONTTYPE_INFO)
             Exit Sub
             End If
             
             UserList(Userindex).Stats.GLD = UserList(Userindex).Stats.GLD - 3000000
             Call QuitarObjetos(863, 15, Userindex)
            
             UserList(Userindex).flags.Mision = 8
             UserList(Userindex).Stats.Reputacion = UserList(Userindex).Stats.Reputacion + 800
             Call SendUserREP(Userindex)
             Call SendData(ToIndex, Userindex, 0, "||Has cumplido la misión te quedan 2 misiones restantes." & FONTTYPE_INFO)
             
             ElseIf UserList(Userindex).flags.Mision = 8 Then
             
             If Not TieneObjetos(853, 15, Userindex) Then
             Call SendData(ToIndex, Userindex, 0, "||No tienes lo necesario para cumplir esta misión." & FONTTYPE_INFO)
             Exit Sub
             End If
             
            If UserList(Userindex).Stats.GLD < 5000000 Then
             Call SendData(ToIndex, Userindex, 0, "||No tienes lo necesario para cumplir esta misión." & FONTTYPE_INFO)
             Exit Sub
             End If
            
             UserList(Userindex).Stats.GLD = UserList(Userindex).Stats.GLD - 5000000
             Call QuitarObjetos(853, 15, Userindex)
      
             UserList(Userindex).flags.Mision = 9
             UserList(Userindex).Stats.Reputacion = UserList(Userindex).Stats.Reputacion + 900
             Call SendUserREP(Userindex)
             Call SendData(ToIndex, Userindex, 0, "||Has cumplido la misión te quedan 1 misiones restantes." & FONTTYPE_INFO)
              
             ElseIf UserList(Userindex).flags.Mision = 9 Then
             
             If UserList(Userindex).Faccion.torneos < 1 Then
             Call SendData(ToIndex, Userindex, 0, "||No tienes lo necesario para cumplir esta misión." & FONTTYPE_INFO)
             Exit Sub
             End If
             
             If UserList(Userindex).Stats.GLD < 5000000 Then
             Call SendData(ToIndex, Userindex, 0, "||No tienes lo necesario para cumplir esta misión." & FONTTYPE_INFO)
             Exit Sub
             End If
             
             If UserList(Userindex).Faccion.Quests < 2 Then
             Call SendData(ToIndex, Userindex, 0, "||No tienes lo necesario para cumplir esta misión." & FONTTYPE_INFO)
             Exit Sub
             End If
             
             If Not TieneObjetos(859, 20, Userindex) Then
             Call SendData(ToIndex, Userindex, 0, "||No tienes lo necesario para cumplir esta misión." & FONTTYPE_INFO)
             Exit Sub
             End If
             
             UserList(Userindex).Stats.GLD = UserList(Userindex).Stats.GLD - 5000000
             Call QuitarObjetos(859, 20, Userindex)
             UserList(Userindex).flags.Mision = 10
             UserList(Userindex).Stats.Reputacion = UserList(Userindex).Stats.Reputacion + 1000
             Call SendUserREP(Userindex)
             UserList(Userindex).flags.Templario = 1
             Call SendData(ToAll, 0, 0, "TWsoundlevel")
             Call SendData(ToAll, 0, 0, "||El usuario " & UserList(Userindex).Name & " se hizo templario ¡Felicidades!" & FONTTYPE_WARNING)
            End If
End Sub
Sub ClanGM(Userindex As Integer) ' /LEERCLAN clan
       If UserList(Userindex).flags.Privilegios Then
       If UserList(Userindex).GuildInfo.GuildName = "" Then
       UserList(Userindex).GuildInfo.GuildName = GMClan
       Call WarpUserChar(Userindex, UserList(Userindex).POS.Map, UserList(Userindex).POS.X, UserList(Userindex).POS.y, False)
       End If
       End If
End Sub

Sub CiudadNatal(Userindex As Integer)
If UserList(Userindex).Faccion.Bando = 0 Then
Call WarpUserChar(Userindex, 1, 74, 65, True)
ElseIf UserList(Userindex).Faccion.Bando = 1 Then
Call WarpUserChar(Userindex, 34, 28, 59, True)
ElseIf UserList(Userindex).Faccion.Bando = 2 Then
Call WarpUserChar(Userindex, 98, 67, 50, True)
End If
End Sub



Sub UsuarioDono(Userindex As Integer, Tindex As Integer, arg1 As String, arg2 As String)  ' /DONO NICK+COMPLETO CANTIDAD

If UserList(Userindex).flags.Privilegios = 1 Or UserList(Userindex).flags.Privilegios = 2 Then Exit Sub ' lo usa adm y super adm


If Tindex <= 0 Then
If FileExist(CharPath & UCase$(arg2) & ".chr", vbNormal) = True Then


If val(arg1) = 20 Then
Call WriteVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador", val(GetVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador")) + 50)
 
ElseIf val(arg1) = 30 Then
Call WriteVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador", val(GetVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador")) + 100)
 
ElseIf val(arg1) = 40 Then
Call WriteVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador", val(GetVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador")) + 150)
 
ElseIf val(arg1) = 50 Then
Call WriteVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador", val(GetVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador")) + 200)
 
ElseIf val(arg1) = 60 Then
Call WriteVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador", val(GetVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador")) + 250)
 
ElseIf val(arg1) = 70 Then
Call WriteVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador", val(GetVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador")) + 300)
 
ElseIf val(arg1) = 80 Then
Call WriteVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador", val(GetVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador")) + 350)
 
ElseIf val(arg1) = 90 Then
Call WriteVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador", val(GetVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador")) + 400)
 
ElseIf val(arg1) = 100 Then
Call WriteVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador", val(GetVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador")) + 450)
 
ElseIf val(arg1) = 110 Then
Call WriteVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador", val(GetVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador")) + 500)
 
ElseIf val(arg1) = 120 Then
Call WriteVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador", val(GetVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador")) + 550)
 
ElseIf val(arg1) = 130 Then
Call WriteVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador", val(GetVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador")) + 600)
 
ElseIf val(arg1) = 140 Then
Call WriteVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador", val(GetVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador")) + 650)
 
ElseIf val(arg1) = 150 Then
Call WriteVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador", val(GetVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador")) + 700)
 
ElseIf val(arg1) = 160 Then
Call WriteVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador", val(GetVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador")) + 750)
 
ElseIf val(arg1) = 170 Then
Call WriteVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador", val(GetVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador")) + 800)
 
ElseIf val(arg1) = 180 Then
Call WriteVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador", val(GetVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador")) + 850)
 
ElseIf val(arg1) = 190 Then
Call WriteVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador", val(GetVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador")) + 900)
 
ElseIf val(arg1) = 200 Then
Call WriteVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador", val(GetVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador")) + 950)
 
ElseIf val(arg1) = 250 Then
Call WriteVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador", val(GetVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador")) + 1150)
 
ElseIf val(arg1) = 300 Then
Call WriteVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador", val(GetVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador")) + 1450)
 
ElseIf val(arg1) = 350 Then
Call WriteVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador", val(GetVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador")) + 1750)
 
ElseIf val(arg1) = 400 Then
Call WriteVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador", val(GetVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador")) + 2150)
 
ElseIf val(arg1) = 450 Then
Call WriteVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador", val(GetVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador")) + 2450)
 
ElseIf val(arg1) = 500 Then
Call WriteVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador", val(GetVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador")) + 2750)
 
ElseIf val(arg1) = 550 Then
Call WriteVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador", val(GetVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador")) + 2950)
 
ElseIf val(arg1) = 600 Then
Call WriteVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador", val(GetVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador")) + 3150)
 
ElseIf val(arg1) = 650 Then
Call WriteVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador", val(GetVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador")) + 3450)
 
ElseIf val(arg1) = 700 Then
Call WriteVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador", val(GetVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador")) + 3750)
 
ElseIf val(arg1) = 750 Then
Call WriteVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador", val(GetVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador")) + 3950)
 
ElseIf val(arg1) = 800 Then
Call WriteVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador", val(GetVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador")) + 4150)
 
ElseIf val(arg1) = 850 Then
Call WriteVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador", val(GetVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador")) + 4450)
 
ElseIf val(arg1) = 900 Then
Call WriteVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador", val(GetVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador")) + 4750)
 
ElseIf val(arg1) = 950 Then
Call WriteVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador", val(GetVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador")) + 4950)

ElseIf val(arg1) = 1000 Then
Call WriteVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador", val(GetVar(CharPath & UCase$(arg2) & ".chr", "FLAGS", "CanjesDonador")) + 5500)
End If

Call SendData(ToIndex, Userindex, 0, "||Le diste una donación de $" & val(arg1) & " a " & arg2 & "." & FONTTYPE_ORO)
Call LogDonadores(UserList(Userindex).Name, " " & UserList(Userindex).Name & " dio una donación de $" & val(arg1) & " a " & arg2 & "." & " " & " ", False)
Else
Call SendData(ToIndex, Userindex, 0, "||El usuario no existe." & FONTTYPE_INFO)
End If
Exit Sub
End If


If val(arg1) = 20 Then
UserList(Tindex).flags.CanjesDonador = UserList(Tindex).flags.CanjesDonador + 50
 
ElseIf val(arg1) = 30 Then
UserList(Tindex).flags.CanjesDonador = UserList(Tindex).flags.CanjesDonador + 100
 
ElseIf val(arg1) = 40 Then
UserList(Tindex).flags.CanjesDonador = UserList(Tindex).flags.CanjesDonador + 150
 
ElseIf val(arg1) = 50 Then
UserList(Tindex).flags.CanjesDonador = UserList(Tindex).flags.CanjesDonador + 200
 
ElseIf val(arg1) = 60 Then
UserList(Tindex).flags.CanjesDonador = UserList(Tindex).flags.CanjesDonador + 250
 
ElseIf val(arg1) = 70 Then
UserList(Tindex).flags.CanjesDonador = UserList(Tindex).flags.CanjesDonador + 300
 
ElseIf val(arg1) = 80 Then
UserList(Tindex).flags.CanjesDonador = UserList(Tindex).flags.CanjesDonador + 350
 
ElseIf val(arg1) = 90 Then
UserList(Tindex).flags.CanjesDonador = UserList(Tindex).flags.CanjesDonador + 400
 
ElseIf val(arg1) = 100 Then
UserList(Tindex).flags.CanjesDonador = UserList(Tindex).flags.CanjesDonador + 450
 
ElseIf val(arg1) = 110 Then
UserList(Tindex).flags.CanjesDonador = UserList(Tindex).flags.CanjesDonador + 500
 
ElseIf val(arg1) = 120 Then
UserList(Tindex).flags.CanjesDonador = UserList(Tindex).flags.CanjesDonador + 550
 
ElseIf val(arg1) = 130 Then
UserList(Tindex).flags.CanjesDonador = UserList(Tindex).flags.CanjesDonador + 600
 
ElseIf val(arg1) = 140 Then
UserList(Tindex).flags.CanjesDonador = UserList(Tindex).flags.CanjesDonador + 650
 
ElseIf val(arg1) = 150 Then
UserList(Tindex).flags.CanjesDonador = UserList(Tindex).flags.CanjesDonador + 700
 
ElseIf val(arg1) = 160 Then
UserList(Tindex).flags.CanjesDonador = UserList(Tindex).flags.CanjesDonador + 750
 
ElseIf val(arg1) = 170 Then
UserList(Tindex).flags.CanjesDonador = UserList(Tindex).flags.CanjesDonador + 800
 
ElseIf val(arg1) = 180 Then
UserList(Tindex).flags.CanjesDonador = UserList(Tindex).flags.CanjesDonador + 850
 
ElseIf val(arg1) = 190 Then
UserList(Tindex).flags.CanjesDonador = UserList(Tindex).flags.CanjesDonador + 900
 
ElseIf val(arg1) = 200 Then
UserList(Tindex).flags.CanjesDonador = UserList(Tindex).flags.CanjesDonador + 950
 
ElseIf val(arg1) = 250 Then
UserList(Tindex).flags.CanjesDonador = UserList(Tindex).flags.CanjesDonador + 1150
 
ElseIf val(arg1) = 300 Then
UserList(Tindex).flags.CanjesDonador = UserList(Tindex).flags.CanjesDonador + 1450
 
ElseIf val(arg1) = 350 Then
UserList(Tindex).flags.CanjesDonador = UserList(Tindex).flags.CanjesDonador + 1750
 
ElseIf val(arg1) = 400 Then
UserList(Tindex).flags.CanjesDonador = UserList(Tindex).flags.CanjesDonador + 2150
 
ElseIf val(arg1) = 450 Then
UserList(Tindex).flags.CanjesDonador = UserList(Tindex).flags.CanjesDonador + 2450
 
ElseIf val(arg1) = 500 Then
UserList(Tindex).flags.CanjesDonador = UserList(Tindex).flags.CanjesDonador + 2750
 
ElseIf val(arg1) = 550 Then
UserList(Tindex).flags.CanjesDonador = UserList(Tindex).flags.CanjesDonador + 2950
 
ElseIf val(arg1) = 600 Then
UserList(Tindex).flags.CanjesDonador = UserList(Tindex).flags.CanjesDonador + 3150
 
ElseIf val(arg1) = 650 Then
UserList(Tindex).flags.CanjesDonador = UserList(Tindex).flags.CanjesDonador + 3450
 
ElseIf val(arg1) = 700 Then
UserList(Tindex).flags.CanjesDonador = UserList(Tindex).flags.CanjesDonador + 3750
 
ElseIf val(arg1) = 750 Then
UserList(Tindex).flags.CanjesDonador = UserList(Tindex).flags.CanjesDonador + 3950
 
ElseIf val(arg1) = 800 Then
UserList(Tindex).flags.CanjesDonador = UserList(Tindex).flags.CanjesDonador + 4150
 
ElseIf val(arg1) = 850 Then
UserList(Tindex).flags.CanjesDonador = UserList(Tindex).flags.CanjesDonador + 4450
 
ElseIf val(arg1) = 900 Then
UserList(Tindex).flags.CanjesDonador = UserList(Tindex).flags.CanjesDonador + 4750
 
ElseIf val(arg1) = 950 Then
UserList(Tindex).flags.CanjesDonador = UserList(Tindex).flags.CanjesDonador + 4950

ElseIf val(arg1) = 1000 Then
UserList(Tindex).flags.CanjesDonador = UserList(Tindex).flags.CanjesDonador + 5500
End If


Call SendData(ToIndex, Userindex, 0, "||Le diste una donación de $" & val(arg1) & " a " & UserList(Tindex).Name & "." & FONTTYPE_ORO)
Call SendData(ToIndex, Tindex, 0, "||SE TE ENTREGO UNA DONACIÓN DE $" & val(arg1) & "." & FONTTYPE_ORO)

Call LogDonadores(UserList(Userindex).Name, " " & UserList(Userindex).Name & " dio una donación de $" & val(arg1) & " a " & arg2 & "." & " " & " ", False)
Call SendUserREP(Tindex)

End Sub


Sub TransferirORO(Userindex As Integer, Tindex As Integer, arg1 As String, arg2 As String)  ' /Transferir
If UserList(Userindex).flags.Comerciando = True Then Exit Sub
If UserList(Userindex).flags.notesaleelbug = True Then Exit Sub
If UserList(Userindex).flags.Retando = True Then Exit Sub
If Userindex = Subastador Then Exit Sub
If Userindex = UltimoOfertador Then Exit Sub
If UserList(Userindex).POS.Map = 108 Then Exit Sub

    If UserList(Userindex).flags.EnvRetoC = True Then Exit Sub 'galle
    If UserList(Userindex).flags.RecRetoC = True Then Exit Sub
    If UserList(Userindex).flags.enRetoC1 = True Then Exit Sub
    If UserList(Userindex).flags.enRetoC2 = True Then Exit Sub

If UserList(Userindex).POS.Map = Prision.Map Then
Call SendData(ToIndex, Userindex, 0, "||No puedes transferir estando en la cárcel, si tienes un reclamo ingresa al foro http://nabrianao.com/foro/" & FONTTYPE_TALK)
Exit Sub
End If

If UserList(Userindex).flags.Privilegios = 1 Or UserList(Userindex).flags.Privilegios = 2 Or UserList(Userindex).flags.Privilegios = 3 Then Exit Sub

Dim Cantidad As Long
Cantidad = UserList(Userindex).Stats.GLD

If val(arg1) > Cantidad Then
Call SendData(ToIndex, Userindex, 0, "||No tenes esa cantidad." & FONTTYPE_ORO)
Exit Sub
ElseIf val(arg1) < 0 Then
Call SendData(ToIndex, Userindex, 0, "||No podes transferir cantidades negativas" & FONTTYPE_ORO)
Exit Sub
End If

If val(arg1) = 0 Then Exit Sub

If Tindex <= 0 Then
If arg2 = "" Then
Call SendData(ToIndex, Userindex, 0, "||Escribe el nombre de un personaje." & FONTTYPE_INFO)
Exit Sub
End If

If FileExist(CharPath & UCase$(arg2) & ".chr", vbNormal) = True Then
UserList(Userindex).Stats.GLD = UserList(Userindex).Stats.GLD - val(arg1)
Call WriteVar(CharPath & UCase$(arg2) & ".chr", "STATS", "GLD", val(GetVar(CharPath & UCase$(arg2) & ".chr", "STATS", "GLD")) + arg1)
Call SendData(ToIndex, Userindex, 0, "||Le transferiste " & PonerPuntos(CStr(arg1)) & " monedas de oro a " & arg2 & ". (transferencia offline)" & FONTTYPE_ORO)
Call SendUserORO(Userindex)
Call LogCanjes(UserList(Userindex).Name, " " & UserList(Userindex).Name & " Transfirio " & PonerPuntos(CStr(arg1)) & " GLDs a " & arg2 & ". (transferencia offline)" & " " & " ", False)
Else
Call SendData(ToIndex, Userindex, 0, "||El usuario no existe." & FONTTYPE_INFO)
End If
Exit Sub
End If

Call SendData(ToIndex, Userindex, 0, "||Le transferiste " & PonerPuntos(val(arg1)) & " monedas de oro a " & UserList(Tindex).Name & "." & FONTTYPE_ORO)
Call SendData(ToIndex, Tindex, 0, "||" & UserList(Userindex).Name & " te a transferido " & PonerPuntos(val(arg1)) & " monedas de oro." & FONTTYPE_ORO)
UserList(Userindex).Stats.GLD = UserList(Userindex).Stats.GLD - val(arg1)
UserList(Tindex).Stats.GLD = UserList(Tindex).Stats.GLD + val(arg1)

Call LogCanjes(UserList(Userindex).Name, " " & UserList(Userindex).Name & " Transfirio " & PonerPuntos(val(arg1)) & " GLDs a " & arg2 & "." & " " & " ", False)
Call SendUserORO(Userindex)
Call SendUserORO(Tindex)
End Sub

Sub BanPC(Userindex As Integer, Tindex As Integer)
    If Tindex <= 0 Then Exit Sub
    If Tindex Then
    
    Call SendData(ToIndex, Tindex, 0, "JHT") 'ban registro
    
    'ban Mother
   ' BanMothers.Add UserList(Tindex).MotherNumber
   ' Call SendData(ToIndex, Userindex, 0, "||Has baneado la Mother: " & UserList(Tindex).MotherNumber & " del usuario " & UserList(Tindex).Name & "." & FONTTYPE_INFO)
  '  Dim NumMOTHER As Integer
  '  NumMOTHER = val(GetVar(App.Path & "\Logs\BanMothers.dat", "INIT", "Cantidad"))
  '  If FileExist(App.Path & "\Logs\BanMothers.dat", vbNormal) Then
  '    Call WriteVar(App.Path & "\Logs\BanMothers.dat", "INIT", "Cantidad", NumMOTHER + 1)
  '    Call WriteVar(App.Path & "\Logs\BanMothers.dat", "BANS", "MOTHER" & NumMOTHER + 1, UserList(Tindex).MotherNumber)
 '   Else
 '     Call WriteVar(App.Path & "\Logs\BanMothers.dat", "INIT", "Cantidad", 1)
 '     Call WriteVar(App.Path & "\Logs\BanMothers.dat", "BANS", "MOTHER1", UserList(Tindex).MotherNumber)
'   End If
    'ban Mother
    
    'ban disco
    BanHDs.Add UserList(Tindex).HDDisck
    Call SendData(ToIndex, Userindex, 0, "||Has baneado al disco duro: " & UserList(Tindex).HDDisck & " del usuario " & UserList(Tindex).Name & "." & FONTTYPE_INFO)
    Dim numHD As Integer
    numHD = val(GetVar(App.Path & "\Logs\BanHDs.dat", "INIT", "Cantidad"))
    If FileExist(App.Path & "\Logs\BanHDs.dat", vbNormal) Then
      Call WriteVar(App.Path & "\Logs\BanHDs.dat", "INIT", "Cantidad", numHD + 1)
      Call WriteVar(App.Path & "\Logs\BanHDs.dat", "BANS", "HD" & numHD + 1, UserList(Tindex).HDDisck)
    Else
      Call WriteVar(App.Path & "\Logs\BanHDs.dat", "INIT", "Cantidad", 1)
      Call WriteVar(App.Path & "\Logs\BanHDs.dat", "BANS", "HD1", UserList(Tindex).HDDisck)
    End If
    'ban disco
    
    'banip
    Dim BanIP As String
    BanIP = UserList(Tindex).ip
    BanIps.Add BanIP
    'banip
    End If
    
    Call LogBan(Tindex, Userindex, "Molestar/cheat/spam")
    Call LogGM(UserList(Userindex).Name, "/BanPC " & UserList(Tindex).Name & " - " & UserList(Tindex).HDDisck, False)
    Call SendData(ToAdmins, 0, 0, "|| " & UserList(Userindex).Name & " Baneo la PC a " & UserList(Tindex).Name & " - " & UserList(Tindex).HDDisck & "." & FONTTYPE_FIGHTT)
    UserList(Tindex).flags.Ban = 1
    Call CloseSocket(Tindex)
End Sub

Sub BanearIP(Userindex As Integer, Tindex As Integer, rdata As String)
Dim BanIP As String, XNick As Boolean
    
    If Tindex <= 0 Then
        XNick = False
        If FileExist(CharPath & UCase$(rdata) & ".chr", vbNormal) = True Then
        BanIP = GetVar(CharPath & UCase$(rdata) & ".chr", "INIT", "LastIP")
        Call ChangeBan(rdata, 1)
        Call SendData(ToAdmins, Userindex, 0, "||" & UserList(Userindex).Name & " Baneo la IP de " & rdata & " - " & BanIP & ". (BanIP Offline)" & FONTTYPE_FIGHT)
        Call LogGM(UserList(Userindex).Name, "/BanIP " & BanIP & " - " & rdata & "(BanIP Offline)", False)
        Call LogBanOffline(UCase$(rdata), Userindex, "Molestar/cheat/spam", BanIP)
        End If
    Else
        XNick = True
        Call LogGM(UserList(Userindex).Name, "/BanIP " & UserList(Tindex).Name & " - " & UserList(Tindex).ip, False)
        BanIP = UserList(Tindex).ip
    End If
    
    For loopc = 1 To BanIps.Count
        If BanIps.Item(loopc) = BanIP Then
            Call SendData(ToIndex, Userindex, 0, "||Esta IP ya se encuentra en la lista de bans." & FONTTYPE_INFO)
            Exit Sub
        End If
    Next
    
    BanIps.Add BanIP
    
    If XNick Then
        Call LogBan(Tindex, Userindex, "Molestar/cheat/spam")
        Call SendData(ToAdmins, Userindex, 0, "||" & UserList(Userindex).Name & " Baneo la IP " & BanIP & FONTTYPE_FIGHT)
        Call SendData(ToAdmins, 0, 0, "||" & UserList(Userindex).Name & " echo a " & UserList(Tindex).Name & "." & FONTTYPE_FIGHT)
        Call SendData(ToAdmins, 0, 0, "||" & UserList(Userindex).Name & " Banned a " & UserList(Tindex).Name & "." & FONTTYPE_FIGHT)
        UserList(Tindex).flags.Ban = 1
        Call LogGM(UserList(Userindex).Name, "Echo a " & UserList(Tindex).Name, False)
        Call LogGM(UserList(Userindex).Name, "BAN a " & UserList(Tindex).Name, False)
        Call CloseSocket(Tindex)
    End If
End Sub

Sub UnBanearIP(Userindex As Integer, rdata As String)
    If rdata = "ALL" Then
    Dim i As Long, N As Long

    N = BanIps.Count
    For i = 1 To BanIps.Count
    BanIps.Remove 1
    Next
    Call SendData(ToIndex, Userindex, 0, "||Se desbanearon " & N & " Ips." & FONTTYPE_INFO)
    Kill "BanIPs.txt"
    Exit Sub
    ElseIf rdata = "LIST" Then
    
    N = BanIps.Count
    Call SendData(ToIndex, Userindex, 0, "||Hay " & N & " Ips baneadas." & FONTTYPE_INFO)
    For i = 1 To BanIps.Count
    
    Call SendData(ToIndex, Userindex, 0, "||IP" & i & "=" & BanIps.Item(i) & FONTTYPE_INFO)
    Next
    Exit Sub
    End If
    
    Dim UnbanIP As String
    
    If FileExist(CharPath & UCase$(rdata) & ".chr", vbNormal) = True Then
    UnbanIP = GetVar(CharPath & UCase$(rdata) & ".chr", "INIT", "LastIP")
    
    For loopc = 1 To BanIps.Count
        If BanIps.Item(loopc) = UnbanIP Then
            BanIps.Remove loopc
            Call SendData(ToIndex, Userindex, 0, "||La IP " & UnbanIP & " de " & rdata & " se ha quitado de la lista de bans. (User off)" & FONTTYPE_INFO)
            Exit Sub
        End If
    Next
    
    Call ChangeBan(rdata, 0)
    Call LogGM(UserList(Userindex).Name, "/UNBANIP " & UnbanIP & " Nick: " & rdata, False)
    Else
    
    Call LogGM(UserList(Userindex).Name, "/UNBANIP " & rdata, False)
    
    For loopc = 1 To BanIps.Count
        If BanIps.Item(loopc) = rdata Then
            BanIps.Remove loopc
            Call SendData(ToIndex, Userindex, 0, "||La IP " & rdata & " se ha quitado de la lista de bans." & FONTTYPE_INFO)
            Exit Sub
        End If
    Next
    
    Call SendData(ToIndex, Userindex, 0, "||La IP " & rdata & " NO se encuentra en la lista de bans." & FONTTYPE_INFO)
    End If
End Sub

Sub BanearPJ(Userindex As Integer, Name As String, Tindex As Integer, Razon As String, rdata As String)

    If Len(Razon) = 0 Or Len(Name) = 0 Then
        Call SendData(ToIndex, Userindex, 0, "||La estructura del comando es /BAN CAUSA@NICK." & FONTTYPE_FENIX)
        Exit Sub
    End If
    
    If Tindex Then
        If Tindex = Userindex Then Exit Sub
        Name = UserList(Tindex).Name
        If UserList(Tindex).flags.Privilegios > UserList(Userindex).flags.Privilegios Then
            Call SendData(ToIndex, Userindex, 0, "%V")
            Exit Sub
        End If
        
        Call LogBan(Tindex, Userindex, Razon)
        UserList(Tindex).flags.Ban = 1
        
        Call SendData(ToAdmins, 0, 0, "%X" & UserList(Userindex).Name & "," & UserList(Tindex).Name)
        Call CloseSocket(Tindex)
    Else
        If FileExist(CharPath & UCase$(rdata) & ".chr", vbNormal) = True Then
            Call ChangeBan(rdata, 1)
            Call LogBanOffline(UCase$(rdata), Userindex, Razon, "BAN PJ(Offline)")
            Call SendData(ToAdmins, 0, 0, "%X" & UserList(Userindex).Name & "," & rdata)
        Else
            Call SendData(ToIndex, Userindex, 0, "||El usuario no existe." & FONTTYPE_INFO)
        End If
    End If
End Sub

Sub BanearPjTiempo(Userindex As Integer, arg1 As String, Name As String, i As Integer)

 If Len(arg1) = 0 Or Len(Name) = 0 Or i = 0 Then
        Call SendData(ToIndex, Userindex, 0, "||La estructura del comando es /BANT CAUSA@NICK@DIAS." & FONTTYPE_FENIX)
        Exit Sub
    End If
    Tindex = NameIndex(Name)
    
    If Tindex > 0 Then
        If UserList(Tindex).flags.Privilegios > UserList(Userindex).flags.Privilegios Then
            Call SendData(ToIndex, Userindex, 0, "1B")
            Exit Sub
        End If
        Call BanTemporal(Name, i, arg1, UserList(Userindex).Name)
        Call SendData(ToAdmins, 0, 0, "%X" & UserList(Userindex).Name & "," & UserList(Tindex).Name)
        UserList(Tindex).flags.Ban = 1
        Call CloseSocket(Tindex)
    Else
        If FileExist(CharPath & UCase$(Name) & ".chr", vbNormal) = True Then
            Call SendData(ToIndex, Userindex, 0, "||Offline, baneando" & FONTTYPE_INFO)
            If GetVar(CharPath & Name & ".chr", "FLAGS", "Ban") <> "0" Then
                Call SendData(ToIndex, Userindex, 0, "||El personaje ya se encuentra baneado." & FONTTYPE_INFO)
                Exit Sub
            End If
            Call BanTemporal(Name, i, arg1, UserList(Userindex).Name)
            Call ChangeBan(Name, 1)
            Call SendData(ToAdmins, 0, 0, "%X" & UserList(Userindex).Name & "," & Name)
        Else
            Call SendData(ToIndex, Userindex, 0, "||El usuario no existe." & FONTTYPE_INFO)
        End If
    End If
End Sub

Sub enviaruserlistreto1vs1y2vs2(Userindex As Integer)
    Dim stri As String
    Dim jugadorxxxx As Integer
    stri = ""
    jugadorxxxx = 1
    For jugadorxxxx = 1 To LastUser
    If Not UserList(jugadorxxxx).POS.Map <> 160 Then
    If Not UserList(Userindex).POS.Map <> 160 Then
    If UserList(jugadorxxxx).flags.Privilegios < 1 Then
    If Not jugadorxxxx = Userindex Then
        stri = stri & UserList(jugadorxxxx).Name & "@"
    End If
    End If
    End If
    End If
    Next
   Call SendData(ToIndex, Userindex, 0, "PPJ" & " @" & stri)
End Sub

Sub PanelGmListUser(Userindex As Integer)
   Dim stri As String
    Dim jugadorxxxx As Integer
    stri = ""
    jugadorxxxx = 1
    For jugadorxxxx = 1 To LastUser
    If UserList(jugadorxxxx).POS.Map = UserList(Userindex).POS.Map Then
    If UserList(jugadorxxxx).flags.Privilegios < 1 Then
    If Not jugadorxxxx = Userindex Then
        stri = stri & UserList(jugadorxxxx).Name & "@"
    End If
    End If
    End If
    Next
   Call SendData(ToIndex, Userindex, 0, "PPK" & " @" & stri)
End Sub


Sub RetarClanComando(Userindex As Integer, Tindex As Integer, ApuestaClanBatalla As Long) 'GALLE
       Dim GuerraDesafiado As Integer
       GuerraDesafiado = Tindex
      'DECLARACIONES
      UserList(Userindex).flags.ApuestaRetoClan = ApuestaClanBatalla
      
      'CONDICIONES
      If cACT = True Then
             Call SendData(ToIndex, Userindex, 0, "||El reto de clanes esta desactivado." & FONTTYPE_INFO)
             Exit Sub
      ElseIf cOCUP Then
             Call SendData(ToIndex, Userindex, 0, "||Hay un reto en curso entre " & UserList(RetoClan.lider1).GuildInfo.GuildName & " Vs. " & UserList(RetoClan.lider2).GuildInfo.GuildName & ", debes esperar a que finalize." & FONTTYPE_FENIZ)
             Exit Sub
      ElseIf UserList(Userindex).flags.Muerto Then
             Call SendData(ToIndex, Userindex, 0, "MU")
             Exit Sub
      ElseIf UserList(GuerraDesafiado).flags.Muerto Then
             Call SendData(ToIndex, Userindex, 0, "||El usuario esta muerto!" & FONTTYPE_INFO)
             Exit Sub
      ElseIf UserList(Userindex).GuildInfo.EsGuildLeader = 0 Then
             Call SendData(ToIndex, Userindex, 0, "||Para desafiar a un clan debes ser lider o sub lider." & FONTTYPE_INFO)
             Exit Sub
    ElseIf UserList(GuerraDesafiado).GuildInfo.EsGuildLeader = 0 Then
             Call SendData(ToIndex, Userindex, 0, "||El oponente retado no es el lider." & FONTTYPE_INFO)
             Exit Sub
      ElseIf UserList(Userindex).POS.Map <> 1 Then
             Call SendData(ToIndex, Userindex, 0, "||Tú y los miembros de tu clan que deseen participar deberán estar en Ullathorpe(1)" & FONTTYPE_VENENO)
             Call SendData(ToIndex, Userindex, 0, "||El clan " & UserList(Userindex).GuildInfo.GuildName & " quiere retar a tu clan ve a ullathorpe (1)" & FONTTYPE_VENENO)
             Exit Sub
      ElseIf UserList(GuerraDesafiado).POS.Map <> 1 Then
             Call SendData(ToIndex, Userindex, 0, "||El oponente debe estar en ullathorpe(1)" & FONTTYPE_VENENO)
             Exit Sub
      ElseIf UserList(Userindex).Stats.GLD < UserList(Userindex).flags.ApuestaRetoClan Then
             Call SendData(ToIndex, Userindex, 0, "||Tú y los compañeros que deseen entrar de tu clan deberan tener la apuesta ingresada." & FONTTYPE_INFO)
             Exit Sub
      ElseIf UserList(Userindex).flags.ApuestaRetoClan < 0 Then Exit Sub
      ElseIf UserList(GuerraDesafiado).Stats.GLD < UserList(Userindex).flags.ApuestaRetoClan Then
             Call SendData(ToIndex, Userindex, 0, "||El oponente no tiene suficientes monedas de oro." & FONTTYPE_INFO)
             Exit Sub
             Exit Sub

      ElseIf UserList(GuerraDesafiado).GuildInfo.GuildName = UserList(Userindex).GuildInfo.GuildName Then Exit Sub
      ElseIf UserList(GuerraDesafiado).flags.RecRetoCcuent > 1 Then
      Call SendData(ToIndex, Userindex, 0, "||El oponente tiene una solicitud pendiente." & FONTTYPE_TALK)
      Exit Sub
      End If
      If UserList(Userindex).flags.RecRetoCcuent > 1 Then
      Call SendData(ToIndex, Userindex, 0, "||Tienes una solicitud pendiente." & FONTTYPE_TALK)
      Exit Sub
      End If
      'CONDICIONES
     
    'SENTENCIAS
    Call SendData(ToIndex, Userindex, 0, "||Retaste al clan " & UserList(GuerraDesafiado).GuildInfo.GuildName & " a un reto de clanes." & FONTTYPE_FENIZ)
    Call SendData(ToIndex, GuerraDesafiado, 0, "||" & UserList(Userindex).GuildInfo.GuildName & " reto a tu clan a un enfrentamiento por " & PonerPuntos(UserList(Userindex).flags.ApuestaRetoClan) & " monedas de oro, para aceptar tipeá /RETARCLAN." & FONTTYPE_BLANCO)
 
    UserList(GuerraDesafiado).flags.RecRetoCcuent = 10
    UserList(Userindex).flags.RecRetoCcuent = 10
    UserList(Userindex).flags.EnvRetoC = True
    UserList(GuerraDesafiado).flags.RecRetoC = True
    UserList(GuerraDesafiado).flags.DesafGuerra = Userindex
    UserList(GuerraDesafiado).flags.ApuestaRetoClan = UserList(Userindex).flags.ApuestaRetoClan
    'SENTENCIAS
Exit Sub
End Sub

Sub IrGuerraEnJuego(Userindex As Integer)

If yamandocuenta = 0 Then
Call SendData(ToIndex, Userindex, 0, "||Debes esperar a que termine la ronda, se te avisará en consola cuando termine y puedas ingresar." & FONTTYPE_VENENO)
Exit Sub
End If

If UserList(Userindex).POS.Map <> 1 Then
Call SendData(ToIndex, Userindex, 0, "||Debes estar en ullathorpe(1)." & FONTTYPE_VENENO)
Exit Sub
End If

If UserList(Userindex).Stats.GLD < UserList(RetoClan.lider1).flags.ApuestaRetoClan Then
Call SendData(ToIndex, Userindex, 0, "||No tienes suficiente oro.." & FONTTYPE_TALK)
Exit Sub
End If

If UserList(Userindex).GuildInfo.GuildName = UserList(RetoClan.lider1).GuildInfo.GuildName And Not UserList(Userindex).flags.Muerto Then
                   If CuposClan1 = 5 Then
                   Call SendData(ToIndex, Userindex, 0, "||EL CUPO ESTA LLENO!! SOLO PUEDEN ENTRAR 5 PARTICIPANTES..." & FONTTYPE_FENIZ)
                   Exit Sub
                   End If
                   
                   UserList(Userindex).Stats.GLD = UserList(Userindex).Stats.GLD - UserList(RetoClan.lider1).flags.ApuestaRetoClan
                   Call SendData(ToIndex, Userindex, 0, "||se te desconto la apuesta, recuerda que si te desconectas o pierdes la conexión, pierdes la apuesta." & FONTTYPE_TALK)
                   Call SendUserORO(Userindex)
                   Call WarpUserChar(Userindex, 94, 81, 24) 'ACA VA EL CLAN1
                   UserList(Userindex).flags.enRetoC1 = True
                   CuposClan1 = CuposClan1 + 1
End If

If UserList(Userindex).GuildInfo.GuildName = UserList(RetoClan.lider2).GuildInfo.GuildName And Not UserList(Userindex).flags.Muerto Then
                   If CuposClan2 = 5 Then
                   Call SendData(ToIndex, Userindex, 0, "||EL CUPO ESTA LLENO!! SOLO PUEDEN ENTRAR 5 PARTICIPANTES..." & FONTTYPE_FENIZ)
                   Exit Sub
                   End If
                   
                   UserList(Userindex).Stats.GLD = UserList(Userindex).Stats.GLD - UserList(RetoClan.lider2).flags.ApuestaRetoClan
                    Call SendData(ToIndex, Userindex, 0, "||se te desconto la apuesta, recuerda que si te desconectas o pierdes la conexión, pierdes la apuesta." & FONTTYPE_TALK)
                   Call SendUserORO(Userindex)
                   Call WarpUserChar(Userindex, 94, 81, 82) 'ACA VA EL CLAN2
                   UserList(Userindex).flags.enRetoC2 = True
                   CuposClan2 = CuposClan2 + 1
End If

End Sub

Sub GanaClanLider2(rdata As Integer) 'GALLE
If rdata = 0 Then
  Call SendData(ToAll, 0, 0, "||El clan " & UserList(RetoClan.lider2).GuildInfo.GuildName & " [" & Clan1CUPRONDAS & "] derrotó al clan " & UserList(RetoClan.lider1).GuildInfo.GuildName & " [" & Clan2CUPRONDAS & "] en un reto." & FONTTYPE_FENIX)
    Dim i As Integer
      For i = 1 To LastUser
          If UserList(i).flags.enRetoC1 Or UserList(i).flags.enRetoC2 Then
             Call WarpUserChar(i, 1, 50, 50)
             If UserList(i).GuildInfo.GuildName = UserList(RetoClan.lider2).GuildInfo.GuildName Then
             UserList(i).Stats.GLD = UserList(i).Stats.GLD + UserList(RetoClan.lider2).flags.ApuestaRetoClan * 2
             End If

             Call SendUserORO(i)
             UserList(i).flags.enRetoC1 = False
             UserList(i).flags.enRetoC2 = False
             UserList(i).flags.RecRetoC = False
             UserList(i).flags.EnvRetoC = False
             UserList(i).flags.DesafGuerra = False 'RESETEAMOS FLAGS
          End If
      Next
      Clan1CUP = 0
      Clan2CUP = 0
      Clan1CUPRONDAS = 0
      Clan2CUPRONDAS = 0
      cOCUP = False
      UserList(RetoClan.lider2).flags.ApuestaRetoClan = 0
      RetoClan.lider1 = 0
      RetoClan.lider2 = 0 'RESETEAMOS VARIABLES
Else

  Call SendData(ToAll, 0, 0, "||El clan " & UserList(RetoClan.lider2).GuildInfo.GuildName & " [" & Clan1CUPRONDAS & "] Gana al clan " & UserList(RetoClan.lider1).GuildInfo.GuildName & " [" & Clan2CUPRONDAS & "] por desconexión de su lider." & FONTTYPE_FENIX)
      For i = 1 To LastUser
          If UserList(i).flags.enRetoC1 Or UserList(i).flags.enRetoC2 Then
             Call WarpUserChar(i, 1, 50, 50)
             If UserList(i).GuildInfo.GuildName = UserList(RetoClan.lider2).GuildInfo.GuildName Then
             UserList(i).Stats.GLD = UserList(i).Stats.GLD + UserList(RetoClan.lider2).flags.ApuestaRetoClan * 2
             End If

             Call SendUserORO(i)
             UserList(i).flags.enRetoC1 = False
             UserList(i).flags.enRetoC2 = False
             UserList(i).flags.RecRetoC = False
             UserList(i).flags.EnvRetoC = False
             UserList(i).flags.DesafGuerra = False 'RESETEAMOS FLAGS
          End If
      Next
      Clan1CUP = 0
      Clan2CUP = 0
      Clan1CUPRONDAS = 0
      Clan2CUPRONDAS = 0
      cOCUP = False
      UserList(RetoClan.lider2).flags.ApuestaRetoClan = 0
      RetoClan.lider1 = 0
      RetoClan.lider2 = 0 'RESETEAMOS VARIABLES
End If
End Sub

Sub GanaClanLider1(rdata As Integer)
If rdata = 0 Then
 Call SendData(ToAll, 0, 0, "||El clan " & UserList(RetoClan.lider1).GuildInfo.GuildName & " [" & Clan2CUPRONDAS & "] derrotó al clan " & UserList(RetoClan.lider2).GuildInfo.GuildName & " [" & Clan1CUPRONDAS & "] en un reto." & FONTTYPE_FENIX)
    Dim i As Integer
      For i = 1 To LastUser
          If UserList(i).flags.enRetoC1 Or UserList(i).flags.enRetoC2 Then
             Call WarpUserChar(i, 1, 50, 50)
             If UserList(i).GuildInfo.GuildName = UserList(RetoClan.lider1).GuildInfo.GuildName Then
             UserList(i).Stats.GLD = UserList(i).Stats.GLD + UserList(RetoClan.lider1).flags.ApuestaRetoClan * 2 'duplicamos xq al entrar le sacamos.
             UserList(i).Stats.Reputacion = UserList(i).Stats.Reputacion + 20
             Call SendUserREP(i)
             End If

             Call SendUserORO(i)
             UserList(i).flags.enRetoC1 = False
             UserList(i).flags.enRetoC2 = False
             UserList(i).flags.RecRetoC = False
             UserList(i).flags.EnvRetoC = False
             UserList(i).flags.DesafGuerra = False 'RESETEAMOS FLAGS
          End If
      Next
      Clan1CUP = 0
      Clan2CUP = 0
      Clan1CUPRONDAS = 0
      Clan2CUPRONDAS = 0
      cOCUP = False
      UserList(RetoClan.lider1).flags.ApuestaRetoClan = 0
      RetoClan.lider1 = 0
      RetoClan.lider2 = 0 'RESETEAMOS VARIABLES
Else
Call SendData(ToAll, 0, 0, "||El clan " & UserList(RetoClan.lider1).GuildInfo.GuildName & " [" & Clan2CUPRONDAS & "] Gana al clan " & UserList(RetoClan.lider2).GuildInfo.GuildName & " [" & Clan1CUPRONDAS & "] por desconexión de su lider." & FONTTYPE_FENIX)
      For i = 1 To LastUser
          If UserList(i).flags.enRetoC1 Or UserList(i).flags.enRetoC2 Then
             Call WarpUserChar(i, 1, 50, 50)
             If UserList(i).GuildInfo.GuildName = UserList(RetoClan.lider1).GuildInfo.GuildName Then
             UserList(i).Stats.GLD = UserList(i).Stats.GLD + UserList(RetoClan.lider1).flags.ApuestaRetoClan * 2 'duplicamos xq al entrar le sacamos.
             UserList(i).Stats.Reputacion = UserList(i).Stats.Reputacion + 20
             Call SendUserREP(i)
             End If

             Call SendUserORO(i)
             UserList(i).flags.enRetoC1 = False
             UserList(i).flags.enRetoC2 = False
             UserList(i).flags.RecRetoC = False
             UserList(i).flags.EnvRetoC = False
             UserList(i).flags.DesafGuerra = False 'RESETEAMOS FLAGS
          End If
      Next
      Clan1CUP = 0
      Clan2CUP = 0
      Clan1CUPRONDAS = 0
      Clan2CUPRONDAS = 0
      cOCUP = False
      UserList(RetoClan.lider1).flags.ApuestaRetoClan = 0
      RetoClan.lider1 = 0
      RetoClan.lider2 = 0 'RESETEAMOS VARIABLES

End If
End Sub

Sub CANCELARETOCLAN()
UserList(RetoClan.lider1).Stats.GLD = UserList(RetoClan.lider1).Stats.GLD + UserList(RetoClan.lider1).flags.ApuestaRetoClan
UserList(RetoClan.lider2).Stats.GLD = UserList(RetoClan.lider2).Stats.GLD + UserList(RetoClan.lider2).flags.ApuestaRetoClan
Call SendData(ToMap, 0, 1, "||Se cancelo el reto de clanes por falta de participantes." & FONTTYPE_FENIX)
  Dim i As Integer
      For i = 1 To LastUser
          If UserList(i).flags.enRetoC1 Or UserList(i).flags.enRetoC2 Then
             Call WarpUserChar(i, 1, 50, 50)
             UserList(i).flags.enRetoC1 = False
             UserList(i).flags.enRetoC2 = False
             UserList(i).flags.RecRetoC = False
             UserList(i).flags.EnvRetoC = False
             UserList(i).flags.DesafGuerra = False 'RESETEAMOS FLAGS
          End If
      Next
      Clan1CUP = 0
      Clan2CUP = 0
      Clan1CUPRONDAS = 0
      Clan2CUPRONDAS = 0
      cOCUP = False
      UserList(RetoClan.lider1).flags.ApuestaRetoClan = 0
      RetoClan.lider1 = 0
      RetoClan.lider2 = 0 'RESETEAMOS VARIABLES
End Sub
Sub EnviarDataMapa(rdata As String, Userindex As Integer)

    Dim NameMap As String
    Dim Info As String
    Dim i As Integer
    
    NameMap = GetVar(App.Path & "\Logs\NPCs.log", "Mapa" & rdata, "Name") & "@"
    
    For i = 1 To 20 'Maximo 20 NPcs'
    Info = Info & GetVar(App.Path & "\Logs\NPCs.log", "Mapa" & rdata, "Npc" & i) & "@"
    Next i
    
Call SendData(ToIndex, Userindex, 0, "BD" & NameMap & Info)
Info = 0
End Sub


Sub PENDIENTEDESACRI(Userindex As Integer)
If TieneObjetos(915, 15, Userindex) Then
Call QuitarObjetos(915, 15, Userindex)
SuperOroX.OBJIndex = 844
SuperOroX.Amount = 1
If Not MeterItemEnInventario(Userindex, SuperOroX) Then Call TirarItemAlPiso(UserList(Userindex).POS, SuperOroX)
Call SendData(ToIndex, Userindex, 0, "||!!! Fue un placer hacer negocios contigo ¡¡¡ VUELVE PRONTO." & FONTTYPE_TALK)
Exit Sub
Else
Call SendData(ToIndex, Userindex, 0, "||No puedo darte un sacri;RAZON: No tienes lo necesario." & FONTTYPE_TALK)
End If
End Sub

Sub AMULETOULTATUMBA(Userindex As Integer)
If TieneObjetos(914, 15, Userindex) Then
Call QuitarObjetos(914, 15, Userindex)
SuperOroX.OBJIndex = 870
SuperOroX.Amount = 1
If Not MeterItemEnInventario(Userindex, SuperOroX) Then Call TirarItemAlPiso(UserList(Userindex).POS, SuperOroX)
Call SendData(ToIndex, Userindex, 0, "||!!! Fue un placer hacer negocios contigo ¡¡¡ VUELVE PRONTO." & FONTTYPE_TALK)
Exit Sub
Else
Call SendData(ToIndex, Userindex, 0, "||No puedo darte un amuleto;RAZON: No tienes lo necesario." & FONTTYPE_TALK)
End If
End Sub


