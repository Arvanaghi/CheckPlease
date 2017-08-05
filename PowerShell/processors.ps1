if ((Get-WMIObject -Class Win32_Processor).NumberOfLogicalProcessors -ge $($args[0])) {
	Write-Output "Proceed!"
}