if ((Get-WMIObject -Class Win32_ComputerSystem).Domain -eq ($($args) -join " ")) {
    Write-Output "Proceed!"
}