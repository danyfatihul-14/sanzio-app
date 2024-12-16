import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raffaelosanzio/pages/history.dart';

class Rincian extends StatelessWidget {
  const Rincian({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Rincian Pesanan",
          style: GoogleFonts.plusJakartaSans(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // Konten utama yang bisa digulir
          SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                _buildDeliverySection(),
                const SizedBox(height: 16),
                _buildAddressSection(context),
                const SizedBox(height: 16),
                _buildItemsSection(),
                const SizedBox(height: 16),
                _buildPaymentMethodSection(),
                const SizedBox(height: 16),
                _buildSummarySection(),
                const SizedBox(height: 100), // Space at the bottom for button
              ],
            ),
          ),
          // Tombol "Bayar Sekarang" tetap di bawah
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildPaymentButton(context),
          ),
        ],
      ),
    );
  }

  Widget _buildDeliverySection() {
    return _buildCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.local_shipping, color: Colors.blue, size: 24),
              const SizedBox(width: 8),
              Text(
                'Info Pengiriman',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'JNT Express : 00000123456',
            style: _infoTextStyle(const Color.fromARGB(255, 148, 148, 148)),
          ),
          const SizedBox(height: 4),
          Text(
            'Pesanan sedang dikemas',
            style: _infoTextStyle(Colors.black),
          ),
        ],
      ),
    );
  }

  Widget _buildAddressSection(BuildContext context) {
    return _buildCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.location_on, color: Colors.blue),
              const SizedBox(width: 8),
              Text(
                'Alamat Pengiriman',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Rafaello Sanzio | 0813XXXXXXX',
            style: GoogleFonts.plusJakartaSans(fontSize: 14),
          ),
          Text(
            'Jalan Soekarno Hatta No. 1, Lowokwaru, Kota Malang, Jawa Timur, ID 12345',
            style: GoogleFonts.plusJakartaSans(fontSize: 14),
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildDeliveryInfo('Jenis Pengiriman:', 'JNT'),
              _buildDeliveryInfo('Berat:', '1 Kg'),
              _buildDeliveryInfo('Estimasi Waktu:', '27 Oktober 2024'),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildDeliveryInfo(String title, String value) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: GoogleFonts.plusJakartaSans(
                fontSize: 12, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text(value, style: GoogleFonts.plusJakartaSans(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildItemsSection() {
    return _buildCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildItemRowWithImage('Jacket Bomber', 'S', 'Yellow',
              'assets/Jacket Bomber.png', 150000, 2),
          const Divider(),
          _buildItemRowWithImage('Jacket Bomber', 'S', 'Yellow',
              'assets/Jacket Bomber.png', 150000, 1),
        ],
      ),
    );
  }

  Widget _buildItemRowWithImage(String name, String size, String color,
      String imagePath, int price, int quantity) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              imagePath,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
                Row(
                  children: [
                    Text(color, style: const TextStyle(fontSize: 12)),
                    const SizedBox(width: 8),
                    Text(', $size', style: const TextStyle(fontSize: 12)),
                  ],
                ),
                const SizedBox(height: 4),
                Text('Jumlah: $quantity', style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
          Text(
            'Rp ${price.toString()}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodSection() {
    return _buildCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.account_balance_wallet, color: Colors.blue),
              const SizedBox(width: 8),
              Text(
                'Metode Pembayaran',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.delivery_dining, size: 20),
              const SizedBox(width: 8),
              Text('Cash On Delivery',
                  style: GoogleFonts.plusJakartaSans(fontSize: 14)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummarySection() {
    return _buildCard(
      child: Column(
        children: [
          _buildSummaryRow('Subtotal Produk', 'Rp 450.000'),
          _buildSummaryRow('Subtotal Pengiriman', 'Rp 12.000'),
          _buildSummaryRow('Total Diskon', 'Rp 5.000'),
          _buildSummaryRow('Voucher Diskon', '- Rp 10.000'),
          const Divider(),
          _buildSummaryRow('Total Pembayaran', 'Rp 447.000', isTotal: true),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String title, String amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal),
          ),
          Text(
            amount,
            style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: isTotal ? FontWeight.bold : FontWeight.normal),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentButton(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(16.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HistoryPage()),
          );
        },
        child: Text(
          'Pesanan Selesai',
          style: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: child,
    );
  }

  TextStyle _infoTextStyle(Color color) {
    return GoogleFonts.plusJakartaSans(fontSize: 14, color: color);
  }
}
