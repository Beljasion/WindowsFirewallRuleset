
<#
MIT License

Copyright (c) 2019 metablaster zebal@protonmail.ch

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
#>

<#
http://www.iana.org/assignments/ipv6-multicast-addresses/ipv6-multicast-addresses.xhtml

IPv6 multicast addresses are distinguished from unicast addresses by the value of the high-order octet of the addresses:
a value of 0xFF (binary 11111111) identifies an address as a multicast address;
any other value identifies an address as a unicast address.

ff00/16 	Reserved
ff01/16	    Interface-Local scope
ff02/16	    Link-Local scope
ff03/16	    Realm-Local scope
ff04/16	    Admin-Local scope
ff05/16	    Site-Local scope
ff06/16	    Unassigned
ff07/16	    Unassigned
ff08/16	    Organization-Local scope
ff09/16 - ff0D/16	Unassigned	
ff0e/16	    Global scope
ff0f/16  	Reserved
#>

# TODO: see if edge traversal should be Allow in some rules

#
# Import global variables
#
. "$PSScriptRoot\..\..\Modules\GlobalVariables.ps1"

# Ask user if he wants to load these rules
if (!(RunThis)) { exit }

#
# Setup local variables:
#
$Group = "Multicast IPv6"
$Interface = "Wired, Wireless"
$Profile = "Private, Domain"
$Description = "http://www.iana.org/assignments/ipv6-multicast-addresses/ipv6-multicast-addresses.xhtml"

#First remove all existing rules matching setup
Remove-NetFirewallRule -PolicyStore $PolicyStore -Group $Group -Direction Inbound -ErrorAction SilentlyContinue

#
# Interface-Local Multicast filtering (All destinations)
#

New-NetFirewallRule -Confirm:$Execute -Whatif:$Debug -ErrorAction $OnError -Platform $Platform -PolicyStore $PolicyStore `
-DisplayName "Interface-Local Multicast" -Service Any -Program Any `
-Enabled False -Action Block -Group $Group -Profile $Profile -InterfaceType $Interface `
-Direction Inbound -Protocol UDP -LocalAddress ff01::/16 -RemoteAddress Any -LocalPort Any -RemotePort Any `
-EdgeTraversalPolicy Block -Localuser Any `
-Description $Description

#
# Interface-Local Multicast filtering (Individual destinations)
#

New-NetFirewallRule -Confirm:$Execute -Whatif:$Debug -ErrorAction $OnError -Platform $Platform -PolicyStore $PolicyStore `
-DisplayName "Interface-Local Multicast - All Nodes" -Service Any -Program Any `
-Enabled False -Action Allow -Group $Group -Profile $Profile -InterfaceType $Interface `
-Direction Inbound -Protocol UDP -LocalAddress ff01::1 -RemoteAddress Any -LocalPort Any -RemotePort Any `
-EdgeTraversalPolicy Block -Localuser Any `
-Description $Description

New-NetFirewallRule -Confirm:$Execute -Whatif:$Debug -ErrorAction $OnError -Platform $Platform -PolicyStore $PolicyStore `
-DisplayName "Interface-Local Multicast - All Routers" -Service Any -Program Any `
-Enabled False -Action Allow -Group $Group -Profile $Profile -InterfaceType $Interface `
-Direction Inbound -Protocol UDP -LocalAddress ff01::2 -RemoteAddress Any -LocalPort Any -RemotePort Any `
-EdgeTraversalPolicy Block -Localuser Any `
-Description $Description

New-NetFirewallRule -Confirm:$Execute -Whatif:$Debug -ErrorAction $OnError -Platform $Platform -PolicyStore $PolicyStore `
-DisplayName "Interface-Local Multicast - mDNSv6" -Service Any -Program Any `
-Enabled False -Action Allow -Group $Group -Profile $Profile -InterfaceType $Interface `
-Direction Inbound -Protocol UDP -LocalAddress ff01::fb -RemoteAddress Any -LocalPort Any -RemotePort Any `
-EdgeTraversalPolicy Block -Localuser Any `
-Description $Description


#
# Link-Local Multicast filtering (All destinations)
#

