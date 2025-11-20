@echo off
REM Windows 7 32-bit için BMP Dosyalarından Sağ Tık Menüsü Öğesini Kaldırma Scripti (Kullanıcı Dizini)
REM Bu script YÖNETİCİ İZNİ GEREKTİRMEZ

echo ========================================
echo BMP Dosyalari Icin Sag Tik Menusu Kaldirma
echo Windows 7 32-bit icin (Kullanici Dizini)
echo Yonetici izni GEREKTIRMEZ
echo ========================================
echo.

REM BMP dosyalarından sağ tık menüsü öğesini kaldırma (HKEY_CURRENT_USER'dan)
echo BMP dosyalarindan sag tik menusu ogesi kaldiriliyor...
reg delete "HKEY_CURRENT_USER\Software\Classes\bmpfile\shell\BmpGenislet" /f >nul 2>&1

if %errorlevel%==0 (
    echo ✓ BMP dosyalari icin oge kaldirildi
) else (
    echo ✗ Oge bulunamadi veya zaten kaldirilmis
)

echo.
echo ========================================
echo Islem tamamlandi!
echo ========================================
echo.
echo Not: Değişikliklerin etkili olması için Windows Explorer'ı yeniden başlatmanız gerekebilir.
echo      Görev Yöneticisi'nden explorer.exe'yi sonlandırıp yeniden başlatabilirsiniz.
echo.
pause
