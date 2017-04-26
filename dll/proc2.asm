;**********************************************************************************************************************************************************
steep1 proc hWin:DWORD, MicrophoneNum:DWORD
LOCAL Graph:DWORD, Builder:DWORD, WebCamNum:DWORD, Src:DWORD, Src_Audio:DWORD, Fetched:DWORD, Moniker:DWORD, ClassEnum1:DWORD, DevEnum1:DWORD, MedVed:DWORD
LOCAL buffer1[1024]:TCHAR, buffer2[1024]:TCHAR
    invoke GetWindowText, hWin, addr buffer1, 1024
    invoke GetWindowLong, hWin, 0   ;номер камеры
    mov WebCamNum, eax
    dec WebCamNum

    invoke CoCreateInstance, addr CLSID_FilterGraph, 0, CLSCTX_INPROC_SERVER, addr IID_IGraphBuilder, addr Graph
        cmp eax, 0
        jne error_cvw
        
    invoke CoCreateInstance, addr CLSID_CaptureGraphBuilder2, 0, CLSCTX_INPROC_SERVER, addr IID_ICaptureGraphBuilder2, addr Builder
        cmp eax, 0
        jne error_cvw
        
    mov eax, Builder
    mov ebx, [eax]
    invoke (ICaptureGraphBuilder2 PTR [ebx]).SetFiltergraph, Builder, Graph
        cmp eax, 0
        jne error_cvw

    invoke CoCreateInstance, addr CLSID_SystemDeviceEnum, 0, CLSCTX_INPROC_SERVER, addr IID_ICreateDevEnum, addr DevEnum1
        cmp eax, 0
        jne error_cvw
        
    mov eax, DevEnum1
    mov ebx, [eax]
    invoke (ICreateDevEnum PTR [ebx]).CreateClassEnumerator, DevEnum1, addr CLSID_VideoInputDeviceCategory, addr ClassEnum1, 0
        cmp eax, 0
        jne error_cvw
        
    mov eax, ClassEnum1
    mov ebx, [eax]
    invoke (IEnumMoniker PTR [ebx]).Reset, ClassEnum1
        cmp eax, 0
        jne error_cvw
        
    invoke (IEnumMoniker PTR [ebx]).Skip, ClassEnum1, WebCamNum
    invoke (IEnumMoniker PTR [ebx]).Next, ClassEnum1, 1, addr Moniker, addr Fetched
        cmp eax, 0
        jne error_cvw
        cmp Fetched, 1
        jne error_cvw
        
    mov eax, Moniker
    mov ebx, [eax]
    invoke (IMoniker PTR [ebx]).BindToObject, Moniker, 0, 0, addr IID_IBaseFilter, addr Src
        cmp eax, 0
        jne error_cvw

    invoke (IEnumMoniker PTR [ebx]).Release, Moniker
    mov eax, ClassEnum1
    mov ebx, [eax]
    invoke (ICreateDevEnum PTR [ebx]).Release, ClassEnum1
    mov eax, DevEnum1
    mov ebx, [eax]
    invoke (ICreateDevEnum PTR [ebx]).Release, DevEnum1
    
    mov eax, Graph
    mov ebx, [eax]
    invoke (IGraphBuilder PTR [ebx]).AddFilter, Graph, Src, addr buffer1
        cmp eax, 0
        jne error_cvw
