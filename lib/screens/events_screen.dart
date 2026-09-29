// import 'package:flutter/material.dart';
//
// class EventsScreen extends StatelessWidget {
//   const EventsScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           physics: const BouncingScrollPhysics(),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 16),
//
//               // ===============================
//               // TOP CATEGORIES (Explore, Events, Activities)
//               // ===============================
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   _buildTopCategoryItem(
//                     title: 'Explore',
//                     icon: Icons.explore_outlined,
//                     isSelected: false,
//                     onTap: () => Navigator.pop(context),
//                   ),
//                   const SizedBox(width: 24),
//                   _buildTopCategoryItem(
//                     title: 'Events',
//                     icon: Icons.confirmation_number_outlined,
//                     isSelected: true,
//                     onTap: () {},
//                   ),
//                   const SizedBox(width: 24),
//                   _buildTopCategoryItem(
//                     title: 'Activities',
//                     icon: Icons.attractions_outlined,
//                     isSelected: false,
//                     onTap: () {},
//                   ),
//                 ],
//               ),
//
//               const SizedBox(height: 32),
//
//               // ===============================
//               // TITLE: global events worth traveling for
//               // ===============================
//               const Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 24),
//                 child: Text(
//                   'global events\nworth traveling for',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontFamily: 'serif',
//                     fontSize: 28,
//                     height: 1.15,
//                     fontWeight: FontWeight.w700,
//                     color: Colors.white,
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 24),
//
//               // ===============================
//               // FILTER CHIPS ROW (All Events, Music, Sports, etc.)
//               // ===============================
//               SizedBox(
//                 height: 44,
//                 child: ListView(
//                   scrollDirection: Axis.horizontal,
//                   padding: const EdgeInsets.symmetric(horizontal: 20),
//                   children: [
//                     _buildFilterChip(title: 'All Events', isSelected: true),
//                     const SizedBox(width: 10),
//                     _buildFilterChip(
//                       title: 'Music',
//                       icon: Icons.music_note,
//                       iconColor: Colors.greenAccent,
//                       isSelected: false,
//                     ),
//                     const SizedBox(width: 10),
//                     _buildFilterChip(
//                       title: 'Sports',
//                       icon: Icons.sports_motorsports,
//                       iconColor: Colors.pinkAccent,
//                       isSelected: false,
//                     ),
//                     const SizedBox(width: 10),
//                     _buildFilterChip(
//                       title: 'Art & C',
//                       icon: Icons.palette,
//                       iconColor: Colors.purpleAccent,
//                       isSelected: false,
//                     ),
//                   ],
//                 ),
//               ),
//
//               const SizedBox(height: 24),
//
//               // ===============================
//               // FEATURED F1 BANNER CARD
//               // ===============================
//               Container(
//                 margin: const EdgeInsets.symmetric(horizontal: 20),
//                 height: 200,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(24),
//                   image: const DecorationImage(
//                     image: AssetImage('assets/images/image.png'),  fit: BoxFit.cover,
//                   ),
//                 ),
//                 child: Stack(
//                   children: [
//                     // Gradient shadow for badge readability
//                     Positioned(
//                       bottom: 16,
//                       left: 0,
//                       right: 0,
//                       child: Center(
//                         child: Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 16,
//                             vertical: 8,
//                           ),
//                           decoration: BoxDecoration(
//                             color: Colors.black.withOpacity(0.6),
//                             borderRadius: BorderRadius.circular(25),
//                             border: Border.all(
//                               color: Colors.white.withOpacity(0.2),
//                             ),
//                           ),
//                           child: const Row(
//                             mainAxisSize: MainAxisSize.min,
//                             children: [
//                               Icon(
//                                 Icons.location_on_outlined,
//                                 color: Colors.white,
//                                 size: 16,
//                               ),
//                               SizedBox(width: 6),
//                               Text(
//                                 'F1 Championship, Barcelona',
//                                 style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               const SizedBox(height: 24),
//
//               // ===============================
//               // WHITE CONTAINER FOR GRID CARDS
//               // ===============================
//               Container(
//                 width: double.infinity,
//                 decoration: const BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.vertical(
//                     top: Radius.circular(30),
//                   ),
//                 ),
//                 padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
//                 child: Column(
//                   children: [
//                     // DATE HEADER (October 2026 - 14)
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Text(
//                           'October 2026',
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 14,
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         const SizedBox(width: 6),
//                         Container(
//                           width: 4,
//                           height: 4,
//                           decoration: const BoxDecoration(
//                             color: Colors.grey,
//                             shape: BoxShape.circle,
//                           ),
//                         ),
//                         const SizedBox(width: 6),
//                         const Text(
//                           '14',
//                           style: TextStyle(
//                             color: Colors.grey,
//                             fontSize: 14,
//                             fontWeight: FontWeight.w600,
//                           ),
//                         ),
//                       ],
//                     ),
//
//                     const SizedBox(height: 20),
//
//                     // ===============================
//                     // TWO MOTOGP EVENT CARDS
//                     // ===============================
//                     Row(
//                       children: [
//                         Expanded(
//                           child: _buildEventCard(
//                             imagePath: 'assets/images/home.png',
//                             countryFlag: '🇮🇩',
//                             visaText: 'Indonesia visa for',
//                             eventTitle: 'MOTOGP INDONESIA GP',
//                             visaInfo: 'Get Visa 12 days before',
//                           ),
//                         ),
//                         const SizedBox(width: 12),
//                         Expanded(
//                           child: _buildEventCard(
//                             imagePath: 'assets/images/explore.png',
//                             countryFlag: '🇮🇩',
//                             visaText: 'Indonesia visa for',
//                             eventTitle: 'MOTOGP INDONESIA 2026 (MANDALIKA)',
//                             visaInfo: 'Get Visa 12 days before',
//                           ),
//                         ),
//                       ],
//                     ),
//
//                     const SizedBox(height: 100), // Bottom nav space
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   // Helper widget for Top Categories
//   Widget _buildTopCategoryItem({
//     required String title,
//     required IconData icon,
//     required bool isSelected,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Column(
//         children: [
//           Container(
//             width: 50,
//             height: 50,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: isSelected ? Colors.white : Colors.grey.shade900,
//             ),
//             child: Icon(
//               icon,
//               color: isSelected ? Colors.black : Colors.white70,
//               size: 24,
//             ),
//           ),
//           const SizedBox(height: 6),
//           Text(
//             title,
//             style: TextStyle(
//               color: isSelected ? Colors.white : Colors.grey.shade500,
//               fontSize: 12,
//               fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
//             ),
//           ),
//           if (isSelected) ...[
//             const SizedBox(height: 3),
//             Container(
//               width: 16,
//               height: 2,
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.circular(2),
//               ),
//             ),
//           ],
//         ],
//       ),
//     );
//   }
//
//   // Helper widget for Filter Chips
//   Widget _buildFilterChip({
//     required String title,
//     IconData? icon,
//     Color? iconColor,
//     required bool isSelected,
//   }) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//       decoration: BoxDecoration(
//         color: isSelected ? Colors.white : Colors.grey.shade900,
//         borderRadius: BorderRadius.circular(25),
//         border: Border.all(
//           color: isSelected ? Colors.white : Colors.grey.shade800,
//         ),
//       ),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           if (icon != null) ...[
//             Icon(icon, color: iconColor ?? Colors.white, size: 16),
//             const SizedBox(width: 6),
//           ],
//           Text(
//             title,
//             style: TextStyle(
//               color: isSelected ? Colors.black : Colors.white,
//               fontSize: 13,
//               fontWeight: FontWeight.w600,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Helper widget for Individual Event Card
//   Widget _buildEventCard({
//     required String imagePath,
//     required String countryFlag,
//     required String visaText,
//     required String eventTitle,
//     required String visaInfo,
//   }) {
//     return Container(
//       height: 260,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(20),
//         color: Colors.grey.shade200,
//         image: DecorationImage(
//           image: AssetImage(imagePath),
//           fit: BoxFit.cover,
//           onError: (_, __) {},
//         ),
//       ),
//       child: Stack(
//         children: [
//           // Dark gradient overlay for text visibility
//           Positioned.fill(
//             child: Container(
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(20),
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [
//                     Colors.black.withOpacity(0.1),
//                     Colors.black.withOpacity(0.7),
//                   ],
//                 ),
//               ),
//             ),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(12),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 // Top Flag Badge
//                 Align(
//                   alignment: Alignment.topRight,
//                   child: Container(
//                     padding: const EdgeInsets.all(4),
//                     decoration: const BoxDecoration(
//                       color: Colors.white,
//                       shape: BoxShape.circle,
//                     ),
//                     child: Text(countryFlag, style: const TextStyle(fontSize: 12)),
//                   ),
//                 ),
//                 // Bottom Text details
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       visaText,
//                       style: const TextStyle(
//                         color: Colors.white70,
//                         fontSize: 10,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     const SizedBox(height: 2),
//                     Text(
//                       eventTitle,
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontSize: 13,
//                         fontWeight: FontWeight.bold,
//                         height: 1.2,
//                       ),
//                     ),
//                     const SizedBox(height: 8),
//                     Container(
//                       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                       decoration: BoxDecoration(
//                         color: Colors.black.withOpacity(0.4),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       child: Text(
//                         visaInfo,
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 8.5,
//                           fontWeight: FontWeight.w500,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }