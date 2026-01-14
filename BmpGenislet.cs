using System;
using System.IO;
using System.Drawing;
using System.Drawing.Imaging;

/// <summary>
/// BMP dosyasının genişliğini 1 piksel artırır ve sağ tarafa mavi (R:0, G:0, B:255) piksel ekler
/// Windows 7 32-bit için uyumludur
/// </summary>
class Program
{
    static int Main(string[] args)
    {
        try
        {
            // Komut satırından dosya yolunu al
            if (args.Length == 0)
            {
                Console.WriteLine("Kullanım: BmpGenislet.exe <bmp_dosya_yolu>");
                Console.WriteLine("Örnek: BmpGenislet.exe C:\\resim.bmp");
                return 1;
            }

            string dosyaYolu = args[0];

            // Dosyanın var olup olmadığını kontrol et
            if (!File.Exists(dosyaYolu))
            {
                Console.WriteLine("Hata: Dosya bulunamadı: " + dosyaYolu);
                return 1;
            }

            // Dosya uzantısını kontrol et
            string uzanti = Path.GetExtension(dosyaYolu).ToLower();
            if (uzanti != ".bmp")
            {
                Console.WriteLine("Hata: Bu program sadece .bmp dosyaları için çalışır.");
                return 1;
            }

            // BMP dosyasını yükle
            Bitmap orijinalBmp;
            try
            {
                orijinalBmp = new Bitmap(dosyaYolu);
            }
            catch (Exception ex)
            {
                Console.WriteLine("Hata: BMP dosyası okunamadı: " + ex.Message);
                return 1;
            }

            int eskiGenislik = orijinalBmp.Width;
            int yukseklik = orijinalBmp.Height;
            int yeniGenislik = eskiGenislik + 1;

            // Yeni bitmap oluştur (1 piksel daha geniş)
            Bitmap yeniBmp = new Bitmap(yeniGenislik, yukseklik, PixelFormat.Format24bppRgb);

            // Mavi renk (R:0, G:0, B:255)
            Color maviRenk = Color.FromArgb(0, 0, 255);

            // Orijinal pikselleri kopyala ve sağ tarafa mavi piksel ekle
            for (int y = 0; y < yukseklik; y++)
            {
                for (int x = 0; x < eskiGenislik; x++)
                {
                    Color piksel = orijinalBmp.GetPixel(x, y);
                    yeniBmp.SetPixel(x, y, piksel);
                }
                // Sağ tarafa mavi piksel ekle
                yeniBmp.SetPixel(eskiGenislik, y, maviRenk);
            }

            // Orijinal dosyayı yedekle
            string yedekDosyaYolu = dosyaYolu + ".yedek";
            if (File.Exists(yedekDosyaYolu))
            {
                File.Delete(yedekDosyaYolu);
            }
            File.Copy(dosyaYolu, yedekDosyaYolu);

            // Yeni bitmap'i kaydet
            yeniBmp.Save(dosyaYolu, ImageFormat.Bmp);

            // Kaynakları temizle
            orijinalBmp.Dispose();
            yeniBmp.Dispose();

            Console.WriteLine("Başarılı!");
            Console.WriteLine("Dosya genişliği " + eskiGenislik + " pikselden " + yeniGenislik + " piksele çıkarıldı.");
            Console.WriteLine("Sağ tarafa mavi (R:0, G:0, B:255) piksel eklendi.");
            Console.WriteLine("Orijinal dosya yedeklendi: " + yedekDosyaYolu);

            return 0;
        }
        catch (Exception ex)
        {
            Console.WriteLine("Beklenmeyen hata: " + ex.Message);
            Console.WriteLine("Detay: " + ex.StackTrace);
            return 1;
        }
    }
}
