; Author:            7ya
; Update date:       26.04.2017
; Contact:           7ya@protonmail.com
; Internet address:  https://github.com/7ya/win_asm_webcam32.dll
; License:           GPL-3.0
;------------------------------------------------------------------------------
PINDIR_INPUT                dd 0
PINDIR_OUTPUT               dd 1
VideoControlFlag_FlipHorizontal         dd 01h
VideoControlFlag_FlipVertical           dd 02h
VideoControlFlag_ExternalTriggerEnable  dd 04h
VideoControlFlag_Trigger                dd 08h

IID_IRunningObjectTable         GUID <000000010h,00000h,00000h,<0c0h,000h,000h,000h,000h,000h,000h,046h>>
IID_IBindCtx                    GUID <00000000eh,00000h,00000h,<0c0h,000h,000h,000h,000h,000h,000h,046h>>
IID_IAMVideoControl             GUID <06a2e0670h,028e4h,011d0h,<0a1h,08ch,000h,0a0h,0c9h,011h,089h,056h>>
IID_IMediaEventEx               GUID <056a868c0h,00ad4h,011ceh,<0b0h,03ah,000h,020h,0afh,00bh,0a7h,070h>>
IID_IPersistMediaPropertyBag    GUID <05738E040h,0B67Fh,011d0h,<0BDh,04Dh,000h,0A0h,0C9h,011h,0CEh,086h>>
IID_IMoniker                    GUID <00000000fh,00000h,00000h,<0C0h,000h,000h,000h,000h,000h,000h,046h>> 
IID_IMediaControl               GUID <056A868B1h,00AD4h,011CEh,<0B0h,03Ah,000h,020h,0AFh,00Bh,0A7h,070h>>
IID_IVideoWindow                GUID <056A868b4h,00AD4h,011CEh,<0B0h,03Ah,000h,020h,0AFh,00Bh,0A7h,070h>>
IID_IPropertyBag                GUID <055272A00h,042CBh,011CEh,<081h,035h,000h,0AAh,000h,04Bh,0B8h,051h>>
IID_IPropertyBag2               GUID <022F55882h,0280Bh,011d0h,<0A8h,0A9h,000h,0A0h,0C9h,00Ch,020h,004h>>
IID_IPropertyPage               GUID <0B196B28Dh,0BAB4h,0101Ah,<0B6h,09Ch,000h,0AAh,000h,034h,01Dh,007h>>
IID_ISpecifyPropertyPages       GUID <0B196B28Bh,0BAB4h,0101Ah,<0B6h,09Ch,000h,0AAh,000h,034h,01Dh,007h>>
IID_IAMStreamConfig             GUID <0C6E13340h,030ACh,011D0h,<0A1h,08Ch,000h,0A0h,0C9h,011h,089h,056h>>
IID_IConfigAviMux               GUID <05ACD6AA0h,0F482h,011CEh,<08Bh,067h,000h,0AAh,000h,0A3h,0F1h,0A6h>>
IID_IConfigAsfWriter            GUID <045086030h,0F7E4h,0486Ah,<0B5h,004h,082h,06Bh,0B5h,079h,02Ah,03Bh>>
IID_IWMProfile                  GUID <096406bdbh,02b2bh,011d3h,<0b3h,06bh,000h,0c0h,04fh,061h,008h,0ffh>>
IID_IWMStreamConfig             GUID <096406bdch,02b2bh,011d3h,<0b3h,06bh,000h,0c0h,04fh,061h,008h,0ffh>>
IID_IWMVideoMediaProps          GUID <096406bcfh,02b2bh,011d3h,<0b3h,06bh,000h,0c0h,04fh,061h,008h,0ffh>>
IID_IWMMediaProps               GUID <096406bceh,02b2bh,011d3h,<0b3h,06bh,000h,0c0h,04fh,061h,008h,0ffh>>

MEDIATYPE_Video                 GUID <073646976h,00000h,00010h,<080h,000h,000h,0AAh,000h,038h,09Bh,071h>>
MEDIATYPE_Audio                 GUID <073647561h,00000h,00010h,<080h,000h,000h,0AAh,000h,038h,09Bh,071h>>
MEDIATYPE_Interleaved           GUID <073766169h,00000h,00010h,<080h,000h,000h,0AAh,000h,038h,09Bh,071h>>
MEDIASUBTYPE_Avi                GUID <0E436EB88h,0524Fh,011CEh,<09Fh,053h,000h,020h,0AFh,00Bh,0A7h,070h>>
MEDIASUBTYPE_Asf                GUID <03DB80F90h,09412h,011D1h,<0ADh,0EDh,000h,000h,0F8h,075h,04Bh,099h>>
PIN_CATEGORY_STILL              GUID <0fb6c428ah,00353h,011d1h,<090h,05fh,000h,000h,0c0h,0cch,016h,0bah>>
PIN_CATEGORY_PREVIEW            GUID <0FB6C4282h,00353h,011D1h,<090h,05Fh,000h,000h,0C0h,0CCh,016h,0BAh>>
PIN_CATEGORY_CAPTURE            GUID <0FB6C4281h,00353h,011D1h,<090h,05Fh,000h,000h,0C0h,0CCh,016h,0BAh>>
CLSID_NullRenderer              GUID <0c1f400a4h,03f08h,011d3h,<09fh,00bh,000h,060h,008h,003h,09eh,037h>>
CLSID_SampleGrabber             GUID <0c1f400a0h,03f08h,011d3h,<09fh,00bh,000h,060h,008h,003h,09eh,037h>>
IID_ISampleGrabber              GUID <06b652fffh,011feh,04fceh,<092h,0adh,002h,066h,0b5h,0d7h,0c7h,08fh>>
IID_ISampleGrabberCB            GUID <00579154ah,02b53h,04994h,<0b0h,0d0h,0e7h,073h,014h,08eh,0ffh,085h>>
FORMAT_VideoInfo                GUID <005589f80h,0c356h,011ceh,<0bfh,001h,000h,0aah,000h,055h,059h,05ah>>
MEDIASUBTYPE_RGB24              GUID <0e436eb7dh,0524fh,011ceh,<09fh,053h,000h,020h,0afh,00bh,0a7h,070h>>
MEDIASUBTYPE_YUY2               GUID <032595559h,00000h,00010h,<080h,000h,000h,0aah,000h,038h,09bh,071h>>
MEDIASUBTYPE_MJPG               GUID <047504a4dh,00000h,00010h,<080h,000h,000h,0aah,000h,038h,09bh,071h>>

