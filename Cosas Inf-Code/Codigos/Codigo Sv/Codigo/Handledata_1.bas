Attribute VB_Name = "Handledata_1"
 
'director del proyecto: #Esteban(Neliam)

'servidor basado en fénixao 1.0
'medios de contacto:
'Skype: dc.esteban
'E-mail: nabrianao@gmail.com
Public Sub HandleData1(Userindex As Integer, rdata As String, Procesado As Boolean)
Dim tInt As Integer, Tindex As Integer, X As Integer, y As Integer
Dim arg1 As String, arg2 As String, arg3 As String
Dim nPos As WorldPos
Dim tLong As Long
Dim ind

Procesado = True

Select Case UCase$(Left$(rdata, 1))

    Case "D¦"
        UserList(Userindex).flags.OnlineCastillo = 1
        Exit Sub
        
    Case "\"
        If UserList(Userindex).flags.Muerto = 1 Then
            Call SendData(ToIndex, Userindex, 0, "MU")
            Exit Sub
        End If
        
        rdata = Right$(rdata, Len(rdata) - 1)
        tName = ReadField(1, rdata, 32)
        Tindex = NameIndex(tName)
        
        If Tindex <> 0 Then
            If UserList(Tindex).flags.Muerto = 1 Then Exit Sub
    
            If Len(rdata) <> Len(tName) Then
                tMessage = Right$(rdata, Len(rdata) - (1 + Len(tName)))
            Else
                tMessage = " "
            End If
             
            If Not EnPantalla(UserList(Userindex).POS, UserList(Tindex).POS, 1) Then
                Call SendData(ToIndex, Userindex, 0, "2E")
                Exit Sub
            End If
             
            ind = UserList(Userindex).Char.CharIndex
             
            If InStr(tMessage, "°") Then Exit Sub
    
            If UserList(Tindex).flags.Privilegios > 0 And UserList(Userindex).flags.Privilegios = 0 Then
                Call SendData(ToIndex, Userindex, 0, "3E")
                Exit Sub
            End If
    
            Call SendData(ToIndex, Userindex, UserList(Userindex).POS.Map, "||" & vbCyan & "°" & tMessage & "°" & str(ind))
            Call SendData(ToIndex, Tindex, UserList(Userindex).POS.Map, "||" & vbCyan & "°" & tMessage & "°" & str(ind))
            Call SendData(ToGMArea, Userindex, UserList(Userindex).POS.Map, "||" & vbCyan & "°" & tMessage & "°" & str(ind))
            Exit Sub
        End If
        
        Call SendData(ToIndex, Userindex, 0, "3E")
        Exit Sub
            
    Case ";"
        Dim Modo As String
        
        rdata = Right$(rdata, Len(rdata) - 1)
        If Right$(rdata, Len(rdata) - 1) = " " Or Right$(rdata, Len(rdata) - 1) = "-" Then rdata = "1 "
        If Len(rdata) = 1 Then Exit Sub
        
        If val(Right$(rdata, Len(rdata) - 1)) > 0 Then
        'If UserList(UserIndex).flags.Trabajando Then Exit Sub
                'UserList(UserIndex).flags.IntentosCodigo = UserList(UserIndex).flags.IntentosCodigo + 1
                'If UserList(UserIndex).flags.IntentosCodigo >= 10 Then
                    'UserList(UserIndex).flags.CodigoTrabajo = 0
                    'UserList(UserIndex).flags.IntentosCodigo = 0
                    'Call SacarModoTrabajo(UserIndex)
                    'Call SendData(ToIndex, UserIndex, 0, "||Fuiste encarcelado por mandar demasiados códigos de trabajo incorrectos." & FONTTYPE_FIGHT)
                    'Call SendData(ToAdmins, 0, 0, "||" & UserList(UserIndex).Name & " fue encarcelado por mandar demasiados códigos incorrectos." & fonttype_Server)
                    'Call Encarcelar(UserIndex, 15)
                    'Exit Sub
                'Else: Call SendData(ToIndex, UserIndex, 0, "||Código incorrecto. Te quedan " & 10 - UserList(UserIndex).flags.IntentosCodigo & " intentos o serás encarcelado." & FONTTYPE_INFO)
                'End If
            End If
       
        
        Modo = Left$(rdata, 1)
 
        rdata = Replace(Right$(rdata, Len(rdata) - 1), "~", "-")
        
          If HayAdminsOnline Then
        If EsMalaPalabra(rdata) Then
            Call SendData(ToAdmins, 0, 0, "||" & UserList(Userindex).Name & "> " & rdata & FONTTYPE_FIGHTT)
              End If
              End If
        
    Select Case Modo
            
        Case 1, 4, 5, 8, 9
            
            If InStr(rdata, "°") Then Exit Sub
            
            If (Modo = 4 Or Modo = 5) And UserList(Userindex).flags.Muerto = 1 Then
                Call SendData(ToIndex, Userindex, 0, "MU")
                Exit Sub
            End If
            
            If UserList(Userindex).flags.Privilegios = 1 Or UserList(Userindex).flags.Privilegios = 2 Or UserList(Userindex).flags.Privilegios = 3 Or UserList(Userindex).flags.Privilegios = 4 Then Call LogGM(UserList(Userindex).Name, "Dijo: " & rdata, True)
            If InStr(1, rdata, Chr$(255)) Then rdata = Replace(rdata, Chr$(255), " ")
            
            ind = UserList(Userindex).Char.CharIndex
            Dim Color As Long
            Dim IndexSendData As Byte
            
            If Modo = 4 Then
                Color = vbRed
            
            ElseIf Modo = 5 Then
                Color = vbGreen
           ElseIf UserList(Userindex).flags.Privilegios = 1 Then
                Color = &HC000&
            ElseIf UserList(Userindex).flags.Privilegios = 2 Then
                Color = &HFF00&
            ElseIf UserList(Userindex).flags.Privilegios = 3 Then
                Color = &HFFFF&
            ElseIf UserList(Userindex).flags.Privilegios = 4 Then
                Color = &H80FF&
            ElseIf UserList(Userindex).flags.EsConseCaos And UserList(Userindex).Faccion.Bando = Caos Then 'Real
                Color = &H40C0&
            ElseIf UserList(Userindex).flags.EsConseReal And UserList(Userindex).Faccion.Bando = Real Then  'Caos
                Color = &HC0C000
                ElseIf UserList(Userindex).flags.EsConcilioNegro And UserList(Userindex).Faccion.Bando = Neutral Then  'Caos
                Color = &H808080
            ElseIf UserList(Userindex).flags.Quest And UserList(Userindex).Faccion.Bando <> Neutral Then
                If UserList(Userindex).Faccion.Bando = Real Then
                    Color = vbBlue
                Else: Color = vbRed
                End If
            ElseIf UserList(Userindex).flags.Muerto Then
                Color = vbYellow
            Else: Color = vbWhite
            End If
            
            If UserList(Userindex).flags.Privilegios > 0 Or UserList(Userindex).Clase = CLERIGO Then
                IndexSendData = ToPCArea
            ElseIf UserList(Userindex).flags.Muerto Then
                IndexSendData = ToMuertos
            Else
                IndexSendData = ToPCAreaVivos
            End If
            
            If UCase$(rdata) = "SACRIFICATE!" Then
                nPos = UserList(Userindex).POS
                Call HeadtoPos(UserList(Userindex).Char.Heading, nPos)
                Tindex = MapData(nPos.Map, nPos.X, nPos.y).Userindex
                If Tindex > 0 Then
                    If MapData(nPos.Map, nPos.X - 1, nPos.y).OBJInfo.OBJIndex = Cruz And _
                    MapData(nPos.Map, nPos.X + 1, nPos.y).OBJInfo.OBJIndex = Cruz And _
                    MapData(nPos.Map, nPos.X, nPos.y - 1).OBJInfo.OBJIndex = Cruz And _
                    MapData(nPos.Map, nPos.X, nPos.y + 1).OBJInfo.OBJIndex = Cruz Then
                        If UserList(Userindex).Stats.ELV < 40 Then
                            Call SendData(ToIndex, Userindex, 0, "||Debes ser nivel 40 o más para iniciar un sacrificio." & FONTTYPE_INFO)
                            Exit Sub
                        End If
                        If UserList(Tindex).Stats.MinHP < UserList(Tindex).Stats.MaxHP / 2 Then
                            Call SendData(ToIndex, Userindex, 0, "||Solo puedes comenzar a sacrificar a usuarios que tengan más de la mitad de sus HP." & FONTTYPE_INFO)
                            Exit Sub
                        End If
                        UserList(Tindex).flags.Sacrificando = 1
                        UserList(Tindex).flags.Sacrificador = Userindex
                        UserList(Userindex).flags.Sacrificado = Tindex
                        Call SendData(ToIndex, Userindex, 0, "||¡Comenzaste a sacrificar a " & UserList(Tindex).Name & "!" & FONTTYPE_INFO)
                        Call SendData(ToIndex, Tindex, 0, "||¡" & UserList(Userindex).Name & " comenzó a sacrificarte! ¡Huye!" & FONTTYPE_INFO)
                    End If
                End If
            End If
            
            If Modo = 5 Then rdata = "* " & rdata & " *"

            Call SendData(IndexSendData, Userindex, UserList(Userindex).POS.Map, "||" & Color & "°" & rdata & "°" & str(ind))
            Exit Sub
            
        Case 2
            
            If UserList(Userindex).flags.Muerto Then
                Call SendData(ToIndex, Userindex, 0, "MU")
                Exit Sub
            End If
            
            Tindex = UserList(Userindex).flags.Whispereando
            
            If Tindex Then
                If UserList(Tindex).flags.Muerto Then Exit Sub
    
                If Not EnPantalla(UserList(Userindex).POS, UserList(Tindex).POS, 1) Then
                    Call SendData(ToIndex, Userindex, 0, "2E")
                    Exit Sub
                End If
                
                ind = UserList(Userindex).Char.CharIndex
                
                If InStr(rdata, "°") Then Exit Sub

                If UserList(Tindex).flags.Privilegios > 0 And UserList(Tindex).flags.AdminInvisible Then
                    Call SendData(ToIndex, Userindex, 0, "3E")
                    Call SendData(ToIndex, Tindex, UserList(Userindex).POS.Map, "||" & vbBlue & "°" & rdata & "°" & str(ind))
                    Exit Sub
                End If
                
                If UserList(Userindex).flags.Privilegios = 1 Then Call LogGM(UserList(Userindex).Name, "Grito: " & rdata, True)
                
                If EnPantalla(UserList(Userindex).POS, UserList(Tindex).POS, 1) Then
                    Call SendData(ToIndex, Userindex, 0, "||" & vbCyan & "°" & rdata & "°" & str(ind))
                    Call SendData(ToIndex, Tindex, 0, "||" & vbCyan & "°" & rdata & "°" & str(ind))
                    Call SendData(ToGMArea, Userindex, UserList(Userindex).POS.Map, "||" & vbCyan & "°" & rdata & "°" & str(ind))
                Else
                    Call SendData(ToIndex, Userindex, 0, "{F")
                    UserList(Userindex).flags.Whispereando = 0
                End If
            End If
            
            Exit Sub
        
        Case 3
            If UserList(Userindex).flags.Muerto Then
                Call SendData(ToIndex, Userindex, 0, "MU")
                Exit Sub
            End If
        
            If Len(rdata) And Len(UserList(Userindex).GuildInfo.GuildName) > 0 Then Call SendData(ToGuildMembers, Userindex, 0, "||" & UserList(Userindex).Name & "> " & rdata & FONTTYPE_GUILD)
            Exit Sub
            
        Case 6
            If UserList(Userindex).flags.Party = 0 Then Exit Sub
            
            If Len(rdata) > 0 Then
                Call SendData(ToParty, Userindex, 0, "||" & UserList(Userindex).Name & ": " & rdata & FONTTYPE_PARTY)
            End If
            Exit Sub
                
        Case 7
            If UserList(Userindex).flags.Privilegios = 0 Then Exit Sub
            
            Call LogGM(UserList(Userindex).Name, "Mensaje a Gms:" & rdata, (UserList(Userindex).flags.Privilegios = 1))
            If Len(rdata) > 0 Then
                Call SendData(ToAdmins, 0, 0, "||" & UserList(Userindex).Name & "> " & rdata & "~255~255~255~0~1")
                Call SendData(ToConse, 0, 0, "||" & UserList(Userindex).Name & "> " & rdata & "~255~255~255~0~1")
                Call SendData(ToConci, 0, 0, "||" & UserList(Userindex).Name & "> " & rdata & "~255~255~255~0~1")
            End If
            
            Exit Sub
    
        End Select
        
    Case "M"
        Dim Mide As Double
        rdata = Right$(rdata, Len(rdata) - 1)
        
        If TiempoTranscurrido(UserList(Userindex).Counters.LastCaminar) < (IntervaloCaminar / 2) Then
        Call PasoIntervalo(Userindex, "-Caminar-")
        End If
        
        UserList(Userindex).Counters.LastCaminar = Timer
        
        If UserList(Userindex).flags.Trabajando Then

                Call SacarModoTrabajo(Userindex)

        End If
        
        If Not UserList(Userindex).flags.Descansar And Not UserList(Userindex).flags.Meditando _
           And UserList(Userindex).flags.Paralizado = 0 Then
            Call MoveUserChar(Userindex, val(rdata))
        ElseIf UserList(Userindex).flags.Descansar Then
            UserList(Userindex).flags.Descansar = False
            Call SendData(ToIndex, Userindex, 0, "DOK")
            Call SendData(ToIndex, Userindex, 0, "DN")
            Call MoveUserChar(Userindex, val(rdata))
        End If

        If UserList(Userindex).flags.Oculto Then
            If Not (UserList(Userindex).Clase = LADRON And UserList(Userindex).Recompensas(2) = 1) Then
                UserList(Userindex).flags.Oculto = 0
                UserList(Userindex).flags.Invisible = 0
                Call SendData(ToMap, 0, UserList(Userindex).POS.Map, ("V3" & DesteEncripTE("0," & UserList(Userindex).Char.CharIndex)))
                Call SendData(ToIndex, Userindex, 0, "V5")
            End If
        End If

        Exit Sub
