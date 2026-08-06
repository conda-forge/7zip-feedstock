set enabledelayedexpansion

cd CPP\7zip
if %target_platform%==win-64 set PLATFORM=x64
if %target_platform%==win-arm64 set PLATFORM=arm64
nmake PLATFORM=%PLATFORM% NEW_COMPILER=1 MY_DYNAMIC_LINK=1

if not exist "%PREFIX%\bin" mkdir "%PREFIX%\bin"
if not exist "%LIBRARY_BIN%" mkdir "%LIBRARY_BIN%"
if not exist "%LIBRARY_LIB%" mkdir "%LIBRARY_LIB%"

copy Bundles\Alone7z\%PLATFORM%\7zr.exe "%PREFIX%\bin" /Y
copy Bundles\Alone2\%PLATFORM%\7zz.exe "%PREFIX%\bin" /Y
copy Bundles\Alone\%PLATFORM%\7za.exe "%PREFIX%\bin" /Y
copy UI\Console\%PLATFORM%\7z.exe "%PREFIX%\bin" /Y

REM 7z.exe is built with external codecs and loads its codec/format plugin
REM (7z.dll) from the directory of the executable (GetModuleFileNameW), so the
REM plugin must sit next to 7z.exe -- not only in %LIBRARY_BIN%. Without this the
REM console 7z fails with "Codec Load Error -> E_NOTIMPL".
copy Bundles\Format7zF\%PLATFORM%\7z.dll "%PREFIX%\bin" /Y

for /d %%G in (Bundles\Format*) do (
    echo Copying from %%G\!PLATFORM!
    copy "%%G\!PLATFORM!\*.dll" "%LIBRARY_BIN%" /Y
    copy "%%G\!PLATFORM!\*.lib" "%LIBRARY_LIB%" /Y
)
