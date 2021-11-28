import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:twitter_clone/app/routes/app_pages.dart';
import 'package:twitter_clone/services/firebase_service.dart';
import 'package:twitter_clone/services/utility_service.dart';

void main() async {
  runApp(
    GetMaterialApp.router(
      title: "TwitterClone",
      initialBinding: BindingsBuilder(
        () {
          Get.put(UtilityService());
          Get.put(FirebaseService());
        },
      ),
      getPages: AppPages.routes,
    ),
  );
}