End Select

Select Case UCase$(Left$(rdata, 2))

    Case "XE"
        rdata = Right$(rdata, Len(rdata) - 2)
        If UserList(Userindex).flags.Privilegios > 1 Then
        Call AbrirQuestRetos(rdata)
        End If
    Case "XX"
        rdata = Right$(rdata, Len(rdata) - 2)
        If UserList(Userindex).flags.Privilegios > 1 Then
        Call CancelarQuestRetos
        End If
    Case "XW"
        rdata = Right$(rdata, Len(rdata) - 2)
        If UserList(Userindex).flags.Privilegios > 1 Then
        
        If rdata = 1 Then
        ClaseTorneo = "MAGO"
        ClaseTorneovariable = 38
        ElseIf rdata = 2 Then
        ClaseTorneo = "BARDO"
        ClaseTorneovariable = 44
        ElseIf rdata = 3 Then
        ClaseTorneo = "CLERIGO"
        ClaseTorneovariable = 42
        ElseIf rdata = 4 Then
        ClaseTorneo = "PALADIN"
        ClaseTorneovariable = 41
        ElseIf rdata = 5 Then
        ClaseTorneo = "ASESINO"
        ClaseTorneovariable = 47
        ElseIf rdata = 6 Then
        ClaseTorneo = "GUERRERO"
        ClaseTorneovariable = 51
        ElseIf rdata = 7 Then
        ClaseTorneo = "ARQUERO"
        ClaseTorneovariable = 50
        ElseIf rdata = 8 Then
        ClaseTorneo = "CAZADOR"
        ClaseTorneovariable = 48
        ElseIf rdata = 9 Then
        ClaseTorneo = "NIGROMANTE"
        ClaseTorneovariable = 39
        ElseIf rdata = 10 Then
        ClaseTorneo = "DRUIDA"
        ClaseTorneovariable = 45
        Else
        ClaseTorneo = "TODAS"
        End If
        
        Call SendData(ToAdmins, 0, 0, "||Admin's: Clase permitida para automático: " & ClaseTorneo & FONTTYPE_VENENO)
        End If
        Exit Sub
    Case "ZI"
        rdata = Right$(rdata, Len(rdata) - 2)
        Dim Bait(1 To 2) As Byte
        Bait(1) = val(ReadField(1, rdata, 44))
        Bait(2) = val(ReadField(2, rdata, 44))
        
        Select Case Bait(2)
            Case 0
                Bait(2) = Bait(1) - 1
            Case 1
                Bait(2) = Bait(1) + 1
            Case 2
                Bait(2) = Bait(1) - 5
            Case 3
                Bait(2) = Bait(1) + 5
        End Select
        
        If Bait(2) > 0 And Bait(2) <= MAX_INVENTORY_SLOTS Then Call AcomodarItems(Userindex, Bait(1), Bait(2))
        
        Exit Sub
    Case "TI"
        If UserList(Userindex).flags.Navegando = 1 Or _
           UserList(Userindex).flags.Muerto = 1 Or _
                          UserList(Userindex).flags.Montado Then Exit Sub
           
        
        rdata = Right$(rdata, Len(rdata) - 2)
        arg1 = ReadField(1, rdata, 44)
        arg2 = ReadField(2, rdata, 44)
        
    If UserList(Userindex).flags.ComerCiandoNuevo = True Then
    If UserList(Userindex).flags.Comerciando = True Then 'ComercioNuevo
    Call CanceloComercio(Userindex)
    End If
    End If
        
        If arg2 < 0 Then Exit Sub
        If val(arg1) = FLAGORO Then
                If UserList(Userindex).Counters.TiroItemTiempo = 0 Then
                UserList(Userindex).Counters.TiroItemTiempo = 3
                Call TirarOro(val(arg2), Userindex)
                 Call SendUserORO(Userindex)
                Else
                Call SendData(ToIndex, Userindex, 0, "||Espera " & UserList(Userindex).Counters.TiroItemTiempo & " segundos para volver a tirar." & FONTTYPE_INFO)
                End If
        Else
            If val(arg1) <= MAX_INVENTORY_SLOTS And val(arg1) Then
                If UserList(Userindex).Invent.Object(val(arg1)).OBJIndex = 0 Then
                        Exit Sub
                End If
                
                If UserList(Userindex).Counters.TiroItemTiempo = 0 Then
                UserList(Userindex).Counters.TiroItemTiempo = 2
                Call DropObj(Userindex, val(arg1), val(arg2), UserList(Userindex).POS.Map, UserList(Userindex).POS.X, UserList(Userindex).POS.y)
                Else
                Call SendData(ToIndex, Userindex, 0, "||Espera " & UserList(Userindex).Counters.TiroItemTiempo & " segundos para volver a tirar." & FONTTYPE_INFO)
                End If
            Else
                Exit Sub
            End If
        End If
        Exit Sub
    Case "SF"
        rdata = Right$(rdata, Len(rdata) - 2)
        If Not PuedeFaccion(Userindex) Then Exit Sub
        If UserList(Userindex).POS.Map = 9 Or UserList(Userindex).POS.Map = 10 Or UserList(Userindex).POS.Map = 11 Or UserList(Userindex).POS.Map = 26 Or UserList(Userindex).POS.Map = 27 Or UserList(Userindex).POS.Map = 28 Then Exit Sub
        If UserList(Userindex).Faccion.BandoOriginal Then Exit Sub
        tInt = val(rdata)
        
        If tInt = Neutral Then
            If UserList(Userindex).Faccion.Bando <> Neutral Then
                Call SendData(ToIndex, Userindex, 0, "7&")
            Else: Call SendData(ToIndex, Userindex, 0, "0&")
            End If
            Exit Sub
        End If
        
        If UserList(Userindex).Faccion.Matados(tInt) > UserList(Userindex).Faccion.Matados(Enemigo(tInt)) Then
            Call SendData(ToIndex, Userindex, 0, Mensajes(tInt, 9))
            Exit Sub
        End If
        
        Call SendData(ToIndex, Userindex, 0, Mensajes(tInt, 10))
        UserList(Userindex).Faccion.BandoOriginal = tInt
        UserList(Userindex).Faccion.Bando = tInt
        UserList(Userindex).Faccion.Ataco(tInt) = 0
        If Not PuedeFaccion(Userindex) Then Call SendData(ToIndex, Userindex, 0, "SUFA0")
        
        Call UpdateUserChar(Userindex)
        
        Exit Sub
 Case "LH"
        If UserList(Userindex).flags.Muerto Then
            Call SendData(ToIndex, Userindex, 0, "MU")
            Exit Sub
        End If
        rdata = Right$(rdata, Len(rdata) - 2)
        
        UserList(Userindex).flags.Hechizo = val(CInt(ReadField(1, rdata, 32)))
        
        Exit Sub
    Case "WH"
        rdata = Right$(rdata, Len(rdata) - 2)
        arg1 = ReadField(1, rdata, 44)
        arg2 = ReadField(2, rdata, 44)
        If Not Numeric(arg1) Or Not Numeric(arg2) Then Exit Sub
        X = CInt(arg1)
        y = CInt(arg2)
        If Not InMapBounds(X, y) Then Exit Sub
        Call LookatTile(Userindex, UserList(Userindex).POS.Map, X, y)
        
        If UserList(Userindex).flags.TargetUser = Userindex Then
            Call SendData(ToIndex, Userindex, 0, "{C")
            Exit Sub
        End If
        
        If UserList(Userindex).flags.TargetUser Then
            UserList(Userindex).flags.Whispereando = UserList(Userindex).flags.TargetUser
            Call SendData(ToIndex, Userindex, 0, "{B" & UserList(UserList(Userindex).flags.Whispereando).Name)
        Else
            Call SendData(ToIndex, Userindex, 0, "{D")
        End If
        
        Exit Sub
    Case "LC"
        rdata = Right$(rdata, Len(rdata) - 2)
        arg1 = ReadField(1, rdata, 44)
        arg2 = ReadField(2, rdata, 44)
        If Not Numeric(arg1) Or Not Numeric(arg2) Then Exit Sub
        Dim POS As WorldPos
        POS.Map = UserList(Userindex).POS.Map
        POS.X = CInt(arg1)
        POS.y = CInt(arg2)
        If Not EnPantalla(UserList(Userindex).POS, POS, 1) Then Exit Sub
        Call LookatTile(Userindex, UserList(Userindex).POS.Map, POS.X, POS.y)
        Exit Sub
    Case "RC"
        rdata = Right$(rdata, Len(rdata) - 2)
        arg1 = ReadField(1, rdata, 44)
        arg2 = ReadField(2, rdata, 44)
        If Not Numeric(arg1) Or Not Numeric(arg2) Then Exit Sub
        X = CInt(arg1)
        y = CInt(arg2)
        Call Accion(Userindex, UserList(Userindex).POS.Map, X, y)
        Exit Sub
    Case "UK"
        If UserList(Userindex).flags.Muerto Then
            Call SendData(ToIndex, Userindex, 0, "MU")
            Exit Sub
        End If

        rdata = Right$(rdata, Len(rdata) - 2)
        Select Case val(rdata)
            Case Robar
                Call SendData(ToIndex, Userindex, 0, "T01" & Robar)
            Case Magia
                Call SendData(ToIndex, Userindex, 0, "T01" & Magia)
            Case Domar
                Call SendData(ToIndex, Userindex, 0, "T01" & Domar)
            Case Invitar
                Call SendData(ToIndex, Userindex, 0, "T01" & Invitar)
                
            Case Ocultarse
                
                If UserList(Userindex).flags.Navegando Then
                      Call SendData(ToIndex, Userindex, 0, "6E")
                      Exit Sub
                End If
                
                If UserList(Userindex).flags.Oculto Then
                      Call SendData(ToIndex, Userindex, 0, "7E")
                      Exit Sub
                End If
                
                Call DoOcultarse(Userindex)
        End Select
        Exit Sub
