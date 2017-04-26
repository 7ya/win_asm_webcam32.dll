; Author:            7ya
; Update date:       26.04.2017
; Contact:           7ya@protonmail.com
; Internet address:  https://github.com/7ya/win_asm_webcam32.dll
; License:           GPL-3.0
;------------------------------------------------------------------------------
    __UNICODE__ equ 1
    include \masm32\include\masm32rt.inc

    includelib webcam32.lib
    include webcam32.inc

about_box               proto :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
WinMain                 proto :DWORD, :DWORD, :DWORD, :DWORD
vw_proc                 proto :DWORD, :DWORD, :DWORD, :DWORD
update_menu_webcam      proto :DWORD, :DWORD, :DWORD, :DWORD
update_menu_mic         proto :DWORD, :DWORD

s MACRO idstr, temp_str, siz_buf
    invoke LoadString, hInstance, idstr, addr temp_str, siz_buf
    EXITM <addr temp_str>
ENDM

.data
    UC ClassTest,   "Test_Window", 0
    UC ClassVW,     "Test_Video_Window", 0
    ;-------
    h_hmenu2        dd 0
    hmenu1          dd 0
    
.data?
    hInstance       dd ?
    CommandLine     dd ?
    hWin            dd ?
    hmenu           dd ?
    hmenu2          dd ?
    h_hmenu         dd ?
    i_str           dd ?

    focus_hwnd      dd ?
    buffer          TCHAR 1024 dup (?)
    temp_str        TCHAR 1024 dup (?)

    poin            POINT <>
    rct             RECT <>
    wc              WNDCLASSEX <>
    iccex           INITCOMMONCONTROLSEX <>
    seci            SHELLEXECUTEINFO <>
    bmpinf          BITMAPINFOHEADER <>

.code

start:
invoke GetCommandLine
mov CommandLine, eax
invoke GetModuleHandle, 0
mov hInstance, eax
mov iccex.dwSize, sizeof INITCOMMONCONTROLSEX
mov iccex.dwICC, ICC_WIN95_CLASSES
invoke InitCommonControlsEx, addr iccex
invoke WinMain, hInstance, 0, CommandLine, SW_SHOWDEFAULT
invoke ExitProcess, eax
;*********************************************************************************************************************************************************
WinMain proc hInst:HINSTANCE, hPrevInst:HINSTANCE, CmdLine:LPSTR, CmdShow:DWORD
LOCAL msg:MSG
    mov wc.cbSize, sizeof WNDCLASSEX
    mov wc.style, CS_HREDRAW or CS_VREDRAW
    mov wc.lpfnWndProc, offset WndProc
    mov wc.cbClsExtra, 0
    mov wc.cbWndExtra, 0
    mrm wc.hInstance, hInstance
    invoke LoadIcon, hInstance, 1101
    mov wc.hIcon, eax
    mov wc.hIconSm, eax
    invoke LoadCursor, 0, IDC_ARROW
    mov wc.hCursor, eax
    mov wc.hbrBackground, COLOR_BTNFACE+1
    mov wc.lpszMenuName, 0
    mov wc.lpszClassName, offset ClassTest
    invoke RegisterClassEx, addr wc
    invoke CreateWindowEx, 0, addr ClassTest, s(1018, temp_str, 1024), WS_OVERLAPPEDWINDOW or WS_CLIPCHILDREN or WS_VISIBLE, 150, 50, 750, 450, 0, 0, hInstance, 0
    mov hWin, eax
    .WHILE TRUE
        invoke GetMessage, addr msg, 0, 0, 0
    .BREAK .IF (!eax)
        invoke TranslateMessage, addr msg
        invoke DispatchMessage, addr msg
    .ENDW
    mov eax, msg.wParam
