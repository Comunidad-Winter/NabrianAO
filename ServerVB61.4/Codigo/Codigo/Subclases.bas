Attribute VB_Name = "modSubclases"
 
'director del proyecto: #Esteban(Neliam)

'servidor basado en fénixao 1.0
'medios de contacto:
'Skype: dc.esteban
'E-mail: nabrianao@gmail.com
Sub EnviarSubclase(Userindex As Integer)

If PuedeSubirClase(Userindex) Then Call SendData(ToIndex, Userindex, 0, "RECOM" & UserList(Userindex).Clase)

End Sub
Sub RecibirRecompensa(Userindex As Integer, Eleccion As Byte)
Dim Recompensa As Byte
Dim i As Integer

Recompensa = PuedeRecompensa(Userindex)

If Recompensa = 0 Then Exit Sub

UserList(Userindex).Recompensas(Recompensa) = Eleccion

If Recompensas(UserList(Userindex).Clase, Recompensa, Eleccion).SubeHP Then
    Call AddtoVar(UserList(Userindex).Stats.MaxHP, Recompensas(UserList(Userindex).Clase, Recompensa, Eleccion).SubeHP, STAT_MAXHP)
    Call SendUserMAXHP(Userindex)
End If

If Recompensas(UserList(Userindex).Clase, Recompensa, Eleccion).SubeMP Then
    Call AddtoVar(UserList(Userindex).Stats.MaxMAN, Recompensas(UserList(Userindex).Clase, Recompensa, Eleccion).SubeMP, 2000 + 200 * Buleano(UserList(Userindex).Clase = MAGO) * 200 + 300 * Buleano(UserList(Userindex).Clase = MAGO And UserList(Userindex).Recompensas(2) = 2))
    Call SendUserMAXMANA(Userindex)
End If

For i = 1 To 2
    If Recompensas(UserList(Userindex).Clase, Recompensa, Eleccion).Obj(i).OBJIndex Then
        If Not MeterItemEnInventario(Userindex, Recompensas(UserList(Userindex).Clase, Recompensa, Eleccion).Obj(i)) Then Call TirarItemAlPiso(UserList(Userindex).POS, Recompensas(UserList(Userindex).Clase, Recompensa, Eleccion).Obj(i))
    End If
Next

If PuedeRecompensa(Userindex) = 0 Then Call SendData(ToIndex, Userindex, 0, "SURE0")

End Sub
Sub RecibirSubclase(Clase As Byte, Userindex As Integer)

If Not PuedeSubirClase(Userindex) Then Exit Sub

Select Case UserList(Userindex).Clase
    Case CIUDADANO
        If Clase = 1 Then
            UserList(Userindex).Clase = TRABAJADOR
UserList(Userindex).Stats.UserSkills(1) = 100 ' SKILLS TABAJADOR AL 100%
UserList(Userindex).Stats.UserSkills(2) = 100
UserList(Userindex).Stats.UserSkills(3) = 100
UserList(Userindex).Stats.UserSkills(4) = 100
UserList(Userindex).Stats.UserSkills(5) = 100
UserList(Userindex).Stats.UserSkills(6) = 100
UserList(Userindex).Stats.UserSkills(7) = 100
UserList(Userindex).Stats.UserSkills(8) = 100
UserList(Userindex).Stats.UserSkills(9) = 100
UserList(Userindex).Stats.UserSkills(10) = 100
UserList(Userindex).Stats.UserSkills(11) = 100
UserList(Userindex).Stats.UserSkills(12) = 100
UserList(Userindex).Stats.UserSkills(13) = 100
UserList(Userindex).Stats.UserSkills(14) = 100
UserList(Userindex).Stats.UserSkills(15) = 100
UserList(Userindex).Stats.UserSkills(16) = 100
UserList(Userindex).Stats.UserSkills(17) = 100
UserList(Userindex).Stats.UserSkills(18) = 100
UserList(Userindex).Stats.UserSkills(19) = 100
UserList(Userindex).Stats.UserSkills(20) = 100
UserList(Userindex).Stats.UserSkills(21) = 100
UserList(Userindex).Stats.UserSkills(22) = 100
Call SendData(ToIndex, Userindex, 0, "||¡RECUERDA QUE ESTO NO ES UNA CLASE DE COMBATE!" & FONTTYPE_TALK)
        Else: UserList(Userindex).Clase = Luchador
        End If

    Case TRABAJADOR
        Select Case Clase
            Case 1
                UserList(Userindex).Clase = EXPERTO_MINERALES
            Case 2
                UserList(Userindex).Clase = EXPERTO_MADERA
            Case 3
                UserList(Userindex).Clase = PESCADOR
            Case 4
                UserList(Userindex).Clase = SASTRE
        End Select
        
    Case EXPERTO_MINERALES
        If Clase = 1 Then
            UserList(Userindex).Clase = MINERO
        Else: UserList(Userindex).Clase = HERRERO
        End If
        
    Case EXPERTO_MADERA
        If Clase = 1 Then
            UserList(Userindex).Clase = TALADOR
        Else: UserList(Userindex).Clase = CARPINTERO
        End If
        
    Case Luchador
        If Clase = 1 Then
            UserList(Userindex).Clase = CON_MANA
            Call Aprenderhechizo(Userindex, 2)
            UserList(Userindex).Stats.MaxMAN = 100
            Call SendUserMAXMANA(Userindex)
            If Not PuedeSubirClase(Userindex) Then Call SendData(ToIndex, Userindex, 0, "SUCL0")
            Exit Sub
        Else: UserList(Userindex).Clase = SIN_MANA
        End If
        
    Case CON_MANA
        Select Case Clase
            Case 1
                UserList(Userindex).Clase = HECHICERO
            Case 2
                UserList(Userindex).Clase = ORDEN_SAGRADA
            Case 3
                UserList(Userindex).Clase = NATURALISTA
            Case 4
                UserList(Userindex).Clase = SIGILOSO
        End Select
        
    Case HECHICERO
        If Clase = 1 Then
            UserList(Userindex).Clase = MAGO
        Else: UserList(Userindex).Clase = NIGROMANTE
        End If

    Case ORDEN_SAGRADA
        If Clase = 1 Then
            UserList(Userindex).Clase = PALADIN
        Else
            UserList(Userindex).Clase = CLERIGO
        End If
    
    Case NATURALISTA
        If Clase = 1 Then
            UserList(Userindex).Clase = BARDO
        Else: UserList(Userindex).Clase = DRUIDA
        End If
        
    Case SIGILOSO
        If Clase = 1 Then
            UserList(Userindex).Clase = ASESINO
        Else: UserList(Userindex).Clase = CAZADOR
        End If
        
    Case SIN_MANA
        If Clase = 1 Then
            UserList(Userindex).Clase = BANDIDO
        Else: UserList(Userindex).Clase = CABALLERO
        End If
        
    Case BANDIDO
        If Clase = 1 Then
            UserList(Userindex).Clase = PIRATA
        Else: UserList(Userindex).Clase = LADRON
        End If
        
    Case CABALLERO
        If Clase = 1 Then
            UserList(Userindex).Clase = GUERRERO
        Else: UserList(Userindex).Clase = ARQUERO
        End If
End Select

Call CalcularValores(Userindex)
Call SendData(ToIndex, Userindex, 0, "/0" & ListaClases(UserList(Userindex).Clase))

If Not PuedeSubirClase(Userindex) Then Call SendData(ToIndex, Userindex, 0, "SUCL0")

End Sub