New-NetFirewallRule -Confirm:$Execute -Whatif:$Debug -ErrorAction $OnError -Platform $Platform -PolicyStore $PolicyStore `
-DisplayName "Link-Local Multicast" -Service Any -Program Any `
-Enabled False -Action Block -Group $Group -Profile $Profile -InterfaceType $Interface `
-Direction Inbound -Protocol UDP -LocalAddress ff02::/16 -RemoteAddress Any -LocalPort Any -RemotePort Any `
-EdgeTraversalPolicy Block -Localuser Any `
-Description $Description

#
# Link-Local Multicast filtering (Individual destinations)
#

New-NetFirewallRule -Confirm:$Execute -Whatif:$Debug -ErrorAction $OnError -Platform $Platform -PolicyStore $PolicyStore `
-DisplayName "Link-Local Multicast - All Nodes" -Service Any -Program Any `
-Enabled False -Action Allow -Group $Group -Profile $Profile -InterfaceType $Interface `
-Direction Inbound -Protocol UDP -LocalAddress ff02::1 -RemoteAddress Any -LocalPort Any -RemotePort Any `
-EdgeTraversalPolicy Block -Localuser Any `
-Description $Description

New-NetFirewallRule -Confirm:$Execute -Whatif:$Debug -ErrorAction $OnError -Platform $Platform -PolicyStore $PolicyStore `
-DisplayName "Link-Local Multicast - All Routers" -Service Any -Program Any `
-Enabled False -Action Allow -Group $Group -Profile $Profile -InterfaceType $Interface `
-Direction Inbound -Protocol UDP -LocalAddress ff02::2 -RemoteAddress Any -LocalPort Any -RemotePort Any `
-EdgeTraversalPolicy Block -Localuser Any `
-Description $Description

New-NetFirewallRule -Confirm:$Execute -Whatif:$Debug -ErrorAction $OnError -Platform $Platform -PolicyStore $PolicyStore `
-DisplayName "Link-Local Multicast - DVMRP Routers" -Service Any -Program Any `
-Enabled False -Action Allow -Group $Group -Profile $Profile -InterfaceType $Interface `
-Direction Inbound -Protocol UDP -LocalAddress ff02::4 -RemoteAddress Any -LocalPort Any -RemotePort Any `
-EdgeTraversalPolicy Block -Localuser Any `
-Description $Description

New-NetFirewallRule -Confirm:$Execute -Whatif:$Debug -ErrorAction $OnError -Platform $Platform -PolicyStore $PolicyStore `
-DisplayName "Link-Local Multicast - OSPFIGP" -Service Any -Program Any `
-Enabled False -Action Allow -Group $Group -Profile $Profile -InterfaceType $Interface `
-Direction Inbound -Protocol UDP -LocalAddress ff02::5 -RemoteAddress Any -LocalPort Any -RemotePort Any `
-EdgeTraversalPolicy Block -Localuser Any `
-Description $Description

New-NetFirewallRule -Confirm:$Execute -Whatif:$Debug -ErrorAction $OnError -Platform $Platform -PolicyStore $PolicyStore `
-DisplayName "Link-Local Multicast - OSPFIGP Designated Routers" -Service Any -Program Any `
-Enabled False -Action Allow -Group $Group -Profile $Profile -InterfaceType $Interface `
-Direction Inbound -Protocol UDP -LocalAddress ff02::6 -RemoteAddress Any -LocalPort Any -RemotePort Any `
-EdgeTraversalPolicy Block -Localuser Any `
-Description $Description

New-NetFirewallRule -Confirm:$Execute -Whatif:$Debug -ErrorAction $OnError -Platform $Platform -PolicyStore $PolicyStore `
-DisplayName "Link-Local Multicast - ST Routers" -Service Any -Program Any `
-Enabled False -Action Allow -Group $Group -Profile $Profile -InterfaceType $Interface `
-Direction Inbound -Protocol UDP -LocalAddress ff02::7 -RemoteAddress Any -LocalPort Any -RemotePort Any `
-EdgeTraversalPolicy Block -Localuser Any `
-Description $Description

New-NetFirewallRule -Confirm:$Execute -Whatif:$Debug -ErrorAction $OnError -Platform $Platform -PolicyStore $PolicyStore `
-DisplayName "Link-Local Multicast - ST Hosts" -Service Any -Program Any `
-Enabled False -Action Allow -Group $Group -Profile $Profile -InterfaceType $Interface `
-Direction Inbound -Protocol UDP -LocalAddress ff02::8 -RemoteAddress Any -LocalPort Any -RemotePort Any `
-EdgeTraversalPolicy Block -Localuser Any `
-Description $Description

