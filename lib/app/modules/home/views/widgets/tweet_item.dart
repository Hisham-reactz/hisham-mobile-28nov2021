// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twitter_clone/app/modules/home/controllers/home_controller.dart';
import 'package:twitter_clone/services/utility_service.dart';
import 'package:timeago/timeago.dart' as timeago;
part 'footer_buttons.dart';
part 'tweet_content.dart';

class TweetItem extends StatelessWidget {
  const TweetItem(
      {Key? key,
      required this.controller,
      required this.data,
      required this.document})
      : super(key: key);

  final HomeController controller;
  final data;
  final document;

  @override
  Widget build(BuildContext context) {
    final util = UtilityService.to;
    double height(double px) => util.height(context, px);
    double width(double px) => util.width(context, px);
    return Obx(() => ListTile(
          contentPadding: EdgeInsets.only(
              top: height(20), left: width(20), right: width(20)),
          isThreeLine: true,
          dense: true,
          trailing: Visibility(
              visible: controller.userId == data['user_id'],
              child: IconButton(
                  onPressed: () =>
                      controller.editId.value != document.reference.id
                          ? controller.showMyDialog(context, document.reference)
                          : controller.updateTweet(document.reference),
                  icon: Icon(
                    controller.editId.value == document.reference.id
                        ? Icons.check_circle_rounded
                        : Icons.delete,
                    size: 35,
                    color: Colors.redAccent,
                  )),
              replacement: const IconButton(
                  onPressed: null,
                  icon: Icon(
                    Icons.arrow_drop_down_circle_rounded,
                  ))),
          horizontalTitleGap: 0,
          minVerticalPadding: 0,
          //Firebase tweet user bulder
          title: FutureBuilder<DocumentSnapshot>(
              future: controller.users(data),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                const textStyle = TextStyle(
                    fontWeight: FontWeight.w900,
                    color: Colors.black,
                    fontSize: 16);
                var children = <TextSpan>[
                  TextSpan(
                      text: snapshot.data == null
                          ? '...'
                          : userName(snapshot, data),
                      style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                          color: Color(0xff687684))),
                ];
                var textSpan = TextSpan(
                  text: snapshot.data == null
                      ? '...'
                      : '${snapshot.data!['name']} ',
                  style: textStyle,
                  children: children,
                );
                return RichText(
                  text: textSpan,
                );
              }),
          subtitle:
              //Firebase tweet content
              tweetContent(height, context, controller, document, data),
          minLeadingWidth: 50,
          leading: const CircleAvatar(
            backgroundColor: Colors.teal,
          ),
        ));
  }

  String userName(snapshot, data) =>
      ' @${snapshot.data!['name']} ·${timeago.format(data['created_at'].toDate(), locale: 'en_short')}';
}
