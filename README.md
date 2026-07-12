# KuyFit - UAS Mobile Computing (MoC02)

**KuyFit** adalah aplikasi *fitness tracker* modern yang mengedepankan aspek antarmuka (UI/UX) premium, fungsionalitas intuitif, serta estetika visual. Proyek ini dikerjakan sebagai bagian dari Ujian Akhir Semester (UAS) mata kuliah Mobile Computing (MoC02).

## 🎨 Tautan Desain Figma
👉 **https://www.figma.com/design/rWDiwspI7DvavERqVaCStg/MoC02---KuyFit_24120300013?node-id=0-1&t=T6va08rRdWpAckSG-1** 👈

---

## 📱 Fitur & Spesifikasi Teknis Aplikasi (Sesuai Syarat UAS)

Aplikasi ini dikembangkan sepenuhnya menggunakan kerangka kerja **Flutter** dan mematuhi desain UI/UX dengan tingkat presisi (*pixel-perfect*) tinggi. Aplikasi ini telah mengimplementasikan spesifikasi teknis berikut:

1. **Arsitektur MVC (Model-View-Controller)**
   - Menggunakan pemisahan kode berbasis MVC untuk skalabilitas proyek (terdapat pemisahan logika pada folder `models`, `views`, `controllers`, dan `services`).
2. **State Management (Provider)**
   - Menggunakan arsitektur Provider (`ChangeNotifierProvider` dan `MultiProvider`) melalui `AuthController` dan `WorkoutController` untuk mengelola *state* aplikasi.
3. **Integrasi REST API**
   - Aplikasi mengambil data list latihan (*workout exercises*) secara dinamis melalui REST API (HTTP GET).
4. **Local Storage (Shared Preferences)**
   - Menggunakan `SharedPreferences` untuk menyimpan status autentikasi (*login state*), sehingga sesi *user* tetap tersimpan saat aplikasi ditutup.
5. **Mobile Feature (Local Notification)**
   - Mengimplementasikan `flutter_local_notifications` yang terintegrasi pada aplikasi untuk memicu fitur pengingat (*reminder*) notifikasi lokal.

## 📸 Screenshots (Tangkapan Layar)

*(TODO: Tambahkan file gambar screenshot di direktori root dan sesuaikan tautan di bawah ini)*
- **Halaman Login:** `![Login](login_screenshot.png)`
- **Halaman Dashboard/Home:** `![Dashboard](dashboard_screenshot.png)`
- **Halaman API (Workout):** `![Workout API](workout_api_screenshot.png)`
- **Fitur Notifikasi:** `![Notification](notification_screenshot.png)`

---

## 🛠 Teknologi Utama yang Digunakan
- **Flutter SDK**: Dibangun khusus untuk kompatibilitas kompilasi Web/Mobile.
- **Provider**: Untuk pengelolaan State Management.
- **Shared Preferences**: Untuk penyimpanan data statis lokal.
- **Google Fonts (Plus Jakarta Sans)**: Memberikan tipografi beraksen modern, kokoh, dan rapi di setiap teks antarmuka.

---

## 🚀 Cara Menjalankan Aplikasi
1. Pastikan Anda telah menginstal Flutter di perangkat Anda.
2. Clone repositori ini:
   ```bash
   git clone https://github.com/camkanman/kuyfit.git
   ```
3. Arahkan direktori terminal ke dalam *folder* proyek:
   ```bash
   cd kuyfit
   ```
4. Dapatkan seluruh dependensi paket:
   ```bash
   flutter pub get
   ```
5. Jalankan aplikasi (pada perangkat atau emulator Android/iOS):
   ```bash
   flutter run
   ```

---
*Dibuat untuk memenuhi kualifikasi dan rubrik penilaian Ujian Akhir Semester (UAS).*
