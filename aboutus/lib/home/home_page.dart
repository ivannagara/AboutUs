// home_view.dart
import 'package:aboutus/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.indigo.shade900, Colors.indigo.shade600],
          ),
        ),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Game title
                Text(
                  'appTitle'.tr,
                  style: const TextStyle(
                    fontSize: 48,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                
                // Description
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50.0),
                  child: Text(
                    'Get to know your friends and yourself better with this card game',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white.withOpacity(0.9),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 50),
                
                // Start game button
                ElevatedButton(
                  onPressed: controller.startGame,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.indigo.shade900,
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text('Start Game'),
                ),
                
                const SizedBox(height: 30),
                
                // Language selection
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.language, color: Colors.white),
                    const SizedBox(width: 10),
                    Obx(() => DropdownButton<String>(
                      value: controller.currentLanguage.value,
                      dropdownColor: Colors.indigo.shade700,
                      iconEnabledColor: Colors.white,
                      style: const TextStyle(color: Colors.white),
                      underline: Container(
                        height: 1,
                        color: Colors.white70,
                      ),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          controller.changeLanguage(newValue);
                        }
                      },
                      items: controller.availableLanguages.map<DropdownMenuItem<String>>((String value) {
                        String languageName = '';
                        if (value == 'en_US') languageName = 'English';
                        if (value == 'es_ES') languageName = 'Español';
                        if (value == 'fr_FR') languageName = 'Français';
                        
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(languageName),
                        );
                      }).toList(),
                    )),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}