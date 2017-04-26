; Author:            7ya
; Update date:       26.04.2017
; Contact:           7ya@protonmail.com
; Internet address:  https://github.com/7ya/win_asm_webcam32.dll
; License:           GPL-3.0
;------------------------------------------------------------------------------
__UNICODE__ equ 1
include \masm32\include\masm32rt.inc

include \masm32\include\cryptdll.inc
include \masm32\include\gdiplus.inc
include \masm32\include\msdmo.inc

includelib \masm32\lib\cryptdll.lib
includelib \masm32\lib\gdiplus.lib
includelib \masm32\lib\msdmo.lib

CreateVideoWindow   proto :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
GetWebCamName       proto :DWORD, :DWORD, :DWORD, :DWORD
PhotoSave           proto :DWORD, :DWORD, :DWORD, :DWORD
SetVWData           proto :DWORD, :DWORD, :DWORD
GetVWData           proto :DWORD, :DWORD
GetMicrophoneName   proto :DWORD, :DWORD
SetVWColor          proto :DWORD, :DWORD
GetBuffer           proto :DWORD, :DWORD
VWRatio             proto :DWORD, :DWORD
VWFullScreen        proto :DWORD, :DWORD
GetDeviceName       proto :DWORD, :DWORD
GetVWInfo           proto :DWORD
VWColorDialog       proto :DWORD
dFormat             proto :DWORD
dWebCam             proto :DWORD
PauseVideo          proto :DWORD
StartVideo          proto :DWORD, :DWORD, :DWORD, :DWORD
StopVideo           proto :DWORD
GetTime             proto

loc_cmp             proto :DWORD, :DWORD
img_conv            proto :DWORD, :DWORD, :DWORD
dd_push             proto :DWORD, :DWORD
cmp_md5             proto :DWORD, :DWORD
get_folder          proto :DWORD, :DWORD
loc_cmp_zero        proto :DWORD
dd_cmp              proto :DWORD
dd_del              proto :DWORD
RatioFPU            proto :DWORD
steep1              proto :DWORD, :DWORD
set_grabber         proto :DWORD, :DWORD, :DWORD, :DWORD, :DWORD
set_format          proto :DWORD
release_graph       proto :DWORD

.const
    VWM_GRAPHNOTIFY         equ     WM_USER + 160
    GDN_WEBCAM              equ     0h
    GDN_MICROPHONE          equ     01h
    SV_PREVIEW_VIDEO        equ     0h
    SV_PREVIEW_AUDIO        equ     01h
    SV_RECORDING_VIDEO      equ     02h
    SV_RECORDING_AUDIO      equ     04h

.data
    include directshow.inc
    align word
    EncQuality      GUID <01d5be4b5h,0fa4ah,0452dh,<09ch,0ddh,05dh,0b3h,051h,05h,0e7h,0ebh>>
    ClassEnum       dd 0
    DevEnum         dd 0
    ClassEnumM      dd 0
    DevEnumM        dd 0
    num             dd 0
    maxdev          dd 0
    maxdevM         dd 0
    f_FullScreen    dd 2
    dd_stek         dd 0

.data?
    hInstance       dd ?
    threadID        dd ?
    
    AM_MEDIA_TYPE STRUCT
        majortype               GUID <>
        subtype                 GUID <>
        bFixedSizeSamples       dd ?
        bTemporalCompression    dd ?
        lSampleSize             dd ?
        formattype              GUID <>
        pUnk                    dd ?
        cbFormat                dd ?
        pbFormat                dd ?
    AM_MEDIA_TYPE ENDS

    WMVIDEOINFOHEADER STRUCT
        rcSource                RECT <>
        rcTarget                RECT <>
        dwBitRate               dd ?
        dwBitErrorRate          dd ?
        AvgTimePerFrame         dd ?
        bmiHeader               BITMAPINFOHEADER <>
    WMVIDEOINFOHEADER ENDS

    CAUUID STRUCT
        cElems dd ?
        pElems dd ?
    CAUUID ENDS
    cauuid CAUUID <>

    VWNOTIFY STRUCT
        lParam1S     dd ?
        lParam2S     dd ?
    VWNOTIFY ENDS
    vwn VWNOTIFY <>

    VARIANT STRUCT
        vt          dw ?
        wReserved1  dw ?
        wReserved2  dw ?
        wReserved3  dw ?
        parray      dd ?
        xyz         dd ?
    VARIANT ENDS
    vt VARIANT <>

    MD5_CTX STRUCT
        i      db 8  dup(0)
        buf    db 16 dup(0)
        inn    db 64 dup(0)
        digest db 16 dup(0)
    MD5_CTX ENDS

    GdiplusStartupOutput STRUCT
        NotificationHook        dd ?
        NotificationUnhook      dd ?
    GdiplusStartupOutput ENDS

    GdiplusStartupInput STRUCT
        GdiplusVersion              DWORD ?
        DebugEventCallback          DWORD ?
        SuppressBackgroundThread    DWORD ?
        SuppressExternalCodecs      DWORD ?
    GdiplusStartupInput ENDS
    gditoken dd ?

    EncParameters STRUC
        Count             DWORD ?
        pGUID             GUID  <>
        NumberOfValues    DWORD ?
        vType             DWORD ?
        value             DWORD ?
    EncParameters ENDS

    rct_2 RECT <>

    VWInfoBuffer    db      1024 dup (?)
    TimeBuffer      TCHAR   1024 dup (?)
    wcBuffer        TCHAR   2048 dup (?)

