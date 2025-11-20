@echo off
REM Windows 7 32-bit için Sağ Tık Menüsünden Öğe Kaldırma Scripti
REM Bu scripti Yönetici olarak çalıştırmanız gerekmektedir

echo ========================================
echo Sağ Tık Menusu Ogeleri Kaldirma Scripti
echo Windows 7 32-bit icin
echo ========================================
echo.

REM Dosyalardan sağ tık menüsü öğesini kaldırma
echo [1/3] Dosyalardan sağ tık menüsü öğesi kaldırılıyor...
reg delete "HKEY_CLASSES_ROOT\*\shell\OzelIslem" /f >nul 2>&1
if %errorlevel%==0 (echo ✓ Dosyalar için öğe kaldırıldı) else (echo ✗ Öğe bulunamadı veya zaten kaldırılmış)

REM Klasörlerden sağ tık menüsü öğesini kaldırma
echo [2/3] Klasörlerden sağ tık menüsü öğesi kaldırılıyor...
reg delete "HKEY_CLASSES_ROOT\Directory\shell\OzelKlasorIslemi" /f >nul 2>&1
if %errorlevel%==0 (echo ✓ Klasörler için öğe kaldırıldı) else (echo ✗ Öğe bulunamadı veya zaten kaldırılmış)

REM Boş alandan sağ tık menüsü öğesini kaldırma
echo [3/3] Boş alandan sağ tık menüsü öğesi kaldırılıyor...
reg delete "HKEY_CLASSES_ROOT\Directory\Background\shell\OzelBosAlan" /f >nul 2>&1
if %errorlevel%==0 (echo ✓ Boş alan için öğe kaldırıldı) else (echo ✗ Öğe bulunamadı veya zaten kaldırılmış)

echo.
echo ========================================
echo İşlem tamamlandı!
echo ========================================
echo.
echo Not: Değişikliklerin etkili olması için Windows Explorer'ı yeniden başlatmanız gerekebilir.
echo      Görev Yöneticisi'nden explorer.exe'yi sonlandırıp yeniden başlatabilirsiniz.
echo.
pause
