import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/text_style_constant.dart';
import 'package:xpressfly_git/Controller/metadata_controller.dart';

class MetadataScreen extends StatelessWidget {
  MetadataScreen({super.key});

  final MetadataController metadataController = Get.put(MetadataController());

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      initialIndex: Get.find<MetadataController>().selectedTabIndex.value,
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
            "Xpressfly",
            style: TextStyleConstant().titleTextStyle26w600Clr242424,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(28),
              bottomRight: Radius.circular(28),
            ),
          ),
        ),
        body: Column(
          children: [
            TabBar(
              labelPadding: EdgeInsets.symmetric(vertical: 10.h),
              dividerColor: Colors.transparent,
              indicatorColor: ColorConstant.clr242424,
              onTap: (value) {
                metadataController.changeTabIndex(value);
              },
              tabs: [
                Text(
                  "Terms & Conditions",
                  style: TextStyleConstant().subTitleTextStyle16w600Clr242424,
                ),
                Text(
                  "Privacy Policy",
                  style: TextStyleConstant().subTitleTextStyle16w600Clr242424,
                ),
              ],
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: Obx(
                () => TabBarView(
                  children: [
                    Center(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(8.0.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${index + 1}. ${metadataController.termsAndConditions.value.data?[index].title ?? ""}",
                                  style:
                                      TextStyleConstant()
                                          .subTitleTextStyle16w600Clr242424,
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  metadataController
                                          .termsAndConditions
                                          .value
                                          .data?[index]
                                          .description ??
                                      "",
                                  style:
                                      TextStyleConstant()
                                          .subTitleTextStyle14w400Clr242424,
                                ),
                              ],
                            ),
                          );
                        },
                        itemCount:
                            metadataController
                                .termsAndConditions
                                .value
                                .data
                                ?.length ??
                            0,
                      ),
                    ),
                    Center(
                      child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.all(8.0.w),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${index + 1}. ${metadataController.privacyPolicy.value.data?[index].title ?? ""}",
                                  style:
                                      TextStyleConstant()
                                          .subTitleTextStyle16w600Clr242424,
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  metadataController
                                          .privacyPolicy
                                          .value
                                          .data?[index]
                                          .description ??
                                      "",
                                  style:
                                      TextStyleConstant()
                                          .subTitleTextStyle14w400Clr242424,
                                ),
                              ],
                            ),
                          );
                        },
                        itemCount:
                            metadataController
                                .privacyPolicy
                                .value
                                .data
                                ?.length ??
                            0,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
