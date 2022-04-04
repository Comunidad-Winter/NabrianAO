Attribute VB_Name = "Seguridad"
 
'director del proyecto: #Esteban(Neliam)

'servidor basado en fénixao 1.0
'medios de contacto:
'Skype: dc.esteban
'E-mail: nabrianao@gmail.com
Option Explicit

Function Encripta(Text As String, Encriptar As Boolean) As String
 
On Error GoTo a:
 
Dim a() As Integer
Dim b() As Integer
Dim Contraseñas(9) As String
Dim i As Integer
Dim ii As Integer
Dim R As String
Dim CI As Byte
Dim ss As Integer

Contraseñas(0) = "782317371207a78sd78as078d78as0789d123123"
Contraseñas(1) = "hfhfdbvnvnvcnfgsdfewrqwerwqer"
Contraseñas(2) = "ouisadfuisaduipfausduifwerwer"
Contraseñas(3) = "cxvbcxvbiopcxbcxpoivbdfgret"
Contraseñas(4) = "sdfgdfgirpoeterptpiopoibcvbcvbcvb"
Contraseñas(5) = "fhfghfhnbncvnvcn"
Contraseñas(6) = "sadasdqweqwue787898123123"
Contraseñas(7) = "ghfghdhrtyrtyeryer"
Contraseñas(8) = "teyrtyertyerghfhdfghdfhdfh"
Contraseñas(9) = "rtyrtertfbcvbcvbcvbcvbcvb"
 
 
 
'********* que contraseña hay q usar? *********
If Not Encriptar Then
    CI = val(Asc(Left(Text, 1))) - 10
    Text = Right(Text, Len(Text) - 1)
End If
'**********************************************
 
'para no llamar a cada rato a la function
ss = Len(Text)
 
'Por las dudas
If ss <= 0 Then Exit Function
 
ReDim a(1 To ss) As Integer
 
    For i = 1 To ss
        a(i) = Asc(Mid(Text, i, 1))
    Next i
 
 
    If Encriptar Then
 
        '****** Separamos la Contraseña ******
            CI = RandomNumber(0, 9)
            ReDim b(1 To Len(Contraseñas(CI))) As Integer
 
            For i = 1 To Len(Contraseñas(CI))
                b(i) = Asc(Mid(Contraseñas(CI), i, 1))
            Next i
        '*************************************
 
        For i = 1 To ss
            If ii >= UBound(b) Then ii = 0
            ii = ii + 1
            a(i) = a(i) + b(ii)
            If a(i) > 255 Then a(i) = a(i) - 255
            R = R + Chr(a(i))
        Next i
 
        Encripta = Chr(CI + 10) & R
 
    Else
       
    '****** Separamos la Contraseña ******
        ReDim b(1 To Len(Contraseñas(CI))) As Integer
       
        For i = 1 To Len(Contraseñas(CI))
            b(i) = Asc(Mid(Contraseñas(CI), i, 1))
        Next i
    '*************************************
       
        For i = 1 To ss
        If ii >= UBound(b) Then ii = 0
            ii = ii + 1
            a(i) = a(i) - b(ii)
            If a(i) < 0 Then
            a(i) = a(i) + 255
            End If
            R = R + Chr(a(i))
        Next i
       
        Encripta = R
   
    End If
 
a:
 
End Function

'EnCriptacion
' Text1.Text = THeDEnCripTe("DATO STRING", "asdasd")
Function THeDEnCripTe(ByVal S As String, ByVal p As String) As String
Dim i As Integer, R As String
Dim C1 As Integer, C2 As Integer
R = ""
If Len(p) > 0 Then
For i = 1 To Len(S)
C1 = Asc(Mid(S, i, 1))
If i > Len(p) Then
C2 = Asc(Mid(p, i Mod Len(p) + 1, 1))
Else
C2 = Asc(Mid(p, i, 1))
End If
C1 = C1 + C2 + 64
If C1 > 255 Then C1 = C1 - 256
R = R + Chr(C1)
Next i
Else
R = S
End If
THeDEnCripTe = R
End Function
'EnCriptacion


'ENCRIPTT

Private Function MamasiTEEX(X As Integer) As String
    If X > 9 Then
        MamasiTEEX = Chr(X + 55)
    Else
        MamasiTEEX = CStr(X)
    End If
End Function
 Function DesteEncripTE(DataValue As Variant) As Variant
      
    Dim X As Long
    Dim Temp As String
    Dim TempNum As Integer
    Dim TempChar As String
    Dim TempChar2 As String
      
    For X = 1 To Len(DataValue)
        TempChar2 = Mid(DataValue, X, 1)
        TempNum = Int(Asc(TempChar2) / 16)
          
        If ((TempNum * 16) < Asc(TempChar2)) Then
                 
            TempChar = MamasiTEEX(Asc(TempChar2) - (TempNum * 16))
            Temp = Temp & MamasiTEEX(TempNum) & TempChar
        Else
            Temp = Temp & MamasiTEEX(TempNum) & "0"
          
        End If
    Next X
      
      
    DesteEncripTE = Temp
