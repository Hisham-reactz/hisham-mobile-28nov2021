import 'package:get/get.dart';
import 'package:twitter_clone/app/modules/home/views/home_view.dart';
import 'package:twitter_clone/app/modules/login/bindings/login_bindings.dart';
import 'package:twitter_clone/app/modules/login/views/login_view.dart';
import 'package:twitter_clone/app/modules/root/bindings/root_binding.dart';
import 'package:twitter_clone/app/modules/root/views/root_view.dart';
import 'package:twitter_clone/app/modules/tweet/bindings/tweet_binding.dart';
import 'package:twitter_clone/app/modules/tweet/views/tweet_view.dart';
import 'package:twitter_clone/app/modules/home/bindings/home_binding.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static final routes = [
    GetPage(
      name: '/',
      page: () => const RootView(),
      binding: RootBinding(),
      participatesInRootNavigator: true,
      preventDuplicates: true,
      children: [
        GetPage(
          name: _Paths.home,
          page: () => const HomeView(),
          binding: HomeBinding(),
        ),
        GetPage(
          name: _Paths.tweet,
          page: () => const TweetView(),
          binding: TweetBinding(),
        ),
        GetPage(
          name: _Paths.login,
          page: () => const LoginView(),
          binding: LoginBinding(),
        ),
      ],
    ),
  ];
}
