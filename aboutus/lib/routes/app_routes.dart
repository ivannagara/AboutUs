part of 'app_pages.dart';

abstract class Routes {
  Routes._();
  static const HOME = _Paths.HOME;
  static const CARD_GAME = _Paths.CARD_GAME;
}

abstract class _Paths {
  _Paths._();
  static const HOME = '/home';
  static const CARD_GAME = '/card-game';
}