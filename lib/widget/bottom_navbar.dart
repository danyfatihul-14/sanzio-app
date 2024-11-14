import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;  // Update index tab yang dipilih
    });

    print('Tapped index: $index');  // Log untuk memeriksa index yang dipilih

    switch (index) {
      case 0: // Home
        Navigator.pushNamed(context, '/home');  // Gunakan pushNamed untuk navigasi ke Home
        break;
      case 1: // FYP
        Navigator.pushNamed(context, '/fyp');  // Gunakan pushNamed untuk navigasi ke FYP
        break;
      case 2: // History
        Navigator.pushNamed(context, '/history');  // Gunakan pushNamed untuk navigasi ke History
        break;
      case 3: // Profile
        Navigator.pushNamed(context, '/profile');  // Gunakan pushNamed untuk navigasi ke Profile
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      onTap: _onItemTapped,  // Panggil fungsi saat item ditap
      type: BottomNavigationBarType.fixed,
      currentIndex: _selectedIndex,  // Menyimpan index tab yang aktif
      selectedItemColor: Colors.blue,  // Warna untuk tab yang aktif
      unselectedItemColor: Colors.grey,  // Warna untuk tab yang tidak aktif
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
          activeIcon: Icon(IconsaxPlusBold.bag_timer), // Ikon bold untuk aktif
          label: "History",
        ),
        BottomNavigationBarItem(
          icon: Icon(IconsaxPlusBroken.profile_circle),
          activeIcon: Icon(IconsaxPlusBold.profile_circle), // Ikon bold untuk aktif
          label: "Profile",
        ),
      ],
    );
  }
}
