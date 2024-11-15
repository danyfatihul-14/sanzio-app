import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raffaelosanzio/pages/editable_address_page.dart';
import 'package:raffaelosanzio/pages/success.dart';

class PaymentPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "Payment",
          style: GoogleFonts.plusJakartaSans(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildAddressSection(context),
            SizedBox(height: 16),
            _buildItemsSection(),
            SizedBox(height: 16),
            _buildPaymentMethodSection(),
            SizedBox(height: 16),
            _buildSummarySection(),
            SizedBox(height: 16),
            _buildPaymentButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildAddressSection(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                child: Icon(Icons.location_on,
                    color: const Color.fromARGB(255, 79, 114, 189)),
              ),
              SizedBox(width: 8),
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Alamat Pengiriman',
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  print("Edit address");
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditableAddressPage(
                              onSave: (String) {},
                            )),
                  );
                },
                child: Icon(Icons.edit,
                    color: const Color.fromARGB(255, 79, 114, 189)),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'Rafaello Sanzio | 0813XXXXXXX',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          Text(
            'Jalan Soekarno Hatta No. 1, Lowokwaru, Kota Malang, Jawa Timur, ID 12345',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 8),
          Divider(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Jenis Pengiriman:',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'JNT',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Berat:',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '1 Kg',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Estimasi Waktu:',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '27 Oktober 2024',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 12,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildItemsSection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Divider(),
          _buildItemRowWithImage('Jacket Bomber', 'S', 'Yellow',
              'assets/jacket.png', 150000, 002), // Added quantity
          SizedBox(height: 15), // Space between items
          _buildItemRowWithImage('Jacket Bomber', 'S', 'Yellow',
              'assets/jacket.png', 150000, 001), // Added quantity
        ],
      ),
    );
  }

  Widget _buildItemRowWithImage(String name, String size, String color,
      String imagePath, int price, int quantity) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Image.asset(
          imagePath,
          width: 60,
          height: 60,
          fit: BoxFit.cover,
        ),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: TextStyle(fontWeight: FontWeight.bold)),
              Row(
                children: [
                  Text(color, style: TextStyle(fontSize: 12)),
                  SizedBox(width: 8),
                  Text(', $size', style: TextStyle(fontSize: 12)),
                ],
              ),
              SizedBox(height: 4),
              Text(' $quantity', style: TextStyle(fontSize: 12)), // Quantity
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              SizedBox(height: 8), // Add space between quantity and price
              Text('Rp ${price.toString()}',
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethodSection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blueAccent.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.payment,
                  color: const Color.fromARGB(255, 79, 114, 189)),
              SizedBox(width: 8),
              Text(
                'Metode Pembayaran',
                style: GoogleFonts.plusJakartaSans(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: const Color.fromARGB(255, 79, 114, 189),
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Icon(Icons.money,
                  color: const Color.fromARGB(255, 148, 148, 148)),
              SizedBox(width: 8),
              Text(
                'COD (Cash On Delivery)',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 12,
                  color: const Color.fromARGB(255, 148, 148, 148),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummarySection() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSummaryRow('Subtotal Produk', '003'),
          _buildSummaryRow('Subtotal Pengiriman', 'Rp 12.000'),
          _buildSummaryRow('Total Diskon', 'Rp 5.000'),
          _buildSummaryRow('Voucher Diskon', '- Rp 10.000'),
          Divider(),
          _buildSummaryRow('Total Pembayaran', 'Rp 447.000', isTotal: true),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String title, String amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,
              style: GoogleFonts.plusJakartaSans(
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                  fontSize: 14)),
          Text(amount,
              style: GoogleFonts.plusJakartaSans(
                  fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
                  fontSize: 14)),
        ],
      ),
    );
  }

  Widget _buildPaymentButton() {
    return Builder(
      builder: (BuildContext context) {
        return ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color.fromARGB(255, 79, 114, 189),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 190),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {
            print('Proceed to Payment');
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    SuccessPage(), // Ganti dengan halaman yang sesuai
              ),
            );
          },
          child: Center(
            child: Text(
              'Payment',
              style: GoogleFonts.plusJakartaSans(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }
}
