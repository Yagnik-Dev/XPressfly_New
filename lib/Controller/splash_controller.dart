import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:xpressfly_git/Constants/storage_constant.dart'
    as StorageConstant;
import 'package:xpressfly_git/Routes/app_routes.dart';
import 'package:xpressfly_git/Screens/AuthScreens/device_info_details.dart';
import 'package:xpressfly_git/Screens/Customer/timer_service.dart';

class SplashController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    loadDeviceData();

    Future.delayed(const Duration(seconds: 2), () {
      _checkAppState();
    });
  }

  void _checkAppState() {
    final timerService = TimerService();
    final accessToken = GetStorage().read(StorageConstant.accessToken);

    // Check if timer is active
    // if (timerService.isTimerActive()) {
    //   Get.offAndToNamed(AppRoutes.waitForResponseTimerScreen);
    //   return;
    // }

    // Check authentication
    if (accessToken != null && accessToken != "Bearer null") {
      final userRole = GetStorage().read(StorageConstant.userRole);
      if (userRole == "customer") {
        Get.offAndToNamed(AppRoutes.customerBottomBarScreen);
      } else if (userRole == "driver") {
        Get.offAndToNamed(AppRoutes.driverBottomBarScreen);
      }
    } else {
      Get.offAndToNamed(AppRoutes.onBoardingScreen);
    }
  }
}
