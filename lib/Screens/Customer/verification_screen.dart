import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xpressfly_git/Common%20Components/common_button.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/image_constant.dart';
import 'package:xpressfly_git/Constants/text_style_constant.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        dividerTheme: DividerThemeData(color: Colors.transparent),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        persistentFooterButtons: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0, left: 22, right: 22),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30.r),
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      width: 100.w,
                      alignment: Alignment.center,
                      child: Text(
                        "Back",
                        style:
                            TextStyleConstant()
                                .subTitleTextStyle18w600Clr242424,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: CommonButtonRounded(
                    btnText: "Submit",
                    color: ColorConstant.clrSecondary,
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ],

        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.07),
              Text(
                "Verification",
                style: TextStyleConstant().subTitleTextStyle30w600Clr242424,
              ),
              Text(
                'Upload your Aadhar Card',
                style: TextStyleConstant().subTitleTextStyle14w500Clr9D9D9D,
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.05),
              Text(
                'Upload front side of your Aadhaar',
                style: TextStyleConstant().subTitleTextStyle16w500Clr242424,
              ),
              Container(
                height: 160.h,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  color: ColorConstant.clrFAFBFF,
                  border: Border.all(color: ColorConstant.clrEEEEEE),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      ImageConstant.imgUploadAadhar,
                      height: 40.h,
                      width: 50.w,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Upload front',
                      style:
                          TextStyleConstant().subTitleTextStyle16w400clr666666,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 10.h),
                child: Text(
                  'Upload front side of your Aadhaar',
                  style: TextStyleConstant().subTitleTextStyle16w500Clr242424,
                ),
              ),
              Container(
                height: 160.h,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  color: ColorConstant.clrFAFBFF,
                  border: Border.all(color: ColorConstant.clrEEEEEE),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      ImageConstant.imgUploadAadhar,
                      height: 40.h,
                      width: 50.w,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      'Upload front',
                      style:
                          TextStyleConstant().subTitleTextStyle16w400clr666666,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
