Attribute VB_Name = "mdlCOmercioConUsuario"
 
'director del proyecto: #Esteban(Neliam)

'servidor basado en fénixao 1.0
'medios de contacto:
'Skype: dc.esteban
'E-mail: nabrianao@gmail.com

Option Explicit


Public Sub IniciarComercioConUsuario(ByVal UserMando As Integer, ByVal UserReciviO As Integer)
On Error GoTo ErrHandler

If UserList(UserMando).flags.Privilegios = 1 Or UserList(UserMando).flags.Privilegios = 2 Or UserList(UserMando).flags.Privilegios = 3 Then Exit Sub

      If UserList(UserMando).flags.Comerciando = True Then
      Call SendData(ToIndex, UserMando, 0, "||¡Estas comerciando!" & FONTTYPE_TALK)
      Exit Sub
      End If

      If UserList(UserReciviO).flags.CuentaPendienteCc > 1 Then
      Call SendData(ToIndex, UserMando, 0, "||El usuario tiene una solicitud de comercio pendiente." & FONTTYPE_TALK)
      Exit Sub
      End If
      
      If UserList(UserMando).flags.CuentaPendienteCc > 1 Then
      Call SendData(ToIndex, UserMando, 0, "||Tienes una solicitud de comercio pendiente." & FONTTYPE_TALK)
      Exit Sub
      End If

If UserList(UserMando).ComercioNuevo.UsuarioManda = 0 Then
UserList(UserMando).ComercioNuevo.UsuarioManda = UserReciviO
UserList(UserReciviO).ComercioNuevo.UsuarioRecive = UserMando

UserList(UserReciviO).ComercioNuevo.UsuarioRecive = UserMando
UserList(UserReciviO).ComercioNuevo.UsuarioManda = UserMando

    UserList(UserReciviO).flags.CuentaPendienteCc = 13
    UserList(UserMando).flags.CuentaPendienteCc = 13

End If


Call SendData(ToIndex, UserReciviO, 0, "||" & UserList(UserMando).Name & " desea comerciar. Si deseas aceptar, Escribe /ACEPTARCOMERCIO." & FONTTYPE_TALK)
Call SendData(ToIndex, UserMando, 0, "||Has mandado comercio a " & UserList(UserReciviO).Name & FONTTYPE_TALK)


Exit Sub
ErrHandler:

End Sub





Public Sub AceptarComercio(Userindex As Integer)

If UserList(Userindex).flags.Comerciando = True Then

If Userindex Then ' ACEPTA EL CULEAO este
UserList(Userindex).ComercioNuevo.AceptoComerCiO = True
Call SendData(ToIndex, UserList(Userindex).ComercioNuevo.Usuario1, 0, "HX") ' le manda msj que aceptaste
End If

If UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.AceptoComerCiO = True Then 'y si acepta el otro ya cambian loco tanto drama pa esto.


If UserList(Userindex).ComercioNuevo.YaOfrecioCanjeos = True Then

UserList(UserList(Userindex).ComercioNuevo.Usuario1).flags.CanjesDonador = UserList(UserList(Userindex).ComercioNuevo.Usuario1).flags.CanjesDonador + UserList(Userindex).ComercioNuevo.CanjeosOfrecidos
Call SendUserREP(UserList(Userindex).ComercioNuevo.Usuario1)
End If

If UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.YaOfrecioCanjeos = True Then

UserList(Userindex).flags.CanjesDonador = UserList(Userindex).flags.CanjesDonador + UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.CanjeosOfrecidos
Call SendUserREP(Userindex)

End If

If UserList(Userindex).ComercioNuevo.YaOfrecioOro = True Then

UserList(UserList(Userindex).ComercioNuevo.Usuario1).Stats.GLD = UserList(UserList(Userindex).ComercioNuevo.Usuario1).Stats.GLD + UserList(Userindex).ComercioNuevo.OroOfrecido
Call SendUserORO(UserList(Userindex).ComercioNuevo.Usuario1)
End If

If UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.YaOfrecioOro = True Then

UserList(Userindex).Stats.GLD = UserList(Userindex).Stats.GLD + UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.OroOfrecido
Call SendUserORO(Userindex)

End If

'le damos los item al reves se supone que es un cambio no?
If UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.vaOfreciendo = 1 Then
If Not MeterItemEnInventario(Userindex, UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.ItemComercio) Then Call TirarItemAlPiso(UserList(Userindex).POS, UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.ItemComercio)
ElseIf UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.vaOfreciendo = 2 Then
If Not MeterItemEnInventario(Userindex, UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.ItemComercio) Then Call TirarItemAlPiso(UserList(Userindex).POS, UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.ItemComercio)
If Not MeterItemEnInventario(Userindex, UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.ItemComercio1) Then Call TirarItemAlPiso(UserList(Userindex).POS, UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.ItemComercio1)
ElseIf UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.vaOfreciendo = 3 Then
If Not MeterItemEnInventario(Userindex, UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.ItemComercio) Then Call TirarItemAlPiso(UserList(Userindex).POS, UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.ItemComercio)
If Not MeterItemEnInventario(Userindex, UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.ItemComercio1) Then Call TirarItemAlPiso(UserList(Userindex).POS, UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.ItemComercio1)
If Not MeterItemEnInventario(Userindex, UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.ItemComercio2) Then Call TirarItemAlPiso(UserList(Userindex).POS, UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.ItemComercio2)
ElseIf UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.vaOfreciendo = 4 Then
If Not MeterItemEnInventario(Userindex, UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.ItemComercio) Then Call TirarItemAlPiso(UserList(Userindex).POS, UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.ItemComercio)
If Not MeterItemEnInventario(Userindex, UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.ItemComercio1) Then Call TirarItemAlPiso(UserList(Userindex).POS, UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.ItemComercio1)
If Not MeterItemEnInventario(Userindex, UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.ItemComercio2) Then Call TirarItemAlPiso(UserList(Userindex).POS, UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.ItemComercio2)
If Not MeterItemEnInventario(Userindex, UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.ItemComercio3) Then Call TirarItemAlPiso(UserList(Userindex).POS, UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.ItemComercio3)
End If

