#!/usr/bin/env python
# -*- coding: utf-8 -*-
"""
BMP dosyasının genişliğini 1 piksel artırır ve sağ tarafa mavi (R:0, G:0, B:255) piksel ekler
Windows 7 32-bit için uyumludur
Python 3.8+ gerektirir
"""

import sys
import os
from PIL import Image

def genislet_bmp(dosya_yolu):
    """
    BMP dosyasının genişliğini 1 piksel artırır ve sağ tarafa mavi piksel ekler
    
    Args:
        dosya_yolu: İşlenecek BMP dosyasının yolu
        
    Returns:
        0: Başarılı
        1: Hata
    """
    try:
        # Dosyanın var olup olmadığını kontrol et
        if not os.path.exists(dosya_yolu):
            print(f"Hata: Dosya bulunamadı: {dosya_yolu}")
            return 1
        
        # Dosya uzantısını kontrol et
        uzanti = os.path.splitext(dosya_yolu)[1].lower()
        if uzanti != '.bmp':
            print("Hata: Bu program sadece .bmp dosyaları için çalışır.")
            return 1
        
        # BMP dosyasını aç
        try:
            img = Image.open(dosya_yolu)
        except Exception as e:
            print(f"Hata: BMP dosyası okunamadı: {e}")
            return 1
        
        # RGB moduna dönüştür (eğer değilse)
        if img.mode != 'RGB':
            img = img.convert('RGB')
        
        eski_genislik = img.width
        yukseklik = img.height
        yeni_genislik = eski_genislik + 1
        
        # Yeni görüntü oluştur (1 piksel daha geniş)
        yeni_img = Image.new('RGB', (yeni_genislik, yukseklik))
        
        # Mavi renk (R:0, G:0, B:255)
        mavi_renk = (0, 0, 255)
        
        # Orijinal pikselleri kopyala
        yeni_img.paste(img, (0, 0))
        
        # Sağ tarafa mavi piksel ekle
        for y in range(yukseklik):
            yeni_img.putpixel((eski_genislik, y), mavi_renk)
        
        # Orijinal dosyayı yedekle
        yedek_dosya_yolu = dosya_yolu + '.yedek'
        if os.path.exists(yedek_dosya_yolu):
            os.remove(yedek_dosya_yolu)
        os.rename(dosya_yolu, yedek_dosya_yolu)
        
        # Yeni görüntüyü kaydet
        yeni_img.save(dosya_yolu, 'BMP')
        
        # Kaynakları temizle
        img.close()
        yeni_img.close()
        
        print("Başarılı!")
        print(f"Dosya genişliği {eski_genislik} pikselden {yeni_genislik} piksele çıkarıldı.")
        print(f"Sağ tarafa mavi (R:0, G:0, B:255) piksel eklendi.")
        print(f"Orijinal dosya yedeklendi: {yedek_dosya_yolu}")
        
        return 0
        
    except Exception as e:
        print(f"Beklenmeyen hata: {e}")
        import traceback
        traceback.print_exc()
        return 1

if __name__ == '__main__':
    if len(sys.argv) < 2:
        print("Kullanım: BmpGenislet.py <bmp_dosya_yolu>")
        print("Örnek: BmpGenislet.py C:\\resim.bmp")
        sys.exit(1)
    
    dosya_yolu = sys.argv[1]
    sys.exit(genislet_bmp(dosya_yolu))
