cd CPP\7zip
nmake PLATFORM=x64 NEW_COMPILER=1 MY_DYNAMIC_LINK=1

copy Bundles\Alone7z\x64\7zr.exe %LIBRARY_PREFIX%\bin\7zr.exe
copy Bundles\Alone\x64\7za.exe %LIBRARY_PREFIX%\bin\7za.exe
copy UI\Console\x64\7z.exe %LIBRARY_PREFIX%\bin\7z.exe

copy Bundles\Format7z\x64\7za.dll %LIBRARY_PREFIX%\bin\7za.dll
copy Bundles\Format7zExtract\x64\7zxa.dll %LIBRARY_PREFIX%\bin\7zxa.dll
copy Bundles\Format7zExtractR\x64\7zxr.dll %LIBRARY_PREFIX%\bin\7zxr.dll
copy Bundles\Format7zF\x64\7z.dll %LIBRARY_PREFIX%\bin\7z.dll
copy Bundles\Format7zR\x64\7zra.dll %LIBRARY_PREFIX%\bin\7zra.dll
