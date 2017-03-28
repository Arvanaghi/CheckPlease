if((Get-WMIObject -Class Win32_ComputerSystem).Domain -eq "enterdomainhere")
{
    Write-Output "put code here"
}