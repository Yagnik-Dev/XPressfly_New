import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xpressfly_git/Common%20Components/common_textfield.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/image_constant.dart';
import 'package:xpressfly_git/Constants/text_style_constant.dart';
import 'package:xpressfly_git/Controller/add_vehicle_maincontroller.dart';
import 'package:xpressfly_git/Screens/Driver/vehicle_type_dialog.dart';

class AddVehicleTwo extends StatelessWidget {
  AddVehicleTwo({super.key});

  AddVehicleMainController addvehicleController =
      Get.find<AddVehicleMainController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.clrF2FAFF,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 18.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.r),
                    bottomRight: Radius.circular(30.r),
                  ),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 8.h,
                        horizontal: 22.w,
                      ),
                      child: Image.asset(ImageConstant.imgAddVehicleTwo),
                    ),
                    Text(
                      "Vehicle Details",
                      style:
                          TextStyleConstant().subTitleTextStyle18w600Clr242424,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Vehicle Model",
                                style:
                                    TextStyleConstant()
                                        .subTitleTextStyle16w500Clr242424,
                              ),
                              SizedBox(height: 6.h),
                              CommonTextFormFieldWithoutBorder(),
                            ],
                          ),
                        ),
                        SizedBox(width: 7.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Vehicle Number",
                                style:
                                    TextStyleConstant()
                                        .subTitleTextStyle16w500Clr242424,
                              ),
                              SizedBox(height: 6.h),
                              CommonTextFormFieldWithoutBorder(),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "Vehicle Type",
                      style:
                          TextStyleConstant().subTitleTextStyle16w500Clr242424,
                    ),
                    SizedBox(height: 6.h),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return VehicleTypeScreen(
                              onSelected: addvehicleController.pickVehicleType,
                            );
                          },
                        );
                      },
                      child: Obx(
                        () => Container(
                          // alignment: Alignment.topLeft,
                          padding: EdgeInsets.fromLTRB(
                            12.w,
                            13.5.h,
                            0.w,
                            13.5.h,
                          ),
                          decoration: BoxDecoration(
                            color:
                                addvehicleController
                                            .selectedVehicleTitle
                                            .value ==
                                        ""
                                    ? ColorConstant.clrWhite
                                    : addvehicleController
                                        .selectedVehicleColor
                                        .value,
                            borderRadius: BorderRadius.circular(8.5.r),
                            border: Border.all(color: ColorConstant.clrEEEEEE),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (addvehicleController
                                      .selectedVehicleTitle
                                      .value !=
                                  "")
                                Padding(
                                  padding: EdgeInsets.only(left: 8.w),
                                  child: Text(
                                    addvehicleController
                                        .selectedVehicleTitle
                                        .value,

                                    style:
                                        TextStyleConstant()
                                            .subTitleTextStyle18w600Clr242424,
                                  ),
                                ),
                              Spacer(),
                              if (addvehicleController
                                      .selectedVehicleIcon
                                      .value !=
                                  "")
                                Image.asset(
                                  addvehicleController
                                      .selectedVehicleIcon
                                      .value,
                                  height: 70.h,
                                  width: 100.w,
                                  fit: BoxFit.contain,
                                ),
                              // Icon(
                              //   Icons.arrow_drop_down,
                              //   color: ColorConstant.clrSubText,
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10.h),
                    Text(
                      "Where You Can Deliver",
                      style:
                          TextStyleConstant().subTitleTextStyle16w500Clr242424,
                    ),
                    SizedBox(height: 6.h),
                    CommonTextFormFieldWithoutBorder(),
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