.code
;**********************************************************************************************************************************************************
CreateVideoWindow proc uses ebx esi edi ebp WebCamNum:DWORD, wvBackground:DWORD, wvStyle:DWORD, wvStyleEx:DWORD, wvx:DWORD, wvy:DWORD, wvw:DWORD, wvh:DWORD, hParent:DWORD, flag_mod:DWORD, User_Proc:DWORD, hInst:DWORD
LOCAL hVWindow:DWORD, wvhWin:DWORD, wc:WNDCLASSEX, md5d[16]:BYTE
LOCAL buffer[1024]:TCHAR, buffer1[1024]:TCHAR
    .if dd_stek== 0
        invoke LocalAlloc, 040h, 6144
        mov dd_stek, eax
    .endif

    invoke GetWebCamName, WebCamNum, addr buffer1, addr md5d, addr wvhWin
    .if eax== 0 || eax== 1
        return 0 ;камера не найдена
    .elseif eax== -1
        .if wvhWin!= 0h
            return 0 ;камера уже задействована в текущем приложении
        .endif
    .endif
    inc num
    invoke lstrcpy, addr buffer, uc$("video_window_class_")
    invoke lstrcat, addr buffer, ustr$(num)
    mrm wc.hInstance, hInst
    invoke CreateSolidBrush, wvBackground
    mrm wc.hbrBackground, eax
    mov wc.hIcon, 0
    mov wc.hIconSm, 0
    mov wc.style, CS_HREDRAW or CS_VREDRAW or CS_DBLCLKS ; or CS_NOCLOSE
    mov wc.cbSize, sizeof WNDCLASSEX
    mov wc.lpfnWndProc, OFFSET VideoWindowProc
    mov wc.cbClsExtra, 0
    mov wc.cbWndExtra, 160
    invoke LoadCursor, 0, IDC_ARROW
    mov wc.hCursor, eax
    mov wc.lpszMenuName, 0
    lea eax, buffer
    mov wc.lpszClassName, eax 
    invoke RegisterClassEx, addr wc
    or wvStyle, WS_CLIPSIBLINGS or WS_CLIPCHILDREN
    mov eax, flag_mod
    .if ax== 1 ;без просмотра
        mov wvx, -11
        mov wvy, -11
        mov wvw, 0
        mov wvh, 0
    .endif
    invoke CreateWindowEx, wvStyleEx, addr buffer, addr buffer1, wvStyle, wvx, wvy, wvw, wvh, hParent, 0, wc.hInstance, 0
    mov hVWindow, eax
    invoke SetWindowLong, hVWindow, 0,  WebCamNum            ;номер камеры
                                            ;nulleg
    invoke SetWindowLong, hVWindow, 8,  0
    invoke SetWindowLong, hVWindow, 24, 0   ;Src
    invoke SetWindowLong, hVWindow, 28, 0
    invoke SetWindowLong, hVWindow, 12, 0
    invoke SetWindowLong, hVWindow, 16, 0   ;Graph
    invoke SetWindowLong, hVWindow, 20, 0   ;Builder
    invoke SetWindowLong, hVWindow, 32, 0
    invoke SetWindowLong, hVWindow, 44, 0   ;MedVed
    invoke SetWindowLong, hVWindow, 48, 1                    ;1- стоп, 2- старт, 3- пауза
    invoke SetWindowLong, hVWindow, 52, hParent
    invoke LocalAlloc, 040h, 1024
    lea esi, md5d
    mov edi, eax
    mov ecx, 4
    rep movsd
    invoke SetWindowLong, hVWindow, 56, eax 
    invoke SetWindowLong, hVWindow, 60, wvStyle ;Стиль
    invoke SetWindowLong, hVWindow, 64, hInst
    invoke SetWindowLong, hVWindow, 68, 0 ;свободно
    mov ebx, wvBackground
    or ebx, 0ff000000h
    invoke SetWindowLong, hVWindow, 72, ebx
    invoke SetWindowLong, hVWindow, 40, flag_mod ;режим и другие флаги
    invoke SetWindowLong, hVWindow, 76, User_Proc
    invoke SetWindowLong, hVWindow, 80, 2   ;полноэкранный режим 1- включен, 2- выключен
    invoke SetWindowLong, hVWindow, 84, wvw ;ширина
    invoke SetWindowLong, hVWindow, 88, wvh ;высота
    invoke SetWindowLong, hVWindow, 92, wvx ;x
    invoke SetWindowLong, hVWindow, 96, wvy ;y
    invoke LocalAlloc, 040h, 10000
    invoke SetWindowLong, hVWindow, 100, eax ;buffer_am_type
    invoke SetWindowLong, hVWindow, 104, 0   ;buffer_am_type_f 0-пусто 1-формат загружен
    invoke SetWindowLong, hVWindow, 108, 0   ;размер буфера под фото
    invoke SetWindowLong, hVWindow, 112, 0   ;указатель на буфер для фото
    invoke SetWindowLong, hVWindow, 116, 0   ;размер буфера под кадр
    invoke SetWindowLong, hVWindow, 120, 0   ;указатель на буфер для кадра
    invoke SetWindowLong, hVWindow, 124, 0   ;Src_Audio
    invoke SetWindowLong, hVWindow, 128, 0   ;pFi
    invoke SetWindowLong, hVWindow, 132, 0   ;pSi
    invoke LocalAlloc, 040h, 100
    invoke SetWindowLong, hVWindow, 136, eax ;crv
    invoke SetWindowLong, hVWindow, 140, 0 ;crv_steper
    invoke LocalAlloc, 040h, 1048576
    invoke SetWindowLong, hVWindow, 144, eax ;user_data
    mrm hInstance, wc.hInstance

    invoke dd_push, addr md5d, hVWindow
    invoke steep1, hVWindow, 0
    .if eax== 0
        invoke DestroyWindow, hVWindow
        return 1    ;к выбранной камере подключиться не удалось.
    .endif
    mov eax, flag_mod
    .if ax== 1 ;без просмотра
        invoke ShowWindow, hVWindow, SW_HIDE
    .endif
