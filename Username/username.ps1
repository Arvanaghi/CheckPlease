$username = $env:username

if ($username -eq ($($args) -join " ")) {
	Write-Output "Proceed!"
}