import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xpressfly_git/Common%20Components/common_textfield.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/image_constant.dart';
import 'package:xpressfly_git/Constants/text_style_constant.dart';

class BookAOrderTwo extends StatefulWidget {
  const BookAOrderTwo({super.key});

  @override
  State<BookAOrderTwo> createState() => _BookAOrderTwoState();
}

class _BookAOrderTwoState extends State<BookAOrderTwo> {
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "What would you like to send?",
                      style:
                          TextStyleConstant().subTitleTextStyle22w600Clr242424,
                    ),
                    SizedBox(height: 10.h),
                    CommonTextFormFieldWithoutBorder(
                      hintText: "Title of the item",
                      fillColor: ColorConstant.clrF7FCFF,
                    ),
                    SizedBox(height: 5.h),

                    Text(
                      "Ex. Brown Sofa and Computer Table",
                      style:
                          TextStyleConstant().subTitleTextStyle12w400ClrSubText,
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16.h),
              Text(
                "Select or upload image",
                style: TextStyleConstant().subTitleTextStyle22w600Clr242424,
              ),
              SizedBox(height: 5.h),

              Text(
                "Don’t forget to pack your items before shipping",
                style: TextStyleConstant().subTitleTextStyle12w400ClrSubText,
              ),
              GridView.builder(
                shrinkWrap: true,
                itemCount: listImages.length,
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
                        // Add your image picker logic here
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
                    // Show images
                    return Image.asset(
                      listImages[index - 1],
                      fit: BoxFit.contain,
                    );
                  }
                },
              ),
            ],
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
