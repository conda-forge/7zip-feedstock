cd CPP\7zip
nmake PLATFORM=x64 NEW_COMPILER=1 MY_DYNAMIC_LINK=1

copy *\*\x64\7z*.exe %LIBRARY_PREFIX%\bin\
copy Bundles\Format*\x64\*.dll %LIBRARY_PREFIX%\bin\

echo Source
attrib /s /d

echo Installation
attrib /s /d %LIBRARY_PREFIX%