return hVWindow
CreateVideoWindow endp
;**********************************************************************************************************************************************************
VideoWindowProc proc hWin:DWORD, uMsg:DWORD, wParam:DWORD, lParam:DWORD
LOCAL loc_1:DWORD, loc_2:DWORD, lEventCode:DWORD, lParam1:DWORD, lParam2:DWORD, flag_mod:DWORD
LOCAL buffer[1024]:TCHAR, rec:RECT
.IF uMsg== WM_SIZE
    invoke GetWindowLong, hWin, 40
    cmp eax, 0
    je end_event_m
    cmp ax, 1
    je end_event_m
    
    mov ecx, lParam
    movzx edx, cx
    mov rec.right, edx
    shr ecx, 16
    mov rec.bottom, ecx
    
    shr eax, 16
    .IF eax== 1     ;сохранять пропорцию
        invoke GetWindowLong, hWin, 36  ;ширина и высота видеокадра в пикселях
        movzx edx, ax
        mov rec.left, edx
        shr eax, 16
        mov rec.top, eax
        invoke RatioFPU, addr rec
    .ELSEIF eax== 2 ;растянуть
        mov rec.left, 0
        mov rec.top, 0
    .ELSE
        jmp end_event_m
    .ENDIF
    invoke GetWindowLong, hWin, 12
    cmp eax, 0
    je end_event_m
    mov ebx,[eax]
    invoke (IVideoWindow PTR [ebx]).SetWindowPosition, eax, rec.left, rec.top, rec.right, rec.bottom
.ELSEIF uMsg== WM_STYLECHANGED
    return 0
.ELSEIF uMsg== WM_WINDOWPOSCHANGING
    invoke GetWindowLong, hWin, 40 ;режим и другие флаги
    cmp eax, 0
    je end_event_m
    mov flag_mod, eax
    invoke GetWindowLong, hWin, 80 ;полноэкранный режим
    mov ebx, flag_mod
    .IF eax== 1 || bx== 1     ;включен полноэкранный режим или включен режим без просмотра
        mov ebx, lParam
        mov eax, SWP_NOMOVE
        or eax, SWP_NOSIZE
        mov dword ptr[ebx+24], eax
        return 0
    .ENDIF
