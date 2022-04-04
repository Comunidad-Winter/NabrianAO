Attribute VB_Name = "ModIni"
 
'director del proyecto: #Esteban(Neliam)

'servidor basado en fénixao 1.0
'medios de contacto:
'Skype: dc.esteban
'E-mail: nabrianao@gmail.com
Option Explicit

Public Declare Function INICarga Lib "LeeInis.dll" (ByVal Arch As String) As Long
Public Declare Function INIDescarga Lib "LeeInis.dll" (ByVal a As Long) As Long
Public Declare Function INIDarError Lib "LeeInis.dll" () As Long

Public Declare Function INIDarNumSecciones Lib "LeeInis.dll" (ByVal a As Long) As Long
Public Declare Function INIDarNombreSeccion Lib "LeeInis.dll" (ByVal a As Long, ByVal N As Long, ByVal Buff As String, ByVal Tam As Long) As Long
Public Declare Function INIBuscarSeccion Lib "LeeInis.dll" (ByVal a As Long, ByVal Buff As String) As Long

Public Declare Function INIDarClave Lib "LeeInis.dll" (ByVal a As Long, ByVal N As Long, ByVal Clave As String, ByVal Buff As String, ByVal Tam As Long) As Long
Public Declare Function INIDarClaveInt Lib "LeeInis.dll" (ByVal a As Long, ByVal N As Long, ByVal Clave As String) As Long
Public Declare Function INIDarNumClaves Lib "LeeInis.dll" (ByVal a As Long, ByVal N As Long) As Long
Public Declare Function INIDarNombreClave Lib "LeeInis.dll" (ByVal a As Long, ByVal N As Long, ByVal Clave As Long, ByVal Buff As String, ByVal Tam As Long) As Long

Public Declare Function INIConf Lib "LeeInis.dll" (ByVal a As Long, ByVal DefectoInt As Long, ByVal DefectoStr As String, ByVal CaseSensitive As Long) As Long


Public Function INIDarClaveStr(a As Long, Seccion As Long, Clave As String) As String
Dim Tmp As String
Dim P As Long, R As Long

Tmp = Space$(3000)
R = INIDarClave(a, Seccion, Clave, Tmp, 3000)
P = InStr(1, Tmp, Chr$(0))
If P Then
    Tmp = Left$(Tmp, P - 1)
    
    INIDarClaveStr = Tmp
End If

End Function

Public Function INIDarNombreSeccionStr(a As Long, Seccion As Long) As String
Dim Tmp As String
Dim P As Long, R As Long

Tmp = Space$(3000)
R = INIDarNombreSeccion(a, Seccion, Tmp, 3000)
P = InStr(1, Tmp, Chr$(0))
If P Then
    Tmp = Left$(Tmp, P - 1)
    INIDarNombreSeccionStr = Tmp
End If

End Function

Public Function INIDarNombreClaveStr(a As Long, Seccion As Long, Clave As Long) As String
Dim Tmp As String
Dim P As Long, R As Long

Tmp = Space$(3000)
R = INIDarNombreClave(a, Seccion, Clave, Tmp, 3000)
P = InStr(1, Tmp, Chr$(0))
If P Then
    Tmp = Left$(Tmp, P - 1)
    INIDarNombreClaveStr = Tmp
End If

End Function

