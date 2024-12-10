import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:raffaelosanzio/api/history_api.dart';
import 'package:raffaelosanzio/models/hive/model.dart';
import 'package:raffaelosanzio/shared/theme.dart';
import 'package:raffaelosanzio/widget/history_list.dart';
import 'package:raffaelosanzio/widget/on_process_list.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<Order> _orders = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _fetchHistoryFromHive();
  }

  Future<void> _fetchHistoryFromHive() async {
    _orders = [];
    await HistoryApiHandler().fetchHistory();
    _isLoading = false;
    var box = Hive.box('History');
    List<Order> orders = box.get(1)?.cast<Order>() ?? [];
    setState(() {
      _orders = orders;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: gray50,
      appBar: AppBar(
        backgroundColor: whiteMain,
        automaticallyImplyLeading: false,
        title: Text(
          "History",
          style: GoogleFonts.plusJakartaSans(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF000000),
          ),
        ),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicator: BoxDecoration(
            color: const Color.fromRGBO(79, 114, 189, 1),
            borderRadius: BorderRadius.circular(0.0),
          ),
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: Colors.white,
          unselectedLabelColor: const Color.fromARGB(255, 113, 113, 113),
          tabs: [
            Tab(
                child: Text('Done',
                    style: GoogleFonts.plusJakartaSans(
                        fontSize: 16, fontWeight: FontWeight.w600))),
            Tab(
              child: Text(
                'On Process',
                style: GoogleFonts.plusJakartaSans(
                    fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : _orders.isEmpty
                  ? Center(
                      child: Text(
                        "No items in process",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  : HistoryList(
                      orders: _orders,
                    ),
          _isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : _orders.isEmpty
                  ? Center(
                      child: Text(
                        "No items in process",
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey,
                        ),
                      ),
                    )
                  : OnProcessList(
                      orders: _orders,
                      then: _fetchHistoryFromHive,
                    ),
        ],
      ),
    );
  }
}
