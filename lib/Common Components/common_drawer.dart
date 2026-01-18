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
import 'package:xpressfly_git/Localization/language_selection_dialog.dart';
import 'package:xpressfly_git/Localization/localization_keys.dart';
import 'package:xpressfly_git/Models/profile_model.dart';
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
    DrawerItem(
      iconPath: ImageConstant.imgHomeBottom,
      title: LocalizationKeys.home.tr,
    ),
    DrawerItem(
      iconPath: ImageConstant.imgParcelBottom,
      title: LocalizationKeys.orderRequest.tr,
    ),
    DrawerItem(
      iconPath: ImageConstant.imgHistoryBottom,
      title: LocalizationKeys.orderHistory.tr,
    ),
    DrawerItem(
      iconPath: ImageConstant.imgProfileBottom,
      title: LocalizationKeys.profile.tr,
    ),
    DrawerItem(
      // iconPath: ImageConstant.imgLanguage,
      title: LocalizationKeys.language.tr,
      isIcon: true,
      iconData: Icons.language,
    ),
    DrawerItem(
      iconPath: ImageConstant.imgTermsAndCondition,
      title: LocalizationKeys.termsCondition.tr,
    ),
    DrawerItem(
      iconPath: ImageConstant.imgPrivacyPolicy,
      title: LocalizationKeys.privacyPolicy.tr,
    ),
    DrawerItem(
      iconPath: ImageConstant.imgHelpAndSupport,
      title: LocalizationKeys.helpSupport.tr,
    ),
    DrawerItem(
      iconPath: ImageConstant.imgLogout,
      title: LocalizationKeys.logout.tr,
    ),
  ];
  // In _CommonDrawerState, add initState:

  @override
  void initState() {
    super.initState();
    // Refresh profile data when drawer opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Get.find<ProfileController>().getData();
    });
  }

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
                // Replace the CircleAvatar section with this:
                Container(
                  decoration: BoxDecoration(
                    color: ColorConstant.clrSecondary,
                    borderRadius: BorderRadius.circular(50),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      // Avatar
                      Obx(() {
                        final profileController = Get.find<ProfileController>();
                        final profileImage =
                            profileController
                                .userDetails
                                .value
                                .user
                                ?.profileImage;

                        debugPrint('Drawer Profile Image: $profileImage');

                        // Show default image if profileImage is null or empty
                        if (profileImage == null || profileImage.isEmpty) {
                          return CircleAvatar(
                            radius: 25,
                            backgroundColor: Colors.grey.shade300,
                            backgroundImage: AssetImage(ImageConstant.imgUser),
                          );
                        }

                        return CircleAvatar(
                          radius: 25,
                          backgroundColor: Colors.grey.shade300,
                          backgroundImage: NetworkImage(profileImage),
                          onBackgroundImageError: (exception, stackTrace) {
                            debugPrint('Drawer image load error: $exception');
                          },
                        );
                      }),
                      const SizedBox(width: 12),
                      // Name + City
                      Expanded(
                        child: Obx(() {
                          final profileController =
                              Get.find<ProfileController>();
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${LocalizationKeys.hello.tr} ${profileController.userDetails.value.user?.name ?? GetStorage().read(userName) ?? ''}",
                                maxLines: 1,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              Text(
                                profileController
                                        .userDetails
                                        .value
                                        .user
                                        ?.address ??
                                    GetStorage().read(userAddress) ??
                                    '',
                                maxLines: 1,
                                style: TextStyle(
                                  color: Colors.white70,
                                  fontSize: 14,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
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
                ), // Container(
                //   decoration: BoxDecoration(
                //     color: ColorConstant.clrSecondary,
                //     borderRadius: BorderRadius.circular(50),
                //   ),
                //   padding: const EdgeInsets.all(12),
                //   child: Row(
                //     children: [
                //       // Avatar
                //       CircleAvatar(
                //         radius: 25,
                //         backgroundImage: AssetImage(ImageConstant.imgUser),
                //       ),
                //       const SizedBox(width: 12),

                //       // Name + City
                //       Expanded(
                //         child: Obx(
                //           () => Column(
                //             crossAxisAlignment: CrossAxisAlignment.start,
                //             children: [
                //               Text(
                //                 "${LocalizationKeys.hello.tr} ${Get.find<ProfileController>().userDetails.value.user?.name ?? GetStorage().read(userName) ?? ''}",
                //                 maxLines: 1,
                //                 style: TextStyle(
                //                   color: Colors.white,
                //                   fontSize: 16,
                //                   fontWeight: FontWeight.w600,
                //                   overflow: TextOverflow.ellipsis,
                //                 ),
                //               ),
                //               Text(
                //                 // "${GetStorage().read(userAddress) ?? 'City Name'}",
                //                 "${Get.find<ProfileController>().userDetails.value.user?.address ?? GetStorage().read(userAddress)}",
                //                 maxLines: 1,
                //                 style: TextStyle(
                //                   color: Colors.white70,
                //                   fontSize: 14,
                //                   overflow: TextOverflow.ellipsis,
                //                 ),
                //               ),
                //             ],
                //           ),
                //         ),
                //       ),
                //       // const Spacer(),
                //       InkWell(
                //         onTap: () {
                //           Get.toNamed(AppRoutes.editProfileScreen);
                //         },
                //         child: Image.asset(
                //           ImageConstant.imgEditBtn,
                //           height: 20.h,
                //         ),
                //       ),
                //       SizedBox(width: 12.w),
                //     ],
                //   ),
                // ),
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
                          showLanguageSelectionDialog(context);
                        } else if (index == 5) {
                          Get.toNamed(
                            AppRoutes.metaDataScreen,
                            arguments: {
                              'tabIndex': 0,
                            }, // Pass Privacy Policy tab
                          );
                        } else if (index == 6) {
                          Get.toNamed(
                            AppRoutes.metaDataScreen,
                            arguments: {
                              'tabIndex': 1,
                            }, // Pass Terms & Conditions tab
                          );
                        } else if (index == 7) {
                          // Logout action
                          // showLogoutDialog(context);
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
                      iconData: drawerItems[index].iconData,
                      isIcon: drawerItems[index].isIcon,
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
  // Reusable Drawer Item
  Widget _drawerItem({
    String? icon,
    String? title,
    TextStyle? style,
    Color? clrIcon,
    IconData? iconData,
    bool isIcon = false,
  }) {
    return ListTile(
      leading:
          isIcon
              ? Icon(
                iconData,
                color: clrIcon ?? ColorConstant.clr444444,
                size: 22.sp,
              )
              : SvgPicture.asset(
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
  final String? iconPath;
  final String title;
  final bool isIcon;
  final IconData iconData;

  const DrawerItem({
    super.key,
    this.iconPath,
    required this.title,
    this.isIcon = false,
    this.iconData = Icons.home,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading:
          isIcon
              ? Icon(iconData, color: ColorConstant.clr444444)
              : SvgPicture.asset(
                iconPath ?? "",
                height: 17.h,
                colorFilter: ColorFilter.mode(
                  ColorConstant.clr444444,
                  BlendMode.srcIn,
                ),
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
          LocalizationKeys.logoutConfirmation.tr,
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
              LocalizationKeys.cancel.tr,
              style: TextStyleConstant().subTitleTextStyle16w500Clr242424,
            ),
          ),
          SizedBox(
            width: 105.w,
            height: 35.h,
            child: CommonButton(
              color: ColorConstant.clr242424,
              onPressed: () {
                // Clear all storage
                GetStorage().remove(accessToken);
                GetStorage().remove(userId);
                GetStorage().remove(userRole);
                GetStorage().remove(userName);
                GetStorage().remove(userPhone);
                GetStorage().remove(userAddress);
                GetStorage().remove(userPincode);
                GetStorage().remove(userProfileImage);
                GetStorage().remove(userCity);
                GetStorage().remove(userEmail);

                // Reset ProfileController
                final profileController = Get.find<ProfileController>();
                profileController.userDetails.value = GetUserProfileDataModel();
                profileController.profileImage.value = null;
                profileController.aadharCardFront.value = null;
                profileController.aadharCardBack.value = null;
                profileController.driverLicenseFront.value = null;
                profileController.driverLicenseBack.value = null;

                // Clear all text controllers
                profileController.nameTextEditingController.clear();
                profileController.mobileTextEditingController.clear();
                profileController.emailTextEditingController.clear();
                profileController.addressTextEditingController.clear();
                profileController.pincodeTextEditingController.clear();
                profileController.cityTextEditingController.clear();
                profileController.bankAccountHolderNameController.clear();
                profileController.bankAccountNumberController.clear();
                profileController.bankIFSCController.clear();

                // Navigate to login
                Get.offAllNamed(AppRoutes.selectAuthScreen);
              },
              btnText: LocalizationKeys.logout.tr,
              // 'Logout',
            ),
          ),
        ],
      );
    },
  );
}