End Select

Select Case UCase$(rdata)
    Case "KLA"
        Call SendData(ToGuildMembers, Userindex, 0, "||" & UserList(Userindex).Name & "(" & UserList(Userindex).Stats.MinHP & "/" & UserList(Userindex).Stats.MaxHP & ") pide ayuda en " & UserList(Userindex).POS.Map & "," & UserList(Userindex).POS.X & "," & UserList(Userindex).POS.y & "" & FONTTYPE_FENIZ)
        Exit Sub
    Case "VSI" 'matute - encuesta votos positivos
        If encuestas.activa = 0 Then Exit Sub
        If UserList(Userindex).flags.votoencuesta = 1 Then Exit Sub
        encuestas.votosSI = encuestas.votosSI + 1
        Call SendData(ToIndex, Userindex, 0, "||Voto computado." & FONTTYPE_INFO)
        UserList(Userindex).flags.votoencuesta = 1
        Exit Sub
    Case "VNO" 'matute - encuesta votos negativos
        If encuestas.activa = 0 Then Exit Sub
        If UserList(Userindex).flags.votoencuesta = 1 Then Exit Sub
        encuestas.votosNP = encuestas.votosNP + 1
        Call SendData(ToIndex, Userindex, 0, "||Voto computado." & FONTTYPE_INFO)
        UserList(Userindex).flags.votoencuesta = 1
        Exit Sub
    Case "VSI" 'matute - encuesta votos positivos
        If encuestas.activa = 0 Then Exit Sub
        If UserList(Userindex).flags.votoencuesta = 1 Then Exit Sub
        encuestas.votosSI = encuestas.votosSI + 1
        Call SendData(ToIndex, Userindex, 0, "||Voto computado." & FONTTYPE_INFO)
        UserList(Userindex).flags.votoencuesta = 1
        Exit Sub
    Case "VNO" 'matute - encuesta votos negativos
        If encuestas.activa = 0 Then Exit Sub
        If UserList(Userindex).flags.votoencuesta = 1 Then Exit Sub
        encuestas.votosNP = encuestas.votosNP + 1
        Call SendData(ToIndex, Userindex, 0, "||Voto computado." & FONTTYPE_INFO)
        UserList(Userindex).flags.votoencuesta = 1
        Exit Sub
       
    Case "RPU"
        Call SendData(ToIndex, Userindex, 0, "PU" & DesteEncripTE(UserList(Userindex).POS.X & "," & UserList(Userindex).POS.y))
        Exit Sub
    Case "AT"
        If UserList(Userindex).flags.Muerto Then
            Call SendData(ToIndex, Userindex, 0, "MU")
            Exit Sub
        End If
      
    
        
        Call UsuarioAtaca(Userindex)
        
        Exit Sub
    Case "AG"
        If UserList(Userindex).flags.Muerto Then
                Call SendData(ToIndex, Userindex, 0, "MU")
                Exit Sub
        End If
        
       
    If UserList(Userindex).flags.ComerCiandoNuevo = True Then
    If UserList(Userindex).flags.Comerciando = True Then 'ComercioNuevo
    Call CanceloComercio(Userindex)
    End If
    End If
   

        Call GetObj(Userindex)
        Exit Sub
    Case "SEG"
        If UserList(Userindex).flags.Seguro Then
              Call SendData(ToIndex, Userindex, 0, "1O")
        Else
              Call SendData(ToIndex, Userindex, 0, "9K")
        End If
        UserList(Userindex).flags.Seguro = Not UserList(Userindex).flags.Seguro
        Exit Sub
    Case "ATRI"
        Call EnviarAtrib(Userindex)
        Exit Sub
    Case "FAMA"
        Call EnviarFama(Userindex)
        Call EnviarMiniSt(Userindex)
        Exit Sub
    Case "ESKI"
        Call EnviarSkills(Userindex)
        Exit Sub
    Case "PARSAL"
        Dim i As Integer
        If UserList(Userindex).flags.Party Then
            If Party(UserList(Userindex).PartyIndex).NroMiembros = 2 Then
                Call RomperParty(Userindex)
            Else: Call SacarDelParty(Userindex)
            End If
        Else
            Call SendData(ToIndex, Userindex, 0, "||No estás en party." & FONTTYPE_PARTY)
        End If
        Exit Sub
    Case "PARINF"
        Call EnviarIntegrantesParty(Userindex)
        Exit Sub
          
    Case "CDONAR"
             SX = "PRM" & UBound(PremiosListDonador) & ","
 
         For Premios = 1 To UBound(PremiosListDonador)
         SX = SX & PremiosListDonador(Premios).ObjName & ","
         Next Premios
 
         Call SendData(ToIndex, Userindex, 0, SX & UserList(Userindex).flags.CanjesDonador)
         Call SendData(ToIndex, Userindex, 0, "INF" & PremiosListDonador(val(rdata)).ObjRequiere & "," & PremiosListDonador(val(rdata)).ObjMaxAt & "," & PremiosListDonador(val(rdata)).ObjMinAt & "," & PremiosListDonador(val(rdata)).ObjMaxdef & "," & PremiosListDonador(val(rdata)).ObjMindef & "," & PremiosListDonador(val(rdata)).ObjMaxAtMag & "," & PremiosListDonador(val(rdata)).ObjMinAtMag & "," & PremiosListDonador(val(rdata)).ObjMaxDefMag & "," & PremiosListDonador(val(rdata)).ObjMinDefMag & "," & PremiosListDonador(val(rdata)).ObjDescripcion)
         'sistema de CANJEOS
         
    Exit Sub
    
     Case "FINCOM"
        
        UserList(Userindex).flags.Comerciando = False
        Call SendData(ToIndex, Userindex, 0, "FINCOMOK")
        Exit Sub
        
    Case "GLINFO"
        If UserList(Userindex).GuildInfo.EsGuildLeader Then
            If UserList(Userindex).flags.InfoClanEstatica Then
            Call SendData(ToIndex, Userindex, 0, "GINFIG")
            Else
                Call SendGuildLeaderInfo(Userindex)
            End If
        ElseIf Len(UserList(Userindex).GuildInfo.GuildName) > 0 Then
            If UserList(Userindex).flags.InfoClanEstatica Then
                Call SendData(ToIndex, Userindex, 0, "GINFII")
            Else
                Call SendGuildsStats(Userindex)
            End If
        Else
            If UserList(Userindex).flags.InfoClanEstatica Then
                Call SendData(ToIndex, Userindex, 0, "GINFIJ")
            Else: Call SendGuildsList(Userindex)
            End If
        End If
        
        Exit Sub

     Case "IQUEST"
            tStr = SendQuestList(Userindex)
            Call SendData(ToIndex, Userindex, 0, "QTL" & SendQuestList(Userindex))
        Exit Sub