.ELSEIF uMsg== WM_DISPLAYCHANGE
    invoke GetWindowLong, hWin, 80 ;полноэкранный режим
    cmp eax, 0
    je end_event_m
    .if eax== 1     ;включен
        invoke GetWindowLong, hWin, 48 ;1- стоп, 2- старт, 3- пауза
        .if eax== 3
            invoke StopVideo, hWin
        .endif
        invoke SetWindowLong, hWin, 80, 7 ;снять защиту от изменения размера
        mov eax, lParam
        movzx ebx, ax
        shr eax, 16
        invoke SetWindowPos, hWin, HWND_TOP, 0, 0, ebx, eax, SWP_SHOWWINDOW
        invoke SetWindowLong, hWin, 80, 1 ;установить защиту от изменения размера
    .endif
.ELSEIF uMsg== WM_ACTIVATEAPP
    mov eax, wParam
    .if ax== 0
        invoke GetWindowLong, hWin, 80 ;полноэкранный режим
        cmp eax, 0
        je end_event_m
        .if eax== 1     ;включен
            invoke VWFullScreen, hWin, 2    ;выключить
            return 0
        .endif
    .endif
.ELSEIF uMsg== WM_DESTROY
    mov f_FullScreen, 0
    invoke release_graph, hWin
    invoke GetWindowLong, hWin, 136     ;crv
    invoke LocalFree, eax
    invoke GetWindowLong, hWin, 144     ;user_data
    invoke LocalFree, eax
    invoke GetWindowLong, hWin, 100     ;buffer_am_type
    invoke LocalFree, eax
    invoke GetWindowLong, hWin, 112     ;указатель на буфер для фото
    .if eax!= 0h
        invoke LocalFree, eax
    .endif
    invoke GetWindowLong, hWin, 120     ;указатель на буфер для кадра
    .if eax!= 0h
        invoke LocalFree, eax
    .endif
    invoke GetWindowLong, hWin, 56      ;hash
    mov loc_1, eax
    .if loc_1!= 0
        invoke dd_del, loc_1
        invoke LocalFree, loc_1
        invoke SetWindowLong, hWin, 56, 0
    .endif
.ELSEIF uMsg== WM_MOUSEACTIVATE
    invoke SetWindowPos, hWin, HWND_TOP, 0, 0, 0, 0, SWP_NOMOVE or SWP_NOSIZE
.ELSEIF uMsg== VWM_GRAPHNOTIFY
    invoke GetWindowLong, hWin, 44
    cmp eax, 0
    je end_event_m
    mov loc_1, eax
    event_m:
    mov eax, loc_1
    mov ebx,[eax]
    invoke (IMediaEvent PTR [ebx]).GetEvent, loc_1, addr lEventCode, addr lParam1, addr lParam2, 999 ;миллисекунд
    .IF eax== E_ABORT
        return 0
    .ENDIF
    .IF lEventCode== EC_DEVICE_LOST
        .IF lParam2== 0h        ;lost
        .ELSEIF lParam2== 01h   ;connected
            invoke StopVideo, hWin
        .ENDIF
    .ELSEIF lEventCode== EC_VIDEO_SIZE_CHANGED
        invoke SetWindowLong, hWin, 36, lParam1
    .ELSEIF lEventCode== EC_PAUSED
    .ELSEIF lEventCode== EC_ERRORABORT || lEventCode== EC_ERRORABORTEX
    .ENDIF
    invoke GetWindowLong, hWin, 76
    mov loc_2, eax
    .IF loc_2!= 0h
        mrm vwn.lParam1S, lParam1
        mrm vwn.lParam2S, lParam2
        lea ebx, vwn
        push ebx
        push lEventCode
        push VWM_GRAPHNOTIFY
        push hWin
        call loc_2
    .ENDIF
    mov eax, loc_1
    mov ebx,[eax]
    invoke (IMediaEvent PTR [ebx]).FreeEventParams, loc_1, addr lEventCode, addr lParam1, addr lParam2
    jmp event_m
.ENDIF
invoke GetWindowLong, hWin, 76
.IF eax!= 0h
    push lParam
    push wParam
    push uMsg
    push hWin
    call eax
    ret
