import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sire/binding/initialbinding.dart';
import 'package:sire/core/constant/color.dart';
import 'package:sire/core/localization/changelocale.dart';
import 'package:sire/core/localization/translation.dart';
import 'package:sire/core/services/services.dart';
import 'package:sire/routes.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
  statusBarColor: Appcolor.black,
  statusBarIconBrightness: Brightness.light,
)); 
  WidgetsFlutterBinding.ensureInitialized();
  await InitialServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Localecontroller locale = Get.put(Localecontroller());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      locale: locale.languge,
      initialBinding: InitialBindings(),
      translations: Translation(),
      theme: ThemeData(
        fontFamily: 'Cairo',
        textTheme: TextTheme(
          headlineLarge: TextStyle(fontWeight: FontWeight.w800, fontSize: 28),
          headlineMedium: TextStyle(fontWeight: FontWeight.w700, fontSize: 22),
          headlineSmall: TextStyle(fontWeight: FontWeight.w600, fontSize: 20),
          bodyLarge: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          bodyMedium: TextStyle(fontWeight: FontWeight.w600, fontSize: 19),
          bodySmall: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
          labelLarge: TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
          labelMedium: TextStyle(
              fontWeight: FontWeight.w500, fontSize: 18, color: Appcolor.white),
          labelSmall: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Appcolor.rosePompadour),
        useMaterial3: true,
      ),
      getPages: route,
    );
  }
}