ret
WinMain endp
;*********************************************************************************************************************************************************
WndProc proc hWnd:HWND, uMsg:UINT, wParam:WPARAM, lParam:LPARAM
LOCAL loc_1:DWORD, loc_2:DWORD
.IF uMsg== WM_CREATE
    invoke CoInitializeEx, 0, COINIT_MULTITHREADED or COINIT_SPEED_OVER_MEMORY
    invoke CreatePopupMenu
    mov hmenu, eax
    invoke CreatePopupMenu
    mov hmenu1, eax
    invoke CreatePopupMenu
    mov hmenu2, eax
    invoke AppendMenu, hmenu, MF_STRING, 3001, s(1000, temp_str, 1024)
    invoke AppendMenu, hmenu, MF_STRING, 3002, s(1001, temp_str, 1024)
    invoke AppendMenu, hmenu, MF_STRING, 3010, s(1012, temp_str, 1024)
    invoke AppendMenu, hmenu, MF_SEPARATOR, 0, 0
    invoke AppendMenu, hmenu, MF_POPUP or MF_STRING, hmenu1, s(1025, temp_str, 1024)
    invoke AppendMenu, hmenu, MF_SEPARATOR, 0, 0
    invoke AppendMenu, hmenu, MF_STRING, 3014, s(1017, temp_str, 1024)
    invoke AppendMenu, hmenu, MF_STRING, 3012, s(1014, temp_str, 1024)
    invoke AppendMenu, hmenu, MF_STRING, 3015, s(1015, temp_str, 1024)
    invoke AppendMenu, hmenu, MF_SEPARATOR, 0, 0
    invoke AppendMenu, hmenu, MF_POPUP or MF_STRING, hmenu2, s(1002, temp_str, 1024)
    invoke AppendMenu, hmenu2, MF_STRING, 3005, s(1007, temp_str, 1024)
    invoke AppendMenu, hmenu2, MF_SEPARATOR, 0, 0
    invoke AppendMenu, hmenu2, MF_STRING, 3008, s(1008, temp_str, 1024)
    invoke AppendMenu, hmenu2, MF_STRING, 3016, s(1020, temp_str, 1024)
    invoke AppendMenu, hmenu2, MF_STRING, 3017, s(1021, temp_str, 1024)
    invoke AppendMenu, hmenu, MF_STRING, 3006, s(1003, temp_str, 1024)
    invoke AppendMenu, hmenu, MF_SEPARATOR, 0, 0
    invoke AppendMenu, hmenu, MF_STRING, 3004, s(1004, temp_str, 1024)
    invoke AppendMenu, hmenu, MF_STRING, 3011, s(1013, temp_str, 1024)
    invoke AppendMenu, hmenu, MF_SEPARATOR, 0, 0
    invoke AppendMenu, hmenu, MF_STRING, 3007, s(1005, temp_str, 1024)
    invoke AppendMenu, hmenu, MF_STRING, 3013, s(1016, temp_str, 1024)
    invoke AppendMenu, hmenu, MF_STRING, 3009, s(1011, temp_str, 1024)
    invoke AppendMenu, hmenu, MF_SEPARATOR, 0, 0
    invoke AppendMenu, hmenu, MF_STRING, 3003, s(1006, temp_str, 1024)
;----------------------------------------------------------------------------------------
    invoke CreateMenu
    mov h_hmenu, eax
    invoke CreatePopupMenu
    mov h_hmenu2, eax
    invoke AppendMenu, h_hmenu, MF_POPUP or MF_STRING, h_hmenu2, s(1010, temp_str, 1024)
    invoke AppendMenu, h_hmenu, MF_STRING, 3999, s(1019, temp_str, 1024)
    call WebCamList
    invoke SetMenu, hWnd, h_hmenu
.ELSEIF uMsg== WM_COMMAND
    mov eax, wParam
    ror eax, 16
    .IF ax== BN_CLICKED
        ror eax, 16
