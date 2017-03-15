<#
    PowerShell sleep acceleration checker via NTP cluster queries
    Module written by Brandon Arvanaghi 
    Website: arvanaghi.com 
    Twitter: @arvanaghi
#>

[Byte[]]$NTPTransmit=,1*48;
$NTPTransmit[0]=0x1B;

$Socket = New-Object Net.Sockets.Socket([Net.Sockets.AddressFamily]::InterNetwork,[Net.Sockets.SocketType]::Dgram,[Net.Sockets.ProtocolType]::Udp)
$Socket.SendTimeOut = 2000
$Socket.ReceiveTimeOut = 2000
$Socket.Connect('us.pool.ntp.org',123)
[Void]$Socket.Send($NTPTransmit)
[Void]$Socket.Receive($NTPTransmit)

$firstTime = [BitConverter]::ToUInt32($NTPTransmit[43..40], 0)

$firstTime -= 2208988800;
Write-Output "NTP time (in seconds) before sleeping: $firstTime"

Write-Output "Attempting to sleep for $($args[0]) seconds..."
Start-Sleep -s $($args[0])

[Byte[]]$secondTransmit=,1*48;
$secondTransmit[0]=0x1B;

$NewSock = New-Object Net.Sockets.Socket([Net.Sockets.AddressFamily]::InterNetwork,[Net.Sockets.SocketType]::Dgram,[Net.Sockets.ProtocolType]::Udp)
$NewSock.SendTimeOut = 2000
$NewSock.ReceiveTimeOut = 2000
$NewSock.Connect('us.pool.ntp.org',123)
[Void]$NewSock.Send($secondTransmit)
[Void]$NewSock.Receive($secondTransmit)
$NewSock.Close()

$secondTime = [BitConverter]::ToUInt32($secondTransmit[43..40], 0)

$secondTime -= 2208988800;
Write-Output "NTP time (in seconds) after sleeping: $secondTime"

$difference = $secondTime - $firstTime
Write-Output "Difference in NTP times (should be at least $($args[0]) seconds): $difference"

if ($difference -ge $($args[0])) {
	Write-Output "Proceed!"
}