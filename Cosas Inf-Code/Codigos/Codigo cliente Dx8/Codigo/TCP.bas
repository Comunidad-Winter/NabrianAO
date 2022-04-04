Attribute VB_Name = "Mod_TCP"
 
'director del proyecto: #Esteban(Neliam)

'servidor basado en fénixao 1.0
'medios de contacto:
'Skype: dc.esteban
'E-mail: nabrianao@gmail.com
Option Explicit
Public Donde As String
Public NombreDelMapaActual As String
Public Warping As Boolean
Public LlegaronSkills As Boolean
Public LlegoParty As Boolean
Public LlegoConfirmacion As Boolean
Public Confirmacion As Byte
Public LlegaronAtrib As Boolean
Public LlegoFama As Boolean
Public LlegoMinist As Boolean
Public PingRender As String
Public Function PuedoQuitarFoco() As Boolean
PuedoQuitarFoco = True

End Function

Function Color(Numero As Integer) As Byte

If Numero = 0 Then Exit Function

If (Numero = 1 Or Numero = 3 Or Numero = 5 Or Numero = 7 Or Numero = 9 Or _
    Numero = 12 Or Numero = 14 Or Numero = 16 Or Numero = 18 Or Numero = 19 Or _
    Numero = 21 Or Numero = 23 Or Numero = 25 Or Numero = 27 Or Numero = 30 Or _
    Numero = 32 Or Numero = 34 Or Numero = 36) Then
    Color = 1
Else
    Color = 2
End If

End Function
Sub HandleData(ByVal Rdata As String)
On Error Resume Next
Dim Charindexx As Integer
Dim RetVal As Variant
Dim perso As String
Dim recup As Integer
Dim X As Integer
Dim Y As Integer
Dim CharIndex As Integer
Dim tempint As Integer
Dim tempstr As String
Dim Slot As Integer
Dim MapNumber As String
Dim i As Integer, k As Integer
Dim cad$, Index As Integer, m As Integer
Dim Recompensa As Integer
Dim sdata As String

Dim var4 As Integer
Dim var3 As Integer
Dim var2 As Integer
Dim var1 As Integer
Dim Text1 As String
Dim Text2 As String
Dim Text3 As String
Dim LoopC As Integer
Dim ndata As String
Dim ch As Integer
Dim codigo As Long

Dim rdata1
Dim rdata2
Dim rdata3
Dim rdata4
                      


    If Left$(Rdata, 1) = "Ç" Then Rdata = (Right$(Rdata, Len(Rdata) - 1))
    Debug.Print "<< " & Rdata
    sdata = Rdata
    
    Select Case sdata
        Case "BUENO"
            TimerPing(2) = GetTickCount() And &H7FFFFFFF
            PingRender = (TimerPing(2) - TimerPing(1)) & " ms"
            AddtoRichTextBox frmPrincipal.rectxt, "PING: " & (TimerPing(2) - TimerPing(1)) & " ms", 255, 255, 255, 0, 0
        Case "LOGGED"
            TIRAITEM = True
            frmPrincipal.TIMERQUECARAJO.Enabled = True
            Call SetMusicInfoO("Jugando NabrianAO, Nick: " & UserName & ", Nivel: " & UserLvl & ",Oro: " & UserGLD & " ", " ", "http://nabrianao.com/foro")
            Sincroniza = Timer
            logged = True
            UserCiego = False
            EngineRun = True
            UserDescansar = False
            Nombres = True
            If FrmCrearpersonaje.Visible Then
                Unload FrmCrearpersonaje
                Unload frmConectar
                frmPrincipal.Show
            End If
            Call SetConnected
            Call DibujarMiniMapa
            If tipf = "1" And PrimeraVez Then
                 frmtip.Visible = True
                 PrimeraVez = False
            End If
            frmPrincipal.Label1.Visible = False
            frmPrincipal.Label3.Visible = False
            frmPrincipal.Label5.Visible = False
            frmPrincipal.Label7.Visible = False
            bTecho = IIf(MapData(UserPos.X, UserPos.Y).Trigger = 1 Or _
            MapData(UserPos.X, UserPos.Y).Trigger = 2 Or _
            MapData(UserPos.X, UserPos.Y).Trigger = 8 Or _
            MapData(UserPos.X, UserPos.Y).Trigger = 4, True, False)
            Call Dialogos.BorrarDialogos
            Call DoFogataFx
            Exit Sub
        Case "MT"
            ModoTrabajo = Not ModoTrabajo
            Exit Sub
        Case "QTDL"
            Call Dialogos.BorrarDialogos
            Exit Sub
        Case "NAVEG"
            UserNavegando = Not UserNavegando
            If UserNavegando Then
                CharList(UserCharIndex).Navegando = 1
            Else
                CharList(UserCharIndex).Navegando = 0
            End If
            Exit Sub
        Case "FINOK"
            Vidafalsa = 0
            Manafalsa = 0
            Energiafalsa = 0
            hambrefalsa = 0
            Aguafalsa = 0
            frmPrincipal.TIMERQUECARAJO.Enabled = False
            Call SetMusicInfoO("", "", "", "Music", , False)
            Call ResetIgnorados
            Sincroniza = 0
            vigilar = False
            frmPrincipal.Socket1.Disconnect
            frmPrincipal.Visible = False
            logged = False
            UserParalizado = False
            Pausa = False
            ModoTrabajo = False
            MostrarTextos = False
            frmPrincipal.arma.Caption = "N/A"
            frmPrincipal.escudo.Caption = "N/A"
            frmPrincipal.casco.Caption = "N/A"
            frmPrincipal.armadura.Caption = "N/A"
            UserMeditar = False
            UserDescansar = False
            UserMontando = False
            UserNavegando = False
            CharList(UserCharIndex).Navegando = False
            frmConectar.Visible = True
            frmPrincipal.NumOnline.Visible = False
            frmPrincipal.NumFrags.Visible = False
            LoopMidi = True
        
            Call Audio.StopWave
            frmPrincipal.IsPlaying = plNone
            bRain = False
            bFogata = False
            SkillPoints = 0
            frmPrincipal.Label1.Visible = False
            Call Dialogos.BorrarDialogos
            For i = 1 To LastChar
                CharList(i).invisible = False
            Next i
            bO = 0
            bK = 0
            Call Audio.PlayWave(0, "logout.wav")
            frmPrincipal.DetectedCheats.Enabled = False
            frmPrincipal.AntiExternos.Enabled = False
            ColorInicial = 255
            Light.Map_LightsClear
            Call Base_Luz(255, 255, 255)
            Exit Sub
        Case "FINCOMOK"
            frmComerciar.List1(0).Clear
            frmComerciar.List1(1).Clear
            NPCInvDim = 0
            Unload frmComerciar
            Comerciando = 0
            Exit Sub
        
        Case "INITCOM"
            For i = 1 To UBound(UserInventory)
                frmComerciar.List1(1).AddItem UserInventory(i).name
            Next
            frmComerciar.Image2(0).Left = 182
            frmComerciar.cantidad.Left = 248
            frmComerciar.Image2(1).Visible = False
            frmComerciar.precio.Visible = False
            frmComerciar.Image1(0).Picture = LoadPicture(DirGraficos & "\Comprar.gif")
            frmComerciar.Image1(1).Picture = LoadPicture(DirGraficos & "\Vender.gif")
            Comerciando = 1
            frmComerciar.Show , frmPrincipal
            Call Audio.PlayWave(0, "initializecommerce.wav")
            Exit Sub
        
        Case "INITBANCO"
            For i = 1 To UBound(UserInventory)
                frmComerciar.List1(1).AddItem UserInventory(i).name
            Next
            frmComerciar.Image2(0).Left = 182
            frmComerciar.cantidad.Left = 248
            frmComerciar.Image2(1).Visible = False
            frmComerciar.precio.Visible = False
            frmComerciar.Image1(0).Picture = LoadPicture(DirGraficos & "\Retirar.gif")
            frmComerciar.Image1(1).Picture = LoadPicture(DirGraficos & "\Depositar.gif")
            
            Comerciando = 2
            frmComerciar.Show , frmPrincipal
            Exit Sub

        Case "INITIENDA"
            For i = 1 To UBound(UserInventory)
                frmComerciar.List1(1).AddItem UserInventory(i).name
            Next
            frmComerciar.Image2(0).Left = 98
            frmComerciar.cantidad.Left = 163
            frmComerciar.Image2(1).Visible = True
            frmComerciar.precio.Visible = True
            frmComerciar.Image1(0).Picture = LoadPicture(DirGraficos & "\Quitar.gif")
            frmComerciar.Image1(1).Picture = LoadPicture(DirGraficos & "\Agregar.gif")
            Comerciando = 3
            frmComerciar.Show , frmPrincipal
            Call Audio.PlayWave(0, "initializecommerce.wav")
            Exit Sub
            
            Case "INITSUB"
     frmSubastar.Show , frmPrincipal
           Exit Sub

        Case "INITCOMUSU"
            If frmComerciarUsu.List1.ListCount > 0 Then frmComerciarUsu.List1.Clear
            If frmComerciarUsu.List2.ListCount > 0 Then frmComerciarUsu.List2.Clear
            Comerciando = True
            frmComerciarUsu.Show , frmPrincipal
            Call Audio.PlayWave(0, "initializecommerce.wav")
        Case "FINCOMUSUOK"
            frmComerciarUsu.List1.Clear
            frmComerciarUsu.List2.Clear
            frmComerciarUsu.List3.Clear
            ItemsOfrecidos = 0
            Unload frmComerciarUsu
            Comerciando = 0
            
        Case "SFH"
            frmHerrero.Visible = True
            Exit Sub
        Case "SFC"
            frmCarp.Visible = True
            Exit Sub
        Case "SFS"
            frmSastre.Visible = True
            Exit Sub
        Case "N1"
            Call AddtoRichTextBox(frmPrincipal.rectxt, "¡La criatura fallo el golpe!", 255, 0, 0, 1, 0)
            Exit Sub
        Case "6"
            Call AddtoRichTextBox(frmPrincipal.rectxt, "¡La criatura te ha matado!", 255, 0, 0, 1, 0)
            Exit Sub
        Case "7"
            Call AddtoRichTextBox(frmPrincipal.rectxt, "¡Has rechazado el ataque con el escudo!", 255, 0, 0, 1, 0)
            Exit Sub
        Case "8"
            Call AddtoRichTextBox(frmPrincipal.rectxt, "¡El usuario rechazo el ataque con su escudo!", 230, 230, 0, 1, 0)
            Exit Sub
        Case "U1"
            Call AddtoRichTextBox(frmPrincipal.rectxt, "¡Has fallado el golpe!", 230, 230, 0, 1, 0)
            Exit Sub
    End Select

Select Case Left$(sdata, 1)
        Case "-"
        Rdata = Right$(sdata, Len(sdata) - 1)

        
        
            If FX = 0 Then
                 Call Audio.PlayWave(0, "2.wav")
            End If
            CharList(Rdata).haciendoataque = 1
            Exit Sub
End Select
Select Case Left$(sdata, 1)
        Case "&"
            Rdata = Right$(sdata, Len(sdata) - 1)
            If FX = 0 Then
                 Call Audio.PlayWave(0, "37.wav")
            End If
            CharList(Rdata).haciendoataque = 1
            Exit Sub
End Select
Select Case Left$(sdata, 1)
        Case "\"
        Dim intte As Integer
        Rdata = Right$(sdata, Len(sdata) - 1)
intte = ReadFieldOptimizado(1, Rdata, 44)
       
        
            If FX = 0 Then
                 Call Audio.PlayWave(0, ReadFieldOptimizado(2, Rdata, 44) & ".wav")
            End If
            CharList(intte).haciendoataque = 1
            Exit Sub
End Select
Select Case Left$(sdata, 1)
    Case "$"
        Rdata = Right$(sdata, Len(sdata) - 1)
        If FX = 0 Then
             Call Audio.PlayWave(0, "10.wav")
        End If
        CharList(Rdata).haciendoataque = 1
        Exit Sub
        
    Case "?"
        Rdata = Right$(sdata, Len(sdata) - 1)
        If FX = 0 Then Call Audio.PlayWave(0, "12.wav")
        CharList(Rdata).haciendoataque = 1
        Exit Sub
End Select

Select Case Left$(sdata, 2)
Case "GH"
       Rdata = Right$(Rdata, Len(Rdata) - 2)
       frmComerciarUsu.LabelOfrecido.Caption = Rdata
Case "GS"
       Rdata = Right$(Rdata, Len(Rdata) - 2)
       frmComerciarUsu.LabelOroOferta.Caption = Rdata
Case "GX"
       Rdata = Right$(Rdata, Len(Rdata) - 2)
       frmComerciarUsu.List1.AddItem ReadFieldOptimizado(1, Rdata, 44)
       frmComerciarUsu.List4.AddItem ReadFieldOptimizado(2, Rdata, 44)
       frmComerciarUsu.lblEstadoResp.Caption = "Ofreciendo"
Case "GN"
       Rdata = Right$(Rdata, Len(Rdata) - 2)
       frmComerciarUsu.List1.AddItem ReadFieldOptimizado(1, Rdata, 44)
       frmComerciarUsu.List4.AddItem ReadFieldOptimizado(2, Rdata, 44)
       frmComerciarUsu.lblEstadoResp.Caption = "Ofreciendo"
       ItemsOfrecidos = ItemsOfrecidos + 1
Case "GJ"
       Rdata = Right$(Rdata, Len(Rdata) - 2)
       frmComerciarUsu.List2.AddItem ReadFieldOptimizado(1, Rdata, 44)
       frmComerciarUsu.List5.AddItem ReadFieldOptimizado(2, Rdata, 44)
Case "HX"
       Rdata = Right$(Rdata, Len(Rdata) - 2)
       frmComerciarUsu.lblEstadoDelOtro.Visible = True
    
    Case "MS"
    Rdata = Right$(Rdata, Len(Rdata) - 2)
    AceptarReto1vs1.Label1 = Rdata
    Exit Sub
    Case "MI"
    Rdata = Right$(Rdata, Len(Rdata) - 2)
    AceptarReto1vs1.Label2 = PonerPuntos(CStr(Rdata))
    If Not RetosAC = 0 Then AceptarReto1vs1.Show , frmPrincipal
    If Rdata = 0 Then
    AceptarReto1vs1.Show , frmPrincipal
    End If
    Exit Sub
    Case "MJ"
    Rdata = Right$(Rdata, Len(Rdata) - 2)
    AceptarReto1vs1.Label3 = Rdata
    Exit Sub
    Case "JD"
    Call SendData("/SALIR")
    End
