@echo off
REM Windows 7 32-bit için BMP Dosyalarına Sağ Tık Menüsüne Öğe Ekleme Scripti
REM Bu scripti Yönetici olarak çalıştırmanız gerekmektedir

echo ========================================
echo BMP Dosyalari Icin Sag Tik Menusu Ekleme
echo Windows 7 32-bit icin
echo ========================================
echo.

REM BmpGenislet.bat wrapper'ının yolunu ayarla
REM NOT: Bu yolu kendi kurulum konumunuza göre değiştirin
set BMPGENISLET_YOLU=%~dp0BmpGenislet.bat

REM Eğer mevcut dizinde yoksa, varsayılan kurulum yolunu kullan
if not exist "%BMPGENISLET_YOLU%" (
    set BMPGENISLET_YOLU=C:\Program Files\BmpGenislet\BmpGenislet.bat
)

REM BMP dosyalarına sağ tık menüsüne öğe ekleme
echo BMP dosyalarina sag tik menusu ogesi ekleniyor...
reg add "HKEY_CLASSES_ROOT\bmpfile\shell\BmpGenislet" /ve /d "+1 piksel sag kisma" /f >nul 2>&1
reg add "HKEY_CLASSES_ROOT\bmpfile\shell\BmpGenislet" /v "Icon" /d "shell32.dll,1" /f >nul 2>&1
reg add "HKEY_CLASSES_ROOT\bmpfile\shell\BmpGenislet\command" /ve /d "\"%BMPGENISLET_YOLU%\" \"%%1\"" /f >nul 2>&1

if %errorlevel%==0 (
    echo ✓ BMP dosyalari icin oge eklendi
    echo   Menu metni: "+1 piksel sag kisma"
    echo   Program yolu: %BMPGENISLET_YOLU%
) else (
    echo ✗ Hata: BMP dosyalari icin oge eklenemedi
    echo   Lutfen scripti Yonetici olarak calistirdiginizdan emin olun.
)

echo.
echo ========================================
echo Islem tamamlandi!
echo ========================================
echo.
echo Not: Değişikliklerin etkili olması için Windows Explorer'ı yeniden başlatmanız gerekebilir.
echo      Görev Yöneticisi'nden explorer.exe'yi sonlandırıp yeniden başlatabilirsiniz.
echo.
echo UYARI: BmpGenislet.exe dosyasının doğru konumda olduğundan emin olun!
echo        Şu anki yol: %BMPGENISLET_YOLU%
echo.
pause
