import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:xpressfly_git/Common%20Components/common_textfield.dart';
import 'package:xpressfly_git/Common%20Components/places_autocomplete_field.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/image_constant.dart';
import 'package:xpressfly_git/Constants/storage_constant.dart';
import 'package:xpressfly_git/Constants/text_style_constant.dart';
import 'package:xpressfly_git/Controller/book_a_order_controller.dart';
import 'package:xpressfly_git/Screens/Driver/order_history_screen.dart';

class BookAOrderOne extends StatelessWidget {
  BookAOrderOne({super.key});

  final BookAOrderController bookAOrderController =
      Get.find<BookAOrderController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.clrF2FAFF,
      // Remove ResizeToAvoidBottomInset to work with adjustPan
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(), // Better for keyboard
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Padding(
          padding: EdgeInsets.only(bottom: 10.h),
          child: Form(
            key: bookAOrderController.bookAOrderFormKey,
            child: Column(
              children: [
                // Wrap heavy widgets in RepaintBoundary
                RepaintBoundary(child: _buildLocationSection()),
                SizedBox(height: 20.h),
                RepaintBoundary(child: _buildOrderDetailsSection()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Separate location section to reduce rebuilds
  Widget _buildLocationSection() {
    return Container(
      padding: EdgeInsets.fromLTRB(20.w, 10.h, 20.w, 18.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(30.r),
          bottomRight: Radius.circular(30.r),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Separate icon column
          _buildLocationIcons(),
          SizedBox(width: 14.w),
          // Text fields
          Expanded(
            child: Column(
              children: [
                GooglePlacesTextField(
                  controller: bookAOrderController.pickUpPinCodeController,
                  hintText: "Enter Pickup Location with Pin-code",
                  fillColor: ColorConstant.clrF7FCFF,
                  onPlaceSelected: (placeDetails) {
                    bookAOrderController.onPickupLocationSelected(placeDetails);
                  },
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return 'Please enter pickup location';
                    } else if (p0.length < 6 || p0.length > 9) {
                      return 'ZIP code must be 6 to 9 characters';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 12.h),
                GooglePlacesTextField(
                  controller: bookAOrderController.dropOffPinCodeController,
                  hintText: "Enter Drop Location with Pin-code",
                  fillColor: ColorConstant.clrF7FCFF,
                  onPlaceSelected: (placeDetails) {
                    bookAOrderController.onDropoffLocationSelected(
                      placeDetails,
                    );
                  },
                  validator: (p0) {
                    if (p0 == null || p0.isEmpty) {
                      return 'Please enter drop location';
                    } else if (p0.length < 6 || p0.length > 9) {
                      return 'ZIP code must be 6 to 9 characters';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Extract icon column as separate widget
  Widget _buildLocationIcons() {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: ColorConstant.clrF7FCFF,
            shape: BoxShape.circle,
            border: Border.all(color: ColorConstant.clrEEEEEE, width: 2),
          ),
          child: Icon(
            Icons.arrow_circle_down,
            color: ColorConstant.clrSecondary,
            size: 20.w,
          ),
        ),
        SizedBox(height: 6.h),
        DashedLineVertical(
          height: 30.h,
          dashHeight: 3.h,
          dashGap: 4.h,
          color: ColorConstant.clrSubText,
          strokeWidth: 1.w,
        ),
        SizedBox(height: 6.h),
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: ColorConstant.clrF7FCFF,
            shape: BoxShape.circle,
            border: Border.all(color: ColorConstant.clrEEEEEE, width: 2),
          ),
          child: Icon(
            Icons.location_on,
            color: ColorConstant.clrSecondary,
            size: 20.w,
          ),
        ),
      ],
    );
  }

  // Separate order details section
  Widget _buildOrderDetailsSection() {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        Container(
          margin: EdgeInsets.only(top: 65.h),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(20.w, 74.h, 20.w, 30.h),
            child: Column(
              children: [
                Text(
                  "Order Details",
                  style: TextStyleConstant().subTitleTextStyle22w600Clr242424,
                ),
                SizedBox(height: 20.h),
                _buildReceiverSection(),
                SizedBox(height: 15.h),
                _buildSenderSection(),
                SizedBox(height: 15.h),
                _buildWeightSection(),
              ],
            ),
          ),
        ),
        // Box image
        Positioned(
          child: InkWell(
            onTap: () {
              bookAOrderController.testGooglePlacesAPI();
            },
            child: Image.asset(
              ImageConstant.imgBox,
              height: 130.h,
              // Add these for better performance
              cacheWidth:
                  (130 * WidgetsBinding.instance.window.devicePixelRatio)
                      .toInt(),
              filterQuality: FilterQuality.medium,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReceiverSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Receiver Name & Mobile no.",
          style: TextStyleConstant().subTitleTextStyle16w500Clr242424,
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Expanded(
              child: CommonTextFormFieldWithoutBorder(
                controller: bookAOrderController.receiverNameController,
                hintText: "ex. Rohit Shah",
                fillColor: ColorConstant.clrF7FCFF,
                validator:
                    (p0) =>
                        p0 == null || p0.isEmpty
                            ? 'Please enter receiver name'
                            : null,
              ),
            ),
            SizedBox(width: 9.w),
            Expanded(
              child: CommonTextFormFieldWithoutBorder(
                controller: bookAOrderController.receiverMobileNoController,
                hintText: "ex. 98765 43210",
                maxLines: 1,
                maxLength: 10,
                keyboardType: TextInputType.phone,
                fillColor: ColorConstant.clrF7FCFF,
                validator:
                    (p0) =>
                        p0 == null || p0.isEmpty
                            ? 'Please enter receiver mobile no.'
                            : null,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSenderSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Sender Name & Mobile no.",
          style: TextStyleConstant().subTitleTextStyle16w500Clr242424,
        ),
        SizedBox(height: 8.h),
        Row(
          children: [
            Expanded(
              child: CommonTextFormFieldWithoutBorder(
                controller: TextEditingController(
                  text: GetStorage().read(userName) ?? '',
                ),
                readOnly: true,
                hintText: "ex. Mohit Shah",
                fillColor: ColorConstant.clrF7FCFF,
              ),
            ),
            SizedBox(width: 10.w),
            Expanded(
              child: CommonTextFormFieldWithoutBorder(
                controller: TextEditingController(
                  text: GetStorage().read(userPhone) ?? '',
                ),
                readOnly: true,
                hintText: "ex. 98765 43210",
                fillColor: ColorConstant.clrF7FCFF,
                maxLines: 1,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWeightSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Approx Weight of Your Items",
          style: TextStyleConstant().subTitleTextStyle16w500Clr242424,
        ),
        SizedBox(height: 8.h),
        CommonTextFormFieldWithoutBorder(
          hintText: "ex. 15-20 kg Simple table",
          controller: bookAOrderController.orderWeightController,
          fillColor: ColorConstant.clrF7FCFF,
          keyboardType: TextInputType.number,
          validator:
              (p0) =>
                  p0 == null || p0.isEmpty ? 'Please enter order weight' : null,
        ),
      ],
    );
  }
}
