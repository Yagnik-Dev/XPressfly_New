import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xpressfly_git/Common%20Components/common_button.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/image_constant.dart';
import 'package:xpressfly_git/Constants/text_style_constant.dart';
import 'package:xpressfly_git/Controller/add_vehicle_maincontroller.dart';
import 'package:xpressfly_git/Routes/app_routes.dart';
import 'package:xpressfly_git/Screens/Customer/book_a_order_one.dart';
import 'package:xpressfly_git/Screens/Customer/book_a_order_three.dart';
import 'package:xpressfly_git/Screens/Customer/book_a_order_two.dart';

// ignore: must_be_immutable
class BookAOrderMainScreen extends StatefulWidget {
  const BookAOrderMainScreen({super.key});

  @override
  State<BookAOrderMainScreen> createState() => _BookAOrderMainScreenState();
}

class _BookAOrderMainScreenState extends State<BookAOrderMainScreen> {
  AddVehicleMainController addvehicleController = Get.put(
    AddVehicleMainController(),
  );

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
                      setState(() {});
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
                  child:
                      addvehicleController.intCurrentStep.value == 2
                          ? InkWell(
                            onTap: () {
                              Get.toNamed(AppRoutes.waitForResponseTimerScreen);
                              Future.delayed(Duration(seconds: 3), () {
                                Get.back();
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 5.h,
                                horizontal: 5.w,
                              ),
                              decoration: BoxDecoration(
                                color: ColorConstant.clrSecondary,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    padding: EdgeInsets.all(11.sp),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.white,
                                    ),
                                    child: Image.asset(
                                      ImageConstant.imgSwipeToAccept,
                                      height: 20.h,
                                      width: 20.w,
                                    ),
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    "Slide to Confirm",
                                    style:
                                        TextStyleConstant()
                                            .subTitleTextStyle18w500clrFFFAFA,
                                  ),
                                ],
                              ),
                            ),
                          )
                          : CommonButtonRounded(
                            btnText:
                                addvehicleController.intCurrentStep.value == 2
                                    ? "Submit"
                                    : "Next",
                            color: ColorConstant.clrSecondary,
                            onPressed: () {
                              if (addvehicleController.intCurrentStep.value ==
                                  0) {
                                // if (addvehicleController.addVehicleFormKey.currentState!
                                //     .validate()) {
                                addvehicleController.pageviewController
                                    .nextPage(
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                      curve: Curves.easeInOut,
                                    );
                                // }
                              } else if (addvehicleController
                                      .intCurrentStep
                                      .value ==
                                  1) {
                                // if (addvehicleController.addVehicleFormKey.currentState!
                                //     .validate()) {
                                addvehicleController.pageviewController
                                    .nextPage(
                                      duration: const Duration(
                                        milliseconds: 300,
                                      ),
                                      curve: Curves.easeInOut,
                                    );
                                // }
                              } else {
                                // if (addvehicleController.addVehicleFormKey.currentState!
                                //     .validate()) {
                                // addvehicleController.createVehicle((p0) {});
                                // }
                              }
                              setState(() {});
                            },
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
                Text(
                  'Book a Order',
                  style: TextStyleConstant().subTitleTextStyle26w600Clr242424,
                ),
                // SizedBox(height: 10.h),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 10.h,
                  ),
                  child: Row(
                    children: [
                      // here manage 3 container based on stepper
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
                      SizedBox(width: 6.w),
                      Obx(
                        () => Expanded(
                          child: Container(
                            height: 4.h,
                            decoration: BoxDecoration(
                              color:
                                  addvehicleController.intCurrentStep.value == 2
                                      ? ColorConstant.clrSecondary
                                      : ColorConstant.clrF2FAFF,
                              borderRadius: BorderRadius.circular(30.r),
                            ),
                          ),
                        ),
                      ),
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
        children: [BookAOrderOne(), BookAOrderTwo(), BookAOrderThree()],
        onPageChanged: (value) {
          addvehicleController.intCurrentStep.value = value;
          addvehicleController.intCurrentStep.refresh();
          setState(() {});
        },
      ),
    );
  }
}