;----------------------------------------------------------------------------------------
        .IF ax== 3999
            invoke about_box, hInstance, hWnd, ucc$("webcam32.lib v3 test © 2017 Author: 7ya\nContact: 7ya@protonmail.com\nhttps://github.com/7ya/win_asm_webcam32.dll\n\n"), s(1018, temp_str, 1024), MB_OK, 900

        .ELSEIF ax>= 4000
            sub ax, 4000
            movzx ebx, ax
            invoke CreateVideoWindow, ebx, 0h, WS_CHILD or WS_VISIBLE, 0, 0, 0, 0, 0, hWnd, 010002h, addr vw_proc, hInstance
            .if eax> 1 && eax< -2
                mov loc_1, eax
                invoke GetWindowText, loc_1, addr buffer, 2048
                mov wc.style, CS_DBLCLKS
                mov wc.lpfnWndProc, offset VWProc
                mov wc.cbWndExtra, 20
                mov wc.lpszClassName, offset ClassVW
                invoke RegisterClassEx, addr wc
                invoke CreateWindowEx, WS_EX_TOPMOST, addr ClassVW, addr buffer, WS_OVERLAPPEDWINDOW or WS_CLIPCHILDREN or WS_CLIPSIBLINGS or WS_VISIBLE or WS_THICKFRAME or WS_CHILD, 0, 0, 350, 350, hWnd, 0, hInstance, 0
                mov loc_2, eax
                invoke SendMessage, loc_2, WM_NCACTIVATE, 1, 0
                invoke SetParent, loc_1, loc_2
                invoke SetWindowLong, loc_2, 0, loc_1
                invoke GetClientRect, loc_2, addr rct
                invoke MoveWindow, loc_1, 0, 0, rct.right, rct.bottom, 1
            .endif
            call WebCamList
        .ENDIF
    .ENDIF

.ELSEIF uMsg== WM_DEVICECHANGE                      ;обновление
    call WebCamList
    
.ELSEIF uMsg== WM_CLOSE || uMsg== WM_DESTROY
    invoke CoUninitialize
    invoke PostQuitMessage, 0
.ELSE
    invoke DefWindowProc, hWnd, uMsg, wParam, lParam
    ret
.ENDIF
return 0 
WndProc endp
;*********************************************************************************************************************************************************
WebCamList proc
    mov i_str, 4000
    .if h_hmenu2!= 0
        invoke DestroyMenu, h_hmenu2
        mov h_hmenu2, 0
    .endif
    invoke CreatePopupMenu
    mov h_hmenu2, eax
    invoke ModifyMenu, h_hmenu, 0, MF_BYPOSITION or MF_ENABLED or MF_POPUP or MF_STRING, h_hmenu2, s(1010, temp_str, 1024)
    invoke GetDeviceName, GDN_WEBCAM, addr update_menu_webcam
    .if i_str== 4000
        invoke EnableMenuItem, h_hmenu, 0, MF_BYPOSITION or MF_GRAYED
    .endif
    invoke SendMessage, hWin, WM_NCPAINT, 1, 0
ret
WebCamList endp
;*********************************************************************************************************************************************************
MicList proc
    mov i_str, 4200
    .if hmenu1!= 0
        invoke DestroyMenu, hmenu1
        mov hmenu1, 0
    .endif
    invoke CreatePopupMenu
    mov hmenu1, eax
    invoke ModifyMenu, hmenu, 4, MF_BYPOSITION or MF_ENABLED or MF_POPUP or MF_STRING, hmenu1, s(1025, temp_str, 1024)
    invoke GetDeviceName, GDN_MICROPHONE, addr update_menu_mic
    .if i_str== 4200
        invoke EnableMenuItem, hmenu, 4, MF_BYPOSITION or MF_GRAYED
    .endif
ret
MicList endp
;*********************************************************************************************************************************************************
update_menu_webcam proc WCNum:DWORD, WCName:DWORD, WCHash:DWORD, WCHWin:DWORD
    inc i_str
    invoke AppendMenu, h_hmenu2, MF_STRING, i_str, WCName
    .IF WCHWin!= 0
        invoke CheckMenuItem, h_hmenu2, i_str, MF_BYCOMMAND or MF_CHECKED
    .ENDIF
ret
update_menu_webcam endp
;*********************************************************************************************************************************************************
update_menu_mic proc MNum:DWORD, MName:DWORD
    inc i_str
    invoke AppendMenu, hmenu1, MF_STRING, i_str, MName
ret
update_menu_mic endp
;*********************************************************************************************************************************************************
VWProc proc hWnd:HWND, uMsg:UINT, wParam:WPARAM, lParam:LPARAM
.IF uMsg== WM_SIZE
    invoke GetWindowLong, hWnd, 0
    mov ecx, lParam
    movzx edx, cx
    shr ecx, 16
    invoke MoveWindow, eax, 0, 0, edx, ecx, 1
.ELSEIF uMsg== WM_MOUSEACTIVATE
    invoke SetWindowPos, hWnd, HWND_TOP, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE
.ELSEIF uMsg== WM_CLOSE
    invoke DestroyWindow, hWnd
    call WebCamList