;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;++++++++++++++++++++++++++++++++++++++++++++++++++++++++++ADD AUDIO DEVICE+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    mov Src_Audio, 0
.if MicrophoneNum!= 0
    invoke GetMicrophoneName, MicrophoneNum, addr buffer2
    dec MicrophoneNum

    invoke CoCreateInstance, addr CLSID_SystemDeviceEnum, 0, CLSCTX_INPROC_SERVER, addr IID_ICreateDevEnum, addr DevEnum1
        cmp eax, 0
        jne error_cvw2
        
    mov eax, DevEnum1
    mov ebx, [eax]
    invoke (ICreateDevEnum PTR [ebx]).CreateClassEnumerator, DevEnum1, addr CLSID_AudioInputDeviceCategory, addr ClassEnum1, 0
        cmp eax, 0
        jne error_cvw2
        
    mov eax, ClassEnum1
    mov ebx, [eax]
    invoke (IEnumMoniker PTR [ebx]).Reset, ClassEnum1
        cmp eax, 0
        jne error_cvw2
        
    invoke (IEnumMoniker PTR [ebx]).Skip, ClassEnum1, MicrophoneNum
    invoke (IEnumMoniker PTR [ebx]).Next, ClassEnum1, 1, addr Moniker, addr Fetched
        cmp eax, 0
        jne error_cvw2
        cmp Fetched, 1
        jne error_cvw2
        
    mov eax, Moniker
    mov ebx, [eax]
    invoke (IMoniker PTR [ebx]).BindToObject, Moniker, 0, 0, addr IID_IBaseFilter, addr Src_Audio
        cmp eax, 0
        jne error_cvw2

    invoke (IEnumMoniker PTR [ebx]).Release, Moniker
    mov eax, ClassEnum1
    mov ebx, [eax]
    invoke (ICreateDevEnum PTR [ebx]).Release, ClassEnum1
    mov eax, DevEnum1
    mov ebx, [eax]
    invoke (ICreateDevEnum PTR [ebx]).Release, DevEnum1
    
    mov eax, Graph
    mov ebx, [eax]
    invoke (IGraphBuilder PTR [ebx]).AddFilter, Graph, Src_Audio, addr buffer2
        cmp eax, 0
        jne error_cvw2
.endif
;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
;+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    invoke (IGraphBuilder PTR [ebx]).QueryInterface, Graph, addr IID_IMediaEventEx, addr MedVed
    mov eax, MedVed
    mov ebx,[eax]
    invoke (IMediaEvent PTR [ebx]).SetNotifyWindow, MedVed, hWin, VWM_GRAPHNOTIFY, 0 ; 0- lParam
    invoke (IMediaEvent PTR [ebx]).SetNotifyFlags, MedVed, 0
    
    invoke SetWindowLong, hWin, 16, Graph
    invoke SetWindowLong, hWin, 20, Builder
    invoke SetWindowLong, hWin, 24, Src
    invoke SetWindowLong, hWin, 124, Src_Audio
    invoke SetWindowLong, hWin, 44, MedVed
return 1 ;OK
    
error_cvw2:
    invoke MessageBox, hWin, uc$("Unable to connect the selected microphone."), addr buffer2, MB_OK
    jmp error_cvw_
error_cvw:
    invoke MessageBox, hWin, uc$("Unable to connect to the selected camera."), addr buffer1, MB_OK
error_cvw_:
    mov eax, Builder
    cmp eax, 0
    je @F
    mov ebx, [eax]
    invoke (ICaptureGraphBuilder2 PTR [ebx]).Release, Builder
    
    @@:
    mov eax, Graph
    cmp eax, 0
    je @F
    mov ebx, [eax]
    invoke (IGraphBuilder PTR [ebx]).Release, Graph
    
    @@:
    invoke SetWindowLong, hWin, 16, 0
    invoke SetWindowLong, hWin, 20, 0
    invoke SetWindowLong, hWin, 24, 0
    invoke SetWindowLong, hWin, 124, 0
    invoke SetWindowLong, hWin, 44, 0
    return 0 ;ERROR
steep1 endp
;**********************************************************************************************************************************************************
set_format proc hWin:DWORD
LOCAL pBuilder:DWORD, pInterface:DWORD, Src:DWORD, buffer_am_type:DWORD, buffer_am_type_f:DWORD
LOCAL buffer[1024]:TCHAR
invoke GetWindowLong, hWin, 104
 mov buffer_am_type_f, eax
.if buffer_am_type_f== 1
    invoke GetWindowLong, hWin, 100
    mov buffer_am_type, eax
    invoke GetWindowLong, hWin, 24
    mov Src, eax
    invoke GetWindowLong, hWin, 20
    mov pBuilder, eax
    mov ebx, [eax]
    invoke (ICaptureGraphBuilder2 PTR [ebx]).FindInterface, pBuilder, addr PIN_CATEGORY_CAPTURE, addr MEDIATYPE_Interleaved, Src, addr IID_IAMStreamConfig, addr pInterface
    cmp eax,S_OK
    je set_format_start

    invoke (ICaptureGraphBuilder2 PTR [ebx]).FindInterface, pBuilder, addr PIN_CATEGORY_CAPTURE, addr MEDIATYPE_Video, Src, addr IID_IAMStreamConfig, addr pInterface
    cmp eax, E_NOINTERFACE
    je set_format_err
    cmp eax, S_OK
    jne set_format_err

    set_format_start:

    mov eax, pInterface
    mov ebx, [eax]
    invoke (IAMStreamConfig PTR [ebx]).SetFormat, pInterface, buffer_am_type
    cmp eax, S_OK
    jne set_format_err
    invoke (ICaptureGraphBuilder2 PTR [ebx]).Release, pInterface

    set_format_err:
.endif
ret
set_format endp
;**********************************************************************************************************************************************************
set_grabber proc hWin:DWORD, fAudioPreview:DWORD, fAudioRecording:DWORD, fVideoRecording:DWORD, BufferFileName:DWORD
LOCAL GrabberF:DWORD, Grabber:DWORD, NulleG:DWORD, Graph:DWORD, Builder:DWORD, flag_mod:DWORD, Src:DWORD, Src_Audio:DWORD, VidWin:DWORD, ControlVideo:DWORD, AsfWriter:DWORD, pSi:DWORD
LOCAL pAsfConfig:DWORD, pProfile:DWORD, pStreamConfig:DWORD, pMediaProps:DWORD
LOCAL buffer_am_type:DWORD, buffer_am_type_f:DWORD, a_loc:DWORD, a_loc2:DWORD
LOCAL buffer1[1024]:TCHAR, amt:AM_MEDIA_TYPE
    invoke GetWindowLong, hWin, 16
    mov Graph, eax
    invoke GetWindowLong, hWin, 20
    mov Builder, eax
    invoke GetWindowLong, hWin, 24
    mov Src, eax
    invoke GetWindowLong, hWin, 124
    mov Src_Audio, eax
    invoke GetWindowLong, hWin, 40
    mov flag_mod, eax

    invoke CoCreateInstance, addr CLSID_SampleGrabber, 0, CLSCTX_INPROC_SERVER, addr IID_IBaseFilter, addr GrabberF
    mov eax, Graph
    mov ebx, [eax]
    invoke (IGraphBuilder PTR [ebx]).AddFilter, Graph, GrabberF, uc$("Sample_Grabber")
    cmp eax, S_OK
    jne err_grabber_m
;-------------------------------------
    mov eax, flag_mod
    .IF ax== 1
        invoke CoCreateInstance, addr CLSID_NullRenderer, 0, CLSCTX_INPROC_SERVER, addr IID_IBaseFilter, addr NulleG
        mov eax, Graph
        mov ebx, [eax]
        invoke (IGraphBuilder PTR [ebx]).AddFilter, Graph, NulleG, uc$("Null_Renderer")
    .ELSE
        mov NulleG, 0
    .ENDIF
;-------------------------------------
    mov eax, GrabberF
    mov ebx, [eax]
    invoke (IGraphBuilder PTR [ebx]).QueryInterface, GrabberF, addr IID_ISampleGrabber, addr Grabber
    cmp eax, S_OK
    jne err_grabber_m
;-------
    lea edi, amt
    mov ecx, sizeof amt
    mov eax, 0h
    rep stosd
;-------
    lea esi, MEDIATYPE_Video
    lea edi, amt.majortype
    mov ecx, 4
    rep movsd
    lea esi, MEDIASUBTYPE_RGB24
    lea edi, amt.subtype
    mov ecx, 4
    rep movsd
    lea esi, FORMAT_VideoInfo
    lea edi, amt.formattype
    mov ecx, 4
    rep movsd
    mov eax, Grabber
    mov ebx, [eax]
    invoke (ISampleGrabber PTR [ebx]).SetMediaType, Grabber, addr amt
    cmp eax, S_OK
    jne err_grabber_m
    mov eax, Grabber
    mov ebx, [eax]
    invoke (ISampleGrabber PTR [ebx]).SetOneShot, Grabber, 0
    cmp eax, S_OK
    jne err_grabber_m
    mov eax, Grabber
    mov ebx, [eax]
    invoke (ISampleGrabber PTR [ebx]).SetBufferSamples, Grabber, 1
;----------------------------------+++
    .if fVideoRecording== 1
        invoke lstrcpy, addr wcBuffer, BufferFileName
        invoke lstrcat, addr wcBuffer, uc$(".avi")
        mov eax, Builder
        mov ebx, [eax]
        invoke (ICaptureGraphBuilder2 PTR [ebx]).SetOutputFileName, Builder, addr MEDIASUBTYPE_Avi, addr wcBuffer, addr AsfWriter, addr pSi
        cmp eax, S_OK
        jne err_grabber_m
        invoke (ICaptureGraphBuilder2 PTR [ebx]).RenderStream, Builder, addr PIN_CATEGORY_CAPTURE, addr MEDIATYPE_Video, Src, 0, AsfWriter
        cmp eax, S_OK
        jne err_grabber_m
        .if fAudioRecording== 1 && Src_Audio!= 0
            invoke (ICaptureGraphBuilder2 PTR [ebx]).RenderStream, Builder, addr PIN_CATEGORY_CAPTURE, addr MEDIATYPE_Audio, Src_Audio, 0, AsfWriter
            cmp eax, S_OK
            jne err_grabber_m
        .endif
        invoke SetWindowLong, hWin, 128, AsfWriter
        invoke SetWindowLong, hWin, 132, pSi
    .endif
;----------------------------------+++
    mov eax, Builder
    mov ebx, [eax]
    invoke (ICaptureGraphBuilder2 PTR [ebx]).RenderStream, Builder, addr PIN_CATEGORY_PREVIEW, addr MEDIATYPE_Video, Src, GrabberF, NulleG
;+++++++++++++++++++++++++++++++++++++
;++++ AUDIO ++++++++++++++++++++++++++
;+++++++++++++++++++++++++++++++++++++
    .if fAudioPreview== 1 && Src_Audio!= 0
        invoke (ICaptureGraphBuilder2 PTR [ebx]).RenderStream, Builder, addr PIN_CATEGORY_PREVIEW, addr MEDIATYPE_Audio, Src_Audio, 0, 0
    .endif
;+++++++++++++++++++++++++++++++++++++
;+++++++++++++++++++++++++++++++++++++
    mov eax, Graph
    mov ebx, [eax]
    invoke (IGraphBuilder PTR [ebx]).QueryInterface, Graph, addr IID_IVideoWindow, addr VidWin
    invoke (IGraphBuilder PTR [ebx]).QueryInterface, Graph, addr IID_IMediaControl, addr ControlVideo
;-------------------------------------
    mov eax, VidWin
    mov ebx, [eax]
    invoke (IVideoWindow PTR [ebx]).put_Owner, VidWin, hWin
    invoke (IVideoWindow PTR [ebx]).put_MessageDrain, VidWin, hWin
    invoke (IVideoWindow PTR [ebx]).put_WindowStyle, VidWin, WS_CHILD or WS_CLIPSIBLINGS
    invoke (IVideoWindow PTR [ebx]).put_Visible, VidWin, 0

    mov eax, Grabber
    mov ebx, [eax]
    invoke (ISampleGrabber PTR [ebx]).GetConnectedMediaType, Grabber, addr amt
    mov ebx, amt.pbFormat
    mov eax, dword ptr[ebx+52]
    mov ecx, dword ptr[ebx+56]
    shl ecx, 16
    mov cx, ax
    invoke SetWindowLong, hWin, 36, ecx
    invoke CoTaskMemFree, amt.pbFormat
;-------------------------------------
    invoke SetWindowLong, hWin, 4,  NulleG
    invoke SetWindowLong, hWin, 28, GrabberF
    invoke SetWindowLong, hWin, 32, Grabber
    invoke SetWindowLong, hWin, 8,  ControlVideo
    invoke SetWindowLong, hWin, 12, VidWin
    mov ecx, flag_mod
    shr ecx, 16
    invoke VWRatio, hWin, ecx
    return 1
err_grabber_m:
    invoke GetWindowText, hWin, addr buffer1, 1024
    invoke MessageBox, hWin, uc$("Unable to connect to the selected camera."), addr buffer1, MB_OK
