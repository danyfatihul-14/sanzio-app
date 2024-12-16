import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raffaelosanzio/shared/theme.dart';

class Kebijakan extends StatelessWidget {
  const Kebijakan({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: gray50,
      appBar: AppBar(
        title: Text(
          "Kebijakan Sanzio",
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: gray600,
          ),
        ),
        centerTitle: true,
        backgroundColor: whiteMain,
        shadowColor: Colors.grey,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8.0), // Ukuran lingkaran
            decoration: const BoxDecoration(
              color: Colors.white, // Warna latar belakang lingkaran
              shape: BoxShape.circle, // Bentuk lingkaran
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  spreadRadius: -2,
                ),
              ],
            ),
            child: Icon(
              Icons.arrow_back,
              color: blue600,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Kebijakan Privasi Aplikasi Sanzio',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: blue400,
              ),
            ),
            const SizedBox(height: 14),
            _buildBodyText(
              'Kami di Sanzio sangat menghargai privasi Anda. Kebijakan privasi ini bertujuan untuk memberi tahu Anda tentang bagaimana kami mengumpulkan, menggunakan, dan melindungi data pribadi Anda saat menggunakan aplikasi kami.',
            ),
            const SizedBox(height: 14),
            _buildSection('1. Pengumpulan Data Pribadi',
                'Kami mengumpulkan data pribadi yang Anda berikan saat mendaftar akun, bertransaksi, atau berinteraksi dengan aplikasi kami. Data yang dikumpulkan meliputi nama, alamat email, nomor telepon, dan informasi pembayaran.'),
            _buildSection('2. Penggunaan Data',
                'Data pribadi yang kami kumpulkan digunakan untuk memproses pesanan Anda, memberikan dukungan pelanggan, mengirimkan informasi tentang produk dan layanan kami, serta meningkatkan pengalaman pengguna.'),
            _buildSection('3. Keamanan Data',
                'Kami menggunakan langkah-langkah keamanan yang sesuai untuk melindungi data pribadi Anda. Namun, Anda juga bertanggung jawab untuk menjaga kerahasiaan kata sandi dan informasi akun Anda.'),
            _buildSection('4. Pembagian Data dengan Pihak Ketiga',
                'Kami tidak akan menjual atau menyewakan data pribadi Anda kepada pihak ketiga. Data Anda mungkin dibagikan kepada penyedia layanan yang membantu kami menjalankan aplikasi, seperti layanan pengiriman dan pembayaran.'),
            _buildSection('5. Hak Pengguna',
                'Anda berhak untuk mengakses, memperbarui, atau menghapus data pribadi Anda yang kami simpan. Untuk melakukannya, Anda dapat menghubungi layanan pelanggan kami.'),
            _buildSection('6. Perubahan Kebijakan',
                'Kami dapat memperbarui kebijakan privasi ini dari waktu ke waktu. Setiap perubahan akan dipublikasikan di aplikasi dan berlaku segera setelah dipublikasikan.'),
            _buildSection('7. Menghubungi Kami',
                'Jika Anda memiliki pertanyaan atau kekhawatiran mengenai kebijakan privasi ini, Anda dapat menghubungi kami melalui kontak yang tersedia di aplikasi.'),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, String content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: blue400,
          ),
        ),
        const SizedBox(height: 8),
        _buildBodyText(content),
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildBodyText(String text) {
    return Text(
      text,
      style: GoogleFonts.plusJakartaSans(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: gray600,
      ),
    );
  }
}
