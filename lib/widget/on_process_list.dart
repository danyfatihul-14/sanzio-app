import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raffaelosanzio/shared/theme.dart';

class OnProcessList extends StatelessWidget {
  final List<Map<String, String>> items;

  const OnProcessList({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(20),
      itemCount: items.length,
      itemBuilder: (context, index) {
        final item = items[index];
        return Card(
          color: whiteMain,
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
                    'assets/jacket.jpg',
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
                        item['name'] ?? "Unknown",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: const Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item['price'] ?? "Unknown",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF242F38),
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item['size'] ?? "Unknown",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 10,
                          fontWeight: FontWeight.w400,
                          color: const Color(0xFF242F38),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            item['date'] ?? "Unknown",
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 8,
                              fontWeight: FontWeight.w400,
                              color: const Color(0xFF242F38),
                            ),
                          ),
                          const Spacer(),
                          Text(
                            item['status'] ?? "Unknown",
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 8,
                              fontWeight: FontWeight.w600,
                              color: item['status'] == 'Pending'
                                  ? const Color.fromARGB(255, 79, 114, 189)
                                  : item['status'] == 'Rejected'
                                      ? Colors.red
                                      : Colors.grey,
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