New-NetFirewallRule -Confirm:$Execute -Whatif:$Debug -ErrorAction $OnError -Platform $Platform -PolicyStore $PolicyStore `
-DisplayName "Link-Local Multicast - RIP Routers" -Service Any -Program Any `
-Enabled False -Action Allow -Group $Group -Profile $Profile -InterfaceType $Interface `
-Direction Inbound -Protocol UDP -LocalAddress ff02::9 -RemoteAddress Any -LocalPort Any -RemotePort Any `
-EdgeTraversalPolicy Block -Localuser Any `
-Description $Description

New-NetFirewallRule -Confirm:$Execute -Whatif:$Debug -ErrorAction $OnError -Platform $Platform -PolicyStore $PolicyStore `
-DisplayName "Link-Local Multicast - EIGRP Routers" -Service Any -Program Any `
-Enabled False -Action Allow -Group $Group -Profile $Profile -InterfaceType $Interface `
-Direction Inbound -Protocol UDP -LocalAddress ff02::a -RemoteAddress Any -LocalPort Any -RemotePort Any `
-EdgeTraversalPolicy Block -Localuser Any `
-Description $Description

New-NetFirewallRule -Confirm:$Execute -Whatif:$Debug -ErrorAction $OnError -Platform $Platform -PolicyStore $PolicyStore `
-DisplayName "Link-Local Multicast - Mobile-Agents" -Service Any -Program Any `
-Enabled False -Action Allow -Group $Group -Profile $Profile -InterfaceType $Interface `
-Direction Inbound -Protocol UDP -LocalAddress ff02::b -RemoteAddress Any -LocalPort Any -RemotePort Any `
-EdgeTraversalPolicy Block -Localuser Any `
-Description $Description

New-NetFirewallRule -Confirm:$Execute -Whatif:$Debug -ErrorAction $OnError -Platform $Platform -PolicyStore $PolicyStore `
-DisplayName "Link-Local Multicast - SSDP" -Service Any -Program Any `
-Enabled False -Action Allow -Group $Group -Profile $Profile -InterfaceType $Interface `
-Direction Inbound -Protocol UDP -LocalAddress ff02::c -RemoteAddress Any -LocalPort Any -RemotePort Any `
-EdgeTraversalPolicy Block -Localuser Any `
-Description $Description

New-NetFirewallRule -Confirm:$Execute -Whatif:$Debug -ErrorAction $OnError -Platform $Platform -PolicyStore $PolicyStore `
-DisplayName "Link-Local Multicast - All PIM Routers" -Service Any -Program Any `
-Enabled False -Action Allow -Group $Group -Profile $Profile -InterfaceType $Interface `
-Direction Inbound -Protocol UDP -LocalAddress ff02::d -RemoteAddress Any -LocalPort Any -RemotePort Any `
-EdgeTraversalPolicy Block -Localuser Any `
-Description $Description

New-NetFirewallRule -Confirm:$Execute -Whatif:$Debug -ErrorAction $OnError -Platform $Platform -PolicyStore $PolicyStore `
-DisplayName "Link-Local Multicast - RSVP-ENCAPSULATION" -Service Any -Program Any `
-Enabled False -Action Allow -Group $Group -Profile $Profile -InterfaceType $Interface `
-Direction Inbound -Protocol UDP -LocalAddress ff02::e -RemoteAddress Any -LocalPort Any -RemotePort Any `
-EdgeTraversalPolicy Block -Localuser Any `
-Description $Description

