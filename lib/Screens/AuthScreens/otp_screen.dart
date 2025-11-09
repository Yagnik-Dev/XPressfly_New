import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/image_constant.dart';
import 'package:xpressfly_git/Constants/text_style_constant.dart';
import 'package:xpressfly_git/Controller/login_controller.dart';
import 'package:xpressfly_git/Controller/otp_controller.dart';
import 'package:xpressfly_git/Screens/AuthScreens/join_as_screen.dart';
import '../../Common Components/common_button.dart';
import '../../Common Components/common_textfield.dart';

class OtpScreen extends StatelessWidget {
  String? mobileNo;
  int? loginType;
  OtpScreen({super.key, this.mobileNo, this.loginType});

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
                        "Verify your\nNumber with OTP",
                        textAlign: TextAlign.center,
                        style:
                            TextStyleConstant().titleTextStyle34w600Clr242424,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      "Enter OTP",
                      style: TextStyleConstant().subTitleTextStyle16w500,
                    ),
                    SizedBox(height: 8.h),
                    CommonTextFormField(
                      controller:
                          otpController.otpTextEditingController =
                              TextEditingController(text: '1234'),
                      keyboardType: TextInputType.number,
                      maxLength: 4,
                      letterSpacing: 30,
                      textAlign: TextAlign.center,
                      hintText: "Enter OTP",
                      validator:
                          (p0) =>
                              (p0 == null || p0.isEmpty)
                                  ? 'Please enter OTP'
                                  : (p0.length < 4)
                                  ? 'Please enter valid OTP'
                                  : null,
                    ),
                    SizedBox(height: 18.h),
                    CommonButton(
                      btnText: "CONFIRM",
                      onPressed: () {
                        if (otpController.formKey.currentState!.validate()) {
                          if (loginType == 1) {
                            Get.find<LoginController>().loginApiCall(
                              (p0) {},
                              details: {"mobile_number": mobileNo},
                            );
                          } else {
                            Get.to(
                              () => JoinAsScreen(
                                mobileNo: mobileNo,
                                otp:
                                    otpController.otpTextEditingController.text,
                              ),
                            );
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
                              text: "Didn’t receive OTP? ",
                              style:
                                  TextStyleConstant().subTitleTextStyle16w500,
                            ),
                            TextSpan(
                              text: "Resend",
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
