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

### ⭐ Yöntem 1: Kullanıcı Dizinine Kurulum (ÖNERİLEN - Yönetici İzni GEREKTİRMEZ)

**"Öğeye erişmek için gereken izinler yok" hatası alıyorsanız bu yöntemi kullanın!**

1. **Pillow kütüphanesini kurun (eğer yoksa):**
   - `PillowKur.bat` dosyasını çalıştırın
   - Veya manuel: `python -m pip install Pillow`

2. **Ana kurulumu yapın:**
   - `BmpGenisletKurKullanici.bat` dosyasını çift tıklayarak çalıştırın
   - **Yönetici izni gerektirmez!**
   - Script otomatik olarak:
     - Pillow'un kurulu olduğunu kontrol eder (yoksa kurar)
     - Programı `%USERPROFILE%\BmpGenislet\` dizinine kopyalar (örn: `C:\Users\KullaniciAdi\BmpGenislet\`)
     - Sağ tık menüsünü ekler (sadece mevcut kullanıcı için)

### Yöntem 2: Program Files'e Kurulum (Yönetici İzni GEREKTİRİR)

1. **Pillow kütüphanesini kurun (eğer yoksa):**
   - `PillowKur.bat` dosyasını çalıştırın
   - Veya manuel: `python -m pip install Pillow`

2. **Ana kurulumu yapın:**
   - `BmpGenisletKur.bat` dosyasına sağ tıklayın
   - **"Yönetici olarak çalıştır"** seçeneğini seçin
   - Script otomatik olarak:
     - Pillow'un kurulu olduğunu kontrol eder (yoksa kurar)
     - Programı `C:\Program Files\BmpGenislet\` dizinine kopyalar
     - Sağ tık menüsünü ekler

### Yöntem 3: Manuel Kurulum

1. **Pillow kütüphanesini kurun:**
   ```bash
   python -m pip install Pillow
   ```

2. **Dosyaları kopyalayın:**
   - Kullanıcı dizinine: `%USERPROFILE%\BmpGenislet\` (yönetici izni gerektirmez)
   - Veya Program Files'e: `C:\Program Files\BmpGenislet\` (yönetici izni gerekir)

3. **Sağ tık menüsünü ekleyin:**
   - Kullanıcı dizini için: `SagTikMenuEkleKullanici.bat` (yönetici izni gerektirmez)
   - Program Files için: `SagTikMenuEkle.bat` (yönetici olarak çalıştırın)

### Yöntem 4: Registry Dosyası ile

**Kullanıcı dizini versiyonu (yönetici izni gerektirmez):**
1. `SagTikMenuEkleKullanici.reg` dosyasını düzenleyin
2. `BmpGenislet.bat` yolunu kendi kurulum konumunuza göre değiştirin
3. Dosyaya çift tıklayarak kayıt defterine ekleyin

**Program Files versiyonu (yönetici izni gerekir):**
1. `SagTikMenuEkle.reg` dosyasını düzenleyin
2. `BmpGenislet.bat` yolunu kendi kurulum konumunuza göre değiştirin
3. Dosyaya sağ tıklayıp "Yönetici olarak çalıştır" seçeneğini seçin

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

**Kurulum Scriptleri:**
- **BmpGenisletKurKullanici.bat** - ⭐ Kullanıcı dizinine kurulum (YÖNETİCİ İZNİ GEREKTİRMEZ - ÖNERİLEN)
- **BmpGenisletKur.bat** - Program Files'e kurulum (Yönetici izni gerekir)
- **PillowKur.bat** - Pillow kütüphanesini kurma scripti

**Sağ Tık Menüsü Scriptleri (Kullanıcı Dizini - Yönetici İzni GEREKTİRMEZ):**
- **SagTikMenuEkleKullanici.bat** - Sağ tık menüsü ekleme (kullanıcı dizini)
- **SagTikMenuKaldirKullanici.bat** - Sağ tık menüsü kaldırma (kullanıcı dizini)
- **SagTikMenuEkleKullanici.reg** - Registry dosyası (kullanıcı dizini)

**Sağ Tık Menüsü Scriptleri (Program Files - Yönetici İzni GEREKTİRİR):**
- **SagTikMenuEkle.bat** - Sağ tık menüsü ekleme (Program Files)
- **SagTikMenuKaldir.bat** - Sağ tık menüsü kaldırma (Program Files)
- **SagTikMenuEkle.reg** - Registry dosyası (Program Files)

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

### "Öğeye erişmek için gereken izinler yok" hatası
- **Çözüm:** `BmpGenisletKurKullanici.bat` dosyasını kullanın (yönetici izni gerektirmez)
- Bu script programı kullanıcı dizinine kurar ve HKEY_CURRENT_USER kullanarak menü ekler
- Alternatif: `BmpGenisletKur.bat` dosyasına sağ tıklayıp **"Yönetici olarak çalıştır"** seçeneğini seçin

### "Dosya bulunamadı" hatası
- BmpGenislet.bat'ın doğru konumda olduğundan emin olun
- Registry'deki yol ayarını kontrol edin
- Kullanıcı dizini versiyonu kullanıyorsanız: `%USERPROFILE%\BmpGenislet\BmpGenislet.bat`

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
