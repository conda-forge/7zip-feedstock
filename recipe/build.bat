cd CPP\7zip
nmake PLATFORM=x64 NEW_COMPILER=1 MY_DYNAMIC_LINK=1

robocopy Bundles\Alone7z\x64 "%PREFIX%\bin" 7zr.exe
robocopy Bundles\Alone2\x64 "%PREFIX%\bin" 7zz.exe
robocopy Bundles\Alone\x64 "%PREFIX%\bin" 7za.exe
robocopy UI\Console\x64 "%PREFIX%\bin" 7z.exe

for /d %%G in (Bundles\Format*) do (
    echo Copying from %%G\x64
    ( robocopy "%%G\x64" "%LIBRARY_BIN%" *.dll ) ^& IF %ERRORLEVEL% LSS 8 SET ERRORLEVEL = 0
    ( robocopy "%%G\x64" "%LIBRARY_LIB%" *.lib ) ^& IF %ERRORLEVEL% LSS 8 SET ERRORLEVEL = 0
)
