;**********************************************************************************************************************************************************
GetDeviceName proc uses ebx esi edi ebp device:DWORD, user_proc:DWORD
LOCAL wvhWin:DWORD
LOCAL buffer[1024]:TCHAR, md5d[16]:BYTE
.if user_proc== 0
    return 0
.endif
.if device== GDN_WEBCAM
    @@:
    invoke GetWebCamName, 0, addr buffer, addr md5d, addr wvhWin
    cmp eax, 0
    je @F
    push wvhWin
    lea ebx, md5d
    push ebx
    lea ebx, buffer
    push ebx
    push eax
    call user_proc
    jmp @B
    @@:
.elseif device== GDN_MICROPHONE
    @@:
    invoke GetMicrophoneName, 0, addr buffer
    cmp eax, 0
    je @F
    lea ebx, buffer
    push ebx
    push eax
    call user_proc
    jmp @B
    @@:
.endif
return 1
GetDeviceName endp
;**********************************************************************************************************************************************************
GetMicrophoneName proc uses ebx esi edi ebp wcNum:DWORD, wcName:DWORD
LOCAL Fetched:DWORD, Moniker:DWORD, PropBag:DWORD, locNum:DWORD
LOCAL md5:MD5_CTX, len_data:DWORD
    .IF wcNum> 0
        mov maxdevM, 0
        mrm locNum, wcNum
        dec locNum
    .ELSE
        mov locNum, 0
    .ENDIF
    .IF maxdevM== 0
        .if ClassEnumM!= 0 && DevEnumM!= 0
            mov eax, ClassEnumM
            mov ebx, [eax]
            invoke (ICreateDevEnum PTR [ebx]).Release, ClassEnumM
            mov eax, DevEnumM
            mov ebx, [eax]
            invoke (ICreateDevEnum PTR [ebx]).Release, DevEnumM
        .endif
        invoke CoCreateInstance, addr CLSID_SystemDeviceEnum, 0, CLSCTX_INPROC_SERVER, addr IID_ICreateDevEnum, addr DevEnumM
        .IF eax!= 0
            return 0
        .ENDIF
        mov eax, DevEnumM
        mov ebx, [eax]
        invoke (ICreateDevEnum PTR [ebx]).CreateClassEnumerator, DevEnumM, addr CLSID_AudioInputDeviceCategory, addr ClassEnumM, 0
        .IF ClassEnumM== 0 || eax!= 0
            return 0
        .ENDIF
    .ENDIF
    .if locNum> 0
        mov eax, ClassEnumM
        mov ebx, [eax]
        invoke (IEnumMoniker PTR [ebx]).Skip, ClassEnumM, locNum
        cmp eax, S_OK
        jne endEnumDeviceM
    .endif
    mov eax, ClassEnumM
    mov ebx, [eax]
    invoke (IEnumMoniker PTR [ebx]).Next, ClassEnumM, 1, addr Moniker, addr Fetched
    cmp eax, S_OK
    jne endEnumDeviceM
    cmp Fetched, 1
    jne endEnumDeviceM
    mov eax, Moniker
    mov ebx, [eax]
    invoke (IMoniker PTR [ebx]).BindToStorage, Moniker, 0, 0, addr IID_IPropertyBag, addr PropBag
    cmp eax, S_OK
    jne endEnumDeviceM

    mov vt.vt, VT_BSTR
    mov vt.parray, 0
    mov eax, PropBag
    mov ebx, [eax]
    invoke (IPropertyBag PTR [ebx]).Read, PropBag, uc$("FriendlyName"), addr vt, 0
    invoke lstrcpy, wcName, vt.parray
    invoke SysFreeString, vt.parray

    mov eax, PropBag
    mov ebx, [eax]
    invoke (IPropertyBag PTR [ebx]).Release, PropBag
    mov eax, Moniker
    mov ebx, [eax]
    invoke (IEnumMoniker PTR [ebx]).Release, Moniker
    .IF wcNum> 0
        return -1 ;OK
    .ENDIF

    inc maxdevM
    cmp maxdevM, 101
    jae endEnumDeviceM
    return maxdevM ;OK
endEnumDeviceM:
    .if ClassEnumM!= 0 && DevEnumM!= 0
        mov eax, ClassEnumM
        mov ebx, [eax]
        invoke (ICreateDevEnum PTR [ebx]).Release, ClassEnumM
        mov eax, DevEnumM
        mov ebx, [eax]
        invoke (ICreateDevEnum PTR [ebx]).Release, DevEnumM
        mov ClassEnumM, 0
        mov DevEnumM, 0
    .endif
    invoke lstrcpy, wcName, uc$("No microphone")
    mov maxdevM, 0
