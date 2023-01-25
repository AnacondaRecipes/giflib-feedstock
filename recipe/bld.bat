copy %RECIPE_DIR%\\CMakeLists.txt %SRC_DIR%\\CMakeLists.txt
mkdir build
cd build

REM https://github.com/conda/conda-build/issues/2850
REM set "CXXFLAGS=%CXXFLAGS:-GL=%"
REM set "CFLAGS=%CFLAGS:-GL=%"

cmake -G "NMake Makefiles" ^
	  -DCMAKE_INSTALL_PREFIX=%LIBRARY_PREFIX% ^
	  -DCMAKE_BUILD_TYPE=Release ^
	  ..
if errorlevel 1 exit 1

nmake
if errorlevel 1 exit 1

nmake install
if errorlevel 1 exit 13

REM Remove the executable gif2rgb and its associated man page.
REM This executable has a CVE (CVE-2022-28506) that doesn't have a fix yet.
del %LIBRARY_PREFIX%\bin\gif2rgb.exe
del %LIBRARY_PREFIX%\share\man\man1\gif2rgb.1
