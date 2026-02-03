import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xpressfly_git/Common%20Components/common_button.dart';
import 'package:xpressfly_git/Common%20Components/common_textfield.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/image_constant.dart';
import 'package:xpressfly_git/Constants/text_style_constant.dart';
import 'package:xpressfly_git/Controller/help_and_support_controller.dart';
import 'package:xpressfly_git/Localization/localization_keys.dart';

class HelpSupportScreen extends StatelessWidget {
  HelpSupportScreen({super.key});

  final HelpSupportController controller = Get.put(HelpSupportController());

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        dividerTheme: DividerThemeData(color: Colors.transparent),
      ),
      child: Scaffold(
        backgroundColor: ColorConstant.clrF7FCFF,
        appBar: AppBar(
          backgroundColor: ColorConstant.clrF7FCFF,
          centerTitle: true,
          elevation: 0,
          leadingWidth: 70.w,
          leading: InkWell(
            onTap: () => Get.back(),
            child: Padding(
              padding: EdgeInsets.only(left: 16.w),
              child: Container(
                height: 50.w,
                width: 50.w,
                decoration: BoxDecoration(
                  color: ColorConstant.clrWhite,
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
          automaticallyImplyLeading: false,
          title: Text(
            LocalizationKeys.helpSupport.tr, // Add to LocalizationKeys
            style: TextStyleConstant().titleTextStyle26w600Clr242424,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(28),
              bottomRight: Radius.circular(28),
            ),
          ),
        ),
        persistentFooterButtons: [
          Padding(
            padding: EdgeInsets.fromLTRB(11.w, 4.h, 11.w, 13.h),
            child: Obx(
              () => CommonButton(
                radius: 50.r,
                color: ColorConstant.clrSecondary,
                btnText: LocalizationKeys.submit.tr, // Add to LocalizationKeys
                onPressed:
                    controller.isLoading.value
                        ? null
                        : () => controller.submitHelpSupport(),
              ),
            ),
          ),
        ],
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(
                margin: EdgeInsets.only(top: 150.h),
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                decoration: BoxDecoration(
                  color: ColorConstant.clrWhite,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r),
                  ),
                ),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 70.h),

                      /// Subject
                      Text(
                        LocalizationKeys.subject.tr, // Add to LocalizationKeys
                        style:
                            TextStyleConstant()
                                .subTitleTextStyle16w500ClrSubText,
                      ),
                      SizedBox(height: 6.h),
                      CommonTextFormFieldWithoutBorder(
                        controller: controller.subjectController,
                        hintText: LocalizationKeys.enterSubject.tr,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return LocalizationKeys.pleaseEnterSubject.tr;
                          }
                          return null;
                        },
                      ),

                      SizedBox(height: 16.h),

                      /// Message
                      Text(
                        LocalizationKeys.message.tr, // Add to LocalizationKeys
                        style:
                            TextStyleConstant()
                                .subTitleTextStyle16w500ClrSubText,
                      ),
                      SizedBox(height: 6.h),
                      CommonTextFormFieldWithoutBorder(
                        controller: controller.messageController,
                        hintText: LocalizationKeys.enterYourMessageHere.tr,
                        maxLines: 6,
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return LocalizationKeys.pleaseEnterYourMessage.tr;
                          }
                          return null;
                        },
                      ),

                      // TextFormField(
                      //   controller: controller.messageController,
                      //   maxLines: 6,
                      //   minLines: 6,
                      //   validator: (value) {
                      //     if (value == null || value.trim().isEmpty) {
                      //       return "Please enter your message";
                      //     }
                      //     return null;
                      //   },
                      //   decoration: InputDecoration(
                      //     hintText: "Enter your message here...",
                      //     hintStyle:
                      //         TextStyleConstant()
                      //             .subTitleTextStyle14w500ClrCCCCCC,
                      //     filled: true,
                      //     fillColor: ColorConstant.clrF2FAFF,
                      //     contentPadding: EdgeInsets.symmetric(
                      //       horizontal: 16.w,
                      //       vertical: 14.h,
                      //     ),
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(16.r),
                      //       borderSide: BorderSide.none,
                      //     ),
                      //     enabledBorder: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(16.r),
                      //       borderSide: BorderSide.none,
                      //     ),
                      //     focusedBorder: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(16.r),
                      //       borderSide: BorderSide(
                      //         color: ColorConstant.clrSecondary,
                      //         width: 1.5,
                      //       ),
                      //     ),
                      //     errorBorder: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(16.r),
                      //       borderSide: BorderSide(
                      //         color: ColorConstant.clrError,
                      //         width: 1.5,
                      //       ),
                      //     ),
                      //     focusedErrorBorder: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(16.r),
                      //       borderSide: BorderSide(
                      //         color: ColorConstant.clrError,
                      //         width: 1.5,
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),

              /// Top Image (Use help/support related image)
              Positioned(
                top: 20.h,
                left: 0,
                right: 0,
                child: Center(
                  child: Image.asset(
                    ImageConstant
                        .imgYourDetails, // Replace with help support image
                    height: 180.h,
                    width: 160.w,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
