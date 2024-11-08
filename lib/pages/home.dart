// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// // import 'package:iconsax_plus/iconsax_plus.dart';

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         elevation: 0,
//         backgroundColor: Colors.transparent,
//         title: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: TextField(
//             decoration: InputDecoration(
//               hintText: 'Search',
//               filled: true,
//               fillColor: Colors.grey[200],
//               prefixIcon: Icon(Icons.search, color: Colors.grey),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(10.0),
//                 borderSide: BorderSide.none,
//               ),
//             ),
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Banner Slider
//               Container(
//                 height: 180,
//                 child: PageView(
//                   children: [
//                     Image.asset('assets/banner1.png', fit: BoxFit.cover),
//                     Image.asset('assets/banner2.png', fit: BoxFit.cover),
//                     Image.asset('assets/banner3.png', fit: BoxFit.cover),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 16.0),

//               // Categories Section
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text("Categories", style: GoogleFonts.plusJakartaSans(fontSize: 18, fontWeight: FontWeight.bold)),
//                   Text("See All", style: GoogleFonts.plusJakartaSans(fontSize: 14, color: Colors.blue)),
//                 ],
//               ),
//               SizedBox(height: 8.0),
//               Container(
//                 height: 100,
//                 child: ListView(
//                   scrollDirection: Axis.horizontal,
//                   children: [
//                     // categoryItem("T-Shirts", Iconsax.tshirt),
//                     // categoryItem("Kemeja", Iconsax.shirt),
//                     // categoryItem("Blouse", Iconsax.blouse),
//                     // categoryItem("Dress", Iconsax.dress),
//                     // categoryItem("Jacket", Iconsax.jacket),
//                   ],
//                 ),
//               ),
//               SizedBox(height: 16.0),

//               // Popular Products Section
//               Text("Popular Products", style: GoogleFonts.plusJakartaSans(fontSize: 18, fontWeight: FontWeight.bold)),
//               SizedBox(height: 8.0),
//               GridView.count(
//                 crossAxisCount: 2,
//                 shrinkWrap: true,
//                 physics: NeverScrollableScrollPhysics(),
//                 childAspectRatio: 0.75,
//                 children: [
//                   productItem("Jacket Bomber", "Rp 150.000", "assets/jacket.png"),
//                   productItem("Daster", "Rp 150.000", "assets/daster.png"),
//                   productItem("Tank Top", "Rp 100.000", "assets/tanktop.png"),
//                   productItem("Batik Shirt", "Rp 250.000", "assets/batik.png"),
//                 ],
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         type: BottomNavigationBarType.fixed,
//         selectedItemColor: Colors.blue,
//         unselectedItemColor: Colors.grey,
//         items: [
//           BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
//           BottomNavigationBarItem(icon: Icon(Icons.explore), label: "FYP"),
//           BottomNavigationBarItem(icon: Icon(Icons.camera_alt), label: "Scan"),
//           BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: "Cart"),
//           BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
//         ],
//       ),
//     );
//   }

//   Widget categoryItem(String name, IconData icon) {
//     return Column(
//       children: [
//         CircleAvatar(
//           radius: 30,
//           backgroundColor: Colors.grey[200],
//           child: Icon(icon, color: Colors.grey[700]),
//         ),
//         SizedBox(height: 8.0),
//         Text(name, style: GoogleFonts.plusJakartaSans(fontSize: 12)),
//       ],
//     );
//   }

//   Widget productItem(String name, String price, String imagePath) {
//     return Card(
//       elevation: 2,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Expanded(child: Image.asset(imagePath, fit: BoxFit.cover)),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(name, style: GoogleFonts.plusJakartaSans(fontSize: 14, fontWeight: FontWeight.w500)),
//           ),
//           Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 8.0),
//             child: Text(price, style: GoogleFonts.plusJakartaSans(fontSize: 14, color: Colors.blue)),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Row(
//               children: [
//                 Icon(Icons.star, color: Colors.orange, size: 16),
//                 SizedBox(width: 4.0),
//                 Text("4.8", style: GoogleFonts.plusJakartaSans(fontSize: 12)),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