New-NetFirewallRule -Confirm:$Execute -Whatif:$Debug -ErrorAction $OnError -Platform $Platform -PolicyStore $PolicyStore `
-DisplayName "Link-Local Multicast - UPnP" -Service Any -Program Any `
-Enabled False -Action Allow -Group $Group -Profile $Profile -InterfaceType $Interface `
-Direction Inbound -Protocol UDP -LocalAddress ff02::f -RemoteAddress Any -LocalPort Any -RemotePort Any `
-EdgeTraversalPolicy Block -Localuser Any `
-Description $Description

New-NetFirewallRule -Confirm:$Execute -Whatif:$Debug -ErrorAction $OnError -Platform $Platform -PolicyStore $PolicyStore `
-DisplayName "Link-Local Multicast - All-BBF-Access-Nodes" -Service Any -Program Any `
-Enabled False -Action Allow -Group $Group -Profile $Profile -InterfaceType $Interface `
-Direction Inbound -Protocol UDP -LocalAddress ff02::10 -RemoteAddress Any -LocalPort Any -RemotePort Any `
-EdgeTraversalPolicy Block -Localuser Any `
-Description $Description

New-NetFirewallRule -Confirm:$Execute -Whatif:$Debug -ErrorAction $OnError -Platform $Platform -PolicyStore $PolicyStore `
-DisplayName "Link-Local Multicast - VRRP" -Service Any -Program Any `
-Enabled False -Action Allow -Group $Group -Profile $Profile -InterfaceType $Interface `
-Direction Inbound -Protocol UDP -LocalAddress ff02::12 -RemoteAddress Any -LocalPort Any -RemotePort Any `
-EdgeTraversalPolicy Block -Localuser Any `
-Description $Description

New-NetFirewallRule -Confirm:$Execute -Whatif:$Debug -ErrorAction $OnError -Platform $Platform -PolicyStore $PolicyStore `
-DisplayName "Link-Local Multicast - All MLDv2-capable routers" -Service Any -Program Any `
-Enabled False -Action Allow -Group $Group -Profile $Profile -InterfaceType $Interface `
-Direction Inbound -Protocol UDP -LocalAddress ff02::16 -RemoteAddress Any -LocalPort Any -RemotePort Any `
-EdgeTraversalPolicy Block -Localuser Any `
-Description $Description

New-NetFirewallRule -Confirm:$Execute -Whatif:$Debug -ErrorAction $OnError -Platform $Platform -PolicyStore $PolicyStore `
-DisplayName "Link-Local Multicast - all-RPL-nodes" -Service Any -Program Any `
-Enabled False -Action Allow -Group $Group -Profile $Profile -InterfaceType $Interface `
-Direction Inbound -Protocol UDP -LocalAddress ff02::1a -RemoteAddress Any -LocalPort Any -RemotePort Any `
-EdgeTraversalPolicy Block -Localuser Any `
-Description $Description

New-NetFirewallRule -Confirm:$Execute -Whatif:$Debug -ErrorAction $OnError -Platform $Platform -PolicyStore $PolicyStore `
-DisplayName "Link-Local Multicast - All-Snoopers" -Service Any -Program Any `
-Enabled False -Action Allow -Group $Group -Profile $Profile -InterfaceType $Interface `
-Direction Inbound -Protocol UDP -LocalAddress ff02::6a -RemoteAddress Any -LocalPort Any -RemotePort Any `
-EdgeTraversalPolicy Block -Localuser Any `
-Description $Description

New-NetFirewallRule -Confirm:$Execute -Whatif:$Debug -ErrorAction $OnError -Platform $Platform -PolicyStore $PolicyStore `
-DisplayName "Link-Local Multicast - PTP-pdelay" -Service Any -Program Any `
-Enabled False -Action Allow -Group $Group -Profile $Profile -InterfaceType $Interface `
-Direction Inbound -Protocol UDP -LocalAddress ff02::6b -RemoteAddress Any -LocalPort Any -RemotePort Any `
-EdgeTraversalPolicy Block -Localuser Any `
-Description $Description

New-NetFirewallRule -Confirm:$Execute -Whatif:$Debug -ErrorAction $OnError -Platform $Platform -PolicyStore $PolicyStore `
-DisplayName "Link-Local Multicast - Saratoga" -Service Any -Program Any `
-Enabled False -Action Allow -Group $Group -Profile $Profile -InterfaceType $Interface `
-Direction Inbound -Protocol UDP -LocalAddress ff02::6c -RemoteAddress Any -LocalPort Any -RemotePort Any `
-EdgeTraversalPolicy Block -Localuser Any `
-Description $Description

