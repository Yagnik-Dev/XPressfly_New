import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/image_constant.dart';

class CustomBottomBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const CustomBottomBar({
    super.key,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
        color: ColorConstant.clrBottomBarBackground,
        borderRadius: BorderRadius.circular(50.r),
      ),
      margin: const EdgeInsets.all(16),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildNavItem(ImageConstant.imgHomeBottom, 0),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            // child: _buildNavItem(ImageConstant.imgParcelBottom, 1),
            child: _buildNavItem(ImageConstant.imgTrackOrder, 1),
          ),
          Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: _buildNavItem(ImageConstant.imgHistoryBottom, 2),
          ),
          _buildNavItem(ImageConstant.imgProfileBottom, 3),
        ],
      ),
    );
  }

  Widget _buildNavItem(String asset, int index) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        padding: EdgeInsets.all(12.sp),
        // margin: EdgeInsets.symmetric(horizontal: 10.w),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color:
              selectedIndex == index
                  ? ColorConstant.clrFFFAFA
                  : ColorConstant.clrBottomBarItemBackground,
        ),
        child: SvgPicture.asset(
          asset,
          colorFilter: ColorFilter.mode(
            selectedIndex == index
                ? ColorConstant.clrBottomBarBackground
                : ColorConstant.clrBottomBarItemColor,
            BlendMode.srcIn,
          ),
          // size: 26,
          height: 20.h,
        ),
      ),
    );
  }
}
