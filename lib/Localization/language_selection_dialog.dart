import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/text_style_constant.dart';
import 'package:xpressfly_git/Localization/localization.dart';
import 'package:xpressfly_git/Localization/localization_keys.dart';

void showLanguageSelectionDialog(BuildContext context) {
  final localizationService = LocalizationService();
  final currentLocale = Get.locale ?? LocalizationService.locale;

  // Determine current selected language
  String currentLanguage = 'English';
  if (currentLocale.languageCode == 'hi') {
    currentLanguage = 'Hindi';
  }

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        backgroundColor: Colors.white,
        insetPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 24.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(28.r),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                LocalizationKeys.language.tr, // Changed from 'language'.tr
                style: TextStyleConstant().subTitleTextStyle20w600Clr242424,
              ),
              SizedBox(height: 20.h),
              // Language options
              ...LocalizationService.language.map((language) {
                bool isSelected = language == currentLanguage;
                return InkWell(
                  onTap: () {
                    localizationService.changeLocale(language);
                    Navigator.pop(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(bottom: 12.h),
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 16.h,
                    ),
                    decoration: BoxDecoration(
                      color:
                          isSelected ? ColorConstant.clrF2FAFF : Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                      border: Border.all(
                        color:
                            isSelected
                                ? ColorConstant.clrSecondary
                                : ColorConstant.clrEEEEEE,
                        width: isSelected ? 2 : 1,
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            language,
                            style:
                                isSelected
                                    ? TextStyleConstant()
                                        .subTitleTextStyle16w600Clr242424
                                    : TextStyleConstant()
                                        .subTitleTextStyle16w500Clr242424,
                          ),
                        ),
                        if (isSelected)
                          Icon(
                            Icons.check_circle,
                            color: ColorConstant.clrSecondary,
                            size: 24.sp,
                          ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      );
    },
  );
}