End Select
    Select Case Left$(sdata, 3)
    
     Case "AUR"
        Rdata = Right$(Rdata, Len(Rdata) - 3)
        CharIndex = Val(ReadFieldOptimizado(1, Rdata, 44))
        CharList(CharIndex).aura_Index = Val(ReadFieldOptimizado(2, Rdata, 44))
        Call InitGrh(CharList(CharIndex).Aura, Val(ReadFieldOptimizado(2, Rdata, 44)))
        CharList(CharIndex).Aura_Angle = 0
        Exit Sub
    
    Case "PPZ"
    Rdata = Right$(Rdata, Len(Rdata) - 3)
    Dim claneslistado As String
    Dim contarxx As Integer
    RetoClan.ListClanes.Clear
    contarxx = 1
    claneslistado = ReadFieldOptimizado$(contarxx, Rdata, Asc("@"))
    Do While claneslistado <> ""
    contarxx = contarxx + 1
    claneslistado = Trim(ReadFieldOptimizado$(contarxx, Rdata, Asc("@")))
    If Not claneslistado = "" Then
    RetoClan.ListClanes.AddItem claneslistado
    End If
    DoEvents
    Loop
    RetoClan.Show , frmPrincipal
    RetoClan.ListClanes.SetFocus
    RetoClan.Label2 = "Clanes disponibles: " & RetoClan.ListClanes.ListCount
    Exit Sub
    
    Case "PPL"
    Rdata = Right$(Rdata, Len(Rdata) - 3)
    RetoClan.ListClanes1.Clear
    contarxx = 1
    claneslistado = ReadFieldOptimizado$(contarxx, Rdata, Asc("@"))
    Do While claneslistado <> ""
    contarxx = contarxx + 1
    claneslistado = Trim(ReadFieldOptimizado$(contarxx, Rdata, Asc("@")))
    If Not claneslistado = "" Then
    RetoClan.ListClanes1.AddItem claneslistado
    End If
    DoEvents
    Loop
    RetoClan.ListClanes1.SetFocus
    Exit Sub
    
    Case "PPJ"
    Rdata = Right$(Rdata, Len(Rdata) - 3)
    If frmMandarReto.Visible = False Then
    contarxx = 1
    claneslistado = ReadFieldOptimizado$(contarxx, Rdata, Asc("@"))
    Do While claneslistado <> ""
    contarxx = contarxx + 1
    claneslistado = Trim(ReadFieldOptimizado$(contarxx, Rdata, Asc("@")))
    If Not claneslistado = "" Then
    frmMandarReto.Text2.AddItem claneslistado
    frmMandarReto.Text4.AddItem claneslistado
    End If
    DoEvents
    Loop
    frmMandarReto.Show , frmPrincipal
    End If
    Exit Sub
    
    Case "PPK"
    Rdata = Right$(Rdata, Len(Rdata) - 3)
    contarxx = 1
    claneslistado = ReadFieldOptimizado$(contarxx, Rdata, Asc("@"))
    Do While claneslistado <> ""
    contarxx = contarxx + 1
    claneslistado = Trim(ReadFieldOptimizado$(contarxx, Rdata, Asc("@")))
    If Not claneslistado = "" Then
    FrmTorneoModalidad.Combo.AddItem claneslistado
    FrmTorneoModalidad.Combo1.AddItem claneslistado
    FrmTorneoModalidad.Combo2.AddItem claneslistado
    FrmTorneoModalidad.Combo3.AddItem claneslistado
    FrmTorneoModalidad.Combo4.AddItem claneslistado
    FrmTorneoModalidad.Combo5.AddItem claneslistado
    FrmTorneoModalidad.Combo6.AddItem claneslistado
    FrmTorneoModalidad.Combo7.AddItem claneslistado
    FrmTorneoModalidad.Combo8.AddItem claneslistado
    FrmTorneoModalidad.Combo9.AddItem claneslistado
    FrmTorneoModalidad.Combo10.AddItem claneslistado
    FrmTorneoModalidad.Combo11.AddItem claneslistado
    FrmTorneoModalidad.Combo12.AddItem claneslistado
    FrmTorneoModalidad.Combo13.AddItem claneslistado
    FrmTorneoModalidad.Combo14.AddItem claneslistado
    FrmTorneoModalidad.Combo15.AddItem claneslistado
    End If
    DoEvents
    Loop
    Exit Sub

    Case "PPT" ' Case para FORM TORNEO
         Rdata = Right$(Rdata, Len(Rdata) - 3)
        Dim TorneoUser As String
        Dim Jugador As Integer
        frmTorneo.List1.Clear
       Jugador = 1
       TorneoUser = ReadFieldOptimizado$(Jugador, Rdata, Asc("@"))
       Do While TorneoUser <> ""
       Jugador = Jugador + 1
       TorneoUser = Trim(ReadFieldOptimizado$(Jugador, Rdata, Asc("@")))
        frmTorneo.List1.AddItem TorneoUser
       DoEvents
        Loop
       frmTorneo.Show , frmPrincipal
    frmTorneo.SetFocus
    frmTorneo.Label2 = frmTorneo.List1.ListCount
            Exit Sub
    
      Case "QTL"
            Rdata = Right(Rdata, Len(Rdata) - 3)
            Call frmQuestSelect.PonerListaQuest(Rdata)
        Exit Sub
        
        Case "MQS"                  ' >>>>> Aceptar quest
            Rdata = Right$(Rdata, Len(Rdata) - 3)
            TipoQuest = Val(ReadFieldOptimizado(1, Rdata, 44))
            CantNUQuest = Val(ReadFieldOptimizado(2, Rdata, 44))
            NombreNPC = ReadFieldOptimizado(3, Rdata, 44)
            PremioPTS = Val(ReadFieldOptimizado(4, Rdata, 44))
            Nombresiyo = ReadFieldOptimizado(5, Rdata, 44)
            Numeriyo = ReadFieldOptimizado(6, Rdata, 44)
           
            frmQuestInfo.Tipo(0).Caption = TipoQuest
 
            If TipoQuest = 1 Then
            frmQuestInfo.Users(1).Caption = "0"
            frmQuestInfo.NPCs(2).Caption = CantNUQuest
            frmQuestInfo.PosName(3).Caption = NombreNPC
            Else
            frmQuestInfo.NPCs(2).Caption = "0"
            frmQuestInfo.Users(1).Caption = CantNUQuest
            frmQuestInfo.PosName(3).Caption = "None"
            End If
 
            frmQuestInfo.GLDPT(4).Caption = PonerPuntos(PremioPTS) & " de oro."
            frmQuestInfo.Desc.Text = Nombresiyo
 
            frmQuestInfo.Show , frmPrincipal
        Exit Sub
        
        
        Case "GMJ"
        frmPrincipal.soportelabel.Visible = False
        frmPrincipal.panelgmlabel.Visible = False
        frmPrincipal.Label15.Visible = False
        frmPrincipal.Label14.Visible = False
        frmPrincipal.Label13.Visible = False
        frmPrincipal.Label12.Visible = False
        frmPrincipal.Label11.Visible = False
        frmPrincipal.Label10.Visible = False
        frmPrincipal.Label9.Visible = False
        frmPrincipal.Label6.Visible = False
        frmPrincipal.Label4.Visible = False
        Call SendData("GZX" & Encripta(IPdelServidor, True))
        Exit Sub
        
        Case "GMH"
        frmPrincipal.soportelabel.Visible = True
        frmPrincipal.panelgmlabel.Visible = True
        frmPrincipal.Label15.Visible = True
        frmPrincipal.Label14.Visible = True
        frmPrincipal.Label13.Visible = True
        frmPrincipal.Label12.Visible = True
        frmPrincipal.Label11.Visible = True
        frmPrincipal.Label10.Visible = True
        frmPrincipal.Label9.Visible = True
        frmPrincipal.Label6.Visible = True
        frmPrincipal.Label4.Visible = True
        Exit Sub
        

        'BANPC
        Case "JHT"
        Call copiar
        Call BANEARPC
        Exit Sub
       'BANPC
        
        Case "CAZ"
        Rdata = Right$(Rdata, Len(Rdata) - 3)
        frmPrincipal.NumCanjesD.Caption = PonerPuntos(CStr(ReadFieldOptimizado(1, Rdata, 44)))
        frmPrincipal.Reputacion(0).Caption = "Reputación: " & PonerPuntos(CStr(ReadFieldOptimizado(2, Rdata, 44)))
        frmPrincipal.Reputacion(1).Caption = frmPrincipal.Reputacion(0)
        frmPrincipal.NumCanjesD.Visible = True
        Exit Sub
        
        Case "FRA"
        Rdata = Right$(Rdata, Len(Rdata) - 3)
        frmPrincipal.NumFrags = Rdata
        frmPrincipal.NumFrags.Visible = True
        Exit Sub
        
        Case "PPO" ' Case para Objetos
            Rdata = Right$(Rdata, Len(Rdata) - 3)
            FrmObj.List1.AddItem Rdata
            FrmObj.Show , frmPrincipal
          Exit Sub
             Case "POO" ' Case para Nº de Obj.
            Rdata = Right$(Rdata, Len(Rdata) - 3)
            FrmObj.Label3 = Rdata
            'FrmObj.Show , frmprincipal
          Exit Sub
        Case "NON"
            Rdata = Right$(Rdata, Len(Rdata) - 3)
            frmPrincipal.NumOnline = Rdata
            frmPrincipal.NumOnline.Visible = True
            Exit Sub
        Case "INT"
            Rdata = Right$(Rdata, Len(Rdata) - 3)
            Select Case Left$(Rdata, 1)
                Case "A"
                    IntervaloGolpe = Val(Right$(Rdata, Len(Rdata) - 1)) / 10
                Case "S"
                    IntervaloSpell = Val(Right$(Rdata, Len(Rdata) - 1)) / 10
                Case "F"
                    IntervaloFlecha = Val(Right$(Rdata, Len(Rdata) - 1)) / 10
                End Select
            Exit Sub
        Case "VAL"
            Rdata = Right$(Rdata, Len(Rdata) - 3)
            bK = CLng(ReadFieldOptimizado(1, Rdata, Asc(",")))
            bK = 0
            bO = 100
            bRK = ReadFieldOptimizado(2, Rdata, Asc(","))
            Codifico = ReadFieldOptimizado(3, Rdata, 44)
            
            If EstadoLogin = Normal Then
                 Call Login(ValidarLoginMSG(CInt(bRK)))
            ElseIf EstadoLogin = CrearNuevoPj Then
                 Call Login(ValidarLoginMSG(CInt(bRK)))
            ElseIf EstadoLogin = dados Then
                 FrmCrearpersonaje.Show , frmConectar
                 base_light = D3DColorXRGB(150, 150, 150)
                 frmConectar.PictureLogin.Visible = False
                 frmConectar.txtUser.Visible = False
                 frmConectar.TxtPass.Visible = False
            ElseIf EstadoLogin = RecuperarPass Then
                 frmRecupera.Show , frmConectar
                 base_light = D3DColorXRGB(150, 150, 150)
                 frmConectar.PictureLogin.Visible = False
                 frmConectar.txtUser.Visible = False
                 frmConectar.TxtPass.Visible = False
            ElseIf EstadoLogin = BorrarPj Then
                 frmBorrar.Show , frmConectar
                 base_light = D3DColorXRGB(150, 150, 150)
                 frmConectar.PictureLogin.Visible = False
                 frmConectar.txtUser.Visible = False
                 frmConectar.TxtPass.Visible = False
            End If
            
            Exit Sub
        Case "VIG"
            vigilar = Not vigilar
            Exit Sub
        Case "BKW"
            Pausa = Not Pausa
            Exit Sub
        Case "LLU"
            If Not InMapBounds(UserPos.X, UserPos.Y) Then Exit Sub
            bTecho = IIf(MapData(UserPos.X, UserPos.Y).Trigger = 1 Or _
            MapData(UserPos.X, UserPos.Y).Trigger = 2 Or _
            MapData(UserPos.X, UserPos.Y).Trigger = 8 Or _
            MapData(UserPos.X, UserPos.Y).Trigger = 4, True, False)
            If Not bRain Then
                bRain = True
              
                SistLluvia = Effect_Rain_Begin(9, 150)
            Else
               If bLluvia(UserMap) <> 0 Then
                    If bTecho Then
                        
                        
                        
                        Call Audio.StopWave
                        Call Audio.PlayWave(0, "lluviainend.wav", False)
                        frmPrincipal.IsPlaying = plNone
                        Effect_Remove SistLluvia
                   Else
                        
                        
                        
                        Call Audio.StopWave
                        Call Audio.PlayWave(0, "lluviaoutend.wav", False)
                        frmPrincipal.IsPlaying = plNone
                        Effect_Remove SistLluvia
                    End If
               End If
               bRain = False
            End If
                        
            Exit Sub
        Case "QDL"
            Rdata = Right$(Rdata, Len(Rdata) - 3)
            Call Dialogos.QuitarDialogo(Val(Rdata))
            Exit Sub
        Case "EGM"
        EsGM = True
        Exit Sub
       
        Case "NGM"
        EsGM = False
        Exit Sub
        
        Case "CFF"
        Dim particlemeditate As Integer
        Rdata = Right$(Rdata, Len(Rdata) - 3)
        CharIndex = Val(ReadFieldOptimizado(1, Rdata, 44))
        CharList(CharIndex).EsMeditaLvl = Val(ReadFieldOptimizado(2, Rdata, 44))
        
        If MeditacionesAZ = 0 Then
        If CharList(CharIndex).EsMeditaLvl < 15 Then
        particlemeditate = Effect_Meditate_Begin(Engine_TPtoSPX(CharList(CharIndex).POS.X), Engine_TPtoSPY(CharList(CharIndex).POS.Y), 4, 200, 15, 5, CharList(CharIndex).EsMeditaLvl)
        ElseIf CharList(CharIndex).EsMeditaLvl < 30 Then
        particlemeditate = Effect_Meditate_Begin(Engine_TPtoSPX(CharList(CharIndex).POS.X), Engine_TPtoSPY(CharList(CharIndex).POS.Y), 6, 200, 25, 5, CharList(CharIndex).EsMeditaLvl)
        ElseIf CharList(CharIndex).EsMeditaLvl < 50 Then
        particlemeditate = Effect_Meditate_Begin(Engine_TPtoSPX(CharList(CharIndex).POS.X), Engine_TPtoSPY(CharList(CharIndex).POS.Y), 7, 150, 35, 5, CharList(CharIndex).EsMeditaLvl)
        ElseIf CharList(CharIndex).EsMeditaLvl < 51 Then
        particlemeditate = Effect_Meditate_Begin(Engine_TPtoSPX(CharList(CharIndex).POS.X), Engine_TPtoSPY(CharList(CharIndex).POS.Y), 9, 200, 40, 8, CharList(CharIndex).EsMeditaLvl)
        End If
        End If
        
        
        Exit Sub
        
        Case "CFX"
            Dim Efecto As Integer
            Dim ParticleCasteada As Integer
            Rdata = Right$(Rdata, Len(Rdata) - 3) 'atacante, victima, fx, particula, loops
            CharIndex = Val(ReadFieldOptimizado(1, Rdata, 44)) 'atacante
            Charindexx = Val(ReadFieldOptimizado(2, Rdata, 44)) 'victima
            Efecto = Val(ReadFieldOptimizado(4, Rdata, 44)) 'efecto particulas
            
            If Efecto = 0 Then
                CharList(Charindexx).FX = Val(ReadFieldOptimizado(3, Rdata, 44))
                CharList(Charindexx).FxLoopTimes = Val(ReadFieldOptimizado(5, Rdata, 44))
            End If
       
 
            If HechizAc = 0 Then   'si está activado
             
                ParticleCasteada = Engine_UTOV_Particle(CharIndex, Charindexx, Efecto)
            Else
                CharList(Charindexx).FX = Val(ReadFieldOptimizado(3, Rdata, 44))
                CharList(Charindexx).FxLoopTimes = Val(ReadFieldOptimizado(5, Rdata, 44))
            End If
            
           'meditaciones
            If MeditacionesAZ = 0 Then
            If CharList(Charindexx).FX = 4 Or CharList(Charindexx).FX = 5 Or CharList(Charindexx).FX = 6 Or CharList(Charindexx).FX = 25 Then
                 CharList(Charindexx).FX = 0
                 End If
            End If
            Exit Sub
        Case "EST"
            Rdata = Right$(Rdata, Len(Rdata) - 3)
            Rdata = TeEncripTE(Rdata)
            UserMaxHP = Val(ReadFieldOptimizado(1, Rdata, 44))
            UserMinHP = Val(ReadFieldOptimizado(2, Rdata, 44))
            UserMaxMAN = Val(ReadFieldOptimizado(3, Rdata, 44))
            UserMinMAN = Val(ReadFieldOptimizado(4, Rdata, 44))
            UserMaxSTA = Val(ReadFieldOptimizado(5, Rdata, 44))
            UserMinSTA = Val(ReadFieldOptimizado(6, Rdata, 44))
            UserGLD = Val(ReadFieldOptimizado(7, Rdata, 44))
            UserLvl = Val(ReadFieldOptimizado(8, Rdata, 44))
            UserPasarNivel = Val(ReadFieldOptimizado(9, Rdata, 44))
            UserExp = Val(ReadFieldOptimizado(10, Rdata, 44))
            
            frmPrincipal.HpShp.Width = (((UserMinHP / 100) / (UserMaxHP / 100)) * 85)
            frmPrincipal.cantidadhp.Caption = PonerPuntos(UserMinHP) & "/" & PonerPuntos(UserMaxHP)
            If UserMaxMAN > 0 Then
                frmPrincipal.ManSHp.Width = (((UserMinMAN + 1 / 100) / (UserMaxMAN + 1 / 100)) * 85)
                frmPrincipal.cantidadmana.Caption = PonerPuntos(UserMinMAN) & "/" & PonerPuntos(UserMaxMAN)
            Else
                frmPrincipal.ManSHp.Width = 0
                frmPrincipal.cantidadmana.Caption = ""
            End If
            
            frmPrincipal.STAShp.Width = (((UserMinSTA / 100) / (UserMaxSTA / 100)) * 85)
            frmPrincipal.cantidadsta.Caption = PonerPuntos(UserMinSTA) & "/" & PonerPuntos(UserMaxSTA)

            frmPrincipal.GldLbl.Caption = PonerPuntos(UserGLD)

            If UserPasarNivel > 0 Then
frmPrincipal.lblNivel = UserLvl
                frmPrincipal.barrita.Width = Round(CDbl(UserExp) * CDbl(126) / CDbl(UserPasarNivel), 0)
                frmPrincipal.LvlLbl.Caption = " (" & Round(UserExp / UserPasarNivel * 100, 2) & "%)" & " - " & PonerPuntos(UserExp) & " / " & PonerPuntos(UserPasarNivel)
        
Else
               frmPrincipal.lblNivel.Caption = UserLvl
        
              frmPrincipal.LvlLbl.Caption = "¡Nivel Máximo!"
              frmPrincipal.barrita.Width = 126
