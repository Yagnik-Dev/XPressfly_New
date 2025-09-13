import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';

class TextStyleConstant {
  TextStyle titleTextStyle34w600 = GoogleFonts.lato(
    color: ColorConstant.clrPrimary,
    fontWeight: FontWeight.w600,
    fontSize: 34.sp,
  );
  TextStyle titleTextStyle34w600Clr242424 = GoogleFonts.lato(
    color: ColorConstant.clr242424,
    fontWeight: FontWeight.w600,
    fontSize: 34.sp,
  );
  TextStyle titleTextStyle26w600Clr242424 = GoogleFonts.lato(
    color: ColorConstant.clr242424,
    fontWeight: FontWeight.w600,
    fontSize: 26.sp,
  );
  TextStyle titleTextStyle20w600ClrWhite = GoogleFonts.lato(
    color: ColorConstant.clrWhite,
    fontWeight: FontWeight.w600,
    fontSize: 20.sp,
  );
  TextStyle subTitleTextStyle18w400 = GoogleFonts.lato(
    color: ColorConstant.clrSubText,
    fontWeight: FontWeight.w400,
    fontSize: 18.sp,
  );
  TextStyle subTitleTextStyle18w600 = GoogleFonts.lato(
    color: ColorConstant.clr242424,
    fontWeight: FontWeight.w600,
    fontSize: 18.sp,
  );
  TextStyle subTitleTextStyle14w600clr242424 = GoogleFonts.lato(
    color: ColorConstant.clr242424,
    fontWeight: FontWeight.w600,
    fontSize: 14.sp,
  );
  TextStyle subTitleTextStyle18w500 = GoogleFonts.lato(
    color: ColorConstant.clrBackGround,
    fontWeight: FontWeight.w500,
    fontSize: 18.sp,
  );
  TextStyle subTitleTextStyle40w600clrSecondary = GoogleFonts.lato(
    color: ColorConstant.clrSecondary,
    fontWeight: FontWeight.w600,
    fontSize: 40.sp,
  );
  TextStyle subTitleTextStyle16w500 = GoogleFonts.lato(
    color: ColorConstant.clrA2A2A2,
    fontWeight: FontWeight.w500,
    fontSize: 16.sp,
  );
  TextStyle subTitleTextStyle16w500ClrSubText = GoogleFonts.lato(
    color: ColorConstant.clrSubText,
    fontWeight: FontWeight.w500,
    fontSize: 16.sp,
  );
  TextStyle subTitleTextStyle14w500ClrSubText = GoogleFonts.lato(
    color: ColorConstant.clrSubText,
    fontWeight: FontWeight.w500,
    fontSize: 14.sp,
  );
  TextStyle subTitleTextStyle14w500ClrCCCCCC = GoogleFonts.lato(
    color: ColorConstant.clrCCCCCC,
    fontWeight: FontWeight.w500,
    fontSize: 14.sp,
  );
  TextStyle subTitleTextStyle16w500Clr242424 = GoogleFonts.lato(
    color: ColorConstant.clr242424,
    fontWeight: FontWeight.w500,
    fontSize: 16.sp,
  );
  TextStyle subTitleTextStyle20w500Clr242424 = GoogleFonts.lato(
    color: ColorConstant.clr242424,
    fontWeight: FontWeight.w500,
    fontSize: 20.sp,
  );
  TextStyle subTitleTextStyle18w600Clr242424 = GoogleFonts.lato(
    color: ColorConstant.clr242424,
    fontWeight: FontWeight.w600,
    fontSize: 18.sp,
  );
  TextStyle subTitleTextStyle26w600Clr242424 = GoogleFonts.lato(
    color: ColorConstant.clr242424,
    fontWeight: FontWeight.w600,
    fontSize: 26.sp,
  );
  TextStyle subTitleTextStyle16w500ClrD9C0C0 = GoogleFonts.lato(
    color: ColorConstant.clrD9C0C0,
    fontWeight: FontWeight.w500,
    fontSize: 16.sp,
  );
}

BoxDecoration commonBoxDecoration = BoxDecoration(
  color: Colors.white,
  boxShadow: [
    BoxShadow(blurRadius: 24, offset: Offset(10, 0), color: Colors.black12),
    BoxShadow(blurRadius: 24, offset: Offset(-10, 10), color: Colors.black12),
  ],
  borderRadius: BorderRadius.circular(20),
);
BoxDecoration commonBoxDecorationJoinAs = BoxDecoration(
  color: Colors.white,
  boxShadow: [
    BoxShadow(blurRadius: 20, offset: Offset(14, 0), color: Colors.black12),
    BoxShadow(blurRadius: 20, offset: Offset(-14, 14), color: Colors.black12),
  ],
  borderRadius: BorderRadius.circular(16),
);
