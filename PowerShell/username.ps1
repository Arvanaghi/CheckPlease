if ($env:username -eq ($($args) -join " ")) {
	Write-Output "Proceed!"
}