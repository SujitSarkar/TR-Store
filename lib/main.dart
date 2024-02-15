import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/constant/app_string.dart';
import 'core/constant/app_theme.dart';
import 'core/router/app_router.dart';
import 'core/router/app_router_settings.dart';

void main(){
  WidgetsFlutterBinding.ensureInitialized();
  AppTheme.deviceOrientation;
  AppTheme.statusBarTheme;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: Get.key,
      title: AppString.appName,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.themeData,
      onGenerateRoute: (settings) => GeneratedRoute.onGenerateRoute(settings),
      initialRoute: AppRouter.product,
    );
  }
}
