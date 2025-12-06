import 'dart:io';
import 'package:dio/src/form_data.dart' as formdata;
import 'package:dio/src/multipart_file.dart' as multipart_file;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xpressfly_git/Common%20Components/common_button.dart';
import 'package:xpressfly_git/Common%20Components/common_textfield.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/image_constant.dart';
import 'package:xpressfly_git/Constants/text_style_constant.dart';
import 'package:xpressfly_git/Controller/bank_detail_controller.dart';
import 'package:xpressfly_git/Screens/AuthScreens/device_info_details.dart';
import 'package:xpressfly_git/Utility/app_utility.dart';

class BankDetailsScreen extends StatelessWidget {
  final int type;
  final String? mobileNo;
  final String? otp;
  final String? name;
  final String? city;
  final String? pincode;
  final File aadharFrontImg;
  final File aadharBackImg;
  final File licenseFrontImg;
  final File licenseBackImg;

  BankDetailsScreen({
    super.key,
    required this.type,
    this.mobileNo,
    this.otp,
    this.name,
    this.city,
    this.pincode,
    required this.aadharFrontImg,
    required this.aadharBackImg,
    required this.licenseFrontImg,
    required this.licenseBackImg,
  });

  final BankDetailController bankDetailController = Get.put(
    BankDetailController(),
  );

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        dividerTheme: DividerThemeData(color: Colors.transparent),
      ),
      child: Scaffold(
        backgroundColor: ColorConstant.clrF7FCFF,
        appBar: AppBar(
          backgroundColor: ColorConstant.clrF7FCFF,
          centerTitle: true,
          elevation: 0,
          leadingWidth: 70.w,
          leading: InkWell(
            onTap: () => Get.back(),
            child: Padding(
              padding: EdgeInsets.only(left: 16.w),
              child: Container(
                height: 50.w,
                width: 50.w,
                decoration: BoxDecoration(
                  color: ColorConstant.clrWhite,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_back,
                  color: ColorConstant.clrPrimary,
                  size: 30.sp,
                ),
              ),
            ),
          ),
          automaticallyImplyLeading: false,
          title: Text(
            "Your Bank Details",
            style: TextStyleConstant().titleTextStyle26w600Clr242424,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(28),
              bottomRight: Radius.circular(28),
            ),
          ),
        ),
        persistentFooterButtons: [
          Padding(
            padding: EdgeInsets.fromLTRB(11.w, 4.h, 11.w, 13.h),
            child: CommonButton(
              color: ColorConstant.clrSecondary,
              radius: 50.sp,
              btnText: "Save Details",
              onPressed: () async {
                // if (bankDetailController.bankDetailFormKey.currentState!
                //     .validate()) {
                deviceInfo = await getDeviceInfo();
                var formData = formdata.FormData.fromMap({
                  "phone": mobileNo,
                  // "otp": otp,
                  "name": name,
                  "city": city,
                  "pincode": pincode,
                  "device_fcm_token":
                      "c_-jq5UPIwCQilLKVuWtgf:APA91bFG4hy_yuIW2OidJLe7CCWWtM6u5hMolcMcXATwrUDTv9nzq4fd5NnA97vyEtb9VnzS4l7CmEtwDQQRLoBKoUVtceb9OyUb7iWjEbeQs6RKgGV2w74",
                  "device_id": deviceInfo["deviceId"],
                  "device_name": deviceInfo["deviceName"],
                  "device_type": deviceInfo["deviceType"],
                  "is_duty_on": "",
                  "bank_account_number":
                      bankDetailController.bankAccountNumberController.text,
                  "bank_account_holder_name":
                      bankDetailController.bankAccountNameController.text,
                  "bank_ifsc": bankDetailController.bankIFSCController.text,
                  // "profile_image": "",
                  "email": "user@gmail.com",
                  "address": "surat",
                  // "adhar_card_front": aadharFrontImg.path,
                  // "adhar_card_back": aadharBackImg.path,
                  // "driver_license_front": licenseFrontImg.path,
                  // "driver_license_back": licenseBackImg.path,
                });
                formData.files.add(
                  MapEntry(
                    "profile_image",
                    multipart_file.MultipartFile.fromFileSync(
                      aadharFrontImg.path,
                      filename: aadharFrontImg.path.split('/').last,
                    ),
                  ),
                );
                formData.files.add(
                  MapEntry(
                    "adhar_card_front",
                    multipart_file.MultipartFile.fromFileSync(
                      aadharFrontImg.path,
                      filename: aadharFrontImg.path.split('/').last,
                    ),
                  ),
                );
                formData.files.add(
                  MapEntry(
                    "adhar_card_front",
                    multipart_file.MultipartFile.fromFileSync(
                      aadharFrontImg.path,
                      filename: aadharFrontImg.path.split('/').last,
                    ),
                  ),
                );

                formData.files.add(
                  MapEntry(
                    "adhar_card_back",
                    multipart_file.MultipartFile.fromFileSync(
                      aadharBackImg.path,
                      filename: aadharBackImg.path.split('/').last,
                    ),
                  ),
                );

                formData.files.add(
                  MapEntry(
                    "driver_license_front",
                    multipart_file.MultipartFile.fromFileSync(
                      licenseFrontImg.path,
                      filename: licenseFrontImg.path.split('/').last,
                    ),
                  ),
                );

                formData.files.add(
                  MapEntry(
                    "driver_license_back",
                    multipart_file.MultipartFile.fromFileSync(
                      licenseBackImg.path,
                      filename: licenseBackImg.path.split('/').last,
                    ),
                  ),
                );

                await bankDetailController.createDriverApiCall((isSuccess) {
                  if (isSuccess) {
                    showMessage("Success", "Bank details saved successfully");
                  }
                }, details: formData);
                // }
              },
            ),
          ),
        ],
        body: Stack(
          children: [
            Positioned(
              top: 150.h,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 18.w),
                decoration: BoxDecoration(
                  color: ColorConstant.clrWhite,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r),
                  ),
                ),
                child: Column(
                  children: [
                    /// SCROLLABLE CONTENT
                    ///
                    SizedBox(height: 70.h),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Bank Account Number",
                              style:
                                  TextStyleConstant()
                                      .subTitleTextStyle16w500ClrSubText,
                            ),
                            SizedBox(height: 6.h),
                            CommonTextFormFieldWithoutBorder(
                              controller:
                                  bankDetailController
                                      .bankAccountNumberController,
                            ),
                            SizedBox(height: 16.h),

                            Text(
                              "Bank Account Name",
                              style:
                                  TextStyleConstant()
                                      .subTitleTextStyle16w500ClrSubText,
                            ),
                            SizedBox(height: 6.h),
                            CommonTextFormFieldWithoutBorder(
                              controller:
                                  bankDetailController
                                      .bankAccountNameController,
                            ),
                            SizedBox(height: 16.h),

                            Text(
                              "IFSC Code",
                              style:
                                  TextStyleConstant()
                                      .subTitleTextStyle16w500ClrSubText,
                            ),
                            SizedBox(height: 6.h),
                            CommonTextFormFieldWithoutBorder(
                              controller:
                                  bankDetailController.bankIFSCController,
                              maxLength: 11,
                              validator: (p0) {
                                if (p0 == null || p0.isEmpty) {
                                  return 'Please enter IFSC Code';
                                }
                                if (p0.length != 11) {
                                  return 'IFSC Code must be 11 characters';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.number,
                            ),

                            SizedBox(height: 20.h),
                          ],
                        ),
                      ),
                    ),

                    /// FIXED BOTTOM BUTTON
                    // Padding(
                    //   padding: EdgeInsets.only(bottom: 20.h, top: 10.h),
                    //   child: CommonButton(
                    //     color: ColorConstant.clrSecondary,
                    //     radius: 50.sp,
                    //     btnText: "Save Details",
                    //     onPressed: () async {
                    //       // if (bankDetailController.bankDetailFormKey.currentState!
                    //       //     .validate()) {
                    //       deviceInfo = await getDeviceInfo();
                    //       var formData = formdata.FormData.fromMap({
                    //         "phone": mobileNo,
                    //         // "otp": otp,
                    //         "name": name,
                    //         "city": city,
                    //         "pincode": pincode,
                    //         "device_fcm_token":
                    //             "c_-jq5UPIwCQilLKVuWtgf:APA91bFG4hy_yuIW2OidJLe7CCWWtM6u5hMolcMcXATwrUDTv9nzq4fd5NnA97vyEtb9VnzS4l7CmEtwDQQRLoBKoUVtceb9OyUb7iWjEbeQs6RKgGV2w74",
                    //         "device_id": deviceInfo["deviceId"],
                    //         "device_name": deviceInfo["deviceName"],
                    //         "device_type": deviceInfo["deviceType"],
                    //         "is_duty_on": "",
                    //         "bank_account_number":
                    //             bankDetailController
                    //                 .bankAccountNumberController
                    //                 .text,
                    //         "bank_account_holder_name":
                    //             bankDetailController
                    //                 .bankAccountNameController
                    //                 .text,
                    //         "bank_ifsc":
                    //             bankDetailController.bankIFSCController.text,
                    //         // "profile_image": "",
                    //         "email": "user@gmail.com",
                    //         "address": "surat",
                    //         // "adhar_card_front": aadharFrontImg.path,
                    //         // "adhar_card_back": aadharBackImg.path,
                    //         // "driver_license_front": licenseFrontImg.path,
                    //         // "driver_license_back": licenseBackImg.path,
                    //       });
                    //       formData.files.add(
                    //         MapEntry(
                    //           "profile_image",
                    //           multipart_file.MultipartFile.fromFileSync(
                    //             aadharFrontImg.path,
                    //             filename: aadharFrontImg.path.split('/').last,
                    //           ),
                    //         ),
                    //       );
                    //       formData.files.add(
                    //         MapEntry(
                    //           "adhar_card_front",
                    //           multipart_file.MultipartFile.fromFileSync(
                    //             aadharFrontImg.path,
                    //             filename: aadharFrontImg.path.split('/').last,
                    //           ),
                    //         ),
                    //       );
                    //       formData.files.add(
                    //         MapEntry(
                    //           "adhar_card_front",
                    //           multipart_file.MultipartFile.fromFileSync(
                    //             aadharFrontImg.path,
                    //             filename: aadharFrontImg.path.split('/').last,
                    //           ),
                    //         ),
                    //       );

                    //       formData.files.add(
                    //         MapEntry(
                    //           "adhar_card_back",
                    //           multipart_file.MultipartFile.fromFileSync(
                    //             aadharBackImg.path,
                    //             filename: aadharBackImg.path.split('/').last,
                    //           ),
                    //         ),
                    //       );

                    //       formData.files.add(
                    //         MapEntry(
                    //           "driver_license_front",
                    //           multipart_file.MultipartFile.fromFileSync(
                    //             licenseFrontImg.path,
                    //             filename: licenseFrontImg.path.split('/').last,
                    //           ),
                    //         ),
                    //       );

                    //       formData.files.add(
                    //         MapEntry(
                    //           "driver_license_back",
                    //           multipart_file.MultipartFile.fromFileSync(
                    //             licenseBackImg.path,
                    //             filename: licenseBackImg.path.split('/').last,
                    //           ),
                    //         ),
                    //       );

                    //       await bankDetailController.createDriverApiCall((
                    //         isSuccess,
                    //       ) {
                    //         if (isSuccess) {
                    //           showMessage(
                    //             "Success",
                    //             "Bank details saved successfully",
                    //           );
                    //         }
                    //       }, details: formData);
                    //       // }
                    //     },
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 20.h,
              left: 0,
              right: 0,
              child: Center(
                child: Image.asset(
                  ImageConstant.imgBankDetails,
                  height: 180.h,
                  width: 220.w,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
