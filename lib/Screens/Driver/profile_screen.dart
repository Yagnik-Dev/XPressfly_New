import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:xpressfly_git/Common%20Components/common_textfield.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/storage_constant.dart';
import 'package:xpressfly_git/Constants/text_style_constant.dart';
import 'package:xpressfly_git/Controller/profile_controller.dart';
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
                    profileController.userDetails.value.user?.profileImage ??
                        "https://cdn-icons-png.flaticon.com/512/149/149071.png",
                  ),
                ),
                SizedBox(height: 10.h),
                Text(
                  profileController.userDetails.value.user?.name ??
                      GetStorage().read(userName) ??
                      "User",
                  style: TextStyleConstant().subTitleTextStyle22w600Clr242424,
                ),
              ],
            ),
            SizedBox(height: 18.h),
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
                              Get.toNamed(AppRoutes.editProfileScreen)?.then((
                                value,
                              ) async {
                                if (value == true) {
                                  await profileController.getUserDetails(
                                    (isSuccess) {},
                                  );
                                }
                              });
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
                        "Phone Number",
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
                              profileController.userDetails.value.user?.phone ??
                              GetStorage().read(userPhone) ??
                              '',
                        ),
                      ),
                      SizedBox(height: 16.h),
                      // Email Field
                      Text(
                        "Email",
                        style:
                            TextStyleConstant()
                                .subTitleTextStyle16w500ClrSubText,
                      ),
                      SizedBox(height: 6.h),
                      CommonTextFormFieldWithoutBorder(
                        controller: TextEditingController(
                          text:
                              profileController.userDetails.value.user?.email ??
                              GetStorage().read(userEmail) ??
                              '',
                        ),
                        keyboardType: TextInputType.emailAddress,
                        readOnly: true,
                      ),
                      SizedBox(height: 16.h),
                      // Pincode Field
                      Text(
                        "Pincode",
                        style:
                            TextStyleConstant()
                                .subTitleTextStyle16w500ClrSubText,
                      ),
                      SizedBox(height: 6.h),
                      CommonTextFormFieldWithoutBorder(
                        controller: TextEditingController(
                          text:
                              profileController
                                  .userDetails
                                  .value
                                  .user
                                  ?.pincode ??
                              GetStorage().read(userPincode) ??
                              '',
                        ),
                        keyboardType: TextInputType.number,
                        readOnly: true,
                      ),
                      SizedBox(height: 16.h),
                      // City Field
                      Text(
                        "City",
                        style:
                            TextStyleConstant()
                                .subTitleTextStyle16w500ClrSubText,
                      ),
                      SizedBox(height: 6.h),
                      CommonTextFormFieldWithoutBorder(
                        controller: TextEditingController(
                          text:
                              profileController.userDetails.value.user?.city ??
                              GetStorage().read(userCity) ??
                              '',
                        ),
                        readOnly: true,
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
                        controller: TextEditingController(
                          text:
                              profileController
                                  .userDetails
                                  .value
                                  .user
                                  ?.address ??
                              GetStorage().read(userAddress) ??
                              '',
                        ),
                        maxLines: 2,
                        readOnly: true,
                      ),
                      SizedBox(height: 80.h),
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
