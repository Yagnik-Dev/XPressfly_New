import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:xpressfly_git/Screens/AuthScreens/join_as_screen.dart';
import 'package:xpressfly_git/Screens/AuthScreens/login_screen.dart';
import 'package:xpressfly_git/Screens/AuthScreens/onboarding_screen.dart';
import 'package:xpressfly_git/Screens/AuthScreens/otp_screen.dart';
import 'package:xpressfly_git/Screens/AuthScreens/select_auth_screen.dart';
import 'package:xpressfly_git/Screens/AuthScreens/splash_screen.dart';
import 'package:xpressfly_git/Screens/Customer/book_a_order_main.dart';
import 'package:xpressfly_git/Screens/Customer/customer_bottombar_screen.dart';
import 'package:xpressfly_git/Screens/Customer/customer_homescreen.dart';
import 'package:xpressfly_git/Screens/Customer/orderfailure_screen.dart';
import 'package:xpressfly_git/Screens/Customer/ordersuccess_screen.dart';
import 'package:xpressfly_git/Screens/Customer/timer_screen.dart';
import 'package:xpressfly_git/Screens/Customer/verification_screen.dart';
import 'package:xpressfly_git/Screens/DrawerScreens/metadata_screen.dart';
import 'package:xpressfly_git/Screens/Driver/addvehicle_mainscreen.dart';
import 'package:xpressfly_git/Screens/Driver/driver_homescreen.dart';
import 'package:xpressfly_git/Screens/Driver/driver_bottombar_screen.dart';
import 'package:xpressfly_git/Screens/Driver/edit_profile.dart';
import 'package:xpressfly_git/Screens/Driver/edit_vehicle.dart';
import 'package:xpressfly_git/Screens/Driver/vehicle_details.dart';
import 'package:xpressfly_git/Screens/Driver/vehicle_type_dialog.dart';

class AppRoutes {
  static const String splashScreen = '/splash_screen';
  static const String registerScreen = '/register_screen';
  static const String loginScreen = '/login_screen';
  static const String onBoardingScreen = '/onboarding_screen';
  static const String selectAuthScreen = '/select_auth_screen';
  static const String otpScreen = '/otp_screen';
  static const String joinAsScreen = '/join_as_screen';
  // static const String yourDetailsScreen = '/your_details_screen';
  static const String driverHomeScreen = '/driver_home_screen';
  static const String driverBottomBarScreen = '/driver_bottom_bar_screen';
  static const String addVehicleMainScreen = '/add_vehicle_main_screen';
  static const String vehicleDetailsScreen = '/vehicle_details_screen';
  static const String vehicleTypeScreen = '/vehicle_type_screen';
  static const String editVehicleDetailsScreen = '/edit_vehicle_details_screen';
  static const String editProfileScreen = '/edit_profile_screen';
  static const String customerHomeScreen = '/customer_home_screen';
  static const String customerBottomBarScreen = '/customer_bottom_bar_screen';
  static const String verificationScreen = '/verification_screen';
  static const String bookAOrderMainScreen = '/book_a_order_main_screen';
  static const String waitForResponseTimerScreen =
      '/wait_for_response_timer_screen';
  static const String metaDataScreen = '/metadata_screen';
  static const String orderSuccessScreen = '/order_success_screen';
  static const String orderFailureScreen = '/order_failure_screen';

  static List<GetPage> pages = [
    GetPage(name: splashScreen, page: () => SplashScreen()),
    GetPage(name: loginScreen, page: () => LoginScreen()),
    GetPage(name: onBoardingScreen, page: () => OnBoardingScreen()),
    GetPage(name: selectAuthScreen, page: () => SelectAuthScreen()),
    GetPage(name: otpScreen, page: () => OtpScreen()),
    GetPage(name: joinAsScreen, page: () => JoinAsScreen()),
    // GetPage(name: yourDetailsScreen, page: () => YourDetailsScreen()),
    GetPage(name: driverHomeScreen, page: () => DriverHomeScreen()),
    GetPage(name: driverBottomBarScreen, page: () => DriverBottomBarScreen()),
    GetPage(
      name: customerBottomBarScreen,
      page: () => CustomerBottomBarScreen(),
    ),
    GetPage(name: addVehicleMainScreen, page: () => AddVehicleMainScreen()),
    GetPage(name: vehicleDetailsScreen, page: () => VehicleDetailsScreen()),
    GetPage(name: vehicleTypeScreen, page: () => VehicleTypeScreen()),
    GetPage(name: editProfileScreen, page: () => EditProfileScreen()),
    GetPage(name: customerHomeScreen, page: () => CustomerHomeScreen()),
    GetPage(name: verificationScreen, page: () => VerificationScreen()),
    GetPage(name: bookAOrderMainScreen, page: () => BookAOrderMainScreen()),
    GetPage(
      name: waitForResponseTimerScreen,
      page: () => WaitForResponseTimerScreen(),
    ),
    GetPage(
      name: editVehicleDetailsScreen,
      page: () => EditVehicleDetailsScreen(),
    ),
    GetPage(name: metaDataScreen, page: () => MetadataScreen()),
    GetPage(name: orderSuccessScreen, page: () => OrderSuccessScreen()),
    GetPage(name: orderFailureScreen, page: () => OrderFailureScreen()),
  ];
}
