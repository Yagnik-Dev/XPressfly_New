import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/image_constant.dart';
import 'package:xpressfly_git/Constants/text_style_constant.dart';

Future<void> showErrorDialog(String title, String content) async {
  await Get.dialog(
    PopScope(
      canPop: true,
      child: AlertDialog(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
        backgroundColor: ColorConstant.clrPrimary,
        title: Text(title),
        content: Text(content),
        actions: [
          MaterialButton(
            child: const Text("OK"),
            onPressed: () {
              Get.back();
              Get.focusScope?.unfocus();
            },
          ),
        ],
      ),
    ),
    barrierDismissible: false,
  );
}

Future<bool> isInternetConnectivityEnabled() async {
  var connectivityResult = await Connectivity().checkConnectivity();

  // ignore: unrelated_type_equality_checks
  if (connectivityResult == ConnectivityResult.none) {
    return false;
  } else {
    return true;
  }
}

showLoading() {
  if (!(Get.isDialogOpen ?? false)) {
    Get.dialog(
      barrierDismissible: false,
      Center(
        child: Container(
          decoration: ShapeDecoration(
            color: ColorConstant.clrBackGround,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          width: 80,
          height: 80,
          padding: const EdgeInsets.all(10),
          child: Center(
            child: CircularProgressIndicator(color: ColorConstant.clrPrimary),
          ),
        ),
      ),
    );
  }
}

hideLoading() {
  if (Get.isDialogOpen!) {
    Get.back();
  }
}

Future showMessage(String title, String message) async {
  Get.closeAllSnackbars();
  Get.snackbar(
    title,
    message,
    snackPosition: SnackPosition.BOTTOM,
    duration: const Duration(milliseconds: 1200),
    margin: const EdgeInsets.all(8),
    backgroundColor: ColorConstant.clrPrimary,
    colorText: ColorConstant.clrBackGround,
  );
}

Future<dynamic> approvedDialog(
  // BuildContext context,
  String? title,
  String? message,
) {
  return Get.dialog(
    barrierColor: Colors.black.withOpacity(0.7),
    // context: context,
    // builder: (context) {
    SimpleDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
      backgroundColor: ColorConstant.clrBorder,
      children: [
        SizedBox(height: 20.h),
        Image.asset(ImageConstant.imgApproved, height: 48.h, width: 48.w),
        SizedBox(height: 10.h),
        Text(
          title ?? '',
          textAlign: TextAlign.center,
          style: TextStyleConstant().subTitleTextStyle22w600Clr242424,
        ),
        SizedBox(height: 12.h),
        Text(
          message ?? '',
          textAlign: TextAlign.center,
          style: TextStyleConstant().subTitleTextStyle18w400Clr242424,
        ),
        SizedBox(height: 20.h),
      ],
    ),
    // },
  );
}

Future<dynamic> declineDialog(
  // BuildContext context,
  String? title,
  String message,
) {
  return Get.dialog(
    // barrierColor: Colors.black.withOpacity(0.7),
    // context: context,
    // builder: (context) {
    SimpleDialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 20.w),
      contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
      backgroundColor: ColorConstant.clrBorder,
      children: [
        SizedBox(height: 20.h),
        Image.asset(ImageConstant.imgDeclined, height: 48.h, width: 48.w),
        SizedBox(height: 10.h),
        Text(
          title ?? '',
          textAlign: TextAlign.center,
          style: TextStyleConstant().subTitleTextStyle22w600Clr242424,
        ),
        SizedBox(height: 12.h),
        Text(
          message,
          textAlign: TextAlign.center,
          style: TextStyleConstant().subTitleTextStyle18w400Clr242424,
        ),
        SizedBox(height: 20.h),
      ],
    ),
    // },
  );
}