.ENDIF
end_event_m:
invoke DefWindowProc, hWin, uMsg, wParam, lParam
ret
VideoWindowProc endp
;**********************************************************************************************************************************************************
dWebCam proc uses ebx esi edi ebp hWin:DWORD
LOCAL spec:DWORD, Src:DWORD
LOCAL buffer[1024]:TCHAR
    invoke GetWindowLong, hWin, 24
    .IF eax== 0
        return -2
    .ENDIF
    mov Src, eax
    mov ebx, [eax]
    invoke (IAMVideoProcAmp PTR [ebx]).QueryInterface, Src, addr IID_ISpecifyPropertyPages, addr spec
    mov eax, spec
    mov ebx, [eax]
    invoke (ISpecifyPropertyPages PTR [ebx]).GetPages, spec, addr cauuid
    invoke (ISpecifyPropertyPages PTR [ebx]).Release, spec
    invoke GetWindowText, hWin, addr buffer, 1024
    invoke OleCreatePropertyFrame, hWin, 0, 0, addr buffer, 1, addr Src, cauuid.cElems, cauuid.pElems, 0, 0, 0
    cmp eax, S_OK
    jne endDlgWebCam
    invoke CoTaskMemFree, cauuid.pElems 
    return 1
endDlgWebCam:
return 0
dWebCam endp
;**********************************************************************************************************************************************************
PhotoSave proc uses ebx esi edi ebp hWin:DWORD, fName:DWORD, fForm:DWORD, jpeg_quality:DWORD
LOCAL Grabber:DWORD, sizInfStr:DWORD, sizImg:DWORD, hend:DWORD, rzv:DWORD, size_buf:DWORD, sample_buf:DWORD
LOCAL bmpfinf:BITMAPFILEHEADER, bmpinfh:BITMAPINFOHEADER, amt:AM_MEDIA_TYPE
    invoke GetWindowLong, hWin, 48  ;1-Stop\2-Start
    .IF eax== 0
        return -2
    .ELSEIF eax== 1
        return 0
    .ENDIF
    invoke GetWindowLong, hWin, 32
    mov Grabber, eax
    mov ebx, [eax]
    invoke (ISampleGrabber PTR [ebx]).GetConnectedMediaType, Grabber, addr amt
    .IF eax!= 0
        return 0
    .ENDIF
    mov esi, amt.pbFormat
    add esi, 48
    lea edi, bmpinfh
    mov ecx, 10
    rep movsd
    invoke CoTaskMemFree, amt.pbFormat
    mov eax, Grabber
    mov ebx, [eax]
    invoke (ISampleGrabber PTR [ebx]).GetCurrentBuffer, Grabber, addr size_buf, 0
    .IF eax!= 0
        return 0
    .ENDIF
;----------------------------------------------
    invoke GetWindowLong, hWin, 112
    mov sample_buf, eax
    invoke GetWindowLong, hWin, 108
    .if size_buf> eax
        .if sample_buf!= 0h
            invoke LocalFree, sample_buf
        .endif
        invoke LocalAlloc, 040h, size_buf
        .if eax== 0h
            ret ;ERROR
        .endif
        mov sample_buf, eax
        invoke SetWindowLong, hWin, 112, sample_buf
        invoke SetWindowLong, hWin, 108, size_buf
    .endif
;----------------------------------------------
    mov eax, Grabber
    mov ebx, [eax]
    invoke (ISampleGrabber PTR [ebx]).GetCurrentBuffer, Grabber, addr size_buf, sample_buf
    .IF eax!= 0
        return 0
    .ENDIF
    invoke lstrcpy, addr wcBuffer, fName
    invoke CreateFile, addr wcBuffer, GENERIC_WRITE, FILE_SHARE_WRITE, 0, CREATE_ALWAYS, FILE_ATTRIBUTE_HIDDEN, 0
    .IF eax== INVALID_HANDLE_VALUE
        return 0
    .ENDIF
    mov hend, eax
;----------------------------------------------
    mov sizInfStr, sizeof BITMAPINFOHEADER
    add sizInfStr, sizeof BITMAPFILEHEADER
    invoke IntMul, bmpinfh.biWidth, bmpinfh.biHeight
    invoke IntMul, eax, 3
    mov sizImg, eax
;-------
    mov bmpfinf.bfType, 04d42h
    mov eax, sizImg
    add eax, sizInfStr
    mov bmpfinf.bfSize, eax
    mov bmpfinf.bfReserved1, 0
    mov bmpfinf.bfReserved2, 0
    mrm bmpfinf.bfOffBits, sizInfStr
;----------------------------------------------
    invoke WriteFile, hend, addr bmpfinf, sizeof BITMAPFILEHEADER, addr rzv, 0
    invoke WriteFile, hend, addr bmpinfh, sizeof BITMAPINFOHEADER, addr rzv, 0
    invoke WriteFile, hend, sample_buf, size_buf, addr rzv, 0
    invoke CloseHandle, hend
    invoke img_conv, addr wcBuffer, fForm, jpeg_quality