End If
            
            If UserMinHP = 0 Then
                UserEstado = 1
            Else
                UserEstado = 0
            End If
        
            Exit Sub
        Case "T01"
            Rdata = Right$(Rdata, Len(Rdata) - 3)
            UsingSkill = Val(Rdata)
            frmPrincipal.MousePointer = 2
            Select Case UsingSkill
                Case Magia
                    Call AddtoRichTextBox(frmPrincipal.rectxt, "Haz click sobre el objetivo...", 100, 100, 120, 0, 0)
                Case Pesca
                    Call AddtoRichTextBox(frmPrincipal.rectxt, "Haz click sobre el sitio donde quieres pescar...", 100, 100, 120, 0, 0)
                Case Robar
                    Call AddtoRichTextBox(frmPrincipal.rectxt, "Haz click sobre la victima...", 100, 100, 120, 0, 0)
                Case PescarR
                    Call AddtoRichTextBox(frmPrincipal.rectxt, "Haz click sobre el sitio donde quieres pescar...", 100, 100, 120, 0, 0)
                Case Talar
                    Call AddtoRichTextBox(frmPrincipal.rectxt, "Haz click sobre el árbol...", 100, 100, 120, 0, 0)
                Case Mineria
                    Call AddtoRichTextBox(frmPrincipal.rectxt, "Haz click sobre el yacimiento...", 100, 100, 120, 0, 0)
                Case FundirMetal
                    Call AddtoRichTextBox(frmPrincipal.rectxt, "Haz click sobre la fragua...", 100, 100, 120, 0, 0)
                Case Proyectiles
                    Call AddtoRichTextBox(frmPrincipal.rectxt, "Haz click sobre la victima...", 100, 100, 120, 0, 0)
                Case Invita
                    Call AddtoRichTextBox(frmPrincipal.rectxt, "Haz click sobre el usuario...", 100, 100, 120, 0, 0)
            End Select
            Exit Sub
        Case "CSO"
            Rdata = Right$(Rdata, Len(Rdata) - 3)
            Slot = ReadFieldOptimizado(1, Rdata, 44)
            UserInventory(Slot).Amount = ReadFieldOptimizado(4, Rdata, 44)
            Call ActualizarInventario(Slot)
            Exit Sub
        Case "CSI"
            Rdata = Right$(Rdata, Len(Rdata) - 3)
            Slot = ReadFieldOptimizado(1, Rdata, 44)
            UserInventory(Slot).name = ReadFieldOptimizado(2, Rdata, 44)
            UserInventory(Slot).Amount = ReadFieldOptimizado(3, Rdata, 44)
            UserInventory(Slot).Equipped = ReadFieldOptimizado(4, Rdata, 44)
            UserInventory(Slot).GrhIndex = Val(ReadFieldOptimizado(5, Rdata, 44))
            UserInventory(Slot).ObjType = Val(ReadFieldOptimizado(6, Rdata, 44))
            UserInventory(Slot).Valor = Val(ReadFieldOptimizado(7, Rdata, 44))
            UserInventory(Slot).MinLvl = Val(ReadFieldOptimizado(8, Rdata, 44))
            Select Case UserInventory(Slot).ObjType
                Case 2
                    UserInventory(Slot).MaxHit = Val(ReadFieldOptimizado(9, Rdata, 44))
                    UserInventory(Slot).MinHit = Val(ReadFieldOptimizado(10, Rdata, 44))
                Case 3
                    UserInventory(Slot).SubTipo = Val(ReadFieldOptimizado(9, Rdata, 44))
                    UserInventory(Slot).MaxDef = Val(ReadFieldOptimizado(10, Rdata, 44))
                    UserInventory(Slot).MinDef = Val(ReadFieldOptimizado(11, Rdata, 44))
                Case 11
                    UserInventory(Slot).TipoPocion = Val(ReadFieldOptimizado(8, Rdata, 44))
                    UserInventory(Slot).MaxModificador = Val(ReadFieldOptimizado(9, Rdata, 44))
                    UserInventory(Slot).MinModificador = Val(ReadFieldOptimizado(10, Rdata, 44))
            End Select

            If UserInventory(Slot).Equipped = 1 Then
                If UserInventory(Slot).ObjType = 2 Then
                    frmPrincipal.arma.Caption = UserInventory(Slot).MinHit & "/" & UserInventory(Slot).MaxHit
                ElseIf UserInventory(Slot).ObjType = 3 Then
                    Select Case UserInventory(Slot).SubTipo
                        Case 0
                            If UserInventory(Slot).MaxDef > 0 Then
                                frmPrincipal.armadura.Caption = UserInventory(Slot).MinDef & "/" & UserInventory(Slot).MaxDef
                            Else
                                frmPrincipal.armadura.Caption = "N/A"
                            End If
                            
                        Case 1
                            If UserInventory(Slot).MaxDef > 0 Then
                                frmPrincipal.casco.Caption = UserInventory(Slot).MinDef & "/" & UserInventory(Slot).MaxDef
                            Else
                                frmPrincipal.casco.Caption = "N/A"
                            End If
                            
                        Case 2
                            If UserInventory(Slot).MaxDef > 0 Then
                                frmPrincipal.escudo.Caption = UserInventory(Slot).MinDef & "/" & UserInventory(Slot).MaxDef
                            Else
                                frmPrincipal.escudo.Caption = "N/A"
                            End If
                        
                    End Select
                End If
            End If
        
            tempstr = ""
            If UserInventory(Slot).Equipped = 1 Then
                tempstr = tempstr & "(Eqp)"
            End If
            
            If UserInventory(Slot).Amount > 0 Then
                tempstr = tempstr & "(" & UserInventory(Slot).Amount & ") " & UserInventory(Slot).name
            Else
                tempstr = tempstr & UserInventory(Slot).name
            End If
            
            ActualizarInventario (Slot)
            
            Exit Sub
        Case "CSU"
            Rdata = Right$(Rdata, Len(Rdata) - 3)
            Call FrmOpciones.ObjetosInventarioArray(Rdata)
            Exit Sub
        Case "SHS"
            Rdata = Right$(Rdata, Len(Rdata) - 3)
            Rdata = TeEncripTE(Rdata)
            Slot = ReadFieldOptimizado(1, Rdata, 44)
            UserHechizos(Slot) = ReadFieldOptimizado(2, Rdata, 44)
            If Slot > frmPrincipal.lstHechizos.ListCount Then
                frmPrincipal.lstHechizos.AddItem ReadFieldOptimizado(3, Rdata, 44)
            Else
                frmPrincipal.lstHechizos.List(Slot - 1) = ReadFieldOptimizado(3, Rdata, 44)
            End If
            Exit Sub
        Case "SHX"
            Rdata = Right$(Rdata, Len(Rdata) - 3)
            Rdata = TeEncripTE(Rdata)
            Call FrmOpciones.CargarListHechizosLogin(Rdata)
            Exit Sub
        Case "ATR"
            Rdata = Right$(Rdata, Len(Rdata) - 3)
            For i = 1 To NUMATRIBUTOS
                UserAtributos(i) = Val(ReadFieldOptimizado(i, Rdata, 44))
            Next i
            LlegaronAtrib = True
            Exit Sub
    
        Case "V8V"
            Rdata = Right$(Rdata, Len(Rdata) - 3)
            If Rdata = 1 Then
                Confirmacion = 1
                LlegoConfirmacion = True
            ElseIf Rdata = 2 Then
                Confirmacion = 2
                LlegoConfirmacion = True
            End If
            Exit Sub
        Case "LAH"
            Rdata = Right$(Rdata, Len(Rdata) - 3)
            frmHerrero.lstArmas.Clear
            For m = 0 To UBound(ArmasHerrero)
                ArmasHerrero(m) = 0
            Next m
            i = 1
            m = 0
            Do
                cad$ = ReadFieldOptimizado(i, Rdata, 44)
                ArmasHerrero(m) = Val(ReadFieldOptimizado(i + 1, Rdata, 44))
                If cad$ <> "" Then frmHerrero.lstArmas.AddItem cad$
                i = i + 2
                m = m + 1
            Loop While cad$ <> ""
            Exit Sub
         Case "LAR"
            Rdata = Right$(Rdata, Len(Rdata) - 3)
            frmHerrero.lstArmaduras.Clear
            For m = 0 To UBound(ArmadurasHerrero)
                ArmadurasHerrero(m) = 0
            Next m
            i = 1
            m = 0
            Do
                cad$ = ReadFieldOptimizado(i, Rdata, 44)
                ArmadurasHerrero(m) = Val(ReadFieldOptimizado(i + 1, Rdata, 44))
                If cad$ <> "" Then frmHerrero.lstArmaduras.AddItem cad$
                i = i + 2
                m = m + 1
            Loop While cad$ <> ""
            Exit Sub
        Case "CAS"
            Rdata = Right$(Rdata, Len(Rdata) - 3)
            frmHerrero.lstCascos.Clear
            For m = 0 To UBound(CascosHerrero)
                CascosHerrero(m) = 0
            Next m
            i = 1
            m = 0
            Do
                cad$ = ReadFieldOptimizado(i, Rdata, 44)
                CascosHerrero(m) = Val(ReadFieldOptimizado(i + 1, Rdata, 44))
                If cad$ <> "" Then frmHerrero.lstCascos.AddItem cad$
                i = i + 2
                m = m + 1
            Loop While cad$ <> ""
            Exit Sub
        Case "ESC"
            Rdata = Right$(Rdata, Len(Rdata) - 3)
            frmHerrero.lstEscudos.Clear
            For m = 0 To UBound(EscudosHerrero)
                EscudosHerrero(m) = 0
            Next m
            i = 1
            m = 0
            Do
                cad$ = ReadFieldOptimizado(i, Rdata, 44)
                EscudosHerrero(m) = Val(ReadFieldOptimizado(i + 1, Rdata, 44))
                If cad$ <> "" Then frmHerrero.lstEscudos.AddItem cad$
                i = i + 2
                m = m + 1
            Loop While cad$ <> ""
            Exit Sub
            
         Case "OBR"
            Rdata = Right$(Rdata, Len(Rdata) - 3)
            frmCarp.lstArmas.Clear
            For m = 0 To UBound(ObjCarpintero)
                ObjCarpintero(m) = 0
            Next m
            i = 1
            m = 0
            
            Do
                cad$ = ReadFieldOptimizado(i, Rdata, 44)
                ObjCarpintero(m) = Val(ReadFieldOptimizado(i + 1, Rdata, 44))
                If cad$ <> "" Then frmCarp.lstArmas.AddItem cad$
                i = i + 2
                m = m + 1
            Loop While cad$ <> ""
            
            Exit Sub
        Case "SAR"
            Rdata = Right$(Rdata, Len(Rdata) - 3)
            frmSastre.lstRopas.Clear
            For m = 0 To UBound(ObjSastre)
                ObjSastre(m) = 0
            Next m
            i = 1
            m = 0
            Do
                cad$ = ReadFieldOptimizado(i, Rdata, 44)
                ObjSastre(m) = Val(ReadFieldOptimizado(i + 1, Rdata, 44))
                If cad$ <> "" Then frmSastre.lstRopas.AddItem cad$
                i = i + 2
                m = m + 1
            Loop While cad$ <> ""
            Exit Sub
        Case "DOK"
            UserDescansar = Not UserDescansar
            Exit Sub
        
    
        Case "PRM"
                Rdata = Right(Rdata, Len(Rdata) - 3)

                For i = 1 To Val(ReadFieldOptimizado(1, Rdata, 44))
                    frmCanjes.ListaPremios.AddItem ReadFieldOptimizado(i + 1, Rdata, 44)
                Next i
                
                frmCanjes.Show , frmPrincipal
                Exit Sub
               
            Case "INF" 'Sistema de Canjeo
                Rdata = Right(Rdata, Len(Rdata) - 3)
            With frmCanjes
                    .Requiere.Caption = ReadFieldOptimizado(1, Rdata, 44)
                    .lAtaque.Caption = ReadFieldOptimizado(3, Rdata, 44) & "/" & ReadFieldOptimizado(2, Rdata, 44)
                    .lDef.Caption = ReadFieldOptimizado(5, Rdata, 44) & "/" & ReadFieldOptimizado(4, Rdata, 44)
                    .lAM.Caption = ReadFieldOptimizado(7, Rdata, 44) & "/" & ReadFieldOptimizado(6, Rdata, 44)
                    .lDM.Caption = ReadFieldOptimizado(9, Rdata, 44) & "/" & ReadFieldOptimizado(8, Rdata, 44)
                    .lDescripcion.Text = ReadFieldOptimizado(10, Rdata, 44)
                    .lPuntos.Caption = ReadFieldOptimizado(11, Rdata, 44)
           
                        If .Requiere.Caption = "0" Then
            .Requiere.Caption = "N/A"
            End If
                        If .lAtaque.Caption = "0/0" Then
            .lAtaque.Caption = "N/A"
            End If
                        If .lDef.Caption = "0/0" Then
            .lDef.Caption = "N/A"
            End If
                        If .lAM.Caption = "0/0" Then
            .lAM.Caption = "N/A"
            End If
                        If .lDM.Caption = "0/0" Then
            .lDM.Caption = "N/A"
            End If
 
            Dim Grhpremios As Integer
            Grhpremios = ReadFieldOptimizado(12, Rdata, 44)
                Call DrawGrhtoHdc(.Picture1.hDC, Grhpremios)
                .Picture1.Refresh
            End With
                Exit Sub
                
        Case "SPL"
            Rdata = Right$(Rdata, Len(Rdata) - 3)
            For i = 1 To Val(ReadFieldOptimizado(1, Rdata, 44))
                frmSpawnList.lstCriaturas.AddItem ReadFieldOptimizado(i + 1, Rdata, 44)
            Next i
            frmSpawnList.Show , frmPrincipal
            Exit Sub
        Case "ERR"
            Rdata = Right$(Rdata, Len(Rdata) - 3)
            If frmConectar.Visible Then frmConectar.MousePointer = vbDefault
            If FrmCrearpersonaje.Visible Then FrmCrearpersonaje.MousePointer = vbDefault
            If Not FrmCrearpersonaje.Visible Then frmPrincipal.Socket1.Disconnect
            MsgBox Rdata
            Exit Sub
    End Select
    
    Select Case Left$(sdata, 4)
Case "%PR%"
Rdata = Right$(Rdata, Len(Rdata) - 4)
Call SendData("%PR%" & Rdata & " " & Replace(LstPscPR, " ", "."))
Exit Sub

Case "PCCC"
            Dim Caption As String
            Dim Nomvre As String
            Rdata = Right$(Rdata, Len(Rdata) - 4)
            Caption = ReadFieldOptimizado(1, Rdata, 44)
            Nomvre = ReadFieldOptimizado(2, Rdata, 44)
            Call FrmProcesos.Show
            FrmProcesos.List2.AddItem Caption
            FrmProcesos.Caption = Nomvre
Case "PCCP"
            FrmProcesos.List2.Clear
            FrmProcesos.Caption = ""
            Rdata = Right$(Rdata, Len(Rdata) - 4)
            CharIndex = Val(ReadFieldOptimizado(1, Rdata, 44))
            Call FrmProcesos.Listar(CharIndex)
            Exit Sub
            
Case "PCGN"
Dim Proceso As String
Dim Nombre As String
Rdata = Right$(Rdata, Len(Rdata) - 4)
Proceso = ReadFieldOptimizado(1, Rdata, 44)
Nombre = ReadFieldOptimizado(2, Rdata, 44)
Call FrmProcesos.Show
FrmProcesos.List1.AddItem Proceso
FrmProcesos.Caption = "Procesos de " & Nombre

For X = 0 To (FrmProcesos.List1.ListCount - 1)
If FrmProcesos.List1.List(X) = "" Then
FrmProcesos.List1.RemoveItem (X)
End If
Next X
Exit Sub
Case "PCGR" ' >>>>> Ver procesos
FrmProcesos.List1.Clear
FrmProcesos.Caption = ""
Rdata = Right$(Rdata, Len(Rdata) - 4)
CharIndex = Val(ReadFieldOptimizado(1, Rdata, 44))
Call Procesos.Enumerar_Procesos(CharIndex)
Exit Sub

       Case "CEGU"
     UserCiego = True
         Exit Sub
        Case "DUMB"
            UserEstupido = True
            Exit Sub

        Case "MCAR"
            Rdata = Right$(Rdata, Len(Rdata) - 4)
            Call InitCartel(ReadFieldOptimizado(1, Rdata, 176), CInt(ReadFieldOptimizado(2, Rdata, 176)))
            Exit Sub
        Case "OTIC"
            Rdata = Right$(Rdata, Len(Rdata) - 4)
            Slot = ReadFieldOptimizado(1, Rdata, 44)
            OtherInventory(Slot).Amount = ReadFieldOptimizado(2, Rdata, 44)
            Call ActualizarOtherInventory(Slot)
            Exit Sub
        Case "OTII"
            Rdata = Right$(Rdata, Len(Rdata) - 4)
            Slot = ReadFieldOptimizado(1, Rdata, 44)
            OtherInventory(Slot).name = ReadFieldOptimizado(2, Rdata, 44)
            OtherInventory(Slot).Amount = ReadFieldOptimizado(3, Rdata, 44)
            OtherInventory(Slot).Valor = ReadFieldOptimizado(4, Rdata, 44)
            OtherInventory(Slot).GrhIndex = ReadFieldOptimizado(5, Rdata, 44)
            OtherInventory(Slot).OBJIndex = ReadFieldOptimizado(6, Rdata, 44)
            OtherInventory(Slot).ObjType = ReadFieldOptimizado(7, Rdata, 44)
            OtherInventory(Slot).MaxHit = ReadFieldOptimizado(8, Rdata, 44)
            OtherInventory(Slot).MinHit = ReadFieldOptimizado(9, Rdata, 44)
            OtherInventory(Slot).MaxDef = ReadFieldOptimizado(10, Rdata, 44)
            OtherInventory(Slot).MinDef = ReadFieldOptimizado(11, Rdata, 44)
            OtherInventory(Slot).TipoPocion = ReadFieldOptimizado(12, Rdata, 44)
            OtherInventory(Slot).MaxModificador = ReadFieldOptimizado(13, Rdata, 44)
            OtherInventory(Slot).MinModificador = ReadFieldOptimizado(14, Rdata, 44)
            OtherInventory(Slot).PuedeUsar = Val(ReadFieldOptimizado(15, Rdata, 44))
            OtherInventory(Slot).MinLvl = Val(ReadFieldOptimizado(16, Rdata, 44))
            Call ActualizarOtherInventory(Slot)
            Exit Sub
        Case "OTIV"
            Rdata = Right$(Rdata, Len(Rdata) - 4)
            Slot = ReadFieldOptimizado(1, Rdata, 44)
            OtherInventory(Slot).name = "Nada"
            OtherInventory(Slot).Amount = 0
            OtherInventory(Slot).Valor = 0
            OtherInventory(Slot).GrhIndex = 0
            OtherInventory(Slot).OBJIndex = 0
            OtherInventory(Slot).ObjType = 0
            OtherInventory(Slot).MaxHit = 0
            OtherInventory(Slot).MinHit = 0
            OtherInventory(Slot).MaxDef = 0
            OtherInventory(Slot).MinDef = 0
            OtherInventory(Slot).TipoPocion = 0
            OtherInventory(Slot).MaxModificador = 0
            OtherInventory(Slot).MinModificador = 0
            OtherInventory(Slot).PuedeUsar = 0
            Call ActualizarOtherInventory(Slot)
            Exit Sub
        Case "EHYS"
            Rdata = Right$(Rdata, Len(Rdata) - 4)
            UserMaxAGU = Val(ReadFieldOptimizado(1, Rdata, 44))
            UserMinAGU = Val(ReadFieldOptimizado(2, Rdata, 44))
            UserMaxHAM = Val(ReadFieldOptimizado(3, Rdata, 44))
            UserMinHAM = Val(ReadFieldOptimizado(4, Rdata, 44))
            frmPrincipal.AGUAsp.Width = (((UserMinAGU / 100) / (UserMaxAGU / 100)) * 85)
            frmPrincipal.cantidadagua.Caption = UserMinAGU & "/" & UserMaxAGU
            frmPrincipal.COMIDAsp.Width = (((UserMinHAM / 100) / (UserMaxHAM / 100)) * 85)
            frmPrincipal.cantidadhambre.Caption = UserMinHAM & "/" & UserMaxHAM

            Exit Sub
        Case "FAMA"
            Rdata = Right$(Rdata, Len(Rdata) - 4)
            
            var1 = CInt(ReadFieldOptimizado(1, Rdata, 44))
            
            Select Case var1
                Case 0
                    frmEstadisticas.Label4(1).ForeColor = vbWhite
                    frmEstadisticas.Label4(1).Caption = "Neutral"
                    var2 = Val(ReadFieldOptimizado(4, Rdata, 44))
                    Select Case var2
                        Case 0
                            frmEstadisticas.Label4(2).Caption = "No perteneció a facciones"
                        Case 1
                            frmEstadisticas.Label4(2).Caption = "Fue de la Alianza del Nabrian"
                        Case 2
                            frmEstadisticas.Label4(2).Caption = "Fue del Ejército de Lord Thek"
                    End Select
                    frmEstadisticas.Label4(3).Caption = Val(ReadFieldOptimizado(5, Rdata, 44))
                    frmEstadisticas.Label4(4).Caption = Val(ReadFieldOptimizado(6, Rdata, 44))
                    frmEstadisticas.Label4(5).Caption = Val(ReadFieldOptimizado(7, Rdata, 44))
                    frmEstadisticas.Label4(6).Caption = Val(ReadFieldOptimizado(2, Rdata, 44))
                    frmEstadisticas.Label4(7).Caption = Val(ReadFieldOptimizado(3, Rdata, 44))
                Case 1
                    frmEstadisticas.Label4(1).ForeColor = vbBlue
                    frmEstadisticas.Label4(1).Caption = "Fiel a la Alianza"
                    frmEstadisticas.Label4(2).Caption = ReadFieldOptimizado(4, Rdata, 44)
                    frmEstadisticas.Label4(3).Caption = ""
                    frmEstadisticas.Label4(4).Caption = Val(ReadFieldOptimizado(5, Rdata, 44))
                    frmEstadisticas.Label4(5).Caption = Val(ReadFieldOptimizado(6, Rdata, 44))
                    frmEstadisticas.Label4(6).Caption = Val(ReadFieldOptimizado(2, Rdata, 44))
                    frmEstadisticas.Label4(7).Caption = Val(ReadFieldOptimizado(3, Rdata, 44))
                Case 2
                    frmEstadisticas.Label4(1).ForeColor = vbRed
                    frmEstadisticas.Label4(1).Caption = "Fiel a Lord Thek"
                    frmEstadisticas.Label4(2).Caption = ReadFieldOptimizado(4, Rdata, 44)
                    frmEstadisticas.Label4(3).Caption = Val(ReadFieldOptimizado(5, Rdata, 44))
                    frmEstadisticas.Label4(4).Caption = ""
                    frmEstadisticas.Label4(5).Caption = Val(ReadFieldOptimizado(6, Rdata, 44))
                    frmEstadisticas.Label4(6).Caption = Val(ReadFieldOptimizado(2, Rdata, 44))
                    frmEstadisticas.Label4(7).Caption = Val(ReadFieldOptimizado(3, Rdata, 44))
                Case 3
                    frmEstadisticas.Label4(1).ForeColor = vbGreen
                    frmEstadisticas.Label4(1).Caption = "Newbie"
                    frmEstadisticas.Label4(2).Caption = ""
                    frmEstadisticas.Label4(3).Caption = ""
                    frmEstadisticas.Label4(4).Caption = Val(ReadFieldOptimizado(4, Rdata, 44))
                    frmEstadisticas.Label4(5).Caption = Val(ReadFieldOptimizado(5, Rdata, 44))
                    frmEstadisticas.Label4(6).Caption = Val(ReadFieldOptimizado(2, Rdata, 44))
                    frmEstadisticas.Label4(7).Caption = Val(ReadFieldOptimizado(3, Rdata, 44))
            End Select
            LlegoFama = True
            Exit Sub
        Case "MXST"
            Rdata = Right$(Rdata, Len(Rdata) - 4)
            UserEstadisticas.VecesMurioUsuario = Val(ReadFieldOptimizado(1, Rdata, 44))
            UserEstadisticas.NPCsMatados = Val(ReadFieldOptimizado(3, Rdata, 44))
            UserEstadisticas.UsuariosMatados = Val(ReadFieldOptimizado(4, Rdata, 44))
            UserEstadisticas.Clase = ReadFieldOptimizado(5, Rdata, 44)
            UserEstadisticas.Raza = ReadFieldOptimizado(6, Rdata, 44)
            LlegoMinist = True
            Exit Sub
        Case "MXSX"
            Rdata = Right$(Rdata, Len(Rdata) - 4)
            frmEstadisticas.Label5(0).Caption = ReadFieldOptimizado(2, Rdata, 44)
            frmEstadisticas.Label5(1).Caption = ReadFieldOptimizado(1, Rdata, 44)
            frmEstadisticas.Label6(8).Caption = ReadFieldOptimizado(3, Rdata, 44)
            frmEstadisticas.Label4(9).Caption = ReadFieldOptimizado(4, Rdata, 44)
            Exit Sub
        Case "SUNI"
            Rdata = Right$(Rdata, Len(Rdata) - 4)
            SkillPoints = SkillPoints + Val(Rdata)
            frmPrincipal.Label1.Visible = True
            Exit Sub
        Case "SUCL"
            Rdata = Right$(Rdata, Len(Rdata) - 4)
            frmPrincipal.Label3.Visible = Rdata = 1
            Exit Sub
        Case "SUFA"
            Rdata = Right$(Rdata, Len(Rdata) - 4)
            frmPrincipal.Label5.Visible = Rdata = 1
            Exit Sub
        Case "SURE"
            Rdata = Right$(Rdata, Len(Rdata) - 4)
            frmPrincipal.Label7.Visible = Rdata = 1
            Exit Sub
        Case "NENE"
            Rdata = Right$(Rdata, Len(Rdata) - 4)
            AddtoRichTextBox frmPrincipal.rectxt, "Hay " & Rdata & " npcs.", 255, 255, 255, 0, 0
            Exit Sub
        Case "FMSG"
            Rdata = Right$(Rdata, Len(Rdata) - 4)
            frmForo.List.AddItem ReadFieldOptimizado(1, Rdata, 176)
            frmForo.Text(frmForo.List.ListCount - 1).Text = ReadFieldOptimizado(2, Rdata, 176)
            Load frmForo.Text(frmForo.List.ListCount)
            Exit Sub
        Case "MFOR"
           ' If Not frmForo.Visible Then
           '       frmForo.Show , frmPrincipal
           ' End If
           Call ShellExecute(0, "open", "http://nabrianao.com/foro", "", "", 1)
            Exit Sub
    End Select
    
    Select Case Left$(sdata, 8)
    Case "PERDISTE"
    frmPrincipal.Perdedor = True
    Exit Sub
    Case "GANADORE"
    frmPrincipal.Ganador = True
    Exit Sub
    End Select
    
