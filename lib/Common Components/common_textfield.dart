import 'dart:ffi';

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
  final Color? fillColor;
  final Widget? suffixIcon;
  final double? letterSpacing;
  final TextAlign textAlign;
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
    this.suffixIcon,
    this.letterSpacing,
    this.textAlign = TextAlign.start,
    this.controller,
    this.hintText,
    this.maxLength,
    this.validator,
    this.fillColor,
    // this.buildCounter,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      cursorColor: ColorConstant.clrPrimary,
      style: TextStyle(
        color: ColorConstant.clrPrimary,
        letterSpacing: letterSpacing,
      ),
      maxLength: maxLength,
      validator: validator,
      textAlign: textAlign,
      // buildCounter: buildCounter,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        counterText: '',
        fillColor: fillColor ?? ColorConstant.clrBackGround,
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
          borderSide: BorderSide(width: 1, color: ColorConstant.clrError),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(18.r)),
          borderSide: BorderSide(width: 1, color: ColorConstant.clrBorder),
        ),
      ),
    );
  }
}

class CommonTextFormFieldWithoutBorder extends StatelessWidget {
  final TextInputType? keyboardType;
  final int? maxLength;
  final int? maxLines;
  final String? hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final Widget? prefixIcon;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final bool? readOnly;
  final Widget? suffixIcon;
  final Color? fillColor;

  const CommonTextFormFieldWithoutBorder({
    super.key,
    this.keyboardType,
    this.controller,
    this.hintText,
    this.maxLength,
    this.maxLines,
    this.validator,
    this.prefixIcon,
    this.onTap,
    this.onChanged,
    this.readOnly,
    this.suffixIcon,
    this.fillColor,
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
      maxLines: maxLines,
      readOnly: readOnly ?? false,
      onTap: onTap,
      onChanged: onChanged,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        counterText: '',
        fillColor: fillColor ?? ColorConstant.clrWhite,
        filled: true,
        contentPadding: EdgeInsetsDirectional.symmetric(
          vertical: 14.h,
          horizontal: 17.w,
        ),
        isDense: true,
        isCollapsed: true,
        suffixIcon: suffixIcon,
        hintStyle: TextStyleConstant().subTitleTextStyle16w500,
        hintText: hintText,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
          borderSide: BorderSide(width: 1, color: ColorConstant.clrEEEEEE),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
          borderSide: BorderSide(width: 1, color: ColorConstant.clrEEEEEE),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
          borderSide: BorderSide(width: 1, color: ColorConstant.clrEEEEEE),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
          borderSide: BorderSide(width: 1, color: ColorConstant.clrError),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10.r)),
          borderSide: BorderSide(width: 1, color: ColorConstant.clrEEEEEE),
        ),
      ),
    );
  }
}
