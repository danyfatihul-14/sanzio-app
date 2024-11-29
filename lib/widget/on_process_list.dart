import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:raffaelosanzio/models/hive/model.dart';
import 'package:raffaelosanzio/shared/theme.dart';

class OnProcessList extends StatelessWidget {
  final List<Order> orders;

  const OnProcessList({super.key, required this.orders});

  @override
  Widget build(BuildContext context) {
    final onProcessList =
        orders.where((orders) => orders.finishAt == null).toList();
    return onProcessList.isNotEmpty
        ? _buildListData(context, onProcessList)
        : _buildEmptyData();
  }

  Widget _buildEmptyData() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 16),
          Text(
            "No Orders",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: gray600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "You haven't made any orders yet",
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w400,
              color: gray400,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListData(BuildContext context, List<Order> onProcessList) {
    return ListView.builder(
      padding: const EdgeInsets.all(14.0),
      itemCount:
          onProcessList.length, // Update this with dynamic data if necessary
      itemBuilder: (context, index) {
        final orderItem = onProcessList[index];
        return Card(
          color: whiteMain,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  orderItem.orderCode,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  height: 1,
                  color: blue300,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(left: 12.0, top: 12.0),
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: gray100,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: blue400,
                              width: 2,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: whiteMain,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: blue400,
                              width: 2,
                            ),
                          ),
                          padding: const EdgeInsets.all(1.0),
                          child: Image.network(
                            orderItem
                                .orderDetails[0].productDetail.product.image,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Rp${NumberFormat('#,###', 'id_ID').format(orderItem.amount)}",
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: gray600,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "${orderItem.orderDetails.length.toString()} Barang",
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              color: gray500,
                            ),
                          ),
                          const SizedBox(height: 20),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "${DateFormat('dd MMM yyyy').format(orderItem.orderDate)}",
                                style: GoogleFonts.plusJakartaSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: gray300,
                                ),
                              ),
                              const Spacer(),
                              orderItem.isPaid
                                  ? Text(
                                      "On Process",
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.blue,
                                      ),
                                    )
                                  : Text(
                                      "Unpaid",
                                      style: GoogleFonts.plusJakartaSans(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.orange,
                                      ),
                                    ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
