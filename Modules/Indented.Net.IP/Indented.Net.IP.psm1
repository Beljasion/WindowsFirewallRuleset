
<#
ISC License

Copyright (C) 2016, Chris Dent

Permission to use, copy, modify, and/or distribute this software for any
purpose with or without fee is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies.

THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
#>

# TODO: does StrictMode apply to this script only or also all dot sourced scripts?
Set-StrictMode -Version Latest
Set-Variable -Name ThisModule -Scope Script -Option ReadOnly -Force -Value ($MyInvocation.MyCommand.Name -replace ".{5}$")

#
# Module preferences
#

if ($Develop)
{
	$ErrorActionPreference = $ModuleErrorPreference
	$WarningPreference = $ModuleWarningPreference
	$DebugPreference = $ModuleDebugPreference
	$VerbosePreference = $ModuleVerbosePreference
	$InformationPreference = $ModuleInformationPreference

	Write-Debug -Message "[$ThisModule] ErrorActionPreference is $ErrorActionPreference"
	Write-Debug -Message "[$ThisModule] WarningPreference is $WarningPreference"
	Write-Debug -Message "[$ThisModule] DebugPreference is $DebugPreference"
	Write-Debug -Message "[$ThisModule] VerbosePreference is $VerbosePreference"
	Write-Debug -Message "[$ThisModule] InformationPreference is $InformationPreference"
}
else
{
	# Everything is default except InformationPreference should be enabled
	$InformationPreference = "Continue"
}

$private = @(
	'ConvertTo-Network'
	'Get-Permutation'
)

foreach ($file in $private)
{
	. ("{0}\private\{1}.ps1" -f $psscriptroot, $file)
}

$public = @(
	'ConvertFrom-HexIP'
	'ConvertTo-BinaryIP'
	'ConvertTo-DecimalIP'
	'ConvertTo-DottedDecimalIP'
	'ConvertTo-HexIP'
	'ConvertTo-Mask'
	'ConvertTo-MaskLength'
	'ConvertTo-Subnet'
	'Get-BroadcastAddress'
	'Get-NetworkAddress'
	'Get-NetworkRange'
	'Get-NetworkSummary'
	'Get-Subnet'
	'Resolve-IPAddress'
	'Test-SubnetMember'
)

foreach ($file in $public)
{
	. ("{0}\public\{1}.ps1" -f $psscriptroot, $file)
}

$functionsToExport = @(
	'ConvertFrom-HexIP'
	'ConvertTo-BinaryIP'
	'ConvertTo-DecimalIP'
	'ConvertTo-DottedDecimalIP'
	'ConvertTo-HexIP'
	'ConvertTo-Mask'
	'ConvertTo-MaskLength'
	'ConvertTo-Subnet'
	'Get-BroadcastAddress'
	'Get-NetworkAddress'
	'Get-NetworkRange'
	'Get-NetworkSummary'
	'Get-Subnet'
	'Resolve-IPAddress'
	'Test-SubnetMember'
)

Export-ModuleMember -Function $functionsToExport
