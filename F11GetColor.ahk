#NoEnv
#SingleInstance, Force
SetWinDelay, 10

nZ := 4                     ; Zoom Factor
nR := 220//2//nZ * nZ - 1   ; Rectangle of the Zoomer

CoordMode, Mouse,Relative
CoordMode, Pixel,Relative

ToolTip, %A_Space%

WinGet, hWnd, ID, ahk_class tooltips_class32
WinSet, ExStyle, +0x08000000, ahk_id %hWnd%

hDC_SC := DllCall("GetDC", "Uint", 0)
hDC_TT := DllCall("GetDC", "Uint", hWnd)

Loop
{
   MouseGetPos, xmouse, ymouse
   DllCall("StretchBlt", "Uint", hDC_TT, "int", 0, "int", 0, "int", 2*nR, "int", 2*nR, "Uint", hDC_SC, "int", xmouse-nR//nZ, "int", ymouse-nR//nZ, "int", 2*nR//nZ, "int", 2*nR//nZ, "Uint", 0x00CC0020)
   WinMove, ahk_id %hWnd%,, xmouse-nR, ymouse-nR, 2*nR, 2*nR


GetKeyState, state, NumpadAdd

MouseGetPos, MouseX, MouseY
PixelGetColor, color, % MouseX -1, % MouseY -1
tooltip % color,,,20


if state = D
       goto Exit 
}

DllCall("ReleaseDC", "Uint", 0, "Uint", hDC_SC)
DllCall("ReleaseDC", "Uint", hWnd, "Uint", hDC_TT)


F11::
;MouseGetPos, MouseX, MouseY
;PixelGetColor, color, %MouseX%, %MouseY%
clipboard:= "#" substr(color,7,2) substr(color,5,2) substr(color,3,2)
;tooltip % color,,,20
return 

Exit:
ExitApp