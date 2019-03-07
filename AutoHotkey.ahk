; IMPORTANT INFO ABOUT GETTING STARTED: Lines that start with a
; semicolon, such as this one, are comments.  They are not executed.

; This script has a special filename and path because it is automatically
; launched when you run the program directly.  Also, any text file whose
; name ends in .ahk is associated with the program, which means that it
; can be launched simply by double-clicking it.  You can have as many .ahk
; files as you want, located in any folder.  You can also run more than
; one ahk file simultaneously and each will get its own tray icon.

; SAMPLE HOTKEYS: Below are two sample hotkeys.  The first is Win+Z and it
; launches a web site in the default browser.  The second is Control+Alt+N
; and it launches a new Notepad window (or activates an existing one).  To
; try out these hotkeys, run AutoHotkey again, which will load this file.

#z::Run www.autohotkey.com

^!n::
IfWinExist Untitled - Notepad
	WinActivate
else
	Run Notepad
return


; Note: From now on whenever you run AutoHotkey directly, this script
; will be loaded.  So feel free to customize it to suit your needs.

; Please read the QUICK-START TUTORIAL near the top of the help file.
; It explains how to perform common automation tasks such as sending
; keystrokes and mouse clicks.  It also explains more about hotkeys.

; MY HOTKEYS:


; Remap Capslock
Capslock::Ctrl  
^+Capslock::Capslock

; MOUSE CLICKS
^Capslock::Send {Click}
!Capslock::Click Right ; right click
#Capslock::Send {Click 2} ; double left click 
+Capslock:: ; Left mouse click toggle useful for dragging and selecting stuff - had to use send so I could drag and drop files in explorer
   hold:= Not hold   ; toggle hold flag

   If hold
      {
       Send {Click Down} ; presses the left button
       ToolTip Left
      }
   else
      {
       Send {Click Up} ; releases the left button
       ToolTip
      }
   return

; MY HOTSTRINGS

; Symbols
::,em::{Asc 0151} ; Auto replace "--" with em dash. To actually create "--" type with a space and then delete space.
::,en::{ASC 0150} ;  Auto replace "-*" with en dash
::,hl::--- ; Put in three dashes for horizontal lines in markdown or in R script comments. 
::,md::{Asc 0183} ; Add midline decimal point (required by some journals)

; Email addresses

::,he::leftygray@gmail.com ; personal email
::,we::Rgray@kirby.unsw.edu.au ; work email

; Logins
::,lh::leftygray
::,lw::Rgray

; Time and dates

::,dd:: ; Current date in YYYY-MM-DD format
FormatTime, CurrentDateTime,, yyyy-MM-dd
SendInput %CurrentDateTime%
Return
::,dl::
FormatTime, CurrentDateTime,, d MMMM yyyy
SendInput %CurrentDateTime%
Return
::,ds::
FormatTime, CurrentDateTime,, d/MM/yyyy
SendInput %CurrentDateTime%
Return
::,day::
FormatTime, CurrentDateTime,, dddd
SendInput %CurrentDateTime%
Return
::,ts::
FormatTime, CurrentDateTime,, H:mm
SendInput %CurrentDateTime%
Return
::,tt::
FormatTime, CurrentDateTime,, h:mm tt
SendInput %CurrentDateTime%
Return
::,edt::
FormatTime, CurrentDateTime,, dddd
SendInput %CurrentDateTime%
Send {Space}{Asc 0151}{Space}
FormatTime, CurrentDateTime,, d/MM/yyyy
SendInput %CurrentDateTime%
Return
::,wdt::
Send, Work
Send {Space}{Asc 0151}{Space}
FormatTime, CurrentDateTime,, dddd
SendInput %CurrentDateTime%
Send {Space}{Asc 0151}{Space}
FormatTime, CurrentDateTime,, d/MM/yyyy
SendInput %CurrentDateTime%
Return

; Common folders/paths in windows


; Common text
::,wnb::
Send ^bAdmin^b`r`r^bMeetings^b`r`r^bReading^b`r
Return

; Canned responses for emails

:oc:,th::
(
Thanks.

Richard
)

:oc:,ch::
(
Cheers,
Richard
)

:oc:,pe::
(
Best regards,
Richard Gray
)

:oc:,ecb::
(
Best regards,
Richard Gray
On behalf of the Early Career Academic Network Executive Committee
)

; Addressess


; Temporary stuff
::,ap::Annual spending (millions USD)
::,pa::Proportion of acts protected


; Funny emoticons
