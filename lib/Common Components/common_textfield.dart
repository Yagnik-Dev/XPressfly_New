import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/text_style_constant.dart';

class CommonTextFormField extends StatelessWidget {
  final TextInputType? keyboardType;
  final int? maxLength;
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  // final Widget? Function(
  //   BuildContext, {
  //   int? currentLength,
  //   bool? isFocused,
  //   int? maxLength,
  // })?
  // buildCounter;

  const CommonTextFormField({
    super.key,
    this.keyboardType,
    this.controller,
    this.hintText,
    this.maxLength,
    this.validator,
    // this.buildCounter,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      cursorColor: ColorConstant.clrPrimary,
      style: TextStyle(color: ColorConstant.clrPrimary),
      maxLength: maxLength,
      validator: validator,
      // buildCounter: buildCounter,
      decoration: InputDecoration(
        counterText: '',
        fillColor: ColorConstant.clrBackGround,
        filled: true,
        contentPadding: EdgeInsetsDirectional.symmetric(
          vertical: 16.h,
          horizontal: 17.w,
        ),
        isDense: true,
        isCollapsed: true,
        hintStyle: TextStyleConstant().subTitleTextStyle16w500,
        hintText: hintText,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(18.r)),
          borderSide: BorderSide(width: 1, color: ColorConstant.clrBorder),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(18.r)),
          borderSide: BorderSide(width: 1, color: ColorConstant.clrBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(18.r)),
          borderSide: BorderSide(width: 1, color: ColorConstant.clrBorder),
        ),
        // border: OutlineInputBorder(
        //   borderRadius: BorderRadius.all(Radius.circular(15)),
        //   // borderSide: BorderSide(width: 1),
        // ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(18.r)),
          borderSide: BorderSide(width: 1.1, color: ColorConstant.clrError),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(18.r)),
          borderSide: BorderSide(width: 1, color: ColorConstant.clrBorder),
        ),
      ),
    );
  }
}

// class CommonTextFormFieldWithoutBorder extends StatelessWidget {
//   final TextInputType? keyboardType;
//   final int? maxLength;
//   final String? hintText;
//   final TextEditingController? controller;
//   final String? Function(String?)? validator;
//   final Widget? Function(
//     BuildContext, {
//     int? currentLength,
//     bool? isFocused,
//     int? maxLength,
//   })?
//   buildCounter;
//   final int? maxLines;
//   final bool? readOnly;
//   final void Function()? onTap;

//   const CommonTextFormFieldWithoutBorder({
//     super.key,
//     this.keyboardType,
//     this.controller,
//     this.hintText,
//     this.maxLength,
//     this.validator,
//     this.buildCounter,
//     this.maxLines,
//     this.readOnly,
//     this.onTap,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       keyboardType: keyboardType,
//       cursorColor: ColorConstant.clrPrimary,
//       style: TextStyle(color: ColorConstant.clrPrimary),
//       maxLength: maxLength,
//       validator: validator,
//       buildCounter: buildCounter,
//       maxLines: maxLines,
//       readOnly: readOnly ?? false,
//       onTap: onTap,
//       decoration: InputDecoration(
//         counterText: '',
//         fillColor: ColorConstant.clrPrimary,

//         filled: true,
//         contentPadding: EdgeInsetsDirectional.symmetric(
//           vertical: 14.h,
//           horizontal: 17.w,
//         ),
//         hintStyle: TextStyle(
//           fontFamily: FontConstant.fontFamilyRegular,
//           color: ColorConstant.clrSubText,
//         ),
//         hintText: hintText,
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(15)),
//           borderSide: BorderSide(width: 1, color: Colors.transparent),
//         ),
//         disabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(15)),
//           borderSide: BorderSide(width: 1, color: Colors.transparent),
//         ),
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(15)),
//           borderSide: BorderSide(width: 1, color: Colors.transparent),
//         ),
//         border: OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(15)),
//           borderSide: BorderSide(width: 1, color: Colors.transparent),
//         ),
//         errorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(15)),
//           borderSide: BorderSide(width: 1, color: Colors.transparent),
//         ),
//         focusedErrorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.all(Radius.circular(15)),
//           borderSide: BorderSide(width: 1, color: Colors.transparent),
//         ),
//       ),
//     );
//   }
// }
