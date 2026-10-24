
# Check Windows Server Disk Space

Get-CimInstance Win32_LogicalDisk -Filter "DriveType=3" |
Select-Object DeviceID,
@{Name="TotalGB";Expression={
    [math]::Round($_.Size / 1GB, 2)
}},
@{Name="FreeGB";Expression={
    [math]::Round($_.FreeSpace / 1GB, 2)
}},
@{Name="FreePercent";Expression={
    if ($_.Size -gt 0) {
        [math]::Round(
            ($_.FreeSpace / $_.Size) * 100, 2
        )
    }
}} |
Format-Table -AutoSize