return 0
GetMicrophoneName endp
;**********************************************************************************************************************************************************
GetWebCamName proc uses ebx esi edi ebp wcNum:DWORD, wcName:DWORD, wcHash:DWORD, wchWin:DWORD
LOCAL Fetched:DWORD, Moniker:DWORD, PropBag:DWORD, locNum:DWORD
LOCAL md5:MD5_CTX, len_data:DWORD
    .IF wcNum> 0
        mov maxdev, 0
        mrm locNum, wcNum
        dec locNum
    .ELSE
        mov locNum, 0
    .ENDIF
    .IF maxdev== 0
        .if ClassEnum!= 0 && DevEnum!= 0
            mov eax, ClassEnum
            mov ebx, [eax]
            invoke (ICreateDevEnum PTR [ebx]).Release, ClassEnum
            mov eax, DevEnum
            mov ebx, [eax]
            invoke (ICreateDevEnum PTR [ebx]).Release, DevEnum
        .endif
        invoke CoCreateInstance, addr CLSID_SystemDeviceEnum, 0, CLSCTX_INPROC_SERVER, addr IID_ICreateDevEnum, addr DevEnum
        .IF eax!= 0
            return 0
        .ENDIF
        mov eax, DevEnum
        mov ebx, [eax]
        invoke (ICreateDevEnum PTR [ebx]).CreateClassEnumerator, DevEnum, addr CLSID_VideoInputDeviceCategory, addr ClassEnum, 0
        .IF ClassEnum== 0 || eax!= 0
            return 0
        .ENDIF
    .ENDIF
    .if locNum> 0
        mov eax, ClassEnum
        mov ebx, [eax]
        invoke (IEnumMoniker PTR [ebx]).Skip, ClassEnum, locNum
        cmp eax, S_OK
        jne endEnumDevice
    .endif
    mov eax, ClassEnum
    mov ebx, [eax]
    invoke (IEnumMoniker PTR [ebx]).Next, ClassEnum, 1, addr Moniker, addr Fetched
    cmp eax, S_OK
    jne endEnumDevice
    cmp Fetched, 1
    jne endEnumDevice
    mov eax, Moniker
    mov ebx, [eax]
    invoke (IMoniker PTR [ebx]).BindToStorage, Moniker, 0, 0, addr IID_IPropertyBag, addr PropBag
    cmp eax, S_OK
    jne endEnumDevice

    mov vt.vt, VT_BSTR
    mov vt.parray, 0
    mov eax, PropBag
    mov ebx, [eax]
    invoke (IPropertyBag PTR [ebx]).Read, PropBag, uc$("FriendlyName"), addr vt, 0
    invoke lstrcpy, wcName, vt.parray
    invoke SysFreeString, vt.parray

    mov vt.vt, VT_BSTR
    mov vt.parray, 0
    mov eax, PropBag
    mov ebx, [eax]
    invoke (IPropertyBag PTR [ebx]).Read, PropBag, uc$("DevicePath"), addr vt, 0
    invoke lstrlen, vt.parray
    mov len_data, eax
    invoke MD5Init, addr md5
    invoke MD5Update, addr md5, vt.parray, len_data
    invoke MD5Final, addr md5
    lea esi, md5.digest
    mov edi, wcHash
    mov ecx, 4
    rep movsd
    invoke SysFreeString, vt.parray

    mov eax, PropBag
    mov ebx, [eax]
    invoke (IPropertyBag PTR [ebx]).Release, PropBag
    mov eax, Moniker
    mov ebx, [eax]
    invoke (IEnumMoniker PTR [ebx]).Release, Moniker
    .IF wcNum> 0
        invoke dd_cmp, addr md5.digest
        .if eax> 0
            mov ebx, wchWin
            mov dword ptr[ebx], eax
        .else
            mov ebx, wchWin
            mov dword ptr[ebx], 0
        .endif
        return -1 ;OK
    .ENDIF

    inc maxdev
    cmp maxdev, 101
    jae endEnumDevice
    invoke dd_cmp, addr md5.digest
    .if eax> 0
        mov ebx, wchWin
        mov dword ptr[ebx], eax
    .else
        mov ebx, wchWin
        mov dword ptr[ebx], 0
    .endif
    return maxdev ;OK
