import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:xpressfly_git/Screens/AuthScreens/join_as_screen.dart';
import 'package:xpressfly_git/Screens/AuthScreens/login_screen.dart';
import 'package:xpressfly_git/Screens/AuthScreens/onboarding_screen.dart';
import 'package:xpressfly_git/Screens/AuthScreens/otp_screen.dart';
import 'package:xpressfly_git/Screens/AuthScreens/select_auth_screen.dart';
import 'package:xpressfly_git/Screens/AuthScreens/splash_screen.dart';
import 'package:xpressfly_git/Screens/AuthScreens/your_details.dart';

class AppRoutes {
  static const String splashScreen = '/splash_screen';
  static const String registerScreen = '/register_screen';
  static const String loginScreen = '/login_screen';
  static const String onBoardingScreen = '/onboarding_screen';
  static const String selectAuthScreen = '/select_auth_screen';
  static const String otpScreen = '/otp_screen';
  static const String joinAsScreen = '/join_as_screen';
  static const String yourDetailsScreen = '/your_details_screen';

  static List<GetPage> pages = [
    GetPage(name: splashScreen, page: () => SplashScreen()),
    GetPage(name: loginScreen, page: () => LoginScreen()),
    GetPage(name: onBoardingScreen, page: () => OnBoardingScreen()),
    GetPage(name: selectAuthScreen, page: () => SelectAuthScreen()),
    GetPage(name: otpScreen, page: () => OtpScreen()),
    GetPage(name: joinAsScreen, page: () => JoinAsScreen()),
    GetPage(name: yourDetailsScreen, page: () => YourDetailsScreen()),
  ];
}
