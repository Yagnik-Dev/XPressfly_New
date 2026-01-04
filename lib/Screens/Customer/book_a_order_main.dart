import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:slide_to_act/slide_to_act.dart';
import 'package:xpressfly_git/Common%20Components/common_button.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/image_constant.dart';
import 'package:xpressfly_git/Constants/text_style_constant.dart';
import 'package:xpressfly_git/Controller/book_a_order_controller.dart';
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
  BookAOrderController bookAOrderController = Get.put(BookAOrderController());

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
                      if (bookAOrderController.intCurrentStep.value == 0) {
                        Get.back();
                      } else {
                        bookAOrderController.pageviewController.previousPage(
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
                      bookAOrderController.intCurrentStep.value == 2
                          ? SlideAction(
                            height: 44.h,
                            borderRadius: 50.r,
                            outerColor: ColorConstant.clrSecondary,
                            innerColor: Colors.white,
                            text: "",
                            sliderButtonIconPadding: 11.sp,
                            sliderButtonIcon: Image.asset(
                              ImageConstant.imgSwipeToAccept,
                              height: 15.h,
                              width: 16.w,
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 50.w, right: 0),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Slide to Confirm",
                                  style:
                                      TextStyleConstant()
                                          .subTitleTextStyle18w500clrFFFAFA,
                                ),
                              ),
                            ),
                            onSubmit: () async {
                              if (bookAOrderController
                                  .bookAOrderThreeFormKey
                                  .currentState!
                                  .validate()) {
                                await bookAOrderController.createOrder((p0) {
                                  log('Order Created Callback: $p0');
                                });

                                Get.toNamed(
                                  AppRoutes.waitForResponseTimerScreen,
                                );

                                Future.delayed(const Duration(seconds: 3), () {
                                  Get.back();
                                });
                              }
                            },
                          )
                          // InkWell(
                          //   onTap: () async {
                          //     if (bookAOrderController
                          //         .bookAOrderThreeFormKey
                          //         .currentState!
                          //         .validate()) {
                          //       await bookAOrderController.createOrder((p0) {
                          //         log('Order Created Callback: $p0');
                          //       });
                          //       Get.toNamed(
                          //         AppRoutes.waitForResponseTimerScreen,
                          //       );
                          //       Future.delayed(Duration(seconds: 3), () {
                          //         Get.back();
                          //       });
                          //     }
                          //   },
                          //   child: Container(
                          //     padding: EdgeInsets.symmetric(
                          //       vertical: 5.h,
                          //       horizontal: 5.w,
                          //     ),
                          //     decoration: BoxDecoration(
                          //       color: ColorConstant.clrSecondary,
                          //       borderRadius: BorderRadius.circular(50),
                          //     ),
                          //     child: Row(
                          //       mainAxisSize: MainAxisSize.min,
                          //       children: [
                          //         Container(
                          //           padding: EdgeInsets.all(11.sp),
                          //           decoration: BoxDecoration(
                          //             shape: BoxShape.circle,
                          //             color: Colors.white,
                          //           ),
                          //           child: Image.asset(
                          //             ImageConstant.imgSwipeToAccept,
                          //             height: 20.h,
                          //             width: 20.w,
                          //           ),
                          //         ),
                          //         SizedBox(width: 8),
                          //         Text(
                          //           "Slide to Confirm",
                          //           style:
                          //               TextStyleConstant()
                          //                   .subTitleTextStyle18w500clrFFFAFA,
                          //         ),
                          //       ],
                          //     ),
                          //   ),
                          // )
                          : CommonButtonRounded(
                            btnText:
                                bookAOrderController.intCurrentStep.value == 2
                                    ? "Submit"
                                    : "Next",
                            color: ColorConstant.clrSecondary,
                            onPressed: () async {
                              if (bookAOrderController.intCurrentStep.value ==
                                  0) {
                                if (bookAOrderController
                                    .bookAOrderFormKey
                                    .currentState!
                                    .validate()) {
                                  bookAOrderController.pageviewController
                                      .nextPage(
                                        duration: const Duration(
                                          milliseconds: 300,
                                        ),
                                        curve: Curves.easeInOut,
                                      );
                                }
                              } else if (bookAOrderController
                                      .intCurrentStep
                                      .value ==
                                  1) {
                                if (bookAOrderController
                                    .bookAOrderTwoFormKey
                                    .currentState!
                                    .validate()) {
                                  bookAOrderController.pageviewController
                                      .nextPage(
                                        duration: const Duration(
                                          milliseconds: 300,
                                        ),
                                        curve: Curves.easeInOut,
                                      );
                                }
                              } else {
                                // if (bookAOrderController
                                //     .bookAOrderThreeFormKey
                                //     .currentState!
                                //     .validate()) {
                                //   await bookAOrderController.createOrder((p0) {
                                //     log('Order Created Callback: $p0');
                                //   });
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
                                  bookAOrderController.intCurrentStep.value == 0
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
                                  bookAOrderController.intCurrentStep.value == 1
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
                                  bookAOrderController.intCurrentStep.value == 2
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
        controller: bookAOrderController.pageviewController,
        physics: const NeverScrollableScrollPhysics(),
        children: [BookAOrderOne(), BookAOrderTwo(), BookAOrderThree()],
        onPageChanged: (value) {
          bookAOrderController.intCurrentStep.value = value;
          bookAOrderController.intCurrentStep.refresh();
          setState(() {});
        },
      ),
    );
  }
}
