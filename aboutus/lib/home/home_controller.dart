// home_controller.dart
import 'package:aboutus/services/translation_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final RxList<String> availableLanguages = <String>[].obs;
  final RxString currentLanguage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadLanguages();
  }

  void loadLanguages() {
    availableLanguages.value = TranslationService.languages;
    currentLanguage.value = TranslationService.getLanguageCode();
  }

  void changeLanguage(String languageCode) {
    TranslationService.changeLocale(languageCode);
    currentLanguage.value = languageCode;
  }

  void startGame() {
    Get.toNamed('/card-game');
  }
}