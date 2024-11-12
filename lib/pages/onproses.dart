import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnProses extends StatefulWidget {
  @override
  _OnProsesState createState() => _OnProsesState();
}

class _OnProsesState extends State<OnProses> {
  final List<Map<String, String>> items = [
    {
      'name': 'Blue T-Shirt',
      'price': 'Rp 150.000',
      'size': 'XL',
      'date': '19-10-2024',
      'status': 'Pending',
    },
    {
      'name': 'Green Jacket',
      'price': 'Rp 250.000',
      'size': 'M',
      'date': '18-10-2024',
      'status': 'Rejected',
    },
    // Tambahkan lebih banyak item jika diperlukan
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: items.isEmpty
          ? Center(
              child: Text(
                "No items in process",
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
            )
          : OnprosesList(items: items),
    );
  }
}

class OnprosesList extends StatelessWidget {
  final List<Map<String, String>> items;

  OnprosesList({required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.asset(
                    'assets/jacket.jpg', // Ganti dengan path gambar yang sesuai
                    width: 80,
                    height: 80,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['name'] ?? "Unknown", // Nama item
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item['price'] ?? "Unknown", // Harga
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF242F38),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item['size'] ?? "Unknown", // Ukuran
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF242F38),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Text(
                            item['date'] ?? "Unknown", // Tanggal
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 8,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF242F38),
                            ),
                          ),
                          const SizedBox(
                            height: 35,
                          ),
                          const Spacer(),
                          Text(
                            item['status'] ?? "Unknown", // Status
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 8,
                              fontWeight: FontWeight.w600,
                              color: item['status'] == 'Pending'
                                  ? const Color.fromARGB(255, 79, 114,
                                      189) // Status Pending berwarna biru
                                  : item['status'] == 'Rejected'
                                      ? Colors
                                          .red // Status Rejected berwarna merah
                                      : Colors
                                          .grey, // Status lainnya berwarna abu-abu
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
