cd CPP\7zip
nmake PLATFORM=x64 NEW_COMPILER=1 MY_DYNAMIC_LINK=1

copy Bundles\Alone7z\x64\7zr.exe %LIBRARY_PREFIX%\bin\7zr.exe
copy Bundles\Alone\x64\7za.exe %LIBRARY_PREFIX%\bin\7za.exe
copy UI\Console\x64\7z.exe %LIBRARY_PREFIX%\bin\7z.exe

for /d %%G in (Bundles\Format*) do (
    echo Copying from %%G\x64\
    ls %%G\x64\
    copy "%%G\x64\*.lib" "%PREFIX%\Library\lib\" /Y
    copy "%%G\x64\*.dll" "%PREFIX%\Library\bin\" /Y
)