End Function
Private Function MoveEltoto(X As String) As Integer
      
    Dim X1 As String
    Dim X2 As String
    Dim Temp As Integer
      
    X1 = Mid(X, 1, 1)
    X2 = Mid(X, 2, 1)
      
    If IsNumeric(X1) Then
        Temp = 16 * Int(X1)
    Else
        Temp = (Asc(X1) - 55) * 16
    End If
      
    If IsNumeric(X2) Then
        Temp = Temp + Int(X2)
    Else
        Temp = Temp + (Asc(X2) - 55)
    End If
      
    ' retorno
    MoveEltoto = Temp
      
End Function

'ENCRIPTT

'Anti SPAM
Public Function EsMalaPalabra(ByVal rdata As String)
If ReconocerPalabra("WWW.", UCase$(rdata)) Then EsMalaPalabra = True
If ReconocerPalabra("MERCURY", UCase$(rdata)) Then EsMalaPalabra = True
If ReconocerPalabra("WW W.", UCase$(rdata)) Then EsMalaPalabra = True
If ReconocerPalabra("W W W.", UCase$(rdata)) Then EsMalaPalabra = True
If ReconocerPalabra("W WW.", UCase$(rdata)) Then EsMalaPalabra = True
If ReconocerPalabra("FURIUS", UCase$(rdata)) Then EsMalaPalabra = True
If ReconocerPalabra("FSAO", UCase$(rdata)) Then EsMalaPalabra = True
If ReconocerPalabra("BLOSAM", UCase$(rdata)) Then EsMalaPalabra = True
If ReconocerPalabra("WAYNE", UCase$(rdata)) Then EsMalaPalabra = True
If ReconocerPalabra("TPAO", UCase$(rdata)) Then EsMalaPalabra = True
If ReconocerPalabra("MPAO", UCase$(rdata)) Then EsMalaPalabra = True
If ReconocerPalabra("HISPANO", UCase$(rdata)) Then EsMalaPalabra = True
If ReconocerPalabra("NEWFEN", UCase$(rdata)) Then EsMalaPalabra = True
If ReconocerPalabra("GIMATH", UCase$(rdata)) Then EsMalaPalabra = True
If ReconocerPalabra("IMPERIUM", UCase$(rdata)) Then EsMalaPalabra = True
If ReconocerPalabra("BAO", UCase$(rdata)) Then EsMalaPalabra = True
If ReconocerPalabra("IAO", UCase$(rdata)) Then EsMalaPalabra = True
If ReconocerPalabra("TDS", UCase$(rdata)) Then EsMalaPalabra = True
If ReconocerPalabra("TIERRAS DEL SUR", UCase$(rdata)) Then EsMalaPalabra = True
If ReconocerPalabra(".com", UCase$(rdata)) Then EsMalaPalabra = True
If ReconocerPalabra(".net", UCase$(rdata)) Then EsMalaPalabra = True
If ReconocerPalabra(".cc", UCase$(rdata)) Then EsMalaPalabra = True
If ReconocerPalabra(".wix", UCase$(rdata)) Then EsMalaPalabra = True
If ReconocerPalabra(".tk", UCase$(rdata)) Then EsMalaPalabra = True
If ReconocerPalabra(".ucoz", UCase$(rdata)) Then EsMalaPalabra = True
End Function
Public Function HayAdminsOnline() As Boolean
    Dim i As Integer
        For i = 1 To LastUser
            If UserList(i).flags.Privilegios > 0 Then HayAdminsOnline = True
        Next i
End Function
Private Function ReconocerPalabra(ByVal Palabra As String, ByVal Donde As String) As Boolean
Dim i As Integer
For i = 1 To (Len(Donde) - Len(Palabra) + 1)
 If UCase(Mid(Donde, i, 1)) = UCase(Mid(Palabra, 1, 1)) Then
       If UCase(Mid(Donde, i, Len(Palabra))) = UCase(Mid(Palabra, 1, Len(Palabra))) Then
         ReconocerPalabra = True
         Exit Function
       Else
         ReconocerPalabra = False
        End If
  Else
        ReconocerPalabra = False
  End If
Next
End Function
'Anti SPAM

'ANTI EDITORES DE PACKET Y HUEVADAS
Sub DataFalsaNo(Userindex As Integer, EsDataFalsa As Integer)

If Not EsDataFalsa = 1 Then
UserList(Userindex).flags.DataSTRINGGENM = UserList(Userindex).flags.DataSTRINGGENM + 1

