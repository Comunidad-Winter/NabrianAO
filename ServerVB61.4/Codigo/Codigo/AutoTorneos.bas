Attribute VB_Name = "AutoTorneos"
 
'director del proyecto: #Esteban(Neliam)

'servidor basado en fénixao 1.0
'medios de contacto:
'Skype: dc.esteban
'E-mail: nabrianao@gmail.com
Option Explicit

Public deathac As Boolean
Public deathesp As Boolean
 
Sub death_entra(ByVal Userindex As Integer)
On Error GoTo errordm:
       If UserList(Userindex).PartyIndex > 0 Then
        Call SendData(ToIndex, Userindex, 0, "||No puedes entrar si estas en party." & FONTTYPE_RETOS)
        Exit Sub
        End If

If deathac = False Then
 'Call SendData(ToIndex, 0, 0, "||No hay ningun deathmatch" & FONTTYPE_INFO)
 Exit Sub
 End If
If deathesp = False Then
'Call SendData(ToIndex, 0, 0, "||El deathmatch ya ha comenzado, te quedaste fuera!" & FONTTYPE_INFO)
Exit Sub
End If

If UserList(Userindex).Stats.GLD < InscripcionCosto Then
 Call SendData(ToIndex, Userindex, 0, "||No tienes suficiente oro para la inscripcion: " & PonerPuntos(InscripcionCosto) & " monedas de oro." & FONTTYPE_RETOS)
Exit Sub
End If

Cantidaddeath = Cantidaddeath + 1

Call SendData(ToAll, 0, 0, "||Deathmatch> Entra " & UserList(Userindex).Name & FONTTYPE_INFO)
UserList(Userindex).Stats.GLD = UserList(Userindex).Stats.GLD - InscripcionCosto
Call SendUserORO(Userindex)
OroDeLosInscriptos = OroDeLosInscriptos + InscripcionCosto
Call ponerbodydeath(Userindex)
Call WarpUserChar(Userindex, 120, 61, 41, True)

UserList(Userindex).flags.death = True

 If Cantidaddeath = cantdeath Then
  Call SendData(ToAll, 0, 0, "||Deathmatch> ¡Empieza el Deathmach!" & FONTTYPE_ORO)
     frmMain.TimerDeath.Enabled = True
       
     deathesp = False
     Call Deathauto_empieza
     End If
             
errordm:
End Sub
 
Sub death_comienza(ByVal wetas As Integer)
On Error GoTo errordm
If deathac = True Then
 Call SendData(ToIndex, 0, 0, "||ya hay un deathmatch!!" & FONTTYPE_INFO)
 Exit Sub
 End If
 
 If deathesp = True Then
 Call SendData(ToIndex, 0, 0, "||El deathmatch ya ha comenzado!" & FONTTYPE_INFO)
 Exit Sub
 End If
 
cantdeath = wetas

   Call SendData(ToAll, 0, 0, "||Deathmatch> Esta empezando un nuevo deathmatch para " & cantdeath & " participantes. Para participar envía /PARTICIPAR, precio de inscripción: " & PonerPuntos(InscripcionCosto) & " !!" & FONTTYPE_TALK)
        Call SendData(ToAll, 0, 0, "TW124")
        deathac = True
        deathesp = True

errordm:
End Sub
 
Sub death_muere(ByVal Userindex As Integer)
On Error GoTo errord

Call sacarbodydeath(Userindex)
Cantidaddeath = Cantidaddeath - 1

If Cantidaddeath = 1 Or MapInfo(16).NumUsers = 1 Then
terminodeat = True
Call SendData(ToAll, 0, 0, "||Deathmatch> Termina! El Ganador debe escribir /GANE para recibir su premio!" & FONTTYPE_TALK)
End If

If Cantidaddeath = 0 Then
   terminodeat = False
   deathesp = False
deathac = False

Cantidaddeath = 0
Call SendData(ToAll, 0, 0, "||Deathmatch> El Ganador se desconecto, ¡Se anulan los premios!" & FONTTYPE_TALK)
OroDeLosInscriptos = 0
InscripcionCosto = 100000
End If

errord:
End Sub
 
Sub Death_Cancela()
On Error GoTo errordm
If deathac = False And deathesp = False Then
Exit Sub
End If
    deathesp = False
    deathac = False

    Cantidaddeath = 0
    Call SendData(ToAll, 0, 0, "||Deathmatch> Cancelado por Game Master." & FONTTYPE_TALK)
    OroDeLosInscriptos = 0
InscripcionCosto = 100000
    Dim loopc As Integer
    For loopc = 1 To LastUser
        If UserList(loopc).POS.Map = 120 Then
            Call WarpUserChar(loopc, 1, 50, 50, True)
            Call sacarbodydeath(loopc)
            UserList(loopc).flags.death = False
            End If
      Next
errordm:
End Sub
 
Sub Deathauto_Cancela()
On Error GoTo errordm
If deathac = False And deathesp = False Then
Exit Sub
End If
    deathesp = False
    deathac = False
OroDeLosInscriptos = 0
InscripcionCosto = 100000
    Cantidaddeath = 0
    Call SendData(ToAll, 0, 0, "||Deathmatch> Cancelado por falta de participantes." & FONTTYPE_TALK)
    
    Dim loopc As Integer
    For loopc = 1 To LastUser
        If UserList(loopc).POS.Map = 120 Then
            Call WarpUserChar(loopc, 1, 50, 50, True)
            Call sacarbodydeath(loopc)
            UserList(loopc).flags.death = False
            End If
      Next
errordm:
End Sub
 
Sub Deathauto_empieza()
On Error GoTo errordm
            Dim loopc As Integer

    For loopc = 1 To LastUser
        If UserList(loopc).POS.Map = 120 Then
            Call WarpUserChar(loopc, 120, RandomNumber(54, 66), RandomNumber(59, 67), True)
            End If
      Next
        
errordm:
End Sub
 

 
