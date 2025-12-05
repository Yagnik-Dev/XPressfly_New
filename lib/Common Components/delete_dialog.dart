import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/image_constant.dart';
import 'package:xpressfly_git/Constants/text_style_constant.dart';
import 'package:xpressfly_git/Controller/driver_home_controller.dart';
import 'package:xpressfly_git/Controller/vehicle_details_controller.dart';

class DeleteVehicleDialog extends StatelessWidget {
  DeleteVehicleDialog({super.key});

  final VehicleDetailsController vehicleDetailsController =
      Get.find<VehicleDetailsController>();
  final DriverHomeController driverHomeController =
      Get.find<DriverHomeController>();

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 12.w),
      backgroundColor: ColorConstant.clrWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
      child: Padding(
        padding: EdgeInsets.all(20.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Circle with icon
            Image.asset(
              ImageConstant.imgDeleteVehicle,
              fit: BoxFit.contain,
              height: 64.w,
              width: 64.w,
            ),
            SizedBox(height: 8.h),

            // Title
            Text(
              "Are you sure?",
              style: TextStyleConstant().subTitleTextStyle22w600Clr242424,
            ),
            SizedBox(height: 8.h),

            // Subtitle
            Text(
              "Do you want to delete this vehicle?\nThis action cannot be undone.",
              textAlign: TextAlign.center,
              style: TextStyleConstant().subTitleTextStyle14w500ClrSubText,
            ),
            SizedBox(height: 20.h),

            // Buttons row
            Row(
              children: [
                // Cancel Button
                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: BorderSide.none,
                      backgroundColor: ColorConstant.clrF2FAFF,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                    ),
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: Text(
                      "Cancel",
                      style:
                          TextStyleConstant().subTitleTextStyle18w500Clr242424,
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                // Sure Button
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ColorConstant.clrSecondary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                    ),
                    // Update the DeleteVehicleDialog's Sure button:
                    onPressed: () async {
                      final success =
                          await vehicleDetailsController.deleteVehicleCall();
                      if (success) {
                        Navigator.pop(context, true);
                        if (context.mounted) {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder:
                                (context) => DeleteSuccess(
                                  onAnimationComplete: () {
                                    Future.delayed(
                                      const Duration(seconds: 2),
                                      () async {
                                        Get.back();
                                        await driverHomeController
                                            .refreshVehicleList();
                                      },
                                    );
                                  },
                                ),
                          );
                        }
                      } else {
                        Navigator.pop(context, false);
                        Get.snackbar(
                          'Error',
                          'Failed to delete vehicle. Please try again.',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      }
                    },
                    child: Text(
                      "Sure",
                      style:
                          TextStyleConstant().subTitleTextStyle18w500clrFFFAFA,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DeleteSuccess extends StatelessWidget {
  final VoidCallback? onAnimationComplete;
  const DeleteSuccess({super.key, this.onAnimationComplete});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      onAnimationComplete?.call();
    });
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 12.w),
      backgroundColor: ColorConstant.clrWhite,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.r)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 30.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Successfully Delete",
              style: TextStyleConstant().subTitleTextStyle18w600Clr242424,
            ),
            SizedBox(height: 20.h),
            // Circle with icon
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                border: Border.all(
                  color: ColorConstant.clrSecondary,
                  width: 4.w,
                ),
                // color: ColorConstant.clrSecondary,
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.done_rounded,
                color: ColorConstant.clrSecondary,
                size: 60.w,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
