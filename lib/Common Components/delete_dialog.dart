import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/image_constant.dart';
import 'package:xpressfly_git/Constants/text_style_constant.dart';

class DeleteVehicleDialog extends StatelessWidget {
  const DeleteVehicleDialog({super.key});

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
                      backgroundColor: Colors.redAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                    ),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => const DeleteSuccess(),
                      );
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
  const DeleteSuccess({super.key});

  @override
  Widget build(BuildContext context) {
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