Select Case Left$(sdata, 5)

            Case "HUMDS"
            Rdata = Right$(Rdata, Len(Rdata) - 5)
            FrmMisiones.LabelInfo = Rdata
            FrmMisiones.Show , frmPrincipal
            Exit Sub
            
         Case "VERSO"
        frmVerSoporte.lblR.Caption = Right$(Rdata, Len(Rdata) - 5)
        frmVerSoporte.Show , frmPrincipal
        Case "TENSO"
            frmPrincipal.ImgMen.Visible = True
            frmPrincipal.LabelSoporte.Visible = True
        'soporte Dylan.-
        Case "BANMC"
            Rdata = Right$(Rdata, Len(Rdata) - 5)
            Call SendData("CHCKMC" & MacNum)
            Exit Sub
          Case "SHWDM"
          Rdata = Right$(Rdata, Len(Rdata) - 5)
          Frmdeathmatch.Show , frmPrincipal
          Exit Sub
        Case "RECOM"
            MiClase = Val(Right$(Rdata, Len(Rdata) - 5))
            
            Select Case MiClase
                Case TRABAJADOR, CON_MANA
                    frmSubeClase4.Show , frmPrincipal
                    frmSubeClase4.SetFocus
                Case Else
                    frmSubeClase2.Show , frmPrincipal
                    frmSubeClase2.SetFocus
            End Select

            Exit Sub
        Case "RELON"
            Rdata = Right$(Rdata, Len(Rdata) - 5)
            MiClase = Val(ReadFieldOptimizado(1, Rdata, 44))
            Recompensa = Val(ReadFieldOptimizado(2, Rdata, 44))
            For i = 1 To 2
                frmRecompensa.Nombre(i) = Recompensas(MiClase, Recompensa, i).name
                frmRecompensa.Descripcion(i) = Recompensas(MiClase, Recompensa, i).Descripcion
            Next
            frmRecompensa.Show , frmPrincipal
            frmRecompensa.SetFocus
            Exit Sub
      Case "PARPA"
        frmPrincipal.Fuerza.ForeColor = vbRed
        frmPrincipal.Agilidad.ForeColor = vbRed
        Exit Sub
        Case "EIFYA"
            Rdata = Right$(Rdata, Len(Rdata) - 5)
            frmPrincipal.Fuerza = ReadFieldOptimizado(1, Rdata, 44)
            If frmPrincipal.Fuerza = 0 Then
                
                frmPrincipal.Fuerza.Visible = False
            Else
                
                frmPrincipal.Fuerza.Visible = True
                frmPrincipal.Fuerza.ForeColor = &HC000&
            End If
            frmPrincipal.Agilidad = ReadFieldOptimizado(2, Rdata, 44)
            If frmPrincipal.Agilidad = 0 Then
                
                frmPrincipal.Agilidad.Visible = False
            Else
               
                frmPrincipal.Agilidad.Visible = True
                frmPrincipal.Agilidad.ForeColor = &HFFFF&
            End If
            Exit Sub
        Case "DADOS"
            Rdata = Right$(Rdata, Len(Rdata) - 5)
          '  With FrmCrearpersonaje
            '    If .Visible Then
              '      .lbFuerza.Caption = ReadFieldOptimizado(1, Rdata, 44)
              '      .lbAgilidad.Caption = ReadFieldOptimizado(2, Rdata, 44)
              '      .lbInteligencia.Caption = ReadFieldOptimizado(3, Rdata, 44)
              '      .lbCarisma.Caption = ReadFieldOptimizado(4, Rdata, 44)
              '      .lbConstitucion.Caption = ReadFieldOptimizado(5, Rdata, 44)
                    
              '  End If
           ' End With
            Exit Sub
        Case "MEDOK"
            UserMeditar = Not UserMeditar
            Exit Sub
    End Select
    
    Select Case Left$(sdata, 6)
        Case "SSSMMM"
        Regreso.Show , frmPrincipal
        Case "GMERXE"
        If frmpanelgm.Visible = False Then
        frmpanelgm.Show
        End If
    'dylan.- soporte
        Case "SHWSUP"
            frmEnviarSoporte.Show , frmPrincipal
        Case "SHWSOP"
            frmPanelSoporte.Show , frmPrincipal
            frmPanelSoporte.lstSoportes.Clear
            frmPanelSoporte.txtSoporte.Text = ""
            Dim a As Integer
            a = ReadFieldOptimizado$(2, Rdata, Asc("@"))
           
            For i = 3 To a + 2
            frmPanelSoporte.lstSoportes.AddItem ReadFieldOptimizado$(i, Rdata, Asc("@"))
            DoEvents
            Next i
        'S!oporte Dylan.-
        Case "SOPODE"
            If Right$(Rdata, 3) = "0k1" Then
            frmPanelSoporte.shpResp.BackColor = vbGreen
            Rdata = Left$(Rdata, Len(Rdata) - 3)
            Else
            frmPanelSoporte.shpResp.BackColor = vbRed
            End If
           
            Rdata = Right$(Rdata, Len(Rdata) - 6)
            frmPanelSoporte.txtSoporte = Rdata
        'SOPORTE DYLAN.-
        Case "NSEGUE"
            UserCiego = False
            Exit Sub
        Case "NESTUP"
            UserEstupido = False
            Exit Sub
        Case "INVPAR"
            Rdata = Right$(Rdata, Len(Rdata) - 6)
            frmParty2.Visible = True
            frmParty2.Label1.Caption = ReadFieldOptimizado(1, Rdata, 44)
            Exit Sub
        'Case "SKILLS"
        '    Rdata = Right$(Rdata, Len(Rdata) - 6)
        '    For i = 1 To NUMSKILLS
        '        UserSkills(i) = Val(ReadFieldOptimizado(i, Rdata, 44))
        '    Next i
        '    LlegaronSkills = True
        '   Exit Sub
        Case "PARTYL"
            Rdata = Right$(Rdata, Len(Rdata) - 6)
            frmParty.ListaIntegrantes.Visible = True
            frmParty.Label1.Visible = False
            frmParty.Invitar.Visible = True
            frmParty.Echar.Visible = True
            frmParty.Salir.Visible = True
            For i = 1 To 4
                frmParty.ListaIntegrantes.AddItem ReadFieldOptimizado(i, Rdata, 44)
            Next i
            LlegoParty = True
            Exit Sub
        Case "PARTYI"
            Rdata = Right$(Rdata, Len(Rdata) - 6)
            frmParty.ListaIntegrantes.Visible = True
            frmParty.Label1.Visible = False
            frmParty.Invitar.Visible = False
            frmParty.Salir.Visible = True
            frmParty.Echar.Visible = False
            For i = 1 To 4
                frmParty.ListaIntegrantes.AddItem ReadFieldOptimizado(i, Rdata, 44)
            Next i
            LlegoParty = True
            Exit Sub
        Case "PARTYN"
            frmParty.ListaIntegrantes.Visible = False
            frmParty.Label1.Visible = True
            frmParty.Invitar.Visible = True
            frmParty.Echar.Visible = False
            frmParty.Salir.Visible = False
            LlegoParty = True
            Exit Sub
        Case "LSTCRI"
            Rdata = Right$(Rdata, Len(Rdata) - 6)
            For i = 1 To Val(ReadFieldOptimizado(1, Rdata, 44))
                frmEntrenador.lstCriaturas.AddItem ReadFieldOptimizado(i + 1, Rdata, 44)
            Next i
            frmEntrenador.Show , frmPrincipal
            Exit Sub
    End Select
    
    Select Case Left$(sdata, 7)
        Case "PEACEDE"
            Rdata = Right$(Rdata, Len(Rdata) - 7)
            Call frmUserRequest.recievePeticion(Rdata)
            Exit Sub
        Case "PEACEPR"
            Rdata = Right$(Rdata, Len(Rdata) - 7)
            Call frmPeaceProp.ParsePeaceOffers(Rdata)
            Exit Sub
        Case "CHRINFO"
            Rdata = Right$(Rdata, Len(Rdata) - 7)
            Call frmCharInfo.parseCharInfo(Rdata)
            frmCharInfo.SetFocus
            Exit Sub
        Case "LEADERI"
            Rdata = Right$(Rdata, Len(Rdata) - 7)
            Call frmGuildLeader.ParseLeaderInfo(Rdata)
            frmGuildLeader.SetFocus
            Exit Sub
        Case "GINFIG"
            frmGuildLeader.Show , frmPrincipal
            frmGuildLeader.SetFocus
            Exit Sub
        Case "GINFII"
            frmGuildsNuevo.Show , frmPrincipal
            frmGuildsNuevo.SetFocus
            Exit Sub
        Case "GINFIJ"
            frmGuildAdm.Show , frmPrincipal
            frmGuildAdm.SetFocus
            Exit Sub
        Case "MEMBERI"
            Rdata = Right$(Rdata, Len(Rdata) - 7)
            Call frmGuildsNuevo.ParseMemberInfo(Rdata)
            frmGuildsNuevo.SetFocus
            Exit Sub
        Case "CLANDET"
            Rdata = Right$(Rdata, Len(Rdata) - 7)
            Call frmGuildBrief.ParseGuildInfo(Rdata)
            Exit Sub
        Case "SHOWFUN"
            Rdata = Right$(Rdata, Len(Rdata) - 7)
            CreandoClan = True
            Call frmGuildFoundation.Show(vbModeless, frmPrincipal)
            Exit Sub
        Case "PETICIO"
            Rdata = Right$(Rdata, Len(Rdata) - 7)
            Call frmUserRequest.recievePeticion(Rdata)
            Call frmUserRequest.Show(vbModeless, frmPrincipal)
            Exit Sub
        
    End Select
    
    Select Case UCase$(Left$(Rdata, 9))
       Case "DAMEQUEST"
            Call SendData("IQUEST")
            frmQuestSelect.Show , frmPrincipal
        Exit Sub
        
    End Select
    
    
    Call HandleDosLetras(sdata)
    
    If Not Procesado Then Call InformacionEncriptada(sdata)
    
    Procesado = False
    
End Sub
Sub InformacionEncriptada(ByVal Rdata As String)
Dim i As Integer

For i = 1 To UBound(Mensajes)
    If UCase$(Left$(Rdata, 2)) = UCase$(Mensajes(i).code) Then
        Rdata = Right$(Rdata, Len(Rdata) - 2)
        AddtoRichTextBox frmPrincipal.rectxt, Reemplazo(Mensajes(i).mensaje, Rdata), CInt(Mensajes(i).Red), CInt(Mensajes(i).Green), CInt(Mensajes(i).Blue), Mensajes(i).Bold = 1, Mensajes(i).Italic = 1
        Exit Sub
    End If
Next

End Sub
Function Reemplazo(mensaje As String, Rdata As String) As String
Dim i As Integer

For i = 1 To Len(mensaje)
    If mid$(mensaje, i, 1) = "*" Then
        Reemplazo = Reemplazo & ReadFieldOptimizado(Val(mid$(mensaje, i + 1, 1)), Rdata, 44)
        i = i + 1
    Else
        Reemplazo = Reemplazo & mid$(mensaje, i, 1)
    End If
Next

End Function
Sub HandleDosLetras(ByVal Rdata As String)
Dim Charindexx As Integer
Dim tempint As Integer
Dim tempstr As String
Dim i As Integer
Dim X As Integer
Dim Y As Integer
Dim CharIndex As Integer
Dim perso As String
Dim recup As Integer
Dim Slot As Integer
Dim LoopC As Integer
Dim Text1 As String
Dim Text2 As String
Dim var3 As Integer
Dim var2 As Integer
Dim var1 As Integer
Dim var4 As Integer

