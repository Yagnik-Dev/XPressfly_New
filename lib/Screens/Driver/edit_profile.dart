import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xpressfly_git/Common%20Components/common_textfield.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/text_style_constant.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        dividerTheme: DividerThemeData(color: Colors.transparent),
      ),
      child: Scaffold(
        backgroundColor: ColorConstant.clrF7FCFF,
        // backgroundColor: Colors.red,
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          automaticallyImplyLeading: false,
          title: Text(
            "Edit Profile",
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
          Container(
            color: ColorConstant.clrWhite,
            child: Padding(
              padding: const EdgeInsets.only(
                bottom: 10.0,
                top: 0,
                left: 22,
                right: 22,
              ),
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
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        backgroundColor: ColorConstant.clrSecondary,
                        side: const BorderSide(color: Colors.transparent),
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                      ),
                      child: Text(
                        "Save",
                        style:
                            TextStyleConstant()
                                .subTitleTextStyle18w500clrFFFAFA,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        body: Column(
          children: [
            SizedBox(height: 20.h),
            Column(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 50.r,
                      backgroundImage: NetworkImage(
                        "https://cdn-icons-png.flaticon.com/512/149/149071.png",
                      ),
                      // replace with NetworkImage if dynamic
                    ),
                    Container(
                      // width: 30.w,
                      // height: 30.h,
                      margin: EdgeInsets.only(left: 6.w, top: 4.h),
                      padding: EdgeInsets.all(8.sp),
                      decoration: BoxDecoration(
                        color: ColorConstant.clrWhite,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: ColorConstant.clrEEEEEE,
                          width: 2.w,
                        ),
                      ),
                      child: Icon(
                        Icons.camera_alt,
                        size: 14.h,
                        color: ColorConstant.clrPrimary,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10.h),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Jagdish Sain",
                      style:
                          TextStyleConstant().subTitleTextStyle22w600Clr242424,
                    ),
                    SizedBox(width: 10.w),
                    Icon(
                      Icons.edit,
                      size: 18.h,
                      color: ColorConstant.clrSubText,
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 18.h),
            // Details Card
            Expanded(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 20.h),
                decoration: BoxDecoration(
                  color: ColorConstant.clrWhite,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r),
                  ),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Your Details",
                        style:
                            TextStyleConstant()
                                .subTitleTextStyle20w500Clr242424,
                      ),
                      SizedBox(height: 20.h),
                      // Phone Field
                      Text(
                        "Number",
                        style:
                            TextStyleConstant()
                                .subTitleTextStyle16w500ClrSubText,
                      ),
                      SizedBox(height: 6.h),
                      CommonTextFormFieldWithoutBorder(
                        hintText: "+91 98765 43210",
                        keyboardType: TextInputType.phone,
                        suffixIcon: Icon(
                          Icons.edit,
                          color: ColorConstant.clrPrimary,
                          size: 18.h,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      // Email Field + Verify
                      Text(
                        "Email",
                        style:
                            TextStyleConstant()
                                .subTitleTextStyle16w500Clr242424,
                      ),
                      SizedBox(height: 6.h),
                      CommonTextFormFieldWithoutBorder(
                        hintText: "jagdishsain25@gmail.com",
                        keyboardType: TextInputType.emailAddress,
                        suffixIcon: Icon(
                          Icons.edit,
                          color: ColorConstant.clrPrimary,
                          size: 18.h,
                        ),
                      ),
                      SizedBox(height: 16.h),
                      // Address Field
                      Text(
                        "Address",
                        style:
                            TextStyleConstant()
                                .subTitleTextStyle16w500ClrSubText,
                      ),
                      SizedBox(height: 6.h),
                      CommonTextFormFieldWithoutBorder(
                        hintText: "90, Houses, Surat, Gujarat - 395010",
                        maxLines: 2,
                        suffixIcon: Icon(
                          Icons.edit,
                          color: ColorConstant.clrPrimary,
                          size: 18.h,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
