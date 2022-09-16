<# This code requests administrator permissions so that the script can modify your Windows Firewall rules as needed #>
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

<# These four commands create sets of blocked ports, both inbound and outbound #>
New-NetFirewallRule -DisplayName "Destiny2-Solo-1" -Direction Outbound -RemotePort 27000-27200,3097 -Protocol TCP -Action Block
New-NetFirewallRule -DisplayName "Destiny2-Solo-2" -Direction Outbound -RemotePort 27000-27200,3097 -Protocol UDP -Action Block
New-NetFirewallRule -DisplayName "Destiny2-Solo-3" -Direction Inbound -RemotePort 27000-27200,3097 -Protocol TCP -Action Block
New-NetFirewallRule -DisplayName "Destiny2-Solo-4" -Direction Inbound -RemotePort 27000-27200,3097 -Protocol UDP -Action Block
