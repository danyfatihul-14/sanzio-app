import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:raffaelosanzio/api/address_api.dart';
import 'package:raffaelosanzio/models/hive/model.dart';
import 'package:raffaelosanzio/shared/theme.dart';

class EditableAddressPage extends StatefulWidget {
  final Function(List<String>) onSave;

  const EditableAddressPage({super.key, required this.onSave});

  @override
  // ignore: library_private_types_in_public_api
  _EditableAddressPageState createState() => _EditableAddressPageState();
}

class _EditableAddressPageState extends State<EditableAddressPage> {
  final TextEditingController addressController = TextEditingController();
  List<Address> _addresses = [];
  Address? mainAddress;
  int? editingIndex;
  bool showForm = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _getAddresses();
  }

  Future<void> _getAddresses() async {
    var box = await AddressApiHandler().getAddress();
    setState(() {
      _addresses = box;
      mainAddress = _addresses.firstWhere(
        (address) => address.isDefault == true,
        orElse: () => Address(id: 0, address: '', isDefault: false),
      );
      _isLoading = false;
    });
  }

  Future<void> addOrUpdateAddress(String address) async {
    if (editingIndex != null) {
      bool isUpdated =
          await AddressApiHandler().updateAddress(address, editingIndex!);
      isUpdated ? _getAddresses() : print("Failed");
    } else {
      bool isUpdated = await AddressApiHandler().createAddress(address);
      isUpdated ? _getAddresses() : print("Failed");
    }
    setState(() {
      addressController.clear();
      showForm = false;
    });
  }

  Future<void> setMainAddress(int index) async {
    print(index);
    bool isUpdated = await AddressApiHandler().mainAddress(index);
    isUpdated ? print("Updated") : print("Failed");
    setState(() {
      // for (var addr in _addresses) {
      //   if (addr.isInBox) {
      //     print("Checkpoint 1");
      //     addr.isDefault = false;
      //     addr.save();
      //     print("Checkpoint 1.1");
      //   } else {
      //     print("Ga Jalan");
      //   }
      // }
      // if (_addresses[index].isInBox) {
      //   print("Checkpoint 2");
      //   _addresses[index].isDefault = true;
      //   _addresses[index].save();
      isUpdated ? _getAddresses() : print("Failed");
      mainAddress = _addresses.where((item) => item.id == index).first;
      //   print(mainAddress!.isDefault);
      // }
      // print("Checkpoint 3");
    });
  }

  Future<void> deleteAddress(int index) async {
    bool isUpdated = await AddressApiHandler().deleteAddress(index);
    isUpdated ? _getAddresses() : print("Failed");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gray50,
      appBar: AppBar(
        foregroundColor: whiteMain,
        centerTitle: true,
        title: Text(
          "Alamat Saya",
          style: GoogleFonts.plusJakartaSans(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: gray600,
          ),
        ),
        backgroundColor: Colors.white,
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
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (mainAddress != null && mainAddress!.isDefault == true)
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
                        margin: const EdgeInsets.only(bottom: 8),
                        decoration: BoxDecoration(
                          color: Colors.blue[50],
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.blue),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                mainAddress!.address,
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
                                    color: mainAddress!.isDefault
                                        ? const Color.fromARGB(
                                            255, 79, 114, 189)
                                        : Colors.grey,
                                  ),
                                  onPressed: () {
                                    setMainAddress(mainAddress!.id);
                                  },
                                ),
                                TextButton(
                                  onPressed: () {
                                    setState(() {
                                      editingIndex = mainAddress!.id;
                                      addressController.text =
                                          mainAddress!.address;
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
                                IconButton(
                                  icon: const Icon(Icons.delete,
                                      color: Colors.red),
                                  onPressed: () {
                                    deleteAddress(mainAddress!.id);
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
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
              _isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      children: _addresses
                          .where((address) => address.isDefault == false)
                          .toList()
                          .asMap()
                          .entries
                          .map((entry) {
                        int index = entry.value.id;
                        Address address = entry.value;
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
                                  address.address,
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
                                      color: address.isDefault
                                          ? const Color.fromARGB(
                                              255, 79, 114, 189)
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
                                        addressController.text =
                                            address.address;
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
                                  IconButton(
                                    icon: const Icon(Icons.delete,
                                        color: Colors.red),
                                    onPressed: () {
                                      deleteAddress(index);
                                    },
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
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                  ),
                  maxLines: 5,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    if (addressController.text.isNotEmpty) {
                      addOrUpdateAddress(addressController.text);
                      widget.onSave(_addresses.map((e) => e.address).toList());
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 79, 114, 189),
                    minimumSize:
                        const Size(double.infinity, 48), // Tombol panjang
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
      ),
    );
  }
}
