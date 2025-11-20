@echo off
REM Windows 7 32-bit için Sağ Tık Menüsüne Öğe Ekleme Scripti
REM Bu scripti Yönetici olarak çalıştırmanız gerekmektedir

echo ========================================
echo Sağ Tık Menusu Ogeleri Ekleme Scripti
echo Windows 7 32-bit icin
echo ========================================
echo.

REM Dosyalara sağ tık menüsüne öğe ekleme
echo [1/3] Dosyalara sağ tık menüsü öğesi ekleniyor...
reg add "HKEY_CLASSES_ROOT\*\shell\OzelIslem" /ve /d "Özel İşlem" /f >nul 2>&1
reg add "HKEY_CLASSES_ROOT\*\shell\OzelIslem" /v "Icon" /d "shell32.dll,0" /f >nul 2>&1
reg add "HKEY_CLASSES_ROOT\*\shell\OzelIslem\command" /ve /d "cmd.exe /c echo Seçilen dosya: %%1 && pause" /f >nul 2>&1
if %errorlevel%==0 (echo ✓ Dosyalar için öğe eklendi) else (echo ✗ Hata: Dosyalar için öğe eklenemedi)

REM Klasörlere sağ tık menüsüne öğe ekleme
echo [2/3] Klasörlere sağ tık menüsü öğesi ekleniyor...
reg add "HKEY_CLASSES_ROOT\Directory\shell\OzelKlasorIslemi" /ve /d "Özel Klasör İşlemi" /f >nul 2>&1
reg add "HKEY_CLASSES_ROOT\Directory\shell\OzelKlasorIslemi" /v "Icon" /d "shell32.dll,3" /f >nul 2>&1
reg add "HKEY_CLASSES_ROOT\Directory\shell\OzelKlasorIslemi\command" /ve /d "cmd.exe /c echo Seçilen klasör: %%1 && pause" /f >nul 2>&1
if %errorlevel%==0 (echo ✓ Klasörler için öğe eklendi) else (echo ✗ Hata: Klasörler için öğe eklenemedi)

REM Boş alana sağ tık menüsüne öğe ekleme
echo [3/3] Boş alana sağ tık menüsü öğesi ekleniyor...
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\OzelBosAlan" /ve /d "Özel Boş Alan İşlemi" /f >nul 2>&1
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\OzelBosAlan" /v "Icon" /d "shell32.dll,4" /f >nul 2>&1
reg add "HKEY_CLASSES_ROOT\Directory\Background\shell\OzelBosAlan\command" /ve /d "cmd.exe /c echo Mevcut klasör: %%V && pause" /f >nul 2>&1
if %errorlevel%==0 (echo ✓ Boş alan için öğe eklendi) else (echo ✗ Hata: Boş alan için öğe eklenemedi)

echo.
echo ========================================
echo İşlem tamamlandı!
echo ========================================
echo.
echo Not: Değişikliklerin etkili olması için Windows Explorer'ı yeniden başlatmanız gerekebilir.
echo      Görev Yöneticisi'nden explorer.exe'yi sonlandırıp yeniden başlatabilirsiniz.
echo.
pause