New-NetFirewallRule -Confirm:$Execute -Whatif:$Debug -ErrorAction $OnError -Platform $Platform -PolicyStore $PolicyStore `
-DisplayName "Link-Local Multicast - LL-MANET-Routers" -Service Any -Program Any `
-Enabled False -Action Allow -Group $Group -Profile $Profile -InterfaceType $Interface `
-Direction Inbound -Protocol UDP -LocalAddress ff02::6d -RemoteAddress Any -LocalPort Any -RemotePort Any `
-EdgeTraversalPolicy Block -Localuser Any `
-Description $Description

New-NetFirewallRule -Confirm:$Execute -Whatif:$Debug -ErrorAction $OnError -Platform $Platform -PolicyStore $PolicyStore `
-DisplayName "Link-Local Multicast - IGRS" -Service Any -Program Any `
-Enabled False -Action Allow -Group $Group -Profile $Profile -InterfaceType $Interface `
-Direction Inbound -Protocol UDP -LocalAddress ff02::6e -RemoteAddress Any -LocalPort Any -RemotePort Any `
-EdgeTraversalPolicy Block -Localuser Any `
-Description $Description

New-NetFirewallRule -Confirm:$Execute -Whatif:$Debug -ErrorAction $OnError -Platform $Platform -PolicyStore $PolicyStore `
-DisplayName "Link-Local Multicast - iADT Discovery" -Service Any -Program Any `
-Enabled False -Action Allow -Group $Group -Profile $Profile -InterfaceType $Interface `
-Direction Inbound -Protocol UDP -LocalAddress ff02::6f -RemoteAddress Any -LocalPort Any -RemotePort Any `
-EdgeTraversalPolicy Block -Localuser Any `
-Description $Description

New-NetFirewallRule -Confirm:$Execute -Whatif:$Debug -ErrorAction $OnError -Platform $Platform -PolicyStore $PolicyStore `
-DisplayName "Link-Local Multicast - mDNSv6" -Service Any -Program Any `
-Enabled False -Action Allow -Group $Group -Profile $Profile -InterfaceType $Interface `
-Direction Inbound -Protocol UDP -LocalAddress ff02::fb -RemoteAddress Any -LocalPort Any -RemotePort Any `

New-NetFirewallRule -Confirm:$Execute -Whatif:$Debug -ErrorAction $OnError -Platform $Platform -PolicyStore $PolicyStore `
-DisplayName "Link-Local Multicast - Link Name" -Service Any -Program Any `
-Enabled False -Action Allow -Group $Group -Profile $Profile -InterfaceType $Interface `
-Direction Inbound -Protocol UDP -LocalAddress ff02::1:1 -RemoteAddress Any -LocalPort Any -RemotePort Any `
-EdgeTraversalPolicy Block -Localuser Any `
-Description $Description

New-NetFirewallRule -Confirm:$Execute -Whatif:$Debug -ErrorAction $OnError -Platform $Platform -PolicyStore $PolicyStore `
-DisplayName "Link-Local Multicast - All-dhcp-agents" -Service Any -Program Any `
-Enabled False -Action Allow -Group $Group -Profile $Profile -InterfaceType $Interface `
-Direction Inbound -Protocol UDP -LocalAddress ff02::1:2 -RemoteAddress Any -LocalPort Any -RemotePort Any `
-EdgeTraversalPolicy Block -Localuser Any `
-Description $Description

New-NetFirewallRule -Confirm:$Execute -Whatif:$Debug -ErrorAction $OnError -Platform $Platform -PolicyStore $PolicyStore `
-DisplayName "Link-Local Multicast - Link-local Multicast Name Resolution" -Service Any -Program Any `
-Enabled False -Action Allow -Group $Group -Profile $Profile -InterfaceType $Interface `
-Direction Inbound -Protocol UDP -LocalAddress ff02::1:3 -RemoteAddress Any -LocalPort Any -RemotePort Any `
-EdgeTraversalPolicy Block -Localuser Any `
-Description $Description

