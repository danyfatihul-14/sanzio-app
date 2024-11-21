import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:raffaelosanzio/blocs/cart/cart_bloc.dart';
import 'package:raffaelosanzio/blocs/cart/cart_event.dart';
import 'package:raffaelosanzio/models/cart.dart';
import 'package:raffaelosanzio/shared/theme.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DetailProductPage extends StatefulWidget {
  final Map<String, dynamic> product;

  const DetailProductPage({super.key, required this.product});

  @override
  _DetailProductPageState createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  String selectedSize = 'S'; // Default size selection

  @override
  Widget build(BuildContext context) {
    // Mengakses data dari Map
    final product = widget.product;
    final imageUrl = product['image']; // Mengambil imageUrl dari Map
    final title = product['title']; // Mengambil title dari Map
    final subtitle = product['subtitle']; // Mengambil subtitle dari Map
    final price = product['price']; // Mengambil price dari Map
    final description =
        product['description']; // Mengambil description dari Map
    final ratings = product['rating']; // Mengambil ratings dari Map

    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(top: 40, left: 16.0, right: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Center(
                  child: Image.asset(
                    imageUrl, // Menggunakan imageUrl dari Map
                    height: 300,
                  ),
                ),
                Positioned(
                  top: 20,
                  left: 0,
                  width: 36,
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 2,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back, color: blue600),
                      onPressed: () {
                        Navigator.pop(context); // Back button
                      },
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircleAvatar(backgroundColor: Colors.grey, radius: 5),
                SizedBox(width: 8),
                CircleAvatar(backgroundColor: Colors.brown, radius: 5),
                SizedBox(width: 8),
                CircleAvatar(backgroundColor: Colors.blueGrey, radius: 5),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  "Rp${NumberFormat('#,###', 'id_ID').format(price)}", // Menggunakan price dari Map
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w400),
                ),
                const Spacer(),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 20),
                    SizedBox(width: 2),
                    Text(
                      ratings.toString(), // Menggunakan ratings dari Map
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              title, // Menggunakan title dari Map
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle, // Menggunakan subtitle dari Map
              textAlign: TextAlign.left,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 8),
            const Text(
              'Select Size',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: product['product_details'].map<Widget>((detail) {
                String size = detail['size'];
                int stock = detail['stock'];
                bool isOutOfStock = stock == 0;

                return ChoiceChip(
                  label: Text(size),
                  selectedColor: blue600,
                  labelStyle: selectedSize == size
                      ? TextStyle(color: whiteMain)
                      : TextStyle(color: gray800),
                  selected: selectedSize == size,
                  checkmarkColor: whiteMain,
                  onSelected: isOutOfStock
                      ? null // Jika stok habis, tidak bisa dipilih
                      : (bool selected) {
                          if (selected) {
                            setState(() {
                              selectedSize = size;
                            });
                          }
                        },
                );
              }).toList(),
            ),
            const SizedBox(height: 16),
            const Text(
              'Description',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              description, // Menggunakan description dari Map
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFA5D1FE),
                      Color(0xFFCDB4DB),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                padding: const EdgeInsets.all(1),
                child: OutlinedButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(16)),
                      ),
                      builder: (context) {
                        int quantity = 1; // Inisialisasi jumlah awal
                        return StatefulBuilder(
                          builder: (context, setModalState) {
                            return Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Select Size",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: product['product_details']
                                        .map<Widget>((detail) {
                                      String size = detail['size'];
                                      int stock = detail['stock'];
                                      bool isOutOfStock = stock == 0;

                                      return ChoiceChip(
                                        label: Text(size),
                                        checkmarkColor: whiteMain,
                                        selectedColor: blue500,
                                        labelStyle: selectedSize == size
                                            ? TextStyle(color: whiteMain)
                                            : TextStyle(color: gray800),
                                        selected: selectedSize == size,
                                        onSelected: isOutOfStock
                                            ? null
                                            : (bool selected) {
                                                if (selected) {
                                                  setModalState(() {
                                                    selectedSize = size;
                                                  });
                                                }
                                              },
                                      );
                                    }).toList(),
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Stock: ${product['product_details'].firstWhere((detail) => detail['size'] == selectedSize, orElse: () => {
                                              'stock': 0
                                            })['stock']}",
                                        style: const TextStyle(fontSize: 14),
                                      ),
                                      Row(
                                        children: [
                                          IconButton(
                                            icon: const Icon(Icons.remove),
                                            onPressed: quantity > 1
                                                ? () {
                                                    setModalState(() {
                                                      quantity--;
                                                    });
                                                  }
                                                : null,
                                          ),
                                          Text(
                                            quantity.toString(),
                                            style:
                                                const TextStyle(fontSize: 16),
                                          ),
                                          IconButton(
                                            icon: const Icon(Icons.add),
                                            onPressed: quantity <
                                                    product['product_details']
                                                        .firstWhere(
                                                            (detail) =>
                                                                detail[
                                                                    'size'] ==
                                                                selectedSize,
                                                            orElse: () => {
                                                                  'stock': 0
                                                                })['stock']
                                                ? () {
                                                    setModalState(() {
                                                      quantity++;
                                                    });
                                                  }
                                                : null,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  Container(
                                    width: double.infinity,
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 12.0),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        // Ambil detail produk berdasarkan ukuran yang dipilih
                                        final selectedDetail =
                                            product['product_details']
                                                .firstWhere(
                                          (detail) =>
                                              detail['size'] == selectedSize,
                                          orElse: () => throw Exception(
                                              "Detail produk tidak ditemukan"),
                                        );
                                        // Buat array Cart
                                        final cartArray = Cart(
                                            detailProductId:
                                                selectedDetail['id'],
                                            title: title,
                                            price: price,
                                            size: selectedSize,
                                            imageUrl: imageUrl,
                                            quantity: quantity,
                                            stock: selectedDetail['stock']);
                                        // Tambahkan ke keranjang menggunakan event Bloc
                                        context.read<CartBloc>().add(
                                            AddToCart(cartItem: cartArray));
                                        print(cartArray);

                                        // Tampilkan notifikasi kepada pengguna
                                        Fluttertoast.showToast(
                                          msg: "${title} Berhasil Ditambahkan",
                                          toastLength: Toast.LENGTH_SHORT,
                                          gravity: ToastGravity.TOP,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: Colors.green,
                                          textColor: Colors.white,
                                          fontSize: 16.0,
                                        );

                                        // Tutup Bottom Sheet setelah menambahkan ke keranjang
                                        Navigator.pop(context);
                                      },
                                      style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 8.0, horizontal: 8.0),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                          ),
                                          backgroundColor: blue600),
                                      child: Text(
                                        "ADD TO CART",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: whiteMain),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: whiteMain, // Warna latar belakang tombol
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    side: BorderSide.none, // Hilangkan garis pembatas
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.shopping_cart,
                        color: Color(0xFF8AA1D3),
                        size: 16.0,
                      ),
                      SizedBox(width: 4),
                      Text(
                        'ADD TO CART',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF8AA1D3), // Warna teks
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4F72BD),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Text(
                  'BUY',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFFFFFFF),
                    letterSpacing: 1.2, // Menambahkan spasi antar huruf
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
