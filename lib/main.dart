import 'package:flutter/material.dart';
import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hicom/resource/srting.dart';
import 'package:hicom/splash_screen.dart';


main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
        debugShowFloatingThemeButton: false,
        initial: AdaptiveThemeMode.system,
        light: ThemeData.light(useMaterial3: true),
        dark: ThemeData.dark(useMaterial3: true),
        builder: (theme, lightTheme) => GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Ildiz Kitoblari',
            theme: theme,
            translations: LocaleString(),
            //locale: Get.locale ?? const Locale('uz', 'UZ'),
            locale: Locale(Get.locale?.languageCode ?? 'uz', Get.locale?.countryCode ?? 'UZ'),
            darkTheme: lightTheme,
            routes: {
              '/': (context) => SplashScreen()
            }));
  }
}

