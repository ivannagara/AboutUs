import 'package:aboutus/routes/app_pages.dart';
import 'package:aboutus/services/setting_service.dart';
import 'package:aboutus/services/translation_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Set preferred orientations to landscape for the card game
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);
  
  // Initialize services
  await initServices();
  
  runApp(const MyApp());
}

Future<void> initServices() async {
  await Get.putAsync(() => SettingsService().init());
  await Get.putAsync(() => TranslationService().init());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'AboutUs',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      locale: TranslationService.locale,
      fallbackLocale: TranslationService.fallbackLocale,
      translations: TranslationService(),
    );
  }
}