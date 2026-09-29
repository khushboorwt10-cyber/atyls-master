// import 'package:flutter/material.dart';
//
// class HomeBottomNav extends StatelessWidget {
//   final int selectedIndex;
//   final ValueChanged<int> onChanged;
//
//   const HomeBottomNav({
//     super.key,
//     required this.selectedIndex,
//     required this.onChanged,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 64,
//       margin: const EdgeInsets.symmetric(horizontal: 24),
//       padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(35),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.12),
//             blurRadius: 12,
//             offset: const Offset(0, 4),
//           ),
//         ],
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           // HOME TAB (Dynamic: Agar index 0 hai toh expanded pill, warna chota circle)
//           GestureDetector(
//             onTap: () => onChanged(0),
//             behavior: HitTestBehavior.opaque,
//             child: AnimatedContainer(
//               duration: const Duration(milliseconds: 200),
//               padding: selectedIndex == 0
//                   ? const EdgeInsets.symmetric(horizontal: 28, vertical: 10)
//                   : const EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 color: selectedIndex == 0 ? Colors.black : Colors.transparent,
//                 borderRadius: BorderRadius.circular(28),
//               ),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(
//                     Icons.home_rounded,
//                     color: selectedIndex == 0 ? Colors.white : Colors.black,
//                     size: 22,
//                   ),
//                   if (selectedIndex == 0) ...[
//                     const SizedBox(width: 8),
//                     const Text(
//                       'Home',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ],
//               ),
//             ),
//           ),
//
//           // PROFILE TAB (Dynamic: Agar index 1 hai toh expanded pill, warna chota circle)
//           GestureDetector(
//             onTap: () => onChanged(1),
//             behavior: HitTestBehavior.opaque,
//             child: AnimatedContainer(
//               duration: const Duration(milliseconds: 200),
//               padding: selectedIndex == 1
//                   ? const EdgeInsets.symmetric(horizontal: 44, vertical: 10)
//                   : const EdgeInsets.all(10),
//               decoration: BoxDecoration(
//                 color: selectedIndex == 1 ? Colors.black : Colors.transparent,
//                 borderRadius: BorderRadius.circular(28),
//               ),
//               child: Row(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Icon(
//                     Icons.person_rounded,
//                     color: selectedIndex == 1 ? Colors.white : Colors.black,
//                     size: 22,
//                   ),
//                   if (selectedIndex == 1) ...[
//                     const SizedBox(width: 8),
//                     const Text(
//                       'Profile',
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: 14,
//                         fontWeight: FontWeight.w600,
//                       ),
//                     ),
//                   ],
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }