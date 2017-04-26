@echo off

echo        Assembling library modules.
echo.
\masm32\bin\ml /c /coff webcam32.asm
\masm32\bin\lib *.obj /out:webcam32.lib

dir webcam32.*

@echo off
pause