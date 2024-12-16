import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:raffaelosanzio/api/address_api.dart';
import 'package:raffaelosanzio/api/profile_api.dart';
import 'package:raffaelosanzio/blocs/cart/cart_bloc.dart';
import 'package:raffaelosanzio/blocs/cart/cart_event.dart';
import 'package:raffaelosanzio/models/cart.dart';
import 'package:raffaelosanzio/models/hive/model.dart';
import 'package:raffaelosanzio/models/order.dart';
import 'package:raffaelosanzio/pages/editable_address_page.dart';
import 'package:raffaelosanzio/pages/success.dart';
import 'package:raffaelosanzio/shared/theme.dart';

class PaymentPage extends StatefulWidget {
  final List<Cart> selectedCart;

  const PaymentPage({super.key, required this.selectedCart});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> with RouteAware {
  Address? address;
  User? user;
  bool isLoading = true;
  late int totalItem;

  @override
  void initState() {
    super.initState();
    totalItem = widget.selectedCart.fold(0, (sum, cart) => sum + cart.quantity);
    _fetchAddress();
  }

  void _clearSelectedCartItems() {
    for (var cart in widget.selectedCart) {
      context
          .read<CartBloc>()
          .add(RemoveFromCart(detailProductId: cart.detailProductId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gray50,
      appBar: AppBar(
        backgroundColor: whiteMain,
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
        title: Text(
          "Payment",
          style: GoogleFonts.plusJakartaSans(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: gray600,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildAddressSection(context),
            const SizedBox(height: 16),
            _buildItemsSection(),
            const SizedBox(height: 16),
            _buildPaymentMethodSection(),
            const SizedBox(height: 16),
            _buildSummarySection(),
            const SizedBox(height: 16),
            _buildPaymentButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildItemsSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: whiteMain,
        border: Border.all(color: gray100),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Items",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          ...widget.selectedCart
              .map((cart) => _buildItemRowWithImage(cart)),
        ],
      ),
    );
  }

  Widget _buildItemRowWithImage(Cart cart) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            cart.imageUrl,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  cart.title,
                  style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                Row(
                  children: [
                    Text(
                      'Size: ${cart.size}',
                      style: GoogleFonts.plusJakartaSans(fontSize: 14),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Qty: ${cart.quantity}',
                      style: GoogleFonts.plusJakartaSans(fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  "Rp${NumberFormat('#,###', 'id_ID').format(cart.price * cart.quantity)}",
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      color: gray800,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _fetchAddress() async {
    isLoading = true;
    final box = await AddressApiHandler().getAddress();
    await UserApiHandler().fetchUser();
    var boxUser = Hive.box('User');
    User user = boxUser.get(1);
    final address = box.where((element) => element.isDefault == true).first;
    setState(() {
      this.address = address;
      this.user = user;
      if (this.address != null) {
        isLoading = false;
      }
    });
  }

  Widget _buildAddressSection(BuildContext context) {
    if (isLoading) {
      return GestureDetector(
        onTap: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => EditableAddressPage(
                      // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
                      onSave: (String) {},
                    )),
          ).then((value) {
            _fetchAddress();
          })
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: whiteMain,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                offset: const Offset(2, 2),
                blurRadius: 4,
              ),
            ],
          ),
          child: Center(
            child: Text(
              'Alamat Utama Belum Ditentukan',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: blue600,
              ),
            ),
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: whiteMain,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(2, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(Icons.location_on, color: blue600),
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditableAddressPage(
                              // ignore: avoid_types_as_parameter_names, non_constant_identifier_names
                              onSave: (String) {},
                            )),
                  ).then((value) {
                    _fetchAddress();
                  });
                },
                child: Icon(
                  Icons.edit,
                  color: blue600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "${user!.fullname} | 0813XXXXXXX",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          Text(
            address!.address,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethodSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: whiteMain,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blueAccent.withOpacity(0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.payment,
                  color: Color.fromARGB(255, 79, 114, 189)),
              const SizedBox(width: 8),
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
          const SizedBox(height: 8),
          Row(
            children: [
              const Icon(Icons.money,
                  color: Color.fromARGB(255, 148, 148, 148)),
              const SizedBox(width: 8),
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
    final int totalAmount = widget.selectedCart
        .fold(0, (sum, cart) => sum + (cart.price * cart.quantity));
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: whiteMain,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            offset: const Offset(2, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSummaryRow('Total Barang', '$totalItem'),
          _buildSummaryRow('Total Harga', 'Rp $totalAmount'),
          const Divider(),
          _buildSummaryRow('Total Pembayaran', 'Rp $totalAmount',
              isTotal: true),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String title, String amount, {bool isTotal = false}) {
    return Container(
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

  Widget _buildPaymentButton(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 79, 114, 189),
        padding: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * 0.02,
          horizontal: MediaQuery.of(context).size.width * 0.32,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: () {
        if (isLoading) {
          Fluttertoast.showToast(
            msg: 'Pilih Alamat Yang Ingin Digunakan',
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0,
          );
        } else {
          _clearSelectedCartItems();
          List<OrderDetailForm> orderDetails = widget.selectedCart
              .map((cart) => OrderDetailForm(
                    detailId: cart.detailProductId,
                    amount: cart.quantity,
                  ))
              .toList();
          OrderForm orderForm =
              OrderForm(addressId: address!.id, detailProducts: orderDetails);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LoadingToFlipCheck(
                orderForm: orderForm,
              ),
            ),
          );
        }
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
  }
}
