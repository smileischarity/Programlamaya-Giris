@echo off
REM Windows 7 32-bit için BMP Dosyalarına Sağ Tık Menüsüne Öğe Ekleme Scripti (Kullanıcı Dizini)
REM Bu script YÖNETİCİ İZNİ GEREKTİRMEZ
REM HKEY_CURRENT_USER kullanarak sadece mevcut kullanıcı için ekler

echo ========================================
echo BMP Dosyalari Icin Sag Tik Menusu Ekleme
echo Windows 7 32-bit icin (Kullanici Dizini)
echo Yonetici izni GEREKTIRMEZ
echo ========================================
echo.

REM BmpGenislet.bat wrapper'ının yolunu ayarla
REM Önce kullanıcı dizininde ara, sonra mevcut dizinde, sonra Program Files'te
set BMPGENISLET_YOLU=%USERPROFILE%\BmpGenislet\BmpGenislet.bat

if not exist "%BMPGENISLET_YOLU%" (
    set BMPGENISLET_YOLU=%~dp0BmpGenislet.bat
)

if not exist "%BMPGENISLET_YOLU%" (
    set BMPGENISLET_YOLU=C:\Program Files\BmpGenislet\BmpGenislet.bat
)

REM Dosyanın var olup olmadığını kontrol et
if not exist "%BMPGENISLET_YOLU%" (
    echo ✗ Hata: BmpGenislet.bat bulunamadi!
    echo   Lutfen once BmpGenisletKurKullanici.bat dosyasini calistirin.
    pause
    exit /b 1
)

REM BMP dosyalarına sağ tık menüsüne öğe ekleme (HKEY_CURRENT_USER kullanarak)
echo BMP dosyalarina sag tik menusu ogesi ekleniyor...
reg add "HKEY_CURRENT_USER\Software\Classes\bmpfile\shell\BmpGenislet" /ve /d "+1 piksel sag kisma" /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Classes\bmpfile\shell\BmpGenislet" /v "Icon" /d "shell32.dll,1" /f >nul 2>&1
reg add "HKEY_CURRENT_USER\Software\Classes\bmpfile\shell\BmpGenislet\command" /ve /d "\"%BMPGENISLET_YOLU%\" \"%%1\"" /f >nul 2>&1

if %errorlevel%==0 (
    echo ✓ BMP dosyalari icin oge eklendi
    echo   Menu metni: "+1 piksel sag kisma"
    echo   Program yolu: %BMPGENISLET_YOLU%
) else (
    echo ✗ Hata: BMP dosyalari icin oge eklenemedi
    echo   Lutfen scripti dogru calistirdiginizdan emin olun.
)

echo.
echo ========================================
echo Islem tamamlandi!
echo ========================================
echo.
echo Not: Değişikliklerin etkili olması için Windows Explorer'ı yeniden başlatmanız gerekebilir.
echo      Görev Yöneticisi'nden explorer.exe'yi sonlandırıp yeniden başlatabilirsiniz.
echo.
echo UYARI: BmpGenislet.bat dosyasının doğru konumda olduğundan emin olun!
echo        Şu anki yol: %BMPGENISLET_YOLU%
echo.
pause
