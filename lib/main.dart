import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:xpressfly_git/Localization/localization.dart';
import 'package:xpressfly_git/Routes/app_routes.dart';
import 'package:xpressfly_git/Services/firebase_cli_helper.dart';
import 'package:xpressfly_git/Services/firebase_messaging_service.dart';
import 'Utility/common_imports.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await GetStorage.init();

  // Initialize Firebase Messaging
  FirebaseMessagingService().initializeFirebaseMessaging();

  await FirebaseMessaging.instance.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  runApp(const MyApp());
}

class AndroidNotificationChannel {
  const AndroidNotificationChannel();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Load saved language preference
    final savedLocale = LocalizationService.getSavedLocale();

    return ScreenUtilInit(
      designSize: const Size(360, 690),
      child: GetMaterialApp(
        debugShowCheckedModeBanner: false,
        locale: savedLocale,
        fallbackLocale: LocalizationService.fallbackLocale,
        translations: LocalizationService(),
        initialRoute: AppRoutes.splashScreen,
        title: 'xpressfly',
        getPages: AppRoutes.pages,
      ),
    );
  }
}
