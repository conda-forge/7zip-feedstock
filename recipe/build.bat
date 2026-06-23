cd CPP\7zip
nmake PLATFORM=x64 NEW_COMPILER=1 MY_DYNAMIC_LINK=1

if not exist "%PREFIX%\bin" mkdir "%PREFIX%\bin"
if not exist "%LIBRARY_BIN%" mkdir "%LIBRARY_BIN%"
if not exist "%LIBRARY_LIB%" mkdir "%LIBRARY_LIB%"

copy Bundles\Alone7z\x64\7zr.exe "%PREFIX%\bin" /Y
copy Bundles\Alone2\x64\7zz.exe "%PREFIX%\bin" /Y
copy Bundles\Alone\x64\7za.exe "%PREFIX%\bin" /Y
copy UI\Console\x64\7z.exe "%PREFIX%\bin" /Y

REM 7z.exe is built with external codecs and loads its codec/format plugin
REM (7z.dll) from the directory of the executable (GetModuleFileNameW), so the
REM plugin must sit next to 7z.exe -- not only in %LIBRARY_BIN%. Without this the
REM console 7z fails with "Codec Load Error -> E_NOTIMPL".
copy Bundles\Format7zF\x64\7z.dll "%PREFIX%\bin" /Y

for /d %%G in (Bundles\Format*) do (
    echo Copying from %%G\x64
    copy "%%G\x64\*.dll" "%LIBRARY_BIN%" /Y
    copy "%%G\x64\*.lib" "%LIBRARY_LIB%" /Y
)