If UserList(Userindex).ComercioNuevo.vaOfreciendo = 1 Then
If Not MeterItemEnInventario(UserList(Userindex).ComercioNuevo.Usuario1, UserList(Userindex).ComercioNuevo.ItemComercio) Then Call TirarItemAlPiso(UserList(UserList(Userindex).ComercioNuevo.Usuario1).POS, UserList(Userindex).ComercioNuevo.ItemComercio)
ElseIf UserList(Userindex).ComercioNuevo.vaOfreciendo = 2 Then
If Not MeterItemEnInventario(UserList(Userindex).ComercioNuevo.Usuario1, UserList(Userindex).ComercioNuevo.ItemComercio) Then Call TirarItemAlPiso(UserList(UserList(Userindex).ComercioNuevo.Usuario1).POS, UserList(Userindex).ComercioNuevo.ItemComercio)
If Not MeterItemEnInventario(UserList(Userindex).ComercioNuevo.Usuario1, UserList(Userindex).ComercioNuevo.ItemComercio1) Then Call TirarItemAlPiso(UserList(UserList(Userindex).ComercioNuevo.Usuario1).POS, UserList(Userindex).ComercioNuevo.ItemComercio1)
ElseIf UserList(Userindex).ComercioNuevo.vaOfreciendo = 3 Then
If Not MeterItemEnInventario(UserList(Userindex).ComercioNuevo.Usuario1, UserList(Userindex).ComercioNuevo.ItemComercio) Then Call TirarItemAlPiso(UserList(UserList(Userindex).ComercioNuevo.Usuario1).POS, UserList(Userindex).ComercioNuevo.ItemComercio)
If Not MeterItemEnInventario(UserList(Userindex).ComercioNuevo.Usuario1, UserList(Userindex).ComercioNuevo.ItemComercio1) Then Call TirarItemAlPiso(UserList(UserList(Userindex).ComercioNuevo.Usuario1).POS, UserList(Userindex).ComercioNuevo.ItemComercio1)
If Not MeterItemEnInventario(UserList(Userindex).ComercioNuevo.Usuario1, UserList(Userindex).ComercioNuevo.ItemComercio2) Then Call TirarItemAlPiso(UserList(UserList(Userindex).ComercioNuevo.Usuario1).POS, UserList(Userindex).ComercioNuevo.ItemComercio2)
ElseIf UserList(Userindex).ComercioNuevo.vaOfreciendo = 4 Then
If Not MeterItemEnInventario(UserList(Userindex).ComercioNuevo.Usuario1, UserList(Userindex).ComercioNuevo.ItemComercio) Then Call TirarItemAlPiso(UserList(UserList(Userindex).ComercioNuevo.Usuario1).POS, UserList(Userindex).ComercioNuevo.ItemComercio)
If Not MeterItemEnInventario(UserList(Userindex).ComercioNuevo.Usuario1, UserList(Userindex).ComercioNuevo.ItemComercio1) Then Call TirarItemAlPiso(UserList(UserList(Userindex).ComercioNuevo.Usuario1).POS, UserList(Userindex).ComercioNuevo.ItemComercio1)
If Not MeterItemEnInventario(UserList(Userindex).ComercioNuevo.Usuario1, UserList(Userindex).ComercioNuevo.ItemComercio2) Then Call TirarItemAlPiso(UserList(UserList(Userindex).ComercioNuevo.Usuario1).POS, UserList(Userindex).ComercioNuevo.ItemComercio2)
If Not MeterItemEnInventario(UserList(Userindex).ComercioNuevo.Usuario1, UserList(Userindex).ComercioNuevo.ItemComercio3) Then Call TirarItemAlPiso(UserList(UserList(Userindex).ComercioNuevo.Usuario1).POS, UserList(Userindex).ComercioNuevo.ItemComercio3)
End If


If UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.vaOfreciendo = 1 Then
Call QuitarObjetos(UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.ItemComercio.OBJIndex, UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.ItemComercio.Amount, UserList(Userindex).ComercioNuevo.Usuario1)
ElseIf UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.vaOfreciendo = 2 Then
Call QuitarObjetos(UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.ItemComercio.OBJIndex, UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.ItemComercio.Amount, UserList(Userindex).ComercioNuevo.Usuario1)
Call QuitarObjetos(UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.ItemComercio1.OBJIndex, UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.ItemComercio1.Amount, UserList(Userindex).ComercioNuevo.Usuario1)
ElseIf UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.vaOfreciendo = 3 Then
Call QuitarObjetos(UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.ItemComercio.OBJIndex, UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.ItemComercio.Amount, UserList(Userindex).ComercioNuevo.Usuario1)
Call QuitarObjetos(UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.ItemComercio1.OBJIndex, UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.ItemComercio1.Amount, UserList(Userindex).ComercioNuevo.Usuario1)
Call QuitarObjetos(UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.ItemComercio2.OBJIndex, UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.ItemComercio2.Amount, UserList(Userindex).ComercioNuevo.Usuario1)
ElseIf UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.vaOfreciendo = 4 Then
Call QuitarObjetos(UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.ItemComercio.OBJIndex, UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.ItemComercio.Amount, UserList(Userindex).ComercioNuevo.Usuario1)
Call QuitarObjetos(UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.ItemComercio1.OBJIndex, UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.ItemComercio1.Amount, UserList(Userindex).ComercioNuevo.Usuario1)
Call QuitarObjetos(UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.ItemComercio2.OBJIndex, UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.ItemComercio2.Amount, UserList(Userindex).ComercioNuevo.Usuario1)
Call QuitarObjetos(UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.ItemComercio3.OBJIndex, UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.ItemComercio3.Amount, UserList(Userindex).ComercioNuevo.Usuario1)
End If




