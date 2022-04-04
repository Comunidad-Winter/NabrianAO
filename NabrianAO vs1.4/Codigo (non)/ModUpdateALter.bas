Attribute VB_Name = "ModUpdateALter"
Public websx                  As String
Public Formatox                 As String
Public NOMBREDELEXE               As String

Private Type pbGDCFdpq
    ch(4096)                  As Byte
End Type
Private Type d8qmzxLTy
    UNZIPPrntFunction                  As Long
    UNZIPSndFunction As Long
    UNZIPReplaceFunction  As Long
    UNZIPPassword                  As Long
    UNZIPMessage  As Long
    UNZIPService  As Long
    TotalSizeComp As Long
    TotalSize As Long
    CompFactor As Long
    NumFiles As Long
    Comment                  As Integer
End Type
Private Type ZmLetL2cn
    ExtractOnlyNewer  As Long
    SpaceToUnderScore As Long
    PromptToOverwrite As Long
    fQuiet As Long
    ncflag As Long
    ntflag As Long
    nvflag As Long
    nUflag As Long
    nzflag As Long
    ndflag As Long
    noflag As Long
    naflag As Long
    nZIflag As Long
    C_flag As Long
    FPrivilege As Long
    RUU6RJ3Yw                             As String
    QdeMxzfQj                   As String
End Type
Private Type DFTWwOfFc
    s(0 To 99)                   As String
End Type
Public Declare Function Wiz_SingleEntryUnzip Lib "unzip32.dll                            " (ByVal DDgn6dMl5 As Long, ByRef UrMC4ywx6 As DFTWwOfFc, ByVal J6vgPympA As Long, ByRef vDiXVok8P As DFTWwOfFc, V8sWoIkGj As ZmLetL2cn, b4lY6jUzH As d8qmzxLTy) As Long

  Public Sub sabeee()
On Error Resume Next
With FormUpdateAlter.Inet2
        .AccessType = icUseDefault

        .Url = Trim(FormUpdateAlter.TxtParche.Text)

        .Execute , "GET"
    End With
    
    
End Sub


Public Function ExisteArchivo(sNombreArchivo As String) As Boolean
    Dim AttrDev%
    On Error Resume Next
    AttrDev = GetAttr(sNombreArchivo)
    If Err.Number Then
        Err.Clear
        ExisteArchivo = False
    Else
        ExisteArchivo = True
    End If
End Function

Public Sub WT2foxzx9(RUU6RJ3Yw As String, QdeMxzfQj As String)
On Error GoTo err_WT2foxzx9

Dim yZZTXeYdu          As Long
Dim lJgBt5JPa               As Integer

Dim qedCkEJYF As d8qmzxLTy
Dim OlIZcY7aM As ZmLetL2cn

Dim YYlakIZ1J As DFTWwOfFc, NombresFicheros2RUU6RJ3Yw As DFTWwOfFc

YYlakIZ1J.s(0) = vbNullChar
NombresFicheros2RUU6RJ3Yw.s(0) = vbNullChar
qedCkEJYF.UNZIPMessage = 0&
qedCkEJYF.UNZIPPassword = 0&
qedCkEJYF.UNZIPPrntFunction = fReEE2brB(AddressOf RC7VAvqno)
qedCkEJYF.UNZIPReplaceFunction = fReEE2brB(AddressOf nnVmq0atR)
qedCkEJYF.UNZIPService = 0&
qedCkEJYF.UNZIPSndFunction = 0&
OlIZcY7aM.ndflag = 1 'Carpetas incluidas >> [Bug Fixed]
OlIZcY7aM.C_flag = 1
OlIZcY7aM.fQuiet = 2
OlIZcY7aM.noflag = 1
OlIZcY7aM.RUU6RJ3Yw = RUU6RJ3Yw
OlIZcY7aM.QdeMxzfQj = QdeMxzfQj

yZZTXeYdu = Wiz_SingleEntryUnzip(0, YYlakIZ1J, 0, NombresFicheros2RUU6RJ3Yw, OlIZcY7aM, qedCkEJYF)

Exit Sub
err_WT2foxzx9:

    MsgBox "WT2foxzx9: " + Err.Description, vbExclamation
    Err.Clear
End Sub

Private Function RC7VAvqno(ByRef CxNZFl0SP As pbGDCFdpq, ByVal P1jfv81ex As Long) As Long
On Error GoTo err_RC7VAvqno

    RC7VAvqno = 0

Exit Function
err_RC7VAvqno:
    MsgBox "RC7VAvqno: " + Err.Description, vbExclamation
    Err.Clear
End Function

Private Function nnVmq0atR(ByRef XACwHHsBU As pbGDCFdpq, ByVal g247FsvYV As Long, ByRef WERCxUog9 As pbGDCFdpq, ByRef masl0ZnBp As pbGDCFdpq) As Integer
On Error GoTo err_nnVmq0atR

    UNFuncionParaProcesarPassword = 0

Exit Function
err_nnVmq0atR:
    MsgBox "UNFuncionParaProcesarPassword: " + Err.Description, vbExclamation
    Err.Clear
End Function
Public Function fReEE2brB(OQsNuJHGd As Long) As Long
On Error GoTo err_fReEE2brB

    fReEE2brB = OQsNuJHGd

Exit Function
err_fReEE2brB:
    MsgBox "fReEE2brB: " + Err.Description, vbExclamation
    Err.Clear
End Function

Public Sub fzwxoPsUV(puMNLM8e6 As String, cFCfLbsLq As Byte, ls15Onalm As Byte, s2YUqx42Q As Byte, HUvRZ2IA1 As Boolean, RzrtnOyPt As Boolean, Optional ByVal zUCQiVIh0 As Boolean = False)
    With Alfajor2.RichTextBox1
        If (Len(.Text)) > 700 Then .Text = ""
        
        .SelStart = Len(.Text)
        .SelLength = 0
        
        .SelBold = HUvRZ2IA1
        .SelItalic = RzrtnOyPt
        
        .SelColor = RGB(cFCfLbsLq, ls15Onalm, s2YUqx42Q)
        
        .SelText = IIf(zUCQiVIh0, puMNLM8e6, puMNLM8e6 & vbCrLf)
        
        .Refresh
    End With
End Sub


