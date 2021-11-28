import 'package:get/get.dart';
import 'package:twitter_clone/app/modules/tweet/controllers/tweet_controller.dart';

class TweetBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TweetController>(
      () => TweetController(),
    );
  }
}
