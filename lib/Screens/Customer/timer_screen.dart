import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xpressfly_git/Constants/image_constant.dart';
import 'package:xpressfly_git/Constants/text_style_constant.dart';

class WaitForResponseTimerScreen extends StatelessWidget {
  const WaitForResponseTimerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Image.asset(ImageConstant.imgTimer, height: 200.h),
                Text(
                  "07:40:47",
                  style: TextStyleConstant().subTitleTextStyle35w700clr242424,
                ),
              ],
            ),
            SizedBox(height: 24.h),
            Text(
              "Almost there",
              style: TextStyleConstant().subTitleTextStyle25w700clr242424,
            ),
            SizedBox(height: 8.h),

            Text(
              "Looking for nearby drivers…\nYou’ll be redirected once your request is accepted.",
              textAlign: TextAlign.center,
              style: TextStyleConstant().subTitleTextStyle14w400ClrSubText,
            ),
          ],
        ),
      ),
    );
  }
}
