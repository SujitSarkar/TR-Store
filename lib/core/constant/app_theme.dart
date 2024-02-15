import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_color.dart';
import 'app_string.dart';

class AppTheme {
  static final ThemeData themeData = ThemeData(
      colorScheme: ColorScheme.fromSeed(
          seedColor: AppColor.primaryColor, brightness: Brightness.light),
      useMaterial3: true,
      // primarySwatch:
      //     const MaterialColor(AppColor.primarySwatch, AppColor.primaryColorMap),
      scaffoldBackgroundColor: AppColor.appBodyBg,
      cupertinoOverrideTheme: NoDefaultCupertinoThemeData(
          brightness: Brightness.light,
          scaffoldBackgroundColor: AppColor.appBodyBg,
          barBackgroundColor: AppColor.cardColor,
          primaryColor: AppColor.primaryColor,
          primaryContrastingColor: AppColor.primaryColor,
          textTheme: CupertinoTextThemeData(
            textStyle: const TextStyle(fontFamily: AppString.fontName),
            actionTextStyle: const TextStyle(fontFamily: AppString.fontName),
            tabLabelTextStyle: const TextStyle(fontFamily: AppString.fontName),
            navTitleTextStyle: const TextStyle(fontFamily: AppString.fontName),
            navLargeTitleTextStyle:
                const TextStyle(fontFamily: AppString.fontName),
            navActionTextStyle: const TextStyle(fontFamily: AppString.fontName),
            pickerTextStyle: const TextStyle(fontFamily: AppString.fontName),
            dateTimePickerTextStyle: TextStyle(
                fontFamily: AppString.fontName,
                color: AppColor.textColor,
                fontSize: 16.0),
          )),
      appBarTheme: const AppBarTheme(
          backgroundColor: AppColor.primaryColor,
          titleTextStyle: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          elevation: 0.0,
          iconTheme: IconThemeData(color: Colors.white),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: AppColor.primaryColor,
            statusBarIconBrightness: Brightness.light),
      ),
      canvasColor: Colors.transparent,
      textSelectionTheme: TextSelectionThemeData(
          cursorColor: AppColor.primaryColor,
          selectionColor: AppColor.primaryColor.withOpacity(0.4)),
      bottomSheetTheme:
          const BottomSheetThemeData(modalBackgroundColor: Colors.transparent,
              backgroundColor: AppColor.bottomSheetColor),
      fontFamily: AppString.fontName,
      textTheme: const TextTheme(
          displayLarge: TextStyle(fontFamily: AppString.fontName),
          displayMedium: TextStyle(fontFamily: AppString.fontName),
          displaySmall: TextStyle(fontFamily: AppString.fontName),
          headlineMedium: TextStyle(fontFamily: AppString.fontName),
          headlineSmall: TextStyle(fontFamily: AppString.fontName),
          titleLarge: TextStyle(fontFamily: AppString.fontName),
          titleMedium: TextStyle(fontFamily: AppString.fontName),
          titleSmall: TextStyle(fontFamily: AppString.fontName),
          bodyLarge: TextStyle(fontFamily: AppString.fontName),
          bodyMedium: TextStyle(fontFamily: AppString.fontName),
          bodySmall: TextStyle(fontFamily: AppString.fontName),
          labelLarge: TextStyle(fontFamily: AppString.fontName),
          labelSmall: TextStyle(fontFamily: AppString.fontName)));

  static var deviceOrientation = SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  static var statusBarTheme = SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: AppColor.primaryColor,
      statusBarIconBrightness: Brightness.light));
}
