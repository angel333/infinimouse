;
; InfiniMouse
;   an AutoIt script
;
; Author:  Ondrej Simek
; License: MIT
;
; If you move mouse to one border, it'll come from the other.
;
; Works for multiple screens too, but will have issues if the screen
; layout doesn't make a perfect rectangle (e.g. for different
; resolutions).
;


;; Settings ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

Global $ENABLE_LEFT_BORDER   = True
Global $ENABLE_RIGHT_BORDER  = True
Global $ENABLE_TOP_BORDER    = False
Global $ENABLE_BOTTOM_BORDER = False

Global $DELAY                = 20


;; Boundaries ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; for the constants see https://msdn.microsoft.com/en-us/library/windows/desktop/ms724385(v=vs.85).aspx
Global Const $SM_CXVIRTUALSCREEN = _
   DllCall("user32.dll", "int", "GetSystemMetrics", "int", 78)[0]
Global Const $SM_CYVIRTUALSCREEN = _
   DllCall("user32.dll", "int", "GetSystemMetrics", "int", 79)[0]
Global Const $SM_XVIRTUALSCREEN = _
   DllCall("user32.dll", "int", "GetSystemMetrics", "int", 76)[0]
Global Const $SM_YVIRTUALSCREEN = _
   DllCall("user32.dll", "int", "GetSystemMetrics", "int", 77)[0]

; Boundaries of the virtual screen
Global Const $X_MIN = $SM_XVIRTUALSCREEN
Global Const $X_MAX = $SM_CXVIRTUALSCREEN + $SM_XVIRTUALSCREEN - 1
Global Const $Y_MIN = $SM_YVIRTUALSCREEN
Global Const $Y_MAX = $SM_CYVIRTUALSCREEN + $SM_YVIRTUALSCREEN - 1

; Current mouse position
Global $Pos[2]


;; Main Loop ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

While 1
   $Pos = MouseGetPos ()

   If $ENABLE_RIGHT_BORDER And $Pos[0] = $X_MAX Then
	  MouseMove($X_MIN + 1, $Pos[1], 0)
   EndIf

   If $ENABLE_LEFT_BORDER And $Pos[0] = $X_MIN Then
	  MouseMove($X_MAX - 1, $Pos[1], 0)
   EndIf

   If $ENABLE_TOP_BORDER And $Pos[1] = $Y_MIN Then
	  MouseMove($Pos[0], $Y_MAX - 1, 0)
   EndIf

   If $ENABLE_BOTTOM_BORDER And $Pos[1] = $Y_MAX Then
	  MouseMove($Pos[0], $Y_MIN + 1, 0)
   EndIf

   Sleep($DELAY)
WEnd