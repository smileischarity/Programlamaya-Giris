# BMP Genişletme Aracı - Windows 7 32-bit (Python 3.8+)

Bu araç, BMP dosyalarının genişliğini 1 piksel artırır ve sağ tarafa mavi (R:0, G:0, B:255) renkli bir piksel ekler.

## Özellikler

- ✅ Sadece .bmp dosyaları için çalışır
- ✅ Sağ tık menüsüne "+1 piksel sağ kısma" seçeneği ekler
- ✅ Dosyanın genişliğini 1 piksel artırır
- ✅ Sağ tarafa mavi (R:0, G:0, B:255) piksel ekler
- ✅ Orijinal dosyayı otomatik yedekler (.yedek uzantılı)
- ✅ Python 3.8+ ile çalışır (derleme gerektirmez)

## Gereksinimler

- Python 3.8 veya üzeri
- Pillow kütüphanesi (otomatik kurulur)

## Kurulum

### Yöntem 1: Otomatik Kurulum (Önerilen)

1. **Pillow kütüphanesini kurun (eğer yoksa):**
   - `PillowKur.bat` dosyasını çalıştırın
   - Veya manuel: `python -m pip install Pillow`

2. **Ana kurulumu yapın:**
   - `BmpGenisletKur.bat` dosyasına sağ tıklayın
   - "Yönetici olarak çalıştır" seçeneğini seçin
   - Script otomatik olarak:
     - Pillow'un kurulu olduğunu kontrol eder (yoksa kurar)
     - Programı `C:\Program Files\BmpGenislet\` dizinine kopyalar
     - Sağ tık menüsünü ekler

### Yöntem 2: Manuel Kurulum

1. **Pillow kütüphanesini kurun:**
   ```bash
   python -m pip install Pillow
   ```

2. **Dosyaları kopyalayın:**
   - `BmpGenislet.py` → `C:\Program Files\BmpGenislet\`
   - `BmpGenislet.bat` → `C:\Program Files\BmpGenislet\`

3. **Sağ tık menüsünü ekleyin:**
   - `SagTikMenuEkle.bat` dosyasını düzenleyip yolu güncelleyin
   - Yönetici olarak çalıştırın

### Yöntem 3: Registry Dosyası ile

1. `SagTikMenuEkle.reg` dosyasını düzenleyin
2. `BmpGenislet.bat` yolunu kendi kurulum konumunuza göre değiştirin
3. Dosyaya çift tıklayarak kayıt defterine ekleyin

## Kullanım

1. Herhangi bir `.bmp` dosyasına sağ tıklayın
2. "+1 piksel sağ kısma" seçeneğini seçin
3. Program çalışacak ve:
   - Dosyanın genişliği 1 piksel artacak
   - Sağ tarafa mavi piksel eklenecek
   - Orijinal dosya `.bmp.yedek` olarak kaydedilecek

## Dosyalar

- **BmpGenislet.py** - Python scripti (Pillow kullanır, önerilen)
- **BmpGenislet.bat** - Python scriptini çalıştıran wrapper batch dosyası
- **BmpGenislet.cs** - C# kaynak kodu (System.Drawing kullanır, alternatif)
- **BmpGenislet.cpp** - C++ kaynak kodu (Windows API kullanır, alternatif)
- **BmpGenisletKur.bat** - Otomatik kurulum scripti (Python versiyonu için)
- **PillowKur.bat** - Pillow kütüphanesini kurma scripti
- **SagTikMenuEkle.bat** - Sağ tık menüsü ekleme scripti
- **SagTikMenuKaldir.bat** - Sağ tık menüsü kaldırma scripti
- **SagTikMenuEkle.reg** - Registry dosyası

## Python Versiyonu (Önerilen)

Python 3.8+ kurulu olduğu için derleme gerektirmez. Sadece Pillow kütüphanesi kurulmalıdır:

```bash
python -m pip install Pillow
```

veya `PillowKur.bat` dosyasını çalıştırın.

## Alternatif: C# veya C++ Versiyonları

Eğer Python kullanmak istemiyorsanız, C# veya C++ versiyonlarını derleyebilirsiniz:

### C# Versiyonu (.NET Framework gerekir)

```bash
csc /target:exe /out:BmpGenislet.exe BmpGenislet.cs
```

### C++ Versiyonu (Visual Studio gerekir)

```bash
cl BmpGenislet.cpp /Fe:BmpGenislet.exe
```

## Kaldırma

1. `SagTikMenuKaldir.bat` dosyasını Yönetici olarak çalıştırın
2. İsterseniz `C:\Program Files\BmpGenislet\` dizinini manuel olarak silebilirsiniz

## Teknik Detaylar

- **Desteklenen format:** Tüm BMP formatları (Pillow otomatik dönüştürür)
- **Renk formatı:** RGB
- **Yedekleme:** Orijinal dosya `.bmp.yedek` uzantısıyla yedeklenir
- **Windows sürümü:** Windows 7 32-bit (diğer Windows sürümlerinde de çalışabilir)
- **Python versiyonu:** 3.8+
- **Kütüphane:** Pillow (PIL)

## Sorun Giderme

### "Dosya bulunamadı" hatası
- BmpGenislet.exe'nin doğru konumda olduğundan emin olun
- Registry'deki yol ayarını kontrol edin

### "BMP dosyası okunamadı" hatası
- Dosyanın gerçekten BMP formatında olduğundan emin olun
- Dosyanın bozuk olmadığını kontrol edin
- Pillow kütüphanesinin kurulu olduğundan emin olun: `python -c "import PIL"`

### "Pillow bulunamadı" hatası
- Pillow kütüphanesini kurun: `python -m pip install Pillow`
- Veya `PillowKur.bat` dosyasını çalıştırın

### Menü görünmüyor
- Windows Explorer'ı yeniden başlatın (Görev Yöneticisi > explorer.exe > Sonlandır > Yeni Görev > explorer)
- Registry değişikliklerinin doğru yapıldığından emin olun
- Yönetici yetkileriyle çalıştırdığınızdan emin olun

## Lisans

Bu araç örnek amaçlıdır. İstediğiniz gibi kullanabilir ve değiştirebilirsiniz.
