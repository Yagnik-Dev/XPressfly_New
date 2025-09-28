import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/image_constant.dart';
import 'package:xpressfly_git/Constants/text_style_constant.dart';

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
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            "Hello Jagnish",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(
                            "Surat, GJ",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Image.asset(ImageConstant.imgEditBtn, height: 20.h),
                      SizedBox(width: 12.w),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20.h),
          // Drawer Items
          // Expanded(
          //   child: ListView(
          //     padding: EdgeInsets.zero,
          //     children: [
          //       _drawerItem(ImageConstant.imgHomeBottom, "Home"),
          //       _drawerItem(ImageConstant.imgParcelBottom, "Order Request"),
          //       _drawerItem(ImageConstant.imgHistoryBottom, "Order History"),
          //       _drawerItem(ImageConstant.imgProfileBottom, "Profile"),
          //       Padding(
          //         padding: const EdgeInsets.symmetric(horizontal: 18.0),
          //         child: Divider(color: ColorConstant.clrEEEEEE),
          //       ),
          //       _drawerItem(
          //         ImageConstant.imgTermsAndCondition,
          //         "Terms & Condition",
          //       ),
          //       _drawerItem(ImageConstant.imgPrivacyPolicy, "Privacy Policy"),
          //       _drawerItem(ImageConstant.imgHelpAndSupport, "Help & Support"),
          //       Padding(
          //         padding: const EdgeInsets.symmetric(horizontal: 18.0),
          //         child: Divider(color: ColorConstant.clrEEEEEE),
          //       ),
          // Padding(
          //   padding: EdgeInsets.symmetric(
          //     horizontal: 50.w,
          //     vertical: 9.h,
          //   ),
          //   child: Row(
          //     children: [
          //       SvgPicture.asset(
          //         ImageConstant.imgLogout,
          //         height: 17.h,
          //         color: ColorConstant.clrSecondary,
          //       ),
          //       SizedBox(width: 16.w),
          //       Text(
          //         "Logout",
          //         style:
          //             TextStyleConstant()
          //                 .subTitleTextStyle18w500ClrSecondary,
          //       ),
          //     ],
          //   ),
          // ),
          //     ],
          //   ),
          // ),
          Flexible(
            child: ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
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
                        selectedIndex = index;
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
        color: clrIcon ?? ColorConstant.clr444444,
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
        color: ColorConstant.clr444444,
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
