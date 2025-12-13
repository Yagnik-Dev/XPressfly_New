import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xpressfly_git/Common%20Components/common_button.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/text_style_constant.dart';
import 'package:xpressfly_git/Controller/add_vehicle_maincontroller.dart';
import 'package:xpressfly_git/Controller/driver_home_controller.dart';
import 'package:xpressfly_git/Screens/Driver/add_vehicle_one.dart';
import 'package:xpressfly_git/Screens/Driver/add_vehicle_two.dart';

// ignore: must_be_immutable
class AddVehicleMainScreen extends StatelessWidget {
  AddVehicleMainScreen({super.key});

  AddVehicleMainController addvehicleController = Get.put(
    AddVehicleMainController(),
  );
  final DriverHomeController driverHomeController =
      Get.find<DriverHomeController>();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        dividerTheme: DividerThemeData(color: Colors.transparent),
      ),
      child: Scaffold(
        backgroundColor: ColorConstant.clrF2FAFF,
        persistentFooterButtons: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10.0, left: 22, right: 22),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(30.r),
                  child: InkWell(
                    onTap: () {
                      if (addvehicleController.intCurrentStep.value == 0) {
                        Get.back();
                      } else {
                        addvehicleController.pageviewController.previousPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      }
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
                  child: Obx(
                    () => CommonButtonRounded(
                      btnText:
                          addvehicleController.intCurrentStep.value == 1
                              ? (addvehicleController.isUpdateMode.value
                                  ? "Update"
                                  : "Submit")
                              : "Next",
                      color: ColorConstant.clrSecondary,
                      onPressed: () async {
                        if (addvehicleController.intCurrentStep.value == 0) {
                          if (addvehicleController
                              .addVehicleFormKey
                              .currentState!
                              .validate()) {
                            addvehicleController.pageviewController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        } else if (addvehicleController.intCurrentStep.value ==
                            1) {
                          if (addvehicleController
                              .addVehicleTwoFormKey
                              .currentState!
                              .validate()) {
                            await addvehicleController.createVehicle((
                              success,
                            ) async {
                              if (success) {
                                await driverHomeController.refreshVehicleList();
                                Get.back();
                              }
                            });
                            // addvehicleController.pageviewController.nextPage(
                            //   duration: const Duration(milliseconds: 300),
                            //   curve: Curves.easeInOut,
                            // );
                          }
                        }
                        // else {
                        //   // This is the submit step
                        //   await addvehicleController.createVehicle((
                        //     success,
                        //   ) async {
                        //     if (success) {
                        //       await driverHomeController.refreshVehicleList();
                        //       Get.back();
                        //     }
                        //   });
                        // }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
        body: Container(
          color: Colors.white,
          child: Padding(
            padding: EdgeInsets.fromLTRB(0, 46.sp, 0, 0),
            child: Column(
              children: [
                Obx(
                  () => Text(
                    addvehicleController.isUpdateMode.value
                        ? 'Update Vehicle'
                        : 'Add Vehicle',
                    style: TextStyleConstant().subTitleTextStyle26w600Clr242424,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 10.h,
                  ),
                  child: Row(
                    children: [
                      Obx(
                        () => Expanded(
                          child: Container(
                            height: 4.h,
                            decoration: BoxDecoration(
                              color:
                                  addvehicleController.intCurrentStep.value == 0
                                      ? ColorConstant.clrSecondary
                                      : ColorConstant.clrF2FAFF,
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 6.w),
                      Obx(
                        () => Expanded(
                          child: Container(
                            height: 4.h,
                            decoration: BoxDecoration(
                              color:
                                  addvehicleController.intCurrentStep.value == 1
                                      ? ColorConstant.clrSecondary
                                      : ColorConstant.clrF2FAFF,
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                          ),
                        ),
                      ),
                      // SizedBox(width: 6.w),
                      // Obx(
                      //   () => Expanded(
                      //     child: Container(
                      //       height: 4.h,
                      //       decoration: BoxDecoration(
                      //         color:
                      //             addvehicleController.intCurrentStep.value == 2
                      //                 ? ColorConstant.clrSecondary
                      //                 : ColorConstant.clrF2FAFF,
                      //         borderRadius: BorderRadius.circular(30.r),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                pageView(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Expanded pageView() {
    return Expanded(
      child: PageView(
        controller: addvehicleController.pageviewController,
        physics: const NeverScrollableScrollPhysics(),
        children: [AddVehicleOne(), AddVehicleTwo()],
        onPageChanged: (value) {
          addvehicleController.intCurrentStep.value = value;
          addvehicleController.intCurrentStep.refresh();
        },
      ),
    );
  }
}
