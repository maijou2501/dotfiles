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

; Note: From now on whenever you run AutoHotkey directly, this script
; will be loaded.  So feel free to customize it to suit your needs.

; Please read the QUICK-START TUTORIAL near the top of the help file.
; It explains how to perform common automation tasks such as sending
; keystrokes and mouse clicks.  It also explains more about hotkeys.


; muhenkan & hjkl -> hjkl key bind
vk1Dsc07B & H:: Send {Left}
vk1Dsc07B & J:: Send {Down}
vk1Dsc07B & K:: Send {Up}
vk1Dsc07B & L:: Send {Right}

; henkan -> hankaku&zenkaku
vk1Csc079:: Send {sc029}

; muhenkan -> Esc
vk1Dsc07B:: Send {Esc}

; muhenkan & x -> Del
vk1Dsc07B & X:: Send {Delete}

; muhenkan & d -> Del
vk1Dsc07B & D:: Send {Delete}


; muhenkan & henkan -> Enter
vk1Dsc07B & vk1Csc079::Send {Enter}

; muhenkan & Space  -> hankaku Space
vk1Dsc07B & Space:: Send,{sc029}{Space}{sc029}

; muhenkan & ^  -> Home
; muhenkan & $ -> End
vk1Dsc07B & ^::Send {Home}
vk1Dsc07B & $::Send {End}

; muhenkan & a -> menu
vk1Dsc07B & a::Send,{AppsKey}

; Shift & Enter -> {hankaku&zenkaku}+Space + Space + Enter+{hankaku&zenkaku}
+Enter:: Send {sc029}{Space}{Space}{Enter}{sc029}