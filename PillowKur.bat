@echo off
REM Pillow kütüphanesini kurma scripti
REM Python 3.8+ gerektirir

echo ========================================
echo Pillow Kutuphanesi Kurulumu
echo ========================================
echo.

REM Python'un kurulu olup olmadığını kontrol et
where python >nul 2>&1
if %errorlevel% neq 0 (
    echo ✗ Hata: Python bulunamadi!
    echo   Lutfen Python 3.8 veya uzeri bir surumun kurulu oldugundan emin olun.
    pause
    exit /b 1
)

REM Python versiyonunu göster
for /f "tokens=2" %%i in ('python --version 2^>^&1') do set PYTHON_VERSION=%%i
echo Python versiyonu: %PYTHON_VERSION%
echo.

REM Pillow'un zaten kurulu olup olmadığını kontrol et
python -c "import PIL" >nul 2>&1
if %errorlevel%==0 (
    echo ✓ Pillow kutuphanesi zaten kurulu
    python -c "import PIL; print('Pillow versiyonu:', PIL.__version__)"
    pause
    exit /b 0
)

echo Pillow kutuphanesi kuruluyor...
echo.

python -m pip install Pillow

if %errorlevel%==0 (
    echo.
    echo ✓ Pillow kutuphanesi basariyla kuruldu!
) else (
    echo.
    echo ✗ Hata: Pillow kutuphanesi kurulamadi
    echo   Lutfen pip'in guncel oldugundan emin olun: python -m pip install --upgrade pip
)

echo.
pause
