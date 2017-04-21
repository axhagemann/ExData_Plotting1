Declare Function CryptAcquireContext Lib "advapi32" Alias "CryptAcquireContextA" (ByRef hProv As Long, ByVal sContainer As String, _
        ByVal sProvider As String, ByVal lProvType As Long, ByVal lFlags As Long) As Long

Declare Function CryptCreateHash Lib "advapi32" (ByVal hProv As Long, ByVal lALG_ID As Long, _
                                                 ByVal hKey As Long, ByVal lFlags As Long, ByRef hhash As Long) As Long

Declare Function CryptHashData Lib "advapi32" (ByVal hhash As Long, ByVal lDataPtr As Long, ByVal lLen As Long, ByVal lFlags As Long) As Long

Declare Function CryptGetHashParam Lib "advapi32" (ByVal hhash As Long, ByVal lParam As Long, ByVal sBuffer As String, _
                                                   ByRef lLen As Long, ByVal lFlags As Long) As Long

Declare Function CryptDestroyHash Lib "advapi32" (ByVal hhash As Long) As Long

Declare Function CryptReleaseContext Lib "advapi32" (ByVal hProv As Long, ByVal lFlags As Long) As Long

Const MS_DEF_PROV = "Microsoft Base Cryptographic Provider v1.0"
Const PROV_RSA_FULL As Long = 1
Const CRYPT_NEWKEYSET As Long = 8
Const CALG_MD5 As Long = 32771
Const HP_HASHVAL As Long = 2

Public Function MD5Hash(rngdata) As String
    Dim rngdata2 As String
    Dim hProv As Long
    Dim hhash As Long
    Dim lLen As Long
    Dim sBuffer As String
    Dim sBuffer2 As String
    Dim lresult As Long
    Dim i As Long
    
    CryptAcquireContext hProv, vbNullString, MS_DEF_PROV, PROV_RSA_FULL, 0
    If hProv = 0 Then
        CryptAcquireContext hProv, vbNullString, MS_DEF_PROV, PROV_RSA_FULL, CRYPT_NEWKEYSET
    End If
    If hProv <> 0 Then
        CryptCreateHash hProv, CALG_MD5, 0, 0, hhash
        If hhash <> 0 Then
            rngdata2 = StrConv(rngdata, vbFromUnicode)
            lresult = CryptHashData(hhash, StrPtr(rngdata2), LenB(rngdata2), 0&)
            sBuffer = Space(16)
            lLen = 16
            CryptGetHashParam hhash, HP_HASHVAL, sBuffer, lLen, 0
            For i = 1 To 16
                sBuffer2 = Hex(Asc(Mid(sBuffer, i, 1)))
                If Len(sBuffer2) <> 2 Then
                    MD5Hash = MD5Hash + "0" + sBuffer2
                Else
                    MD5Hash = MD5Hash + sBuffer2
                End If
            Next
            CryptDestroyHash hhash
        End If
        CryptReleaseContext hProv, 0
    End If
End Function

