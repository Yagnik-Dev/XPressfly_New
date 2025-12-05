import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:xpressfly_git/Constants/storage_constant.dart';
import 'package:xpressfly_git/Routes/app_routes.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    Future.delayed(const Duration(seconds: 5), () {
      if (GetStorage().read(accessToken) != null &&
          GetStorage().read(accessToken) != "Bearer null") {
        if (GetStorage().read(userRole) == "customer") {
          Get.offAndToNamed(AppRoutes.customerBottomBarScreen);
        } else if (GetStorage().read(userRole) == "driver") {
          Get.offAndToNamed(AppRoutes.driverBottomBarScreen);
        }
      } else {
        Get.offAndToNamed(AppRoutes.onBoardingScreen);
      }
    });
  }
}
