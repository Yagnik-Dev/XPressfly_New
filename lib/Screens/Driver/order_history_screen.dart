import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/text_style_constant.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // If you use ScreenUtil, ensure it's initialized in your app (ScreenUtilInit).
    ScreenUtil.init(context);

    return Scaffold(
      backgroundColor: ColorConstant.clrF7FCFF,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          "Order History",
          style: TextStyleConstant().titleTextStyle26w600Clr242424,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(28),
            bottomRight: Radius.circular(28),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Active Orders",
                style: TextStyleConstant().subTitleTextStyle18w500Clr242424,
              ),
              SizedBox(height: 12.h),
              OrderCard(),
              SizedBox(height: 22.h),
              Text(
                "Past Orders",
                style: TextStyleConstant().subTitleTextStyle18w500Clr242424,
              ),
              SizedBox(height: 12.h),
              Column(
                children: List.generate(
                  4,
                  (index) => Padding(
                    padding: EdgeInsets.only(bottom: 12.h),
                    child: OrderCard(),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.07),
            ],
          ),
        ),
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  const OrderCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black12,
        //     blurRadius: 12,
        //     offset: Offset(0, 6),
        //   ),
        // ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // icons column
          Column(
            children: [
              // pickup icon circle
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: ColorConstant.clrF7FCFF,
                  shape: BoxShape.circle,
                  border: Border.all(color: ColorConstant.clrEEEEEE, width: 2),
                ),
                child: Icon(
                  Icons.arrow_circle_down,
                  color: ColorConstant.clrSecondary,
                  size: 20.w,
                ),
              ),
              SizedBox(height: 6.h),

              // dashed vertical line
              DashedLineVertical(
                height: 30.h,
                dashHeight: 3.h,
                dashGap: 4.h,
                color: ColorConstant.clrSubText,
                strokeWidth: 1.w,
              ),

              SizedBox(height: 6.h),
              // destination icon circle
              Container(
                padding: EdgeInsets.all(8.w),
                decoration: BoxDecoration(
                  color: ColorConstant.clrF7FCFF,
                  shape: BoxShape.circle,
                  border: Border.all(color: ColorConstant.clrEEEEEE, width: 2),
                ),
                child: Icon(
                  Icons.location_on,
                  color: ColorConstant.clrSecondary,
                  size: 20.w,
                ),
              ),
            ],
          ),

          SizedBox(width: 14.w),

          // middle texts (pickup/destination)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "456 Shreeman Street, Su...",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyleConstant().subTitleTextStyle16w600Clr242424,
                ),
                SizedBox(height: 4.h),
                Text(
                  "Pickup Point",
                  style: TextStyleConstant().subTitleTextStyle14w500Clr9D9D9D,
                ),
                SizedBox(height: 30.h),
                Text(
                  "739 Honey Park, Surat",
                  style: TextStyleConstant().subTitleTextStyle16w600Clr242424,
                ),
                SizedBox(height: 4.h),
                Text(
                  "Destination",
                  style: TextStyleConstant().subTitleTextStyle14w500Clr9D9D9D,
                ),
              ],
            ),
          ),

          SizedBox(width: 12.w),

          // right info (payment/distance)
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Payment",
                style: TextStyleConstant().subTitleTextStyle14w500ClrSubText,
              ),
              SizedBox(height: 6.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: ColorConstant.clrF7FCFF, // very light green
                  borderRadius: BorderRadius.circular(50.r),
                ),
                child: Text(
                  "₹ 105",
                  style: TextStyleConstant().subTitleTextStyle16w600Clr008000,
                ),
              ),
              SizedBox(height: 18.h),
              Text(
                "Distance",
                style: TextStyleConstant().subTitleTextStyle14w500ClrSubText,
              ),
              SizedBox(height: 2.h),
              Text(
                "12Km",
                style: TextStyleConstant().subTitleTextStyle16w500Clr242424,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// Custom painter-based vertical dashed line
class DashedLineVertical extends StatelessWidget {
  final double height;
  final double dashHeight;
  final double dashGap;
  final double strokeWidth;
  final Color color;

  const DashedLineVertical({
    super.key,
    required this.height,
    this.dashHeight = 4,
    this.dashGap = 4,
    this.strokeWidth = 2,
    this.color = Colors.grey,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: strokeWidth,
      height: height,
      child: CustomPaint(
        painter: _DashedLinePainter(
          dashHeight: dashHeight,
          gap: dashGap,
          color: color,
          strokeWidth: strokeWidth,
        ),
      ),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  final double dashHeight;
  final double gap;
  final Color color;
  final double strokeWidth;

  _DashedLinePainter({
    required this.dashHeight,
    required this.gap,
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint =
        Paint()
          ..color = color
          ..strokeWidth = strokeWidth
          ..strokeCap = StrokeCap.round;

    double startY = 0;
    while (startY < size.height) {
      final endY = math.min(startY + dashHeight, size.height);
      canvas.drawLine(
        Offset(size.width / 2, startY),
        Offset(size.width / 2, endY),
        paint,
      );
      startY += dashHeight + gap;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