.ELSE
    invoke DefWindowProc, hWnd, uMsg, wParam, lParam
    ret
.ENDIF
return 0
VWProc endp
;*********************************************************************************************************************************************************
vw_proc proc hWnd:HWND, uMsg:UINT, wParam:WPARAM, lParam:LPARAM
LOCAL buff:DWORD, hdc:DWORD, hdc1:DWORD, bmap:DWORD
.IF uMsg== WM_COMMAND
    mov eax, wParam
    ror eax, 16
    .IF ax== BN_CLICKED
        ror eax, 16
        .IF ax== 3001                               ;старт
            invoke GetVWData, focus_hwnd, 1
            mov esi, eax
            invoke GetVWData, focus_hwnd, 0
            mov ebx, eax
            invoke GetTime
            invoke StartVideo, focus_hwnd, ebx, esi, eax    ;SV_RECORDING_VIDEO or SV_RECORDING_AUDIO or SV_PREVIEW_VIDEO or SV_PREVIEW_AUDIO
            
        .ELSEIF ax== 3002                           ;стоп
            invoke StopVideo, focus_hwnd
            
        .ELSEIF ax== 3010                           ;пауза
            invoke PauseVideo, focus_hwnd
            
        .ELSEIF ax== 3004                           ;настройка камеры
            invoke dWebCam, focus_hwnd
            
        .ELSEIF ax== 3005                           ;фотография
            mov esi, 0
            mov edi, 0
            call ph_save
        .ELSEIF ax== 3008
            mov esi, 1
            mov edi, 50
            call ph_save
        .ELSEIF ax== 3016
            mov esi, 1
            mov edi, 85
            call ph_save
        .ELSEIF ax== 3017
            mov esi, 1
            mov edi, 100
            call ph_save
            
        .ELSEIF ax== 3006                           ;кадр выводится в окно
            invoke GetBuffer, focus_hwnd, addr bmpinf
            .IF eax!= 0
                mov buff, eax
                invoke CreateCompatibleDC, 0
                mov hdc1, eax
                invoke CreateDIBSection, hdc1, addr bmpinf, 0, 0, 0, 0
                mov bmap, eax
                invoke SelectObject, hdc1, bmap
                invoke GetDC, hWin
                mov hdc, eax
                invoke SetDIBits, hdc1, bmap, 0, bmpinf.biHeight, buff, addr bmpinf, 0
                invoke GetClientRect, hWin, addr rct
                invoke StretchBlt, hdc, 0, 0, rct.right, rct.bottom, hdc1, 0, 0, bmpinf.biWidth, bmpinf.biHeight, SRCCOPY
                invoke DeleteDC, hdc
                invoke DeleteDC, hdc1
                invoke DeleteObject, bmap
            .ENDIF
            
        .ELSEIF ax== 3007                           ;цвет фона
            invoke VWColorDialog, focus_hwnd
            
        .ELSEIF ax== 3013                           ;сохранить пропорцию\растянуть
            invoke GetVWInfo, focus_hwnd
            mov ebx, dword ptr[eax+16]
            shr ebx, 16
            .if bx== 1
                invoke VWRatio, focus_hwnd, 2
            .else
                invoke VWRatio, focus_hwnd, 1
                ;movzx ebx, ax
                ;shr eax, 16
                ;invoke SetWindowPos, focus_hwnd, HWND_TOP, 0, 0, ebx, eax, SWP_NOMOVE
            .endif
            
        .ELSEIF ax== 3014                           ;Запись видео
            mov esi, SV_RECORDING_VIDEO
            call sv_set_param

        .ELSEIF ax== 3012                           ;Запись звука
            mov esi, SV_RECORDING_AUDIO
            call sv_set_param
            
        .ELSEIF ax== 3015                           ;Воспроизводить звук
            mov esi, SV_PREVIEW_AUDIO
            call sv_set_param
            
        .ELSEIF ax== 3009                           ;во весь экран включить\отключить
            invoke GetVWInfo, focus_hwnd
            mov ebx, dword ptr[eax+24]
            .if ebx== 1
                invoke VWFullScreen, focus_hwnd, 2
            .else
                invoke VWFullScreen, focus_hwnd, 1
            .endif
            
        .ELSEIF ax== 3003                           ;закрыть
            invoke GetVWInfo, focus_hwnd
            mov ebx, dword ptr[eax+24]
            .if ebx== 1
                invoke VWFullScreen, focus_hwnd, 2
            .endif
            invoke GetParent, focus_hwnd
            invoke DestroyWindow, eax
            call WebCamList
            
        .ELSEIF ax== 3011                           ;формат
            invoke dFormat, focus_hwnd
            
        .ELSEIF ax>= 4200                           ;микрофон
            sub ax, 4200
            movzx ebx, ax
            invoke GetVWData, focus_hwnd, 0
            .if eax== ebx
                invoke SetVWData, focus_hwnd, 0, 0
            .else
                invoke SetVWData, focus_hwnd, 0, ebx
            .endif
        .ENDIF
    .ENDIF
    
.ELSEIF uMsg== WM_CONTEXTMENU
    invoke GetVWInfo, hWnd
    mov ebx, eax
    mov eax, dword ptr[ebx+16]
    shr eax, 16
    .if ax== 1
        invoke CheckMenuItem, hmenu, 3013, MF_BYCOMMAND or MF_CHECKED
    .else
        invoke CheckMenuItem, hmenu, 3013, MF_BYCOMMAND or MF_UNCHECKED
    .endif
    mov eax, dword ptr[ebx+24]
    .if eax== 1
        invoke CheckMenuItem, hmenu, 3009, MF_BYCOMMAND or MF_CHECKED
    .else
        invoke CheckMenuItem, hmenu, 3009, MF_BYCOMMAND or MF_UNCHECKED
    .endif
    
    call MicList
    invoke GetVWData, hWnd, 0
    .if eax!= 0
        dec eax
        invoke CheckMenuItem, hmenu1, eax, MF_BYPOSITION or MF_CHECKED
    .endif
    
    invoke GetVWData, hWnd, 1
    mov ebx, eax
    mov esi, SV_RECORDING_VIDEO
    mov edi, 3014
    call sv_check_param
    mov esi, SV_RECORDING_AUDIO
    mov edi, 3012
    call sv_check_param
    mov esi, SV_PREVIEW_AUDIO
    mov edi, 3015
    call sv_check_param
    ;-------
    invoke GetVWInfo, hWnd
    mov ebx, dword ptr[eax]
    .if ebx== 1  ;1-Stop\2-Start\3-Pause
        invoke EnableMenuItem, hmenu, 3006, MF_BYCOMMAND or MF_GRAYED or MF_DISABLED
        invoke EnableMenuItem, hmenu, 10, MF_BYPOSITION or MF_GRAYED or MF_DISABLED
    .else
        invoke EnableMenuItem, hmenu, 3006, MF_BYCOMMAND or MF_ENABLED
        invoke EnableMenuItem, hmenu, 10, MF_BYPOSITION or MF_ENABLED
    .endif
    .if ebx== 2 || ebx== 3
        invoke EnableMenuItem, hmenu, 3011, MF_BYCOMMAND or MF_GRAYED or MF_DISABLED
        invoke EnableMenuItem, hmenu, 3012, MF_BYCOMMAND or MF_GRAYED or MF_DISABLED
        invoke EnableMenuItem, hmenu, 3014, MF_BYCOMMAND or MF_GRAYED or MF_DISABLED
        invoke EnableMenuItem, hmenu, 3015, MF_BYCOMMAND or MF_GRAYED or MF_DISABLED
        invoke EnableMenuItem, hmenu, 4, MF_BYPOSITION or MF_GRAYED or MF_DISABLED
    .else
        invoke EnableMenuItem, hmenu, 3011, MF_BYCOMMAND or MF_ENABLED
        invoke EnableMenuItem, hmenu, 3012, MF_BYCOMMAND or MF_ENABLED
        invoke EnableMenuItem, hmenu, 3014, MF_BYCOMMAND or MF_ENABLED
        invoke EnableMenuItem, hmenu, 3015, MF_BYCOMMAND or MF_ENABLED
        invoke EnableMenuItem, hmenu, 4, MF_BYPOSITION or MF_ENABLED
    .endif
    
    mrm focus_hwnd, hWnd
    invoke GetCursorPos, addr poin
    invoke TrackPopupMenu, hmenu, 0, poin.x, poin.y, 0, focus_hwnd, 0
    
