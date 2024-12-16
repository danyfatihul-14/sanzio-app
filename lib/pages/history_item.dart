import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:raffaelosanzio/api/address_api.dart';
import 'package:raffaelosanzio/api/history_api.dart';
import 'package:raffaelosanzio/api/profile_api.dart';
import 'package:raffaelosanzio/models/hive/model.dart';
import 'package:raffaelosanzio/shared/theme.dart';

class HistoryItemPage extends StatefulWidget {
  final Order orderItem;

  const HistoryItemPage({super.key, required this.orderItem});

  @override
  State<HistoryItemPage> createState() => _HistoryItemPageState();
}

class _HistoryItemPageState extends State<HistoryItemPage> with RouteAware {
  Address? address;
  User? user;
  bool isLoading = true;
  int totalItem = 0;
  int amount = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    totalItem = widget.orderItem.orderDetails.length;
    amount = widget.orderItem.amount;
    _fetchAddress();
  }

  Future<void> _finishOrder(int orderId) async {
    bool isFinished = await HistoryApiHandler().FinishOrder(orderId);
    if (isFinished) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } else {
      Fluttertoast.showToast(
        msg: "Failed to finish order",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<void> _cancleOrder(int orderId) async {
    bool isFinished = await HistoryApiHandler().CancleOrder(orderId);
    if (isFinished) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    } else {
      Fluttertoast.showToast(
        msg: "Failed to finish order",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gray50,
      appBar: AppBar(
        backgroundColor: whiteMain,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          "History Detail",
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
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                children: [
                  _buildAddressSection(context),
                  const SizedBox(height: 16),
                  _buildItemsSection(),
                  const SizedBox(height: 16),
                  _buildPaymentMethodSection(),
                  const SizedBox(height: 16),
                  _buildSummarySection(),
                  const SizedBox(height: 16),
                  widget.orderItem.finishAt != null
                      ? const SizedBox()
                      : Column(
                          children: [
                            _buildPaymentButton(context),
                            const SizedBox(height: 12),
                            _buildCancleButton(context),
                          ],
                        ),
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
          ...widget.orderItem.orderDetails
              .map((detail) => _buildItemRowWithImage(detail)),
        ],
      ),
    );
  }

  Widget _buildItemRowWithImage(OrderDetail detail) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.network(
            detail.productDetail.product.image,
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
                  detail.productDetail.product.title,
                  style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
                Row(
                  children: [
                    Text(
                      'Size: ${detail.productDetail.size}',
                      style: GoogleFonts.plusJakartaSans(fontSize: 14),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Qty: ${detail.amount}',
                      style: GoogleFonts.plusJakartaSans(fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text(
                  "Rp${NumberFormat('#,###', 'id_ID').format(detail.productDetail.product.price * detail.amount)}",
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
    _isLoading = true;
    final box = await AddressApiHandler().getAddress();
    await UserApiHandler().fetchUser();
    var boxUser = Hive.box('User');
    User user = boxUser.get(1);
    final address =
        box.where((element) => element.id == widget.orderItem.addressId).first;
    setState(() {
      this.address = address;
      this.user = user;
      if (this.address != null) {
        _isLoading = false;
      }
    });
  }

  Widget _buildAddressSection(BuildContext context) {
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
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "${user!.fullname} | ${user!.phone ?? '0899xxxxxxx'}",
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
          _buildSummaryRow('Total Harga',
              'Rp${NumberFormat('#,###', 'id_ID').format(amount)}'),
          const Divider(),
          _buildSummaryRow('Total Pembayaran',
              'Rp${NumberFormat('#,###', 'id_ID').format(amount)}',
              isTotal: true)
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
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      onPressed: () {
        _finishOrder(widget.orderItem.id);
      },
      child: Center(
        child: Text(
          widget.orderItem.isPaid ? 'Selesai' : 'Bayar Sekarang',
          style: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildCancleButton(BuildContext context) {
    return OutlinedButton(
      onPressed: () {
        _cancleOrder(widget.orderItem.id);
      },
      style: OutlinedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        side: BorderSide(
          color: purple600, // Border color
          width: 2.0, // Border width
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0), // Rounded corners
        ),
      ),
      child: Text(
        "Cancle Order",
        style: GoogleFonts.plusJakartaSans(
          fontSize: 16,
          fontWeight: FontWeight.w600,
          color: purple600, // Text color
        ),
      ),
    );
  }
}
