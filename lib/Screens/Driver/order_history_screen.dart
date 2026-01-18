import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/text_style_constant.dart';
import 'package:xpressfly_git/Controller/order_history_controller.dart';
import 'package:xpressfly_git/Models/orderlist_model.dart';
import 'package:xpressfly_git/Localization/localization_keys.dart';

class OrderHistoryScreen extends StatelessWidget {
  final OrderHistoryController controller = Get.put(OrderHistoryController());

  OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context);

    return Scaffold(
      backgroundColor: ColorConstant.clrF7FCFF,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          LocalizationKeys.orderHistory.tr,
          style: TextStyleConstant().titleTextStyle26w600Clr242424,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(28),
            bottomRight: Radius.circular(28),
          ),
        ),
      ),
      body: Obx(
        () =>
            controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                  onRefresh: () => controller.refreshOrders(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 18.h,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            LocalizationKeys.activeOrders.tr,
                            style:
                                TextStyleConstant()
                                    .subTitleTextStyle18w500Clr242424,
                          ),
                          SizedBox(height: 12.h),
                          controller.activeOrders.isEmpty
                              ? Center(
                                child: Text(
                                  LocalizationKeys.noActiveOrders.tr,
                                  style:
                                      TextStyleConstant()
                                          .subTitleTextStyle14w500Clr9D9D9D,
                                ),
                              )
                              : Column(
                                children: List.generate(
                                  controller.activeOrders.length,
                                  (index) => Padding(
                                    padding: EdgeInsets.only(bottom: 12.h),
                                    child: OrderCard(
                                      order: controller.activeOrders[index],
                                    ),
                                  ),
                                ),
                              ),
                          SizedBox(height: 22.h),
                          Text(
                            LocalizationKeys.pastOrders.tr,
                            style:
                                TextStyleConstant()
                                    .subTitleTextStyle18w500Clr242424,
                          ),
                          SizedBox(height: 12.h),
                          controller.pastOrders.isEmpty
                              ? Center(
                                child: Text(
                                  LocalizationKeys.noPastOrders.tr,
                                  style:
                                      TextStyleConstant()
                                          .subTitleTextStyle14w500Clr9D9D9D,
                                ),
                              )
                              : Column(
                                children: List.generate(
                                  controller.pastOrders.length,
                                  (index) => Padding(
                                    padding: EdgeInsets.only(bottom: 12.h),
                                    child: OrderCard(
                                      order: controller.pastOrders[index],
                                    ),
                                  ),
                                ),
                              ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.07,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
      ),
    );
  }
}

class OrderCard extends StatelessWidget {
  final Data order;

  const OrderCard({super.key, required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(14.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
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
              DashedLineVertical(
                height: 30.h,
                dashHeight: 3.h,
                dashGap: 4.h,
                color: ColorConstant.clrSubText,
                strokeWidth: 1.w,
              ),
              SizedBox(height: 6.h),
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  order.fromAddress ?? "Unknown",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyleConstant().subTitleTextStyle16w600Clr242424,
                ),
                SizedBox(height: 4.h),
                Text(
                  LocalizationKeys.pickupPoint.tr,
                  style: TextStyleConstant().subTitleTextStyle14w500Clr9D9D9D,
                ),
                SizedBox(height: 30.h),
                Text(
                  order.toAddress ?? "Unknown",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyleConstant().subTitleTextStyle16w600Clr242424,
                ),
                SizedBox(height: 4.h),
                Text(
                  LocalizationKeys.destination.tr,
                  style: TextStyleConstant().subTitleTextStyle14w500Clr9D9D9D,
                ),
              ],
            ),
          ),
          SizedBox(width: 12.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                LocalizationKeys.payment.tr,
                style: TextStyleConstant().subTitleTextStyle14w500ClrSubText,
              ),
              SizedBox(height: 6.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 9.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: ColorConstant.clrF7FCFF,
                  borderRadius: BorderRadius.circular(50.r),
                ),
                child: Text(
                  "₹ ${order.distance ?? '0'}",
                  style: TextStyleConstant().subTitleTextStyle16w600Clr008000,
                ),
              ),
              SizedBox(height: 18.h),
              Text(
                LocalizationKeys.distance.tr,
                style: TextStyleConstant().subTitleTextStyle14w500ClrSubText,
              ),
              SizedBox(height: 2.h),
              Text(
                "${order.distance ?? '0'} Km",
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
