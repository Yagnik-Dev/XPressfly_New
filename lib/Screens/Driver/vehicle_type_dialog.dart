import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/image_constant.dart';
import 'package:xpressfly_git/Constants/text_style_constant.dart';

class VehicleTypeScreen extends StatelessWidget {
  final Function(String title, String icon, Color color)? onSelected;
  const VehicleTypeScreen({super.key, this.onSelected});

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
                      itemCount: vehicleTypes.length,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.3,
                        crossAxisSpacing: 12.w,
                        mainAxisSpacing: 12.h,
                      ),
                      itemBuilder: (context, index) {
                        final item = vehicleTypes[index];
                        return GestureDetector(
                          onTap: () {
                            if (onSelected != null) {
                              onSelected!(
                                item['title'],
                                item['icon'],
                                item['color'],
                              );
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: item["color"],
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            padding: EdgeInsets.fromLTRB(11.w, 12.h, 0.w, 0.h),
                            child: Stack(
                              children: [
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Image.asset(
                                    item["icon"],
                                    fit: BoxFit.contain,
                                    height:
                                        80.h, // <-- give fixed size instead of Expanded
                                    width: 80.w,
                                  ),
                                ),

                                Text(
                                  item["title"],
                                  style:
                                      TextStyleConstant()
                                          .subTitleTextStyle16w500Clr242424,
                                  textAlign: TextAlign.center,
                                ),
                                SizedBox(height: 8.h),
                                InkWell(
                                  onTap: () {
                                    if (onSelected != null) {
                                      onSelected!(
                                        item['title'],
                                        item['icon'],
                                        item['color'],
                                      );
                                    }
                                    // Get.toNamed(AppRoutes.vehicleDetailsScreen);
                                  },
                                  child: Align(
                                    alignment: Alignment.bottomLeft,
                                    child: Container(
                                      padding: EdgeInsets.all(8.sp),
                                      margin: EdgeInsets.only(bottom: 8.h),
                                      decoration: BoxDecoration(
                                        color: ColorConstant.clrFFFAFA,
                                        shape: BoxShape.circle,
                                      ),
                                      child: Icon(
                                        Icons.arrow_outward_rounded,
                                        color: ColorConstant.clrSecondary,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
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
