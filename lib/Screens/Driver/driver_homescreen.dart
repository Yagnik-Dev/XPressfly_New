import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:xpressfly_git/Common%20Components/common_drawer.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/image_constant.dart';
import 'package:xpressfly_git/Constants/storage_constant.dart';
import 'package:xpressfly_git/Constants/text_style_constant.dart';
import 'package:xpressfly_git/Controller/driver_home_controller.dart';
import 'package:xpressfly_git/Models/get_user_wise_vehicle_model.dart';
import 'package:xpressfly_git/Routes/app_routes.dart';

class DriverHomeScreen extends StatelessWidget {
  DriverHomeScreen({super.key});

  final DriverHomeController driverHomeController = Get.put(
    DriverHomeController(),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      endDrawer: const CommonDrawer(),
      backgroundColor: ColorConstant.clrBackGroundLight,
      body: Column(
        children: [
          SizedBox(height: 30.h),
          _buildAppBar(),
          _buildEarningsCard(),
          SizedBox(height: 4.h),
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                children: [
                  _buildVehicleHeader(),
                  SizedBox(height: 10.h),
                  _buildSearchField(),
                  SizedBox(height: 16.h),
                  _buildVehicleList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Row(
      children: [
        Container(
          height: 46.h,
          width: 46.w,
          margin: EdgeInsets.only(right: 10.w, left: 16.w),
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
          child: Image.asset(ImageConstant.imgUser),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Hello Jagnish",
                style: TextStyleConstant().subTitleTextStyle18w600Clr242424,
              ),
              Text(
                "Surat, GJ",
                style: TextStyleConstant().subTitleTextStyle16w500ClrSubText,
              ),
            ],
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

  Widget _buildEarningsCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(34.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Today Earning',
            style: TextStyleConstant().subTitleTextStyle16w500Clr242424,
          ),
          Text(
            '₹ 3,265.00',
            style: TextStyleConstant().subTitleTextStyle40w600clrSecondary,
          ),
          SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Trips',
                      style:
                          TextStyleConstant().subTitleTextStyle14w500ClrSubText,
                    ),
                    SizedBox(height: 4),
                    Text(
                      '15',
                      style:
                          TextStyleConstant().subTitleTextStyle14w600clr242424,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Distance',
                      style:
                          TextStyleConstant().subTitleTextStyle14w500ClrSubText,
                    ),
                    SizedBox(height: 4),
                    Text(
                      '60km',
                      style:
                          TextStyleConstant().subTitleTextStyle14w600clr242424,
                    ),
                  ],
                ),
              ),
              Obx(
                () => Switch(
                  value: driverHomeController.isSwitched.value,
                  activeColor: ColorConstant.clrSecondary,
                  activeTrackColor: ColorConstant.clrSecondary.withOpacity(0.3),
                  inactiveTrackColor: ColorConstant.clrWhite,
                  inactiveThumbColor: ColorConstant.clrSecondary,
                  trackOutlineColor: WidgetStatePropertyAll(
                    ColorConstant.clrSecondary,
                  ),
                  onChanged: (value) {
                    driverHomeController.isSwitched.value = value;
                    driverHomeController.toggleDutyApiCall(
                      details: {
                        "user_id": GetStorage().read(userId),
                        "on_duty": value ? "1" : "0",
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildVehicleHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Vehicle List',
          style: TextStyleConstant().subTitleTextStyle20w500Clr242424,
        ),
        InkWell(
          onTap: () {
            Get.toNamed(AppRoutes.addVehicleMainScreen);
          },
          child: Text(
            'Add Vehicle',
            style: TextStyleConstant().subTitleTextStyle14w500ClrSubText,
          ),
        ),
      ],
    );
  }

  Widget _buildSearchField() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search Vehicle',
        hintStyle: TextStyleConstant().subTitleTextStyle14w500ClrCCCCCC,
        suffixIcon: Padding(
          padding: const EdgeInsets.only(right: 8.0),
          child: Icon(Icons.search, color: ColorConstant.clrC8C8C8),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.r),
          borderSide: BorderSide(color: ColorConstant.clrEEEEEE),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.r),
          borderSide: BorderSide(color: ColorConstant.clrEEEEEE),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.r),
          borderSide: BorderSide(color: ColorConstant.clrEEEEEE),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 19.w),
      ),
    );
  }

  Widget _buildVehicleList() {
    return Obx(() {
      if (driverHomeController.isVehicleLoading.value) {
        return Center(
          child: CircularProgressIndicator(color: ColorConstant.clrSecondary),
        );
      }

      final vehicles =
          driverHomeController.userWiseVehicleList.value.data ?? [];

      if (vehicles.isEmpty) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.directions_car_outlined,
                size: 50.sp,
                color: ColorConstant.clrCCCCCC,
              ),
              SizedBox(height: 16.h),
              Text(
                'No vehicles found',
                style: TextStyleConstant().subTitleTextStyle16w500Clr242424,
              ),
              SizedBox(height: 8.h),
              Text(
                'Add your first vehicle to get started',
                style: TextStyleConstant().subTitleTextStyle14w500ClrCCCCCC,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h),
              ElevatedButton(
                onPressed: () {
                  Get.toNamed(AppRoutes.addVehicleMainScreen);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorConstant.clrSecondary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
                child: Text(
                  'Add Vehicle',
                  style: TextStyleConstant().subTitleTextStyle14w500ClrSubText,
                ),
              ),
            ],
          ),
        );
      }

      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children:
              vehicles
                  .asMap()
                  .entries
                  .map((entry) => _buildVehicleCard(entry.value, entry.key))
                  .toList(),
        ),
      );
    });
  }

  Widget _buildVehicleCard(GetUserVehicleData vehicle, int index) {
    // Determine background color and image based on vehicle type
    Color bgColor = index.isEven ? Color(0xFFFEE3BA) : Color(0xFFC2EAFF);
    String imagePath = _getVehicleImage(vehicle.vehicleType);

    return Container(
      height: 165.h,
      margin: EdgeInsets.only(top: 0.h, right: 12.w),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(30.r),
      ),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(18.w, 18.h, 0, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          vehicle.vehicleModel ?? 'Unknown Vehicle',
                          style:
                              TextStyleConstant()
                                  .subTitleTextStyle16w500Clr242424,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          vehicle.vehicleNumber ?? 'No Number',
                          style:
                              TextStyleConstant()
                                  .subTitleTextStyle16w500Clr242424,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    SizedBox(height: 45.h),
                    InkWell(
                      onTap: () {
                        Get.toNamed(
                          AppRoutes.vehicleDetailsScreen,
                          arguments:
                              vehicle.id, // Pass vehicle data to details screen
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.all(14.sp),
                        decoration: BoxDecoration(
                          color: ColorConstant.clrFFFAFA,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.arrow_forward,
                          color: ColorConstant.clrSecondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Image.asset(imagePath, height: 160.h, width: 160.w),
            ],
          ),
        ],
      ),
    );
  }

  Color _getVehicleColor(String? vehicleType) {
    switch (vehicleType?.toLowerCase()) {
      case 'truck':
      case 'mahindra jeeto':
        return Color(0xffFEE3BA);
      case 'car':
      case 'suzuki dzire':
        return Color(0xffD5E8FF);
      default:
        return Color(0xffFEE3BA);
    }
  }

  String _getVehicleImage(String? vehicleType) {
    switch (vehicleType?.toLowerCase()) {
      case 'truck':
      case 'mahindra jeeto':
        return ImageConstant.imgSmallTruck;
      case 'car':
      case 'suzuki dzire':
        return ImageConstant.imgMotorCar;
      default:
        return ImageConstant.imgSmallTruck;
    }
  }
}
