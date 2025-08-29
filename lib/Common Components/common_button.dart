import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/text_style_constant.dart';

class CommonButton extends StatelessWidget {
  final String btnText;
  final void Function()? onPressed;
  final Color? color;
  const CommonButton({
    super.key,
    required this.btnText,
    required this.onPressed,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(
            color ?? ColorConstant.clrPrimary,
          ),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(18.sp)),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          btnText,
          style: TextStyleConstant().subTitleTextStyle18w500,
        ),
      ),
    );
  }
}