ret
PhotoSave endp
;**********************************************************************************************************************************************************
GetBuffer proc uses ebx esi edi ebp hWin:DWORD, bufStruct:DWORD
LOCAL Grabber:DWORD, size_buf:DWORD, sample_buf:DWORD
LOCAL amt:AM_MEDIA_TYPE
    invoke GetWindowLong, hWin, 48  ;1-Stop\2-Start
    .IF eax== 0
        return -2
    .ELSEIF eax== 1
        return 0
    .ENDIF
    invoke GetWindowLong, hWin, 32
    mov Grabber, eax
    mov ebx, [eax]
    invoke (ISampleGrabber PTR [ebx]).GetConnectedMediaType, Grabber, addr amt
    .IF eax!= 0
        return 0
    .ENDIF
    mov esi, amt.pbFormat
    add esi, 48
    mov edi, bufStruct
    mov ecx, 10
    rep movsd
    invoke CoTaskMemFree, amt.pbFormat
    mov eax, Grabber
    mov ebx, [eax]
    invoke (ISampleGrabber PTR [ebx]).GetCurrentBuffer, Grabber, addr size_buf, 0
    .IF eax!= 0
        return 0
    .ENDIF
;----------------------------------------------
    invoke GetWindowLong, hWin, 120
    mov sample_buf, eax
    invoke GetWindowLong, hWin, 116
    .if size_buf> eax
        .if sample_buf!= 0h
            invoke LocalFree, sample_buf
        .endif
        invoke LocalAlloc, 040h, size_buf
        .if eax== 0h
            ret ;ERROR
        .endif
        mov sample_buf, eax
        invoke SetWindowLong, hWin, 120, sample_buf
        invoke SetWindowLong, hWin, 116, size_buf
    .endif
;----------------------------------------------
    invoke (ISampleGrabber PTR [ebx]).GetCurrentBuffer, Grabber, addr size_buf, sample_buf
    .IF eax!= 0
        return 0
    .ENDIF
return sample_buf
GetBuffer endp
;**********************************************************************************************************************************************************
GetVWInfo proc uses ebx esi edi ebp hWin:DWORD
    invoke GetWindowLong, hWin, 48 ;1- стоп, 2- старт
    .if eax== 0
        return -2
    .endif
    lea ebx, VWInfoBuffer
    mov dword ptr[ebx], eax
    invoke GetWindowLong, hWin, 0 ;WebCamNum
    lea ebx, VWInfoBuffer
    mov dword ptr[ebx+4], eax
    invoke GetWindowLong, hWin, 72 ;RGB
    xor eax, 0ff000000h
    lea ebx, VWInfoBuffer
    mov dword ptr[ebx+8], eax
    invoke GetWindowLong, hWin, 36 ;x\y
    lea ebx, VWInfoBuffer
    mov dword ptr[ebx+12], eax
    invoke GetWindowLong, hWin, 40 ;режим
    lea ebx, VWInfoBuffer
    mov dword ptr[ebx+16], eax
    invoke GetWindowLong, hWin, 76 ;User_Proc
    lea ebx, VWInfoBuffer
    mov dword ptr[ebx+20], eax
    invoke GetWindowLong, hWin, 80 ;полноэкранный режим 1-включен,2-выключен
    lea ebx, VWInfoBuffer
    mov dword ptr[ebx+24], eax
return ebx
GetVWInfo endp
;**********************************************************************************************************************************************************
loc_cmp proc uses ebx ecx edx esi arg1:DWORD, arg2:DWORD
    mov ebx, arg1
    mov esi, arg2
    mov ecx, 4
loc_cmp_m:
    mov eax, dword ptr[ebx]
    mov edx, dword ptr[esi]
    cmp eax, edx
    jne loc_cmp_m1
    add ebx, 4
    add esi, 4
loop loc_cmp_m
    return 1  ;равно
loc_cmp_m1:
    return 0  ;неравно
loc_cmp endp
;**********************************************************************************************************************************************************
loc_cmp_zero proc uses ebx ecx edx arg1:DWORD
    mov ebx, arg1
    mov ecx, 4
loc_cmp_zero_m:
    mov eax, dword ptr[ebx]
    cmp eax, 0
    jne loc_cmp_zero_m1
    add ebx, 4
loop loc_cmp_zero_m
    return 1  ;равно нулю
loc_cmp_zero_m1:
return 0      ;неравно нулю
loc_cmp_zero endp
;**********************************************************************************************************************************************************
dd_push proc uses ebx ecx edx dd_data:DWORD, hWin:DWORD
    cmp dd_stek, 0
    jne @F
    return 0 ;ERROR
