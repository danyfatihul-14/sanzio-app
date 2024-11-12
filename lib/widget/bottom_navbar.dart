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

class CustomBottomNavbar extends StatelessWidget {
  const CustomBottomNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: blue600,
      unselectedItemColor: blue400,
      items: [
        const BottomNavigationBarItem(
          icon: Icon(IconsaxPlusBold.home_2),
          label: "Home",
        ),
        const BottomNavigationBarItem(
          icon: Icon(IconsaxPlusLinear.heart),
          label: "FYP",
        ),
        const BottomNavigationBarItem(
          icon: Icon(IconsaxPlusBroken.shopping_cart),
          label: "Cart",
        ),
        const BottomNavigationBarItem(
          icon: Icon(IconsaxPlusBroken.profile_circle),
          label: "Profile",
        ),
      ],
    );
  }
}
