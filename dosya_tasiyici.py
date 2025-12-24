"""
Dosyaları isimlerine göre hedef klasörde alt klasörlere taşıyan araç.

Belirtilen kaynak içindeki dosyalar (veya tek bir dosya yolu) için her dosyanın
adıyla eşleşen bir klasör hedefte oluşturulur ve dosya, adı değişmeden bu
klasöre taşınır. Alt klasörler oluşturulurken dosya isimleri veya içerikleri
üzerinde herhangi bir değişiklik yapılmaz.
"""
from __future__ import annotations

import argparse
import shutil
import time
from pathlib import Path
from typing import Iterable, List, Tuple


def _iter_source_files(source: Path):
    """Kaynak yolundaki dosyaları verir.

    Tek bir dosya verildiyse onu döndürür; klasör verildiyse yalnızca doğrudan
    içindeki dosyalar dikkate alınır (alt klasörler dahil edilmez).
    """

    if source.is_file():
        yield source
        return

    if not source.is_dir():
        raise FileNotFoundError(f"Kaynak bulunamadı: {source}")

    for item in sorted(source.iterdir()):
        if item.is_file():
            yield item


def tasima_hedefi_olustur(file_path: Path, hedef_kok: Path) -> Path:
    """Dosya adından yola çıkarak hedef klasörü oluşturur ve hedef yol döner."""

    hedef_klasor = hedef_kok / file_path.stem
    hedef_klasor.mkdir(parents=True, exist_ok=True)
    return hedef_klasor / file_path.name


def dosyalari_tasi(kaynak: Path, hedef: Path, *, overwrite: bool = False) -> list[Path]:
    """Kaynak dosyaları hedefe taşır ve yeni yolları döndürür.

    Dosyaların isimleri veya içerikleri üzerinde hiçbir değişiklik yapılmaz;
    yalnızca uygun klasörlere taşınırlar. ``overwrite`` ``True`` ise hedefte
    aynı isimli dosya varsa sessizce üzerine yazılır.
    """

    yeni_yollar: list[Path] = []

    for dosya in _iter_source_files(kaynak):
        hedef_yolu = tasima_hedefi_olustur(dosya, hedef)
        hedef.parent.mkdir(parents=True, exist_ok=True)
        hedef_yolu.parent.mkdir(parents=True, exist_ok=True)

        if overwrite and hedef_yolu.exists():
            if hedef_yolu.is_dir():
                raise IsADirectoryError(f"Hedef dosya bekleniyordu ancak klasör bulundu: {hedef_yolu}")
            hedef_yolu.unlink()

        yeni_yollar.append(Path(shutil.move(str(dosya), str(hedef_yolu))))

    return yeni_yollar


def gorevleri_tasi(gorevler: Iterable[Tuple[Path, Path]], *, overwrite: bool = True) -> List[Path]:
    """Birden fazla (kaynak, hedef) ikilisini sırayla taşır."""

    tasinanlar: List[Path] = []
    for kaynak, hedef in gorevler:
        tasinanlar.extend(dosyalari_tasi(kaynak, hedef, overwrite=overwrite))
    return tasinanlar


def _parse_args():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument(
        "kaynak",
        type=Path,
        nargs="?",
        help="Taşınacak dosyaların bulunduğu klasör ya da tekil dosya yolu",
    )
    parser.add_argument(
        "hedef",
        type=Path,
        nargs="?",
        help="Dosyaların taşınacağı kök klasör (gerekirse oluşturulur)",
    )
    parser.add_argument(
        "--overwrite",
        action="store_true",
        help="Hedefte aynı isimli dosya varsa üzerine yaz",
    )
    parser.add_argument(
        "--gui",
        action="store_true",
        help="PyQt5 arayüzünü başlat (Windows 7 32 bit ile uyumlu)",
    )
    parser.add_argument(
        "--interval",
        type=int,
        default=5,
        help="Arka plan kopyalama döngüsü için saniye cinsinden bekleme süresi",
    )
    return parser.parse_args()


