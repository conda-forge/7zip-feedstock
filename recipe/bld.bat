cd CPP\7zip
nmake PLATFORM=x64 NEW_COMPILER=1 MY_DYNAMIC_LINK=1

copy Bundles\Alone7z\x64\7zr.exe %LIBRARY_PREFIX%\bin\7zr.exe
copy Bundles\Alone\x64\7za.exe %LIBRARY_PREFIX%\bin\7za.exe
copy UI\Console\x64\7z.exe %LIBRARY_PREFIX%\bin\7z.exe

for /d %%G in (dir Bundles\Format*) do copy %%G\x64\*.dll %LIBRARY_PREFIX%\bin\
for /d %%G in (dir Bundles\Format*) do copy %%G\x64\*.lib %LIBRARY_PREFIX%\lib\

echo Source
attrib /s /d

echo Installation
attrib /s /d %LIBRARY_PREFIX%
