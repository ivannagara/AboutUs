import 'package:aboutus/card_game/card_game_controller.dart';
import 'package:get/get.dart';

class CardGameBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CardGameController>(
      () => CardGameController(),
    );
  }
}