'reseteo las diferentes entonces .-. (ni ganas de explicar) lo mismo para todas las otras datas.
UserList(Userindex).flags.DataJffsdfgdrt = 0
UserList(Userindex).flags.DataWEJDJz = 0
UserList(Userindex).flags.DatagfsdewS = 0
UserList(Userindex).flags.DataUEUSIDx = 0

If UserList(Userindex).flags.DataSTRINGGENM > 45 Then ' Si Envia la data igual 45 veces KB
Call AvisoChit(Userindex)
End If

ElseIf Not EsDataFalsa = 2 Then
UserList(Userindex).flags.DataJffsdfgdrt = UserList(Userindex).flags.DataJffsdfgdrt + 1

UserList(Userindex).flags.DataSTRINGGENM = 0
UserList(Userindex).flags.DataWEJDJz = 0
UserList(Userindex).flags.DatagfsdewS = 0
UserList(Userindex).flags.DataUEUSIDx = 0

If UserList(Userindex).flags.DataJffsdfgdrt > 45 Then ' Si Envia la data igual 45 veces KB
Call AvisoChit(Userindex)
End If

ElseIf Not EsDataFalsa = 3 Then
UserList(Userindex).flags.DataWEJDJz = UserList(Userindex).flags.DataWEJDJz + 1

UserList(Userindex).flags.DataSTRINGGENM = 0
UserList(Userindex).flags.DataJffsdfgdrt = 0
UserList(Userindex).flags.DatagfsdewS = 0
UserList(Userindex).flags.DataUEUSIDx = 0

If UserList(Userindex).flags.DataWEJDJz > 45 Then ' Si Envia la data igual 45 veces KB
Call AvisoChit(Userindex)
End If

ElseIf Not EsDataFalsa = 4 Then
UserList(Userindex).flags.DatagfsdewS = UserList(Userindex).flags.DatagfsdewS + 1

UserList(Userindex).flags.DataSTRINGGENM = 0
UserList(Userindex).flags.DataJffsdfgdrt = 0
UserList(Userindex).flags.DataWEJDJz = 0
UserList(Userindex).flags.DataUEUSIDx = 0

If UserList(Userindex).flags.DatagfsdewS > 45 Then ' Si Envia la data igual 45 veces KB
Call AvisoChit(Userindex)
End If

ElseIf Not EsDataFalsa = 5 Then
UserList(Userindex).flags.DataUEUSIDx = UserList(Userindex).flags.DataUEUSIDx + 1

UserList(Userindex).flags.DataSTRINGGENM = 0
UserList(Userindex).flags.DataJffsdfgdrt = 0
UserList(Userindex).flags.DataWEJDJz = 0
UserList(Userindex).flags.DatagfsdewS = 0

If UserList(Userindex).flags.DataUEUSIDx > 45 Then ' Si Envia la data igual 45 veces KB
Call AvisoChit(Userindex)
End If

End If

End Sub

Sub AvisoChit(Userindex As Integer)
Call SendData(ToAdmins, 0, 0, "||AVISO> " & UserList(Userindex).Name & " posible uso de proxy o cliente editado." & FONTTYPE_FIGHT)

End Sub



Public Sub PasoIntervalo(ByVal Userindex As Integer, ByVal NombreIntervalo As String)
        Dim Mensaje As String
Dim TActual As Long

    If haciendoBK Then Exit Sub
    
    TActual = GetTickCount And &H7FFFFFFF
    UserList(Userindex).Counters.Cheat = UserList(Userindex).Counters.Cheat + 1
  
    
          Mensaje = UserList(Userindex).Name & " aviso por pasar intervalo de " & NombreIntervalo & " " & UserList(Userindex).Counters.Cheat & " veces."
        'Call SendData(ToAdmins, 0, 0, "||Control> " & Mensaje & FONTTYPE_FIGHT)
    Call LogCheat(Mensaje)
    If UserList(Userindex).Counters.Cheat >= 30 Then
        Mensaje = UserList(Userindex).Name & " echado por pasar intervalo de " & NombreIntervalo & " " & UserList(Userindex).Counters.Cheat & " veces."
        Call SendData(ToAdmins, 0, 0, "||Control> " & Mensaje & FONTTYPE_VENENO)
        Call LogCheat(Mensaje)
        UserList(Userindex).Counters.Cheat = 0
        Call CloseSocket(Userindex)
    End If
    
    If TActual - UserList(Userindex).Counters.Cheater > 5000 Then
        UserList(Userindex).Counters.Cheat = 0
        UserList(Userindex).Counters.Cheater = TActual
    End If
    
End Sub

'ANTI EDITORES DE PACKET Y HUEVADAS
