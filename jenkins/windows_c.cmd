@REM Copyright (c) Microsoft. All rights reserved.
@REM Licensed under the MIT license. See LICENSE file in the project root for full license information.

setlocal

set build-root=%~dp0..
rem // resolve to fully qualified path
for %%i in ("%build-root%") do set build-root=%%~fi

cd %build-root%

mkdir %build-root%\cmake
pushd %build-root%\cmake
if not ERRORLEVEL==0 exit /b ERRORLEVEL

cmake -DENABLE_UNIT_TESTS=ON ..
if not ERRORLEVEL==0 exit /b ERRORLEVEL

cmake --build . -- /m /p:Configuration=Release
if not ERRORLEVEL==0 exit /b ERRORLEVEL

cmake --build . -- /m /p:Configuration=Debug
if not ERRORLEVEL==0 exit /b ERRORLEVEL

ctest -C "debug" -V
if not ERRORLEVEL==0 exit /b ERRORLEVEL

popd