endEnumDevice:
    .if ClassEnum!= 0 && DevEnum!= 0
        mov eax, ClassEnum
        mov ebx, [eax]
        invoke (ICreateDevEnum PTR [ebx]).Release, ClassEnum
        mov eax, DevEnum
        mov ebx, [eax]
        invoke (ICreateDevEnum PTR [ebx]).Release, DevEnum
        mov ClassEnum, 0
        mov DevEnum, 0
    .endif
    mov ebx, wchWin
    mov dword ptr[ebx], 0
    invoke lstrcpy, wcName, uc$("Is no camera")
    mov maxdev, 0
return 0
GetWebCamName endp
;**********************************************************************************************************************************************************
VWFullScreen proc uses ebx esi edi ebp hWin:DWORD, on_off:DWORD
LOCAL hParent:DWORD, wvw:DWORD, wvh:DWORD, wvx:DWORD, wvy:DWORD, rec:RECT, wvStyle:DWORD
    invoke GetWindowLong, hWin, 40  ;режим: 2- с просмотром, 1- без просмотра
    .IF ax== 1 || eax== 0  ;если без просмотра или идентификатор не активен- полноэкранный режим не используется
        return -2
    .ENDIF
    invoke GetWindowLong, hWin, 80  ;полноэкранный режим 1-включен, 2-выключен
    .IF f_FullScreen> 2 && eax== 2  ;блокировать полноэкранный режим в других окнах если в одном он уже активен
        return 0
    .ENDIF
    .IF on_off== 1 && eax== 2      ;включение
        invoke GetWindowRect, hWin, addr rec
        mov eax, rec.right
        sub eax, rec.left
        mov wvw, eax
        mov eax, rec.bottom
        sub eax, rec.top
        mov wvh, eax
        invoke GetParent, hWin
        mov hParent, eax
        invoke SetWindowLong, hWin, 52, hParent
        .if hParent!= 0
            invoke ScreenToClient, hParent, addr rec
        .endif
        invoke SetWindowLong, hWin, 92, rec.left ;x
        invoke SetWindowLong, hWin, 96, rec.top ;y
        invoke SetWindowLong, hWin, 84, wvw ;ширина
        invoke SetWindowLong, hWin, 88, wvh ;высота
        invoke GetSystemMetrics, SM_CXSCREEN
        mov wvw, eax
        invoke GetSystemMetrics, SM_CYSCREEN
        mov wvh, eax
        invoke ShowWindow, hWin, SW_HIDE
        invoke GetWindowLong, hWin, GWL_STYLE
        mov wvStyle, eax
        invoke SetWindowLong, hWin, 60, wvStyle
        invoke SetWindowLong, hWin, GWL_STYLE, WS_POPUP or WS_CLIPCHILDREN or WS_CLIPSIBLINGS
        .if hParent!= 0
            invoke SetParent, hWin, 0
        .endif
        invoke SetWindowPos, hWin, HWND_TOP, 0, 0, wvw, wvh, SWP_SHOWWINDOW
        invoke SetForegroundWindow, hWin
        invoke SetActiveWindow, hWin
        invoke SetWindowLong, hWin, 80, 1
        mrm f_FullScreen, hWin
    .ELSEIF on_off== 2 && eax== 1  ;выключение
        invoke SetWindowLong, hWin, 80, 2
        mov f_FullScreen, 2
        invoke GetWindowLong, hWin, 84
        mov wvw, eax
        invoke GetWindowLong, hWin, 88
        mov wvh, eax
        invoke GetWindowLong, hWin, 92
        mov wvx, eax
        invoke GetWindowLong, hWin, 96
        mov wvy, eax
        invoke ShowWindow, hWin, SW_HIDE
        invoke GetWindowLong, hWin, 60
        or eax, WS_CLIPCHILDREN or WS_CLIPSIBLINGS
        invoke SetWindowLong, hWin, GWL_STYLE, eax
        invoke GetWindowLong, hWin, 52
        mov hParent, eax
        .if hParent!= 0
            invoke SetParent, hWin, hParent
        .endif
        invoke SetWindowPos, hWin, HWND_TOP, wvx, wvy, wvw, wvh, SWP_SHOWWINDOW
        invoke SetForegroundWindow, hParent
        invoke SetActiveWindow, hParent
    .ENDIF
