<# This code requests administrator permissions so that the script can modify your Windows Firewall rules as needed #>
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

<# Once user input is detected, the script resumes and removes the port blocks, restoring things to how they were prior to running #>
Remove-NetFirewallRule -DisplayName "Destiny2-Solo-1"
Remove-NetFirewallRule -DisplayName "Destiny2-Solo-2"
Remove-NetFirewallRule -DisplayName "Destiny2-Solo-3"
Remove-NetFirewallRule -DisplayName "Destiny2-Solo-4"