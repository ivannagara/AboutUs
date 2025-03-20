import 'package:aboutus/card_game/card_game_binding.dart';
import 'package:aboutus/card_game/card_game_view.dart';
import 'package:aboutus/home/home_binding.dart';
import 'package:aboutus/home/home_page.dart';
import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.CARD_GAME,
      page: () => const CardGameView(),
      binding: CardGameBinding(),
    ),
  ];
}