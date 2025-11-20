# BMP Genişletme Aracı - Windows 7 32-bit

Bu araç, BMP dosyalarının genişliğini 1 piksel artırır ve sağ tarafa mavi (R:0, G:0, B:255) renkli bir piksel ekler.

## Özellikler

- ✅ Sadece .bmp dosyaları için çalışır
- ✅ Sağ tık menüsüne "+1 piksel sağ kısma" seçeneği ekler
- ✅ Dosyanın genişliğini 1 piksel artırır
- ✅ Sağ tarafa mavi (R:0, G:0, B:255) piksel ekler
- ✅ Orijinal dosyayı otomatik yedekler (.yedek uzantılı)

## Kurulum

### Yöntem 1: Otomatik Kurulum (Önerilen)

1. `BmpGenisletKur.bat` dosyasına sağ tıklayın
2. "Yönetici olarak çalıştır" seçeneğini seçin
3. Script otomatik olarak:
   - Programı `C:\Program Files\BmpGenislet\` dizinine kopyalar
   - Sağ tık menüsünü ekler

### Yöntem 2: Manuel Kurulum

1. **BmpGenislet.exe'yi derleyin:**
   - C# için: `csc BmpGenislet.cs` (Visual Studio veya .NET Framework SDK gerekir)
   - C++ için: Visual Studio ile derleyin

2. **Programı bir dizine kopyalayın:**
   - Örnek: `C:\Program Files\BmpGenislet\BmpGenislet.exe`

3. **Sağ tık menüsünü ekleyin:**
   - `SagTikMenuEkle.bat` dosyasını düzenleyip BmpGenislet.exe yolunu güncelleyin
   - Yönetici olarak çalıştırın

### Yöntem 3: Registry Dosyası ile

1. `SagTikMenuEkle.reg` dosyasını düzenleyin
2. `BmpGenislet.exe` yolunu kendi kurulum konumunuza göre değiştirin
3. Dosyaya çift tıklayarak kayıt defterine ekleyin

## Kullanım

1. Herhangi bir `.bmp` dosyasına sağ tıklayın
2. "+1 piksel sağ kısma" seçeneğini seçin
3. Program çalışacak ve:
   - Dosyanın genişliği 1 piksel artacak
   - Sağ tarafa mavi piksel eklenecek
   - Orijinal dosya `.bmp.yedek` olarak kaydedilecek

## Dosyalar

- **BmpGenislet.cs** - C# kaynak kodu (System.Drawing kullanır)
- **BmpGenislet.cpp** - C++ kaynak kodu (Windows API kullanır, daha hafif)
- **BmpGenisletKur.bat** - Otomatik kurulum scripti
- **SagTikMenuEkle.bat** - Sağ tık menüsü ekleme scripti
- **SagTikMenuKaldir.bat** - Sağ tık menüsü kaldırma scripti
- **SagTikMenuEkle.reg** - Registry dosyası

## Derleme

### C# Versiyonu (.NET Framework gerekir)

```bash
csc /target:exe /out:BmpGenislet.exe BmpGenislet.cs
```

veya Visual Studio'da:
- Yeni bir Console Application projesi oluşturun
- `BmpGenislet.cs` içeriğini kopyalayın
- System.Drawing referansını ekleyin
- Derleyin

### C++ Versiyonu (Visual Studio gerekir)

```bash
cl BmpGenislet.cpp /Fe:BmpGenislet.exe
```

veya Visual Studio'da:
- Yeni bir Win32 Console Application projesi oluşturun
- `BmpGenislet.cpp` içeriğini kopyalayın
- Derleyin

## Kaldırma

1. `SagTikMenuKaldir.bat` dosyasını Yönetici olarak çalıştırın
2. İsterseniz `C:\Program Files\BmpGenislet\` dizinini manuel olarak silebilirsiniz

## Teknik Detaylar

- **Desteklenen format:** 24-bit BMP dosyaları
- **Renk formatı:** RGB (BGR byte sırası)
- **Yedekleme:** Orijinal dosya `.bmp.yedek` uzantısıyla yedeklenir
- **Windows sürümü:** Windows 7 32-bit (diğer Windows sürümlerinde de çalışabilir)

## Sorun Giderme

### "Dosya bulunamadı" hatası
- BmpGenislet.exe'nin doğru konumda olduğundan emin olun
- Registry'deki yol ayarını kontrol edin

### "BMP dosyası okunamadı" hatası
- Dosyanın gerçekten BMP formatında olduğundan emin olun
- Dosyanın bozuk olmadığını kontrol edin
- 24-bit BMP formatında olduğundan emin olun

### Menü görünmüyor
- Windows Explorer'ı yeniden başlatın (Görev Yöneticisi > explorer.exe > Sonlandır > Yeni Görev > explorer)
- Registry değişikliklerinin doğru yapıldığından emin olun
- Yönetici yetkileriyle çalıştırdığınızdan emin olun

## Lisans

Bu araç örnek amaçlıdır. İstediğiniz gibi kullanabilir ve değiştirebilirsiniz.
