@echo off
REM BMP Genişletme için Python scriptini çalıştıran wrapper batch dosyası
REM Python 3.8+ gerektirir

REM Python'un yolunu bul
set PYTHON_EXE=
where python >nul 2>&1
if %errorlevel%==0 (
    for /f "delims=" %%i in ('where python') do set PYTHON_EXE=%%i
)

if "%PYTHON_EXE%"=="" (
    echo Hata: Python bulunamadi!
    echo Lutfen Python 3.8 veya uzeri bir surumun kurulu oldugundan emin olun.
    pause
    exit /b 1
)

REM Script'in yolunu bul
set SCRIPT_YOLU=%~dp0BmpGenislet.py

REM Eğer mevcut dizinde yoksa, varsayılan kurulum yolunu kullan
if not exist "%SCRIPT_YOLU%" (
    set SCRIPT_YOLU=C:\Program Files\BmpGenislet\BmpGenislet.py
)

REM Python scriptini çalıştır
"%PYTHON_EXE%" "%SCRIPT_YOLU%" %*