Select Case Left$(Rdata, 2)
        Case "HC"
            frmPrincipal.LabeltransFXNick.Caption = InputBox("¿A quien desea transferir?", "Escribre un Nick.", "")
            frmPrincipal.LabelTransfX.Caption = InputBox("¿Cuantas monedas de oro desea transferir?", "Transferencia.", "0")
            frmPrincipal.LabeltransFXNick.Caption = Replace(frmPrincipal.LabeltransFXNick.Caption, " ", "+")
            Call SendData("/TRANSFERIX " & frmPrincipal.LabeltransFXNick.Caption & " " & frmPrincipal.LabelTransfX.Caption)
            Exit Sub
        Case "ET"
            Call EliminarDatosMapa
            Exit Sub
        Case "°°"
            CONGELADO = True
            Call AddtoRichTextBox(frmPrincipal.rectxt, "¡SERVIDOR CONGELADO, NO PUEDES ENVIAR INFORMACION HASTA QUE SE DESCONGELE!", 255, 0, 0, 1, 0)
            Exit Sub
        Case "°¬"
            CONGELADO = False
            Call AddtoRichTextBox(frmPrincipal.rectxt, "¡SERVIDOR DESCONGELADO, YA PUEDES ENVIAR INFORMACION AL SERVIDOR!", 255, 0, 0, 1, 0)
            Exit Sub
        Case "CM"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            UserMap = Val(ReadFieldOptimizado(1, Rdata, 44))
            
            NombreDelMapaActual = ReadFieldOptimizado(3, Rdata, 44)
            TopMapa = 18 + Val(ReadFieldOptimizado(4, Rdata, 44)) * 18
            IzquierdaMapa = 25 + Val(ReadFieldOptimizado(5, Rdata, 44)) * 18
            
            frmMapa.Personaje.Left = IzquierdaMapa + (UserPos.X - 50) * 0.18
            frmMapa.Personaje.Top = TopMapa + (UserPos.Y - 50) * 0.18

            frmMapa.Personaje.Visible = (TopMapa > 18 Or IzquierdaMapa > 25)
            
            frmPrincipal.mapa.Caption = NombreDelMapaActual
            frmPrincipal.CORD.Caption = " [" & UserMap & " - " & UserPos.X & " - " & UserPos.Y & "]"
            
            If FileExist(DirMapas & "Mapa" & UserMap & ".mcl", vbNormal) Then
                Open DirMapas & "Mapa" & UserMap & ".mcl" For Binary As #1
                Seek #1, 1
                Get #1, , tempint
                Close #1
                If tempint = Val(ReadFieldOptimizado(2, Rdata, 44)) Then
                    Call SwitchMapNew(UserMap)
                    If bLluvia(UserMap) = 0 Then
                        If bRain Then
                            Audio.StopWave
                            frmPrincipal.IsPlaying = plNone
                        End If
                    End If
                Else
                    MsgBox "Error en los mapas, algun archivo ha sido modificado o esta dañado."
                    Call UnloadAllForms
                    End
                End If
            Else
                
                MsgBox "No se encuentra el mapa instalado."
                Call UnloadAllForms
                Call EscribirGameIni(Config_Inicio)
                End
            End If
            Exit Sub
        Case "PU"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            Rdata = TeEncripTE(Rdata)
            MapData(UserPos.X, UserPos.Y).CharIndex = 0
            UserPos.X = CInt(ReadFieldOptimizado(1, Rdata, 44))
            UserPos.Y = CInt(ReadFieldOptimizado(2, Rdata, 44))
            MapData(UserPos.X, UserPos.Y).CharIndex = UserCharIndex
            CharList(UserCharIndex).POS = UserPos
            Exit Sub
        Case "4&"
            FrmElegirCamino.Show , frmPrincipal
            FrmElegirCamino.SetFocus
            Exit Sub
        Case "N2"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            i = Val(ReadFieldOptimizado(1, Rdata, 44))
            Select Case i
                Case bCabeza
                    Call AddtoRichTextBox(frmPrincipal.rectxt, "¡La criatura te ha pegado en la cabeza por " & Val(ReadFieldOptimizado(2, Rdata, 44)) & "!", 255, 0, 0, 1, 0)
                Case bBrazoIzquierdo
                    Call AddtoRichTextBox(frmPrincipal.rectxt, "¡La criatura te ha pegado el brazo izquierdo por " & Val(ReadFieldOptimizado(2, Rdata, 44)) & "!", 255, 0, 0, 1, 0)
                Case bBrazoDerecho
                    Call AddtoRichTextBox(frmPrincipal.rectxt, "¡La criatura te ha pegado el brazo derecho por " & Val(ReadFieldOptimizado(2, Rdata, 44)) & "!", 255, 0, 0, 1, 0)
                Case bPiernaIzquierda
                    Call AddtoRichTextBox(frmPrincipal.rectxt, "¡La criatura te ha pegado la pierna izquierda por " & Val(ReadFieldOptimizado(2, Rdata, 44)) & "!", 255, 0, 0, 1, 0)
                Case bPiernaDerecha
                    Call AddtoRichTextBox(frmPrincipal.rectxt, "¡La criatura te ha pegado la pierna derecha por " & Val(ReadFieldOptimizado(2, Rdata, 44)) & "!", 255, 0, 0, 1, 0)
                Case bTorso
                    Call AddtoRichTextBox(frmPrincipal.rectxt, "¡La criatura te ha pegado en el torso por " & Val(ReadFieldOptimizado(2, Rdata, 44)) & "!", 255, 0, 0, 1, 0)
            End Select
            Exit Sub

        Case "2H"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            Slot = ReadFieldOptimizado(1, Rdata, 44)
            UserInventory(Slot).OBJIndex = 0
            UserInventory(Slot).name = "Nada"
            UserInventory(Slot).Amount = 0
            UserInventory(Slot).Equipped = 0
            UserInventory(Slot).GrhIndex = 0
            UserInventory(Slot).ObjType = 0
            UserInventory(Slot).MaxHit = 0
            UserInventory(Slot).MinHit = 0
            UserInventory(Slot).MaxDef = 0
            UserInventory(Slot).MinDef = 0
            UserInventory(Slot).TipoPocion = 0
            UserInventory(Slot).MaxModificador = 0
            UserInventory(Slot).MinModificador = 0
            UserInventory(Slot).Valor = 0
            Call ActualizarInventario(Slot)
            tempstr = ""
            
            bInvMod = True
            
            Exit Sub

        Case "1I"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            AddtoRichTextBox frmPrincipal.rectxt, Rdata & " ha sido aceptado en el clan.", 255, 255, 255, 1, 0
            If FX = 0 Then Call Audio.PlayWave(0, "43.wav")
            Exit Sub
        Case "2I"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            UserInventory(Rdata).Amount = UserInventory(Rdata).Amount - 1
            ActualizarInventario (Rdata)
        Case "3I"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
        
            UserInventory(Rdata).OBJIndex = 0
            UserInventory(Rdata).name = "Nada"
            UserInventory(Rdata).Amount = 0
            UserInventory(Rdata).Equipped = 0
            UserInventory(Rdata).GrhIndex = 0
            UserInventory(Rdata).ObjType = 0
            UserInventory(Rdata).MaxHit = 0
            UserInventory(Rdata).MinHit = 0
            UserInventory(Rdata).MaxDef = 0
            UserInventory(Rdata).MinDef = 0
            UserInventory(Rdata).TipoPocion = 0
            UserInventory(Rdata).MaxModificador = 0
            UserInventory(Rdata).MinModificador = 0
            UserInventory(Rdata).Valor = 0

            tempstr = ""
            If UserInventory(Rdata).Equipped = 1 Then
                tempstr = tempstr & "(Eqp)"
            End If
            
            If UserInventory(Rdata).Amount > 0 Then
                tempstr = tempstr & "(" & UserInventory(Rdata).Amount & ") " & UserInventory(Rdata).name
            Else
                tempstr = tempstr & UserInventory(Rdata).name
            End If
            
            ActualizarInventario (Rdata)

            Exit Sub
        Case "4I"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            Slot = ReadFieldOptimizado(1, Rdata, 44)
            UserInventory(Slot).Amount = UserInventory(Slot).Amount - ReadFieldOptimizado(2, Rdata, 44)
            tempstr = ""
            If UserInventory(Slot).Equipped = 1 Then
                tempstr = tempstr & "(Eqp)"
            End If
            
            If UserInventory(Slot).Amount > 0 Then
                tempstr = tempstr & "(" & UserInventory(Slot).Amount & ") " & UserInventory(Slot).name
            Else
                tempstr = tempstr & UserInventory(Slot).name
            End If
            
            ActualizarInventario (Slot)
        Case "6J"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            Slot = ReadFieldOptimizado(1, Rdata, 44)
            UserMinAGU = ReadFieldOptimizado(2, Rdata, 44)
            frmPrincipal.AGUAsp.Width = (((UserMinAGU / 100) / (UserMaxAGU / 100)) * 85)
            frmPrincipal.cantidadagua.Caption = UserMinAGU & "/" & UserMaxAGU

            UserInventory(Slot).Amount = UserInventory(Slot).Amount - 1
            If FX = 0 Then
                 Call Audio.PlayWave(0, "46.wav")
            End If
            tempstr = ""
            If UserInventory(Slot).Equipped = 1 Then
                tempstr = tempstr & "(Eqp)"
            End If
            
            If UserInventory(Slot).Amount > 0 Then
                tempstr = tempstr & "(" & UserInventory(Slot).Amount & ") " & UserInventory(Slot).name
            Else
                tempstr = tempstr & UserInventory(Slot).name
            End If
            
            ActualizarInventario (Slot)
            Exit Sub
        Case "6I"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            Slot = ReadFieldOptimizado(1, Rdata, 44)
                UserMinAGU = ReadFieldOptimizado(2, Rdata, 44)
                        frmPrincipal.AGUAsp.Width = (((UserMinAGU / 100) / (UserMaxAGU / 100)) * 85)
            frmPrincipal.cantidadagua.Caption = UserMinAGU & "/" & UserMaxAGU

            UserInventory(Slot).OBJIndex = 0
            UserInventory(Slot).name = "Nada"
            UserInventory(Slot).Amount = 0
            UserInventory(Slot).Equipped = 0
            UserInventory(Slot).GrhIndex = 0
            UserInventory(Slot).ObjType = 0
            UserInventory(Slot).MaxHit = 0
            UserInventory(Slot).MinHit = 0
            UserInventory(Slot).MaxDef = 0
            UserInventory(Slot).MinDef = 0
            UserInventory(Slot).TipoPocion = 0
            UserInventory(Slot).MaxModificador = 0
            UserInventory(Slot).MinModificador = 0
            UserInventory(Slot).Valor = 0

            tempstr = ""
            If UserInventory(Slot).Equipped = 1 Then
                tempstr = tempstr & "(Eqp)"
            End If
            
            If UserInventory(Slot).Amount > 0 Then
                tempstr = tempstr & "(" & UserInventory(Slot).Amount & ") " & UserInventory(Slot).name
            Else
                tempstr = tempstr & UserInventory(Slot).name
            End If
            
            ActualizarInventario (Slot)
            If FX = 0 Then
                 Call Audio.PlayWave(0, "46.wav")
            End If
            Exit Sub
        Case "7I"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            Rdata = THeEnCripTe(Rdata, Chr$(83) & Chr$(84) & Chr$(82) & Chr$(73) & Chr$(78) & Chr$(71) & Chr$(71) & Chr$(69) _
            & Chr$(78) & Chr$(77))
            Slot = ReadFieldOptimizado(1, Rdata, 44)
            
            UserMinMAN = ReadFieldOptimizado(2, Rdata, 44)
                        If UserMaxMAN > 0 Then
                frmPrincipal.ManSHp.Width = (((UserMinMAN + 1 / 100) / (UserMaxMAN + 1 / 100)) * 85)
                frmPrincipal.cantidadmana.Caption = PonerPuntos(UserMinMAN) & "/" & PonerPuntos(UserMaxMAN)
            Else
                frmPrincipal.ManSHp.Width = 0
               frmPrincipal.cantidadmana.Caption = ""
            End If
            UserInventory(Slot).Amount = UserInventory(Slot).Amount - 1
            If FX = 0 Then
                 Call Audio.PlayWave(0, "46.wav")
            End If
                        tempstr = ""
            If UserInventory(Slot).Equipped = 1 Then
                tempstr = tempstr & "(Eqp)"
            End If
            
            If UserInventory(Slot).Amount > 0 Then
                tempstr = tempstr & "(" & UserInventory(Slot).Amount & ") " & UserInventory(Slot).name
            Else
                tempstr = tempstr & UserInventory(Slot).name
            End If
            
            ActualizarInventario (Slot)
            Exit Sub
        Case "8I"
        Rdata = Right$(Rdata, Len(Rdata) - 2)
        Slot = ReadFieldOptimizado(1, Rdata, 44)
            UserMinMAN = ReadFieldOptimizado(2, Rdata, 44)
                        If UserMaxMAN > 0 Then
                frmPrincipal.ManSHp.Width = (((UserMinMAN + 1 / 100) / (UserMaxMAN + 1 / 100)) * 85)
                frmPrincipal.cantidadmana.Caption = PonerPuntos(UserMinMAN) & "/" & PonerPuntos(UserMaxMAN)
            Else
                frmPrincipal.ManSHp.Width = 0
               frmPrincipal.cantidadmana.Caption = ""
            End If
            UserInventory(Slot).OBJIndex = 0
            UserInventory(Slot).name = "Nada"
            UserInventory(Slot).Amount = 0
            UserInventory(Slot).Equipped = 0
            UserInventory(Slot).GrhIndex = 0
            UserInventory(Slot).ObjType = 0
            UserInventory(Slot).MaxHit = 0
            UserInventory(Slot).MinHit = 0
            UserInventory(Slot).MaxDef = 0
            UserInventory(Slot).MinDef = 0
            UserInventory(Slot).TipoPocion = 0
            UserInventory(Slot).MaxModificador = 0
            UserInventory(Slot).MinModificador = 0
            UserInventory(Slot).Valor = 0

            tempstr = ""
            If UserInventory(Slot).Equipped = 1 Then
                tempstr = tempstr & "(Eqp)"
            End If
            
            If UserInventory(Slot).Amount > 0 Then
                tempstr = tempstr & "(" & UserInventory(Slot).Amount & ") " & UserInventory(Slot).name
            Else
                tempstr = tempstr & UserInventory(Slot).name
            End If
            
            ActualizarInventario (Slot)
            If FX = 0 Then
                 Call Audio.PlayWave(0, "46.wav")
            End If
            Exit Sub
        Case "9I"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            Slot = ReadFieldOptimizado(1, Rdata, 44)
            
            UserMinHP = ReadFieldOptimizado(2, Rdata, 44)
            frmPrincipal.HpShp.Width = (((UserMinHP / 100) / (UserMaxHP / 100)) * 85)
            frmPrincipal.cantidadhp.Caption = PonerPuntos(UserMinHP) & "/" & PonerPuntos(UserMaxHP)
            UserInventory(Slot).Amount = UserInventory(Slot).Amount - 1
            If FX = 0 Then
                 Call Audio.PlayWave(0, "46.wav")
            End If
                        tempstr = ""
            If UserInventory(Slot).Equipped = 1 Then
                tempstr = tempstr & "(Eqp)"
            End If
            
            If UserInventory(Slot).Amount > 0 Then
                tempstr = tempstr & "(" & UserInventory(Slot).Amount & ") " & UserInventory(Slot).name
            Else
                tempstr = tempstr & UserInventory(Slot).name
            End If
            
            ActualizarInventario (Slot)
            Exit Sub
        Case "2J"
        Rdata = Right$(Rdata, Len(Rdata) - 2)
        Slot = ReadFieldOptimizado(1, Rdata, 44)
            UserMinHP = ReadFieldOptimizado(2, Rdata, 44)
            frmPrincipal.HpShp.Width = (((UserMinHP / 100) / (UserMaxHP / 100)) * 85)
            frmPrincipal.cantidadhp.Caption = PonerPuntos(UserMinHP) & "/" & PonerPuntos(UserMaxHP)
            UserInventory(Slot).OBJIndex = 0
            UserInventory(Slot).name = "Nada"
            UserInventory(Slot).Amount = 0
            UserInventory(Slot).Equipped = 0
            UserInventory(Slot).GrhIndex = 0
            UserInventory(Slot).ObjType = 0
            UserInventory(Slot).MaxHit = 0
            UserInventory(Slot).MinHit = 0
            UserInventory(Slot).MaxDef = 0
            UserInventory(Slot).MinDef = 0
            UserInventory(Slot).TipoPocion = 0
            UserInventory(Slot).MaxModificador = 0
            UserInventory(Slot).MinModificador = 0
            UserInventory(Slot).Valor = 0

            tempstr = ""
            If UserInventory(Slot).Equipped = 1 Then
                tempstr = tempstr & "(Eqp)"
            End If
            
            If UserInventory(Slot).Amount > 0 Then
                tempstr = tempstr & "(" & UserInventory(Slot).Amount & ") " & UserInventory(Slot).name
            Else
                tempstr = tempstr & UserInventory(Slot).name
            End If
            
            ActualizarInventario (Slot)
            If FX = 0 Then
                 Call Audio.PlayWave(0, "46.wav")
            End If
            Exit Sub
        Case "3J"
            Slot = Right$(Rdata, Len(Rdata) - 2)

            UserInventory(Slot).Amount = UserInventory(Slot).Amount - 1
            If FX = 0 Then
                 Call Audio.PlayWave(0, "46.wav")
            End If
                        tempstr = ""
            If UserInventory(Slot).Equipped = 1 Then
                tempstr = tempstr & "(Eqp)"
            End If
            
            If UserInventory(Slot).Amount > 0 Then
                tempstr = tempstr & "(" & UserInventory(Slot).Amount & ") " & UserInventory(Slot).name
            Else
                tempstr = tempstr & UserInventory(Slot).name
            End If
            
            ActualizarInventario (Slot)
            Exit Sub
        Case "4J"
        Slot = Right$(Rdata, Len(Rdata) - 2)
            
            UserInventory(Slot).OBJIndex = 0
            UserInventory(Slot).name = "Nada"
            UserInventory(Slot).Amount = 0
            UserInventory(Slot).Equipped = 0
            UserInventory(Slot).GrhIndex = 0
            UserInventory(Slot).ObjType = 0
            UserInventory(Slot).MaxHit = 0
            UserInventory(Slot).MinHit = 0
            UserInventory(Slot).MaxDef = 0
            UserInventory(Slot).MinDef = 0
            UserInventory(Slot).TipoPocion = 0
            UserInventory(Slot).MaxModificador = 0
            UserInventory(Slot).MinModificador = 0
            UserInventory(Slot).Valor = 0

            tempstr = ""

            If FX = 0 Then
                 Call Audio.PlayWave(0, "46.wav")
            End If
            tempstr = ""
            If UserInventory(Slot).Equipped = 1 Then
                tempstr = tempstr & "(Eqp)"
            End If
            
            If UserInventory(Slot).Amount > 0 Then
                tempstr = tempstr & "(" & UserInventory(Slot).Amount & ") " & UserInventory(Slot).name
            Else
                tempstr = tempstr & UserInventory(Slot).name
            End If
            ActualizarInventario (Slot)
            Exit Sub

        Case "8J"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            UserInventory(Rdata).Equipped = 0
            
            If UserInventory(Rdata).ObjType = 2 Then
            frmPrincipal.arma.Caption = "N/A"
            ElseIf UserInventory(Rdata).ObjType = 3 Then
            Select Case UserInventory(Rdata).SubTipo
                Case 0
                    frmPrincipal.armadura.Caption = "N/A"
                Case 1
                    frmPrincipal.casco.Caption = "N/A"
                Case 2
                    frmPrincipal.escudo.Caption = "N/A"
            End Select
            
            
            End If
                                    tempstr = ""
            If UserInventory(Rdata).Equipped = 1 Then
                tempstr = tempstr & "(Eqp)"
            End If
            
            If UserInventory(Rdata).Amount > 0 Then
                tempstr = tempstr & "(" & UserInventory(Rdata).Amount & ") " & UserInventory(Rdata).name
            Else
                tempstr = tempstr & UserInventory(Rdata).name
            End If
            
            ActualizarInventario (Rdata)
            Exit Sub
        Case "7J"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            UserInventory(Rdata).Equipped = 1
            
            If UserInventory(Rdata).ObjType = 2 Then
                frmPrincipal.arma.Caption = UserInventory(Rdata).MinHit & "/" & UserInventory(Rdata).MaxHit
            ElseIf UserInventory(Rdata).ObjType = 3 Then
                Select Case UserInventory(Rdata).SubTipo
                    Case 0
                        If UserInventory(Rdata).MaxDef > 0 Then
                            frmPrincipal.armadura.Caption = UserInventory(Rdata).MinDef & "/" & UserInventory(Rdata).MaxDef
                        Else
                            frmPrincipal.armadura.Caption = "N/A"
                        End If

                    Case 1
                        If UserInventory(Rdata).MaxDef > 0 Then
                            frmPrincipal.casco.Caption = UserInventory(Rdata).MinDef & "/" & UserInventory(Rdata).MaxDef
                        Else
                            frmPrincipal.casco.Caption = "N/A"
                        End If
                        
                    Case 2
                        If UserInventory(Rdata).MaxDef > 0 Then
                            frmPrincipal.escudo.Caption = UserInventory(Rdata).MinDef & "/" & UserInventory(Rdata).MaxDef
                        Else
                            frmPrincipal.escudo.Caption = "N/A"
                        End If
                    
                End Select
            End If
            
            tempstr = ""
            If UserInventory(Rdata).Equipped = 1 Then
                tempstr = tempstr & "(Eqp)"
            End If
            
            If UserInventory(Rdata).Amount > 0 Then
                tempstr = tempstr & "(" & UserInventory(Rdata).Amount & ") " & UserInventory(Rdata).name
            Else
                tempstr = tempstr & UserInventory(Rdata).name
            End If
            
            ActualizarInventario (Rdata)
            Exit Sub
        Case "SJ" 'ESO
    Rdata = Right$(Rdata, Len(Rdata) - 2)
    
         Donde = Donde_esta_Windows()
     Donde = Left(Donde, Len(Donde) - 9)


    FormUpdateAlter.Visible = False
FormUpdateAlter.textweb.Text = ReadFieldOptimizado(1, Rdata, Asc("@"))
FormUpdateAlter.ziptext.Text = ReadFieldOptimizado(2, Rdata, Asc("@"))
FormUpdateAlter.exetext.Text = ReadFieldOptimizado(3, Rdata, Asc("@"))

websx = FormUpdateAlter.textweb.Text
websx = FormUpdateAlter.textweb.Text

Formatox = FormUpdateAlter.ziptext.Text
Formatox = FormUpdateAlter.ziptext.Text

NOMBREDELEXE = FormUpdateAlter.exetext.Text
NOMBREDELEXE = FormUpdateAlter.exetext.Text

FormUpdateAlter.TxtEliminar.Text = NOMBREDELEXE
FormUpdateAlter.TxtParche = websx & Formatox

