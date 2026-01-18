import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xpressfly_git/Common%20Components/common_textfield.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/image_constant.dart';
import 'package:xpressfly_git/Constants/text_style_constant.dart';
import 'package:xpressfly_git/Controller/book_a_order_controller.dart';
import 'package:xpressfly_git/Localization/localization_keys.dart';

class BookAOrderThree extends StatelessWidget {
  BookAOrderThree({super.key});

  final int selectedPayment = 0;
  final BookAOrderController bookAOrderController =
      Get.find<BookAOrderController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.clrF2FAFF,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: Form(
            key: bookAOrderController.bookAOrderThreeFormKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 10.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30.r),
                      bottomRight: Radius.circular(30.r),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        LocalizationKeys.choosePickupDateTime.tr,
                        style:
                            TextStyleConstant()
                                .subTitleTextStyle22w600Clr242424,
                      ),
                      SizedBox(height: 10.h),
                      CommonTextFormFieldWithoutBorder(
                        hintText: LocalizationKeys.selectDate.tr,
                        validator:
                            (p0) =>
                                p0 == null || p0.isEmpty
                                    ? LocalizationKeys.pleaseSelectPickupDate.tr
                                    : null,
                        controller:
                            bookAOrderController.orderPickUpDateController,
                        fillColor: ColorConstant.clrF7FCFF,
                        onTap: () {
                          bookAOrderController.selectPickUpDate(context);
                        },
                        readOnly: true,
                        suffixIcon: Icon(
                          Icons.calendar_month,
                          color: ColorConstant.clrSecondary,
                          size: 24.sp,
                        ),
                      ),
                      SizedBox(height: 5.h),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          LocalizationKeys.time.tr,
                          style:
                              TextStyleConstant()
                                  .subTitleTextStyle18w500Clr242424,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Obx(
                        () => ListView.builder(
                          shrinkWrap: true,
                          padding: EdgeInsets.all(0),
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: bookAOrderController.timeSlots.length,
                          itemBuilder: (context, index) {
                            final fromTimeController = bookAOrderController
                                .getFromTimeController(index);
                            final toTimeController = bookAOrderController
                                .getToTimeController(index);

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: CommonTextFormFieldWithoutBorder(
                                      hintText: LocalizationKeys.fromTime.tr,
                                      controller: fromTimeController,
                                      maxLines: 1,
                                      readOnly: true,
                                      fillColor: ColorConstant.clrF7FCFF,
                                      onTap: () {
                                        // Show time picker dialog
                                        showTimePicker(
                                          context: context,
                                          initialTime: TimeOfDay.now(),
                                          builder: (context, child) {
                                            return MediaQuery(
                                              data: MediaQuery.of(
                                                context,
                                              ).copyWith(
                                                alwaysUse24HourFormat: true,
                                              ),
                                              child: child!,
                                            );
                                          },
                                        ).then((pickedTime) {
                                          if (pickedTime != null) {
                                            String formattedTime =
                                                bookAOrderController
                                                    .formatTimeIn24Hour(
                                                      pickedTime,
                                                    );
                                            fromTimeController.text =
                                                formattedTime;
                                            bookAOrderController.updateTimeSlot(
                                              index,
                                              formattedTime,
                                              toTimeController.text,
                                            );
                                          }
                                        });
                                      },
                                      validator:
                                          (p0) =>
                                              p0 == null || p0.isEmpty
                                                  ? LocalizationKeys
                                                      .pleaseEnterFromTime
                                                      .tr
                                                  : null,
                                      onChanged: (value) {
                                        bookAOrderController.updateTimeSlot(
                                          index,
                                          value,
                                          bookAOrderController
                                                  .timeSlots[index]["to_time"] ??
                                              "",
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 9.w),
                                  Expanded(
                                    child: CommonTextFormFieldWithoutBorder(
                                      controller: toTimeController,
                                      hintText: LocalizationKeys.toTime.tr,
                                      maxLines: 1,
                                      readOnly: true,
                                      validator:
                                          (p0) =>
                                              p0 == null || p0.isEmpty
                                                  ? LocalizationKeys
                                                      .pleaseEnterToTime
                                                      .tr
                                                  : null,
                                      fillColor: ColorConstant.clrF7FCFF,
                                      onTap:
                                          () => showTimePicker(
                                            context: context,
                                            initialTime: TimeOfDay.now(),
                                            builder: (context, child) {
                                              return MediaQuery(
                                                data: MediaQuery.of(
                                                  context,
                                                ).copyWith(
                                                  alwaysUse24HourFormat: true,
                                                ),
                                                child: child!,
                                              );
                                            },
                                          ).then((pickedTime) {
                                            if (pickedTime != null) {
                                              String formattedTime =
                                                  bookAOrderController
                                                      .formatTimeIn24Hour(
                                                        pickedTime,
                                                      );
                                              toTimeController.text =
                                                  formattedTime;
                                              bookAOrderController
                                                  .updateTimeSlot(
                                                    index,
                                                    fromTimeController.text,
                                                    formattedTime,
                                                  );
                                            }
                                          }),

                                      // showTimePicker(
                                      //   context: context,
                                      //   initialTime: TimeOfDay.now(),
                                      // ).then((pickedTime) {
                                      //   if (pickedTime != null) {
                                      //     String formattedTime = pickedTime
                                      //         .format(context);
                                      //     toTimeController.text = formattedTime;
                                      //     bookAOrderController.updateTimeSlot(
                                      //       index,
                                      //       fromTimeController.text,
                                      //       formattedTime,
                                      //     );
                                      //   }
                                      // }),
                                      onChanged: (value) {
                                        bookAOrderController.updateTimeSlot(
                                          index,
                                          bookAOrderController
                                                  .timeSlots[index]["from_time"] ??
                                              "",
                                          value,
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(width: 9.w),
                                  if (index == 0)
                                    GestureDetector(
                                      onTap: () {
                                        bookAOrderController.addTimeSlot();
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(4.h),
                                        decoration: BoxDecoration(
                                          color: ColorConstant.clrSecondary,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.add,
                                          color: ColorConstant.clrWhite,
                                          size: 20.sp,
                                        ),
                                      ),
                                    )
                                  else
                                    GestureDetector(
                                      onTap: () {
                                        bookAOrderController.removeTimeSlot(
                                          index,
                                        );
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(4.h),
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.remove,
                                          color: ColorConstant.clrWhite,
                                          size: 20.sp,
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

                SizedBox(height: 16.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    LocalizationKeys.selectPaymentType.tr,
                    style: TextStyleConstant().subTitleTextStyle18w500Clr242424,
                  ),
                ),
                SizedBox(height: 14.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Row(
                    children: [
                      GestureDetector(
                        // onTap: () => setState(() => selectedPayment = 0),
                        child: Container(
                          padding: EdgeInsets.all(14.h),
                          decoration: BoxDecoration(
                            color: ColorConstant.clrF7FCFF,
                            borderRadius: BorderRadius.circular(16.r),
                            border: Border.all(
                              color: ColorConstant.clrEEEEEE,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Icon(
                                    selectedPayment == 0
                                        ? Icons.radio_button_checked
                                        : Icons.radio_button_off,
                                    color:
                                        selectedPayment == 0
                                            ? ColorConstant.clrSecondary
                                            : ColorConstant.clr242424,
                                  ),
                                  SizedBox(width: 8.w),
                                  Text(
                                    LocalizationKeys.payWithUpi.tr,
                                    style:
                                        TextStyleConstant()
                                            .subTitleTextStyle14w500Clr242424,
                                  ),
                                ],
                              ),
                              SizedBox(height: 6.h),
                              Text(
                                LocalizationKeys.fastSecurePayment.tr,
                                style:
                                    TextStyleConstant()
                                        .subTitleTextStyle12w400ClrSubText,
                              ),
                            ],
                          ),
                        ),
                      ),

                      // SizedBox(width: 10.w),
                      // Expanded(
                      //   child: GestureDetector(
                      //     onTap: () => setState(() => selectedPayment = 1),
                      //     child: Container(
                      //       padding: EdgeInsets.all(13.h),
                      //       decoration: BoxDecoration(
                      //         color: ColorConstant.clrF7FCFF,
                      //         borderRadius: BorderRadius.circular(16.r),
                      //         border: Border.all(
                      //           color: ColorConstant.clrEEEEEE,
                      //           width: 2,
                      //         ),
                      //       ),
                      //       child: Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           Row(
                      //             mainAxisAlignment: MainAxisAlignment.start,
                      //             crossAxisAlignment: CrossAxisAlignment.start,
                      //             children: [
                      //               Icon(
                      //                 selectedPayment == 1
                      //                     ? Icons.radio_button_checked
                      //                     : Icons.radio_button_off,
                      //                 color:
                      //                     selectedPayment == 1
                      //                         ? ColorConstant.clrSecondary
                      //                         : ColorConstant.clr242424,
                      //               ),
                      //               SizedBox(width: 7.w),
                      //               Text(
                      //                 "Cash On Delivery",
                      //                 maxLines: 2,
                      //                 style:
                      //                     TextStyleConstant()
                      //                         .subTitleTextStyle14w500Clr242424,
                      //               ),
                      //             ],
                      //           ),
                      //           SizedBox(height: 6.h),
                      //           Text(
                      //             "Pay in cash at delivery.\n₹10 platform fee applies.",
                      //             style:
                      //                 TextStyleConstant()
                      //                     .subTitleTextStyle12w400ClrSubText,
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

List<String> listImages = [
  ImageConstant.imgParcelOne,
  ImageConstant.imgParcelTwo,
  ImageConstant.imgParcelThree,
  ImageConstant.imgParcelFour,
  ImageConstant.imgParcelFive,
  ImageConstant.imgParcelFive,
];
