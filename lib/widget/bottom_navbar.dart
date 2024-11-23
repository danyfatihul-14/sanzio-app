import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:raffaelosanzio/pages/history.dart';
import 'package:raffaelosanzio/pages/home.dart';
import 'package:raffaelosanzio/pages/profile.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      elevation: 5, // Menambah bayangan FAB
      backgroundColor: Colors.transparent,
      onPressed: () {}, // Tambahkan logika onPressed jika diperlukan
      child: Container(
        width: 50,
        height: 50,
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
          boxShadow: const [
            BoxShadow(
              color: Colors.white,
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: const Stack(
          alignment: Alignment.center,
          children: [
            Icon(IconsaxPlusBroken.user, size: 24, color: Colors.white),
            Positioned(
              bottom: 5,
              right: 4.5,
              child: Icon(IconsaxPlusBroken.maximize_2,
                  size: 40, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomBottomNavbar extends StatefulWidget {
  final int selectedIndex;
  const CustomBottomNavbar({super.key, this.selectedIndex = 0});

  @override
  _CustomBottomNavbarState createState() => _CustomBottomNavbarState();
}

class _CustomBottomNavbarState extends State<CustomBottomNavbar> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  List<Widget> widgetOptions = <Widget>[
    const HomePage(),
    const Text('FYP'),
    const HistoryPage(),
    const MyProfile(),
  ];

  void onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false, // Keyboard tidak mengubah ukuran halaman
      body: Center(
        child: widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onItemTapped,
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFF4F72BD),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(IconsaxPlusBold.home_2),
            activeIcon: Icon(IconsaxPlusBold.home_2),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(IconsaxPlusLinear.heart),
            activeIcon: Icon(IconsaxPlusBold.heart),
            label: "FYP",
          ),
          BottomNavigationBarItem(
            icon: Icon(IconsaxPlusBroken.bag_timer),
            activeIcon: Icon(IconsaxPlusBold.bag_timer),
            label: "History",
          ),
          BottomNavigationBarItem(
            icon: Icon(IconsaxPlusBroken.profile_circle),
            activeIcon: Icon(IconsaxPlusBold.profile_circle),
            label: "Profile",
          ),
        ],
      ),
      floatingActionButton: const ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