End Select

 Select Case UCase$(Left$(rdata, 2))
    Case "(A"
        If PuedeDestrabarse(Userindex) Then
            Call ClosestLegalPos(UserList(Userindex).POS, nPos)
            If InMapBounds(nPos.X, nPos.y) Then Call WarpUserChar(Userindex, nPos.Map, nPos.X, nPos.y, True)
        End If
        
        Exit Sub
    Case "GM"
        rdata = Right$(rdata, Len(rdata) - 2)
        Call SendData(ToAdmins, 0, 0, "||Soporte " & "(" & ReadField(2, rdata, Asc("¬")) & ") >" & UserList(Userindex).Name & " dice: " & ReadField(3, rdata, Asc("¬")) & FONTTYPE_FENIX)
        Exit Sub
        
    End Select
        
 Select Case UCase$(Left$(rdata, 3))
    Case "GZX"
        rdata = Right$(rdata, Len(rdata) - 3)
        
        If IpdelServidor = Encripta(rdata, False) Then
        'Call SendData(ToAdmins, 0, 0, "||IPCORRECTA" & FONTTYPE_FIGHTT)
        Else
        Call LogginIP(UserList(Userindex).Name, " " & UserList(Userindex).Name & " Logeo con IP INCORRECTA.", False)
        Call SendData(ToAdmins, 0, 0, "||" & UserList(Userindex).Name & " psxl chitero." & FONTTYPE_FIGHTT)
        End If
        Exit Sub
        
    Case "FRF"
        rdata = Right$(rdata, Len(rdata) - 3)
        For i = 1 To 10
            If UserList(Userindex).flags.Espiado(i) > 0 Then
                If UserList(UserList(Userindex).flags.Espiado(i)).flags.Privilegios > 1 Then Call SendData(ToIndex, UserList(Userindex).flags.Espiado(i), 0, "{{" & UserList(Userindex).Name & "," & rdata)
            End If
        Next
        Exit Sub
   Case "(SD"
        rdata = Right$(rdata, Len(rdata) - 3)
        rdata = Encripta(rdata, False)
        Call DataFalsaNo(Userindex, CInt(ReadField(2, rdata, 32)))

        If TiempoTranscurrido(UserList(Userindex).Counters.LastPocionesU) < (IntervaloPocionesSEGURIDAD / 2) Then
        Call PasoIntervalo(Userindex, "USAR(U)")
        End If
        
        If TiempoTranscurrido(UserList(Userindex).Counters.LastPocionesU) < (IntervaloPociones / 2) Then Exit Sub
        
        UserList(Userindex).Counters.LastPocionesU = Timer
        If val(CInt(ReadField(1, rdata, 32))) <= MAX_INVENTORY_SLOTS And val(CInt(ReadField(1, rdata, 32))) Then
        If UserList(Userindex).Invent.Object(val(CInt(ReadField(1, rdata, 32)))).OBJIndex = 0 Then Exit Sub
        Else
            Exit Sub
        End If
        Call UseInvItem(Userindex, val(CInt(ReadField(1, rdata, 32))), 0)
        
        Exit Sub
    Case "(SX"
        rdata = Right$(rdata, Len(rdata) - 3)
        rdata = Encripta(rdata, False)
        Call DataFalsaNo(Userindex, CInt(ReadField(2, rdata, 32)))
          
        If TiempoTranscurrido(UserList(Userindex).Counters.LastPocionesClick) < (IntervaloPocionesSEGURIDAD / 2) Then
        Call PasoIntervalo(Userindex, "USAR(Click)")
        End If
        
        If TiempoTranscurrido(UserList(Userindex).Counters.LastPocionesClick) < (IntervaloPociones / 2) Then Exit Sub

        UserList(Userindex).Counters.LastPocionesClick = Timer
        If val(CInt(ReadField(1, rdata, 32))) <= MAX_INVENTORY_SLOTS And val(CInt(ReadField(1, rdata, 32))) Then
            If UserList(Userindex).Invent.Object(val(CInt(ReadField(1, rdata, 32)))).OBJIndex = 0 Then Exit Sub
        Else
            Exit Sub
        End If
        Call UseInvItem(Userindex, val(CInt(ReadField(1, rdata, 32))), 1)
        
        Exit Sub
    Case "CNS"
        Dim Arg5 As Integer
        rdata = Right$(rdata, Len(rdata) - 3)
        
        X = CInt(ReadField(1, rdata, 32))
        Arg5 = CInt(ReadField(2, rdata, 32))
        If Arg5 < 1 Then Exit Sub
        If X < 1 Then Exit Sub
        If ObjData(X).SkHerreria = 0 Then Exit Sub
        Call HerreroConstruirItem(Userindex, X, val(Arg5))
        Exit Sub
        
    Case "CNC"
        rdata = Right$(rdata, Len(rdata) - 3)
        
        X = CInt(ReadField(1, rdata, 32))
        arg1 = CInt(ReadField(2, rdata, 32))
        If arg1 < 1 Then Exit Sub
        If X < 1 Or ObjData(X).SkCarpinteria = 0 Then Exit Sub
        Call CarpinteroConstruirItem(Userindex, X, val(arg1))
        Exit Sub
    Case "SCR"
        rdata = Right$(rdata, Len(rdata) - 3)
        
        X = CInt(ReadField(1, rdata, 32))
        arg1 = CInt(ReadField(2, rdata, 32))
        If X < 1 Or ObjData(X).SkSastreria = 0 Then Exit Sub
        Call SastreConstruirItem(Userindex, X, val(arg1))
        Exit Sub
    