New-NetFirewallRule -Confirm:$Execute -Whatif:$Debug -ErrorAction $OnError -Platform $Platform -PolicyStore $PolicyStore `
-DisplayName "Link-Local Multicast - DTCP Announcement" -Service Any -Program Any `
-Enabled False -Action Allow -Group $Group -Profile $Profile -InterfaceType $Interface `
-Direction Inbound -Protocol UDP -LocalAddress ff02::1:4 -RemoteAddress Any -LocalPort Any -RemotePort Any `
-EdgeTraversalPolicy Block -Localuser Any `
-Description $Description

New-NetFirewallRule -Confirm:$Execute -Whatif:$Debug -ErrorAction $OnError -Platform $Platform -PolicyStore $PolicyStore `
-DisplayName "Link-Local Multicast - afore_vdp" -Service Any -Program Any `
-Enabled False -Action Allow -Group $Group -Profile $Profile -InterfaceType $Interface `
-Direction Inbound -Protocol UDP -LocalAddress ff02::1:5 -RemoteAddress Any -LocalPort Any -RemotePort Any `
-EdgeTraversalPolicy Block -Localuser Any `
-Description $Description

New-NetFirewallRule -Confirm:$Execute -Whatif:$Debug -ErrorAction $OnError -Platform $Platform -PolicyStore $PolicyStore `
-DisplayName "Link-Local Multicast - Babel" -Service Any -Program Any `
-Enabled False -Action Allow -Group $Group -Profile $Profile -InterfaceType $Interface `
-Direction Inbound -Protocol UDP -LocalAddress ff02::1:6 -RemoteAddress Any -LocalPort Any -RemotePort Any `
-EdgeTraversalPolicy Block -Localuser Any `
-Description $Description

New-NetFirewallRule -Confirm:$Execute -Whatif:$Debug -ErrorAction $OnError -Platform $Platform -PolicyStore $PolicyStore `
-DisplayName "Link-Local Multicast - Solicited-Node Address" -Service Any -Program Any `
-Enabled False -Action Allow -Group $Group -Profile $Profile -InterfaceType $Interface `
-Direction Inbound -Protocol UDP -LocalAddress ff02::1:ff00:0000/104 -RemoteAddress Any -LocalPort Any -RemotePort Any `
-EdgeTraversalPolicy Block -Localuser Any `
-Description $Description

New-NetFirewallRule -Confirm:$Execute -Whatif:$Debug -ErrorAction $OnError -Platform $Platform -PolicyStore $PolicyStore `
-DisplayName "Link-Local Multicast - Node Information Queries" -Service Any -Program Any `
-Enabled False -Action Allow -Group $Group -Profile $Profile -InterfaceType $Interface `
-Direction Inbound -Protocol UDP -LocalAddress FF02:0:0:0:0:2:FF00::/104 -RemoteAddress Any -LocalPort Any -RemotePort Any `
-EdgeTraversalPolicy Block -Localuser Any `
-Description $Description

#
# Site-Local Multicast filtering (All destinations)
#

New-NetFirewallRule -Confirm:$Execute -Whatif:$Debug -ErrorAction $OnError -Platform $Platform -PolicyStore $PolicyStore `
-DisplayName "Site-Local Multicast - All Routers" -Service Any -Program Any `
-Enabled False -Action Block -Group $Group -Profile $Profile -InterfaceType $Interface `
-Direction Inbound -Protocol UDP -LocalAddress ff05::/16 -RemoteAddress Any -LocalPort Any -RemotePort Any `
-EdgeTraversalPolicy Block -Localuser Any `
-Description $Description

#
# Site-Local Multicast filtering (Individual destinations)
#

New-NetFirewallRule -Confirm:$Execute -Whatif:$Debug -ErrorAction $OnError -Platform $Platform -PolicyStore $PolicyStore `
-DisplayName "Site-Local Multicast - All Routers" -Service Any -Program Any `
-Enabled False -Action Allow -Group $Group -Profile $Profile -InterfaceType $Interface `
-Direction Inbound -Protocol UDP -LocalAddress ff05::2 -RemoteAddress Any -LocalPort Any -RemotePort Any `
-EdgeTraversalPolicy Block -Localuser Any `
-Description $Description

New-NetFirewallRule -Confirm:$Execute -Whatif:$Debug -ErrorAction $OnError -Platform $Platform -PolicyStore $PolicyStore `
-DisplayName "Site-Local Multicast - mDNSv6" -Service Any -Program Any `
-Enabled False -Action Allow -Group $Group -Profile $Profile -InterfaceType $Interface `
-Direction Inbound -Protocol UDP -LocalAddress ff05::fb -RemoteAddress Any -LocalPort Any -RemotePort Any `
-EdgeTraversalPolicy Block -Localuser Any `
-Description $Description

