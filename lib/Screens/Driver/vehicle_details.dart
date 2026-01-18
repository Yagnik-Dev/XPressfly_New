import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xpressfly_git/Common%20Components/delete_dialog.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/image_constant.dart';
import 'package:xpressfly_git/Constants/text_style_constant.dart';
import 'package:xpressfly_git/Controller/driver_home_controller.dart';
import 'package:xpressfly_git/Controller/vehicle_details_controller.dart';
import 'package:xpressfly_git/Models/get_vehicle_Details_model.dart';
import 'package:xpressfly_git/Routes/app_routes.dart';
import 'package:xpressfly_git/Localization/localization_keys.dart';

class VehicleDetailsScreen extends StatelessWidget {
  VehicleDetailsScreen({super.key});

  final VehicleDetailsController vehicleDetailsController = Get.put(
    VehicleDetailsController(),
  );
  final DriverHomeController driverHomeController =
      Get.find<DriverHomeController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.clrF2FAFF,
      appBar: AppBar(
        leadingWidth: 70.w,
        centerTitle: true,
        backgroundColor: ColorConstant.clrF2FAFF,
        leading: InkWell(
          onTap: () => Get.back(),
          child: Padding(
            padding: EdgeInsets.only(left: 16.w),
            child: Container(
              height: 50.w,
              width: 50.w,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.arrow_back,
                color: ColorConstant.clrPrimary,
                size: 30.sp,
              ),
            ),
          ),
        ),
        title: Text(
          LocalizationKeys.vehicleDetails.tr,
          style: TextStyleConstant().titleTextStyle26w600Clr242424,
        ),
      ),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              height: 455.h,
              padding: EdgeInsets.symmetric(horizontal: 18.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.only(top: 40.h),
                child: Obx(
                  () => Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            vehicleDetailsController
                                    .vehicleDetails
                                    .value
                                    .data
                                    ?.vehicleModel ??
                                "Tata Ace",
                            style:
                                TextStyleConstant()
                                    .subTitleTextStyle22w600Clr242424,
                          ),
                          Text(
                            vehicleDetailsController
                                    .vehicleDetails
                                    .value
                                    .data
                                    ?.vehicleNumber ??
                                "GJ01AB1234",
                            style:
                                TextStyleConstant()
                                    .subTitleTextStyle16w500Clr242424,
                          ),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      Text(
                        // vehicleDetailsController.vehicleDetails.value.data.
                        "The perfect mini truck with ample space to carry TVs, tables, chairs and all your household essentials with ease.",
                        style:
                            TextStyleConstant()
                                .subTitleTextStyle14w400ClrSubText,
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          LocalizationKeys.pinCode.tr,
                          style:
                              TextStyleConstant().titleTextStyle20w600Clr242424,
                        ),
                      ),
                      Text(
                        LocalizationKeys
                            .serviceablePinCodesAsSelectedByDriver
                            .tr,
                        style:
                            TextStyleConstant()
                                .subTitleTextStyle14w400ClrSubText,
                      ),
                      const SizedBox(height: 12),
                      Expanded(
                        child: GridView.builder(
                          shrinkWrap: true,
                          itemCount:
                              vehicleDetailsController
                                  .vehicleDetails
                                  .value
                                  .data
                                  ?.zipCode
                                  ?.length ??
                              0,
                          // physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 3,
                                childAspectRatio: 1.7,
                              ),
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.all(6.sp),
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  color: ColorConstant.clrF2FAFF,
                                  borderRadius: BorderRadius.circular(9.r),
                                ),
                                child: Text(
                                  vehicleDetailsController
                                          .vehicleDetails
                                          .value
                                          .data
                                          ?.zipCode?[index] ??
                                      "",
                                  style:
                                      TextStyleConstant()
                                          .subTitleTextStyle16w500Clr242424,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => DeleteVehicleDialog(),
                                ).then((confirmed) {
                                  if (confirmed == true) {
                                    // Perform delete action
                                    driverHomeController.refreshVehicleList();
                                  }
                                });
                              },
                              style: OutlinedButton.styleFrom(
                                backgroundColor: ColorConstant.clrF2FAFF,
                                side: const BorderSide(
                                  color: Colors.transparent,
                                ),
                                padding: EdgeInsets.symmetric(vertical: 12.h),
                              ),
                              icon: Image.asset(
                                ImageConstant.imgDeleteBtn,
                                color: ColorConstant.clrSecondary,
                                width: 24.w,
                                height: 24.h,
                              ),
                              label: Text(
                                LocalizationKeys.delete.tr,
                                style:
                                    TextStyleConstant()
                                        .subTitleTextStyle18w600Clr242424,
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: OutlinedButton.icon(
                              onPressed: () {
                                // Pass vehicle data to edit screen
                                Get.toNamed(
                                  AppRoutes.addVehicleMainScreen,
                                  arguments: {
                                    'isUpdate': true,
                                    'vehicleId':
                                        vehicleDetailsController.vehicleId,
                                    'vehicleData':
                                        vehicleDetailsController
                                            .vehicleDetails
                                            .value
                                            .data ??
                                        VehicleDetailsData(),
                                  },
                                )?.then((_) {
                                  vehicleDetailsController.getData();
                                });
                              },
                              style: OutlinedButton.styleFrom(
                                backgroundColor: ColorConstant.clrSecondary,
                                side: const BorderSide(
                                  color: Colors.transparent,
                                ),
                                padding: EdgeInsets.symmetric(vertical: 12.h),
                              ),
                              icon: Image.asset(
                                ImageConstant.imgEditBtn,
                                color: ColorConstant.clrFFFAFA,
                                width: 24.w,
                                height: 24.h,
                              ),
                              label: Text(
                                LocalizationKeys.edit.tr,
                                style:
                                    TextStyleConstant()
                                        .subTitleTextStyle18w500clrFFFAFA,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ),

          /// Truck image (floating above the container)
          Positioned(
            top: 50.h,
            left: 0,
            right: 0,
            child: Obx(
              () => Center(
                child:
                    vehicleDetailsController
                                .vehicleDetails
                                .value
                                .data
                                ?.vehicleType
                                ?.logo ==
                            null
                        ? CircularProgressIndicator()
                        : Image.network(
                          vehicleDetailsController
                                  .vehicleDetails
                                  .value
                                  .data
                                  ?.vehicleType
                                  ?.logo ??
                              '',
                          height: 180,
                        ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
