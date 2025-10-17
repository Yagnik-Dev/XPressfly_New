import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/image_constant.dart';
import 'package:xpressfly_git/Constants/text_style_constant.dart';
import 'package:xpressfly_git/Screens/Driver/order_history_screen.dart';

class CustomerHistoryScreen extends StatelessWidget {
  const CustomerHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.clrF7FCFF,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          "Track Order",
          style: TextStyleConstant().titleTextStyle26w600Clr242424,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(28),
            bottomRight: Radius.circular(28),
          ),
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 25.h),
            Expanded(
              child: Stack(
                alignment: Alignment.topCenter,
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 85.h),
                    width: double.infinity,
                    padding: EdgeInsets.only(
                      top: 60,
                      left: 16,
                      right: 16,
                      bottom: 16,
                    ),
                    decoration: BoxDecoration(
                      color: ColorConstant.clrWhite,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(28.r),
                        topRight: Radius.circular(28.r),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Your Order',
                          style:
                              TextStyleConstant()
                                  .subTitleTextStyle18w500Clr242424,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              '20kg',
                              style:
                                  TextStyleConstant()
                                      .subTitleTextStyle14w500Clr9D9D9D,
                            ),
                            SizedBox(width: 16),
                            Text(
                              '|',
                              style: TextStyle(
                                color: ColorConstant.clr9D9D9D,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(width: 16),
                            Text(
                              'Mini Truck',
                              style:
                                  TextStyleConstant()
                                      .subTitleTextStyle14w500Clr9D9D9D,
                            ),
                            SizedBox(width: 16),
                            Text(
                              '|',
                              style: TextStyle(
                                color: ColorConstant.clr9D9D9D,
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(width: 16),
                            Text(
                              'AHM',
                              style:
                                  TextStyleConstant()
                                      .subTitleTextStyle14w500Clr9D9D9D,
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8),
                          padding: const EdgeInsets.symmetric(
                            vertical: 16,
                            horizontal: 16,
                          ),
                          decoration: BoxDecoration(
                            color: ColorConstant.clrF7FCFF,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: const [
                              Text(
                                'Estimated delivery time',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16,
                                ),
                              ),
                              Spacer(),
                              Text(
                                '1Day 2Hours',
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        // Timeline steps
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildTimelineStep(
                              icon: Icons.arrow_downward_rounded,
                              title: 'Request Confirmation',
                              subtitle: 'We will pickup your item soon',
                              isActive: true,
                            ),
                            _buildTimelineDivider(),
                            _buildTimelineStep(
                              icon: Icons.arrow_downward_rounded,
                              title: 'In Transit',
                              subtitle: 'Your item was picked up',
                              isActive: true,
                            ),
                            _buildTimelineDivider(),
                            _buildTimelineStep(
                              icon: Icons.arrow_downward_rounded,
                              title: 'Out for Delivery',
                              subtitle: 'Your parcel is on the way',
                              isActive: true,
                            ),
                            _buildTimelineDivider(),
                            _buildTimelineStep(
                              icon: Icons.location_on_rounded,
                              title: 'Delivered',
                              subtitle: 'Parcel delivered successfully',
                              isActive: false,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Box image above the container
                  Positioned(
                    top: 0,
                    child: Image.asset(
                      ImageConstant.imgBox,
                      width: 130.w,
                      height: 130.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                ],
              ),
            ),
            // Add Spacer if you want to push content to bottom
            // const Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildTimelineStep({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isActive,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 34.w,
          height: 34.h,
          decoration: BoxDecoration(
            color: isActive ? const Color(0xFFF6FAFF) : Colors.white,
            border: Border.all(color: Colors.red.shade100, width: 2),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: ColorConstant.clrSecondary, size: 20.sp),
        ),
        SizedBox(width: 14.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyleConstant().subTitleTextStyle16w600Clr242424,
            ),
            // SizedBox(height: 2.h),
            Text(
              subtitle,
              style: TextStyleConstant().subTitleTextStyle14w500Clr9D9D9D,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildTimelineDivider() {
    return Padding(
      padding: EdgeInsets.only(left: 14.w),
      child: DashedLineVertical(
        height: 30.h,
        dashHeight: 3.h,
        dashGap: 4.h,
        color: ColorConstant.clrSubText,
        strokeWidth: 1.w,
      ),
    );
  }
}
