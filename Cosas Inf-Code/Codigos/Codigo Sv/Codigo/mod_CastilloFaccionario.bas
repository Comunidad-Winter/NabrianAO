Attribute VB_Name = "mod_CastilloFaccionario"
 
'director del proyecto: #Esteban(Neliam)

'servidor basado en fénixao 1.0
'medios de contacto:
'Skype: dc.esteban
'E-mail: nabrianao@gmail.com
Option Explicit
Public Const NPCReyFaccion As Integer = 691 ' aca tienen q pner el npc del bichos.dat o como se llame
'Public Const DaPuntosHonor As Integer = 500
Public Const CastilloMapfaccN As Byte = 57
Public Const CastilloXfaccN As Byte = 88
Public Const CastilloYfaccN As Byte = 58

Public Const CastilloMapfaccCR As Byte = 57
Public Const CastilloXfaccCR As Byte = 51
Public Const CastilloYfaccCR As Byte = 92

Public Const CastilloMapfaccD As Byte = 57
Public Const CastilloXfaccD As Byte = 51
Public Const CastilloYfaccD As Byte = 23
Public GolpesReyFacc As Byte
Public HayReyFacc As Byte
 
Public Sub MuereReyFacc(ByVal Userindex As Integer)
    
    Dim loopc As Integer
    Dim FaccionCastillo As String
    FaccionCastillo = GetVar(App.Path & "\Dat\Castillitosfacc.Siam", "CASTILLOS", "FaccCastillo")


                If FaccionCastillo = 0 Then
                PuntosNeutrales = PuntosNeutrales + HonorAfacc
                Call WriteVar(IniPath & "\Dat\UsersOn.Siam", "NEU", "PUNTOS", PuntosNeutrales + HonorAfacc)
                ElseIf FaccionCastillo = 1 Then
                PuntosCiudadanos = PuntosCiudadanos + HonorAfacc
                Call WriteVar(IniPath & "\Dat\UsersOn.Siam", "CIU", "PUNTOS", PuntosCiudadanos + HonorAfacc)
                ElseIf FaccionCastillo = 2 Then
                PuntosCriminales = PuntosCriminales + HonorAfacc
                Call WriteVar(IniPath & "\Dat\UsersOn.Siam", "CRI", "PUNTOS", PuntosCriminales + HonorAfacc)
                End If

    

    If UserList(Userindex).Faccion.Bando = 0 Then
    Call SendData(ToAll, 0, 0, "||El cuartel fue dominado por el bando 'Neutral'" & FONTTYPE_GUILD)
      Call SendData(ToNeutral, 0, 0, "||Tu facción a dominado el cuartel, escribe /Castillos para ver cuantos puntos de facción llevan." & FONTTYPE_INFO)
    Call WriteVar(IniPath & "\Dat\Castillitosfacc.Siam", "CASTILLOS", "FaccCastillo", 0)
    ElseIf UserList(Userindex).Faccion.Bando = 1 Then
    Call SendData(ToAll, 0, 0, "||El cuartel fue dominado por el bando 'Ciudadano'" & FONTTYPE_GUILD)
      Call SendData(ToAlianza, 0, 0, "||Tu facción a dominado el cuartel, escribe /Castillos para ver cuantos puntos de facción llevan." & FONTTYPE_INFO)
    Call WriteVar(IniPath & "\Dat\Castillitosfacc.Siam", "CASTILLOS", "FaccCastillo", 1)
    ElseIf UserList(Userindex).Faccion.Bando = 2 Then
    Call SendData(ToAll, 0, 0, "||El cuartel fue dominado por el bando 'Criminal'" & FONTTYPE_GUILD)
      Call SendData(ToCaos, 0, 0, "||Tu facción a dominado el cuartel, escribe /Castillos para ver cuantos puntos de facción llevan." & FONTTYPE_INFO)
    Call WriteVar(IniPath & "\Dat\Castillitosfacc.Siam", "CASTILLOS", "FaccCastillo", 2)
    End If
  
    Call SendData(ToAll, 0, 0, "TW" & SND_CREACIONCLAN)
    HayReyFacc = 0
    HonorAfacc = 0
End Sub
 
Public Sub DarPremioCastillosFaccion()
HonorAfacc = HonorAfacc + 1

    Dim FaccionCastillo As String
    FaccionCastillo = GetVar(App.Path & "\Dat\Castillitosfacc.Siam", "CASTILLOS", "FaccCastillo")

Dim loopc As Integer
    For loopc = 1 To LastUser
        If UserList(loopc).Faccion.Bando Then
            If UserList(loopc).Faccion.Bando = FaccionCastillo Then
                If FaccionCastillo = 0 Then
         
                UserList(loopc).flags.Canje = UserList(loopc).flags.Canje + 1
         
                ElseIf FaccionCastillo = 1 Then
           
                UserList(loopc).flags.Canje = UserList(loopc).flags.Canje + 1

                ElseIf FaccionCastillo = 2 Then
      
                UserList(loopc).flags.Canje = UserList(loopc).flags.Canje + 1
                 End If
                 Call SendData(ToIndex, loopc, 0, "CAN" & UserList(loopc).flags.Canje)

                End If
            End If
    Next loopc
 Call SendData(ToAll, 0, 0, "||Cuartel> Premio al bando dominante entregados." & FONTTYPE_VERSION)
End Sub
