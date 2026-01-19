import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/image_constant.dart';
import 'package:xpressfly_git/Constants/text_style_constant.dart';
import 'package:xpressfly_git/Localization/localization_keys.dart';
import 'package:xpressfly_git/Screens/Driver/order_history_screen.dart';
import 'package:xpressfly_git/Controller/customer_history_controller.dart';

class CustomerHistoryScreen extends StatelessWidget {
  const CustomerHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(CustomerHistoryController());

    return Scaffold(
      backgroundColor: ColorConstant.clrF7FCFF,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          LocalizationKeys.trackOrder.tr,
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
        child: Obx(
          () =>
              controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : controller.orderData.value == null
                  ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.inbox_outlined,
                          size: 80.sp,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          LocalizationKeys.noOrdersFound.tr,
                          style:
                              TextStyleConstant()
                                  .subTitleTextStyle18w500Clr242424,
                        ),
                      ],
                    ),
                  )
                  : _buildOrderDetails(context, controller),
        ),
      ),
    );
  }

  Widget _buildOrderDetails(
    BuildContext context,
    CustomerHistoryController controller,
  ) {
    final order = controller.orderData.value!;
    final timelineStatuses = controller.getTimelineStatuses();

    return Column(
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
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        LocalizationKeys.yourOrder.tr,
                        style:
                            TextStyleConstant()
                                .subTitleTextStyle18w500Clr242424,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            '${order.data?.weightInKg ?? '0'}kg',
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
                            order.data?.vehicleType ?? 'N/A',
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
                            order.data?.fromZipCode ?? 'N/A',
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
                          children: [
                            Text(
                              LocalizationKeys.estimatedDeliveryTime.tr,
                              style: TextStyle(color: Colors.red, fontSize: 16),
                            ),
                            Spacer(),
                            Text(
                              _calculateEstimatedTime(order.data?.pickupDate),
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
                            title: LocalizationKeys.requestConfirmation.tr,
                            subtitle:
                                LocalizationKeys.weWillPickupYourItemSoon.tr,
                            isActive:
                                timelineStatuses['requestConfirmation'] ??
                                false,
                          ),
                          _buildTimelineDivider(),
                          _buildTimelineStep(
                            icon: Icons.arrow_downward_rounded,
                            title: LocalizationKeys.inTransit.tr,
                            subtitle: LocalizationKeys.yourItemWasPickedUp.tr,
                            isActive: timelineStatuses['inTransit'] ?? false,
                          ),
                          _buildTimelineDivider(),
                          _buildTimelineStep(
                            icon: Icons.arrow_downward_rounded,
                            title: LocalizationKeys.outForDelivery.tr,
                            subtitle: LocalizationKeys.yourParcelIsOnTheWay.tr,
                            isActive:
                                timelineStatuses['outForDelivery'] ?? false,
                          ),
                          _buildTimelineDivider(),
                          _buildTimelineStep(
                            icon: Icons.location_on_rounded,
                            title: LocalizationKeys.delivered.tr,
                            subtitle:
                                LocalizationKeys.parcelDeliveredSuccessfully.tr,
                            isActive: timelineStatuses['delivered'] ?? false,
                          ),
                        ],
                      ),
                    ],
                  ),
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
      ],
    );
  }

  String _calculateEstimatedTime(String? pickupDate) {
    if (pickupDate == null) return 'N/A';

    try {
      final date = DateTime.parse(pickupDate);
      final now = DateTime.now();
      final difference = date.difference(now);

      if (difference.inDays > 0) {
        return '${difference.inDays} Day${difference.inDays > 1 ? 's' : ''}';
      } else if (difference.inHours > 0) {
        return '${difference.inHours} Hour${difference.inHours > 1 ? 's' : ''}';
      } else {
        return 'Today';
      }
    } catch (e) {
      return 'N/A';
    }
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