If UserList(Userindex).ComercioNuevo.vaOfreciendo = 1 Then
Call QuitarObjetos(UserList(Userindex).ComercioNuevo.ItemComercio.OBJIndex, UserList(Userindex).ComercioNuevo.ItemComercio.Amount, Userindex)
ElseIf UserList(Userindex).ComercioNuevo.vaOfreciendo = 2 Then
Call QuitarObjetos(UserList(Userindex).ComercioNuevo.ItemComercio.OBJIndex, UserList(Userindex).ComercioNuevo.ItemComercio.Amount, Userindex)
Call QuitarObjetos(UserList(Userindex).ComercioNuevo.ItemComercio1.OBJIndex, UserList(Userindex).ComercioNuevo.ItemComercio1.Amount, Userindex)
ElseIf UserList(Userindex).ComercioNuevo.vaOfreciendo = 3 Then
Call QuitarObjetos(UserList(Userindex).ComercioNuevo.ItemComercio.OBJIndex, UserList(Userindex).ComercioNuevo.ItemComercio.Amount, Userindex)
Call QuitarObjetos(UserList(Userindex).ComercioNuevo.ItemComercio1.OBJIndex, UserList(Userindex).ComercioNuevo.ItemComercio1.Amount, Userindex)
Call QuitarObjetos(UserList(Userindex).ComercioNuevo.ItemComercio2.OBJIndex, UserList(Userindex).ComercioNuevo.ItemComercio2.Amount, Userindex)
ElseIf UserList(Userindex).ComercioNuevo.vaOfreciendo = 4 Then
Call QuitarObjetos(UserList(Userindex).ComercioNuevo.ItemComercio.OBJIndex, UserList(Userindex).ComercioNuevo.ItemComercio.Amount, Userindex)
Call QuitarObjetos(UserList(Userindex).ComercioNuevo.ItemComercio1.OBJIndex, UserList(Userindex).ComercioNuevo.ItemComercio1.Amount, Userindex)
Call QuitarObjetos(UserList(Userindex).ComercioNuevo.ItemComercio2.OBJIndex, UserList(Userindex).ComercioNuevo.ItemComercio2.Amount, Userindex)
Call QuitarObjetos(UserList(Userindex).ComercioNuevo.ItemComercio3.OBJIndex, UserList(Userindex).ComercioNuevo.ItemComercio3.Amount, Userindex)
End If


Call LogComercios(UserList(Userindex).Name, UserList(Userindex).Name & ": " & ObjData(UserList(Userindex).ComercioNuevo.ItemComercio.OBJIndex).Name & " -- " & ObjData(UserList(Userindex).ComercioNuevo.ItemComercio1.OBJIndex).Name & " -- " & ObjData(UserList(Userindex).ComercioNuevo.ItemComercio2.OBJIndex).Name & " -- " & ObjData(UserList(Userindex).ComercioNuevo.ItemComercio3.OBJIndex).Name & " CANJEOS:" & UserList(Userindex).ComercioNuevo.CanjeosOfrecidos, False)
Call LogComercios(UserList(Userindex).Name, UserList(UserList(Userindex).ComercioNuevo.Usuario1).Name & ": " & ObjData(UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.ItemComercio.OBJIndex).Name & " -- " & ObjData(UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.ItemComercio1.OBJIndex).Name & " -- " & ObjData(UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.ItemComercio2.OBJIndex).Name & " -- " & ObjData(UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.ItemComercio3.OBJIndex).Name & " CANJEOS: " & UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.CanjeosOfrecidos, False)
            

Call SendData(ToIndex, Userindex, 0, "||tu comercio se efectuó correctamente." & FONTTYPE_TALK)
Call SendData(ToIndex, UserList(Userindex).ComercioNuevo.Usuario1, 0, "||tu comercio se efectuó correctamente." & FONTTYPE_TALK)

UserList(Userindex).flags.Comerciando = False
UserList(Userindex).flags.ComerCiandoNuevo = False

UserList(UserList(Userindex).ComercioNuevo.Usuario1).flags.Comerciando = False
UserList(UserList(Userindex).ComercioNuevo.Usuario1).flags.ComerCiandoNuevo = False

UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.ItemComercio.OBJIndex = 0 'reseteamos los item que ofrecio
UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.ItemComercio.Amount = 0
UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.ItemComercio1.OBJIndex = 0
UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.ItemComercio1.Amount = 0
UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.ItemComercio2.OBJIndex = 0
UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.ItemComercio2.Amount = 0
UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.ItemComercio3.OBJIndex = 0
UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.ItemComercio3.Amount = 0

UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.AceptoComerCiO = False
UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.YaOfrecio = False 'reseteamos todo para que vuelva a comerciar correctamente
UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.YaOfrecioCanjeos = False
UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.CanjeosOfrecidos = 0
UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.YaOfrecioOro = False
UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.OroOfrecido = 0
UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.UsuarioRecive = 0
UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.UsuarioManda = 0
UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.vaOfreciendo = 0
Call SendData(ToIndex, UserList(Userindex).ComercioNuevo.Usuario1, 0, "FINCOMUSUOK")

UserList(Userindex).ComercioNuevo.ItemComercio.OBJIndex = 0 ' reseteamos los item que ofrecio
UserList(Userindex).ComercioNuevo.ItemComercio.Amount = 0
UserList(Userindex).ComercioNuevo.ItemComercio1.OBJIndex = 0
UserList(Userindex).ComercioNuevo.ItemComercio1.Amount = 0
UserList(Userindex).ComercioNuevo.ItemComercio2.OBJIndex = 0
UserList(Userindex).ComercioNuevo.ItemComercio2.Amount = 0
UserList(Userindex).ComercioNuevo.ItemComercio3.OBJIndex = 0
UserList(Userindex).ComercioNuevo.ItemComercio3.Amount = 0

UserList(Userindex).ComercioNuevo.AceptoComerCiO = False
UserList(Userindex).ComercioNuevo.YaOfrecio = False 'reseteamos todo para que vuelva a comerciar correctamente
UserList(Userindex).ComercioNuevo.YaOfrecioCanjeos = False
UserList(Userindex).ComercioNuevo.CanjeosOfrecidos = 0
UserList(Userindex).ComercioNuevo.YaOfrecioOro = False
UserList(Userindex).ComercioNuevo.OroOfrecido = 0
UserList(Userindex).ComercioNuevo.UsuarioRecive = 0
UserList(Userindex).ComercioNuevo.UsuarioManda = 0
UserList(Userindex).ComercioNuevo.vaOfreciendo = 0
Call SendData(ToIndex, Userindex, 0, "FINCOMUSUOK")

End If
End If

End Sub

Sub CanceloComercio(Userindex As Integer) 'cancelo

If UserList(Userindex).flags.Comerciando = True Then

If UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.YaOfrecioCanjeos = True Then ' le damos los canjes si rechaza o cancela.
UserList(UserList(Userindex).ComercioNuevo.Usuario1).flags.CanjesDonador = UserList(UserList(Userindex).ComercioNuevo.Usuario1).flags.CanjesDonador + UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.CanjeosOfrecidos
Call SendUserREP(UserList(Userindex).ComercioNuevo.Usuario1)
End If

If UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.YaOfrecioOro = True Then ' le damos los canjes si rechaza o cancela.
UserList(UserList(Userindex).ComercioNuevo.Usuario1).Stats.GLD = UserList(UserList(Userindex).ComercioNuevo.Usuario1).Stats.GLD + UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.OroOfrecido
Call SendUserORO(UserList(Userindex).ComercioNuevo.Usuario1)
End If

UserList(Userindex).flags.Comerciando = False
UserList(Userindex).flags.ComerCiandoNuevo = False

UserList(UserList(Userindex).ComercioNuevo.Usuario1).flags.Comerciando = False
UserList(UserList(Userindex).ComercioNuevo.Usuario1).flags.ComerCiandoNuevo = False

Call SendData(ToIndex, UserList(Userindex).ComercioNuevo.Usuario1, 0, "||tu comerciante canceló." & FONTTYPE_TALK)

UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.ItemComercio.OBJIndex = 0 'reseteamos los item que ofrecio
UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.ItemComercio.Amount = 0
UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.ItemComercio1.OBJIndex = 0
UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.ItemComercio1.Amount = 0
UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.ItemComercio2.OBJIndex = 0
UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.ItemComercio2.Amount = 0
UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.ItemComercio3.OBJIndex = 0
UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.ItemComercio3.Amount = 0



UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.AceptoComerCiO = False
UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.YaOfrecio = False 'reseteamos todo para que vuelva a comerciar correctamente
UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.YaOfrecioCanjeos = False
UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.CanjeosOfrecidos = 0
UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.YaOfrecioOro = False
UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.OroOfrecido = 0
UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.UsuarioRecive = 0
UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.UsuarioManda = 0
UserList(UserList(Userindex).ComercioNuevo.Usuario1).ComercioNuevo.vaOfreciendo = 0
Call SendData(ToIndex, UserList(Userindex).ComercioNuevo.Usuario1, 0, "FINCOMUSUOK")

Call SendData(ToIndex, Userindex, 0, "||Haz cancelado el comercio." & FONTTYPE_TALK)

If UserList(Userindex).ComercioNuevo.YaOfrecioCanjeos = True Then ' le damos los canjes si rechaza o cancela.
UserList(Userindex).flags.CanjesDonador = UserList(Userindex).flags.CanjesDonador + UserList(Userindex).ComercioNuevo.CanjeosOfrecidos
Call SendUserREP(Userindex)
End If

If UserList(Userindex).ComercioNuevo.YaOfrecioOro = True Then ' le damos los canjes si rechaza o cancela.
UserList(Userindex).Stats.GLD = UserList(Userindex).Stats.GLD + UserList(Userindex).ComercioNuevo.OroOfrecido
Call SendUserORO(Userindex)
End If

UserList(Userindex).ComercioNuevo.ItemComercio.OBJIndex = 0 ' reseteamos los item que ofrecio
UserList(Userindex).ComercioNuevo.ItemComercio.Amount = 0
UserList(Userindex).ComercioNuevo.ItemComercio1.OBJIndex = 0
UserList(Userindex).ComercioNuevo.ItemComercio1.Amount = 0
UserList(Userindex).ComercioNuevo.ItemComercio2.OBJIndex = 0
UserList(Userindex).ComercioNuevo.ItemComercio2.Amount = 0
UserList(Userindex).ComercioNuevo.ItemComercio3.OBJIndex = 0
UserList(Userindex).ComercioNuevo.ItemComercio3.Amount = 0

UserList(Userindex).ComercioNuevo.AceptoComerCiO = False
UserList(Userindex).ComercioNuevo.YaOfrecio = False 'reseteamos todo para que vuelva a comerciar correctamente
UserList(Userindex).ComercioNuevo.YaOfrecioCanjeos = False
UserList(Userindex).ComercioNuevo.CanjeosOfrecidos = 0
UserList(Userindex).ComercioNuevo.YaOfrecioOro = False
UserList(Userindex).ComercioNuevo.OroOfrecido = 0
UserList(Userindex).ComercioNuevo.UsuarioRecive = 0
UserList(Userindex).ComercioNuevo.UsuarioManda = 0
UserList(Userindex).ComercioNuevo.vaOfreciendo = 0
Call SendData(ToIndex, Userindex, 0, "FINCOMUSUOK")
End If

End Sub





