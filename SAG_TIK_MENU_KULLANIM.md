# Windows 7 32-bit Sağ Tık Menüsü Özelleştirme Kılavuzu

Bu klasörde Windows 7 32-bit için sağ tık menüsüne öğe ekleme/kaldırma araçları bulunmaktadır.

## Dosyalar

1. **SagTikMenuEkle.reg** - Registry dosyası (çift tıklayarak kullanılabilir)
2. **SagTikMenuEkle.bat** - Batch scripti (Yönetici olarak çalıştırılmalı)
3. **SagTikMenuKaldir.bat** - Öğeleri kaldırmak için batch scripti

## Kullanım Yöntemleri

### Yöntem 1: Registry Dosyası (.reg)

1. `SagTikMenuEkle.reg` dosyasına çift tıklayın
2. "Evet" diyerek kayıt defterine eklemeyi onaylayın
3. Windows Explorer'ı yeniden başlatın (Görev Yöneticisi > explorer.exe > Sonlandır > Yeni Görev > explorer)

### Yöntem 2: Batch Scripti (.bat)

1. `SagTikMenuEkle.bat` dosyasına sağ tıklayın
2. "Yönetici olarak çalıştır" seçeneğini seçin
3. Script otomatik olarak öğeleri ekleyecektir
4. Windows Explorer'ı yeniden başlatın

## Eklenen Öğeler

- **Dosyalar için**: "Özel İşlem" - Herhangi bir dosyaya sağ tıklandığında görünür
- **Klasörler için**: "Özel Klasör İşlemi" - Klasörlere sağ tıklandığında görünür
- **Boş alan için**: "Özel Boş Alan İşlemi" - Klasör içinde boş alana sağ tıklandığında görünür

## Özelleştirme

### Komut Değiştirme

Öğelerin çalıştırdığı komutları değiştirmek için:

**Registry dosyasında:**
```
[HKEY_CLASSES_ROOT\*\shell\OzelIslem\command]
@="cmd.exe /c echo Seçilen dosya: %1 && pause"
```

Bu satırı kendi komutunuzla değiştirin. Örnekler:
- Bir program çalıştırmak: `"C:\Program Files\Uygulama\app.exe" "%1"`
- PowerShell scripti: `powershell.exe -File "C:\Scripts\script.ps1" "%1"`
- Batch dosyası: `"C:\Scripts\script.bat" "%1"`

**Özel Değişkenler:**
- `%1` - Seçilen dosya/klasör yolu
- `%V` - Mevcut klasör yolu (boş alan için)
- `%L` - Uzun dosya yolu

### Menü Adı Değiştirme

Registry dosyasında veya batch scriptinde `@="..."` değerini değiştirin.

### İkon Ekleme

`"Icon"="shell32.dll,0"` satırını değiştirerek farklı ikonlar kullanabilirsiniz:
- `shell32.dll,0` - Dosya ikonu
- `shell32.dll,3` - Klasör ikonu
- `shell32.dll,4` - Klasör açık ikonu
- Özel ikon: `"C:\Yol\ikon.ico"`

## Öğeleri Kaldırma

1. `SagTikMenuKaldir.bat` dosyasına sağ tıklayın
2. "Yönetici olarak çalıştır" seçeneğini seçin
3. Windows Explorer'ı yeniden başlatın

## Notlar

- Windows 7 32-bit için test edilmiştir
- Yönetici yetkileri gerektirir
- Değişikliklerin görünmesi için Windows Explorer'ın yeniden başlatılması gerekebilir
- Registry değişiklikleri sistem genelinde etkilidir

## Güvenlik Uyarısı

Registry değişiklikleri sisteminizi etkileyebilir. Değişiklik yapmadan önce:
1. Sistem geri yükleme noktası oluşturun
2. Registry'yi yedekleyin (regedit > Dosya > Dışa Aktar)
