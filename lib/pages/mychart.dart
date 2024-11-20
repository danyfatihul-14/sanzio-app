import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:raffaelosanzio/models/cart.dart';
import 'package:raffaelosanzio/pages/payment.dart';

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  List<Cart> cartItems = [
    Cart(
      name: 'Jacket Bomber',
      price: 150000,
      quantity: 1,
      ukuran: "XL",
      imageUrl: 'assets/Daster.png',
    ),
    Cart(
      name: 'T-shirt',
      price: 75000,
      quantity: 2,
      ukuran: "XL",
      imageUrl: 'assets/T-Shirt.png',
    ),
    Cart(
      name: 'Jeans',
      price: 125000,
      quantity: 1,
      ukuran: "XL",
      imageUrl: 'assets/Batik.png',
    ),
  ];
  // Controllers for the checkout form fields
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  // Getters for total items and total price
  int get totalItems => cartItems.fold(0, (sum, item) {
        return item.status == 'Selected' ? sum + item.quantity : sum;
      });
  int get totalPrice {
    return cartItems.fold(0, (sum, item) {
      if (item.status == 'Selected') {
        return sum + (item.price * item.quantity);
      }
      return sum;
    });
  }

  bool selectAll = false;
  void toggleSelectAll(bool? value) {
    setState(() {
      selectAll = value ?? false;
      for (var item in cartItems) {
        item.status = selectAll ? 'Selected' : 'In Cart';
      }
    });
  }

  void incrementQuantity(int index) {
    setState(() {
      cartItems[index].quantity++;
    });
  }

  void decrementQuantity(int index) {
    setState(() {
      if (cartItems[index].quantity > 1) {
        cartItems[index].quantity--; // Mengurangi jumlah item, minimal 1
      }
    });
  }

  void removeItem(int index) {
    setState(() {
      cartItems.removeAt(index);
    });
  }

  void checkout() {
    String name = nameController.text;
    String address = addressController.text;

    if (name.isNotEmpty && address.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Checkout successful for $name!")),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in your details.")),
      );
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "My Cart",
          style: GoogleFonts.plusJakartaSans(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Select All Checkbox
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Checkbox(
                  value: selectAll,
                  onChanged: toggleSelectAll,
                ),
                Text(
                  "Select All",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: const Color.fromARGB(255, 79, 114, 189),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: CartItemWidget(
                          cart: cartItems[index],
                          onIncrement: () => incrementQuantity(index),
                          onDecrement: () => decrementQuantity(index),
                          onRemove: () => removeItem(index),
                          onCheckboxChanged: (bool? value) {
                            setState(() {
                              cartItems[index].status =
                                  value! ? 'Selected' : 'In Cart';
                              selectAll = cartItems.every(
                                (item) => item.status == 'Selected',
                              );
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total Items",
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      totalItems.toString().padLeft(3, '0'),
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Total Price",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        )),
                    Text("Rp ${totalPrice.toString()}",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        )),
                  ],
                ),
                Column(
                  children: [
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: checkout,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 138, 161, 211),
                        padding: const EdgeInsets.symmetric(
                            vertical: 20, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(
                                Icons.card_giftcard,
                                color: Colors.black,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                "Voucher",
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "Gunakan/masukan kode",
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        // Navigate to PaymentScreen
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const PaymentPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 79, 114, 189),
                        padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height * 0.02,
                          horizontal: MediaQuery.of(context).size.width * 0.32,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        "Checkout",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CartItemWidget extends StatelessWidget {
  final Cart cart;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onRemove;
  final ValueChanged<bool?> onCheckboxChanged;

  const CartItemWidget({
    super.key,
    required this.cart,
    required this.onIncrement,
    required this.onDecrement,
    required this.onRemove,
    required this.onCheckboxChanged, // Menambahkan callback untuk perubahan status checkbox
  });

  @override
  Widget build(BuildContext context) {
    final formattedPrice = NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp. ',
      decimalDigits: 0,
    ).format(cart.price);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(2.0),
        child: Row(
          children: [
            Checkbox(
              value: cart.status == 'Selected',
              onChanged: onCheckboxChanged,
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: SizedBox(
                width: 80,
                height: 80,
                child: Image.asset(
                  cart.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          cart.name,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: onRemove,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          // ignore: avoid_print
                          print("Ukuran dipilih");
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              Text(
                                cart.ukuran,
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          "Rp. ${cart.price.toString()}",
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                          overflow:
                              TextOverflow.ellipsis, // Menangani teks panjang
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            color:
                                cart.quantity > 1 ? Colors.blue : Colors.grey,
                            onPressed: cart.quantity > 1 ? onDecrement : null,
                          ),
                          Text(
                            cart.quantity.toString(),
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline),
                            color: Colors.blue,
                            onPressed: onIncrement,
                          ),
                        ],
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
  }
}