@@:
    mov ebx, dd_stek
    mov ecx, ebx
    add ecx, 5100
push_m2:
    invoke loc_cmp_zero, ebx
    cmp eax, 0
    je push_m1
    mov ecx, hWin
    mov dword ptr[ebx+16], ecx
    mov esi, dd_data
    mov edi, ebx
    mov ecx, 4
    rep movsd
return 1 ;OK
push_m1:
    add ebx, 20
    cmp ebx, ecx
    jne push_m2
return 0 ;ERROR
dd_push endp
;**********************************************************************************************************************************************************
dd_cmp proc uses ebx ecx edx dd_data:DWORD
    cmp dd_stek, 0
    jne @F
    return 0 ;ERROR
@@:
    mov ebx, dd_stek
    mov ecx, ebx
    add ecx, 5100
    mov edx, dd_data
cmp_m2:
    invoke loc_cmp, ebx, edx
    cmp eax, 1
    je cmp_m1
    add ebx, 20
    cmp ebx, ecx
    jne cmp_m2
return 0 ;ERROR
cmp_m1:
mov eax, dword ptr[ebx+16]
ret ;OK
dd_cmp endp
;**********************************************************************************************************************************************************
dd_del proc uses ebx ecx edx dd_data:DWORD
    cmp dd_stek, 0
    jne @F
    return 0 ;ERROR
@@:
    mov ebx, dd_stek
    mov ecx, ebx
    add ecx, 5100
    mov edx, dd_data
del_m2:
    invoke loc_cmp, ebx, edx
    cmp eax, 1
    je del_m1
    add ebx, 20
    cmp ebx, ecx
    jne del_m2
return 0 ;ERROR
del_m1:
    mov dword ptr[ebx], 0h
    mov dword ptr[ebx+4], 0h
    mov dword ptr[ebx+8], 0h
    mov dword ptr[ebx+12], 0h
    mov dword ptr[ebx+16], 0h
return 1 ;OK
dd_del endp
;**********************************************************************************************************************************************************
SetVWColor proc uses ebx esi edi ebp hWin:DWORD, rgb_dat:DWORD
    invoke GetWindowLong, hWin, 40
    .IF ax== 1 || eax== 0
        return -2
    .ENDIF
    invoke CreateSolidBrush, rgb_dat
    invoke SetClassLong, hWin, GCL_HBRBACKGROUND, eax
    invoke InvalidateRect, hWin, 0, 1
    mov ebx, rgb_dat
    or ebx, 0ff000000h
    invoke SetWindowLong, hWin, 72, ebx
return 1
SetVWColor endp
;**********************************************************************************************************************************************************
VWColorDialog proc uses ebx esi edi ebp hWin:DWORD
LOCAL ccl:CHOOSECOLOR, loc_rgb:DWORD, crv:DWORD, crv_steper:DWORD
    invoke GetWindowLong, hWin, 40
    .IF ax== 1 || eax== 0
        return -2
    .ENDIF
    invoke GetWindowLong, hWin, 72 ;RGB
    xor eax, 0ff000000h
    mov loc_rgb, eax
    mov ccl.rgbResult, eax
    mov ccl.lStructSize, sizeof CHOOSECOLOR
    mrm ccl.hwndOwner, hWin
    invoke GetWindowLong, hWin, GWL_HINSTANCE
    mov ccl.hInstance, eax
    invoke GetWindowLong, hWin, 136
    mov crv, eax
    mov ccl.lpCustColors, eax
    mov ccl.Flags, CC_RGBINIT
    or ccl.Flags, CC_FULLOPEN
    mov ccl.lCustData, 0
    mov ccl.lpfnHook, 0
    mov ccl.lpTemplateName, 0
    invoke ChooseColor, addr ccl
    mov ebx, ccl.rgbResult
    .if eax!= 0 && ebx!= loc_rgb
        invoke GetWindowLong, hWin, 140
        mov crv_steper, eax
        .if crv_steper== 64
            mov crv_steper, 0
        .endif
        mov ebx, crv
        mov ecx, crv_steper
        mov eax, ccl.rgbResult
        mov dword ptr[ebx+ecx], eax
        add crv_steper, 4
        invoke SetWindowLong, hWin, 140, crv_steper
    .endif
