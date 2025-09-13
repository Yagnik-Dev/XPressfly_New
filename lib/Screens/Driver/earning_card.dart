// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:xpressfly_git/Constants/color_constant.dart';

// class EarningCard extends StatelessWidget {
//   const EarningCard({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Stack(
//         clipBehavior: Clip.none,
//         children: [
//           // White card
//           Container(
//             width: double.infinity,
//             margin: const EdgeInsets.all(16),
//             padding: const EdgeInsets.all(20),
//             decoration: BoxDecoration(
//               color: Colors.white,
//               borderRadius: BorderRadius.circular(28),
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const Text(
//                   "Today Earning",
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.w500,
//                     color: Colors.black87,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 const Text(
//                   "₹ 3,265.00",
//                   style: TextStyle(
//                     fontSize: 34,
//                     fontWeight: FontWeight.w700,
//                     color: Color(0xFFE74C3C),
//                   ),
//                 ),
//                 const SizedBox(height: 24),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: const [
//                         Text(
//                           "Total Trips",
//                           style: TextStyle(color: Colors.grey, fontSize: 14),
//                         ),
//                         SizedBox(height: 4),
//                         Text(
//                           "15",
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.black,
//                           ),
//                         ),
//                       ],
//                     ),
//                     const SizedBox(width: 40),
//                     Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: const [
//                         Text(
//                           "Total Distance",
//                           style: TextStyle(color: Colors.grey, fontSize: 14),
//                         ),
//                         SizedBox(height: 4),
//                         Text(
//                           "60km",
//                           style: TextStyle(
//                             fontSize: 16,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.black,
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ],
//             ),
//           ),

//           // Floating red circular button (outside card)
//           Positioned(
//             right: 32,
//             bottom: 10,
//             child: Container(
//               width: 160,
//               padding: const EdgeInsets.all(14),
//               decoration: BoxDecoration(
//                 color: const Color(0xFFE74C3C),
//                 shape: BoxShape.circle,
//                 border: Border.all(color: ColorConstant.clr242424, width: 4),
//               ),
//               child: Row(
//                 children: [
//                   Container(
//                     width: 28,
//                     height: 28,
//                     decoration: const BoxDecoration(
//                       color: Colors.red,
//                       shape: BoxShape.circle,
//                     ),
//                     child: const Icon(
//                       Icons.arrow_upward,
//                       color: Color(0xFFE74C3C),
//                       size: 16,
//                     ),
//                   ),
//                   const SizedBox(width: 8),
//                   SvgPicture.asset(
//                     "assets/icons/earning_logo.svg", // your custom icon
//                     width: 28,
//                     height: 28,
//                     color: Colors.white,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

import 'package:xpressfly_git/Utility/common_imports.dart';

class TodayEarningCard extends StatelessWidget {
  const TodayEarningCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Today Earning',
              style: TextStyle(
                fontSize: 16,
                color: Colors.black54,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 12),
            Text(
              '₹ 3,265.00',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Trips',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '15',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Distance',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    SizedBox(height: 4),
                    Text(
                      '60 km',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                CircleAvatar(
                  backgroundColor: Colors.redAccent,
                  child: Icon(Icons.local_taxi, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