return 0
set_grabber endp
;**********************************************************************************************************************************************************
dFormat proc uses ebx esi edi ebp hWin:DWORD
LOCAL am_type:DWORD, pBuilder:DWORD, pInterface:DWORD, Src:DWORD, pSpecify:DWORD, buffer_am_type:DWORD, buffer_am_type_f:DWORD
LOCAL buffer[1024]:TCHAR
    invoke GetWindowLong, hWin, 48 ;1- стоп, 2- старт, 3- пауза
    .if eax== 2 || eax== 3 || eax== 0 ;если старт или пауза или идентификатор недействителен диалог блокируется
        return 0
    .endif
    invoke release_graph, hWin
    invoke steep1, hWin, 0
    .if eax== 0
        return 0    ;к выбранной камере подключиться не удалось.
    .endif
    invoke GetWindowLong, hWin, 100
    mov buffer_am_type, eax
    invoke GetWindowLong, hWin, 104
    mov buffer_am_type_f, eax
    invoke GetWindowLong, hWin, 24
    mov Src, eax
    invoke GetWindowLong, hWin, 20
    mov pBuilder, eax
    mov ebx, [eax]
    invoke (ICaptureGraphBuilder2 PTR [ebx]).FindInterface, pBuilder, addr PIN_CATEGORY_CAPTURE, addr MEDIATYPE_Interleaved, Src, addr IID_IAMStreamConfig, addr pInterface
    cmp eax,S_OK
    je SubVideoStreamConfigurationGo

    invoke (ICaptureGraphBuilder2 PTR [ebx]).FindInterface, pBuilder, addr PIN_CATEGORY_CAPTURE, addr MEDIATYPE_Video, Src, addr IID_IAMStreamConfig, addr pInterface
    cmp eax, E_NOINTERFACE
    je SubVideoStreamConfigurationReturn
    cmp eax, S_OK
    jne SubVideoStreamConfigurationReturn

    SubVideoStreamConfigurationGo:
    .if buffer_am_type_f== 1
        mov eax, pInterface
        mov ebx, [eax]
        invoke (IAMStreamConfig PTR [ebx]).SetFormat, pInterface, buffer_am_type
        cmp eax, S_OK
        jne SubVideoStreamConfigurationReturn
    .endif

    mov eax, pInterface
    mov ebx, [eax]
    invoke (IAMVideoProcAmp PTR [ebx]).QueryInterface, pInterface, addr IID_ISpecifyPropertyPages, addr pSpecify
    cmp eax, S_OK
    jne SubVideoStreamConfigurationRelease
    mov eax, pSpecify
    mov ebx, [eax]
    invoke (ISpecifyPropertyPages PTR [ebx]).GetPages, pSpecify, addr cauuid
    invoke (ISpecifyPropertyPages PTR [ebx]).Release, pSpecify
    invoke GetWindowText, hWin, addr buffer, 1024
    invoke OleCreatePropertyFrame, hWin, 0, 0, addr buffer, 1, addr pInterface, cauuid.cElems, cauuid.pElems, 0, 0, 0
    cmp eax, S_OK
    jne SubVideoStreamConfigurationRelease
    invoke CoTaskMemFree, cauuid.pElems
    invoke GetWindowLong, hWin, 48 ;1- стоп, 2- старт, 3- пауза
    .if eax== 0 ;если идентификатор недействителен диалог блокируется
        return 0
    .endif
    
    mov eax, pInterface
    mov ebx, [eax]
    invoke (IAMStreamConfig PTR [ebx]).GetFormat, pInterface, addr am_type
    cmp eax, S_OK
    jne SubVideoStreamConfigurationReturn
    
    invoke MoFreeMediaType, buffer_am_type
    invoke MoCopyMediaType, buffer_am_type, am_type
    mov buffer_am_type_f, 1
    invoke MoDeleteMediaType, am_type
    invoke SetWindowLong, hWin, 104, buffer_am_type_f
    
    mov eax, pInterface
    mov ebx, [eax]
    invoke (IAMStreamConfig PTR [ebx]).SetFormat, pInterface, buffer_am_type
    cmp eax, S_OK
    jne SubVideoStreamConfigurationReturn
    
    SubVideoStreamConfigurationRelease:
    mov eax, pInterface
    mov ebx, [eax]
    invoke (ICaptureGraphBuilder2 PTR [ebx]).Release, pInterface

    SubVideoStreamConfigurationReturn:
return 1
dFormat endp
;**********************************************************************************************************************************************************
release_graph proc hWin:DWORD
LOCAL GrabberF:DWORD, Grabber:DWORD, MedVed:DWORD, Graph:DWORD, Builder:DWORD, VidWin:DWORD, ControlVideo:DWORD, Src:DWORD, Src_Audio:DWORD, AsfWriter:DWORD, pSi:DWORD
    invoke GetWindowLong, hWin, 8
    mov ControlVideo, eax
    invoke GetWindowLong, hWin, 44
    mov MedVed, eax
    invoke GetWindowLong, hWin, 12
    mov VidWin, eax
    invoke GetWindowLong, hWin, 20
    mov Builder, eax
    invoke GetWindowLong, hWin, 24
    mov Src, eax
    invoke GetWindowLong, hWin, 124
    mov Src_Audio, eax
    invoke GetWindowLong, hWin, 16
    mov Graph, eax
    invoke GetWindowLong, hWin, 32
    mov Grabber, eax
    invoke GetWindowLong, hWin, 28
    mov GrabberF, eax
    invoke GetWindowLong, hWin, 128
    mov AsfWriter, eax
    invoke GetWindowLong, hWin, 132
    mov pSi, eax

    mov eax, ControlVideo
    cmp eax, 0
    je @F
    mov ebx, [eax]
    invoke (IMediaControl PTR [ebx]).Release, ControlVideo
    mov ControlVideo, 0

    @@:
    mov eax, AsfWriter
    cmp eax, 0
    je @F
    mov ebx, [eax]
    invoke (ICaptureGraphBuilder2 PTR [ebx]).Release, AsfWriter
    mov AsfWriter, 0

    @@:
    mov eax, pSi
    cmp eax, 0
    je @F
    mov ebx, [eax]
    invoke (ICaptureGraphBuilder2 PTR [ebx]).Release, pSi
    mov pSi, 0

    @@:
    mov eax, MedVed
    cmp eax, 0
    je @F
    mov ebx,[eax]
    invoke (IMediaEvent PTR [ebx]).Release, MedVed
    mov MedVed, 0

    @@:
    mov eax, VidWin
    cmp eax, 0
    je @F
    mov ebx, [eax]
    invoke (IVideoWindow PTR [ebx]).put_Visible, VidWin, 0
    invoke (IVideoWindow PTR [ebx]).Release, VidWin
    mov VidWin, 0
    
    @@:
    mov eax, Grabber
    cmp eax, 0
    je @F
    mov ebx, [eax]
    invoke (ISampleGrabber PTR [ebx]).Release, Grabber
    mov Grabber, 0
    
    @@:
    cmp GrabberF, 0
    je @F
    mov eax, Graph
    mov ebx,[eax]
    invoke (IGraphBuilder PTR [ebx]).RemoveFilter, Graph, GrabberF
    mov eax, GrabberF
    mov ebx, [eax]
    invoke (IBaseFilter PTR [ebx]).Release, GrabberF
    mov GrabberF, 0

    @@:
    cmp Src, 0
    je @F
    mov eax, Graph
    mov ebx,[eax]
    invoke (IGraphBuilder PTR [ebx]).RemoveFilter, Graph, Src
    mov eax, Src
    mov ebx, [eax]
    invoke (IGraphBuilder PTR [ebx]).Release, Src
    mov Src, 0

    @@:
    cmp Src_Audio, 0
    je @F
    mov eax, Graph
    mov ebx,[eax]
    invoke (IGraphBuilder PTR [ebx]).RemoveFilter, Graph, Src_Audio
    mov eax, Src_Audio
    mov ebx, [eax]
    invoke (IGraphBuilder PTR [ebx]).Release, Src_Audio
    mov Src_Audio, 0

    @@:
    mov eax, Builder
    cmp eax, 0
    je @F
    mov ebx, [eax]
    invoke (ICaptureGraphBuilder2 PTR [ebx]).Release, Builder
    mov Builder, 0
    
    @@:
    mov eax, Graph
    cmp eax, 0
    je @F
    mov ebx, [eax]
    invoke (IGraphBuilder PTR [ebx]).Release, Graph
    mov Graph, 0
    
    @@:
    invoke SetWindowLong, hWin, 8,  0
    invoke SetWindowLong, hWin, 44, 0
    invoke SetWindowLong, hWin, 12, 0
    invoke SetWindowLong, hWin, 20, 0
    invoke SetWindowLong, hWin, 24, 0
    invoke SetWindowLong, hWin, 124, 0
    invoke SetWindowLong, hWin, 16, 0
    invoke SetWindowLong, hWin, 32, 0
    invoke SetWindowLong, hWin, 28, 0
    invoke SetWindowLong, hWin, 128, 0
    invoke SetWindowLong, hWin, 132, 0
ret
release_graph endp
;**********************************************************************************************************************************************************

