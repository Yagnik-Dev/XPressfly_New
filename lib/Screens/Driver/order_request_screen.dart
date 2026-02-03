import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xpressfly_git/Common%20Components/common_button.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/text_style_constant.dart';
import 'package:xpressfly_git/Controller/order_request_controller.dart';
import 'package:xpressfly_git/Localization/localization_keys.dart';
import 'package:xpressfly_git/Models/order_request_model.dart';
import 'package:xpressfly_git/Screens/Driver/swipe_to_accept_button.dart';

class OrderRequestScreen extends StatelessWidget {
  OrderRequestScreen({super.key});

  final OrderRequestController controller = Get.put(OrderRequestController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.clrF2FAFF,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(46.h),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(30.r),
            bottomRight: Radius.circular(30.r),
          ),
          child: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            elevation: 0,
            automaticallyImplyLeading: false,
            title: Text(
              LocalizationKeys.orderRequest.tr,
              style: TextStyleConstant().titleTextStyle26w600Clr242424,
            ),
          ),
        ),
      ),
      body: Obx(() {
        // Loading state
        if (controller.isLoading.value && controller.orderList.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        }

        // Error state
        if (controller.errorMessage.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 60, color: Colors.red),
                SizedBox(height: 20),
                Text(
                  'Error',
                  style: TextStyleConstant().titleTextStyle26w600Clr242424,
                ),
                SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    controller.errorMessage.value,
                    textAlign: TextAlign.center,
                    style: TextStyleConstant().subTitleTextStyle14w400clr666666,
                  ),
                ),
                SizedBox(height: 30),
                SizedBox(
                  width: 95.w,
                  height: 38.h,
                  child: CommonButton(
                    radius: 50.r,
                    btnText: LocalizationKeys.retry.tr,
                    onPressed: () {
                      controller.clearError();
                      controller.refreshOrderList();
                    },
                  ),
                ),
              ],
            ),
          );
        }

        // Empty state
        if (controller.orderList.isEmpty) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.inbox_outlined, size: 80, color: Colors.grey),
                SizedBox(height: 20),
                Text(
                  LocalizationKeys.oops.tr,
                  style: TextStyleConstant().subTitleTextStyle26w600Clr242424,
                ),
                SizedBox(height: 6.h),
                Text(
                  LocalizationKeys.noMoreOrderRightNow.tr,
                  textAlign: TextAlign.center,
                  style: TextStyleConstant().subTitleTextStyle12w400Clr9D9D9D,
                ),
                SizedBox(height: 30),
                // ElevatedButton.icon(
                //   onPressed: controller.refreshOrderList,
                //   icon: const Icon(Icons.refresh),
                //   label: const Text('Refresh'),
                // ),
                SizedBox(
                  width: 95.w,
                  height: 38.h,
                  child: CommonButton(
                    radius: 50.r,
                    btnText: LocalizationKeys.retry.tr,
                    onPressed: controller.refreshOrderList,
                  ),
                ),
              ],
            ),
          );
        }

        // Order list
        return RefreshIndicator(
          onRefresh: controller.refreshOrderList,
          child: ListView.builder(
            padding: EdgeInsets.fromLTRB(0, 12.h, 0, 85.h),
            itemCount: controller.orderList.length,
            itemBuilder: (context, index) {
              final order = controller.orderList[index];
              return _buildOrderCard(context, order);
            },
          ),
        );
      }),
    );
  }

  Widget _buildOrderCard(BuildContext context, OrderData order) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      padding: EdgeInsets.all(15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // User Info Row
          Container(
            padding: EdgeInsets.all(12.sp),
            decoration: BoxDecoration(
              color: ColorConstant.clrFAFBFF,
              border: Border.all(color: ColorConstant.clrEEEEEE),
              borderRadius: BorderRadius.circular(12.sp),
            ),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Image.network(
                        order.customer?.profileImage ??
                            "https://images.unsplash.com/photo-1508214751196-bcfd4ca60f91?ixlib=rb-4.0.3&auto=format&fit=crop&w=100&q=80",
                        width: 55,
                        height: 55,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            width: 55,
                            height: 55,
                            color: Colors.grey[300],
                            child: const Icon(Icons.person),
                          );
                        },
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          log(
                            "============ Vehicle id ======= ${order.vehicleTypeId.toString()}",
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              order.customer?.name ?? "N/A",
                              style:
                                  TextStyleConstant()
                                      .subTitleTextStyle18w600Clr242424,
                            ),
                            Text(
                              order.customer?.phone ?? "N/A",
                              style:
                                  TextStyleConstant()
                                      .subTitleTextStyle14w400clr666666,
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Distance Container
                    Container(
                      decoration: BoxDecoration(
                        color: ColorConstant.clrSecondary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: EdgeInsets.symmetric(
                        horizontal: 11.w,
                        vertical: 6.h,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            order.distance ?? "0",
                            style:
                                TextStyleConstant()
                                    .subTitleTextStyle14w700clrWhite,
                          ),
                          Text(
                            "KM",
                            style:
                                TextStyleConstant()
                                    .subTitleTextStyle14w700clrWhite,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: ColorConstant.clrWhite,
                            border: Border.all(
                              color: ColorConstant.clrSecondary,
                            ),
                          ),
                          child: Icon(
                            Icons.location_on,
                            color: ColorConstant.clrSecondary,
                            size: 20,
                          ),
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          LocalizationKeys.pickPoint.tr,
                          style:
                              TextStyleConstant()
                                  .subTitleTextStyle10w400ClrSubText,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    SizedBox(width: 11.w),
                    Expanded(
                      child: Text(
                        order.fromAddress ?? "N/A",
                        style:
                            TextStyleConstant()
                                .subTitleTextStyle14w400Clr242424,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Divider(
                  color: ColorConstant.clrBorder,
                  thickness: 1,
                  endIndent: 10,
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                child: Text(
                  LocalizationKeys.deliveryDetails.tr,
                  style: TextStyleConstant().subTitleTextStyle12w400Clr9D9D9D,
                ),
              ),
              Expanded(
                child: Divider(
                  color: ColorConstant.clrBorder,
                  thickness: 1,
                  indent: 10,
                ),
              ),
            ],
          ),
          SizedBox(height: 8),
          // Delivery order number and date row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  "#${order.id}",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyleConstant().subTitleTextStyle18w500Clr242424,
                ),
              ),
              SizedBox(width: 2.w),
              Text(
                controller.formatDate(order.createdAt) ?? "N/A",
                style: TextStyleConstant().subTitleTextStyle12w400clr666666,
              ),
            ],
          ),
          SizedBox(height: 12),
          // Drop Point Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(width: 6),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: ColorConstant.clrSecondary),
                    ),
                    child: Icon(
                      Icons.location_on,
                      color: ColorConstant.clrSecondary,
                      size: 20,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Text(
                    LocalizationKeys.dropPoint.tr,
                    style:
                        TextStyleConstant().subTitleTextStyle10w400ClrSubText,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              SizedBox(width: 11.w),
              Expanded(
                child: Text(
                  order.toAddress ?? "N/A",
                  style: TextStyleConstant().subTitleTextStyle14w400Clr242424,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Obx(() {
                  final isProcessing = controller.isOrderProcessing(
                    order.id ?? '',
                  );
                  return SwipeToAcceptButton(
                    onAccept:
                        isProcessing
                            ? () {}
                            : () {
                              controller
                                  .acceptOrder(
                                    order.id ?? '',
                                    order.vehicleTypeId ?? 0,
                                  )
                                  .then((success) {
                                    if (success) {
                                      showSuccess(
                                        'Order accepted successfully',
                                      );

                                      // Get.snackbar(
                                      //   'Success',
                                      //   'Order accepted successfully',
                                      //   icon: const Icon(
                                      //     Icons.check_circle,
                                      //     color: Colors.white,
                                      //   ),
                                      //   backgroundColor: Colors.green,
                                      //   colorText: Colors.white,
                                      //   duration: const Duration(seconds: 2),
                                      // );
                                    } else {
                                      Get.snackbar(
                                        'Error',
                                        controller.errorMessage.value,
                                        icon: const Icon(
                                          Icons.error,
                                          color: Colors.white,
                                        ),
                                        backgroundColor: Colors.red,
                                        colorText: Colors.white,
                                      );
                                    }
                                  });
                            },
                    // isLoading: isProcessing,
                  );
                }),
              ),
              SizedBox(width: 20.h),
              Obx(() {
                final isProcessing = controller.isOrderProcessing(
                  order.id ?? '',
                );
                return GestureDetector(
                  onTap:
                      isProcessing
                          ? null
                          : () async {
                            final success = await controller.rejectOrder(
                              order.id ?? '',
                              order.vehicleTypeId ?? 0,
                            );
                            if (success) {
                              showSuccess('Order rejected successfully');
                              // Get.snackbar(
                              //   'Success',
                              //   'Order rejected',
                              //   backgroundColor: Colors.orange,
                              //   colorText: Colors.white,
                              //   duration: const Duration(seconds: 2),
                              // );
                            }
                          },
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                      color:
                          isProcessing
                              ? Colors.grey[300]
                              : ColorConstant.clrF7FCFF,
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child:
                        isProcessing
                            ? SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  ColorConstant.clrSecondary,
                                ),
                              ),
                            )
                            : Text(
                              LocalizationKeys.reject.tr,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                  ),
                );
              }),
            ],
          ),
        ],
      ),
    );
  }

  void showSuccess(String message) {
    // You can use your preferred way to show success messages
    Get.snackbar(
      'Success',
      message,
      backgroundColor: ColorConstant.clr242424,
      colorText: Colors.white,
    );
  }
}
