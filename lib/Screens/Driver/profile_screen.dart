import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xpressfly_git/Common%20Components/common_textfield.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/text_style_constant.dart';
import 'package:xpressfly_git/Controller/profilel_controller.dart';
import '../../Routes/app_routes.dart';

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.clrF7FCFF,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          "Your Profile",
          style: TextStyleConstant().titleTextStyle26w600Clr242424,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(28),
            bottomRight: Radius.circular(28),
          ),
        ),
      ),
      body: Obx(
        () => Column(
          children: [
            SizedBox(height: 20.h),
            Column(
              children: [
                CircleAvatar(
                  radius: 50.r,
                  backgroundImage: NetworkImage(
                    "https://cdn-icons-png.flaticon.com/512/149/149071.png",
                  ),
                  // replace with NetworkImage if dynamic
                ),
                SizedBox(height: 10.h),
                Text(
                  // GetStorage().read(userName) ?? "Jagdish Sain",
                  profileController.userDetails.value.data?.name ??
                      "Jagdish Sain",
                  style: TextStyleConstant().subTitleTextStyle22w600Clr242424,
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
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Your Details",
                            style:
                                TextStyleConstant()
                                    .subTitleTextStyle20w500Clr242424,
                          ),
                          InkWell(
                            onTap: () {
                              Get.toNamed(AppRoutes.editProfileScreen);
                            },
                            child: Text(
                              "Edit Profile",
                              style:
                                  TextStyleConstant()
                                      .subTitleTextStyle14w500ClrSubText,
                            ),
                          ),
                        ],
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
                        maxLength: 10,
                        readOnly: true,
                        controller: TextEditingController(
                          text:
                              profileController
                                  .userDetails
                                  .value
                                  .data
                                  ?.mobileNumber,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your number';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),
                      // Email Field + Verify
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Email",
                            style:
                                TextStyleConstant()
                                    .subTitleTextStyle16w500Clr242424,
                          ),
                          // Text(
                          //   "Verify",
                          //   style: TextStyle(
                          //     color: ColorConstant.clrPrimary,
                          //     fontWeight: FontWeight.w500,
                          //   ),
                          // ),
                        ],
                      ),
                      SizedBox(height: 6.h),
                      CommonTextFormFieldWithoutBorder(
                        controller: TextEditingController(
                          text:
                              profileController
                                  .userDetails
                                  .value
                                  .data
                                  ?.mobileNumber,
                        ),
                        hintText: "jagdishsain25@gmail.com",
                        keyboardType: TextInputType.emailAddress,
                        readOnly: true,
                        suffixIcon: Padding(
                          padding: EdgeInsets.fromLTRB(0, 12.sp, 20.sp, 12.sp),
                          child: Text(
                            "Verify",
                            style: TextStyle(
                              color: ColorConstant.clrPrimary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
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
                        readOnly: true,
                        controller: TextEditingController(
                          text: profileController.userDetails.value.data?.city,
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
