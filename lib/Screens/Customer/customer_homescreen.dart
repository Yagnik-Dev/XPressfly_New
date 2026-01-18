import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:xpressfly_git/Common%20Components/common_drawer.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/image_constant.dart';
import 'package:xpressfly_git/Constants/storage_constant.dart';
import 'package:xpressfly_git/Constants/text_style_constant.dart';
import 'package:xpressfly_git/Controller/customer_home_controller.dart';
import 'package:xpressfly_git/Controller/profile_controller.dart';
import 'package:xpressfly_git/Localization/localization_keys.dart';
import 'package:xpressfly_git/Utility/app_utility.dart';
import '../../Routes/app_routes.dart';

class CustomerHomeScreen extends StatelessWidget {
  CustomerHomeScreen({super.key});

  final CustomerHomeController customerHomeController = Get.put(
    CustomerHomeController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      endDrawer: const CommonDrawer(),
      backgroundColor: ColorConstant.clrF2FAFF,
      // appBar: PreferredSize(
      //   preferredSize: Size.fromHeight(50.h),
      //   child: AppBar(
      //     // leadingWidth: 100.w,
      //     backgroundColor: ColorConstant.clrF2FAFF,
      //     // leading: Container(
      //     //   // height: 46.h,
      //     //   // width: 44.w,
      //     //   margin: EdgeInsets.only(left: 8.w),
      //     //   decoration: BoxDecoration(
      //     //     color: Colors.white,
      //     //     shape: BoxShape.circle,
      //     //   ),
      //     //   child: Image.asset(ImageConstant.imgUser),
      //     // ),
      //     leading: Container(
      //       height: 46.h,
      //       width: 46.w,
      //       margin: EdgeInsets.only(right: 10.w, left: 16.w),
      //       decoration: BoxDecoration(
      //         color: Colors.white,
      //         shape: BoxShape.circle,
      //       ),
      //       child: ClipOval(
      //         child: Obx(() {
      //           final profileImage =
      //               Get.find<ProfileController>()
      //                   .userDetails
      //                   .value
      //                   .user
      //                   ?.profileImage;
      //           return profileImage != null && profileImage.isNotEmpty
      //               ? Image.network(
      //                 profileImage,
      //                 fit: BoxFit.cover,
      //                 width: 46.w,
      //                 height: 46.h,
      //                 errorBuilder: (context, error, stackTrace) {
      //                   return Image.asset(ImageConstant.imgUser);
      //                 },
      //               )
      //               : Image.asset(ImageConstant.imgUser);
      //         }),
      //       ),
      //     ),
      //     title: Obx(
      //       () => Column(
      //         crossAxisAlignment: CrossAxisAlignment.start,
      //         children: [
      //           Text(
      //             "${LocalizationKeys.hello.tr} ${Get.find<ProfileController>().userDetails.value.user?.name ?? GetStorage().read(userName) ?? ''}",
      //             style: TextStyleConstant().subTitleTextStyle18w600Clr242424,
      //           ),
      //           Text(
      //             '${Get.find<ProfileController>().userDetails.value.user?.city ?? GetStorage().read(userAddress)} - ${Get.find<ProfileController>().userDetails.value.user?.pincode ?? GetStorage().read(userPincode) ?? '395010'}',
      //             style: TextStyleConstant().subTitleTextStyle16w500ClrSubText,
      //           ),
      //         ],
      //       ),
      //     ),
      //     actions: [
      //       Builder(
      //         builder:
      //             (context) => InkWell(
      //               onTap: () {
      //                 Scaffold.of(context).openEndDrawer();
      //               },
      //               child: Container(
      //                 height: 46.h,
      //                 width: 46.w,
      //                 margin: EdgeInsets.only(right: 16.w),
      //                 padding: EdgeInsets.all(10.sp),
      //                 decoration: BoxDecoration(
      //                   color: Colors.white,
      //                   shape: BoxShape.circle,
      //                 ),
      //                 child: Image.asset(ImageConstant.imgInformation),
      //               ),
      //             ),
      //       ),
      //     ],
      //   ),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 30.h),
            _buildAppBar(),
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(19.w, 0, 0, 19.h),
              margin: EdgeInsets.fromLTRB(15.w, 8.h, 15.w, 15.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(34.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withValues(alpha: 0.1),
                    spreadRadius: 1,
                    blurRadius: 8,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.topRight,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 16.h),
                      Image.asset(
                        ImageConstant.imgVerificationComplete,
                        height: 34.h,
                        width: 34.w,
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        LocalizationKeys.verificationRequired.tr,
                        style:
                            TextStyleConstant()
                                .subTitleTextStyle18w600Clr242424,
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        LocalizationKeys.verifyAccountWithAadhar.tr,
                        style:
                            TextStyleConstant()
                                .subTitleTextStyle14w400clr666666,
                      ),
                      SizedBox(height: 24),
                      Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  ImageConstant.imgSafeDelivery,
                                  height: 20.h,
                                  width: 18.w,
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  LocalizationKeys.safeDelivery.tr,
                                  style:
                                      TextStyleConstant()
                                          .subTitleTextStyle14w500ClrSubText,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  ImageConstant.imgFastDelivery,
                                  height: 20.h,
                                  width: 20.w,
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  LocalizationKeys.fastDelivery.tr,
                                  style:
                                      TextStyleConstant()
                                          .subTitleTextStyle14w500ClrSubText,
                                ),
                              ],
                            ),
                          ),
                          Transform.scale(
                            scale: 0.9,
                            child: Switch(
                              // value: driverHomeController.isSwitched.value,
                              value: true,
                              activeColor: ColorConstant.clrSecondary,
                              activeTrackColor: ColorConstant.clrSecondary
                                  .withValues(alpha: 0.3),
                              inactiveTrackColor: ColorConstant.clrWhite,
                              inactiveThumbColor: ColorConstant.clrSecondary,
                              trackOutlineColor: WidgetStatePropertyAll(
                                ColorConstant.clrSecondary,
                              ),
                              onChanged: (value) {
                                // driverHomeController.isSwitched.value =
                                //     !driverHomeController.isSwitched.value;
                                // driverHomeController.isSwitched.refresh();
                              },
                            ),
                          ),
                          SizedBox(width: 16.w),

                          // InkWell(
                          //   onTap: () {
                          //     Get.toNamed(AppRoutes.verificationScreen);
                          //   },
                          //   child: Container(
                          //     padding: EdgeInsets.all(12),
                          //     decoration: BoxDecoration(
                          //       color: Color(0xFFE74C3C),
                          //       shape: BoxShape.circle,
                          //     ),
                          //     child: Icon(
                          //       Icons.arrow_back,
                          //       color: Colors.white,
                          //       size: 20,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(34.r),
                      bottomLeft: Radius.circular(30.r),
                    ),
                    child: Image.asset(
                      ImageConstant.imgCardTopRight,
                      // height: 100.h,
                      width: 110.w,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 4.h),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
              decoration: BoxDecoration(
                color: Colors.white,
                // here set radius only top left-right
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        LocalizationKeys.selectVehicle.tr,
                        style:
                            TextStyleConstant()
                                .subTitleTextStyle20w600Clr242424,
                      ),
                      // InkWell(
                      //   onTap: () {
                      //     Get.toNamed(AppRoutes.bookAOrderMainScreen);
                      //   },
                      //   child: Text(
                      //     LocalizationKeys.bookAOrder.tr,
                      //     style:
                      //         TextStyleConstant()
                      //             .subTitleTextStyle14w500Clr9D9D9D,
                      //   ),
                      // ),
                    ],
                  ),
                  Obx(
                    () => GridView.builder(
                      shrinkWrap: true,
                      itemCount:
                          customerHomeController
                              .vehicleTypeList
                              .value
                              .data
                              ?.length ??
                          0,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.only(top: 14.h, bottom: 60.h),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 1.05,
                        crossAxisSpacing: 12.w,
                        mainAxisSpacing: 12.h,
                      ),
                      itemBuilder: (context, index) {
                        final item =
                            customerHomeController
                                .vehicleTypeList
                                .value
                                .data?[index];
                        return Container(
                          decoration: BoxDecoration(
                            color: Color(parseColorCode(item?.colorCode)),
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          padding: EdgeInsets.fromLTRB(11.w, 12.h, 0.w, 0.h),
                          child: Stack(
                            children: [
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Image.network(
                                  item!.logo!,
                                  fit: BoxFit.contain,
                                  height:
                                      80.h, // <-- give fixed size instead of Expanded
                                  width: 80.w,
                                ),
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name ?? '',
                                    style:
                                        TextStyleConstant()
                                            .subTitleTextStyle18w400Clr242424,
                                  ),
                                  Text(
                                    item.description ?? "",
                                    style:
                                        TextStyleConstant()
                                            .subTitleTextStyle12w400clr666666,
                                    textAlign: TextAlign.left,
                                  ),
                                ],
                              ),
                              SizedBox(height: 8.h),
                              InkWell(
                                onTap: () {
                                  Get.toNamed(
                                    AppRoutes.bookAOrderMainScreen,
                                    arguments: {'vehicleType': item.id ?? 0},
                                  );
                                  // Get.toNamed(AppRoutes.vehicleDetailsScreen);
                                },
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Container(
                                    padding: EdgeInsets.all(6.sp),
                                    margin: EdgeInsets.only(bottom: 7.h),
                                    decoration: BoxDecoration(
                                      color: ColorConstant.clrFFFAFA,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      Icons.arrow_outward_rounded,
                                      color: ColorConstant.clrSecondary,
                                      size: 18.sp,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Row(
      children: [
        // In _buildAppBar() method, replace the first Container:
        Container(
          margin: EdgeInsets.only(right: 10.w, left: 16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: CircleAvatar(
            radius: 24.r,
            backgroundColor: Colors.white,
            child: ClipOval(
              child: Obx(() {
                final profileImage =
                    Get.find<ProfileController>()
                        .userDetails
                        .value
                        .user
                        ?.profileImage;
                return profileImage != null && profileImage.isNotEmpty
                    ? Image.network(
                      profileImage,
                      fit: BoxFit.cover,
                      width: 48.w,
                      height: 48.h,
                      errorBuilder: (context, error, stackTrace) {
                        return Image.asset(ImageConstant.imgUser);
                      },
                    )
                    : Image.asset(ImageConstant.imgUser);
              }),
            ),
          ),
        ),
        Expanded(
          child: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${LocalizationKeys.hello.tr} ${Get.find<ProfileController>().userDetails.value.user?.name ?? GetStorage().read(userName) ?? 'Driver'}",
                  style: TextStyleConstant().subTitleTextStyle18w600Clr242424,
                ),
                Text(
                  Get.find<ProfileController>().userDetails.value.user?.city ??
                      GetStorage().read(userAddress) ??
                      LocalizationKeys.address.tr,
                  style: TextStyleConstant().subTitleTextStyle16w500ClrSubText,
                ),
              ],
            ),
          ),
        ),
        Builder(
          builder:
              (context) => InkWell(
                onTap: () {
                  Scaffold.of(context).openEndDrawer();
                },
                child: Container(
                  height: 46.h,
                  width: 46.w,
                  margin: EdgeInsets.only(right: 16.w),
                  padding: EdgeInsets.all(10.sp),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(ImageConstant.imgInformation),
                ),
              ),
        ),
        SizedBox(height: 4.w),
      ],
    );
  }
}

class VehicleList {
  String vehicleName;
  String vehicleNumber;
  String imagePath;
  Color bgColor;

  VehicleList({
    required this.vehicleName,
    required this.vehicleNumber,
    required this.imagePath,
    required this.bgColor,
  });
}

List<VehicleList> vehicleList = [
  VehicleList(
    vehicleName: 'Mahindra Jeeto',
    vehicleNumber: 'GJ05AE8080',
    imagePath: ImageConstant.imgSmallTruck,
    bgColor: Color(0xffFEE3BA),
  ),
  VehicleList(
    vehicleName: 'Suzuki Dzire LXi',
    vehicleNumber: 'GJ05AE8080',
    imagePath: ImageConstant.imgMotorCar,
    bgColor: Color(0xffD5E8FF),
  ),
  VehicleList(
    vehicleName: 'Mahindra Jeeto',
    vehicleNumber: 'GJ05AE8080',
    imagePath: ImageConstant.imgSmallTruck,
    bgColor: Color(0xffFEE3BA),
  ),
];
