import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/image_constant.dart';
import 'package:xpressfly_git/Constants/text_style_constant.dart';
import 'package:xpressfly_git/Controller/driver_home_controller.dart';

class VehicleTypeScreen extends StatelessWidget {
  final Function(String title, String icon, int color)? onSelected;
  VehicleTypeScreen({super.key, this.onSelected});

  final driverHomeController = Get.find<DriverHomeController>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      child: Container(
        // padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                width: 0.9.sw,
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Your Vehicle Type",
                      style:
                          TextStyleConstant().subTitleTextStyle18w600Clr242424,
                    ),
                    SizedBox(height: 6.h),
                    Divider(color: ColorConstant.clrEEEEEE),
                    SizedBox(height: 14.h),
                    GridView.builder(
                      shrinkWrap: true,
                      itemCount:
                          driverHomeController
                              .vehicleTypeList
                              .value
                              .data
                              ?.length ??
                          0,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.4,
                        crossAxisSpacing: 12.w,
                        mainAxisSpacing: 10.h,
                      ),
                      itemBuilder: (context, index) {
                        // final item = vehicleTypes[index];
                        return GestureDetector(
                          onTap: () {
                            if (onSelected != null) {
                              onSelected!(
                                driverHomeController
                                    .vehicleTypeList
                                    .value
                                    .data![index]
                                    .name!,
                                driverHomeController
                                    .vehicleTypeList
                                    .value
                                    .data![index]
                                    .logo!,
                                int.parse(
                                  driverHomeController
                                      .vehicleTypeList
                                      .value
                                      .data![index]
                                      .colorCode!
                                      .replaceFirst('#', '0xff'),
                                ),
                              );
                            }
                          },
                          child: Image.network(
                            driverHomeController
                                .vehicleTypeList
                                .value
                                .data![index]
                                .image!,
                            fit: BoxFit.contain,
                            height:
                                80.h, // <-- give fixed size instead of Expanded
                            width: 80.w,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

final List<Map<String, dynamic>> vehicleTypes = [
  {
    "title": "Mini Truck",
    "icon": ImageConstant.imgSmallTruck,
    "color": Color(0xfffee2ba),
    "description": "TV, Table, Sofa,\nBad, Bicycle...",
  },
  {
    "title": "Car/Taxi",
    "icon": ImageConstant.imgMotorCar,
    "color": Color(0xffc1eafe),
    "description": "Files, Small Electronics\nSmall Boxes...",
  },
  {
    "title": "Big Truck",
    "icon": ImageConstant.imgBigTruck,
    "color": Color(0xffe1fffd),
    "description": "Whole apartments\nfurniture",
  },
  {
    "title": "Van",
    "icon": ImageConstant.imgVan,
    "color": Color(0xfff5ffc8),
    "description": "Small Furniture, Large\nbox, Groceries...",
  },
  {
    "title": "Auto",
    "icon": ImageConstant.imgAuto,
    "color": Color(0xffffe3e5),
    "description": "Shop Stock, Event\nMaterials...",
  },
  {
    "title": "Bike",
    "icon": ImageConstant.imgMotorbike,
    "color": Color(0xffcffdd6),
    "description": "Documents, Health\nSupplies...",
  },
  {
    "title": "Scooter",
    "icon": ImageConstant.imgScooter,
    "color": Color(0xfff6e8ff),
    "description": "Shop Stock, Event\nMaterials...",
  },
];
