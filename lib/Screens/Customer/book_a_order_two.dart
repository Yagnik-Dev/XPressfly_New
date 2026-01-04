import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:xpressfly_git/Common%20Components/common_textfield.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/text_style_constant.dart';
import 'package:xpressfly_git/Controller/book_a_order_controller.dart';

class BookAOrderTwo extends StatelessWidget {
  BookAOrderTwo({super.key});

  final BookAOrderController bookAOrderController =
      Get.find<BookAOrderController>();

  void _showImageSourceDialog() {
    Get.focusScope?.unfocus();
    showModalBottomSheet(
      context: Get.context!,
      backgroundColor: ColorConstant.clrWhite,
      builder:
          (context) => SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      Get.back();
                      bookAOrderController.pickImage(ImageSource.gallery);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: 25.r,
                          backgroundColor: ColorConstant.clrSecondary,
                          child: Icon(
                            Icons.photo_library,
                            color: ColorConstant.clrWhite,
                            size: 30.sp,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Gallery',
                          style:
                              TextStyleConstant()
                                  .subTitleTextStyle16w400clrSecondary,
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();
                      bookAOrderController.pickImage(ImageSource.camera);
                    },
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: 25.r,
                          backgroundColor: ColorConstant.clrSecondary,
                          child: Icon(
                            Icons.photo_camera,
                            color: ColorConstant.clrWhite,
                            size: 30.sp,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Camera',
                          style:
                              TextStyleConstant()
                                  .subTitleTextStyle16w400clrSecondary,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }

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
                width: double.infinity,
                padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 18.h),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(30.r),
                    bottomRight: Radius.circular(30.r),
                  ),
                ),
                child: Form(
                  key: bookAOrderController.bookAOrderTwoFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "What would you like to send?",
                        style:
                            TextStyleConstant()
                                .subTitleTextStyle22w600Clr242424,
                      ),
                      SizedBox(height: 10.h),
                      CommonTextFormFieldWithoutBorder(
                        hintText: "Title of the item",
                        controller: bookAOrderController.orderTitleController,
                        fillColor: ColorConstant.clrF7FCFF,
                        validator:
                            (p0) =>
                                p0 == null || p0.isEmpty
                                    ? 'Please enter order title'
                                    : null,
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        "Ex. Brown Sofa and Computer Table",
                        style:
                            TextStyleConstant()
                                .subTitleTextStyle12w400ClrSubText,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                "Select or upload image",
                style: TextStyleConstant().subTitleTextStyle22w600Clr242424,
              ),
              SizedBox(height: 5.h),
              Text(
                "Don't forget to pack your items before shipping",
                style: TextStyleConstant().subTitleTextStyle12w400ClrSubText,
              ),
              Obx(
                () => GridView.builder(
                  shrinkWrap: true,
                  itemCount: bookAOrderController.pickedImages.length + 1,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.only(
                    top: 14.h,
                    bottom: 0.h,
                    left: 20.w,
                    right: 20.w,
                  ),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 1.2,
                    crossAxisSpacing: 12.w,
                    mainAxisSpacing: 0.h,
                  ),
                  itemBuilder: (context, index) {
                    if (index == 0) {
                      // "Select Image" button
                      return GestureDetector(
                        onTap: () {
                          _showImageSourceDialog();
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 6.h, top: 6.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.file_upload_outlined,
                                color: ColorConstant.clrSecondary,
                                size: 40.sp,
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                "Select Image",
                                style:
                                    TextStyleConstant()
                                        .subTitleTextStyle16w600clrSecondary,
                              ),
                            ],
                          ),
                        ),
                      );
                    } else {
                      return Container(
                        margin: EdgeInsets.only(bottom: 6.h, top: 6.h),
                        padding: EdgeInsets.fromLTRB(0, 6.h, 6.w, 0),
                        alignment: Alignment.topRight,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.r),
                          // border: Border.all(
                          //   color: ColorConstant.clrSecondary,
                          //   width: 1.w,
                          // ),
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(
                              bookAOrderController.pickedImages[index - 1],
                            ),
                          ),
                        ),
                        child: GestureDetector(
                          onTap: () {
                            bookAOrderController.removeImage(index - 1);
                          },
                          child: Container(
                            padding: EdgeInsets.all(2.r),
                            decoration: BoxDecoration(
                              color: ColorConstant.clrSecondary,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 18.sp,
                            ),
                          ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
