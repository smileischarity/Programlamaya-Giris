@echo off
REM BmpGenislet.exe'yi kurulum dizinine kopyalama ve sağ tık menüsünü ekleme scripti
REM Bu scripti Yönetici olarak çalıştırmanız gerekmektedir

echo ========================================
echo BmpGenislet Kurulum Scripti
echo Windows 7 32-bit icin
echo ========================================
echo.

REM Kurulum dizinini oluştur
set KURULUM_DIZINI=C:\Program Files\BmpGenislet

echo [1/3] Kurulum dizini olusturuluyor...
if not exist "%KURULUM_DIZINI%" (
    mkdir "%KURULUM_DIZINI%" >nul 2>&1
    if %errorlevel%==0 (
        echo ✓ Kurulum dizini olusturuldu: %KURULUM_DIZINI%
    ) else (
        echo ✗ Hata: Kurulum dizini olusturulamadi
        echo   Lutfen scripti Yonetici olarak calistirdiginizdan emin olun.
        pause
        exit /b 1
    )
) else (
    echo ✓ Kurulum dizini zaten mevcut
)

REM BmpGenislet.exe'yi kopyala
echo [2/3] BmpGenislet.exe kopyalaniyor...
if exist "%~dp0BmpGenislet.exe" (
    copy /Y "%~dp0BmpGenislet.exe" "%KURULUM_DIZINI%\" >nul 2>&1
    if %errorlevel%==0 (
        echo ✓ BmpGenislet.exe kopyalandi
    ) else (
        echo ✗ Hata: BmpGenislet.exe kopyalanamadi
        pause
        exit /b 1
    )
) else (
    echo ✗ Hata: BmpGenislet.exe bulunamadi
    echo   Lutfen bu scripti BmpGenislet.exe ile ayni dizinde calistirin.
    pause
    exit /b 1
)

REM Sağ tık menüsünü ekle
echo [3/3] Sag tik menusu ekleniyor...
reg add "HKEY_CLASSES_ROOT\bmpfile\shell\BmpGenislet" /ve /d "+1 piksel sag kisma" /f >nul 2>&1
reg add "HKEY_CLASSES_ROOT\bmpfile\shell\BmpGenislet" /v "Icon" /d "shell32.dll,1" /f >nul 2>&1
reg add "HKEY_CLASSES_ROOT\bmpfile\shell\BmpGenislet\command" /ve /d "\"%KURULUM_DIZINI%\\BmpGenislet.exe\" \"%%1\"" /f >nul 2>&1

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
echo BmpGenislet.exe kuruldu: %KURULUM_DIZINI%
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