def main():
    args = _parse_args()
    if args.gui:
        run_gui(interval_s=args.interval)
        return

    if args.kaynak is None or args.hedef is None:
        raise SystemExit("Komut satırında kaynak ve hedef yollarını belirtin veya --gui kullanın.")

    tasinanlar = dosyalari_tasi(args.kaynak, args.hedef, overwrite=args.overwrite)

    if not tasinanlar:
        print("Taşınacak dosya bulunamadı.")
        return

    print("Taşınan dosyalar:")
    for yeni_yol in tasinanlar:
        print(f"- {yeni_yol}")


class ArkaplanTasiyici:
    """Basit bir döngüyle arka planda dosya taşıyan yardımcı.

    PyQt5 olmayan ortamlarda da testlerin çalışabilmesi için saf Python ile
    uygulanmıştır. ``baslat`` ile çalışır, ``durdur`` ile kapanır.
    """

    def __init__(self, gorevler: Iterable[Tuple[Path, Path]], interval_s: int = 5):
        self.gorevler = list(gorevler)
        self.interval_s = max(1, int(interval_s))
        self._calisiyor = False

    def baslat(self):
        self._calisiyor = True
        while self._calisiyor:
            gorevleri_tasi(self.gorevler, overwrite=True)
            time.sleep(self.interval_s)

    def durdur(self):
        self._calisiyor = False