New-NetFirewallRule -Confirm:$Execute -Whatif:$Debug -ErrorAction $OnError -Platform $Platform -PolicyStore $PolicyStore `
-DisplayName "Site-Local Multicast - All-dhcp-servers" -Service Any -Program Any `
-Enabled False -Action Allow -Group $Group -Profile $Profile -InterfaceType $Interface `
-Direction Inbound -Protocol UDP -LocalAddress ff05::1:3 -RemoteAddress Any -LocalPort Any -RemotePort Any `
-EdgeTraversalPolicy Block -Localuser Any `
-Description $Description

New-NetFirewallRule -Confirm:$Execute -Whatif:$Debug -ErrorAction $OnError -Platform $Platform -PolicyStore $PolicyStore `
-DisplayName "Site-Local Multicast - SL-MANET-ROUTERS" -Service Any -Program Any `
-Enabled False -Action Allow -Group $Group -Profile $Profile -InterfaceType $Interface `
-Direction Inbound -Protocol UDP -LocalAddress ff05::1:5 -RemoteAddress Any -LocalPort Any -RemotePort Any `
-EdgeTraversalPolicy Block -Localuser Any `
-Description $Description

#
# Realm-Local Multicast filtering (All destinations)
#

New-NetFirewallRule -Confirm:$Execute -Whatif:$Debug -ErrorAction $OnError -Platform $Platform -PolicyStore $PolicyStore `
-DisplayName "Realm-Local Multicast" -Service Any -Program Any `
-Enabled False -Action Block -Group $Group -Profile $Profile -InterfaceType $Interface `
-Direction Inbound -Protocol UDP -LocalAddress ff01::/16 -RemoteAddress Any -LocalPort Any -RemotePort Any `
-EdgeTraversalPolicy Block -Localuser Any `
-Description $Description

#
# Admin-Local Multicast filtering (All destinations)
#

New-NetFirewallRule -Confirm:$Execute -Whatif:$Debug -ErrorAction $OnError -Platform $Platform -PolicyStore $PolicyStore `
-DisplayName "Admin-Local Multicast" -Service Any -Program Any `
-Enabled False -Action Block -Group $Group -Profile $Profile -InterfaceType $Interface `
-Direction Inbound -Protocol UDP -LocalAddress ff01::/16 -RemoteAddress Any -LocalPort Any -RemotePort Any `
-EdgeTraversalPolicy Block -Localuser Any `
-Description $Description

#
# Organization-Local Multicast filtering (All destinations)
#

New-NetFirewallRule -Confirm:$Execute -Whatif:$Debug -ErrorAction $OnError -Platform $Platform -PolicyStore $PolicyStore `
-DisplayName "Organization-Local Multicast" -Service Any -Program Any `
-Enabled False -Action Block -Group $Group -Profile $Profile -InterfaceType $Interface `
-Direction Inbound -Protocol UDP -LocalAddress ff01::/16 -RemoteAddress Any -LocalPort Any -RemotePort Any `
-EdgeTraversalPolicy Block -Localuser Any `
-Description $Description

#
# Global scope Multicast filtering (All destinations)
#

New-NetFirewallRule -Confirm:$Execute -Whatif:$Debug -ErrorAction $OnError -Platform $Platform -PolicyStore $PolicyStore `
-DisplayName "Global scope Multicast" -Service Any -Program Any `
-Enabled False -Action Block -Group $Group -Profile $Profile -InterfaceType $Interface `
-Direction Inbound -Protocol UDP -LocalAddress ff01::/16 -RemoteAddress Any -LocalPort Any -RemotePort Any `
-EdgeTraversalPolicy Block -Localuser Any `
-Description $Description