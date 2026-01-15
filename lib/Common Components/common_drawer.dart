import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:xpressfly_git/Common%20Components/common_button.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/image_constant.dart';
import 'package:xpressfly_git/Constants/storage_constant.dart';
import 'package:xpressfly_git/Constants/text_style_constant.dart';
import 'package:xpressfly_git/Controller/profile_controller.dart';
import 'package:xpressfly_git/Routes/app_routes.dart';
import 'package:xpressfly_git/Screens/Driver/order_history_screen.dart';

class CommonDrawer extends StatefulWidget {
  const CommonDrawer({super.key});

  @override
  State<CommonDrawer> createState() => _CommonDrawerState();
}

class _CommonDrawerState extends State<CommonDrawer> {
  int selectedIndex = 0;
  List<DrawerItem> get drawerItems => [
    DrawerItem(iconPath: ImageConstant.imgHomeBottom, title: "Home"),
    DrawerItem(iconPath: ImageConstant.imgParcelBottom, title: "Order Request"),
    DrawerItem(
      iconPath: ImageConstant.imgHistoryBottom,
      title: "Order History",
    ),
    DrawerItem(iconPath: ImageConstant.imgProfileBottom, title: "Profile"),
    DrawerItem(
      iconPath: ImageConstant.imgTermsAndCondition,
      title: "Terms & Condition",
    ),
    DrawerItem(
      iconPath: ImageConstant.imgPrivacyPolicy,
      title: "Privacy Policy",
    ),
    DrawerItem(
      iconPath: ImageConstant.imgHelpAndSupport,
      title: "Help & Support",
    ),
    DrawerItem(iconPath: ImageConstant.imgLogout, title: "Logout"),
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      width: MediaQuery.of(context).size.width * 0.82,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          bottomLeft: Radius.circular(30.r),
        ),
      ),
      child: Column(
        children: [
          // 🔹 Header
          Container(
            color: ColorConstant.clr292929,
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Logo
                SizedBox(height: MediaQuery.of(context).padding.top),
                Image.asset(
                  'assets/images/app_logo.png',
                  height: 20.h,
                  // width: 245.w,
                ),
                SizedBox(height: 26.h),

                // Profile card
                Container(
                  decoration: BoxDecoration(
                    color: ColorConstant.clrSecondary,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      // Avatar
                      CircleAvatar(
                        radius: 25,
                        backgroundImage: AssetImage(ImageConstant.imgUser),
                      ),
                      const SizedBox(width: 12),

                      // Name + City
                      Expanded(
                        child: Obx(
                          () => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Hello ${Get.find<ProfileController>().userDetails.value.user?.name ?? GetStorage().read(userName) ?? ''}",
                                maxLines: 1,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                // "${GetStorage().read(userAddress) ?? 'City Name'}",
                                "${Get.find<ProfileController>().userDetails.value.user?.address ?? GetStorage().read(userAddress)}",
                                maxLines: 1,
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // const Spacer(),
                      InkWell(
                        onTap: () {
                          Get.toNamed(AppRoutes.editProfileScreen);
                        },
                        child: Image.asset(
                          ImageConstant.imgEditBtn,
                          height: 20.h,
                        ),
                      ),
                      SizedBox(width: 12.w),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          Flexible(
            child: ListView.separated(
              shrinkWrap: true,
              // physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.only(bottom: 60.h),
              separatorBuilder: (context, index) {
                return Visibility(
                  visible: index == 3 || index == 6,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 12.w,
                      vertical: 4.h,
                    ),
                    child: Divider(
                      color: ColorConstant.clrEEEEEE,
                      thickness: 1.5,
                    ),
                  ),
                );
              },
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap:
                      () => setState(() {
                        log(index.toString());
                        selectedIndex = index;
                        if (index == 2) {
                          Get.to(OrderHistoryScreen());
                        } else if (index == 3) {
                          Get.toNamed(AppRoutes.editProfileScreen);
                        } else if (index == 4) {
                          Get.toNamed(
                            AppRoutes.metaDataScreen,
                            arguments: {
                              'tabIndex': 0,
                            }, // Pass Privacy Policy tab
                          );
                        } else if (index == 5) {
                          Get.toNamed(
                            AppRoutes.metaDataScreen,
                            arguments: {
                              'tabIndex': 1,
                            }, // Pass Terms & Conditions tab
                          );
                        } else if (index == 7) {
                          // Logout action
                          showLogoutDialog(context);
                        } else if (index == 8) {
                          // Logout action
                          showLogoutDialog(context);
                        }
                      }),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 20.w),
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 2.h,
                    ),
                    decoration: BoxDecoration(
                      color:
                          index == selectedIndex
                              ? ColorConstant.clrF2FAFF
                              : Colors.transparent,
                      borderRadius: BorderRadius.circular(18.r),
                    ),
                    child: _drawerItem(
                      icon: drawerItems[index].iconPath,
                      clrIcon:
                          index != 7
                              ? ColorConstant.clr444444
                              : ColorConstant.clrSecondary,
                      title: drawerItems[index].title,
                      style:
                          index != 7
                              ? TextStyleConstant()
                                  .subTitleTextStyle18w500Clr242424
                              : TextStyleConstant()
                                  .subTitleTextStyle18w500ClrSecondary,
                    ),
                  ),
                );
              },
              itemCount: drawerItems.length,
            ),
          ),
        ],
      ),
    );
  }

  // Reusable Drawer Item
  Widget _drawerItem({
    String? icon,
    String? title,
    TextStyle? style,
    Color? clrIcon,
  }) {
    return ListTile(
      leading: SvgPicture.asset(
        icon ?? "",
        height: 17.h,
        colorFilter: ColorFilter.mode(
          clrIcon ?? ColorConstant.clr444444,
          BlendMode.srcIn,
        ),
      ),
      title: Text(title ?? "", style: style),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      hoverColor: Colors.grey.shade100,
    );
  }
}