.ELSEIF uMsg== VWM_GRAPHNOTIFY
    .if wParam== EC_DEVICE_LOST
        mov ebx, lParam
        mov eax, dword ptr[ebx+4]
        .if eax== 0     ;lost
            invoke GetWindowText, hWnd, addr buffer, 2048
            invoke MessageBox, hWnd, s(1023, temp_str, 1024), addr buffer, MB_OK
        .elseif eax== 1 ;connected
            invoke GetWindowText, hWnd, addr buffer, 2048
            invoke MessageBox, hWnd, s(1024, temp_str, 1024), addr buffer, MB_OK
        .endif
    .elseif wParam== EC_ERRORABORT || wParam== EC_ERRORABORTEX  ;error
        invoke GetWindowText, hWnd, addr buffer, 2048
        invoke MessageBox, hWnd, s(1022, temp_str, 1024), addr buffer, MB_OK
    .elseif wParam== EC_GRAPH_CHANGED
        ;invoke Beep, 555, 555
    .endif
    
.ELSEIF uMsg== WM_LBUTTONDBLCLK
    invoke GetVWInfo, hWnd
    mov ebx, dword ptr[eax+24]
    .if ebx== 2
        invoke VWFullScreen, hWnd, 1
    .elseif ebx== 1
        invoke VWFullScreen, hWnd, 2
    .endif
    
.ELSEIF uMsg== WM_MBUTTONUP
    invoke GetVWInfo, hWnd
    mov ebx, dword ptr[eax+16]
    shr ebx, 16
    .if ebx== 2
        invoke VWRatio, hWnd, 1
    .elseif ebx== 1
        invoke VWRatio, hWnd, 2
    .endif
.ELSE
    invoke DefWindowProc, hWnd, uMsg, wParam, lParam
    ret
.ENDIF
return 0
vw_proc endp
;*********************************************************************************************************************************************************
sv_set_param proc
    invoke GetVWData, focus_hwnd, 1
    test eax, esi
    jz @F
        xor eax, esi
        invoke SetVWData, focus_hwnd, 1, eax
        ret
@@:
    or eax, esi
    invoke SetVWData, focus_hwnd, 1, eax
ret
sv_set_param endp
;*********************************************************************************************************************************************************
sv_check_param proc
    test ebx, esi
    jz @F
        invoke CheckMenuItem, hmenu, edi, MF_BYCOMMAND or MF_CHECKED
        ret
    @@:
        invoke CheckMenuItem, hmenu, edi, MF_BYCOMMAND or MF_UNCHECKED
ret
sv_check_param endp
;*********************************************************************************************************************************************************
ph_save proc
    invoke GetTime
    invoke PhotoSave, focus_hwnd, eax, esi, edi
    .IF eax> 0 && eax< -2
        mov seci.cbSize, sizeof SHELLEXECUTEINFO
        mov seci.lpFile, eax
        mov seci.fMask, SEE_MASK_NOCLOSEPROCESS
        mov seci.nShow, SW_SHOWNORMAL
        invoke GetVWInfo, focus_hwnd
        mov ebx, dword ptr[eax+24]
        .if ebx== 1
            invoke VWFullScreen, focus_hwnd, 2
        .endif
        invoke ShellExecuteEx, addr seci
    .ENDIF
ret
ph_save endp
;*********************************************************************************************************************************************************
about_box proc uses ebx h_instance:DWORD, hParent:DWORD, msgtxt:DWORD, caption:DWORD, mbstyle:DWORD, iconID:DWORD
LOCAL mbp:MSGBOXPARAMS
    or mbstyle, MB_USERICON
    mov mbp.cbSize, sizeof mbp
    mrm mbp.hwndOwner, hParent
    mrm mbp.hInstance, h_instance
    mrm mbp.lpszText, msgtxt
    mrm mbp.lpszCaption, caption
    mrm mbp.dwStyle, mbstyle
    mrm mbp.lpszIcon, iconID
    mov mbp.dwContextHelpId, 0
    mov mbp.lpfnMsgBoxCallback, 0
    mov mbp.dwLanguageId, 0
    invoke MessageBoxIndirect, addr mbp
ret
about_box endp
;*********************************************************************************************************************************************************
end start