Case "WLC"
        rdata = Right$(rdata, Len(rdata) - 3)
        
        arg1 = ReadField(1, rdata, 44)
        arg2 = ReadField(2, rdata, 44)
        arg3 = ReadField(3, rdata, 44)
        If Len(arg3) = 0 Or Len(arg2) = 0 Or Len(arg1) = 0 Then Exit Sub
        If Not Numeric(arg1) Or Not Numeric(arg2) Or Not Numeric(arg3) Then Exit Sub
        
        POS.Map = UserList(Userindex).POS.Map
        POS.X = CInt(arg1)
        POS.y = CInt(arg2)
        tLong = CInt(arg3)
        
        If UserList(Userindex).flags.Muerto = 1 Or _
           UserList(Userindex).flags.Descansar Or _
           UserList(Userindex).flags.Meditando Or _
           Not InMapBounds(POS.X, POS.y) Then Exit Sub
        
        If Not EnPantalla(UserList(Userindex).POS, POS, 1) Then
            Call SendData(ToIndex, Userindex, 0, "PU" & DesteEncripTE(UserList(Userindex).POS.X & "," & UserList(Userindex).POS.y))
            Exit Sub
        End If
        
        Select Case tLong
        
        Case Proyectiles
            Dim TU As Integer, tN As Integer
            
            If UserList(Userindex).Invent.WeaponEqpObjIndex = 0 Or _
            UserList(Userindex).Invent.MunicionEqpObjIndex = 0 Then Exit Sub
            
            If UserList(Userindex).Invent.WeaponEqpSlot < 1 Or UserList(Userindex).Invent.WeaponEqpSlot > MAX_INVENTORY_SLOTS Or _
            UserList(Userindex).Invent.MunicionEqpSlot < 1 Or UserList(Userindex).Invent.MunicionEqpSlot > MAX_INVENTORY_SLOTS Or _
            ObjData(UserList(Userindex).Invent.MunicionEqpObjIndex).ObjType <> OBJTYPE_FLECHAS Or _
            UserList(Userindex).Invent.Object(UserList(Userindex).Invent.MunicionEqpSlot).Amount < 1 Or _
            ObjData(UserList(Userindex).Invent.WeaponEqpObjIndex).proyectil <> 1 Then Exit Sub
            
            If TiempoTranscurrido(UserList(Userindex).Counters.LastFlecha) < IntervaloUserFlechas Then Exit Sub
            
            UserList(Userindex).Counters.LastFlecha = Timer
            Call SendData(ToIndex, Userindex, 0, "LF")
            

            If TiempoTranscurrido(UserList(Userindex).Counters.LastHechizo) < IntervaloUserPuedeHechiGolpe Then Exit Sub
            If TiempoTranscurrido(UserList(Userindex).Counters.LastGolpe) < IntervaloUserPuedeAtacar Then Exit Sub
            

            
            
            If UserList(Userindex).Stats.MinSta >= 10 Then
                 Call QuitarSta(Userindex, RandomNumber(1, 10))
            Else
                 Call SendData(ToIndex, Userindex, 0, "9E")
                 Exit Sub
            End If
             
            Call LookatTile(Userindex, UserList(Userindex).POS.Map, val(arg1), val(arg2))
            
            TU = UserList(Userindex).flags.TargetUser
            tN = UserList(Userindex).flags.TargetNpc
                            
            If TU = Userindex Then
                Call SendData(ToIndex, Userindex, 0, "3N")
                Exit Sub
            End If

            Call QuitarUnItem(Userindex, UserList(Userindex).Invent.MunicionEqpSlot)
            
            If UserList(Userindex).Invent.MunicionEqpSlot Then
                UserList(Userindex).Invent.Object(UserList(Userindex).Invent.MunicionEqpSlot).Equipped = 1
                Call UpdateUserInv(False, Userindex, UserList(Userindex).Invent.MunicionEqpSlot)
            End If
            
            If tN Then
                If Npclist(tN).Attackable Then Call UsuarioAtacaNpc(Userindex, tN)
            ElseIf TU Then
                If TU <> Userindex Then
                    Call UsuarioAtacaUsuario(Userindex, TU)
                    SendUserHP TU
                End If
            Else
                Call SendData(ToIndex, Userindex, 0, "||Target invalido." & FONTTYPE_INFO)
            End If
            
            
                
                
                
                
        Case Invitar
            
            If UserList(Userindex).POS.Map = 7 Or UserList(Userindex).POS.Map = 8 Then Exit Sub
            If UserList(Userindex).POS.Map = 107 Or UserList(Userindex).POS.Map = 99 Or UserList(Userindex).POS.Map = 120 Then
            Call SendData(ToIndex, Userindex, 0, "||No puedes enviar party estando en un torneo automático." & FONTTYPE_PARTY)
            Exit Sub
            End If
            
            Call LookatTile(Userindex, UserList(Userindex).POS.Map, POS.X, POS.y)
            
            If UserList(Userindex).flags.TargetUser = 0 Then
                Call SendData(ToIndex, Userindex, 0, "||No hay nadie a quien invitar." & FONTTYPE_PARTY)
                Exit Sub
            End If
            
            If UserList(Userindex).flags.Privilegios > 0 Or UserList(UserList(Userindex).flags.TargetUser).flags.Privilegios > 0 Then Exit Sub

            Call DoInvitar(Userindex, UserList(Userindex).flags.TargetUser)
            
        Case Magia


            If UserList(Userindex).flags.Privilegios = 1 Then Exit Sub
            
            Call LookatTile(Userindex, UserList(Userindex).POS.Map, POS.X, POS.y)
            
            If UserList(Userindex).flags.Hechizo Then
                Call LanzarHechizo(UserList(Userindex).flags.Hechizo, Userindex)
                UserList(Userindex).flags.Hechizo = 0
            Else
                Call SendData(ToIndex, Userindex, 0, "4N")
            End If
    

            
        Case Robar
               If TiempoTranscurrido(UserList(Userindex).Counters.LastTrabajo) < 1 Then Exit Sub
               If MapInfo(UserList(Userindex).POS.Map).Pk Or (UserList(Userindex).Clase = LADRON) Then
               
                    
                    Call LookatTile(Userindex, UserList(Userindex).POS.Map, POS.X, POS.y)

                    If UserList(Userindex).flags.TargetUser > 0 And UserList(Userindex).flags.TargetUser <> Userindex Then
                       If UserList(UserList(Userindex).flags.TargetUser).flags.Muerto = 0 Then
                            nPos.Map = UserList(Userindex).POS.Map
                            nPos.X = POS.X
                            nPos.y = POS.y
                            
                            If Distancia(nPos, UserList(Userindex).POS) > 4 Or (Not (UserList(Userindex).Clase = LADRON And UserList(Userindex).Recompensas(3) = 1) And Distancia(nPos, UserList(Userindex).POS) > 2) Then
                                Call SendData(ToIndex, Userindex, 0, "DL")
                                Exit Sub
                            End If

                            Call DoRobar(Userindex, UserList(Userindex).flags.TargetUser)
                       End If
                    Else
                        Call SendData(ToIndex, Userindex, 0, "4S")
                    End If
                Else
                    Call SendData(ToIndex, Userindex, 0, "5S")
                End If
                
        Case Domar
          
          
          
          Dim CI As Integer
          
          Call LookatTile(Userindex, UserList(Userindex).POS.Map, POS.X, POS.y)
          CI = UserList(Userindex).flags.TargetNpc
          
          If CI Then
                   If Npclist(CI).flags.Domable Then
                        nPos.Map = UserList(Userindex).POS.Map
                        nPos.X = POS.X
                        nPos.y = POS.y
                        If Distancia(nPos, Npclist(UserList(Userindex).flags.TargetNpc).POS) > 2 Then
                              Call SendData(ToIndex, Userindex, 0, "DL")
                              Exit Sub
                        End If
                        If Npclist(CI).flags.AttackedBy Then
                              Call SendData(ToIndex, Userindex, 0, "7S")
                              Exit Sub
                        End If
                        Call DoDomar(Userindex, CI)
                    Else
                        Call SendData(ToIndex, Userindex, 0, "8S")
                    End If
          Else
                 Call SendData(ToIndex, Userindex, 0, "9S")
          End If
          
        Case FundirMetal
            Call LookatTile(Userindex, UserList(Userindex).POS.Map, POS.X, POS.y)
            
            If UserList(Userindex).flags.TargetObj Then
                If ObjData(UserList(Userindex).flags.TargetObj).ObjType = OBJTYPE_FRAGUA Then
                    Call FundirMineral(Userindex)
                Else
                    Call SendData(ToIndex, Userindex, 0, "8N")
                End If
            Else
                Call SendData(ToIndex, Userindex, 0, "8N")
            End If
            
        Case Herreria
            Call LookatTile(Userindex, UserList(Userindex).POS.Map, POS.X, POS.y)
            
            If UserList(Userindex).flags.TargetObj Then
                If ObjData(UserList(Userindex).flags.TargetObj).ObjType = OBJTYPE_YUNQUE Then
                    Call EnviarArmasConstruibles(Userindex)
                    Call EnviarArmadurasConstruibles(Userindex)
                    Call EnviarEscudosConstruibles(Userindex)
                    Call EnviarCascosConstruibles(Userindex)
                    Call SendData(ToIndex, Userindex, 0, "SFH")
                    UserList(Userindex).flags.EnviarHerreria = 1
                Else
                    Call SendData(ToIndex, Userindex, 0, "2T")
                End If
            Else
                Call SendData(ToIndex, Userindex, 0, "2T")
            End If
        Case Else

            If UserList(Userindex).flags.Trabajando = 0 Then
                Dim TrabajoPos As WorldPos
                TrabajoPos.Map = UserList(Userindex).POS.Map
                TrabajoPos.X = POS.X
                TrabajoPos.y = POS.y
                Call InicioTrabajo(Userindex, tLong, TrabajoPos)
            End If
            Exit Sub
            
        End Select
        
        UserList(Userindex).Counters.LastTrabajo = Timer
        Exit Sub
    Case "REL"
        If UserList(Userindex).flags.Muerto Then Exit Sub
        rdata = Right$(rdata, Len(rdata) - 3)
        Call RecibirRecompensa(Userindex, val(rdata))
        Exit Sub
    Case "CIG"
        rdata = Right$(rdata, Len(rdata) - 3)
        X = Guilds.Count
        
        If CreateGuild(UserList(Userindex).Name, Userindex, rdata) Then
            If X = 1 Then
                Call SendData(ToIndex, Userindex, 0, "3T")
            Else
                Call SendData(ToIndex, Userindex, 0, "4T" & X)
            End If
            Call UpdateUserChar(Userindex)
            
        End If
        
        Exit Sub
    Case "RSB"
        If UserList(Userindex).flags.Muerto Then Exit Sub
        rdata = Right$(rdata, Len(rdata) - 3)
        Call RecibirSubclase(CByte(rdata), Userindex)
        Exit Sub