return 1
VWFullScreen endp
;**********************************************************************************************************************************************************
StartVideo proc uses ebx esi edi ebp hWin:DWORD, MicrophoneNum:DWORD, fAudioVideo:DWORD, BufferFileName:DWORD
LOCAL buffer[1024]:TCHAR, md5d[16]:BYTE
LOCAL f_control_video:DWORD, new_num:DWORD, wvhWin:DWORD
    invoke GetWindowLong, hWin, 48 ;1- стоп, 2- старт, 3- пауза
    .if eax== 0
        return -2
    .elseif eax== 1 || eax== 3
        mov f_control_video, eax
        .if eax== 1
            invoke GetWindowLong, hWin, 0
            mov ebx, eax
            invoke GetWebCamName, ebx, addr buffer, addr md5d, addr wvhWin
            cmp eax, 0
            je start_vid_m
            invoke cmp_md5, hWin, addr md5d
            .if eax== 0
              start_vid_m:
                invoke GetWebCamName, 0, addr buffer, addr md5d, addr wvhWin
                cmp eax, 0
                je start_vid_m1
                mov new_num, eax
                invoke cmp_md5, hWin, addr md5d
                cmp eax, 1
                jne @F
                invoke SetWindowLong, hWin, 0, new_num
                jmp start_vid_m2
                @@:
                jmp start_vid_m
              start_vid_m1:
                invoke GetWindowText, hWin, addr buffer, 1024
                invoke MessageBox, hWin, uc$("Unable to connect to the selected camera."), addr buffer, MB_OK
                return 0    ;к выбранной камере подключиться не удалось.
            .endif
            start_vid_m2:
            invoke release_graph, hWin
            invoke steep1, hWin, MicrophoneNum
            .if eax== 0
                return 0    ;к выбранной камере\микрофону подключиться не удалось.
            .endif
            invoke set_format, hWin
            
            xor eax, eax
            xor ebx, ebx
            xor ecx, ecx
            test fAudioVideo, SV_PREVIEW_AUDIO
            jz @F
                mov eax, 1
            @@:
            test fAudioVideo, SV_RECORDING_AUDIO
            jz @F
                mov ebx, 1
            @@:
            test fAudioVideo, SV_RECORDING_VIDEO
            jz @F
                mov ecx, 1
            @@:            
            invoke set_grabber, hWin, eax, ebx, ecx, BufferFileName     ;fAudioPreview -eax, fAudioRecording -ebx, fVideoRecording -ecx
            .if eax== 0
                return 0    ;к выбранной камере подключиться не удалось.
            .endif
        .endif
        invoke GetWindowLong, hWin, 8
        mov ebx, [eax]
        invoke (IMediaControl PTR [ebx]).Run, eax
        .if eax== 1 && f_control_video== 1                            ;успешно
            invoke GetWindowLong, hWin, 12
            mov ebx, [eax]
            invoke (IVideoWindow PTR [ebx]).put_Visible, eax, -1
            invoke SetWindowLong, hWin, 48, 2 ;start
        .elseif eax== 0 && f_control_video== 3                        ;успешно
            invoke SetWindowLong, hWin, 48, 2 ;start
        .else
            invoke GetWindowLong, hWin, 12
            mov ebx, [eax]
            invoke (IVideoWindow PTR [ebx]).put_Visible, eax, 0
            invoke SetWindowLong, hWin, 48, 1 ;stop
            invoke GetWindowText, hWin, addr buffer, 1024
            invoke MessageBox, hWin, ucc$("The camera is already in use by another application or system \nperformance is not enough to run."), addr buffer, MB_OK
            return 0
        .endif
        invoke GetWindowLong, hWin, 40; режим
        .if ax== 1 ;без просмотра
            invoke Sleep, 2500
        .endif
    .endif
return 1
StartVideo endp
;**********************************************************************************************************************************************************
StopVideo proc uses ebx esi edi ebp hWin:DWORD
    invoke GetWindowLong, hWin, 48 ;1- стоп, 2- старт, 3- пауза
    .if eax== 0
        return -2
    .elseif eax== 2 || eax== 3
        invoke SetWindowLong, hWin, 48, 1 ;stop
        invoke GetWindowLong, hWin, 8
        mov ebx, [eax]
        invoke (IMediaControl PTR [ebx]).Stop, eax
        invoke GetWindowLong, hWin, 12
        mov ebx, [eax]
        invoke (IVideoWindow PTR [ebx]).put_Visible, eax, 0
    .endif
return 1
StopVideo endp
;**********************************************************************************************************************************************************
PauseVideo proc uses ebx esi edi ebp hWin:DWORD
    invoke GetWindowLong, hWin, 48 ;1- стоп, 2- старт, 3- пауза
    .if eax== 0
        return -2
    .elseif eax== 2
        invoke SetWindowLong, hWin, 48, 3 ;pause
        invoke GetWindowLong, hWin, 8
        mov ebx, [eax]
        invoke (IMediaControl PTR [ebx]).IMCPause, eax
    .endif
