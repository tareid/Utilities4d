Add-Type @"
using System;
using System.Runtime.InteropServices;

public class Win32 {
    [DllImport("user32.dll", SetLastError = true)]
    [return: MarshalAs(UnmanagedType.Bool)]
    public static extern bool EnumWindows(EnumWindowsProc lpEnumFunc, IntPtr lParam);

    [DllImport("user32.dll", SetLastError = true)]
    [return: MarshalAs(UnmanagedType.Bool)]
    public static extern bool EnumChildWindows(IntPtr hWndParent, EnumWindowsProc lpEnumFunc, IntPtr lParam);

    [DllImport("user32.dll", CharSet = CharSet.Auto, SetLastError = true)]
    public static extern int GetWindowText(IntPtr hWnd, StringBuilder lpString, int nMaxCount);

    public delegate bool EnumWindowsProc(IntPtr hWnd, IntPtr lParam);
}
"@

$windows = [System.Collections.ArrayList]::new()
$callback = {
    param (
        [IntPtr]$hWnd,
        [IntPtr]$lParam
    )

    $sb = [System.Text.StringBuilder]::new(256)
    [void][Win32]::GetWindowText($hWnd, $sb, $sb.Capacity)
    $title = $sb.ToString()
    if ($title -like '*File Explorer*') {
        $windows.Add($title)
    }

    return $true
}

[Win32]::EnumWindows($callback, [IntPtr]::Zero) | Out-Null
$windows | ForEach-Object { Write-Output $_ }
