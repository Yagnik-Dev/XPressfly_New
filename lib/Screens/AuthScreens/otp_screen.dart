import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/image_constant.dart';
import 'package:xpressfly_git/Constants/text_style_constant.dart';
import 'package:xpressfly_git/Controller/login_controller.dart';
import 'package:xpressfly_git/Controller/otp_controller.dart';
import 'package:xpressfly_git/Localization/localization_keys.dart';
import 'package:xpressfly_git/Models/login_model.dart';
import '../../Common Components/common_button.dart';
import '../../Common Components/common_textfield.dart';

class OtpScreen extends StatelessWidget {
  final String? mobileNo;
  final int? loginType;
  final String? otp;
  OtpScreen({super.key, this.mobileNo, this.loginType, this.otp});

  final OtpController otpController = Get.put(OtpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.clrF7FCFF,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned(
            top: 38.h,
            left: 15.w,
            child: Align(
              alignment: Alignment.topLeft,
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Container(
                  padding: EdgeInsets.all(12.sp),
                  decoration: BoxDecoration(
                    color: ColorConstant.clrWhite,
                    // border: Border.all(
                    //   color: ColorConstant.clrFFE2DF,
                    //   width: 1.w,
                    // ),
                    // borderRadius: BorderRadius.circular(12.r),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_back,
                    color: ColorConstant.clrPrimary,
                    size: 24.sp,
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Image.asset(
              ImageConstant.imgLoginTop,
              height: 170.h,
              // width: 290.w,
            ),
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.sp),
              child: Form(
                key: otpController.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Text(
                        LocalizationKeys.verifyYourNumberWithOtp.tr,
                        textAlign: TextAlign.center,
                        style:
                            TextStyleConstant().titleTextStyle34w600Clr242424,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      LocalizationKeys.enterOtp.tr,
                      style: TextStyleConstant().subTitleTextStyle16w500,
                    ),
                    SizedBox(height: 8.h),
                    CommonTextFormField(
                      controller:
                          otpController.otpTextEditingController =
                              TextEditingController(text: otp ?? ""),
                      keyboardType: TextInputType.number,
                      maxLength: 6,
                      letterSpacing: 30,
                      textAlign: TextAlign.center,
                      hintText: LocalizationKeys.enterOtp.tr,
                      validator:
                          (p0) =>
                              (p0 == null || p0.isEmpty)
                                  ? LocalizationKeys.pleaseEnterOtp.tr
                                  : (p0.length < 6)
                                  ? LocalizationKeys.pleaseEnterValidOtp.tr
                                  : null,
                    ),
                    SizedBox(height: 18.h),
                    CommonButton(
                      btnText: LocalizationKeys.confirm.tr,
                      onPressed: () {
                        final LoginController loginController;
                        if (Get.isRegistered<LoginController>()) {
                          loginController = Get.find<LoginController>();
                        } else {
                          loginController = Get.put(LoginController());
                        }
                        if (otpController.formKey.currentState!.validate()) {
                          if (loginType == 1) {
                            loginController.verifyOtpApiCall(
                              (p0) {},
                              details: LoginRequestModel(
                                phone: mobileNo.toString(),
                                otp:
                                    otpController.otpTextEditingController.text
                                        .toString(),
                                type: "signin",
                              ),
                            );
                          } else {
                            loginController.verifyOtpApiCall(
                              (p0) {},
                              details: LoginRequestModel(
                                phone: mobileNo.toString(),
                                otp:
                                    otpController.otpTextEditingController.text
                                        .toString(),
                                type: "signup",
                              ),
                            );
                            // Get.to(
                            //   () => JoinAsScreen(
                            //     mobileNo: mobileNo,
                            //     otp:
                            //         otpController.otpTextEditingController.text,
                            //   ),
                            // );
                          }
                        }
                      },
                      color: ColorConstant.clrSecondary,
                    ),
                    SizedBox(height: 18.h),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: LocalizationKeys.didntReceiveOtp.tr,
                              style:
                                  TextStyleConstant().subTitleTextStyle16w500,
                            ),
                            TextSpan(
                              text: LocalizationKeys.resend.tr,
                              style:
                                  TextStyleConstant()
                                      .subTitleTextStyle16w500Clr242424,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Image.asset(
              ImageConstant.imgLoginBottom,
              height: 135.h,
              // width: 180.w,
            ),
          ),
        ],
      ),
    );
  }
}
