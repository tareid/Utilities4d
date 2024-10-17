#Requires AutoHotkey v2.0
#Persistent

SetTitleMatchMode, 2

; Create a hidden window to hold the tray icon
Gui, +LastFound +AlwaysOnTop +ToolWindow
Gui, Show, Hide, TrayIconHolder

; List all open windows
WinGet, id, list

; Loop through each window id
Loop, %id%
{
    this_id := id%A_Index%
    WinGetTitle, title, ahk_id %this_id%

    ; If the title contains "File Explorer"
    IfInString, title, File Explorer
    {
        MsgBox, %title%
    }
}
Return