End Select

Select Case UCase$(Left$(rdata, 4))

Case "INFD" 'Aceptquest
            Dim ttx As String
            Dim numerokest As Byte
            rdata = Right$(rdata, Len(rdata) - 4)
            ttx = ReadField(1, rdata, 44)
           
            numerokest = val(GetVar(DatPath & "Quests.dat", "Nombres", "" & ttx & ""))
           
            Dim TipoQ As Byte
            Dim NUR As Byte
            Dim nnnpc As String
            Dim roro As Byte
            Dim rpts As Byte
            Dim namesin As String
           
                'TipoQ = GetVar(DatPath & "Quests.dat", "Quest" & numerokest, "Tipo")
                'nnnpc = GetVar(DatPath & "Quests.dat", "Quest" & numerokest, "BuscaNPC")
             
                'rpts = GetVar(DatPath & "Quests.dat", "Quest" & numerokest, "Premio")
                'namesin = GetVar(DatPath & "Quests.dat", "Quest" & numerokest, "Name")
           
                'If TipoQ = 1 Then
                'NUR = GetVar(DatPath & "Quests.dat", "Quest" & numerokest, "Cant")
                'Else
                'NUR = GetVar(DatPath & "Quests.dat", "Quest" & numerokest, "Usuarios")
                'End If
               
            If 1 = GetVar(DatPath & "Quests.dat", "Quest" & numerokest, "Tipo") Then
            Call SendData(ToIndex, Userindex, 0, "MQS" & GetVar(DatPath & "Quests.dat", "Quest" & numerokest, "Tipo") & "," & GetVar(DatPath & "Quests.dat", "Quest" & numerokest, "Cant") & "," & GetVar(DatPath & "Quests.dat", "Quest" & numerokest, "BuscaNPC") & "," & GetVar(DatPath & "Quests.dat", "Quest" & numerokest, "Premio") & "," & GetVar(DatPath & "Quests.dat", "Quest" & numerokest, "Name") & "," & numerokest)
            Else
            Call SendData(ToIndex, Userindex, 0, "MQS" & GetVar(DatPath & "Quests.dat", "Quest" & numerokest, "Tipo") & "," & GetVar(DatPath & "Quests.dat", "Quest" & numerokest, "Usuarios") & "," & GetVar(DatPath & "Quests.dat", "Quest" & numerokest, "BuscaNPC") & "," & GetVar(DatPath & "Quests.dat", "Quest" & numerokest, "Premio") & "," & GetVar(DatPath & "Quests.dat", "Quest" & numerokest, "Name"))
            End If
           
        Exit Sub
   
        Case "ACQT"
        Dim numakest As Byte
        rdata = Right$(rdata, Len(rdata) - 4)
        numakest = ReadField(1, rdata, 44)
       
            If UserList(Userindex).flags.Questeando = 1 Then
                Call SendData(ToIndex, Userindex, 0, "||Ya estàs haciendo una quest." & FONTTYPE_INFO)
                Exit Sub
            End If
                   
            UserList(Userindex).flags.Questeando = 0
            UserList(Userindex).flags.MuereQuest = 0
            Call SendData(ToIndex, Userindex, 0, "||Has aceptado la quest. para ver cuantos Npc's llevas matado tipeá /INFOQUEST." & FONTTYPE_ORO)
            UserList(Userindex).flags.Questeando = 1
            UserList(Userindex).flags.UserNumQuest = val(numakest)
            UserList(Userindex).flags.MuereQuest = 0
        Exit Sub
        
   Case "PPCC"
            Dim caption As String
            rdata = Right$(rdata, Len(rdata) - 4)
            caption = ReadField(1, rdata, 44)
            Tindex = ReadField(2, rdata, 44)
            Call SendData(ToIndex, Tindex, 0, "PCCC" & caption & "," & UserList(Userindex).Name)
            Exit Sub
    Case "PRCS"
        rdata = Right$(rdata, Len(rdata) - 4)
        Call SendData(ToIndex, UserList(Userindex).flags.EsperandoLista, 0, "PRAP" & rdata)
        If rdata = "@*|" Then UserList(Userindex).flags.EsperandoLista = 0
        Exit Sub
    Case "PASS"
        rdata = Right$(rdata, Len(rdata) - 4)
        arg1 = ReadField(1, rdata, 44)
        arg2 = ReadField(2, rdata, 44)
        
        If UserList(Userindex).PassWord <> arg1 Then
            Call SendData(ToIndex, Userindex, 0, "||El password viejo provisto no es correcto." & FONTTYPE_INFO)
            Exit Sub
        End If
        
        UserList(Userindex).PassWord = arg2
        Call SendData(ToIndex, Userindex, 0, "3V")
        
        Exit Sub
Case "%PR%"
rdata = Right$(rdata, Len(rdata) - 4)
Tindex = ReadField(1, rdata, 32)
rdata = ReadField(2, rdata, 32)
Call SendData(ToIndex, Tindex, 0, "||Procesos de " & UCase$(UserList(Userindex).Name) & ":" & FONTTYPE_VENENO)
Call SendData(ToIndex, Tindex, 0, "||" & rdata & FONTTYPE_INFO)
Exit Sub
Case "PCGF"
Dim proceso As String
rdata = Right$(rdata, Len(rdata) - 4)
proceso = ReadField(1, rdata, 44)
Tindex = ReadField(2, rdata, 44)
Call SendData(ToIndex, Tindex, 0, "PCGN" & proceso & "," & UserList(Userindex).Name)
Exit Sub

