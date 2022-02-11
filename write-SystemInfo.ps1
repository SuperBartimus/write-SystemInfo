<#
.SYNTAX       write-SystemInfo.ps1
.Author: Bart Strauss / https://github.com/SuperBartimus
.Version: 1.0
.DESCRIPTION  writes details of the current system to the console
.LINK         https://github.com/SuperBartimus/Misc-PowerShell_Scripts
.EXAMPLE      write-SystemInfo.ps1
    Computer System: LENOVO      20L6S1E700 (aka= T480)
    CPU0 : Intel(R) Core(TM) i7-8650U CPU @ 1.90GHz   [4 cores / 8 threads]
    GPU2:  [ 1GB VRAM /  Drv Ver: 30.0.101.1122 ]  (1920x1080 @ 60Hz) Intel(R) UHD Graphics 620
    Monitor: DELL P2417H     [ S/N: J1#######FL ]
    Interface:  [ ( Up ) 1 Gbps / 10.###.###.### ] Ethernet
    ExtIPv4: 2##.1##.###.### [ Loc: SomeTown, Texas  (3#.#### / -9#.####) ]
    Drive: C:\ [ (OS Drive) NTFS / Fixed / Lbl: "Windows_Drv" / 385.3GBs Free / 476.3GBs Total ]

.NOTES        MS Windows Flag Content based on: https://github.com/fleschutz/PowerShell/blob/master/Scripts/write-motd.ps1
.License: CC0
#>

$WinFormDLL = $($env:WinDir) + '\Microsoft.NET\Framework64\v4.0.30319\System.Windows.Forms.dll'
Add-Type -Path $WinFormDLL -ErrorAction SilentlyContinue # Required for to get cursor position

#Region Generate MS Windows Flag
Write-Host ""
# Save the current positions.
$x = [System.Console]::get_CursorLeft()
$y = [System.Console]::get_CursorTop()
# $CurrForegroundColor = [System.Console]::ForegroundColor
# $CurrBackgroundColor = [System.Console]::BackgroundColor

Write-Host ""
Write-Host " ,.=:^!^!t3Z3z., " -ForegroundColor Red

Write-Host " :tt:::tt333EE3 " -ForegroundColor Red

Write-Host " Et:::ztt33EEE " -ForegroundColor Red -NoNewline
Write-Host " @Ee., ..,     " -ForegroundColor green

Write-Host " ;tt:::tt333EE7" -ForegroundColor Red -NoNewline
Write-Host " ;EEEEEEttttt33# " -ForegroundColor Green

Write-Host " :Et:::zt333EEQ." -NoNewline -ForegroundColor Red
Write-Host " SEEEEEttttt33QL " -ForegroundColor Green

Write-Host " it::::tt333EEF" -NoNewline -ForegroundColor Red
Write-Host " @EEEEEEttttt33F " -ForegroundColor Green

Write-Host " ;3=*^``````'*4EEV" -NoNewline -ForegroundColor Red
Write-Host " :EEEEEEttttt33@. " -ForegroundColor Green

Write-Host " ,.=::::it=., " -NoNewline -ForegroundColor Cyan
Write-Host "``" -NoNewline -ForegroundColor Red
Write-Host " @EEEEEEtttz33QF " -ForegroundColor Green

Write-Host " ;::::::::zt33) " -NoNewline -ForegroundColor Cyan
Write-Host " '4EEEtttji3P* " -ForegroundColor Green

Write-Host " :t::::::::tt33." -NoNewline -ForegroundColor Cyan
Write-Host ":Z3z.. " -NoNewline -ForegroundColor Yellow
Write-Host " ````" -NoNewline -ForegroundColor Green
Write-Host " ,..g. " -ForegroundColor Yellow

Write-Host " i::::::::zt33F" -NoNewline -ForegroundColor Cyan
Write-Host " AEEEtttt::::ztF " -ForegroundColor Yellow

Write-Host " ;:::::::::t33V" -NoNewline -ForegroundColor Cyan
Write-Host " ;EEEttttt::::t3 " -NoNewline -ForegroundColor Yellow
Write-Host ""

Write-Host " E::::::::zt33L" -NoNewline -ForegroundColor Cyan
Write-Host " @EEEtttt::::z3F " -NoNewline -ForegroundColor Yellow
Write-Host ""

Write-Host " {3=*^``````'*4E3)" -NoNewline -ForegroundColor Cyan
Write-Host " ;EEEtttt:::::tZ`` " -NoNewline -ForegroundColor Yellow
Write-Host ""

Write-Host "              ``" -NoNewline -ForegroundColor Cyan
Write-Host " :EEEEtttt::::z7 " -NoNewline -ForegroundColor Yellow
Write-Host ""

Write-Host "                 'VEzjt:;;z>*`` " -ForegroundColor Yellow
Write-Host ""

# Collect the current positions of the end of the Flag
$x_end = [System.Console]::get_CursorLeft()
$y_end = [System.Console]::get_CursorTop()
#EndRegion Generate Windows Flag


#Region Retrieve information:
$Delay = 1 # Delay between each element written to the console (in milliseconds)
$x = 33 # X position of the cursor (in characters).  Used to position the cursor after right edge of the flag
$y += 0 # like above, but for Y position. Really not needed, but I like to keep it in case I need it later.

#Region Retrieve device Make/Model
Start-Sleep -Milliseconds $Delay; $x += 0 ; $y += 1; $Host.UI.RawUI.CursorPosition = @{ X = $x; Y = $y } ; Write-Host -Fore White "| " -NoNewline
Write-Host "Computer System: " -NoNewline -ForegroundColor Red
$ComputerSystem = Get-WmiObject -Class win32_computersystem
$Mke = $ComputerSystem.Manufacturer
$Mdl = (($ComputerSystem.Model).Replace($Mke, "")).Trim() # Remove Manufacturer from Model -- somtimes included in Model
#below replacings are to convert the model name to a common name for the procduct.
$Mdl = $Mdl.Replace("20L7002CUS", "$Mdl (aka= T480s)")
$Mdl = $Mdl.Replace("20L6S1E700", "$Mdl (aka= T480)")
$Mdl = $Mdl.Replace("20L6S0XV00", "$Mdl (aka= T480)")
$Mdl = $Mdl.Replace("20NX002XUS", "$Mdl (aka= T490)")
$Mdl = $Mdl.Replace("20NKS3BS00", "$Mdl (aka= T495)")
$ComputerSystem = $Mke + "`t" + $Mdl
Write-Host "$ComputerSystem" -ForegroundColor Cyan
#EndRegion Retrieve device Make/Model

#Region Retrieve Processor Information
Get-CimInstance -ClassName Win32_Processor | ForEach-Object {
    $x += 0 ; $y += 1; $Host.UI.RawUI.CursorPosition = @{ X = $x; Y = $y } ; Write-Host -Fore White "| " -NoNewline
    Write-Host "$($_.DeviceID) : " -NoNewline -ForegroundColor Red
    Write-Host "$($_.Name)  " -ForegroundColor Cyan -NoNewline
    $CPU_Info = " [" + $_.NumberOfCores + " cores / " + $_.NumberOfLogicalProcessors + " threads]"
    Write-Host "$CPU_Info" -ForegroundColor Blue -NoNewline
    Write-Host " ( $($_.MaxClockSpeed)GHz )" -ForegroundColor DarkGray
}
#EndRegion Retrieve Processor Information

#Region Retrieve CPU Usage
Start-Sleep -Milliseconds $Delay; $x += 0 ; $y += 1; $Host.UI.RawUI.CursorPosition = @{ X = $x; Y = $y } ; Write-Host -Fore White "| " -NoNewline
Write-Host "Processes: " -NoNewline -ForegroundColor Red
$NumberOfProcesses = (Get-Process).Count
Write-Host "$NumberOfProcesses" -ForegroundColor Cyan -NoNewline
Write-Host "     Current CPU Load: " -NoNewline -ForegroundColor Red
$Current_Load = $Processor.LoadPercentage
Write-Host "$Current_Load%" -ForegroundColor Cyan
#EndRegion Retrieve CPU Usage

#Region Retrieve Memory Information
Start-Sleep -Milliseconds $Delay; $x += 0 ; $y += 1; $Host.UI.RawUI.CursorPosition = @{ X = $x; Y = $y } ; Write-Host -Fore White "| " -NoNewline
Write-Host "Memory: " -NoNewline -ForegroundColor Red
$Memory_Size = Get-CimInstance Win32_OperatingSystem | Select-Object FreePhysicalMemory, TotalVisibleMemorySize # output in KB
$Memory_Size = "$([math]::Round($Memory_Size.FreePhysicalMemory / 1KB)) MBs free of $([math]::Round($Memory_Size.TotalVisibleMemorySize / 1KB)) MBs Total"
Write-Host "$Memory_Size" -ForegroundColor Cyan
#EndRegion Retrieve Memory Information

#Region Retrieve device's name
Start-Sleep -Milliseconds $Delay; $x += 0 ; $y += 1; $Host.UI.RawUI.CursorPosition = @{ X = $x; Y = $y } ; Write-Host -Fore White "| " -NoNewline
Write-Host "Hostname: " -NoNewline -ForegroundColor Red
Write-Host "$(hostname)" -ForegroundColor Cyan
#EndRegion Retrieve device's name

#Region Retrieve OS Information
Start-Sleep -Milliseconds $Delay; $x += 0 ; $y += 1; $Host.UI.RawUI.CursorPosition = @{ X = $x; Y = $y } ; Write-Host -Fore White "| " -NoNewline
Write-Host "OS: " -NoNewline -ForegroundColor Red
$OSInfo = (Get-WmiObject Win32_OperatingSystem  | Select-Object Caption, BuildNumber, OSArchitecture)
$OSName = $OSInfo.OSArchitecture + " " + $OSInfo.Caption + " " + $OSInfo.BuildNumber
Write-Host "$OSName" -ForegroundColor Cyan
#EndRegion Retrieve OS Information

#Region Retrieve Video Adapter Information
Get-WmiObject Win32_VideoController | Select-Object DeviceID, Description, AdapterRAM, Name, VideoProcessor, status, DriverVersion, CurrentHorizontalResolution, CurrentVerticalResolution, CurrentRefreshRate | ForEach-Object {
    $Video_InfoA = " [ " + [math]::round($_.AdapterRAM / 1GB, 1) + "GB VRAM" + " /  Drv Ver: " + $_.DriverVersion + " ]"
    $Video_InfoB = " (" + $_.CurrentHorizontalResolution + "x" + $_.CurrentVerticalResolution + " @ " + $_.CurrentRefreshRate + "Hz)"
    Start-Sleep -Milliseconds $Delay; $x += 0 ; $y += 1; $Host.UI.RawUI.CursorPosition = @{ X = $x; Y = $y } ; Write-Host -Fore White "| " -NoNewline
    Write-Host "$(($_.DeviceID).Replace("VideoController","GPU")): " -NoNewline -ForegroundColor Red
    Write-Host "$Video_InfoA " -ForegroundColor Blue -NoNewline
    Write-Host "$Video_InfoB " -ForegroundColor Gray -NoNewline
    Write-Host "$($_.Name)" -ForegroundColor Cyan
}
#EndRegion Retrieve Video Adapter Information

#Region Retrieve Monitor Information
function Decode { If ($args[0] -is [System.Array]) { [System.Text.Encoding]::ASCII.GetString($args[0]) }Else { "Not Found" } }

ForEach ($Monitor in Get-WmiObject WmiMonitorID -Namespace root\wmi) {
    $Manufacturer = Decode $Monitor.ManufacturerName -notmatch 0
    $Name = Decode $Monitor.UserFriendlyName -notmatch 0
    $Serial = Decode $Monitor.SerialNumberID -notmatch 0
    # $ManufactureWeek = (Get-WmiObject WmiMonitorID -Namespace root\wmi).WeekofManufacture
    # $ManufactureYear = (Get-WmiObject WmiMonitorID -Namespace root\wmi).YearOfManufacture
    Start-Sleep -Milliseconds $Delay; $x += 0 ; $y += 1; $Host.UI.RawUI.CursorPosition = @{ X = $x; Y = $y } ; Write-Host -Fore White "| " -NoNewline
    Write-Host "Monitor: " -NoNewline -ForegroundColor Red
    Write-Host "$Manufacturer`t$Name " -ForegroundColor Cyan -NoNewline
    Write-Host "`t[ S/N: $Serial ]" -ForegroundColor Blue
}
#EndRegion Retrieve Monitor Information

#Region Retrieve Interface Adapter Information
Get-NetAdapter -ErrorAction SilentlyContinue | Select-Object interfaceDescription, name, status, linkSpeed, ifIndex | ForEach-Object {
    $Interface_Info = $_.linkSpeed + " / "
    Get-NetIPAddress -InterfaceIndex $_.ifIndex -ErrorAction SilentlyContinue | Where-Object -Property AddressFamily -Like "*IPv4*" | Select-Object IPAddress, SubnetMask | ForEach-Object {
        $Interface_Info += $_.IPAddress
    }
    Start-Sleep -Milliseconds $Delay; $x += 0 ; $y += 1; $Host.UI.RawUI.CursorPosition = @{ X = $x; Y = $y } ; Write-Host -Fore White "| " -NoNewline
    Write-Host "Interface: " -NoNewline -ForegroundColor Red
    Write-Host " [ " -NoNewline -ForegroundColor Blue
    If ($_.status -eq 'Up') {
        Write-Host "( Up ) " -ForegroundColor Green -NoNewline
    }
    else {
        Write-Host "(Down) " -ForegroundColor yellow -NoNewline
    }
    Write-Host "$Interface_Info ] " -ForegroundColor Blue -NoNewline
    Write-Host "$($_.name)" -ForegroundColor Cyan
}
#EndRegion Retrieve Interface Adapter Information

#Region Retrieve External IP Address and Geolocation
Start-Sleep -Milliseconds $Delay; $x += 0 ; $y += 1; $Host.UI.RawUI.CursorPosition = @{ X = $x; Y = $y } ; Write-Host -Fore White "| " -NoNewline
Write-Host "ExtIPv4: " -NoNewline -ForegroundColor Red
$Location = Invoke-RestMethod -Method Get -Uri "http://ip-api.com/json/$((Invoke-WebRequest ifconfig.me/ip).Content.Trim())"
Write-Host "$($Location.query) " -ForegroundColor Cyan -NoNewline
Write-Host "[ Loc: " -ForegroundColor Blue -NoNewline
Write-Host "$($Location.city), $($Location.regionName)  ($($Location.lat) / $($Location.lon))" -ForegroundColor Gray -NoNewline
Write-Host " ]" -ForegroundColor Blue
#EndRegion Retrieve External IP Address and Geolocation

#Region Retrieve Drive Information
$SystemDrive = (Get-WmiObject win32_operatingsystem).systemdrive
[System.IO.DriveInfo]::getdrives() | Where-Object { $_.DriveType -ne 'Network' } | ForEach-Object {
    $Drive_Info = $_.DriveFormat + " / " + $_.DriveType + " / Lbl: """ + $_.VolumeLabel + """ / " + [math]::round($_.AvailableFreeSpace / 1GB, 1) + "GBs Free / " + [math]::round($_.TotalSize / 1GB, 1) + "GBs Total ]"
    Start-Sleep -Milliseconds $Delay; $x += 0 ; $y += 1; $Host.UI.RawUI.CursorPosition = @{ X = $x; Y = $y } ; Write-Host -Fore White "| " -NoNewline
    Write-Host "Drive: " -NoNewline -ForegroundColor Red
    Write-Host "$($_.Name)" -ForegroundColor Cyan -NoNewline
    Write-Host " [ " -NoNewline -ForegroundColor Blue
    If ($_.Name -like "*$SystemDrive*") {
        Write-Host "(OS Drive) " -ForegroundColor Green -NoNewline
    }
    Write-Host "$Drive_Info" -ForegroundColor Blue
}
#EndRegion Retrieve Drive Information

#Region Retrieve Power Information
Get-CimInstance -ClassName Win32_Battery | ForEach-Object {
    Start-Sleep -Milliseconds $Delay; $x += 0 ; $y += 1; $Host.UI.RawUI.CursorPosition = @{ X = $x; Y = $y } ; Write-Host -Fore White "| " -NoNewline
    Write-Host "$($_.Caption) (" -NoNewline -ForegroundColor Red
    Write-Host "$($_.name)" -NoNewline -ForegroundColor DarkGray
    Write-Host "): " -NoNewline -ForegroundColor Red
    Write-Host "Charged: $($_.EstimatedChargeRemaining)% " -ForegroundColor Green -NoNewline
    Write-Host "[ " -NoNewline -ForegroundColor Blue
    if ($null -eq $_.DesignCapacity) {
        Write-Host "Design Cap: (Unknown)mAh" -ForegroundColor Cyan -NoNewline
    }
    else {
        Write-Host "Design Cap: $($_.DesignCapacity)mAh" -ForegroundColor Cyan -NoNewline
    }

    Write-Host "`tStatus: $($_.Status) " -ForegroundColor Gray -NoNewline
    Write-Host "]" -ForegroundColor Blue

}
#EndRegion Retrieve Power Information

#Region Powershell Information
Start-Sleep -Milliseconds $Delay; $x += 0 ; $y += 1; $Host.UI.RawUI.CursorPosition = @{ X = $x; Y = $y } ; Write-Host -Fore White "| " -NoNewline
Write-Host "PowerShell: " -NoNewline -ForegroundColor Red
$PowerShellVersion = $PSVersionTable.PSVersion
$PowerShellEdition = $PSVersionTable.PSEdition
Write-Host "$PowerShellVersion $PowerShellEdition" -ForegroundColor Cyan
#EndRegion Powershell Information

#Region Retrieve User Information
Start-Sleep -Milliseconds $Delay; $x += 0 ; $y += 1; $Host.UI.RawUI.CursorPosition = @{ X = $x; Y = $y } ; Write-Host -Fore White "| " -NoNewline
Write-Host "User: " -NoNewline -ForegroundColor Red
Write-Host "$(whoami)" -ForegroundColor Cyan
#EndRegion Retrieve User Information

#Region Show Current Date and Time and Time Zone
Start-Sleep -Milliseconds $Delay; $x += 0 ; $y += 1; $Host.UI.RawUI.CursorPosition = @{ X = $x; Y = $y } ; Write-Host -Fore White "| " -NoNewline
Write-Host "Time: " -ForegroundColor Red -NoNewline
$CurrentTime = Get-Date -Format "yyyy-MMM-dd HH:mm"
$TimeZone = (Get-TimeZone).id
Write-Host "$CurrentTime " -ForegroundColor Cyan -NoNewline
Write-Host "$TimeZone" -ForegroundColor blue
#EndRegion Show Current Date and Time and Time Zone

#Region Show Current System Uptime
Start-Sleep -Milliseconds $Delay; $x += 0 ; $y += 1; $Host.UI.RawUI.CursorPosition = @{ X = $x; Y = $y } ; Write-Host -Fore White "| " -NoNewline
Write-Host "Uptime: " -NoNewline -ForegroundColor Red
$Uptime = New-TimeSpan -Start $((Get-CimInstance -ClassName win32_operatingsystem ).lastbootuptime) -End $(Get-Date)
$Uptime = "$(($uptime).Days) days, $(($uptime).Hours) hours, $(($uptime).Minutes) minutes and $(($uptime).Seconds) seconds"
Write-Host "$Uptime" -ForegroundColor Cyan
#EndRegion Show Current System Uptime

#EndRegion Retrieve information:

#Region Return cursor to bottom of MSWin Flag or end of information list, whichever is greater
$x += 0 ; $y += 1
If ($y -gt $y_end) { $y_end = $y }
Start-Sleep -Milliseconds $Delay; $x = $x_end ; $y = $y_end; $Host.UI.RawUI.CursorPosition = @{ X = $x; Y = $y }
#EndRegion Return cursor to bottom of MS Flag or end of information list, whichever is greater

#endregion Retrieve information:
exit 0
