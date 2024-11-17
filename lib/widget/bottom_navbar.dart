import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
import 'package:raffaelosanzio/pages/history.dart';
import 'package:raffaelosanzio/pages/home.dart';
import 'package:raffaelosanzio/shared/theme.dart';

class ScanButton extends StatelessWidget {
  const ScanButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Container(
        width: 50, // Adjust size as needed
        height: 50,
        decoration: BoxDecoration(
          // shape: BoxShape.circle,
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(
            colors: [
              Color(0xFFA5D1FE),
              Color(0xFFCDB4DB)
            ], // Adjust gradient colors
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: const [
            BoxShadow(
              color: Colors.white,
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 3), // Shadow position
            ),
          ],
        ),
        child: const Stack(
          alignment: Alignment.center,
          children: [
            Icon(IconsaxPlusBroken.user,
                size: 24, color: Colors.white), // Main icon
            Positioned(
              bottom: 5,
              right: 4.5,
              child: Icon(IconsaxPlusBroken.maximize_2,
                  size: 40, color: Colors.white), // Overlay icon
            ),
          ],
        ),
      ),
      onPressed: () {},
    );
  }
}

class CustomBottomNavbar extends StatefulWidget {
  const CustomBottomNavbar({super.key});

  @override
  _CustomBottomNavbarState createState() => _CustomBottomNavbarState();
}

class _CustomBottomNavbarState extends State<CustomBottomNavbar> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    HomePage(),
    Text('FYP'),
    HistoryPage(),
    Text('Profile'),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemTapped, // Panggil fungsi saat item ditap
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex, // Menyimpan index tab yang aktif
        selectedItemColor: const Color(0xFF4F72BD), // Warna untuk tab yang aktif
        unselectedItemColor: Colors.grey, // Warna untuk tab yang tidak aktif
        items: [
          BottomNavigationBarItem(
            icon: Icon(IconsaxPlusBold.home_2),
            activeIcon: Icon(IconsaxPlusBold.home_2), // Ikon bold untuk aktif
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(IconsaxPlusLinear.heart),
            activeIcon: Icon(IconsaxPlusBold.heart), // Ikon bold untuk aktif
            label: "FYP",
          ),
          BottomNavigationBarItem(
            icon: Icon(IconsaxPlusBroken.bag_timer),
            activeIcon:
                Icon(IconsaxPlusBold.bag_timer), // Ikon bold untuk aktif
            label: "History",
          ),
          BottomNavigationBarItem(
            icon: Icon(IconsaxPlusBroken.profile_circle),
            activeIcon:
                Icon(IconsaxPlusBold.profile_circle), // Ikon bold untuk aktif
            label: "Profile",
          ),
        ],
      ),
      floatingActionButton: const ScanButton(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}
