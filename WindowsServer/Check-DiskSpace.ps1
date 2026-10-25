
# Windows Server Disk Space Monitoring
# Warning threshold: 15%

$WarningThreshold = 15

$Disks = Get-CimInstance Win32_LogicalDisk -Filter "DriveType=3"

foreach ($Disk in $Disks) {

    if ($Disk.Size -le 0) {
        continue
    }

    $TotalGB = [math]::Round($Disk.Size / 1GB, 2)
    $FreeGB = [math]::Round($Disk.FreeSpace / 1GB, 2)
    $FreePercent = [math]::Round(
        ($Disk.FreeSpace / $Disk.Size) * 100, 2
    )

    if ($FreePercent -lt $WarningThreshold) {
        $Status = "WARNING"
        $Color = "Red"
    }
    else {
        $Status = "OK"
        $Color = "Green"
    }

    Write-Host "$($Disk.DeviceID) | Total: $TotalGB GB | Free: $FreeGB GB | Free: $FreePercent% | $Status" -ForegroundColor $Color
}

