@echo off
if exist webcam32.obj del webcam32.obj
if exist webcam32.dll del webcam32.dll
\masm32\bin\rc /v rsrc.rc
\masm32\bin\ml /c /coff webcam32.asm
\masm32\bin\Link /SUBSYSTEM:WINDOWS /DLL /DEF:webcam32.def webcam32.obj rsrc.res
del webcam32.obj
del webcam32.exp
dir webcam32.*
pause
