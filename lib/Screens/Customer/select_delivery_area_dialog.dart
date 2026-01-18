import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xpressfly_git/Constants/image_constant.dart';
import 'package:xpressfly_git/Constants/text_style_constant.dart';
import 'package:xpressfly_git/Localization/localization_keys.dart';

class SelectDeliveryAreaDialog extends StatelessWidget {
  const SelectDeliveryAreaDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.symmetric(horizontal: 12.w),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.r)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              LocalizationKeys.selectDeliveryArea.tr,
              style: TextStyleConstant().subTitleTextStyle20w600Clr242424,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    height: 120.h,
                    padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 10.h),
                    alignment: AlignmentDirectional.bottomCenter,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage(ImageConstant.imgSameCity),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Text(
                      LocalizationKeys.sameCity.tr,
                      style:
                          TextStyleConstant().subTitleTextStyle16w500Clr242424,
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Expanded(
                  child: Container(
                    height: 120.h,
                    padding: EdgeInsets.fromLTRB(8.w, 8.h, 8.w, 10.h),
                    alignment: AlignmentDirectional.bottomCenter,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage(ImageConstant.imgOtherCity),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Text(
                      LocalizationKeys.otherCity.tr,
                      style:
                          TextStyleConstant().subTitleTextStyle16w500Clr242424,
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