class DrawerItem extends StatelessWidget {
  final String iconPath;
  final String title;

  const DrawerItem({super.key, required this.iconPath, required this.title});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgPicture.asset(
        iconPath,
        height: 17.h,
        colorFilter: ColorFilter.mode(ColorConstant.clr444444, BlendMode.srcIn),
      ),
      title: Text(
        title,
        style: TextStyleConstant().subTitleTextStyle18w500Clr242424,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      hoverColor: Colors.grey.shade100,
    );
  }
}

showLogoutDialog(BuildContext context) {
  // final ThemeController themeController = Get.find<ThemeController>();
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        // themeController.themeMode.value == ThemeMode.dark
        //     ? ColorConstant.clr27292A
        // : Colors.white,
        title: Text(
          // LocalizationStrings.logoutConfirmationText.tr,
          'Are you sure you want to logout?',
          textAlign: TextAlign.center,
          style: TextStyleConstant().subTitleTextStyle20w500Clr242424,
        ),
        actionsAlignment: MainAxisAlignment.spaceAround,
        // actionsPadding: EdgeInsets.symmetric(vertical: 10),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: Text(
              // LocalizationStrings.cancel.tr,
              'Cancel',
              style: TextStyleConstant().subTitleTextStyle16w500Clr242424,
            ),
          ),
          SizedBox(
            width: 105.w,
            height: 35.h,
            child: CommonButton(
              color: ColorConstant.clr242424,
              onPressed: () {
                // GetStorage().remove(userData);
                GetStorage().remove(accessToken);
                GetStorage().remove(userId);
                GetStorage().remove(userRole);
                GetStorage().remove(userName);
                GetStorage().remove(userPhone);
                GetStorage().remove(userAddress);
                GetStorage().remove(userPincode);
                GetStorage().remove(userProfileImage);
                Get.offAllNamed(AppRoutes.selectAuthScreen);
              },
              btnText: "Logout",
              // 'Logout',
            ),
          ),
        ],
      );
    },
  );
}
