import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xpressfly_git/Common%20Components/common_button.dart';
import 'package:xpressfly_git/Common%20Components/common_textfield.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/image_constant.dart';
import 'package:xpressfly_git/Constants/text_style_constant.dart';
import 'package:xpressfly_git/Controller/login_controller.dart';
import 'package:xpressfly_git/Localization/localization_keys.dart';
import 'package:xpressfly_git/Models/login_model.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final LoginController loginController = Get.put(LoginController());

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
                key: loginController.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Center(
                      child: Text(
                        LocalizationKeys.welcomeTo.tr,
                        textAlign: TextAlign.center,
                        style:
                            TextStyleConstant().titleTextStyle34w600Clr242424,
                      ),
                    ),
                    SizedBox(height: 20.h),
                    Text(
                      LocalizationKeys.number.tr,
                      style: TextStyleConstant().subTitleTextStyle16w500,
                    ),
                    SizedBox(height: 8.h),
                    CommonTextFormField(
                      controller: loginController.phoneTextEditingController,
                      hintText: LocalizationKeys.enterYourNumber.tr,
                      keyboardType: TextInputType.phone,
                      maxLength: 10,
                      validator: (p0) {
                        if (p0 == null || p0.isEmpty) {
                          return LocalizationKeys.pleaseEnterPhoneNumber.tr;
                        } else if (p0.length != 10) {
                          return LocalizationKeys.phoneNumberMustBe10Digits.tr;
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 18.h),
                    CommonButton(
                      btnText: LocalizationKeys.getOtp.tr,
                      onPressed: () {
                        if (loginController.formKey.currentState!.validate()) {
                          if (loginController.loginType == 1) {
                            loginController.loginApiCall(
                              (p0) {},
                              details: LoginRequestModel(
                                phone:
                                    loginController
                                        .phoneTextEditingController
                                        .text,
                                type: "signin",
                              ),
                            );
                          } else {
                            loginController.registerApiCall(
                              (p0) {},
                              details: LoginRequestModel(
                                phone:
                                    loginController
                                        .phoneTextEditingController
                                        .text,
                                type: "signup",
                              ),
                            );
                          }
                          // Get.to(
                          //   () => OtpScreen(
                          //     mobileNo:
                          //         loginController
                          //             .phoneTextEditingController
                          //             .text,
                          //     loginType: loginController.loginType,
                          //   ),
                          // );
                        }
                      },
                      color: ColorConstant.clrSecondary,
                    ),
                    SizedBox(height: 18.h),
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          log('Terms & Conditions tapped');
                          // Add navigation logic here
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => TermsScreen()));
                        },
                        child: Text(
                          LocalizationKeys.termsConditions.tr,
                          style:
                              TextStyleConstant()
                                  .subTitleTextStyle16w500clrSecondary,
                        ),
                      ),
                    ),
                    // Center(
                    //   child: RichText(
                    //     text: TextSpan(
                    //       children: [
                    //         TextSpan(
                    //           text: "New to Xpressfly? ",
                    //           style:
                    //               TextStyleConstant().subTitleTextStyle16w500,
                    //         ),
                    //         TextSpan(
                    //           text: "Signup",
                    //           style:
                    //               TextStyleConstant()
                    //                   .subTitleTextStyle16w500Clr242424,
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),
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
