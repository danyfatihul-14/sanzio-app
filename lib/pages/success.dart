import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:intl/intl.dart';
import 'package:raffaelosanzio/api/address_api.dart';
import 'package:raffaelosanzio/api/history_api.dart';
import 'package:raffaelosanzio/models/hive/model.dart';
import 'package:raffaelosanzio/models/order.dart';
import 'package:raffaelosanzio/shared/theme.dart';
import 'dart:math' as math;

import 'package:raffaelosanzio/widget/button.dart';

class LoadingToFlipCheck extends StatefulWidget {
  final OrderForm orderForm;

  const LoadingToFlipCheck({super.key, required this.orderForm});
  @override
  // ignore: library_private_types_in_public_api
  _LoadingToFlipCheckState createState() => _LoadingToFlipCheckState();
}

class _LoadingToFlipCheckState extends State<LoadingToFlipCheck>
    with TickerProviderStateMixin {
  late AnimationController _loadingController;
  late AnimationController _flipController;

  late Animation<double> _flipAnimation;
  bool _showCheckmark = false;
  Order? ordercode;

  @override
  void initState() {
    super.initState();

    // Inisialisasi loading controller
    _loadingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    // Inisialisasi flip controller
    _flipController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );

    // Inisialisasi flip animation
    _flipAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_flipController);

    // Memulai proses pesanan setelah inisialisasi
    _processOrder();
  }

  Future<void> _processOrder() async {
    try {
      // Simulasi atau panggil API
      ordercode = await HistoryApiHandler().createOrder(widget.orderForm);
      _loadingController.stop();

      // Mulai animasi flip
      _flipController.forward().whenComplete(() {
        setState(() {
          _showCheckmark = true;
        });

        // Tunggu 2 detik lalu pindah ke halaman berikutnya
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pushReplacement(
            // ignore: use_build_context_synchronously
            context,
            MaterialPageRoute(
              builder: (context) => CheckmarkPage(
                order: ordercode!,
              ),
            ),
          );
        });
      });
    } catch (e) {
      // Tangani error
      _loadingController.stop();
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Gagal memproses pesanan: $e"),
        ),
      );
    }
  }

  @override
  void dispose() {
    _loadingController.dispose();
    _flipController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteMain,
      body: Center(
        child: AnimatedBuilder(
          animation: _flipAnimation,
          builder: (context, child) {
            return Transform(
              alignment: Alignment.center,
              transform: Matrix4.rotationY(_flipAnimation.value * math.pi),
              child: _flipAnimation.value >= 0.5
                  ? Transform(
                      alignment: Alignment.center,
                      transform: Matrix4.rotationY(math.pi),
                      child: Column(
                        key: ValueKey<bool>(_showCheckmark),
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Hero(
                            tag: 'checkmark',
                            child: Icon(
                              IconsaxPlusBold.tick_circle, // Ikon centang
                              color: blue600, // Warna ikon putih
                              size: 80, // Ukuran ikon
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Pemesanan Berhasil',
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 20,
                              fontWeight: FontWeight.bold, // Font tebal
                              color: blue600, // Warna teks putih
                            ),
                          ),
                        ],
                      ),
                    )
                  : SizedBox(
                      key: ValueKey<bool>(_showCheckmark),
                      width: 50,
                      height: 50,
                      child: CircularProgressIndicator(
                        color: blue600,
                        strokeWidth: 8.0,
                        strokeCap: StrokeCap.round,
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }
}

class CheckmarkPage extends StatefulWidget {
  final Order order;

  const CheckmarkPage({super.key, required this.order});

  @override
  State<CheckmarkPage> createState() => _CheckmarkPageState();
}

class _CheckmarkPageState extends State<CheckmarkPage> {
  Address? address;

  @override
  void initState() {
    super.initState();
    _fetchAddress();
  }

  Future<void> _fetchAddress() async {
    final _address = await AddressApiHandler().getAddress();
    setState(() {
      address = _address.firstWhere((element) => element.isDefault == true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gray50,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 60),
            decoration: BoxDecoration(
              color: blue600,
              image: const DecorationImage(
                image: AssetImage('assets/bg_success.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              children: [
                Center(
                  child: Hero(
                    tag: 'checkmark',
                    child: Icon(
                      IconsaxPlusBold.tick_circle, // Ikon centang
                      color: whiteMain, // Warna ikon putih
                      size: 80, // Ukuran ikon
                    ),
                  ),
                ),
                const SizedBox(height: 14.0),
                Text(
                  "Pemesanan Berhasil",
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 24,
                    fontWeight: FontWeight.bold, // Font tebal
                    color: whiteMain, // Warna teks putih
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16.0),
            decoration: BoxDecoration(
              color: whiteMain,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Detail Transaksi",
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: gray600,
                    ),
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        IconsaxPlusLinear.location,
                        color: gray600,
                        size: 24.0,
                      ),
                      const SizedBox(
                        width: 8.0,
                      ),
                      Expanded(
                        child: Text(
                          address?.address ?? 'Alamat tidak ditemukan',
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                            color: gray600,
                          ),
                          softWrap: true,
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Container(
                    height: 1.0,
                    color: gray300,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "No. Pesanan",
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: gray600,
                            ),
                          ),
                          Text(
                            widget.order.orderCode,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: gray400,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Tanggal",
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: gray600,
                            ),
                          ),
                          Text(
                            DateFormat('dd MMM yyyy').format(widget.order.orderDate),
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: gray400,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 4.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Waktu",
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: gray600,
                            ),
                          ),
                          Text(
                            "${DateFormat('HH:mm').format(widget.order.orderDate.toLocal())} WIB",
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: gray400,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Container(
                    height: 1.0,
                    color: gray300,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: gray600,
                        ),
                      ),
                      Text(
                        NumberFormat.currency(locale: 'id', symbol: 'Rp ', decimalDigits: 0).format(widget.order.amount),
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: gray400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 16.0,
          ),
          Row(
            children: [
              Expanded(
                child: CustomOutlineButton(
                  title: "Kembali ke Beranda",
                  color: blue600,
                  pushTo: () {
                    Navigator.pushReplacementNamed(context, '/main-home');
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
