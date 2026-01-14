@echo off
REM BmpGenislet Python scriptini kullanıcı dizinine kurma ve sağ tık menüsünü ekleme scripti
REM Bu script YÖNETİCİ İZNİ GEREKTİRMEZ (kullanıcı dizinine kurar)
REM Python 3.8+ ve Pillow kütüphanesi gerektirir

echo ========================================
echo BmpGenislet Kurulum Scripti (Kullanici Dizini)
echo Windows 7 32-bit icin (Python 3.8+)
echo Yonetici izni GEREKTIRMEZ
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

REM Python versiyonunu kontrol et
for /f "tokens=2" %%i in ('python --version 2^>^&1') do set PYTHON_VERSION=%%i
echo ✓ Python bulundu: %PYTHON_VERSION%

REM Pillow kütüphanesinin kurulu olup olmadığını kontrol et
python -c "import PIL" >nul 2>&1
if %errorlevel% neq 0 (
    echo.
    echo [UYARI] Pillow kutuphanesi bulunamadi!
    echo         Pillow kuruluyor...
    python -m pip install Pillow --quiet
    if %errorlevel% neq 0 (
        echo ✗ Hata: Pillow kutuphanesi kurulamadi
        echo   Lutfen manuel olarak kurun: python -m pip install Pillow
        pause
        exit /b 1
    )
    echo ✓ Pillow kutuphanesi kuruldu
) else (
    echo ✓ Pillow kutuphanesi zaten kurulu
)

REM Kullanıcı dizininde kurulum klasörü oluştur
set KURULUM_DIZINI=%USERPROFILE%\BmpGenislet

echo.
echo [1/3] Kurulum dizini olusturuluyor...
if not exist "%KURULUM_DIZINI%" (
    mkdir "%KURULUM_DIZINI%" >nul 2>&1
    if %errorlevel%==0 (
        echo ✓ Kurulum dizini olusturuldu: %KURULUM_DIZINI%
    ) else (
        echo ✗ Hata: Kurulum dizini olusturulamadi
        pause
        exit /b 1
    )
) else (
    echo ✓ Kurulum dizini zaten mevcut
)

REM BmpGenislet.py'yi kopyala
echo [2/3] BmpGenislet.py kopyalaniyor...
if exist "%~dp0BmpGenislet.py" (
    copy /Y "%~dp0BmpGenislet.py" "%KURULUM_DIZINI%\" >nul 2>&1
    if %errorlevel%==0 (
        echo ✓ BmpGenislet.py kopyalandi
    ) else (
        echo ✗ Hata: BmpGenislet.py kopyalanamadi
        pause
        exit /b 1
    )
) else (
    echo ✗ Hata: BmpGenislet.py bulunamadi
    echo   Lutfen bu scripti BmpGenislet.py ile ayni dizinde calistirin.
    pause
    exit /b 1
)

REM BmpGenislet.bat wrapper'ını kopyala
if exist "%~dp0BmpGenislet.bat" (
    copy /Y "%~dp0BmpGenislet.bat" "%KURULUM_DIZINI%\" >nul 2>&1
    echo ✓ BmpGenislet.bat kopyalandi
)

REM Sağ tık menüsünü ekle (HKEY_CURRENT_USER kullanarak - yönetici izni gerektirmez)
echo [3/3] Sag tik menusu ekleniyor...
reg add "HKEY_CURRENT_USER\Software\Classes\bmpfile\shell\BmpGenislet" /ve /d "+1 piksel sag kisma" /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Classes\bmpfile\shell\BmpGenislet" /v "Icon" /d "shell32.dll,1" /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Classes\bmpfile\shell\BmpGenislet\command" /ve /d "\"%KURULUM_DIZINI%\\BmpGenislet.bat\" \"%%1\"" /f >nul 2>&1

if %errorlevel%==0 (
    echo ✓ Sag tik menusu eklendi
) else (
    echo ✗ Hata: Sag tik menusu eklenemedi
    pause
    exit /b 1
)

echo.
echo ========================================
echo Kurulum tamamlandi!
echo ========================================
echo.
echo BmpGenislet kuruldu: %KURULUM_DIZINI%
echo Python versiyonu: %PYTHON_VERSION%
echo.
echo Kullanim:
echo   1. Herhangi bir .bmp dosyasina sag tiklayin
echo   2. "+1 piksel sag kisma" secenegini secin
echo   3. Dosya genisligi 1 piksel artacak ve sag tarafa mavi piksel eklenecek
echo.
echo Not: Degisikliklerin etkili olmasi icin Windows Explorer'i yeniden baslatmaniz gerekebilir.
echo      Gorev Yoneticisi'nden explorer.exe'yi sonlandirip yeniden baslatabilirsiniz.
echo.
pause
