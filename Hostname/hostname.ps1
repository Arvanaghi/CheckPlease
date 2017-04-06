if ($env:computername -eq ($($args) -join " ")) {
    Write-Output "Proceed!"
}