return 1
PauseVideo endp
;**********************************************************************************************************************************************************
RatioFPU proc uses ebx esi edi ebp rec:DWORD
    mov ebx, rec
    mov ecx, dword ptr[ebx+8]
    mov edx, dword ptr[ebx+12]
    ;--FPU--
    finit
    fild dword ptr[ebx+8]
    fidiv dword ptr[ebx+12]
    fild dword ptr[ebx]
    fidiv dword ptr[ebx+4]
    fcom
    fstsw ax
    fwait
    sahf
    ja fpu_m1
        fimul dword ptr[ebx+12]
        fist dword ptr[ebx+8]
        jmp fpu_m2
    fpu_m1:
        fidivr dword ptr[ebx+8]
        fist dword ptr[ebx+12]
    fpu_m2:
    fwait
    ;-------
    sub ecx, dword ptr[ebx+8]
    shr ecx, 1
    mov dword ptr[ebx], ecx
    sub edx, dword ptr[ebx+12]
    shr edx, 1
    mov dword ptr[ebx+4], edx
return ebx
RatioFPU endp
;**********************************************************************************************************************************************************
VWRatio proc uses ebx esi edi ebp hWin:DWORD, f_ratio:DWORD
LOCAL rec:RECT
    invoke GetWindowLong, hWin, 40
    .if eax== 0 || ax== 1
        return 0
    .endif
    mov ebx, f_ratio
    ror eax, 16
    mov ax, bx
    ror eax, 16
    invoke SetWindowLong, hWin, 40, eax
    invoke GetClientRect, hWin, addr rec
    .IF f_ratio== 1     ;сохранять пропорцию
        invoke GetWindowLong, hWin, 36  ;ширина и высота видеокадра в пикселях
        movzx edx, ax
        mov rec.left, edx
        shr eax, 16
        mov rec.top, eax
        invoke RatioFPU, addr rec
    .ELSEIF f_ratio== 2 ;растянуть
        mov rec.left, 0
        mov rec.top, 0
    .ELSE
        mov rec.left, 0
        mov rec.top, 0
    .ENDIF
    invoke GetWindowLong, hWin, 12
    cmp eax, 0
    je @F
    mov ebx,[eax]
    invoke (IVideoWindow PTR [ebx]).SetWindowPosition, eax, rec.left, rec.top, rec.right, rec.bottom
    mov eax, rec.bottom
    shl eax, 16
    mov ecx, rec.right
    mov ax, cx
    @@:
ret
VWRatio endp
;**********************************************************************************************************************************************************
cmp_md5 proc hWin:DWORD, md5d:DWORD
    invoke GetWindowLong, hWin, 56
    mov esi, md5d
    mov ecx, 4
    @@:
    mov ebx, dword ptr[esi]
    mov edx, dword ptr[eax]
    cmp ebx, edx
    jne @F
    add esi, 4
    add eax, 4
    loop @B
    return 1 ;OK
    @@:
    return 0 ;ERROR
cmp_md5 endp
;**********************************************************************************************************************************************************
GetTime proc uses ebx esi edi ebp
LOCAL stmt:SYSTEMTIME
    invoke GetLocalTime, addr stmt
    movzx ebx, stmt.wDay
    invoke lstrcpy, addr TimeBuffer, ustr$(ebx)
    invoke lstrcat, addr TimeBuffer, uc$("-")
    movzx ebx, stmt.wMonth
    invoke lstrcat, addr TimeBuffer, ustr$(ebx)
    invoke lstrcat, addr TimeBuffer, uc$("-")
    movzx ebx, stmt.wYear
    invoke lstrcat, addr TimeBuffer, ustr$(ebx)
    invoke lstrcat, addr TimeBuffer, uc$("_")
    movzx ebx, stmt.wHour
    invoke lstrcat, addr TimeBuffer, ustr$(ebx)
    invoke lstrcat, addr TimeBuffer, uc$("h-")
    movzx ebx, stmt.wMinute
    invoke lstrcat, addr TimeBuffer, ustr$(ebx)
    invoke lstrcat, addr TimeBuffer, uc$("m-")
    movzx ebx, stmt.wSecond
    invoke lstrcat, addr TimeBuffer, ustr$(ebx)
    invoke lstrcat, addr TimeBuffer, uc$("s-")
    movzx ebx, stmt.wMilliseconds
    invoke lstrcat, addr TimeBuffer, ustr$(ebx)
    invoke lstrcat, addr TimeBuffer, uc$("ms")
    lea eax, TimeBuffer
    ret
GetTime endp
;**********************************************************************************************************************************************************