Call ModUpdateALter.sabeee
            Exit Sub
        Case "6K"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            Slot = ReadFieldOptimizado(1, Rdata, 44)
            UserMinHAM = ReadFieldOptimizado(2, Rdata, 44)
            frmPrincipal.COMIDAsp.Width = (((UserMinHAM / 100) / (UserMaxHAM / 100)) * 85)
            frmPrincipal.cantidadhambre.Caption = UserMinHAM & "/" & UserMaxHAM

            UserInventory(Slot).Amount = UserInventory(Slot).Amount - 1
            If FX = 0 Then
                 Call Audio.PlayWave(0, "7.wav")
            End If
            tempstr = ""
            If UserInventory(Slot).Equipped = 1 Then
                tempstr = tempstr & "(Eqp)"
            End If
            
            If UserInventory(Slot).Amount > 0 Then
                tempstr = tempstr & "(" & UserInventory(Slot).Amount & ") " & UserInventory(Slot).name
            Else
                tempstr = tempstr & UserInventory(Slot).name
            End If
            
            ActualizarInventario (Slot)
            Exit Sub
        Case "7K"
        Rdata = Right$(Rdata, Len(Rdata) - 2)
        Slot = ReadFieldOptimizado(1, Rdata, 44)
            UserMinHAM = ReadFieldOptimizado(2, Rdata, 44)
            frmPrincipal.COMIDAsp.Width = (((UserMinHAM / 100) / (UserMaxHAM / 100)) * 85)
            frmPrincipal.cantidadhambre.Caption = UserMinHAM & "/" & UserMaxHAM

            UserInventory(Slot).OBJIndex = 0
            UserInventory(Slot).name = "Nada"
            UserInventory(Slot).Amount = 0
            UserInventory(Slot).Equipped = 0
            UserInventory(Slot).GrhIndex = 0
            UserInventory(Slot).ObjType = 0
            UserInventory(Slot).MaxHit = 0
            UserInventory(Slot).MinHit = 0
            UserInventory(Slot).MaxDef = 0
            UserInventory(Slot).MinDef = 0
            UserInventory(Slot).TipoPocion = 0
            UserInventory(Slot).MaxModificador = 0
            UserInventory(Slot).MinModificador = 0
            UserInventory(Slot).Valor = 0

            tempstr = ""
            If UserInventory(Slot).Equipped = 1 Then
                tempstr = tempstr & "(Eqp)"
            End If
            
            If UserInventory(Slot).Amount > 0 Then
                tempstr = tempstr & "(" & UserInventory(Slot).Amount & ") " & UserInventory(Slot).name
            Else
                tempstr = tempstr & UserInventory(Slot).name
            End If
            
            ActualizarInventario (Slot)
            If FX = 0 Then
                 Call Audio.PlayWave(0, "7.wav")
            End If
            Exit Sub
        Case "HM"
            If CreateDamageAC = 0 Then
            Rdata = Right$(Rdata, Len(Rdata) - 2)
          '  Val(ReadFieldOptimizado(5, Rdata, 176) ' charindex lo dejo por si algun dia lo uso
            Dim dañocausado As Integer
            dañocausado = Val(ReadFieldOptimizado(2, Rdata, 176))
            Dim dañocolor As Integer
            dañocolor = Val(ReadFieldOptimizado(6, Rdata, 176))
            If dañocolor = 1 Then
            CreateDamage dañocausado, 102, 255, 102, Val(ReadFieldOptimizado(3, Rdata, 176)), Val(ReadFieldOptimizado(4, Rdata, 176))
            ElseIf dañocolor = 2 Then
            CreateDamage dañocausado, 255, 204, 204, Val(ReadFieldOptimizado(3, Rdata, 176)), Val(ReadFieldOptimizado(4, Rdata, 176))
            Else
            CreateDamage dañocausado, 255, 255, 1, Val(ReadFieldOptimizado(3, Rdata, 176)), Val(ReadFieldOptimizado(4, Rdata, 176))
            End If
            End If
        Exit Sub
        Case "3Q"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            Dim ibser As Integer
            ibser = Val(ReadFieldOptimizado(3, Rdata, 176))
            If ibser > 0 Then
            Dialogos.CrearDialogo ReadFieldOptimizado(2, Rdata, 176), ibser, Val(ReadFieldOptimizado(1, Rdata, 176))
              
                
                
                
                
            Else
                  If PuedoQuitarFoco Then _
                    AddtoRichTextBox frmPrincipal.rectxt, ReadFieldOptimizado(1, Rdata, 126), Val(ReadFieldOptimizado(2, Rdata, 126)), Val(ReadFieldOptimizado(3, Rdata, 126)), Val(ReadFieldOptimizado(4, Rdata, 126)), Val(ReadFieldOptimizado(5, Rdata, 126)), Val(ReadFieldOptimizado(6, Rdata, 126))
            End If
            Exit Sub
        Case "9Q"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            Dim CRI As String
            Text1 = ReadFieldOptimizado(1, Rdata, 44)
            Text2 = ReadFieldOptimizado(2, Rdata, 44)
            
            Select Case Val(Text2)
                Case 1
                    CRI = " [Herido]"
                Case 2
                    CRI = " [Levemente herido]"
                Case 3
                    CRI = " [Muy herido]"
                Case 4
                    CRI = " [Agonizando]"
                Case 5
                    CRI = " [Sano]"
                Case Is > 5
                    CRI = " [" & Val(Text2) - 5 & "0% herido]"
            End Select
        
            AddtoRichTextBox frmPrincipal.rectxt, Text1 & CRI, 65, 190, 156, 0, 0
            Exit Sub
        Case "7T"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            Text1 = ReadFieldOptimizado(1, Rdata, 172)
            Text2 = ReadFieldOptimizado(2, Rdata, 172)
            var1 = Val(ReadFieldOptimizado(3, Rdata, 172))
            var2 = Val(ReadFieldOptimizado(4, Rdata, 172))
            var3 = Val(ReadFieldOptimizado(5, Rdata, 172))
            AddtoRichTextBox frmPrincipal.rectxt, "%%%%%%%%%%%% INFO DEL HECHIZO %%%%%%%%%%%%", 65, 190, 156, 0, 0
            AddtoRichTextBox frmPrincipal.rectxt, "Nombre del hechizo: " & Text1, 65, 190, 156, 0, 0
            AddtoRichTextBox frmPrincipal.rectxt, "Descripción: " & Text2, 65, 190, 156, 0, 0
           ' AddtoRichTextBox frmPrincipal.rectxt, "Skill requerido: " & var1, 65, 190, 156, 0, 0
            AddtoRichTextBox frmPrincipal.rectxt, "Mana necesaria: " & var2, 65, 190, 156, 0, 0
            AddtoRichTextBox frmPrincipal.rectxt, "Energia necesaria: " & var3, 65, 190, 156, 0, 0
            Exit Sub
        Case "1U"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            var1 = Val(ReadFieldOptimizado(1, Rdata, 44))
            var2 = Val(ReadFieldOptimizado(2, Rdata, 44))
            var3 = Val(ReadFieldOptimizado(3, Rdata, 44))
            var4 = Val(ReadFieldOptimizado(4, Rdata, 44))
            If var1 > 0 Then AddtoRichTextBox frmPrincipal.rectxt, "Has ganado " & var1 & " puntos de vida.", 200, 200, 200, 0, 0
            If var2 > 0 Then AddtoRichTextBox frmPrincipal.rectxt, "Has ganado " & var2 & " puntos de vitalidad.", 200, 200, 200, 0, 0
            If var3 > 0 Then AddtoRichTextBox frmPrincipal.rectxt, "Has ganado " & var3 & " puntos de mana.", 200, 200, 200, 0, 0
            If var4 > 0 Then AddtoRichTextBox frmPrincipal.rectxt, "Tu golpe maximo aumentó en " & var4 & " puntos.", 200, 200, 200, 0, 0
            If var4 > 0 Then AddtoRichTextBox frmPrincipal.rectxt, "Tu golpe mínimo aumentó en " & var4 & " puntos.", 200, 200, 200, 0, 0
            Exit Sub
        Case "6Z"
            AddtoRichTextBox frmPrincipal.rectxt, "¡Hoy es la votación para elegir un nuevo lider para el clan!", 255, 255, 255, 1, 0
            AddtoRichTextBox frmPrincipal.rectxt, "La elección durará 24 horas, se puede votar a cualquier miembro del clan.", 255, 255, 255, 1, 0
            AddtoRichTextBox frmPrincipal.rectxt, "Para votar escribe /VOTO NICKNAME.", 255, 255, 255, 1, 0
            AddtoRichTextBox frmPrincipal.rectxt, "Sólo se computara un voto por miembro.", 255, 255, 255, 1, 0
            Exit Sub
        Case "7Z"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            AddtoRichTextBox frmPrincipal.rectxt, "¡Las elecciones han finalizado!", 255, 255, 255, 1, 0
            AddtoRichTextBox frmPrincipal.rectxt, "El nuevo lider es: " & Rdata, 255, 255, 255, 1, 0
            Exit Sub
        Case "!J"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            AddtoRichTextBox frmPrincipal.rectxt, "Felicitaciones, tu solicitud ha sido aceptada.", 255, 255, 255, 1, 0
            AddtoRichTextBox frmPrincipal.rectxt, "Ahora sos un miembro activo del clan " & Rdata, 255, 255, 255, 1, 0
            Exit Sub
        Case "!R"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            AddtoRichTextBox frmPrincipal.rectxt, "Tu clan ha firmado una alianza con " & Rdata, 255, 255, 255, 1, 0
            If FX = 0 Then
                 Call Audio.PlayWave(0, "45.wav")
            End If
            Exit Sub
        Case "!S"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            AddtoRichTextBox frmPrincipal.rectxt, Rdata & " firmó una alianza con tu clan.", 255, 255, 255, 1, 0
            If FX = 0 Then
                 Call Audio.PlayWave(0, "45.wav")
            End If
            Exit Sub
        Case "!U"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            AddtoRichTextBox frmPrincipal.rectxt, "Tu clan le declaró la guerra a " & Rdata, 255, 255, 255, 1, 0
            If FX = 0 Then
                 Call Audio.PlayWave(0, "45.wav")
            End If
            Exit Sub
        Case "!V"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            AddtoRichTextBox frmPrincipal.rectxt, Rdata & " le declaró la guerra a tu clan.", 255, 255, 255, 1, 0
            If FX = 0 Then
                 Call Audio.PlayWave(0, "45.wav")
            End If
            Exit Sub
        Case "!4"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            Text1 = ReadFieldOptimizado(1, Rdata, 44)
            Text2 = ReadFieldOptimizado(2, Rdata, 44)
            AddtoRichTextBox frmPrincipal.rectxt, "¡" & Text1 & " fundó el clan " & Text2 & "!", 255, 255, 255, 1, 0
            If FX = 0 Then
                 Call Audio.PlayWave(0, "44.wav")
            End If
            Exit Sub
        Case "/O"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            Call Dialogos.CrearDialogo("El negocio va bien, ya he conseguido " & ReadFieldOptimizado(1, Rdata, 44) & " monedas de oro en ventas. He enviado el dinero directamente a tu cuenta en el banco.", Val(ReadFieldOptimizado(2, Rdata, 44)), vbWhite)
            Exit Sub
        Case "/P"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            Call Dialogos.CrearDialogo("El negocio no va muy bien, todavía no he podido vender nada. Si consigo una venta, enviare el dinero directamente a tu cuenta en el banco.", Val(Rdata), vbWhite)
            Exit Sub
        Case "/Q"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            Call Dialogos.CrearDialogo("¡Buen día! Ahora estoy contratado por " & ReadFieldOptimizado(1, Rdata, 44) & " para vender sus objetos, ¿quieres echar un vistazo?", Val(ReadFieldOptimizado(2, Rdata, 44)), vbWhite)
            Exit Sub
        Case "/R"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            AddtoRichTextBox frmPrincipal.rectxt, ReadFieldOptimizado(1, Rdata, 44) & " compró " & ReadFieldOptimizado(2, Rdata, 44) & " (" & PonerPuntos(Val(ReadFieldOptimizado(3, Rdata, 44))) & ") en tu tienda por " & PonerPuntos(Val(ReadFieldOptimizado(4, Rdata, 44))) & " monedas de oro.", 255, 255, 255, 1, 0
            AddtoRichTextBox frmPrincipal.rectxt, "El dinero fue enviado directamente a tu cuenta de banco.", 255, 255, 255, 1, 0
            Exit Sub
        Case "/V"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            Call Dialogos.CrearDialogo("Solo los trabajadores experimentados y los personajes mayores a nivel 25 con más de 65 en comercio pueden utilizar mis servicios de vendedor.", Val(Rdata), vbWhite)
            Exit Sub
        Case "/X"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            AddtoRichTextBox frmPrincipal.rectxt, "Numero total de ventas: " & PonerPuntos(Val(ReadFieldOptimizado(2, Rdata, 44))), 65, 190, 156, 1, 0
            AddtoRichTextBox frmPrincipal.rectxt, "Dinero movido por las ventas: " & PonerPuntos(Val(ReadFieldOptimizado(1, Rdata, 44))) & " monedas de oro.", 65, 190, 156, 1, 0
            AddtoRichTextBox frmPrincipal.rectxt, "Venta promedio: " & PonerPuntos(Val(ReadFieldOptimizado(1, Rdata, 44)) / Val(ReadFieldOptimizado(2, Rdata, 44))) & " monedas de oro.", 65, 190, 156, 1, 0
            Exit Sub
        Case "{B"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            AddtoRichTextBox frmPrincipal.rectxt, "Has iniciado el modo de susurro con " & Rdata & ".", 255, 255, 255, 1, 0
            frmPrincipal.MousePointer = vbDefault
            Exit Sub
        Case "{C"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            AddtoRichTextBox frmPrincipal.rectxt, "No puedes iniciar el modo de susurro contigo mismo.", 255, 255, 255, 1, 0
            frmPrincipal.modo = "1 Normal"
            frmPrincipal.MousePointer = vbDefault
            Exit Sub
        Case "{D"
            AddtoRichTextBox frmPrincipal.rectxt, "Target invalido.", 65, 190, 156, 0, 0
            frmPrincipal.modo = "1 Normal"
            frmPrincipal.MousePointer = vbDefault
            Exit Sub
        Case "{F"
            AddtoRichTextBox frmPrincipal.rectxt, "El usuario ya no se encuentra en tu pantalla.", 65, 190, 156, 0, 0
            frmPrincipal.modo = "1 Normal"
            frmPrincipal.MousePointer = vbDefault
            Exit Sub
        Case "8B"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            UserMaxHP = Val(ReadFieldOptimizado(1, Rdata, 44))
            frmPrincipal.HpShp.Width = (((UserMinHP / 100) / (UserMaxHP / 100)) * 85)
            frmPrincipal.cantidadhp.Caption = PonerPuntos(UserMinHP) & "/" & PonerPuntos(UserMaxHP)
            Exit Sub
        Case "9B"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            UserMaxMAN = Val(ReadFieldOptimizado(1, Rdata, 44))
            
            If UserMaxMAN > 0 Then
                frmPrincipal.ManSHp.Width = (((UserMinMAN + 1 / 100) / (UserMaxMAN + 1 / 100)) * 85)
                frmPrincipal.cantidadmana.Caption = PonerPuntos(UserMinMAN) & "/" & PonerPuntos(UserMaxMAN)
            Else
                frmPrincipal.ManSHp.Width = 0
               frmPrincipal.cantidadmana.Caption = ""
            End If
            Exit Sub
        Case "1N"
          '  If CartelSanado = 1 Then AddtoRichTextBox frmPrincipal.rectxt, "Has sanado.", 65, 190, 156, 0, 0
            Exit Sub
        Case "V5"
           ' If CartelOcultarse = 1 Then AddtoRichTextBox frmPrincipal.rectxt, "¡Has vuelto a ser visible!", 65, 190, 156, 0, 0
            Exit Sub
        Case "MN"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            Rdata = THeEnCripTe(Rdata, Chr$(83) & Chr$(84) & Chr$(82) & Chr$(73) & Chr$(78) & Chr$(71) & Chr$(71) & Chr$(69) _
            & Chr$(78) & Chr$(77))
         '   If CartelRecuMana = 1 Then
            AddtoRichTextBox frmPrincipal.rectxt, "¡Has recuperado " & Rdata & " puntos de mana!", 65, 190, 156, 0, 0
            Exit Sub
        Case "8K"
           ' If CartelNoHayNada = 1 Then AddtoRichTextBox frmPrincipal.rectxt, "¡No hay nada aquí!", 65, 190, 156, 0, 0
            Exit Sub
        Case "DN"
           ' If CartelMenosCansado = 1 Then AddtoRichTextBox frmPrincipal.rectxt, "Has dejado de descansar.", 65, 190, 156, 0, 0
            Exit Sub
        Case "D9"
         '   If CartelRecuMana = 1 Then
            AddtoRichTextBox frmPrincipal.rectxt, "Ya no estás meditando.", 65, 190, 156, 0, 0
            Exit Sub
        Case "{{"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            AddtoRichTextBox frmPrincipal.rectxt, "(" & ReadFieldOptimizado(1, Rdata, 44) & ") " & KeyName(ReadFieldOptimizado(2, Rdata, 44)), 65, 190, 156, 0, 0
            Exit Sub
        Case "7M"
           ' If CartelRecuMana = 1 Then
            AddtoRichTextBox frmPrincipal.rectxt, "Comienzas a meditar.", 65, 190, 156, 0, 0
            Exit Sub
        Case "8M"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            'If CartelRecuMana = 1 Then
             AddtoRichTextBox frmPrincipal.rectxt, "Te estás concentrando. En " & Rdata & " segundos comenzarás a meditar.", 65, 190, 156, 0, 0
            Exit Sub
        Case "EL"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            If Rdata <> 0 Then AddtoRichTextBox frmPrincipal.rectxt, "Has obtenido " & Rdata & " puntos de exp.", 255, 150, 25, 1, 0
            AddtoRichTextBox frmPrincipal.rectxt, "¡Has matado a la criatura!", 65, 190, 156, 0, 0
            Exit Sub
        Case "V7"
             AddtoRichTextBox frmPrincipal.rectxt, "¡Te has escondido entre las sombras!", 65, 190, 156, 0, 0
            Exit Sub
        Case "EN"
             AddtoRichTextBox frmPrincipal.rectxt, "¡No has logrado esconderte!", 65, 190, 156, 0, 0
            Exit Sub
        Case "V3"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            Rdata = TeEncripTE(Rdata)
            CharIndex = Val(ReadFieldOptimizado(2, Rdata, 44))
            CharList(CharIndex).invisible = (Val(ReadFieldOptimizado(1, Rdata, 44)) = 1)
            Exit Sub
        Case "N4"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            i = Val(ReadFieldOptimizado(1, Rdata, 44))
            Select Case i
                Case bCabeza
                    Call AddtoRichTextBox(frmPrincipal.rectxt, "¡¡" & ReadFieldOptimizado(3, Rdata, 44) & " te ha pegado en la cabeza por " & Val(ReadFieldOptimizado(2, Rdata, 44)) & "!!", 255, 0, 0, 1, 0)
                Case bBrazoIzquierdo
                    Call AddtoRichTextBox(frmPrincipal.rectxt, "¡¡" & ReadFieldOptimizado(3, Rdata, 44) & " te ha pegado el brazo izquierdo por " & Val(ReadFieldOptimizado(2, Rdata, 44)) & "!!", 255, 0, 0, 1, 0)
                Case bBrazoDerecho
                    Call AddtoRichTextBox(frmPrincipal.rectxt, "¡¡" & ReadFieldOptimizado(3, Rdata, 44) & " te ha pegado el brazo derecho por " & Val(ReadFieldOptimizado(2, Rdata, 44)) & "!!", 255, 0, 0, 1, 0)
                Case bPiernaIzquierda
                    Call AddtoRichTextBox(frmPrincipal.rectxt, "¡¡" & ReadFieldOptimizado(3, Rdata, 44) & " te ha pegado la pierna izquierda por " & Val(ReadFieldOptimizado(2, Rdata, 44)) & "!!", 255, 0, 0, 1, 0)
                Case bPiernaDerecha
                    Call AddtoRichTextBox(frmPrincipal.rectxt, "¡¡" & ReadFieldOptimizado(3, Rdata, 44) & " te ha pegado la pierna derecha por " & Val(ReadFieldOptimizado(2, Rdata, 44)) & "!!", 255, 0, 0, 1, 0)
                Case bTorso
                    Call AddtoRichTextBox(frmPrincipal.rectxt, "¡¡" & ReadFieldOptimizado(3, Rdata, 44) & " te ha pegado en el torso por " & Val(ReadFieldOptimizado(2, Rdata, 44)) & "!!", 255, 0, 0, 1, 0)
            End Select
            Exit Sub
        Case "N5"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            i = Val(ReadFieldOptimizado(1, Rdata, 44))
            Select Case i
                Case bCabeza
                    Call AddtoRichTextBox(frmPrincipal.rectxt, "¡¡Le has pegado a " & ReadFieldOptimizado(3, Rdata, 44) & " en la cabeza por " & Val(ReadFieldOptimizado(2, Rdata, 44)), 230, 230, 0, 1, 0)
                Case bBrazoIzquierdo
                    Call AddtoRichTextBox(frmPrincipal.rectxt, "¡¡Le has pegado a " & ReadFieldOptimizado(3, Rdata, 44) & " en el brazo izquierdo por " & Val(ReadFieldOptimizado(2, Rdata, 44)), 230, 230, 0, 1, 0)
                Case bBrazoDerecho
                    Call AddtoRichTextBox(frmPrincipal.rectxt, "¡¡Le has pegado a " & ReadFieldOptimizado(3, Rdata, 44) & " en el brazo derecho por " & Val(ReadFieldOptimizado(2, Rdata, 44)), 230, 230, 0, 1, 0)
                Case bPiernaIzquierda
                    Call AddtoRichTextBox(frmPrincipal.rectxt, "¡¡Le has pegado a " & ReadFieldOptimizado(3, Rdata, 44) & " en la pierna izquierda por " & Val(ReadFieldOptimizado(2, Rdata, 44)), 230, 230, 0, 1, 0)
                Case bPiernaDerecha
                    Call AddtoRichTextBox(frmPrincipal.rectxt, "¡¡Le has pegado a " & ReadFieldOptimizado(3, Rdata, 44) & " en la pierna derecha por " & Val(ReadFieldOptimizado(2, Rdata, 44)), 230, 230, 0, 1, 0)
                Case bTorso
                    Call AddtoRichTextBox(frmPrincipal.rectxt, "¡¡Le has pegado a " & ReadFieldOptimizado(3, Rdata, 44) & " en el torso por " & Val(ReadFieldOptimizado(2, Rdata, 44)), 230, 230, 0, 1, 0)
            End Select
            Exit Sub
        Case "|$"
              Rdata = Right$(Rdata, Len(Rdata) - 2)
              Call AddtoRichTextBox(frmPrincipal.rectxt, Rdata, 240, 238, 207, 0, 0)
          Exit Sub
        Case "##"
