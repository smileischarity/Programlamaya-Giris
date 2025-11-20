# "Öğeye erişmek için gereken izinler yok" Hatası Çözümü

Bu hata genellikle Windows'ta kayıt defterine (Registry) veya sistem dizinlerine yazma izni olmadığında oluşur.

## ⭐ Hızlı Çözüm (Önerilen)

**Yönetici izni gerektirmeyen kurulum yöntemini kullanın:**

1. `BmpGenisletKurKullanici.bat` dosyasını çift tıklayarak çalıştırın
2. Bu script:
   - Programı kullanıcı dizininize kurar (`%USERPROFILE%\BmpGenislet\`)
   - HKEY_CURRENT_USER kullanarak sadece sizin kullanıcı hesabınız için menü ekler
   - **Yönetici izni gerektirmez!**

## Neden Bu Hata Oluşur?

1. **Program Files dizinine yazma izni yok:**
   - `C:\Program Files\` dizinine yazmak için yönetici izni gerekir
   - Çözüm: Kullanıcı dizinine kurulum yapın

2. **HKEY_CLASSES_ROOT'a yazma izni yok:**
   - Sistem genelinde kayıt defteri değişiklikleri için yönetici izni gerekir
   - Çözüm: HKEY_CURRENT_USER kullanın (sadece mevcut kullanıcı için)

## Kurulum Yöntemleri Karşılaştırması

| Özellik | Kullanıcı Dizini | Program Files |
|---------|----------------|---------------|
| Yönetici İzni | ❌ Gerekmez | ✅ Gerekir |
| Kurulum Yeri | `%USERPROFILE%\BmpGenislet\` | `C:\Program Files\BmpGenislet\` |
| Menü Kapsamı | Sadece mevcut kullanıcı | Tüm kullanıcılar |
| Script | `BmpGenisletKurKullanici.bat` | `BmpGenisletKur.bat` |

## Adım Adım Çözüm

### Çözüm 1: Kullanıcı Dizinine Kurulum (Önerilen)

1. **Pillow kütüphanesini kurun:**
   ```
   python -m pip install Pillow
   ```
   veya `PillowKur.bat` dosyasını çalıştırın

2. **Ana kurulumu yapın:**
   - `BmpGenisletKurKullanici.bat` dosyasını çift tıklayın
   - **Yönetici izni gerektirmez!**
   - Program `%USERPROFILE%\BmpGenislet\` dizinine kurulur

3. **Kullanım:**
   - Herhangi bir `.bmp` dosyasına sağ tıklayın
   - "+1 piksel sağ kısma" seçeneğini seçin

### Çözüm 2: Program Files'e Kurulum (Yönetici İzni Gerekir)

1. **Pillow kütüphanesini kurun:**
   ```
   python -m pip install Pillow
   ```

2. **Ana kurulumu yapın:**
   - `BmpGenisletKur.bat` dosyasına **sağ tıklayın**
   - **"Yönetici olarak çalıştır"** seçeneğini seçin
   - UAC (Kullanıcı Hesabı Denetimi) penceresinde "Evet" deyin

## Hangi Yöntemi Seçmeliyim?

- ✅ **Kullanıcı Dizini:** Yönetici izni yoksa veya sadece kendi hesabınız için kullanacaksanız
- ✅ **Program Files:** Tüm kullanıcılar için kurmak istiyorsanız ve yönetici izniniz varsa

## Sorun Devam Ederse

1. **Windows Explorer'ı yeniden başlatın:**
   - Görev Yöneticisi'ni açın (Ctrl+Shift+Esc)
   - explorer.exe'yi bulun
   - Sağ tıklayıp "Sonlandır" seçin
   - Dosya > Yeni Görev > `explorer` yazıp Enter'a basın

2. **Manuel kontrol:**
   - `regedit` komutunu çalıştırın
   - `HKEY_CURRENT_USER\Software\Classes\bmpfile\shell\BmpGenislet` anahtarına gidin
   - Değerlerin doğru olduğundan emin olun

3. **Dosya yolunu kontrol edin:**
   - `%USERPROFILE%\BmpGenislet\BmpGenislet.bat` dosyasının var olduğundan emin olun
   - Dosya yolunda Türkçe karakter veya özel karakter varsa sorun çıkarabilir

## İletişim

Sorun devam ederse, hata mesajının tamamını ve hangi scripti çalıştırdığınızı not edin.