invoke SetVWColor, hWin, ccl.rgbResult
return ccl.rgbResult
VWColorDialog endp
;**********************************************************************************************************************************************************
img_conv proc uses ebx esi edi ebp img_name:DWORD, img_type:DWORD, quality:DWORD
LOCAL t_buf:DWORD, mime_type:DWORD, hImage:DWORD, encnum:DWORD, encsize:DWORD, encinfo:DWORD, qqq:DWORD
LOCAL gdisi:GdiplusStartupInput, encpar:EncParameters
LOCAL del_name[2048]:TCHAR
    .if img_type== 0
        mov mime_type, uc$("image/bmp")
        mov t_buf, uc$(".bmp")
    .elseif img_type== 1
        mov mime_type, uc$("image/jpeg")
        mov t_buf, uc$(".jpg")
    .elseif img_type== 2
        mov mime_type, uc$("image/png")
        mov t_buf, uc$(".png")
    .elseif img_type== 3
        mov mime_type, uc$("image/gif")
        mov t_buf, uc$(".gif")
    .elseif img_type== 4
        mov mime_type, uc$("image/tiff")
        mov t_buf, uc$(".tif")
    .elseif img_type== 5
        mov mime_type, uc$("image/x-icon")
        mov t_buf, uc$(".ico")
    .else
        return img_name
    .endif
    invoke lstrcpy, addr del_name, img_name
    invoke lstrcat, img_name, t_buf

    mov gdisi.GdiplusVersion, 1
    mov gdisi.DebugEventCallback, 0
    mov gdisi.SuppressBackgroundThread, 0
    mov gdisi.SuppressExternalCodecs, 0
    invoke GdiplusStartup, addr gditoken, addr gdisi, 0
    invoke GdipLoadImageFromFile, addr del_name, addr hImage

    mrm qqq, quality
    lea esi, qqq
    mov encpar.Count, 1
    mov encpar.value, esi
    mov encpar.NumberOfValues, 1
    mov encpar.vType, EncoderValueCompressionCCITT4
    lea esi, EncQuality
    lea edi, encpar.pGUID
    mov ecx, 4
    rep movsd
   ;invoke RtlMoveMemory, addr encpar.pGUID, addr EncQuality, 16

    invoke GdipGetImageEncodersSize, addr encnum, addr encsize
    invoke VirtualAlloc, 0, encsize, MEM_COMMIT, PAGE_READWRITE
    mov encinfo, eax
    invoke GdipGetImageEncoders, encnum, encsize, encinfo

    mov ebx, encinfo
    @@:
    mov eax, [ebx.ImageCodecInfo.MimeType]
    add ebx, sizeof ImageCodecInfo
    mov ecx, eax
    invoke lstrcmp, ecx, mime_type
    test eax, eax
    jz @F
    dec encnum
    jnz @B
    @@:
    sub ebx, sizeof ImageCodecInfo

    invoke GdipSaveImageToFile, hImage, img_name, ebx, addr encpar
    invoke VirtualFree, encinfo, 0, MEM_RELEASE
    invoke GdipDisposeImage, hImage
    invoke GdiplusShutdown, gditoken
    invoke DeleteFile, addr del_name
return img_name
img_conv endp
;**********************************************************************************************************************************************************
get_folder proc loc_buf:DWORD, stri:DWORD
    invoke GetModuleFileName, 0h, loc_buf, 1024
    mov eax, loc_buf
    gfol_m:
    mov bx, word ptr[eax]
    .if bx== 0005ch  ;\
        mov ecx, eax
        add ecx, 02h
    .elseif bx== 00000h
        jmp gfol_m2
    .endif
    add eax, 02h
    jmp gfol_m
    gfol_m2:
    mov word ptr[ecx], 00000h
    invoke lstrcat, loc_buf, stri
    mov eax, loc_buf
ret
get_folder endp
;**********************************************************************************************************************************************************
SetVWData proc uses ebx esi edi ebp hWin:DWORD, num_dat:DWORD, x_dat:DWORD
    invoke GetWindowLong, hWin, 40
    .IF eax== 0
        return -2
    .ENDIF
    invoke GetWindowLong, hWin, 144
    mov ebx, num_dat
    shl ebx, 2
    add eax, ebx
    m2m dword ptr[eax], x_dat
ret
SetVWData endp
;**********************************************************************************************************************************************************
GetVWData proc uses ebx esi edi ebp hWin:DWORD, num_dat:DWORD
    invoke GetWindowLong, hWin, 40
    .IF eax== 0
        return -2
    .ENDIF
    invoke GetWindowLong, hWin, 144
    mov ebx, num_dat
    shl ebx, 2
    add eax, ebx
    mov ecx, dword ptr[eax]
return ecx
GetVWData endp
;**********************************************************************************************************************************************************
    include proc1.asm
    include proc2.asm
;**********************************************************************************************************************************************************
end
