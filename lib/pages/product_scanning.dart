import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:raffaelosanzio/api/product_api.dart';
import 'package:raffaelosanzio/api/profile_api.dart';
import 'package:raffaelosanzio/models/hive/model.dart';
import 'package:raffaelosanzio/shared/theme.dart';
import 'package:raffaelosanzio/widget/button.dart';
import 'package:raffaelosanzio/widget/product_item.dart';

class ProductScanningPage extends StatefulWidget {
  // ignore: non_constant_identifier_names
  final int skin_type;
  // ignore: non_constant_identifier_names
  const ProductScanningPage({super.key, required this.skin_type});

  @override
  State<ProductScanningPage> createState() => _ProductScanningPageState();
}

class _ProductScanningPageState extends State<ProductScanningPage> {
  List<Product> _products = [];
  User? _user;
  bool _isLoading = true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _fetchProductsFromHive().then((_) {
      _showModalSave();
    });
  }

  Future<void> _fetchProductsFromHive() async {
    List<Product> products = await ProductApiHandler().getProducts();
    var user = await UserApiHandler().getUser();
    setState(() {
      _user = user;
      _products = products;
    });
    _isLoading = false;
  }

  void _showModalSave() {
    showModalBottomSheet<void>(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 128,
          color: whiteMain,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Text(
                  'Simpan Hasil Scan ?',
                  style: GoogleFonts.plusJakartaSans(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: gray600),
                ),
                const SizedBox(height: 16),
                CustomButton(
                    title: "Simpan",
                    color: blue600,
                    pushTo: () {
                      var box = Hive.box('SkinType');
                      box.put(1, widget.skin_type);
                      Fluttertoast.showToast(
                          msg: "Hasil Scan Berhasil Disimpan",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.TOP,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.green,
                          textColor: whiteMain,
                          fontSize: 16.0);
                      Navigator.pop(context);
                    })
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String color = SkinType.numToHexcode(widget.skin_type);
    int hexColor = int.parse('FF$color', radix: 16);
    return Scaffold(
      backgroundColor: gray50,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Product Scanning",
          style: GoogleFonts.plusJakartaSans(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: whiteMain,
        leading: IconButton(
          icon: Container(
            padding: const EdgeInsets.all(8.0), // Ukuran lingkaran
            child: Icon(
              Icons.arrow_back,
              color: blue600,
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                color: whiteMain,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: Color(hexColor),
                      borderRadius: const BorderRadius.all(Radius.circular(50)),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Your Skin Tone Type-${widget.skin_type + 1}",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Here is the product recommendation for you",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                        ),
                        softWrap: true,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  )
                ],
              ),
            ),
            _buildPopularProductsSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildPopularProductsSection() {
    List<Product> data = _products
        .where((element) =>
            element.skin_type
                .any((skinType) => skinType.skin_type == widget.skin_type) &&
            User.jsonToGender(element.gender) == _user!.gender)
        .toList();
    List<Map<String, dynamic>> formattedProducts =
        data.map((product) => product.toJson()).toList();
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            childAspectRatio: MediaQuery.of(context).size.width /
                (MediaQuery.of(context).size.height *
                    0.68), // Sesuaikan proporsi
            children: List.generate(
              formattedProducts.length,
              (index) {
                final product = formattedProducts[index];

                // Mengirimkan satu Map<String, dynamic> ke ProductItem
                return ProductItem(product: product);
              },
            ),
          )
        ],
      ),
    );
  }
}