CLSID_FilterGraph               GUID <0E436EBB3h,0524Fh,011CEh,<09Fh,053h,000h,020h,0AFh,00Bh,0A7h,070h>>
IID_IFilterGraph2               GUID <036B73882h,0C2C8h,011CFh,<08Bh,046h,000h,080h,05Fh,06Ch,0EFh,060h>>
IID_IGraphBuilder               GUID <056A868A9h,00AD4h,011CEh,<0B0h,03Ah,000h,020h,0AFh,00Bh,0A7h,070h>>
CLSID_CaptureGraphBuilder2      GUID <0BF87B6E1h,08C27h,011d0h,<0B3h,0F0h,000h,0AAh,000h,037h,061h,0C5h>>
IID_ICaptureGraphBuilder2       GUID <093E5A4E0h,02D50h,011d2h,<0ABh,0FAh,000h,0A0h,0C9h,0C6h,0E3h,08Dh>>
CLSID_SystemDeviceEnum          GUID <062BE5D10h,060EBh,011d0h,<0BDh,03Bh,000h,0A0h,0C9h,011h,0CEh,086h>>
IID_ICreateDevEnum              GUID <029840822h,05B84h,011D0h,<0BDh,03Bh,000h,0A0h,0C9h,011h,0CEh,086h>>
CLSID_VideoInputDeviceCategory  GUID <0860BB310h,05D01h,011d0h,<0BDh,03Bh,000h,0A0h,0C9h,011h,0CEh,086h>>
CLSID_AudioInputDeviceCategory  GUID <033D9A762h,090C8h,011D0h,<0BDh,043h,000h,0A0h,0C9h,011h,0CEh,086h>>
IID_IBaseFilter                 GUID <056A86895h,00AD4h,011CEh,<0B0h,03Ah,000h,020h,0AFh,00Bh,0A7h,070h>>
CLSID_CaptureGraphBuilder       GUID <0BF87B6E0h,08C27h,011D0h,<0B3h,0F0h,000h,0AAh,000h,037h,061h,0C5h>>
IID_ICaptureGraphBuilder        GUID <0BF87B6E0h,08C27h,011D0h,<0B3h,0F0h,000h,0AAh,000h,037h,061h,0C5h>>
;------------------------------------------------------------------------------
IWMMediaProps_QueryInterfaceProto                        typedef PROTO :DWORD,:DWORD,:DWORD
IWMMediaProps_QueryInterface                             typedef ptr IWMMediaProps_QueryInterfaceProto
IWMMediaProps_AddRefProto                                typedef PROTO :DWORD
IWMMediaProps_AddRef                                     typedef ptr IWMMediaProps_AddRefProto
IWMMediaProps_ReleaseProto                               typedef PROTO :DWORD
IWMMediaProps_Release                                    typedef ptr IWMMediaProps_ReleaseProto
IWMMediaProps_GetTypeProto                               typedef PROTO :DWORD,:DWORD
IWMMediaProps_GetType                                    typedef ptr IWMMediaProps_GetTypeProto
IWMMediaProps_GetMediaTypeProto                          typedef PROTO :DWORD,:DWORD,:DWORD
IWMMediaProps_GetMediaType                               typedef ptr IWMMediaProps_GetMediaTypeProto
IWMMediaProps_SetMediaTypeProto                          typedef PROTO :DWORD,:DWORD
IWMMediaProps_SetMediaType                               typedef ptr IWMMediaProps_SetMediaTypeProto
IWMMediaProps STRUCT DWORD
QueryInterface                                      IWMMediaProps_QueryInterface                     ?
AddRef                                              IWMMediaProps_AddRef                             ?
Release                                             IWMMediaProps_Release                            ?
GetType                                             IWMMediaProps_GetType                            ?
GetMediaType                                        IWMMediaProps_GetMediaType                       ?
SetMediaType                                        IWMMediaProps_SetMediaType                       ?
IWMMediaProps ENDS
;------------------------------------------------------------------------------
IWMStreamConfig_QueryInterfaceProto                        typedef PROTO :DWORD,:DWORD,:DWORD
IWMStreamConfig_QueryInterface                             typedef ptr IWMStreamConfig_QueryInterfaceProto
IWMStreamConfig_AddRefProto                                typedef PROTO :DWORD
IWMStreamConfig_AddRef                                     typedef ptr IWMStreamConfig_AddRefProto
IWMStreamConfig_ReleaseProto                               typedef PROTO :DWORD
IWMStreamConfig_Release                                    typedef ptr IWMStreamConfig_ReleaseProto
IWMStreamConfig_GetStreamTypeProto                         typedef PROTO :DWORD,:DWORD
IWMStreamConfig_GetStreamType                              typedef ptr IWMStreamConfig_GetStreamTypeProto
IWMStreamConfig_GetStreamNumberProto                       typedef PROTO :DWORD,:DWORD
IWMStreamConfig_GetStreamNumber                            typedef ptr IWMStreamConfig_GetStreamNumberProto
IWMStreamConfig_SetStreamNumberProto                       typedef PROTO :DWORD,:DWORD
IWMStreamConfig_SetStreamNumber                            typedef ptr IWMStreamConfig_SetStreamNumberProto
IWMStreamConfig_GetStreamNameProto                         typedef PROTO :DWORD,:DWORD,:DWORD
IWMStreamConfig_GetStreamName                              typedef ptr IWMStreamConfig_GetStreamNameProto
IWMStreamConfig_SetStreamNameProto                         typedef PROTO :DWORD,:DWORD
IWMStreamConfig_SetStreamName                              typedef ptr IWMStreamConfig_SetStreamNameProto
IWMStreamConfig_GetConnectionNameProto                     typedef PROTO :DWORD,:DWORD,:DWORD
IWMStreamConfig_GetConnectionName                          typedef ptr IWMStreamConfig_GetConnectionNameProto
IWMStreamConfig_SetConnectionNameProto                     typedef PROTO :DWORD,:DWORD
IWMStreamConfig_SetConnectionName                          typedef ptr IWMStreamConfig_SetConnectionNameProto
IWMStreamConfig_GetBitrateProto                            typedef PROTO :DWORD,:DWORD
IWMStreamConfig_GetBitrate                                 typedef ptr IWMStreamConfig_GetBitrateProto
IWMStreamConfig_SetBitrateProto                            typedef PROTO :DWORD,:DWORD
IWMStreamConfig_SetBitrate                                 typedef ptr IWMStreamConfig_SetBitrateProto
IWMStreamConfig_GetBufferWindowProto                       typedef PROTO :DWORD,:DWORD
IWMStreamConfig_GetBufferWindow                            typedef ptr IWMStreamConfig_GetBufferWindowProto
IWMStreamConfig_SetBufferWindowProto                       typedef PROTO :DWORD,:DWORD
IWMStreamConfig_SetBufferWindow                            typedef ptr IWMStreamConfig_SetBufferWindowProto
IWMStreamConfig STRUCT DWORD
QueryInterface                                      IWMStreamConfig_QueryInterface                     ?
AddRef                                              IWMStreamConfig_AddRef                             ?
Release                                             IWMStreamConfig_Release                            ?
GetStreamType                                       IWMStreamConfig_GetStreamType                      ?
GetStreamNumber                                     IWMStreamConfig_GetStreamNumber                    ?
SetStreamNumber                                     IWMStreamConfig_SetStreamNumber                    ?
GetStreamName                                       IWMStreamConfig_GetStreamName                      ?
SetStreamName                                       IWMStreamConfig_SetStreamName                      ?
GetConnectionName                                   IWMStreamConfig_GetConnectionName                  ?
SetConnectionName                                   IWMStreamConfig_SetConnectionName                  ?
GetBitrate                                          IWMStreamConfig_GetBitrate                         ?
SetBitrate                                          IWMStreamConfig_SetBitrate                         ?
GetBufferWindow                                     IWMStreamConfig_GetBufferWindow                    ?
SetBufferWindow                                     IWMStreamConfig_SetBufferWindow                    ?
IWMStreamConfig ENDS
; -------------------------------------------------------------------------
IWMProfile_QueryInterfaceProto                        typedef PROTO :DWORD,:DWORD,:DWORD
IWMProfile_QueryInterface                             typedef ptr IWMProfile_QueryInterfaceProto
IWMProfile_AddRefProto                                typedef PROTO :DWORD
IWMProfile_AddRef                                     typedef ptr IWMProfile_AddRefProto
IWMProfile_ReleaseProto                               typedef PROTO :DWORD
IWMProfile_Release                                    typedef ptr IWMProfile_ReleaseProto
IWMProfile_GetVersionProto                            typedef PROTO :DWORD,:DWORD
IWMProfile_GetVersion                                 typedef ptr IWMProfile_GetVersionProto
IWMProfile_GetNameProto                               typedef PROTO :DWORD,:DWORD,:DWORD
IWMProfile_GetName                                    typedef ptr IWMProfile_GetNameProto
IWMProfile_SetNameProto                               typedef PROTO :DWORD,:DWORD
IWMProfile_SetName                                    typedef ptr IWMProfile_SetNameProto
IWMProfile_GetDescriptionProto                        typedef PROTO :DWORD,:DWORD,:DWORD
IWMProfile_GetDescription                             typedef ptr IWMProfile_GetDescriptionProto
IWMProfile_SetDescriptionProto                        typedef PROTO :DWORD,:DWORD
IWMProfile_SetDescription                             typedef ptr IWMProfile_SetDescriptionProto
IWMProfile_GetStreamCountProto                        typedef PROTO :DWORD,:DWORD
IWMProfile_GetStreamCount                             typedef ptr IWMProfile_GetStreamCountProto
IWMProfile_GetStreamProto                             typedef PROTO :DWORD,:DWORD,:DWORD
IWMProfile_GetStream                                  typedef ptr IWMProfile_GetStreamProto
IWMProfile_GetStreamByNumberProto                     typedef PROTO :DWORD,:DWORD,:DWORD
IWMProfile_GetStreamByNumber                          typedef ptr IWMProfile_GetStreamByNumberProto
IWMProfile_RemoveStreamProto                          typedef PROTO :DWORD,:DWORD
IWMProfile_RemoveStream                               typedef ptr IWMProfile_RemoveStreamProto
IWMProfile_RemoveStreamByNumberProto                  typedef PROTO :DWORD,:DWORD
IWMProfile_RemoveStreamByNumber                       typedef ptr IWMProfile_RemoveStreamByNumberProto
IWMProfile_AddStreamProto                             typedef PROTO :DWORD,:DWORD
IWMProfile_AddStream                                  typedef ptr IWMProfile_AddStreamProto
IWMProfile_ReconfigStreamProto                        typedef PROTO :DWORD,:DWORD
IWMProfile_ReconfigStream                             typedef ptr IWMProfile_ReconfigStreamProto
IWMProfile_CreateNewStreamProto                       typedef PROTO :DWORD,:DWORD,:DWORD
IWMProfile_CreateNewStream                            typedef ptr IWMProfile_CreateNewStreamProto
IWMProfile_GetMutualExclusionCountProto               typedef PROTO :DWORD,:DWORD
IWMProfile_GetMutualExclusionCount                    typedef ptr IWMProfile_GetMutualExclusionCountProto
IWMProfile_GetMutualExclusionProto                    typedef PROTO :DWORD,:DWORD,:DWORD
IWMProfile_GetMutualExclusion                         typedef ptr IWMProfile_GetMutualExclusionProto
IWMProfile_RemoveMutualExclusionProto                 typedef PROTO :DWORD,:DWORD
IWMProfile_RemoveMutualExclusion                      typedef ptr IWMProfile_RemoveMutualExclusionProto
IWMProfile_AddMutualExclusionProto                    typedef PROTO :DWORD,:DWORD
IWMProfile_AddMutualExclusion                         typedef ptr IWMProfile_AddMutualExclusionProto
IWMProfile_CreateNewMutualExclusionProto              typedef PROTO :DWORD,:DWORD
IWMProfile_CreateNewMutualExclusion                   typedef ptr IWMProfile_CreateNewMutualExclusionProto
IWMProfile STRUCT DWORD
QueryInterface                                      IWMProfile_QueryInterface                     ?
AddRef                                              IWMProfile_AddRef                             ?
Release                                             IWMProfile_Release                            ?
GetVersion                                          IWMProfile_GetVersion                         ?
GetName                                             IWMProfile_GetName                            ?
SetName                                             IWMProfile_SetName                            ?
GetDescription                                      IWMProfile_GetDescription                     ?
SetDescription                                      IWMProfile_SetDescription                     ?
GetStreamCount                                      IWMProfile_GetStreamCount                     ?
GetStream                                           IWMProfile_GetStream                          ?
GetStreamByNumber                                   IWMProfile_GetStreamByNumber                  ?
RemoveStream                                        IWMProfile_RemoveStream                       ?
RemoveStreamByNumber                                IWMProfile_RemoveStreamByNumber               ?
AddStream                                           IWMProfile_AddStream                          ?
ReconfigStream                                      IWMProfile_ReconfigStream                     ?
CreateNewStream                                     IWMProfile_CreateNewStream                    ?
GetMutualExclusionCount                             IWMProfile_GetMutualExclusionCount            ?
GetMutualExclusion                                  IWMProfile_GetMutualExclusion                 ?
RemoveMutualExclusion                               IWMProfile_RemoveMutualExclusion              ?
AddMutualExclusion                                  IWMProfile_AddMutualExclusion                 ?
CreateNewMutualExclusion                            IWMProfile_CreateNewMutualExclusion           ?
IWMProfile ENDS
; -------------------------------------------------------------------------
IConfigAsfWriter_QueryInterfaceProto                        typedef PROTO :DWORD,:DWORD,:DWORD
IConfigAsfWriter_QueryInterface                             typedef ptr IConfigAsfWriter_QueryInterfaceProto
IConfigAsfWriter_AddRefProto                                typedef PROTO :DWORD
IConfigAsfWriter_AddRef                                     typedef ptr IConfigAsfWriter_AddRefProto
IConfigAsfWriter_ReleaseProto                               typedef PROTO :DWORD
IConfigAsfWriter_Release                                    typedef ptr IConfigAsfWriter_ReleaseProto
IConfigAsfWriter_ConfigureFilterUsingProfileIdProto         typedef PROTO :DWORD,:DWORD
IConfigAsfWriter_ConfigureFilterUsingProfileId              typedef ptr IConfigAsfWriter_ConfigureFilterUsingProfileIdProto
IConfigAsfWriter_GetCurrentProfileIdProto                   typedef PROTO :DWORD,:DWORD
IConfigAsfWriter_GetCurrentProfileId                        typedef ptr IConfigAsfWriter_GetCurrentProfileIdProto
IConfigAsfWriter_ConfigureFilterUsingProfileGuidProto       typedef PROTO :DWORD,:DWORD
IConfigAsfWriter_ConfigureFilterUsingProfileGuid            typedef ptr IConfigAsfWriter_ConfigureFilterUsingProfileGuidProto
IConfigAsfWriter_GetCurrentProfileGuidProto                 typedef PROTO :DWORD,:DWORD
IConfigAsfWriter_GetCurrentProfileGuid                      typedef ptr IConfigAsfWriter_GetCurrentProfileGuidProto
IConfigAsfWriter_ConfigureFilterUsingProfileProto           typedef PROTO :DWORD,:DWORD
IConfigAsfWriter_ConfigureFilterUsingProfile                typedef ptr IConfigAsfWriter_ConfigureFilterUsingProfileProto
IConfigAsfWriter_GetCurrentProfileProto                     typedef PROTO :DWORD,:DWORD
IConfigAsfWriter_GetCurrentProfile                          typedef ptr IConfigAsfWriter_GetCurrentProfileProto
IConfigAsfWriter_SetIndexModeProto                          typedef PROTO :DWORD,:DWORD
IConfigAsfWriter_SetIndexMode                               typedef ptr IConfigAsfWriter_SetIndexModeProto
IConfigAsfWriter_GetIndexModeProto                          typedef PROTO :DWORD,:DWORD
IConfigAsfWriter_GetIndexMode                               typedef ptr IConfigAsfWriter_GetIndexModeProto
IConfigAsfWriter STRUCT DWORD
QueryInterface                                      IConfigAsfWriter_QueryInterface                     ?
AddRef                                              IConfigAsfWriter_AddRef                             ?
Release                                             IConfigAsfWriter_Release                            ?
ConfigureFilterUsingProfileId                       IConfigAsfWriter_ConfigureFilterUsingProfileId      ?
GetCurrentProfileId                                 IConfigAsfWriter_GetCurrentProfileId                ?
ConfigureFilterUsingProfileGuid                     IConfigAsfWriter_ConfigureFilterUsingProfileGuid    ?
GetCurrentProfileGuid                               IConfigAsfWriter_GetCurrentProfileGuid              ?
ConfigureFilterUsingProfile                         IConfigAsfWriter_ConfigureFilterUsingProfile        ?
GetCurrentProfile                                   IConfigAsfWriter_GetCurrentProfile                  ?
SetIndexMode                                        IConfigAsfWriter_SetIndexMode                       ?
GetIndexMode                                        IConfigAsfWriter_GetIndexMode                       ?
IConfigAsfWriter ENDS
; -------------------------------------------------------------------------
IFileSinkFilter_QueryInterfaceProto                       typedef PROTO :DWORD,:DWORD,:DWORD
IFileSinkFilter_QueryInterface                            typedef ptr IFileSinkFilter_QueryInterfaceProto
IFileSinkFilter_AddRefProto                               typedef PROTO :DWORD
IFileSinkFilter_AddRef                                    typedef ptr IFileSinkFilter_AddRefProto
IFileSinkFilter_ReleaseProto                              typedef PROTO :DWORD
IFileSinkFilter_Release                                   typedef ptr IFileSinkFilter_ReleaseProto
IFileSinkFilter_SetFileNameProto                          typedef PROTO :DWORD,:DWORD,:DWORD
IFileSinkFilter_SetFileName                               typedef ptr IFileSinkFilter_SetFileNameProto
IFileSinkFilter_GetCurFileProto                           typedef PROTO :DWORD,:DWORD,:DWORD
IFileSinkFilter_GetCurFile                                typedef ptr IFileSinkFilter_GetCurFileProto
IFileSinkFilter STRUCT DWORD
QueryInterface                                      IFileSinkFilter_QueryInterface                     ?
AddRef                                              IFileSinkFilter_AddRef                             ?
Release                                             IFileSinkFilter_Release                            ?
SetFileName                                         IFileSinkFilter_SetFileName                        ?
GetCurFile                                          IFileSinkFilter_GetCurFile                         ?
IFileSinkFilter ENDS
;------------------------------------------------------------------------------
IUnknown_QueryInterfaceProto                        typedef PROTO :DWORD,:DWORD,:DWORD
IUnknown_AddRefProto                                typedef PROTO :DWORD
IUnknown_ReleaseProto                               typedef PROTO :DWORD
IUnknown_QueryInterface                             typedef ptr IUnknown_QueryInterfaceProto
IUnknown_AddRef                                     typedef ptr IUnknown_AddRefProto
IUnknown_Release                                    typedef ptr IUnknown_ReleaseProto
IUnknown STRUCT DWORD
QueryInterface                                      IUnknown_QueryInterface                     ?
AddRef                                              IUnknown_AddRef                             ?
Release                                             IUnknown_Release                            ?
IUnknown ENDS
; -------------------------------------------------------------------------
IRunningObjectTable_QueryInterfaceProto             typedef PROTO :DWORD,:DWORD,:DWORD
IRunningObjectTable_QueryInterface                  typedef ptr IRunningObjectTable_QueryInterfaceProto
IRunningObjectTable_AddRefProto                     typedef PROTO :DWORD
IRunningObjectTable_AddRef                          typedef ptr IRunningObjectTable_AddRefProto
IRunningObjectTable_ReleaseProto                    typedef PROTO :DWORD
IRunningObjectTable_Release                         typedef ptr IRunningObjectTable_ReleaseProto
IRunningObjectTable_RegisterProto                   typedef PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IRunningObjectTable_Register                        typedef ptr IRunningObjectTable_RegisterProto
IRunningObjectTable_RevokeProto                     typedef PROTO :DWORD,:DWORD
IRunningObjectTable_Revoke                          typedef ptr IRunningObjectTable_RevokeProto
IRunningObjectTable_IsRunningProto                  typedef PROTO :DWORD,:DWORD
IRunningObjectTable_IsRunning                       typedef ptr IRunningObjectTable_IsRunningProto
IRunningObjectTable_GetObjectProto                  typedef PROTO :DWORD,:DWORD,:DWORD
IRunningObjectTable_GetObject                       typedef ptr IRunningObjectTable_GetObjectProto
IRunningObjectTable_NoteChangeTimeProto             typedef PROTO :DWORD,:DWORD,:DWORD
IRunningObjectTable_NoteChangeTime                  typedef ptr IRunningObjectTable_NoteChangeTimeProto
IRunningObjectTable_GetTimeOfLastChangeProto        typedef PROTO :DWORD,:DWORD,:DWORD
IRunningObjectTable_GetTimeOfLastChange             typedef ptr IRunningObjectTable_GetTimeOfLastChangeProto
IRunningObjectTable_EnumRunningProto                typedef PROTO :DWORD,:DWORD
IRunningObjectTable_EnumRunning                     typedef ptr IRunningObjectTable_EnumRunningProto
IRunningObjectTable STRUCT DWORD
QueryInterface                                      IRunningObjectTable_QueryInterface              ?
AddRef                                              IRunningObjectTable_AddRef                      ?
Release                                             IRunningObjectTable_Release                     ?
Register                                            IRunningObjectTable_Register                    ?
Revoke                                              IRunningObjectTable_Revoke                      ?
IsRunning                                           IRunningObjectTable_IsRunning                   ?
GetObject                                           IRunningObjectTable_GetObject                   ?
NoteChangeTime                                      IRunningObjectTable_NoteChangeTime              ?
GetTimeOfLastChange                                 IRunningObjectTable_GetTimeOfLastChange         ?
EnumRunning                                         IRunningObjectTable_EnumRunning                 ?
IRunningObjectTable ENDS
; -------------------------------------------------------------------------
IBindCtx_QueryInterfaceProto                                 typedef PROTO :DWORD,:DWORD,:DWORD
IBindCtx_QueryInterface                                      typedef ptr IBindCtx_QueryInterfaceProto
IBindCtx_AddRefProto                                         typedef PROTO :DWORD
IBindCtx_AddRef                                              typedef ptr IBindCtx_AddRefProto
IBindCtx_ReleaseProto                                        typedef PROTO :DWORD
IBindCtx_Release                                             typedef ptr IBindCtx_ReleaseProto
IBindCtx_RegisterObjectBoundProto                            typedef PROTO :DWORD,:DWORD
IBindCtx_RegisterObjectBound                                 typedef ptr IBindCtx_RegisterObjectBoundProto
IBindCtx_RevokeObjectBoundProto                              typedef PROTO :DWORD,:DWORD
IBindCtx_RevokeObjectBound                                   typedef ptr IBindCtx_RevokeObjectBoundProto
IBindCtx_ReleaseBoundObjectsProto                            typedef PROTO :DWORD
IBindCtx_ReleaseBoundObjects                                 typedef ptr IBindCtx_ReleaseBoundObjectsProto
IBindCtx_SetBindOptionsProto                                 typedef PROTO :DWORD,:DWORD
IBindCtx_SetBindOptions                                      typedef ptr IBindCtx_SetBindOptionsProto
IBindCtx_GetBindOptionsProto                                 typedef PROTO :DWORD,:DWORD
IBindCtx_GetBindOptions                                      typedef ptr IBindCtx_GetBindOptionsProto
IBindCtx_GetRunningObjectTableProto                          typedef PROTO :DWORD,:DWORD
IBindCtx_GetRunningObjectTable                               typedef ptr IBindCtx_GetRunningObjectTableProto
IBindCtx_RegisterObjectParamProto                            typedef PROTO :DWORD,:DWORD,:DWORD
IBindCtx_RegisterObjectParam                                 typedef ptr IBindCtx_RegisterObjectParamProto
IBindCtx_GetObjectParamProto                                 typedef PROTO :DWORD,:DWORD,:DWORD
IBindCtx_GetObjectParam                                      typedef ptr IBindCtx_GetObjectParamProto
IBindCtx_EnumObjectParamProto                                typedef PROTO :DWORD,:DWORD
IBindCtx_EnumObjectParam                                     typedef ptr IBindCtx_EnumObjectParamProto
IBindCtx_RevokeObjectParamProto                              typedef PROTO :DWORD,:DWORD
IBindCtx_RevokeObjectParam                                   typedef ptr IBindCtx_RevokeObjectParamProto
IBindCtx STRUCT DWORD
QueryInterface                                               IBindCtx_QueryInterface                     ?
AddRef                                                       IBindCtx_AddRef                             ?
Release                                                      IBindCtx_Release                            ?
RegisterObjectBound                                          IBindCtx_RegisterObjectBound                ?
RevokeObjectBound                                            IBindCtx_RevokeObjectBound                  ?
ReleaseBoundObjects                                          IBindCtx_ReleaseBoundObjects                ?
SetBindOptions                                               IBindCtx_SetBindOptions                     ?
GetBindOptions                                               IBindCtx_GetBindOptions                     ?
GetRunningObjectTable                                        IBindCtx_GetRunningObjectTable              ?
RegisterObjectParam                                          IBindCtx_RegisterObjectParam                ?
GetObjectParam                                               IBindCtx_GetObjectParam                     ?
EnumObjectParam                                              IBindCtx_EnumObjectParam                    ?
RevokeObjectParam                                            IBindCtx_RevokeObjectParam                  ?
IBindCtx ENDS
;------------------------------------------------------------------------------
IMediaSample_QueryInterfaceProto                   typedef  PROTO :DWORD,:DWORD,:DWORD
IMediaSample_QueryInterface                        typedef  ptr IMediaSample_QueryInterfaceProto
IMediaSample_AddRefProto                           typedef  PROTO :DWORD
IMediaSample_AddRef                                typedef  ptr IMediaSample_AddRefProto
IMediaSample_ReleaseProto                          typedef  PROTO :DWORD
IMediaSample_Release                               typedef  ptr IMediaSample_ReleaseProto
IMediaSample_GetPointerProto                       typedef  PROTO :DWORD
IMediaSample_GetPointer                            typedef  ptr IMediaSample_GetPointerProto
IMediaSample_GetSizeProto                          typedef  PROTO
IMediaSample_GetSize                               typedef  ptr IMediaSample_GetSizeProto
IMediaSample_GetActualDataLengthProto              typedef  PROTO
IMediaSample_GetActualDataLength                   typedef  ptr IMediaSample_GetActualDataLengthProto
IMediaSample STRUCT DWORD
QueryInterface                                     IMediaSample_QueryInterface               ?
AddRef                                             IMediaSample_AddRef                       ?
Release                                            IMediaSample_Release                      ?
GetPointer                                         IMediaSample_GetPointer                   ?
GetSize                                            IMediaSample_GetSize                      ?
GetActualDataLength                                IMediaSample_GetActualDataLength          ?
IMediaSample ENDS
;не закончена
;------------------------------------------------------------------------------
IMediaEvent_QueryInterfaceProto                typedef  PROTO :DWORD,:DWORD,:DWORD,:DWORD
IMediaEvent_QueryInterface                     typedef  ptr IMediaEvent_QueryInterfaceProto
IMediaEvent_GetTypeInfoCountProto              typedef  PROTO :DWORD,:DWORD
IMediaEvent_GetTypeInfoCount                   typedef  ptr IMediaEvent_GetTypeInfoCountProto
IMediaEvent_GetTypeInfoProto                   typedef  PROTO :DWORD,:DWORD,:DWORD,:DWORD
IMediaEvent_GetTypeInfo                        typedef  ptr IMediaEvent_GetTypeInfoProto
IMediaEvent_AddRefProto                        typedef  PROTO :DWORD
IMediaEvent_AddRef                             typedef  ptr IMediaEvent_AddRefProto
IMediaEvent_ReleaseProto                       typedef  PROTO :DWORD
IMediaEvent_Release                            typedef  ptr IMediaEvent_ReleaseProto
IMediaEvent_GetIDsOfNamesProto                 typedef  PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IMediaEvent_GetIDsOfNames                      typedef  ptr IMediaEvent_GetIDsOfNamesProto
IMediaEvent_QInvokeProto                       typedef  PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IMediaEvent_QInvoke                            typedef  ptr IMediaEvent_QInvokeProto
IMediaEvent_GetEventHandleProto                typedef  PROTO :DWORD,:DWORD
IMediaEvent_GetEventHandle                     typedef  ptr IMediaEvent_GetEventHandleProto
IMediaEvent_GetEventProto                      typedef  PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IMediaEvent_GetEvent                           typedef  ptr IMediaEvent_GetEventProto
IMediaEvent_WaitForCompletionProto             typedef  PROTO :DWORD,:DWORD,:DWORD
IMediaEvent_WaitForCompletion                  typedef  ptr IMediaEvent_WaitForCompletionProto
IMediaEvent_CancelDefaultHandlingProto         typedef  PROTO :DWORD,:DWORD
IMediaEvent_CancelDefaultHandling              typedef  ptr IMediaEvent_CancelDefaultHandlingProto
IMediaEvent_RestoreDefaultHandlingProto        typedef  PROTO :DWORD,:DWORD
IMediaEvent_RestoreDefaultHandling             typedef  ptr IMediaEvent_RestoreDefaultHandlingProto
IMediaEvent_FreeEventParamsProto               typedef  PROTO :DWORD,:DWORD,:DWORD,:DWORD
IMediaEvent_FreeEventParams                    typedef  ptr IMediaEvent_FreeEventParamsProto
IMediaEvent_SetNotifyWindowProto               typedef  PROTO :DWORD,:DWORD,:DWORD,:DWORD
IMediaEvent_SetNotifyWindow                    typedef  ptr IMediaEvent_SetNotifyWindowProto
IMediaEvent_SetNotifyFlagsProto                typedef  PROTO :DWORD,:DWORD
IMediaEvent_SetNotifyFlags                     typedef  ptr IMediaEvent_SetNotifyFlagsProto
IMediaEvent_GetNotifyFlagsProto                typedef  PROTO :DWORD,:DWORD
IMediaEvent_GetNotifyFlags                     typedef  ptr IMediaEvent_GetNotifyFlagsProto
IMediaEvent STRUCT DWORD
QueryInterface                                             IMediaEvent_QueryInterface              ?
AddRef                                                     IMediaEvent_AddRef                      ?
Release                                                    IMediaEvent_Release                     ?
GetTypeInfoCount                                           IMediaEvent_GetTypeInfoCount            ?
GetTypeInfo                                                IMediaEvent_GetTypeInfo                 ?
GetIDsOfNames                                              IMediaEvent_GetIDsOfNames               ?
QInvoke                                                    IMediaEvent_QInvoke                     ?
GetEventHandle                                             IMediaEvent_GetEventHandle              ?
GetEvent                                                   IMediaEvent_GetEvent                    ?
WaitForCompletion                                          IMediaEvent_WaitForCompletion           ?
CancelDefaultHandling                                      IMediaEvent_CancelDefaultHandling       ?
RestoreDefaultHandling                                     IMediaEvent_RestoreDefaultHandling      ?
FreeEventParams                                            IMediaEvent_FreeEventParams             ?
SetNotifyWindow                                            IMediaEvent_SetNotifyWindow             ?
SetNotifyFlags                                             IMediaEvent_SetNotifyFlags              ?
GetNotifyFlags                                             IMediaEvent_GetNotifyFlags              ?
IMediaEvent ENDS
;------------------------------------------------------------------------------
ISampleGrabberCB_QueryInterfaceProto                       typedef PROTO :DWORD,:DWORD,:DWORD
ISampleGrabberCB_QueryInterface                            typedef ptr ISampleGrabberCB_QueryInterfaceProto
ISampleGrabberCB_AddRefProto                               typedef PROTO :DWORD
ISampleGrabberCB_AddRef                                    typedef ptr ISampleGrabberCB_AddRefProto
ISampleGrabberCB_ReleaseProto                              typedef PROTO :DWORD
ISampleGrabberCB_Release                                   typedef ptr ISampleGrabberCB_ReleaseProto
ISampleGrabberCB_SampleCBProto                             typedef PROTO :DWORD,:DWORD,:DWORD
ISampleGrabberCB_SampleCB                                  typedef ptr ISampleGrabberCB_SampleCBProto
ISampleGrabberCB_BufferCBProto                             typedef PROTO :DWORD,:DWORD,:DWORD,:DWORD
ISampleGrabberCB_BufferCB                                  typedef ptr ISampleGrabberCB_BufferCBProto
ISampleGrabberCB STRUCT DWORD
QueryInterface                                             ISampleGrabberCB_QueryInterface                     ?
AddRef                                                     ISampleGrabberCB_AddRef                             ?
Release                                                    ISampleGrabberCB_Release                            ?
SampleCB                                                   ISampleGrabberCB_SampleCB                           ?
BufferCB                                                   ISampleGrabberCB_BufferCB                           ?
ISampleGrabberCB ENDS
; -------------------------------------------------------------------------
ISampleGrabber_QueryInterfaceProto                 typedef  PROTO :DWORD,:DWORD,:DWORD
ISampleGrabber_QueryInterface                      typedef  ptr ISampleGrabber_QueryInterfaceProto
ISampleGrabber_AddRefProto                         typedef  PROTO :DWORD
ISampleGrabber_AddRef                              typedef  ptr ISampleGrabber_AddRefProto
ISampleGrabber_ReleaseProto                        typedef  PROTO :DWORD
ISampleGrabber_Release                             typedef  ptr ISampleGrabber_ReleaseProto
ISampleGrabber_SetOneShotProto                     typedef  PROTO :DWORD,:DWORD
ISampleGrabber_SetOneShot                          typedef  ptr ISampleGrabber_SetOneShotProto
ISampleGrabber_SetMediaTypeProto                   typedef  PROTO :DWORD,:DWORD
ISampleGrabber_SetMediaType                        typedef  ptr ISampleGrabber_SetMediaTypeProto
ISampleGrabber_GetConnectedMediaTypeProto          typedef  PROTO :DWORD,:DWORD
ISampleGrabber_GetConnectedMediaType               typedef  ptr ISampleGrabber_GetConnectedMediaTypeProto
ISampleGrabber_SetBufferSamplesProto               typedef  PROTO :DWORD,:DWORD
ISampleGrabber_SetBufferSamples                    typedef  ptr ISampleGrabber_SetBufferSamplesProto
ISampleGrabber_GetCurrentBufferProto               typedef  PROTO :DWORD,:DWORD,:DWORD
ISampleGrabber_GetCurrentBuffer                    typedef  ptr ISampleGrabber_GetCurrentBufferProto
ISampleGrabber_GetCurrentSampleProto               typedef  PROTO :DWORD,:DWORD
ISampleGrabber_GetCurrentSample                    typedef  ptr ISampleGrabber_GetCurrentSampleProto
ISampleGrabber_SetCallbackProto                    typedef  PROTO :DWORD,:DWORD,:DWORD
ISampleGrabber_SetCallback                         typedef  ptr ISampleGrabber_SetCallbackProto
ISampleGrabber STRUCT DWORD
QueryInterface                                     ISampleGrabber_QueryInterface          ?
AddRef                                             ISampleGrabber_AddRef                  ?
Release                                            ISampleGrabber_Release                 ?
SetOneShot                                         ISampleGrabber_SetOneShot              ?
SetMediaType                                       ISampleGrabber_SetMediaType            ?
GetConnectedMediaType                              ISampleGrabber_GetConnectedMediaType   ?
SetBufferSamples                                   ISampleGrabber_SetBufferSamples        ?
GetCurrentBuffer                                   ISampleGrabber_GetCurrentBuffer        ?
GetCurrentSample                                   ISampleGrabber_GetCurrentSample        ?
SetCallback                                        ISampleGrabber_SetCallback             ?
ISampleGrabber ENDS
; -------------------------------------------------------------------------
IPersist_GetClassIDProto                           typedef PROTO :DWORD,:DWORD
IPersist_GetClassID                                typedef ptr IPersist_GetClassIDProto
IPersist STRUCT DWORD
QueryInterface                                     IUnknown_QueryInterface                     ?
AddRef                                             IUnknown_AddRef                             ?
Release                                            IUnknown_Release                            ?
GetClassID                                         IPersist_GetClassID                         ?
IPersist ENDS
; -------------------------------------------------------------------------
IPersistStream_GetClassIDProto                     typedef PROTO :DWORD,:DWORD
IPersistStream_GetClassID                          typedef ptr IPersistStram_GetClassIDProto
IPersistStream_IsDirtyProto                        typedef PROTO :DWORD
IPersistStream_IsDirty                             typedef ptr IPersistStream_IsDirtyProto
IPersistStream_LoadProto                           typedef PROTO :DWORD,:DWORD
IPersistStream_Load                                typedef ptr IPersistStream_LoadProto
IPersistStream_SaveProto                           typedef PROTO :DWORD,:DWORD,:DWORD
IPersistStream_Save                                typedef ptr IPersistStream_SaveProto
IPersistStream_GetSizeMaxProto                     typedef PROTO :DWORD,:DWORD
IPersistStream_GetSizeMax                          typedef ptr IPersistStream_GetSizeMaxProto
IPersistStream STRUCT DWORD
QueryInterface                                     IUnknown_QueryInterface                     ?
AddRef                                             IUnknown_AddRef                             ?
Release                                            IUnknown_Release                            ?
GetClassID                                         IPersistStream_GetClassID                   ?
IsDirty                                            IPersistStream_IsDirty                      ?
Load                                               IPersistStream_Load                         ?
Save                                               IPersistStream_Save                         ?
GetSizeMax                                         IPersistStream_GetSizeMax                   ?
IPersistStream ENDS
; -------------------------------------------------------------------------
IEnumMoniker_NextProto                             typedef PROTO :DWORD,:DWORD,:DWORD,:DWORD
IEnumMoniker_SkipProto                             typedef PROTO :DWORD,:DWORD
IEnumMoniker_ResetProto                            typedef PROTO :DWORD
IEnumMoniker_CloneProto                            typedef PROTO :DWORD,:DWORD
IEnumMoniker_Next                                  typedef ptr IEnumMoniker_NextProto
IEnumMoniker_Skip                                  typedef ptr IEnumMoniker_SkipProto
IEnumMoniker_Reset                                 typedef ptr IEnumMoniker_ResetProto
IEnumMoniker_Clone                                 typedef ptr IEnumMoniker_CloneProto
IEnumMoniker STRUCT DWORD
QueryInterface                                     IUnknown_QueryInterface                     ?
AddRef                                             IUnknown_AddRef                             ?
Release                                            IUnknown_Release                            ?
Next                                               IEnumMoniker_Next                           ?
Skip                                               IEnumMoniker_Skip                           ?
Reset                                              IEnumMoniker_Reset                          ?
Clone                                              IEnumMoniker_Clone                          ?
IEnumMoniker ENDS
; -------------------------------------------------------------------------
IMoniker_BindToObjectProto                         typedef PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IMoniker_BindToObject                              typedef ptr IMoniker_BindToObjectProto
IMoniker_BindToStorageProto                        typedef PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IMoniker_BindToStorage                             typedef ptr IMoniker_BindToStorageProto
IMoniker_ReduceProto                               typedef PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IMoniker_Reduce                                    typedef ptr IMoniker_ReduceProto
IMoniker_ComposeWithProto                          typedef PROTO :DWORD,:DWORD,:DWORD,:DWORD
IMoniker_ComposeWith                               typedef ptr IMoniker_ComposeWithProto
IMoniker_EnumProto                                 typedef PROTO :DWORD,:DWORD,:DWORD
IMoniker_Enum                                      typedef ptr IMoniker_EnumProto
IMoniker_IsEqualProto                              typedef PROTO :DWORD,:DWORD
IMoniker_IsEqual                                   typedef ptr IMoniker_IsEqualProto
IMoniker_HashProto                                 typedef PROTO :DWORD,:DWORD
IMoniker_Hash                                      typedef ptr IMoniker_HashProto
IMoniker_IsRunningProto                            typedef PROTO :DWORD,:DWORD,:DWORD,:DWORD
IMoniker_IsRunning                                 typedef ptr IMoniker_IsRunningProto
IMoniker_GetTimeOfLastChangeProto                  typedef PROTO :DWORD,:DWORD,:DWORD,:DWORD
IMoniker_GetTimeOfLastChange                       typedef ptr IMoniker_GetTimeOfLastChangeProto
IMoniker_InverseProto                              typedef PROTO :DWORD,:DWORD
IMoniker_Inverse                                   typedef ptr IMoniker_InverseProto
IMoniker_CommonPrefixWithProto                     typedef PROTO :DWORD,:DWORD,:DWORD
IMoniker_CommonPrefixWith                          typedef ptr IMoniker_CommonPrefixWithProto
IMoniker_RelativePathToProto                       typedef PROTO :DWORD,:DWORD,:DWORD
IMoniker_RelativePathTo                            typedef ptr IMoniker_RelativePathToProto
IMoniker_GetDisplayNameProto                       typedef PROTO :DWORD,:DWORD,:DWORD,:DWORD
IMoniker_GetDisplayName                            typedef ptr IMoniker_GetDisplayNameProto
IMoniker_ParseDisplayNameProto                     typedef PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IMoniker_ParseDisplayName                          typedef ptr IMoniker_ParseDisplayNameProto
IMoniker_IsSystemMonikerProto                      typedef PROTO :DWORD,:DWORD
IMoniker_IsSystemMoniker                           typedef ptr IMoniker_IsSystemMonikerProto
IMoniker STRUCT DWORD
QueryInterface                                     IUnknown_QueryInterface                     ?
AddRef                                             IUnknown_AddRef                             ?
Release                                            IUnknown_Release                            ?
GetClassID                                         IPersist_GetClassID                         ?
IsDirty                                            IPersistStream_IsDirty                      ?
Load                                               IPersistStream_Load                         ?
Save                                               IPersistStream_Save                         ?
GetSizeMax                                         IPersistStream_GetSizeMax                   ?
BindToObject                                       IMoniker_BindToObject                       ?
BindToStorage                                      IMoniker_BindToStorage                      ?
Reduce                                             IMoniker_Reduce                             ?
ComposeWith                                        IMoniker_ComposeWith                        ?
Enum                                               IMoniker_Enum                               ?
IsEqual                                            IMoniker_IsEqual                            ?
Hash                                               IMoniker_Hash                               ?
IsRunning                                          IMoniker_IsRunning                          ?
GetTimeOfLastChange                                IMoniker_GetTimeOfLastChange                ?
Inverse                                            IMoniker_Inverse                            ?
CommonPrefixWith                                   IMoniker_CommonPrefixWith                   ?
RelativePathTo                                     IMoniker_RelativePathTo                     ?
GetDisplayName                                     IMoniker_GetDisplayName                     ?
ParseDisplayName                                   IMoniker_ParseDisplayName                   ?
IsSystemMoniker                                    IMoniker_IsSystemMoniker                    ?
IMoniker ENDS
; -------------------------------------------------------------------------
ISpecifyPropertyPages_GetPagesProto                typedef PROTO :DWORD,:DWORD
ISpecifyPropertyPages_GetPages                     typedef ptr ISpecifyPropertyPages_GetPagesProto
ISpecifyPropertyPages STRUCT DWORD
QueryInterface                                     IUnknown_QueryInterface                     ?
AddRef                                             IUnknown_AddRef                             ?
Release                                            IUnknown_Release                            ?
GetPages                                           ISpecifyPropertyPages_GetPages              ?
ISpecifyPropertyPages ENDS
; -------------------------------------------------------------------------
ICreateDevEnum_CreateClassEnumeratorProto          typedef PROTO :DWORD,:DWORD,:DWORD,:DWORD
ICreateDevEnum_CreateClassEnumerator               typedef ptr ICreateDevEnum_CreateClassEnumeratorProto
ICreateDevEnum STRUCT DWORD
QueryInterface                                     IUnknown_QueryInterface                     ?
AddRef                                             IUnknown_AddRef                             ?
Release                                            IUnknown_Release                            ?
CreateClassEnumerator                              ICreateDevEnum_CreateClassEnumerator        ?
ICreateDevEnum ENDS
; -------------------------------------------------------------------------
ICaptureGraphBuilder2_SetFiltergraphProto          typedef PROTO :DWORD,:DWORD
ICaptureGraphBuilder2_SetFiltergraph               typedef ptr ICaptureGraphBuilder2_SetFiltergraphProto
ICaptureGraphBuilder2_GetFiltergraphProto          typedef PROTO :DWORD,:DWORD
ICaptureGraphBuilder2_GetFiltergraph               typedef ptr ICaptureGraphBuilder2_GetFiltergraphProto
ICaptureGraphBuilder2_SetOutputFileNameProto       typedef PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
ICaptureGraphBuilder2_SetOutputFileName            typedef ptr ICaptureGraphBuilder2_SetOutputFileNameProto
ICaptureGraphBuilder2_FindInterfaceProto           typedef PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
ICaptureGraphBuilder2_FindInterface                typedef ptr ICaptureGraphBuilder2_FindInterfaceProto
ICaptureGraphBuilder2_RenderStreamProto            typedef PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
ICaptureGraphBuilder2_RenderStream                 typedef ptr ICaptureGraphBuilder2_RenderStreamProto
ICaptureGraphBuilder2_ControlStreamProto           typedef PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
ICaptureGraphBuilder2_ControlStream                typedef ptr ICaptureGraphBuilder2_ControlStreamProto
ICaptureGraphBuilder2_AllocCapFileProto            typedef PROTO :DWORD,:DWORD,:DWORD
ICaptureGraphBuilder2_AllocCapFile                 typedef ptr ICaptureGraphBuilder2_AllocCapFileProto
ICaptureGraphBuilder2_CopyCaptureFileProto         typedef PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
ICaptureGraphBuilder2_CopyCaptureFile              typedef ptr ICaptureGraphBuilder2_CopyCaptureFileProto
ICaptureGraphBuilder2_FindPinProto                 typedef PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
ICaptureGraphBuilder2_FindPin                      typedef ptr ICaptureGraphBuilder2_FindPinProto
ICaptureGraphBuilder2 STRUCT DWORD
QueryInterface                                     IUnknown_QueryInterface                     ?
AddRef                                             IUnknown_AddRef                             ?
Release                                            IUnknown_Release                            ?
SetFiltergraph                                     ICaptureGraphBuilder2_SetFiltergraph        ?
GetFiltergraph                                     ICaptureGraphBuilder2_GetFiltergraph        ?
SetOutputFileName                                  ICaptureGraphBuilder2_SetOutputFileName     ?
FindInterface                                      ICaptureGraphBuilder2_FindInterface         ?
RenderStream                                       ICaptureGraphBuilder2_RenderStream          ?
ControlStream                                      ICaptureGraphBuilder2_ControlStream         ?
AllocCapFile                                       ICaptureGraphBuilder2_AllocCapFile          ?
CopyCaptureFile                                    ICaptureGraphBuilder2_CopyCaptureFile       ?
FindPin                                            ICaptureGraphBuilder2_FindPin               ?
ICaptureGraphBuilder2 ENDS
; -------------------------------------------------------------------------
IFilterGraph_AddFilterProto                        typedef PROTO :DWORD,:DWORD,:DWORD
IFilterGraph_AddFilter                             typedef ptr IFilterGraph_AddFilterProto
IFilterGraph_RemoveFilterProto                     typedef PROTO :DWORD,:DWORD
IFilterGraph_RemoveFilter                          typedef ptr IFilterGraph_RemoveFilterProto
IFilterGraph_EnumFiltersProto                      typedef PROTO :DWORD,:DWORD
IFilterGraph_EnumFilters                           typedef ptr IFilterGraph_EnumFiltersProto
IFilterGraph_FindFilterByNameProto                 typedef PROTO :DWORD,:DWORD,:DWORD
IFilterGraph_FindFilterByName                      typedef ptr IFilterGraph_FindFilterByNameProto
IFilterGraph_ConnectDirectProto                    typedef PROTO :DWORD,:DWORD,:DWORD,:DWORD
IFilterGraph_ConnectDirect                         typedef ptr IFilterGraph_ConnectDirectProto
IFilterGraph_ReconnectProto                        typedef PROTO :DWORD,:DWORD
IFilterGraph_Reconnect                             typedef ptr IFilterGraph_ReconnectProto
IFilterGraph_DisconnectProto                       typedef PROTO :DWORD,:DWORD
IFilterGraph_Disconnect                            typedef ptr IFilterGraph_DisconnectProto
IFilterGraph_SetDefaultSyncSourceProto             typedef PROTO :DWORD
IFilterGraph_SetDefaultSyncSource                  typedef ptr IFilterGraph_SetDefaultSyncSourceProto
IFilterGraph STRUCT DWORD
QueryInterface                                     IUnknown_QueryInterface                     ?
AddRef                                             IUnknown_AddRef                             ?
Release                                            IUnknown_Release                            ?
AddFilter                                          IFilterGraph_AddFilter                      ?
RemoveFilter                                       IFilterGraph_RemoveFilter                   ?
EnumFilters                                        IFilterGraph_EnumFilters                    ?
FindFilterByName                                   IFilterGraph_FindFilterByName               ?
ConnectDirect                                      IFilterGraph_ConnectDirect                  ?
Reconnect                                          IFilterGraph_Reconnect                      ?
Disconnect                                         IFilterGraph_Disconnect                     ?
SetDefaultSyncSource                               IFilterGraph_SetDefaultSyncSource           ?
IFilterGraph ENDS
; -------------------------------------------------------------------------
IFilterGraph2_AddSourceFilterForMonikerProto       typedef PROTO :DWORD,:DWORD,:DWORD,:DWORD
IFilterGraph2_AddSourceFilterForMoniker            typedef ptr IFilterGraph2_AddSourceFilterForMonikerProto
IFilterGraph2_ReconnectExProto                     typedef PROTO :DWORD,:DWORD,:DWORD
IFilterGraph2_ReconnectEx                          typedef ptr IFilterGraph2_ReconnectExProto
IFilterGraph2 STRUCT DWORD
QueryInterface                                     IUnknown_QueryInterface                     ?
AddRef                                             IUnknown_AddRef                             ?
Release                                            IUnknown_Release                            ?
AddSourceFilterForMoniker                          IFilterGraph2_AddSourceFilterForMoniker     ?
ReconnectEx                                        IFilterGraph2_ReconnectEx                   ?
IFilterGraph2 ENDS
; -------------------------------------------------------------------------
IGraphBuilder_ConnectProto                      typedef PROTO :DWORD,:DWORD,:DWORD
IGraphBuilder_Connect                           typedef ptr IGraphBuilder_ConnectProto
IGraphBuilder_RenderProto                       typedef PROTO :DWORD,:DWORD
IGraphBuilder_Render                            typedef ptr IGraphBuilder_RenderProto
IGraphBuilder_RenderFileProto                   typedef PROTO :DWORD,:DWORD,:DWORD
IGraphBuilder_RenderFile                        typedef ptr IGraphBuilder_RenderFileProto
IGraphBuilder_AddSourceFilterProto              typedef PROTO :DWORD,:DWORD,:DWORD,:DWORD
IGraphBuilder_AddSourceFilter                   typedef ptr IGraphBuilder_AddSourceFilterProto
IGraphBuilder_SetLogFileProto                   typedef PROTO :DWORD,:DWORD
IGraphBuilder_SetLogFile                        typedef ptr IGraphBuilder_SetLogFileProto
IGraphBuilder_AbortProto                        typedef PROTO :DWORD
IGraphBuilder_Abort                             typedef ptr IGraphBuilder_AbortProto
IGraphBuilder_ShouldOperationContinueProto      typedef PROTO :DWORD,:DWORD
IGraphBuilder_ShouldOperationContinue           typedef ptr IGraphBuilder_ShouldOperationContinueProto
IGraphBuilder STRUCT DWORD
QueryInterface                                  IUnknown_QueryInterface                     ?
AddRef                                          IUnknown_AddRef                             ?
Release                                         IUnknown_Release                            ?
AddFilter                                       IFilterGraph_AddFilter                      ?
RemoveFilter                                    IFilterGraph_RemoveFilter                   ?
EnumFilters                                     IFilterGraph_EnumFilters                    ?
FindFilterByName                                IFilterGraph_FindFilterByName               ?
ConnectDirect                                   IFilterGraph_ConnectDirect                  ?
Reconnect                                       IFilterGraph_Reconnect                      ?
Disconnect                                      IFilterGraph_Disconnect                     ?
SetDefaultSyncSource                            IFilterGraph_SetDefaultSyncSource           ?
Connect                                         IGraphBuilder_Connect                       ?
Render                                          IGraphBuilder_Render                        ?
RenderFile                                      IGraphBuilder_RenderFile                    ?
AddSourceFilter                                 IGraphBuilder_AddSourceFilter               ?
SetLogFile                                      IGraphBuilder_SetLogFile                    ?
Abort                                           IGraphBuilder_Abort                         ?
ShouldOperationContinue                         IGraphBuilder_ShouldOperationContinue       ?
AddSourceFilterForMoniker                       IFilterGraph2_AddSourceFilterForMoniker     ?
ReconnectEx                                     IFilterGraph2_ReconnectEx                   ?
IGraphBuilder ENDS
; -------------------------------------------------------------------------
IDispatch_GetTypeInfoCountProto                 typedef PROTO :DWORD,:DWORD
IDispatch_GetTypeInfoCount                      typedef ptr IDispatch_GetTypeInfoCountProto
IDispatch_GetTypeInfoProto                      typedef PROTO :DWORD,:DWORD,:DWORD,:DWORD
IDispatch_GetTypeInfo                           typedef ptr IDispatch_GetTypeInfoProto
IDispatch_GetIDsOfNameProto                     typedef PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IDispatch_GetIDsOfName                          typedef ptr IDispatch_GetIDsOfNameProto
IDispatch_InvokeProto                           typedef PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IDispatch_Invoke                                typedef ptr IDispatch_InvokeProto
IDispatch STRUCT DWORD
QueryInterface                                  IUnknown_QueryInterface                     ?
AddRef                                          IUnknown_AddRef                             ?
Release                                         IUnknown_Release                            ?
GetTypeInfoCount                                IDispatch_GetTypeInfoCount                  ?
GetTypeInfo                                     IDispatch_GetTypeInfo                       ?
GetIDsOfName                                    IDispatch_GetIDsOfName                      ?
xInvoke                                         IDispatch_Invoke                            ?
IDispatch ENDS
; -------------------------------------------------------------------------
IPropertyBag_ReadProto                          typedef PROTO :DWORD,:DWORD,:DWORD,:DWORD
IPropertyBag_Read                               typedef ptr IPropertyBag_ReadProto
IPropertyBag_WriteProto                         typedef PROTO :DWORD,:DWORD,:DWORD
IPropertyBag_Write                              typedef ptr IPropertyBag_WriteProto
IPropertyBag STRUCT DWORD
QueryInterface                                  IUnknown_QueryInterface                     ?
AddRef                                          IUnknown_AddRef                             ?
Release                                         IUnknown_Release                            ?
Read                                            IPropertyBag_Read                           ?
Write                                           IPropertyBag_Write                          ?
IPropertyBag ENDS
; -------------------------------------------------------------------------
IPropertyBag2_ReadProto                          typedef PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IPropertyBag2_Read                               typedef ptr IPropertyBag2_ReadProto
IPropertyBag2_WriteProto                         typedef PROTO :DWORD,:DWORD,:DWORD,:DWORD
IPropertyBag2_Write                              typedef ptr IPropertyBag2_WriteProto
IPropertyBag2_CountPropertiesProto               typedef PROTO :DWORD,:DWORD
IPropertyBag2_CountProperties                    typedef ptr IPropertyBag2_CountPropertiesProto
IPropertyBag2_GetPropertyInfoProto               typedef PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IPropertyBag2_GetPropertyInfo                    typedef ptr IPropertyBag2_GetPropertyInfoProto
IPropertyBag2_LoadObjectProto                    typedef PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IPropertyBag2_LoadObject                         typedef ptr IPropertyBag2_LoadObjectProto
IPropertyBag2 STRUCT DWORD
QueryInterface                                  IUnknown_QueryInterface                 ?
AddRef                                          IUnknown_AddRef                         ?
Release                                         IUnknown_Release                        ?
Read                                            IPropertyBag2_Read                           ?
Write                                           IPropertyBag2_Write                          ?
CountProperties                                 IPropertyBag2_CountProperties                ?
GetPropertyInfo                                 IPropertyBag2_GetPropertyInfo                ?
LoadObject                                      IPropertyBag2_LoadObject                     ?
IPropertyBag2 ENDS
; -------------------------------------------------------------------------
IVideoWindow_put_CaptionProto                   typedef PROTO :DWORD,:DWORD
IVideoWindow_put_Caption                        typedef ptr IVideoWindow_put_CaptionProto
IVideoWindow_get_CaptionProto                   typedef PROTO :DWORD,:DWORD
IVideoWindow_get_Caption                        typedef ptr IVideoWindow_get_CaptionProto
IVideoWindow_put_WindowStyleProto               typedef PROTO :DWORD,:DWORD
IVideoWindow_put_WindowStyle                    typedef ptr IVideoWindow_put_WindowStyleProto
IVideoWindow_get_WindowStyleProto               typedef PROTO :DWORD,:DWORD
IVideoWindow_get_WindowStyle                    typedef ptr IVideoWindow_get_WindowStyleProto
IVideoWindow_put_WindowStyleExProto             typedef PROTO :DWORD,:DWORD
IVideoWindow_put_WindowStyleEx                  typedef ptr IVideoWindow_put_WindowStyleExProto
IVideoWindow_get_WindowStyleExProto             typedef PROTO :DWORD,:DWORD
IVideoWindow_get_WindowStyleEx                  typedef ptr IVideoWindow_get_WindowStyleExProto
IVideoWindow_put_AutoShowProto                  typedef PROTO :DWORD,:DWORD
IVideoWindow_put_AutoShow                       typedef ptr IVideoWindow_put_AutoShowProto
IVideoWindow_get_AutoShowProto                  typedef PROTO :DWORD,:DWORD
IVideoWindow_get_AutoShow                       typedef ptr IVideoWindow_get_AutoShowProto
IVideoWindow_put_WindowStateProto               typedef PROTO :DWORD,:DWORD
IVideoWindow_put_WindowState                    typedef ptr IVideoWindow_put_WindowStateProto
IVideoWindow_get_WindowStateProto               typedef PROTO :DWORD,:DWORD
IVideoWindow_get_WindowState                    typedef ptr IVideoWindow_get_WindowStateProto
IVideoWindow_put_BackgroundPaletteProto         typedef PROTO :DWORD,:DWORD
IVideoWindow_put_BackgroundPalette              typedef ptr IVideoWindow_put_BackgroundPaletteProto
IVideoWindow_get_BackgroundPaletteProto         typedef PROTO :DWORD,:DWORD
IVideoWindow_get_BackgroundPalette              typedef ptr IVideoWindow_get_BackgroundPaletteProto
IVideoWindow_put_VisibleProto                   typedef PROTO :DWORD,:DWORD
IVideoWindow_put_Visible                        typedef ptr IVideoWindow_put_VisibleProto
IVideoWindow_get_VisibleProto                   typedef PROTO :DWORD,:DWORD
IVideoWindow_get_Visible                        typedef ptr IVideoWindow_get_VisibleProto
IVideoWindow_put_LeftProto                      typedef PROTO :DWORD,:DWORD
IVideoWindow_put_Left                           typedef ptr IVideoWindow_put_LeftProto
IVideoWindow_get_LeftProto                      typedef PROTO :DWORD,:DWORD
IVideoWindow_get_Left                           typedef ptr IVideoWindow_get_LeftProto
IVideoWindow_put_WidthProto                     typedef PROTO :DWORD,:DWORD
IVideoWindow_put_Width                          typedef ptr IVideoWindow_put_WidthProto
IVideoWindow_get_WidthProto                     typedef PROTO :DWORD,:DWORD
IVideoWindow_get_Width                          typedef ptr IVideoWindow_get_WidthProto
IVideoWindow_put_TopProto                       typedef PROTO :DWORD,:DWORD
IVideoWindow_put_Top                            typedef ptr IVideoWindow_put_TopProto
IVideoWindow_get_TopProto                       typedef PROTO :DWORD,:DWORD
IVideoWindow_get_Top                            typedef ptr IVideoWindow_get_TopProto
IVideoWindow_put_HeightProto                    typedef PROTO :DWORD,:DWORD
IVideoWindow_put_Height                         typedef ptr IVideoWindow_put_HeightProto
IVideoWindow_get_HeightProto                    typedef PROTO :DWORD,:DWORD
IVideoWindow_get_Height                         typedef ptr IVideoWindow_getHeightProto
IVideoWindow_put_OwnerProto                     typedef PROTO :DWORD,:DWORD
IVideoWindow_put_Owner                          typedef ptr IVideoWindow_put_OwnerProto
IVideoWindow_get_OwnerProto                     typedef PROTO :DWORD,:DWORD
IVideoWindow_get_Owner                          typedef ptr IVideoWindow_get_OwnerProto
IVideoWindow_put_MessageDrainProto              typedef PROTO :DWORD,:DWORD
IVideoWindow_put_MessageDrain                   typedef ptr IVideoWindow_put_MessageDrainProto
IVideoWindow_get_MessageDrainProto              typedef PROTO :DWORD,:DWORD
IVideoWindow_get_MessageDrain                   typedef ptr IVideoWindow_get_MessageDrainProto
IVideoWindow_get_BorderColorProto               typedef PROTO :DWORD,:DWORD
IVideoWindow_get_BorderColor                    typedef ptr IVideoWindow_get_BorderColorProto
IVideoWindow_put_BorderColorProto               typedef PROTO :DWORD,:DWORD
IVideoWindow_put_BorderColor                    typedef ptr IVideoWindow_put_BorderColorProto
IVideoWindow_get_FullScreenModeProto            typedef PROTO :DWORD,:DWORD
IVideoWindow_get_FullScreenMode                 typedef ptr IVideoWindow_get_FullScreenModeProto
IVideoWindow_put_FullScreenModeProto            typedef PROTO :DWORD,:DWORD
IVideoWindow_put_FullScreenMode                 typedef ptr IVideoWindow_put_FullScreenModeProto
IVideoWindow_SetWindowForegroundProto           typedef PROTO :DWORD,:DWORD
IVideoWindow_SetWindowForeground                typedef ptr IVideoWindow_SetWindowForegroundProto
IVideoWindow_NotifyOwnerMessageProto            typedef PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IVideoWindow_NotifyOwnerMessage                 typedef ptr IVideoWindow_NotifyOwnerMessageProto
IVideoWindow_SetWindowPositionProto             typedef PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IVideoWindow_SetWindowPosition                  typedef ptr IVideoWindow_SetWindowPositionProto
IVideoWindow_GetWindowPositionProto             typedef PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IVideoWindow_GetWindowPosition                  typedef ptr IVideoWindow_GetWindowPositionProto
IVideoWindow_GetMinIdealImageSizeProto          typedef PROTO :DWORD,:DWORD,:DWORD
IVideoWindow_GetMinIdealImageSize               typedef ptr IVideoWindow_GetMinIdealImageSizeProto
IVideoWindow_GetMaxIdealImageSizeProto          typedef PROTO :DWORD,:DWORD,:DWORD
IVideoWindow_GetMaxIdealImageSize               typedef ptr IVideoWindow_GetMaxIdealImageSizeProto
IVideoWindow_GetRestorePositionProto            typedef PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IVideoWindow_GetRestorePosition                 typedef ptr IVideoWindow_GetRestorePositionProto
IVideoWindow_HideCursorProto                    typedef PROTO :DWORD,:DWORD
IVideoWindow_HideCursor                         typedef ptr IVideoWindow_HideCursorProto
IVideoWindow_IsCursorHiddenProto                typedef PROTO :DWORD,:DWORD
IVideoWindow_IsCursorHidden                     typedef ptr IVideoWindow_IsCursorHiddenProto
IVideoWindow STRUCT DWORD
QueryInterface                                  IUnknown_QueryInterface                     ?
AddRef                                          IUnknown_AddRef                             ?
Release                                         IUnknown_Release                            ?
GetTypeInfoCount                                IDispatch_GetTypeInfoCount                  ?
GetTypeInfo                                     IDispatch_GetTypeInfo                       ?
GetIDsOfName                                    IDispatch_GetIDsOfName                      ?
xInvoke                                         IDispatch_Invoke                            ?
put_Caption                                     IVideoWindow_put_Caption                    ?
get_Caption                                     IVideoWindow_get_Caption                    ?
put_WindowStyle                                 IVideoWindow_put_WindowStyle                ?
get_WindowStyle                                 IVideoWindow_get_WindowStyle                ?
put_WindowStyleEx                               IVideoWindow_put_WindowStyleEx              ?
get_WindowStyleEx                               IVideoWindow_get_WindowStyleEx              ?
put_AutoShow                                    IVideoWindow_put_AutoShow                   ?
get_AutoShow                                    IVideoWindow_get_AutoShow                   ?
put_WindowState                                 IVideoWindow_put_WindowState                ?
get_WindowState                                 IVideoWindow_get_WindowState                ?
put_BackgroundPalette                           IVideoWindow_put_BackgroundPalette          ?
get_BackgroundPalette                           IVideoWindow_get_BackgroundPalette          ?
put_Visible                                     IVideoWindow_put_Visible                    ?
get_Visible                                     IVideoWindow_get_Visible                    ?
put_Left                                        IVideoWindow_put_Left                       ?
get_Left                                        IVideoWindow_get_Left                       ?
put_Width                                       IVideoWindow_put_Width                      ?
get_Width                                       IVideoWindow_get_Width                      ?
put_Top                                         IVideoWindow_put_Top                        ?
get_Top                                         IVideoWindow_get_Top                        ?
put_Height                                      IVideoWindow_put_Height                     ?
get_Height                                      IVideoWindow_get_Height                     ?
put_Owner                                       IVideoWindow_put_Owner                      ?
get_Owner                                       IVideoWindow_get_Owner                      ?
put_MessageDrain                                IVideoWindow_put_MessageDrain               ?
get_MessageDrain                                IVideoWindow_get_MessageDrain               ?
get_BorderColor                                 IVideoWindow_get_BorderColor                ?
put_BorderColor                                 IVideoWindow_put_BorderColor                ?
get_FullScreenMode                              IVideoWindow_get_FullScreenMode             ?
put_FullScreenMode                              IVideoWindow_put_FullScreenMode             ?
SetWindowForeground                             IVideoWindow_SetWindowForeground            ?
NotifyOwnerMessage                              IVideoWindow_NotifyOwnerMessage             ?
SetWindowPosition                               IVideoWindow_SetWindowPosition              ?
GetWindowPosition                               IVideoWindow_GetWindowPosition              ?
GetMinIdealImageSize                            IVideoWindow_GetMinIdealImageSize           ?
GetMaxIdealImageSize                            IVideoWindow_GetMaxIdealImageSize           ?
GetRestorePosition                              IVideoWindow_GetRestorePosition             ?
HideCursor                                      IVideoWindow_HideCursor                     ?
IsCursorHidden                                  IVideoWindow_IsCursorHidden                 ?
IVideoWindow ENDS
; -------------------------------------------------------------------------
IMediaControl_RunProto                          typedef PROTO :DWORD
IMediaControl_Run                               typedef ptr IMediaControl_RunProto
IMediaControl_PauseProto                        typedef PROTO :DWORD
IMediaControl_Pause                             typedef ptr IMediaControl_PauseProto
IMediaControl_StopProto                         typedef PROTO :DWORD
IMediaControl_Stop                              typedef ptr IMediaControl_StopProto
IMediaControl_StopWhenReadyProto                typedef PROTO :DWORD
IMediaControl_StopWhenReady                     typedef ptr IMediaControl_StopWhenReadyProto
IMediaControl_GetStateProto                     typedef PROTO :DWORD,:DWORD,:DWORD
IMediaControl_GetState                          typedef ptr IMediaControl_GetStateProto
IMediaControl_RenderFileProto                   typedef PROTO :DWORD,:DWORD
IMediaControl_RenderFile                        typedef ptr IMediaControl_RenderFileProto
IMediaControl_AddSourceFilterProto              typedef PROTO :DWORD,:DWORD,:DWORD
IMediaControl_AddSourceFilter                   typedef ptr IMediaControl_AddSourceFilterProto
IMediaControl_get_FilterCollectionProto         typedef PROTO :DWORD,:DWORD
IMediaControl_get_FilterCollection              typedef ptr IMediaControl_get_FilterCollectionProto
IMediaControl_get_RegFilterCollectionProto      typedef PROTO :DWORD,:DWORD
IMediaControl_get_RegFilterCollection           typedef ptr IMediaControl_get_RegFilterCollectionProto
IMediaControl STRUCT DWORD
QueryInterface                                  IUnknown_QueryInterface                     ?
AddRef                                          IUnknown_AddRef                             ?
Release                                         IUnknown_Release                            ?
GetTypeInfoCount                                IDispatch_GetTypeInfoCount                  ?
GetTypeInfo                                     IDispatch_GetTypeInfo                       ?
GetIDsOfName                                    IDispatch_GetIDsOfName                      ?
xInvoke                                         IDispatch_Invoke                            ?
Run                                             IMediaControl_Run                           ?
IMCPause                                        IMediaControl_Pause                         ?
Stop                                            IMediaControl_Stop                          ?
StopWhenReady                                   IMediaControl_StopWhenReady                 ?
GetState                                        IMediaControl_GetState                      ?
RenderFile                                      IMediaControl_RenderFile                    ?
AddSourceFilter                                 IMediaControl_AddSourceFilter               ?
get_FilterCollection                            IMediaControl_get_FilterCollection          ?
get_RegFilterCollection                         IMediaControl_get_RegFilterCollection       ?
IMediaControl ENDS
; -------------------------------------------------------------------------
IMediaFilter_StopProto                          typedef PROTO :DWORD
IMediaFilter_Stop                               typedef ptr IMediaFilter_StopProto
IMediaFilter_PauseProto                         typedef PROTO :DWORD
IMediaFilter_Pause                              typedef ptr IMediaFilter_PauseProto
IMediaFilter_RunProto                           typedef PROTO :DWORD,:DWORD
IMediaFilter_Run                                typedef ptr IMediaFilter_RunProto
IMediaFilter_GetStateProto                      typedef PROTO :DWORD,:DWORD,:DWORD
IMediaFilter_GetState                           typedef ptr IMediaFilter_GetStateProto
IMediaFilter_SetSyncSourceProto                 typedef PROTO :DWORD,:DWORD
IMediaFilter_SetSyncSource                      typedef ptr MediaFilter_SetSyncSourceProto
IMediaFilter_GetSyncSourceProto                 typedef PROTO :DWORD,:DWORD
IMediaFilter_GetSyncSource                      typedef ptr IMediaFilter_GetSyncSourceProto
IMediaFilter STRUCT DWORD
QueryInterface                                  IUnknown_QueryInterface                     ?
AddRef                                          IUnknown_AddRef                             ?
Release                                         IUnknown_Release                            ?
Stop                                            IMediaFilter_Stop                           ?
IMFPause                                        IMediaFilter_Pause                          ?
Run                                             IMediaFilter_Run                            ?
GetState                                        IMediaFilter_GetState                       ?
SetSyncSource                                   IMediaFilter_SetSyncSource                  ?
GetSyncSource                                   IMediaFilter_GetSyncSource                  ?
IMediaFilter ENDS
; -------------------------------------------------------------------------
IBaseFilter_EnumPinsProto                       typedef PROTO :DWORD,:DWORD
IBaseFilter_EnumPins                            typedef ptr IBaseFilter_EnumPinsProto
IBaseFilter_FindPinProto                        typedef PROTO :DWORD,:DWORD,:DWORD
IBaseFilter_FindPin                             typedef ptr IBaseFilter_FindPinProto
IBaseFilter_QueryFilterInfoProto                typedef PROTO :DWORD,:DWORD
IBaseFilter_QueryFilterInfo                     typedef ptr IBaseFilter_QueryFilterInfoProto
IBaseFilter_JoinFilterGraphProto                typedef PROTO :DWORD,:DWORD,:DWORD
IBaseFilter_JoinFilterGraph                     typedef ptr IBaseFilter_JoinFilterGraphProto
IBaseFilter_QueryVendorInfoProto                typedef PROTO :DWORD,:DWORD
IBaseFilter_QueryVendorInfo                     typedef ptr IBaseFilter_QueryVendorInfoProto
IBaseFilter STRUCT DWORD
QueryInterface                                  IUnknown_QueryInterface                     ?
AddRef                                          IUnknown_AddRef                             ?
Release                                         IUnknown_Release                            ?
Stop                                            IMediaFilter_Stop                           ?
IBFPause                                        IMediaFilter_Pause                          ?
Run                                             IMediaFilter_Run                            ?
GetState                                        IMediaFilter_GetState                       ?
SetSyncSource                                   IMediaFilter_SetSyncSource                  ?
GetSyncSource                                   IMediaFilter_GetSyncSource                  ?
EnumPins                                        IBaseFilter_EnumPins                        ?
FindPin                                         IBaseFilter_FindPin                         ?
QueryFilterInfo                                 IBaseFilter_QueryFilterInfo                 ?
JoinFilterGraph                                 IBaseFilter_JoinFilterGraph                 ?
QueryVendorInfo                                 IBaseFilter_QueryVendorInfo                 ?
IBaseFilter ENDS
; -------------------------------------------------------------------------
IEnumFilters_NextProto                          typedef PROTO :DWORD,:DWORD,:DWORD,:DWORD
IEnumFilters_Next                               typedef ptr IEnumFilters_NextProto
IEnumFilters_SkipProto                          typedef PROTO :DWORD,:DWORD
IEnumFilters_Skip                               typedef ptr IEnumFilters_SkipProto
IEnumFilters_ResetProto                         typedef PROTO :DWORD
IEnumFilters_Reset                              typedef ptr IEnumFilters_ResetProto
IEnumFilters_CloneProto                         typedef PROTO :DWORD,:DWORD
IEnumFilters_Clone                              typedef ptr IEnumFilters_CloneProto
IEnumFilters STRUCT DWORD
QueryInterface                                  IUnknown_QueryInterface                     ?
AddRef                                          IUnknown_AddRef                             ?
Release                                         IUnknown_Release                            ?
Next                                            IEnumFilters_Next                           ?
Skip                                            IEnumFilters_Skip                           ?
Reset                                           IEnumFilters_Reset                          ?
Clone                                           IEnumFilters_Clone                          ?
IEnumFilters ENDS
; -------------------------------------------------------------------------
IFilterInfo_FindPinProto                        typedef PROTO :DWORD,:DWORD,:DWORD
IFilterInfo_FindPin                             typedef ptr IFilterInfo_FindPinProto
IFilterInfo_get_NameProto                       typedef PROTO :DWORD,:DWORD
IFilterInfo_get_Name                            typedef ptr IFilterInfo_get_NameProto
IFilterInfo_get_VendorInfoProto                 typedef PROTO :DWORD,:DWORD
IFilterInfo_get_VendorInfo                      typedef ptr IFilterInfo_get_VendorInfoProto
IFilterInfo_get_FilterProto                     typedef PROTO :DWORD,:DWORD
IFilterInfo_get_Filter                          typedef ptr IFilterInfo_get_FilterProto
IFilterInfo_get_PinsProto                       typedef PROTO :DWORD,:DWORD
IFilterInfo_get_Pins                            typedef ptr IFilterInfo_get_PinsProto
IFilterInfo_get_IsFileSourceProto               typedef PROTO :DWORD,:DWORD
IFilterInfo_get_IsFileSource                    typedef ptr IFilterInfo_get_IsFileSourceProto
IFilterInfo_get_FilenameProto                   typedef PROTO :DWORD,:DWORD
IFilterInfo_get_Filename                        typedef ptr IFilterInfo_get_FilenameProto
IFilterInfo_put_FilenameProto                   typedef PROTO :DWORD,:DWORD
IFilterInfo_put_Filename                        typedef ptr IFilterInfo_put_FilenameProto
IFilterInfo STRUCT DWORD
QueryInterface                                  IUnknown_QueryInterface                     ?
AddRef                                          IUnknown_AddRef                             ?
Release                                         IUnknown_Release                            ?
GetTypeInfoCount                                IDispatch_GetTypeInfoCount                  ?
GetTypeInfo                                     IDispatch_GetTypeInfo                       ?
GetIDsOfName                                    IDispatch_GetIDsOfName                      ?
xInvoke                                         IDispatch_Invoke                            ?
FindPin                                         IFilterInfo_FindPin                         ?
get_Name                                        IFilterInfo_get_Name                        ?
get_VendorInfo                                  IFilterInfo_get_VendorInfo                  ?
get_Filter                                      IFilterInfo_get_Filter                      ?
get_Pins                                        IFilterInfo_get_Pins                        ?
get_IsFileSource                                IFilterInfo_get_IsFileSource                ?
get_Filename                                    IFilterInfo_get_Filename                    ?
put_Filename                                    IFilterInfo_put_Filename                    ?
IFilterInfo ENDS
; -------------------------------------------------------------------------
IAMVideoProcAmp_GetRangeProto                   typedef PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IAMVideoProcAmp_GetRange                        typedef ptr IAMVideoProcAmp_GetRangeProto
IAMVideoProcAmp_SetProto                        typedef PROTO :DWORD,:DWORD,:DWORD,:DWORD
IAMVideoProcAmp_Set                             typedef ptr IAMVideoProcAmp_SetProto
IAMVideoProcAmp_GetProto                        typedef PROTO :DWORD,:DWORD,:DWORD,:DWORD
IAMVideoProcAmp_Get                             typedef ptr IAMVideoProcAmp_GetProto
IAMVideoProcAmp STRUCT DWORD
QueryInterface                                  IUnknown_QueryInterface                     ?
AddRef                                          IUnknown_AddRef                             ?
Release                                         IUnknown_Release                            ?
GetRange                                        IAMVideoProcAmp_GetRange                    ?
Set                                             IAMVideoProcAmp_Set                         ?
Get                                             IAMVideoProcAmp_Get                         ?
IAMVideoProcAmp ENDS
; -------------------------------------------------------------------------
IAMVideoControl_GetCapsProto                    typedef PROTO :DWORD,:DWORD,:DWORD
IAMVideoControl_GetCaps                         typedef ptr IAMVideoControl_GetCapsProto
IAMVideoControl_SetModeProto                    typedef PROTO :DWORD,:DWORD,:DWORD
IAMVideoControl_SetMode                         typedef ptr IAMVideoControl_SetModeProto
IAMVideoControl_GetModeProto                    typedef PROTO :DWORD,:DWORD,:DWORD
IAMVideoControl_GetMode                         typedef ptr IAMVideoControl_GetModeProto
IAMVideoControl_GetCurrentActualFrameRateProto  typedef PROTO :DWORD,:DWORD,:DWORD
IAMVideoControl_GetCurrentActualFrameRate       typedef ptr IAMVideoControl_GetCurrentActualFrameRateProto
IAMVideoControl_GetMaxAvailableFrameRateProto   typedef PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IAMVideoControl_GetMaxAvailableFrameRate        typedef ptr IAMVideoControl_GetMaxAvailableFrameRateProto
IAMVideoControl_GetFrameRateListProto           typedef PROTO :DWORD,:DWORD,:DWORD,:DWORD,:DWORD,:DWORD
IAMVideoControl_GetFrameRateList                typedef ptr IAMVideoControl_GetFrameRateListProto
IAMVideoControl STRUCT DWORD
QueryInterface                                  IUnknown_QueryInterface                     ?
AddRef                                          IUnknown_AddRef                             ?
Release                                         IUnknown_Release                            ?
GetCaps                                         IAMVideoControl_GetCaps                     ?
SetMode                                         IAMVideoControl_SetMode                     ?
GetMode                                         IAMVideoControl_GetMode                     ?
GetCurrentActualFrameRate                       IAMVideoControl_GetCurrentActualFrameRate   ?
GetMaxAvailableFrameRate                        IAMVideoControl_GetMaxAvailableFrameRate    ?
GetFrameRateList                                IAMVideoControl_GetFrameRateList            ?
IAMVideoControl ENDS
; -------------------------------------------------------------------------
IAMStreamConfig_SetFormatProto                  typedef PROTO :DWORD,:DWORD
IAMStreamConfig_SetFormat                       typedef ptr IAMStreamConfig_SetFormatProto
IAMStreamConfig_GetFormatProto                  typedef PROTO :DWORD,:DWORD
IAMStreamConfig_GetFormat                       typedef ptr IAMStreamConfig_GetFormatProto
IAMStreamConfig_GetNumberOfCapabilitiesProto    typedef PROTO :DWORD,:DWORD,:DWORD
IAMStreamConfig_GetNumberOfCapabilities         typedef ptr IAMStreamConfig_GetNumberOfCapabilitiesProto
IAMStreamConfig_GetStreamCapsProto              typedef PROTO :DWORD,:DWORD,:DWORD,:DWORD
IAMStreamConfig_GetStreamCaps                   typedef ptr IAMStreamConfig_GetStreamCapsProto
IAMStreamConfig STRUCT DWORD
QueryInterface                                  IUnknown_QueryInterface                     ?
AddRef                                          IUnknown_AddRef                             ?
Release                                         IUnknown_Release                            ?
SetFormat                                       IAMStreamConfig_SetFormat                   ?
GetFormat                                       IAMStreamConfig_GetFormat                   ?
GetNumberOfCapabilities                         IAMStreamConfig_GetNumberOfCapabilities     ?
GetStreamCaps                                   IAMStreamConfig_GetStreamCaps               ?
IAMStreamConfig ENDS
; -------------------------------------------------------------------------


