# KuyFit - UTS Mobile Computing (MoC02)

**KuyFit** adalah aplikasi *fitness tracker* modern yang mengedepankan aspek antarmuka (UI/UX) premium, fungsionalitas intuitif, serta estetika visual. Proyek ini dikerjakan sebagai bagian dari Ujian Tengah Semester (UTS) mata kuliah Mobile Computing (MoC02).

## 🎨 Tautan Desain Figma
👉 **https://www.figma.com/design/rWDiwspI7DvavERqVaCStg/MoC02---KuyFit_24120300013?node-id=0-1&t=T6va08rRdWpAckSG-1** 👈

---

## 📱 Fitur & Layar Aplikasi (*Slicing* Hasil Desain)

Aplikasi ini dikembangkan sepenuhnya menggunakan kerangka kerja **Flutter** dan mematuhi desain UI/UX dengan tingkat presisi (*pixel-perfect*) tinggi. Tiga halaman utama yang telah diimplementasikan adalah:

1. **Login Page (`login_page.dart`)**
   - Implementasi form *login* dengan validasi komprehensif (Email RegEx, panjang karakter Password, dll).
   - Tipografi yang konsisten dengan desain Tailwind menggunakan `google_fonts` (*Plus Jakarta Sans*).
   
2. **Home / Dashboard Page (`dashboard_page.dart`)**
   - Menyajikan ringkasan aktivitas (Langkah, Menit Aktif, Kalori yang terbakar).
   - Penggunaan konsep *Bento Grid* untuk menyusun kartu-kartu ringkasan nutrisi dengan proporsi yang sempurna dan responsif.
   - Indikator progres yang detail dengan warna primer *(secondary/tertiary container)* yang solid.
   
3. **Nutrition & Hydration Page (`nutrition_page.dart`)**
   - Menampilkan susunan kartu Kalori Harian dan nutrisi Makro (Protein, Karbohidrat) secara spesifik mengikuti hierarki pembacaan layar (layout bersusun yang proporsional).
   - Efek tingkat lanjut seperti elemen *Glassmorphism* (BackdropFilter) pada kartu "Tip of the Day".
   - *Custom Painter* eksklusif yang dirancang khusus untuk melukis garis putus-putus (Dashed Border) pada bagian pelacakan dehidrasi (*Hydration Tracker*).

## 🛠 Teknologi Utama yang Digunakan
- **Flutter SDK**: Dibangun khusus untuk kompatibilitas kompilasi Web/Mobile.
- **Google Fonts (Plus Jakarta Sans)**: Memberikan tipografi beraksen modern, kokoh, dan rapi di setiap teks antarmuka.
- **Custom Painter & Blur Effect**: Mengangkat sentuhan estetika pada komponen visual tingkat tinggi (*glass panel* & *dashed rings*).

---

## 🚀 Cara Menjalankan Aplikasi
1. Pastikan Anda telah menginstal Flutter di perangkat Anda.
2. Clone repositori ini:
   ```bash
   git clone https://github.com/camkanman/kuyfit.git
   ```
3. Arahkan direktori terminal ke dalam *folder* proyek:
   ```bash
   cd kuyFit
   ```
4. Dapatkan seluruh dependensi paket:
   ```bash
   flutter pub get
   ```
5. Jalankan aplikasi (Contohnya di peramban Chrome):
   ```bash
   flutter run -d chrome
   ```

---
*Dibuat untuk memenuhi kualifikasi dan rubrik penilaian UTS.*