Case "DRAG"
            rdata = Right$(rdata, Len(rdata) - 4)
            ObjSlot1 = ReadField(1, rdata, 44)
            ObjSlot2 = ReadField(2, rdata, 44)
            Call DragObjects(Userindex, ObjSlot1, ObjSlot2)
    Exit Sub
    
    Case "INFS"
        rdata = Right$(rdata, Len(rdata) - 4)
        If val(rdata) > 0 And val(rdata) < MAXUSERHECHIZOS + 1 Then
            Dim H As Integer
            H = UserList(Userindex).Stats.UserHechizos(val(rdata))
            If H > 0 And H < NumeroHechizos + 1 Then
                Call SendData(ToIndex, Userindex, 0, "7T" & Hechizos(H).Nombre & "¬" & Hechizos(H).Desc & "¬" & Hechizos(H).MinSkill & "¬" & ManaHechizo(Userindex, H) & "¬" & Hechizos(H).StaRequerido)
            End If
        Else
            Call SendData(ToIndex, Userindex, 0, "5T")
        End If
        Exit Sub
   Case "EQUI"
            If UserList(Userindex).flags.Muerto Then
                Call SendData(ToIndex, Userindex, 0, "MU")
                Exit Sub
            End If
            rdata = Right$(rdata, Len(rdata) - 4)
            If val(rdata) <= MAX_INVENTORY_SLOTS And val(rdata) Then
                 If UserList(Userindex).Invent.Object(val(rdata)).OBJIndex = 0 Then Exit Sub
            Else
                Exit Sub
            End If
            Call EquiparInvItem(Userindex, val(rdata))
            Exit Sub

    Case "CHEA"
        rdata = Right$(rdata, Len(rdata) - 4)

        If val(rdata) > 0 And val(rdata) < 5 Then
            UserList(Userindex).Char.Heading = rdata
            Call ChangeUserChar(ToPCAreaG, Userindex, UserList(Userindex).POS.Map, Userindex, UserList(Userindex).Char.Body, UserList(Userindex).Char.Head, UserList(Userindex).Char.Heading, UserList(Userindex).Char.WeaponAnim, UserList(Userindex).Char.ShieldAnim, UserList(Userindex).Char.CascoAnim)
        End If
        Exit Sub

    Case "SKSE"
        Dim sumatoria As Integer
        Dim incremento As Integer
        rdata = Right$(rdata, Len(rdata) - 4)
        
        
        
        For i = 1 To NUMSKILLS
            incremento = val(ReadField(i, rdata, 44))
            
            If incremento < 0 Then
                
                Call LogHackAttemp(UserList(Userindex).Name & " IP:" & UserList(Userindex).ip & " trato de hackear los skills.")
                UserList(Userindex).Stats.SkillPts = 0
                Call CloseSocket(Userindex)
                Exit Sub
            End If
            
            sumatoria = sumatoria + incremento
        Next
        
        If sumatoria > UserList(Userindex).Stats.SkillPts Then
            
            
            Call LogHackAttemp(UserList(Userindex).Name & " IP:" & UserList(Userindex).ip & " trato de hackear los skills.")
            Call CloseSocket(Userindex)
            Exit Sub
        End If
        
        
        For i = 1 To NUMSKILLS
            incremento = val(ReadField(i, rdata, 44))
            UserList(Userindex).Stats.SkillPts = UserList(Userindex).Stats.SkillPts - incremento
            UserList(Userindex).Stats.UserSkills(i) = UserList(Userindex).Stats.UserSkills(i) + incremento
            If UserList(Userindex).Stats.UserSkills(i) > 100 Then UserList(Userindex).Stats.UserSkills(i) = 100
        Next
        Exit Sub
    Case "ENTR"
        
        If UserList(Userindex).flags.TargetNpc = 0 Then Exit Sub
        
        If Npclist(UserList(Userindex).flags.TargetNpc).NPCtype <> NPCTYPE_ENTRENADOR Then Exit Sub
        
        rdata = Right$(rdata, Len(rdata) - 4)
        
        If Npclist(UserList(Userindex).flags.TargetNpc).Mascotas < MAXMASCOTASENTRENADOR Then
            If val(rdata) > 0 And val(rdata) < Npclist(UserList(Userindex).flags.TargetNpc).NroCriaturas + 1 Then
                Dim SpawnedNpc As Integer
                SpawnedNpc = SpawnNpc(Npclist(UserList(Userindex).flags.TargetNpc).Criaturas(val(rdata)).NpcIndex, Npclist(UserList(Userindex).flags.TargetNpc).POS, True, False)
                If SpawnedNpc <= MAXNPCS Then
                    Npclist(SpawnedNpc).MaestroNpc = UserList(Userindex).flags.TargetNpc
                    Npclist(UserList(Userindex).flags.TargetNpc).Mascotas = Npclist(UserList(Userindex).flags.TargetNpc).Mascotas + 1
                    
                End If
            End If
        Else
            Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "3Q" & vbWhite & "°" & "No puedo traer más criaturas, mata las existentes!" & "°" & str(Npclist(UserList(Userindex).flags.TargetNpc).Char.CharIndex))
        End If
        
        Exit Sub
    Case "COMP"
         If UserList(Userindex).flags.ComerCiandoNuevo = True Then
         If UserList(Userindex).flags.Comerciando = True Then 'ComercioNuevo
         Call CanceloComercio(Userindex)
         End If
         End If
    
         If UserList(Userindex).flags.Muerto Then
            Call SendData(ToIndex, Userindex, 0, "MU")
            Exit Sub
         End If
         
         rdata = Right$(rdata, Len(rdata) - 4)
         If UserList(Userindex).flags.TargetNpc Then
         
            If Npclist(UserList(Userindex).flags.TargetNpc).NPCtype = NPCTYPE_TIENDA Then
                Call TiendaVentaItem(Userindex, val(ReadField(1, rdata, 44)), val(ReadField(2, rdata, 44)), UserList(Userindex).flags.TargetNpc)
                Exit Sub
            End If
               
            If Npclist(UserList(Userindex).flags.TargetNpc).Comercia = 0 Then
                Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "3Q" & FONTTYPE_TALK & "°" & "No tengo ningún interes en comerciar." & "°" & str(Npclist(UserList(Userindex).flags.TargetNpc).Char.CharIndex))
                Exit Sub
            End If
         Else: Exit Sub
         End If
         
         
         Call NPCVentaItem(Userindex, val(ReadField(1, rdata, 44)), val(ReadField(2, rdata, 44)), UserList(Userindex).flags.TargetNpc)
         Exit Sub
    Case "RETI"
         
        If UserList(Userindex).flags.ComerCiandoNuevo = True Then
        If UserList(Userindex).flags.Comerciando = True Then 'ComercioNuevo
        Call CanceloComercio(Userindex)
        End If
        End If
    
        If UserList(Userindex).flags.Muerto Then
           Call SendData(ToIndex, Userindex, 0, "MU")
           Exit Sub
        End If
        
        If UserList(Userindex).flags.TargetNpc Then
           If Npclist(UserList(Userindex).flags.TargetNpc).NPCtype <> NPCTYPE_BANQUERO Then Exit Sub
        Else: Exit Sub
        
        End If
        rdata = Right$(rdata, Len(rdata) - 4)
        Call UserRetiraItem(Userindex, val(ReadField(1, rdata, 44)), val(ReadField(2, rdata, 44)))
        
        Exit Sub
         
    Case "POVE"
        If Npclist(UserList(Userindex).flags.TargetNpc).flags.TiendaUser Then
            If Npclist(UserList(Userindex).flags.TargetNpc).flags.TiendaUser <> Userindex Then Exit Sub
        Else
            Npclist(UserList(Userindex).flags.TargetNpc).flags.TiendaUser = Userindex
        End If
        
        If UserList(Userindex).flags.Muerto Then
            Call SendData(ToIndex, Userindex, 0, "MU")
            Exit Sub
         End If

         If UserList(Userindex).flags.TargetNpc Then
            If Npclist(UserList(Userindex).flags.TargetNpc).NPCtype <> NPCTYPE_TIENDA Then
                Exit Sub
            End If
         Else: Exit Sub
         End If
         
         rdata = Right$(rdata, Len(rdata) - 4)
         
         Call UserPoneVenta(Userindex, val(ReadField(1, rdata, 44)), val(ReadField(2, rdata, 44)), val(ReadField(3, rdata, 44)))
         
         Exit Sub
    
    Case "SAVE"
         If UserList(Userindex).flags.Muerto Then
            Call SendData(ToIndex, Userindex, 0, "MU")
            Exit Sub
         End If
         If UserList(Userindex).flags.TargetNpc Then
            If Npclist(UserList(Userindex).flags.TargetNpc).NPCtype <> NPCTYPE_TIENDA Then Exit Sub
         Else: Exit Sub
         End If
         rdata = Right$(rdata, Len(rdata) - 4)
         Call UserSacaVenta(Userindex, val(ReadField(1, rdata, 44)), val(ReadField(2, rdata, 44)))
         Exit Sub
         
    Case "VEND"
         
    If UserList(Userindex).flags.ComerCiandoNuevo = True Then
    If UserList(Userindex).flags.Comerciando = True Then 'ComercioNuevo
    Call CanceloComercio(Userindex)
    End If
    End If
    
         If UserList(Userindex).flags.Muerto Then
            Call SendData(ToIndex, Userindex, 0, "MU")
            Exit Sub
         End If

         If UserList(Userindex).flags.TargetNpc Then
               If Npclist(UserList(Userindex).flags.TargetNpc).NPCtype = NPCTYPE_TIENDA Then
                   Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "/N")
                   Exit Sub
               End If
               
               If Npclist(UserList(Userindex).flags.TargetNpc).Comercia = 0 Then
                   Call SendData(ToPCArea, Userindex, UserList(Userindex).POS.Map, "3Q" & FONTTYPE_TALK & "°" & "No tengo ningun interes en comerciar." & "°" & str(Npclist(UserList(Userindex).flags.TargetNpc).Char.CharIndex))
                   Exit Sub
               End If
         Else
           Exit Sub
         End If
         rdata = Right$(rdata, Len(rdata) - 4)
         
         If val(ReadField(2, rdata, 44)) < 0 Then Exit Sub 'BUG DUPEO
         If val(ReadField(1, rdata, 44)) < 0 Then Exit Sub 'BUG DUPEO
         
         Call NPCCompraItem(Userindex, val(ReadField(1, rdata, 44)), val(ReadField(2, rdata, 44)))
         Exit Sub

    Case "DEPO"
            If UserList(Userindex).flags.ComerCiandoNuevo = True Then
            If UserList(Userindex).flags.Comerciando = True Then 'ComercioNuevo
            Call CanceloComercio(Userindex)
            End If
            End If
         If UserList(Userindex).flags.Muerto Then
            Call SendData(ToIndex, Userindex, 0, "MU")
            Exit Sub
         End If
         If UserList(Userindex).flags.TargetNpc Then
            If Npclist(UserList(Userindex).flags.TargetNpc).NPCtype <> NPCTYPE_BANQUERO Then Exit Sub
         Else: Exit Sub
         End If
         rdata = Right$(rdata, Len(rdata) - 4)

         Call UserDepositaItem(Userindex, val(ReadField(1, rdata, 44)), val(ReadField(2, rdata, 44)))
         Exit Sub
    

        
    
         
