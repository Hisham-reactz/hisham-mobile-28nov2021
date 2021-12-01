import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:twitter_clone/app/modules/tweet/controllers/tweet_controller.dart';
import 'package:twitter_clone/services/utility_service.dart';

class TweetView extends GetView<TweetController> {
  const TweetView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final util = UtilityService.to;
    double height(double px) => util.height(context, px);
    double width(double px) => util.width(context, px);

    return Scaffold(
      appBar: AppBar(
        bottom: PreferredSize(
            preferredSize: Size(width(1000), height(50)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                    onPressed: () => controller.popNav(context),
                    child: const Text('Cancel',
                        style:
                            TextStyle(color: Colors.lightBlue, fontSize: 17))),
                SizedBox(width: width(100)),
                ElevatedButton(
                    key: const ValueKey('addTweetButton'),
                    style: ButtonStyle(
                        alignment: Alignment.center,
                        backgroundColor:
                            MaterialStateProperty.all(Colors.lightBlue),
                        shape:
                            MaterialStateProperty.all(const StadiumBorder())),
                    onPressed: () => controller.submitForm(context),
                    child: const Text(
                      'Tweet',
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ))
              ],
            )),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
          padding: EdgeInsets.all(width(17)), child: tweetform(height, width)),
    );
  }

  //Tweet Form
  Form tweetform(
      double Function(double px) height, double Function(double px) width) {
    var inputDecoration = InputDecoration(
      hintText: 'What’s happening?',
      hintStyle: const TextStyle(fontSize: 19, color: Color(0xff687684)),
      contentPadding:
          EdgeInsets.symmetric(vertical: height(30), horizontal: width(30)),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.lightBlueAccent, width: 1.0),
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
        borderRadius: BorderRadius.all(Radius.circular(32.0)),
      ),
    );
    return Form(
        key: controller.formKey,
        child: TextFormField(
          key: const ValueKey('addTweetInput'),
          initialValue: controller.tweet.value,
          keyboardType: TextInputType.multiline,
          textInputAction: TextInputAction.newline,
          minLines: 9,
          maxLines: 9,
          maxLength: 280,
          validator: (String? val) => controller.validate(val),
          decoration: inputDecoration,
        ));
  }
}
