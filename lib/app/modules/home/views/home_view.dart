import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twitter_clone/app/modules/home/controllers/home_controller.dart';
import 'package:twitter_clone/app/modules/home/views/widgets/tweet_item.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () => controller.tweetNav(),
          child: const Icon(Icons.post_add),
        ),
        body:
            //Tweets stream builder
            StreamBuilder<QuerySnapshot>(
          stream: controller.tweets.value,
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            //Loading
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                  child: Text(
                'Loading...',
                style: TextStyle(fontSize: 27),
              ));
            }
            //Empty stream
            if (snapshot.hasError || snapshot.data == null) {
              return const Center(
                  child: Text(
                'No Tweets.',
                style: TextStyle(fontSize: 27),
              ));
            }
            //Tweet ListView
            return ListView(
              children: tweetList(snapshot)
                  .data!
                  .docs
                  .map((DocumentSnapshot document) {
                Map<String, dynamic> data =
                    document.data()! as Map<String, dynamic>;
                //Tweet item widget
                return TweetItem(
                    controller: controller, data: data, document: document);
              }).toList(),
            );
          },
        ));
  }

  AsyncSnapshot<QuerySnapshot<Object?>> tweetList(
          AsyncSnapshot<QuerySnapshot<Object?>> snapshot) =>
      snapshot;
}
