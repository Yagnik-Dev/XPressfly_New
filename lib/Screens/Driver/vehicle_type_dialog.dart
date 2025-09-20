import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/text_style_constant.dart';

class VehicleTypeScreen extends StatelessWidget {
  final List<Map<String, dynamic>> vehicleTypes = [
    {
      "title": "Mini Truck",
      "icon": "assets/mini_truck.png",
      "color": Colors.orange.shade100,
    },
    {
      "title": "Car/Taxi",
      "icon": "assets/car.png",
      "color": Colors.blue.shade100,
    },
    {
      "title": "Big Truck",
      "icon": "assets/big_truck.png",
      "color": Colors.cyan.shade100,
    },
    {"title": "Van", "icon": "assets/van.png", "color": Colors.yellow.shade100},
    {"title": "Auto", "icon": "assets/auto.png", "color": Colors.red.shade100},
    {
      "title": "Bike",
      "icon": "assets/bike.png",
      "color": Colors.green.shade100,
    },
    {
      "title": "Scooter",
      "icon": "assets/scooter.png",
      "color": Colors.purple.shade100,
    },
  ];

  VehicleTypeScreen({super.key});

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
                            // Handle selection
                            print("Selected: ${item['title']}");
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: item["color"],
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            padding: EdgeInsets.all(12.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Image.asset(
                                    item["icon"],
                                    fit: BoxFit.contain,
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                Text(
                                  item["title"],
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.center,
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
