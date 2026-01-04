import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:xpressfly_git/Constants/color_constant.dart';
import 'package:xpressfly_git/Constants/image_constant.dart';
import 'package:xpressfly_git/Utility/common_imports.dart';

import '../../Constants/text_style_constant.dart';

class SwipeToAcceptButton extends StatefulWidget {
  final VoidCallback onAccept;

  const SwipeToAcceptButton({super.key, required this.onAccept});

  @override
  State<SwipeToAcceptButton> createState() => _SwipeToAcceptButtonState();
}

class _SwipeToAcceptButtonState extends State<SwipeToAcceptButton> {
  double dragX = 0;
  final double maxDrag = 180;
  bool isAccepted = false;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final maxWidth = constraints.maxWidth;
        return Container(
          height: 46.h,
          decoration: BoxDecoration(
            color: ColorConstant.clrF7FCFF,
            borderRadius: BorderRadius.circular(50),
          ),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 120),
                width:
                    isAccepted
                        ? maxWidth
                        : (dragX + 46.h).clamp(0, maxWidth),
                decoration: BoxDecoration(
                  color:
                      (dragX > 0 || isAccepted)
                          ? ColorConstant.clrSecondary
                          : Colors.transparent,
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
              Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  child:
                      isAccepted
                          ? Row(
                            key: const ValueKey("accepted"),
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(
                                Icons.check_circle,
                                color: Colors.white,
                                size: 20,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                "Accepted",
                                style: TextStyleConstant()
                                    .subTitleTextStyle14w400Clr242424
                                    .copyWith(color: Colors.white),
                              ),
                            ],
                          )
                          : Padding(
                            key: const ValueKey("default"),
                            padding: EdgeInsets.only(left: 60.w),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Swipe to Accept",
                                style:
                                    TextStyleConstant()
                                        .subTitleTextStyle14w600Clr008000,
                              ),
                            ),
                          ),
                ),
              ),
              if (!isAccepted)
                Positioned(
                  left: dragX,
                  child: GestureDetector(
                    onHorizontalDragUpdate: (details) {
                      setState(() {
                        dragX += details.delta.dx;
                        dragX = dragX.clamp(0, maxDrag);
                      });
                    },
                    onHorizontalDragEnd: (_) {
                      if (dragX >= maxDrag - 10) {
                        _onAccepted();
                      } else {
                        setState(() => dragX = 0);
                      }
                    },
                    child: _sliderThumb(),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

  void _onAccepted() async {
    setState(() {
      isAccepted = true;
      dragX = maxDrag;
    });

    widget.onAccept();
  }

  Widget _sliderThumb() {
    return Container(
      padding: EdgeInsets.all(3.sp),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: ColorConstant.clrSecondary, width: 2),
      ),
      child: Container(
        padding: EdgeInsets.all(11.sp),
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
        ),
        child: Image.asset(
          ImageConstant.imgSwipeToAccept,
          height: 16.h,
          width: 16.w,
        ),
      ),
    );
  }
}
