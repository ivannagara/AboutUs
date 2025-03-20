import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsService extends GetxService {
  late SharedPreferences _prefs;
  
  // Card deck settings
  final cardAnimationDuration = 500.obs; // Animation duration in milliseconds

  Future<SettingsService> init() async {
    _prefs = await SharedPreferences.getInstance();
    
    // Load saved settings
    cardAnimationDuration.value = _prefs.getInt('card_animation_duration') ?? 500;
    
    return this;
  }
  
  // Save animation duration setting
  void saveCardAnimationDuration(int duration) {
    cardAnimationDuration.value = duration;
    _prefs.setInt('card_animation_duration', duration);
  }
}