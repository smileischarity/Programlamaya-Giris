#include <windows.h>
#include <stdio.h>
#include <string.h>

// BMP dosya başlık yapıları
#pragma pack(push, 1)
typedef struct {
    WORD  bfType;
    DWORD bfSize;
    WORD  bfReserved1;
    WORD  bfReserved2;
    DWORD bfOffBits;
} BITMAPFILEHEADER;

typedef struct {
    DWORD biSize;
    LONG  biWidth;
    LONG  biHeight;
    WORD  biPlanes;
    WORD  biBitCount;
    DWORD biCompression;
    DWORD biSizeImage;
    LONG  biXPelsPerMeter;
    LONG  biYPelsPerMeter;
    DWORD biClrUsed;
    DWORD biClrImportant;
} BITMAPINFOHEADER;
#pragma pack(pop)

// BMP dosyasını genişlet ve sağ tarafa mavi piksel ekle
int GenisletBmp(const char* dosyaYolu) {
    FILE* dosya = fopen(dosyaYolu, "rb+");
    if (!dosya) {
        printf("Hata: Dosya acilamadi: %s\n", dosyaYolu);
        return 1;
    }

    BITMAPFILEHEADER bmfHeader;
    BITMAPINFOHEADER bmiHeader;

    // Dosya başlığını oku
    if (fread(&bmfHeader, sizeof(BITMAPFILEHEADER), 1, dosya) != 1) {
        printf("Hata: Dosya basligi okunamadi.\n");
        fclose(dosya);
        return 1;
    }

    // BMP dosyası kontrolü
    if (bmfHeader.bfType != 0x4D42) { // "BM"
        printf("Hata: Gecersiz BMP dosyasi.\n");
        fclose(dosya);
        return 1;
    }

    // Bilgi başlığını oku
    if (fread(&bmiHeader, sizeof(BITMAPINFOHEADER), 1, dosya) != 1) {
        printf("Hata: Bilgi basligi okunamadi.\n");
        fclose(dosya);
        return 1;
    }

    int eskiGenislik = bmiHeader.biWidth;
    int yukseklik = abs(bmiHeader.biHeight);
    int yeniGenislik = eskiGenislik + 1;

    // Sadece 24-bit BMP destekleniyor
    if (bmiHeader.biBitCount != 24) {
        printf("Hata: Bu program sadece 24-bit BMP dosyalarini destekler.\n");
        fclose(dosya);
        return 1;
    }

    // Satır başına byte sayısı (4 byte'a hizalanmış)
    int eskiSatirByte = ((eskiGenislik * 3 + 3) / 4) * 4;
    int yeniSatirByte = ((yeniGenislik * 3 + 3) / 4) * 4;

    // Yeni dosya boyutu
    DWORD yeniDosyaBoyutu = sizeof(BITMAPFILEHEADER) + sizeof(BITMAPINFOHEADER) + 
                            (yeniSatirByte * yukseklik);

    // Yedek dosya oluştur
    char yedekDosyaYolu[MAX_PATH];
    strcpy(yedekDosyaYolu, dosyaYolu);
    strcat(yedekDosyaYolu, ".yedek");
    CopyFileA(dosyaYolu, yedekDosyaYolu, FALSE);

    fclose(dosya);

    // Orijinal dosyayı oku
    dosya = fopen(dosyaYolu, "rb");
    if (!dosya) {
        printf("Hata: Dosya tekrar acilamadi.\n");
        return 1;
    }

    // Tüm dosyayı oku
    fseek(dosya, 0, SEEK_END);
    long dosyaBoyutu = ftell(dosya);
    fseek(dosya, 0, SEEK_SET);

    BYTE* eskiVeri = (BYTE*)malloc(dosyaBoyutu);
    if (!eskiVeri) {
        printf("Hata: Bellek ayrilamadi.\n");
        fclose(dosya);
        return 1;
    }

    fread(eskiVeri, 1, dosyaBoyutu, dosya);
    fclose(dosya);

    // Yeni dosya verisi için bellek ayır
    BYTE* yeniVeri = (BYTE*)malloc(yeniDosyaBoyutu);
    if (!yeniVeri) {
        printf("Hata: Yeni veri icin bellek ayrilamadi.\n");
        free(eskiVeri);
        return 1;
    }

    // Başlıkları kopyala
    memcpy(yeniVeri, eskiVeri, sizeof(BITMAPFILEHEADER) + sizeof(BITMAPINFOHEADER));

    // Başlıkları güncelle
    BITMAPFILEHEADER* yeniBmfHeader = (BITMAPFILEHEADER*)yeniVeri;
    BITMAPINFOHEADER* yeniBmiHeader = (BITMAPINFOHEADER*)(yeniVeri + sizeof(BITMAPFILEHEADER));

    yeniBmfHeader->bfSize = yeniDosyaBoyutu;
    yeniBmiHeader->biWidth = yeniGenislik;
    yeniBmiHeader->biSizeImage = yeniSatirByte * yukseklik;

    // Piksel verilerini kopyala ve sağ tarafa mavi ekle
    BYTE* eskiPikselVerisi = eskiVeri + bmfHeader.bfOffBits;
    BYTE* yeniPikselVerisi = yeniVeri + sizeof(BITMAPFILEHEADER) + sizeof(BITMAPINFOHEADER);

    for (int y = 0; y < yukseklik; y++) {
        // Orijinal satırı kopyala
        memcpy(yeniPikselVerisi, eskiPikselVerisi, eskiGenislik * 3);
        
        // Sağ tarafa mavi piksel ekle (BGR formatında: B=255, G=0, R=0)
        int yeniSatirBaslangic = y * yeniSatirByte;
        int maviPikselPozisyonu = yeniSatirBaslangic + (eskiGenislik * 3);
        yeniPikselVerisi[maviPikselPozisyonu] = 255;     // B (Blue)
        yeniPikselVerisi[maviPikselPozisyonu + 1] = 0;   // G (Green)
        yeniPikselVerisi[maviPikselPozisyonu + 2] = 0;   // R (Red)

        // Padding byte'larını sıfırla
        for (int i = eskiGenislik * 3 + 3; i < yeniSatirByte; i++) {
            yeniPikselVerisi[yeniSatirBaslangic + i] = 0;
        }

        eskiPikselVerisi += eskiSatirByte;
        yeniPikselVerisi += yeniSatirByte;
    }

    // Yeni dosyayı yaz
    dosya = fopen(dosyaYolu, "wb");
    if (!dosya) {
        printf("Hata: Dosya yazilamadi.\n");
        free(eskiVeri);
        free(yeniVeri);
        return 1;
    }

    fwrite(yeniVeri, 1, yeniDosyaBoyutu, dosya);
    fclose(dosya);

    free(eskiVeri);
    free(yeniVeri);

    printf("Basarili!\n");
    printf("Dosya genisligi %d pikselden %d piksele cikarildi.\n", eskiGenislik, yeniGenislik);
    printf("Sag tarafa mavi (R:0, G:0, B:255) piksel eklendi.\n");
    printf("Orijinal dosya yedeklendi: %s\n", yedekDosyaYolu);

    return 0;
}

int main(int argc, char* argv[]) {
    if (argc < 2) {
        printf("Kullanim: BmpGenislet.exe <bmp_dosya_yolu>\n");
        printf("Ornek: BmpGenislet.exe C:\\resim.bmp\n");
        return 1;
    }

    // Dosya uzantısını kontrol et
    const char* dosyaYolu = argv[1];
    const char* uzanti = strrchr(dosyaYolu, '.');
    if (!uzanti || _stricmp(uzanti, ".bmp") != 0) {
        printf("Hata: Bu program sadece .bmp dosyalari icin calisir.\n");
        return 1;
    }

    return GenisletBmp(dosyaYolu);
}
