import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:raffaelosanzio/blocs/cart/cart_bloc.dart';
import 'package:raffaelosanzio/blocs/cart/cart_event.dart';
import 'package:raffaelosanzio/blocs/cart/cart_state.dart';
import 'package:raffaelosanzio/models/cart.dart';
import 'package:raffaelosanzio/pages/payment.dart';
import 'package:raffaelosanzio/widget/cart_widget.dart';

class ShoppingCartPage extends StatelessWidget {
  const ShoppingCartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartBloc(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
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
            // Select All Checkbox
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  BlocBuilder<CartBloc, CartState>(
                    builder: (context, state) {
                      if (state is CartUpdated) {
                        bool allSelected =
                            state.cartItems.every((item) => item.isSelected);
                        return Checkbox(
                          value: allSelected,
                          onChanged: (bool? value) {
                            for (int i = 0; i < state.cartItems.length; i++) {
                              context
                                  .read<CartBloc>()
                                  .add(ToggleSelectEvent(i, value ?? false));
                            }
                          },
                        );
                      }
                      return const SizedBox.shrink();
                    },
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
              child: BlocBuilder<CartBloc, CartState>(
                builder: (context, state) {
                  print('Current State: $state');
                  if (state is CartUpdated) {
                    return ListView.builder(
                      itemCount: state.cartItems.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: CartItemWidget(
                                  cart: state.cartItems[index],
                                  onIncrement: () {
                                    context.read<CartBloc>().add(
                                        UpdateQuantityEvent(
                                            index,
                                            state.cartItems[index].quantity +
                                                1));
                                  },
                                  onDecrement: () {
                                    context.read<CartBloc>().add(
                                        UpdateQuantityEvent(
                                            index,
                                            state.cartItems[index].quantity -
                                                1));
                                  },
                                  onRemove: () {
                                    context.read<CartBloc>().add(RemoveFromCart(
                                        detailProductId: state
                                            .cartItems[index].detailProductId));
                                  },
                                  onCheckboxChanged: (bool? value) {
                                    context.read<CartBloc>().add(
                                        ToggleSelectEvent(
                                            index, value ?? false));
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
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
                      BlocBuilder<CartBloc, CartState>(
                        builder: (context, state) {
                          if (state is CartUpdated) {
                            return Text(
                              "${state.cartItems.length}",
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
                            horizontal:
                                MediaQuery.of(context).size.width * 0.32,
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
      ),
    );
  }
}
