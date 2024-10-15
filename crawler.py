import requests
import json
import os

def getSurah(surah_num):
    try:
        # Membuat request ke API
        resp = requests.get(f'https://equran.id/api/surat/{surah_num}')
        
        # Jika request berhasil
        if resp.status_code == 200:
            data = resp.text

            # Pastikan direktori tujuan ada
            os.makedirs('assets/datas/surah', exist_ok=True)

            # Menyimpan data dalam file JSON dengan encoding UTF-8
            with open(f'assets/datas/surah/{surah_num}.json', 'w', encoding='utf-8') as f:
                f.write(data)

            # Memuat data JSON sebagai objek Python
            jsonObj = json.loads(data)

            print(f"Berhasil mengunduh surah {jsonObj['nama']} (No: {surah_num})")
        else:
            print(f"Gagal mengambil surah {surah_num}. Status kode: {resp.status_code}")

    except Exception as e:
        print(f"Terjadi kesalahan: {e}")

# Loop untuk mengunduh 114 surah
def downloadAllSurahs():
    for i in range(1, 115):
        getSurah(i)
    print("Semua surah berhasil diunduh.")

# Memulai proses pengunduhan
downloadAllSurahs()
