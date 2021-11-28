import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:twitter_clone/services/firebase_service.dart';

class TweetController extends GetxController {
  final userId = ''.obs;
  final tweet = ''.obs;
  final formKey = GlobalKey<FormState>();
  final _prefs = FirebaseService.to.prefs;
  dynamic addTweet;

  @override
  void onInit() {
    super.onInit();
    if (Get.rootDelegate.arguments()['addTweet'] != null) {
      addTweet = Get.rootDelegate.arguments()['addTweet'];
    }
  }

  //Tweet Submit
  void submitForm(context) async {
    final prefs = await _prefs;
    userId.value = prefs.getString('userId')!;
    if (formKey.currentState!.validate()) {
      var formData = {
        'content': tweet.value,
        'created_at': DateTime.now(),
        'user_id': userId.value
      };
      addTweet(formData);
      popNav(context);
    }
  }

  void popNav(context) {
    Get.rootDelegate.popRoute(popMode: PopMode.History);
  }

  //Tweeet validate
  String? validate(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'No Empty Tweets!';
    }
    tweet.value = value;
    return null;
  }
}