End Select

Select Case UCase$(Left$(rdata, 5))
    Case "DEMSG"
        
        
        If UserList(Userindex).flags.TargetObj Then
        rdata = Right$(rdata, Len(rdata) - 5)
        Dim f As String, Titu As String, msg As String, f2 As String
   
        f = App.Path & "\foros\"
        f = f & UCase$(ObjData(UserList(Userindex).flags.TargetObj).ForoID) & ".for"
        Titu = ReadField(1, rdata, 176)
        msg = ReadField(2, rdata, 176)
   
        Dim n2 As Integer, loopme As Integer
        If FileExist(f, vbNormal) Then
            Dim Num As Integer
            Num = val(GetVar(f, "INFO", "CantMSG"))
            If Num > MAX_MENSAJES_FORO Then
                For loopme = 1 To Num
                    Kill App.Path & "\foros\" & UCase$(ObjData(UserList(Userindex).flags.TargetObj).ForoID) & loopme & ".for"
                Next
                Kill App.Path & "\foros\" & UCase$(ObjData(UserList(Userindex).flags.TargetObj).ForoID) & ".for"
                Num = 0
            End If
          
            n2 = FreeFile
            f2 = Left$(f, Len(f) - 4)
            f2 = f2 & Num + 1 & ".for"
            Open f2 For Output As n2
            Print #n2, Titu
            Print #n2, msg
            Call WriteVar(f, "INFO", "CantMSG", Num + 1)
        Else
            n2 = FreeFile
            f2 = Left$(f, Len(f) - 4)
            f2 = f2 & "1" & ".for"
            Open f2 For Output As n2
            Print #n2, Titu
            Print #n2, msg
            Call WriteVar(f, "INFO", "CantMSG", 1)
        End If
        Close #n2
        End If
        Exit Sub
End Select

Select Case UCase$(Left$(rdata, 6))
    Case "DESCOD"
            rdata = Right$(rdata, Len(rdata) - 6)
            Call UpdateCodexAndDesc(rdata, Userindex)
            Exit Sub
    Case "DESPHE"
            rdata = Right$(rdata, Len(rdata) - 6)
            Call DesplazarHechizo(Userindex, CInt(ReadField(1, rdata, 44)), CByte(ReadField(2, rdata, 44)))
            Exit Sub
    Case "PARACE"
        If UserList(Userindex).flags.Ofreciente = 0 Then Exit Sub
        If Not UserList(UserList(Userindex).flags.Ofreciente).flags.UserLogged Then Exit Sub

        If NoPuedeEntrarParty(UserList(Userindex).flags.Ofreciente, Userindex) Then Exit Sub
    
        Dim PartyIndex As Integer
        If UserList(UserList(Userindex).flags.Ofreciente).flags.Party Then
            PartyIndex = UserList(UserList(Userindex).flags.Ofreciente).PartyIndex
            If PartyIndex = 0 Then Exit Sub
            Call EntrarAlParty(Userindex, PartyIndex)
        Else
            Call CrearParty(Userindex)
        End If
        Exit Sub
    Case "PARREC"
        If UserList(Userindex).flags.Ofreciente = 0 Then Exit Sub
        If Not UserList(UserList(Userindex).flags.Ofreciente).flags.UserLogged Then Exit Sub
        Call SendData(ToIndex, Userindex, 0, "||Rechazaste entrar a party con " & UserList(UserList(Userindex).flags.Ofreciente).Name & "." & FONTTYPE_PARTY)
        Call SendData(ToIndex, UserList(Userindex).flags.Ofreciente, 0, "||" & UserList(Userindex).Name & " rechazo entrar en party con vos." & FONTTYPE_PARTY)
        UserList(Userindex).flags.Ofreciente = 0
        Exit Sub
    Case "PARECH"
        rdata = ReadField(1, Right$(rdata, Len(rdata) - 6), Asc("("))
        rdata = Left$(rdata, Len(rdata) - 1)
        If UserList(Userindex).flags.Party Then
            If Party(UserList(Userindex).PartyIndex).NroMiembros = 2 Then
                For i = 1 To Party(UserList(Userindex).PartyIndex).NroMiembros
                    Call RomperParty(Userindex)
                Next
            Else
                Call EcharDelParty(NameIndex(rdata))
            End If
        Else
            Call SendData(ToIndex, Userindex, 0, "||No estás en party." & FONTTYPE_PARTY)
        End If
        Exit Sub
            
 End Select


Select Case UCase$(Left$(rdata, 7))

Case "TERMINC"
Call CanceloComercio(Userindex)
Exit Sub

Case "ACEPTCM"
Call AceptarComercio(Userindex)
Exit Sub

Case "BANEAME"
            rdata = Right(rdata, Len(rdata) - 7)
        arg1 = ReadField(1, rdata, Asc(","))
        arg2 = ReadField(2, rdata, Asc(","))
        
            H = FreeFile
            Open App.Path & "\Logs\CHITEROS.log" For Append Shared As H
            
            Print #H, "########################################################################"
            Print #H, "USUARIO: " & UserList(Userindex).Name
            Print #H, "FECHA: " & Date
            Print #H, "HORA: " & Time
            Print #H, "CHEAT: " & arg1
            Print #H, "CLASS: " & arg2
            Print #H, "########################################################################"
            Print #H, " "
            Close #H

            Call SendData(ToAdmins, 0, 0, "||NabrianSeC> " & UserList(Userindex).Name & " ha sido echado por uso de " & arg1 & FONTTYPE_FIGHTT)
            Call CloseSocket(Userindex)
            Exit Sub


End Select


Select Case UCase$(Left$(rdata, 8))
    Case "ACEPPEAT"
        rdata = Right$(rdata, Len(rdata) - 8)
        Call AcceptPeaceOffer(Userindex, rdata)
        Exit Sub
    Case "PEACEOFF"
        rdata = Right$(rdata, Len(rdata) - 8)
        Call RecievePeaceOffer(Userindex, rdata)
        Exit Sub
    Case "PEACEDET"
        rdata = Right$(rdata, Len(rdata) - 8)
        Call SendPeaceRequest(Userindex, rdata)
        Exit Sub
    Case "ENVCOMEN"
        rdata = Right$(rdata, Len(rdata) - 8)
        Call SendPeticion(Userindex, rdata)
        Exit Sub
    Case "ENVPROPP"
        Call SendPeacePropositions(Userindex)
        Exit Sub
    Case "DECGUERR"
        rdata = Right$(rdata, Len(rdata) - 8)
        Call DeclareWar(Userindex, rdata)
        Exit Sub
    Case "DECALIAD"
        rdata = Right$(rdata, Len(rdata) - 8)
        Call DeclareAllie(Userindex, rdata)
        Exit Sub
    Case "NEWWEBSI"
        rdata = Right$(rdata, Len(rdata) - 8)
        Call SetNewURL(Userindex, rdata)
        Exit Sub
    Case "ACEPTARI"
        rdata = Right$(rdata, Len(rdata) - 8)
        Call AcceptClanMember(Userindex, rdata, rdata)
        Exit Sub
    Case "RECHAZAR"
        rdata = Right$(rdata, Len(rdata) - 8)
        Call DenyRequest(Userindex, rdata, rdata)
        Exit Sub
    Case "ECHARCLA"
        Dim eslider As Integer
        rdata = Right$(rdata, Len(rdata) - 8)
        Tindex = NameIndex(rdata)
        If UserList(Userindex).GuildInfo.EsGuildLeader = 0 Then Exit Sub
        Call EcharMember(Userindex, rdata, rdata)
        Exit Sub
    Case "ACTGNEWS"
        rdata = Right$(rdata, Len(rdata) - 8)
        Call UpdateGuildNews(rdata, Userindex)
        Exit Sub
    Case "1HRINFO<"
        rdata = Right$(rdata, Len(rdata) - 8)
        Call SendCharInfo(rdata, Userindex)
        Exit Sub
End Select

Select Case UCase$(Left$(rdata, 9))
    Case "SOLICITUD"
         rdata = Right$(rdata, Len(rdata) - 9)
         Call SolicitudIngresoClan(Userindex, rdata)
         Exit Sub
End Select

Select Case UCase$(Left$(rdata, 11))
  Case "CLANDETAILS"
        rdata = Right$(rdata, Len(rdata) - 11)
        Call SendGuildDetails(Userindex, rdata)
        Exit Sub
End Select

Procesado = False
End Sub
