import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:raffaelosanzio/api/profile_api.dart';
import 'package:raffaelosanzio/blocs/cart/cart_bloc.dart';
import 'package:raffaelosanzio/blocs/cart/cart_event.dart';
import 'package:raffaelosanzio/blocs/cart/cart_state.dart';
import 'package:raffaelosanzio/models/hive/model.dart';
import 'package:raffaelosanzio/pages/payment.dart';
import 'package:raffaelosanzio/shared/theme.dart';
import 'package:raffaelosanzio/widget/cart_widget.dart';

class ShoppingCartPage extends StatefulWidget {
  const ShoppingCartPage({super.key});

  @override
  State<ShoppingCartPage> createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage> {
  User? user;

  Future<void> getUser() async {
    final box = await UserApiHandler().getUser();
    setState(() {
      user = box;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
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
          "Cart",
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
          Expanded(
            child: BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                if (state is CartUpdated && state.cartItems.isNotEmpty) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            BlocBuilder<CartBloc, CartState>(
                              builder: (context, state) {
                                bool allSelected = false;
                                if (state is CartUpdated) {
                                  allSelected = state.cartItems.isNotEmpty
                                      ? state.cartItems.every((item) =>
                                              item.status == 'Selected')
                                          ? true
                                          : false
                                      : false;
                                  return Checkbox(
                                    value: allSelected,
                                    onChanged: (bool? value) {
                                      for (int i = 0;
                                          i < state.cartItems.length;
                                          i++) {
                                        context.read<CartBloc>().add(
                                            ToggleSelectEvent(
                                                i, value ?? false));
                                        setState(() {});
                                      }
                                    },
                                  );
                                }
                                return Checkbox(
                                  value: allSelected,
                                  onChanged: (bool? value) {
                                    allSelected = false;
                                  },
                                );
                              },
                            ),
                            Text(
                              "Select All",
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: blue600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.cartItems.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: CartItemWidget(
                                      cart: state.cartItems[index],
                                      onIncrement: () {
                                        context.read<CartBloc>().add(
                                            UpdateQuantityEvent(
                                                index,
                                                state.cartItems[index]
                                                        .quantity +
                                                    1));
                                        setState(() {});
                                      },
                                      onDecrement: () {
                                        context.read<CartBloc>().add(
                                            UpdateQuantityEvent(
                                                index,
                                                state.cartItems[index]
                                                        .quantity -
                                                    1));
                                        setState(() {});
                                      },
                                      onRemove: () {
                                        context.read<CartBloc>().add(
                                            RemoveFromCart(
                                                detailProductId: state
                                                    .cartItems[index]
                                                    .detailProductId));
                                        setState(() {});
                                      },
                                      onCheckboxChanged: (bool? value) {
                                        context.read<CartBloc>().add(
                                            ToggleSelectEvent(
                                                index, value ?? false));
                                        setState(() {});
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      // Container for total items and total price placed at the bottom
                      Container(
                        color: whiteMain,
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
                                BlocBuilder<CartBloc, CartState>(
                                  builder: (context, state) {
                                    if (state is CartUpdated) {
                                      final selectedItemCount = state.cartItems
                                          .where((item) =>
                                              item.status == 'Selected')
                                          .map((item) => item.quantity)
                                          .fold(
                                              0,
                                              (total, quantity) =>
                                                  total + quantity);

                                      return Text(
                                        "$selectedItemCount",
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400,
                                          color: Colors.black,
                                        ),
                                      );
                                    }
                                    return const SizedBox.shrink();
                                  },
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Total Price",
                                  style: GoogleFonts.plusJakartaSans(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                ),
                                BlocBuilder<CartBloc, CartState>(
                                  builder: (context, state) {
                                    if (state is CartUpdated) {
                                      return Text(
                                        NumberFormat.currency(
                                                locale: 'id_ID', symbol: 'Rp ')
                                            .format(state.totalPrice),
                                        style: GoogleFonts.plusJakartaSans(
                                          fontSize: 15,
                                          fontWeight: FontWeight.w600,
                                          color: Colors.black,
                                        ),
                                      );
                                    }
                                    return const SizedBox.shrink();
                                  },
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                const SizedBox(height: 16),
                                ElevatedButton(
                                  onPressed: () {
                                    // Checkout action
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: blue400,
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 20, horizontal: 20),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.card_giftcard,
                                            color: gray800,
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
                                    final cartState =
                                        context.read<CartBloc>().state;

                                    if (cartState is CartUpdated) {
                                      final selectedItems = cartState.cartItems
                                          .where((item) =>
                                              item.status == 'Selected')
                                          .toList();

                                      if (selectedItems.isNotEmpty) {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => PaymentPage(
                                                selectedCart: selectedItems),
                                          ),
                                        );
                                      } else {
                                        Fluttertoast.showToast(
                                            msg:
                                                "Pilih setidaknya 1 Item terlebih dahulu",
                                            toastLength: Toast.LENGTH_SHORT,
                                            gravity: ToastGravity.TOP,
                                            timeInSecForIosWeb: 1,
                                            backgroundColor: Colors.red,
                                            textColor: Colors.white,
                                            fontSize: 16.0);
                                      }
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: (context
                                                .read<CartBloc>()
                                                .state is CartUpdated &&
                                            (context.read<CartBloc>().state
                                                    as CartUpdated)
                                                .cartItems
                                                .any((item) =>
                                                    item.status == 'Selected'))
                                        ? blue600
                                        : gray300,
                                    padding: EdgeInsets.symmetric(
                                      vertical:
                                          MediaQuery.of(context).size.height *
                                              0.02,
                                      horizontal:
                                          MediaQuery.of(context).size.width *
                                              0.32,
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
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/icon 1.png',
                        width: 150,
                        height: 150,
                      ),
                      const SizedBox(height: 16),
                      const Text("Cart is Empty"),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