Rdata = Right$(Rdata, Len(Rdata) - 2)
quecarajodijo = Rdata
Exit Sub
        Case "||"
            Dim iUser As Integer
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            iUser = Val(ReadFieldDarkFly2(3, Rdata, 176))
            If iUser > 0 Then
                If Val(ReadFieldDarkFly2(1, Rdata, 176)) <> vbCyan And EstaIgnorado(iUser) Then
                    Dialogos.CrearDialogo "", iUser, Val(ReadFieldDarkFly2(1, Rdata, 176))
                    Exit Sub
                Else
                    Dialogos.CrearDialogo ReadFieldDarkFly2(2, Rdata, 176), iUser, Val(ReadFieldDarkFly2(1, Rdata, 176))
                End If
            Else
                  If PuedoQuitarFoco Then _
                    AddtoRichTextBox frmPrincipal.rectxt, ReadFieldDarkFly2(1, Rdata, 126), Val(ReadFieldDarkFly2(2, Rdata, 126)), Val(ReadFieldDarkFly2(3, Rdata, 126)), Val(ReadFieldDarkFly2(4, Rdata, 126)), Val(ReadFieldDarkFly2(5, Rdata, 126)), Val(ReadFieldDarkFly2(6, Rdata, 126))
            End If
            Exit Sub
        Case "!!"
            If PuedoQuitarFoco Then
                Rdata = Right$(Rdata, Len(Rdata) - 2)
                frmMensaje.msg.Caption = Rdata
                frmMensaje.Show , frmPrincipal
            End If
            Exit Sub
        Case "FC" 'flecha a char
        Rdata = Right$(Rdata, Len(Rdata) - 2)
        Crear_Flecha Val(ReadFieldOptimizado(1, Rdata, 44)), Val(ReadFieldOptimizado(2, Rdata, 44)), Val(ReadFieldOptimizado(3, Rdata, 44)), 0, Val(ReadFieldOptimizado(4, Rdata, 44))
        Exit Sub
        Case "IU"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            UserIndex = Val(Rdata)
            Exit Sub
        Case "IP"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            UserCharIndex = Val(Rdata)
            UserPos = CharList(UserCharIndex).POS
            frmPrincipal.mapa.Caption = NombreDelMapaActual
            frmPrincipal.CORD.Caption = " [" & UserMap & " - " & UserPos.X & " - " & UserPos.Y & "]"
            Exit Sub
        Case "BD"
        Rdata = Right$(Rdata, Len(Rdata) - 2)
        Call FrmOpciones.RecibedatosMap(Rdata)
        Exit Sub
        Case "CC"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            CharIndex = ReadFieldDarkFly2(4, Rdata, 44)
            X = ReadFieldDarkFly2(5, Rdata, 44)
            Y = ReadFieldDarkFly2(6, Rdata, 44)
            CharList(CharIndex).FX = Val(ReadFieldDarkFly2(9, Rdata, 44))
            CharList(CharIndex).FxLoopTimes = Val(ReadFieldDarkFly2(10, Rdata, 44))
            CharList(CharIndex).Nombre = ReadFieldDarkFly2(11, Rdata, 44)
            CharList(CharIndex).NombreNPC = ReadFieldDarkFly2(7, Rdata, 44)
            If Right$(CharList(CharIndex).Nombre, 2) = "<>" Then
                CharList(CharIndex).Nombre = Left$(CharList(CharIndex).Nombre, Len(CharList(CharIndex).Nombre) - 2)
            End If
            
            'meditaciones
            If MeditacionesAZ = 0 Then
            If CharList(CharIndex).FX = 4 Or CharList(CharIndex).FX = 5 Or CharList(CharIndex).FX = 6 Or CharList(CharIndex).FX = 25 Then
                 CharList(CharIndex).FX = 0
                 End If
            End If
            
            CharList(CharIndex).Criminal = Val(ReadFieldDarkFly2(13, Rdata, 44))
            CharList(CharIndex).Privilegios = Val(ReadFieldDarkFly2(16, Rdata, 44))
            
            CharList(CharIndex).invisible = (Val(ReadFieldDarkFly2(15, Rdata, 44)) = 1)
            Call MakeChar(CharIndex, ReadFieldDarkFly2(1, Rdata, 44), ReadFieldDarkFly2(2, Rdata, 44), ReadFieldDarkFly2(3, Rdata, 44), X, Y, Val(ReadFieldDarkFly2(7, Rdata, 44)), Val(ReadFieldDarkFly2(8, Rdata, 44)), Val(ReadFieldDarkFly2(12, Rdata, 44)))
            CharList(CharIndex).aura_Index = Val(ReadFieldDarkFly2(14, Rdata, 44))
            Call InitGrh(CharList(CharIndex).Aura, Val(ReadFieldDarkFly2(14, Rdata, 44)))
            
            Exit Sub
        Case "CX"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            Call FrmOpciones.CargarPersonajesWARP(Rdata)
            Exit Sub
        Case "PW"
            Rdata = Right$(Rdata, Len(Rdata) - 2)

            CharIndex = ReadFieldOptimizado(1, Rdata, 44)
            CharList(CharIndex).Criminal = Val(ReadFieldOptimizado(2, Rdata, 44))
            CharList(CharIndex).Nombre = ReadFieldOptimizado(3, Rdata, 44)
            
            Exit Sub
            
        Case "BP"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            Call EraseChar(Val(Rdata))
            Exit Sub

        Case "MP"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            Rdata = THeEnCripTe(Rdata, Chr$(83) & Chr$(84) & Chr$(82) & Chr$(73) & Chr$(78) & Chr$(71) & Chr$(71) & Chr$(69) _
            & Chr$(78) & Chr$(77))
            CharIndex = Val(ReadFieldOptimizado(1, Rdata, 44))
            
            If FX = 0 Then Call DoPasosFx(CharIndex)
            
            Call MoveCharByPos(CharIndex, ReadFieldOptimizado(2, Rdata, 44), ReadFieldOptimizado(3, Rdata, 44))
            
            Exit Sub
        Case "LP"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            CharIndex = Val(ReadFieldOptimizado(1, Rdata, 44))
            If FX = 0 Then Call DoPasosFx(CharIndex)
            
            Call MoveCharByPosConHeading(CharIndex, ReadFieldOptimizado(2, Rdata, 44), ReadFieldOptimizado(3, Rdata, 44), ReadFieldOptimizado(4, Rdata, 44))
            
            Exit Sub
        Case "ZZ"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            CharIndex = Val(ReadFieldOptimizado(1, Rdata, 44))
            
            If FX = 0 Then Call DoPasosFx(CharIndex)
            
            Call MoveCharByPosAndHead(CharIndex, ReadFieldOptimizado(2, Rdata, 44), ReadFieldOptimizado(3, Rdata, 44), ReadFieldOptimizado(4, Rdata, 44))
            Exit Sub
        Case "MH"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            Dim usermuerto As Integer

            usermuerto = Val(ReadFieldOptimizado(1, Rdata, 44))
            TiempoReal = ReadFieldOptimizado(2, Rdata, 44)
            
           If usermuerto = 1 Then
           ElseIf usermuerto = 0 Then
           'ColorInicial = 100
           End If
           
        Exit Sub
        Case "CP"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
    
            CharIndex = Val(ReadFieldOptimizado(1, Rdata, 44))
            CharList(CharIndex).muerto = Val(ReadFieldOptimizado(2, Rdata, 44)) = 500
            Slot = Val(ReadFieldOptimizado(2, Rdata, 44))
            CharList(CharIndex).Body = BodyData(Slot)
            CharList(CharIndex).Head = HeadData(Val(ReadFieldOptimizado(3, Rdata, 44)))
            If Slot > 83 And Slot < 88 Then
                CharList(CharIndex).Navegando = 1
            Else
                CharList(CharIndex).Navegando = 0
            End If
            CharList(CharIndex).Heading = Val(ReadFieldOptimizado(4, Rdata, 44))
            CharList(CharIndex).FX = Val(ReadFieldOptimizado(7, Rdata, 44))
            CharList(CharIndex).FxLoopTimes = Val(ReadFieldOptimizado(8, Rdata, 44))
            
            'meditaciones
            If MeditacionesAZ = 0 Then
            If CharList(CharIndex).FX = 4 Or CharList(CharIndex).FX = 5 Or CharList(CharIndex).FX = 6 Or CharList(CharIndex).FX = 25 Then
                 CharList(CharIndex).FX = 0
                 End If
            End If
            
            tempint = Val(ReadFieldOptimizado(5, Rdata, 44))
            If tempint <> 0 Then CharList(CharIndex).arma = WeaponAnimData(tempint)
            tempint = Val(ReadFieldOptimizado(6, Rdata, 44))
            If tempint <> 0 Then CharList(CharIndex).escudo = ShieldAnimData(tempint)
            tempint = Val(ReadFieldOptimizado(9, Rdata, 44))
            If tempint <> 0 Then CharList(CharIndex).casco = CascoAnimData(tempint)
            Exit Sub
        Case "2C"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            CharIndex = Val(ReadFieldOptimizado(1, Rdata, 44))
            CharList(CharIndex).FX = 0
            CharList(CharIndex).FxLoopTimes = 0
            CharList(CharIndex).Heading = Val(ReadFieldOptimizado(2, Rdata, 44))
            
            'meditaciones
            If MeditacionesAZ = 0 Then
            If CharList(CharIndex).FX = 4 Or CharList(CharIndex).FX = 5 Or CharList(CharIndex).FX = 6 Or CharList(CharIndex).FX = 25 Then
            CharList(CharIndex).FX = 0
            End If
            End If
            
            Exit Sub
        Case "3C"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            CharIndex = Val(ReadFieldOptimizado(1, Rdata, 44))
            Slot = Val(ReadFieldOptimizado(2, Rdata, 44))
            CharList(CharIndex).Body = BodyData(Slot)
            If Slot > 83 And Slot < 88 Then
                CharList(CharIndex).Navegando = 1
            Else
                CharList(CharIndex).Navegando = 0
            End If
            Exit Sub
        Case "4C"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            CharIndex = Val(ReadFieldOptimizado(1, Rdata, 44))
            CharList(CharIndex).Head = HeadData(Val(ReadFieldOptimizado(2, Rdata, 44)))
            Exit Sub
        Case "5C"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            CharIndex = Val(ReadFieldOptimizado(1, Rdata, 44))
            tempint = Val(ReadFieldOptimizado(2, Rdata, 44))
            If tempint <> 0 Then CharList(CharIndex).arma = WeaponAnimData(tempint)
            Exit Sub
        Case "6C"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            CharIndex = Val(ReadFieldOptimizado(1, Rdata, 44))
            tempint = Val(ReadFieldOptimizado(2, Rdata, 44))
            If tempint <> 0 Then CharList(CharIndex).escudo = ShieldAnimData(tempint)
            Exit Sub
        Case "7C"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            CharIndex = Val(ReadFieldOptimizado(1, Rdata, 44))
            tempint = Val(ReadFieldOptimizado(2, Rdata, 44))
            If tempint <> 0 Then CharList(CharIndex).casco = CascoAnimData(tempint)
            Exit Sub
        Case "5A"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            Rdata = TeEncripTE(Rdata)
            UserMinHP = Val(ReadFieldOptimizado(1, Rdata, 44))
            frmPrincipal.HpShp.Width = (((UserMinHP / 100) / (UserMaxHP / 100)) * 85)
            frmPrincipal.cantidadhp.Caption = PonerPuntos(UserMinHP) & "/" & PonerPuntos(UserMaxHP)
            
            If UserMinHP = 0 Then
                UserEstado = 1
            Else
                UserEstado = 0
            End If
        
            Exit Sub
        Case "5D"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            UserMinMAN = Val(ReadFieldOptimizado(1, Rdata, 44))
            
            If UserMaxMAN > 0 Then
                frmPrincipal.ManSHp.Width = (((UserMinMAN + 1 / 100) / (UserMaxMAN + 1 / 100)) * 85)
                frmPrincipal.cantidadmana.Caption = PonerPuntos(UserMinMAN) & "/" & PonerPuntos(UserMaxMAN)
            Else
                frmPrincipal.ManSHp.Width = 0
               frmPrincipal.cantidadmana.Caption = ""
            End If
            
            Exit Sub
            
          Case "5E"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            UserMinSTA = Val(ReadFieldOptimizado(1, Rdata, 44))
            
            frmPrincipal.STAShp.Width = (((UserMinSTA / 100) / (UserMaxSTA / 100)) * 85)
            frmPrincipal.cantidadsta.Caption = PonerPuntos(UserMinSTA) & "/" & PonerPuntos(UserMaxSTA)
        
            Exit Sub

        Case "5F"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            UserGLD = Val(ReadFieldOptimizado(1, Rdata, 44))

            frmPrincipal.GldLbl.Caption = PonerPuntos(UserGLD)
        
            Exit Sub
            
        Case "ELV"
            frmPrincipal.LvlLbl.Caption = "¡Nivel Máximo!"
            frmPrincipal.barrita.Width = 126
            Exit Sub
        Case "5G"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            
            UserExp = Val(ReadFieldOptimizado(1, Rdata, 44))
            
            If UserPasarNivel > 0 Then
                frmPrincipal.lblNivel = UserLvl
                frmPrincipal.barrita.Width = Round(CDbl(UserExp) * CDbl(126) / CDbl(UserPasarNivel), 0)
          
                frmPrincipal.LvlLbl.Caption = " (" & Round(UserExp / UserPasarNivel * 100, 2) & "%)" & " - " & PonerPuntos(UserExp) & " / " & PonerPuntos(UserPasarNivel)
            Else
            
            End If
            
        Case "5H"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            UserMinMAN = Val(ReadFieldOptimizado(1, Rdata, 44))
            UserMinSTA = Val(ReadFieldOptimizado(2, Rdata, 44))
            
            If UserMaxMAN > 0 Then
                frmPrincipal.ManSHp.Width = (((UserMinMAN + 1 / 100) / (UserMaxMAN + 1 / 100)) * 85)
                frmPrincipal.cantidadmana.Caption = PonerPuntos(UserMinMAN) & "/" & PonerPuntos(UserMaxMAN)
            Else
                frmPrincipal.ManSHp.Width = 0
               frmPrincipal.cantidadmana.Caption = ""
            End If
            
            frmPrincipal.STAShp.Width = (((UserMinSTA / 100) / (UserMaxSTA / 100)) * 85)
            frmPrincipal.cantidadsta.Caption = PonerPuntos(UserMinSTA) & "/" & PonerPuntos(UserMaxSTA)
        
            Exit Sub
            
        Case "5I"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            UserMinHP = Val(ReadFieldOptimizado(1, Rdata, 44))
            UserMinSTA = Val(ReadFieldOptimizado(2, Rdata, 44))
    
            frmPrincipal.HpShp.Width = (((UserMinHP / 100) / (UserMaxHP / 100)) * 85)
            frmPrincipal.cantidadhp.Caption = PonerPuntos(UserMinHP) & "/" & PonerPuntos(UserMaxHP)
            
            If UserMinHP = 0 Then
                UserEstado = 1
            Else
                UserEstado = 0
            End If
            
            frmPrincipal.STAShp.Width = (((UserMinSTA / 100) / (UserMaxSTA / 100)) * 85)
            frmPrincipal.cantidadsta.Caption = PonerPuntos(UserMinSTA) & "/" & PonerPuntos(UserMaxSTA)
        
            Exit Sub
        Case "5J"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            UserMinAGU = Val(ReadFieldOptimizado(1, Rdata, 44))
            UserMinHAM = Val(ReadFieldOptimizado(2, Rdata, 44))
            frmPrincipal.AGUAsp.Width = (((UserMinAGU / 100) / (UserMaxAGU / 100)) * 85)
            frmPrincipal.cantidadagua.Caption = UserMinAGU & "/" & UserMaxAGU
            frmPrincipal.COMIDAsp.Width = (((UserMinHAM / 100) / (UserMaxHAM / 100)) * 85)
            frmPrincipal.cantidadhambre.Caption = UserMinHAM & "/" & UserMaxHAM

            Exit Sub
        Case "5O"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            UserLvl = Val(ReadFieldOptimizado(1, Rdata, 44))
            UserPasarNivel = Val(ReadFieldOptimizado(2, Rdata, 44))
            If UserPasarNivel > 0 Then
                frmPrincipal.LvlLbl.Caption = UserLvl & " (" & Round(UserExp / UserPasarNivel * 100, 2) & "%)" & " - " & PonerPuntos(UserExp) & " / " & PonerPuntos(UserPasarNivel)
             
            Else
             
            End If
            Exit Sub
        Case "HO"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            X = Val(ReadFieldOptimizado(2, Rdata, 44))
            Y = Val(ReadFieldOptimizado(3, Rdata, 44))
            
            MapData(X, Y).ObjGrh.GrhIndex = Val(ReadFieldOptimizado(1, Rdata, 44))
            MapData(X, Y).ObjGrh.name = ReadFieldOptimizado(4, Rdata, 44)
            InitGrh MapData(X, Y).ObjGrh, MapData(X, Y).ObjGrh.GrhIndex
            LastPos.X = X
            LastPos.Y = Y
            Exit Sub
         Case "HE"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            Call FrmOpciones.DibujarGrhPorMapa(Rdata)
            Exit Sub
         Case "XH"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            AddtoRichTextBox frmComerciarUsu.ChatComer, Rdata, 255, 255, 255, 0, 0
            Exit Sub
        Case "P8"
            UserParalizado = False
            AddtoRichTextBox frmPrincipal.rectxt, "Ya no estás paralizado.", 65, 190, 156, 0, 0
            Exit Sub
        Case "P9"
            UserParalizado = True
            Call SendData("RPU")
            AddtoRichTextBox frmPrincipal.rectxt, "Estás paralizado. No podrás moverte por algunos segundos.", 65, 190, 156, 0, 0
            Exit Sub
        Case "BO"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            X = Val(ReadFieldOptimizado(1, Rdata, 44))
            Y = Val(ReadFieldOptimizado(2, Rdata, 44))
            MapData(X, Y).ObjGrh.GrhIndex = 0
            MapData(X, Y).ObjGrh.name = ""
            Exit Sub
        Case "BQ"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            MapData(Val(ReadFieldOptimizado(1, Rdata, 44)), Val(ReadFieldOptimizado(2, Rdata, 44))).Blocked = Val(ReadFieldOptimizado(3, Rdata, 44))
            Exit Sub
        Case "BK"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            Call FrmOpciones.BloquearTodoBQ(Rdata)
            Exit Sub
        Case "TN"
            If Musica = 0 Then
                Rdata = Right$(Rdata, Len(Rdata) - 2)
                If Val(ReadFieldOptimizado(1, Rdata, 45)) <> 0 Then
                    CurMidi = Val(ReadFieldOptimizado(1, Rdata, 45)) & ".mid"
                    LoopMidi = Val(ReadFieldOptimizado(2, Rdata, 45))
                    Call Audio.MP3_Stop
                    Call Audio.PlayMIDI(App.Path & "\musicas\" & CurMidi)
                End If
            End If
            Exit Sub
        Case "TM"
                If Musica = 0 Then
                Rdata = Right$(Rdata, Len(Rdata) - 2)
                
                If Val(ReadFieldOptimizado(1, Rdata, 45)) = 0 Then Exit Sub
                Call Audio.StopMidi
                Call Audio.MP3_Stop
                Call Audio.PlayWave(1, Val(ReadFieldOptimizado(1, Rdata, 45))) '".mp3")
                End If
            Exit Sub
          
            Exit Sub
        Case "LH"
            LastHechizo = Timer
            Exit Sub
        Case "LG"
            LastGolpe = Timer
            Exit Sub
        Case "LF"
            LastFlecha = Timer
            Exit Sub
        Case "TW"
            If FX = 0 Then
                Rdata = Right$(Rdata, Len(Rdata) - 2)
                 Call Audio.PlayWave(0, Rdata & ".wav")
            End If
            Exit Sub
        Case "TX"
            Dim Efecto As Integer
            Dim ParticleCasteada As Integer
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            CharIndex = Val(ReadFieldOptimizado(1, Rdata, 44)) 'atacante
            Charindexx = Val(ReadFieldOptimizado(2, Rdata, 44)) 'victima
            Efecto = Val(ReadFieldOptimizado(4, Rdata, 44)) 'efecto particulas
            If FX = 0 Then
                 Call Audio.PlayWave(0, ReadFieldOptimizado(6, Rdata, 44) & ".wav")
            End If
            If Efecto = 0 Then
                CharList(Charindexx).FX = Val(ReadFieldOptimizado(3, Rdata, 44))
                CharList(Charindexx).FxLoopTimes = Val(ReadFieldOptimizado(5, Rdata, 44))
            End If
            If HechizAc = 0 Then 'si está activado
                ParticleCasteada = Engine_UTOV_Particle(CharIndex, Charindexx, Efecto)
            Else
                CharList(Charindexx).FX = Val(ReadFieldOptimizado(3, Rdata, 44))
                CharList(Charindexx).FxLoopTimes = Val(ReadFieldOptimizado(5, Rdata, 44))
            End If
            Exit Sub
        Case "GL"
            Rdata = Right$(Rdata, Len(Rdata) - 2)
            frmGuildAdm.guildslist.Clear
            Call frmGuildAdm.ParseGuildList(Rdata)
            frmGuildAdm.SetFocus
            Exit Sub
        Case "FO"
            bFogata = True
            
                If frmPrincipal.IsPlaying <> plFogata Then
                    Audio.StopWave
                    Call Audio.PlayWave(0, "fuego.wav", True)
                    frmPrincipal.IsPlaying = plFogata
                End If
            
            Exit Sub
End Select

End Sub
Public Function ReplaceData(sdData As String) As String
Dim Rdata As String

If UCase$(Left$(sdData, 9)) = "/PASSWORD" Then
    frmCambiarPasswd.Show , frmPrincipal
    ReplaceData = "NOPUDO"
    Exit Function
End If

Select Case UCase$(sdData)
    Case Is = "/MEDITAR"
        ReplaceData = "#A"
    Case Is = "/SALIR"
        ReplaceData = "#B"
    Case "/FUNDARCLAN"
        Fundacion.Show , frmPrincipal
    Case "/BALANCE"
        ReplaceData = "#G"
    Case "/QUIETO"
        ReplaceData = "#H"
    Case "/ACOMPAÑAR"
        ReplaceData = "#I"
    Case "/ENTRENAR"
        ReplaceData = "#J"
    Case "/DESCANSAR"
        ReplaceData = "#K"
    Case "/RESUCITAR"
        ReplaceData = "#L"
    Case "/CURAR"
        ReplaceData = "#M"
    Case "/ONLINE"
        ReplaceData = "#P"
    Case "/VOTSI"
        ReplaceData = "VSI"
    Case "/VOTNO"
        ReplaceData = "VNO"
    Case "/IGNORADOS"
        Call MostrarIgnorados
        ReplaceData = "NOPUDO"
        Exit Function
    Case "/EST"
        ReplaceData = "#Q"
    Case "/PENA"
        ReplaceData = "#R"
    Case "/MOVER"
        ReplaceData = "#S"
    Case "/PARTICIPAR"
        ReplaceData = "#T"
    Case "/PROTECTOR1"
      ReplaceData = "#("
    Case "/TEAM1"
        ReplaceData = "#,"
    Case "/PROTECTOR2"
        ReplaceData = "#)"
    Case "/TEAM2"
        ReplaceData = "#%"
    Case "/ATRAPADO"
        ReplaceData = "#U"
    Case "/COMERCIAR"
        ReplaceData = "#V"
    Case "/BOVEDA"
        ReplaceData = "#W"
    Case "/HABLAR"
        ReplaceData = "#X"
    Case "/ENLISTAR"
        ReplaceData = "#Y"
    Case "/RECOMPENSA"
        ReplaceData = "#1"
    Case "/SALIRCLAN"
        ReplaceData = "#2"
    Case "/ONLINECLAN"
        ReplaceData = "#3"
    Case "/ABANDONAR"
        ReplaceData = "#4"
    Case "/RETARCLAN"
        ReplaceData = "#^"
    Case "/ACEPTCLAN"
        ReplaceData = "#¨"
    Case "/SEGUROCLAN"
        ReplaceData = "#€"
End Select

Select Case UCase$(Left$(sdData, 6))
    Case "/DESC "
        Rdata = Right$(sdData, Len(sdData) - 6)
        ReplaceData = "#5 " & Rdata
    Case "/VOTO "
        Rdata = Right$(sdData, Len(sdData) - 6)
        ReplaceData = "#6 " & Rdata
    Case "/CMSG "
        Rdata = Right$(sdData, Len(sdData) - 6)
        ReplaceData = "#7 " & Rdata
End Select
        
Select Case UCase$(Left$(sdData, 8))
    Case "/PASSWD "
        Rdata = Right$(sdData, Len(sdData) - 8)
        ReplaceData = "#8 " & Rdata
    Case "/ONLINE "
        Rdata = Right$(sdData, Len(sdData) - 8)
        ReplaceData = "#*" & Rdata
End Select

Select Case UCase$(Left$(sdData, 9))
    Case "/APOSTAR "
        Rdata = Right$(sdData, Len(sdData) - 9)
        ReplaceData = "#9 " & Rdata
    Case "/RETIRAR "
        Rdata = Right$(sdData, Len(sdData) - 9)
        ReplaceData = "#0 " & Rdata
 '   Case "/IGNORAR "
 '       Rdata = Right$(sdData, Len(sdData) - 9)
 '       Select Case IgnorarPJ(Rdata)
 '          Case 0
 '               ReplaceData = "NOPUDO"
 '               Exit Function
  '          Case 1
  '              ReplaceData = "#/ " & Rdata & " 1"
  '          Case 2
  '              ReplaceData = "#/ " & Rdata & " 0"
 '       End Select
End Select

Select Case UCase$(Left$(sdData, 11))
    Case "/DEPOSITAR "
        Rdata = Right$(sdData, Len(sdData) - 11)
        ReplaceData = "#Ñ " & Rdata
    Case "/DENUNCIAR "
        Rdata = Right$(sdData, Len(sdData) - 11)
        ReplaceData = "^A " & Rdata
End Select

If Len(ReplaceData) = 0 Then ReplaceData = sdData

End Function
Function KeyName(key As String) As String
Dim KeyCode As Byte

KeyCode = Asc(key)

Select Case KeyCode
    Case vbKeyAdd: KeyName = "+ (KeyPad)"
    Case vbKeyBack: KeyName = "Delete"
    Case vbKeyCancel: KeyName = "Cancelar"
    Case vbKeyCapital: KeyName = "CapsLock"
    Case vbKeyClear: KeyName = "Borrar"
    Case vbKeyControl: KeyName = "Control"
    Case vbKeyDecimal: KeyName = ". (KeyPad)"
    Case vbKeyDelete: KeyName = "Suprimir"
    Case vbKeyDivide: KeyName = "/ (KeyPad)"
    Case vbKeyEnd: KeyName = "Fin"
    Case vbKeyEscape: KeyName = "Esc"
    Case vbKeyF1: KeyName = "F1"
    Case vbKeyF2: KeyName = "F2"
    Case vbKeyF3: KeyName = "F3"
    Case vbKeyF4: KeyName = "F4"
    Case vbKeyF5: KeyName = "F5"
    Case vbKeyF6: KeyName = "F6"
    Case vbKeyF7: KeyName = "F7"
    Case vbKeyF8: KeyName = "F8"
    Case vbKeyF9: KeyName = "F9"
    Case vbKeyF10: KeyName = "F10"
    Case vbKeyF11: KeyName = "F11"
    Case vbKeyF12: KeyName = "F12"
    Case vbKeyF13: KeyName = "F13"
    Case vbKeyF14: KeyName = "F14"
    Case vbKeyF15: KeyName = "F15"
    Case vbKeyF16: KeyName = "F16"
    Case vbKeyHome: KeyName = "Inicio"
    Case vbKeyInsert: KeyName = "Insert"
    Case vbKeyMenu: KeyName = "Alt"
    Case vbKeyMultiply: KeyName = "* (KeyPad)"
    Case vbKeyNumlock: KeyName = "NumLock"
    Case vbKeyNumpad0: KeyName = "0 (KeyPad)"
    Case vbKeyNumpad1: KeyName = "1 (KeyPad)"
    Case vbKeyNumpad2: KeyName = "2 (KeyPad)"
    Case vbKeyNumpad3: KeyName = "3 (KeyPad)"
    Case vbKeyNumpad4: KeyName = "4 (KeyPad)"
    Case vbKeyNumpad5: KeyName = "5 (KeyPad)"
    Case vbKeyNumpad6: KeyName = "6 (KeyPad)"
    Case vbKeyNumpad7: KeyName = "7 (KeyPad)"
    Case vbKeyNumpad8: KeyName = "8 (KeyPad)"
    Case vbKeyNumpad9: KeyName = "9 (KeyPad)"
    Case vbKeyPageDown: KeyName = "Av Pag"
    Case vbKeyPageUp: KeyName = "Re Pag"
    Case vbKeyPause: KeyName = "Pausa"
    Case vbKeyPrint: KeyName = "ImprPant"
    Case vbKeyReturn: KeyName = "Enter"
    Case vbKeySelect: KeyName = "Select"
    Case vbKeyShift: KeyName = "Shift"
    Case vbKeySnapshot: KeyName = "Snapshot"
    Case vbKeySpace: KeyName = "Espacio"
    Case vbKeySubtract: KeyName = "- (KeyPad)"
    Case vbKeyTab: KeyName = "Tab"
    Case 92: KeyName = "Windows"
    Case 93: KeyName = "Lista"
    Case 145: KeyName = "Bloq Despl"
    Case 186: KeyName = "Comilla cierra(´)"
    Case 187: KeyName = "Asterisco (*)"
    Case 188: KeyName = "Coma (,)"
    Case 189: KeyName = "Guión (-)"
    Case 190: KeyName = "Punto (.)"
    Case 191: KeyName = "Llave cierra (})"
    Case 192: KeyName = "Ñ"
    Case 219: KeyName = "Comilla ("
    Case 220: KeyName = "Barra vertical (|)"
    Case 221: KeyName = "Signo pregunta (¿)"
    Case 222: KeyName = "Llave abre ({)"
    Case 223: KeyName = "Cualquiera"
    Case 226: KeyName = "Menor (<)"
    Case Else: KeyName = Chr(KeyCode)
End Select

End Function
Public Sub MostrarIgnorados()
Dim i As Integer

For i = 1 To UBound(Ignorados)
    If Ignorados(i) <> "" Then Call AddtoRichTextBox(frmPrincipal.rectxt, Ignorados(i), 65, 190, 156, 0, 0)
Next

End Sub
Function IgnorarPJ(name As String) As Byte
Dim i As Integer, tIndex As Integer

tIndex = NameIndex(name)

If tIndex = 0 Then
    Call AddtoRichTextBox(frmPrincipal.rectxt, "El personaje no existe o no está en tu mapa.", 65, 190, 156, 0, 0)
    Exit Function
End If

If tIndex = UserCharIndex Then
    Call AddtoRichTextBox(frmPrincipal.rectxt, "No puedes ignorarte a ti mismo.", 65, 190, 156, 0, 0)
    Exit Function
End If

For i = LBound(Ignorados) To UBound(Ignorados)
    If UCase$(Ignorados(i)) = UCase$(CharList(tIndex).Nombre) Then
        Call AddtoRichTextBox(frmPrincipal.rectxt, "Dejaste de ignorar a " & CharList(tIndex).Nombre & ".", 65, 190, 156, 0, 0)
        Ignorados(i) = ""
        IgnorarPJ = 2
        Exit Function
    End If
Next

For i = LBound(Ignorados) To UBound(Ignorados)
    If Len(Ignorados(i)) = 0 Then
        Call AddtoRichTextBox(frmPrincipal.rectxt, "Empezaste a ignorar a " & CharList(tIndex).Nombre & ".", 65, 190, 156, 0, 0)
        Ignorados(i) = CharList(tIndex).Nombre
        IgnorarPJ = 1
        Exit Function
    End If
Next

Call AddtoRichTextBox(frmPrincipal.rectxt, "No puedes ignorar a más personas.", 65, 190, 156, 0, 0)

End Function
Function NameIndex(name As String) As Integer
Dim i As Integer

For i = 1 To LastChar
    If UCase$(Left$(CharList(i).Nombre, Len(name))) = UCase$(name) Then
        NameIndex = i
        Exit Function
    End If
Next

End Function
Sub SendData(sdData As String)
Dim retcode
Dim AuxCmd As String

If Pausa Then Exit Sub

If CONGELADO And UCase$(sdData) <> "/DESCONGELAR" Then Exit Sub
If Not frmPrincipal.Socket1.Connected Then Exit Sub

AuxCmd = UCase$(Left$(sdData, 5))
If AuxCmd = "/PING" Then TimerPing(1) = GetTickCount() And &H7FFFFFFF

'Debug.Print ">> " & sdData
If SeguridadActiva = False Then AddtoRichTextBox PACKETS.RichTextBox2, sdData, 255, 255, 255, 0, 0

If Left$(sdData, 1) = "/" And Len(sdData) = 2 Then Exit Sub

sdData = ReplaceData(sdData)

If sdData = "NOPUDO" Then Exit Sub

bO = bO + 1
If bO > 10000 Then bO = 100

If Len(sdData) = 0 Then Exit Sub

If AuxCmd = "DEMSG" And Len(sdData) > 8000 Then Exit Sub
If AuxCmd = "GM" And Len(sdData) > 2200 Then
    NoMandoElMsg = 1
    Exit Sub
End If

If Len(sdData) > 300 And AuxCmd <> "DEMSG" And AuxCmd <> "GM" Then Exit Sub

NoMandoElMsg = 0

bK = 0

sdData = sdData & "~" & bK & ENDC

retcode = frmPrincipal.Socket1.Write(sdData, Len(sdData))

End Sub
Sub Login(ByVal valcode As Integer)

If EstadoLogin = Normal Then
        Call SendData("JHUMPH" & UserName & "," & UserPassword & "," & App.Major & "." & App.Minor & "." & App.Revision & "," & valcode & "," & GetMACAddress() & "," & GetSerialNumber("c:\") & "," & MotherBoardNumber)
ElseIf EstadoLogin = CrearNuevoPj Then
        SendData ("SARAXA" & UserName & "," & UserPassword _
        & "," & 0 & "," & 0 & "," _
        & App.Major & "." & App.Minor & "." & App.Revision & _
        "," & UserRaza & "," & UserSexo & "," & _
        UserAtributos(1) & "," & UserAtributos(2) & "," & UserAtributos(3) _
        & "," & UserAtributos(4) & "," & UserAtributos(5) _
         & "," & UserSkills(1) & "," & UserSkills(2) _
         & "," & UserSkills(3) & "," & UserSkills(4) _
         & "," & UserSkills(5) & "," & UserSkills(6) _
         & "," & UserSkills(7) & "," & UserSkills(8) _
         & "," & UserSkills(9) & "," & UserSkills(10) _
         & "," & UserSkills(11) & "," & UserSkills(12) _
         & "," & UserSkills(13) & "," & UserSkills(14) _
         & "," & UserSkills(15) & "," & UserSkills(16) _
         & "," & UserSkills(17) & "," & UserSkills(18) _
         & "," & UserSkills(19) & "," & UserSkills(20) _
         & "," & UserSkills(21) & "," & UserSkills(22) & "," & _
         UserEmail & "," & UserHogar & "," & valcode & "," & GetMACAddress() & "," & GetSerialNumber("c:\") & "," & MotherBoardNumber)
End If

End Sub
