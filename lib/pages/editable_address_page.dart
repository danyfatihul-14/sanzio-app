import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EditableAddressPage extends StatefulWidget {
  final Function(List<String>) onSave;

  const EditableAddressPage({super.key, required this.onSave});

  @override
  // ignore: library_private_types_in_public_api
  _EditableAddressPageState createState() => _EditableAddressPageState();
}

class _EditableAddressPageState extends State<EditableAddressPage> {
  final TextEditingController addressController = TextEditingController();
  List<String> addresses = [];
  int? editingIndex;
  bool showForm = false; // Mengontrol tampilan form
  int? mainAddressIndex; // Untuk menyimpan index alamat utama

  @override
  void initState() {
    super.initState();
    // Tambahkan alamat default ke daftar
    addresses.add(
      'Jalan Soekarno Hatta No. 1, Lowokwaru, Kota Malang, Jawa Timur, ID 12345',
    );
  }

  void addOrUpdateAddress(String address) {
    setState(() {
      if (editingIndex != null) {
        addresses[editingIndex!] = address; // Mengedit alamat yang ada
        editingIndex = null;
      } else {
        addresses.add(address); // Menambah alamat baru di bagian bawah
      }
      addressController.clear();
      showForm = false;
    });
  }

  void setMainAddress(int index) {
    setState(() {
      mainAddressIndex =
          index; // Menandai alamat yang dipilih sebagai alamat utama
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            "History",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF000000),
            ),
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tampilkan alamat utama
            if (mainAddressIndex != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Alamat Utama',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.blue),
                      ),
                      child: Text(
                        addresses[mainAddressIndex!],
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Alamat Saat Ini',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      showForm = true;
                      editingIndex = null;
                      addressController.clear();
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 79, 114, 189),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                    'Tambah Alamat',
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w600,
                      color: const Color.fromARGB(221, 255, 255, 255),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Column(
              children: addresses.asMap().entries.map((entry) {
                int index = entry.key;
                String address = entry.value;
                return Container(
                  padding: const EdgeInsets.all(12),
                  margin: const EdgeInsets.only(bottom: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.grey),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          address,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            color: Colors.black87,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.check_circle,
                              color: mainAddressIndex == index
                                  ? const Color.fromARGB(255, 79, 114, 189)
                                  : Colors.grey,
                            ),
                            onPressed: () {
                              setMainAddress(index);
                            },
                          ),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                editingIndex = index;
                                addressController.text = address;
                                showForm = true;
                              });
                            },
                            child: Text(
                              'Ubah',
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 14,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
            if (showForm) ...[
              const SizedBox(height: 16),
              TextField(
                controller: addressController,
                decoration: InputDecoration(
                  labelText: editingIndex != null
                      ? 'Ubah Alamat'
                      : 'Masukkan Alamat Baru',
                  labelStyle: GoogleFonts.plusJakartaSans(),
                  border: const OutlineInputBorder(),
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                ),
                maxLines: 5,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (addressController.text.isNotEmpty) {
                    addOrUpdateAddress(addressController.text);
                    widget.onSave(addresses);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 79, 114, 189),
                  minimumSize: const Size(double.infinity, 48), // Tombol panjang
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'Simpan Alamat',
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w600,
                    color: const Color.fromARGB(221, 255, 255, 255),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}