def run_gui(interval_s: int = 5):
    """PyQt5 arayüzünü başlatır.

    PyQt5 yüklenmemişse açıklayıcı bir hata verir. Arayüz, her satırı bir
    (kaynak, hedef) ikilisi olan tablo, satır ekleme/çıkarma butonları ve
    arka planda çalıştırma/durdurma tuşlarından oluşur.
    """

    try:
        from PyQt5 import QtCore, QtGui, QtWidgets
    except ImportError as exc:  # pragma: no cover - ortama bağlı
        raise SystemExit(
            "PyQt5 bulunamadı. Lütfen 'pip install pyqt5' komutuyla kurun."
        ) from exc

    class TasiyiciThread(QtCore.QThread):
        durum_degisti = QtCore.pyqtSignal(bool)

        def __init__(self, gorevler: Iterable[Tuple[Path, Path]], interval_s: int):
            super().__init__()
            self.gorevler = list(gorevler)
            self.interval_s = max(1, int(interval_s))
            self._istek_dur = False

        def run(self):
            self.durum_degisti.emit(True)
            while not self._istek_dur:
                gorevleri_tasi(self.gorevler, overwrite=True)
                self.sleep(self.interval_s)
            self.durum_degisti.emit(False)

        def durdur(self):
            self._istek_dur = True

    class AnaPencere(QtWidgets.QMainWindow):
        def __init__(self):
            super().__init__()
            self.setWindowTitle("Otomatik Dosya Taşıyıcı")
            self.resize(720, 320)

            self.thread: TasiyiciThread | None = None

            merkez_widget = QtWidgets.QWidget()
            self.setCentralWidget(merkez_widget)
            yerlesim = QtWidgets.QVBoxLayout(merkez_widget)

            self.tablo = QtWidgets.QTableWidget(0, 2)
            self.tablo.setHorizontalHeaderLabels(["Kaynak klasör", "Hedef klasör"])
            self.tablo.horizontalHeader().setSectionResizeMode(QtWidgets.QHeaderView.Stretch)
            yerlesim.addWidget(self.tablo)

            buton_panel = QtWidgets.QHBoxLayout()
            yerlesim.addLayout(buton_panel)

            self.ekle_btn = QtWidgets.QPushButton("Satır ekle")
            self.sil_btn = QtWidgets.QPushButton("Seçili satırı sil")
            self.baslat_btn = QtWidgets.QPushButton("Başlat")
            self.durdur_btn = QtWidgets.QPushButton("Durdur")
            self.durdur_btn.setEnabled(False)

            buton_panel.addWidget(self.ekle_btn)
            buton_panel.addWidget(self.sil_btn)
            buton_panel.addStretch()
            buton_panel.addWidget(self.baslat_btn)
            buton_panel.addWidget(self.durdur_btn)

            self.durum_etiketi = QtWidgets.QLabel("Durum: Beklemede")
            yerlesim.addWidget(self.durum_etiketi)

            self.ekle_btn.clicked.connect(self.satir_ekle)
            self.sil_btn.clicked.connect(self.secili_satiri_sil)
            self.baslat_btn.clicked.connect(self.baslat)
            self.durdur_btn.clicked.connect(self.durdur)

        def satir_ekle(self):
            satir = self.tablo.rowCount()
            self.tablo.insertRow(satir)
            for sutun, baslik in enumerate(["Kaynak klasör", "Hedef klasör"]):
                hucre = QtWidgets.QWidget()
                kutu = QtWidgets.QHBoxLayout(hucre)
                kutu.setContentsMargins(0, 0, 0, 0)
                line_edit = QtWidgets.QLineEdit()
                btn = QtWidgets.QToolButton()
                btn.setText("...")
                btn.clicked.connect(lambda _=None, s=satir, c=sutun: self.klasor_sec(s, c))
                kutu.addWidget(line_edit)
                kutu.addWidget(btn)
                self.tablo.setCellWidget(satir, sutun, hucre)

        def secili_satiri_sil(self):
            satir = self.tablo.currentRow()
            if satir >= 0:
                self.tablo.removeRow(satir)

        def klasor_sec(self, satir: int, sutun: int):
            yol = QtWidgets.QFileDialog.getExistingDirectory(self, "Klasör Seç")
            if yol:
                hucre = self.tablo.cellWidget(satir, sutun)
                if hucre:
                    line_edit = hucre.findChild(QtWidgets.QLineEdit)
                    if line_edit:
                        line_edit.setText(yol)

        def _gorev_listesi(self) -> list[tuple[Path, Path]]:
            gorevler: list[tuple[Path, Path]] = []
            for satir in range(self.tablo.rowCount()):
                kaynak_hucre = self.tablo.cellWidget(satir, 0)
                hedef_hucre = self.tablo.cellWidget(satir, 1)
                if not kaynak_hucre or not hedef_hucre:
                    continue
                kaynak = kaynak_hucre.findChild(QtWidgets.QLineEdit).text().strip()
                hedef = hedef_hucre.findChild(QtWidgets.QLineEdit).text().strip()
                if kaynak and hedef:
                    gorevler.append((Path(kaynak), Path(hedef)))
            return gorevler

        def baslat(self):
            if self.thread and self.thread.isRunning():
                return

            gorevler = self._gorev_listesi()
            if not gorevler:
                QtWidgets.QMessageBox.warning(self, "Eksik bilgi", "En az bir kaynak ve hedef girin.")
                return

            self.thread = TasiyiciThread(gorevler, interval_s)
            self.thread.durum_degisti.connect(self._durum_guncelle)
            self.thread.start()
            self.baslat_btn.setEnabled(False)
            self.durdur_btn.setEnabled(True)

        def durdur(self):
            if self.thread and self.thread.isRunning():
                self.thread.durdur()
                self.thread.wait()
            self.baslat_btn.setEnabled(True)
            self.durdur_btn.setEnabled(False)
            self.durum_etiketi.setText("Durum: Beklemede")

        def _durum_guncelle(self, calisiyor: bool):
            self.durum_etiketi.setText("Durum: Çalışıyor" if calisiyor else "Durum: Beklemede")

        def closeEvent(self, event: QtGui.QCloseEvent):  # noqa: N802
            self.durdur()
            return super().closeEvent(event)

    app = QtWidgets.QApplication([])
    pencere = AnaPencere()
    pencere.show()
    app.exec_()


if __name__ == "__main__":
    main()
