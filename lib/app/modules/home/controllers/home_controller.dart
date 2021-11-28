import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twitter_clone/app/routes/app_pages.dart';
import 'package:twitter_clone/services/firebase_service.dart';
import 'package:twitter_clone/services/utility_service.dart';

class HomeController extends GetxController {
  final fireBase = FirebaseService.to;
  final userId = ''.obs;
  final editId = ''.obs;
  final editTweet = ''.obs;
  Rx tweets = const Stream.empty().obs;
  dynamic users;
  dynamic _prefs;
  dynamic addTweet;

  @override
  void onInit() {
    super.onInit();
    _prefs = fireBase.prefs;
    //Get all users
    users = (data) => fireBase.getUser(data);
    //Get logged user id
    getLocal();
    //Get arguments from root wrapper
    if (Get.rootDelegate.arguments()['tweets'] != null) {
      tweets.value = Get.rootDelegate.arguments()['tweets'];
    }
    if (Get.rootDelegate.arguments()['addTweet'] != null) {
      addTweet = Get.rootDelegate.arguments()['addTweet'];
    }
  }

  //Get Firebase user id local storage
  void getLocal() async {
    final prefs = await _prefs;
    userId.value = prefs.getString('userId')!;
  }

  //Edit input show
  setEdit(doc, val) {
    editId.value = doc.id;
    if (val.toString().trim().isNotEmpty) {
      editTweet.value = val;
    }
  }

  //Firebase tweet update
  updateTweet(doc) {
    if (editTweet.value.toString().trim().isNotEmpty) {
      doc.update({'content': editTweet.value});
    }
    editId.value = '';
    editTweet.value = '';
  }

  //Firebase delete item
  void delItem(context, doc) {
    doc.delete();
    Navigator.of(context).pop();
    UtilityService.to.snack('Tweet Deleted');
  }

  //Add tweet nav
  void tweetNav() {
    Get.rootDelegate.toNamed(Routes.tweet, arguments: {'addTweet': addTweet});
  }

  //Delete confirm dialog
  Future<void> showMyDialog(context, doc) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete the tweet?'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('You are about to delete this tweet'),
                Text('Would you like to delete this tweet?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Delete'),
              onPressed: () => delItem(context, doc),
            ),
          ],
        );
      },
    );
  }
}
