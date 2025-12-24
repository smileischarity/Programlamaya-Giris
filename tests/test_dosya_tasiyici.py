import tempfile
import unittest
from pathlib import Path

import dosya_tasiyici as dt


def create_file(directory: Path, name: str, content: str = "icerik") -> Path:
    path = directory / name
    path.parent.mkdir(parents=True, exist_ok=True)
    path.write_text(content, encoding="utf-8")
    return path


class TasiyiciTestleri(unittest.TestCase):
    def test_dosyalar_isimlerine_gore_klasorlerde_tasinir(self):
        with tempfile.TemporaryDirectory() as kaynak_dir, tempfile.TemporaryDirectory() as hedef_dir:
            kaynak = Path(kaynak_dir)
            hedef = Path(hedef_dir)

            dosya1 = create_file(kaynak, "belge.txt")
            dosya2 = create_file(kaynak, "rapor.pdf")

            tasinanlar = dt.dosyalari_tasi(kaynak, hedef)

            beklenen_belge = hedef / "belge" / "belge.txt"
            beklenen_rapor = hedef / "rapor" / "rapor.pdf"

            self.assertEqual(tasinanlar, [beklenen_belge, beklenen_rapor])
            self.assertFalse(dosya1.exists())
            self.assertFalse(dosya2.exists())
            self.assertEqual(beklenen_belge.read_text(encoding="utf-8"), "icerik")
            self.assertEqual(beklenen_rapor.read_text(encoding="utf-8"), "icerik")

    def test_tekil_dosya_tasinir(self):
        with tempfile.TemporaryDirectory() as kaynak_dir, tempfile.TemporaryDirectory() as hedef_dir:
            kaynak = Path(kaynak_dir)
            hedef = Path(hedef_dir)

            dosya = create_file(kaynak, "notlar.md")
            tasinanlar = dt.dosyalari_tasi(dosya, hedef)

            beklenen = hedef / "notlar" / "notlar.md"
            self.assertEqual(tasinanlar, [beklenen])
            self.assertTrue(beklenen.exists())

    def test_hedefteki_dosyalarin_uzerine_yazilir(self):
        with tempfile.TemporaryDirectory() as kaynak_dir, tempfile.TemporaryDirectory() as hedef_dir:
            kaynak = Path(kaynak_dir)
            hedef = Path(hedef_dir)

            tasinacak = create_file(kaynak, "rapor.txt", "guncel")
            hedef_dosya = create_file(hedef / "rapor", "rapor.txt", "eski")

            tasinanlar = dt.dosyalari_tasi(kaynak, hedef, overwrite=True)

            self.assertEqual(tasinanlar, [hedef_dosya])
            self.assertEqual(hedef_dosya.read_text(encoding="utf-8"), "guncel")

    def test_birden_fazla_gorev_ayni_anda_tasinir(self):
        with tempfile.TemporaryDirectory() as kaynak1_dir, tempfile.TemporaryDirectory() as kaynak2_dir, tempfile.TemporaryDirectory() as hedef1_dir, tempfile.TemporaryDirectory() as hedef2_dir:
            kaynak1 = Path(kaynak1_dir)
            kaynak2 = Path(kaynak2_dir)
            hedef1 = Path(hedef1_dir)
            hedef2 = Path(hedef2_dir)

            dosya1 = create_file(kaynak1, "dokuman.txt", "a")
            dosya2 = create_file(kaynak2, "veri.csv", "b")

            tasinanlar = dt.gorevleri_tasi(
                [(kaynak1, hedef1), (kaynak2, hedef2)], overwrite=True
            )

            beklenen1 = hedef1 / "dokuman" / dosya1.name
            beklenen2 = hedef2 / "veri" / dosya2.name

            self.assertCountEqual(tasinanlar, [beklenen1, beklenen2])
            self.assertTrue(beklenen1.exists())
            self.assertTrue(beklenen2.exists())


if __name__ == "__main__":
    unittest.main()