;**********************************************************************************************************************************************************
;ActiveMovie event codes :
;**********************************************************************************************************************************************************
    EC_SYSTEMBASE                   equ 00000h
    EC_USER                         equ 08000h
    EC_COMPLETE                     equ 00001h
    EC_USERABORT                    equ 00002h
    EC_ERRORABORT                   equ 00003h
    EC_TIME                         equ 00004h
    EC_REPAINT                      equ 00005h
    EC_STREAM_ERROR_STOPPED         equ 00006h
    EC_STREAM_ERROR_STILLPLAYING    equ 00007h
    EC_ERROR_STILLPLAYING           equ 00008h
    EC_PALETTE_CHANGED              equ 00009h
    EC_VIDEO_SIZE_CHANGED           equ 0000Ah
    EC_QUALITY_CHANGE               equ 0000Bh
    EC_SHUTTING_DOWN                equ 0000Ch
    EC_CLOCK_CHANGED                equ 0000Dh
    EC_PAUSED                       equ 0000Eh
    EC_OPENING_FILE                 equ 00010h
    EC_BUFFERING_DATA               equ 00011h
    EC_FULLSCREEN_LOST              equ 00012h
    EC_ACTIVATE                     equ 00013h
    EC_NEED_RESTART                 equ 00014h
    EC_WINDOW_DESTROYED             equ 00015h
    EC_DISPLAY_CHANGED              equ 00016h
    EC_STARVATION                   equ 00017h
    EC_OLE_EVENT                    equ 00018h
    EC_NOTIFY_WINDOW                equ 00019h
    EC_STREAM_CONTROL_STOPPED       equ 0001Ah
    EC_STREAM_CONTROL_STARTED       equ 0001Bh
    EC_END_OF_SEGMENT               equ 0001Ch
    EC_SEGMENT_STARTED              equ 0001Dh
    EC_LENGTH_CHANGED               equ 0001Eh
    EC_DEVICE_LOST                  equ 0001Fh
    EC_SAMPLE_NEEDED                equ 00020h
    EC_PROCESSING_LATENCY           equ 00021h
    EC_SAMPLE_LATENCY               equ 00022h
    EC_SCRUB_TIME                   equ 00023h
    EC_STEP_COMPLETE                equ 00024h
    EC_TIMECODE_AVAILABLE           equ 00030h
    EC_EXTDEVICE_MODE_CHANGE        equ 00031h
    EC_STATE_CHANGE                 equ 00032h
    EC_GRAPH_CHANGED                equ 00050h
    EC_CLOCK_UNSET                  equ 00051h
    EC_VMR_RENDERDEVICE_SET         equ 00053h
    EC_VMR_SURFACE_FLIPPED          equ 00054h
    EC_VMR_RECONNECTION_FAILED      equ 00055h
    EC_PREPROCESS_COMPLETE          equ 00056h
    EC_CODECAPI_EVENT               equ 00057h
    EC_WMT_EVENT_BASE               equ 00251h
    EC_WMT_INDEX_EVENT              equ EC_WMT_EVENT_BASE + 0
    EC_WMT_EVENT                    equ EC_WMT_EVENT_BASE + 1
    EC_BUILT                        equ 00300h
    EC_UNBUILT                      equ 00311h
    EC_SKIP_FRAMES                  equ 00025h
    EC_PLEASE_REOPEN                equ 00040h
    EC_STATUS                       equ 00041h
    EC_MARKER_HIT                   equ 00042h
    EC_LOADSTATUS                   equ 00043h
    EC_FILE_CLOSED                  equ 00044h
    EC_ERRORABORTEX                 equ 00045h
    EC_NEW_PIN                      equ 00020h
    EC_RENDER_FINISHED              equ 00021h
    EC_EOS_SOON                     equ 00046h
    EC_CONTENTPROPERTY_CHANGED      equ 00047h
    EC_BANDWIDTHCHANGE              equ 00048h
    EC_VIDEOFRAMEREADY              equ 00049h

