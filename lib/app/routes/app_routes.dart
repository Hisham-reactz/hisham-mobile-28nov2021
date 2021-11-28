part of 'app_pages.dart';

abstract class Routes {
  Routes._();

  static const home = _Paths.home;
  static const tweet = _Paths.tweet;
  static const login = _Paths.login;
}

abstract class _Paths {
  static const home = '/home';
  static const tweet = '/tweet';
  static const login = '/login';
}
