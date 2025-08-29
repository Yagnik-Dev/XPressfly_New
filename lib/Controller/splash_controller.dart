import 'package:get/get.dart';
import 'package:xpressfly_git/Routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 5), () {
      // if (GetStorage().read(accessToken) != null) {
      //   if (GetStorage().read(userType) == 0 ||
      //       GetStorage().read(userType) == "0") {
      //     Get.offAndToNamed(AppRoutes.bottomBarScreen);
      //   } else if (GetStorage().read(userType) == 1 ||
      //       GetStorage().read(userType) == "1") {
      //     Get.offAndToNamed(AppRoutes.customerBottomBarScreen);
      //   }
      // } else {
      Get.offAndToNamed(AppRoutes.onBoardingScreen);
      // }
    });
  }
}
